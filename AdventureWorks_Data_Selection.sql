-- Data Selection

-- Dates Table
SELECT
	*
FROM DimDate

SELECT
	DateKey,
	FullDateAlternateKey AS Date,
	EnglishDayNameOfWeek AS DayOfWeek,
	WeekNumberOfYear AS WeekOfYear,
	EnglishMonthName AS Month,
	LEFT(EnglishMonthName, 3) AS MonthShort,
	CalendarQuarter AS Quarter,
	CalendarSemester AS Semester,
	CalendarYear AS Year
FROM DimDate

-- Customers Table
SELECT
	*
FROM DimCustomer

SELECT
	A.CustomerKey,
	A.FirstName, -- In real work scenario, filter out PII data
	A.LastName,
	CASE A.Gender 
		WHEN 'M' THEN 'Male'
		WHEN 'F' THEN 'Female'
	END AS Gender,
	A.DateFirstPurchase,
	B.EnglishCountryRegionName AS Country,
	B.City
FROM DimCustomer AS A LEFT JOIN DimGeography AS B
ON A.GeographyKey = B.GeographyKey

-- Products Data
SELECT
	*
FROM DimProduct

SELECT
	*
FROM DimProductCategory

SELECT
	*
FROM DimProductSubcategory

SELECT
	A.ProductKey,
	A.ProductAlternateKey AS ProductCode,
	A.EnglishProductName AS ProductName,
	B.EnglishProductSubcategoryName AS ProductSubcategory, 
	C.EnglishProductCategoryName AS ProductCategory
FROM DimProduct AS A LEFT JOIN DimProductSubcategory AS B
ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
LEFT JOIN DimProductCategory AS C
ON B.ProductCategoryKey = C.ProductCategoryKey

-- Internet Sales Table
SELECT
	*
FROM FactInternetSales

SELECT
	*
FROM FactInternetSalesReason

SELECT
	*
FROM DimSalesReason -- Might come in handy for textual analysis

SELECT
	A.ProductKey,
	A.CustomerKey,
	A.OrderDateKey,
	A.SalesAmount AS Amount,
	A.ProductStandardCost AS ProductionCost,
	C.SalesReasonName AS PurchaseReason
FROM FactInternetSales AS A LEFT JOIN FactInternetSalesReason AS B
ON A.SalesOrderNumber = B.SalesOrderNumber
LEFT JOIN DimSalesReason AS C
ON B.SalesReasonKey = C.SalesReasonKey



