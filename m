Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011061.outbound.protection.outlook.com [52.103.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E523A6B68
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908304; cv=fail; b=admaMVhF6m8bNX3w4GXnt/GK8a+mYR23+kXYk5C2/gRXU/br9eIcoqrD/YXrNtJA06RQnx1Rct0gVpYirQdksE1H1gEK8FugM7OrZY9D2eow9xSE2JTHrofsavPPwMckX873P+eHQ4uRjL0gD89QP9ZVpixQPiBKrkgaFzULOGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908304; c=relaxed/simple;
	bh=hCJKrNgAVaT4Z1QuQe/lCSFlda/RNQzivLPF0CsZURA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUF2KXH2lT851lt6tfiB29ApEXJeSNTCVSL84VxlE91OyFhlhuLig/eceDXELa+OOGRbgqJVveB4U9+5UcMThdU5eUCN/MHOM/EjBgahr+2mtzL2peQb1UeavYU5JBx0GwepyEMw+UyqHw2+k5v1Zw8EK0z1Pk8rArksyE55Ssg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q4vejrjO; arc=fail smtp.client-ip=52.103.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q4vejrjO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFN1/ainXRQ656mFxjWtFYAhqGQ4bS9WxyIQAxpQOKf2gCF7KcMKpLraO0CvfUq6Taa/dEeL7hHFTMhNVKWn6038bWZOpN91wsV4pFhLk2F5pJK33TsbId2GU1HxDygdIIKf4rjd4I2ayuXj9qcNL3EE9uaDAfT7LXsq0pY1LRDOawVjarJg9K2HRy+WOcwnCOyRPkUaFyVr5grN00tqF1aVGOS05IpMgT852OhumV7vm7XuaaLXpSbAFKbpPFYVosfhPLo3QAfjUAwLR/7sMmu38WqU0wC1JSTMzSRtUXivLO404iIavdqrLApFHRoKIHekX2GFSOSnFYCo0YmaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVbQPPc8yHSUm5V4O8QB0HyNHAI5deAgJOkhZdG9dsk=;
 b=Rc3ZsBaKM+ol2hVnj8MfNVNk3qUtDFi3NF33KgqKEF0QyLPjhztDw2VrXXhGZfChUMcGcOBT+J7yUYvbdBLK0bLi3MAn6sYMi0yzGfCwtFxj+3d6EGegrd3ibPIEkmF6tA15vccoyvPEf6BHv6Vy9OXBXR+Ws92RqZ0E7Oserkelscg6Fubic0uLLoAej8U0ManGtUVnVmiQMQtnCks3AGTqEDpZnCIrCIK7t0yqf94ez+wAsguWadvIV7e8QhvcEPPMt/gqbCuNxo2nWvkjti3ac9apZ8AIksKBu3I3zQD0Tmi7avmtnLEcxMXow7Z4EBn1xSqVOWiEk99+Ljw35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVbQPPc8yHSUm5V4O8QB0HyNHAI5deAgJOkhZdG9dsk=;
 b=Q4vejrjOp5UcIiKiGYSruMOr2GO1Y3GOQvgCGs7DY9MfQVBCjxd3MinvlOImVkF8mkdDtD87PqOAByVB4YVChPPj53rdVO5R4GcipUxxkE/cLcoE28NPXDRjj3gvYSSN8yEPEo0fRF1O3NjSByH0k4gF5QMAT3hJZa6DA4lKCAj8Luy3/4HR2yFeX40mslnd3NGKpiDXhKkjyCCYtmlSdT/DTO5kjokX6JS5XynylBOwmiHpzex7B5a4zlQ92mzuep/IjdvCKJ/p8XcNTNM3zFRBOiNx1frnnzfQSD2R8BaBo/43E20H2WXjDjLZU8Kk0+ZONJ0IgD1rKBykGiz6Ow==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY3PPF5F39D32ED.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::498) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:18 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:17 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 02/10] help: make autocorrect handling reusable
Date: Thu, 23 Apr 2026 10:37:52 +0900
Message-ID:
 <SY0P300MB080119BC1519FDE5DCD62088CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-3-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 02def7ef-faab-4ce1-abb4-08dea0d8fd96
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|25031999004|8060799015|19110799012|51005399006|5072599009|41001999006|15080799012|461199028|55001999006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDnTVpsQKKr1ffMbJd1W5YVz4apTVbpm1pRKa9XwLe7Ir5Fh+1mupUSjHNfH?=
 =?us-ascii?Q?1A5Mmiht5rPyMUQ5yn+mEz1f1eCQAMSwxVi+MnmGIA3opheav7R3skl4uhj5?=
 =?us-ascii?Q?UdNRM/RRIyupXGbWd2Do10esWIyvFziLRiKnT0/kFjnJHwoETvWup1fKUhWY?=
 =?us-ascii?Q?zBNlu57TqPj2ckF64CRobil/6/YqeSIANNauz/IyBRejv5rXoHR32Azms6Sm?=
 =?us-ascii?Q?U6/cukLTxrYg4ZVVUH/Vx+danUlo9/FgHNfTSQpOCozshY8I44ypgzFJtfnF?=
 =?us-ascii?Q?zfoSlA5y3v2jQAEhMCcb3MVov4EIFZbwlB/EeNRKPynm4jw+zHL1hzftFwRZ?=
 =?us-ascii?Q?KCntWSPc+Dp+tww5VGxwaoTTCEbSIYiE+AzJr0L6hJEAtz2TPdePaSR0Uozt?=
 =?us-ascii?Q?CBWloY/0QZgCqQ3Cw6Laqo3lBT7rBa+b+PrC8OqsAP2FADHD2vfLV+1Ks6A4?=
 =?us-ascii?Q?WC1776LTrq0CRUHLoDfIK55n7wpk/YBUK6KVPeZmi6VAhRwFSXHx0M8Nj8Dr?=
 =?us-ascii?Q?C4ZaIJXefcYZ3jIgxO5gtWgs/TsrMJer/Xa33kuGQ0oKN1ZAwxSi2CxPlmBB?=
 =?us-ascii?Q?XA9yiv0X1WKqlgRfRxWJGOeQ9TBGV0j0wa/hdl0MoHshvSm9BEbOXVSDHqMF?=
 =?us-ascii?Q?itsos6b9blHxE2r4a2Jhmbi9LC8ra/ILbqI5F/7h3DA6X4a4BJbocXZ99iI2?=
 =?us-ascii?Q?1k1QRQ56UlClq9s8uklHgDZ2VIqrQVzhX5dMEhNsCvjGHizjs0MbziI5yR6X?=
 =?us-ascii?Q?KjCxvJJPpKgmThy7rcdDbBCJCEcq95HVuL6/uaX2+UkDKISnDvb0+8q4/Dan?=
 =?us-ascii?Q?6IRdZfYmQg8Vo8BRywT15gfBurs8Dtm7zuPXbNehT/7Wthfk/5MfgPhzCrSo?=
 =?us-ascii?Q?pq7lmcd40kgtK629+pujDlQRewtxi1/Y+jvS4kGg/j3nzwQHFRTujkIBlJvG?=
 =?us-ascii?Q?oRk8wk9mSQvI60XAO+grB+63GdIhUdbQJiXr+mtIYOFQx4mAq7m2cF+Lj3gS?=
 =?us-ascii?Q?BAnmcchHjmjoxyBbHKSEQ2h+uvEkQQ1VY8iQFEKVuNuy08ZXmRcadBYHtIZ9?=
 =?us-ascii?Q?tvz78GUG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GHTqA7f0kjcvJRmKrRXqpbgFWBGqa9eytLht5v2/Rn9a5IbdSv2InWxsdjn?=
 =?us-ascii?Q?ZlKfrIKTa+3Ov+P5K/EJU+NZUZ4ND+vutYlSEr1hs3/8FOocCIHR6sdxP8gc?=
 =?us-ascii?Q?rvgo5ZgsZe+GthfTbWFH2PAdmcksCEmx848x9DI/6DdcZDzIKfAilGUll/hO?=
 =?us-ascii?Q?BbaTU0SyW6a+60qg5U9EJLlMepJrUcUHAseXQqv4xhFjHq+Yr8+fnOoHQAr6?=
 =?us-ascii?Q?F+SGuCPJ4iufcvhY1peqh0OGC2XzBL5dWPXcpZwaEkjkVQfVRBI+rGysabBm?=
 =?us-ascii?Q?IF0gqBPGq1vXAWFyBnQCkPNi+t/M/wjUWzd52mJKX8aNlYM5dRJRfDf2SpYh?=
 =?us-ascii?Q?h2KJdl/P0d1lThvRavjdE1vBx2dbQhF8WLfwXx7i1SV6avTBYfV7MM9ISx20?=
 =?us-ascii?Q?/z1s/nPCTeapnYe+Cr9TAoqoTgW63fT4m/sac/VC4Hqb2iwmvUQcI649Wogq?=
 =?us-ascii?Q?4UmwSjol6NYUh5U+UYWHtpWLrtikf9mOYJOZd4b0+1aVSOdXrRBdbQPIkdsO?=
 =?us-ascii?Q?GRVkQiLrwiDE0HR7o+YmaH8m6pxH3xQHlD6/2C1F9WhvrmydHkLqkwvKWV84?=
 =?us-ascii?Q?klP7YBrM4mqTyekhkmELXrwQ2k0TtxgiDqMcUqPwEGAotpVMOjZx58WjSmwq?=
 =?us-ascii?Q?Gp1FJWXHDgbKTOV3Je6JEaPRFadYo1dZEEtPsmjP1Sofx25DGsEBuc9kJktQ?=
 =?us-ascii?Q?rSN2yQbe0X/RrZUNBwcudujLrZdzjSiSXa/7crYsIq2smIfkS/NfBi8c4vQE?=
 =?us-ascii?Q?7WGBYyx88n4cpXUxMgsaC/X3GHsyjr6LEs+zjuiMXnGYrEhAmNKbgONNUnyz?=
 =?us-ascii?Q?pHq3sXjMj3avkjLprNcOhFjUTXGrwl9oiz7E1ax/RRFMwEM504dVzDaBawv/?=
 =?us-ascii?Q?yfTRYrEArY6JcYblThyVI+GMiBtJKIgFD4AftEYbRDTA9ngJkZNHmNh85+I8?=
 =?us-ascii?Q?xGeg+3yB322CgU65Zsybmuu5cvCd9oHVu+PvWWGktPIzJdHWfqVmR1pTyfW3?=
 =?us-ascii?Q?dFwg74dsl8aUxM1JkO2JWfjMD95XkuGCGzkr8JPO6asFntuvJox/hhFAKCkS?=
 =?us-ascii?Q?5KQxXbhoZpHD5/VSGZmImch+GuhfXYaxRECH9XmYOqO6u6HGFoYupjJBZLrN?=
 =?us-ascii?Q?IzbM2hjh3ppPZydzT9QXVUd4Z48nuZE7IUyFOc28uQCRwD9STrIMdmGj+zqZ?=
 =?us-ascii?Q?5XDKKvdVQ17H7TMMOJ/9E+IwGDwPvClSkMpKXNBiqCUuuZWWzLWMZyfmDy15?=
 =?us-ascii?Q?SIygsrIS45j3ilvYzPhsVjVKjarMJS65BfsEWrTF9DuWzeX7NcH8vZGYW0UF?=
 =?us-ascii?Q?wwtbQeEfI1Hw7xfw62MA3zohT8L7wldsbZ5DOr77p/awt7Xy5aoIgZhSlhfs?=
 =?us-ascii?Q?coQfixWCS70NgsFwvR3kgsN7lnhI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02def7ef-faab-4ce1-abb4-08dea0d8fd96
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:17.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF5F39D32ED

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
2.54.0

