Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981743AA4
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164983; cv=fail; b=uSSXQIK8Z4EgTQg81r6U+8GDpB2j6bTdbBcofBBhXdLcifk8F3aJrYFX9U23aOeIyhxiLRdiCtCfXgiwHT4MyWqibdyPuuuR83pK9EZgfbAe3Sj+5B6IDNAkbIHwB8MJr/lIkLsYVa0yM0uAQ14bkM9uhDSt5ixEVpRUbIhJ6vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164983; c=relaxed/simple;
	bh=0cPoD6M8euZOpmLLwhLxwigZ4T7LuI4jgxNUr4J3aJM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZeiZMz0xoDcFwgvmrkw1DEZwueL8K5usP2GvGQzF8vhz9StyvcMghIKTTKbFcEuhcVke9yJio0Re8/ZuS2ih2EV8F5PfeGmtBaW8nC9+ifNbIeKp6bjrqNstFMZa4Qs80R7JNRR5v0NbS8SJgcdaz6eoOOVbxCFbopvn/0vkP+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lLB1YHWR; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lLB1YHWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENQuxkMlYM93pb5wWlj+kezpVxe+byfu7mfONssnBE8/qRHSCWhQkdHC/opbP9AoGD2KjCLmfzq6MP3pCnIaPJzkClrUy1OwoD+jT8R2IeOzJUjhEfp4fFr78H41PoBHMo9DncU9GrD5uoZMBPZGaGknjHTAZt/s6LSK4VAJIqFfJMj9ucjZ350m5GX55UvqOdIs3yNiZo4T0WKm2oEf+sA+Y+NlLW0t8RAMP03s1aeiR3FpwNR0tMNwSpLYsE+xSL9zKoxKMn4dEfn+5fdBhcnDtIqCcioHLvK3vipkYSgW+APCduwudAkkkNGOLg/QlnQJnCRrad9ENesQyESIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FKtgk4F5gphzTQ5R3JHu3aec1aqydnIvHkuDqT9emM=;
 b=CetA7Pu0m+wZIW+caTrm0r6ESGClnd29nagzqLzgEgi7N3S74P54X9SJkyCzlzWd8uLdfPlD/xhdh2NVBl96bpvwDi4GffrXk1PDTIsUEURty1DFwfZnVn5VHQ/HACZSjCshvQOydC0BIyIIJ7kyn3n2OWDo3hPqiMciKU/xoFhIV7DJmOeM90RxPg3lfKRkeC+zqdRwImffgMsDfjUd8BYCf0stAkutFf9WprjNUL+7EaoMkrMgoIR/EEvxNWTce7Y0AYRvfDLTVOoSMH2ILPrjwCDXXvdXkxFRYhJfpET4sPi2I2oDcAiUE/4w6vzxq0b3fHvGSKGerMRFC/pgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FKtgk4F5gphzTQ5R3JHu3aec1aqydnIvHkuDqT9emM=;
 b=lLB1YHWRkwfKh7Mr1iZcg3PdbiDLenktjVr0ydyfG0BH5DRm14Q2QRSzSjleU7nX/7eXmWQfjHYbQ9KzattB1xFOnCeoVuquEzR24FaVgZArDbx4nO3BaueJR9zjz6WBkuGSpNVztmB8R2Eo28w5p/GAPqmiJ+BcudM8Onw+r9+UWua3MlSI3eVsoJ3nyXWgVKQCkadd2MRlnTgtWrXhRfrexkEoFRq2UMsOzd0uSsEMJUUhUPkslppFKddl4DGoi8tWDnWblO/XuaFqZUpapGCpAHoi7XvVUxh+maxqP20k+lviiyW5OmOEYmeJAx6quhPJYitX7GEmPt7I31i0Qg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8986.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 13 May
 2025 19:36:17 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 19:36:17 +0000
Message-ID:
 <PN3PR01MB95977BF45DCF3E7F784FD909B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 14 May 2025 01:06:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add instructions to use Yahoo with send-mail
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 sandals@crustytoothpaste.net
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597AEC10C20F4B06C4BE254B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqzffgfj2m.fsf@gitster.g>
 <PN3PR01MB9597028D4430E9C2C2BB1E5FB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597028D4430E9C2C2BB1E5FB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <1550e0ee-5955-4493-8bcc-5bc65ac81ca2@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd8ba80-b799-4054-4184-08dd92556cdd
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReFQO+5d6ofa7WPjBVpSbrYuZq4V89O4AxzYAOF7hxqH6LIDOnEvoLTHRFLQhUyk7uWvHNW05nJJtkxgKBLNdKEUBGC65btXcKDN2OoP0xgygVgW5yuc7Oeq52/b4ELSLSNgJ5Rs6AstOcsbaPMl0HaYVKCWmnAlUdraiWDTluZCFBg1AAuOiqNlotBKqzx0lVqnxADmbcG5g1d6c1GJ7xtwH2/zd5+9cKgmN6b6yqlPBi0583UKhZEa4eicP4JXOPsDovlmIsavfV7Sl6uTrmIzjbSG2RXinkliZ+VlBIiCvnTOORf/NLR264OVAsXWxYp8w+2lK4Km+bPbutzVnNFNTFZDs50zcLpcUF5BYfy8cPPGgDpqF2jiP36Hi2GfXUy+n91ADj/hx8Vof1SSdN+sDUjAqbXongGczjeggnfKb5CN/kwazbJQip3ukwCqeZ9Oym6hWjod1IKY4mW/YNPVRXR0lvZqr5x3h7zEuG58gE65rtbnKIQHIALhrr8fjZtjkVp6Y3WKF6H4Sqi2ta083QlJAJWmG8enfzPfi5vAuoJApVTMVQQjIs1O3nwJF+Gv8tG80heaIxOGpCgZNjyfIsMQWiVMRg49hO1nsovkbEZSScDfvgkRhRwnIwJxGuBVug83UzoOHBYaQ94FymENYDokNBe07dlzUqN2gk7Hev3s23B3qS51F0eg3yle7BJ25PdYrD1NhJhkEjlyMKB0UEfFPAk/Z/AHcUiQDFO5ttZQEXyBzFs1POyGYCe+yVAh6AYc+eRishIyoDt+KTg5oD4Gtyj8G9fE/9zOoliisg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|15080799009|7092599006|19110799006|8060799009|440099028|3412199025|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzBjSzVTczdjMWxidGlTd3Fmb1o4blVuV29VOFNhTGhmdGRVSkk1WUxiZ3F2?=
 =?utf-8?B?UXpTV1BvaXNvRVdrUXdOREhlQlhRUkRuU1Q1OVg3ZkpEemlQM0FJS3QxTXNQ?=
 =?utf-8?B?c05LQUY3bk8zdHpSUms2Nzg4SDg2YXZiVVZzcWZUUklicms0ODlwandmdUtR?=
 =?utf-8?B?QkI4anBHQXI1elptcEU2Rlk2RlZJbm1LN1hUdXpUMFFENnJyajl3V2YxYlJq?=
 =?utf-8?B?TzFpT1hudkM4RFVJUzRNTDdnTkV2eCtpSWlDd1l1aUd1U1Jmd3p4b1BEajZm?=
 =?utf-8?B?SDVweDlGdnFIT0hCRWl0MTdLYnlCWkxiNzdOc3l0bk0zL1JKM3dBRmNZaVhr?=
 =?utf-8?B?VktOaXU3Wmlqa0JrVUlXcysvSXRKSEdDQXVneUN2VjdtaVRyRUZLUWc1MkpW?=
 =?utf-8?B?dGtoVWk4ZTVnUWRmUStSS2tUQTVmQXRhNFJ5Sjk1S2ZsOGtlSXlhc0h3OXhD?=
 =?utf-8?B?Ynp1N1l3WkNMajRReDhoTW12SnlONXZqK08vOVJaazc3T3ZpbUJWVjN6cUlI?=
 =?utf-8?B?NGhvRTFwNFlwOUlCRytWTVlGUHQ0c1Npb2ZuRjRaQncxTGQvKy9ESWM4UzEw?=
 =?utf-8?B?blZaTVoxMHlxd2dIR0RIejlTTUxrVVBYL1p6RlZkMmFWdW9uSU9PZlhRQTRC?=
 =?utf-8?B?Nm11UFBhTldYOTBGZFhKQ0g5STJUcHJJN2JXV0tYWEtBMmN2T09TSWZsUU04?=
 =?utf-8?B?ZDl6ZFdBUHN5ZFFxVVZ4QjhnbENvTTMvWDNBOFFObldVQy9XUVFMZUNHUFJY?=
 =?utf-8?B?UnNvTGFJRFBybGgyNktBeDhqL1FiL090cVFHR2RUL1cxMDRyRjF6ODhrSTFU?=
 =?utf-8?B?R1p4MFdFZURlWHo3ZksrYU5uZGNrZmVtNklJNjZHU05Ua0lRK3RlQXZoVE5m?=
 =?utf-8?B?eEpTaWkwQlVmSWMwYVBvTTFZNkNsK1lXS3czeEJucXRWMXlRL25kUDNMM08w?=
 =?utf-8?B?K1JtSCtjU3dHQ2V3RnNseUh2R3liWDAva2V1M3BQZWxadEJkSFBvRU05Z1hn?=
 =?utf-8?B?bmF4TTRZc3NPclBwd2JldVR4UXdYNTc5R2IxdGxDbGpUZWNWekQrMXF3ZnhG?=
 =?utf-8?B?eCtIYU9Qc2pNWFBoSU1kelJTM0NGMVJlY1ZsVEhNOGhSWDFCb0Uvb0pWbDZR?=
 =?utf-8?B?eDhrdFZLdGtrZEJRQUdwdE0xajRzcENuSVMxK3dRNWIrMlo0UUJJYXVWNXJ2?=
 =?utf-8?B?ZE1seUphWnZEekFMQ04xRUhGRTMzTDZMbW5SU1Y2aVVDNk5PeUpFUmNDSVla?=
 =?utf-8?B?dHdTeHlxbm5ya2YrWGw4K0RFd3hlUTZuSFNyc1lBN1dMTGk4bmREZUdxVmNu?=
 =?utf-8?B?WmIvYjhZcTVJdjkzQ1BVbEdOK1cwS01tRnZZTVQvN2VxalNsMlNENEpGaVE0?=
 =?utf-8?B?MVFtNW1lOFF4V0FvNnlidTBnOURGWG5ieUg0S09mV3BLWkhQY0hqM1ZVU1Zi?=
 =?utf-8?B?U005Umpyb2k5U0I2TE92OFFvdnhTbFAxKzVDMWFxME1ncm1Sa2QxbXpJZ0dR?=
 =?utf-8?B?djQyL1AyKzcrT2V4aU1PeDZ4cVdnNXVwbXl2cTBhWDAyTjJoZFpYc0R4MnBQ?=
 =?utf-8?B?Q3plYUVFRjNudTkzV2RCVHJaYjNnSjQyV3MxUUZWME5jSjlPOVJPaVRCZEor?=
 =?utf-8?Q?fN7UylqvJRJvGGqQ67QVBGtlByZiuEXJcNueJ1TA822k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWh5TzlDWWYzcDMweGhzUmZzbFR4TS94Z2NvQmxucXFRUzkyNnk3N2NUaENK?=
 =?utf-8?B?VHVsNk90cTRFZFExRnFlR2Z6NHkrR1Jka0FpemxIUGFCemFNYy9YYkM2NVor?=
 =?utf-8?B?ekN2bmdrZzlRTXg1ZDd2dlpNZ3o2aEJHbWxaQ2d0ZjRxdEVlaW0veXZRcEE2?=
 =?utf-8?B?QkkvSDMrWHpyWHB0djREN01rK2VyRE1kUDZjb0xoZy9haE9JNFVlNXFrVzdr?=
 =?utf-8?B?ZU5mUEN3Tm5teWlEZU4xbHdNK05XeDVzNk11QVFxUGNSYTByWk9GRkVPOExz?=
 =?utf-8?B?UDJBQkZlb1NVN2FnMWZyWVZrZHZacWR1Y3VpTnFGUGFvbDJSQnhkTndnVGNH?=
 =?utf-8?B?V1RFSU9oaDBpOTFKNkZUaVRtRlNpbDJnVkRPN0pLSFpabFM5WEJ0SmhUc1E2?=
 =?utf-8?B?YXBaYTl3SU9YZGtkRnFrTzhCYlNTNDlPVTRGbWE4c3RhS3FXcDMxUDduVWdS?=
 =?utf-8?B?U0V5OGp5NUlTeXV2b0ZjZWJOTm8wcmRDUDRIRnZjYndJYis3NEViWGdhcjBh?=
 =?utf-8?B?UEpSdUpENDNIYWMraGlQV0pjWTE0Vkw3N2FCSnc4UWRJVEJ6eG1EOGdlcE85?=
 =?utf-8?B?bmtvUXpnSm9MUmk0dXV3eFphdVFCZk1OZjVGNHd4bFpEd2dOY2ltNGM3SjNh?=
 =?utf-8?B?Nlg3MmNQdGw1c1gxenhuZGhHMHp3MHV5Ykc5Q2dvZXVpWEVJd1Z3dXd2R2NR?=
 =?utf-8?B?dEZIWU1pZFpGeGcrOWlVT3k5cXhGU0g1WGdvZ3ZIeUlSbUpIeWR3Y1RqVWVY?=
 =?utf-8?B?VGhQNlhJdVlEVis2Kzh6WEZkSVZIbXlkbVV5aUg3VU9UWWlwT0UvWThtdVg2?=
 =?utf-8?B?dWo4dmQ2RHVmYWZBNjNCVWxXQWgySTlVTldQM0JhMXV5Sm1GRTJCaW1JaXVY?=
 =?utf-8?B?VG9HK0Z0UnJJRmQzcDV4VHVSdWVqWFdtSEhoSzJKTjVsaWcvQWZKbDRnTUVx?=
 =?utf-8?B?MlprSmI0dmd3QVI5TkhYK2wxVCt1LzQ2cnlPcHd6cExBbTRpTlc5MFJoU0lT?=
 =?utf-8?B?aEVMMGpmd1EvaExCMWlTaWpUV0ZtaS9NOE5FeC9HRCtGa05VWVJiWDJwZHI0?=
 =?utf-8?B?MG1jU204cjYwQ1gyU2JjRGVRdWFEMWZCenU2Qit0am9WaUNROXZpRWZOb3Z1?=
 =?utf-8?B?d3IwcGMrWDIvZXV2S0RzNCtPRmZtb3pxVERvdjE5blN0anVzR2lmNENqTHY4?=
 =?utf-8?B?TFQ5a0I1UHUzYkVhMWVKaG4ySDBYaTFoUGRhbGYwaGFmcTlLamZHdWRsSlFD?=
 =?utf-8?B?VDlBci9LQzlTckVoUzNMTHFsWkNlWnVtRWtjYkNDaUU5eXZZSHpNUUpFWExt?=
 =?utf-8?B?eksrU0ZwMXFsbzBQVVQrei9sazVwZnJ1UFFLdDVkVm85M0pDT3ZQUHY5QTdJ?=
 =?utf-8?B?V1FOWjB6Tmw0bGlieHRLSzBienh5aEFQSlRwZ3NHUGllZjdBNGcrSjZsbUUw?=
 =?utf-8?B?NnFTNzR5YmhVZGFlcWJNRTkzckp1S1ZkdHhld1lkV1pqMTNUV0RFaDcxb2h4?=
 =?utf-8?B?QmQ1YS8ySnZkUnVRWVpHbVdCNjNMRG5hTlAyekhsT3lEa1FUSkRibUljN2FB?=
 =?utf-8?B?enFUQnlWTnhrY3lYRHNIK2VDSnJqRGVuZFJWRWZXaWwzR05WYXFmOXZZekp3?=
 =?utf-8?B?UDFUMkx3TGVrcUhTaG11OU9vNlc2Sk45b0RFU2xiUXhBMGxOaW04amdRNk1z?=
 =?utf-8?B?RnFkb2F3T2w4dFNzTm9qMDh3OUJCeHlPSDlxOTlWSm1vQ1QyYUV3clNWODRG?=
 =?utf-8?Q?tYhU+02MkrWNSfW1oQ=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd8ba80-b799-4054-4184-08dd92556cdd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:36:15.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8986



On 14/05/25 12:21 am, Aditya Garg wrote:
> 
> 
> On 14/05/25 12:12 am, Junio C Hamano wrote:
>> Aditya Garg <gargaditya08@live.com> writes:
>>
>>> BTW, I could not get the source code for https://git-scm.com/doc/credential-helpers. It
>>> seems to be a page for all credential helpers.
>>
>> Probably
>>
>> https://github.com/git/git-scm.com/blob/gh-pages/content/doc/credential-helpers.html
>>

Ok so I'll just get the Yahoo docs merged before opening a PR in this repo.

>> See https://github.com/git/git-scm.com?tab=readme-ov-file#git-homepage--
>> for the general notes to get changes to that repository.
> 
> Thanks!
> 
