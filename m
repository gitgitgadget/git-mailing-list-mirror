Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921473B38A7
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908319; cv=fail; b=JeVs7WHMWiSO/sig6zfDVZDPE8SK7U1IGmj3vpVqjRxYcgsfal51M+Ux3xKZslwgRsWADV0qS2tCbEUCXlV6F69MeFYeNJdKh9WAjY42WImJAsygmyCp0q4HrIVF5ZvnHcjL/5jjrWxG0TEYicQBngPXTQG+nrFGXdzhhZXdRZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908319; c=relaxed/simple;
	bh=KDM2et6QVK6GfNiPTP4MX3k2OC/OPB0OPnlfiWSMj1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itR424+flRj8fTgw/PxJfADMjOzmQ8OCwFVI8JWcfNGKxD4TvIP72RZvnkfc3yn+I2NDWkCbL1bs4doYPHwzXoLZkLvSai33oRarRpmGJrDCqv8ZIzHtgtDEENoYzkTHvNseEtpJ6DVIrs4o9pejvpLpm4fDJlvmB2XES5sqUa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CJCFmhOK; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CJCFmhOK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GviH9KOpU4IWONz3080xs73hT6GO9HyvlI1wHQavPbTn6xLnk7mGo/HeUanKiuUJNwlVwwA64iln1oUv0aqIAQRQ6+YIITw5TZvBRzWTUWbKkhdDldzjXlC2BmnhbVBK8gml+ZRFQgphmbpHW57G8ZdVOUk0MzfnWHrx78ck/DmxjRpAJLzjOpRdTUUeiwG4+5SCL3nImW1Na9rF6HUbPNLmBb2cBrVdWdCcljLnjqmVtkY4t5V0kj872PYDm2+GGFlwS78zjyPTYRyVoPHmjBA0pArolJALZIlSCJnMYhbE40O1MzJ0L3zrkVWOtQVOsVmlQVG4fX7W/4yl9vo3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S26Hi1T+0PjumUZ/Jy7KV6FBSGUbKjReCmTDMz0XeoM=;
 b=IWfX++VfOZLxAop1PvFnafprQRCqL9GpX5AUbrgz7gn2obPbqvJSszwVgJFeHKjQWZIkGXivWo8c248bRyZ+vTCTUxwgtoasvhO0OVjR6zktRBbwoBu6cnUWwzJNLgPqJjCQCLF7lKxOhdj1EDJ4KY6PaiZ5FQECINNdL1lS9IKc7KAMDWaRLO60hTQLcdeLGIcLFNx/V1BlCA5AOY0QSlgwjd94951+K2SBEgWQON5rq6Q5p4hjEDZq3PD2hUBlKhvKb5dFmbHnWFpXpCWkIdUBBeeIpekElsfkEVhYrYIWwY5hSMmUxnH9yaksKRQqcKwLdVgXPMM/QclJqCXejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S26Hi1T+0PjumUZ/Jy7KV6FBSGUbKjReCmTDMz0XeoM=;
 b=CJCFmhOKDkp1mGyBSVGWqASxVvixfqEwZcL2MyMCumQGcYPjhBDLcRGqVVi5g5vC/yOq7C036uM58ivA/+b+mgWfHPDI3DsixFXrMcdciBs4WLfjIaPXBpgzWX4ukiKMGwJ1e1pGoxy2nCA9f+NBYc634e5Ob2BZdH+F6Xyv0PEh/5ve9GxVz2m1pF9lnwRBwm26PZt4DmjGbPeS2E2nBzgJxjymKj2UwbWyd0DgBEIAHCY8Z2Ved3gKmyALsBElZAPEREE/8wxza1lmIvw+DARV+Cfo72Gid30PEL42Swl45Xykc4Gg/4BrOqreda0UhMfB3bOJ+xodCHAj6lLfBw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:27 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:27 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 06/10] autocorrect: provide config resolution API
Date: Thu, 23 Apr 2026 10:37:56 +0900
Message-ID:
 <SY0P300MB0801C8300663FF8204A2AFA3CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-7-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 53033704-d6fa-4622-6f1e-08dea0d902de
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|41001999006|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zdo2jLG4AXs13HmYARESddXwEZnqaYDp1efaIk5wLAzZsd7Sdo1I0NuqZkgJ?=
 =?us-ascii?Q?3BuzA5rT2i1ZuOduzxsdAuVDuFrIUNevUg4XX4WQwb+I+N3x/AjQEz5RQdHE?=
 =?us-ascii?Q?bP2ImrhyweCtnH2Vkgb/xuTgYC7NKJ0ZmoiVweVJFT9PMYXDBCYSFudQQ0qL?=
 =?us-ascii?Q?r0VkKMc1tXl0oGl8Pmp5MDAM241NltppkYAOZ9Cbmwx3wtJeUldgiqXGhrQR?=
 =?us-ascii?Q?M4ZUiZw5nOlHD3kKAzjhVDVpNFYR6BFVmBpDEPyGazgXqyZ66rIK7Mm5ZiDf?=
 =?us-ascii?Q?2k1w0xjdyhpRDWAQp68qFmIiWxIwokl+6/t1DG7Nfzwojc3IrQqZUIUlgFFc?=
 =?us-ascii?Q?ZNfBlWLnyYkOsdjOGE7rfiaVF3eSqpObFRayZOq7+aM0hOOLHIJWDwC1N/aS?=
 =?us-ascii?Q?63yh+4uSiFT4jDKxWpTpP6Lc7AdSpOcOSjXa942YDzyEFGDFKdbicAJR51mO?=
 =?us-ascii?Q?/5cQ5c1d7W8Q7MdV1tILPwmCC4r1Hm3h++4b+G4ojEq1yR/VAlqCwlSgSMib?=
 =?us-ascii?Q?h1LYvjFM1OIJJywUb4g1pegUWJtU9L9JSS4N0GI9dCCp2WAhOvVrqvSe+OAs?=
 =?us-ascii?Q?YNb278CS9VtLV/9zpB0zoxUj9qQczqce2IdYlB9MgLIs891sBv4Hm7F483Z4?=
 =?us-ascii?Q?H5OUArTgxB5armrjFh5xs9iulPIDpDMgy52hx1cWi1lAMR/lLcaGX5ZV7NQc?=
 =?us-ascii?Q?qiumHJyvMQNqdauhGh1oKABjIhy7MX9IySZ75KvV5zDQ+SzGFChnG8V5rTCT?=
 =?us-ascii?Q?Jg9qik4bJFMSxnlA/HCqqV+LUCs4vcAbk9lHcbza2Nw3lACOmbXmTvzgaXlE?=
 =?us-ascii?Q?trvOH68k3DCTs15Og4OK/V/nsf34yYtd0nq5bIR0pJrhe2j5efWk9ci+K0zu?=
 =?us-ascii?Q?UTYZS0nCvdIBJAqpfZjkzLM6vl+rFfjGwcnCGnwJ1UrKI0gKwbpQC4srR8Gp?=
 =?us-ascii?Q?feAI8d6l9aSiVyztEcZZl8Roe+Rw+6J0JxLyEXVd+eBBHBlfte4HBPMn8l6g?=
 =?us-ascii?Q?GnU4oRm6m1dptwe8TIp/kAvsr/twH/E1KZ5gWrEOHo45Q+8JwawOsggfyYeK?=
 =?us-ascii?Q?OpS8qt/J?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kSeZ+h3aUSmb/RuC6fB3HcdvKsclw9icWy4vt6iY+e5C6Gcg6RY1j3f1ZTMF?=
 =?us-ascii?Q?X/UhqprayqpJnUGw3iJdDagSjW38GBHY9lK+0vS5siGL0TiXGavwEEl7wnFC?=
 =?us-ascii?Q?wbp3CZ2RUWHKMUsUPd7ZZ2aDOXFi7MgpiDAQFhYWBB3+0znMdDEoxsoicny5?=
 =?us-ascii?Q?UBND122YJx50kw0yPLmbpshVdAo54+RYqghQgiKGFu+3RXm/aoWNjf5bmc8j?=
 =?us-ascii?Q?lAbGwJjIgzMe6JzgHupNx4tcoy3KZWLNnZljSwbbB67twJXUFNP8T/rkK8Tt?=
 =?us-ascii?Q?MqNNZOssD4Ovg1MZV6D2lQ4lmHXp5EI77t32j9F8SWw6LOmujiCMAxc7tARc?=
 =?us-ascii?Q?nAKQkHZRqr2pelxXJpELb+pExlpYxWuSPlSNQM2BvPCCVlsF+wm8y6UzoBnv?=
 =?us-ascii?Q?ghzrbq3ikGGdA8z0maVKAPT9UGTLJOK7Jg/C0byqZwvoy4aOAJFegGHGVted?=
 =?us-ascii?Q?9jRnijiqhYi5ZKc4MUScgKwhn3m8j8yQje6bPsceRX18rdQN/qPah9L7wJBB?=
 =?us-ascii?Q?Wk0NHWQ0b1Pxr5nj4ayOO/56COSztMfjZE/QhMF4SFxHIm8uiz9vs8SSiJHC?=
 =?us-ascii?Q?u5nTnflT0R7tHv6hQclB8xhge3GVFRtHD51d6XXyR6xE3PWzVzCY+hoBiyqd?=
 =?us-ascii?Q?FhigMfduS2jp7B7RwESuZTUbdzoQiRKv/o0g4Fb+oxg3bonRiSZFEmg9GntA?=
 =?us-ascii?Q?Xqk7KMjMXlb3eq1L7cvJmUkbng9naaIQ7/tKINqf65SfXsI3DSD3MPhZhNpR?=
 =?us-ascii?Q?4H9YFXcYDxU5hdCr78xmSBe57o/crGFxeANaINVepY24kAyLIxbIwUIaX3B9?=
 =?us-ascii?Q?FY1ntEs2vIs0XF+Pkm0mXp8r9rBxrGpWOTidZ3BdqX3LhZ+1xeqb/0FX122v?=
 =?us-ascii?Q?4K0J7oHIHscWiDo0TEOYjlVbABJUWIHK421lJKypGU4F9GM2pdy3YfnLlgcg?=
 =?us-ascii?Q?TO7pTnAU4m71uBl0712f+1vbpeSzP/r9jER8oO/dsQpAin/dLYgYLtPP9rwC?=
 =?us-ascii?Q?odkFRdsXg/uxfv876HJzaftdTSbF6coBrlJrwjOingeuqdqHG8hdpTjS6Mm2?=
 =?us-ascii?Q?rQVlZxr2WSh8sAU1t6NOE5WCb2jNAbeSVN8P1AKIaEBdJPP0OL9vJswOyVYY?=
 =?us-ascii?Q?LnlY1SGpKVLNwsCBPm9bpJnxGeZM7rCKoDQzw+TZVovfxVcKJRwSpGxWQNS6?=
 =?us-ascii?Q?ztk/7uMIwUSD7TyFRwrPp3+8BGWx8z4u1Ktrwx4jp/ghxF1x/hHtMWpaAr39?=
 =?us-ascii?Q?UVF4QvzGHhjt2SIy9jjtUTZwGZA8aoN3JRhDtwR9SI5z12B+Gklc7/XTHD/A?=
 =?us-ascii?Q?APlFkWZtpUCRMUihHooAjbeS1l92m4Scx2g5P5Zu7gD6l7NJGT/kmV/QFDWb?=
 =?us-ascii?Q?LBLJXj40GA8WqyX8UostNKD8b7FZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53033704-d6fa-4622-6f1e-08dea0d902de
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:26.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

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
index c7dab8395ee2..0fff43545cc1 100644
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
2.54.0

