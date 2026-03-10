Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9E389113
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142887; cv=fail; b=Pas1kbia3PrOIqe1wZYogM/IpyqzN2RWjnHeunPAS+hEo4xB06h++Iy+zCeL9Bmi4JLevp173qSRlOC08eW9KrDhOZeACiaNznn0bsPM8cAQXFj0e7xi2rhJcRLwNNc9kS9xmqazLA0ZDPdJ/RG8iUKP7fc7k4mxmTJ5RFEHvrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142887; c=relaxed/simple;
	bh=WLT3aT2j+4n20mmHSXWBCayHE625W2bmg9AUpGMAp90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cNCZvMsigOB76HsG3vhGgBAaBY03ykXQtczI0WpfxhhQZ9WgAIJ5JwKWhnlXLqWYQxhupcemaaQO5w8kM2uZaSPjnXDu5XTNVPmUm+6HhdFGESOsLazL3Nn4UmGqY//rfCg/iH1oe3AcxuyxprhFekMKXqkOu8Hzxigle1pMjfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YYI9IDc0; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YYI9IDc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqA3H/3iBnjzFMBLEFYlBy4/XcrMkGWqMi/NxlAlvwUUsa2GBexwWrNmp8r+7Wcsz/K2JOHrh92m6A5Yi/YT+lcMaMKtTllhsrTFfRchquDmzmYL+DReasNLQsRG1E+D9kGYJsMXEUi4ozJwo48KPWjCF2WdzgBxyxeqIZKW8uIv0ZEb0jR8bMZ2qX9vx1yVJPsQ0dh3akjJqi60ytrqw5AkSeikRVlcqls2+gYu5IlTw5+lMS6ZT5VbF4mDg31Sk8EHvwRLt+EAJkt05cb8lHv3OCY/e6jlzfnIvVuvoasX6xDILnhTa121Bcff3jW4a9BnV8ZSa5WvX4SNCyV7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKTQDogVcws8Wrj5HEPGgai7PvnbUVKNYJDnct7Rtzw=;
 b=OBxrdJa/mjbsfu/qFsvqozxxqgkxgfrazK/BU5R5TXJ4ntc0Wc6ksvOaZMcL9wFgugNSMZ34kdIAdWAqkSlf1+SHK2hseKl3DnvUwqEldbsLh4IEoQMJ1etQ/vca1arYt33jHLtlzcXoS2LO9SPE8CmXIfZimsEPV9utod7Yh6JPXPn+UJCEu2QdDtx3VlHtUx/MH/YBmueV1kUuCY3oN9IDkQagAdmGNPrWrN3XSA+YoN2EWH8Bb5MKpvcuMlFw/Iog8bW+oEOp4iEzT2IsTB1WpT8+PcKhlvWjgO9oSr9afPeMNcC9whQEliocCcBtcfxoE4R3CyFrXzTSWhi1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKTQDogVcws8Wrj5HEPGgai7PvnbUVKNYJDnct7Rtzw=;
 b=YYI9IDc0Li6xxUHyBT1qVxmq/F4s6r2QYx1MRX0HIkyfbrupQWSTAmGnhKbCfmFcEQjHqfsoCLI+09lXVoj9C7/Q8BY0vBrGPCEoO6so2vAQ2YnTh37Xyd7c1/InnQWLhmxOvSyqXBRiznuFojtTuSx58UMmcsrxKHDkzKG+Ds2eVNewci+Kajr4UhmM5UNxbMrRZF5T2GqOx/kyKi62Zv6PbwO5GR/3xUj/qimiRRerIQE37bPYNdPuT/q0E5GoIOmx8rl68Rk+YzU+cyQLB5+h+cndQNKKepLEInCEhEgHQTYR5QNFBa2WRTP8qvE8lNdog5z5VXKaWi8bptTZQA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:21 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:20 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 2/8] help: make autocorrect handling reusable
Date: Tue, 10 Mar 2026 20:41:01 +0900
Message-ID:
 <SY0P300MB08017404C417D02058423130CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-3-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 0b7788c4-c5b2-4506-3cf3-08de7e99f2ba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|41001999006|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vId6NiyR8V8GzbUEnrAEuHBWUyBdgZmymBfk7ZfNnrCKVUMQJmozUIwO95Yk?=
 =?us-ascii?Q?ALNbIUo2mst9WoHvWbjv+Z5DpvhCyRwQw80kavAPt2tCmMQpzUKaPv0K2pW3?=
 =?us-ascii?Q?a/m+RKu8ki3zjG5OupDlTLhaBdDMnaKulo4WK/TlW2+8wA7EviRq4nNNqCO/?=
 =?us-ascii?Q?4o1KiC7Wx1f92tCil7OOgT8bbeRmgvVf4rMDRAsurp+CSzBtReg2T7jA+g1O?=
 =?us-ascii?Q?upv9KtY4a4JmtWs7uSUpsgfSntvIzLJ5S1zwnSHhIWG7DSC1G/kug03DSs2E?=
 =?us-ascii?Q?5DP4A5bdQjKmOcbAyZMdR9Xr5U5Ew7emDTqoQir8/xXr9K8b8EDi213N71x1?=
 =?us-ascii?Q?l4VntzLm4aX+hrNdkNau7Fc9PQBasCPdZUnwKQiDyWkJvjfQeip0wZJBecxI?=
 =?us-ascii?Q?7/0BBxxffBALGtmYlUzawMELLctI6eAmqvYsnahW7Gq2LfJb1GQHuLaK7ROt?=
 =?us-ascii?Q?Fo5orvJagmR4XxfqxqCxFTiGpS/FghMFZVUzCxAT1uFLGwsS1SG7iOnB7PQk?=
 =?us-ascii?Q?MyhEC3yEQirrzYIgtO4LvQrjuuDVGYlhSb7l4lCwd4z8bd+jdg/vPnyX37Ta?=
 =?us-ascii?Q?7JWMQhGdeBWZfTlXaTHIYcIwdSRqfGg2JUfCvT5T0uJEe477ebJBo5ZwCtDl?=
 =?us-ascii?Q?Yi9Wm0ePlJ7xhLN35oPGZiJBrTmyzgCsHk4driON6TSfxjMLcrMiUoakXkw6?=
 =?us-ascii?Q?P+Eq2vwCs0oxGy1aCucJSp2zansWrpgVALYi4SL03NF0V4RsrFEo2K/yE+1s?=
 =?us-ascii?Q?qjklBksP5THcmkndJ7rwuTQC4SEGTfpveqF0Ok5Rm3YP6DW01ILhdTZx1+Y0?=
 =?us-ascii?Q?L9Zf+al8PkPM1ZMpf2/gWbge0sYrk7P5klJzwewSrriVSboYNLMoWeej6Z0S?=
 =?us-ascii?Q?9RIppkvbPSovdOM2O7cwIi5Ja3C1qvCye5Z1uKJOiBBsJFJlI1EECxMGSUd6?=
 =?us-ascii?Q?ZJSv6Wv96RRxN7WOpZdzUyCxLrb/zaRl9VjneUp0yvpC0oQuhPgN7W6LokbZ?=
 =?us-ascii?Q?1V3I?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ByDTqzyfEZLDCtGdtqbCOmPbQhVheExxi4nb7O9e0Lgm2HGT7OmCR2IO79N?=
 =?us-ascii?Q?yPHlvedjIeryxnaWNhou05ZD+IG5TJ1CQ4F/t055GMKoIgl0oJjUs3WPMPiD?=
 =?us-ascii?Q?K5VBA7MjZUGPIQsAFX6X6F2R6UAoBCn2bOCosgKLZGlyK4g3Tqy6Gmw625vA?=
 =?us-ascii?Q?RpFaYwiob8YjRf7AeTQE0Lwvm6n7QzZNiKDnksxANvHtldM8Xmoi+PglGc7S?=
 =?us-ascii?Q?RmMvbK1IqPcIE3C7Znuj3zGsBtOVqsYJ4t4tHZNxxnigx/vo71Uf4GTvoq4x?=
 =?us-ascii?Q?lBOrRyxFcBAccCmCqQuu4BzaZLIKwvXH14Wr2yRrONbzJIL6LGDDVJVlBDbU?=
 =?us-ascii?Q?P1sz0cY1M1V/Q5sdDSXgzcp2rkS79fdiwcgA5cILX7oKEVq6QZgCpSPwXVTa?=
 =?us-ascii?Q?NSEcXpBAaVYpjo0O2SOGqONlv6L8N1JCUwVL/OU/YDdrsKbQkFjtYmFHglk0?=
 =?us-ascii?Q?ziFQcykEwb9YAMobgEce7RIgVch+YszxVDW8U7XYcq4X9Sy34qARql+Kq28Z?=
 =?us-ascii?Q?nIZq5T0pkUGtLsu7BEKvHD87s98aOxag0GXpbL6yKNb6VKTBT8xLOqc2NKW/?=
 =?us-ascii?Q?2JAJKW3bDeIof/UxF9l1ZK8DZUI3kaU+m5M0exvEVlSR3XsykFsAlJo6wzM+?=
 =?us-ascii?Q?4fackz9kmx+HN/LBQ0hQ2Djw0zjCaNKfhXYDubZ9krtPcIUtq2VVu8ALG1Zz?=
 =?us-ascii?Q?YSreSgp9o8EcIoDJcHjHL9yXiX6/0iGHS9GG4LGErJ4J9BpHQAwJD6FMNvzt?=
 =?us-ascii?Q?UGD14fjanDcaWF1QlDgHBL3UG6AkVEt6kHDx2XQQ5tK+BFtZkYUW6oqLu9VC?=
 =?us-ascii?Q?VaacQ/ra067ZFogBb9RwY1y+FGxIhw02hsSTLJQEGSlalHVjZ2TVR/dRzrXe?=
 =?us-ascii?Q?v05n3Wg66uYyVnvmoEi1U7A/CFO0QAlM+WLUkj3YtGb/GS5MfGBdgKqulxqY?=
 =?us-ascii?Q?BpDWt3/rrgBDWcMJZj9DBhJ0AoVQBEkSMgxchyMm2m5qpOJhUTN0l/OeJx1f?=
 =?us-ascii?Q?tBlwtnH8Gq2Vqc3F7OhwZo/w0KGE1hflNIY9vJu67MjE/mpXbVpcjNF5i7DO?=
 =?us-ascii?Q?E8GYD95pv5RB/Y/OA7nQ4g8056PP3eg0SYX28aSPRChRq0jR0FmsyCLLRaEV?=
 =?us-ascii?Q?c5nrE747g/5yJftKZU7CZmtsNXLY3MKlTMXLaJNIdGZ6gKqoLh1CKa3WIzz1?=
 =?us-ascii?Q?DBuU4qWUTQ4Dx6YqT7nVEVT10izGZ2X9ZHh3Oj5Zvwzyyy2nETKDo8j5lakc?=
 =?us-ascii?Q?RsBc0fMczCO/HR+IwHKmUKlpQOwNEzBTZLjK5GevzhhE2S9VPgXzFOVIfQIz?=
 =?us-ascii?Q?2jv1UWah5/562IuczHq1gncPTrMpSjMm2B5Syy0yLIUF35Nym+X3isbp5X+Q?=
 =?us-ascii?Q?UYUKJ4PrqoHySJgk19iTyr1nCbpb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7788c4-c5b2-4506-3cf3-08de7e99f2ba
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:20.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

Move config parsing and prompt/delay handling into autocorrect.c and
expose them in autocorrect.h. This makes autocorrect reusable regardless
of which target links against it.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
This patch moves autocorrect handling out of help.c as a preparatory
step for subcommand autocorrection.

This is necessary because help.c uses load_builtin_commands(), which is
provided by git.o. Executables that do not link against git.o, such as
git-daemon, will hit a link error if they use symbols defined in help.o.
A simple and clean fix is to make the relevant functions independent of
help.c and move them to a dedicated file.

Changes in v3:
  - Split patch so diffs don't get hidden by code movement

 Makefile      |  1 +
 autocorrect.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 autocorrect.h | 16 ++++++++++++
 help.c        | 64 +++------------------------------------------
 4 files changed, 93 insertions(+), 60 deletions(-)
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
index 000000000000..1037f032019b
--- /dev/null
+++ b/autocorrect.c
@@ -0,0 +1,72 @@
+#include "git-compat-util.h"
+#include "autocorrect.h"
+#include "config.h"
+#include "parse.h"
+#include "strbuf.h"
+#include "prompt.h"
+#include "gettext.h"
+
+static int parse_autocorrect(const char *value)
+{
+	switch (git_parse_maybe_bool_text(value)) {
+		case 1:
+			return AUTOCORRECT_IMMEDIATELY;
+		case 0:
+			return AUTOCORRECT_SHOW;
+		default: /* other random text */
+			break;
+	}
+
+	if (!strcmp(value, "prompt"))
+		return AUTOCORRECT_PROMPT;
+	if (!strcmp(value, "never"))
+		return AUTOCORRECT_NEVER;
+	if (!strcmp(value, "immediate"))
+		return AUTOCORRECT_IMMEDIATELY;
+	if (!strcmp(value, "show"))
+		return AUTOCORRECT_SHOW;
+
+	return 0;
+}
+
+void autocorr_resolve_config(const char *var, const char *value,
+			     const struct config_context *ctx, void *data)
+{
+	int *out = data;
+
+	if (!strcmp(var, "help.autocorrect")) {
+		int v = parse_autocorrect(value);
+
+		if (!v) {
+			v = git_config_int(var, value, ctx->kvi);
+			if (v < 0 || v == 1)
+				v = AUTOCORRECT_IMMEDIATELY;
+		}
+
+		*out = v;
+	}
+}
+
+void autocorr_confirm(int autocorrect, const char *assumed)
+{
+	if (autocorrect == AUTOCORRECT_IMMEDIATELY) {
+		fprintf_ln(stderr,
+			   _("Continuing under the assumption that you meant '%s'."),
+			   assumed);
+	} else if (autocorrect == AUTOCORRECT_PROMPT) {
+		char *answer;
+		struct strbuf msg = STRBUF_INIT;
+
+		strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
+		answer = git_prompt(msg.buf, PROMPT_ECHO);
+		strbuf_release(&msg);
+
+		if (!(starts_with(answer, "y") || starts_with(answer, "Y")))
+			exit(1);
+	} else {
+		fprintf_ln(stderr,
+			   _("Continuing in %0.1f seconds, assuming that you meant '%s'."),
+			   (float)autocorrect / 10.0, assumed);
+		sleep_millisec(autocorrect * 100);
+	}
+}
diff --git a/autocorrect.h b/autocorrect.h
new file mode 100644
index 000000000000..45609990c77e
--- /dev/null
+++ b/autocorrect.h
@@ -0,0 +1,16 @@
+#ifndef AUTOCORRECT_H
+#define AUTOCORRECT_H
+
+#define AUTOCORRECT_SHOW (-4)
+#define AUTOCORRECT_PROMPT (-3)
+#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_IMMEDIATELY (-1)
+
+struct config_context;
+
+void autocorr_resolve_config(const char *var, const char *value,
+			     const struct config_context *ctx, void *data);
+
+void autocorr_confirm(int autocorr, const char *assumed);
+
+#endif /* AUTOCORRECT_H */
diff --git a/help.c b/help.c
index 95f576c5c81d..6be3ec9dfb12 100644
--- a/help.c
+++ b/help.c
@@ -22,6 +22,7 @@
 #include "repository.h"
 #include "alias.h"
 #include "utf8.h"
+#include "autocorrect.h"
 
 #ifndef NO_CURL
 #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
@@ -541,34 +542,6 @@ struct help_unknown_cmd_config {
 	struct cmdnames aliases;
 };
 
-#define AUTOCORRECT_SHOW (-4)
-#define AUTOCORRECT_PROMPT (-3)
-#define AUTOCORRECT_NEVER (-2)
-#define AUTOCORRECT_IMMEDIATELY (-1)
-
-static int parse_autocorrect(const char *value)
-{
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
 static int git_unknown_cmd_config(const char *var, const char *value,
 				  const struct config_context *ctx,
 				  void *cb)
@@ -577,17 +550,7 @@ static int git_unknown_cmd_config(const char *var, const char *value,
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
+	autocorr_resolve_config(var, value, ctx, &cfg->autocorrect);
 
 	/* Also use aliases for command lookup */
 	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
@@ -724,27 +687,8 @@ char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
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
+
+		autocorr_confirm(cfg.autocorrect, assumed);
 
 		cmdnames_release(&cfg.aliases);
 		cmdnames_release(&main_cmds);
-- 
2.53.0

