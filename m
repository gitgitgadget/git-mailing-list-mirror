Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6213B3C1C
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908344; cv=fail; b=IldDKIB7/Mku1QV4A9bzsQKGnTVSy1uldj53qHTukxDmqG8M5n7cw64e7l5b1n4/JLKzwHeq/Go3nj/vNriAH7NakFh4rgHabnGP60deT544/rZh6WWocl2PPuuzBo+nQ1idf1h037qvyZwlj0VwmZOUa7pUhOJ4OLY47tMf5YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908344; c=relaxed/simple;
	bh=LyiYe4D34NTxk8wE9Ayrw85ekjdMxI86zmbr9B0bgGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkrXXtWXidBojHTshMirhDiFJpwVhBY1xeMXAntTvaXwgZc0ONFhjnY+DixjFdgZk35C1A3OMhx26olJS9ws5FUSQHdC9JHL2hpTZAZL/Wjh9SHMjAXxJMPXxF33AX39aUM6rgmqQGC9vJNGJr2EVoydktyFYPJnpft0M6xHJ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YIAZ7FOJ; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YIAZ7FOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7q99BFiZJ17AjDXRg/BlwV/3SRaoEBFYzvd58wS7+KN9QzoBKo2fWm2gRQxZW4bQWFADBDbmVbdGHO6gvFXI4xBO4rktLKLFRXaK0/5e5yEOh6yT1WltVAiWlo6eAkJULb1548E/0UB3wJHp5GJ0kMrqfD0NbiiQK+zwMmS6PnibklA1zROLklinyUErTuwSuCh+UbCn+n2RhY3ioYkpEN8okT+L5auPcwDCk4YUmz9eNy0WmxMYkDS/u80i+jRrvD0Zn4yB4ovAR4XcNiHKTY2ztyPJ0ltP090E/tCdtPT7i2rh018Nfbv1Qi4IIcA1u3jMqNTNxditbM5lcx3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BANj67SkY5kZrb2mENWDQ9FSvdeIMMq+ex1cATOIXF8=;
 b=QshBLerpFN0juQqECUaOYLCe+RHEkFfhOOBWQHWJfxMQgxkNS3Y4YSz8Q7oPtefxvfHZAhdtDcIgKyFQjyPE/sTg2jUoyIdFxUpULd+vrv31xd6v5H0iRlvSFJAO5DqKKd8gqkQdTW7xHLW+iB8hDAFpN8sE0YJ3X17dGJezgL4sKY+dTLqKaaYtEU0Vs3zerYkqnP5pddbChrvY8h/8Hlb8wV3enpInXsBzyJ3ooZYEPLGowW9f+AMd7FaVGu32NThsKRXAz8BZj/J/zqUImg6ig4P4AWCVAzZNVs0b4EF2FuHXIWqPDC2qPc/5GZJZ0m/ijzuk3N7vuQ+XlV20Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BANj67SkY5kZrb2mENWDQ9FSvdeIMMq+ex1cATOIXF8=;
 b=YIAZ7FOJv0BC6U3S82NBLfLdI0PX2oceSMgMDVfxAU/Gg1JLu9v/8rg4ulqUZVLWXC7KR+vysFON0uqNA+h8T3FIhkOpoDcIG2xGtZCtL46VKLXXoZW6UWDkz9EEH4P+zHfhmLCkAUxOYAZALXNAEYI4Os6/nWVB/t3qZXvXNDyQYApqKAr+MI5PKUTTFUVS4xXkce9EouJdiV36QWdHc141Ty9crZrAW/ED6IPTFvTpZk8jKtpMF27HR2kFNieqQn/6G1kyFYOTVO0N87N54IITDkrQtumaVuf4vpjbaoGBKKKIxg/UZz0MaXwAJv8Jqduikeu7KL8mifLjv9y3lA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:30 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:30 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 07/10] parseopt: autocorrect mistyped subcommands
Date: Thu, 23 Apr 2026 10:37:57 +0900
Message-ID:
 <SY0P300MB0801EB4A5AB42DAC9607F819CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-8-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 2cfa9961-4f0c-430c-4418-08dea0d9047f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|41001999006|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|12121999013|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UFH3h2nxnzG8S7WVP6rw6nezOVPj7uEQfXfCdiujIClTH6ef8V67G/06Aiwe?=
 =?us-ascii?Q?zC6JSWICdOimfLkjFLaj10BXk05kn2NoyrPrEXkxmpPC+Vk/NUuxFkerbaiD?=
 =?us-ascii?Q?ka1ju/9TgZUY3jjwwkIfRwMD5UKGFdn1pQowkxrKVjhER/dlAr+6T4M2XKk6?=
 =?us-ascii?Q?LaNmypxfNMuWsvqnGblmN0zOsfvR4tziNpU2t4jqHOGHh5taQEUJRNeZGDms?=
 =?us-ascii?Q?IgLoi45l3xGvOPN4cUXNejm/VfzXGYwlPZkaD7XJK3+qt2ucMq9JgcH+2iA6?=
 =?us-ascii?Q?SaC7WfnJOXcOVBGa9YdsMnjFwEn4miYNiXo9LutvpyXz6bx5wAIxHEuxA5Ss?=
 =?us-ascii?Q?rkhgGlsOTqNYTbgDZ4afY4zx7ooY3jpRaDM6eY+VlEoQl6dBtf3PptG/Yw5T?=
 =?us-ascii?Q?5dIwSJ724985pI2/Y3JlNQwc5s50uoq1WJxRzqQYbNYBcokZ5ixKoUqCmmQs?=
 =?us-ascii?Q?PZY41APyh1PabrqKtmNsqNtzh0j0Y2Ukgp9F+uM1XX+0coaOVnZixL7iuuPA?=
 =?us-ascii?Q?vAuHZNlGhp/+qwKSvOwW8DF81kvrB6v2Os1NBNj/RsyWYovjwzhGW3uhjnW8?=
 =?us-ascii?Q?tfAxiDN7a0DbNz0VBvNmH44WwEeovNelUHXBmPO7zkQmLYoqYKDMC+YmgSmH?=
 =?us-ascii?Q?qcYiJ8/AMYKQI6b1DGECGNvEdi/l3QTxWCQ3Athw0wqneL9cGmgISx5WZWRn?=
 =?us-ascii?Q?Q4usLfYQjy+9aX6y3tPZnZ0H4mNphEumopUMn3AKQZMox9kUFXCs4fNJeAq2?=
 =?us-ascii?Q?TmzWZ6OQIEY8Q7Q1gKpWMGijFxa48cU3J8W+04Lz6FYD7n+x2gl3c3pZgIuI?=
 =?us-ascii?Q?2OnB7iCY1TtFJeTjfTG24kZdcAA/UcG0Dx2xTKkgxVjL62inYd5BZ6oEN2Fu?=
 =?us-ascii?Q?Ap6iXsGukpSf2OhZoOe07z0QPm5mjkjiNR0PAdmiueLcyGZC6Dq194Ak+S9n?=
 =?us-ascii?Q?In7C/KrWpu0qhgTL786FO88467Yw3N85FPILolnn4EHfIjMWXKBsIEW8Lg/8?=
 =?us-ascii?Q?jKe3C1c7denF6U8g71QA7rmwA3jVlPjpA6FdsqNAMfnLDjBTfbTXfHBpJX1t?=
 =?us-ascii?Q?CVgL2ftws115LgfbE24NE77tYSD5cA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XXXlzrygvBOn4UQyH7SfwWYNzRJLBVnMBVF3ejLRqQywqJg40K7wQszd6FMC?=
 =?us-ascii?Q?Jlv/1Ea041dLmLFjutT6UvV74YvRo3z8h26HVhIlnTPRRsKa7/1cjsunlZRU?=
 =?us-ascii?Q?+kSiM4EdHMQnEaclMG2ogBeiIkN3YD6b33+SSdRa16Sm7R8NqrBk5EJnY+/Y?=
 =?us-ascii?Q?yXVVI0F7D/udhXUZOzVGfn2qHud4BTotptgyxMxfGp9qUub68GVOWZxaoEoy?=
 =?us-ascii?Q?ouu+TsJFU8sujh9qEoO33pyX8YHlRSm90qaA8KSCZdSVoj7Wbrndozj2SzfU?=
 =?us-ascii?Q?pA5wlb0CdZRS3htvXNgaz1UVrUI1m20QVc7KkCTYnqV+sSipKfXDRjOrMFCN?=
 =?us-ascii?Q?WwfqaK1mKBR/7Bp9eLIuzv7JWkadsEfpYV65GNpE435KMK6al/j3/eaXFY6B?=
 =?us-ascii?Q?lL7GssDhzFHi8aBaiOAeZQBxQR1OitIP+hWjoZyuoX9RdkcRfx4T6ptBTgtF?=
 =?us-ascii?Q?OnxP2Tq8r5JdGf9M77Qj0/+lsVpPqpVPQB/BYdwkCk8gUvZo6112NlpKXhXA?=
 =?us-ascii?Q?/MCsWx5ZSQiYlhrhZLwnYVhyx+oFkvLWUc8YIJsaJDHJLKuBslQXO2K8P9yG?=
 =?us-ascii?Q?iqxIdbImB0o4H+fEkGJ05/ZqHO4GVv7wfhDPSPA5qCsVcJjtcO3ccA2xJyQW?=
 =?us-ascii?Q?TtWwDD7BAtsGn68pkmR6xGydA/QWZ2SmjibBMB+k5q/pWvC/ipaSxll3XYEh?=
 =?us-ascii?Q?WlEtkTwD0ouqmFQME4l2+RhB9V0clzps8xuEV6CBigoZYq30OOIWvLSphjSd?=
 =?us-ascii?Q?PRVc0sejek2FYrgDmM/maOZyBET2uUQG7ExW5Nrf2qSXMyqgbFiEa+ZFjbGU?=
 =?us-ascii?Q?/mhQzOOG8Wwoe00jm7bzHUtCNeU0z9nqClWgWuc3ZLMhPaqj18ZNP1FgDmXN?=
 =?us-ascii?Q?vLq5KSkOR/C7A1243uAptyBEVJZUMsY+zyTi9EQ8vbld8nt+TL/HL71gVU4C?=
 =?us-ascii?Q?hxvwJXZAcoFezkqvKg8WMf5hQHubFvkeHYmsYFz61Add2BFBDa8CriBd7oVg?=
 =?us-ascii?Q?SRymWxB6mYCSPOrDaE5PA7ZJ+cJS8qK7tosDN2M5DxkCJhiNEahVaDBioTOx?=
 =?us-ascii?Q?QWRqph41EKuwZpzlqzlAf33wtbWeAAu8r1iTwFIp/Hg/Nrsd5O3FmXcbnMt8?=
 =?us-ascii?Q?u9ubGMcxuIDOB3YbrE9ftvLWZWy5rpo2w/efbbb/5Xa3caxIL/91edO2TP9x?=
 =?us-ascii?Q?1Sr7uIY/IQakdnxizxvn+xxN0NGZTu7JcPfxzokTP/Uig5MdW5tCGYdx8XjG?=
 =?us-ascii?Q?lJNQuzQcD8c1bzmb1NpT8623n7dTRY78lvLNRB3wlAhHYdGY9o7BcbGeR+/G?=
 =?us-ascii?Q?RG2FpgH7SnlCEDdgchI2aecgKBbnlUWLj2aZeT1mOj2SR1bT1fceyU1dn9Zg?=
 =?us-ascii?Q?iaB1Mn2MAU8GLf/wxOkN81JF+MGv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfa9961-4f0c-430c-4418-08dea0d9047f
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:28.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

Try to autocorrect the mistyped mandatory subcommand before showing an
error and exiting. Subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL
are skipped.

The subcommand autocorrection behaves the same as the command
autocorrection.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.h            |   4 ++
 help.c                   |  13 ++---
 parse-options.c          | 102 +++++++++++++++++++++++++++++++++++++--
 t/t0040-parse-options.sh |   5 +-
 t/t7900-maintenance.sh   |   4 +-
 5 files changed, 112 insertions(+), 16 deletions(-)

diff --git a/autocorrect.h b/autocorrect.h
index 0d3e819262ed..14ee7c4548d3 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,6 +1,10 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H
 
+/* An empirically derived magic number */
+#define AUTOCORRECT_SIMILARITY_FLOOR 7
+#define AUTOCORRECT_SIMILAR_ENOUGH(x) ((x) < AUTOCORRECT_SIMILARITY_FLOOR)
+
 enum autocorrect_mode {
 	AUTOCORRECT_HINT,
 	AUTOCORRECT_NEVER,
diff --git a/help.c b/help.c
index 0fff43545cc1..ecc5673b7243 100644
--- a/help.c
+++ b/help.c
@@ -580,10 +580,6 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->cnt = 0;
 }
 
-/* An empirically derived magic number */
-#define SIMILARITY_FLOOR 7
-#define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
-
 static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
@@ -659,7 +655,7 @@ char *help_unknown_cmd(const char *cmd)
 
 	if (main_cmds.cnt <= n) {
 		/* prefix matches with everything? that is too ambiguous */
-		best_similarity = SIMILARITY_FLOOR + 1;
+		best_similarity = AUTOCORRECT_SIMILARITY_FLOOR + 1;
 	} else {
 		/* count all the most similar ones */
 		for (best_similarity = main_cmds.names[n++]->len;
@@ -670,7 +666,7 @@ char *help_unknown_cmd(const char *cmd)
 	}
 
 	if (autocorrect.mode != AUTOCORRECT_HINT && n == 1 &&
-	    SIMILAR_ENOUGH(best_similarity)) {
+	    AUTOCORRECT_SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
@@ -687,11 +683,10 @@ char *help_unknown_cmd(const char *cmd)
 
 	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 
-	if (SIMILAR_ENOUGH(best_similarity)) {
+	if (AUTOCORRECT_SIMILAR_ENOUGH(best_similarity)) {
 		fprintf_ln(stderr,
 			   Q_("\nThe most similar command is",
-			      "\nThe most similar commands are",
-			   n));
+			      "\nThe most similar commands are", n));
 
 		for (i = 0; i < n; i++)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
diff --git a/parse-options.c b/parse-options.c
index 803ce2ba4443..4370d9c623e4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -7,6 +7,8 @@
 #include "string-list.h"
 #include "strmap.h"
 #include "utf8.h"
+#include "autocorrect.h"
+#include "levenshtein.h"
 
 static int disallow_abbreviated_options;
 
@@ -623,13 +625,98 @@ static int parse_subcommand(const char *arg, const struct option *options)
 	return -1;
 }
 
+static void find_subcommands(struct string_list *list,
+			     const struct option *options)
+{
+	for (; options->type != OPTION_END; options++) {
+		if (options->type == OPTION_SUBCOMMAND)
+			string_list_append(list, options->long_name);
+	}
+}
+
+static int levenshtein_compare(const void *p1, const void *p2)
+{
+	const struct string_list_item *i1 = p1, *i2 = p2;
+	const char *s1 = i1->string, *s2 = i2->string;
+	int l1 = (intptr_t)i1->util;
+	int l2 = (intptr_t)i2->util;
+
+	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
+}
+
+static const char *autocorrect_subcommand(const char *cmd,
+					  struct string_list *cmds)
+{
+	struct autocorrect autocorrect = { 0 };
+	unsigned int n = 0, best = 0;
+	struct string_list_item *cand;
+
+	autocorrect_resolve(&autocorrect);
+
+	if (autocorrect.mode == AUTOCORRECT_NEVER)
+		return NULL;
+
+	for_each_string_list_item(cand, cmds) {
+		if (starts_with(cand->string, cmd)) {
+			cand->util = 0;
+		} else {
+			int edit = levenshtein(cmd, cand->string,
+					       0, 2, 1, 3) + 1;
+
+			cand->util = (void *)(intptr_t)edit;
+		}
+	}
+
+	QSORT(cmds->items, cmds->nr, levenshtein_compare);
+
+	/* Match help.c:help_unknown_cmd */
+	for (; n < cmds->nr && !cmds->items[n].util; n++);
+
+	if (n == cmds->nr)
+		/* prefix matches with every subcommands */
+		best = AUTOCORRECT_SIMILARITY_FLOOR + 1;
+	else
+		for (best = (intptr_t)cmds->items[n++].util;
+		     (n < cmds->nr && best == (intptr_t)cmds->items[n].util);
+		     n++);
+
+	if (autocorrect.mode != AUTOCORRECT_HINT &&  n == 1 &&
+	    AUTOCORRECT_SIMILAR_ENOUGH(best)) {
+		fprintf_ln(stderr,
+			   _("WARNING: You called a subcommand named '%s', which does not exist."),
+			   cmd);
+
+		autocorrect_confirm(&autocorrect, cmds->items[0].string);
+		return cmds->items[0].string;
+	}
+
+	if (AUTOCORRECT_SIMILAR_ENOUGH(best)) {
+		error(_("'%s' is not a subcommand."), cmd);
+
+		fprintf_ln(stderr,
+			   Q_("\nThe most similar subcommand is",
+			      "\nThe most similar subcommands are",
+			   n));
+
+		for (unsigned int i = 0; i < n; i++)
+			fprintf(stderr, "\t%s\n", cmds->items[i].string);
+
+		exit(129);
+	}
+
+	return NULL;
+}
+
 static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 					       const char *arg,
 					       const struct option *options,
 					       const char * const usagestr[])
 {
-	int err = parse_subcommand(arg, options);
+	int err;
+	const char *assumed;
+	struct string_list cmds = STRING_LIST_INIT_NODUP;
 
+	err = parse_subcommand(arg, options);
 	if (!err)
 		return PARSE_OPT_SUBCOMMAND;
 
@@ -642,8 +729,17 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
 		return PARSE_OPT_DONE;
 
-	error(_("unknown subcommand: `%s'"), arg);
-	usage_with_options(usagestr, options);
+	find_subcommands(&cmds, options);
+	assumed = autocorrect_subcommand(arg, &cmds);
+
+	if (!assumed) {
+		error(_("unknown subcommand: `%s'"), arg);
+		usage_with_options(usagestr, options);
+	}
+
+	string_list_clear(&cmds, 0);
+	parse_subcommand(assumed, options);
+	return PARSE_OPT_SUBCOMMAND;
 }
 
 static void check_typos(const char *arg, const struct option *options)
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ca55ea8228c3..2a2fef1e17dc 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -632,8 +632,9 @@ test_expect_success 'subcommand - unknown subcommand shows error and usage' '
 
 test_expect_success 'subcommand - subcommands cannot be abbreviated' '
 	test_expect_code 129 test-tool parse-subcommand cmd subcmd-o 2>err &&
-	grep "^error: unknown subcommand: \`subcmd-o$SQ$" err &&
-	grep ^usage: err
+	grep "^The most similar subcommands are$" err &&
+	grep "subcmd-one$" err &&
+	grep "subcmd-two$" err
 '
 
 test_expect_success 'subcommand - no negated subcommands' '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc182..7174b9932829 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -37,8 +37,8 @@ test_systemd_analyze_verify () {
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h >actual &&
 	test_grep "usage: git maintenance <subcommand>" actual &&
-	test_expect_code 129 git maintenance barf 2>err &&
-	test_grep "unknown subcommand: \`barf'\''" err &&
+	test_expect_code 129 git maintenance abarf 2>err &&
+	test_grep "unknown subcommand: \`abarf'\''" err &&
 	test_grep "usage: git maintenance" err &&
 	test_expect_code 129 git maintenance 2>err &&
 	test_grep "error: need a subcommand" err &&
-- 
2.54.0

