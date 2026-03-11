Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010010.outbound.protection.outlook.com [52.103.73.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A12F4A05
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209420; cv=fail; b=MwjosbnadxOh4kZX/jW9SkrNLKvefNfi/wZDzKUpXWJy0IhvsTBiSNVzwZ7O04dBlS1zZKrgkp4+Vuf/hO6VNAURcLVFg+mjPLd311Zws8Ne+m28TrRqAJhpVp/BCbP6vOk7mqHwEKDjIhlmeSSTKqOdVsMmV1D/me2sKtlIpQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209420; c=relaxed/simple;
	bh=Raq1CMDnLJo9zhuYwuTJsCowhhrg4U3Y/K1w9qpjNeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PYx/hm+3VlUaD2R6E+MRFESsav5HLjS2BFehxFozJWM6wzweMuTY1BZGkkpOckpBcpkz4whqyir4oLQsYUft3B9+ssP+j84GzYfObgx918RbASBlkBvP5iZ7sfAWbLtH4QGMw/w0EVop/QUX6SZcc+VyO6R9DRAytFxLTHdOh6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t6WZX2Km; arc=fail smtp.client-ip=52.103.73.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t6WZX2Km"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfOaqfSRXY4xlBjW3iUj/x117Kv8bXMszvtEjBns6Jagt7s6KRn4FbrraDVHyE2ktB3uAjVP0DzL4d7oy59M2B9TFdgWYoyWuk4Yt3qaiMj8mLPKhPUwKubvHHZRitZSgybRJ57slBo0Wrga1b5yOmFszAw1w4iYODrXIWu+8oLLF/ZrfxWPBu2OkRnou0OB9Jtivli8xJjuOxmeUdnXj0OI2T1HoOaR8KYZPOsUkle/rhYG3zsjMWdzCgFO+cLk3/1h/FpJMyl7UpMrCHPMNcTPIb6vdE4qrP0Q0N4TL7SosBPhQ4cK6b/l/v6WWBrKAUZ3FtbeiSU9vd5kqyD3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNQFVW0rI5hhE6+3WEY/feoeOKSxLHM+hC6Ge9NqSBU=;
 b=W/J/1ZZUFnbDXAopkqVFMGdV8M/Q1ktS/29qPd94Bd9SgmlfAHYEZW6O5Yfx6Viy7leuYSrCVGVQ4FvBOUwqfICQ9zPYeth9+jsa3T/rdwmgcGWLTg6pHNO2n++jgWpA9Hwen5PPrNqbyXZyJeOiqGLSaXwCIpajxFa+XD+sH8Q6t3Cz1O86jtoKAZdeoPrpe18Co4DqPSH0amgZeGFuFxKqdVCKo4fP/IHfFYUJggZoFR14SP4QaLMh/r7j6Cy1w2z1OcliavaFckJ2pFfeGrQ7QxbUl7SwRosbbjLq+hUMJXfubi0ajFFbNvF9WpQ3bRTRZ8BZjlicXIr8jufOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNQFVW0rI5hhE6+3WEY/feoeOKSxLHM+hC6Ge9NqSBU=;
 b=t6WZX2KmTuwB/r+6m2Va3T2Z2L+b6kj/XxVNg6/zUQl8QE/zdx7d7Mt1MnCKrqalu/UZqG2a1IzMb8ftHg4Z7Sd/5RSaLViPrFyn/W/LbbWf4t8FKBskZG3cLFtQHayxrs2b6qFlMhGxxRfsYEmcWNAesTJjVpPJVgfS1hFCLMB17aNwj6sglFoPIwE3sqJjOT1k4DPbid6lNhxfHTx2A938rwu4cRyWDh00Z8VIVSikwq3zIUv0HYVjaGq3zjldIsnAJn1Ie61h/kaXV4AVRTxYkGHcP7wHujNhQ0UrUqPWLnq4n3DdrG75+32TyAgap5YSNK7/hPPROuD7c/3azg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:10:13 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 06:10:13 +0000
Date: Wed, 11 Mar 2026 15:10:06 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 8/8] help: add tests for subcommand autocorrection
Message-ID:
 <SY0P300MB080155275E53D8C11279DCE4CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080107A9E22F2C0959290BB0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqy0jzq9js.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0jzq9js.fsf@gitster.g>
X-ClientProxiedBy: TY4P286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::13) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abEHPk32RRRwsVfH@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|ME0P300MB0618:EE_
X-MS-Office365-Filtering-Correlation-Id: fa87f09b-e405-41c0-a507-08de7f34db4a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|461199028|19110799012|23021999003|15080799012|51005399006|5072599009|8060799015|6090799003|40105399003|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fG1i6nCz565zY5XV5Cu8QuAQEXf+pD1LydoE60NZYsknktOZaRghaD3yVFLl?=
 =?us-ascii?Q?jf46KaGt0/3fx7d2VDfIFwuOCbd44g1sDLw/yM49wOm8ddes7yIHsq8ryBZv?=
 =?us-ascii?Q?TKiLrK6suYbl4+T/IFBfmT2aI11wCA/RHYLMxJJTPqKIYy43bSmPmyl1OsZQ?=
 =?us-ascii?Q?0CHDqamG8zaektjkPxlr4rEwzRxoQXGwY9Q6UA/F1347HyKfKCMFrQfU48I2?=
 =?us-ascii?Q?ze601zpKHKVMl6CGEkL294KhqUBWjKIFRy7ptW5Rjfsx3NB8Iak5xaYyVzUO?=
 =?us-ascii?Q?qYPsPAArIgFVG+MwD+xxVEiMWQbovxGXDC8jMnXqflzS3hZW4meVXo7dXVih?=
 =?us-ascii?Q?gu16gEJ/oWdZqCqGsy/8GtMBmStZyAMrwcXEvRQ7rBGGQCvyi+EJSa03VjRp?=
 =?us-ascii?Q?xOJBRkWdwUdofNNa8gtCk+b9LLUGU98oHrzHACHuM4t1cp1e32mgsHs25WUb?=
 =?us-ascii?Q?iknJHs7uiPJkFzxGxYQpxfCez4fmZYiRD3LNjjykMuDnH4vqeiItxzoZNzST?=
 =?us-ascii?Q?oUYgHzPKcxyAwD1VSqKdrz7NlotBUHhXlP+vgQWNep2AivIKxGM/b6u877Sq?=
 =?us-ascii?Q?vYd+Tn6N8xac90lzmrkQUs1/MsZv0kIXp8smu88sjfGNwm82+0ABd9Kfylpc?=
 =?us-ascii?Q?TaivZfqsLUCKm1Fj02fNEGB776UTEhUqs0pIqdT7gtkTVk/lXWr1qAY0m3Sd?=
 =?us-ascii?Q?7BEDysjEycxa1WCfoC/7utoxP0VJtENMQCOh9jaOP4HJvHPWmM9dg28zJrfg?=
 =?us-ascii?Q?WfJGrKov+lQtiMTctN5W2aNUA/ZQFIDi/KKeVZ1kJszq6E1cRaIhsniT84hc?=
 =?us-ascii?Q?YzYbOR0BBCNoc0ACWFI8cyKdqSCr5xRc5VJ4CLmB3lsoJHoicuYXk/42kIIK?=
 =?us-ascii?Q?+QDvSQfViSMgCD4irhPtD9pt6gWllytZWg62uo3a8eIzDIt56UiVb3jzDqrC?=
 =?us-ascii?Q?08vk0lmHvs/0nK+Samkb93XfxjJp/eryuN00nOtNUDo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZiyBDxPjqJzMXP9ZaZZ699ZvPmdygNnADiP8135tI7xCVSUCq/9QEX7vzGuC?=
 =?us-ascii?Q?3AcDLX2emYYbdAJ1EC+0n3Mgucxjbky1OMUC2fWJCaPHeorGR1kSUYILQGqF?=
 =?us-ascii?Q?zuhifBhUXVdqKclXrXhgntyMmHR9F+YJD/CJ2ncDMr1qmRDt8PZrHfO32HtW?=
 =?us-ascii?Q?xVCYTV01pR1krj4tnqbywQr8ae4besF0mtKPAZdbMMChFLRglqQbvVzopyRL?=
 =?us-ascii?Q?/Gs+n56A5oVe9E6BHcTxU/3XV95lXigQ1XftL1Fub3wW/K1nTwReK/s6IAdG?=
 =?us-ascii?Q?v09ajM0hWqfh+lpwzaKg4Qr7P1PkUcU/qnCY8s27e7qOVEQ+y1yhlBXA3BYe?=
 =?us-ascii?Q?T2h9zTnKH4i8vlIY/7aO/0wEjttRkCGcHbRuSNuPk5iJD2HAxebnCG8lTmxk?=
 =?us-ascii?Q?9m4ItketqH7a3UI9aDMTdXQCJwnSzrWqjSE1vKDcHIFYQ9Z9+kbZPe2EzZuR?=
 =?us-ascii?Q?Vk2rshZ6yGRJI0+CtZe2RSw79qDv7q5BAjE2GocISM4VnMcMEvWCINO3mXFh?=
 =?us-ascii?Q?Oq71tDo2m6VLLbvzzDeIqCr3kqR00PW8tLPuj1qb3QMlApPWq7j9K12MEwew?=
 =?us-ascii?Q?QgJFDsqbqxRIcr5D1m6490Kyl7sDB5i0/BjGdxjk1zQw7LtDke5cJYunetfp?=
 =?us-ascii?Q?N/0ssD3jZvOG06jI5LgA6k6Uk7iESrEssGU5A0eUQ5PLCTUrRU4f0SwOpugi?=
 =?us-ascii?Q?g43nO4IwBWh1xVy4+Ud1bSOzncn3jmzBUwbnaJH/BB9g7P+MhLPwxO1JRYzk?=
 =?us-ascii?Q?M65yK4ReSMdGfD1FSN4MSe7Ebf+89Z68UWFzsvS893SsI97Kr8hFrxfUPyqO?=
 =?us-ascii?Q?QBfxXT7l0VTF916hae0HGJWL6S8FSvWZrXOh6toVeKPeOexjtYUR0M8HLU0x?=
 =?us-ascii?Q?aPEGbnv+c25ap5YAWmT5qxxH65DkaxHZauyhZz7Hv4LUocV1n5SLiILsASgB?=
 =?us-ascii?Q?e4D1ph2v0dPZFJTcsgMPvp3joqPIJBhBEN6E6RDajKKG9fAkAjGs/4b/WRlw?=
 =?us-ascii?Q?yG/DjXzw+gNlyt/oK0Ru0Ls1zPk0haExkPj3yeeW34ZIQJk3eGMl/8zPCv+z?=
 =?us-ascii?Q?WOCdmVzvqtHjMMWKIGXfvV2z7LVhXvHkm2FhFrhiazDjgYe0Bt5hiBgR8qjo?=
 =?us-ascii?Q?9vMFsipwbgJdy+jMY+U+LU8YXVXGxWijbj3Sa0Pm4CZroV67idNlyeDHNGk9?=
 =?us-ascii?Q?0BYPjpe+FmJUbTAyLVUDCjqliFE7aREf9+SqAhb5FdEZ1MoMLTkWBpnsHLGs?=
 =?us-ascii?Q?eeubJgFY7br11WeJEpiXNuTfEOkaZ5UKcGzBzx2uFtcgTYFllT/pEPgeqb7z?=
 =?us-ascii?Q?ICc+BrKUH3EcUYT/IhiI8bahSR8t8gp54Qqrwf1ilor/AVT1jPQVia48vMbR?=
 =?us-ascii?Q?8EW1egtCsGZAYtKJmFagz0wWdfTr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa87f09b-e405-41c0-a507-08de7f34db4a
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:10:13.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0618

On Tue, Mar 10, 2026 at 09:23:03PM -0700, Junio C Hamano wrote:
> t/meson.build needs to be told about this file, or you'll break CI,
> like this:
> 
>     https://github.com/git/git/actions/runs/22929006339/job/66546202060

Will update and verify the meson build. Thanks for the catch.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
