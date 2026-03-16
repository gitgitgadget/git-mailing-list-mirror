Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D73A1E73
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675410; cv=fail; b=XPPuIHc5NTZn12hM7i7OekCHBY8gZSpWW2GanvT+jdpFwgy/qqLyUZF+o3f/QY8gc35/aK+QXvqINjJulfTyZqZTrg5cNc2Un1+I3sQC1L9cjbH9X7xY7L222yQzmcmizFg3kDsZEbhxGWKUyW4D5SZFo8KAszRXeQgJa1/D1WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675410; c=relaxed/simple;
	bh=fasM0caaK3oAdO1yUtr75ta32FJFHlcYC8a2six1XWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHnzhajA1itN/sRa+qTMh+IiYImA3MH+RFQaovxIJC7qeuUeGIaOECvpMC+hFXIsOmhfCdLbdM0FMWpspcwZBbvCfVH2SfBPfRZz14wiNOmtOBhzDubcxiVcbLv5S/C6qKkC+eoVaOMGn8e87zeFmPk82oNwAYLNU4/LP43ZZLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=okTfpPTA; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="okTfpPTA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nugPemtd5YzdHnvLWNvpcxVy6Tz+5GkKCAh3BUVawXP9hxFPACZ5+VeY5cCBrWAHHBgjS+QaQmk4v2YVnY+kdjv8gSKiOhHww54ejwTzjnqTFbhkC71FqmloVL7DKbOwmAuENSse4RfzLlLwfeFVtu5cBPTZfhdnxyA0ZXB7smDT2Y/r5e8At0LHNiN13iHJKB4wIVaUWGItL5hcqDK2qbkY6P9g1+bnQ3zZl8B5rag8sMdolT/xmCCZwUdaGfnk/JUc2ptPt8CtaTZaZHnqY0JDEaAkTmgQxlmmwATKzWk7GmCdV1EosYgjqCovkVdHReTCfR/NgYABLsS0dmO6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vau6JjxYsIcxIYaOkJO1NPodm4ufSZdb5VfcXVA6qY=;
 b=lz4A7Ust7J3VfG6wVs3Ld0GY9bkkcWOJbI9jtS5fwaH/NoDqVQ0qvVX6xujsuUi4rTEdrac2iyzKQ47EQY3WCw2Mc+YyuR6DbyHNF6w7XmfBiW7AYIUMvH5l/4mI2QzfgT8LlomYMm3DGeRo5biuOfQU/F4pT7slz2de7bsUpKDqyFff0LmQaSMvhLShMQmmLPhN5T9HYH65OrHWQhhQ7xIiVtsxlPHYFlnPiPUbiAWEj0wNc0qiCQagxe4bj1aivJTOW8+V6cj2nckvrCxWqcsCFgjKvnIAN2OLkykYcrGY4xWi1/ElFxKRm/DeMJ3drqZhlI7QCOHXgGwxz3Yvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vau6JjxYsIcxIYaOkJO1NPodm4ufSZdb5VfcXVA6qY=;
 b=okTfpPTAb9EcHxuqkaKokwrCi9zBNtgyjNRR8UP9ZquLhF2MwBSF/AgVF2ESfpWmJOR9jkhWQsu+/FblGis9C1EPk0DPx01d5XdmQRGh6C9QiJOkk1/YpRqcpi9RRVvTWROkHzsRWtJcILImMsa8koJoTeFaMk+k7Pbw2Mg3LMCRFHk2A66MbSINyN5XQIf+DzaZfDH8fYlpt8d0gz4FC2DPaZsZW7FIKL+dt0aBORNgCUBxJnslRSAqkM30osLzoy2y6FpK06jY0Lawgn0FJVmmXVHlwxIGsjPz68Q/1WYStCSWLOba0DGvuSwsVk9OIMfiqyrpPW5RLt97VSbjbg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:41 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:41 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 06/10] autocorrect: provide config resolution API
Date: Tue, 17 Mar 2026 00:36:19 +0900
Message-ID:
 <SY0P300MB080164A69A247148EDA79F38CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-7-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 10eaf10e-e8ff-4b43-a7fd-08de8371d1fc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xa8zlZiSuf6hMULxqYfApnEiJ0PDe62iJNg7uAIyl2o5xAd0qPJ+zVszcZpl?=
 =?us-ascii?Q?Vaqn4zVGcnUM2CirBgaqjMQdppdHV3YIZf8AqkUCzHUAUUcJR6DqCYFqR9Bl?=
 =?us-ascii?Q?y0hBecT8BxX8BqTecg+21qIvH/BylF98xFjwjFxuLdJKWGkc+GXRryaY/cfA?=
 =?us-ascii?Q?9D3VZH+5LEfS6jynQ7fXzC1h9vyUdToK1ZAuflyEIy1jg1A3jYS3NjoVPElp?=
 =?us-ascii?Q?SOrNU4W8b3OmKhvyUPlpCE3sg72CDezlzPsy+1M/LUgdb1byjOcwObtPoYLq?=
 =?us-ascii?Q?KltNV5KpyxkdaKpT6WQpGDcGq8fNOZ4H/evGd95uwh8m4vaJHmlp3zUBZWW0?=
 =?us-ascii?Q?ufQhNZV4WtCgI3wzoo1h0Cj8ZYF1Lludorr7RkwrflnjJiZSc60F9hprvbIk?=
 =?us-ascii?Q?cPC74A4VGfWKprmACauog6ii4u9T7zF7CaA3Ewtf4Yz4GjW+QBDgRNecFFY9?=
 =?us-ascii?Q?4H3ptsyqX1u9z/yN4cibcmujbUfUuhttcqHNIlYTZJPMRQ+rX7O+dHctmz8J?=
 =?us-ascii?Q?qk0SvArtb76U+GpLJGDComWBKAOy2dSZfTR1nl/g6IATKcjiuMq17a7xplm5?=
 =?us-ascii?Q?tL10CmP53HRv5vewzcQ/X1jGCggK1dQuZRwRr0HhFLIKyno/t+0IJNWA+CUP?=
 =?us-ascii?Q?XdiDrGZ2h9tqaaE9nSyhzD023dm2HUQMiCsyqr2v//bRQBac5ws/tzyklH+q?=
 =?us-ascii?Q?8ptVWAkYVFZIgpSlWjkPFwZ/uDcxKsPAkoF+ZzavZ9tnBnowt6KaSHGBNpVq?=
 =?us-ascii?Q?+9lf/rg+n8NlPO1yL3SqzzE4MsbISCtfoIyftz7Pv5H+TvQw+kt7b8xcwN6D?=
 =?us-ascii?Q?GxGkMQPSM8ut46ZS8Pw/eKk8oHbO0a3tj8mV1Yv63ftMYYWWe/AcfCF3/xze?=
 =?us-ascii?Q?sEVVszkfSHIKDQAtt4Ulgf8qGo+hvn4XcrQgo0xpq55kkZMEAZogSrP61RtP?=
 =?us-ascii?Q?IDZb0E/yWHl0PvJmczW1Xb3/D4daaO/2QGxJv6ajrG4oAFxV4dZ3fLsQ0RWw?=
 =?us-ascii?Q?XijF?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JZoY8N1euTvteudNzIf9oNK7VC5YaW5tal/pNH7DaworTtUyWYoRUAkaIe/?=
 =?us-ascii?Q?tlQ7sG1Fv8YLfwR7AqGu4VlKiK9YWXz/4bEypnG6+Atn1XLx7VGodDwJQUb4?=
 =?us-ascii?Q?2hBnQfP8csyHjp8C7n8/GOV6WNJOvm2OzWWlS0DgFf7JkGJ9vct3rC/TFJeh?=
 =?us-ascii?Q?+tzfLjbqTba/gh1Ig25rhx4iv9w7xcixVmLHVApZCbanQHCK/QSnfhhJRnsR?=
 =?us-ascii?Q?utwLhuyHocIq74yuky35vi40o5TPfa/KIEmsML2u2zHGcoG8UjVzE6q0fXRQ?=
 =?us-ascii?Q?6YoS3lyHudSiqwZvoeCo9i3nPudXxyJ3jTdz2upsjckl10NSwdV2yiJFPj1y?=
 =?us-ascii?Q?XH3Xnr/cOjWNdpbl8CZJAM6nD60Pa9BPND6lMl4/1DLDz+7WvdbntRJvVJ4T?=
 =?us-ascii?Q?wEvwgB0iRphunTMvHYW1FvjklDVm5JQG3yW2CUfOgL1jTKNfiI8ozFvc5pgA?=
 =?us-ascii?Q?2cAZxWwsCEANpW98Kik6TQK8S180NKA9QN30SQd1Ifa6Y2tNd8PySQWdzw+/?=
 =?us-ascii?Q?5zdgkRbRi14v+GD5UIN7XnI9FbwIkuOu5CeQdfqHx8AaLacc4QPlloyuPTcj?=
 =?us-ascii?Q?D7NO/thqnxdaR7n5dzW4ZI5BOmQ/+JSwbshndeoUrO6355pBymXjnzJRbPdi?=
 =?us-ascii?Q?iIoxNaicCiqbEVv6fazeQCCBdRbvdQ8qfNzhKMDpovBDvOWG6rD22lkcBHAv?=
 =?us-ascii?Q?2rNx63meIZvMjk9tLuqczHwvGRTn7QB3Uz0p3MCo4ShLsaxsFmyx3c/f1hQH?=
 =?us-ascii?Q?SaRiVGYNJrmT5Mh4QiX9m/V5BhupgGYpHBMwV4tPjXXOzUIAQ9MjzIsJOPJZ?=
 =?us-ascii?Q?jcu+tYVTeAyBozuRyrl5WN+HN+qJx83XND1dagxlBYZ72JqJbK83yP/BNMqg?=
 =?us-ascii?Q?0DP6L21m1lXDygtm/W3KsGrA9sM28t2juacLAB4MRxa+EeHKHvDEWcwLZfj7?=
 =?us-ascii?Q?A6cm1jqG9uz4g9UfA99b+HlbBe512rBk47id7FbN5WyzlW/YSnninyPS3gwF?=
 =?us-ascii?Q?JcY9a6uBRytga2lo94+RKBHRG7tL8md0sOOlKUNIKDPyugm0kxEku1KBtegi?=
 =?us-ascii?Q?VXa9QHSLiZIU+CywoyyxoRXltALfOpRCF5rCL96mncsxIA2jhPuVNFdLWSdY?=
 =?us-ascii?Q?VeQYPMnOBH6LlbRQgM76/V+npVmlC8MVK2jT2+ZCc4ZtF6ZnZcsi4yg2LrIO?=
 =?us-ascii?Q?e4fhguFPODrrE7ebgAtgCmK1viDTmlMjJ2T3Ysk0+ud5R7gieU89e1Xb6SOA?=
 =?us-ascii?Q?dCtUMALnNPiYSq2GWM2uQcv53C8G8E5v3DNRd3K3H4j37EhwcCdEvwVDDSbT?=
 =?us-ascii?Q?18v2woXKACWopMkHWv1l0hBvvAyMZA6thM9o55erEgiT+8rCFvXCSWZcsRCi?=
 =?us-ascii?Q?v77bWvErFTkqP6Ot/kTRWduABjPt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10eaf10e-e8ff-4b43-a7fd-08de8371d1fc
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:41.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

Add autocorrect_resolve(). This resolves and populates the correct
values for autocorrect config.

Make autocorrect config callback internal. The API is meant to provide
a high-level way to retrieve the config. Allowing access to the config
callback from outside violates that intent.

Additionally, in some cases, without access to the config callback, two
config iterations cannot be merged into one, which can hurt performance.
This is fine, as the code path that calls autocorrect_resolve() is cold.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 15 ++++++++++++---
 autocorrect.h |  5 +----
 help.c        | 40 +++++++++++++++++-----------------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index de0fa282c934..b2ee9f51e8c0 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "autocorrect.h"
 #include "config.h"
@@ -29,13 +31,13 @@ static enum autocorrect_mode parse_autocorrect(const char *value)
 		return AUTOCORRECT_DELAY;
 }
 
-void autocorrect_resolve_config(const char *var, const char *value,
-				const struct config_context *ctx, void *data)
+static int resolve_autocorrect(const char *var, const char *value,
+			       const struct config_context *ctx, void *data)
 {
 	struct autocorrect *conf = data;
 
 	if (strcmp(var, "help.autocorrect"))
-		return;
+		return 0;
 
 	conf->mode = parse_autocorrect(value);
 
@@ -53,6 +55,13 @@ void autocorrect_resolve_config(const char *var, const char *value,
 		else if (conf->delay < 0 || conf->delay == 1)
 			conf->mode = AUTOCORRECT_IMMEDIATELY;
 	}
+
+	return 0;
+}
+
+void autocorrect_resolve(struct autocorrect *conf)
+{
+	read_early_config(the_repository, resolve_autocorrect, conf);
 }
 
 void autocorrect_confirm(struct autocorrect *conf, const char *assumed)
diff --git a/autocorrect.h b/autocorrect.h
index 328807242c15..0d3e819262ed 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,8 +1,6 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H
 
-struct config_context;
-
 enum autocorrect_mode {
 	AUTOCORRECT_HINT,
 	AUTOCORRECT_NEVER,
@@ -16,8 +14,7 @@ struct autocorrect {
 	int delay;
 };
 
-void autocorrect_resolve_config(const char *var, const char *value,
-				const struct config_context *ctx, void *data);
+void autocorrect_resolve(struct autocorrect *conf);
 
 void autocorrect_confirm(struct autocorrect *conf, const char *assumed);
 
diff --git a/help.c b/help.c
index 2d441ded3f14..81efdb13d4a3 100644
--- a/help.c
+++ b/help.c
@@ -537,32 +537,23 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-struct help_unknown_cmd_config {
-	struct autocorrect autocorrect;
-	struct cmdnames aliases;
-};
-
-static int git_unknown_cmd_config(const char *var, const char *value,
-				  const struct config_context *ctx,
-				  void *cb)
+static int resolve_aliases(const char *var, const char *value UNUSED,
+			   const struct config_context *ctx UNUSED, void *data)
 {
-	struct help_unknown_cmd_config *cfg = cb;
+	struct cmdnames *aliases = data;
 	const char *subsection, *key;
 	size_t subsection_len;
 
-	autocorrect_resolve_config(var, value, ctx, &cfg->autocorrect);
-
-	/* Also use aliases for command lookup */
 	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
 			      &key)) {
 		if (subsection) {
 			/* [alias "name"] command = value */
 			if (!strcmp(key, "command"))
-				add_cmdname(&cfg->aliases, subsection,
+				add_cmdname(aliases, subsection,
 					    subsection_len);
 		} else {
 			/* alias.name = value */
-			add_cmdname(&cfg->aliases, key, strlen(key));
+			add_cmdname(aliases, key, strlen(key));
 		}
 	}
 
@@ -599,22 +590,26 @@ static const char bad_interpreter_advice[] =
 
 char *help_unknown_cmd(const char *cmd)
 {
-	struct help_unknown_cmd_config cfg = { 0 };
+	struct cmdnames aliases = { 0 };
+	struct autocorrect autocorrect = { 0 };
 	int i, n, best_similarity = 0;
 	struct cmdnames main_cmds = { 0 };
 	struct cmdnames other_cmds = { 0 };
 	struct cmdname_help *common_cmds;
 
-	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
+	autocorrect_resolve(&autocorrect);
 
-	if (cfg.autocorrect.mode == AUTOCORRECT_NEVER) {
+	if (autocorrect.mode == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	add_cmd_list(&main_cmds, &cfg.aliases);
+	/* Also use aliases for command lookup */
+	read_early_config(the_repository, resolve_aliases, &aliases);
+
+	add_cmd_list(&main_cmds, &aliases);
 	add_cmd_list(&main_cmds, &other_cmds);
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
@@ -674,18 +669,17 @@ char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 
-	if (cfg.autocorrect.mode != AUTOCORRECT_HINT && n == 1 &&
+	if (autocorrect.mode != AUTOCORRECT_HINT && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
-			   _("WARNING: You called a Git command named '%s', "
-			     "which does not exist."),
+			   _("WARNING: You called a Git command named '%s', which does not exist."),
 			   cmd);
 
-		autocorrect_confirm(&cfg.autocorrect, assumed);
+		autocorrect_confirm(&autocorrect, assumed);
 
-		cmdnames_release(&cfg.aliases);
+		cmdnames_release(&aliases);
 		cmdnames_release(&main_cmds);
 		cmdnames_release(&other_cmds);
 		return assumed;
-- 
2.53.0

