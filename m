Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010006.outbound.protection.outlook.com [52.103.67.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAE13D503
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751782867; cv=fail; b=k3Y+pQaOf34OKrbKBtoOytpS/aPo5jhPHvaMH367ASPi9tsKMislFOwJ+qncT69GRgLr1wkXoiQ20HNsgKZjz56n24/Y62nUkamaNfL3139h5y2LDUmsnTl4cQJYc8HNVVSzMG6BgxAhramXqgNSAjw9MCzSet8wECnp6uwBgj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751782867; c=relaxed/simple;
	bh=mKsMzfCMyK4sfeeynqLz/Y3DkZuDwAuHT6sxMQlY8r4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pi9TciDfk4YgLVqJkFDgJQ+g3SJh1WWJSc/soD6pnY+/NI8lUhr0ZpH074+AWlfxWv/UUTlL0mU3QCSoB4XOjnYYgdzUPXZ731fVPv9/1tjp1leG8KRk69A+3cC0q6ruaXc1QORGMYBbFQd1sClZ1CUe7G5HLJFgC2NNPq8ra5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=c0Kl1SH4; arc=fail smtp.client-ip=52.103.67.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="c0Kl1SH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSd5/EvN+YLFi4RztBsCC7x/JqdtueLlflfWRUcUaVtorTXH7hd6iSqwzEqgWAwGxlzVx4Ra1pt/EJKaY1xlAKvScO4+/N2p9903uhKjrFgPGgx05Y30xYxUfjJadbA7lQUho31XZ2T20hVOTjw0TyDXdLGGbWW3h8TJCtcGHAL53V9SFuPC5vswsMxjRtz4IkfB8EJtAhBKiZptPeW5MKUi+Wnfhe+qG6Z7N1n7lRWuHgkmrGJ5eZblQKV8Ab4hvsct0JlogVlBo8Fmmnkp0eJW2oJmQX72hdu3HT/MQe3y8gOWjKVt6/omWWtdjyfrWKGbt+D+9Sogl8nCFGlwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RhvrcMADCw1ZjyHs1dTHxGxQWRTT9mSsEpo5ikjKc0=;
 b=HO8+xYmPkAacqdxFg9Uhuh+Xc4Lu0BZutgzTK+EgKakAG+WVc2nzezfWopPirM8XcV0JIc1xcENnwPmS7//Q5qgJVFH1u0Px4pM6b0hWRPTbMCTMZRTlgIsyv58AWDhehmNVtYbiUNXd6bpd35526tB8OfsCqscBTN+qG2s0y7QwQFkThgs2t4JqMNug0HXBvN2i2NjBKxO5Y1DPmSce0dmsD3YQfPcJiti74/XL2kcvMRVbCej1iWhHdy7s0Rht7gGRARmcPby2s2gJlesxkByGSFhgg59XuRJ5WUWYHGMBFV97aB6CeYxg/3R+zawvTh/Gi2u4gi5TVW8e5G8TXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RhvrcMADCw1ZjyHs1dTHxGxQWRTT9mSsEpo5ikjKc0=;
 b=c0Kl1SH4DC7wsGa0xk3ddkN5w22hiA5G+McRtPipiwu8iOJOggY092ksxFevTIPAoh7pMQV+5yQ/wmnchdnRAbfneymA9AtaLc9xAvvIX7svx8FE/hyIazDyTuerTkkGo1iFtVzopD5VGWfdhkLqbol2ILfexwcTGX2+H8rzVLj1P7ZOeANlcAIIrdjqlOYsRSkQbFFT8y/KAfy4J3qk1v8qAqgPEbwUtM7S4j5SOZBIFVQozSBeCsc3/TNu9CcTxmDwK66rh8jLn0h16jrMavDlhrcXNGYFoR//fEY2ojGEATGUMSyUSozISZLUCwWb1U5ytXbeKCvABLQKG2YeEQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAXPR01MB4343.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Sun, 6 Jul
 2025 06:20:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%6]) with mapi id 15.20.8901.024; Sun, 6 Jul 2025
 06:20:59 +0000
Message-ID:
 <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 6 Jul 2025 11:50:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
To: Drew DeVault <drew@ddevault.org>, git@vger.kernel.org
Cc: Martin von Zweigbergk <martinvonz@google.com>,
 Patrick Steinhardt <ps@pks.im>, Andy Koppe <andy.koppe@gmail.com>,
 Remo Senekowitsch <remo@buenzli.dev>, Jeff King <peff@peff.net>
References: <20250703113505.11889-1-drew@ddevault.org>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <20250703113505.11889-1-drew@ddevault.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::30) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <d1161e78-5928-414e-bdfc-18ed74917be1@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAXPR01MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 51dcbf61-b9e0-4d53-5add-08ddbc5545dc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|5072599009|6090799003|461199028|440099028|53005399003|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzIvK216ZFY2dVJob1Z2SllTc1J6WVFFVGVFa0FGNmt6SXVBUDJiMGdUR09B?=
 =?utf-8?B?dUttSGRhOXVXZ0prMmRVUFo3THBGQ1lRcmRYUFJJRXlDOHZ5VnhCZVc2UE0y?=
 =?utf-8?B?aXh1RStaL3VjRVdKOVVBRWVhVVhHckZmMm1sOGd3VlRPNXVkZEdNTGwwaUZP?=
 =?utf-8?B?c0xpTVhRYlZxYW1ObkRXSCt2VWxLQzNvSUI2clM0ZG5WQWNSMUw0cXRvb3Mr?=
 =?utf-8?B?bklaUXczZ0ZsMkxqUE5kY05DazlLdUVtTE5Va3dGT2FDeFdwYTN5d3NEbHd2?=
 =?utf-8?B?QzFseWhLWndkNlI5U3B0cHJmazU2TWs1eHBobHZmeC9YSjdIZ043QmREY3Aw?=
 =?utf-8?B?c0RVdUdlU05jUGxObTBXVDlmd3BGNCtoU1FYOXFidDNWS0RVNjA5alpvT1Ra?=
 =?utf-8?B?cmF3V2hBRll3WEVpK0JTbTZlQksvcmJ2WG85enJZdGh6ZUkwaWFtbVFoSHhD?=
 =?utf-8?B?ejh0WUxCMk5jTXBzcDBITDJHOFpCQjVwbm5qYlJnZE1xd1NxSzlYc25tYmR0?=
 =?utf-8?B?dDI4TEJlVjVQU2xGSUpVVnpiNEx6LzhxTXIydUZWNDd2cEc3Ri9IL2V3Nk5F?=
 =?utf-8?B?NGcxMjhvdjFudzNxelVqb2xNWW9EM0xmRGF3RldmcHdJVzlJVGUva1p6VEdD?=
 =?utf-8?B?d3BvRlBSY0VOY0hCY3pnejdXcFhXdzlBQXZEVEp4YmVsWmRGMjhjTmx1b0dU?=
 =?utf-8?B?WVM4ODAzcGlaM2ZFNjdLMmU3NWY1N2tXS043TlNhZEw1WmdyUkN1aFV1eEpr?=
 =?utf-8?B?WUlPWTE5b3VvNE1hK0d4dGI1M0lqUkNCalYza1k1NUZ0SGxURjdEZkdaczFF?=
 =?utf-8?B?L1lwcmVXTC9YT25GTGNtQzVxWEhCZ2VIRGU2UHBrZmRPejZOMWQ5YmxGM2tI?=
 =?utf-8?B?SVl4dFNPcDZmdUh5Tm9YckNFM2EwZ2pDTUsvYlFiQzJ3YXhQRitKQ3dlTkFn?=
 =?utf-8?B?ZXN0RlBhV3Q0UmFaVk05YTh1NkQ4OWUxVGNodkx0NXMwcU1ieXErM1RyZk56?=
 =?utf-8?B?elVjaGhHMnkrNHJIVlRTZlZKNVR0dXJnZnREUVppeCtVbHNJYkl0MldydTFi?=
 =?utf-8?B?OS92Um1UTUxkYlFJVExaN0t0SlYzRWo4RjYwZ3lZMTZGRUUzY2szYnZJaU1V?=
 =?utf-8?B?bXFlNkM5WnBKa2YwNndyTEZxNVpVaGxGZHYxRkNnZ29BRzB3MDhDZDYxN09C?=
 =?utf-8?B?TG4xNGMySWtjOE5kQWZjbUg4U05IRmxtYnVNZmdXZWpvY3JscVdqbnRHRjVP?=
 =?utf-8?B?bEZJY0ZlV0JBb0xzb1E2Z2kzQnZIZFh1UzdnZWpPN2VJK3JOUmJRN0wxamI3?=
 =?utf-8?B?dkdMTFdleE0yS0t3dXJocWJOT2ExVi9BOFNFeExkVVIzT0RmOTdUbThneWlS?=
 =?utf-8?B?M3NwR3dWVnkzZ0wxTVFib3ltbVBEOWJHb2xyUDNtc2hmZlNRRlJVd1pXclF5?=
 =?utf-8?B?Zml5WGVQL2dqbE9kQW9pYS93VVRUSG9uU0Jsc2tIbUVmeGNscEJSTlo4alQ1?=
 =?utf-8?B?cUFwZmhiajBKai9zSU01NytCSVVCQ2tHc0diU2JEckwvMkUxcGI1TlJTOE80?=
 =?utf-8?B?c1Y4R0FDY0NjK3BJdjdjTTI4QytLSEZhcjVOS3hQN2Jra3dDZVBvYTI1MElO?=
 =?utf-8?B?NXZoc2t4ZDRtMXNpMGZaanoyRUxLYmc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnNqOGFoVW1PQVlrdmpOT0R5ZGlGUy9SQnNwTFg3cUlYUlBWTUI0WnBNMkVn?=
 =?utf-8?B?WXdsSFlmLy9ZOGJBREtYbjdVMjczZmQwUXVrOHJKWG91UVlMVDd4aHA4ckdJ?=
 =?utf-8?B?UlgwT0NUNlYwUm9XWGhoRnkrSEpzYmtva1BxcVplaW5wWjBaZCtFZS9TazJ2?=
 =?utf-8?B?SkhqSUxNZzYrdjhXYmppejRHUXZoK3IvdVpXUWhNM3JpSC8weEVFS0ErR1Vq?=
 =?utf-8?B?SWNoSksrSk8yYnhnOFZCMWgwUmhCRVBBRlZYRFJvRWovZ1F6T1BnT2NQeFdB?=
 =?utf-8?B?blVudEExVDhxSGl1V0JaSlVhZnpYanJEMmQ2Z2FtTms5d2cvQ1BiOHNtZ3Ir?=
 =?utf-8?B?ZDhVaGgxNTdYVllJTlN3SVZsd2ZiVW1ZQnZNTm4yUGJvUEpNYjNyMlZHWG56?=
 =?utf-8?B?YWdEUExyamtqN0FoeU5IVHFUeUIvcG5wNUFUbUFMeHhYNHhlUEEwMFoyajFi?=
 =?utf-8?B?elpkVzdGSDEwTFpSNmUvWTBuaUJycWpnYTVacVZBREVkSHJHZTg3MXVmWEN4?=
 =?utf-8?B?c3FLYUVSM3RXS3N4ZGRuVEdPTDFOTXN2bHdHYncwK1NhditmckdyZjliRDlu?=
 =?utf-8?B?dkFvYUlnd1Q2eDZmZDc0SFYxRUYxdTc3WDJXOXlLZ1QrWVZmSUVHL25IUUl3?=
 =?utf-8?B?SzVlbE01cnhJWGdmbmptNjJOQmwzbjNybXRvQ05td2RzbjFvS094eUxyc2NF?=
 =?utf-8?B?VXJpY3F1SWlaZ2FVS1kxV0N4SkcvNTZTNFhrNzFENTZmVi9ORXd2MUlHc2I3?=
 =?utf-8?B?dnI4OHhTeldtR2hZWEQrU1YxQzA1ZnVNYW1Ob0hWSkZMd1U5SlVmUGZiSVpm?=
 =?utf-8?B?WGdWYkZIbURwZFphcERLL05temRFY01zWGFialgxSUhJcUNrTXhweGs4cXIw?=
 =?utf-8?B?QkRrc0hvVmJRYWdFeUVtRTNocmM4WnBRVFdQRmdFYkhPSjlIamoyL2xqYStl?=
 =?utf-8?B?SEV3N0JhSEU5QW9hNDFCMjFxbElRT3ZqUkh3RjNLUHBiT04wQkw2eFptRnNz?=
 =?utf-8?B?TyswL1dEakQ3V2RZVFZoTFU4cmYxZmRpTU1RQXlzZmphVUZNYlFad1kvSEYz?=
 =?utf-8?B?ajNoSTRqUnZxTWpWZHE3emwzL0pWV0xsUVFVZERacUlvbUU1M1h6cW1Lb3FS?=
 =?utf-8?B?TkhjRklFbW5XdytKUktuVFpHYndwa3dkNUFkbTV0bkFLd3JVb1lzYm1Ia1o2?=
 =?utf-8?B?RTllYnZmU3BhRjZJTEk3bDBRbFF1L05BZUFOSk1PQWwrTUIxZTduNkhnc0g2?=
 =?utf-8?B?THNhTHZQbmlTZjlteEVybjg4cUZNK1RBM2duejZKdytoU3lQVlVud1RDRnBt?=
 =?utf-8?B?T2xpTUJSQnI3QVVWYjVTRDBVZmtpWUJ1Uis2YklLczNhSHRlbFZCV05CWGtL?=
 =?utf-8?B?VWltYmdOTXF5a3VIZ3lKMkZOS3h0ZVFDSEF1ZWFlTGh1K1dVdTVBU2t0Und6?=
 =?utf-8?B?Y2I5cmZKc1A5T3crOVN0RGZCSEJHV0FGYjQ5V2JOR01qeXZvaVFkMXI1S2lN?=
 =?utf-8?B?bEZqTDhRSUEyTW8ycjVXVG8wS2lOSUx6Y3Q0SWZzN1B5TUgrUHFzb3l2TGFh?=
 =?utf-8?B?cWowUlVIWksvYU9GNm1yeGQ3UkZmUkdGWGoxUjZOSElodTFkM1RYSzVUbjAz?=
 =?utf-8?B?b010WTdsTFh2ekQvd2xhb1JjVEJKQmc1WmtGY2xoM3BGTzB2QWErTVp4TG9h?=
 =?utf-8?B?UVg1a3FYNUQzOXZVQ0NsT1lTekxMRXl1aWdPN0NobG5vQ2dFN2I5MWE3djA3?=
 =?utf-8?Q?WxgSkU7lD6XrQ5CnpCzlLC2kSBPZqQ4xbYM4KP8?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dcbf61-b9e0-4d53-5add-08ddbc5545dc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2025 06:20:58.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4343



On 03-07-2025 04:59 pm, Drew DeVault wrote:
> Introduce the X-Change-ID header to emails prepared by git (i.e. via
> format-patch, send-email). This allows tools which work with those
> emails (e.g. patchwork, sourcehut) to meaningfully integrate with tools
> that assign change IDs to commits.
> 
> With some follow-up work, this is also the first step towards ensuring
> that those change IDs are preserved through from git-send-email to
> git-am as a change moves through its review lifecycle.
> 
> Signed-off-by: Drew DeVault <drew@ddevault.org>
> ---
> v2 is unchanged from v1.
> 
> One remark that occurs to me upon spinning v2 is that I'm not sure how
> to test this behavior. There is no obvious way to cause git upstream to
> produce a commit with a change-id -- presently these are only ever added
> by third-party tools.

I don't think we should add it to email headers. There are many email providers
which do not allow custom headers in the emails. For example if you are using
protonmail bridge or any third party protonmail client, the headers are not
preserved. Similarly, if you are using MS Graph to send emails, headers are
again not preserved. We should also consider cases when people use Thunderbird,
Mutt or something similar to send emails, rather than git send-email.

The headers IMO should include the standard ones like From, Subject etc.
Custom headers should be a part of body, just like we do Signed-off-by, Link etc.
