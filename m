Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012065.outbound.protection.outlook.com [52.103.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B021C173
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776306307; cv=fail; b=SqTwFAtuvJ5fM3WbGuo4Y3vh8GQyf2In2L5kO1RrSSGwOcSNpv96BORZ4u0eSwogJbvzUKe5cGQHR16vx89PVNO6VjK+WFi8RL2TyqDyzf/ycb2QGeZmEHuZ95U842cTguJ2l/V+IbKT/hdol37Vx0olcE3K+zi/GR5qpJSO2M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776306307; c=relaxed/simple;
	bh=jejOOIgaenpD+z4qpGygSlti2v+yYmsN5hdWp0Jn9pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZR/V5PFAv4fktQ2lbh0xPtkzKN9uMIYQO5k/7pEjeDUX+mqxi4E60rRuIhbYFVfm0M61as15TfAxh49lHu1Q4nUqDZlGWxL9PYxnq5EB6tAfL4CbzoTZUx98gjZsrT23KZpmqDl9A6P4uvKrtco6Ton7hkXMjN5RqxLU4U+t9wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V/sWqE0e; arc=fail smtp.client-ip=52.103.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V/sWqE0e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttLS2fJ7FTn3gXoZZrsz7j2jQyLZUCPmy7mP8+B8BaO1ZBop7Gd6MHcMGKRjEmvzF3x9Lr+ZPUgmJdoMwjUGRbTGHWCnulOciCVo6ZkxAQORHzBKtUeS/H94KTvmjYuxK7BHB7OZIqLfDYfgealqNg1adn+Mihv8sl2awwPZ8M9oBoD0Nifu7nB1yBMktF2h5mCCUEaB+CZa45mbiOrKJNggJVp03FzPrarKWAGjJ2Yf6KAdbVnEDwf2z4MScYmoK4+DoCer/y8eWoyTcJm6sBtgOGnJ5JN09FarVzqDUbAUW4x/ZJ+sq7R1+eHWfgDOMera0mkPQIICiCCaJ7dvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fg2Fe1Kaz19zmXmMFyMgHYJKFWaIdp2yzecXY8UY7o=;
 b=dqI6x/MHR6kd2zgDYS44pCyCbB4BTcUIX1bfjMyXxmjRsERJ3nakLnGi+sM/grKJPiO7Q6YUepXqY0w9i8igJLlz2tBLSnoL7VR3S6cKZkb3ujmXBgwW9Yswcmvk++7tugKE/fQRPt+HXVJSs9OolAUmHyfmS2/3/U66TuhqSjLUxHmSOPtCG7kO17qNOt8eFEqN0mR6+pmGvAp4+e08z9Pzti3sVCpL3ieniN8D3gguWKzPMseDYAIBBiWC3BP/j3u7z0ykqG6t5QBRpOzBjJOqRp2M50+ERfZOl6NUoK/mqDd2vQ8Al4Rmzo73CKGO72fFiW5g1FjihXskRMYEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fg2Fe1Kaz19zmXmMFyMgHYJKFWaIdp2yzecXY8UY7o=;
 b=V/sWqE0ehfzdM5zpi5o9yuqoWnz/IumArsdNe1rTPZetTcJFoq2ERG83k4WaH936rQNaB9Bt5L8enXlfuQCU4Aau0G+3K6j/HVS0Z2COXbpkgYhxM7OkmetmQegktrkh56RFDX131EdJMOjfWgTeeM48937tZV0X/UrG/HJAgPs23h5cGZH7wbZ/GUn9tqbtSGnno8iD0N3IoxlMnp6RGCjYQJOAdDR6Opj9X0VG2UGFyHFh6mm6PpUaVWynCJVxCsFFTWtydvue7UjIqN1ywzwIh4Z3aeLtMkPQME+Ht/Ht5WYeNZrAgIepTlNNe7zays5TJI6XVy87DbO0pcuvUg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0417.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 02:25:02 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 02:25:02 +0000
Date: Thu, 16 Apr 2026 11:24:56 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 07/10] parseopt: autocorrect mistyped subcommands
Message-ID:
 <SY0P300MB080153D97E8B1E90846C8FC3CE232@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801E3F75349DFDF98C221F6CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqse9zo93p.fsf@gitster.g>
 <ME0P300MB08117F31CDFE8D038C3E0557CE41A@ME0P300MB0811.AUSP300.PROD.OUTLOOK.COM>
 <xmqqse8w6rd7.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse8w6rd7.fsf@gitster.g>
X-ClientProxiedBy: TYCPR01CA0174.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::13) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <aeBIeKEsSD8g7y0q@raider.node>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c142df2-857f-493c-7bba-08de9b5f5cee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|6090799003|19110799012|8060799015|5072599009|23021999003|25031999004|461199028|15080799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QswON8crCRRIwSkxAM7UJoMv+tfJ1a1794/8igyUCGZMGWcwBB2K9+Aejgfp?=
 =?us-ascii?Q?CzEc0QWjguyybnig/NySLy3FPVVZkienXmVBo0v2g55aWP5CRr7M7opXNueF?=
 =?us-ascii?Q?lEg6/JChJEAw9OZZiwpBqtMIkdgIyU1FbfG0wl6NJ0T9RK8XnX7EYAq4XvuO?=
 =?us-ascii?Q?AoOdKak0pxKKEH5/rLe46+FKPvWnx7WQ+EM7bYS0cmcIedjnh7wg0Q1X+40Q?=
 =?us-ascii?Q?Q3lF1/Qu3vHYTfXZMDzYa2ruyIDpImdiiXLF7nrvAEy/qF7JblIoldfFaMEd?=
 =?us-ascii?Q?Gf7UB6I5wGqeUUT0AyqNIGltsfTfUskEi9JxCPMc327rCf3mwAMELFm2bpiu?=
 =?us-ascii?Q?b2oy/uBP8/z7wj3t0ZIoPoOBqHQCTuoNN3cbYQwkeubMh2MQANuYpvBFQSvv?=
 =?us-ascii?Q?ZV0zSJqceMGL5sPtMiJMlz/FdZ8PZarNSIOGbT/4ez46L1FXiRsCaNCbVR/+?=
 =?us-ascii?Q?qSmUC5aKV6qTMMT/eO1y8OS3R+cWcKcHrS+yZEsCbQ3fGjuPdyKpnuSJGLxo?=
 =?us-ascii?Q?LiXigZ6AdM7xXWTb+pVQ5FKRSUeKz0YSLcZSfOP8YOK5oqt+pKP/PrNN6vZa?=
 =?us-ascii?Q?4pJ9Gkp9v26P9VCLfk83dSz0qZPXSNre5shuTvGsbWuTMqy5yq/e8ji5nUev?=
 =?us-ascii?Q?lB6b6uOeBUh9z4qNvNt1NzSP54GJtvxCQAMpP5ZzYYSnK1P8PNpTiv8d92RZ?=
 =?us-ascii?Q?tovvdzNpallNzJYkMZp94c8q7e3RSAGF2yD+/gJSdOwxIv+azZXsgqfX6rli?=
 =?us-ascii?Q?OQDMX4LP8cKvjCJxllZ5ZVSy2J4vrsJ9XmJEtEudjAjZjI024wkVbP673ulG?=
 =?us-ascii?Q?U2soeH132GcHPM6iTgWuaIon7EfS+zYEv5JwNbV7Wcg0n2HlRe2yHOX5slst?=
 =?us-ascii?Q?e1APCAqMhdjy+0Bz4pWSMukGS5GjKWa1xydw5egbJbmE2L+SccgM8GTEJJK8?=
 =?us-ascii?Q?nf7J+Wz87sUq7Vlj7NXSPA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Di5nsxL03oNbxPMtks2J3r7cVwpGvgOS33DpMACfuByTYP8MzGHsovE/T9f2?=
 =?us-ascii?Q?KEsFpX3IElopRHwXeuRYzHCtQCxQ5eF8A8yKJv3cHxfo0efklAkMilF5Eygw?=
 =?us-ascii?Q?cc9k2FX9nsYo/zi0omtdUEuu95Ai6nQjEP/zWimBvOrLqZVafwi4XbpxkmaA?=
 =?us-ascii?Q?LffrIA6Iv4CexZ4gui2F13AvqkZLI+AUr+76IKVf82EY9I94w62Vk+QyYrGk?=
 =?us-ascii?Q?vzdNfwYQmKLvSv0HbkvQzdV1Trj7tsweKXURmgJlCFC88wV8TrsjDRwEYRYZ?=
 =?us-ascii?Q?2vQdEGZOpecwR9lV4aHL1D+PZPrn5cHpp17exX0do1vplW6AvPFCX+uQMzej?=
 =?us-ascii?Q?e6rNKM6wR20sm2aGZBS7AJ1D2hU4j/RFp7ZqbZ/xucM6SFyaAdMVYRsmjAnC?=
 =?us-ascii?Q?9TuY0R3VFtA9gAlIkVb7te6iVJUUar0150rl7OeokpdK0ENyTYVoVanRvnUp?=
 =?us-ascii?Q?DodsUzppdx20MPpliyTOuEdrSHmNB/CGtqV5BkHs7jc/j1nkHdPV6B2YVPCm?=
 =?us-ascii?Q?LLT+KeD/mVdtYXwBmlFP1PAEuokfA4uHae237AcOGMcjFaUZ8adZfXbDnxyL?=
 =?us-ascii?Q?xjv4gR0d54JELIwMyLzj4QmF9yoQlNH5WvlvV8Ix8Ogyx8tIUEIQTMOtTiu6?=
 =?us-ascii?Q?3CZeUoQGKv8GmZR2tuBLxcvkIXBgUNGfCEL6cndooiKOSGk590/4WELTgxz6?=
 =?us-ascii?Q?c+eExcvhn3PHsyqhv8JIP8i7fPVBHHjjW8yFjWeSOsDk1CpDTwK+T0y+bMAl?=
 =?us-ascii?Q?gJNUbMhtRO1fNl8ENOyaJeZtwRKbbcmzHskXestPZGnLhpcksI4CYmN6GynR?=
 =?us-ascii?Q?ihsRadq5/ZbgyI2r33Yoi7K4FY5UeuoI66sIsHY+O08YGy3m5MwnDsTMNxup?=
 =?us-ascii?Q?daqOiJ9fMjy9wxl6G7ThX06uGhNDKQBGKRsl1s+wiC/lddaxQo5fXL7d5IOi?=
 =?us-ascii?Q?+5TTAJsnFjHOqM0s+wsIDwXdXu+PR0uKEOgzXHOlDUuM54R3m6kLh6369tla?=
 =?us-ascii?Q?G/E1Odr7xVqogcmpiNfBp9A6bzbZwzPw7Bw5M6Qs8XrwvwJV6QMTx1UOD+vs?=
 =?us-ascii?Q?GSIVS4g+WY3kSi1NJLxim37ToRTQ48HvOtoQgg4DcqlYjmW3ud9IpRAZCgAT?=
 =?us-ascii?Q?8g0WrGNYUuFiJPjkpX0+owkrmOd6ZGshIXMyiCN0FW5/udkxYH2bMYu3pKnE?=
 =?us-ascii?Q?Qhay7Z9pryOYb9iH7JgH+tDNn46mJBhLE4PVLIO+aJy65BBueYHp+TziBO4I?=
 =?us-ascii?Q?kJtwFPLVjclEu8DgU0zBiQwlTy0EkuWomyayB1s+bFJuiLQde1A8cWDwcrFE?=
 =?us-ascii?Q?bTx4lR7deIJnEKc8zRl2aOkrO6esFkitvuki7LBtqNvwYNHh+OvzqnFRrETC?=
 =?us-ascii?Q?C8yrWS/uEith+f3LRXtrbV17yapU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c142df2-857f-493c-7bba-08de9b5f5cee
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 02:25:02.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0417

On Wed, Apr 15, 2026 at 10:55:00AM -0700, Junio C Hamano wrote: 
> Either do that (which is probably conceptually simpler), or explain
> in the proposed log message why they have to be different.  My gut
> feeling is that you should start from identical settings that has
> been used for years, and then in a separate topic propose to improve
> the parameters to improve the behaviour for both main commands and
> sub commands at the same time, but that is largely because there

Agreed. I will change the subcommand autocorrection behavior to be the
same as the main command in the next revision.

> weren't any explanation why subcommands correction should behave
> differently from main commands ("Correction for main commands
> behaves strangely and I do not want to inherit it" is not a good
> explanation as it invites a natural question "if you have a better
> behaviour you can use for subcommand correction, can't it be used
> also for main commands?  If not, why not?").
> 

Currently, command autocorrection skips all prefix matched commands.
In my mind, this shouldn't happen because "branc" can indeed be
autocorrected to "branch". I studied the old thread, but didn't find
any explanation that expands on why it's doing that. Instead of
skipping that, applying the autocorrect handling to that case would
be better, maybe? But for this patch, I'll keep them the same.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
