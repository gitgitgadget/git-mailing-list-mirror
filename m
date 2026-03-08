Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9B33A9C4
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972280; cv=fail; b=GF5WKQ4CGuIr9YUMi2eS18l8Keww4DJ9gUG2QkfnpoyaOgRfcvCl8bw5oAK+6rLc7x91YEkqZRR07clsmetQ04IjKrt15lqscsuuae87Bq3TZeaT4ktYzrPFOUPnexpRjblbx0CRV7xq2Ei/kyPubc5EUQ6VgyREp6q7kcKvVjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972280; c=relaxed/simple;
	bh=FNur9w7T5Okgc6K0g/rXat1XSKWJvzw7c1Ch/YGjw7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiwcy7rBkUT2CA/ho773nIV46Zbj2p1jf1MHTm8idLbsHE3F72xpHcjlFsabE/Ann7nTF9tMi22+29j1DGL0yHCFZYOMqIFn5RYwlsdI4kQnXXmtviEoQ/fd+FKxy9BozGuUZVbM/Awoo9FNq1qF0FpR+prdJWjIbH9jYNIPoAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UphWXOAZ; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UphWXOAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksJT00SH/YtaZPXLQUAUwRn/qNL6WGuqAvSRku+rRdL+/eUjs1IQxr22XsP3gHn97xkyRsrVqMt38XCyG3WkI+HzVOabU92g0UAEamZS3YJqD82jp7A+TsYo4QNMkJ4ah4Isy7LYdNuvsEYlxTS9vZJS3rqdqix3m0D/rlmuT83ZEEDZ0rn5pg8phVxqZM4Jzb72X/iLy4P5kGtRknzTH07xZY7npxBYVCy5BCuoBgGxxMoVzGR5KbY83683tyCkJr7zMWDRSkTB3vUQRudQ6SR06Wq5aWsVAtnP20oNvYm8wVpVRx4c2TG5ANhalFFM1ArKCEHfI2ams0P+BSKP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcHMkuhzMPTuG/KWgB76Pjx5rPusIhN6jaPHcf6atqU=;
 b=QbwAhB6Dxshw296yGoVS+56r1wknW3vQzgDp66E2q5gzIUWPSw3ZC0gAAvQAEEBlv9OOGXImETCSIrya3zYLB3zvggKYCmcuTE/ZPdrUMjxo0T3+rdpfRnUXTzJC+vpicXH7AzAFeZH4gwLVxHTTIhANt0HPv1uafkYhWah7Dgc4AH4/cPgl+c3i7jgUTNT4jBdfVR8lNLDGbC7JejHoN5ykRFzqAv6LS2ILMx2c9fqamr2gAQx8ng6ilyyWIHhBvAf5CW++OTL+33dfNhoyx5KJUBcBsQsWi62//lvgSdwGEmZNaIrHr5fBDBb38rPDcx0/3qwrC/PrSDCEJUo2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcHMkuhzMPTuG/KWgB76Pjx5rPusIhN6jaPHcf6atqU=;
 b=UphWXOAZUw9QOpgQ7uhSAdwlgVBeKFj7u9iZCdj6ZeSKTBBXR0mSoMURjcUEF1aUXIxKsRZhd8O5Z1nIJsbZeVkpBBx8VDtpbGZBxwsPp+bFCebtwY/7cpZUtA0rixKBDwdN3B5p2qorL6KZpZJPL/2PMDDrTWbJ7BhpPJdoI1ZQ8LQw59FPpSjfBF0a6JJqhc2o9VjtMkCYulsEvWFBM/eOKXZXKEXk8AvypGRouyC1dP3zxDHuL8qe66rfzafxJl+HlZiGuIyhzguxrCvt5nVZNL9aJdr0itAmcq1YkhZe/XQd/b2pfimzx8MLYtwG80NxvpdVyABDZc/BuDxvRA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0080.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 12:17:53 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 12:17:53 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH 3/5] parseopt: autocorrect mistyped subcommands
Date: Sun,  8 Mar 2026 21:17:23 +0900
Message-ID:
 <SY0P300MB08010BFD00AA7C73503D8B92CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308121725.2333643-4-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: a0165bba-62bd-4ab7-46c5-08de7d0cb935
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|51005399006|12121999013|15080799012|23021999003|19110799012|8060799015|461199028|41001999006|5072599009|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5v9LXvcUpDgvMqN/zf3PpQRMfTU+ghS6wwNNMvuA+4Ebw9qGIXrBywil2adL?=
 =?us-ascii?Q?MmydYD13vu/XbvVFl33puP5B4li4tMrVuRx8FJlGd/Nfq8/BbMHqRYN4+nLU?=
 =?us-ascii?Q?nP/xsqwUYCD4bEdHSdXmaSEy3WScvk0RWNmGPTnqjQP7PC6fMNBWevLCPOSw?=
 =?us-ascii?Q?rz43cKRLXDwbopFym/mWsChYn1z/MpfnLXtHNE7rJLsK0w1rfFkaesfMGdNr?=
 =?us-ascii?Q?pOIJWcj8hjKMrz3/g12CM2HyUJbknb1/9sxWuCTPZ7HdB57xQ/UYh63Va4N4?=
 =?us-ascii?Q?Nz+BkKBS/+XfAKIrnmz3hNxkJdPZhHD8uVLt0QT+C2a53Y3O+dyGhu2VMg24?=
 =?us-ascii?Q?ZO+ejpgN9DKf0J3OxdiLwkjJfOkas6S+0A6eMcPB2J+nN6FhcmM/YK6WwmXU?=
 =?us-ascii?Q?unH+giEAMupmfLyzRI6xRp6Cz6AdISetMy/GrnRRskeCddTrWC8SqVMbk2GS?=
 =?us-ascii?Q?iXJnSc+TkPnCex5SgD4Q2bV0PSIWIVlz78CdZmDYocaSLbczFjzSkde4wj0E?=
 =?us-ascii?Q?AwHD3tDQAnHZsp1CfGGTJ8NrFyzj/Q64YU+Ms6U3xFByrVSjHjKUgkSxZYgu?=
 =?us-ascii?Q?MubvPYt2TTvsLFzsLGArhRENr+6igM4RzIPT8fx1+/LXdmB1RIf7Ohzo1hJj?=
 =?us-ascii?Q?IzRx1LCuZFhtkd6Hz5OBWP5XYyB7B/Utf5PkbeocuhjbBD0hSLN5vShhaqN0?=
 =?us-ascii?Q?OSDg6z4kU3y7UqN3h3zsmzvpTQibzxLE9bOYusXOJrvwlpW6Sz7w015Hsu3V?=
 =?us-ascii?Q?aHQpIHrpUBfly2VJS037fKVvsJq6hEeE65amTk06aNjMswB1jYcFgYPs1TPR?=
 =?us-ascii?Q?e1DyPKd1vznRbuA0Qhrzy+kP6w7f7TXiAJF5IEumbLmb7jVIbOqNwL3AULZ3?=
 =?us-ascii?Q?CoVqHE8XPJsEnel4SCHV5kAY7BXkcLMkiixSMgu6HTclNmet7ffbKUQWhhgz?=
 =?us-ascii?Q?2EaRlwwmAhI9HSwPdqq96qOxVivAq0YMtkK3m15UUM9x4PEJfVrqpBTnQ/7o?=
 =?us-ascii?Q?Vf9Q8aaJka4ypgISmmg79x8wwIXY7KzMLpZN4uwFS4cYS08=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1t0bJW/wnDPEorkJNP/q9aCYFdrrPvNC/0cFphK6VRgZw9iusIh7P4I7Jbsq?=
 =?us-ascii?Q?UFOcsgJNuEMmsPTkllyBGugQvll7DNhaPK9yX0v23JvMHAqDXuFNF5grAdRL?=
 =?us-ascii?Q?o6Lwi/KTxtrcIiXSY9tnG9s3eygTSHeiBsybM30O6gtax7Gs6Vzi61UVg7EG?=
 =?us-ascii?Q?U9zukWalMFGStENUnfoI4XFVR6NxsuEuoDPqpQwqFuPa0BKZEtfRLrwjLF9a?=
 =?us-ascii?Q?k+XQJgE0KMDNP+I21XZ6K68lC1cNjLRwPB8YlLf8EykZu4z+oeBBtv6n/nDV?=
 =?us-ascii?Q?04NQyWlbxK0sIOwbOJK4G+/40djUsTWvHMMaUEtaKGba8AwwJeyKnebDtO+M?=
 =?us-ascii?Q?yselQazitYjF8EJQ5CFvTSzThPtqDojwpZH1fEQKxhLD3JgfOLe36kmSlKfp?=
 =?us-ascii?Q?Bxdb/dY5OCMACk5tXJvz2BW8o37F7KgQ39In+z0EizymrpgMZZ443PdI56Rq?=
 =?us-ascii?Q?ozhPh+s+vIvxeJIS4dNpcdP5jj1snGUDccxWkuX0XSDaan246oaW00ogeoTp?=
 =?us-ascii?Q?JZjlobLc8y6O8EsWGeKMYXj/cJaUUhjsJbmRJgOaptY3j8z/njkgYhKnU58D?=
 =?us-ascii?Q?JVrmzpIziLYZNjaZVXni6tsyAe+l8LcTqls/PmErFGcSJvlCVd9+UR113jkb?=
 =?us-ascii?Q?E9D5DCHUAUHQ65KJNvlTeD3Hz2WFZzI/GBlpo/9ozXwxp+hvdjFmSQPDTZWo?=
 =?us-ascii?Q?XXWUXSUIrsTFYb9vVNawek7K80LWT8m249RpsTQzlF0sRyzlz9IONajiDK4q?=
 =?us-ascii?Q?4K0esyRgzNyuwS+dDmKGwDHOBYs/T1+IeglSwVrOkmyapOY7hUacPlgd8NHk?=
 =?us-ascii?Q?7v0gmriztjYwPVfWRgN3Uy85iVDkF0y5ENvOXYCeaXNWoRrCXU3ZC5myboyx?=
 =?us-ascii?Q?ZZPlK7UrDT23U4xHLkHz8qp8m1FL9/sBa38KAWVnFLhsC3EAwHV9v+g7+FBW?=
 =?us-ascii?Q?Lhf6bzaT5ISVGqF2Mr9TTcUa2Qf4OLz9XmxkD8E4xzigPKLv6oekpGQYH4eA?=
 =?us-ascii?Q?CiA/aAvHpF+ugieBUDLkGH0vEommH821RXyNVJD31ZXCtA8xC4r8mJKoy0br?=
 =?us-ascii?Q?4f027VSHzUti0Dfx2k3r5ZzAJzxngVamq617ckKGFoqLSVTrrsXkKjoLQmQl?=
 =?us-ascii?Q?Oy5ME0c+6mQaW2pg3C38AWaoJrOHiJGWYoPIiF/qrgQCVaO461Wc+Out3TWA?=
 =?us-ascii?Q?7NFW2Ez5PTrL7hOQJdQ6iXsY31OPar9qk+UtIf8dtMlVeic9wfBF8fXbVyf6?=
 =?us-ascii?Q?+pS44zYytcRcQaZll81+W0G87SImo9PEIymSMtJKdSlOgX5yC0rjO9Tn69y1?=
 =?us-ascii?Q?J4BL4bwK7PVrF/IAPJKiNEPuRqj0euAvWau42qwYcEr8A2v+QvzmezdEev4g?=
 =?us-ascii?Q?mgiVSPZy6N3yWWbt9pjx3dcSyoq7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0165bba-62bd-4ab7-46c5-08de7d0cb935
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:17:53.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0080

Enable autocorrection for mandatory subcommands parsed through
parse-options.

AUTOCORR_HINTONLY is equivalent to AUTOCORR_NEVER here, because builtins
have a limited number of subcommands. They won't become too large.
Displaying all subcommands via usage_with_options() is already good
enough. This keeps the autocorrection handling simple, too.

Also, use a dynamic threshold for similar_enough(), which can yield more
accurate typo correction results. Although subcommands are often short,
they can still vary across builtins. And a fixed threshold won't do
better on both short and long subcommands at the same time.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 parse-options.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6bb0c5697099..cbbb04b9997a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,6 +6,8 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "autocorrect.h"
+#include "levenshtein.h"
 
 static int disallow_abbreviated_options;
 
@@ -621,6 +623,64 @@ static int parse_subcommand(const char *arg, const struct option *options)
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
+static int similar_enough(const char *cmd, unsigned int dist)
+{
+	size_t len = strlen(cmd);
+	unsigned int threshold = len < 3 ? 1 : len < 6 ? 3 : 6;
+
+	return dist < threshold;
+}
+
+static const char *autocorrect_subcmd(const char *cmd,
+				      struct string_list *cmds)
+{
+	struct autocorr autocorr = { 0 };
+
+	autocorr_resolve(&autocorr);
+
+	if (autocorr.mode == AUTOCORR_NEVER ||
+	    autocorr.mode == AUTOCORR_HINTONLY)
+		return NULL;
+
+	unsigned int min = -1;
+	unsigned int ties = 0;
+	struct string_list_item *cand;
+	struct string_list_item *best = NULL;
+
+	for_each_string_list_item(cand, cmds) {
+		unsigned int dist = levenshtein(cmd, cand->string, 0, 2, 1, 3);
+
+		if (dist < min) {
+			min = dist;
+			best = cand;
+			ties = 0;
+
+		} else if (dist == min) {
+			ties++;
+		}
+	}
+
+	if (ties == 0 && similar_enough(cmd, min)) {
+		fprintf_ln(stderr,
+			   _("WARNING: You called a subcommand named '%s', which does not exist."),
+			   cmd);
+
+		autocorr_prompt_or_delay(&autocorr, best->string);
+		return best->string;
+	}
+
+	return NULL;
+}
+
 static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 					       const char *arg,
 					       const struct option *options,
@@ -640,8 +700,20 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
 		return PARSE_OPT_DONE;
 
-	error(_("unknown subcommand: `%s'"), arg);
-	usage_with_options(usagestr, options);
+	struct string_list cmds = STRING_LIST_INIT_NODUP;
+
+	find_subcommands(&cmds, options);
+
+	const char *cmd = autocorrect_subcmd(arg, &cmds);
+
+	if (!cmd) {
+		error(_("unknown subcommand: `%s'"), arg);
+		usage_with_options(usagestr, options);
+	}
+
+	string_list_clear(&cmds, 0);
+	parse_subcommand(cmd, options);
+	return PARSE_OPT_SUBCOMMAND;
 }
 
 static void check_typos(const char *arg, const struct option *options)
-- 
2.53.0

