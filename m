Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011061.outbound.protection.outlook.com [52.103.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071F3B388C
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908315; cv=fail; b=Y0AtMIbxiFcXsYzxqW1C4Y6qdn/ivp2dss8omzld/08TycpRazSCQinSd37slTqN9bR2HG8DHZO8+zgGq+BjCJOgLTlSL5zUTN+QTY2ppBmhocg4iYkgqgzzUi/0KXtesbHnqYQ7ynwQv/Tn5D6eU+cBIIDq63R997SWHLGFBvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908315; c=relaxed/simple;
	bh=K1SoVQwsKoN6djosH5BV6dHXyzRxuePjDE1/3NoA58M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7o9KZPh6cEiyMcRd79VFLtxQYGFCsxUc/KkE5cARBEG70/afEYEXJSXBNS+ycMEGp7bCaSN77tp2Dzr+PCaGF511pmBfLLWcyYJEYLtvr3f4OoatQGj3U4gCJyCj+Ob3/X8yh7GHIx4sKbZSGkzvPcfeyLZY5bV+2hmaEK8viA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BZjLuBuZ; arc=fail smtp.client-ip=52.103.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BZjLuBuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLyvunFQ5xkhYuDv1uYDF5iZm3IFpWEoOtKw7R8TcnWc2QqbV5DjSq8gwVGokQMX9jwY8cEwdwWY7jZvhMo6fJ9Gbf3dqmMkfnxgCQOFSc69clmZ7qQ/SCoACcha8FatKogjNGNT3wJvpu+qcimYSY82D3W4g6+uXY0LAOPrZBWBy+kf1YNr/SgdQUCF0P1QnmGwC3/MthmT5VqA3r27vn8dkSCapXz530j+DkY5aQMpFYrs7diXfmWAXBd/okZBboTlPGYeyuQN8PewLAL0CDwLjCjcWgkehFo7w23p5YDZY7Rzt4db7vyT/7nXlY59ZPxK3UoPyY3hjxHT1z7+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC9ZKlRx/E7SZgU77QlKwBoVzjrEjVF9KbjBde3WcOk=;
 b=dyxPUzkCWF6BSh3JOVQr/LeFDrNUZYfnbk7AOwIgILm96+7hok7AYlptxNYjvG2eWX1W4PoJL7x0OvxV/t3k/SOHpFHrfiS7Z3LjOb9xuPs+E0sbfCa96gdlpZxcuujBpz/XgY0LZoHuCzgIb1ON2AQCfoAceeq36efJQx6fES7RqlyrBCeC0f6ZBPeCp5GKP0+bN9YyVgmRvEsGIfIbQT8hvBhKYgfDmQYGdfl053j17AnMHGn6f+5TJSjOPJqullhLLNvV1qfwgTVGxY98hbWKGOMrmXUyGBxVoR+IqxZFEigFFEjnrPTE6ZX3OUf9XGloRnWr7CLpMhRhllhiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC9ZKlRx/E7SZgU77QlKwBoVzjrEjVF9KbjBde3WcOk=;
 b=BZjLuBuZkHUVzJocphOa7UHxRkC8ytFUcz6rZ0DI60mXNzpfau7M+FjG9J9XzvsCqrjOsESWcgXxrLZDnBc0Y17oW0VO/m9MkCAwrLTlGdgUD8qm4GsQIwH4xjK+QJKNA1C2NOoKKpLTOO1pwYkEcX5rHnZB65qN8Mu/PWjMsMA0ZzHVGxnW6sacuTErFC6Uokrst1Mv21mCIVOs46QMiHIk+vXqfawPym7pf8voModxJi9y+rma9DOAezXJCZZVpd6lL6rrsIkelEdqsMFQHeopBhKIsJ8l/oDiazPaViNYY1Uu2zf/0ttbRAT/R8/T4MRjyLbg5g17Chyr0vQLZg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY3PPF5F39D32ED.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::498) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:22 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:21 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 04/10] autocorrect: use mode and delay instead of magic numbers
Date: Thu, 23 Apr 2026 10:37:54 +0900
Message-ID:
 <SY0P300MB0801FD1292D97ACCAB153374CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-5-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY3PPF5F39D32ED:EE_
X-MS-Office365-Filtering-Correlation-Id: eced8471-3a61-40a0-d417-08dea0d9003b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|25031999004|8060799015|19110799012|51005399006|5072599009|41001999006|15080799012|461199028|55001999006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06Go2mLj0jcA/V0CvBQk9M/VLIWTkEls1qFAn2l27Z9zg6bQTkM9uZoiF87k?=
 =?us-ascii?Q?MLxMRPSQfBNbxOwpmZzLrCYBwX6u7jsbCKXCJ5mILcWsODxfjzK2Y9tF5GJw?=
 =?us-ascii?Q?u2MZAQUOzTugsoV7QH4J5sRFxJM33G0JgJD+Dwv7WwdHftVvj9kh0WXIfE6r?=
 =?us-ascii?Q?4E0iULqHxEopTpUU9at+ujOE7TOrvmVFY9eOy4vFcaYJcBy3FxeHadXBruHW?=
 =?us-ascii?Q?PWNPrAcIoeRjC8F0VP5wl0eMj9q07XB2IJploxiWvLPs0gnmQRL++ycJ/DHl?=
 =?us-ascii?Q?oXkzAdPoioZVy8vdoYJu9AE+44SG6X8fkaCH82MKusXHsSVaKnnD2LKfMNEN?=
 =?us-ascii?Q?RLPgW5wpkMW+52+mSo1k4Kdp6ZiRcMqp5cQCtULl+uqKpA1HmLbf6eBb9RA7?=
 =?us-ascii?Q?0PaxgkziCGsFYZg7ZCUKiD+5c+s2s2+cFvIulEyqBKNT6+1n2xiV8hQEG++j?=
 =?us-ascii?Q?oy20EQ9q7oYUrDCJmhLjRphLPho+vgn3RJ9Vth6ehnbTj6nREZc7GF+o3BLT?=
 =?us-ascii?Q?a5/+nAk7aRnCZzXf5ZHGmVyL7hl6sZI05w4lQYY8cv1r9HvWBmB6G0V7SLlD?=
 =?us-ascii?Q?0+pjrA60eeVVyM+yHhcg4lu7wfWJLgw1Iqe3oo2kUEytC/og516i1ymK/lMH?=
 =?us-ascii?Q?ya2K+L7PxdAg10Oj+0tWUzs7+gYzF2kV0+BGUfFsT8AbMRE4sYsDXdkg/cmm?=
 =?us-ascii?Q?fUl5vs9gq9AqZ4zyA6rBM6T6lM1S/036UZkccgIoiBQHjb03eOKT9lkFORf2?=
 =?us-ascii?Q?6qE7kldb1YqntFo3rrK+LGCdesoVh68FHYRgVpgX3AIX0CoAUvOwR+a08sye?=
 =?us-ascii?Q?WkGIcJ4gUU4Vwqv08W+X1iyvFWLS5Q5DATAt0LrHsxGKL0BGjZ3+Q2SBduSH?=
 =?us-ascii?Q?JoXkIqTepKg6hE0a13SX9cV/cOzOHeOSstdFRnsAU1bqdTaqFF3yxVGN01oY?=
 =?us-ascii?Q?HNnqo0P0abd9btBjXjwD0IPJ+M13tmhvKoY2xx0UFcG+uuRHM5/Htoea6qHB?=
 =?us-ascii?Q?Ov0fDryX5k7fnY/X1kYjz2wHOmkwagyU4/BQowe/zWr5aSmlo0wOkG4gBzCf?=
 =?us-ascii?Q?yYvH/TU0?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXpC/iawVE3Dzdrqo4W32gooE/0/fDM81yaQ5l5/3yMr+sp6hDlqI7Kft5V7?=
 =?us-ascii?Q?zOSN5+oVV2xY51WB8GqvmgPCeM0RCgcxthlANWS6zcgvd9X3LdXQg688BFD5?=
 =?us-ascii?Q?s0dPYmKwoNTedrum4sBtb4ZiyWah9b6O8ktORwtMB/pLPKAtho5paW6B/WNZ?=
 =?us-ascii?Q?ZNHzfP01JiQEtuJnxYL/6QBjU3andn7FznUnU+dMpWfrQDn1pBW0hn2q9hG4?=
 =?us-ascii?Q?4bvBovy6GwUQhzCWSuyXFFrhKKhMeyyvTVnZBMex61m4Ei7KmSwkyn9rmKXf?=
 =?us-ascii?Q?S4LPd/BqiUi+H9q2rkdJP/AInbOLnGRHmC/nw+Qi+obIxNGPisKZpSOMUoSa?=
 =?us-ascii?Q?E2GRH03j/weHMXXCnDhmRiNT1rxnAPgyyTUPiW8E9OOKMnYfQJN/CTe3ysS4?=
 =?us-ascii?Q?otOX9+h6Y7sLMcDaWVP10p9N2jw/Fs/rOMZbGYG/bfC2N/8sEVuBC4BXaJ9H?=
 =?us-ascii?Q?jZtgHzI7LH65AEjqUjTRMWbe19hmO4YXlStKBBIccVBTHSPKzQpwK+sU1DK+?=
 =?us-ascii?Q?J0ypK4zTuzf6FZUsHVhOGjDftz99TPoQdNxArx/9JQnv05s8eGBXw8B1GnFl?=
 =?us-ascii?Q?Ke14kD+330uDvZ9boYfACtGZsyj2u6uhygG7L3UWurWlVhNTVTf8haF184fd?=
 =?us-ascii?Q?RE91n4yRnMVwVCkQc6Rtl3uH79VyegAlIwX81aWSJuUxPoyRulsyQvYV6M8o?=
 =?us-ascii?Q?ci1PJdx7+ZQhykjLkXoVHmfe4igKrfQzRZV2fNnZPwCtXE+cVWitYAD2lckd?=
 =?us-ascii?Q?Td9g2rTtGBbrsEPYVgB5HWkxFBqfeRDiMLEEggP1D2ptoFp2TgVXYeCWk4Oj?=
 =?us-ascii?Q?92jr/VgZTr3cYFHQZGmml90F20ZR5txhCOkbkP2tPn0V7mHNdMwDrgwdSyul?=
 =?us-ascii?Q?aG/llz7Egm3k28+goj9HVYcZkmps58qI4cFvpV40tjA3HWniMUHG1DyPaccd?=
 =?us-ascii?Q?fC3Qbrdi4w9/2cG2u2Ls8TFSe7LtPB0kwZbInK0olD9kpLxOWEgpONWrWj6g?=
 =?us-ascii?Q?HtHzEEOoK5YbC7ofkI+DmSFSnrsvFhKve+dJCQMnRBmAL5yzA1sdXt4scyG1?=
 =?us-ascii?Q?svIcxMFFVEKER/m/KrzJw+8KWxdmnIMTN+Arj8lOucqxm5tPY3M3MARAFe4g?=
 =?us-ascii?Q?ZGdesRfhmGxdJ1b2cpbLeEaKaNfucJXg659c4XZdTBpWxCCaxRHx95OheNTQ?=
 =?us-ascii?Q?Dtn/jksR+4pUxqEM1BScLXqhexSVrnfM9gU8XkWoKAj3ifCv9PJ6TGTgz0EX?=
 =?us-ascii?Q?jUvuAFC+2PWTCtr0tmr0yC4yWnjCFsEVn/L2TIjTRcN0owv12NCI81JC6mqx?=
 =?us-ascii?Q?CC67EXSYpo+9MPB99uXLe1wtv3PLVcyq0zqYFP+tQuvUVGnLZujTsv6nKIqE?=
 =?us-ascii?Q?BFdwjG8qlo+YCsfFkHYSykRygLx8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eced8471-3a61-40a0-d417-08dea0d9003b
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:21.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF5F39D32ED

Drop magic numbers and describe autocorrect config with a mode enum and
an integer delay. This reduces errors when mutating config values and
makes the values easier to access.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 46 +++++++++++++++++++++++-----------------------
 autocorrect.h | 20 ++++++++++++++------
 help.c        |  9 +++++----
 3 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 887d2396da44..2484546fc731 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -6,7 +6,7 @@
 #include "prompt.h"
 #include "gettext.h"
 
-static int parse_autocorrect(const char *value)
+static enum autocorrect_mode parse_autocorrect(const char *value)
 {
 	switch (git_parse_maybe_bool_text(value)) {
 	case 1:
@@ -19,49 +19,49 @@ static int parse_autocorrect(const char *value)
 
 	if (!strcmp(value, "prompt"))
 		return AUTOCORRECT_PROMPT;
-	if (!strcmp(value, "never"))
+	else if (!strcmp(value, "never"))
 		return AUTOCORRECT_NEVER;
-	if (!strcmp(value, "immediate"))
+	else if (!strcmp(value, "immediate"))
 		return AUTOCORRECT_IMMEDIATELY;
-	if (!strcmp(value, "show"))
+	else if (!strcmp(value, "show"))
 		return AUTOCORRECT_SHOW;
-
-	return 0;
+	else
+		return AUTOCORRECT_DELAY;
 }
 
 void autocorrect_resolve_config(const char *var, const char *value,
 				const struct config_context *ctx, void *data)
 {
-	int *out = data;
-	int parsed;
+	struct autocorrect *conf = data;
 
 	if (strcmp(var, "help.autocorrect"))
 		return;
 
-	parsed = parse_autocorrect(value);
+	conf->mode = parse_autocorrect(value);
 
 	/*
 	 * Disable autocorrection prompt in a non-interactive session
 	 */
-	if (parsed == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
-		parsed = AUTOCORRECT_NEVER;
+	if (conf->mode == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
+		conf->mode = AUTOCORRECT_NEVER;
 
-	if (!parsed) {
-		parsed = git_config_int(var, value, ctx->kvi);
-		if (parsed < 0 || parsed == 1)
-			parsed = AUTOCORRECT_IMMEDIATELY;
-	}
+	if (conf->mode == AUTOCORRECT_DELAY) {
+		conf->delay = git_config_int(var, value, ctx->kvi);
 
-	*out = parsed;
+		if (!conf->delay)
+			conf->mode = AUTOCORRECT_SHOW;
+		else if (conf->delay < 0 || conf->delay == 1)
+			conf->mode = AUTOCORRECT_IMMEDIATELY;
+	}
 }
 
-void autocorrect_confirm(int autocorrect, const char *assumed)
+void autocorrect_confirm(struct autocorrect *conf, const char *assumed)
 {
-	if (autocorrect == AUTOCORRECT_IMMEDIATELY) {
+	if (conf->mode == AUTOCORRECT_IMMEDIATELY) {
 		fprintf_ln(stderr,
 			   _("Continuing under the assumption that you meant '%s'."),
 			   assumed);
-	} else if (autocorrect == AUTOCORRECT_PROMPT) {
+	} else if (conf->mode == AUTOCORRECT_PROMPT) {
 		char *answer;
 		struct strbuf msg = STRBUF_INIT;
 
@@ -71,10 +71,10 @@ void autocorrect_confirm(int autocorrect, const char *assumed)
 
 		if (!(starts_with(answer, "y") || starts_with(answer, "Y")))
 			exit(1);
-	} else {
+	} else if (conf->mode == AUTOCORRECT_DELAY) {
 		fprintf_ln(stderr,
 			   _("Continuing in %0.1f seconds, assuming that you meant '%s'."),
-			   (float)autocorrect / 10.0, assumed);
-		sleep_millisec(autocorrect * 100);
+			   conf->delay / 10.0, assumed);
+		sleep_millisec(conf->delay * 100);
 	}
 }
diff --git a/autocorrect.h b/autocorrect.h
index f5fadf9d9605..5506a36f11a7 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,16 +1,24 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H
 
-#define AUTOCORRECT_SHOW (-4)
-#define AUTOCORRECT_PROMPT (-3)
-#define AUTOCORRECT_NEVER (-2)
-#define AUTOCORRECT_IMMEDIATELY (-1)
-
 struct config_context;
 
+enum autocorrect_mode {
+	AUTOCORRECT_SHOW,
+	AUTOCORRECT_NEVER,
+	AUTOCORRECT_PROMPT,
+	AUTOCORRECT_IMMEDIATELY,
+	AUTOCORRECT_DELAY,
+};
+
+struct autocorrect {
+	enum autocorrect_mode mode;
+	int delay;
+};
+
 void autocorrect_resolve_config(const char *var, const char *value,
 				const struct config_context *ctx, void *data);
 
-void autocorrect_confirm(int autocorrect, const char *assumed);
+void autocorrect_confirm(struct autocorrect *conf, const char *assumed);
 
 #endif /* AUTOCORRECT_H */
diff --git a/help.c b/help.c
index d2b29715817e..353596c17d82 100644
--- a/help.c
+++ b/help.c
@@ -538,7 +538,7 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 struct help_unknown_cmd_config {
-	int autocorrect;
+	struct autocorrect autocorrect;
 	struct cmdnames aliases;
 };
 
@@ -607,7 +607,7 @@ char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
-	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
+	if (cfg.autocorrect.mode == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
@@ -673,7 +673,8 @@ char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (cfg.autocorrect && cfg.autocorrect != AUTOCORRECT_SHOW && n == 1 &&
+
+	if (cfg.autocorrect.mode != AUTOCORRECT_SHOW && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
@@ -682,7 +683,7 @@ char *help_unknown_cmd(const char *cmd)
 			     "which does not exist."),
 			   cmd);
 
-		autocorrect_confirm(cfg.autocorrect, assumed);
+		autocorrect_confirm(&cfg.autocorrect, assumed);
 
 		cmdnames_release(&cfg.aliases);
 		cmdnames_release(&main_cmds);
-- 
2.54.0

