Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07740388E65
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142892; cv=fail; b=HAzdAUkhVPIeTEGux6XCKaucgG/PFPWlzfP5lc5Mi0ECDbWHhz1q4JRoVkJ+d6rrbhPUuuYENv5EnKs/S5WGlxEsHkGF7adoJItjrD8E2rHvCi1NHAiilqtDJmizcKLIxOTr+dL5a+UiiAchC9koqgVH/Ovc9UDlxnrTMIrY/zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142892; c=relaxed/simple;
	bh=WyHJkYOgfj66M8PlAHkyknXNQKlM3ofz/C+P0FQux1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hno3Xm6ZMpAMXuR4zRmOI1iaukh/ZiHvgZ+7w5KfM/Rmbz48wVPbcBGsTINKvTjHjE3n87AvnAK3JV+XOKal0NW8LopHTnaLSgyWH13MI5MZ2hykx6UTolfC2vQtnP5RLa9msCJ56D+OLAslepyBCloAQpzRe6inGAfBkWDE5p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nLIfnhCu; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nLIfnhCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUcrxPFaFaOCWqDBWDJPXfc51N64Rt7kajoGrZRP1wZdWcj/1qI8Ul/vEUsxy6yPFmOfQBYNBEavcIXZcDPRNyMRkagj+/AmJoCautJvfIfoffgKbpqopSV6o7FFLsEpjU0c2mDlVunYQlQZNqpbK09UNCMb+dbUzqjPxaO8c3t5shhQSocygLltdkX2wNRzfcw+tp7ycrPPZpHmNi6vVbA5fYGf+022T8HWGr2E49rnBkluPZ+tpdarjYRmnzSuEaLkRmSsBlqdMSCQNawEtI1Ub8HIt0ssOZu7lndIP2hKrgQQSqDa1kNeYxBjbpIQhv2aIC6a0+FaM7H7v+PPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEXBXoSVujG3kSr3sNIw9fnCUsvuSfgUyI58aqR7u5I=;
 b=Rzuw2e5xUb5eIJru9S88QhFiwQdo4mIMk/vEzRSVxlJdWXwXlGQ2WsVgeq/w6RA0ys+Kc2sd+tjp9d0my7/kHtuyINqxGNIKR9PDSHVo09xvuhKnNxRbBSvn2G4iX/rKVFAUM6jgWqysuoeAtDvGWTwHFcjgKrabbiNJlaJHpc3KfjWL4UJ7dFrFtqFh3gIOjqqxZ/vph9wkaJOO86/CkUjLn48QTZ7OC3Tacvzf1nvf2goZrHps6Vx8uoXuYI4/Y+sEAvWpXrxQbhz9knowtep008SrIWZPid5YQOfAxvZZ7vN/IBUHt0Ql0jtDfYtFkg0u6/wzmuyEOGqFAq4unQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEXBXoSVujG3kSr3sNIw9fnCUsvuSfgUyI58aqR7u5I=;
 b=nLIfnhCuNXhuxKy9jIKIX2h8lpvMUG4rObWmq8Wgn25jhFjpImOyyUqniOazninzyGk5X0PEAoepin3NGqpL0mlv8ZR945nrfNIZ5WspXT7f/878bhcNJU8vRXfs6X5DRxQuVQI6vKf9GHwOx8XRhuY2oAD7QUsWbkDRoU73VsOqYQHzAIqE4plBs/L1wKTWwDd2d6HWcjRSVtMZrntLY+prJq/3RYTUF7V+WssSw5c7YS4eQReOtDO3hDviWUioZsbF0nmB84U59mcEmsRXBCE0bePg4oyHGQJgKYieYrwnErra5aw9XgJJO/eK8UHX5MTXFMNuJR0fbGDpQ2jewA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:23 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:23 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 5/8] autocorrect: provide config resolution API
Date: Tue, 10 Mar 2026 20:41:04 +0900
Message-ID:
 <SY0P300MB08013A8A073C935934E1B4D7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-6-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 4b52e801-e3c3-44cd-a492-08de7e99f46c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|41001999006|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pi1DJkkKcyqhVncEfOZQMaihsfm943IMcqwL4ySC7tp/UEK/zBR5pIDfoMFK?=
 =?us-ascii?Q?z8Nn+XnpGkbbvM/srIXqHM/Rj3b50Qpam+NQWCJwpUu1CEXqNKU74BvlJVJy?=
 =?us-ascii?Q?cQkhSo0RTQeBm/Q3qWSaYrO+qQbHQ81uqvvyd8ubKJHFCLFZYJSsB1PnGpyO?=
 =?us-ascii?Q?oB5DYO/0bN/gy2vB5Srjt27uxXHA+eetNw0NwWvEBwqAagW8VeeCeYyoNa8d?=
 =?us-ascii?Q?E3BdT4YZWSckXvzuNvxuepbZJEFlav7mR8vdYkURQGeLqWiiqgICvecW9lhP?=
 =?us-ascii?Q?nWm5H6IKazYTJdnFyhm9pNBxSk7PBAqaUEUZVAtiAvUNzNB1a5cO69Ed3xNt?=
 =?us-ascii?Q?gbd1AMCtwxUPT+mvwxdzOpa/e+XHPXTEtfY3/2/IzouMZh2L35aAQaS52Dnu?=
 =?us-ascii?Q?PjB0jOOj0L4y/JnGUKmAlJB+Ioa5XILFQ/Uw8z6KDFFVXDDwxMWELruOozUC?=
 =?us-ascii?Q?J39Qy8J3Af0nxrrXr01rIPJxeiE9yYMYtuND4lrViNB9CSlh0JvCj5M8HjmC?=
 =?us-ascii?Q?77Bb9xGgOpSS2fWzy6UcGmhZRXu05SddnyX5yonrfYSsvHQWUPhaG7MhTOeI?=
 =?us-ascii?Q?0/MxfeKI2TAPmNZwXcRHzUgagG+gzePFpN3e4Zj3Fx2MNG7okLaPV+nrJ5PK?=
 =?us-ascii?Q?XTjpFXTyyZhvLPKWS5ilBEh1kQ+N+wfBwo1zVZa/iNxFQmj9XxWe/S8b0Rd2?=
 =?us-ascii?Q?/vc7TJ9LA9rG8pkPWZGGzKjhY/P5AT7Ge5uSMCenq+9Foi/BTdDFd+itDxJv?=
 =?us-ascii?Q?a3wIMjnQezwfeq9INNAEASCo7yg/ccQeJhO62UJLwMghUB41JpcYS/Lth53L?=
 =?us-ascii?Q?yKMz/xwRPTJQxVk5mEZMAoVMpQEySRqR0wIwHqQoCFhRiUs9XFmUt1zAAgkF?=
 =?us-ascii?Q?XVCI4v+BhvScUPoX5PlOc4hz77p7c/n2rJR2OGHTct21bU8GirTy2zhkO7YE?=
 =?us-ascii?Q?u8XZrFtLaGVNevb9GXpl3CI6cNsq0Qsdsg0cIlz/kQGAaeGRyWX3478rhtVu?=
 =?us-ascii?Q?8h1E?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ge6nWG2K8TgjsMELL51IHBmCBcWMufJqXNul5XAH+fLPsJ8p/t5CtVfLEanf?=
 =?us-ascii?Q?+EKWv24N0Qe+wMdrQuY6deX5aeXJe9lyx3FljL01RDXvRU3jmFfyLb4R7KMM?=
 =?us-ascii?Q?Ulctw7L5oD9hb2j8Eqtzd9tj+DuqAdpylgcmoo2q+qNUjO30PmGOo1U9SX35?=
 =?us-ascii?Q?VuPyiUessl6lXEMjH4tP6KcKDrswxCm06/04Eff4h7IccBfx7DyvWg0aLMPQ?=
 =?us-ascii?Q?5/uOF6m3VZqVpfU9tFC7R4FP0W6GvX3x89Kid3e8c4IFEdtgNK48fK/uBtlT?=
 =?us-ascii?Q?46QQ2rm6g/klcWC9wVFLGvvnBFxJ/+ID07SwhtIgLfq9Wljyi1clNY7t0Ga0?=
 =?us-ascii?Q?N0hmR30oQMC6MgilPPrfahSxqS1c72kJ7jarqjcO9dmqFxy+icATD6dGAb0A?=
 =?us-ascii?Q?jppFtTEoD5/x4F8KbpE0e+HFRisqJRi2vSIMwzg0BPOaPFXmEr5siT1FA550?=
 =?us-ascii?Q?HWfdfNIDRdDaFLFlrIyA41KC6M4gVEM0DHbdVov9nqOsrg1Se9DoODVGRlvb?=
 =?us-ascii?Q?0kQbTo0rgndbexvnzz52C3xEvtYjoAA6kHQCn6noE2j2qVz1AK4MqQd0orND?=
 =?us-ascii?Q?A2NDuNoIX90ScGwyz/8z9k4vSJPxjCpclXEM0t1+Ug2OGk8gkpKsFjZEIBTn?=
 =?us-ascii?Q?zS3hsDDDxheV4dtzd15M1ysC9ahQZfaOYJ19juy5PjXxUi5ALCKqlbZg+aWI?=
 =?us-ascii?Q?NOH7BqmWMutmhAsBpMerr2HEjnITkMgBdp3zt110jO0XizqOr5Y61YNibKc4?=
 =?us-ascii?Q?dVRXdX+fgSU2t4U5UdN0NNLgORNjCL/C3bDqE3K29UgNzUk0IH0Ln+T6Qh6t?=
 =?us-ascii?Q?5pxh4tHMQCEzXHub54PVvoAe/XOIgu5OlMtO0SQ2NwBbzEl74Y5klcRjlhx7?=
 =?us-ascii?Q?HhIJUS13Bx3ygjajFKpLFtE7s/+e4sbZP2C3j02Z0SaevKxp1UWSZZzK8N4+?=
 =?us-ascii?Q?oAogyIcUT9Mc+v0Xc8YDt/p8TEJjZIC4avPXDV4GfhkwroX441ytlqtoNS8H?=
 =?us-ascii?Q?Pv6wmvEhuuw3MInKfMe2SUz3s1GqGCqJJRc4x7HT/lpU24pPb0Ha984X1Kgk?=
 =?us-ascii?Q?BPpysRpBsG7RTsnRQSggGyBfkDMaxmOoA6Lg4CEobXFV7/uKN80XToxiPFgw?=
 =?us-ascii?Q?0uPn7GXLn9jmCdSZxZKvdfptI/u1+aCUqD6pTopofV7LGnFEGE1Zso6mI8hJ?=
 =?us-ascii?Q?WvH2mjjk1nJklfcOOSfzSGxIVqZ+Lowclcf6Ea9qxUNbnEauRPLLRhBdbPVD?=
 =?us-ascii?Q?ToIWJecvFj2fL1gchvi0am+2gYuEoaZTqG6puwj7cRnBcSosuPSXWkZUp1Wm?=
 =?us-ascii?Q?bDaq9apQ4szSpaplFcpRJaqEp10c4HtPvbRaCM6lhq48Fr7o11k6yG4K7Pro?=
 =?us-ascii?Q?zl50aMOD0XAPoUVhpvA02DupVifN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b52e801-e3c3-44cd-a492-08de7e99f46c
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:23.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

Add autocorr_resolve(). This resolves and populates the correct values
for autocorrect config.

Make autocorrect config callback internal. The API is meant to provide
a high-level way to retrieve the config. Allowing access to the config
callback from outside violates that intent.

Additionally, in some cases, without access to the config callback, two
config iterations cannot be merged into one, which can hurt performance.
This is fine, as the code path that calls autocorr_resolve() is cold.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 15 ++++++++++++---
 autocorrect.h |  5 +----
 help.c        | 37 +++++++++++++++----------------------
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 9c4b691fb003..63fa331ef5e2 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "autocorrect.h"
 #include "config.h"
@@ -29,13 +31,13 @@ static enum autocorr_mode parse_autocorrect(const char *value)
 		return AUTOCORRECT_DELAY;
 }
 
-void autocorr_resolve_config(const char *var, const char *value,
-			     const struct config_context *ctx, void *data)
+static int resolve_autocorr(const char *var, const char *value,
+			    const struct config_context *ctx, void *data)
 {
 	struct autocorr *conf = data;
 
 	if (strcmp(var, "help.autocorrect"))
-		return;
+		return 0;
 
 	conf->mode = parse_autocorrect(value);
 
@@ -53,6 +55,13 @@ void autocorr_resolve_config(const char *var, const char *value,
 		else if (conf->delay <= 1)
 			conf->mode = AUTOCORRECT_IMMEDIATELY;
 	}
+
+	return 0;
+}
+
+void autocorr_resolve(struct autocorr *conf)
+{
+	read_early_config(the_repository, resolve_autocorr, conf);
 }
 
 void autocorr_confirm(struct autocorr *conf, const char *assumed)
diff --git a/autocorrect.h b/autocorrect.h
index be4e3e8b2043..5d82c49903be 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,8 +1,6 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H
 
-struct config_context;
-
 enum autocorr_mode {
 	AUTOCORRECT_HINTONLY,
 	AUTOCORRECT_NEVER,
@@ -16,8 +14,7 @@ struct autocorr {
 	int delay;
 };
 
-void autocorr_resolve_config(const char *var, const char *value,
-			     const struct config_context *ctx, void *data);
+void autocorr_resolve(struct autocorr *conf);
 
 void autocorr_confirm(struct autocorr *conf, const char *assumed);
 
diff --git a/help.c b/help.c
index 6158545e48a1..4adb1fcf0726 100644
--- a/help.c
+++ b/help.c
@@ -537,32 +537,24 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-struct help_unknown_cmd_config {
-	struct autocorr autocorr;
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
 
-	autocorr_resolve_config(var, value, ctx, &cfg->autocorr);
-
 	/* Also use aliases for command lookup */
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
 
@@ -599,22 +591,24 @@ static const char bad_interpreter_advice[] =
 
 char *help_unknown_cmd(const char *cmd)
 {
-	struct help_unknown_cmd_config cfg = { 0 };
+	struct cmdnames aliases = { 0 };
+	struct autocorr autocorr = { 0 };
 	int i, n, best_similarity = 0;
 	struct cmdnames main_cmds = { 0 };
 	struct cmdnames other_cmds = { 0 };
 	struct cmdname_help *common_cmds;
 
-	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
+	autocorr_resolve(&autocorr);
 
-	if (cfg.autocorr.mode == AUTOCORRECT_NEVER) {
+	if (autocorr.mode == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
 
 	load_command_list("git-", &main_cmds, &other_cmds);
+	read_early_config(the_repository, resolve_aliases, &aliases);
 
-	add_cmd_list(&main_cmds, &cfg.aliases);
+	add_cmd_list(&main_cmds, &aliases);
 	add_cmd_list(&main_cmds, &other_cmds);
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
@@ -674,18 +668,17 @@ char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 
-	if (cfg.autocorr.mode != AUTOCORRECT_HINTONLY && n == 1 &&
+	if (autocorr.mode != AUTOCORRECT_HINTONLY && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
-			   _("WARNING: You called a Git command named '%s', "
-			     "which does not exist."),
+			   _("WARNING: You called a Git command named '%s', which does not exist."),
 			   cmd);
 
-		autocorr_confirm(&cfg.autocorr, assumed);
+		autocorr_confirm(&autocorr, assumed);
 
-		cmdnames_release(&cfg.aliases);
+		cmdnames_release(&aliases);
 		cmdnames_release(&main_cmds);
 		cmdnames_release(&other_cmds);
 		return assumed;
-- 
2.53.0

