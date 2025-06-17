Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010014.outbound.protection.outlook.com [52.103.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977B28399
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138678; cv=fail; b=c5gJPMZq0GeN0yUrBMYZaJ2RePHES1ok/i4FYu8BLZHKebDTWhKI71O3hyZgH07CPDMHU9Tlu+BLzlBlwOKrQmtCLsZSy6muLKto21VPNZAT6eXtdbB8SU6c2eGXh3qJkWh2hyKiIV8gV2JMunmGppF54tlqZefGP7sN9PCYJP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138678; c=relaxed/simple;
	bh=P2tVGnzDg+zaRvvdL5b1UXJjExfh5mA7ytZycDm9omk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kzSVUtjXj8VuxXeOugBPT3qCS9rEeQ4OY6dEWdSynGLdol+ok9hhJ3IawIIjTm2wb1b2lmYxoyA3kgbTMuwsyr2pNpnk/30wd1bnhxl3z0pN1ARGU1vx/2BpsWEnLGdkObLqzmz/LwlzHIm1CKdsVG73yiVWzdO8goj0KWImg4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fvxL/TJN; arc=fail smtp.client-ip=52.103.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fvxL/TJN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8EkSDePeyFoTymnM+ov9jF3dzbAcCEFM0JCVkemmk7nYsm8YjezIfjtXJaCq5PmngoG7OKlKti9PUxw9wMeT3Q4RE+o9+BUaC//HLopFMxTiwTgjHBjspqHiebd4yqPim/hrPmkfvVUXxxawlYdGNoFUF7nZ+TSdBK4fpBfoT/wUbDt5HNv8roEqtKErgT0fRMRcj8ybmKCElvZy05SDer4gn5HBRckjI63TDo0xhWFN4CfoofnXDaZ1iz3KO6eIl63S+mL5CkqlsLMC4SGq31azdEbeReGa3usdXnb24qh523BXTioz2uAbLR9hbHgLi69tUFxIRZp/+7LttyBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QWMTJP55M3IByvXUn/wdK248no02MZ26/WoO/n51no=;
 b=doru65Sc28S9NanTBuvCHnoTGu1JPsuIrxJHz82Hcw2eIQmT045hCQ0zlnYVFPL9pa3DeErFt79iF4L+1bq+667bqTKRXslFKBzC4fXCufkqf4lrfxRFjA4b8Tz/gRd85FPJPj70sMbCK0GoJYxjSumZ/ARrqVKzZH6HOYAfKrkbShJzYE6wdIbaNATo18vSZErjDunO3o0EyfqK2KjpxPS8xkTmI6RKUualSSB9JMjhpwdM6CR+R5kT86WRKp+PuNfD68DmdG3ColqCzFLQCmAOA2TManTkiQRm7Ld6+KdialyrwQl3BOOyTS5HBYI33tL6dQSK+X8s0oiNC+U4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QWMTJP55M3IByvXUn/wdK248no02MZ26/WoO/n51no=;
 b=fvxL/TJNZE2lgIyoOYe9Hmf6/mQ1ROqYbQjM0CIdosTz1ze859iO5TtqQZOnHORKYfc0xbiXT7ZgLLKvP91kitN6jjyebXh8SGPROuksZyT6LU9zqaL4OqJZlao3mSLuFbnZ1sEBsdJwxCsyfg0BH9117YSnbpaj6j+THr3sekqeySGNQLyvgo+EO2sTGpKtAyVXFpGiDDNK1x1cJCZNMQ9Wu+++vF542Jk78sSsNieKlRNv7f9/33RxI9t3sWZZ92qSHlLDs3m7/AO7/w2Xot+8qfq9RDZEEvmnwqmhcfkW99QqUXuP5X0IKkHOYKzj2fXmgp7XJ4UisiditO1Q/w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA5PR01MB10986.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:169::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 05:37:53 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 05:37:53 +0000
Message-ID:
 <PN3PR01MB95970640DEF31611E3AE3D96B873A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 17 Jun 2025 11:07:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jun 2025, #05; Mon, 16)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwm9bzjpn.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqwm9bzjpn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::30) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <811c732b-069a-4284-a57b-e6569e78f572@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA5PR01MB10986:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a1fedb-c438-4e9b-ab32-08ddad61197b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|19110799006|8022599003|15080799009|7092599006|5072599009|8060799009|1602099012|4302099013|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEdDWkpKR1dWdS9iczlVL2VqenlJQXI0Ym5Qa05qSWFkYmo4dFRaaWtaZzdt?=
 =?utf-8?B?QlFKQXhpU2d5U2NhZTMvVlQ5clpaT0RHOE5BVThXZmFyMm5Jc2pkQXhHdmU4?=
 =?utf-8?B?clJiWWF4NjdNRG9qMkFVbGdsZTNpUzdSeHBDV1hFUS9PeXRPUDFGeUd0Tm9N?=
 =?utf-8?B?ZGltdkFlTm1wYU5QN1F5TlBad25Sb2lpQy9JMWJ1a0JSWUJVeGpMMEhVVDhi?=
 =?utf-8?B?d0ZMdE5YZFl0cTA2NTJqVTd5Mm1IT0l3YWZMM3ZRSDNVbit0a1htZ2JIRE9S?=
 =?utf-8?B?bkpSQ2YzRWJ1cU5wdUJCc2E0WGxFSmlldGh2RmlLLzdkc0NXWVk1NkdRQS8w?=
 =?utf-8?B?VUJJZEVUY05OcDhTTmY5TDVIQVIvakQzMWJyaXhUdzBXS2xRL2ZxQ3NSU1cx?=
 =?utf-8?B?SUxzcjV6Q0V0TFVHVGRoTVNjWC9MSzU4cHZ0aUlBbE94Y2kzcWlSR2xRdVpX?=
 =?utf-8?B?NEQyZkE0aFdLZndxeU5LZVUrZHMxb1psWlp5Zlo2dWErQUpKSDY2Y3hKZzJu?=
 =?utf-8?B?OXgvRUl2UHZ1OUZPU2RaRkhNak0xazR5TktNMmF5Q0pQQ25LM3pWaWtFc01m?=
 =?utf-8?B?d0o0UzYxa1VFanZOamZCR0JDTUo2Tk9qSWF6ai82Z014dXpvVVhqUnEyZTQ2?=
 =?utf-8?B?c3oxamVNME5ac3dkbTl4R0NFRkRjYm1DZlhjdk8rbXF2M3l3TnEvcHBQTE1H?=
 =?utf-8?B?Yjd3QW53c2tJL2kvOU9HdmtTaGE4R0FMWkNSYkhNemV1N0huN0ZFOG9kMXZG?=
 =?utf-8?B?Qi9HckxBNk4xYUIyOFpOdHdneG5Vd1FrV1psdklrTVRRUE0rZlM2Y1VIWkI3?=
 =?utf-8?B?VzYwRy9NY1Y1T1Zab0dFMTNRZklDbEh1QzdwSlYwTEZsTnRZWGhJbUVWT05Y?=
 =?utf-8?B?R2dBRXFqOGRzcCtlZS8rU1lXWHJIb0ovU1A5b3ZCdGczNDhyMWllRml5QkJw?=
 =?utf-8?B?UW0xTUtXaUs4MlFMYkVMazd4dFhFc1U5MlJ3R09VRXRZRFdmemRyRkNMQzZN?=
 =?utf-8?B?VzRyYVdjczNDT0hwS0RKZGhBajBXRVRQUDhsYm9rWldaWS9ZQ3JIeGJpazlW?=
 =?utf-8?B?eVIrdW40L2FCa2J0MFVxZ2kvY3dGMENKbXdJNjc1TUNYNUdLaFFYbnU2T1Rw?=
 =?utf-8?B?aTB3Z25Sa0l2ZUd4a1JiVWYyeVhXQjd6YWxaMHJJa1lsRmJDS0lsZmc1bEdh?=
 =?utf-8?B?enF6bXduMTI0TGt6RTNEK0ZjSVBwYk9uaFpTS01JZmkrZDdmWDA0ZGJqc1FB?=
 =?utf-8?B?OXhBQ2kwdDlSUDl0ekR0cnhFbUh6SDJJZXZzaWJ5d0FHU0pjMVAyZUo5UVVl?=
 =?utf-8?B?Z2RlLzVRaTBXVStWZFlwb2lldzJMYWdaLzNycmVsRDBvbUVqUzRvYzA4NFBp?=
 =?utf-8?B?STFUN1B0UVVuRlJBUUF0Ujc5SXhIejF5ZXc4ZVh1RGIzWHlhOEVJR0NSQ1Bv?=
 =?utf-8?B?ZHBMQzM1andpNG1SalJrU2RGR3paNWdrVXVzM3dwdTh3MnE2THhTd0RNYkVk?=
 =?utf-8?B?Vlh1emVBYm0rODFEQ1UycW5jWXRBaXRLYllUV2lIZ3pOd1NnRzN1SlpnWTFv?=
 =?utf-8?B?WXJJcmEvbnFFdTZEc1h5eWxSUUJwSDFrSm1qVWJhNmtTRFQ5Z21aYXdzMVdZ?=
 =?utf-8?B?R29UYXdubnhac0ZXQStBNnN3eTlocGR1U2hIRmV4N21RemVhL3UxbHhJbDJM?=
 =?utf-8?B?UitCQjlhbWZsT0xNVVV0M0RsSzJXejY3dEZuOFZtTlJBdHBLQWcvZDNBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZER3Z3R3U1pWMkpPRTg4bFRMcS9CSy9ZY2tucUk0c0loUVc1YWppTHRlaXZw?=
 =?utf-8?B?SmR5NFc1aXJEVXFNMkZDNlZDdkFrZGd1T1k5eE9rSkJnT0w0WVNzZnlKQWc1?=
 =?utf-8?B?QzVvS0duNHYxSS8raGJtbzdHQ2hZNE85aitPZlduT0dEdGREL0dpUFdqdkZl?=
 =?utf-8?B?U0FCTk5jbHdrV0ZVUndrUnRNNDB6VnBvNkozdWd1cUFUUEtrWk5zTWVJbklZ?=
 =?utf-8?B?RVJKb05IZ0J3VllyVWFtU0hqRHVYbmpDaGo2NjRZczRxMS9KT2VOSURPS0Jh?=
 =?utf-8?B?aTFndUdxV200YVk1RVhvVHRXNHluSVRLNGRoVVkvZ0VTTU1KdTJ0V0c1SlJP?=
 =?utf-8?B?ZEY4YStPNmNyaWZBeXFzWXQxRnVzRnpReXJ6OXlMa29RbFNDbGxIclk2Z3VQ?=
 =?utf-8?B?anFmWFJxMlR5MTNHVGI1S3MzK241aG9ia0t5MlptQU9Uamd6bjB3N25GTnVD?=
 =?utf-8?B?eGYxYkNUOGVrdW5BSEE3bm9iNzVQR2pQT3luckozWTdGTm81RTd0ZzRUcU1q?=
 =?utf-8?B?RzdFbTJka0Q4T2YzQ1J6S3ZOUlJRNzNVZDlaa2tKRG05bUpwcVFQUGVEU2Fy?=
 =?utf-8?B?SWQ5SFEyT3BxSFVSNFJXNjBjME91aFVqSlhBbWpIUi9IKzlvMXdSMVc3SkQw?=
 =?utf-8?B?SWpxaUxOVWtldFd3Q3kxSEJsY3FUMk9JTXN4bjNyQlRFcS9VTFEwSmdSN25h?=
 =?utf-8?B?T1J4dXMxUldpTlo1c3NlbjVXWVowN3k3NklROWdjY3dra3FYaGJCTXFsQ1RH?=
 =?utf-8?B?Z0k4azJIMTlobFcrRWxCdk41UFMwT1pseDhBNUhudngrWUhBd0w2Skx3T3B6?=
 =?utf-8?B?WFNKVGtzUE5RMlpoVE9PRTg4UnAxUVY3QS8yQ2gxTjFaUWxmL1lvaXNiZkRO?=
 =?utf-8?B?UWpHeEp0dzRyRmNmZG9CUXpZeEpqWGRjak5JN0VET1hpWjViZ2V5UEFzWnVP?=
 =?utf-8?B?NFJueUxXNDFqakwrc3M1Y0FWdm9DQ0F4SmMwOEYxQkNheDlpdDNSK1hSdCtG?=
 =?utf-8?B?bGFPandDckNMRkZNWXVPd005ZjUxTTQzMGRsUW5FVTVjRWZtajR5c2NjZHYz?=
 =?utf-8?B?and4OGJmWTFwcTY1QnRyTElRK0hqcEpYeXhUNCtvbWI5RlU3UitTVXVqUXZS?=
 =?utf-8?B?WjNJeU9wWUlYQ3V4VTRMU0pWNGQ0c1dUNTJVMjRvYmNxdTcyTCtnbXVybFE4?=
 =?utf-8?B?NjlISmZpNklYRDFIalg2cEJKajNGcTAwZE90aitZckU2QTdhSWlXTFMyczkr?=
 =?utf-8?B?T1ZaSUlGT1h5OG1xT1Zacnc0YTBFd0tVQTVRQmNXVndCTzE3YVFxazBMelpK?=
 =?utf-8?B?cVBXcS9OOWZmMVoxVjYvTGZUN2hyUlJqelhLL3ZpUkk5Mk5BMWhuRG5ZZEFK?=
 =?utf-8?B?ZVZEeVZpeHF3NkIzMU5Gdk9MNFNnTGhwSXhVdFpyaWdJL280NzBWRmdMZ1pC?=
 =?utf-8?B?bjlML3Q5OGlESGQxNmRLQysvOXZJVmMwUlZ4d3NNK2JmK1JpK0Q5NlR6NHJl?=
 =?utf-8?B?eWY3MThITVZHdlNXMlVkY3VuYUZwRUI2QjJtU1pBWjUvYXpiVWpxNTI2M1ND?=
 =?utf-8?B?SlVsRjE4VmgwQ21DWVk3ZnF1QWlidTAzMXg0MC9lNVFxaHpHcmt3VFlUZkhS?=
 =?utf-8?B?NzRwNWFyUll3R3JoVHRXUlR6Sll1bDZHdit1cnJLNjMyVCtBUkc5T0JhQnIz?=
 =?utf-8?B?SGZiQjBoMHFVNXgvYnRJMWZXRS94c3pDZzV5NDdUNVpMaitQYTZGakNSKzFh?=
 =?utf-8?Q?zgsNwFCmkMkpVfesyY=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a1fedb-c438-4e9b-ab32-08ddad61197b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 05:37:53.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB10986

 
> * ag/imap-send-resurrection (2025-06-09) 10 commits
>  - imap-send: fix minor mistakes in the logs
>  - imap-send: display the destination mailbox when sending a message
>  - imap-send: display port alongwith host when git credential is invoked
>  - imap-send: add ability to list the available folders
>  - imap-send: enable specifying the folder using the command line
>  - imap-send: add PLAIN authentication method to OpenSSL
>  - imap-send: add support for OAuth2.0 authentication
>  - imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
>  - imap-send: fix memory leak in case auth_cram_md5 fails
>  - imap-send: fix bug causing cfg->folder being set to NULL
> 
>  "git imap-send" has been broken for a long time, which has been
>  resurrected and then taught to talk OAuth2.0 etc.
> 
>  Will merge to 'next'?
>  source: <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

The message ID here doesn't seem to be the same as v18 here:

https://lore.kernel.org/git/PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM/T/#u

But the v18 has been added to the seen branch.
