Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2092.outbound.protection.outlook.com [40.107.236.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FB1BCA18
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658046; cv=fail; b=pSInACoz0RKc7BgvBJtHe0sOpa7l2lc8pY8oI5VIlV5zZrsneqxn1AnCtkQRnmYKGXu99olFUls9EiftPno68pmJjsuPwJ8A8oaYC2mwU413FC5BMrRyMOPsXY3WOgj7ZolhyNdeeqDzO5d0BZ7NBkkl44Dx4t5YPTxrqYB7Cvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658046; c=relaxed/simple;
	bh=OW5deBMdfgWv6SRgBmtQbnR6J0zqkydK4KlldgdigT8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mi10zWIIQf8Re/EK1uxh3qlJfEPgUReqkATjOBkLjgM5RarA7NXlwIzAWrYu25n6L7Wk5Vxk+4uDr/wb/OOQGlNa3fnp7u5EkPadLeeVAw2r72dzczV4amqUKIhBO3pFAeav9cXi9YoaF60oW8W878Ee7LtynsK5w63H3zr+HmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comqi.com; spf=pass smtp.mailfrom=comqi.com; dkim=pass (2048-bit key) header.d=comqi.com header.i=@comqi.com header.b=W/4SrLtm; arc=fail smtp.client-ip=40.107.236.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comqi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comqi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comqi.com header.i=@comqi.com header.b="W/4SrLtm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9r2JNDMrdzmZScoqUPmFgSHkYTV33mb9DAY4kghkdgjUKp1p2XrmB212sMz3+Fufm1qszrwb4PuD6QPan3zqKn3vohowqE1y0ec0EV3nqbRbE2uZMwtMbKKIjYh4ZEyHQeuniwqn32mJBL1TyPW8toMuNTXh+h+nik75wcfKPsYg1qJf1nYhsv/g+rDIeC5x3DsuFPONfLGkQuX+d1/s8zQR9JUFN3zUTATZ3Z60pgiUEK2KPdL3GHBcsGSwmF8p3ijXooMO3fmamaxRTsTY45nYJewl9lqRJZACJpw9jIv0TxrASaZ3qRG8E1XbEHa8r5CC0QJd2MOJH0ihzjbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7ftXVykNHHJpSN466B7uQoE/ixXfkzmE8R6DCL1xyE=;
 b=HZwv6N1yB8wDv5qzPTBTk+pSvcHIPud8GoGv+FfEWA8zPgjTu7E2XDvCWVChbiIcIBdMJZK8ZzsW3ieZo0tmS5A3NujxhBdh01UNnfATDCt9amMoUZLF6jYzCG5FzmYRM3tyEnzAyGBvpP4xg64FVzegSuMVYQMfFypq4nuCHpezGvBu1DhNytaxlRghrfyYqliFxepBcNjP23UAdCnDYqWzNsM0nnDYi4dkfZqTBpWWnWkUJAGt57qHIFGw31NfgurFmGEl6uVXVk7+4/nfYeA8TfpLSOgLLU626BQJ0Jv0/WVJ/6CYqkeXnp0l6JYX2HNxJMR1s6Y2uq1+Bw67KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=comqi.com; dmarc=pass action=none header.from=comqi.com;
 dkim=pass header.d=comqi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comqi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7ftXVykNHHJpSN466B7uQoE/ixXfkzmE8R6DCL1xyE=;
 b=W/4SrLtmtLtLk7ZDWcq/xADF1SqQLvmbGNDqJH6CCBDY1ZW2m6KZc+2+CQrzo/nu8Pfs/5sgCDi1gfnzI9qXl4WASvBe+jhh4te5mwiMJJoOcohSraXoO4j4588k7gOUd1oGZRVkZgRypHfKr9N4Pg/533VG325nGLFdy/xwGm3kY9+0x5J4PQqtKpoAraK5tZ+WndmQPGvi8Bv+waNBY7BPQJA9JNAf8GN+bBUA2AN2AiRNZNq04HryWYR8AChI3I0qbM3/qDfZ/RgNYtH749th8y11qwceBASxmsaa8DqVKONHN25M+QsiZTbxXVZkXVR3WuhDWXxbHHTRqMdGrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=comqi.com;
Received: from LV8PR15MB6439.namprd15.prod.outlook.com (2603:10b6:408:1eb::16)
 by CH0PR15MB5987.namprd15.prod.outlook.com (2603:10b6:610:194::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 17:54:00 +0000
Received: from LV8PR15MB6439.namprd15.prod.outlook.com
 ([fe80::dc2f:9e60:2bba:e49]) by LV8PR15MB6439.namprd15.prod.outlook.com
 ([fe80::dc2f:9e60:2bba:e49%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 17:54:00 +0000
Message-ID: <2edfbfad-bfae-4fe1-8f26-4310fc54b2a0@comqi.com>
Date: Wed, 14 Aug 2024 13:53:57 -0400
User-Agent: Mozilla Thunderbird
From: Alex Galvin <agalvin@comqi.com>
Subject: Re: [PATCH v2] git-svn: mention `svn:global-ignores` in help+docs
To: Junio C Hamano <gitster@pobox.com>,
 Alex Galvin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alex Galvin <alex.v.galvin@gmail.com>
References: <pull.1766.git.git.1723500383989.gitgitgadget@gmail.com>
 <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
 <xmqqzfpg2gup.fsf@gitster.g>
Content-Language: en-CA
In-Reply-To: <xmqqzfpg2gup.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0496.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::10) To LV8PR15MB6439.namprd15.prod.outlook.com
 (2603:10b6:408:1eb::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR15MB6439:EE_|CH0PR15MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: abed4909-d808-42fa-429a-08dcbc8a1395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckJod2NLN2NYa2lNS3J3bXNOcldEMTgyMW9pVnRPcDNnaDhGa1V3QTZXVTUr?=
 =?utf-8?B?VVVpcnBPUWFMS3IxdE01aUxwRjVkOXI2cGk0TkdScG8xM2xRU1Nud3U1eTc4?=
 =?utf-8?B?QzJrTUJOeXVJM04yb0V4ZFJFVGo2OW9rNTRlSmwyNUh0WVZhenFzc3BIMmdR?=
 =?utf-8?B?czVRdjhJUXdQR3kyWVg1Rkt0VGlnRGRvZHVBeXF4MUwvdUpqekN2RnhHQ1l0?=
 =?utf-8?B?Uk9iL3JsbEF0U2lIT2lxYTlwdys4VnFhZE85VGxIOUNZellBWmtYaDRUOUlt?=
 =?utf-8?B?SUN1b2JaRWdPMXBaS2pER3J6RzgzTXhDdS9CM05OYXpBTHBHT1U1ODFFK3ZY?=
 =?utf-8?B?cVFkTlAzVCtoME00V21ORlh6K0JpM0Iyczd3cUVFenNvcDNpKzZVbEJzTFBC?=
 =?utf-8?B?bjh0MHdIMldZWUZFOEJ2b21xbFQ1VzZPZmdnMWpNbUNTQmYwRkJncHlYckxs?=
 =?utf-8?B?Q0hhR0tEWkRmWDFVZnNmYmpTYUljd3MvWDc5MnYzaVIvOTc1VGY0VDFIKzJE?=
 =?utf-8?B?TDRuRWY0MkJyUFBac1Vldi83dGpDVFdxbVJYNThtVkJrblpvMXc4dEhZWllC?=
 =?utf-8?B?R2NVUUVXdVg3N29VWjM2Q1JEOXM1RVJidm5scHdvNUxRSVNYdFRiNkdyMHNm?=
 =?utf-8?B?WUZ3MWVxLy9JSmZHWUxyVEtvUnBCWVdUME9Xd1FUWjNNaTI3OHJYMVZEWDBY?=
 =?utf-8?B?NUdXSHhaV2orRUdQcjhDUVdXNy9jdk9Ld3JBallVRjBKREpyOW5LN0p6Yllh?=
 =?utf-8?B?WUNvRWpzZ2VxOEE2MWtaUGI1SXF2K2czUVJxNWEvcDBrSGFJd2xjdzBITHpD?=
 =?utf-8?B?ZmdpZWpRcTJvbkVqSGd2czNSYXo4SjRlOXU2SDFQNjlqSzZQOFl1Wjhxd1ZR?=
 =?utf-8?B?Q1N4aWZ0ZVRKWUZnNytNcjhBSkNJcjdmMjl6OGNhR3AvNkRiZUp4ZU1hVW9N?=
 =?utf-8?B?Z0FZTE9VWTBWc0lJU2pmTXVVc0tQaTNISUlVeTM0RTNWQUdaUFIvV1RqZ0lQ?=
 =?utf-8?B?YWRWRTlmejNMT1BnTXVRUS9yRkJLQ1IvaUZTUlRlVTQxTm9mb1hiMEQ1dzQz?=
 =?utf-8?B?SWhhUnk1RXpjTXQzNzJZWmZvS3NHOVFDZjlFMVhFQW1GZWdic2tlY0dEc08r?=
 =?utf-8?B?c1ZqNzNkZm9QQTNGN2w4clFHWkh5SjB3MW9UWHgxVkxkMHNMN2tvcGZHVlVl?=
 =?utf-8?B?ZXh6WWwyRUxuVVVESzN6MytycFZNR0R1SUhLcmg3WGlIeEdBSHRra1hNRzNj?=
 =?utf-8?B?WHpJcFdRWTE1SURUK0c0YU1iVVhoSzRybjRRNGcrQ3o1RjVPVVNLRnhHZ1Rl?=
 =?utf-8?B?R3BkN1czWjNUaGNCdU82eG1ZMEcrTlJ2Y1hsQmhYTmZwckV0TnpqRGFwTDAx?=
 =?utf-8?B?UWgvZFFKdmJ0Yng1ekRYdGJFMWxPaEdDSDhOOWFxR0NkMEJGVzV6bXhBWlVv?=
 =?utf-8?B?UVJxdjlqNkFuNzVQQ1daUDNQaWluVjVKR0hoVk9FUmRWRG1rOW9aV1l0WGow?=
 =?utf-8?B?M2dSY0JZL1dORlBpc2ROcEJQRmFPNmp5cHlmLzNseVZrS3VTa0pDUFc5SVBX?=
 =?utf-8?B?Zk1hK2lLU3BkMzFMeTcwU1BTbzFwSmxuU3lFdHpCamI0V3ZZT3J0WDQvcDlK?=
 =?utf-8?B?a040LytjZGE0UFlzSWJBZzg5YUY4Wi9NTExBUGJTOXNVZTlmNjY1Z3pVVVBT?=
 =?utf-8?B?aytwSE5odE4zN2NJb3ZhRFZkSmR0RXM0SFBKTzU4TlNuY2hMU2U2UDhWZUxU?=
 =?utf-8?B?c3V3LzBSdGljRU8yMUw1VFIzWGlmZ2VhMHBzZmNiQWFPU1R4Tk9naE1ud2Zr?=
 =?utf-8?B?V3RNYXN5NFhBdTJkVjhjdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR15MB6439.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU9IWVAwZ0NVWVJ3U0xqcFpTQWx3bk8xQXF5ZFBzZTdyZm14eDNMTTdhQUxT?=
 =?utf-8?B?bVoySHdnblNHdHlyU1dPVmsrempDSXJZYjl6VmdQMHViYTNteVFzVS9ZTWov?=
 =?utf-8?B?TlFkV01XOHhvaDdiS0hJa2ZQbVlXcUFnRnNud1NZZlZ1MEd5SmFKRVZsZGlB?=
 =?utf-8?B?SUM4STgyS0hPNGh0eDczbTZYci83Vm9UMlBFeklpYmt2S01ldXVqeTFZQWg0?=
 =?utf-8?B?d1RiM2tLL1cvaWZRc2VYZlJUTUI5TVNDcEpMQmVTWm1yOTNkVDM0engvNThn?=
 =?utf-8?B?RC9SRVlQczlrdlNzZmdEMlRGOEVubVNrYXdKNmxwYmVsa2FDdXl6UzhQMlR1?=
 =?utf-8?B?NnRzZlYxQ2x2TXdubGpIZEZJbklod05DRlVScmdUWEljUk9LQjVDMHJ4N0NL?=
 =?utf-8?B?a1AxblNnNDZWWmU5aFJyLzF4UG1jMG9UR2FiM3I5RkQrQXgzZno2VnhYM0sx?=
 =?utf-8?B?TVZLMzVGMXA0eTJxWGZvWUZEUWhZakRVY0J5aHd6Y0N0K1UyMEFMVTNJZWps?=
 =?utf-8?B?b3FMNGxCQjY5VTFlQlRRODJ4ck5aUW0vTWp5VGVZQ0l3MG0vRlFFUzFCbmt5?=
 =?utf-8?B?NXlNQXkrL3R3dVZNY3FHU3k1c0F4eUhuMXdkdE9iY0NkbTNEdS9HVUNLUFFI?=
 =?utf-8?B?R1pHNFJZSDZLVVRET2szMi9Cb1ZRNE5kK1ZRWTZqT2wyaDVLRXBjNnBvMEFC?=
 =?utf-8?B?VkxBbHpIVDRTZGpIVndBOStsYWdjYlNaVkZBOGo4UWNYZ2FXalFsZWJZWm9B?=
 =?utf-8?B?bGkxalc4d3JBN1JiMGZ3UnNTb0dxcDVObUl5STVIeGpTQ09KM2RYcXJjWFp3?=
 =?utf-8?B?a2o5b3VJNDJEZWNIbEszRnVZcUkwbm5TKzlZampkZ01McE9sZGk3dE1ZTW9D?=
 =?utf-8?B?ZVdmK2NmRGUzYllUK2VHSGRLQ0RGWTF0bEtLMVBNaEtLcG5ETktocHBYU0Jw?=
 =?utf-8?B?clN0eVNhQVNycVFlN00zejNxY2tTTjBxa2gwQlFaQ3V2R1A2WkkrTFZMSjEw?=
 =?utf-8?B?RUMrZmFOWjMzQTZpZE1DSVMwMXpCN3R2MVRrWUVBSjVhQm03YVZpU29zUFc2?=
 =?utf-8?B?Z3NKNm5UanphRjM2cGRITXFMaUhydGZWUVlZWVFWSWxBM1NhMHlCd0FVSHk3?=
 =?utf-8?B?a28rWGVhVnhTOXhRWmxZSHYvbWxuL252RlZDQmJGcURLVDkyTStpeWdBTS84?=
 =?utf-8?B?MHA3Y3B4WGhVRGUrRG90TWNyRHFKQktGSnRPR2hxMThoMmY2L0prd2h4Z29p?=
 =?utf-8?B?azk5aXdwUmNyZ1pZOEwzMlJ6RzVOYThNS2FIcnZzL2ZoUDFvbDJhNFNaemRN?=
 =?utf-8?B?WmZ1WkdiZW53WGlucXNwWDJCbVlsclptOHZ5UWx0ckJHZGRkbVlrZk5haWs2?=
 =?utf-8?B?N2piL1Z3SGovZnZFK1F5dmUyVWJuck4wdEFGR0FQVzdzSmNKMHZ4M0o4dGUw?=
 =?utf-8?B?QjM2c2htbklvdER5TXdCbC95M3dQOVc4VEFoQ3J1aDdnL1g3S0YvYjVkWkVB?=
 =?utf-8?B?Ymg4UDAxdWNSYWtnajVYeVQ0M3hzSEFreUJZMDdqdXB3cVU4Qml0ZmJxQVkw?=
 =?utf-8?B?b1JVUDk5ekNzOERMbytBeitoQ1c5UmdLY0hKKzAwbGFCRG94MW80dktMRGxU?=
 =?utf-8?B?RG9lVkNJUkxvZHBjMTN6aGIvcXN3ODRQQUN1NlF3ZWhleDFBbTJSSmtqOGwy?=
 =?utf-8?B?NDhyVElMR1FXTnJuTXJRcUg4Y04wR2djNWh5djZYQk96Mmg2QW53N29xL3hP?=
 =?utf-8?B?L3RleXdsRWpsZ0VRenZ1eGpaYjZUVmwzK3htSVUwN1JaUE4xYlZDTkQ2N3pZ?=
 =?utf-8?B?SWJMZ3RwTVkrRE9yUG5GRHRFbGlLbTBqeDd1NjJveC9uQVppZ2U3M2xsdzVp?=
 =?utf-8?B?LzR2SEFqMEJKQmFUMWJISlZFM2tITFZCY0h3Ymx3WjdnZFZrSFpkMUN6ZHhu?=
 =?utf-8?B?c0NGKzVtcHd5bjg0cTAwTGlENDVEYy9oOGZiRThETm5jRHZsa2pGWk05T1dn?=
 =?utf-8?B?TTN5Nlpud3pEdmVQSG5EMEhmaW9VS0RCY1RELzRUc2gzSHNRMUNZNzlEYVVz?=
 =?utf-8?B?YmtyQzh3THFtUTUzZGo5VE9PanBaaGxMNDRzK2l5c0c5QkFXMUhJZDkrSzM3?=
 =?utf-8?Q?DViqm7sQK0QtyEeWp1g3d4quv?=
X-OriginatorOrg: comqi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abed4909-d808-42fa-429a-08dcbc8a1395
X-MS-Exchange-CrossTenant-AuthSource: LV8PR15MB6439.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:54:00.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e9102f64-4b7b-419e-b154-4a6930148e08
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf3F5vCY9oktF26EhfBpAAtGvSN11x8nC1ZECtEUnaUd69DU3gBt0FKeb88OgycVQjuuHzNbkCvgiWRm0GRS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB5987

On 2024-08-13 6:33 p.m., Junio C Hamano wrote:
>> diff --git a/git-svn.perl b/git-svn.perl
>> index a2a46608c9b..d8dc485e50d 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -219,11 +219,11 @@ my %cmd = (
>>   	                "Set an SVN repository to a git tree-ish",
>>   			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
>>   	'create-ignore' => [ \&cmd_create_ignore,
>> -			     'Create a .gitignore persvn:ignore',
>> +			     "Create a .gitignore per directory with an SVN ignore property",
> Hmph.  Is it intentional that this "create" side uses a single
> property while ...
> ... the other "show" side talks about "ignore properties" (plural),
> implying that both svn:ignore and svn:global-ignores may get
> involved?

I was trying to be precise that the create command makes one .gitignore
file in each directory it visits, regardless if that directory only has
one of the attributes or both. Would using "any SVN ignore property"
instead of "a SVN ignore property" make this clear?

Thanks,
Alex

