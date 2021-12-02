SELECT FirstName, LastName FROM Employees
WHERE LEFT(FirstName, 2) = 'SA'
/*---------------------------------------*/
SELECT FirstName, LastName FROM Employees
WHERE NOT CHARINDEX('ei', LastName) = 0
/*---------------------------------------*/
SELECT FirstName FROM Employees
WHERE DepartmentID IN(3, 10) AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005
/*---------------------------------------*/
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE 'engineer'
/*---------------------------------------*/
SELECT Name FROM Towns
WHERE LEN(Name) IN(5, 6)
ORDER BY Name
/*---------------------------------------*/
SELECT * FROM Towns
WHERE Name LIKE '[MKBE]%'
ORDER BY Name
/*---------------------------------------*/
SELECT * FROM Towns
WHERE Name LIKE '[^RBD]%'
ORDER BY Name
/*---------------------------------------*/
--GO
--CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE DATEPART(YEAR, HireDate) > 2000
--GO
/*---------------------------------------*/
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5
/*---------------------------------------*/
SELECT EmployeeID, FirstName, LastName, Salary,
    DENSE_RANK() OVER   
      (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]  
    FROM Employees   
  WHERE Salary BETWEEN 10000 AND 50000   
  ORDER BY Salary DESC;
/*---------------------------------------*/
SELECT * FROM ( SELECT EmployeeID, FirstName, LastName, Salary,
              DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS Rank
       FROM Employees
       WHERE Salary BETWEEN 10000 AND 50000) AS [Rank]
WHERE Rank = 2
ORDER BY Salary DESC
/*---------------------------------------*/
Use Geography

SELECT CountryName, IsoCode FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode
/*---------------------------------------*/
SELECT p.PeakName, r.RiverName, LOWER(PeakName + SUBSTRING(RiverName, 2, LEN(RiverName) - 1)) AS Mix 
FROM Peaks AS p
JOIN Rivers AS r
ON RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix
/*---------------------------------------*/
Use Diablo

SELECT TOP 50 Name, FORMAT(Start, 'yyyy-mm-dd') AS Start FROM Games
WHERE DATEPART(YEAR, Start) IN(2011, 2012)
ORDER BY Start, Name


/*---------------------------------------*/
SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email, 1) + 1, LEN(Email)) AS [Email Provider] FROM Users
ORDER BY [Email Provider], Username
/*---------------------------------------*/
SELECT Username, IpAddress AS [IP Address] FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username
/*---------------------------------------*/
SELECT Name AS Game,
	[Part of the Day] = 
		CASE 
			WHEN DATEPART(HOUR, Start) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, Start) < 18 THEN 'Afternoon'
			ELSE 'Evening'
		END,
	Duration =
		CASE
			WHEN Duration <= 3 THEN 'Extra Short'
			WHEN Duration <= 6 THEN 'Short'
			WHEN Duration > 6 THEN 'Long'
			ELSE 'Extra Long'
		END
FROM Games
ORDER BY Game, Duration, [Part of the Day]
