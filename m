Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B93BFE35
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060736; cv=fail; b=lMW48hKq9fXOthX6D4I881p3oU+Nz98kBOjnQ6+jrs68IoRf7XJ1l0P2jQy4swN2CrREZUTVhcsCA3T6r8H5GtC0WuR9rn28rN3388YpQotMheggTgPob2xHsQv4pFhcaGI+jTPTxGS28Z/y8cI5UfKt1gmpUEu0kgMbZNNB/sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060736; c=relaxed/simple;
	bh=u/EB4qyO1qo50qDN8VqE86xrmaKc+YGhoPip1qP573U=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=WEz07CQLs7EbeDyY0jDNsyHJs2HHX5skDKcmlmcPJCI2Pa2V+/isZ2X1eF9tpok7Tq2RRhxDZXnuZnQbdfzsqUy+5d+9vWZaJjpi3rlRfojS8vUU7uaxPrqClz2ziKMUPAMIJUbvfmE+mKAAuezlwJSL/QOb/n6nmncv7/pmY+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Ju6MgTTq; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=JCK3lIYY; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ju6MgTTq";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JCK3lIYY"
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629A8Pbn1293929
	for <git@vger.kernel.org>; Mon, 9 Mar 2026 05:52:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=Jv5AYZjXc3bhU
	hGE5arKXaaMGzzSSljKx19PKC2zN7E=; b=Ju6MgTTq38wSjONYTOKnseYxPvxuK
	Zli+mmObsMs8RtTixDD9PVXAS/VtF4BX38Js4SUlE/cXXQlUzCUmIpYY4oG9cM8b
	f7GCKmPyK902ZCimbsyNLGEvaNHUdfGJFp7xR8XynjqiQPt51y3DcydArDurvhjS
	lKKXPLPLo+5qsORZ9HNpT80f62bMD/3il9cTRTyBUeSNB+sX7Ei7bFd1PYz6MJmm
	xSqeUAWSycGRqIDwwLU2X4i6JFhqrNSRCFGiAQgyzrdqGzNx2TDZ/E2vPQ3W+UTT
	iKGaExmP6Q023LUausbY7LZreD5+DIk23p4WHfC87Fbw67XdjfalCXmYg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021079.outbound.protection.outlook.com [40.107.208.79])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4crgtac3xb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 09 Mar 2026 05:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoKfxZgcYik0fECqHp8t7MLurEM/6ioU7mXqA5f1EbFr2+gEX3F7uzVY2EhZ5YWe+9kh4jVqHlhF2ON9l6nOT8sWpy5Hjmwvc/K8S323AOHT86AN7PA+wyIPfieZ1OFIGVLK+hVZnRQhzhZuanefgzSlEdls+aHhh4O7ZNkSvqtuUM62Y/B0IbNDC4h10WPgXTAJ0lu+I5Fn4iLCPZvgNNj/egrg/wSla6rdWDtTf2CdVcCfsNQMtR64NR8WIKzNcyfivk9YnvK4sfFafRXLkOVt748Yl5Q//Sn2avCxPI4E1VGUVkNVnlf7376gv7e+4dygMWsalvHwQuqIXIzKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv5AYZjXc3bhUhGE5arKXaaMGzzSSljKx19PKC2zN7E=;
 b=FqGaBkXiS3zG/QMSAGpT/ORrbH8ybTvR9QIcoJlqJh0bq8KZMLc0zpb11D1GC4fD0eeu8A5vlh23tJNEMXzcLt1FAdYv3eLbsToeS5ZTEoBpX/bD+SDYNsaJoODXVQkzdZNv6acjSAWPYXguKsMR8LmlPc+U79Kwy98ML8igegb14qAizkFe9VZhvB7ujsnELetcyqe52Na9jZhmYgTxqF9q5L08b70PX4oeqT4ufpHIOnwRV8F47MpshSj0ifDoOJO7DZ5uqHsWm2HXdY/MzC71kLqp0wqGU17hPQLD3D+0uV84belHfQmLV2uwYn9wJO46EN2kgaYpTmoJCclfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv5AYZjXc3bhUhGE5arKXaaMGzzSSljKx19PKC2zN7E=;
 b=JCK3lIYYYSoc1YD//vcRdUx0Sso4mqkfwi+wgtnkZlO2+EsexCgmCruZ2+EOZONKNQQV1pF/1Ie8hGC0a4loH2XP5Cmu1evlG70JjKRQlePaWY9H1tpyrN6+4Vq0Zcyk+mDoyAprU4U+L712CyJG+A8IfAMLKbEjQA4Tl3nwioHA8FQXL02mLe2YSUU0mIJYUqoXPmf3w7Io/tV3HPOOU4OWdHOI57Cpdl82D9ETWvxa6gq67AJVBvfNjdFWC/4FAvL8Jkpl3mTbajhPo/8aDaqqw1EF2ZyfHe/9GSQm79XsvMF4rWSQQtTcJXMpNgx89XanbPy+nzYcQ0l+x2UHeQ==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by MW4PR02MB7298.namprd02.prod.outlook.com (2603:10b6:303:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 9 Mar
 2026 12:52:09 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%6]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 12:52:08 +0000
Message-ID: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
Date: Mon, 9 Mar 2026 12:52:04 +0000
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Florian Schmidt <flosch@nutanix.com>
Subject: Option for "git submodule foreach" to also run on the parent git?
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|MW4PR02MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e44b72-440e-4d53-1bd8-08de7ddaac9a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	6ACWgeN9uSHKaqTMZNR8YF5fn/D012hfisbG5GFvCsAE8QVlGBsq0LeGqNRfjHBR9rOB4OUlQFoBJn+DWULQeq6IsCqiMPp886U+qixCmfr/VOlbfd/BUdoFQ+4SYDkZFgnwIsULErKpIuXTilZ6OmE0ubqLtMzQrSWsbr1+oaRH4T99S9VV6k0Lg112H9KK+HtDZ7o1BqlSWkY8vB5KSuEaOqI3qYBLcRRa4JCQOg4FgGL053wJ28VJ7rGLgSkAYFYfojrzfXbUgshLE0efErdArOb+uoTfI9QbEHtOEpzUCxEmQ7j2/bHHNxZtjYjkBmsfeyg6Cpo8zSVPD5+KCFa4TF3H1H7T8axzqgrl2dASQq7bmEefeYE0GcH9gmq+IxlOwPG1u6R8+wwikaw4aWz5Xhnkega765w5HF/piGl4mdQ/Za3qr9hFMYAjFadEepS9tHcOcFf8J967ShbtmDaLpE6VVKeAoMWvQ176yoHwsjLh68E+aI3qG+5iC5YrzXz4RmPtZYN5fUMnXdEtqMmkonBrrqYz4wueosxU5hJglV1mG/J+/V6kqIxR0gnSqYP1iVTFI4r6EJ0ZFBZhXJlorYiOv/HabTHyQ4X26hC42RI+B8G5Lf/F6eRgxq26F1ej0asYQuBFdemE1M0qj3qahw3W4/65LRkLyYJXPz/8HVxLErz1xWQicw7EfUGDNcMmgJctyYihZVLxovM46VhGapAdaXygZgpzWOlA14g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR02MB9992.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmoyTFdkSDlPa2VITUpKWDk5SU1xNGQ0bmFjT1poT1huVE0yWjloVU5lVkpT?=
 =?utf-8?B?ekVlQ3NSdnQ3bU01a3poU0hsZGZ3QytLMFFVKzk0UGZRVjBzOU5yaTdoS0pQ?=
 =?utf-8?B?RFhDZ1h5TFlBQktyeHVPTENVa0p6US81TmtUWFVPVTc5UERYZ1BsRUgxS2Zp?=
 =?utf-8?B?Q0JJdG1kazdmZExLRlVlaWhWQXZZK2pkMW1PbDM3Y1Fwelp6VTBFUUhRdEsx?=
 =?utf-8?B?cDBLWkxEYTNFemRYOTcweXpZNDJ0LzZ0MS8zMUptV0xmUW5qbzFsbE9Xdnhl?=
 =?utf-8?B?aStpVGJSdkJnellsQUgrRnZ3bk0wcjl5VmJ3aXgySTBqOXVMYkQ5ejdLczRD?=
 =?utf-8?B?c1NGM3UrWXVWQVUyaTV4MXJacmRYeDhIZW10ZHpZWVFVUTVGVTliN0V5T3V5?=
 =?utf-8?B?VXhmVXIweTBrV2djc1RNamVOUDlmb0QzTjNIUEw0dFFSZldlWWw3RGZJS3cz?=
 =?utf-8?B?SnhpbFNjMkdkNjN2SXZnSWVKSlZRYnNzaHI4amRLSkw3Z2xBYktkZUloMEdH?=
 =?utf-8?B?QVQ1ZHNQaCs1SWFXZnR2T2k0dEV0cGxrRWwyb3hJSm1WUTBZaWNHZXJ2TFBt?=
 =?utf-8?B?Yk9LSThUN1FsZ1RueHRqbkUzWFZIZ3ZjdVBXdjVlTTFJQS9jTUVJdGw4WXNP?=
 =?utf-8?B?cWdCcUxuenVuRjlrQmk5WjJzOHBoZ2lvNmtwTVZ3NWtJM3Z3Q3BaeEVWbCs1?=
 =?utf-8?B?ZUNLdmhmeTl1M1Z2KzIvYXBrK3phUEgzZXRxWEJjbnVyd3cvTTV6eWtXbmNF?=
 =?utf-8?B?V2RiZjdhZVJIWWlyandNcmsrMXhtTXVFU1JUT1VRMGtSY0t1SXRkbzdwQi9L?=
 =?utf-8?B?VlpvSlFDZjR3b21iTEhKdkxyMlFGa1JDYkgwT21BQzlFRm9SL3ArVUlieHZ2?=
 =?utf-8?B?d1BIRUJFdk5iTzFZQnZLeWpSN0xLQW9vWmsyL2JIN0kwS1R5YUZ5aWRWc09k?=
 =?utf-8?B?MFkwb3hCeU9FbWYra1Avbk9lWkt5aThDV25ieGR0K2NCSjFKeUlxampTRUIv?=
 =?utf-8?B?RVd2TkZBZHMvVGNtb0ViK0ZicjUwbVQ1Um52QzhNOEZNbXZIWkdCK0ZQTUw1?=
 =?utf-8?B?RUVmd3BOc3h4QTcxRUVVQjNkZUsrY1IvZllDUkhCcWtBQ3lXODlXNExwWFRi?=
 =?utf-8?B?OHlmTGt4a1V1WG8waU1tbFJaaEhhYWNlZzVpalJjZi92aDRJNFpGbHhQUjBt?=
 =?utf-8?B?TmN6RFZGd2RvNG9qYTFZRGY5eGVienJ5RlNjcmRtZzdsV2RJdGU5Nkxsc0dq?=
 =?utf-8?B?TW8xRmJlWGJFcGZ0YnZvek9QcHJQcEJLU0FDZGRjRGJ4L3lLbjNDeTdtQ0xz?=
 =?utf-8?B?MFpudU10Mi9LYTVxSy9NeWpISVE4azN3QXhsbjZGQ1pKMG1JWHlIaS9ZRHN1?=
 =?utf-8?B?aDJwRkVIY1JnMk5hdnpEdmMvbGJWRDNobEtaTytESVZkNmNhd3paczlKQ3Uy?=
 =?utf-8?B?WWlmNlduSG1EOUZxSjBFdXhUSFFUUVpEdVh3aGJZZGVXZ0FoMW9WN2JUN05P?=
 =?utf-8?B?RkVHakRlWmNJTlBZTU9iOW03d1NZT1l6MXdHemZtS2tuMVlmRjBrbUFKUFM3?=
 =?utf-8?B?eENyVTRRSVQ1SjZGREtENGpKNWJzbm1TZ0laQk0vOGRUMGh3cnovWWFvT2dk?=
 =?utf-8?B?ZUZqVnVqRWFyaFBNd0R6V3ZyRnVoY0M1Tzd0QTkyVXdjRXpWVGtRVXB3bFpF?=
 =?utf-8?B?c1R6cUJLRkRsODE0Q3lEVTVnTkh5bFpyeVJHa25GYzhYTHVFdndKSGdLQ2Fo?=
 =?utf-8?B?SDFLbUZiTlVENWFrcEZKZlFNRHR6Rm1IdVQvSW1vaTF4alJsL0QzTTh4a0Js?=
 =?utf-8?B?cVcwNlJoSHVqSCtzTkd5SzVLekpSeDBVNHBhN1FFYUgvZFAvM3BiUkg5cTh3?=
 =?utf-8?B?eHdCSFczNjFrKzZnZUh2alMrM016MENNZFI2WGVKb09mUmhhSkQ2S2tqSFpK?=
 =?utf-8?B?NVl1Mm1hOFRDa2d2Z2VJRVhNUit6WXJETG1DNG9ROExzcXg5YVBsaFcwZDhY?=
 =?utf-8?B?NWthTDdUMFhFZm0raUQwRkFmQStySXB0a21lTjhYS3dSQ1QyVXhUQm0yT042?=
 =?utf-8?B?eEpPMGhvbjhXMnN2WjFsbDd1QjdjK20rbTlvbUI0MDdMSm5DbjE4b1JoWWVF?=
 =?utf-8?B?UWMvd0pMQUFRc2FLQ2JoS1IrMXlGa1RLMW56K3BuUXlNczR6Z2t5WUdsc2VO?=
 =?utf-8?B?NjhaYnhyc25tbklPWWhjcDJpZHp3L2FVckt4eVlSbGhsWWEwU0wvSm54NDU4?=
 =?utf-8?B?dFhjSlNrTzRqbHpWTGNqR3ovVnMwcmZkTUpqYUhwVTg0QThHdm1BcUdqQ2VX?=
 =?utf-8?B?V2NzY2ZKblp2amlXT1pNYm1pWWlnbjcxTWE3U2hDZWg0eTV3UEdRYzh4aXdp?=
 =?utf-8?Q?bkNBwCjiEHGpAlU8=3D?=
X-Exchange-RoutingPolicyChecked:
	Vp5aqYHxK8IAeZ36vR1RcJ1GjYR4OoFuT/xB95QLqO/XKwXiy34PV6F6FvUrsoAAa6Ow3Jq/L06c4VTUBdVBV7l3KpIUbqKA/rEJj6A0SHcL37F2IS9Nt4T/SYGVlXJYahgKADH3m0ceLEcuTQ6B4QpMPFeJPQltrn2gIZJGBqHqWGr/BAAryBMzr80DlrCQyTrbAfMnNca8EBrRqjKfrSTXrk6t3wIDCDxLBVXGY6FCRJYoWwHc+OCa7iNDvtUzTw7AZQvJ4iLVYpTegvgZT2FLeHCby1Uh/CKvmSSJc7wBGGi1Xwo/2q+mMA32eS3VuM8c9+lD2IOsXrsYq1FACw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e44b72-440e-4d53-1bd8-08de7ddaac9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:52:08.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZ7IIX71gTJKlShOhgs1Wdf2L6xoYUwnf9O6kFUrtQeX8kFa/yA69tQ+VStsJaYYjIYoKxmxFTgxkvYQ1Vf3ZP9ZeBSRe3XfPmXLviLzHgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7298
X-Proofpoint-GUID: Ks2bC8-ZWH3CUaqlKdgxmzOS117HtUdD
X-Authority-Analysis: v=2.4 cv=Ov5CCi/t c=1 sm=1 tr=0 ts=69aec27a cx=c_pps
 a=OrhHz3+zTO+bBwkwaozMtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=nmQwc5Y6np_tO8rHDBEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNyBTYWx0ZWRfX5o9sD9BE0n6G
 U6jibuX0n/elNZtEuk0taQbzZqLk4QE2stDQcEvoJAdEHJiAFadcnjNnp0wDE4MX5dqKYRRLUmT
 JZRhavLBW9UsP6JCOAvehXjpFFSNCvrU2vsnny26GmpOyrBBR/LrDgbF+jGu2c8+OCiYjdGzljG
 L5T095AOBV1IJyrNiqbT3OE7WmQAGBW+5qffSwuV+740b0KcBQIhwP4nYw78iyj+ffWIApc6Kj9
 YdgLWOaR8IOgLK1wM18LHkAaGwAbP4JIC3FJELYwRDmfzXBK8DJUfG1Frm0OjWjQYY9XBY9pfPE
 wzx/t6n7Kkp4jv3vLPc48GIrhtD/OulbZIehaYktScU0IztF/UKFHOx+adFaEhWbuJCa1pbPVOG
 9ezsxmS9V6izNMfv8P22i+M4wtXaQWmTFIKbgzR4w5l+UqYkSmY/3CLfDAn3mm/PyHWXxYiqb+H
 xUbFnIGru1kHQGP9QCg==
X-Proofpoint-ORIG-GUID: Ks2bC8-ZWH3CUaqlKdgxmzOS117HtUdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Hey everyone,

would there be an appetite for a new option to "git submodule foreach" 
to run the foreach command on the parent git repo as well?

I occasionally use "git submodule foreach", for example, to make dev 
branches on all the submodules if I expect to touch them all during a 
dev cycle. Even if I don't need them on all submodule, once I'm done 
with everything, I might run something like "git submodule foreach 'git 
branch -d <foo> || :'" for easy cleanup.

In either case, I likely also want to run the same command on the parent 
git. That's easily achieved by just running it manually one more time, 
and I'm sure it's not hard to make a git alias for that either. But I 
wonder whether the workflow is common enough that there's interest in 
adding a command-line option for that? I'd be happy to have a look in 
that case.

Also, tangentially related, "|| :" works, but what about a command line 
option to continue on non-zero return values and not abort?

Cheers,
Florian
