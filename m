Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012008.outbound.protection.outlook.com [52.103.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9C3A4F27
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908299; cv=fail; b=Z6pSZJpQSXF7k3GsKJvuxOM/5cwSNVDp8HpsqlkWDQFyZxcuApQFY7Cqn41gF7Z7y+af9qrSBNmnre0/E1AMHXI6AX0yWoIsf2NRaEAspDwjQiCTLVAP82n4E1sTU6ElFMRkYzOXWvm6t5lWUzCrE6hRE3mb8ZxrpbM2yeue3Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908299; c=relaxed/simple;
	bh=yjiAqqUD01phLoVxUdCt6MeTf3ykkQ5dztxqtuzQs/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+GzEcgUk3dwi+LnkM5FanWO6cjJSUndfs+G+BjeOmYXJlck0AJaiSJ1r7iK78i9LcYX1Ooa5OXie1n33v3xMhcQ1VZaUem8dAQeA2WIqCj7PBtbQQykVvRN68bKP1Dyau28WGWbLHSJF9qGZIEIJztCzm+v0qqzR6zwYtjog2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=O0si6kli; arc=fail smtp.client-ip=52.103.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="O0si6kli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KggqGzj48HOEQ99c59xKC64QaUFxOos65seoDfZcnom/zRSZ+giOiAIFVbIrul8u2GNJiTkZ986BRzQ1R4nItv3GuFyVBKxLrj4VpohsT3hPZErmfliv0p7Tz+I/0/hQF6YPjGxzF7OKgXKdT1S5cp9oLu+UDMxYxbdGVnni7hqtQx1bP6YZ/9Q8yePYwsHAwGDdSsVl7/88hhc7QEYjmivbilFxn1Zq+Ojj1eBltJvekKC7NpL6pI4OfSt0+v31MPwBDHJE8UrM53Nm5tVog3fGCwx9DfhSo8G5j5D4SgdsJD0/XDRpUGxrYqthdDpVcMLrblYkTwGVXsG6yQibkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/WMp5knRlr1dtWd7exhTnXK+bHsjmmHy2+kV2FBeu0=;
 b=WHY4MgMkHK5zveJBfQqmS+jIxkNRPvVHgirQIPiyk1dmUrrDB2KCR1nxDkaYywIASw01LZsZhRrYgeE3ZPrOoMu5l8YzaO9782zZsIKmMyyUOFTKcPUk4LnDtY7h6uHqoQnbdhcEmTKrO6Y2/EN0HkZxH1g9/yD1XnhC6lu+7BU2TBvFgouTomT7Re5h6oOYyApQ8Fkh+CWnsznYvvILp6vXNSaR3wP/CM0Z/5rLJMcJ8zUsBUCi/1z59Gzg5L4oaOF45ANM7fqCfDhVlwadSDp9/scyK1bClS5MxNAyjcGgb2/QD/D3IGWPuiSMKRDGGLIlyFTNRyb2AyN9Wmr89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/WMp5knRlr1dtWd7exhTnXK+bHsjmmHy2+kV2FBeu0=;
 b=O0si6klirtfVZeAjZ2bBhYKiYxs/Y0RT9TxofB4ott4v6svj6K2a6q8+N5G/y1VZvf1T7HzRsurP90BH2tHrgIXWc6pFEjv8uKHrccy+4NTFOvH7aodAm5zmp5Oq1gTARCgG4b7uCRIbGZzLb0ykFVfg2e4VAcg5Eg+aeqKlqT2WhGDLNAoEBwEdo2E9bUTFUyKjkSv2vNSvdWJWkKH9WyG28acRXpDjrl3IGHSi/RSF4zaFjSIJxl5f4qVGA6KpPGMpLz3C82JxXjrxu8tN42XjozPxBsYknwQT9pOmPbjnA9/Hxzid21Dya0qcEQOGqhHQ/rT7+iIRSkjNiCaqWQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:15 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:15 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 01/10] parseopt: extract subcommand handling from parse_options_step()
Date: Thu, 23 Apr 2026 10:37:51 +0900
Message-ID:
 <SY0P300MB08016A54D415C87EED8EEEA8CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-2-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0270:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d73fa1-3abc-4cec-1807-08dea0d8fc3e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|41001999006|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|12121999013|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LRO0/BdnJSkbVi8fisuUBMWgcHH/NPLfhrxMpLFjy8ZI1/0esjKrrGEkgd/m?=
 =?us-ascii?Q?WcagKK1TOlbAVuWJYYbIU79NTuaCRZh7tIgZR9cre2foTVZorB+39ep9JYSQ?=
 =?us-ascii?Q?JU+H95rF9QL98WAWXX0sGkYOMO2A+0TsF60HW8AecPdOJ18/9Wj7l05ZprM9?=
 =?us-ascii?Q?EQhU4jgGykDyvOGqTaFou1bvziEnSvgEhKjleTHjQnPpI9kApgAdG93yxmTU?=
 =?us-ascii?Q?WNzZIguCRWBUKIMsIQLMzKyUK5ki/Gff/9XFFdfovfGBTd2TQT1fZ3y109Tp?=
 =?us-ascii?Q?2ROvB0ewp9LISv3+K3RCN3D/XsW6rl5bAMRJB/brTLz8Gu+oCTQVz/x0qNNH?=
 =?us-ascii?Q?MOPwZ/A7bdnFqMPB0Ku3M/VqiiwmHFnqhSliFAYpxuq7vAZqgN7SVYjyazqf?=
 =?us-ascii?Q?lTEJst6M9hvkO/7pNatIg39MWuRf20CX9wiLPzaS6qO8wgoq2VEPWLEmb1Aq?=
 =?us-ascii?Q?NsYp0ApJSH9HY7VNgwU/194Q0SN+57yvk6n/5bYK9uYhmXKOKLGPE9jes5eL?=
 =?us-ascii?Q?I62xD1Wy7lpf6UJNZNNpxsk3CBkPZbXekTAqaYGot4ebSwiJdqgcr9laXZSh?=
 =?us-ascii?Q?vTXr0AVruNbR6CHaj8os7/JEW9kYrmwPkAQz0ylJYo1WUsYMMwMFNyTbnTAG?=
 =?us-ascii?Q?rOL2yRYdbmAMrRTqpZeyvZbGDJ/NVesQXO9l2qFXDw6VjrKdiBU4ljZ1Ui7x?=
 =?us-ascii?Q?50HZw8rFGtBAC3ZVm0oPuaFBEnuXn88wK6cVxoAtfCyRf4iF89clxTmZ74kH?=
 =?us-ascii?Q?K/SOEC4fzbQE8ie3mgW7mtTR7NYZYC6x6d7sZQ50yVImnGqCWi7SuVL+xrjf?=
 =?us-ascii?Q?6cHqMh8hSCgxfFj03gZDGGWea9z3ZXoRKON/hbD4UDeaiFdg6+MJ1Ze6rek2?=
 =?us-ascii?Q?7N7lxiCJeCZBvA2h4YpmT4K4yI3HKCg5BI+wqDX62s6TdYRWNGrWUzd+OLrA?=
 =?us-ascii?Q?x5fW4VpSUE8zlO6JJM4RnJwUvG5xogeIkZ9AJ7kMY6loHiPJZ5jyq5RC1bU4?=
 =?us-ascii?Q?lR/cJGN8bSU/iZh7XjWbfGHovnplEgCGi0F1tQ2qwaX4dIO3F+z635CXfMFY?=
 =?us-ascii?Q?ducQlItvxvT5U9jKSjZyA0c5CfqFCQAq+WJn7r13/VSfmBp1DtY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qq0xBnXHIf+d+NbLHO++qSzsCD4EJuKHjQLlYVaoICzC2ND1iM+TZs4BdZ/?=
 =?us-ascii?Q?eG2JkUiAu2xgNVaGoJmsabC3biOivY7+117Jv7vG+sS0Sf7mFbN7EPjhZr8k?=
 =?us-ascii?Q?IPCrab9btxD2ONDNPNgupb7j+zXO1ilgsHSyLkm04VtBFSeqx6Zu1aGDEwGX?=
 =?us-ascii?Q?x57fknfqJhvoDSUGOOxGQ6Ls5NbPY+iDEnmW362Zkp4v+j/iVwUKV2d5X4c5?=
 =?us-ascii?Q?zmbnoNJXYNwZ/jbeIZxfb9duiPJdrx1ciWQ6G/0fFBV2X8PjFYqGhocFVibx?=
 =?us-ascii?Q?BapU8sJFx6oulzre1eDrceVG/tpEe0zXoVkGBZ+FUlTmlqxdVzNiPfukhH8Q?=
 =?us-ascii?Q?NiSh4Wwlmt5X4lMmc2Z6mbeZOLzjVSuSx8ZPdX4iLcvNpExnyIXP/GytbzlY?=
 =?us-ascii?Q?730f/SaSyGQ20xSXLghusf5gYFI+4oa+ZRBTUIpMTYPv81voXE79KuUEeOxv?=
 =?us-ascii?Q?UIodlsW2DBbU3b9B9EzmrrjdY88Tn7PIXazutGJvkeggdewRG+jaaFo8ZLIf?=
 =?us-ascii?Q?XhdbevDhRmVZb/TT6w0X2S56la1LYIubY7U9+LJTV3z6YMKOWP1RjOg/XzsG?=
 =?us-ascii?Q?IkrnJL9wvXleahkaxlwEb0n4EmPZBBkeURTqKw5QG/5DZ+V/OnRqGsTGE0jZ?=
 =?us-ascii?Q?cp/Nu8+BbuK4R95F/Tc7V+1vFP8uT69KUugTLlBBGyW/HngQ5XTOxqoLw/He?=
 =?us-ascii?Q?cZMrR8pELOsvnbrb4uaP8lVgq9XD3YCqSS5ZYt8wZ/XTukx2mIsaLo2qCXfK?=
 =?us-ascii?Q?gSIxySfXq/x0JC/pqGmaXdJaG+G/p3sUeuUQ1Dzy2MgRV92Y7js+TrYwz1pf?=
 =?us-ascii?Q?NjB66e5v7ApJy4qzBzoaSpwZzrYIrqyR6euCXsVmGY0ILDijel6xdONJV21B?=
 =?us-ascii?Q?w/g2E45uM1jOm7pboAr0jcTwE/zFCUy8vIvIGkpbPnIx8NczyryhUp2EY8X6?=
 =?us-ascii?Q?XFKXxe4YcuDJLdJhbi2+luLW+1TDQKxoB2lYJQjFDNYOvOOBRgsYy852Fesi?=
 =?us-ascii?Q?iQZfsROuu+Ld3Y4Lr8iRmNDdHvXOWtrFITGJubEiMIMj9Uh6RGSD/6rRehkU?=
 =?us-ascii?Q?QSlTLwqfZ9cEZlrXae3rxI8n6tkFm5bmWsGUyOxc2l4n3c1nc5lotA2IRLL6?=
 =?us-ascii?Q?roNCKBTwN1ANdkgIyOUsi+9yEWzj6eCGVd81wwFpanTts0i7x7clI47VmDsn?=
 =?us-ascii?Q?bcCryK5hc7L3NqGOk6o48X8cmWxE9GcOfbLY5Lezb9h8wAxm0SkUkSm/dFyh?=
 =?us-ascii?Q?BPgBP1CBz42yUdnU/5Tf8++vBuoBv2qZpOxrxyU3HDpLosQb69UQyBAR9/i7?=
 =?us-ascii?Q?2XoyoXE2zmaUgacuwPj7rtD+Ua8dduzunyciDIhxlrq+sdiPgl49wq9PB/ic?=
 =?us-ascii?Q?rQ5iIGQR3v23dKJNQGPe6eGqS+oD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d73fa1-3abc-4cec-1807-08dea0d8fc3e
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:14.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

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
index a676da86f5d6..803ce2ba4443 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -606,17 +606,44 @@ static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
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
@@ -1011,38 +1038,16 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
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
2.54.0

