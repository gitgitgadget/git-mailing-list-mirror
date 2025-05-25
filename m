Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD01C7013
	for <git@vger.kernel.org>; Sun, 25 May 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748172171; cv=fail; b=jQHFFshRpNIbRG4lcT3/Uzt1eRdG5ZJ9dr+IjmjAkLvEillydhYrH3qTpvMEUyBQ0yg6PraxiQBalwTgL31kkb8CIApXcE/XGmzjo29OBytqe9G1PbDsz40YwqbAbokVCvxu4M1ZNr7K2pLcaWzFw1FcMqvWZRVOeeHpWEsxluI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748172171; c=relaxed/simple;
	bh=HUyn6yxCdh2zBrCgoR+jdxcn4+Scq8idqiId1DfOIA4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHAFEbDCp056gqEanKCU7SURPQS2Pz+/G+kYSxBg4Xx7w4+YqtiNnLWHdBJUD1H9FtMlcKwTeYANS5WZ0pombOVC1B8gOcBXf7GZRDL0M9L+8jtIXSMnR/0VEjbQhzKOrGlXsUpN938oWvwdQa0XCsf6p3D9Th97br13myBGDFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=BDQMKXE8; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="BDQMKXE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4uZZMg4APEiXh/8Sm1gDAHGWJaBKgN0ea1D1l/5XbOJPc6/pgJ1D+IsqQVgkKAuqNYZvBQz/8/tyhVgVkrWZAxHIMvxB8qX138/lehVKhGX3Ge6veBHPYtipDGIGcnqsATubhygtrijhaXlmPE5I7kXitIL+nwpAb4AKMfIqg319A0FbRLGtrCZtrzLz5Q6yjipqaMTxLpEupIw+wVEDoaCnxV4AKrn9YVOjqhm/urth9Up/rxEPW3Sol3Kmhb+t38qNgZ+GWzqDCRQHjzUIPtZDOgz7b9cJSNjVbAWYzpm1/CZ8n3FYglUedU5L83stqwRu6sSe8fofY/la54vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXunL9DEaZJZkcc57FkVui2GTUsVkfDjxJ4aZiQWfZM=;
 b=qVvxZGdJIW03Cx3QHFx6ajK1RZGhglMtrOWXUqGinfsbnACuFe3Ltx6otG6ao8oRUIdKVHai/LQ5eDNnrrFTW6T+ThMsZmFpVpg09OmBA0ABGe2BSEavesfwEampqvodaKFRTAhs4aBkq52PGwC7fD++glaeSxjrddKpvChDrQkfjWtufF8HNiQLbADGmLt8Rmw3K1Vb52kL5hwwTKzpfkdM1BRGKBjmok3nhquNjrezgrQGeNG7hl7OOoPlAsJZSGi1m37MUTwOpjliPX0IdxN9JX4inEG40A4W9yL/ohLyTz2j+vLQudhzmPKONQF9I5cXiWE8Yzi9LIqTACE1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXunL9DEaZJZkcc57FkVui2GTUsVkfDjxJ4aZiQWfZM=;
 b=BDQMKXE8w9tkCpxbx/nMicKBNjiu4KgL94+BrYS1p0M3kuIut0ZibINZlLH5//jg4OqgcwXnVAKySZAGD9cFIH9PpNk53P6x90p/EUJieguPVcyaH1erwxJvRDrdbGWKLJeujWAh5XdhfzoCwf+M+NDqq7TeShAlrDYV2MyWW4vcVemBSHLk7ZSH4MYdrPVMfZzilygw26jSPMpX6k+zwKBjnTP/YLIxu1gmAuwpvtInXNlrxkYKjfG6d84HSk+OivlsF2JKnLwM6p0CXVHWBm9H45xoP9AF1jj1fwqtSdkgWvaFypR8OoI47PovIPrx7ds6IQt5UUonUCqkZ2C0+A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8986.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 11:22:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 11:22:43 +0000
Message-ID:
 <PN3PR01MB95974D6A19D6C53776BE4BAEB89AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 25 May 2025 16:52:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] send-mail: add support for Microsoft Graph API
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, sandals@crustytoothpaste.net,
 Julian Swagemakers <julian@swagemakers.org>, Jeff King <peff@peff.net>,
 Zi Yao <ziyao@disroot.org>, Rens Oliemans <hallo@rensoliemans.nl>,
 Drew DeVault <drew@ddevault.org>
References: <20250525110621.64308-1-gargaditya08@live.com>
Content-Language: en-US
In-Reply-To: <20250525110621.64308-1-gargaditya08@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <bc4f7eed-15e2-47ae-b48a-6073574df43d@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: fca53b36-e191-4695-9305-08dd9b7e7790
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|5072599009|15080799009|7092599006|8060799009|19110799006|440099028|3412199025|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWx2YzREd29FSnplOCs3V1ZqNm51c09FRGJZQWtteU9XRzVLMlhUbSs1ZzFz?=
 =?utf-8?B?R2lXanZLRmVYWUlGdmtPNXdBb3hTendzc0NIM1lMd1J3ZmkzK0NYWWtuZXlF?=
 =?utf-8?B?alJiY0p0WlM3bjlpa2YwK1gxMTBFeDEySjNpSFNHdW5raEJyTmZtOXk1aTZJ?=
 =?utf-8?B?bFpnVXpWZXNjYnQzcVFIMlJvaEFKVk5MNEJzWlREa2lxNnhFZjQ0ZFVySEhh?=
 =?utf-8?B?MVNlMVA5cTNTSVZyckNiem1WcHZHRllrREhzWmRtQ0EwbHNOTEFZTzB0bGVV?=
 =?utf-8?B?UVJGQjFFM01kWU50KzNFN1ByR2dXU0ZSVmZmSDNRZTZTZEtaVkdoUTdaV1Zl?=
 =?utf-8?B?MFh2ZGdKbU90eXJZT2hTNkdFa0tKbEF2VExNZ1lWSE5Xdll3cWNhOFhZWFRI?=
 =?utf-8?B?ZTVhVDZZRlRNaEUvTDRwMU13Yi81dzNOWHNQQ3dsSUpIdThsdXRJMGNzRFQw?=
 =?utf-8?B?cS9XdkFrY1lwSDc0ZXNhZUE3eEV6a3E5T1FvbE5VVlR3cUQ3NFd1YkRIWm5a?=
 =?utf-8?B?S2JqNFJlbFhyVzIrdEZld1hZdmdKZmh3a3ovZ1V1WFA4MW9kMTNNNHRpZ0hH?=
 =?utf-8?B?L2xPWDgyMml5cGFIb1NkZ3JCUWJCUFlwem9DaWtJdzZ6c05iTk44K2V2dFRj?=
 =?utf-8?B?ZFk0M3VMaVRadjZES3Q4K2hZWklFbFIwdm8vQlJBaEVpeHJ3SmJHYzhRZ0xK?=
 =?utf-8?B?dnRzek9pMlR2ZVc2QlJla0JrT2dnSW85b2xGZ3lEcE1JK2hNMnFEQkRoU3ZR?=
 =?utf-8?B?dFZ5amwwSkVGeVM4aDlaU2p4OFVyZEZiaE9UMWVCUm1PbGV3WGtqVTFvb1BG?=
 =?utf-8?B?U3RtQklFdUZuaUZvUERhblJPMU8ycXgzUFRmajZOYzZmZU1GNkxEb1ZPZVZX?=
 =?utf-8?B?dWczdjZoT1cwamV5SUViaXczaUVPWi9jNnJzb0tLMXBoVWlpWUNVWFJXWC81?=
 =?utf-8?B?SWtVbFJrd2ttNE8yZ2F2VU5IdEt3V3FrMXU0cXNRN0dPdHV4SEZ1VzkxMGkv?=
 =?utf-8?B?dzRlSUtzeTVjaTNYRnh4N1lvc241WkRPdTdzeklRQVpxazk3bHRFcFpxeUR1?=
 =?utf-8?B?aCtHR3BWZEVrY1JnUVh4NHp5djN5S25qa1RhRTVndktYa1Rvb2Y0aHY3dDZV?=
 =?utf-8?B?TVdNZ1B3ejFlbmFaVytraUFlRWwrMERqUnZpdEczVHR6cURnSWlWQ0tZWVo1?=
 =?utf-8?B?bGJKWWd1NkNoUjlZMW8yMmltQS8yY040d0pIQ0Q4ZXVHUEdRWVUxc3VzSTda?=
 =?utf-8?B?TTFRRzQ3K1o0Wi8rQ1ZqQjlqMkxTTE9La3ZKQy85bkgzWGV5Uy9vNGNjY3E1?=
 =?utf-8?B?RDhCbVEyYUloNWJ6K3RjbldxSkU5OG5tY2FIRGpKTFRrLzRidlhadzFlc3hk?=
 =?utf-8?B?eFd5TVlOWG1GUWFhZDA2SngwaUFGdmdMRkhEQW9KU0ZmcHU1cHlCKzJyK0o2?=
 =?utf-8?B?ZGNKTFNmN0hqMUFTcWpKMDE3UjlQbjM4OW9HY0hKdVo1NGUxUGJRN0d6VkIz?=
 =?utf-8?B?UXV4TmdSVUI0Nk5hN0MxbHc2ODdaZUFITlJWaGhXSXBCakdmOGtNY21xdEs3?=
 =?utf-8?B?emdITkJsQk5kOERLdFF2ZHd1RE5XOHh0YUUzNVVRN3U2cjNid3BoQ1pFWUFo?=
 =?utf-8?Q?SKhC/kRvZiPbF7DM3FBb7KaIiDCfq0XhfNC6m1QYi1AA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVV1cHA5cWIxRDhkZDJTNXNJWmlHR1pPWDJXWHNxNytTSDFMWnZCZHowRDdr?=
 =?utf-8?B?TjZWV3h2d094NFhFcENUSWpVY2tCcEE0amcxdDFtR0x4MjVjOWM0WFF4eFln?=
 =?utf-8?B?MnVZazNCZ04yOFdUUmVIRTlhQ0h5TWdjclgydENUY2VEc3R0WjdHVFM3aUJu?=
 =?utf-8?B?SjJkb1V1Y0Z0dFQ1Uk14VVNwSEpJRWpvamZmdkkxaDhxY3FlMHJIZUNGOVRJ?=
 =?utf-8?B?a0JHQ0lvQzdveEtRK3B6WGQ3OXY3Q2xEUGVnck9DaWtxZ3pGeDlJT2FvM1Q3?=
 =?utf-8?B?bDJLYW9rdXJJemRTaDE3cEtIN3hFYjN3Y2h4MFdZbDJVL1M3cDVaSjcrZUFU?=
 =?utf-8?B?S2dSSUdFd3NubVc2VlFNd255aXpKaUVpUFdlbTUvem1XbU0wOTFsNnQwUnJ2?=
 =?utf-8?B?U3J3NHBhSkxLS1FvS3BKUElDaUpjZDhDQU9zZVFtdUZNTjVQbU1mTlR4elpI?=
 =?utf-8?B?WnFXWUk5aTd3UDk1R0NYZ2xzVVdSSm42TGIxSko5d3J5aWFWVEtCQkNlWkVR?=
 =?utf-8?B?TWs2UjFCZ21ob0pkSXowNGxVZ2pxYzhMQ3ZubFFmeUxnKy80L0FhSEF4Z3Rj?=
 =?utf-8?B?a3BBeGUwWXJZSk5uR3d1d1JpdDFubEVJT25HLzZudXoyU3J4Rkh3S3NNdnFX?=
 =?utf-8?B?Y0hTZkd0ZDZzaFZCSHZSZ0FtREl2WExOaTdwaXJIVHZBSmN3YTBwVTBpN3hI?=
 =?utf-8?B?RFlrQXBodnFadWlHeUd4UG5nOTVDeTNUcUtJRE02OUlrTjd0MEVLemQ1ck9N?=
 =?utf-8?B?V0wzNk1EajFMQ0NDdHpZemlpQTA5TUFQMkJpUHpBU1BnT1ovRjVPTS94ZVk5?=
 =?utf-8?B?a0FRUjFjTVlhZDQ1YzVEaE1JQmNUZDZiaTlzYXhsMEhUbThZRHdxUWtENHRG?=
 =?utf-8?B?OFZmVnhZNDhpeFJ2MlJBWmV6b2QxOGh4c2dhZHU4SDIwOVRxNi92anF4TmtG?=
 =?utf-8?B?ak9oVVFYbVRsSkg5emJabHk0L2lSSEtvZWVMT0Z0SkpoL3UreklJcWZPYjlO?=
 =?utf-8?B?V3NHYTRrRU9tTFgxSTJ5a1hPOEVTRjRnOFRPcXFrMEVHTWlHdWxSS2FXNjJx?=
 =?utf-8?B?WEFiM0NkY1NNTFJvQy83OFRnN2U0RElhSnRnQi9Rb25UcVVqTGpJV3RMTk43?=
 =?utf-8?B?cDJYdTNrMlhHSldZaFU0MnJ2QVJhVFh3bDlRNjZYUmdqcFZhU2EyVTlraFd5?=
 =?utf-8?B?eC82ZllxS0cxRFNRV2VkTnpkZkhJeUZMeGxydEtCcktWVmtPb0I1bGVxU3lK?=
 =?utf-8?B?bElTZG1lWUcvTm40OUp3VEdTb1RqV2UrNFpWWGF3ck1rUGh5b3hyQ3dnRjEw?=
 =?utf-8?B?aW12MmVUTHYzK1FaRmlMRDYxb3dkeXdtOWdRN0p5K1FNT1pXNFZ6SHRKaks4?=
 =?utf-8?B?dXF6ZVFSTHZud01xZ2trS3cwTGtReXVsY2tKUnpaczRzVlM0SkxJQXNUOXlp?=
 =?utf-8?B?Sy9jYVVLS28yVUZrc1hYdlNubExGKzYxQWNVUHpTVktocVJhQkhFWHlFU2tk?=
 =?utf-8?B?NFBKOU5aVGwvb1diaEVqWUFzemhqeFN2Q1JZSVlLSlFjT0V3Y0NhemV0MXJp?=
 =?utf-8?B?VjJWODNRVlMvZm4xY1Q2a0Z5RVk5UmVYdDRqMGFYeis1ek81ZUVYblBwQnZv?=
 =?utf-8?B?Uk0xMmhzRUxoaUNrTWxWRUpBVzhzZDd0TDBVMDZ6MzVmd1Q0Ni9JLzZFT1pO?=
 =?utf-8?B?Q0ppSFpiV1lNSk9XZFNwNlVFRVNTMDJBN25IL2kwOVo4N3l2a0d0YzFVMzZN?=
 =?utf-8?Q?AIxmmnqet8atepU8fk=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fca53b36-e191-4695-9305-08dd9b7e7790
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:22:43.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8986



On 25/05/25 4:34 pm, Aditya Garg wrote:
> Apart from SMTP, Microsoft also provides a REST API, branded as
> Microsoft Graph for sending mails. Upon testing a bit, I have
> found a few benefits over SMTP. Firstly, SMTP servers of Microsoft
> are kinda slow. On an average, initialising the SMTP server even
> on a fast internet connection takes around 8-10 seconds with
> send-email. Once initialised, subsequent messages sometimes also
> face delays, taking around 3-5 seconds per message, and other
> times they are sent almost instantaneously. Secondly, their SMTP
> server does not respect the Message-ID specified by the user and
> replaces it with their own generated string.
> 
> Microsoft Graph API solves both these problems. It is extremely
> fast, taking around 1 second to send a series of 5 patches, and
> also respects the Message-ID specified by the user.
> 
> After this patch, users can use the graph API by having their
> config as:
> 
> [sendemail]
> 	useMSGraph = true
> 	MSGraphUser = yourname@outlook.com
> 
> The API requires an OAuth2.0 access token for authentication, and
> users can either generate them manually, or use a credential helper

Also, if someone is interested in testing, you can use a small credentialhelper for msgraph here:

https://github.com/AdityaGarg8/git-credential-email/tree/msgraph
