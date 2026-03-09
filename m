Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010023.outbound.protection.outlook.com [52.103.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F85191F91
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022314; cv=fail; b=Ep0USrrz7UTV3myel/j2ZZd3fvF/0nyMISkJ84913j+m4CsgrxKycX24WWG8JTAKEvelIDx4WGAlL1aNdH3IH2AbAXAlixBuaproZH9C9/UcpiHCr91xmCnHSrsiabWiQOMsrEoERPh4xiXNwIw2anekcThVOMQjUo60FZEWH1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022314; c=relaxed/simple;
	bh=cvp5exsj2L5EBJ5A5jPcaZDSYmA7nbsNv9wnKaOoaF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RX7nhjOXYjDXGz3iKmvVRQ6QE6m83LWlfU3xpAtXBhVpEXawc8xwlvgzk7Uscj7QgXr+crxKGfj7H6ZqaPCpRaCO5f/CXcUaRWe5wdPJm6nCn18+EKoXLnbro5R4dtWhic7+E/DYxv4BazzZb7qOMM8F0HYHA38DnyYloEfe+3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j96ZFpSU; arc=fail smtp.client-ip=52.103.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j96ZFpSU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCu0f6z8xnkVpSxajNA768P0NGsfiSdl+sXgs+T8HYIsBKr3lxzCRnYKBTBhyDC0xxAX46kVJZofRGUH12mXi25G1ZbSkGzAb9XiHkDyn82HrQGoBuSdNdNu/bGWg3MZg+5YjQsQybpuYo088MAEF8ag1kuhG7U5PlAPfyioWspE5qHLH1ErnH6lPEfYjUctFDZKMLNWkagKH/SHsi+BB3KWh7StJ0+bIFpWDIE94ltyQdMSzfbc3kwH3tz1KSMgz89NV+Jw1nlgzh6pnb0APO6f/q3eDLI1uNSvSfBmyMOftZKN3sBN9NIgg5bL7fYFxqfli3i4LJLgYqrHXmU4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGKg6Bq/jgxwCScaFtEpo8zKMcweeZznYajQxWHy+m0=;
 b=iBC2xFRtT5E14747P2cLVFPHdWqRlVV61u1XGuUoxjaNEnX4M2AbS70/T7Qi5Cf2AtE8zeGVYnIoKOq8t7U5xVCgL0bIGEgttWDIbTVBay7k+lhwm5Bi2xRbxb4T00hivG+Lo6rKQiZdXjHVYskjfgppMTqNUxdyrrfiytFqWuo3n6R9tkatOHpoeC8GHZARfxdFKmTpbbnoQoit7PE11Z68PcBVfS7GumJx1BDZ4ZVHWnrslH3jwRKK9yIikBVQFFMgFRWYTAMoWRpj5iCX2XkKnZksicNhPnaeeW3vaYgx5I4pAX/xyMxYwePrAqhZ0Y40+pVy5S1h4o45Yertlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGKg6Bq/jgxwCScaFtEpo8zKMcweeZznYajQxWHy+m0=;
 b=j96ZFpSUtaIQIZwLJOLX63SYoHYZnVi93+F4HWAcIYP6b9AQ2TTDlqrx1OBC8H16GGmLCBBeh3nq3TBqLlmSnYHAV47ocjlcz6tpbgFlFRJCNvnAGADxrHCsSBeL0wSJBqv9lvaxmk/nl3leAJJy8ZEHXbrFneYNAtlyeKSZWBmAVXWzYyt3O7tqhgmDw3CaQpTsioufuSIM5EHtxSmVPECXJRaurjU8gk60yFmLWndpXFPWQLjCEK7fb8WwcvE74c9tHNeGMuUrT+++mcoQAK4sPxGHwNLl8aOKDNWOz3d9Cl/hIRxGYzu5L8an8dcvLWNdURBiqoraO0x8xeudUw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0689.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 02:11:50 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 02:11:50 +0000
Date: Mon, 9 Mar 2026 11:11:45 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] parseopt: autocorrect mistyped subcommands
Message-ID:
 <SY0P300MB0801336282FC2BB0FED45085CE79A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08010BFD00AA7C73503D8B92CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqo6kx98bi.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6kx98bi.fsf@gitster.g>
X-ClientProxiedBy: TYCP286CA0361.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::17) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <aa4sYQhROzGFGhvx@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0689:EE_
X-MS-Office365-Filtering-Correlation-Id: c13ff9aa-2d40-4c91-6632-08de7d81392c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799012|8060799015|23021999003|19110799012|12121999013|6090799003|25031999004|51005399006|5072599009|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zwXDNlrj4XEUNSSFUVVh/S6PCM713WxFSsr0OFI8BENqh27Q6AoW/1MPbaq7?=
 =?us-ascii?Q?mSNfRfH8cmGh7zBVoX6RKM19jnNY4ZmMGtHvx1AeJA2kfKfDoyxL+dhSauyF?=
 =?us-ascii?Q?+W1PGitLCEHI9X/kMHLhVg1ih/RdVJb7kEJHJlPvjMymO34E2NgU4Ppcq/GS?=
 =?us-ascii?Q?WIArN8JFJdwJBY3//n8C366OGbH7mhQ5lojMWCTOWlH05k7Y1YsHEZMTAPOk?=
 =?us-ascii?Q?acfhnZROobJ2IO3dXhNL5LAir4AmEFq1Lb2n518Zprs2lXnwCgbITajomatz?=
 =?us-ascii?Q?QJz5Pj6Y1yrLj9zQGZXKquPFDubghD9pZDXyONPY1dcRIFOpEwikJP800hZG?=
 =?us-ascii?Q?0Ak1rDIWee47oqbjZtzReGdgfDVzxbIzUG0UviBqVXFof+IKFshDt0q/e/1r?=
 =?us-ascii?Q?rkKKf08mNRhX1zQtZlQHQ5vIWVh91/XrByp1NFpWehEVQWks1WsP/QAYYXcK?=
 =?us-ascii?Q?N4Gef0FWYP5e0+dGWFvtelkxT5hZi6b2kFb9dbIxsLoCyGWE4GPKiyVdQGpz?=
 =?us-ascii?Q?KPSP7uv2ekAz6UUaHjaCeJsGMEb/5sEadaDG8SCVgo/H1lRNNzM2BCn52df2?=
 =?us-ascii?Q?EWy1JGDTYDe03za7ceniTaSiBX4AekzE6taChD2vQIMRTRh+CgMQJbFbsJWu?=
 =?us-ascii?Q?ocCW0xEcWStoDGuonkeSDcK68gXiy4QH9T8/5FUM9e6q5gN1Ahj8WWQUwUPt?=
 =?us-ascii?Q?1RKrDZsS39JSW5R2XPWPtIUH4pPamK4dpA/EDWvw0X+dn7vj2cv3/vULBffN?=
 =?us-ascii?Q?iyyjH0twYrzWq27I7umseSfpeRpJvU9b7w+wEYCD0xPI7Eo8ZwcuETcstNmp?=
 =?us-ascii?Q?qWMYnmRUxhdsjRBilmDn5gooO6jBq8/IBhUiwxX3mQAitkgwXoiKzNIS4PV5?=
 =?us-ascii?Q?XwIlWZTVkfZ5QpKzEGtpvXmAXTE2z7+PMY/2PM0/fVpthSZM5GpVns1Nhc4Z?=
 =?us-ascii?Q?FwIYrBdDnjIIIhAnbmW2zKnNIgitKePOgYg2sU/euJZzIqZRScFaBoCnu6Eo?=
 =?us-ascii?Q?rtFd?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2Qu1iRiVjorEhUn0e/tonShrDmSSYAzfmZD3EvmI+k3GqqCrccKein9Br2w?=
 =?us-ascii?Q?7YeG2tHSZxoKoA3E3nNu4BtxHjz4rTCzK0b0/Y/xSHI8fOhyo0k2/ZZ2qyIb?=
 =?us-ascii?Q?Okzdbed0s7iLfJ2GVXuEZJkIJ/9ZE/wZy1DcWBfg5jjxds5zijcqTVHaLZuf?=
 =?us-ascii?Q?CXUe1yvW3alfOQdHE9iIdr32ag8WjmScrjwzkyeEHAKp4Y6oKuCaefmDK/Gc?=
 =?us-ascii?Q?qTdw1IkiQymevm6CECtYLyAxxou28ufYeOt0TewmDqsmsI9DLLRBDdfD4qI5?=
 =?us-ascii?Q?ngO7op1/DZ6tSFyO2U+eJVUc7ZKQ3DuUppOzgPESP8zaZVnIXYISNXKZq3Sd?=
 =?us-ascii?Q?1kq/qDTWpTG5YTJ8ae3hgUF0Il4umNjZgMn/UVQ5aOd1t+FmStMUhh+h01c0?=
 =?us-ascii?Q?WNyCc9QkSpP0/kZ3ii4Nxn3iqpXNQg9lKqcwIGk0l63TRd6NeJTLFfqrO6LG?=
 =?us-ascii?Q?jtzr3djZQXmRJww8kSQLK5a8Mzv7C7xur1KwzwoUioV9oQFkh2jnWfokHXaq?=
 =?us-ascii?Q?Iz1SuFi1+eTMNlCKo5rLPV6ISQ1BLbNEfLtGI+uhRrv/DkNmJVeLBFWVtI3i?=
 =?us-ascii?Q?18imwdVeL4XIWbjQ+5lPewc6f7oh3fvoBd7/vpwSCJwIt5bBmNJJSyNB7z1J?=
 =?us-ascii?Q?chh9N/VxeWTuzHCUzMkV4hKOtYIEHywQcRK6lPTGQhcats/7+3/nvjiqu/gB?=
 =?us-ascii?Q?978KFpX1V5AdCBvF/sTK5eWC9Qp/4y+iZQ/CiqYRg93ZjXGLyRFqxrWgQdrP?=
 =?us-ascii?Q?N9QrBc1SbclHSQPOxZwMZqeesbkmKjutnkINayDakOctoNyyTh9CB/2SzyLq?=
 =?us-ascii?Q?34hLhzQ4WsHHw7XiewdNsfN/YHlygWQ3x7xyJse+W8NIMhzUrJceavULDnTE?=
 =?us-ascii?Q?6JcZ3BEv2WBkLrpcF4shPExPRBkArcOJsGzbtkW9G5z9SlIVrO7UrxFIUSTs?=
 =?us-ascii?Q?qw4PZLI7YTSJ8D7AQnl6yvrOlsxJimIQVzZJx6vyQuz7jYlfWkhAJ7zh23Z0?=
 =?us-ascii?Q?X+LduU3AjWQ1EUswC4BRbKrWxeHAxB4mGtuNGCjn5oMn4JXJ7sTSdJP7h85C?=
 =?us-ascii?Q?OJgzt/zs2u39CG/mSYZDuvS3T39OwJjt2viXJmOeXxeLJA8ItIBSpGRxfAq4?=
 =?us-ascii?Q?udKUL36rQPObwReuW7GGmaqIV/Mg470SGN92PGCRZn0pS2GB5s0SQRz3xVrH?=
 =?us-ascii?Q?xneIlAU8wjY33a5acIrb3/5iapFk539VSWnYKCSPTAdk9F0FCnGzTQC/TbJC?=
 =?us-ascii?Q?MoamHlG1W84RXFMCH5XFkISVzHwYswOYDKhXj9Y6BdI83uL1L54utaVA2vSV?=
 =?us-ascii?Q?6p8HhqsWjbssGp9gy77LJCqawiScb/J9ZaPL/RjeVyMGHfArhBDLZkZaKYWm?=
 =?us-ascii?Q?mScpkSGztCV2mMsEPQSRZqrAh2gJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13ff9aa-2d40-4c91-6632-08de7d81392c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 02:11:49.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0689

On Sun, Mar 08, 2026 at 05:04:49PM -0700, Junio C Hamano wrote:
> > +	unsigned int min = -1;
> > +	unsigned int ties = 0;
> > +	struct string_list_item *cand;
> > +	struct string_list_item *best = NULL;
> 
> CodingGuidelines: -Wdeclaration-after-statement is here.

Will fix that to follow CodingGuidelines.

> Using "-1" as "the maximum value this unsigned type can represent"
> is somewhat misleading.  Can't we avoid that?
>

Yes, UINT_MAX is a better fit here.

-- 
Jiamu Sun <39@barroit.sh>
