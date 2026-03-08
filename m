Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08715322B72
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972278; cv=fail; b=ssas7yaHabnnFcN1yWLPE6DzDD3Imvckh93VSM46W4Vx8YuyxipuvhRKu/JLDHUSZTbtDQdNQnJtdDCQO9bcvIqkcNN/Lc3nKaYMphghW1GtmlzAR/Q4gqKDuYNcAimiQ5Wx3uSNbiEcogEhuZ4UCuQ9oT94kheOXw9SUHt7VY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972278; c=relaxed/simple;
	bh=3hiic/+skxYu6wtg47L8mIbpO/tWgg/SjFI9EaouGd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQ/d4uhfIBndowjazoALZsEEoySgBbJSlEDhAMhuTW+kRI0dTnSMSaNwGdeUwOuGHuGwsntXdxbN6WJ0q+H3ZlKD7F8txcsQKwyj4uUCotWWMEgiCR0jT7Z0oTBGtd3CpbmE5g4GdsRgTj7Itl3yUYWzMgyOhIEE3A5bFP0wRO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fDjv94Yk; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fDjv94Yk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYrVvLnvRp8E0kDkwzMqM1TIYo3PFv91K61wxYQRKqSMkFL+Bvp0C4WwM/18DAPrqD/INLDfo2oLEfRTswX+nioxpvax+TvDSh91sfDIHDwm3hdxKX8TrAzxvlDuIVWCKFm1O0Vm/71J8clwYhQuttx8ELkDR3z1EkO9kV3S6U+cHiSRvfd/HpRSqtVL3Sv1BMhh2uwjIOg7o92RTy4ho86vWe153BlnWgw8SxbiE1zmJsgmuF1EJrRRTYNPnezDzPQTKkTIK1ads6g0rWsqQp9zixWYwykGQi4uuB02ZjzLM37JO48zvrybAqN79FGNmR+Lygkw7qe9DkE/9aoZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsMVWPNPTQM/AOR6TeOGZ93b5gqZgupnUOmj5dZI7kU=;
 b=PVnsnNTINQDpibnElFQcF5iBAY4XMaPh1qinKumGaMDL9r7nBqIt0m7QGCfHeAZkI0+rAe9aJzNzxdz99CFdpQlEM2U8ekaM0BhaUmrDummhL3IQLcvLB94FyROe5XlFmzNaSKY2YS4joTonNe0qvpaEk7jIAaFz/qa0UlPI1winmMQnozMCmJ0axGOaAt0Ku4Qb6XYFrJLI9f6xyYV64kXC11UXZGred+fE6UvB7sUFCKaemFP1sjWoky8UMSQUaoiQCzPIfTiDvBSU0SZtnCz6MkCMwB5VLybsj8TddemCGR5zFYybEONKYeXRlGB2IHwrLCYv91bm5ftQe2rrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsMVWPNPTQM/AOR6TeOGZ93b5gqZgupnUOmj5dZI7kU=;
 b=fDjv94YkjMTdWlsLjVQPuVYyE0irmywYt6y9D8swQ+jbJg+CSYnLe9vXbdsv86GCjfQuI4D5/9PRfyrH+sAwyEd6/mw8lOOYgyVpER+2wyVWWJUUqyJKRuFUxI3yAhILRfZrkPwau4XqezoG/TMJg9rZbJD94D++J0OmPCI3wVh5IeQUJVRxhjFdtHI3Nop/n/jQK2n0vhv8hnbRQi3O5WysVnvSeMT0t/9rEMP2kCvzqMM8R+3U91KYDSkUjv6JQVNnP0tBkQWxrw+4JSeQjff7NpdlhfJQO4zxhuTNMXU3TeMhG9ruU4cA213HylO3gwmB3/ElvYDNy5o2adpT7w==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0080.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 12:17:51 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 12:17:51 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH 2/5] help: refactor command autocorrection handling
Date: Sun,  8 Mar 2026 21:17:22 +0900
Message-ID:
 <SY0P300MB080180E17B471505A4150C08CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308121725.2333643-3-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0080:EE_
X-MS-Office365-Filtering-Correlation-Id: 61af5558-4638-4131-88f4-08de7d0cb819
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|51005399006|15080799012|23021999003|19110799012|8060799015|461199028|41001999006|5072599009|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kCUg0pA0spD/y9cLTPtKpb8zpYF3mO+tFDCgLPy/bYSFYpTPGIrI+rVSp2R/?=
 =?us-ascii?Q?R03EuP4BqecbB+F1gxYzSdl56bP+sQm+XPjm4U8NaARt5GwMJVxh2bQAuNw1?=
 =?us-ascii?Q?eyOgxZY0VcfWm2vqqh6YoantOdNMWvUqsihvCjIhN/GWE7IOV/pwXUondDo8?=
 =?us-ascii?Q?0xWUDybLfboLi3TWA8pG2CvD9Rj+VZfQIHLPwHJr4LyEsro4KLmi+95xjToL?=
 =?us-ascii?Q?z6gK1czBZWQSrRWhWPIhniehyfgXuOeyEAUC0kjFQJidzm7sU8YljDuQftCh?=
 =?us-ascii?Q?25/PMVVnHuMT9I2BxQO2AArRr0YXr2pgUhw9B4tdLhKAhbOu/qSRTBc5BNBr?=
 =?us-ascii?Q?/88he5lMr8orUZlTQmprXCob7htYy1AOv30x8eEvJYsjvNGD5vkca6W+tTor?=
 =?us-ascii?Q?dSHLxVbsazktRAesdjaHzsuo3O7aYsndXW+h5JaMK4H6cbsVl6BfYexuS4nL?=
 =?us-ascii?Q?j8DrBCLn7kOCYJIdRMT7A0ZWd4/AF01qYck8pADWL2OntJkCxlq3iicT3TIf?=
 =?us-ascii?Q?basAxik0nlj2lnFg5CKxwg4XZh3VX55Hd1hSdgoKEJ1++TOrgihBpGpVxNkz?=
 =?us-ascii?Q?8heXQy7fqnXPGKnMxiR9C6YlJOZ/VrM0b+3AbKzcMF7Xl8Uu09a330SWHOzz?=
 =?us-ascii?Q?C+d+43wVvAXV2IMc1FEmiUQZTICEiA8/fBKQLGo8xI73CaY0b95KVD7y87aH?=
 =?us-ascii?Q?Har2LwqSVMqXjfGWycChm3+f/TijXcmoH4/JSkHocu1tDEy+P/S51otnHQQB?=
 =?us-ascii?Q?P1bgoiFOLaccWwfXIT/SMALm+rzeyoLRKof7ZsAWZyu04ejysvIS0QCtN53D?=
 =?us-ascii?Q?N1GrQEKiBKrFVp2yYovLNZgmaXLl3MgUZh+LxD49UnyVsOoyVG7K9sHXrlek?=
 =?us-ascii?Q?aSzQxw+o7qPUkFxGcH5YeQYX3nuxjXAvSJYzD5A6b2T20z1tBnsKSvV7HN8R?=
 =?us-ascii?Q?7f9LawNYQlgsf8GBM/ObSeEVWk5nMLVyHBC45xOVEthkSeYg9THHU+JP0ksZ?=
 =?us-ascii?Q?+bhW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3sNkFYcKuOYRQqwII+HCEUN+73pSpqM4BiO1PM1UHIGbImGZDIn6ur3XGVQj?=
 =?us-ascii?Q?1NGraJNDjnHusvX8dLbmnk8xO5SaB3vs3EBGfRDlpbHF4YDQdBTa3zO3FBnf?=
 =?us-ascii?Q?mC6KhiVHvXdLAhBZ7QCdz37prRMiSzIqcmQ61hF2jlgPgewPokXNNB3DDMFI?=
 =?us-ascii?Q?eSsk3DdvY44odW2UOPzrgIsKufSjaQq1uAnjd8qvkvzkXrpTKru2khSnTRnJ?=
 =?us-ascii?Q?TPeD/s92RzJWtn+US7yI/i1Wg+XDkVilK3DIyezuPWKC1rTGC1npJ3HTaZKb?=
 =?us-ascii?Q?sMDLL5itYUvOKpSZHdT87vpsLjBVqx5TVEzaH3ev0yGtyH1MUHgt46bGvtFt?=
 =?us-ascii?Q?pqA3pQURQciGAdMgDW3+Se8DViYRRuosEGN2FOTya/jHbpQgsTdf4zkq8gCs?=
 =?us-ascii?Q?buQaQ9qLKIk+WfGeF3KjHS6tJF9FUr61tqJlZ2XopyeucnpEDGjjjwEslu85?=
 =?us-ascii?Q?PjmCk2xq14i5WuNOX+nERLpMFtsoyhu0P6nSmE3EQRS5N3epNRtqwBkyqzn4?=
 =?us-ascii?Q?HjLuL1nisYGAPgXGhdcTKZS17Ny5bc4MkqphJg3bP7Q4su/rz4WxZ2oFLWkb?=
 =?us-ascii?Q?00zS8Ql4BQkD1N79SWa4UyY/NLKGN+duDrBOKtvzqOjGo07Prb/XebSO0HYl?=
 =?us-ascii?Q?SkCpGkKDybGJUP4gRcOyR+a5dig1cNEc0P+wxBbchxONEn/w+ze/IVzRaADT?=
 =?us-ascii?Q?QBbb/ZGivPMvKc+KQ/O8Ruky2BJWPB8DA3b9RKRxgj2+Wdtg9MSgxia5s+Po?=
 =?us-ascii?Q?GepDeTw1yNkoEV6mVUUsbNHRYXnq6tdOJCEifwAF+4QAZVgqrRXCZPM2fA1n?=
 =?us-ascii?Q?nYX4LJIh9i1FOwzASfoNKzJjoSW/HqkyfogMT3ZIrkalVMrMnzIBzsJnBzSW?=
 =?us-ascii?Q?J/iLbwo/8y/UB6cOouVALdjAruwiP8YowZRmkJXA03yQgdO1rp9QRhDzq+Al?=
 =?us-ascii?Q?imYkYGwgz7EVGwnJ6bfz5r4WEDRlEBvTnYOUw/lVypHOkj0D6UiVFBAHDAUX?=
 =?us-ascii?Q?2mI8SpxcaZBaKEl1MrEpxoNAbS/zY28AySS/1XG0i28RH18PmlAkle+7iAdN?=
 =?us-ascii?Q?tL2ElDZhSRHpJyq8+laj6nbfJZ3uB2G/eR8RntqiEfijKM3lPQy1v9XSQue2?=
 =?us-ascii?Q?m+LOUh9EiQ48OVGKtOA+pvtSzIKH+Gu1vf5GJZccw+gOKaI6vpH11vfi8HxG?=
 =?us-ascii?Q?QNppbZuv+AC8aRQ+BOswkGGgfeMJHtfRjL1LWYdOKpDK4FIkkSinB6Ll4Uh/?=
 =?us-ascii?Q?ZbDN80bUzCoVOoYEt8+oAnN4/FcFR8/7MOi3U3S+IVcztEHB61c29ZsTCRNW?=
 =?us-ascii?Q?s00JZkoLAlfpzF92NH201DPZwN2rpppDefbo7mxQwhq94rFK3bgFy2alO7OK?=
 =?us-ascii?Q?JZRwYx5KDdkcN8sYHp98I+UUWmgf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61af5558-4638-4131-88f4-08de7d0cb819
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:17:51.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0080

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

