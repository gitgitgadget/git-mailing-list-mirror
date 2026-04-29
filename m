Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010021.outbound.protection.outlook.com [52.103.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C801F4C8E
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777439599; cv=fail; b=biRgePtF0TABTtDVVUWjHIzWuOzXJZ3+mg+5klL/zHNWbQxJR18x7lQ86YKKEL18z7G+eVXzrSKohIobL1P53DI/nR9di18nRbiidF6UC8yg07yitSeSk0rM8dWzN8bHj4sIttGnAx2XuDNNzrbuH81RKbrSZ0o5rOnmHoCANrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777439599; c=relaxed/simple;
	bh=HNnbCtMq0gXt6BrL9sXfuWiIjrEql7bPuUDBBJ4Gvn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zl+7hyGnx9yB7W/NaeJc5U+EBEKTaJFd8+OSP7VNAxB70rSPnuZgM4A4nfE75cZykrFf7h2d/7slDLixewDglZFgH8bgMDNpFNW06MvQJeUFTnsZec+ZZLjd8rmlsPI9rHTUjorocfKtygxTQO4Xtn+Be0Seekp4vk5GGFf1u6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V5EWHjjD; arc=fail smtp.client-ip=52.103.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V5EWHjjD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzTU+qn/mRa0Ty/JNoyaSo1vm4nYg6Xke0O8oVrXAm/j3PtnLNb5P9hxo+kQ7dD6pQA+7cV5/Wwg9hDjy4+da+3dvNjVl8Ct5vIpD8G7LV3eHKEOunL+9SW6bRljA098aij/hTFPPWRLSlSjy3Hf6nlXab71xGU/N2akaGjYumyQuCj4KNtWd5VZ2t2tK0kCApODeWMW8ihzr8JmMp+48d8XoQtiI/gjQo6cSbWEPKSFHVCGLqUOCZKMQTOSKSJ36o5bRYdjI9474o+6HT/2SkNpI/+xQkskiSJKCVhnkJVJsRUhCowX74l8zoDts6f5bFiupjxpbAy2C068kE4EIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP4dbnLpgrVFZbHbtgyQQMXaNN1up3eMsmgga59pTc8=;
 b=Df+QWAuSICSY7TaMGYtvVKTjr6s0HMAQ+LV29VSYfkIUbD4ciylj2+2CaUxya/oBjdii1aRz+zcZ+6Ppuwsg99xvrUYrIQCHu7vYgskTJYP98fZU9kHinufThvcOKiaXJ9Yjf3V4h3NYEBXlSJzOZMfPpM3r4HlqqhO2SedfJCvQWAqj2wGimNP8/Y+udCpJqLvyx8Br1/FVu7zOiRoG0TD+3TJkbPtfUy2B7REE2CYZDfUXPZ6uNCmn7fWe3WTB1tGq+2XXuwHPP3yYjPx0UYPrGYNWNzgsgJDuyO+3PJrXxvwZwKBh+7qKNASqIUpbud3XcENag8McASyP+3D4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP4dbnLpgrVFZbHbtgyQQMXaNN1up3eMsmgga59pTc8=;
 b=V5EWHjjDC/2VqFdwcV0slHPTbX6Db2OnwWg0XQmCG/YJIM34SpsjyVw3cAn5RVc49xeiUnBV1bDel0EAJPKlijTLSC8MVp4HXGcvCRCRvE+ljowMPr8bO5bCY3wb4/gN+VIo0zrRyE7A4lnL/9noFldy88ZODppKm5AglfXlF1YHQbnToqAF0ndmwgnrSYB6Z/Fi6P43XRcwcEruAtBcvOrNYLqtff8fLsbCik+ggPk040JTx2VM6kQBPcUh2uVXr2lS/O0R12z755cgiFbv/Mm/lfVQ2QqpNiod4rH1AvZa3tCS3/bzutto2it+aA5Akc7U3WNjb8iPNC2MpkQzww==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB0412.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:287::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 05:13:12 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 05:13:11 +0000
Date: Wed, 29 Apr 2026 14:13:07 +0900
From: Jiamu Sun <39@barroit.sh>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: fix sparse 'plain integer as NULL pointer'
Message-ID:
 <SY0P300MB0801A25D4414FCB5C522E407CE342@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <7aac2206-8b60-484f-a5f6-4943348ad3f6@ramsayjones.plus.com>
 <CAPc5daWZUJA0sEqS4Qk2vn5x+LNRgphxjzjdbcLFpEgS+69kUg@mail.gmail.com>
 <d0357af8-ce70-77be-a885-070420d76c0b@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0357af8-ce70-77be-a885-070420d76c0b@gmx.de>
X-ClientProxiedBy: TYCPR01CA0053.jpnprd01.prod.outlook.com
 (2603:1096:405:2::17) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <afGTY5dCIzPNxQri@raider.node>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB0412:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b54d94-33cd-4a25-30a8-08dea5ae0230
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|5072599009|19110799012|6090799003|23021999003|461199028|25031999004|55001999006|24021099003|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HuD0sPyL85RKJaHHLbUPaw7ZElb3m3iBaHEVuQzSTR5/xnB+wNMg95P3+rZB?=
 =?us-ascii?Q?LNAh+s4ZQ2/Y3a9NX3u9Xo8DxNtF4I9PVKu5ozvC8tECNEDqrEpErZrr/IYc?=
 =?us-ascii?Q?VZsvjyF+xfZy3cchxPsnGqY7LjqSg/Kpa3Gz6s8aqQwAs1TEoCt9jbrT3+rS?=
 =?us-ascii?Q?lWjaWdbdPVSlwzjF0gQoeGuD5GGTLKo4WtohgTFCv7wrHFYn4/YYdgq9jOdW?=
 =?us-ascii?Q?whq04izAdNcdC5PYZGGfyuHlH2OFWOSMUkzHNYCpkErFSJHbz9XhKRTQCPVy?=
 =?us-ascii?Q?U50EZ5eci2/jjJgrxpKKkYC3ge+eyNqL+7tCB8bgDOHly9VVCvzEQ5njZ8Vk?=
 =?us-ascii?Q?rvuyhCdhYZFGyy4kz30fiQMFacD7Js3Vp9asG0aCVF6Ws+BdOej0dh7TQEB8?=
 =?us-ascii?Q?tS3BUI3rCzGQyyabNQwlVvdMCBfU9Iu8hVvFX2XzhuGN6LVbbmF8ziJzOu5m?=
 =?us-ascii?Q?7MLbgIbXGuH/BfVsoBHIyxYv13GQY6SPz8tJzgapMUs8mWSrtgLrydVlkgoy?=
 =?us-ascii?Q?o5QIOLRe7U0hqvfJjN58wcQkn8kxSiiaUjC94ewpCoDWn5VpaLrYPv6wZohy?=
 =?us-ascii?Q?OrFCNU30mp5RVcI7gHxOGT2bnt7XJOum4bgOC3/XxNlWMqjAO278roiJqljV?=
 =?us-ascii?Q?CNtO5o/hq9Ud1MTmQcOCSQU8U2oqz0qceFDV3JBotaQJ6os5eCzQgOfT7vmP?=
 =?us-ascii?Q?76kLjAThRFYZQh388pMZr+PM9iS7KOemkWEw/XPaG5v9C32O4hj+uGNMDyCR?=
 =?us-ascii?Q?idRIRNdDfkua7zB45hCBMUB/9d6uRLCl6qr1NlfpOjtpLBhWFnCXEu19gFTC?=
 =?us-ascii?Q?RLcUAbEhEbt9R/D3LNHXPijVKhhqk29VuJENvSmwsCvCk2V0HSlRknLnWJ21?=
 =?us-ascii?Q?OOPFdzei8LScUrJZfScdiWj8Z3g97ry0q+q8nF5SDSO8yasoeF94AqbkLHaN?=
 =?us-ascii?Q?/BaLMZfWWygYbj30QC+Be/b7geDar7WH3coq5ui1RKme/Grm4qkJR7kDtnrB?=
 =?us-ascii?Q?OlABB5psksIzt3BdcYRZj8nAsRCtXywuhkDj3LnEVeKvxEs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mqi1+Zt8wSrez/7TUVlSxqhjY4unTIiyibvgkksEpra6XB7/bP/aXorIUeyB?=
 =?us-ascii?Q?6NgI4+rVQgU2uMt/V8Pd2hq8LAY4NlGpnfJb76SyHxGlt9/BW4vEcOmgpNvT?=
 =?us-ascii?Q?Z1YVwuusYwKp/j0Rn3U9FFLuk9v+OfJtOqD9K8pKxuYeBwjHlcDr6hJYaaZb?=
 =?us-ascii?Q?bWHvn6mG8TXPJAnSoAx8KaqZzM7GHGcXF39QZASQ2e6kiEi6U6BNT5WiUwoS?=
 =?us-ascii?Q?9aPMqkMmLuE3+tUkDZgW6iVaYrxr4JSV+ixuykoAeYquv3ZifC5fwLVAHMou?=
 =?us-ascii?Q?JYTwyE4d3pEK8DsGT7baBIxPGnGYCLY2n6v4aD39RasjAHSiVE2PhSBKVH4r?=
 =?us-ascii?Q?0JH38ozpopqaFdvJ4MQfzHyFkgril13Ca/If6V5bJ+fgbhdWqB0Bzr44wdZL?=
 =?us-ascii?Q?O8acyVTT9wQ1B6dFnnxMUK1Scd+3+oL7P1rzegrn/H6UU5MtWiWbHEqfjnoD?=
 =?us-ascii?Q?yf4M9HE7eU8IYOn/Z8nU1+JSKhOYH+Uto0SBWkQXHe5gNGBHzUBqJZ9qL4jf?=
 =?us-ascii?Q?6kGL/FR0kaI2X/ktNtGtvEfbMCv4puvm15xLZYMY/ScqYDWv9iHKJlQLy1bM?=
 =?us-ascii?Q?hL972B87YdlLg0Oc1vHm9eJL8wluTPxe/PpHf+FVlx/7QaTk61T+Pgv2AxEI?=
 =?us-ascii?Q?8+VltC1VN79dXh2L71TzYosbiojWjv9EiDvcUqPEx3ND+oLE7qeZaaXUZP/4?=
 =?us-ascii?Q?lr2th8QL5m2s7xsbaHON3t9q0F2fOXRleNcxX35TbGscXACighzA7oYymual?=
 =?us-ascii?Q?z/aY8PMx7Gx5puGXFi4dJaBTD5MSY0Wf5DRZbdgv9CLI0iPMsZiDnHiDm3U0?=
 =?us-ascii?Q?ObpxmJWBxxGx5I1t24Qxn6H8FjIU2wL4+mdasXdoUwToGvXQzNUHkrnVWGbb?=
 =?us-ascii?Q?gH+CR1VVLGa0aSrphJ65Y5yf9gJxgP4viXm4SyAV+GhEAZC4aHfF9SWYvlAn?=
 =?us-ascii?Q?2OA3MIJjRGi4LIU+MIXZIUIeKlVJiP4bwiO0s8pGzATlx4LXo7gA+buNZO1N?=
 =?us-ascii?Q?RyZhtSikXhLhxe9Ln8b/ZelFsFudmDCNO00VA1pEwGcY0VDVTiIodRL9qVpr?=
 =?us-ascii?Q?oQ92X24BGntr8BhQGXxY7LTqKEviCLOnG5lQNLLd5zvGCqvnnldCwFuhJgdv?=
 =?us-ascii?Q?FyA28CN0//MouN3QkU86TpSPGI7/oRWi1S0DR2ZwDCexAHx1iOhF6v+jhRHw?=
 =?us-ascii?Q?oIbgWgmq2vaU+A0vHt9Nh2JF8j2xJgu+hyo0qDpvVah/A8GdcTLvJCQeY9zA?=
 =?us-ascii?Q?oXov3ysaulLIfh0NCi24m2Z59Fudd31QwpdaVmXOt+2Mo1Htw1jxIulwv90F?=
 =?us-ascii?Q?LZi/FwKK8dvlO+Ba5R+OAnDwEqH5Tz1S+jZ8EnKjMnyBr83RDPfFaNYJKtV3?=
 =?us-ascii?Q?X596OuOF0aMqzCDh3y0ELftPf9Om?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b54d94-33cd-4a25-30a8-08dea5ae0230
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 05:13:11.7895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0412

On Sun, Apr 26, 2026 at 02:14:03PM +0200, Johannes Schindelin wrote:
> Indeed. With this patch on top of Ramsay's fixup, it passes the build:
> 
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  parse-options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 14f3f385eb4..0ba6905fed5 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -648,7 +648,8 @@ static const char *autocorrect_subcommand(const char *cmd,
>  					  struct string_list *cmds)
>  {
>  	struct autocorrect autocorrect = { 0 };
> -	unsigned int n = 0, best = 0;
> +	unsigned int n = 0;
> +	intptr_t best = 0;
>  	struct string_list_item *cand;
>  
>  	autocorrect_resolve(&autocorrect);
> -- snap --
> 
> > > Ramsay Jones
> > >
> > >  parse-options.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/parse-options.c b/parse-options.c
> > > index d60e7bd3c9..14f3f385eb 100644
> > > --- a/parse-options.c
> > > +++ b/parse-options.c
> > > @@ -658,7 +658,7 @@ static const char *autocorrect_subcommand(const char *cmd,
> > >
> > >         for_each_string_list_item(cand, cmds) {
> > >                 if (starts_with(cand->string, cmd)) {
> > > -                       cand->util = 0;
> > > +                       cand->util = NULL;
> > >                 } else {
> > >                         int edit = levenshtein(cmd, cand->string,
> > >                                                0, 2, 1, 3) + 1;
> > > --
> > > 2.54.0

Will squash these in next re-roll.

Thanks everyone for catching these issues and providing the fixups.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
