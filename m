Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3C388E65
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142885; cv=fail; b=X5qTRZIqWNPJvhz8VIorCVf5SflVdOtYq4/dZYfFSEgIFTImQy69X0DbS4dp6oyWVe2ZWmgapAWyY9SrA3ztq+B6PNCm/17RpGkLoitoZuGBiU24GMe5wOMrlr1O5GasecgjD3L26SKbctPWSXitHjLgsTwgFAw2vBTIMn+Nd3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142885; c=relaxed/simple;
	bh=BWqvhOaPo5/aOmYyivoghU+eBQ2K/soCy1NJJNzbbXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s+gmoqaI9k8Ob04Nn4O70ZgTZWqrl4x2X4FueOkJGdeUEMY193JzDFmPDjdBi6JJqiX4rG5DlQ5C/q6/SzdZ9SW2ASCq+vwUCSK4gXyGJ9RvfWP1pzyjD6leQFAILh2Fb6Tl/JJDPrkYOtuLVt+8Te3jRkJ68+/i+XfRMonzj+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CG6oqBT9; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CG6oqBT9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d//hbkoKRw7ht0KiPwYzUbehEYD+SkauqvLfYWz3OC9Q0X/6EiYF/+Id/G1NILtP4dGiSmi7MAh/RNjvoAUGDywM79WGItjGEASmG43S0yJJmaIbTtEcAVQo3XLtEuAt/xPPzYe7Sv+AoTACLZEK9/J6odFa0pJ+VqA7PoWShDedQ/IW67CJCLvs8+MyB8L6pOZHaRlVkYvKSCjCT6XT1H1p3jDMajHcsaY2kWj36U7uCSA8J7daqG6LXupchvmRC+CLfKiLH6Q+8TJ8LGAVwUkv6Oq8v5fMSbQkyL/bIvF1dgRwstLPGnP8Eosv7Lwbfmj/k0niN6kF0EHby7HBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQZSNbFgiNO05yNgE9dRI39zCnuqxz9qnVDEIIfgnlc=;
 b=ebmkYtEYTePwQ9HcnH/W3+jU+L9WpzQjJAlAlsj2BbkZuTpRCBeNyrkRJinSOeaizhsMIyQVlg17QjVtiUrGS0nX2oGq441wat6ZqYkGQLsNBs5lhrpMOGglPTpC3Y+oRvhMKPSoLuMw7lVXH3QG9UviS7lJlMJztTjgtKrA62iDN0nkrWvfvx9nYoYgKMOlMhe3IbNowSaRFbdcbdGYZtQr30JktXDDGdMJRVOhUfVNJftO/EypsG5Nh2id+tIX/wKg4rM41f+cSXVyAvtaSRLrmbPNVhy5vqg/leJx3ffemQWCbnqcZdlPumXVklb+OmfyU7W8FTpcP4PEaxDapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQZSNbFgiNO05yNgE9dRI39zCnuqxz9qnVDEIIfgnlc=;
 b=CG6oqBT9cxpm3V7U2asY9ThWTWYlrhVcOBjWnI/k8keXwV6dTUkmkmfxEfq5U9so6bxUA+XY3rYuHfUNzX8Ba9c6+8PikZZUozgxykP50em1v5o8yMcny454sIKJBEG8sGwfA4F2fA7bwfwulQ7uUql/DSUTCH6M6/VwRBSF4XMonZ9QoboB2jsyWZkhdgHVDoOTA7OUiCkbwjueDZd3i13JHpc9qwNHkZeGzu0J8T3uPJZevTBzpD1gA8fHVa4H7+DiedHjiUWT2IlnMt69Ntsz5nXFUTb3KeGtPNqn/PvDksmTOw/hBXFxgnXhQvXZzXOhdKX/TIF0neTdbZVq9A==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:19 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:19 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 1/8] parseopt: extract subcommand handling from parse_options_step()
Date: Tue, 10 Mar 2026 20:41:00 +0900
Message-ID:
 <SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-2-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB1392:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a94dd5f-0ebd-4795-517b-08de7e99f201
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|12121999013|41001999006|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeTzemh4blTxcwpbeQifduxZM1DZXlfNwHFw6zzQJ9aQZbbs8JgBAvhVV1a5?=
 =?us-ascii?Q?RtwgHpNl73xxlppXTFf/PhO61JzPMa7rduIQO+dq3ehWpW9nLQ4bvJxLRYJq?=
 =?us-ascii?Q?0Knd/J02LHP2fGRe0T+OQdY+a3N+ePUNlqE7uGiLK3u6pdZRm8FLF3h4JHQ/?=
 =?us-ascii?Q?Y6XA3rJSlBZ1v1wSOh0VbCFLWfvB+gbC593EVm0vcNzEQVLwthc7qXzeEZ7j?=
 =?us-ascii?Q?cNIpbhPsNf0Ywo3fjDcz/SHandzqxcg76LLop6Mnvsg2v4GIec5qDlX16KRr?=
 =?us-ascii?Q?uPB+evRgmyRWUY6o/ZMuK2URu7crUKyMNj7edOT4zj2JejgQ6lCmuVjdUGHi?=
 =?us-ascii?Q?TNra/DZpsyIDiRicIYU3jBPYAF3srmOVH+bE6WLnkc9q5BTLqM2Dl9QNR9J1?=
 =?us-ascii?Q?BJnM2EVXKGrkeH8rBV5gQI59ImK1q0iRfc3sewGw+r1uMppt+lCFUof5+1cp?=
 =?us-ascii?Q?M5UzOuccMp9qMHmNso8+aEngzsAne9Hii4gn2iFXY6UgJu5rRwRiOASpX9WP?=
 =?us-ascii?Q?YJVw+woaCyMBbDzaZaZd9XQmAB+z1FP1cCmTETcIKbE5BINcij1MihGcdEIm?=
 =?us-ascii?Q?D36QsCfl2ulsZI0CK00K/0xJh2F/O9zWEfTERkqsxqfrMfNqYjeJ28HwMovs?=
 =?us-ascii?Q?VfTZlV/E3Q0+vjyN2sL0JpRadObkxH2ePjuWjW0kjZAOXt1Y6bSqPIB7QQ0Z?=
 =?us-ascii?Q?vriNeLfunumfl1tVn/K55T+4r0LHaLcxHIkbK4rzSAluvfqWLCg/kFLbL7Tb?=
 =?us-ascii?Q?F88IOUYWfFFM3SA3BOuLUq6w6He1rDRo2VrNLWnHSUHkUHdAbzsx+EPZ9ZBm?=
 =?us-ascii?Q?5N+s0huukILZ/wTItYcUunwhF/vZhgU+PnEF5jz+ANzvKDhTHuGQmh/unchd?=
 =?us-ascii?Q?ZdVNcfVU/Sd+lhgZw2Ddni6jKXPTkpPdBbjoGe6O7dJjHjC9OTh2W/8D8TuC?=
 =?us-ascii?Q?zsS9C62nRnxoPf2BHUPTq+J86f6MCi8LzqYOj8upZxJE2YHQVR3S51X35Uxv?=
 =?us-ascii?Q?KdqmflBDSDWjidGD2cK03ee/PQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GairA2769www4faV/Pomwe8VEDY/pSzM5Zka19ZhiiN5u3pE3R9cvBcYBX4v?=
 =?us-ascii?Q?KFVDT4vyRgY4eTw9UUnnjQWz0YizBF8fazYnL+ZbRXlWg33ixg/WwQRrN/eW?=
 =?us-ascii?Q?fsUyOJpsCdrZgcRrtAuSE6Ou5R9365TH1cAHCxQ59aiCfcpnxovQQoSIFEa1?=
 =?us-ascii?Q?We7htd/IGFwYhTIm+/tK+O4VekRKk9eYK5OmX5vh55eVCDC9+8rccRAyZPyu?=
 =?us-ascii?Q?SKQk2Bsu7BpsiiyGcXvxynLEtjwVm6DZgX21rQvIbqLerHPeBX5gb5FVFzG7?=
 =?us-ascii?Q?PrtbtcJsanC/JrmKkAI7e/EliyLlheCxXP0QXjXizd0unEA5tb4T9pobMmXT?=
 =?us-ascii?Q?lWEGI539vpds2P3GlsCi1a3BYe0XKHuEnJuX7O95sEuTEsRbSFhYLwloGByE?=
 =?us-ascii?Q?/Saz+mdOKzPnCvaiNzdqeIQSQnCtqhoAxu8pRGBY3xqRuuB1lbU/Oyq2TtIQ?=
 =?us-ascii?Q?iPnWXBybtoQlbTsBUFtiBQEIq/W9BQCnZKTOyln0fr6ONrIDErASxH8XnMjg?=
 =?us-ascii?Q?l7+GfoxDAWsWabZL/EpseA0ZUuXajXA7pqPaEaosInZH68gsGWJcs1IRFt70?=
 =?us-ascii?Q?jA4XqPhggx7CN9qCIpDKqM48TD9pPIO+KYGadztJ3jT7nWd+ESoLuLMYoc8t?=
 =?us-ascii?Q?Vw0d89iJcjTYrGspqjP4L4N+h4KTYCr8NgVXyvxxUEIVMFYIGtMQaG45JVRM?=
 =?us-ascii?Q?+0ms6zC0Etl4FVvuKrThi/eRPDK3GZMEIFXKcROv8wJ5id1Yyv5UH7RI75Dt?=
 =?us-ascii?Q?BFqYVqSs0CR3yGJCWReiHSEEfeCj0m+pbuDxClRLRCW57q/OQ/4nQcLctW4f?=
 =?us-ascii?Q?kXRM22S3/XODNyfuVfwoBIpLTMEA/ZZi9ESbvZVREFYvMxvAE3GWOGeUKrlz?=
 =?us-ascii?Q?eMSj9sH8nfnwW62WNOJ4WcFXKRYMtY/5/df9yB2CDg2FC3bLF8DkaPn8bA4H?=
 =?us-ascii?Q?BTFVZHYXavKxabV84lzg3nvrfFAma0kDOOQXxxlImyFL46wEWlnpS1dvKMXZ?=
 =?us-ascii?Q?FngoYd2RjT0dASinjiNx/p/+GVWcuDxZr8t1G9ilbZfvy7HIppxCh4i5iFKg?=
 =?us-ascii?Q?ZI0oddqFjFbROwaQe/warqprlxGwBACznH66r4aEsLYG+nGWFSxvYIk5tOtC?=
 =?us-ascii?Q?5hv+e6VvqASuTtlOzzOjaRJVecygMvuylCcKp0Lqi1/PiWw5WBDP8Q36p/kU?=
 =?us-ascii?Q?Q6w9vcbsKxKs2deBnS5LvNWnCOGuOlSn2UYtIXfgoBNv82bKUgz0HddhBZvz?=
 =?us-ascii?Q?2C2UZKBfc/U7lLMUpFEcas1YqZret3ewW5IxNDK/WxvuxL1b/0wVNBpUZaAX?=
 =?us-ascii?Q?z3YobkokyvMoEZIQEwpYCB6Eoutpu5LiQKz66RTrWxpi8L8s2K0KPFa2Hlvb?=
 =?us-ascii?Q?T1FjwDpr0709mvp3jG0TUOIki03b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a94dd5f-0ebd-4795-517b-08de7e99f201
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:19.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

Move the subcommand branch out of parse_options_step() into a new
handle_subcommand() helper. Also, make parse_subcommand() return a
simple success/failure status.

This removes the switch over impossible parse_opt_result values and
makes the non-option path easier to follow and maintain.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
Changes in v3:
  - Fix coding style issue

 parse-options.c | 86 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c9cafc21b903..33f26d6b6179 100644
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
@@ -990,38 +1017,17 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
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
+
+			if (ctx->has_subcommands) {
+				return handle_subcommand(ctx, arg, options,
+							 usagestr);
 			}
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

