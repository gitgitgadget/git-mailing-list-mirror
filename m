Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377F1B394F
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011841; cv=fail; b=JPs8jezre6JdUSaGbgKXsb0D/hWiU8wMMCuSdKhsImRGRnYCENNXIfB6qPNJAJqkM84EYEgCSzJMlKYpAkjEwA+NUpsnvah4qijXdLR3bxSNw9FTFNHWDRfhXZjA+105q0SWevrM2ZPQ1NEEWwGj02s/4OQfPGUksMdREGq6BFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011841; c=relaxed/simple;
	bh=KRUgNq3jXHYqMaLPULWiwE9aUb94LM+rid16mg394ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOxu9GOzO9c8wiDcfcgkxgrU1E3RyTgRJgaUj3oU4YWiTaPvSfCUsm35QARST9U/b7li6eFH/Ra6H/S5EhU1x85TkAng5VWV+UcvYLfvKmAevdj1jN6lSpe4lxwFqHGhJgNTPclBPv7AkD/mZSxVXEgARRJ6pIxKmifH+gysrEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kPoY0xjI; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kPoY0xjI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toHXIcReVuq3lvvAITpWOeDCXJU7lIuH9JGo6sMgS7MQrsUDiqoNIKHNvnEoID7rQFskYQAkbe8eIHLaz1jruxejOR+MEePCzOemSlDsyRxe1Kr2lnyw5FXr6deUwmsSa5k72LQl0myLT8iT2/bqK6T40ErdofOpaeuR2RNE3JKU9JdLVMdVhl1PfeRf7ogT+53jpzzWUjhX8a+TChbU7lZRZxcuSTZCsBa4giUogZb2IRmQrDMH2MT6rmqHh4UykVU615FBZOunWnyJp7cm2BifaG3phG8kHeZgBvPyvXJs/E/iym8yqODdlbWpEu3abzfW88FL4KnjrtkkRWIz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbyflegdQj6BmgtKV4GiR3a7X0MyYY+vShCAEuwbLRA=;
 b=b+QoDHVvE77Ntn6J5NfLYvsnFhGpuWfthUkUuoQNSsvDT7FKf08pIfoLA3yLG80C+uy07YR+d9mcq48PIerQDQ07fZEIQoE0hjoWunRBkcghku9hBQuMZRPIDOoaFtwhCwcq1TJjA/iUzS5W0uv5MI34ceqOtF3r6ItoFVfsuT8al5zJz0QL5aRYg25fmOo5hKBplrDlO1xfozwssTL+jnjWrEXliFT0kO3VRJhPfzBclMww5NK3qgocn+XfiUGI1re9BA0d8lFkJszq34mtLLhTaEV2qZnw3ekd98n+zAX/2Fe6F3/7d+nwQ2DOVpxV83Aq4Ay353FUhHm02It8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbyflegdQj6BmgtKV4GiR3a7X0MyYY+vShCAEuwbLRA=;
 b=kPoY0xjIksjmTzAW9FaW/VvzHu6KxKURs+lxV++H1g3JNKmsLRBJNWs2J17zeCs/Hq5tVe8/fCaqb37xDcf54SvGc6DSjrn31KZ182dMmJ/LORkNTtHL5zoFC79wwDw3KVo255WRHf1AtSyj4l7ik3J3HxJ8M4XUQN178WTjtYBc7x6BSsREEFQB94qkRovW4AUe0ZeGJRg+Yo8QmIpH4rRjb3U5RJQfTQu399lEF6KafMjEIrnFw7azFGdwKfA2DASA77rOGccDc+KgHH8ra++m17tHmtjp8RvZiHvJ9Mny6xKwvX0Mx88kRA9QVq2HiJ3aekPgrbjbGdjgntmLQw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0653.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 23:17:14 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 23:17:14 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v2 1/5] parseopt: extract subcommand handling from parse_options_step()
Date: Mon,  9 Mar 2026 08:16:55 +0900
Message-ID:
 <SY0P300MB08017CA1F4E85F606B8FAE28CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308231659.2354924-2-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|ME0P300MB0653:EE_
X-MS-Office365-Filtering-Correlation-Id: fa037231-d6e2-4e58-6902-08de7d68d551
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|51005399006|41001999006|8060799015|25031999004|23021999003|15080799012|12121999013|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2ApwNRgnRJcrSyOoo+eBStb/FyfntAMyhipGw7lxIGQWoST2Chu0a3ybq6S?=
 =?us-ascii?Q?5E5nOk8Ddsw+XBLwHYbmCmkMAC8bIiUzpXC1IR3H6Ha6bqOw1gCDUJoOhTvV?=
 =?us-ascii?Q?YDYpvhqCfMUWamtUby31kIBNGMdBUvxErekCjKVyUWj+pXefCbMsfnwqC/SV?=
 =?us-ascii?Q?GoAfNSq3VFoK85TegjKNbN+TMZhbrLvwXikuDE32w5TXgrqhGLvjMzDgsgWh?=
 =?us-ascii?Q?hRWhfxYRKnxmRBB3eSuJX2OaNrVrSwk1xt+q8to7K9oeUoivDbaJ3XbUjL9K?=
 =?us-ascii?Q?IiJrecPKq0TFm8lxuCqT2oh6WlcRK+Lq0pOaiPvuAc2E6nM+Q1dfONExx+Ha?=
 =?us-ascii?Q?0qcRR/2VzGWdrenmrXst8WJZM9FNyiWruz/7DzwzYKv7021pZr0zUxC+rfWG?=
 =?us-ascii?Q?eN2zL4mMjNbJW5Ik4bXCkjr7u2Qze6sUrJLobC6nla6S0zHjDQ6Ru9myPsIW?=
 =?us-ascii?Q?ttfYypV2z5KSzLjaVYPa6LcYMi6XBJGsvsBwH6cwVzTlNLKKzKz9zftPmp6n?=
 =?us-ascii?Q?QdTFGf53nUPONv7IFqkTJ7IrBu27+2Dr+SiSpMoKjJ8VYtvnzNmt+Gg0rd1J?=
 =?us-ascii?Q?4cCm50x3cPfnS9KjOI54ltxd+hu0L4OBiUbud8PmfCyDEfA4T+m5SlkFowjD?=
 =?us-ascii?Q?7GxuN6AKu8BXt/oIbKnNPSXGc2kMLaHrdIAohMa1IG6AMv8ttzScH6URw+S/?=
 =?us-ascii?Q?ecwxBOV6CiBVKncm6CaFFF96nPsNgWxeSVY/+pDn480EY/Y8cobpQ1bUHe0E?=
 =?us-ascii?Q?Jq0NUhTOkTHB9rC07d6og4hd20KMwOef2NyZ6CfBpPoXRij9GQwA57FCPO+O?=
 =?us-ascii?Q?Bnm4s6ilHBhC50NjJZ3hZskXoyU7zaGHahHPI9yNACCHDd8WXZs/JWBq00go?=
 =?us-ascii?Q?oVWfCSnpMqUqFYpaBkqpu31+MYuobY9v5LOcAv+ju99LuQbFmOn7LmFQIEy/?=
 =?us-ascii?Q?P6T0lwtTVoeFzLC0Np5w2KihuLHPU8htG/XzI8U/zcEsXddZTnnqsGYiTXp/?=
 =?us-ascii?Q?Wv56UFkCDRrC8S85ZSLSAP92EA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CaMD9lhXkRWSJRSbwYKdG0E2X1e4Z+m5orPOGubcEaJG2qF1SnCj6Sb9MdY+?=
 =?us-ascii?Q?fRXJbRnzst0Tw0JBGc6zP7b+8oL7bCgmv7PicLYEAK2Y/BPAhhPpMCsoX4z2?=
 =?us-ascii?Q?pWZNADpxyB8vL2iC4cNAo27wVo6HlSCruHCqYCxXdFrk11DLAegzSZtIrI/m?=
 =?us-ascii?Q?wYbj3VT4FTgI0sKLwSEFUHXPq5I7+0Dx9ihgzxvDgbEUbTUYBKkfIQY5M8Di?=
 =?us-ascii?Q?Ol0v8QuShI6R81w+m0nanpseOxfqBYJbPPJ2MZJpb92evopN1j6Z0jZVj48T?=
 =?us-ascii?Q?0Jolvh5Oz+SRUe49kN/fI2vXZE7T52AOdCa8sbCxiLdyrmgNbkm5udpsMdcN?=
 =?us-ascii?Q?TSmWbl1pAbb1eBOdk3U54uIMTvWrUONzfLDe9WSNbUsPUQxqdW27xfnXkiYH?=
 =?us-ascii?Q?MgdzwdhnCxGDXHnb8/rh6Kd8A5XPFQpJJDTYHbfYpNbC0HGlBgOIP5wgCKOr?=
 =?us-ascii?Q?C9oQlkBRgkEKScWpGCFT18w5OqMHwwaInXqVS6lGMG1efzsI7wGov1JaR4c1?=
 =?us-ascii?Q?6V+U1ArR0vJ1M9UI8ti+PeV6upy6f6grHMwhd7ygLv16052375vjWrXj+S3S?=
 =?us-ascii?Q?xqxRZHSLP/bunV7eV1TyhfcoC1ER+xZUJavxLSU48L0T8Wy1BgeND7y4Zrg4?=
 =?us-ascii?Q?Io1SKF36IVJHie29LKj1R4ydQ1bAvDVCSWb1Kgd3nZn2ym6o2U/uLW2VH9kf?=
 =?us-ascii?Q?P/XbPTYxvhS4gLO/nVM3TApK2Xun/T2JRg8tbBXEqg65/DkKVOH+BrLAJ9Ap?=
 =?us-ascii?Q?0yQqp3GmtA0YJEpcE0IhwPmE4qxcHVQ6AJ1TD36Qyh6C21Lj5wpdbV3TnrOL?=
 =?us-ascii?Q?k9LOIKxkUwQoKtCvJKfTr0kFr5LHSrZjkBpGxVBsYwBUhuMvHoCUeh4ZtN0j?=
 =?us-ascii?Q?fAySx7x1SoDPxjyGA7hqlltu3cynxcvEv5eL7ZcwIojhwxfk5mNpdNhhrUw+?=
 =?us-ascii?Q?bs1/LarAZI+ruc/DmEU5iWUBgvqdSzquwbbZ7D94FzARw//TRdNBuj+ysAUA?=
 =?us-ascii?Q?pSjX4raAhjPJOwylYVLp7vzCMEdWij1wj2ENHSw0ujuCk9p+cmtcWzT0bfQu?=
 =?us-ascii?Q?FYMJrqzoYRyN6LWbucbGFo1K2qUBuktmjywZTS4my8En7vGmvCzBQVI94KMm?=
 =?us-ascii?Q?hQ+7OAy7abg7rgvTq8buHubp/uZEU0CC/ljoxGnvDjCO81H8NsvzqOmMtpAK?=
 =?us-ascii?Q?Bu+W+BzGTFGyCdORWYqfSeSKiLeBBH/NRtmNiEj2QnQYM2y29k6WkXP0WYsk?=
 =?us-ascii?Q?aGE4sBtibIqVSkHibw4b1EE8W776ENQfkxOZ/SxXpJAkEuK/nJPMjNd/ZTOi?=
 =?us-ascii?Q?dxiLtUmo+Zp/IWfUy3KvZlbMNZdCwO1UQIuDXJuGkDQYtReSRa8cW89Mrqce?=
 =?us-ascii?Q?Le1XjX6shhdp0ZqgHRMxNd1Mouca?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa037231-d6e2-4e58-6902-08de7d68d551
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 23:17:14.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0653

Move the subcommand branch out of parse_options_step() into a new
handle_subcommand() helper. Also, make parse_subcommand() return a
simple success/failure status.

This removes the switch over impossible parse_opt_result values and
makes the non-option path easier to follow and maintain.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 parse-options.c | 75 ++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c9cafc21b903..6bb0c5697099 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -605,17 +605,43 @@ static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
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
+		if (options->type != OPTION_SUBCOMMAND ||
+		    strcmp(options->long_name, arg))
+			continue;
 
-	return PARSE_OPT_UNKNOWN;
+		parse_opt_subcommand_fn **opt_val = options->value;
+		*opt_val = options->subcommand_fn;
+
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
@@ -990,37 +1016,16 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
+
 			if (!ctx->has_subcommands) {
 				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
 					return PARSE_OPT_NON_OPTION;
 				ctx->out[ctx->cpidx++] = ctx->argv[0];
 				continue;
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
+			} else {
+				return handle_subcommand(ctx, arg,
+							 options, usagestr);
 			}
 		}
 
-- 
2.53.0

