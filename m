Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3F1CAA4
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765050039; cv=fail; b=fj4vKZk/3DURrnTIfkCq/abMF5m41yEk3eTBtFY3sBZyWIIp5zpOrttyrkTMCl3gwcJdImrfCug3oqwXon4Z55XgMt23ZmkwMhtKmAB8IHK7laKo3VSgW9dGalE+urR8nJ9FWeBG9EoQGbLP/3xbBrF9c0wkcdwaklzjf0cSycY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765050039; c=relaxed/simple;
	bh=DcS/RtSXTrgTCeco164ZC0LsV3uoqb/vt021hFzNBw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IspepHQwIhYZCaHLm5Mnzx69LqxDBrg9PQ06WOtFCsw0VD4cOW1FpK/bKUyC3/r9Sg0F9b0+UPLdaJyOFH4HmricZn9Ji32rUoXF6mQPuXHP/BCzviPKv+FJObVUkW7s6FKJ+tChS2MLZJrTip29/nyENf5Ve79Vsz6hkXp3/9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZYYWQdq; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZYYWQdq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvl0PlltDBH3heLRVULUHHKFfzmXFcGEY5rLFQPEKFG6OPUlqeE3z8LHL8yEl5Rx2WXK+J++WYmZ6DRJKpTxKHv5X1vMeavcYeAVU2aN69NFINgbcrFYwCJWPOic1VQ1qwkGgrAVZ2hY+oXdQbYkoMWQKvauHdB4GMMoHCg22A3qm8L4WxZUAsjD+SewDlcWn5JAjF9qDkY4Gvz0YxKIyATLiTsytJ6cH/U7AqecQWbcsQIafLcZmkA6o2VW+ky1dtYsWVzLiUPqCKS7gCKbdq71sQyKhOv0FdlBAcA3hBjg5KJTICgM/phWRfnJRGbzeMSe4qrDHRtor7QrhTN4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMaeD/8LB7U1P5W/kHBaB0T8fut4gVybAAXIh+CbASw=;
 b=OgAv7IexdD/6FVt5DMLjxQY3xiDmq95TcSFrg9es7LtbQ/fXJP5naZ+0r2sfUrdmo9PoX/U/YadQeInitxXTdowWTapQFaIlaHcdEVGYdOgx4eDQEGrBrnqiJ1+gZHWcH+sI0cUz2ARX/WyaOQdYl91dgtuQh28ZpBAE4M5ORorLyF00HNkvKe20Pwz7vqiiDZ6S71g1oxZhAMRlCFidYEgP6qHbBiavrB/EFRAHLMEnlDM643mQedHJyk8DOc0NUGtiT209M+R2Cv+GehA0sDtR1PSmxO+c2L8aogX4fNbJAeXqiJP/y22uQCkQWNBzicaHtlk+DgmyD4mj39cklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMaeD/8LB7U1P5W/kHBaB0T8fut4gVybAAXIh+CbASw=;
 b=FZYYWQdq28lA/KnUsaFkbX2O4YoIqMgYZegzHFCb8+VWjCzvSSk+CbDkQz2qJ1D7XzFmp5sGRV/a/1znkt9mBvClj2iepBdu2fZvIML3Lu8FdM48ZjbgCldMUO5y9hzfG5A6LyCuQDalzpDC0tmjMTy93sYV5I2d92LmQoZyzXS/8q2bP5xD4jKQ3TFwlCEMmB07qMnyLkpIL6j3nFgO6MAsF+eecVd7Z3cvoDzypF/4rb3nNE2v4f8TrJ1dYiDp3wAE2ZR0AImWBVbB/VROHlkfqkgrvuC9TToEiy9LcJDOIDDQajoOrgBq8/ZnvMSU9Q42eHBF5xIdA0xgX5pntA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 19:40:34 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9388.012; Sat, 6 Dec 2025
 19:40:34 +0000
Message-ID: <51c866cb-9a7a-4c59-834a-2f710f34f3a1@nvidia.com>
Date: Sat, 6 Dec 2025 11:40:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20251206002014.2066644-1-aplattner@nvidia.com>
 <20251206020648.GB1714099@coredump.intra.peff.net>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <20251206020648.GB1714099@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: aeeb76a6-7c43-4eb4-af4d-08de34ff5268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3lGVDNnMU9ML0NZQkJVaE9jSkJrMFFhY1cxZmc5eXk1czh3SWw0MlFUODBK?=
 =?utf-8?B?ZUQ2SkJCeW5oaUV0TlE3SmVUa3pTRzFEczN2TStpTGdlZ2FGSy95aDdVbkRm?=
 =?utf-8?B?aE5BbmI5VUVKeEdlTDZ6VjV5eTJpL0FBeXQwYUtCVjNoTkUvSjcyUGFWWExp?=
 =?utf-8?B?K2RyZnlvdDFoblp4OEFwWHpkYXN5WXo0MlU1N2xvVVhvMnZXaWhyTS9ETk1W?=
 =?utf-8?B?cElYRklUbUF2cHJCMVVSemEveEFwT0hmU1hmZlpXWVpDTG9EU1ZTR2UvRUdh?=
 =?utf-8?B?MGNHcnJTdUtYVm44RC9ya01Ca0xDL050MWIxaWkwRTVlN3ZRdW1kbHVpSjI0?=
 =?utf-8?B?dXQ2b3hwWklxYWlSaU5vTDJteWdiaVlpMGVPdmU0OWNXS1lvMjloUmhvbnRu?=
 =?utf-8?B?aUVVUjcrNFNSc1UwNEZtYUJPZzZwd0ZBdHV5OVVOSzRhWlBFMkk0VFdOa2pU?=
 =?utf-8?B?T2h6T1NXTVJsaS9VZi9DY2p2OHJ0NGcyT3VvMm1weXJ0UVpPM0NmcnN1YnRO?=
 =?utf-8?B?dm5CMDFOWGhBaVNmVGtDb0dRU1JxTmtyaUxHRkxXdzJBb3QxWWE3ZFhPeE9M?=
 =?utf-8?B?Q2NnLyszYVZaVVo2aWVWN0dzMEE2dkFHc21QM3R1aFJFWjFrUkRiNnVTeUNQ?=
 =?utf-8?B?MXFLVGdoQnBlUkVyOUNTcWZrNU9EVEdEWWZoOGFnM29pZnpVNU9ad2dDeEJl?=
 =?utf-8?B?YnRCUmxrSnJ5TDdLdEJET25mMytGWlJCcTMyNUNMUHNtaDBoUEhkT2YvenpJ?=
 =?utf-8?B?cVdablZDblcwRDZQQnhYekxjRWZ6aFlQZjN4b1BQajNVYmZZYnZxYUdqZjZD?=
 =?utf-8?B?dXFNWm8rRHJvNkM5MDRjVk84Y3BEMEJOR0t6V3JsampyRUFOYjZub2xsWFVz?=
 =?utf-8?B?VDBhZDd3VkhUdFFFOGxtQnhwUmt6a1RacDNPbUtnUTdvOVhQRnR6U2pKcHp6?=
 =?utf-8?B?MkpkdGNlZVJ0cHJWNHU5TktPeHpNQTVlNUpCb3k1dHZvbkxvTjRnYlRFbFdy?=
 =?utf-8?B?OERLSmx0bDVTRFlCUVFGWTNMWStxU2hHWlI3Nk5mWnlXSXhYNk9teGlkNHJB?=
 =?utf-8?B?OEdzYVZ0cjh5V29pTHAreWRma3B1WUd5eExrMDgzMFJEQkVTZW5zZGgxam80?=
 =?utf-8?B?V2tudGtHeTQ2R0grdFRrVml0YkZWNkEzcTlERU1qeGZGQXpvMzNibHJrQVQr?=
 =?utf-8?B?U08yVVloL0F4Qk5tdGc2aWtNRGIwRXp3b2hBVjVUT3VGNDErdzVneStnNklD?=
 =?utf-8?B?SDNvNUpnUUhGdjd2eG5JWjViK3lWWjE2UHRCWW9oT0xhNmt1T3ZIdDd0K0xH?=
 =?utf-8?B?QXNvREtoVHNmbUh4dXMyOXcramJVRmlvVE9KT2RyUzNIUHB5WGtDRlZMN1pP?=
 =?utf-8?B?cVI0RFNWSytKZUxyNlg4US9sR0ordi9YNnFQaThaN2NpOGg1NHNsV3BiUnB5?=
 =?utf-8?B?WGkzTkhSV1VwZXp1QUtlbCszQk9POFB0dTdKTy9OQ0hmQmdyMXRtMzZlR1Nm?=
 =?utf-8?B?YnM1dEtQZUEwMko5NlhhTU9NVW1iNnErNW9mckNqamgrU05QeGxsM1F4RVN1?=
 =?utf-8?B?M0JFTy8rMDYzU29aZ01uQi9TQjI3Kzk0L2lyRUUxbnJnandLSlVacHB2MGRU?=
 =?utf-8?B?NW1xaFBnMmlnYVprek04djdGbWJqYmdrMEJEZitzdkMvcGZFSDVmVGwxUkpP?=
 =?utf-8?B?a0JnYlJrYmJmNTNQSEE2MWY1WWtQV0tpcmdIdVVabU1Rd3NyUEFnVXRhRUJB?=
 =?utf-8?B?d1RtR2I3eCt4bnZZTnRrQm1xZkNLWjFsbkNuOEhsclJpRnJYQWhna1RsQVpa?=
 =?utf-8?B?NTBMTDJ0aWQrVmQ2UDV4YjlmUlorQXpPcUJYVTU0NGN2bzljQ1BxWkNvcEdH?=
 =?utf-8?B?anBGcS8wY21VU0JUak9pOU9vbkVjNEVKdUlhNkRPQjdSQkw5YkRGNlJBck45?=
 =?utf-8?Q?s6c7nEt/Ulb8ExUxRNuQCwJeM0OipeqP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1g2YkRYck94cXJQMXloRms3UUFTUThEUktLQzg4QzBwYWJzOWxHZ1J4dWlT?=
 =?utf-8?B?M1pmWVcwOHdDTUtJc0FmN1BiM2U5R20vcklyeVdsWm1oUk81ZHd6bkxxRWJ2?=
 =?utf-8?B?K3gwajRYTGlXNkRLRXpUWlNyREtvZGdXNHFyMjNKWHBpL0hObVFNTGE2eTFQ?=
 =?utf-8?B?ZWtxR01MbWtTc1l1L2VJa0xNNDdHOVBxSlZoMVJSa25iRndkdFp6NnFNeXhh?=
 =?utf-8?B?aU9qQTVhYTZoWnRTVlhpck9sQmNGUnUvTkc0ZnFDZVhEcVVOZHpqc09INkww?=
 =?utf-8?B?bDZ6NzdpYmFNWmFQR2Zrb04zWUZ5REs3QXhFWGxkZkE0dmlKRDlHMUJlMEww?=
 =?utf-8?B?amYvcEZoVTMwSFFCTGtWVnJOa0VPaVVOUmYxREo5aVcxT0hFZzlVaG9Wd2th?=
 =?utf-8?B?NGZzK2oxeStwRTRwVE9kbHNNN28wNUpqN0F3VkgzM3BXSVovU2U5aExKQ05v?=
 =?utf-8?B?ajJqR3E1dVFkZ3R2OXdZLy9OdEh6VnBQeUFhK05neHJLcytQMXBQOG9wcHUr?=
 =?utf-8?B?a3gyRlhTVlkzRXEwUEpPcGxseEg0dzF4QnRQOXRNSEpqR2VpdVZVanJzdGo3?=
 =?utf-8?B?QmE0L24xSmJLYjBzcW9abWZHTGRCc0tSQk4vdWdGRWRYcUFCTUhBU3hiOGdo?=
 =?utf-8?B?bnljS2JwaFRreFhCVG9UY0lxcFd2UHFOUDRidVdCbGhyMm1NanVpS01rSzFr?=
 =?utf-8?B?dllzTzhCSDRlV1VyTWJ3RDlUcWtlQVE2YnJteUVCdm0wTUpsTkxGaUVkT0li?=
 =?utf-8?B?NStGVzBjTlMrMEUwamZzZzV2aTdhY25pbHhabVlxZUYwcTJXSXpNUDVxN0RP?=
 =?utf-8?B?M2JyTUp5STd0QzM4d0hpVGxacXpqUmlMRUo2Q09EbmRQUkJRVGpIMlNDN1lO?=
 =?utf-8?B?MWtHbWFodlQ5cXZCSHRheWIyejFwYmpYRVd5elNiQ082TWRqdmZub01xK0VN?=
 =?utf-8?B?WDdaS1hmbjNaRTQzMEhsVjZzd2wrdnpIazk5WlV1Zk9xbk1ZeC9MaXYwM1Iy?=
 =?utf-8?B?T2R6YnhvVFZyRWdONnc4aTd5Tk5IaU5CTk8rcExpK1UycEltMGszV21wY0Jt?=
 =?utf-8?B?RmRrOFdBV3NEblVnVHhvTkFGR1BiOU5lR2dzQmJoZ0lYaFBBM2h1cVRoRXRU?=
 =?utf-8?B?d1o4eEpYU0hFdUl3RHVONlhHRGVyNnVCb3ZsOUhaNjllc2pQdnk2bHFHQ1kr?=
 =?utf-8?B?QnVmODZLNXpmQThkeEdVVWx3Rmpnb1ROaDFaaHM2M0NTcHV4NXVWenk4NlFo?=
 =?utf-8?B?U0VrVldRa3VkNG5VVDRBQ2xYdjd5RUNHT0ZORk40NnZFeGc5YkNlRmExeU40?=
 =?utf-8?B?cXpaMHFuN21lQlZIYUFRaDFTOEdvUmlSNURzc3Q3TzJrc0V2TUQ4cnNGWEZU?=
 =?utf-8?B?S1U4dGdOdjRBd2toUkltd2g1SlhmajRVaDZNYmRZblp2N3dmdTFuWXY3ZmQz?=
 =?utf-8?B?VjNUK0hBaFhNeVk0U1p3eEtFRE1BQXZ1aTBNZE0xVk5YY3dwd0xObFpFSHJO?=
 =?utf-8?B?U1JqTnRYV0V2VHg0bElCSVNGdm93ZXZZNXo3SHZHdm0wMy9qNFd6T0owZzJa?=
 =?utf-8?B?YW5ML3VwMUdRSTMzZFR5QlJBTzRLN215UVNGS0xibC90YmI2UXZFNmlOR3dE?=
 =?utf-8?B?TkFiK3lqejZCeWVLRmowOU80eHZwUFNKYyt3U01ZQkFsSnlxZ0xGcFplRytQ?=
 =?utf-8?B?YjRjYkxrc2ZiSW4wcnUxb25OUUw0dy84OHovQXlaYjNVMm9sTDRVNUNxVVBB?=
 =?utf-8?B?YW1COS84MWQxcjF1QTZQMDZxQ3k2TEs3NW83R0F3RUxLeXRaK1J4UzRnVEIx?=
 =?utf-8?B?aG4zOW9ob0lUM21yMlp5U1F3YzVnYThPYlVNT2NGUGxoSTRGemNZQzU5aWVw?=
 =?utf-8?B?RUNvTGZNR1pKRkVCdnhyYUFkaE5ENWRHckRRZzFrbURNVGNpOGVxWVBJRWUr?=
 =?utf-8?B?Z3kyMzNkeEtYYmVoUTZWM000RDdCVUV5VVN3eDEvL0c5TnlyZnZ3eUo1ZFZj?=
 =?utf-8?B?d1ZuQ1BPZ0J5T2daYzZRaDJIQTRKYUVpWWplNHc4cXNrL2FHemo2eHQ4UVZk?=
 =?utf-8?B?UVJQbTNRNjNmVk1kS21EZGFyZnVLTFpiMmIrWnVHQ3kwQXUvNU94ZG0va1Zv?=
 =?utf-8?B?Yk5iVGQzMFNOc1RRR3NHOW5IQWJqR2NXZldxZnZQaG1TRVJYQmM2OVZxMzhY?=
 =?utf-8?Q?ek8YsmcAGGP0LUwAnuGUJXo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeeb76a6-7c43-4eb4-af4d-08de34ff5268
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 19:40:33.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsbhIdqADP/ic51OeL7dLEjDKgzdsSqTm2l5MT478wqy+DCbNOIIqAI4FRWOZtwZgEwiifUnaIgi0tlaklSSrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596

On 12/5/25 6:06 PM, Jeff King wrote:
> On Fri, Dec 05, 2025 at 04:20:12PM -0800, Aaron Plattner wrote:
> 
>> When is_promisor_object() is called for the first time, it lazily
>> initializes a set of all promisor objects by iterating through all
>> objects in promisor packs. For each object, add_promisor_object() calls
>> parse_object(), which decompresses and hashes the entire object.
>>
>> For repositories with large pack files, this can take an extremely long
>> time. For example, on a production repository with a 176 GB promisor
>> pack:
>>
>>   $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>>   ________________________________________________________
>>   Executed in   76.10 mins    fish           external
>>      usr time   72.10 mins    1.83 millis   72.10 mins
>>      sys time    3.56 mins    0.17 millis    3.56 mins
>>
>> add_promisor_object() needs the full object for trees, commits, and
>> tags. But blobs contain no references to other objects, so the function
>> can just insert their oids into the set and move on.
>>
>> parse_object_with_flags() has code to skip decompressing blobs, but it
>> unfortunately doesn't work with the objects created by
>> mark_uninteresting() because they have obj->type == OBJ_NONE. Update
>> parse_object_with_flags() to handle blobs and trees that are in this
>> state, and then update add_promisor_object() to use
>> PARSE_OBJECT_SKIP_HASH_CHECK.
> 
> Good catch on the matching tree code. It doesn't trigger for your use
> case (the caller has to pass in the DISCARD_TREE flag), but it's a
> lurking bug nonetheless.
> 
> I'm tempted to say that those changes in parse_object_with_flags()
> should happen as a separate patch, since they really are fixing an
> existing bug. But I can live with it all as one, too.
> 
> One other thing it might be worth thinking about or mentioning in the
> commit message: we are skipping the hash check on all objects now (not
> just blobs). I think this is OK to do along the lines of discussion in
> c868d8e91f (parse_object(): allow skipping hash check, 2022-09-06). I
> dunno. Maybe it is kind of self-evident that not every operation needs
> to do a consistency check of every object.

I was rewriting the commit message for that part to justify why it's 
safe to use PARSE_OBJECT_SKIP_HASH_CHECK, and now I'm questioning it. :)

It definitely seems fine for blobs but if what we're trying to check for 
is on-disk corruption, maybe it's not a good idea to skip it for other 
objects since we're actually using their contents here.

I still think the OBJ_NONE fix is worthwhile and I'll send that out 
separately, but maybe it would be a good idea to split 
PARSE_OBJECT_SKIP_HASH_CHECK into separate flags for blobs vs. all 
objects? Or just go back to v1 of the add_promisor_object() patch? Or do 
you think this version is okay despite that concern?

-- Aaron

>>   object.c   | 4 ++--
>>   packfile.c | 3 ++-
>>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> The patch itself looks great to me.
> 
> -Peff

