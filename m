Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5139D6DF
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675404; cv=fail; b=pzWHk1PF9kDhiPDVrBJIMFBnynmvHpeRu8j3rUiYAa+Ts3G5MqYB5YIGv55qzpPPHjKQsPP15hLqQfT/yPrCljJs57YNznU200wxNTW0+HkSDLZ67OTjXzwNvMR3OnJw9aLjYc29Bo6K2Vdum7PhOqKPx7xUqrd79rTTSk+vtzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675404; c=relaxed/simple;
	bh=2o/u3g6llXAHOiZnhM8jtA9N0ZbJIwV1fvTZo5xILi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7c3FpEUgUYjyO+fw77Xdw668FLpgAGrmrw6PsSJ70vEpbnefOxippYjJxH05W2YGYk69Wdkj8qmeM7qKZKCiNMV5sMLOZcSbiEajkAU8SzNPXj+CzZdeZbakpDiwQTCNVzBBYPL2Rr9fHeLtvpmqzjuXw0m+IoTvdKqksoDkx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C/hjhkGK; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C/hjhkGK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYRiQAHq7FK6ckWen8gyp1ziW2CFmAqHDNcMCl95ROcjF+G4FFDEcbBj2Euo/tAru6EHTgb88QUmgSrtvkEkMepWFeHtMckQ4q/WEJgvz4kC22+rrxtt053cwhD3fFR1RlbE0ynm8ZQxtdB4072aY3F6J9+Oidaw53fEEFA6KJTV7a49rcFozlYnhS4qwZicNhT/8dU495Fs7qSgi71sJf8z1hPHn99QS418QEwUH+qhyewMal99VjMWtaqPiFJXVFoHaT54YX7Poqo+Ze5cdtjqwfMboxlwiv1kqOWtTgIviJfzdZ7iULBIWSvNsDwedlmnRfIYAkTPkThWIRubaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZWnJjhbqKI2pOx73NjuaWCIH+uBnco6nbXo29WrGj4=;
 b=Tfb110HWswJBeA74tYAWXdFMyFLoly0AFWQy5g0/nDvb/DzZ3twR/xotLGUWuGspWpB7UEuuE/vNfo6tjKViq+bBZjLWQqwtMGrUo5RBCUwBIvUZo63ZnElMDKu2THthQ5lElhO+t9FOKEERL5CIlyPceRdBcp/Ecx/moEQW3V3w2FRgZp9p2FHx2kfRfUVjfD/zswHyT3p4xafJHrjxXxo7ESxJJnsI1JYQFV0YaGs7+P99hDRPLfL+J6uBvUbPVgA1TwUshQXHSS9Ol3IFaiJyXSFZFoQz2Z0kpnRxKKRmT8AsLWl+TH+dIxYFD16RXfxr1s54Eru5gB5+uyzcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZWnJjhbqKI2pOx73NjuaWCIH+uBnco6nbXo29WrGj4=;
 b=C/hjhkGKBRT0urBFXKJQLGahzyNwuxOpjlIAJpSQVguXCvM9RAmfflMaDYo4DZbBKAf6f8G+rzTT1LrWeODcvu/QQEG5cNe6ClxWn9BXT4ZN8Ul/2gfoIAZTe1hZT3PwywfJ41PXVjAzLKyQxZ0sy2PUplDLv2M7W3nfBZVME5Wn8uyM8sbOtIOcu5Iw+KKpFb0NdJbXnYiH0oeBFL9Yq/bN6XOWtf0waZij1kwJKtCYdJZVhOVjLobR+6dcRMqotKxrNjWcH6bZrLngVYiZGHNKmhSaXGaNhwi1G7oxCzkxUGBh4m6Mbm+S7h9mtgzYHIponKGSJ2A1CsLpVR0nlA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:36 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:36 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 02/10] help: make autocorrect handling reusable
Date: Tue, 17 Mar 2026 00:36:15 +0900
Message-ID:
 <SY0P300MB0801AF3C254CD460EE2A1997CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-3-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 696b9aca-d242-4bca-b6a1-08de8371cf15
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5bZumaLUhPTBgjYJP2P32/j+d+D/uWBFVSoME/E0gL3Ly/XZEqg9coOGNJtW?=
 =?us-ascii?Q?Vc4t8h+S+nu6qPNkP7Ei7i5GcQcG1Y+wGpWY516rT1OJHVHHy/XNxVQRNJxr?=
 =?us-ascii?Q?k4Fatf0q+djqZ8ZX214OjBlTJhDzo9DGNBMriwIXVXKhcsngyDq7oSisZ4Dw?=
 =?us-ascii?Q?cLkut7SiqhTwXXS+YjgqDPsNix8mX5b56c4XJtkoBnfqE8w7w5pkpL9z/bgH?=
 =?us-ascii?Q?r62ZM5uLJ5WkOZ0/T5lAmILfcq2mcz3ILwOcC8MN54q/4b3nN5BDwM8nBp4u?=
 =?us-ascii?Q?y8CeW7hohoz7KdPTx4YvHx5VUYtUU+2+Fpq9fLDvKQUoNgDXlUHQtS6wNlR/?=
 =?us-ascii?Q?TXOPzymBKNR8qNMQIpDMs4xmL17r70xt8HUMK62hIDt/Oud/85jRe4V+1p+U?=
 =?us-ascii?Q?qTkR1u56Y1JMiapROQLrufUVvdO4hIVeMn5NzsZu3PIJkRH0USqyFWuWqqHx?=
 =?us-ascii?Q?IXoEGhMripkA237mM+vKkmxKCgd8rgR3LE+syH8Jg/KbivUFUAmtCvGCW6zG?=
 =?us-ascii?Q?48JtjHCIsHuEbcXdnp48ficXHmeHWKZwFHqVJ5KC52eDIwr8Qm6FfLonMp7L?=
 =?us-ascii?Q?lbaAUCsAgfKyGf60/KIYAEiOQF3tkBa+bh2TNtPWumrzn+z4Z+bNGPGZhM7f?=
 =?us-ascii?Q?PIRpwX8Daey3EXoj5p4bcf2mDD+hrYfpoXBXfjYJ3mnfQx/ijQjqVeul2eXW?=
 =?us-ascii?Q?8hSNmWnK3iRm36sjblo/hxNSq8lUOkZ7/mg60XA7J9+Qjb4QDL3l8U3xIkBT?=
 =?us-ascii?Q?BsjOCeMLcB1beRTgAX2VT9aIzKBJqvDZi54ij/Huen0ZgSogaBuVS7HFcPRV?=
 =?us-ascii?Q?3vf6uZw/tx2qN2fUFA8BIOgP52ksBgY2itcK0D39vxoN9NQ8aNU04DVcfenX?=
 =?us-ascii?Q?3OWn5fixDXvuhIYcvuVzkdOg0Uvzwio7BYWgsiy6NxnetAx3cCwLVW7C1bD/?=
 =?us-ascii?Q?iy5yopbNbpIwq/eWybomy5BCp47sTu2qqJ+d/pXA2dvnc7e5qgnkCbzKM0ua?=
 =?us-ascii?Q?zJUd?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JvKe2fFtajKj9eb+8baWw2lfaLg0pPXoNIyyTNwUGtsgVP08FaWdrE39HmuJ?=
 =?us-ascii?Q?LamX1eoW9ONN/RllSSWl8CVLejyNjVfv0GZB2sYnMlJthF+JhIQY63D1YRtr?=
 =?us-ascii?Q?WtUlw+B9I1AwCUdQwHp1LZ55TkE/gN2bd9EWT7a0/ef6h24XijO56XCL6XC+?=
 =?us-ascii?Q?V2fF0QWuGl6xCyzvxlBC3Lums+LHTZnfVxtbJRmRyR5wzvS7JuW5V7Ojy7tv?=
 =?us-ascii?Q?LzS/fZ+7Murb4Qgs4r/2/CU64gTIxzISlmPnzMSuR3kFHfdEU9GB0vCtgemQ?=
 =?us-ascii?Q?AXrmpnuPKFtIUTSDn2lLYA0W1d6+ODa0FfyBExhr45cWGf7145R74PLp8Wgu?=
 =?us-ascii?Q?Vp63hLdTOppydTx6ruH1ld9xmZryXcQtZn4/LfrBv0bbQb0mXCI3t1GbhBXE?=
 =?us-ascii?Q?1Nug4mC6S2X5HNf0FkFaHpqfmK3xEI+6km9uZq6+E6C6nA9wHreJmS2gETHv?=
 =?us-ascii?Q?ce7X/xT4oNaRRb8eDy383B77ruTL2RUpBJDjkg1Xym1bUT0K+/waTAYCUSP1?=
 =?us-ascii?Q?m2lV2GksXtUAuKbU1un7U/nGOFOU63ShpnaF6u7sBW/caPwWRYeysB13HCd3?=
 =?us-ascii?Q?qSjL9rfSX1fV9TN0O4PTah7Tf4OtAC1J/wtq6BdE5T7uBjNzNmy+2w8AuRnX?=
 =?us-ascii?Q?anw3LPQ9CRqxzJ/ERCrQZ7wbaJ/jo8FgSzOY5MhLn266Z+l79mJ1tbET4m1h?=
 =?us-ascii?Q?xrVZue0T3s/9/fqU0ZRHXNX+ZEtZmqX0wG5P5BfxlH96oMxB6Npl8QW/M7su?=
 =?us-ascii?Q?D9u57ONKEawN7hXpSctMFWnWntt1TCWavVd4SEXlPO3jtFtl/MnoFKuPqCIy?=
 =?us-ascii?Q?yTjm3ozt+sRFliNFnaq7fDzyNNhUyd2es4TwKeMz4doGIWutiaRtRS67s7ca?=
 =?us-ascii?Q?RmIEoUUqw1GU9dTqtaw/KrPl2btzgVpHqqrkGiijbI7W1irT3/Lb2REPziPD?=
 =?us-ascii?Q?o5g6O7DEQy9Z7RM23dy1oa42TzBQUJudZWWnIny5DH1XCzNRjMmdR9aIu3/w?=
 =?us-ascii?Q?jK+dv07+w1H1LujErz7KXSapAizKv1gwehEitUn7Fb2N4jbnD+uGQzOOK6Dv?=
 =?us-ascii?Q?Mfn1BPwTwZV7MbMU/ZECMhIZOwQnbIxE40/EuRdyL4f5/3hP+OjoWuVjF7Ch?=
 =?us-ascii?Q?MFRLoa0Hl99Yayt+3nwXYLtqSdYfGSqEwFNjqG58M7ePnxm0tAIB5fcpSrqG?=
 =?us-ascii?Q?59C+Ng/5UIdQx78UH2m18xDKKHQ90RTfuzZjRwjhaciKqU3CdAJ8RuevZq7V?=
 =?us-ascii?Q?eRRjNR5jzE5RBccAk+/qyQ1+kQomBkIf0TIzw7bigbpfLQl80EjcV7sD1WEs?=
 =?us-ascii?Q?RZdrN/vus3+a+60vE/Pn7zZrfjjVY17W8ugIiUsU1gEfLjbFJieLAr8s6R4G?=
 =?us-ascii?Q?EI+O+UK/7ip7z762fuYvm2fcb+1J?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696b9aca-d242-4bca-b6a1-08de8371cf15
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:36.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

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
index 95f576c5c81d..4acb6ca585ff 100644
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
index 4b536e012481..0429e80a5c96 100644
--- a/meson.build
+++ b/meson.build
@@ -283,6 +283,7 @@ libgit_sources = [
   'archive-zip.c',
   'archive.c',
   'attr.c',
+  'autocorrect.c',
   'base85.c',
   'bisect.c',
   'blame.c',
-- 
2.53.0

