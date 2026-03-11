Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012067.outbound.protection.outlook.com [52.103.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F213FEE
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193798; cv=fail; b=INm7FDDtugA+XrmPGDz44EDQqsAT1tTbG0D+eN51tZSeZzyXc0Wxz0Qa4DgygT76iz6kTQcPMzs0BJKfHDOklMjlWDzGxK+myaztzKo54TNCf8wGilNf4d/PkjrzGdrL0aHt7nX+Wef1473sQjDObPybvwrlkAElSOGKJdCnB+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193798; c=relaxed/simple;
	bh=ZXgseYGqrY6BBrajYmXRMmM3Wmye+4zL21LHsnLFUWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pi7vPlBivc2wpRyj0QQDmHb3ZCNv14rO/rjSYhHMRtAgyT1+PO+ydAoVRvux0s8hj6PgOFLI0EmNAx48Ch7KTN3FXPQ4OGuRMd+p65x+STI2FiumcP/rV53D+AiVspCrjTRFessXu8AKcb6mGkezpZBONlXIg7RB4S7yc3J0PLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EBeNd+vp; arc=fail smtp.client-ip=52.103.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EBeNd+vp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPVVR9B3UkJXIuwCD/gYJuhDU6b001736mJFnc1uEflhdGPvPa68dTS29eVC3lPQbgB+LnNkVDlnl4cpH6voy1zq5pI1oSODIKMz/J7gyAcqUntWjzuGM5GjVDHtU88vzF4PvrQpsMNBYTiJbco52d5LZKgLBa3LFgj/IBNaMWsUokXVMFIsuUAcgwvTM7gEu83ac0O+M/tbOqGj567pLjxKrLtGR4ncXjA+TGgkr3PuawXLATmSLr4cwc74xOC5hNJpuRXgK+pLUUHpu7UeqxEIFSTVn3saA3F7CzuE0n6ehl3oem2GOsLxzajB7Z+22zIaTseDt4NVhODFF8V7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbTvrrjoqOPgjltm5kef1vYUHZuKOGocezchH5W2V1E=;
 b=O51n6vj2s4KMMs32R2lnFRGwCEcbAkKUM2Qyx/s3Rk6JOMV7JWTc0PZhkJLfBXvsU6zu0+M4D1xLptI4rn9z9k1WF4BClwcrrSIifw3/KbrQ/ZMOqCXgw8Bpt/fNl6YXxoHuwftjXVSEOrynGeqnRbHz+6F225mDtrVaxADmaHHH+c9+lP85GQQMAULTX/WUIiXh7C5Ie4zJNAOVi9fF4t8MiwAHDPNmxNuwGeaCiYArJW47N0JR0SfUg227HBsVqPLKl/Y02Lj6HTdtKQWAT8xDGuOyctHjVXXJtcsM/0XJnPRo9e0DUFrWeeqk8z3vrzWJYrvz9Q96qR1itGg76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbTvrrjoqOPgjltm5kef1vYUHZuKOGocezchH5W2V1E=;
 b=EBeNd+vpG+KxYzCTQVUvMC0FuRSUjsDmIQWtFSmUsUop+zuL2x5DKIiglKxzc0eXRhhIpcOk78Ua3osEJbo5WDK2nllHafz7OErOse06KV4KUl9OZ+1i0qJQBmisx9FevFT8bv9Lo9jrBGeIGpooiTFFDmrukuqG8bzbnRDGGByg/BbrsSvzf8pRiHTBEwNhqhns8DFYCeNlT+alXG+3OFKWQ2p+uqex1t8RvuhSyd/YCm9DwNODysg2CENj+qwKqg88St37KxbHZ93m9ebCbetU9neEXYbnK8QurMpunL8ESTtYk1H7yRhwr8BVXqbSnkvDHIYe4jbCvi38yQbOrQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB1341.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 01:49:52 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 01:49:52 +0000
Date: Wed, 11 Mar 2026 10:49:40 +0900
From: Jiamu Sun <39@barroit.sh>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/8] parseopt: extract subcommand handling from
 parse_options_step()
Message-ID:
 <SY0P300MB0801AE08F2AE4C0EAA274A68CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <CAOLa=ZQ3eCky2rH_D-6=vwQ26TKW_dSO84+Z-WL2LFJ2rGVmqQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ3eCky2rH_D-6=vwQ26TKW_dSO84+Z-WL2LFJ2rGVmqQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abDKNHvTrlj0HANp@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|ME0P300MB1341:EE_
X-MS-Office365-Filtering-Correlation-Id: 403ecaf7-4532-403e-ee69-08de7f107b26
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25031999004|12121999013|8022599003|19110799012|23021999003|461199028|41001999006|8060799015|6090799003|15080799012|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3kpYyZAQukUAALHIit3nFEjIBXiWS24fofIjfeZSG9grP/jwHHM2uiuOUmjG?=
 =?us-ascii?Q?bpAUR5AFkMY/AE7F6kSUH1iLUY5BZuowioPLrft4wsGWie6earXIGuGGfWrp?=
 =?us-ascii?Q?aTiFPjgUSj04zNLCRxbDqf7rZj8Ij9JT3chIkefZvFZABKhQ8ihT7nTkbKYy?=
 =?us-ascii?Q?cjEFzjhi08YhXc0p6JQhHDpQjv8zuigyah0QuAgJ1JFIaP0u+nLKJOJVwbnt?=
 =?us-ascii?Q?jtfxfn8c6XyzgMtmRP0TUdAqxiy8931x5hW+dcibdpDutvSL6EGT5Jl8wcAR?=
 =?us-ascii?Q?HthP0rskfgin8EjqazfCskVvMRZOWj+K52oqRvW0L11Cyau8n/3HuuWwUslN?=
 =?us-ascii?Q?teUy95doNCxXC5+gxpLE5s+c4QgyZ/gTWi6gioHkkCieAKiciRBsIcEJpw3B?=
 =?us-ascii?Q?ZzT5zWm9lHy90IPDJy9Q3jaimwWohdug8rgSzC4V+5rtncItscaFFUs9irM8?=
 =?us-ascii?Q?O/ECWYYQEYYm6t9oM/zOmqgEC6vOtYJQamu2ohEv3dp3DnrxyVxTYSS+ksg5?=
 =?us-ascii?Q?HT9mOdO9RZNUSkhus+O4biXJj6md7ZDiRQbn/6CMXEjR8+XKX7Xf2xbbV/rr?=
 =?us-ascii?Q?UTZHic1Kp0OWAvHdeRjMJVP+J9hh2LS7nC6hRGxQYd1lAC7SmykDlwWft9Tn?=
 =?us-ascii?Q?cUdobEC26wxCsivk910pSuqoS4lpMrcesGS4YNqUpAcJK2XH02Jo0/Mpu1Tw?=
 =?us-ascii?Q?QSs/VU3x3EE3bW4dBG/Jo1xKtqNMtmzM3aKg4ysF+7/44gY4E4i6HfTEu/pB?=
 =?us-ascii?Q?kaiPt2MZ3HS4il1SM8gSyeugarQBj6cFc2mek6h2LZbeeMOQO3yYtyhDLedd?=
 =?us-ascii?Q?wIWhiohXtqtQaiY41xjW7jzPA5J+IZtjChVf/Nz6gleQ4XvGuyCRrj77FrFp?=
 =?us-ascii?Q?c1SArlMXFaUOC84zoTgVqvGrVeMP75FyMgBIJbXDSyhGl78kkZiUrh9BMzAu?=
 =?us-ascii?Q?ccuuTppu8knoyIijC4VJTincg0nl5Zkjqj1YxLEUDB976LyICW8t3oItaJFA?=
 =?us-ascii?Q?5r4h?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5odpsFbIDM8rHkenIcH4F+xMjmW+ObV0vkXea4S0zkiGpESBG2UhviJy/wS6?=
 =?us-ascii?Q?LtN53jFGI41IlBI0T8F6DhJZ6Q+k0+RE4b/peTSIbvZt0VcPSHIrpVcafjnl?=
 =?us-ascii?Q?JojanOAtbtCb3pORTWljWXYyGDnzZpR40tvdkRSvxd1Vu3ACp187RSbXksMU?=
 =?us-ascii?Q?M1Udi9tkjRRqCCLQeyem3NpQj1lV6E7wTCNZOLIY25dtdaBkja6dEka9BvnN?=
 =?us-ascii?Q?PuW54y9OazBKF2+Ba2dDj2jn7laEdR4J3XlmTTNG7hkAmzbnbKoLJKkREZ37?=
 =?us-ascii?Q?2IDFl3x3ts4CqTvKfY3CbVq/qTf4IAfTZuEjLhc7g5Xm8mnoqDSsNXemLeRN?=
 =?us-ascii?Q?rjGXqF9KUowxymSxR6GAG+POGKI3ioyciiU/KuHLhtt/Wb5a/MZK3XZUMjpf?=
 =?us-ascii?Q?8Nmhl+Escd2lzwyZUSer/Pc1CnMnJMwDV1cpzJ3oQ0uQMXTpbWaF6S3Gh02R?=
 =?us-ascii?Q?JINJYvjfBmS33Qssz40wixwb5mjnm/kkYC3eOa5FTCjH+ghKt1+tmt/gf5Ov?=
 =?us-ascii?Q?yaWCfHFYUyqLjzBufFMwT3Nn8mBZmRjygDm0beLJNeYJADh+FuJUjm4jZLJG?=
 =?us-ascii?Q?zcatIGuhjswEEjrYL+Jg3KZIi6sHRUp/PtxYinDGD4KD7E31AjaXPd98znXl?=
 =?us-ascii?Q?vTSAhP3VBrTfnMjOd1qcBGgiCEdjSW0SItJ2/roHNVScoTFOIF/L/69v8VRL?=
 =?us-ascii?Q?3BcILHSeKi6wkydQ+BmhcjV76OT/clUUJ6wNQIof8hwNBqCd0UUQ9f98IBCV?=
 =?us-ascii?Q?452GjYjANyF5ubmoM8YFZbUvHr9y8vLM1Ely4n1MrHLwsvmgXp5DYOazCaMI?=
 =?us-ascii?Q?GSaVhXCV7udgcbH5QAs4aIdYQvjQIO1cuT4dm2Tri3DisvbdBvpLhGJA/fFA?=
 =?us-ascii?Q?pVWe6RFEE0ouUyxAU7ZkKUYKjuSMI+s9J+27cWh3jsuYZTnARcTqaY2xit1J?=
 =?us-ascii?Q?2v/3Dv/6djGDR/3uTufIp/fLucY6W8QH4j6Sf9FyWO/sRi6+RRpbO1e2jwmQ?=
 =?us-ascii?Q?5hITidk+qKzyPdxla2T80T5hTRPuJzFf6LUvnN5wUg6kN/CyLDE4LW8mHidU?=
 =?us-ascii?Q?EUeb1BPnyUc7OfRmPwLAr4NUPIutK8VtXV5OOkq2BuZjtO2SQthhtcS1ZvQN?=
 =?us-ascii?Q?uoIq1Ec8k0bIUVZCZjmg+zMYl07i5+hsRtMN6BsljW1LjvpFQvNel7GW2Ei5?=
 =?us-ascii?Q?wXJPgSf6KwQ+HAAPnnwsjzN+eCl1nDYNnXpABvfqgywrR+6E//V2uozp0wY1?=
 =?us-ascii?Q?1ZCMg7YE3USwnAzhL093sLDoJD0O9EyxcxYs9y3aRRHoxOXP4X1yxoro6WjL?=
 =?us-ascii?Q?9c47c45rqj9gzy2qJl2tk52YRqPnzA48wvmq8hJ5kg0xyg7RVuyq7/V5qxJI?=
 =?us-ascii?Q?3Bb2AWMqUPY0QEsSYC518MVTuSRP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403ecaf7-4532-403e-ee69-08de7f107b26
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 01:49:52.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB1341

On Tue, Mar 10, 2026 at 05:46:12AM -0700, Karthik Nayak wrote:
> > +			if (ctx->has_subcommands) {
> > +				return handle_subcommand(ctx, arg, options,
> > +							 usagestr);
> >  			}
> > +
> 
> Nit: we try to avoid braces around single statement blocks.

I'm not sure if we should drop the braces in this case. I mean, the
statement is indeed a single one, but it spans multiple lines. Keeping
the braces improves readability. Also, CodingGuidelines says: "When the
statement extends over a few lines" use braces. So I think we should
keep those braces?

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
