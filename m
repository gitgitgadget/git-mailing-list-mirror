Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010079.outbound.protection.outlook.com [52.103.72.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8226B652
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197329; cv=fail; b=E6eWUWooIn2SkM1x8sc2LlzTrRrwdKkPMVUlt9Y/3y3Gt2fhvQDku3X9ELe9qI2KnpH4IPGbXhEhAuYXebF+1NqjXPs9R/RQCE16o5wQ7D/q6mQ/4Q5aPw8RKgRTT1IHWF14ANarmbaQiB3Hpfufa4P6CtmH+0Qh365RKI/BQQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197329; c=relaxed/simple;
	bh=yQahBz38kG2UsdVv/Os3KLb29oRSqrkUwSFgwbQ8SpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASTEVg2gAafp3SNF0HXmy579cg+Q7XiS3TFt34Jn7aLeIRWj3M70DYuHwmPlUoKdBDFhWYbrcrC14lhKUdkNLbn1gC/yDSqbNSSewu7b1WckTGue7fBt4OoXlu2fMqn3snvvQddLAxvskCphe+Uj0PdJLRZXP1BUTzyVSh4nxPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KL+rGlGj; arc=fail smtp.client-ip=52.103.72.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KL+rGlGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8nuB+MI4wNdZCzB73wal5g03qGAqvcfGP2zMcNAdODGzJ4ScOHa33H084bhTzI53hxWk/5YOGZjeZ9I29Kg7habIMqAXgEBvVnfs/+5iD74JLR9vJ5M870s4ENgmVVdcdcv73gi0P/TFhd/GLmCo/uEb4FIfN4QPKGotBezo9v0N1ffA9Cf8MIFUZ0GpNPS3Js4mZ1in5hdr0DrLuNo9QpWwEyty+fg8blGvSZe90xBiYoskaFrfD5lZJqBxztxOoaduPUcs+oAiHmBYhx/T7M24PR5mk/qWJQEe59wpFeiAbj0Z7PtAhLbQZ5ISJnEfLAYDNtMieC58CVgjWauiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZnTtTDuRM7hiq8Bn1Ts82DJhqENOMT5esly1+3BzNw=;
 b=T1kLm3ieLtqHafXk6B7Jj88zGzeYM0POkr2DXeWaHDQmhSiyMwuylBQGaXlgsA1gEHBZZe60CKSXMoBfLGEZ8fwFhruIv/NnmL/o01zUV2vUSRWSje/OI37gG3vAFWDLiJ9ax29UwsjSd6glCnyogUT6p+8ATblT+eXMVYsLpBaJ/+JQFE3SZ+cjqchMClrySaHkfzpst3JjOMgGV/RFWgjQ+4vR+oyxfUxHWpAaldoakPdgQwOg4F5cpZwveL6RsG1IpEUpoOyjyyLuU6iqkc9VojKSRCkzKFUTBCxtMHlkWZJsdFHNbQdsm8PJ0vHONgem5odxlIw6v2ta9UDSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZnTtTDuRM7hiq8Bn1Ts82DJhqENOMT5esly1+3BzNw=;
 b=KL+rGlGjA+UWHCqpobw9vcW3ia8d9Q6f/+RHu/e24tpLK25duTV9PaaG0D5wuL0g0MsLog0bTqXa+lRvvXhc/BaZmBNV2URneo8npg7zzZ9oHalUNQib5G9jHZ+drKmwhEYHpX5Zo3KEE3+SZshtei0RBGfYHXwiQ7bSz82j7pwFDMZLgljHKJpG3S/WljLMe9BCFzRUrZQCaq5ZYkumKMX1WiiQ4ntRTJ4yLlcfg/OsVt5PZ+1vqeCy3Kb4MVYkvv5FU3NIY9C1ncU55urv811Sl92AiCLqKghcpOnf448NiZE++dfUG7djzJEZRpQy3bxaQy+EIjxwhprk1+g1cA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0602.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 02:48:44 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:48:44 +0000
Date: Wed, 11 Mar 2026 11:48:41 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 6/8] parseopt: autocorrect mistyped subcommands
Message-ID:
 <SY0P300MB0801DA185098623A3729B9F8CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqq7brjtp7c.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7brjtp7c.fsf@gitster.g>
X-ClientProxiedBy: TY4P286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::11) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abDYCb1fuuDBq0cP@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|ME0P300MB0602:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2a6226-5661-4ec9-6b71-08de7f18b635
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|5072599009|461199028|8060799015|19110799012|41001999006|6090799003|51005399006|25031999004|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0715GtTqGj5OkLTf7bCtyUANEXrbVLj3WE+M4pMZIu5FwOyhPaU5XcbF2SPU?=
 =?us-ascii?Q?8KeB5aWZl55hvCbhAr1AOSbK7RJ7zbVTfKfnYhhAjAaHm+ViucnxhGL51lDl?=
 =?us-ascii?Q?uX/JWySqHFwT67HAL71RbjaSxEw2+9qco1LoLUzIulBPV4Bcx6Wac4c0J6eL?=
 =?us-ascii?Q?8B5QjOfF0BRag7kfjE6dLQov5ZONm2dBtRNDx1KSjDw/Qz3DMlCvqj0WCUXh?=
 =?us-ascii?Q?nSwDxLCOy/UI+Ensw64IzlVw6KRgIhfNTYiLOPwXN240DOiNwzqjKuS44T+2?=
 =?us-ascii?Q?A7uspQQWARXlL5vIC5nKNiyLIFboz9lzdZPg9dzJcSYSYXoDiNgvAmj1UdU2?=
 =?us-ascii?Q?9wI1DhZOYwTZKmZuEh+pfCAuTZVwITNEKBzlgE94I2gSshPQw1s+BxzfawB5?=
 =?us-ascii?Q?nT2kyJFLRLc8RMD3ZGTpakN2drXXC220Y5SmTV4pp7X1T0VLgDXD9pACkdaH?=
 =?us-ascii?Q?gCysOvYaBU20klPDQdF2UdOfgWAnMjiZ1jB0rv2QR0dneZVW5FWj9DlFilL5?=
 =?us-ascii?Q?uVSY5sYmdhXsHW0d+FCX6Fd+k9owF9dg9AWXohRpjEZ4I3QaAaOmQA1Lh7me?=
 =?us-ascii?Q?3N1H5Fg3zmEllr8zW+HVV0BQfF3Y7l23kx5R/FpggkXxdEb8UNHKuFtj4pFL?=
 =?us-ascii?Q?jyCvYu5lrXiw0nOaRmXE85SHdfWnT7pEvCg3LvblJ3pfakjoS0ZQNN5ON9zg?=
 =?us-ascii?Q?UMHXqI+x95bnqb+vdn318Ux2r7H5uk0AjDs9XyMWBN3lyntdOOi1cHXeWISU?=
 =?us-ascii?Q?BuUYRUwZMeAAqLby+PsO0E3HcNNp8RvSD8JwqKJgoTjNbOvFExETdmkBZ2Ct?=
 =?us-ascii?Q?HhsQ5kX8ZZBIInXg+3rRsP9jE5F/I/gKPlI14qugHPTuC4ZkKyNN/VA+QbuW?=
 =?us-ascii?Q?DM3DqVRNl8lv38V+2voxIuuc6e5fcl05FzFPTHLEzZRSUx12XzMkEtK/adKd?=
 =?us-ascii?Q?NhyoZq0k9DhvLictNmWO7Q44PNf6oGrKxNfpC9Pg/EdHwAX4rseGMjVVrh8m?=
 =?us-ascii?Q?HG+G?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7uETYwYG2sYxGssQjH0OM/chbzb+SfQPeR4NesYjy36wg6MU7kKh/L9hEPN?=
 =?us-ascii?Q?t6VTymErUTuBobLKpjfW4ErFfbasvBSBuC6tiYRCJhyNBVmYoxROuCD37MFV?=
 =?us-ascii?Q?E74YDTNVGVcTX5Cm/zvulGSQVeIIm7ipIH+xuNneCk5Ls9yUABK9LD0eNGf4?=
 =?us-ascii?Q?eMJzkRrQj1bgmoqRzm9ljF1nPt0VZMN44IpXDfg4dsO1X38+sXnkhRFoOVGI?=
 =?us-ascii?Q?oq2Q6n5CEn5b8QdfnArWNbK61jnbPbALqlzqoezOOGv5IPCJpJHFmgTAvhWF?=
 =?us-ascii?Q?NTVYHNC7dQ6AiOah+Umpb6+qiofcbIfoWMchASpBapa0DsdrZkrxYKv1nMr0?=
 =?us-ascii?Q?mC+xLjnOFXEwwfX8WdsqP9AEzz5sklMLO4XnnJOijvL1pKkq1rc9jqE6QBfM?=
 =?us-ascii?Q?hNBkBXHsVwTZKb/4Dsi3MWN7N7M7bNxmtV/XIF6s7mqt1Jih6Oyehc0rPLK0?=
 =?us-ascii?Q?vvh7Kov3TxMKnzDw7r9Q0ypVB+310YCutv3omGVJb2JVJoMpMhZdJFGDZF16?=
 =?us-ascii?Q?QCIoce4dJtaPKeMYJ3NCaKfFACv6XG17rsM7A/NBEEWsRPpUd15sLU2RVB2O?=
 =?us-ascii?Q?/BSEsIscVLcdWmHujKtjyWUDV+n5gj/T0aPWNsmnRezaKRA/LQAhMfPsYa5E?=
 =?us-ascii?Q?6xnlrmglLCDBoDUqVkOBGS/Q9fYtAa8d1glD8OLISx6A6D60K7xOW5coAhus?=
 =?us-ascii?Q?wrJXafc9p+gEJo91a8n1SpyOK+uOViXOCicHm92jQpzKctefkvknzjmomXWB?=
 =?us-ascii?Q?dWwksBZD+6KW952K17HyJ8ZYdppQHDb5qppdxaRXjcPY97YJ2hahFxKkufl9?=
 =?us-ascii?Q?hlfP+nxVlCYgd4tjPaszLqBO4BzGUOrSDoOsy4ms2F7yPBODfvXPOe58Uxu+?=
 =?us-ascii?Q?m7pljWWcooXXglSB+uEUPY6H9WBGa4TLDZAfAmSrwPA7exiiiIC6sNKPDcZa?=
 =?us-ascii?Q?NrLxlWyanduNmD7ur6sLr7wx4KhZXooWv8fhrSJM/h/HVOKJI/wSxkWoc0wD?=
 =?us-ascii?Q?ekmbZPbSar9q/yCUNnU29zX3z0ASwPOBYz0aLidkncj6zCBwYMZ3vIdxD2Sf?=
 =?us-ascii?Q?lf08CQFyN7iFhdeAMOP6RIVcgTCyMiEkN/rjSxF8b2sBtrE8Vydc6uBz2AJB?=
 =?us-ascii?Q?Q/+VFzSb/lEC8Ud9uEh7csc5/eTfOnWtYmGB25IjtSEHKfS5UnezPbf3wVgx?=
 =?us-ascii?Q?auL0c/7+ndDXLDdivvSBuOH/5R5DNmD1cvAFQ/kazR02FGQuAwtDUqJqGLln?=
 =?us-ascii?Q?6uuKou9ACSo8dL1Tuql5VOj9nYbAu9Mq/Tfv1UfTc5d5nR3wdQ+wyC4ATy4K?=
 =?us-ascii?Q?ym1aPhnyRUg7cW/4h2UTX2E9z8vYm/OcEwdryZ84+3LD8or9EP0ogL0fduN8?=
 =?us-ascii?Q?UDm0UIKsWfg/iqCsn0TT/8uQR3Mr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2a6226-5661-4ec9-6b71-08de7f18b635
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:48:44.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0602

On Tue, Mar 10, 2026 at 01:16:39PM -0700, Junio C Hamano wrote:
> > +	unsigned int threshold = len < 3 ? 1 : len < 6 ? 3 : 6;
> > +
> > +	return dist < threshold;
> > +}
> 
> There should be some explanation on the reason why this is very
> different from SIMILAR_ENOUGH used in help.c for main commands,
> especially given that the levenshtein() call here uses identical
> weight parameters (0,2,1,3) as used by the call there.

Will add a comment to explain it.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
