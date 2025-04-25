Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42149238176
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574343; cv=fail; b=HAHk4xhiZBM2ubnPJf+gY0urcEJNCkeSDS7SQEJQWkgN+B7+L5ZIHQn6CcDdUddDvuF4TTzNvJRmXMFVq83VvGAoE6DbUpCYH1k64Z0qwZn5tLzxoCgNSr47PNjHeQmnsXEMOzCF7KxI3gIdMKeLr2vrD9Mz7moQXUsTXjXw1oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574343; c=relaxed/simple;
	bh=FQk055mnK6qXpCD2480y1B9Q7xVAOYZCwwY6pcMD21o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBSd+1dngbqPhKosfoq3VC9zabQMQ3fKSirM/3SV77OkGALil6re/DliX1R5b+sBSsQobVDHo6hKBjU1T5TU+9IGGCuwRQD6O5f7fD/07SJI0NIROr+zZPsGF6EJYMXI3oXvXNBG2ZLDeDFLahq1rxvKHCxyeVi0HUtIxP+9h2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=DdH4sGa4; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="DdH4sGa4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ6/xjTL32T9TgSpp4gvsTokKLtQAS/MVLY/gVKG2Tqd11M+moe8s5pD1LlDz4/wqhVYNCqZJaY6QuujdOx12cNpGgs5R8RdzdwKW6hH2/eQo6P+IOEuuLe7lfjR66pI/sr3jqH+JelnRYk7jqoQ3Jr5hQOc3Td8XYUs6VavNio2tK9zA6R4JEpiCA/a8jqHDOz6YN0ENxt8Oa6WiDgLpyLrS9VkC8x8L/ea6zCOUbf7EeW4fy81XOUPn2RTZ4w1C/oZ5k1Ro7bCBxnDSO0vh0CSOALB9aWoihfcEu1pWDltg/R7mQan30E+CKjfdtFwEKQhp2pE+V0RWZ/VsigaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQk055mnK6qXpCD2480y1B9Q7xVAOYZCwwY6pcMD21o=;
 b=Wsx2gCtY9aJ5fIEpD3pjReJFHFj4XtoTH/ur3/XmkqIvuxJDRjiolKchU/rGPuoJu5EeYsJoNUCmPevzpsnV2mF34wGL+lSSJ1sAt0Bkf2rARNR/FolPmyaX8DZ40LY+J7h8gd4qdA02e76xuC9l0SgUaAcL8SoXFU6FUEYVC9WZpBENDDRiWz8zWEO96hnLcKrfZhLuXzHZlvAQMsoMUFlTPi50h1VsETf7ZKkShPouySRDbExlVNygjxvJzfp6pomkh+YvJ2xg+9p4kPsojXnfzyXhCR4ybF7CVJsLT4KbsgLSCCzF6e2c+O7P5wXNE7khPpyaERfnLedPWr683w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQk055mnK6qXpCD2480y1B9Q7xVAOYZCwwY6pcMD21o=;
 b=DdH4sGa4iu2IlDkiJGnHBS/bdBD8bIEhtVE3RF4EqZutsAPkhsSKPY6V00t0jqpuLwPd0mW36KH8wGIEBmr/jD2RQgbEo4HNGgKIc/TOAiLF/iJqgEcTvYNs793MBBhljw/XbHVFzcMzxB1jgpyuQFh/KIjx4/PFrQuE4dAAl4Qqo8x0H0XIEA8ig23SUav2SoDT4zUDRKhaK7HGTAzb9MnszBpryLiDTRRaVG9+5JsOVgxgQvaThuxJZEsqjx7O5+IRAQGthO6pVDAxUHWkqQfceEvgdXjDLrFKAbsmsD9Lp580JX7JdRvO0lJy79/VVSSaAQXETgRYYffBWZn/Sw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN1PPF67FD6FC9F.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::310) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 09:45:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 09:45:34 +0000
Message-ID:
 <PN3PR01MB95973DC8D1505AC041263F0EB8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 25 Apr 2025 15:15:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
To: Julian Swagemakers <julian@swagemakers.org>,
 Erik Huelsmann <ehuels@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com>
 <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <D9FI2S0NSC40.28VZMYOR6M8DO@swagemakers.org>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <D9FI2S0NSC40.28VZMYOR6M8DO@swagemakers.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <9b21dc6d-8987-4c20-a71a-b89e5b17719b@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN1PPF67FD6FC9F:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d5effe-6ffe-426f-727b-08dd83ddecd6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|6090799003|461199028|15080799006|19110799003|7092599003|10035399004|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SC8vUUpzcTU1TkIwZ2JwSkFCaTNVWWN2TVZrMXhpUC9Yd0RuZnlKL254bzlu?=
 =?utf-8?B?ekdTZXJxaG0wdnlSeGp2L01FS2ZjdUxiVVVJMk5RZThzYTFBV2xnTk15Qm4w?=
 =?utf-8?B?dHR2d1I2QXVRVU1kZExZdXhieGx1L0M0VGtsOFNIcnVrTXJSNEQwZitxRUR0?=
 =?utf-8?B?MU83c0FkeHZDbVJ6QmR4T2xxQWo3YVJyTEpoRENEWlBkQ2ZRNEhXUzFLcTZN?=
 =?utf-8?B?WXFST3lKWVRmUGhtWEVKdlVWdTlYY1VoVEVCRUpvQ2pvMGExQWo5aUxqV2tt?=
 =?utf-8?B?MTlqT0M5UzVRWW9ETi9NeStDcytJZ1lrdElndHA2Y3J4Skd5NFVPRjM1ckV5?=
 =?utf-8?B?dmRQSm4rY2c4UHIwaFZKM1ZzYlZ2OHR3N2dpemhrdnpmYldvLzRYSGxTOE5i?=
 =?utf-8?B?YnFBMENadkRxUjBwSE9WR1hrbmFWYUttaitxQUpucjFsRXA0YVFPdW9PSVBy?=
 =?utf-8?B?dEhwbDFhNHlBNVI1WmV6TGQxaG5zMHQycTg4N0phK05laVJxUFhPajNIOUYw?=
 =?utf-8?B?ZUhQaFUveG9CUkVEV3lMOEc4cGkvSGhjNWdlbmI4TE94a3F5TnYraHpTVXov?=
 =?utf-8?B?MGx6Qmtpazl5Y1hyTUlZTmRhazRoRExxcnh5R092K1MrekcrNTJRbGZJVVA2?=
 =?utf-8?B?S3NMcWdMd2xVdWZTcDVXRzRTM1pJU2NldkswN2JQSlJDakliU3prSzZlUitt?=
 =?utf-8?B?L1V6Q0dNZ1J0bVBlWU1ldG9vOFZTVkVJRjg1SkNBckZuWHoxdGVFYmtZaUJu?=
 =?utf-8?B?b3hzUzJxellkY1V3NzV2clRldVlTWHNyR0psWHJERnRmMWZqcmVCOGZrSEpn?=
 =?utf-8?B?dnNOcXJHR2RkSTVuQUFJbUt0VGVFaGUrbU8wekxUWCtEYXh4UVVGb2U1aHEr?=
 =?utf-8?B?OTQ1R1BlaThBdmtqdCtlN2JxT0w3Wml4clFOZDVQQnZIRkF6aWpiZzQ0LzVz?=
 =?utf-8?B?UkFucmhNMEwyVVRUVUZjMjhEOEtMQklRWHRFQU5tQ2ZsU25JZXRUeHN4ZDFF?=
 =?utf-8?B?dmV4TlArdHpMc21JSGlMbmpLdnRrejJPcXZhTVBxNlZDUDlnY0s5Q0F6b1lo?=
 =?utf-8?B?ejVRUnMvNUU0KzhRY3JsYkZsd1VvR21jczZuSW53Y1IvaE44WEV1NklqWktl?=
 =?utf-8?B?UXRRWWxzTGs2UW9iTTFVTTNDZHMwbE9uQnRDRHIrZlQ2ODBDMVhRQ1g1RFlF?=
 =?utf-8?B?WU9udGZlM2FXMk4wdk5kbkJ3VHREckRiOVVSRWIrY1pMdWZOOXRXQVhBYjg2?=
 =?utf-8?B?cExMejJJYzFYN0tKb1J1bUNFSkt0dk1OZmtRaFY5U2daQXBNUHNsbkp2TzY4?=
 =?utf-8?B?TnZZM0JwdklxTEg1SHRvL1lBenRuTDIzV0FmSnRaVFFLSDlKK2ZIRENXcEhG?=
 =?utf-8?B?cW9sS3lRei9wTyt6QkNwYWhiYTllTmVCT0NUbmtpTXFydVlHZnVSQ0d5OHJ6?=
 =?utf-8?B?bmpRcXZQUHkyaEZhK1dzU1RSZHA4c2RUNmFVTzNLY3ZXTEhScWFwakxTekhj?=
 =?utf-8?B?cUxxNG10WkhSUEthUnZmZ1EyN3BSNmx0Q0c1YnhDaDVpNkUzM3o4NnAzTEVB?=
 =?utf-8?Q?G/MuxaLFYKG5b0bFWDpTpIIxons/MChSQRjQ/4KDeYWWfc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkR6WjZSRmluUUJzam9WaTJhakNYVkxHbkszYkc0dXZOZ3ROYlhxc0t4dkFa?=
 =?utf-8?B?UEU3a29kTVV4a3ViU0owd3lPV2NVUTVpdmNod3p5aWpaUzZCT04yOVUrVU1Z?=
 =?utf-8?B?MnZBbW8yeWpRc29WbnJnYURWS2RqQ1pNdjhSbHhCQ3FJSVVEQlF5dGIzK3FY?=
 =?utf-8?B?bTE5M29UL0xjMlNaNVFkODZvWmwxUUMwUjI5ZFM0V0hzL2RKMG80eWZseU5k?=
 =?utf-8?B?RmRySUhIczNTUXkvcDJETWE3YmpvT0w5TEZCUUUzaHJNQno2MXM4SGV4TTVZ?=
 =?utf-8?B?N1VKK3g4NmJNT09GdFRTWHp5NGlvSkFqNGRUNkMxRi9GUEF5aG8zWFAyZnVG?=
 =?utf-8?B?QjhhYkIzNnV2dHA2d1ZzbUdJaDBrRDhnZ2lwd1k0VnBQZHpyVUxiTDVVamhu?=
 =?utf-8?B?MCtDcU5lZzI4eTVubHVOakRPZHR5VHByTXhxcHdOc3RtQTdQakk1TU50SElG?=
 =?utf-8?B?c2k0QWlEaVdCbW1MSGlsRkc1cUx5dUZmRVlyRW1WL1RLcnh0cUFxTDlGaVQv?=
 =?utf-8?B?SmdmblJtN2hLa0J4dE9QdDhwbmp4YmtXNlk0VklQTms0Tkg3VHJCN01qWEh1?=
 =?utf-8?B?WTFYem9Dd1A0WktkZ3B2Z09YRnp1Titic3F1enh5ZnNHcFR6RmZTYkZ1RzNs?=
 =?utf-8?B?UmhVSHlsYWwyTmRBbHZTS3NTVEp1amcxUWpWUVQ5ckZZdEhxTllCdy81TW9Q?=
 =?utf-8?B?bDRjOTZpRmtLYXpDby9aTjB0VE5ieEpmSjE1aGU5SXFLWW9BR0EvenFBeEtN?=
 =?utf-8?B?Mm05YVkvcmV3eXZPY3U4a29wRnVJdUpDYnI4U09wR0NRR3Q3aDBHRkJTVnMr?=
 =?utf-8?B?UVk5SlpPUFNjcGlUNVp2NSsvYVN2ZFFVbmYxYjlLOTBUVTZrOVdnQTErdGhz?=
 =?utf-8?B?enU4ZGFwcVdnd0V0cmd6L0FTbnVQemNPUVR2NUpzU2FScjlzVHcrT2I5bjJa?=
 =?utf-8?B?UDlicm4vTDgzVy9zclY0MitlL04zWnNlUEhXMk5SSTI3NlpqRkhjN1FzdkE0?=
 =?utf-8?B?S0dJSG9OdjVpaE5CL3hreS9rc3g1OGxGTFpEZWthcEp1bko4NUUvUjJUVmxa?=
 =?utf-8?B?WUZ3cHZwWU94RXNXZDFtQktuTjE0eS9XODNIL2poaGxod3c2N3gvN0hwTS8v?=
 =?utf-8?B?SnUrd203WVd6dC9RcmtNU0tvSXV2RmFET3dCdTQxVXpGbm1pSGtOc0wvcEk0?=
 =?utf-8?B?WDVXVklhdVFzV1lhWC9VbVRiSHM3Y1dKakJuQk5SZmRaM3hkQVZNVGlsV0Fn?=
 =?utf-8?B?a052aDBZTHZRcGYwcWsxSEJXQlRQb3FlRmxwYzVGWFMvOEJGeVVEaUx2RlVs?=
 =?utf-8?B?akVlTEo3N1c2WFRtb2tvQTFLeXUwRFBDTGE2MDJrR0o2eDRLL1FNNFNNRG44?=
 =?utf-8?B?REYxSXRFNlE2b1BaWTFSUTVRT3lRUm5OMHpEOVhnYU1FcGFKS0xVejZRZFhP?=
 =?utf-8?B?elI5blBOcWNqWTM0UG1HeFlLLys4VXZybjZ4RWVQN2Y4em45U3R0ZlZ5QWZY?=
 =?utf-8?B?bVlRZXJyYWlLM0VRbktZcTFyWTVUeXBxVDBWd1krSjU1QXNEQnRHNG5TM3FK?=
 =?utf-8?B?SERrWUlVRFluUXBUZ0ZlR1M4WndVVmRJVENLZnlFc0ozT3lrbmdtbDNEdjI3?=
 =?utf-8?B?V1U5b3FzWjlOZUFac1NCYW9HVU9tWU14R1N4bC9uTmZTZ3ZSMEgrbS9ybHZC?=
 =?utf-8?B?cnNOZmpJKzhJdkRlUnNTODZKSXRiRXZXdnR0NHFIbDJoWW90K3h5WWJxWlNF?=
 =?utf-8?Q?tIFMbbYMliCqEVxXOWpOxq9yIpSwPKkgqHhrmCx?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d5effe-6ffe-426f-727b-08dd83ddecd6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 09:45:34.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPF67FD6FC9F

Hi Erik, Julian

> Aditya, do you want to create a pull request on perl-authen-sasl, or
> should I?

I've sent a PR here: https://github.com/gbarr/perl-authen-sasl/pull/19

Julian, I have added your and my name to the Copyright here. If you or someone has any objection in any one of this, please let me know.

Cheers!
Aditya

