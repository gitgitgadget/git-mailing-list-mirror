Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249821ABA0
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536108; cv=fail; b=bsHX1KTglCpinMZunIhhO6I2ZLpylGL2CZU5PFzjCzjiYfRLzLXbPEMgSRi0b4MxrYJEuoakExwEyYTUIsyr1VeVDwKhvGzJGrLlYIhn2rl2Z5RkD4YQPwYtX5HFazN5T9MV/giqVZsJ94571D7F5KkyXKCUdRnd+Y6GpcDY2j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536108; c=relaxed/simple;
	bh=Vue8r8d+ovyHf+xs8n9IpJYLXGd7RgBpsPw0vxHe8HM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u2k0X/ckdqrROkCvvbP9krofgIGU1Sk8GCXZR+yeKnPyxaHikLMow7n4kzgNTROTf+loInEg449kCofT4MW1FZ8dTJHp1S+9hE/e8U1YNZzk5TCjEGwbKNrFc8q77uzUmf2SzlfVwbxWSpHG0QnmKYqGC8yYmVV9umWfHucbHhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZKwHOdMC; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZKwHOdMC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf461WxhAeBNOmchqOwVY8ee89Q1gLdtgoF3sdoelOge0agBwUZOWoGtFNn4ZTn1+7ceat6je+/G2ofMfAWYbXBaIkaVjJSJ6i0RraQaSFfTfIiD8fZ6rMJugc1jMdbtVWctG0doaJpUj1klANC7vkMgCUA1c7o7ukoFB9cYq7CK3hBH6kk8rX9WhsRNGG4U/2BAvjrfo2Pihub/Y9AbtFoX3VT4+ICt91OAk/lXg0NIpI04RQlPkOEg7e42Tw0ZSgMnJzZ4731iq3fJ5WdihdPOYU2oa2Qf/0XUWeTeyHok8C/PmRPLjA+Qu5mkBk7zhU1t50+F7exKbULkf93/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRc3n6JRInumMBdjONHDeKX3PrsVjwmCMNlSC3gFGxQ=;
 b=iZekLOaDsN/pMvlfr2QqitaSWP6aqwQonjg21CtXCpWiFYL6QWCl8yE1vSXlhBjx6Zhm+7kHCfL24JkXRAIyx/4zN4rywxiFMd70uQidXdVWXsmAVYMzPsqUp4cVZ3CLFgSr7kDTpSGsbMkIfjFtZg9enIjmA0hk8rrdl5aXejUPqLh0BHSQE2gxxlJugw00UpyKGunaJC24vkHmk7t9VnnS26se6YcAT3h4f1agAk2PGzUXTJWcZ/6hNDGhpd2CfmxK9sxKW+KJa8e7RKW9Lpxs6nagb1G71x49eeIVQfyFQABQh7sJnktdUsusbLUFKgu0j4L8mRecowQLDcFqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRc3n6JRInumMBdjONHDeKX3PrsVjwmCMNlSC3gFGxQ=;
 b=ZKwHOdMCdZVJXCGDdO28+YK/6GYKdnibKAck34ZhG6U6rD4c+OrfBgobG6UO3Sm4PviWQdOMWPZ9Ln7FoiR4xvb0Vh3d9gDp7p0bcUqkcAR6sJAEnqASj324YLXT3KkR/Pz7ql5idtk8stghl6DEIHDzcpn2mJVWW59JvTour53Xd+4c1vhEwj7HzpftrWEmMPhv1+bEfiTHqtYS43izQdHd9+7AnHuUgugud8yyQdZpOZ9cbZHYsq4UIqvAUQzCPnuuhn7Taq7W70z75k7G3uf4JYFTevTsrrQoMW3xIIrqf2qvnVoUjnmepW41ehMN/TQrHJDVcFqe1gqKIREllw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN0PR01MB8811.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 16:28:19 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:28:19 +0000
Message-ID:
 <PN0PR01MB9588797F057CCDCE8EFD51BAB866A@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 29 May 2025 21:58:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] imap-send: enable user to choose between libcurl
 and openssl using the config
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 sandals@crustytoothpaste.net, Zi Yao <ziyao@disroot.org>,
 Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B56233DA6815FC7CA96EB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <42e07f4d-9888-4a1e-826a-b53b7d84fef6@gmail.com> <xmqqldqfl6z3.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqldqfl6z3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::7) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <afd53e4e-ed56-44cc-a157-f9e5e089bf4a@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN0PR01MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fc0063-4bc8-4ba5-bba3-08dd9ecdd287
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|5072599009|19110799006|6090799003|15080799009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azRBeXNoS25oWVNBVGdHMVY1Z2ozM0ovcHlLekdPaHgrZTNJL2ZKSGw0cU0r?=
 =?utf-8?B?dkdwUEtwRlFWYnN4K0dyRzBleWFVOVFvOGJkTmxpZzNXN0dUT0YxdmN2ZUo4?=
 =?utf-8?B?ODNKbWh5Q2lBYWFoQU1rWnl5aFYxUUxJTHV1ZE9UWENOaE9BMWVhczRnUWlL?=
 =?utf-8?B?U3UxbDRZZG0rMDdmS0ZGbDJYbXdRYzFhSWRUVXZEYzRrVGxIak84Q250Q09V?=
 =?utf-8?B?ZERrQ3dCRUdwK2dramlRd3VCeDVVUzR1dzVadWNPQ0FMY01MQU8vQlkxY01K?=
 =?utf-8?B?dzdrcjNKL3NHMHY2eU1tdjdCQ0lydFE2RU5sR3dtYnlxV0YybmtsRnZRWmlM?=
 =?utf-8?B?Z08rTERraTBWdGttcVpCeU9GYlNndjA1cXZhQWFuaXpJdytpNlZSblhwbHIz?=
 =?utf-8?B?L2FXc3lYakp4ZzcwbDZUM3g2L3ZPVnZ6YTNLVmgwc1pGcnNnVU9rbE95TjJE?=
 =?utf-8?B?L0Mrcm52dFpXd2t5eld0U2hsb1N6VFpaRjRtSmRiZWFRYTZvbHhUckt3dzhu?=
 =?utf-8?B?bHV0VktkNGJEMkMvL3VDVnFCbTU5WWtCMDA1cG5BOFkyM2NNTDBsSDFoM2xC?=
 =?utf-8?B?cnlOTkhyWUM2WEV3S01aZmZ5MzNCNjBvR05Cd3kzTTBJaG5EZUoyVVMyaFRa?=
 =?utf-8?B?ZXRmY3dnL2szTlJVSTdISjJpcmNWVzQveFJMVFFueE5Qd0w1SVlmSXl3Z3NL?=
 =?utf-8?B?VCs4L2NiUGlsa20zaHJvNytMTTU2WXRsNCtRbVNwQ3JLUXQ5dUZqY1gxbWJi?=
 =?utf-8?B?M2d4eGZ3aDZ5bXFxTmoyNDFUR2dIM2ZGdFBGdzBDVjRjZmZZMFdScUF1dXNH?=
 =?utf-8?B?RVNlRnJ3SzdWR2VUZUFHdjNmajM0azM1aCtsSEQ2OUFIcDFYdGd2M29TMGlt?=
 =?utf-8?B?TElMQzVaYlZsMXFMTENJRG1rT0tFN2I5Uy82djF5d0V5eFVUdkdnOEkxbkhv?=
 =?utf-8?B?SnlHK0E5Snl6dU80dmpPR25rTzNRYzBBWm9jalZUT3piQ3ZTdUNqbHNmdjB6?=
 =?utf-8?B?NFozQndCOTh2bWZSZDZJenl6b0lJaDFCTVFQWFhTa1NJdFI3eUhML29RbTRH?=
 =?utf-8?B?azIwelJ2U2dBZWk4L2NZdWNUdDNpOXNVV3JQVEdJa3VEL2Jub3dBZzNZeWlP?=
 =?utf-8?B?aVhyY1BTR0lkczdxcDNuNE0wck4vY0E2d2swMjcwZGZraVpKWkF4cGxqNHkw?=
 =?utf-8?B?TEowZTRUcXREdXlmaHlDQWdqdFU1cmp3THlGcFJ4S2IySjRKenYvOGxxeUl4?=
 =?utf-8?B?YUdEZEFjUFNoVGhtN3ZJV3NYenBJaFRuUkhGYnZ1dE1ZS2xLL2c2SU9hUWs4?=
 =?utf-8?B?OUk3aHoyY3ZZZkdTS3JzdkM4YVY0RmZNTWVpWlFGNmppaW52cGZWdHoxU2VY?=
 =?utf-8?B?aXFIWWJ3MTc5dm9NVUpDTmJUNm5IWndSRThWM21JeTh3NFdKNmdHcGlOQ1g5?=
 =?utf-8?B?eUxISVZsTjIwZVBDSSt4MGxZd3o4UGVibXgrRnU4M2dxWXJPSUZreXArelVM?=
 =?utf-8?B?ZTBQOWgzQ01qbDY4RGZXQ1M5K0dETUtnYi83M0FzTlA0SUdyNjJIMktBazdH?=
 =?utf-8?B?cE5SQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUNNMy9HVjV6WTNjTFhrYzAreXN4K2pZdGJ2MEFxbnRuU1ljWEFyUjJiQ3dp?=
 =?utf-8?B?UTNTbERDZUprUkpmSXAraGZpVXBSTHU5WDc5UEVnVEcxNUM3bzdSblRHU3pF?=
 =?utf-8?B?OFMrb05wbFlaSms1b3ArZzNEa1hLaFB6RVNkNmZSL1RqMzlBWXloM0Yxc0tm?=
 =?utf-8?B?QkR5TnBMNi9vWHAyMFd2QU82NUFjQzYzNHhycWxvQ2Z5aUE1Ym04bmJ1Y01z?=
 =?utf-8?B?LzQ3ZWpMd1BRYk5CNzNPNE1pZHZSdWhFeGIzbm1nR3RtK1F2dWNtamZrbDZx?=
 =?utf-8?B?dkNsQlgzL1dySGpqM1N0cFVSQmJXQ2ZUWE5jT3hNU1NiUXRWdml0R3hIR0FU?=
 =?utf-8?B?SzRxUFhZaDJGcjFjdkpLYVhXbHRBV0w5MW9sYXVrOXRmRGpnUTNLR0VEaWpM?=
 =?utf-8?B?TWIxVnNKYjludk9Vd0lmY3JFOUZsQVZ6bU1pQ2FNSUw5QkJDaGx1ZmtBRDNN?=
 =?utf-8?B?K0hQQXVMU0ovcGFtZ1RFN2FiYzV0Y2xaRlRnSytma1hianJyT3BMdXo5ZGZp?=
 =?utf-8?B?UkZkNy9rTFg0cnZmYldUSjhkQXdDb3kyR2dMM0NyaVlHUEVPdGE5Y0V2MStJ?=
 =?utf-8?B?cVRIaElSaGgwUWVSRzhhVm9oa2w1NkQvN2ROQ1M1dlVBazdpb0M2cWthTS9x?=
 =?utf-8?B?Y0lMTkhBSlJSM2JlRFVHbmdkZnVXNEhhTTJUSmdGWnhzejFNNy8xVUxxdmo5?=
 =?utf-8?B?RWNIV0tmQTZ4RUJaZjBvMVJCVFYxbzNrQ1J6eUd1ZWZpejliM0NjMzNWd2ln?=
 =?utf-8?B?eGUzdzROc3ZKMmhvYlJtWkVUOGd4cGlqYjZQbmh3Y2oyakRVS3NWUkp0Ull3?=
 =?utf-8?B?YzcrbEk5a1F4YlhIYUpFaitWdmU4UzBXRnpDamQxN3U5OHZibVRPNityYzdY?=
 =?utf-8?B?bGhIdngvejhrWFFMMWg4OVZuRVlNcHpNdFBrbVR4UXlNU0NZak92djFrRkpV?=
 =?utf-8?B?M2tQMnN0d3p2dWI5Nk9oeWxXR0dwSGFiRGhEWkx6WjRidnRtSFgzczRPRkVG?=
 =?utf-8?B?SGZXQzFqRjlEbGxUcmIxa3pVS2QrM2dVbnJIdmlZcVJ5VzFEb1NLME9EbCtj?=
 =?utf-8?B?a1NZUmoxYnVGNUFoTm1sdVZUZU40N0dXamhmRlNIRnBlU3EwSEJiMm92WUxi?=
 =?utf-8?B?K01ieFZuZHkyRmFXSk1GSE1IZFg1RlNnczlrSk5CbnZZakhQeHhVWi95TDQv?=
 =?utf-8?B?cjZRT2lrTGRSNUFOUkE3Nm9HNkFNTEdOSUFZQS9ac2JaeHRWcWw4b0VEUENz?=
 =?utf-8?B?bjNjSTRqSjBUd05CWWpVQzlXTFJDZ3psY0tyVjRqT2JydzlVSEl0R09tVk00?=
 =?utf-8?B?MkZBSTdUS3IrZHA1RzVOUWhZYUR6MjhEWUFCaEpVYUxNd2J4aXpGdmdabTZt?=
 =?utf-8?B?ZXFKTzM5bGdhTnRLcVpBbjNRYnZOV2N6alBkYjJDYWo5RS91Q3pmMGpzUWw0?=
 =?utf-8?B?QllZZ0hqY3gxRjJjeXZVSko5U0l0WHhUcUtmSGdqWi81NktGREFCM3BPRWJo?=
 =?utf-8?B?OTVtY3d4cG03U3pONW81OEZrSlpvSi9HMnl0N2x0TjBrTXIyQXI2NWFheWNB?=
 =?utf-8?B?UXMzWnMvWmhRMm5WeFlIVjIyQW1IZU1kSHpOdTNQM1NMRDdnMUFsYzRRbnFI?=
 =?utf-8?B?K2I2eW1zZ0JmbWRlQ20yUVkwQXhkeWJlcXBGaFVsdUlMRnZuZUJHR1M0MGdv?=
 =?utf-8?B?cy9tTVNVdzZpbFpJN2dqa08wd2I5UTc1YjJDUUpvcWhVUDdpeDV1bUFHa09v?=
 =?utf-8?Q?1rkP7nlNS5LkeSTUxfxB5pPY9ZONUv/a94DfNLA?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fc0063-4bc8-4ba5-bba3-08dd9ecdd287
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 16:28:19.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8811



On 29/05/25 9:55 pm, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I'm wondering why anyone would want to switch the backend at run-time?
>> There has been talk in the past about removing the openssl code [1]
>> and just relying on the curl backend. I think that is a worthwhile
>> goal as it simplifies the code and means we would avoid having to
>> worry about whether we're using openssl correctly [2].
> 
> Excellent point.  Is there a downside if we only do imap via cURL
> library and lose the code that directly use OpenSSL?

I think the only real down side is removing CRAM-MD5 support, which
won't impact much, especially considering the fact that how little
this is used.

Although, most code will still be needed is you are using the tunnel
option, so in terms of code cleanup, not much will be lost.

Anyways, in v8, I have removed this patch, and added another ability
to list the available folders.
