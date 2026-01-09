Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B500971
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981502; cv=fail; b=etBnWf1sR6O71sbS80dh33fy+zIBWAW/dUsGJL9ZpaLIO2s5iCJZnmOpq5fQG4Szi4DISemlP9grYm5SwKLlrJmpM/JzhKSZVFq0EQLQVgdxALIbzYq3B8xu7jn7xe7WX+HUp0mdleuSYOh2tI2LGoLvnTVJFSrUuFIeQujt43g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981502; c=relaxed/simple;
	bh=wNmARcDBcdXzgh9d9feFUVEaWUiqdC7uO3WZoAeg32I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UNHlVymDtAvsDTx1HQ3aTpTtyp+74fTajssG5J/FyR6qfCURteAYHFfhN+AHEXvWn+ZmSePBj5ZNVSIFdJlhYd0MgvXerSTEicoJ2TH/4hZCVB4LxGqCa1aA4VWA1ED+HLRkaaLLUGBcnVncHRw7VFx4bz62l3QAqkgbNRh20hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c08pjCEb; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c08pjCEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTPyVGf95XoHm5/ZezbUUIAfc0SqBU4Ex6rn1DnSanJECotJT4szLH8bNvSwgu7c1YKMlTA2zHPoFgvZQM2hFyLa2DH4/H3WIDCsaZS/x+cLx8f9/Qt6jgZOvXSNPTZ97eilz/4vTHc23nPV2CRWLZWnw8EGY938wxRM/2jWxRG6xlbLSMroZnJCYzJgZV1G2LAtHIBMGEqRYgcC2wiLJRr6HZyKghsfaesBg5pfOu2nh/Z8JOrUWi46DsLc3TWJ1nYM2oWj9wzYghd2WBpZrEGGYasIyqWBBmxtn2hbU4V5cEiMmyMAAhImgEIg86ylaznF0nsTvmWEHo4JUe+KAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/ZgkwfVLDu7a4hky4AhOulurcNhuDg7XkBBKqtKxb0=;
 b=xeHkp4Tp7ohMNMTcXQbR8kp6NALXTgMLCAHL2tnLY21lFvxxF68PZ2/lkcUVPXGRjTKdzINIMF70WGEb9Cjxbqzo3uuJSNsPtMBxp2fUDGHGbxUvh+PRmJEJ/JVkQeEKyc6MbEUw4FT3dEmWtQfrq94gE25ocM5ys0FUIYwR3Jm94rhd4FmzI3pTDwhe1CcTsDuMBuffdH7UV9qdGv3b6fjHuC/yX4KI726oHJDRUHJd0HFQlCslQ2IxHLAvij688mcFbvswNUlPDPVURV5EyXMEL78ALo2EqjuQx04cb2W4uwBEC7U0MvqCiFRAzI6FgQVWBe2ZVxmmEzwVoPptMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ZgkwfVLDu7a4hky4AhOulurcNhuDg7XkBBKqtKxb0=;
 b=c08pjCEbAxQEwH1vxp92qnMFpoP9mxLpqGlDyyR5CDivdG8Dxu16GxsJDbFbz8SbOkBhxBZMyrbUqbSa7DCekyOP5bQTl6vjSkIdxtxIoQ693W1A3M6iHoZFRyaZI1ZaVbjj9DUKfPwOMzN/ZDle+leB5vIdrQhFaM5Z2iKXztJ5ahB0UPbBDLxR2VZ40St0DimbbwCb2WNJ0TphNyB+9W5EWoHnVaZmEnXipf1yebazKLyDxzhmFIeD58l1z24qn0rrby4aE6T79Vfs3OwNas5deaxSYh7rrnU8prHbxSZEea8ag+pWxN8EVeCaQ5CqFgTay/DerxYNCORwLrD0CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Fri, 9 Jan 2026 17:58:17 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::83f5:1b0e:a61d:6707%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 17:58:17 +0000
Message-ID: <2e103c5b-8cb3-40ec-aa0e-793f85a1f80d@nvidia.com>
Date: Fri, 9 Jan 2026 09:57:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote-curl: Use auth for probe_rpc() requests too
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20251112223722.376330-1-aplattner@nvidia.com>
 <aWEV2qs8MHqt_JXC@pks.im>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <aWEV2qs8MHqt_JXC@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cd810b-ead6-4871-fefd-08de4fa8aac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|13003099007|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjQrNWxSU3UzOVZna1A0emNOa2J2RDBqTFRHYkg2S3pXeERBMWphMmQ0dm81?=
 =?utf-8?B?amtWTU0vN1dZc3E2T09NOG93T2t6NkUyd1dDci9jY2hJVi9xbU5zODFnODZC?=
 =?utf-8?B?SjlkZTh0THpjMXhhLzZPaW5DWlZOb01rOFg5M0tpVmg0d0RpYWY5MVV1S0hJ?=
 =?utf-8?B?NFB4Y3F0Z3M3VE5XVnIwOTdodUQrMFp5N0tpRXlsekZYd0F4a29tU2ZkSG00?=
 =?utf-8?B?YjhOWjllMmZGQzM5LzlsNXVWdXlJVWtkdFdiSExxZ3M4Y25TaHhoMzBvQXlx?=
 =?utf-8?B?dHJZV2xtMy9qNWMrdFpJbytXLzJEQ3pPR2NBSG4yMHN6dGhwNjF2S2tyTUJj?=
 =?utf-8?B?Vm9sK200MDkrb2FHRkFCdnd4TEZPeC90WVN2MGwyaXl5TWhqZ2ZlQ2Z3NVJm?=
 =?utf-8?B?bkRHbWxBbzJKTXZTVks2eUNkYktHdDdGU3JneEUzR3BBd2NCaFRRdEp4Wkpu?=
 =?utf-8?B?RFBHSTdYRERwMFV1elVjOVFjN2ZmaEplVTNrN2ZlTlFCZlZQRFBBaEJlYXRY?=
 =?utf-8?B?OVZSZ1ByVi9nblBLa09Wd3hnd3R2S2hScnRrNDJoNXZVWm16VUt0cnBMU2c1?=
 =?utf-8?B?QkpzVVJYaVRCNUE2MFQ4Nlk2MCtDMjUyUWpMOHVSR1Zxa254dm9vZGdnR1lD?=
 =?utf-8?B?bklSQkVQWEl1K2FVYkNDU3JwK0xUT09BdWZKekJ6d2lLQi92YlA3WGVFSlds?=
 =?utf-8?B?ZmJJQjFmeUliRGFjdTZJajNjZWwrK1VhNWFOT0hvZUNrNDRvNXIxRDJ2dUtL?=
 =?utf-8?B?Y25JczVYZzZLYm0xb0NqWm1NZkhaZGtUM3NoYzluajJ3VG1zeFZrSXJLeGQ1?=
 =?utf-8?B?VWlvaUlQK1lQY1loZGJ0ZlNpbHN3bGk0cVUxQTcrQ29FbnhPVkl5YTJBTTdv?=
 =?utf-8?B?ZytybUQzN0EwLzNZcyszOTVxK3BzZG1VT3BMMUVaaXRxOWF3dUVrZ3FPb1lR?=
 =?utf-8?B?NU9aS0VyQTVwcDB6ZGlZVnZxeFZMZGZSQmgwZmV2ZHZURGw3b0duL09ZdWpn?=
 =?utf-8?B?YnBGbG1ENG94TU95djJJZ1RyZHJEM25UUHBrOFZySWRpVUsxZmZqMmlRTS84?=
 =?utf-8?B?bFM4OHBNSGhuRzNxcjJ5OFFRWWpEdlczcXBzcUJYbk1IUU1ISGUzMGpyVHd4?=
 =?utf-8?B?MzNHV2IyeGN2LzVPTUE2dFgrSkVqdllyeTgrVE5tVGRNdkYyQlFrZ0ZsWXpN?=
 =?utf-8?B?U0l1VUhEcDg5dnF4d0s2RllnSm1tQmNwT09qQVBIQ2MwcERCWXMwdkZTd2Q3?=
 =?utf-8?B?SENNb2t1TE1MRGplMlVWNFVYaVNrcFNWMVoyeWVrU3NaV1ZsOHROLzdualc4?=
 =?utf-8?B?amlYOEFGTkc4T0xicGlYZXhXWGd4Mzg5M2d0MkZ3SHQrRzFsbjZQdXBZUmY0?=
 =?utf-8?B?VDI2eCtBYktDbDJNK2dISXJnaWI0TE80bjB2OUd0czVpRGFLL0lLeG96SW1E?=
 =?utf-8?B?K2FGbU15VW15bDlVZEpzTDJYaUtKWnJKd000U3BHL1NwRnp2SW9ydjF0WUhM?=
 =?utf-8?B?ZzRhV3NYOHJvaGNEV0Vwd2hZdXV0YVVTUnA1NVRsTTJHYXA0VUo1bmZpS1o4?=
 =?utf-8?B?UG5ka0tqSjJ0VUErYlUrSVcxblZzWitYbWQ5SnlKZGcxUmljVm16R0t5SFVj?=
 =?utf-8?B?RHpDK0pna3QzWnhLNW5rWW16QlhNMUdrNEhSaWtRYTBHVXRQVERtK0UzR3pa?=
 =?utf-8?B?UkFrMWRrcDdqazZQRXgremhCV2I5bDJJUEtnbkVVV3NRN3hwM1VnZFNlM013?=
 =?utf-8?B?RHp6Q2QybjZMbzFuS1pveTFvcFhVbjZxaW1XSlpySGFCNUVRRStqczZLdkdD?=
 =?utf-8?B?cXFPV1gvNHhvZm9pNXZwM0dXRXk4QkVxSVVqLzNWeTE2bmJaWGVQbndYY0NG?=
 =?utf-8?B?S2ZFWWYvMmdXbzd6bkRWTm9xWXpHemRxNDZoM1grbEpzT2VULzkzMnJLRXYr?=
 =?utf-8?Q?uHK9N1E8nEocI7pCjW57YX7a63hnZpzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(13003099007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlA3b21EVkJqWTY2bERlVDI0d0xIbklxU2V2VVJDK2liVnBHOGRnNTJnQlA1?=
 =?utf-8?B?N0ZOZk5UcVpxdmxnQ3E3dzNDYXV2d21GS2JFTmE5ejF4bjNuNWNDUnl6Qy9U?=
 =?utf-8?B?RzNnL2p0QTMxMldDbVIyVGI0UDBQbWEzQXNkcVFDWTZiTHhGNXJEVFhXQ0lR?=
 =?utf-8?B?RVJsRXNoWUtXa0UreFBRbEpFRGZLcFRmQzVPaXZzRHU1TEx5eWVUbnF6dDIv?=
 =?utf-8?B?SVpHYmd6T0s0cmhNMHZvZTduNzljMnZlR01paXpMbWdrQitEcXVGdUdhU2pW?=
 =?utf-8?B?QmlBZDR4Nkx4dlFmRW1IY0F4R0JLTzZKVlJzOFYyTm5CMGZzeGtCdlptM3hP?=
 =?utf-8?B?K3N2VWdrRjJScHBEV3gxVitrdTBNcXBINXdRcTlrSktWZGkxZ0tOdEVVRFlQ?=
 =?utf-8?B?bjYrVkphY1c2MmtBYVFKUnNKc0MwR3J4aU1wQlkybk9QL3lsMytlT0kzK2tU?=
 =?utf-8?B?WmwzdS9BOUl0a3VXQXB0MHhsa0M1aUVLdEl3OFZiSitOQ3BwWDljd25wYlpG?=
 =?utf-8?B?Y29meG5WcXBZU2dXM1NoWkYwSGJONjlIWVpTSG13QzFndDZBSXp1SGd5L1ll?=
 =?utf-8?B?Q3BSUU5PTExML1ZhWEJnVERPcGJZUXZlc2czZllDMHJNYTVnYlhINVZ0M2Qv?=
 =?utf-8?B?T0hrcG9SZE0xT0RtRmF0RGdhYTRQb3VGNlQrNFJhRmZBWXFSbmcveHZsSFlZ?=
 =?utf-8?B?YlNCRnVTNWNUSk5PVW8vV0RlYmE5Um5oaWZ3d3EvUndmMXBLcEVJVTRKNVlN?=
 =?utf-8?B?UnZCTVU1ZVJMYUc4WXNyMURPY0hUVmoycWY1ck5IK0F4QlRaN0V1aDhnVCt6?=
 =?utf-8?B?L3h5R3IxTUNFTTV3VEEzakpjK21RTWxCaG1IWUwyWXEvR3VBbnk2bStPV1VY?=
 =?utf-8?B?Q1lDT1ZGQ3owWkpSUTZXcGpUZE5hUW55a29qSmFVUGlydmhCelg2QVIxSUlP?=
 =?utf-8?B?SW1UNlpTdWVpTGt3NzZlbDVENkJkeVdrQ3k5Um1yUUFOTS9BQi8wVGZXZExU?=
 =?utf-8?B?Ty9LRUFWeEFHMWplRi9uYWl4NjVoeEV4a3FMbFlLL28vNCswMG1lZVUrZVcx?=
 =?utf-8?B?dmY2Q25oa3ZqODlTak9xcXBPRmV1NnpwUmdiNnlxMzYxM1lxYmFhbTVzbllv?=
 =?utf-8?B?TWNFbGozb0RYeUMrTHc5Sks4MnBSVmF4ZVlLYi9PNHBjVmRDMEwyaGFTd0N5?=
 =?utf-8?B?UzFDWVRmcFdTWDlueHdraGJ0bkFWWmgrcStCa0VJa2dheitBUGRWODJqVUNv?=
 =?utf-8?B?dzJwRHlrR0Znc3lqdDkyK2pFcWFpWExUYnFlSmdFZytXQlgwSkpXYXhBcm83?=
 =?utf-8?B?Vk81QjNmTHUxb2FyTUhvdWYzMSt2cTQxYi9VZWE3OTJaYm1QbmlvVjkyUWJN?=
 =?utf-8?B?UTBCaG9RSmF3Qi9pdytPQzhuMFhOSTJGaXlwMjFtNlhUa0NlSzRVYXdSQVll?=
 =?utf-8?B?VGp4TktxVytCN3JNUHFLS1pRRUJ5SHBZaWhJbkxIa0plc0piN1daTkljbVpB?=
 =?utf-8?B?Um5DM0o2UlZuU1VrZ01veXJNSEl0RHRWeUs0TU8rKzdraE5jTDFLTStWZDZO?=
 =?utf-8?B?RGRDOFhIRkVONUVvL0xDT1FTZ1dlbFZ5dWNQdGtnRWJraUN2NGZLSUIxZ3VC?=
 =?utf-8?B?b0U3WFB4MnZpREhBS0RoaXJtRDN3ZUZWUXZXSVZ6OFdXdWRwRGpKWXFPa1Zs?=
 =?utf-8?B?Q1N0Wkg0M3J4SVRhUVMva1pLNDU1KzZuK2Y1blVQTDlKM2NTcm12N0pibFpl?=
 =?utf-8?B?VTh5M05jZk5Fc2VxVUJwKzJ1eGcvNHNPZzVwN3B3MGpSMjNBeTZHemZVK0RE?=
 =?utf-8?B?N3l0cC9RS2ZTb3dHdGtHdURYaWF3ckg3ekV0Q3VzajhyNTZva2pQYmhnWDlj?=
 =?utf-8?B?YVFkbmdmakc1ditIUis5akw3dXB5VDVaTDhOUXFMTnh1SEJDR2NBaEk0ZDRv?=
 =?utf-8?B?U0s1R2RQYXkrRHBUT0Qxa3UvUGEvcWhkMkRtWXgrTjQwdnVNdGtyMEZtaGd1?=
 =?utf-8?B?YnBiNVh1dVREQVE1NmNHNGkrc2JTczFGd0dscDEwZUJCc2J0SGJRQUxyd3lr?=
 =?utf-8?B?SGJkUTFGWS91ak5meHpPb3UyUzFTQStjbWlpZHpvSEZyTTB2cEx4VjA5M1lo?=
 =?utf-8?B?WThDWDIxODk4UHRmb1FydlFFOGtOaWhtNndQZ1M5OU01UUNaSlQ2d3FMSTRX?=
 =?utf-8?B?ay9MczNuVFJiYk54RnBxTFVjd0M3Z3hUd0txVmxxaENod3lWQUc3UGl0WGN5?=
 =?utf-8?B?WThxeDZWZVZoSzNXYVF1dlA0ZzlVQzJraUdFd2YvbEZrUENGWEJKcXl5ZWMr?=
 =?utf-8?B?YnJiMDVueC8xRy9vUHJkWERMVWthQlZoQmsvbnhJS0VXZDIwa1VsUkFCMVlU?=
 =?utf-8?Q?zXWpiZ7y9ySAJJZs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cd810b-ead6-4871-fefd-08de4fa8aac6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 17:58:17.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7e9Cf+SOXgwPgfy2ZVf+m5JDpgfUYTEcnzUBPrh/qdPVtYxZJoAUFDN2HdQl/49U3VtDe16ymWmzJLE1qABeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

On 1/9/26 6:51 AM, Patrick Steinhardt wrote:
> Hi,
> 
> sorry for taking so long to review your patch, but I didn't really dare
> to review it as I'm not that familiar with the subsystem in question.
> But given that nobody else reviewed it, either, let me try my best to at
> least provide _some_ helpful feedback to hopefully move this forward.

Thanks Patrick!

> On Wed, Nov 12, 2025 at 02:37:18PM -0800, Aaron Plattner wrote:
>> If a large request requires post_rpc() to call probe_rpc(), the latter
>> does not use the authorization credentials used for other requests. If
>> this fails with an HTTP 401 error and http_auth.multistage isn't set,
>> then the whole request just fails.
>>
>> For example, using git-credential-msal [1], the following attempt to clone a
>> large repository fails partway through because the initial request to download
>> the commit history and promisor packs succeeds, but the
>> subsequent request to download the blobs needed to construct the working
>> tree fails with a 401 error and the checkout fails.
> 
> Okay.
> 
>> (lines removed for brevity)
>>
>>    git clone --filter=blob:none https://secure-server.example/repo
>>    11:03:26.855369 git.c:502               trace: built-in: git clone --filter=blob:none https://secure-server.example/repo
>>    Cloning into 'sw'...
>>    warning: templates not found in /home/aaron/share/git-core/templates
>>    11:03:26.857169 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>>    11:03:27.012104 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>>    11:03:27.049243 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>>    11:03:27.049270 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>>    11:03:27.053786 run-command.c:673       trace: run_command: 'git credential-msal get'
>>    11:03:27.952830 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>>    11:03:27.952849 http.c:849              => Send header: Authorization: Bearer <redacted>
>>    11:03:27.995419 http.c:849              <= Recv header: HTTP/1.1 200 OK
>>    11:03:28.230039 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>>    11:03:28.230208 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>>    11:03:28.230216 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>>    11:03:28.230221 http.c:849              => Send header: Authorization: Bearer <redacted>
>>    11:03:28.269085 http.c:849              <= Recv header: HTTP/1.1 200 OK
>>    11:03:28.684163 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>>    11:03:28.684379 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>>    11:03:28.684391 http.c:849              => Send header: Accept: application/x-git-upload-pack-result
>>    11:03:28.684393 http.c:849              => Send header: Authorization: Bearer <redacted>
>>    11:03:28.869546 run-command.c:673       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 43856 on dgx-spark' --promisor
>>    11:06:39.861237 run-command.c:673       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
>>    11:06:39.865981 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>>    11:06:39.868039 run-command.c:673       trace: run_command: git-remote-https origin https://secure-server.example/repo
>>    11:07:30.412575 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>>    11:07:30.456285 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>>    11:07:30.456318 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>>    11:07:30.456439 run-command.c:673       trace: run_command: 'git credential-cache get'
>>    11:07:30.461266 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>>    11:07:30.461282 http.c:849              => Send header: Authorization: Bearer <redacted>
>>    11:07:30.501628 http.c:849              <= Recv header: HTTP/1.1 200 OK
>>    11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>>    11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>>    11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
> 
> Okay, here we see the 401 error code.
> 
>>    11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
>>    11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>>    11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
>>    11:07:34.761530 http.c:890              == Info: closing connection #0
>>    11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
>>    11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
>>    11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
>>    11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
>>    11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
>>    11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
>>    11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
>>    11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase
> 
> And as we think that we've already set up authentication, this error
> code will cause us to think that the credentials that we've got are
> invalid. Consequently, we invalidate the credentials that we've stored.
> Naturally, this will cause _all_ subsequent requests to fail as we're no
> longer authenticated at all.
> 
>>    error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
>>    fatal: unable to write request to remote: Broken pipe
>>    fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
>>    warning: Clone succeeded, but checkout failed.
>>    You can inspect what was checked out with 'git status'
>>    and retry with 'git restore --source=HEAD :/'
>>
>> Fix the immediate problem by including the authorization headers in the
>> probe_rpc() request as well.
>>
>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
>> Link: [1] https://github.com/Binary-Eater/git-credential-msal
>> ---
>> If http_auth.multistage were set in this scenario, then probe_rpc() would have
>> returned HTTP_REAUTH and this would have probably worked by generating a new
>> Bearer token. And we might need to use HTTP_REAUTH to handle the case where the
>> token expires between the initial request and this one, but I don't think
>> tackling that in this patch makes sense since the original Bearer token was
>> still valid and git just didn't try using it. And setting multistage (the
>> 'continue' parameter in git-credential(1)) doesn't make sense for Bearer tokens
>> since the token comes from an external agent.
> 
> This is something I was wondering about. Specifically, I saw the loop
> that we had around `HTTP_REAUTH`:
> 
> 		do {
> 			err = probe_rpc(rpc, &results);
> 			if (err == HTTP_REAUTH)
> 				credential_fill(the_repository, &http_auth, 0);
> 		} while (err == HTTP_REAUTH);
> 
> I then double-checked that we indeed get `HTTP_REAUTH` as an error code
> on a 401, so I was wondering why this doesn't lead to an infinite loop.
> I didn't connect it with the "multistage" thing though.

Right. I think we don't actually get HTTP_REAUTH because of this logic 
in handle_curl_result:

	else if (results->http_code == 401) {
		if ((http_auth.username && http_auth.password) ||\
		    (http_auth.authtype && http_auth.credential)) {
			if (http_auth.multistage) {
				credential_clear_secrets(&http_auth);
				return HTTP_REAUTH;
			}
			credential_reject(the_repository, &http_auth);
			if (always_auth_proactively())
				http_proactive_auth = PROACTIVE_AUTH_NONE;
			return HTTP_NOAUTH;
		} else {
			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
			if (results->auth_avail) {
				http_auth_methods &= results->auth_avail;
				http_auth_methods_restricted = 1;
			}
			return HTTP_REAUTH;
		}
	}

In this case, http_auth.authtype and http_auth.credential are set and 
http_auth.multistage is false. So it proceeds to call 
credential_reject() and return with HTTP_NOAUTH which causes the calling 
functions to fail immediately.

> In any case, I think this information would be useful to have in the
> commit message to help guide readers.
> 
>>   remote-curl.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/remote-curl.c b/remote-curl.c
>> index 69f919454a..1d0ae72521 100644
>> --- a/remote-curl.c
>> +++ b/remote-curl.c
>> @@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>>   	headers = curl_slist_append(headers, rpc->hdr_content_type);
>>   	headers = curl_slist_append(headers, rpc->hdr_accept);
>>   
>> +	headers = http_append_auth_header(&http_auth, headers);
>> +
>>   	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>>   	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>>   	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
> 
> The change looks simple enough, and matches what we do in `post_rpc()`
> itself.
> 
> It would be great to have a test case for this. It might be possible to
> use t5563-simple-http-auth as an example, where we already know to set
> up an HTTP server with authentication.

I'll look into that. It wasn't obvious to me how to make it hit this RPC 
case specifically but I'll see if I can figure out a way.

-- Aaron

> 
> Thanks!
> 
> Patrick

