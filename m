Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011036.outbound.protection.outlook.com [52.103.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF743208AD
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937065; cv=fail; b=owNxHNc9954bxd/oBR48m3Tqp+THE53eMCjCkdCWy2BytvfHImfbJYFCY35auvxw0svThX0I6HGAsTPlkoX3AhLWfZISHFo+IsOAXBCMcw2PiGDpp+jKJU8NRSWStG8aawsyIqniRBBY+3GbELjPng4UUWkwrvnKigW5hGQirFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937065; c=relaxed/simple;
	bh=90Y4zNlp3OBc+9XqybCSznxn7+YmbTg/P0bjWbngVZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6iz5SwkM8aGM5fJFa4y3pprme3G+mtYMNiix9/2o19WIOM/aBpNZSLDqka1i10NNSJgl75EieLshcCzIekrUOJb2+76KkhfnuopeT0A3wGdzBtE7gRpulQMlm12w6FKuyMiw5RgnSt/ICqr9pQnf2pZyyjE1jT38iHZOvZ27Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aWOu8SeB; arc=fail smtp.client-ip=52.103.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aWOu8SeB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJ3Xjb5B83TXtMH4JNl5gHaGlHXQ+eOhVzems8U+xMD91IynhYHzlO7B9Er0wXEg4AQIG5HyPMnfUJrDR0AE+vuaGHbeRWz5ihIx0wYrDgCmV33Y0/rZgTckx6A14AXrkkUkaskeJz8vG0b26MeyLmhOexm4pYAsYxGTwPBFjU160g5LtIH/xl07gxzU5VnhMrlmbEk5aoqXfh1yvtI55nnF6ycU+z2UlBkJcF7VlcKghDKlY0rFj/Eue/oSJIvEDPXPLR40ibZSyNoyGdrZGmDG/pUXFmNmcFbFHUvSh0jGYTU/fmz6Amhxc5ArZDtZIDWkMRYmOXfWq9MPTeTkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAtZaGgVR0QdCis/0Z8xv4O8EcBi1eVpXIAGqH1OHd4=;
 b=zGiZrKvLinsT46B6CXYZD+1rO8XnhlgG+rpm1ooe1/njbv9JwT2IGvufemouk0TyhNnHgsrL8VTyJu1eyFX+o9vQT5vp3onp5njODsQ4ZbVbi30nSpUJ1HMGTlOdgIhMBwj1NSX5Ank5FpQ+xhJ+vmYT242UFU6deOfwgSYC338u1yoQQfm2KW+cjYmUjgG/BgKqnor1etKNVHo3lh0hM1+6Id545eX42+h8/1GISLBTq/G04Rvy8ZmUGRCs0k5/iMQkg6pM7hGjxKwlCeeBSCK4W9cVky/p7VaErUu8VArB+ZA9D6UqENnMZsXVq3dxbDxhM2YN4pIZqv+mFtMG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAtZaGgVR0QdCis/0Z8xv4O8EcBi1eVpXIAGqH1OHd4=;
 b=aWOu8SeBbUGsJ9d5IbzbsWLfTL6x2SUf/81T8wI38Ykr++8UiJQ9CimI3v/QOugpa6leMY6AHz9DpdoVhHPjqErh1V+9hM1JFV/y9CVT8C4lwNcXsUUfCFCKusGpZpBYflf8EF7kXxGB/9H0QPKMbp88QIAyZOyS/nDXX3VB83RxNq+adTk3uyqTSH9u5t/tKBamBkcMVBm1rb6nsdfM5BasEf01VrYOMnedc9Oh57QZJMop/6E59MXZ+x5c7BP/140PL4UqaA2mrPZh3Uw6pI/sOYOXWuT1oQuIkbxlGv3EjQpArnZILspuTJEtrV6Ax9ztZ4GpObaE8LnEOl6GOg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9425.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 22 May
 2025 18:04:17 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 18:04:17 +0000
Message-ID:
 <PN3PR01MB95976C4FF54E09F369AB02EDB899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 23:34:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <58b3d0e2-0122-4db0-89f5-db09af3b543a@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: c7eb5d26-92a9-47e1-c1a7-08dd995b11b9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|461199028|7092599006|15080799009|19110799006|8060799009|5072599009|6090799003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEdOSFJiK3VkVW52bS9WNkw4bXEwOGlKSjNmNVFTbW5jR3dJUWtrUzhqcDUy?=
 =?utf-8?B?R0FCV2phdEpsMEpIYTFGWGNNbzc0a3U4ZXdOSUF1TWpKT29qZjUrMFJIUXJK?=
 =?utf-8?B?aE9ZTzhhQ0JPZjgxRjNmelRndW14VkhwS2ZkYlVTUHErNHJtWkVOSTVTYTQ0?=
 =?utf-8?B?a2Q4RWJPRmkwMUlZVjE2MFhMeGg1K0ZOdDNHK1BJNjVDdEZuL3M2SG5LaURj?=
 =?utf-8?B?Q2o2aldjTURCVGhxWmNXeTVYNSs2MVdDSzdkTjcwRmxVL1Q1ZmlXWUlKWG1S?=
 =?utf-8?B?WEYwVlhUNWc4VVVrYzR1eXk4bDVUb2NlWWFoclNrbzNveVY3VUlXOXppbG9H?=
 =?utf-8?B?anBPS3d0R0VBanlZRU5GbHNFSVBkRVpnS2s2b25QVk1xUU9zb1lWQzR3Mk04?=
 =?utf-8?B?bVh6U09qTWlOSDQ3RktuenpSUU53aThUQ1o0SjY2d3VYcjhvb1U5UjhWRlh5?=
 =?utf-8?B?Y2hHUm52Y3hvaklPb21aeGNNVEZZemVxdXdRWlFmcy9IdUR5d0hxSzZnQmZZ?=
 =?utf-8?B?UE1DVXZvditmbWZPaHE5NVVrdjJJMVNoT29GbUJqZXR4TWgyQlBnajg1K0lL?=
 =?utf-8?B?aUFxN0ZSWDdwR05EQ1I3eTQrV2VJTEgwSkYxTFJOK0Q4aVpKTWx0N1czUy92?=
 =?utf-8?B?bXJOamN1b3NLaVpGRXdFZHVpQWl4a0huZlhFZ1hZUnhRejlHODUrS2twb0hE?=
 =?utf-8?B?V0tRQ3pPZ2Q4d2Vhb0pYMTFuTysrSUpDblg4ZEVlOXc5R29wSU85U1NKRFdQ?=
 =?utf-8?B?OE01Uys5cXNXRHgvREtOUDNIM2E1ZEkxbVpqTS9wcExJZVlmQnFTa0VSclBT?=
 =?utf-8?B?Z0FFMVFmbFJWbndVUjJzT2twS3NoaytzTFI1OFB1QlpyeGhHY002eFRJUjRv?=
 =?utf-8?B?VmhHaDQ1b2pySjJOUlhjSi9iSEtPYU5mWll0NmNweERvNDAyOGdIOStDY3Av?=
 =?utf-8?B?WFZZV1J3RE9aSmpTYW03Yzl3VDhUeWJKTUZFc2N5WGtBVXpyencrdVU3VXcy?=
 =?utf-8?B?dUJ6VTBUN3VoeDhOZHE0bmo5TUtqanJIWlJBYi9NUHVLaGcxSHFBcWJraStK?=
 =?utf-8?B?Uzc2UmJrV3Jnd3hCaXQ1Um9ISGE4c3BWb3NPRnpCMXdjYmlWdGE2YkdSdjNn?=
 =?utf-8?B?c0dpSGc0bCtzaWYwOFVMVWowUXgxSmFmeTlWdXFtdmFqSHQ4TnpTMGZJaHg4?=
 =?utf-8?B?UHBLUExTeEhGOXM0cVM2VEt5UnlVdjFOOW9WRU5WZ3dibFIyTElBZVhBQWFI?=
 =?utf-8?B?T1dsb01ja1NTUmNmbkRzWmFCSS9hYnh6SGZnYi9TTWVRd1NzS2RkOWVPR04w?=
 =?utf-8?B?NDl5SHl0WkVxenBCU2x0SkVLZEdrcFJYbEpHakZaUVJMUElsNE5SWXo0ankv?=
 =?utf-8?B?SnlwZTZ6K2J5Y0ZYQTZQckV5aFlmNDZwRE5yaDhpVUN4b3cweTZLWGlOVDMw?=
 =?utf-8?B?SnFxbWpVM0xTZnUyTmQ0aFhEVmJSNVZ0bFUrTnh6WEh0c2ZVdnByNklacVpz?=
 =?utf-8?B?MFMzR0x1bEJ2cm9kU0lKVzg4UU9ZUWNGU1Ntalh1T1oxTUdFeStNbUhma2NW?=
 =?utf-8?B?d09RR1VDNERiVUlrSGdrdmg2clJkWEVJY2VjaE1pWnB1MFhIclExbXpob2Fo?=
 =?utf-8?B?MGJiOTdnemtKdmFXeXRSbTQ5cmxhdnc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFc5bVJNd3lHVHF3WEdBaGdkelVMTXczUFNCSG9BdVJZL2k1bFVwbXJ3dUxh?=
 =?utf-8?B?bWdWd0lRTm42djJGaElTdUpFS3B2bzFoWkk0bEZzYXpjSDRmVDAyQVRaSkNQ?=
 =?utf-8?B?ZWM1WGpUemFVajZXdzEzZVFXZDlFbWxmNEZsczBwbWNqbDJ2Nmoyd3J2TkF2?=
 =?utf-8?B?TnY4VXArUUhUZGhxYXhqWTM4eGxsWFNrSGw2aHpzckFJb1ZSd0JiZTdaTzlv?=
 =?utf-8?B?L2lnL0hTcVlkMEFEOXpzOEFYQURBM1d3TTZFU1gwQWZNR1FkSnd3dTE2Q0No?=
 =?utf-8?B?OGFtUEF6Yi90OUlPZEFXUDc3RkR3b05XUEJ1YlNLVHQ2cXVmSnhFeVcwbFJ5?=
 =?utf-8?B?K0FKejJseHkzc0kreVRNSHlyRHVZZE9rU1VkbnRwU0xVdnBzV1FpUHNZcnVy?=
 =?utf-8?B?UkJqUjZSUmtsL2dPcXc3aFVFcCtYWGVkWldkaWtoQkorbnJPUmdkRGFuRGdl?=
 =?utf-8?B?ckkyVk5SOFN5cUJYM2FmenhmT3h2dlFWKzFKcmtjbERmZ3N5NUE4UkZPZFhh?=
 =?utf-8?B?cit4disydWxaTGlTNnQ5Rm1wSUlMNVR5R1JxWlF3S2JCclR5K1hNTWpMVlp2?=
 =?utf-8?B?KzQ1SmNyWUNremNuUWNWWnQ2WUVwUXFudkpHd25kMTAxOTRCOVlHM3Y5YXpp?=
 =?utf-8?B?NjlsbHJJSTRRcEpGbzlDNFp0dGVLQitvN0JFYUtCMFNOZEc3RXMrdUMxek5G?=
 =?utf-8?B?QmhBMTczSDBWcFZBSVltcHNocmZUQ1htSnBpNXA4bFowZlh2d0d3aWlzQ2ls?=
 =?utf-8?B?YjdhbU9qVkJza3lJS3BmU3Jvbk1peFNpeUVORnNkVEZvWXZaSXJ2WHlGRjlJ?=
 =?utf-8?B?YUVVaExhcGhLZElBZDZDT3EyaWJPWU1DOWozL01FMERPWEltQ3FWY0M2TmVp?=
 =?utf-8?B?T1RQcWxXQW1BV3lZT01hc3lDcm9sdllnZUlyQWt0dHJOaWtIalJhcXEwUFgv?=
 =?utf-8?B?dDlNMHZWVjhWa1NTZlVLR1BZYlJTMVlXWmxnSzhqZ1VMajZvdFhVT094bmh0?=
 =?utf-8?B?anJWOFJ4c01xNW0vRHZGRFl5SmR4aEExY3hxODc4SW5wM0VTdWFQNTJCWWp0?=
 =?utf-8?B?OFJKRUN6akozT3FIL0dCK2VlVk82VXAySHBDQ1ZxSWcyb1FIazVPSFhFWUdP?=
 =?utf-8?B?T3Z2emZxS01RZ2c4QWNTNG1hMjNKWkhaSjF5S3B4cHR1UGpmVStmQ3FGZjJL?=
 =?utf-8?B?d1dHaERGSTRHZW85S3hQaG8rNEY5WXpGZmZQVU54NGYwQ2lqUE1wTDlBNVZt?=
 =?utf-8?B?MCtwRkZJQ3djOUUvYUxzZjVHaE9sV2xoaFNsZ2duYkpHaXNuZ29VZ1BtUjNX?=
 =?utf-8?B?UnVMNmVaOFZtSDY4cHpVRWNYVXlUYlc5Q2xNQy8ycE8rOVFvZjZ6bnJDdzVa?=
 =?utf-8?B?bm0yb29HWGZxTUEyb1NUTW5QbDZOK1VNaHNjM1dDeW1Db01FdktIaktSYjFm?=
 =?utf-8?B?MXFUL245RThYb3JUMDhoMjQ1RlpEQ2l2cGowam1kV3hsM3NRZVliK1hhWHZQ?=
 =?utf-8?B?TkR6YU5XT2hPbHN0UHUybDBhZkEzNkJ6WFp4NExLaE5pd1BnNi92WFg3N0hm?=
 =?utf-8?B?N3dZaVdsU0pkQUJUTGR0VCtIcWZKS0lyK0YxNjBMUVBJbm91UHhrc2JWejVR?=
 =?utf-8?B?Z0NXOHk5NjlTY1BSWFoycWRUdnJraklGRFQ5TlUrMUxxUk5uSll4aEw4bXNk?=
 =?utf-8?B?ZzZ4MjZabGdqNlpEQWtCU29RbUpaNG9tcU1GbE5hbmxvM1hicFRWdXBPK0Uy?=
 =?utf-8?Q?YfvS43MRqVVIh/OFPU=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eb5d26-92a9-47e1-c1a7-08dd995b11b9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 18:04:17.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9425



On 22-05-2025 11:30 pm, Eric Sunshine wrote:
> On Thu, May 22, 2025 at 1:29 PM Aditya Garg <gargaditya08@live.com> wrote:
>> Upon setting up imap-send config file, I encountered the very first bug.
>> An error showing "no imap store specified" was being displayed on the
>> terminal. Upon investigating further, in static int git_imap_config,
>> cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
>> imap.tunnel and imap.authmethod were defined, and the values that these configs
>> intended to set were not being set at all. Because of this, git imap-send was
>> basically not usable at all. The bug seems to be there for quite a while, and
>> has not yet been detected, likely due to better options like git send-email
>> being available.
>>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>> diff --git a/imap-send.c b/imap-send.c
>> @@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
>>                 FREE_AND_NULL(cfg->folder);
>>                 return git_config_string(&cfg->folder, var, val);
>>         } else if (!strcmp("imap.user", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->user);
>>                 return git_config_string(&cfg->user, var, val);
>>         } else if (!strcmp("imap.pass", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->pass);
>>                 return git_config_string(&cfg->pass, var, val);
>>         } else if (!strcmp("imap.tunnel", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->tunnel);
>>                 return git_config_string(&cfg->tunnel, var, val);
>>         } else if (!strcmp("imap.authmethod", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->auth_method);
>>                 return git_config_string(&cfg->auth_method, var, val);
> 
> Okay, makes sense. It might be worth mentioning in the commit message
> that these copy/paste bugs were introduced by 6d1f198f34 (imap-send:
> fix leaking memory in `imap_server_conf`, 2024-06-07).

Thanks, I was wondering what commit brought this bug in the first place.

> Squinting at the code a bit more, am I correct in thinking that
> 6d1f198f34 missed a case and that the function is still leaking
> `cfg->host` in the "imap.host" conditional? I haven't traced the code
> or all the callers, but I wonder if server_fill_credential() in the
> same file may also be leaky. In any event, the `cfg->host` and the
> possible server_fill_credential() leaks are outside the scope of this
> bug-fix patch.

While they are outside the scope, in case I am able to get them fixed,
I can sent another patch for the same.

