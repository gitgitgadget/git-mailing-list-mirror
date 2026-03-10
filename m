Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068F389471
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142894; cv=fail; b=KfM9VFEJICEMymAquu5kJwsB4HucUA3aqdEwByLQjYHf4kv943hXl916r/SXmthIxpw+KZLxKXIeIdOrNNxYy2XczGZrGjIJgqOQS4D9fGpMCX1vrD2gXCCRFboe/WcxLHCks4ftAzMVxdnaqD/v1KrIyk7rnqdOZYc1G5BKpHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142894; c=relaxed/simple;
	bh=qOxYuP1t5mkowHgTC+MbWKEk5937zV20fUakpWeTa5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZuXE6Lk3BEbHvP3SbgOCJM2+LYPXuZC2h85GHmktu2lWb2D38I1nJ5EO3Tqs8BdVywsx2/dXI+BQ8yPgXSwU2EC9nykIuhcl47h9I4k+CJys9y1vjRAdMIidmbxGfcxpOdpCXyaMfGwaMVNkXDFYx/5f/WNt/0765ov+bOe2OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P1tVzL09; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P1tVzL09"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDT5gIj6taOXZnYucfFz5EQN2gX8jkpdecvERJEaXSg6VLgmJy0ne2WLbkkRoBivwEmaPszd31b8qDNNQEysU4weZVac//oAU1+XqLU19fm83WCsSOL5e93Ibn4fFfNq9jlaCbAJ70ndPwzLeMYNc0cYg0/nhzJ3n/3jmg8t7kUBk+6RnX0c5VMFAtfVcZJrDNnFXHa/cwuuZMWPnNgNaBYBEkopcEmvUtEdj9Gi+2JHLSRj58Kk1JOuIqdwo1BJgXdiWuT+250wMM6rTEjs9vkSVYH/9YRR/KWVpPxM17fpc/3rzkbr/L6EWqpRBwjLsSdAqc4PPQgtNKMXCHkOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgJLM/ZtfvTLJcu5/FH/1VSUveqeztQ5y05K8GMxXz4=;
 b=J2UfaBwVljSWbNJujggH2h+CFwCv/Z9PyTphvedviKW3YoF5yzHfFzTIK3XM3QHNxSlKKYx82+gXryOAFEV/m7Vax7bZlVaIBun15vMu/rburqpZWA/xapYtTfbkzcn9LBqMTyVutPy61PmDGcV1sLc2fJbbwJMRWJfE0BvbRAASWP1gkfqfLpfe2a5d+3qQvFBWhBZ5vJo01UsUDzsVb6dyD8hkPBLq4benDGt9LaMi1FeKmW/lDYUMAtJnRb9gad8NPjPm3VN/xDCWTUvaZWWZ7bFxfjrtlYPnNkAWfKwgxH3WT6uydYsKCE/8TjmvOl1alQvMjIRi+pG75CWm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgJLM/ZtfvTLJcu5/FH/1VSUveqeztQ5y05K8GMxXz4=;
 b=P1tVzL092NZshEK5JEJ00vYZOr/icweVW5jDoTvwGd0jOozM3XosmUV9tmGr/belTWqB3KBHJCEl6yPXXzfVAkoCOoteizc9KZIpk4d3dFF5QoVhcNe+Iu/bBTN2ZEB/BP9utyPdxL8u5wn6FsHtnG8JTxmG7fArNqvPRKn/xhdgghF3Q69m0c1ulO+RzZ0ISwMqrU+HxgovNRZCz6cLUGjlLN4hOwqfT8m9gHuggtzmw9wUnvYukagblu9WLzxNgSOiRCKzDhT/9FmypTzpH9LCvFauKKd62CAeNJjNTDEKO6dO8CLkf1m6Er3LdlG0qW6HM7bEep7xs576k9UgYg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:24 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:24 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 6/8] parseopt: autocorrect mistyped subcommands
Date: Tue, 10 Mar 2026 20:41:05 +0900
Message-ID:
 <SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-7-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 778b23c2-7c3d-44a6-ddea-08de7e99f502
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|12121999013|41001999006|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/s2Lwytb9FCuSOejE6GBvUR2asXIqvfeDokM4+xvbb03wDD+iS251Iqdyj7n?=
 =?us-ascii?Q?uV9oSN0TfnIMlgWwL8IYM4fhGxi0dYAMTfNFqFIfLi7xSs0gz4ol+GO+N0mg?=
 =?us-ascii?Q?UmJnyAz8wKigoS2rzRJ5mA1UNIlStwkFIGOP1OZPbMDQchPmSuvWNX1ZFlmn?=
 =?us-ascii?Q?7n9LapFXvZzBedOFZAbz1daJbsTWz8Ek0U521ycgKR9SArVNI7w5ao1BcBQC?=
 =?us-ascii?Q?K4plvuV47PcdROtgF9rhGjfg3CweQPN4xaxqZFjUS4YaXsfArB5ugkaEKVsX?=
 =?us-ascii?Q?ogn/mvKGw312VGa7JcrfG4MMS5av5CXkyRXfCDtJyEcpj5CtosvIx7K/0U7V?=
 =?us-ascii?Q?VCYdD8uO5x4ZRMwjLMtAa5G8ORxFr/8zZG/GEQQDn5f4/XYeVdAejOCH2e7L?=
 =?us-ascii?Q?6Oi1EkgmLfNTwfFgr4O+TC64eWRD7eWLNfieYdvyEowZND01F/zNopEqCY8+?=
 =?us-ascii?Q?HAtQ7uszxLl5rwsN0fz7vps3zBDd3sDYI5ntmazxqy/7ftSbcv3SDSaePSB8?=
 =?us-ascii?Q?TqnzHN7pR8G4VflAvh1YYRk59dk1sEA6WTl23DVn5ufSVpbyMi1vnet7bN+8?=
 =?us-ascii?Q?rrcjqxs1Ir9q27xFpeyDfLptX0ZuN9t9BHXqJQjhGZuaIPbkJAnNVzNZ2CGX?=
 =?us-ascii?Q?zJ6ChV8wAoL8gFEYFVf/AjB/w1Oe9bmQmavxN036j3PxQQAxThAAPPHqrp8r?=
 =?us-ascii?Q?Ky14DJBxfF93mBnUJKQar4zEawPeRlEy6uCim2MZDL4vlCsAULFs+WrjuN12?=
 =?us-ascii?Q?uUT9HLmC7PHqaSTvTo7QAk7N5z/+4kEeUizK93vwGTBZUZ/pk+ktTJiXpBKs?=
 =?us-ascii?Q?87Lc0m+o4t2/1RGV+YNfn83cMEEtf8bIgnISC7FRXNg9/zpezM3R01kSuQBO?=
 =?us-ascii?Q?haH3z0pBe/u+ctu/YnKd3jbKgFEIfOzETBILInC4bfgJlgCdCIWa7owgUJbJ?=
 =?us-ascii?Q?RYVrs2Pil2M5pCBJ+oR/OFVw6gkTiQ0RULn2RJnJdVpKvj8yJsqscUbe20CE?=
 =?us-ascii?Q?Pe2GwIi+spwTUp28//q+m3lKSW5kYuB7IH3RNY7ySbuwgvE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFx1otz6e6neWkUCnknUXuGwswRwB0KdORZabGCMd51LpAUiWwBkBZchzUrM?=
 =?us-ascii?Q?bKhDy4q7LfCV/TjZB699c4q2kt3W1ezZ7O23LNcMzk21S871HdSFShSL5ZbF?=
 =?us-ascii?Q?9JIYV9LECruOE/nAUN5QMrx6heVtaRsxs0JGz8SUX84VfuMxRdPjOc4d7xvP?=
 =?us-ascii?Q?0qc1WEww5XjLKX0rpZOmRhU/1Yrr7ZWilFFEz0vyXNesnZHdqiOF/TYgdz3Q?=
 =?us-ascii?Q?zH+OCisQvGjImr67uTg44Q+d3QfyZ8KkhAZA8tLGq1+NNLuuWWzDTMP+rLnZ?=
 =?us-ascii?Q?P1A2zUZ2hNIs2cWSj6cMIaC5RZYCEPj1/jzlPjrKPV7NbNaT7Ts9Eucv87CA?=
 =?us-ascii?Q?1IluqDbyPtByc/wEqBLqeDdptvsEbfaroLZmxoJoBQYPn51gXP6KILwj9ROr?=
 =?us-ascii?Q?wT9+hdzlbdqr31EIsozsIoGGRAh2dIR7xFVkeI38pqs159Lv+nMDhAapz2RN?=
 =?us-ascii?Q?ymjFbBkRl5rxNc+gDorkpfbcXIDRe9sumxFCXAJnKviP/LPPF9ohmyFeaCxA?=
 =?us-ascii?Q?ejZByEIWdU/vNtrR1j17gwG4Ap+VkY5toEBz3ynH95TcmqhqGd3Kb4qHgVcU?=
 =?us-ascii?Q?otU7AxBsftPf7b1k9bBb/LFi1YpUgJ4q/3usJGdiOst4v+5KfsjZIGOuBnzj?=
 =?us-ascii?Q?92apOKn9yAAx9AAsrOGN1928lw0XiacbW8V/+uKJFrkwPL4Q4HtbApQQgnUE?=
 =?us-ascii?Q?8NhKqi1A3U5fAbQMMZwtSoE/xewDC3JBdbQ867sGWT9Lkc3+WmTp0k/pOvrF?=
 =?us-ascii?Q?FSNRbeIAW4W/hQBTdW+3HXljMD4FO2hBUrK2vLu/NOlSDaOBpZ6hwpCYS9Iz?=
 =?us-ascii?Q?M2ATLnUD2DkeolgYEhCEgOh2VAZ686taZDkSW042460HpEdr0sQDvyBvX6sL?=
 =?us-ascii?Q?tq4qox6SArjuM9eLwCabGPB5c8sdhP/6XmMcuR66FaxFvTGTxiakdqXRaJ9Y?=
 =?us-ascii?Q?igkxfC3rtT9zFfcNMXbhYoABZOEzJNbMlYYz1AlrYd3aUWtzYmd25zqvlp76?=
 =?us-ascii?Q?3MBHtlYfScDE2BUKHXY50UYa5EvQqKKTIr7RwCI0TmpoRn9JEvhd7U7t9c3s?=
 =?us-ascii?Q?hujMbc5xu96a6I0b8G2I3wItfRBab6WCzepNPpYEYxucRdi7io2HfbtsLPys?=
 =?us-ascii?Q?147SB5MDt5huv5vrL23XdRhDZVYGh5W6jqKe5sW8cpTMzEmtXF6L0DVGMpJ/?=
 =?us-ascii?Q?x/XZ3Fh6BkjEokH/Mu56Fpt8CKSG7Trdep7Ap+jCjjt4FuBo+H8mCvTkSxz6?=
 =?us-ascii?Q?HQCX/zM10l6ywtHul4r5gWdAdWHBfQvRaQn1Z/GMv4SV62Ujxyx4+wfV4ZdO?=
 =?us-ascii?Q?cNhHMdxO3AuAfZDYulHIXdcESnmaoCXHTBF+vGlKqmbR/byiFzn+3SosAxsq?=
 =?us-ascii?Q?XtBIswAh4pu+oDoHL29JO6QTr6+8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778b23c2-7c3d-44a6-ddea-08de7e99f502
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:24.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

Try to autocorrect the mistyped mandatory subcommand before showing an
error and exiting. Subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL
are skipped.

In autocorrect_subcommand(), AUTOCORR_HINTONLY does the same as
AUTOCORR_NEVER, because builtins have a limited number of subcommands.
Those lists are currently not too large. Therefore, displaying all
subcommands via usage_with_options() is good enough here. This also
keeps the autocorrection handling simple.

Use a dynamic threshold for similar_enough() to check if the result is
usable. This can yield more accurate typo corrections. Even though
subcommands are often short, they can still vary across builtins. And in
the current implementation, a fixed threshold can't do better on both
short and long subcommands at the same time.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
Changes in v3:
  - Improve commit message
  - Fix coding style issue

 parse-options.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 33f26d6b6179..227bc7499115 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,6 +6,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "autocorrect.h"
+#include "levenshtein.h"
 
 static int disallow_abbreviated_options;
 
@@ -622,13 +624,72 @@ static int parse_subcommand(const char *arg, const struct option *options)
 	return -1;
 }
 
+static void find_subcommands(struct string_list *list,
+			     const struct option *options)
+{
+	for (; options->type != OPTION_END; options++) {
+		if (options->type == OPTION_SUBCOMMAND)
+			string_list_append(list, options->long_name);
+	}
+}
+
+static int similar_enough(const char *cmd, unsigned int dist)
+{
+	size_t len = strlen(cmd);
+	unsigned int threshold = len < 3 ? 1 : len < 6 ? 3 : 6;
+
+	return dist < threshold;
+}
+
+static const char *autocorrect_subcommand(const char *cmd,
+					  struct string_list *cmds)
+{
+	struct autocorr autocorr = { 0 };
+	unsigned int min = UINT_MAX;
+	unsigned int ties = 0;
+	struct string_list_item *cand;
+	struct string_list_item *best = NULL;
+
+	autocorr_resolve(&autocorr);
+
+	if (autocorr.mode == AUTOCORRECT_NEVER ||
+	    autocorr.mode == AUTOCORRECT_HINTONLY)
+		return NULL;
+
+	for_each_string_list_item(cand, cmds) {
+		unsigned int dist = levenshtein(cmd, cand->string, 0, 2, 1, 3);
+
+		if (dist < min) {
+			min = dist;
+			best = cand;
+			ties = 0;
+		} else if (dist == min) {
+			ties++;
+		}
+	}
+
+	if (!ties && similar_enough(cmd, min)) {
+		fprintf_ln(stderr,
+			   _("WARNING: You called a subcommand named '%s', which does not exist."),
+			   cmd);
+
+		autocorr_confirm(&autocorr, best->string);
+		return best->string;
+	}
+
+	return NULL;
+}
+
 static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 					       const char *arg,
 					       const struct option *options,
 					       const char * const usagestr[])
 {
-	int err = parse_subcommand(arg, options);
+	int err;
+	const char *assumed;
+	struct string_list cmds = STRING_LIST_INIT_NODUP;
 
+	err = parse_subcommand(arg, options);
 	if (!err)
 		return PARSE_OPT_SUBCOMMAND;
 
@@ -641,8 +702,17 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
 		return PARSE_OPT_DONE;
 
-	error(_("unknown subcommand: `%s'"), arg);
-	usage_with_options(usagestr, options);
+	find_subcommands(&cmds, options);
+	assumed = autocorrect_subcommand(arg, &cmds);
+
+	if (!assumed) {
+		error(_("unknown subcommand: `%s'"), arg);
+		usage_with_options(usagestr, options);
+	}
+
+	string_list_clear(&cmds, 0);
+	parse_subcommand(assumed, options);
+	return PARSE_OPT_SUBCOMMAND;
 }
 
 static void check_typos(const char *arg, const struct option *options)
-- 
2.53.0

