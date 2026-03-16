Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C603A1A5F
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675407; cv=fail; b=Ab89bhihYkuThY8UWBxoFFHWbnRhXn64V02OqiIaVMzQjulKfNF6xY9QqVoOatH3iwivz/IAQZgcF1m65LOP0saEc7XoWjR/TqDwmOs63+HnZ6ELLk1qNaV6za3/2m83s5Fum28eXL5rgv69wLAKAuXPkd6a3kF3ugYSfVHbXkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675407; c=relaxed/simple;
	bh=wpIPzSjhv/RphABZBsG79nEuvtDHFn72PBeVVbgu1xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PluhrIqpAHtunSvOW4H2F8sFPozvS9Yq1rU+ogtj5qtILjmxNKYiO0y7dqjitVpbYopkAyzodrGjU+kSs9whUHFK4680RQH2wZL8lzp23pL0hyjvSnmHhz+/Ba+ZtJ0vmE898JOVC0hKI1C6H8BHYjeObmfZdLe0ro9d3S9z8WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VsqPCCvr; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VsqPCCvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSnfafER6YJdUsHrNFu5KEOJsjHpKLIqRZXWxpifKLLJrSRYUy7Y007TtXfluMhMbbZ6cfRXHUqt04bgN8WQK4+/LDa4DwG260rAGk2zBVlog2xx7Ld8PS9OfbeAGGLNBw6rck0JmLOK6nLbBQo0kkGS4o473uAE/yC9lvYyullozrS2AvwO5EQxsTptfgDu4lSCyVziKpX18GgWYp7qZovhalcNKc1vTqoqggFbPXnxXmq+xsWylHznM7QiPzne6qJgCvdDdr2yWECcvFYyY7nvdM3iLcIYk7V3XBywYMi+UYwnsxWnRRRSZTyvIAeJ/ADVMlsG74umAOu90/ywfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao/1NhWuXw0QK1zpKPujY1dPO7lBUwsw8SM9Fa25YAw=;
 b=cgs//pNaXLzOakEA8Vd5YAC32nwCQ3V9o+PyM3XvrGzor3H47vyXU9OoL/8P3y84CdWtDqeKshEW370eNjbryI28PaUg7xtmiZKy8sMgCeoRDJMk4N3LNk09WdwwPxuB7+H9NwY2JDeQIdWmq/SjIjXZRONqGGyXjpuTqZp6yM9TT/1hPimJHxvsUcagdPFE1ULJ6RUpA3CFM4DxglHvn8c+AMtXR/dn4eeP/+BDdDBqWG9TN4Dt31lRK19lL5tdOjf6XLHwoxP7pR8ok10tVmUXyhuGiKunp8hREWVOPBmX5nYiLO9VCjfDk/kzcYlLqcdvhMmL8mecYmNSE4uRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao/1NhWuXw0QK1zpKPujY1dPO7lBUwsw8SM9Fa25YAw=;
 b=VsqPCCvrh8u92SaJShh/q+pzHMhWb1+amR91hQZTEiWKAOAEI7BaDN/DaCnrg1dkRhriQ0S/WK0y6wFTCBIDiEq9LbUtDXH1UJf5C7fShEdxP9Wv9kAsyxO9wq3F9i9gu9QS4tQWVr4saTbZhziHwavw3P6nOCFN6HvDelrbG/JTbzXQnoCd2l21prMSx557GeC0FQCUxAAWCHsUHF63ubmnw32C3p4GgLMkSJOJ3RGbvg79H3GMFg7Mc6vgRwY+xkTG86cqba81TKVic9Kyg5aAV9/glQfvs32IqwEc8mOQc9u4X8e6bXkruABg166kx7F9tSN8Frl+LAKef5EMgw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:39 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:39 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 04/10] autocorrect: use mode and delay instead of magic numbers
Date: Tue, 17 Mar 2026 00:36:17 +0900
Message-ID:
 <SY0P300MB0801890FF5D48DE132C37699CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-5-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: b4738bd8-c62d-4fe4-6d0c-08de8371d089
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adkYgsxzjB1ubFkzMklJQesS7KS8QpuAGhk4qUeP84t+LgSyyiaVHHtlm4Oh?=
 =?us-ascii?Q?+Hy/hQqwbeCUeSlKyje8bfFiewB/SFu3+j1EwieJ6XAfl+aFNbazozelCWV+?=
 =?us-ascii?Q?QpyAuAB8EFeqoUsmPVqVo/FW4IbsbFdP6/wJXhUBuKjFVjSNW6x0j0uUarhE?=
 =?us-ascii?Q?mTKAB/ov2dWdxmy0PPW6Jt7dKnd/QSoLF4Av+2MkOB8ACsHAVTX25jPbL3/i?=
 =?us-ascii?Q?hRXnyFeCYWv0BAPEkENBN8EoPU3LP31zo9sq7HqE3zym5fQZuk+PrgnXsoQu?=
 =?us-ascii?Q?fCOE54HjI0hIwnqy8rdIGdOu9Se4n1CQ+h4iYSHbTJFnhHlnS62k9q+YS4fm?=
 =?us-ascii?Q?chH/S90nP4rH2DuosuPTllfOcb6aMFh3skaxmzXsj0ynXH3s8B8zLRxQb+Hf?=
 =?us-ascii?Q?h/oq/gmn2QGmwZwgXZx+2k0xoPGFoZINGHI/k4icmWyyJHmhFutq50K+T69r?=
 =?us-ascii?Q?fz5Mvw/aYXDKxYqOkYrvSv7PEphutiWXuVAB5iAunkF+rv3BxE3ZiPqiEmS5?=
 =?us-ascii?Q?ufNITxRwlX2ytWyV7Ze/HRf3CkmOyFYQvB4OdE1zWwBjp0QHC6E4ExS1Fvkc?=
 =?us-ascii?Q?qwSFgdcF0EzW+YPe1DQrbIBA3QUjAuQs0irwZmvDzBV7k2V5Gmixfs87bwuH?=
 =?us-ascii?Q?4lfy4msjiaryJza6c+zQHWKK/iOx5b9EWLwqIX69dFOMVJ16rGq6qiUdw7CE?=
 =?us-ascii?Q?lW4VIvhwKMgJjkqqSph0jbEl2rPVUF0igRP+zmfOLh1hSbP2H/4lz4I/l18D?=
 =?us-ascii?Q?fZZLBHLA+fzef2CV4o2rzJJM14uEP6csi+W6Py6YQqm7uQg/BSFti12CX31X?=
 =?us-ascii?Q?E5AHKL5+Hyszw2gStJXUyxCrd40gnVleWd0M1eg2a4hkFHJl0y41vylL1yih?=
 =?us-ascii?Q?1xfSpILHWPgIgrZV/ZGZXdW0qK+xPkEIp87rzEO7wNbo1AffGn+100wM5yCD?=
 =?us-ascii?Q?EZjcYLW7lb8esfSFj2L+oL0sfLxpY5W10apUDqsLAcTbTniHRLDXVvZPZQEH?=
 =?us-ascii?Q?VRDK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5oC/q71tSuOxcbQSZqXXjbLeeAex8zHqZvkmWpB+G/gxA69MyKaIO/DMptSq?=
 =?us-ascii?Q?ib+NdjZ4fbU1HgtXARM5wC/ZTyOmCG7J8Wok8vDp7UFgkhNRK4THocdq/3CR?=
 =?us-ascii?Q?Sda/7jo8fSdIGsyaNijY5b1IS47rPzv1qMR0RfgtD/m4SGcQXuBWw54zf58e?=
 =?us-ascii?Q?v6EYjrPzMMU9a7Yl1GAzLAwPrj6bEl3yqOT4BRO1jfzGt8R3Osc3P5x0bwFk?=
 =?us-ascii?Q?4hUojms+N3hbduF7x7xDGgHbkosvRAFJqy6JvkPIvyr4nLly8TmpqE0zlJJY?=
 =?us-ascii?Q?ntbvg5L2wAcTmKbIJ9yW9o1Hsa2NXl4Zmcablpias4cb08HQwpIKdEmtLZ6k?=
 =?us-ascii?Q?j3zGoFrnHwQG0DWAxWQ6uKTJYR3LwtC9wlIWwqsps4cs973UfQ5YDDe0u9ET?=
 =?us-ascii?Q?37E+EogZrmoTZFXPkXMALrreD9fSrfDU7dBddr92IoTGiCmWHGwF5p8LROxR?=
 =?us-ascii?Q?JFjGd+fF/jl5TPR39xVIuZ+4xnleEKE4iOozUuDLEzL5hqYw+xrIphd8W8fc?=
 =?us-ascii?Q?cd4I1UgrYGkWVbHdbQb6hWMktt/r7FZE0j89lSzyLrijXR3ge35vRU/L38Nk?=
 =?us-ascii?Q?l3Uvw/K5pqfqQfKOId8XWzTxQtwr1KFVSkdg0Ol1CUwZFX9M9Kvwx3KT55X9?=
 =?us-ascii?Q?Zo9pkNNZFRf7syX3kImsOpVWGCarVfmX0xyKi/kVdsueFhU/mdMZZn0qvI5x?=
 =?us-ascii?Q?CFuX8X/oGZ6ajArRZBrVQlfsIDU4maVrKxDccUJxhkEdysOqITR4zyGlYOXa?=
 =?us-ascii?Q?R8WRpDzrVX495fKFYiGI1cV11IQ4aYZuMOv3breetyJ+pz+pWCXLejqTSTyg?=
 =?us-ascii?Q?LmXJapYNwB6vSPScyJ7UabAIknrCFhHHP3h49AKYNTndch0FpJWhXBLu7j4G?=
 =?us-ascii?Q?Fs7+BIc5cCVrxXrUqT1AxKLVxlZF1meTchgNvKsOP21Tmzx4Da6PaFaZmx2y?=
 =?us-ascii?Q?X/6lsVo6spnv5QZ9iygUJ4YprcUhC1LpiQehdquJ2o9N0lbegLgGtENovd1y?=
 =?us-ascii?Q?rOxFXdtgnlzoI8vHE/9LfW7ZAahlRGjkrer/i8hGTwsyzNfKN2MvjPItzYe4?=
 =?us-ascii?Q?hvl+AeL3kYsBQxD6LJPE6CLz5qXUSkiga+UeipdFZZr5S9MiTc/4jVnGadtT?=
 =?us-ascii?Q?8jznL6uxRw1J8lOvJloGRVsf4vqd1C4/0aQ9PprVK4PVGiH2/k3ouv2qHggI?=
 =?us-ascii?Q?C8FMu9PfR5OPpXSivm8SckiJtIdkaxKbXqjLfN3ibqW09/KQlpo2JFo1aQaH?=
 =?us-ascii?Q?lYI5s+cixcFPrNOB3LWOHdfv5Vtzy8oPHpmtveUrip+chvocDHio6XX5Nnqo?=
 =?us-ascii?Q?WpzKu7/qnuF2K+ToKJtVAB4W75ANDt03Phma2RRMW1uNFFDY+q89OVCcUseo?=
 =?us-ascii?Q?KnwxjQlhr63d3debIA02z/xRPbUu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4738bd8-c62d-4fe4-6d0c-08de8371d089
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:38.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

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
index 983057970e7c..a89ac5aced99 100644
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
2.53.0

