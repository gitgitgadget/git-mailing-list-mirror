Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEC39DBC6
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675402; cv=fail; b=utmxhRYXuKrEp3LTlf/TKeHVdikkAzOfAnK+DuaGp8/KbjMdYP1VkBIvfHXLNmCnQavF6GS8R/mg3p9S6xlQGM65/ikqeUB/EH0sGNpV0boM+hGhBtXHpb4bF9jJO4FX/FvRCctxd8JyIGr1ddtKy4RPjYWR8QP6XDvw4STl0+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675402; c=relaxed/simple;
	bh=tYW1SQOA3nyn6xsidfTOR0P9rK9tCZYDBwIAZyxtKGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7JdXW+aGvBVAAbO+eEnHuYvSHeEk8GVkjo9qWtlfgJl7u2jMUU/komyCMAX1Hu4tw9K1rQVEia7rD85/NrYAjrQd5ygA5Y7LfZ3wP8/5//qT+/VdNUWlygYhECg0n4+fIT4E28naT5Ph/hjDb3miHy9quDQ7PWUll1uO4SIiS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Lrt76SMd; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Lrt76SMd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRLL/MaXhMMWB64Cqb8ICt23msSQ6HAC9nxqb1NVBdSJtw9SEUBLQjF9MFYJlwUBSYhep1FhsRTIRPxREP3P8Oi9GRvBN2yVD6ukmUPEgpjDZM0Ci2tlSVZy7xHdxE558e82fHsYVoQ6YNWyX1oEWx3JLKJjYPrz7z0LNnUQ3w3WRCQLV8wF/rzik8NUvRVXrQ+wlGowNloYUKMpfqDhNOS20NKHN8pBPcEte5d3L3nH5wQ8iEgghCD5rBOQOizfSO59g9lnpPiTOsh4FfdfBc/cU1mjLGEwgTeFzwrXTcn9jphgwRgQyYDZ8OKJHnIQitNO6KpSon82rpoUFU9CWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0ShNvUf6dx0IW6/y7Pa4Xhraio5vfS3fLmQ7qAK0rQ=;
 b=Rb9EkKie2COBalFk6AUx04353Nij+AUV0GvLrFgzrP7geQnIjUhXh3u+p3cTkiCTrZcqrwJR8m50BWO8hnx2asduN+/iIVxhDg/1XJOpq15bdCq4d9oqWaJI5wZyK6MoiNb43sPJCSYHSOt+KCyvS/VUWjYZOlyV8BGzlXhvU9yOwLrvfuoAvh5LGym16PDUSLTzDgKEJRfz40S5i2ul7tkfPOQndHmc4K06NYuyRhaQccSGGLTvpS5XCEdLwpUkrotoAM3p4dePj4kk27tmiHF7yoBmfPVXlnDpMv2XN2I1oGxhm7vX5rq8FFGNlU4IZVvV2CrAxLuQsbK53OGuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0ShNvUf6dx0IW6/y7Pa4Xhraio5vfS3fLmQ7qAK0rQ=;
 b=Lrt76SMd5YbNv3TnBj1mcO77PY0F4jiRSomGdCepK+9YNJy/DxHGUxmMnqy10Aqh9BlGIRsuD+N/8TB3UNwuu+iua8qCU72B+1294Pu7iaDOCDM0W8KGJXswkJgERXDx8M825UzjvHYzcfWETZDiRxiugePTCW8ihrAtmHR4oUhP0tMeUyLFiQxok6fQEJm27n6X4yRqghSEGVzZrO4v6feQq6mx9BmG7pMl6Jkgn/LztRvaWoluLERqMyL72gxNlAd/PnPA/MsBlbwVfuR0ehXAChqYGjVLBrbVnsm2mIIbTAEIpVxxxnTQl/HXwIGlAHTuUsDerzbNItjIJinD1w==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:35 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:35 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 01/10] parseopt: extract subcommand handling from parse_options_step()
Date: Tue, 17 Mar 2026 00:36:14 +0900
Message-ID:
 <SY0P300MB080125630943A294F4E96482CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-2-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb430c4-6969-4312-b2fe-08de8371ce51
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|12121999013|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DPMCFB0kY2BR4YOrDj1KQt3+DaoFyY0g+8mjgahoXimPipY3hP3PupiEz9c5?=
 =?us-ascii?Q?Ut8sLPQxISnwvdkITzSiiGZ3QLwWTIZeNx8qAwmgaJ0xNh0inesj8464UlXe?=
 =?us-ascii?Q?VulGJ3R0VHOR9WvK4AZRU6vekPwcTZtIlGFzfrKQL/9LoOH0aMMqog+F3mZj?=
 =?us-ascii?Q?h9cTAxvXdfglCW7zF+CC6D0i6ozu4l9Rx4Rg3ttpfE32+52Co0Tbq9KYxDk2?=
 =?us-ascii?Q?7ZkrtkRP+ZV/DPNSzxnaQKs5hsmH2ook8AXL6ySrxIGU98Q4cSQUTytYwf4b?=
 =?us-ascii?Q?szjAaR1HQMzCqJdeDaWwSRwLAYCto0v3uGNsd7nDaftJ3KU0deeF3y9IiTio?=
 =?us-ascii?Q?V0lBafkV9Vr2VhNgf2x4roF1gRZNWkuiXUgC2m8wqbeHhCbLQG8D7fWnIQ80?=
 =?us-ascii?Q?snXcDNZOUL/UJx3zmu8A5na8bhvAayBOG+TBwtlpD4yj0jnIXUQRo42Ok8Va?=
 =?us-ascii?Q?ItMdrrUw1I/BbBcSgl2V9p8tVLzB9Ckg4pqxhV/7UHRO/kcwMvrFLsr0FL8N?=
 =?us-ascii?Q?15smC+/7EjFkNNUrQg+BfSvNZHY5uLtuU8dADDeeufBuY3ae/1az4LEH/WE0?=
 =?us-ascii?Q?j/i3R4fA0DfPUO4NAzlMan+bQipLNrc6ezwttu38Q0OD+VoTTrjkDk5aT8Ip?=
 =?us-ascii?Q?CUUOdQ1TNaYT6SL1gvtkAS/RcDtuE8kcE5Jw0V+ug/jDNUe5pDkSovEXTYIp?=
 =?us-ascii?Q?5bFtXEh/s0Oy4IhQguDP3W/1sY6AoEhxnKrcIYpO4nA6G9FHjybdZ5bn4Gj6?=
 =?us-ascii?Q?UA/Dt/+PstMGglffs7bbELQSoS4ctOMXrRkmWTGafHmof5CSQoslad2MBIhA?=
 =?us-ascii?Q?Gc8VTFzdEBRNQH/IhZegYi+VLFvOqPEfJnaYkTAtC+9dVBgUcTTRB7c+dP0Q?=
 =?us-ascii?Q?ynmQD2Xg9kCgOwFDkA70dQ1s/4w6t2807oIvoQEdi4ZOjG6lYQWVFtOkvksp?=
 =?us-ascii?Q?FqTaAiP5TbNnvg7uGR43YaP8TMbGFIZbKP45gpQTaCYGoRDqt2o3KARF1yxq?=
 =?us-ascii?Q?TgI0C8/2RaLVKwfq+/KiFquV9w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jpnKJ8lbtmdneVfTITNXQGsvm9Av/AtZx/5xVeHv74O/akXL2vPGU+4aafh?=
 =?us-ascii?Q?XwEy1/BCdAfmT/kKyreYJlTg+Tw5Wo98x4FvEm+pUgFE6iFoeg1/08PPQWQ9?=
 =?us-ascii?Q?+p/9uhapOcM+bmRAGdyS7fEvTfAUg286b+YprcJTzZgXMjfQWgO+bJ0j6awC?=
 =?us-ascii?Q?zsH7WgQHLW2iCgGm/G/ZW27dJ1EyAmA+z8BGU3zk1/EV3DKlaZ6Y9jnxYZib?=
 =?us-ascii?Q?P0N3dDHH1GK8uSQebpEqd0pOKuN0ulpgvNXlHUnwJkaZPH+gcpDm5kSlsE/u?=
 =?us-ascii?Q?4VaQ+iprRKcAdx3ef7pt5mQMKS8U8CFqo2msOKAwsRn8dUkXr19XXjynwNEC?=
 =?us-ascii?Q?67l08GQZEmVqagimrKTFmXMMpg1lcxfMaT2RVphv/UibaxyOPRSmbmM8FDFn?=
 =?us-ascii?Q?LB9ptLmR3ekSmSl3pt5Lau1Jk/qC0HLq8ej7NDHgwmKus0Bz6xCJKTfO7T7C?=
 =?us-ascii?Q?wlI5qpZAqidSVI9EQQxSOhOVo2AxZLWbtBrY9qmo8t9/5zy8KZHgem3/O6S3?=
 =?us-ascii?Q?3QDj7YQtCSkOr2w32DzXqVirKs4ryw7edA6S5j+HnYf0425E6sK13jnF3Owm?=
 =?us-ascii?Q?xR7ofp2xI5uEubUjoW3yCr5IIDKuouwL4kQvIEjJPnj1zdDZ9jvZiSRQD89/?=
 =?us-ascii?Q?dE9t6/8WQUDomkFp1Wtl3Hc9NIqNvdY2/0seBGhrGRDhomv+/1OH0Q9Xfl8W?=
 =?us-ascii?Q?KsQBdP7SoMQEHZQzTzHl+AJkqaecdI2QQILM5cxZ1v7XEYFjk84SgN3jo6fu?=
 =?us-ascii?Q?JGGrB8pG6Q3+bcPVRJmsupjmzOj18gax8eBLLGOl8o26FY3T//n//t+ciyzn?=
 =?us-ascii?Q?63DpqygpEelwrbXZN6Jlgp6cVt59aF51YcBuzugM3JSunJNiYXCztcfIhf5j?=
 =?us-ascii?Q?lra03Uf5pfE5P8KdRh2rMO5UDTT0UWeA37wBACqcSGwdbrMpbhTEFX2s7ZCG?=
 =?us-ascii?Q?r6oph0cA3/IAgpCpBNbaITgHepJv5fglX1u+OQp0Arc0bFeU42CYRUtVQQRb?=
 =?us-ascii?Q?t7yVTxk2Vbn8Ui3hRmMGFZ/jYumetrzmfmEHo8QERXMNeJ2kg/V/pDA4uTQc?=
 =?us-ascii?Q?lv/+5s7uCVl6ACmW2gqyUGrBXJMpOJv4CvXLIZfF+82cFe5juZkhdCA0IHF0?=
 =?us-ascii?Q?/vwLQZdJ3N3vIe2voeCOiGiG4w/9ymCrNa+wG8HjPFBzw7GPiCAaxtKgffgj?=
 =?us-ascii?Q?TTSQ4YIcuChqAcNGzdhlF++mdJ0T45LRMZfmfFbBvxWnzigdZj17gI2pvxPn?=
 =?us-ascii?Q?LHYjbhUSVq30kkVC/n0SKQkLt2FCpRgutyUfk0cQDg1rceCV3KnmWRH5eDUj?=
 =?us-ascii?Q?6//P9ckQS5aVfRTMkjm3O62BCRlTBYYlFMd94XFc+Y4LycyP7PzbLtH+gyAw?=
 =?us-ascii?Q?O0BaZf7Az/oRwV8ZY2X6/Fz5VIxT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb430c4-6969-4312-b2fe-08de8371ce51
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:35.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

Move the subcommand branch out of parse_options_step() into a new
handle_subcommand() helper. Also, make parse_subcommand() return a
simple success/failure status.

This removes the switch over impossible parse_opt_result values and
makes the non-option path easier to follow and maintain.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 parse-options.c | 87 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c9cafc21b903..02a4f00919f6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -605,17 +605,44 @@ static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
 	return PARSE_OPT_ERROR;
 }
 
-static enum parse_opt_result parse_subcommand(const char *arg,
-					      const struct option *options)
+static int parse_subcommand(const char *arg, const struct option *options)
 {
-	for (; options->type != OPTION_END; options++)
-		if (options->type == OPTION_SUBCOMMAND &&
-		    !strcmp(options->long_name, arg)) {
-			*(parse_opt_subcommand_fn **)options->value = options->subcommand_fn;
-			return PARSE_OPT_SUBCOMMAND;
-		}
+	for (; options->type != OPTION_END; options++) {
+		parse_opt_subcommand_fn **opt_val;
 
-	return PARSE_OPT_UNKNOWN;
+		if (options->type != OPTION_SUBCOMMAND ||
+		    strcmp(options->long_name, arg))
+			continue;
+
+		opt_val = options->value;
+		*opt_val = options->subcommand_fn;
+		return 0;
+	}
+
+	return -1;
+}
+
+static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
+					       const char *arg,
+					       const struct option *options,
+					       const char * const usagestr[])
+{
+	int err = parse_subcommand(arg, options);
+
+	if (!err)
+		return PARSE_OPT_SUBCOMMAND;
+
+	/*
+	 * arg is neither a short or long option nor a subcommand.  Since this
+	 * command has a default operation mode, we have to treat this arg and
+	 * all remaining args as args meant to that default operation mode.
+	 * So we are done parsing.
+	 */
+	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
+		return PARSE_OPT_DONE;
+
+	error(_("unknown subcommand: `%s'"), arg);
+	usage_with_options(usagestr, options);
 }
 
 static void check_typos(const char *arg, const struct option *options)
@@ -990,38 +1017,16 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
-			if (!ctx->has_subcommands) {
-				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-					return PARSE_OPT_NON_OPTION;
-				ctx->out[ctx->cpidx++] = ctx->argv[0];
-				continue;
-			}
-			switch (parse_subcommand(arg, options)) {
-			case PARSE_OPT_SUBCOMMAND:
-				return PARSE_OPT_SUBCOMMAND;
-			case PARSE_OPT_UNKNOWN:
-				if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
-					/*
-					 * arg is neither a short or long
-					 * option nor a subcommand.  Since
-					 * this command has a default
-					 * operation mode, we have to treat
-					 * this arg and all remaining args
-					 * as args meant to that default
-					 * operation mode.
-					 * So we are done parsing.
-					 */
-					return PARSE_OPT_DONE;
-				error(_("unknown subcommand: `%s'"), arg);
-				usage_with_options(usagestr, options);
-			case PARSE_OPT_COMPLETE:
-			case PARSE_OPT_HELP:
-			case PARSE_OPT_ERROR:
-			case PARSE_OPT_DONE:
-			case PARSE_OPT_NON_OPTION:
-				/* Impossible. */
-				BUG("parse_subcommand() cannot return these");
-			}
+
+			if (ctx->has_subcommands)
+				return handle_subcommand(ctx, arg, options,
+							 usagestr);
+
+			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
+				return PARSE_OPT_NON_OPTION;
+
+			ctx->out[ctx->cpidx++] = ctx->argv[0];
+			continue;
 		}
 
 		/* lone -h asks for help */
-- 
2.53.0

