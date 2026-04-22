Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D253CE483
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860393; cv=fail; b=PDTX0rBwYavX2AOKFXpibMrsuloYiWQpYn8mGyRlm9et4ZZj14/6pl061iaiM9reGOhXwAteu3BXL5c/5HC928nGCxNr2Dgd3OoNau43g8czB5PWf3Se3kSDYYm1DVYfawzwl296uxPfQPSVWyADOG+/ixIGZy2GoPRY6o57yhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860393; c=relaxed/simple;
	bh=KzcuyF78OVUY2lbY5YJdU75G30lkoTJVuHnbANQ4DSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q59cHtmVotwJWtmmJKgU/hymEtcUkws0xF2jWaMX3IvpMCysIPcKwg7L0mxUN3M5sWLesy63vpvQrtoCHzYThju5M+5PS/4Q1JeaIsjMxnEJuqnKHS86VpbZ0Soy1p555TXHNTcussUkcDU7+uovRVviHMAypqHBdFYGVC12E4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F7ARvmGI; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F7ARvmGI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHyg5qdqB4UO5iRWAg2DaopUJiuHlwTHK9xRpo3GcyWKu5aLKTbT8HDljqpqwOwBB4VJmnCBc+ozqc7Vs8VK6Gpb3TWNQ7V7FdOZ0eBx80zORwjxnwgghFYIiGH9LKeZp9dnnWzQ3M4J2kv6OGWOnqwAJbLIfAIhpsXhDpKAMgYotoUvKG2ckQ8ZIn4PTZuVMWhgaiCGoImTUVhZW+kVBnaVPLuKCFzn7Og2Vdd/EMGSMTVrXX93w+JtHcFIhJ+1AC/t0qsLRnapKhGQpU9vPl3jXtJfm46rkgP3DxTWBRbG95ciNTAzlpXHp+jfoHqsk63A8yvLOANS8JwnGZEG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQdRovOl83nIv3c8G3mhikzhZMb9AlZAd9IExBDGrzQ=;
 b=ocwgcwN/Y1wIBYpMs2UgRlwIJgmC9nPISwL+yLpCmS+zkEISCSXURGqQ7wD3GncrWd2KmeCQ29dbR8/ScIWqdOUCq7buq23PHQ6I8pmw64F+C9D8TFJtgCDKDuNPM6taZm8YLEmexWHXqYv3rvPv25WiFUKTaqUQBYTUh93cK3Qm9Erlsa2fxW0DW6I0oAcmI3J5x6CoXk38zcnfqWdb8H2CbtB2/sqa5G3jmRJ0JU/Zfaq2BrbyASsnK/iMAen/rrVCp1rOZ+Fe4LGmBak6fMQE2pN+1BwGiXYMLT5emFVI1e6Yqvf3UqxfOj37ZTI9WKxXzvHHDzGJJKR1gxDyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQdRovOl83nIv3c8G3mhikzhZMb9AlZAd9IExBDGrzQ=;
 b=F7ARvmGIUtX5nuJbdZbACtrt3Qf4xEPKgYoNZLTAR05sS1qWHAyyE5k7ax7wltDD4XLvQqK0XppoUwG++JpgWDEP4Wss5WFm7ADiU30DKI6xlHqxannAUwvD6M9A2YXF9Mueb9Pfh9XLp3QgZ7VyTq30fFdHDW5p/Jgip3m4MrnMkz8HpyDIvKmWO85XTJ6iQwR8Y2a3I283VRRxjLZ0/xnFmnuDlxT38dxCkqZhjhTPf6TsOIy7BZ35+kZp+Fl2mgd6ktg1Eafj4JXHfUyBlPGyPKOhL7l6RGmP3j4YrxfL7AADcexY0o86M4qLP1aMGrENnwZnPEAIOOORtn5HWg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:49 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:49 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 02/10] help: make autocorrect handling reusable
Date: Wed, 22 Apr 2026 21:18:02 +0900
Message-ID:
 <SY0P300MB0801DC1AC241760564952863CE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-3-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 91dfecc6-b768-4f1a-3adb-08dea0697273
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J712tSj9vuk37ahTo7M1pUoOfeRWkg+4mErTq08q4hKTkT3+hvUaPSF0KVzm?=
 =?us-ascii?Q?GmZtMsd/egxJj6VXsP5RtMbMpNzWFMr3/V68CupsITjn2hH8kuNUlo5x8Cvw?=
 =?us-ascii?Q?DkkI+UcYhy664NBKvnIGytlCtzs3hZiByOq1oNHslBfBuV+YP4xocvjZ24oX?=
 =?us-ascii?Q?2mcJ+3VJfb71pmvcIJnut5qIU6/zEqa1aWGE+A1npoLUrEDQi2rcykZYiohb?=
 =?us-ascii?Q?KYhCMdaKwnU8ME2Jl20zXSWI0o/1BrO+S7cmw2/SOajRaltMM1Kev3ivlkUT?=
 =?us-ascii?Q?RXXTJOsy6gLFusZQXLJntpBPgHGc6/QPKd93R8TfDvGLB9IvDN2EzkMxPA9n?=
 =?us-ascii?Q?YtwECHNP7mH6hskz8Q7VPlpKQI8HjbD80cWWmHZmCRMYnHuAHtDtQgRnTRp/?=
 =?us-ascii?Q?7MEFYGOjcdV1iQ/n0vX+EdagBCHC/g22yEhvNvNOCIfZWfS5evyGY995bKMn?=
 =?us-ascii?Q?Y9BHAIvcYCqSxaiUsJUe5y0Yc3Cpggel4pB/QjFwYBMwNYug0s0dnt8mNMpa?=
 =?us-ascii?Q?+eJv4Zdr/uu2nP/VGH629JX3cTeoVO9JlFOi7/UskrQg+hXpJstOU+SxJjBc?=
 =?us-ascii?Q?Dec5tjBj+L8OD3JdmWhuz+Uiqiy1sJ9vqJRjw3RUOGfH8N70FGnKdXM4i5gc?=
 =?us-ascii?Q?JrCXsFo/C/N3nlHCRMcc6WoERVUBYKtf+rCEg3sLnkhVlErLBkWHvtp/IX3Q?=
 =?us-ascii?Q?5pgnqRQI81egsK1knPk5gbOqjczDGb6poRtq97p8WoRHLHLYDLq+Iz3VL8mN?=
 =?us-ascii?Q?RyNrxjO8yLHsasOwCZ7N3Hc/6CucFq2NYGFcu+54TcB8+/aQfv3zulNryN3B?=
 =?us-ascii?Q?zKulzImvJj+9NxmoKd8Gu3l3ZZKLOqMfUBTlrN4U7HPBVe6D5Ys0RVmDusJo?=
 =?us-ascii?Q?6oyLAOs3J7MPNbEGbt2EkpNRIpN4DudVtwYtKy/z8T/Ts5nuMtlZ9CbCueTP?=
 =?us-ascii?Q?rp0+lOL6eJ7Ehmqu3lMR7LykS4EIhAbNSiaoqKk+aqP2X0WDDsSHd4WaQIhB?=
 =?us-ascii?Q?fmpAKjpDFI+dHjwHPbEbphqVmA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EizKeaHj10L2kP46D/6sVT+2HdqbL78fWRV6W12sAGDE6nzPl7Rvl2ycFBhK?=
 =?us-ascii?Q?OtPaHZPNVgB5JIVpuHymNo1guraJOfCca8TbMKFtBVeM4Czo/eGaQCofCI/B?=
 =?us-ascii?Q?exfn2vjRnvy9BzqY3P30+OMLljz3eTjOVV/yO4b9Ar1JTCsOVmZns5dGyiuJ?=
 =?us-ascii?Q?m5c/oRNtoANc3kSyUNi7DL/HVYusr++diyk7rCMGn1yi7Sic0WqMq0Ia95m9?=
 =?us-ascii?Q?PBEe8POuFlqOph0y0nzvls/zOCIUJw+rG1elgmJkjgi08YD81D+XjuoCOup3?=
 =?us-ascii?Q?eeo/1ZQF8T6KfQJcrc1FvJ69GwslAPR5DY8zvteqIdQjDZJ+CSx5kdJn/I6Q?=
 =?us-ascii?Q?o8jnU9TT8wxb7sh8CYu9xiIAy4X6u/yAAHtJnLBZz7j6dn7b5zZSVQvIypYC?=
 =?us-ascii?Q?+VC7ug8NFpUXV1mzwDvfVf3GfN9yS/rPPfPMXe32dk6gnsk0IpWsXXCfkavK?=
 =?us-ascii?Q?EwloU5RAKmmMC5oqywBD1rpRwfb5MmgD0KNt+3TI52tpln2KARJ5n6ziX17e?=
 =?us-ascii?Q?0eoVnselOoqa1CF1VxqaAgRbIoDnaTbhbz+JgVfFvlyYYvSmU15dIudAeO+S?=
 =?us-ascii?Q?su+u+gQvG2aElQWy2VzuuTNcyQM1NcA8UoRs9AN2QK4pgoHpZl+tbu6RFZqT?=
 =?us-ascii?Q?R4gdiNtd/M9wI8W/Q+4zjcHKOL3Mry1PMjyWBlyfgWM0a5tQ2iCBbKP9VSnx?=
 =?us-ascii?Q?426YQbvh0jP2Z2DZ1N0OhkJS4HKCsrafdGXrvNfySQ6sZLOP+scGUYnGq50M?=
 =?us-ascii?Q?oWI7PBlBrpFO6qjA4sLJxKPAwZpyZ0Zphl/FSS5fNmPvWr/Oh442oszKBxzU?=
 =?us-ascii?Q?nqQhqgyF7Ws1XBbwlpnVEGwTm9ons7jBUKmwsHuiGtRQqrxqehmRYUeJATtd?=
 =?us-ascii?Q?6wOluUuSKPO3rnlXqbIlonT+cgTwH6UvDUbl2okS6B5EuImDU2PC0ue4U2bd?=
 =?us-ascii?Q?tS7ud9fy0lyDoMvYYcXLesKCqmv/gxujPiSsSM5/vfQT8jlL1UNMMX0WnMrk?=
 =?us-ascii?Q?ID4rvCqwScREypAzLTm23W1qVc9EkfKuzZ0B1JSh7H2yiLTDCN8GzxNOscSf?=
 =?us-ascii?Q?GdUJzad3Svm+3Ekyft4TME2KKsn5cL6uQ8yjo9CC55F2VeCpB/ib9nrqggoA?=
 =?us-ascii?Q?SJBCKwHX07vRDMR5x/Lw+276XDT8Wuj33L/l53DC/A+kBbuT69Ygz9cXvVn/?=
 =?us-ascii?Q?y9EH7zeZBa5RthEYgRSGMkM2DfkwKEi7JtHi3An0IXsLDjAvv39zViroPSEb?=
 =?us-ascii?Q?Khrc+jBLA+8Rj8FGucmkv501sAqlDN58J+iGP9LMcW6r5u6/r5ThYYFyjC70?=
 =?us-ascii?Q?eE7UwjvIU9INapT5611VFWABoobV80oZMv9RLP94kHQ5/ZaFCOQgUzeUFXkq?=
 =?us-ascii?Q?wjgi4+Yg/4vUvBC6nvpOqNJ4Zg4H?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dfecc6-b768-4f1a-3adb-08dea0697273
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:48.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

Move config parsing and prompt/delay handling into autocorrect.c and
expose them in autocorrect.h. This makes autocorrect reusable regardless
of which target links against it.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 Makefile      |  1 +
 autocorrect.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 autocorrect.h | 16 ++++++++++++
 help.c        | 64 +++------------------------------------------
 meson.build   |  1 +
 5 files changed, 94 insertions(+), 60 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h

diff --git a/Makefile b/Makefile
index cedc234173e3..ced8a9b5abb4 100644
--- a/Makefile
+++ b/Makefile
@@ -1100,6 +1100,7 @@ LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
 LIB_OBJS += archive.o
 LIB_OBJS += attr.o
+LIB_OBJS += autocorrect.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
diff --git a/autocorrect.c b/autocorrect.c
new file mode 100644
index 000000000000..97145d3a53ce
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
+	case 1:
+		return AUTOCORRECT_IMMEDIATELY;
+	case 0:
+		return AUTOCORRECT_SHOW;
+	default: /* other random text */
+		break;
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
+void autocorrect_resolve_config(const char *var, const char *value,
+				const struct config_context *ctx, void *data)
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
+void autocorrect_confirm(int autocorrect, const char *assumed)
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
index 000000000000..f5fadf9d9605
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
+void autocorrect_resolve_config(const char *var, const char *value,
+				const struct config_context *ctx, void *data);
+
+void autocorrect_confirm(int autocorrect, const char *assumed);
+
+#endif /* AUTOCORRECT_H */
diff --git a/help.c b/help.c
index 3e59d07c370b..ab619ed43c7a 100644
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
+	autocorrect_resolve_config(var, value, ctx, &cfg->autocorrect);
 
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
+		autocorrect_confirm(cfg.autocorrect, assumed);
 
 		cmdnames_release(&cfg.aliases);
 		cmdnames_release(&main_cmds);
diff --git a/meson.build b/meson.build
index 11488623bfd8..be20d507826d 100644
--- a/meson.build
+++ b/meson.build
@@ -290,6 +290,7 @@ libgit_sources = [
   'archive-zip.c',
   'archive.c',
   'attr.c',
+  'autocorrect.c',
   'base85.c',
   'bisect.c',
   'blame.c',
-- 
2.53.0

