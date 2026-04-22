Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8903344DAD
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860400; cv=fail; b=T6EQRP6Rf4WU8fWPFUAPKOHGYdlUiPUiC1PPHJEB/+4d5RYzGP3mkCtPiSoaS+FS83l5CZK61uilHeloNl0AaEyS0SM8/JIJOKnbuGN5c3sRlFK0wOEB5KN57Pz8JBaWBdEFeIWtEprP3F1TntqaJhNG2lYdiRPIFg0XBvzgIxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860400; c=relaxed/simple;
	bh=68FebspMp9Q6D0Ym8ldxHBPxN4S0c+O2EGeggJKUxT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9VrqcnNUvd//0vG3g/a06NkNhVJ4ec6CZQ6gLYVwZjyEdxSqEtloCS8AXqqdUJXeOoUMnEQzmxSIlm/voYuFGBm0qGfBzzadfZBsgOlS6pdO5nSVOPklzzbkoKO6TD/NXAVKH+enCbKWQkgZSPx7j6bBDwhyibYsXE7e2a0yuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lKtOPj52; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lKtOPj52"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W045eUtkHq4I3OAhdHfaVRGm+1P9L4FF16JTmYgkQdh0V26NbZYmyzw0pS1PZIQ4lkVdO9iB1uPjXBIP3ogATkv6loe1yGYODjZstAKJV5QgVeWl9pR1B/lt1eTSHJgLixhlfV0HyvubeYlwH+y0ed9xrPk5JupsqfJ/oPj1mFM1p4UHb3y5w5VJNei7ABCZ1r7hip152Mr/ecl7XWTx+3U5y1UfJR94Z9QnFSqgKNit5tQHGJiqPE+k7z3Mgpu4ZWyF3cngSTyCxL9S3BuUiSMQ7M2AE9lwqfnXVsgdXyAsLu0q4s2uNCNteS4yxf53MmG5sQIbXzyy6Pf2XGGDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UDxO4fgtt3IkUlFcZtC12qDoEAxN84EDvPGkkhJhBU=;
 b=EPcHVrZ6JusdhcZHm7qAohYYNJsHOtofcDSSn7RjUxZOQ2DlixR+RRqlIJ8Sclux9ofLwiimhuVb+mlieCc23OKPZk5djSmRCZlr5GMHOSBG3wombjuTQdD6R3tvuLKzxGQcEIqSZZsGDTsweWbO3hV8Bp2ThiaTtqB+b4xe5hJRn4BXvl6RRnbKlwnG6RRAM8dME/8BlK2RK4of4ZAuW7rqn6NPfugoOf0h7upB1VNuVzO0cv2cFHzgdPEY/s9QO3b8cQrNhlO1bjdw8EaIjVA9QoloHf9OY9bR/qZGVHTn02cdDS4D6IszBfiqeTr2BmrZKLQjvTKvXikj/y1rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UDxO4fgtt3IkUlFcZtC12qDoEAxN84EDvPGkkhJhBU=;
 b=lKtOPj52LtWmyNQ59KUBdMdA9OlwwdDhsxQRMcaeq/UzQjQBJSz+a2kFvwVyHaJAgVOggjfVnHPRgoUQMYzl9ir4aXXM/7f7a9KbBV4OD3UHVV0rYmtm1g9PeeQ0iSsd7O4+cMNLWIggvA+eiHWwcakdrQZ3Fz+XUBqCHJXzDOQxtDURRcHJnKx39VJ41cYwACpL+FrynBcaj/n+FNkZQOqTcCF4FCLraKIugWaVWSvG4NJ5oFZSJ9iRdZUPZ8/guJTINKG9fo/89L9yKBwlOVg/wTvJt1wo/FxHK68gs29vTqQg0M41stb394GeK16mFMbzplPWi4SHe2A1Wix4OQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:54 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:54 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 06/10] autocorrect: provide config resolution API
Date: Wed, 22 Apr 2026 21:18:06 +0900
Message-ID:
 <SY0P300MB0801D329C871F2F277526CD7CE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-7-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0530:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e5bf24-9550-4082-4b88-08dea06975b0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gHLbrTdrC/gSBtAVUKJrT+pVvb55emUWWeV1msUZLNPwXDINWXvd0WtwT7u8?=
 =?us-ascii?Q?sj2tQkysOLx16qmvdUvs2X3bmpXHE8N62+7l/yLHnTBd0X5YalvmuTqUwMD9?=
 =?us-ascii?Q?MHpFvs56Xh/hVYiKmarYDQ4dSqT548UrQ9635Aqm//mcrgMRJr8SXLtzu4iL?=
 =?us-ascii?Q?l+JIpxMyTEdIiz8ixGJnshcy7Orh8rayek4GdUcJjNFccSNrdjnxtCgLpujO?=
 =?us-ascii?Q?rcEI+G3ndZtkbwGdRoH0lFQi52xZYZVB4pk51BSCwYTL3cCPJ4a/fGAzqVn/?=
 =?us-ascii?Q?DPJqyL5vWjnFISuQhomYRrjgqV7FcGH9Y9QRA8G+VT286C4SR3gp9Xf2e9RY?=
 =?us-ascii?Q?yuP8Wyezqf4HhxLpv1ZrzNHABYxNvhC3/AEWpYBAbwKg+vZ6Mg8PJQ5y8rFw?=
 =?us-ascii?Q?puVUmp2csUeT5uq2qBhYpI/vM46tTguPQTSOBb1TOLUq9vLG5mRqUBvQB9m9?=
 =?us-ascii?Q?uVHN9rCx3U97/LQzJEXATN6j1DJ9qWbPvNwZsfCDT5NtBAaBD7v6p3TPFdyE?=
 =?us-ascii?Q?hzBoCnZ2ZVr6fPhveJElatzCEzK3OKN4wbLgoegriMmDiQx5dXm0Ktf7IQGn?=
 =?us-ascii?Q?VWoXJu4IOK4/j7Uw4GKV40gIP+x7m7LdSUPn41HYeXCnKhe9VRSeICHbildN?=
 =?us-ascii?Q?0g3mTxR9zD6hvX6G28R7d6TrHpzpb83aBCoLxCevWBaq0uYErLDHDKphdohK?=
 =?us-ascii?Q?DKlVrdBSyuVJCPBneRHCi+hGt1Dc0ogeO8tMN37vekbAYTpvSkq1tHs92c5z?=
 =?us-ascii?Q?VO+IviINvB1uKg/pxxte2ksuS4D/w9shUffrIGAdPJkGzZthLGsHID5/iqqB?=
 =?us-ascii?Q?jYDX+NWcet477gjry9YFz+5icUpTZ/Bir9tFoOQ4ZiHpWLjTvLG2QgHQZXR7?=
 =?us-ascii?Q?+YVQeI4TEzaZXZO9Tof1LMxj3bf5l0IJoPWzUuCq5j5Lgsuiu/MrHtmRBq7N?=
 =?us-ascii?Q?z/ACBTTtnl+MwL6UiEOeqGTlfNJ0jfuLFTvEFwVaWjek07zAUhHGgBh7DYRc?=
 =?us-ascii?Q?2i05lpeTYa7i5rdA+OCl+kLi+KK8HBxuMFVPZdp5fmXpAus=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1I63p3Dr41WIsHaNEaqwj2iQhfqxBFW1G4Xgkll9by4UW7KXFJ9tQ8CdxHR?=
 =?us-ascii?Q?z5/ZFFrpuqkrpceA63wq7RhfTWIuy4BwubBarzEcljnuIQ/DMVIkQ/XTVT99?=
 =?us-ascii?Q?qSiw6Mbv1uimNf4MBgDwzxSqGhy1V8ynB4O4hvebxJt1aUUD4P1aFY1Lmjtd?=
 =?us-ascii?Q?4y0jnnvfNq2IS5YdqzmSih90L1xqCtH5TtUdF5CLAmkzotapP1zio4xqDgtm?=
 =?us-ascii?Q?ge9lmoGaeA0IHPCaM1kbnlmGsn2tL6Uam/+wb9lK0wzNnmWpHH3vgOsUPmVg?=
 =?us-ascii?Q?xJHv9f2uWx7W3SqwknSvzjONLTWkvMVGVQW1pLKrW8Fl80nYpj+yQRCaDXIf?=
 =?us-ascii?Q?W84hr1RQcyAqKncsVJNddKHbWgNyBAca+yNXzDseUZnoFC5gBa+HA/dcfzjH?=
 =?us-ascii?Q?mVvGCKEBu1hf+eLD+dxIG232zTuvKmOTApZymXI9CvIemdk/zocBIj6BpJDe?=
 =?us-ascii?Q?RLiKODBpAHBwZiaAjxnqd40yGs30oK4Vlk/fs4d5zShTMmurQ5nfWJH5Rk2C?=
 =?us-ascii?Q?/Zkyfcgfc80vCLqTBHQny0Z1n47tDRAqvjAtoIYnwGep94f6i4yPP0oQs9RK?=
 =?us-ascii?Q?1n+zMOl2vegy6jhjMPji9zO48X8GVK2MsaIbh3r5fw2Of4jyHksUP1nA/CGK?=
 =?us-ascii?Q?rTZpS4kr2rCs6tD6OsuOs/WlSiOD39Pz13xnzdUFIvrqArMk8ggbKEIOTg3c?=
 =?us-ascii?Q?y3Gm4ywEMXOFwTWUmBxNWOEWGuDOFU0TZJkujMrpkFNrtIY332Op7Swi3lTN?=
 =?us-ascii?Q?A7uqBHHMzZanDN6GtGrxnwbl700pKB4Jq8Elh0TsrGBsFqsVl76kvOqBTwnP?=
 =?us-ascii?Q?uW1vQU+mUrYb+B5ofPTqZwJzIzu15gljBwd1d+IChuOiUQAZPeLH6h2vipL3?=
 =?us-ascii?Q?GqjfAv3XdBppxrapSQYZtsLYzO2DZER9/DN9hmD30U106dtLBhs1Fg2gM0Xk?=
 =?us-ascii?Q?8R/kgf5/tn2ud0tL0z9BxbzJq1/WxsWuCrYMc/cMkZ3TzkhblqBxPGpntapc?=
 =?us-ascii?Q?XzVzlmy2d2w6OQGIEQa5eVkgEsNJR+gBkcYfdyupjuqqzcjhdCSFuCs5qsYJ?=
 =?us-ascii?Q?OSkEQvS3/Gvx+nQhyrawDtSr+jsEE0nxqDOo3ljSox2LtxjICM+Tbxd8z/11?=
 =?us-ascii?Q?5KewOacRL8x3fQC1Ofp3Z6Kvbb1eAkigy868mqpXCF48zrQ+KxMr/wDn7PlH?=
 =?us-ascii?Q?AKqxiOtBnYTLB45cWMtdBySVc87Q82ur9toHM3L9Bde32Yx/ae2s/VAPxzBN?=
 =?us-ascii?Q?jtobk3sakkQLUlsW98RfB+zFno6KIXh+hpXZvnkg+eBF9BSb+7OfL1MSh/qz?=
 =?us-ascii?Q?VQ2j0AmQiN6Yobv33q36RBw+XaTYznTwN/URZflGSn3pvfQFaz2u8ms/71pZ?=
 =?us-ascii?Q?t2tdumNkz3e7Ec+KuujxNINtpSIi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e5bf24-9550-4082-4b88-08dea06975b0
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:54.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

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
2.53.0

