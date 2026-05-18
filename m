Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013079.outbound.protection.outlook.com [52.103.35.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E29364935
	for <git@vger.kernel.org>; Mon, 18 May 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125084; cv=fail; b=RI66rMzxyxWqa7s0VwI5VjExlFwfFBODfxF46KVkwt6Q1k7fpYIixNKsbu+tgIJdX5Q7mW8seu6efWr6Tzk3FdZgYc9/L379NA0dHbFStLj3D+DQS4f6/D20JMkBhvgjha8KJYXjj5ZgKdUKGd4b1SM7iLCYsXyXg9TaUqv0b98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125084; c=relaxed/simple;
	bh=+Wav25b+JNvwGcQrQ/DBKZOtgD3g4v1JVB6Z8sJp68c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UZeKMNTL5c678dAadPF605V1MApMu5hjnyaxSEkPHA/Jhpn6p4KjHi6jfFRJ4XswEf/wHow3TFfNTIIgE+aMciFSau2xAHXd3n+S7iLeKmjZ3+LArDQ4Sz1geX/Z3xj5KotD8Dhu1/7gRwlwcyD3jTbDuiLjA9zWd1C1etYwr9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lCXnUT3n; arc=fail smtp.client-ip=52.103.35.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lCXnUT3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJgAr5fsazl31s1bGypk7Xsg36QBZsIFxFnE6uzzTwXkMsn5fvnD1Ipn+MTR1I9NxMIoTPwItdUoy8HuHqO/vT/LMkxGWCx7oaFX6WZdmAMnAb5s2g/IH90+vh0FYpS6+Hm/IKJJcMW8Zi8lkC9HEJPnTSiv+PVN6hY+mF4hdXdWpcOqx0UlHgHW9sneFPTMLBJJkYkuFJQMccdfmxZRaOCErP/sHub6DfG9PuEj6tZhYYHSiSS8bbfnjBHlXEM+apKkbte9QjFeCqn8SkevCe1Oz4P0a8L2I8Nc/Tm9V8PBdrm9Hy0ydtTKWuMlOgG0DRAvK+Shv2BbnXWOHjhkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/13AfG4K4OCXtMx4xX3eu3FyFMGS6pnzdpLvbxlgrw=;
 b=iqVzmxhwsYld+cHg7nV0/0zBKioqrw4A81dPBK3ELte8/khH22j+faBmyRnRSqNQiO1vhIpkU3f4KdVJz7vMC5SyKXBkuk5BZC9sdrKhWr5ujbvnAhe2G0OhVRfCnoqkgVQGnuRHdIjDQGyOtCqeZX3Uzcujq/ClqWEU+egx4NuZpr71+72p+XlPftfObXej41t9HNK4An39OYViXR0Ai1UtFtvh0AnJNd6IRD+kuMDufBZ3a34pAx/guQHVu/aFraMhGs2Crv7oNF/D6XEyVekzPwcYb1+4RchQkcyS3Y40Rza1R81vg+v7AsC81LKv5LlLYqUzb482VH3Sv2omDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/13AfG4K4OCXtMx4xX3eu3FyFMGS6pnzdpLvbxlgrw=;
 b=lCXnUT3nuFecbRdKIZd8GzxGHEpv+H1LPJSYm+SsQADR0qqGVgvsloYBjgdGWkFG2P5SYVNywBglV8fsf/OSkfXMd4LYbHdQHlKdnO+dLgBxlnpikpQ1q5hmac/9CVHs5/aBAwOTk3cUyPjdLyOoZ17rShdk+3aUM0lRywal29p3kGIG/NJVRjVWGLiitRJ2/TR1IzUUksQ7Pal0AntQes+ZejldMzlicLnHERt3p/hKZLiCblPkn4YH2ruM60N35iZgaaC0ZjRTfho09Q0+Icpt+PnTtF8SR0imcaMzARhnv/xJwwoLl5rj3f9GYBPplbju4DwV10JnsmpHfp7qLw==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AS8PR03MB7923.eurprd03.prod.outlook.com
 (2603:10a6:20b:426::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 17:24:40 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 17:24:40 +0000
Message-ID:
 <VI0PR03MB116343A44C3D5E2562FBBEEEBC0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 18:24:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] fetch: rework negotiation tip options
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0007.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::11) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <f21c6be4-51f3-4ecb-9acf-9778d9fbaa08@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AS8PR03MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: ea41ff7b-c520-413a-abd5-08deb50257db
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|24021099003|5072599009|15080799012|8060799015|37011999003|19110799012|23021999003|6090799003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEFwZWVhakpUc0FvWjdodjd4Q1VpeTQ0SHVPOHJtWkp1Y1ZMcCs2REJVek1m?=
 =?utf-8?B?bmtiRWlTQkYyWWZJVkNFVFB1UnZpNEtsTkNuc21ZdUpXVzVTNHI5VnU5ZS9Q?=
 =?utf-8?B?ajE0SnY0WU90d2FJWXR4eFQ1RWpxQ2NOWU0rUXRsR2g5THpNZjNCM1VvTzlN?=
 =?utf-8?B?bzA0em5RODYxaDhXVlNXbWZza2c3bkRPM1VFS1ZpUHZnUTNCME8yU29KLzdt?=
 =?utf-8?B?UHlIeHVpMVkxM25yeTRYSnNVbkplY1orZXBFY1UrelVzRnVLaG1xU0JoZkt3?=
 =?utf-8?B?QmJ5dEVhWU85VTJiYTFsZkNtUDhFbUE2bXhmeTh6cWxmRG5Zd2lSbHhVK1pO?=
 =?utf-8?B?Slgxa1orNEUzNStUb25FQkxRVTVBQ2lZVWZoWEd3ckYvaHFnR01KUWJPOUFG?=
 =?utf-8?B?ZXZIelFxNzRHK2hBMjdXZm9pbGdnU2phenp2b2QzbExQWTJBY1RaRHh2ZFoz?=
 =?utf-8?B?ckt0UGRRWmg3dFhuTnBHRkVaenpYYjV3MzBua3crSWQwTFdyYlZmVzVDSDNt?=
 =?utf-8?B?NUxqalVvamV1UXNCWXRxSDBmKytTMDV5aXNZZldHWE1GNkNkQzhsR1BJVjNH?=
 =?utf-8?B?OTBwVVA0bEszWUFCcXhscExKYmlRUGp0RFh6SmxhUlQvUml1YlNVQmFqd1Av?=
 =?utf-8?B?N0J2ZXVVZDVrZFVQT1BvaExuSGJZMk1DUlRtOU1WaFgvbzM5c1dZaHE3VVUx?=
 =?utf-8?B?MXFUOVlaeU9zY05yN1lZMEE3eEFlZGJXUVlsZThodkZVSVBuRmZDcSt3aHZ5?=
 =?utf-8?B?RHhGdTgrRW9DTW5pUE40dFFvb2hIcFV6aUEwZ3Uxallhcmx2eklkbW1SWG5E?=
 =?utf-8?B?VTFURHVuL0YzOW5zNW5ZNDZkV2pQeWhBTFZFRUlSWjVMa3FqTTdRa3JlWUpq?=
 =?utf-8?B?SWNUV2JiTlJIT0ZiaWJtK2NUNi9vVlZVY3NjeHVqanZQYmRMU3pTVWpEVGls?=
 =?utf-8?B?T1ZwSVpPa0FJUTF4L1ZqdEt2NmFPT29rVXFFYVlPb0lpalR0WCt3c0JRU3ox?=
 =?utf-8?B?R2tjd1pndVNSYUxlWnlOU0Z4MWtLclV5T2JHbzZjWUNRQ3lkKytId2R4RGd3?=
 =?utf-8?B?cGxFUnhBQkMxdE16cDBHWHFDcnlxQTJsQjNPa1FYbndzNWoxelhNaTdHVlFU?=
 =?utf-8?B?WlN6eVVCVmJ3YnB6MGhoRjVrYitwWHI5cUJmdVlobDdaL0h2YkswY2xBOVdz?=
 =?utf-8?B?eEpQaVY5OUU5RHR6RFpncEllWWRydTdVTmxzU0VEK1MzNkZZT3I5TXp0U1dE?=
 =?utf-8?B?bWM1ZXZ4MWxBQ255MU9xWjY5aFlkMjFZdlkvSGhrV0VtRkFNcHR6YmVQVW5z?=
 =?utf-8?Q?kA2y88nXufH9O4FIl/r1bNuU46bLq9c8JV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRYMVgvYTRtSEV1M3c0Q3ArY3kxRHJtSDhsb25DOTE3RnA0NEdIS0FJYVpk?=
 =?utf-8?B?SWozaVorVW04SXVyMEYzenRxZVNzS1dWSUVwLzhoSUhxK1JMaWd1QlFKVFpP?=
 =?utf-8?B?cG1rSUhHMWgvN1AvMjk0MXhUOXQ3VUVmcFE1VXpRS0NNMWRMdlJsZHFjUmt1?=
 =?utf-8?B?RkVWazhyK2hwR1JKREVvaHJLM0RIN0xHSTJ2WWRnZ0t5OWZNc1RlVHNwU01k?=
 =?utf-8?B?cHEyb3VPSU0zb2RLbEprRUNOMytKYko3ODY1T2Q0ZkRNbzh5NUFSdVpDNU5F?=
 =?utf-8?B?ekc4eUZNNWJaQ2xDUXVYSjhqNXQvMGhWanZXLy9UZ21uZm9ubHIvRUcydnRT?=
 =?utf-8?B?Ulp6bmVkRHdoWFZuSEt6Y3Z3czhrS2Z2akowMEp3elJCRFJsVWJiSktLd3V3?=
 =?utf-8?B?d1VEQ3U1UFcvZmx2OElvenVUc2dEQ1l4Z0RSRDBQS01NeG5OaDNHcFN6VnJq?=
 =?utf-8?B?c1kvRmhqVWlFM21DYmhHNUJPYVNTUGRua21RSE9WNTc1QkF3S0haYS9Eenhk?=
 =?utf-8?B?V0V6YnF2Yk8vNExwUTl2Y1RqU25YMjVaNXc1RGZVR2hXT05mUmwxVFhMZitv?=
 =?utf-8?B?ZmV4QVNJbzdvdFBiMU01M0xyaVFCeUg5UlBDdXUzMWg2NEFFaEp6MTcxd1Rp?=
 =?utf-8?B?YVhWUW5RQ3RiaUxkVWQycTdxYkd1Yjh4NnNFZmRxQyt2WXZ0WkxleGt3Zjdy?=
 =?utf-8?B?NDROeGorUm80SzFDTGd0TGlrUndwWjBjcHhwTTBOeklwOGFSdisvOGdXUWpn?=
 =?utf-8?B?SFBDRFpaNC9IYjVaUGp6c0FkZWpkYkxPMnVKc2pIWXByRGlYZENlWDk1M0tt?=
 =?utf-8?B?VXl1bUh6U2I4cjEzYmxDdkliUm5HVkpVWmdDMlAzOTJ5blBLYTdHM3ZGaENn?=
 =?utf-8?B?Z1pPMk9pQ29VVFkzSGN4U1hRVmlMTUc3NEZUek9hcDliekpwM3pRUzVhU0hF?=
 =?utf-8?B?RCtnMk8vOFVvZnYwQklIZHdmeG4vTk0raW8zaFFEcDB2K2xiZ1RZRHpxNyt6?=
 =?utf-8?B?bis3WmpTa1ZWNEdtR2xna21OUkxaY2RhbGtFY3YyMEs4aHl6RElEelpIWDV3?=
 =?utf-8?B?bGtYbDM1U01Sb1BWNDl5citTVUl5LzU3WmdGUzQ4VG81ZVNsT3l3eGJWVTNh?=
 =?utf-8?B?VVR2a3FST2dqVWNpTHBtRnJBWDNiMklmaEgzUGJKMFVnZHlVQTh3R2VxQ09m?=
 =?utf-8?B?Y1l1azNiMnpmdTlHakMyWWxpN1N3SzJJcWlmSXNheUFXYXNISlBqV3RNV2hH?=
 =?utf-8?B?UGpKZWNidHpGdnVLTUZOeXlkWk9MaHVxZG9jQjFhMG4wUXVkOUdHUG1ybTZK?=
 =?utf-8?B?ZXZoUWcvL3ZMSUZCeVRqYUR0YkFsYlY5Ymk5UC9VY01KK2diSk12T0lwU01J?=
 =?utf-8?B?cDJEb0prQ1g3VGgwUXppL05LT1ZyVGRONytnc0J3dWlFdmdQeDAyT1l0NGpt?=
 =?utf-8?B?SGRnZHpxZG1HQnhXdWRKWmNLUjkwWFVVWCtaZ2oxT04zUDdtNVZZbmRDVTB3?=
 =?utf-8?B?QmtHZC9DMU9sMlFsMTNPbU1wQ20vUzI0SE1IV3o3clVXb0xFTzZNZjZuZ0Zo?=
 =?utf-8?B?ZThXU21hem5RRGlNR0hMdXUyRWc4L3JmT21Uc3hMenVtNXo4Nmx5bkZLM0d5?=
 =?utf-8?B?Skx0SDJRTVZWbEFWMzliUFJReW5hMFhsRm4zT05yRlRHLzM4OHNiVHVmWTBj?=
 =?utf-8?B?aWhRSGJaWTZRMzRBVkpSY0o0elY2Ykd2MmRuUjF2YjZGbjE1SjVKZ3p4cWJl?=
 =?utf-8?B?ZUFTdmx0Zno5ZllHSXFTL3RZSk16dzFucmJGZzN0RlJYUyswWlI3N0VuZmtD?=
 =?utf-8?B?V3RPV1Z1dU5saTVyV2NJMU1uTWIvTkVlVDltdUVPRFVRQXFpeVdJb1pQOTRF?=
 =?utf-8?Q?4DNy/NWbUkUSq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea41ff7b-c520-413a-abd5-08deb50257db
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:24:40.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7923

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> Updates in v4
> =============
> 
> Thanks, Matthew, for the detailed review! There are some big changes in this
> version.
> 
>   * Expanded commit message to cite the commit that introduced the bug
>     (3f763ddf28).
>   * Renamed --negotiation-tip to --negotiation-restrict throughout docs/code
>     (including send-pack.c, transport-helper.c, builtin/pull.c). Added
>     OPT_ALIAS in git-pull.
>   * Switched config parsing to use parse_transport_option() helper. Removed
>     git push from docs (not implemented yet). Restructured --negotiate-only
>     validation flow.
>   * NEW Patch 5: Added have_sent() interface to negotiators, so included
>     haves can be de-duplicated properly by the negotiation algorithm.
>   * Replaced COMMON flag hack with negotiator->have_sent() calls. Moved
>     ref-pattern resolution into builtin/fetch.c (add_negotiation_tips()) so
>     fetch-pack receives pre-resolved oid_array instead of string_list. Added
>     test for --negotiation-tip ignoring missing refs. Added
>     duplicate-avoidance test for v0. Accepts commit hashes in addition to ref
>     names/globs.
>   * Use parse_transport_option() for config. Updated docs to mention commit
>     hashes. Removed git push from config docs. Fixed test to use correct
>     restrict/include combinations.
>   * In the last patch, add doc notes that remote config values also apply
>     during git push with push.negotiate, now that they are integrated by that
>     change.
> 

Thank you for going through the comments on v3 in detail. This is a nice
improvement overall.

The main thing flagged (the COMMON bit confusion) is resolved by adding
the new have_sent() API on the negotiator interface, which is much
clearer and cleaner. The hoisting of the ref resolution to the same
layer and reuse of add_negotiate_tips() is also done and appreciated!

I've left replies on each patch, with only a small number of easily
addressed comments.

Thanks,
Matthew
