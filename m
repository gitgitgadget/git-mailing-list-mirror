Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010017.outbound.protection.outlook.com [52.103.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDA2F851
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274231; cv=fail; b=QvWnM6T5DBBRirgOSClDxoBXHgjSBq1Nl4ChlNaO4vxbsa8Z1VODuwEvGsKIqR1rwi30ndr6akh1ipIA+Xy7QBEHZYd2NzjiqqqSqHNQDKg4MqWabDa6ugNYHBIbtz7FpJ34Q4Fp2nW7ZNkX/Sb/cc4XyOHixSal2fyu4HisOtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274231; c=relaxed/simple;
	bh=baOwvf+TSCK7DjmqyvXoKW7noFt8WLnSlO3Ii/Ky5YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fd7WUBcTsq2+dGQ5n1eeK5JtAQpexS86rKpEa+sKblWBabrvffn9X6eHNybg+uPh12V4/O7eVcQn7EfXcztOK1Mv7YKz7FjaJNYUqCD91sKO9fiIjenWCjVSM1/eRjp8aR/+wVfO7npRQCtG8v0ejMBO6eOCyo/LJZvJJkPyWAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ojlgV8/Q; arc=fail smtp.client-ip=52.103.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ojlgV8/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUT11gvg9Mi0Jay2AI2tgE/Yyqj8+uJU1uCP05gNjNITorajaT+HF/0RNl3oIqFNbGRYx/VLdN7QaefzSDsnOTqv/BoOH1eMek8jQGOWdpcw7YEiylpbYlu7z9ypIHy3WxABZ5LFzP7JljMSoH1TuXR9BGHIEr0wXyC30mCS7AKchHM6nasBRxRVmWIcF/CC+62y+me5+7HWmhXifPsaCYx2vVg9gewWFVBnwAH48eALSMJTTe3xRmyUGILFzyDSVCWQYt/Ca0SuosZVPdRj2xaigo4aTlLqVLC8yQheFF6kQh9YcYFSzVXiOlEysityiRR59nSayz4y/JugSMkPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/w4TBuIq3ZhTOy2c8jfUXFv836fKnzLNgf0VXpZi9M=;
 b=id0HKburfwQ4Dq+RaC1Evim4doaZWM7r6GKlLVtBzP9mc8bqqRlpLFvdkTdbwO3HQ1FsOdbPHxmo0SmtdU+ouafMcic3HaVgxoyWi5BUWkB7j24m8/nUN+Lj6CFyVgsD+gwGsq3m1iCYAnsB7hip7afQQoQLWBcLS3NcZP9AfCUibx+0Bn9dM2V2WEYV5XEj3nAHx2itSck6273VIo5PhusicY6ceVxKXHASbI0W3Vn2xhNV9hyFzz3ztwnel37zXtn8IxqTNmj4KyZWigzlzRb4XWO9vSAeuJhTIWa6tZ+EU8BzpszK8cpwxyIFa4J1+/Wf2k3jAuO2WsoXNGJupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/w4TBuIq3ZhTOy2c8jfUXFv836fKnzLNgf0VXpZi9M=;
 b=ojlgV8/Q80YyWpa5nCX2tNzXYYvP+XM+DHbp6itLbh4rJh3sRRdBM5OjOsM87+BggMPnep7k9XTdBAlN8DSJh9OobD79zcIf9RFXrqCvgmZIEJq4hakInDRjulgrL28wZaptzxLiOCx8hHVJRrhAyTH7OIlrwZI9bspdkfkJn+tumIbhL+e5ISU3K3XZGHy9ym44zxXcwyM6RyzfxM8dvs9JIxaFWFJQsPN9UULBx3XMxON4I00oq01VbNnLnJ38e94XOLD0k4nRKauK9QDJzWK+Jv1o0X1ptuLCPfhGlxtUTgDg+t5S1jXvGbD/ohlmD9qhnoEUq6HGwyeOmW16Tg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0204.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 00:10:27 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 00:10:26 +0000
Date: Thu, 12 Mar 2026 09:10:20 +0900
From: Jiamu Sun <39@barroit.sh>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/8] help: move tty check for autocorrection to
 autocorrect.c
Message-ID:
 <SY0P300MB0801E747D883046C5D030D22CE44A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801E98F538F5320E7B663F0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <CAOLa=ZS=2msGg5d-6-LgVD6XSduYze46iWcT2X_dJDd=6AOOkA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS=2msGg5d-6-LgVD6XSduYze46iWcT2X_dJDd=6AOOkA@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abIEbIDfH5vKX83_@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0204:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6bbcad-9b43-4b23-af03-08de7fcbc332
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|23021999003|41001999006|461199028|5072599009|6090799003|51005399006|25031999004|19110799012|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kkYDuB77RRKFsvTO4PuTrUKm30ptOxoA60zv1dlJsrf1h0Xq4cC6teQE/Cci?=
 =?us-ascii?Q?SwCsxhA0go9+8OI0DsPxTpd8WUU4flZWXVAb4bt2ciubNTUE/N+wwdKuWKtX?=
 =?us-ascii?Q?UFAZnegJ0t1P06LSeAy7gm7wdSoPZxAaS8tJKapKGGC/fa11o8KNffSWRS76?=
 =?us-ascii?Q?6KUTzTJIOp0G/0wgFAf/U3C7VUJVMzdg62UzfMOjcooHvmfG+A6sRZr4qJZ/?=
 =?us-ascii?Q?Y1b96zkIfsAhBxO1cW5gyQ8CW0vj7E7HhUq46+bKcuVCnN8VUG5yp9GTvFdj?=
 =?us-ascii?Q?uArtraVMrGExQlHfX4ZAMFWp9YDsDMrmSSu4NfcMHifP8S+nU+t06v1wzavq?=
 =?us-ascii?Q?Wni9eleNiNmir7Zlea8Rv+f/EO0f6oDBXxv6smtZ+WnW3UPmfciWo7sTKmuI?=
 =?us-ascii?Q?vBtPgvHVUl2r08oGNzKeLQncDq8egHCrTAW+GkjHNqBs/s6G+D0pQGZvqyZN?=
 =?us-ascii?Q?HLX9VYYeWCePkLsO/aJAnsQy3JgT1FZthQ8kjeMNZzfwxCzw7oT4+ULjT63I?=
 =?us-ascii?Q?32QD02FGgFKngyugZgenZwmoySpKRln0q5wonuTIfAXZwZr34v0A3VE828bm?=
 =?us-ascii?Q?RZn8N6Iwp0Rtxr9JzFQ3VnF7NZdoidPuqZwyGlwOvA9B9XcIDdackPFWsoZO?=
 =?us-ascii?Q?gTUN5kNM3dgx2AFt27sE0y4xVnlnn2/20fPj23OW0AM3kB33Po+9CZBEpMxC?=
 =?us-ascii?Q?nwfb+QO9gs8Rltx12KMuyrtCVAzeP2DOFlpyy2LJdcaSxweZ8DGWzrmEkN5Q?=
 =?us-ascii?Q?9lDBELUnUdokRBffce8OBZJ4CtIL5+IzMy1dSfohl+3dzE/0AIz+uvUayCoM?=
 =?us-ascii?Q?RNhgULM4cqJnR/glqid7E0HPnp1DtpvMARwWn4+8b2nlsDYOkg7JU4Jsbg19?=
 =?us-ascii?Q?STs0hHplMCESTU2MDLjjti0eygl0V43ZBepYcPTYf3Kyv8wYM39srKw1tlRf?=
 =?us-ascii?Q?GJDIZN/fhPKJe5tyCfhcCjd4xziu4OG2SQAqk8wnPkHrGYkBh548WYOQsZMM?=
 =?us-ascii?Q?LF2o?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GeiSu9hDYvT6ikJprnL6VUddiJiKvSexfAYag/TfCP8mj/2umaSgPNtEwhSL?=
 =?us-ascii?Q?68otpcCsrEB9+EbcQiX+hvA2sgrXhsBc1pYZqThWSP0EaymwolvV82GqLQQZ?=
 =?us-ascii?Q?UwSgfmnXr6FqXlXBwIzFdk0s+2qiy3C4v5aYbvr3uOw5yMkyfCzprFlZMV+J?=
 =?us-ascii?Q?b1+wCKHEFJuKmeknGvXnWtOXs/tctutzsyQQhp1esiLrVOVvPeRrG8cvOehG?=
 =?us-ascii?Q?3OYp9VaxIquTDHVV5xOTRg5mRwMsWHwfU76QKOnuEdkK+MDTp4GK7rmseaBD?=
 =?us-ascii?Q?848wKUmyGh6tNpGIQNEGK7YdQgyiaWOFraSTBIM5IT0FMot1xx7MU3/bhGq5?=
 =?us-ascii?Q?Nq+fOE3LGl/THA2chRcP9wvh/4NV6ZRk1imkF0D0Ey1wG/xGbYw6XwzVdV+m?=
 =?us-ascii?Q?UC36nzk6Inike+T83HGdcOu/fhdLwGXDG+hvC7VXi7eSdVpVlMHFnI7wZ65a?=
 =?us-ascii?Q?MYdaa0QnnwYod2pEISq87K0YfcbWOD5ES+ysu7hpCxC6HRLpPb/riCDa6FPz?=
 =?us-ascii?Q?Ef2wL+LlZW1UlcKVqWdlrs1fekv40aeRGSxiZb+m2guTaYiqw7RjUb8092K3?=
 =?us-ascii?Q?U90L9cWVufXz0mp2ppZ51abrS8DDjLcPeTmVJsqnO/2gW9BBIIdw5dMRnMoE?=
 =?us-ascii?Q?MuAoJRtkVlYYaqRyqE3Qs9UZSF0iOUhBNprKg+RPVtcnhGe9WGNY9+7+6872?=
 =?us-ascii?Q?UiJAhUBgs5aJwqDvGzowAKyu1a9G1vK8bZyUXxvhZK9aZlnjTiMDjCioTK0c?=
 =?us-ascii?Q?Te8J789M+FixUKuPCebg6oNPoahgknIEAHw7qXGlyH9+t6yu9tuEEzautYwF?=
 =?us-ascii?Q?TmaPjjnxHdRcSkkPl2C9vDZj9M9+V0/+kulWYlQsn+jJklgEygeLDF1IFCLs?=
 =?us-ascii?Q?UPc77gDfHLYmMU8SD7ZJxFy+1LMVaxfFgdjq1tiz7Ko0ilBqbs/1EylPsv7+?=
 =?us-ascii?Q?HJg2tuwX2Lc5zzbnyekGCiIeVtGuQY95NMM3dJttTx2R+hHupzTc8wUIeYNA?=
 =?us-ascii?Q?QBfTxdCAZ1nx5V5N3h51oszEAY7B+Lvz4/L6FmJGn9nn+L+JdvhBrqGFDklo?=
 =?us-ascii?Q?/Dr+l4tJBTeZO3NvURs5fXnOgrHzv3aftCds5QgGiVOeX8Q2Jgerfb/Ih25h?=
 =?us-ascii?Q?9EP67bdAlfDJh3A1NpBWd+YDvwcd/FWScoAicurrIUP/dKaM1fIbzSanKee+?=
 =?us-ascii?Q?jt8rquckslSJoUQSl1YE3OTdYpI9L7oZ2xsLSJDFwuqlTFZa4JSbT8sXjfic?=
 =?us-ascii?Q?JrdN1QDrB15wWe2uj3wfDwmP9OJHqmKBnD9rm/hSrFeRmrhSZlzYA8EY1EnZ?=
 =?us-ascii?Q?6kgII+XpJuy26NZTL6FS9o7k4jjZvwiMwBZzYbxrMYXZJyNF/cRmURT6Nj73?=
 =?us-ascii?Q?9/7jLSWakJ1bDJxP7vvd62fvj4Vv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6bbcad-9b43-4b23-af03-08de7fcbc332
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 00:10:26.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0204

On Tue, Mar 10, 2026 at 07:06:17AM -0700, Karthik Nayak wrote:
> > +		return AUTOCORRECT_DELAY;
> >  }
> >
> 
> Okay so since we introduce an enum we use that here.

Ah actually, I messed up this patch. There was a commit that moved
autocorrect config into a struct and introduced the mode enum. But
somehow it's gone. I'll split this patch into two.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
