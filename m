Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2047.outbound.protection.outlook.com [40.92.89.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD11F4C99
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564436; cv=fail; b=h1Si+vgxctMUA1CfpPuWZRykTV8A3Xe0XZNl9oNTbI3G7Pu3n8uF2DcngCOlZj2y4QmVFITgbYvnYLWIdrDtXi/Xv/d3Js7ScRDWFz1HG9i0bT2xMJSP7KRk4zqYq/uHs+yfWrYh5ItB6Odn+MLXUOraXirWchOmZeFqiRgDBY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564436; c=relaxed/simple;
	bh=KHZuKaTPLdoa+DljhMqEBIdNWWWhrUsXBCrFPfjpt4Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=bzUjdAEP5rnADsZnlTFYiMUDHF8C+J+1WWLvEJTIy/E549JFkfRpR7lI9E23siDzCok4e6zYFeUAq+HVw6gwITfBvUbgK4o1pLp6C1SQg97Bk8gtZ8sytiV0OqkKTwG4+tbbxS2ZuEgmT8kY382WvUNSk4czsJiZlKx0/9e3d88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=EvdDaC3Z; arc=fail smtp.client-ip=40.92.89.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="EvdDaC3Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4JkZaFK98eOReL4IDPvos9wKv/kC6Pdlt8Y3rgu9v35XL38cKpPFvnL8Dtd/yem1OCoNmxxoYZXzsQ2sjHGcmZvm+TSDWEOlTxWVojhSNIF35bns0fprxBsQOh/UKVXdn8XWpmrn1AY/REPtnj4pX0Qtwo43e9QyT5XI35eSjeryS2pnBeWa2JpUkeFO+qgEldXjM9eGxZylu3H1Cn3XlfztAWEBOwZG+HyAIq2FawERMCVxq3mStJ/4cLtUU3DNOPlCI4tyB1PNoFTXDEh5iucJ2wHrqLed8Pt6QCkyRaMUgiYdqKiAxBP5iNd1s+kMwtmsazByfm/Yj5E1881Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac7+CffDRoiPI0pqE5ZPbylyDMsmDkqIlH019rXMYDY=;
 b=qSvTNz0yvDj4QoRurETH4dRx7DHuYgQyl5VQc3rzTYn3wFwI+/ry7rdHsMzrw59QutovaWsRvC6Wls97Y4R6l8FoEIygAttJzBKG/eXfof25wX/ExKw6EHGo0Vjhh4DRqwP1xFr3PO6X+DzHNVlOX0ZDDfl/UEf5HBdPZXsoTa1SxzMPwp5UlTpudnf79OPlQ9ppW7FcLhsZzKmcJDxGAJkLT2qDw5pMXypOKwbZeoT6SNJWTYQOPoB412p0OKMu7n2Q3pyMtGWJm62CfkjxTpzFl1soy053RXeRYBZvp+FuEeXvO2XyIj0AccsUN0lOJDup4RG4s1iI7hbObkKuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac7+CffDRoiPI0pqE5ZPbylyDMsmDkqIlH019rXMYDY=;
 b=EvdDaC3ZhZOslR+HdpfKYxm/iPj4DUKUT724AjD454+1aNgD827O+hW5qqGIBN1uyGv/FzLcOkKPw1qVeLaRO6YfHZw8ZZN6w3NP9zDXEkPn0S/+8csvAA28OgaJ8kSSYbUe6dWi06RTy/vTU20RIPwnUbJvYN9C5JuvRtR6BiCmz9ge5rReQLFyHT22nSQ3bdEatEkD8b/R7ggWVpJxLNdUf/lXhadr03BeTKxopkT3cplD/20l9eH8Dp8jAFctYPyXqipB4zvv9YinGjIMeeOzhruGpy7j7A4+qteT1ypNy+qmPlB9EOFotSOenGh29U7rGEMDlceyMD7Tb6IvIQ==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AS8P250MB0985.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 11:00:31 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.9009.016; Thu, 7 Aug 2025
 11:00:31 +0000
Date: Thu, 7 Aug 2025 13:00:24 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
    Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
    Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: introduce `count_t` typedef
In-Reply-To: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
Message-ID:
 <DB9P250MB0692BAB252D4D291F1CE981DA52CA@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <1a7ce761-6dcb-5b1e-2ee6-3c2c309b2882@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AS8P250MB0985:EE_
X-MS-Office365-Filtering-Correlation-Id: 347f0530-46ed-4b87-eed7-08ddd5a19fc5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799012|8060799015|41001999006|461199028|15080799012|5072599009|26104999006|56899033|12091999003|51005399003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y2EpFN+n/bWLS30RMQnQi0RGLcDos3NIqixXtPXGfVqXxPryPYUpzGcgMMMV?=
 =?us-ascii?Q?8CUjiZZL5bfu8WyiNkZoSkMSaqrxMhQpK595SCn6/Z1O0buvvRQOPZTFsdo+?=
 =?us-ascii?Q?jQaKlaofo9aUHPLZU+3GvTIRzL+I83jgi23v7uesF3ynPn+8E3VcqUX343k/?=
 =?us-ascii?Q?MhHRVBbXt7NCNARcRRq8LXyjODJuSpmY9zEc1BgKSW2Lgu6+QcUe39jYsL8k?=
 =?us-ascii?Q?awbbzJOWExAJ2teQ0yzAuVuUHd3vCHvnVApJb5s5DbPamfYi6TThkNAGiKy7?=
 =?us-ascii?Q?428PgtJdhcCMSN/Vq1z6PSnCC+vNrV40/IF2XTOQ3ItjNTkS/J7fhpwumdMg?=
 =?us-ascii?Q?rlPFlIe5BLIMEe/5Bg+OlsoQHb82pSAXF9I6EDSX2d3IKbfoC+seQVQInGDw?=
 =?us-ascii?Q?FUiSBCX54qIhi4nPbwEB+rimjR/DyetDUgPw43vcMrDX3j1ceiV3xa3UcPvx?=
 =?us-ascii?Q?lLrAc2wno9kj/3YOIsmrqdQbdSTnM+bYdrUQOH7BSP+jY7pw9TwJR9YjazV4?=
 =?us-ascii?Q?LV9gdujeq+N8gEb9j1g+Js+FhD9gatLPBJlWUNBvutsOXSFxIfafmnivcr2Z?=
 =?us-ascii?Q?9Fzozg+wu0WFQUMSQzXy0U/qzw/vAAqUUe/aFXGJ/a3NphhuQJQU4UKRLXhi?=
 =?us-ascii?Q?nJY+OB5LJGLQTQAxkj1G7chvHXHsv+H2fkFZDKoCb5i2y+asnew1pr0HMXLi?=
 =?us-ascii?Q?h49aWmEbimcoDT+FFZvZNhMSoRlogJn6kFM3dnDezc6kneqMck3PT5iRKPNo?=
 =?us-ascii?Q?sdZVJ7RadwK2wN5J3g0O3VUCxT4Gf094sCl7GxgOxbFQogciPEWI34KqyH2W?=
 =?us-ascii?Q?WeKWKbRXtGQJ1iQhSiBL/FNovbxc0iqt+R8ot7UIYz+nMQotV9M5/jPn0T5C?=
 =?us-ascii?Q?CV/nySsGcCW3C2LpzIezb5nkr/q8bKO5eZo0XB0vbC/Pxs2c6sTT9Mz6NBuq?=
 =?us-ascii?Q?M5D1DnadT8wtcQJm9pK+YZXtMIrBBNQAlKeGY8j5iYzXInKfCmZOmxME8rTq?=
 =?us-ascii?Q?wTULnio8YLnc0WNHy2cBy+t1oZGIRoTY6ugKQ5MgE7RQRnydNaD55E1JPU2d?=
 =?us-ascii?Q?8laTewTVaiCLGnFTf5QBFqVO9mgNT9kY8WHYSGJkg9ZYlwjxy/2VS2NICUjy?=
 =?us-ascii?Q?BQgY5beSQrzfI058zhla9jfrIIQqZ/YRtswVyD7WqR2zJnvUJa0+UDPG6g/e?=
 =?us-ascii?Q?oCSHuF5lcEkOiHk2Y/0mbc8pave591F4otTJAWSlJ7k+xW29aGc50kySPOeh?=
 =?us-ascii?Q?QlIfQE/Cjhq7xCyxsn9tBG8j+CN/h+5kupdslGauOA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBPlpYVgPa+pD0348HTBSZDCF5X0Oflplfh6QGR9Y9yF+85rZYm61Q2ws/xp?=
 =?us-ascii?Q?/Mt7ffZwDRSkq4W59PtgyiJPiHx4m1cb6Pk/9AxQVAhkoRcv6GxhmxyDiAAr?=
 =?us-ascii?Q?4abZOSn9Bxzn8U6u4n57YIyflb4UlEIQiOR/9YrXhwf6WSm5Il1a114BLwak?=
 =?us-ascii?Q?TyoiTY7kooZ2O9JZiOmTK6lXydxdGB+snqSsAL50F8kTazp8kE7qHzCdnhqb?=
 =?us-ascii?Q?eFXMvhJhGzxI3H/VDUgI41EuDXWVIVP/mcMNy9ct4DNmBoag9+RdXajyl/y5?=
 =?us-ascii?Q?sWLol+/IEMts44gLjDfod3MzKt4arvp2Ofh9SXj/4RSZQD2XAwXB/gDJxldW?=
 =?us-ascii?Q?xo2vxphuIKSLgHv2oH5S5MkHw9TdaoPLCLq5pTtoUZSB+yFsvbZy/u+T7cGG?=
 =?us-ascii?Q?1NZW8K/+01qV9ZhCkppNejdE0WaVyW0dtJfAC7rZ7lKPlDxUhTBUHrATRVHS?=
 =?us-ascii?Q?GH0KijBoKDMNb9VHVsiWmHWSOCXZAYhm3fYU6kXp2OZIg+JnYzeQa55P41D+?=
 =?us-ascii?Q?Bebaa00A4t6oLTAiBAUFXrb9NphJ5MDlkcXqLDQsNus8qki6qVPZ26lfhYUU?=
 =?us-ascii?Q?Jrw/wqoOyCxijrpSIFQdClw/39b0+pkQZK7IMIBiW9KqAbRO/qC6P8373iSY?=
 =?us-ascii?Q?rIdHogPXBoTnkzVYHdYxU792mX6fyx/8TB6PRPkqb4JnbYPMzJ7XW859L9Cj?=
 =?us-ascii?Q?FwmPICLRjL8Uh3yuI4lHTq0JTLZVzZ7qOUP00ba/4Cir00CdcNhFWMV7wgNn?=
 =?us-ascii?Q?kfrprKDT12EJxaLqq5OP9au1OQgcyj1uKECvrZCxQDE1ByMK/ft2oi03Sq9s?=
 =?us-ascii?Q?oKDsLozu33/iJfZD4XfP4wDaGJD6m7jpiyC4KCtJpHRNLIiq2RVVLwJlEA3y?=
 =?us-ascii?Q?+avnhAwsRzRHsZni56nvpvTsIwHN5LXS1qdS7HX8Y+njdn49q7XsSyk7w5gd?=
 =?us-ascii?Q?WzL67lcz5JVeJ4CZcZgMJ5waRm2U+7++6vyLJ7pWSfajbtiyg2oMv40fgRRg?=
 =?us-ascii?Q?sbg9lEKwLOK5qurBQIvIjyM1OAzEvBZlMI7HgAMpyydXc0vtfPxpIRZmjn5M?=
 =?us-ascii?Q?id/sFr/vfZUmBuPJwQyezyPPF8ENJiKpzr8no3pjBsjVB2XJkk7hVuYe92Ub?=
 =?us-ascii?Q?peHnQTwONIsUe3rkF+AKQxKfpQ0wSDzC4gzuQ8EsTwt2YmdZWddrioKbMMi1?=
 =?us-ascii?Q?ZsoBE0UVXfDC2QMSsW4ovowTQoSQFx8W5qKUzv5OmyLTs7K6XeBENalp8Ok?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 347f0530-46ed-4b87-eed7-08ddd5a19fc5
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 11:00:31.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0985



On Thu, 7 Aug 2025, Patrick Steinhardt wrote:

> Historically, Git has been very lenient with its use of integer types
> and didn't really give much thought into which type to use in what
> situation. We interchangeably mix and match signed and unsigned types
> and often times blindly convert them. This use has led to several
> out-of-bounds reads and writes in the past, some of which could be
> turned into arbitrary code execution.
>
> As a counter measure we have eventually enabled "-Wsign-compare"
> warnings. Most of our code base generates heaps of warnings, which is
> why we have a macro `DISABLE_SIGN_COMPARE_WARNINGS` defined for every
> such file. The expectation is that slowly but surely we'll convert our
> code base to have better hygiene around signedness, and new code that is
> being added handles types correctly from the start.
>
> There are regular discussions around whether or not these warnings are
> sensible to have in the first place. My (biased) opinion with having
> fixed several out-of-bounds reads and writes is that they are senisble,
> as they would have provided warnings around code sites that had those
> issues. And arguably, we still have _lots_ of sites that are susceptible
> to using the wrong type, and more likely than not some of those will be
> exploitable.
>
> Furthermore, I would claim that the question of whether or not those
> warnings are helpful wouldn't have come up if we had the warnings
> enabled from the inception of Git. The churn caused by the fixes for
> such warnings is real, and they need to be done with a lot of care. But
> since we have removed this project from our microprojects page we don't
> see "random" contributions in this area anymore.
>
> So overall, the conversions are on the painful side, but in the long
> term they will help us to protect against introducing new exploits.
>
> A discussion that regularly comes up in this context though is what
> types to use for counting entities:
>
>  - One question is whether the type should be signed or unsigned.
>    Arguably, the answer should be to use unsigned types as long as we
>    know that we never need a negative value, e.g. as a sentinel. This
>    helps guide the reader and explicitly conveys the sense that such a
>    counter is only ever going to be a non-negative number. Otherwise,
>    code would need to be more careful as it may hold negative values.
>
>  - Another question is what type to use. In lots of situations we have
>    used `size_t`, but this is conflating semantics. `size_t` is used to
>    count bytes, not entities.
>
> Introduce a new typedef for `count_t` that is of type `uintptr_t` to
> give clear guidance what type to use for counting entities. This type
> was chosen because in the worst case, an entity may be a single byte and
> we fill all of our memory with these entities. As `uintptr_t` is
> guaranteed to hold at least the value of a pointer, we know that it
> could be used to index into every single such entity.
>
> Amend the coding guidelines to state when to use `size_t` and when to
> use `count_t`. Convert an example file to use the new type.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Documentation/CodingGuidelines |  3 +++
> builtin/rm.c                   | 25 ++++++++++++-------------
> git-compat-util.h              | 15 +++++++++++++++
> 3 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 224f0978a8..2e9f3c07ff 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -238,6 +238,9 @@ For shell scripts specifically (not exhaustive):
>
> For C programs:
>
> + - We use `size_t` to count the number of bytes and `count_t` to count the
> +   number of entities of a given type.
> +
>  - We use tabs to indent, and interpret tabs as taking up to
>    8 spaces.
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 05d89e98c3..99b845cf34 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -33,11 +33,11 @@ static const char * const builtin_rm_usage[] = {
> };
>
> static struct {
> -	int nr, alloc;
> 	struct {
> 		const char *name;
> 		char is_submodule;
> 	} *entry;
> +	count_t entry_nr, entry_alloc;
> } list;
>
> static int get_ours_cache_pos(const char *path, unsigned int pos)
> @@ -73,8 +73,7 @@ static void print_error_files(struct string_list *files_list,
>
> static void submodules_absorb_gitdir_if_needed(void)
> {
> -	int i;
> -	for (i = 0; i < list.nr; i++) {
> +	for (count_t i = 0; i < list.entry_nr; i++) {
> 		const char *name = list.entry[i].name;
> 		int pos;
> 		const struct cache_entry *ce;
> @@ -106,14 +105,14 @@ static int check_local_mod(struct object_id *head, int index_only)
> 	 * lazy, and who cares if removal of files is a tad
> 	 * slower than the theoretical maximum speed?
> 	 */
> -	int i, no_head;
> +	int no_head;
> 	int errs = 0;
> 	struct string_list files_staged = STRING_LIST_INIT_NODUP;
> 	struct string_list files_cached = STRING_LIST_INIT_NODUP;
> 	struct string_list files_local = STRING_LIST_INIT_NODUP;
>
> 	no_head = is_null_oid(head);
> -	for (i = 0; i < list.nr; i++) {
> +	for (count_t i = 0; i < list.entry_nr; i++) {
> 		struct stat st;
> 		int pos;
> 		const struct cache_entry *ce;
> @@ -268,7 +267,7 @@ int cmd_rm(int argc,
> 	   struct repository *repo UNUSED)
> {
> 	struct lock_file lock_file = LOCK_INIT;
> -	int i, ret = 0;
> +	int ret = 0;
> 	struct pathspec pathspec;
> 	char *seen;
>
> @@ -321,10 +320,10 @@ int cmd_rm(int argc,
> 			continue;
> 		if (!ce_path_match(the_repository->index, ce, &pathspec, seen))
> 			continue;
> -		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
> -		list.entry[list.nr].name = xstrdup(ce->name);
> -		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
> -		if (list.entry[list.nr++].is_submodule &&
> +		ALLOC_GROW(list.entry, list.entry_nr + 1, list.entry_alloc);
> +		list.entry[list.entry_nr].name = xstrdup(ce->name);
> +		list.entry[list.entry_nr].is_submodule = S_ISGITLINK(ce->ce_mode);
> +		if (list.entry[list.entry_nr++].is_submodule &&
> 		    !is_staging_gitmodules_ok(the_repository->index))
> 			die(_("please stage your changes to .gitmodules or stash them to proceed"));
> 	}

This hunk doesn't deal with count_t at all. Should we split the renaming 
of nr and alloc into a separate patch?
> @@ -335,7 +334,7 @@ int cmd_rm(int argc,
> 		char *skip_worktree_seen = NULL;
> 		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
>
> -		for (i = 0; i < pathspec.nr; i++) {
> +		for (int i = 0; i < pathspec.nr; i++) {

Is this i intentionally still an int?

> 			original = pathspec.items[i].original;
> 			if (seen[i])
> 				seen_any = 1;
> @@ -390,7 +389,7 @@ int cmd_rm(int argc,
> 	 * First remove the names from the index: we won't commit
> 	 * the index unless all of them succeed.
> 	 */
> -	for (i = 0; i < list.nr; i++) {
> +	for (count_t i = 0; i < list.entry_nr; i++) {
> 		const char *path = list.entry[i].name;
> 		if (!quiet)
> 			printf("rm '%s'\n", path);
> @@ -414,7 +413,7 @@ int cmd_rm(int argc,
> 		int removed = 0, gitmodules_modified = 0;
> 		struct strbuf buf = STRBUF_INIT;
> 		int flag = force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
> -		for (i = 0; i < list.nr; i++) {
> +		for (count_t i = 0; i < list.entry_nr; i++) {
> 			const char *path = list.entry[i].name;
> 			if (list.entry[i].is_submodule) {
> 				strbuf_reset(&buf);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 9408f463e3..e9c30d59e8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -610,6 +610,21 @@ static inline bool strip_suffix(const char *str, const char *suffix,
> int git_open_cloexec(const char *name, int flags);
> #define git_open(name) git_open_cloexec(name, O_RDONLY)
>
> +/*
> + * The type used to count the number of entities, e.g. in an array. We have
> + * historically used `size_t` for this, but `size_t` is expected to count the
> + * maximum number of _bytes_, not entities.
> + *
> + * The counter is unsigned. If you need to store sentinel values like `-1` you
> + * should use a different type.

Do we want to make a recommendation of a "different type" here to keep 
things consistent?
> + *
> + * Note that we pick `uintptr_t` because in the theoretical worst case, every
> + * entity is a single byte and we populate the entire address space with them.
> + * As `uintptr_t` is able to point to every addressable byte it would also be
> + * able to count them all.
> + */
> +typedef uintptr_t count_t;
> +
> static inline size_t st_add(size_t a, size_t b)
> {
> 	if (unsigned_add_overflows(a, b))
>
> ---
> base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
> change-id: 20250807-pks-introduce-count-t-0f4499f80221
>
>

Best regards

Matthias
