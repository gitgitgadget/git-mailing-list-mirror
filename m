Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911619E83C
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936799; cv=fail; b=FDoUaHmThwFRMPRmgfgxA1dAtdCpn5GlzdGYrNt2FlmpZObCZrLKFvLdB1GCyG9tI5wOhYfzs1T4NovRa7FsmHytLJytzUW1eRDDq2y0ARDMfq/yJs/Yop39z4ubU7nQQh26SGy7zKTsaunMkcVAZyN1fahxcNi4bn7o4ikJ8pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936799; c=relaxed/simple;
	bh=KppSwteMAfVdgK83j8MzR3tvGt8mS+R+2KBOvlJnOg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NU2+JyH/4BcU86jAa1fdpqrl7uibn0H0tkyzlt5PXtnKIzNzWdugP7dLZeGJkjBisf6B8uN4lV4RebOu7Z0UIY/GvYmn7esG5SGposYqH7nhF3mRXA55juxUfsilz6a/3Qem2fV6X5jKMfDJM3soj8x+pwZYT7v9BVsA2ox7LtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IuZjBKfJ; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IuZjBKfJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBMfG4kfAixMaFSvanw1VvPT2Jg+xoTseYJzX+/9GrKpcBfppsMdWHHD+g4S2nZMwZP4vyOnESBK4/WAzvzWpWhh1vjjacssaVdk2b6amEosmhv2K/mImeBDk+43P/lWVfXlIF2KO1/32fQwya+FCKM9F6R8KEdNqClSBpb4PSkIm8wfqGAd4rsmADMkwIy7rmXxZnPPXqZceGsgmAUpB3Ns1MNDX94wdnvMnrlDzY0ROeoGJru/ZJIU1GuB06Im1lkCyR7zNWcfkCXiXlFls+TDAYM2BEyrhcWTPD/l0vjad4Nsj3+C/2P68sktljDgPYn+PCtoPCpWFBeK1lfj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbfr5oiAAEJSaHEV0zjKociftEj2S2nu/Ed2Ve7I8i0=;
 b=Gb10a36FF9k/rGb7XjJhWB6brb0rwJ799Xwv9f/yCF9Dx/7KZ8/advfEEMglrvCJNxKFnIwX/Ukde+ZDowRPIqjIpxNsXghJ1BWaKhgKRQkZ99UiE3U7wryEJnHsCLP7RAUyt/gLGwRwq1QE9Hkf9LVMj47k1WEtAoEfIAXjusC9lL6ZgkRPhKVGh6c0z71WbXgd/ivOJYVVSnm4PWleDTKUysNyAMbvz3zrDurMD3NEugiTtNzUbnYUF/hBhCewqoIw8Rh7qLfNpVaBjawuXpGdBJ2BykcV0jdZJMWjBRnR0Lbz9mc9BPaM2lDlfTn4D1zogvmNn5lEcrreQ2vJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbfr5oiAAEJSaHEV0zjKociftEj2S2nu/Ed2Ve7I8i0=;
 b=IuZjBKfJcAc9VX6G6qvVXkps9FjL0KcXrgRKzmIVosbFQfnK1f4Ujh67eBz3IO707F82Tes28ZNiAg+k4XoOKXgoqxFNnVT7qAgoCHoakV5EcHCV2rt/wHPv5q0iJv8mnxDxuzgtLRkHs1su/q+yAg1xfG64aFb6Q3RRu9KTyAhQeydDT9p7QgpkwLuYeBTwEkiJk7tg75wioTt4YXMujLNzlLlxVutuNpMeKNm1gn49f0654WN6wI2wLgkrMx1NZpUbBmLtGWrXml1MGLk1WoHcwL7PPeHXKUu5C+/9lCT3p6P3heWCEfKZKsUkgP1QU4IhCnEzFvZ/NdF028tJIQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7450.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:59:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 17:59:54 +0000
Message-ID:
 <PN3PR01MB9597940EFDC160CF7DB2F53AB899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 23:29:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Add git imap-get-recipients command
To: Emily Shaffer <nasamuffin@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikltaghp.fsf@gitster.g>
 <PN3PR01MB9597F61508C56A33136B3844B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAJoAoZm_fsfhq2gD4JVCihf5do-+CurFRBfw8PX8-0QbSKk-VA@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAJoAoZm_fsfhq2gD4JVCihf5do-+CurFRBfw8PX8-0QbSKk-VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017F.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4f) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <b1046fef-ac2e-43c1-b0e3-8d5a15e13e95@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNXPR01MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea336e6-f6e4-4206-5a7a-08dd995a748f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799009|7092599006|15080799009|19110799006|6090799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlgrRWUrbEVSa3BnUy9BTE4ydlBjbmZhZ0VleG5NVVhDNEVmN2tZSG10d1Q5?=
 =?utf-8?B?V2I4VFJHTHozeSs5eXNWaVVsejRXallrcGp4UWVpZlpQcTdzQVdCQ3JxKy94?=
 =?utf-8?B?REp4WW9mUS9xaFlQT3lieDU3bzQza0ZTT3QrdERqL3hnZ1ZwZlNlUzVtQTY3?=
 =?utf-8?B?amU5cFVuVzBJKzNrdlowejlKNTE3dTFOcUlVVGdUTDdQSDRxVVJwUmVQN1FO?=
 =?utf-8?B?MGpsNnlFTXFHcUs3SEV6cUw3azc1Tlc3anZ6eEprc00xcTJGck5vS05Hc2E4?=
 =?utf-8?B?NzdPL2poeUNlWjNpWXRTT1ZITWt4eXZkWTh5TzBKeUFidHl1eUpwNTRWemFE?=
 =?utf-8?B?c0t6NVdaWWZmc21xOGVMOWFxUGVFU0cyT1dCVURNUTM3ckk5bHZlVzY3blBl?=
 =?utf-8?B?Q3k1aUNEbTJGbzJUM20vRHBZek5SNGdxNlRWNW9LazVIUUpWc3NoZ3BsbUdS?=
 =?utf-8?B?U1NBNWxlUjZDc2ZaTGVJQjhVMmcwNEN2aGZDTmg5UU5sc3Ard2NvNEZLaFh5?=
 =?utf-8?B?NnZLNHVXYk8rVlk5UXc0NG43VTBwWFVEVlZkK212M0pZaW5KTU5jZHBjZXRm?=
 =?utf-8?B?dWpOSWpyOXpvYXJMY0RVbVlIdUo5YjFXN1cvdktVdkQ2RktnZmZKU2pkakpv?=
 =?utf-8?B?VmtMVjZIWUpYcXNJTmhWVlFubGhraDVCdWNDSlhHVWNla0N6YkRhc1N4Tm5v?=
 =?utf-8?B?ZGorRnFwR1Nya1RwTitFVTI5Q2ZKSm9XS25WYmdqUzF1aUt0YnFxODRadHh2?=
 =?utf-8?B?Ri9YbGoxbHlNeG1kSHhvcklSVHBoTllNdFd1WUhJamlLNVc5UjR6eFhTdHZM?=
 =?utf-8?B?RExLK3p0VzhLWThNTmgrRXREOFFibUFOOUMwZGQvQUhFaVJ1bHJHYktsOEho?=
 =?utf-8?B?RW8xc29XVC9LNGE0VXNLaUVUNUxlVGx4UnM1WjFpZ2FiT2c1dVlrWnNKNEJJ?=
 =?utf-8?B?VGxSMGhTTzNvVXc4T2ZTdEZYYzNsTDZFQy8xSkpGQzEwOTdrVHphQXdqVjg3?=
 =?utf-8?B?K1FYbFFUaytjdHgzY2F2aHVjOE1oYWRoWkc3MUZmMEw1elN6RE43dmt1Rk96?=
 =?utf-8?B?RmM4K2JYN1Jad3piSGpVaVdhdm44NURzK3pueSthZUQ0VGUxV0M1WFlOUGV1?=
 =?utf-8?B?WDNmK2gwdUlSdWlqbXN5Vnd1STczZzA4UEQ4M1F1NkMwaXdseVBpTGRTNTAy?=
 =?utf-8?B?Y0RKVVJiRndnZ05KV0FlbmVSeHRzYkVuQjJkanpEYnlnLzJyckx6cXB1Wi8v?=
 =?utf-8?B?cHFPS1hRVWF5OXJGd2FURDVaejNpdTF1emRUSmgvS1Z1ZnlmRkYvVW1ya0ZL?=
 =?utf-8?B?d2g1ckRYaDdnTWhaRlRIWDdXNkpnY3E0QXBST2s5VzgybUJJR1JmSEZPdHZW?=
 =?utf-8?B?MDVJYW5GZ1R2S2hlSmFHZGFPWVAwREJlcDhNWUVoV0p0VWpnSGxCL1MvS1Z5?=
 =?utf-8?B?MHJUY3RzVjdzODdHTnQzVldLN0tNZFpoMi9OTnpEK1Y3aFpudllFRVBtVjc4?=
 =?utf-8?B?cUlyaXFjQStvcUswMWRKWlJUM0U0N2VSNlBWQVRvbnQ1UHNJVGVvOXdvYzMx?=
 =?utf-8?B?VWs4dz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZkRGRhQXZtMGdobW02dXVnNXp3Q1ZhKzlPdTBubkN1dWFEdWhIUFV4OUty?=
 =?utf-8?B?TzNjWFFjb3VXRi83Y3pBL1hzaUJST2lrTE8veU5Mb3VSVkhoMDRlZHc5WXQy?=
 =?utf-8?B?S251anJXTkNwMm1abXJQSzArM2VQYmdvVE52ejQ3SU5OTXd5YUcweS9XQnQv?=
 =?utf-8?B?QTV6VFJLbUxMUm1aSXpHTk9hNFdXYm1uRzR4RE5tU3dmMmpRTkdueGRVS3Jp?=
 =?utf-8?B?cmorZEhSSlJzZXBWL2Zna0pVYTloQmdWYzZzNlhTQmR2UW1SRml4cEZ0NDRj?=
 =?utf-8?B?Zk15YnB5U0RkN1RCWU1PVmE3VFgrTnRoNk9jT2tZTkdHZzVRQ3lhc0h2Q1lP?=
 =?utf-8?B?azh6WWdqdUJySnBhVVZwbnAzL3A1S1dxYTB2R2gzZnE1OVVsaDVLT2tKRU56?=
 =?utf-8?B?MStiRFNXc244eHdwZWRtVmNzSDhvL3l2NkVHSEpoMWF1OURYRVZwMXRackpH?=
 =?utf-8?B?VGpRdDc1RGE3TllvWElydHhFTU1iSjREREUrd05UTHRXYWdob3FRZHhYK203?=
 =?utf-8?B?Z2ZnU1NKY3V3Zzc1UDI3S0lyWEpOOHFEdWsvSWdkTzJxMldhMUk2cEUzY3ht?=
 =?utf-8?B?VlNFRUkrV1A0R0ZxbWV5dmdURUpCK2hyTDJxUGt3MktBbEpZdS9BZ0d1ODMz?=
 =?utf-8?B?SWdHcXlubkdjQlpiRXNXTm5tdVVlZGNnS0U5Qm9BWTBYc2l4ZzhNQmlIWEcy?=
 =?utf-8?B?YjVMdE9jNDlhblpuS01WbHFJdURZU25pWWNxRm90cGYyTVI4NVRPUTdLc2dI?=
 =?utf-8?B?cWYyVytHVWlpR1hFZ1ZHSEhxMUlTVFNNQzNwUUlHcG92NWh6THorVGpOMGdm?=
 =?utf-8?B?Y0g0dGJ1eVd4STZXSlVOV21TNHkwbTFBOVN1dU5GRlUzSzhseTVpVGlQRVFS?=
 =?utf-8?B?NlVnSzBKQjJtVUU0RmxJbTNhQXJZZ1Bjb3R4SzllUW1ndXNOSWlXc2NzajRn?=
 =?utf-8?B?RE4rM2FVbm5NcXdIRm85aTNTbTFYS1NTSXRoa3I1NjVBcWx1bS9GSDZuditO?=
 =?utf-8?B?N1krWm94bHd2SzgrVTNib0w3a3NFVERKS09qcDF2Tml6WWtoMUZycjZNVmlE?=
 =?utf-8?B?RStaekRnSHc3V1U3THoxcENpa1JZOUVnVGJ6cXVWSjVzM2RaZVhNbTF6SDNj?=
 =?utf-8?B?N1Qxb3BnazFWeG5KdkU0S3RPQ2lsL2k1TGliUVpwYkxHeE1IT2lyMVYwTitw?=
 =?utf-8?B?WHhOS3NKYjVqTm1ueit1SDBZNTJ4NFZJdUZSUWRpRFV1RWF1MkNIc0YwQmIz?=
 =?utf-8?B?NlpOZGhZRERBTThtc3Y5YWl0TFFESjR4YitXUXVIVE1IL0Jjd1RPelpWdng3?=
 =?utf-8?B?ajlvaDNubHp1UTBwSHJSV3lWalZ5a1cyS1NjNWtXS3ZwTVFRYnFWcVNSWUFx?=
 =?utf-8?B?UmFaMlZ3ajNpVFVzY0RCUjVtTWlzR1BFV09nVkdhdWsvZ1JoTmp4TlpBVHpn?=
 =?utf-8?B?MTJkUTBVUnN4VnI0SThUNTVSOThrMktLY201RUwvczg2Yi9KeXdLTndnOWpR?=
 =?utf-8?B?TmVKTE9wcFJFaHc1MGR0REg1TUdlc2YxYzhEY2JWMjFVSzNPVXFoRlc2OGs2?=
 =?utf-8?B?WjlaV0tWZHV3NTB3UGhhM3VDOTRhQithRWxCSU5UdzJwYndYY1FKbjdVcnZH?=
 =?utf-8?B?Y21uSFk3K1VEK1g5YTlXVjIvOGlpVjNUZ1JQSDMyVUFzMUhybFdjNXV0eVFR?=
 =?utf-8?B?SnlIa0RrUFBFWjRLRnhkV01vSFZ5NjY2TWxnMXVDRWxjUHhGNjR5VjEwZEk5?=
 =?utf-8?Q?QYVsWMbhUwohRl+oDI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea336e6-f6e4-4206-5a7a-08dd995a748f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:59:54.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7450

> I actually don't think this is the point Junio was trying to make -
> rather that you should not need to feel like you have to ask for our
> permission to write this tool which can also stand alone and improve
> your own workflow. Rather, if you do write it and you find it useful,
> it'd be cool to see it sent to the mailing list alongside a cover
> letter like "would anybody else find value in this? It improved my
> workflow because <measurements/reasons>".
> 
> Definitely I don't believe Junio's point was "don't send us this
> patch, I don't care" - but rather "how do we know we care until we see
> how you've implemented it". (One reinforcement here is his question
> about where the Cc list is being queried from; local mbox vs. b4 vs.
> using a direct clone from lore.kernel.org would definitely change who
> this workflow will work well for.)

My interpretation for Junio's comments were the same as your's. No hard
feelings here.

But, at the same time, Junio also said this:

"FWIW, if you're only duplicating the To/Cc list of the previous
round, then I do not need it, and I do not want to see anybody,
including you, to be using it.  To come up with a list of To/Cc
addresses to use in v2, you should start from those who commented on
v1, in addition to To/Cc used in v1, and then whittle it down."

Which is exactly what I was doing here :). And now that I think about
it, it does make sense.
