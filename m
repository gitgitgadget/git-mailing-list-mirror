Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C63563C6
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011843; cv=fail; b=pdCxMd1toxkW5vdRZhzvt74FIb2MaBVdksNHMW2sd590IJuHo+zN4WE8wFErZYUqv3IKNOLgaDhq/eKsPJmH+6S6tfxGLWM/p5lXsDS0gKonPNCoKN5FUfaean7HdVmJnUW9bSousDq/9mOmLFpdjY6UnPxm690WPVMYYg/4LIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011843; c=relaxed/simple;
	bh=3hiic/+skxYu6wtg47L8mIbpO/tWgg/SjFI9EaouGd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SDvXwrwApX+Ea4lJ8tZ+pYgO6b1cQa4VAZIiZd36jklVZHJa87iqUG/tt9S27Y3zMgHd91TIN4pxFoDOael/GrDjxvYDVwsw6/SGxyuJzaEQQwqu8qN61LXana9/DQNuRUvPMcToeqzikLEe8MOgLK8y5Ds3yCZah6OWJkvOL+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qz71ZhqR; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qz71ZhqR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJfTBHvfCxM8qofom7l4AFYLfLH96013ofP997KU5NnznWFG3Fs90yRMFee36s7nHFbJaz9+KQrPQWNsr442R8Ne+JcqdYkqnfuiwuvcOCjzlKruAqFeiMH3QzZYc4Qf/JIr5vTSoB9Alq95TNA2NksGdebuFInY2MM2zg95jrOCuWTY1vkfMbW9RxWs2O5wpwjtZVWDMFvYqclWDM+fDZ8ZPkZwJSKto6DjSfSC9gLjHQ40sCB12MYtGwQHSi4nXcQ6NZ3JMLqyShkmh9wGOcZnET+mRB9aISjvPJ1SpA1bagpPBdQEFxosRFrcO7Bs4Pvj1YRBpOdCsVFDXEFUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsMVWPNPTQM/AOR6TeOGZ93b5gqZgupnUOmj5dZI7kU=;
 b=IfmOuPQrsYC6+TdqAN1HgydPgWJVqj5g3Qe9j2pVnlD5o41X6dHXZq3KmItaCTatA2/NDmiD6SGAvsjd/G18/lYbqdpuRr+nc7JM92KnhRRuSvXCfWl6P9eY/69e4Cl5dD/TbO7a2+oZ3kF2KKCOCypCO0DBEQkoe6TBpQ4T+bkxQe124laIWJBRNUj1iwwUTEl1WL8nVWYEGEaiOX2ACGFdz1+3KTXNvXR46stgVGR4w0P8g8E8llRQClatc0CXj5+lLII1D5n5YomcjI2TZoxMrAnmQAd70ph+zEdhZ9kw4bvdJHrlEbc+sD2S7hlUc78OhHQ2Og5u/o11QUu+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsMVWPNPTQM/AOR6TeOGZ93b5gqZgupnUOmj5dZI7kU=;
 b=Qz71ZhqRJk7olkHQjH5pnIfn43bzTldBy5pOgRepSZbiDKccY/L8LyXxL5Hmmch5CikQHEPZ/XNBVESc1+ktdUCEhoMCUh8ujSFtWaItTyCFogRTfiHbCYbj285WRXibeBb0SqgRFxc9DWpurN4NyosU0nfg3+ViNjTufXa4vZEcGnSubtJdJf83VOLG4vassCTTDqRvikPETfwaBqfWokWWTQYFz8OE3XE441r+I0p/ybNLAd0EvQlKTMGWPSayRx0Qly5kd/EUAtEJ+tJaJoD20+Ihuf1FzX0YxdUYF8AQQ0Y0wmnt7LsNZuFwsmoqQ36lYcA4JaqtYwd+62I42Q==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0653.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 23:17:16 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 23:17:16 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v2 2/5] help: refactor command autocorrection handling
Date: Mon,  9 Mar 2026 08:16:56 +0900
Message-ID:
 <SY0P300MB0801DD4E14C17C5D199788B0CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308231659.2354924-3-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 75a4a1d3-96d0-4b5e-51a0-08de7d68d6aa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|51005399006|41001999006|8060799015|25031999004|23021999003|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?biFSsmB2q4MO93N0HpIfsAAB3GYaK4FIWBOT0rTdXDHh4DF67mzgfDw0Dzqn?=
 =?us-ascii?Q?cWjTeZeNXXGPhKZWnkb6hIlQ4TVFKjp5X/K9/J9FUEo+faEkpU5h8OknKZGe?=
 =?us-ascii?Q?0WmsRsEHZkLGRjeEWTWAwMQHAcc26yHsVDcoUE6c/u/GqezXUzxT6oLkruHE?=
 =?us-ascii?Q?0AUIMT7+QC1PfaxaRbD/lhRkkiCjwoBkBUdhlPSrKpcxIquX0rwZAKCqPjZE?=
 =?us-ascii?Q?SPHH+C+Oy4YJ4v2To8BgXM3kh+1IDnjgEqm5SWgME84YxxO1gHW160HHFOly?=
 =?us-ascii?Q?PUCR/TFTFyjE/81FvjtjdnVWj0FevqxnmIrnRPzh8KX2veUCmeB62vLwIYfi?=
 =?us-ascii?Q?jk0fYRu9F0UT+Loc/EKL2GxGwnf68VfHF7fepWVGz+Hp6ama6CH03XmdoQwr?=
 =?us-ascii?Q?NthQkmAFBYiIFsauQU5aoopcVjvQpULWSgcyo7j65uXPCiy6JpV1cFwprx5z?=
 =?us-ascii?Q?x6doxD1I2adbnVnfLRiXcQt0PKQT4mhojxH+HMIpgw1PqeKcm3twHmb/n0O7?=
 =?us-ascii?Q?sckyURc3yRxk3psItYaBjK0wR2xtOTwuAL4mhBRDGfa2kebMJZytcerxjdIG?=
 =?us-ascii?Q?vKOclpvkYAEiW3T8XA75A481nZRr5QvESPoDWT6zANHi+lxd3iwmySs1eO3I?=
 =?us-ascii?Q?7i5t3peCdXgTzXBM+FJLS04FaAnWpl/BzNbm4ghrfz3KV8d18wQJxlQO90Os?=
 =?us-ascii?Q?bQQriDK4mcNIUylwyMA5/1JRh3silaESaX4RTIdMPjfbJqO0EadmGuE0fJ86?=
 =?us-ascii?Q?C+caE7rygWN+FQJFNf2V2U1hClxJnJWVq+lhO90i23hnokAmedP/n7rcSOc6?=
 =?us-ascii?Q?hWvw2TBF7tXMOHHYTOxjwXJ6o+UmZQYCT0B1H0jn+AV6CRU9PkFb5fqtpbWR?=
 =?us-ascii?Q?oRDX3aW8pf2yAKQxd+4Mynx4C1b7eF9Yl+wLE2T1gpHawce8U2+NlP7GsfzF?=
 =?us-ascii?Q?UndrUyynjGfX2atJFjJcT1KyR17f/BQZPmx3tG38wbAbsIoROz3hCs5jR813?=
 =?us-ascii?Q?mgsK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kC+MtX7zrGTadV5/iEnHJH682q8i1spuUlqhCXNMmQi+Gj2w7BViNuaCbZvn?=
 =?us-ascii?Q?OUB07KDxLdx9Otvu/bxDTltaceVHpAXmaGLaRx65TA4sJVJpIOf3jxQVuRUk?=
 =?us-ascii?Q?3hbdKMMnJzlGWR4yWCHp6/erQE59LgdGgqNAi60cFTUUiyYMCouQbWHmymwM?=
 =?us-ascii?Q?HdRENImO0ZP/evW9pvQz2cs287WFRbX1wGDTWsHoJ02z/Si7Ws7SdFJ8CeXM?=
 =?us-ascii?Q?HKWhYALfbPfZqPYiLrf5gGIuNa08/kpzRehoZ2F5+p1gvm3djSV65hO3ubKF?=
 =?us-ascii?Q?ifBwv4uFnmNjgCb2A/3tYVwc9aOnzqomlEaZptRPLPsHF0iLhn+H+m4HJgDH?=
 =?us-ascii?Q?5D2U9UfIswfWOB+tth5zJev2Vg2eWTbcnKi3NjaJfYWldFXF52so5PbauJv9?=
 =?us-ascii?Q?bLQVJbKI88mX5d7lgrnPtNNjRZsR3wATQWLckHDKtQYXdG+h/5UH2RbucNCb?=
 =?us-ascii?Q?6NbSf8QSECIwaW00GK7Bemq+DjJE3fbFS1bwRrzDHJKHjPubCt2J1kbs+DUV?=
 =?us-ascii?Q?AWCzsK1NyZnMqAlb44esHBGHcwYuT9rsmuF7ZhoSVg3Y1/GZmeQVcjPiehTS?=
 =?us-ascii?Q?VnEXEukDUV3iQcEPXkP3UpU9BdZzFQzC9iTZnqwu2quFeenHv4EWajjRsUQY?=
 =?us-ascii?Q?+wzlo0WQtEgqGDLszcg2T9qChAfq+umzJE6WGfQSCqcayUxVLzDPL/4wGE8H?=
 =?us-ascii?Q?RqSIJFQBdjrQiGORI/2fojwcrsnBPt/MvWLFGOHrTzsGtaeTLND7L4aEjfX/?=
 =?us-ascii?Q?3yVZxcJWV9I1ZZVN4SCeRVeSVcTq1zDY9ETeuyBO1YppzeUNeYdiPm7AHCsU?=
 =?us-ascii?Q?MS84R009f0qfEyjWTpEsEpcG3n6f1oiWBxkcgi0+nE4mGQog82SqzcOtWqoU?=
 =?us-ascii?Q?O65w38ITvqtCjfMlslWE2LRSPXEAiQFrYzAi6XGvKPXiYWx3SCDv99WG8JUF?=
 =?us-ascii?Q?APB5johqGEcm/Svl3tbh4peEYO8AIr5wQxzjeco+1IDL8djZejawSkzsymXF?=
 =?us-ascii?Q?MVgPQfZMkBKppcuMExoafD5d1DXv3DxkhlE3J+ZOqCrdUGt5VSFJBO3UHAr1?=
 =?us-ascii?Q?KeDxXKvAZCYSCUBKl8HMcC8ZUg9jc4w3esbqZWsP8Enm4Cs14d2HeyLZduBj?=
 =?us-ascii?Q?LnM5dQkG5JqBpSZEbr5nc99FsHE70e5iL2BlAx/cy1ywelJjs+Vdw52HKZhU?=
 =?us-ascii?Q?pX4K2ewFzPYg8QXQ5YMtfXeZxtN1qJm73ho7MHzmGiCL9U5xhL7JbP4/W1wS?=
 =?us-ascii?Q?32/MIJaQMlOa0RtajW4/hQ5nAvaFY/+6bOE1MFPxkY12MNfL2i6rXiN2eZsn?=
 =?us-ascii?Q?8Mr0iBS1ZoqkbbnT7IpZ6jWfNBc1ZK3uAGVf+NJdpQaX2TuOmg1TKYr+eeEk?=
 =?us-ascii?Q?GG3afPqOEujtyA2rW4H/Sy9g6XOO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a4a1d3-96d0-4b5e-51a0-08de7d68d6aa
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 23:17:16.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0653

Refactor autocorrect config into struct autocorr, with an explicit mode
enum and a separate delay field. Move config parsing, TTY validation,
and prompt handling into autocorrect.c.

This simplifies help.c and makes state handling for autocorrect explicit
and easier to maintain.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 Makefile      |   1 +
 autocorrect.c |  92 +++++++++++++++++++++++++++++++++++++++++++
 autocorrect.h |  23 +++++++++++
 help.c        | 106 ++++++++++----------------------------------------
 4 files changed, 136 insertions(+), 86 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h

diff --git a/Makefile b/Makefile
index f3264d0a37cc..6111631c2caa 100644
--- a/Makefile
+++ b/Makefile
@@ -1098,6 +1098,7 @@ LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += archive.o
 LIB_OBJS += attr.o
+LIB_OBJS += autocorrect.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
diff --git a/autocorrect.c b/autocorrect.c
new file mode 100644
index 000000000000..eaae01645910
--- /dev/null
+++ b/autocorrect.c
@@ -0,0 +1,92 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "git-compat-util.h"
+#include "autocorrect.h"
+#include "config.h"
+#include "parse.h"
+#include "strbuf.h"
+#include "prompt.h"
+#include "gettext.h"
+
+static enum autocorr_mode parse_autocorr(const char *value)
+{
+	switch (git_parse_maybe_bool_text(value)) {
+		case 1:
+			return AUTOCORR_IMMEDIATELY;
+		case 0:
+			return AUTOCORR_HINTONLY;
+		default: /* other random text */
+			break;
+	}
+
+	if (!strcmp(value, "prompt"))
+		return AUTOCORR_PROMPT;
+	else if (!strcmp(value, "never"))
+		return AUTOCORR_NEVER;
+	else if (!strcmp(value, "immediate"))
+		return AUTOCORR_IMMEDIATELY;
+	else if (!strcmp(value, "show"))
+		return AUTOCORR_HINTONLY;
+	else
+		return AUTOCORR_DELAY;
+}
+
+static int config_cb(const char *var, const char *value,
+		     const struct config_context *ctx, void *data)
+{
+	struct autocorr *conf = data;
+
+	if (strcmp(var, "help.autocorrect"))
+		return 0;
+
+	conf->mode = parse_autocorr(value);
+
+	/*
+	 * Disable autocorrection prompt in a non-interactive session
+	 */
+	if (conf->mode == AUTOCORR_PROMPT && (!isatty(0) || !isatty(2)))
+		conf->mode = AUTOCORR_NEVER;
+
+	if (conf->mode == AUTOCORR_DELAY) {
+		conf->delay = git_config_int(var, value, ctx->kvi);
+
+		if (conf->delay == 0)
+			conf->mode = AUTOCORR_HINTONLY;
+		else if (conf->delay <= 1)
+			conf->mode = AUTOCORR_IMMEDIATELY;
+	}
+
+	return 0;
+}
+
+void autocorr_resolve(struct autocorr *conf)
+{
+	read_early_config(the_repository, config_cb, conf);
+}
+
+void autocorr_prompt_or_delay(struct autocorr *conf, const char *assumed)
+{
+	if (conf->mode == AUTOCORR_IMMEDIATELY) {
+		fprintf_ln(stderr,
+			   _("Continuing under the assumption that you meant '%s'."),
+			   assumed);
+
+	} else if (conf->mode == AUTOCORR_PROMPT) {
+		char *answer;
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
+		answer = git_prompt(msg.buf, PROMPT_ECHO);
+		strbuf_release(&msg);
+
+		if (!(starts_with(answer, "y") || starts_with(answer, "Y")))
+			exit(1);
+
+	} else if (conf->mode == AUTOCORR_DELAY) {
+		fprintf_ln(stderr,
+			   _("Continuing in %0.1f seconds, assuming that you meant '%s'."),
+			   (float)conf->delay / 10.0, assumed);
+
+		sleep_millisec(conf->delay * 100);
+	}
+}
diff --git a/autocorrect.h b/autocorrect.h
new file mode 100644
index 000000000000..ea21811a43f2
--- /dev/null
+++ b/autocorrect.h
@@ -0,0 +1,23 @@
+#ifndef AUTOCORRECT_H
+#define AUTOCORRECT_H
+
+struct config_context;
+
+enum autocorr_mode {
+	AUTOCORR_HINTONLY,
+	AUTOCORR_NEVER,
+	AUTOCORR_PROMPT,
+	AUTOCORR_IMMEDIATELY,
+	AUTOCORR_DELAY,
+};
+
+struct autocorr {
+	enum autocorr_mode mode;
+	int delay;
+};
+
+void autocorr_resolve(struct autocorr *conf);
+
+void autocorr_prompt_or_delay(struct autocorr *conf, const char *assumed);
+
+#endif /* AUTOCORRECT_H */
diff --git a/help.c b/help.c
index 95f576c5c81d..5eec6a34de33 100644
--- a/help.c
+++ b/help.c
@@ -22,6 +22,7 @@
 #include "repository.h"
 #include "alias.h"
 #include "utf8.h"
+#include "autocorrect.h"
 
 #ifndef NO_CURL
 #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
@@ -536,70 +537,23 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-struct help_unknown_cmd_config {
-	int autocorrect;
-	struct cmdnames aliases;
-};
-
-#define AUTOCORRECT_SHOW (-4)
-#define AUTOCORRECT_PROMPT (-3)
-#define AUTOCORRECT_NEVER (-2)
-#define AUTOCORRECT_IMMEDIATELY (-1)
-
-static int parse_autocorrect(const char *value)
+static int resolve_aliases(const char *var, const char *value,
+			   const struct config_context *ctx, void *data)
 {
-	switch (git_parse_maybe_bool_text(value)) {
-		case 1:
-			return AUTOCORRECT_IMMEDIATELY;
-		case 0:
-			return AUTOCORRECT_SHOW;
-		default: /* other random text */
-			break;
-	}
-
-	if (!strcmp(value, "prompt"))
-		return AUTOCORRECT_PROMPT;
-	if (!strcmp(value, "never"))
-		return AUTOCORRECT_NEVER;
-	if (!strcmp(value, "immediate"))
-		return AUTOCORRECT_IMMEDIATELY;
-	if (!strcmp(value, "show"))
-		return AUTOCORRECT_SHOW;
-
-	return 0;
-}
-
-static int git_unknown_cmd_config(const char *var, const char *value,
-				  const struct config_context *ctx,
-				  void *cb)
-{
-	struct help_unknown_cmd_config *cfg = cb;
+	struct cmdnames *aliases = data;
 	const char *subsection, *key;
 	size_t subsection_len;
 
-	if (!strcmp(var, "help.autocorrect")) {
-		int v = parse_autocorrect(value);
-
-		if (!v) {
-			v = git_config_int(var, value, ctx->kvi);
-			if (v < 0 || v == 1)
-				v = AUTOCORRECT_IMMEDIATELY;
-		}
-
-		cfg->autocorrect = v;
-	}
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
 
@@ -636,28 +590,27 @@ static const char bad_interpreter_advice[] =
 
 char *help_unknown_cmd(const char *cmd)
 {
-	struct help_unknown_cmd_config cfg = { 0 };
+	struct cmdnames aliases = { 0 };
+	struct autocorr autocorr = { 0 };
+
 	int i, n, best_similarity = 0;
 	struct cmdnames main_cmds = { 0 };
 	struct cmdnames other_cmds = { 0 };
 	struct cmdname_help *common_cmds;
 
-	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
+	autocorr_resolve(&autocorr);
 
-	/*
-	 * Disable autocorrection prompt in a non-interactive session
-	 */
-	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
-		cfg.autocorrect = AUTOCORRECT_NEVER;
+	/* Also use aliases for command lookup */
+	read_early_config(the_repository, resolve_aliases, &aliases);
 
-	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
+	if (autocorr.mode == AUTOCORR_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	add_cmd_list(&main_cmds, &cfg.aliases);
+	add_cmd_list(&main_cmds, &aliases);
 	add_cmd_list(&main_cmds, &other_cmds);
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
@@ -716,37 +669,18 @@ char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (cfg.autocorrect && cfg.autocorrect != AUTOCORRECT_SHOW && n == 1 &&
+
+	if (autocorr.mode != AUTOCORR_HINTONLY && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
-			   _("WARNING: You called a Git command named '%s', "
-			     "which does not exist."),
+			   _("WARNING: You called a Git command named '%s', which does not exist."),
 			   cmd);
-		if (cfg.autocorrect == AUTOCORRECT_IMMEDIATELY)
-			fprintf_ln(stderr,
-				   _("Continuing under the assumption that "
-				     "you meant '%s'."),
-				   assumed);
-		else if (cfg.autocorrect == AUTOCORRECT_PROMPT) {
-			char *answer;
-			struct strbuf msg = STRBUF_INIT;
-			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
-			answer = git_prompt(msg.buf, PROMPT_ECHO);
-			strbuf_release(&msg);
-			if (!(starts_with(answer, "y") ||
-			      starts_with(answer, "Y")))
-				exit(1);
-		} else {
-			fprintf_ln(stderr,
-				   _("Continuing in %0.1f seconds, "
-				     "assuming that you meant '%s'."),
-				   (float)cfg.autocorrect/10.0, assumed);
-			sleep_millisec(cfg.autocorrect * 100);
-		}
 
-		cmdnames_release(&cfg.aliases);
+		autocorr_prompt_or_delay(&autocorr, assumed);
+
+		cmdnames_release(&aliases);
 		cmdnames_release(&main_cmds);
 		cmdnames_release(&other_cmds);
 		return assumed;
-- 
2.53.0

