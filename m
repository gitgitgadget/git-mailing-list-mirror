Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8924A044
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972276; cv=fail; b=GACOIQaKdilhl/h00f8TTxVxcS5Dt9GjiqkdZw5NWQ+q6p+2RA4wX78VnymeBKZUh8lDCCdsQljlrdeTOAdmGc9rnWp5kW8oG7cHFwSGjkjbqysAOqB1LCEKFh5WGS045v5NbiIkDCpm5GIFGfss14vWZaPsS7ufI3gYsMgjkPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972276; c=relaxed/simple;
	bh=KRUgNq3jXHYqMaLPULWiwE9aUb94LM+rid16mg394ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ad6zmpf/kvYDI3Xep85xVZm+75hVop1FmBmdQDZyiWnRc/JnYRbqTRLJdgTqsB1DL/oplFc2IPP+44anHD5oF5u2Gp8oWNglUTs1f8BZ3vSmma5XCoex5lW/SGAIjsf9SOjN47MlsUo8UNLGS/UQBwlaVNo1hLiyHy0s6hLCvTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lLd7ND/3; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lLd7ND/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clZ75lNPUS1IiIhotXU0S1Pxb/ugDum2KtmkT3gZQGRXIzNjSFXh6i/GblSlKy5FqnDYXu4AGjGkBDQZ1Ka5ataLfsVIc6aUKAFGUt9eRfnUf89HcUcqyc22G6BYx1Xo0q/kU7FnvIg+y2IZ3JWVJ8Ki6AVAV0px3Ku6lS7vznBHNEAqTxuiwXpc/BV25gIw90p8IoWDVYiGzPvGno3dHg8Pe1Rl7/AepVVlxavrGlb9SvTl4SQLs44vWyHAXfPAU3JypdBcGBxY448mhYXC/sEFub6U92WeWmXJpXSBsHb0LFnWb+vVmXPnKQUceijfjjBOlpB55+VWu0qDYS7RDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbyflegdQj6BmgtKV4GiR3a7X0MyYY+vShCAEuwbLRA=;
 b=YI3vNzgkPBDPKC8uI3j0Q1DWfblquK8bUHr22cy/pjcFmhDB2Bq3mVlpmTzWBrXursWxFrGOY87qvkYgByrtNDigt+ASg0M/bqQRC1FY7IOTzNAIPXb7E4M22PHNfTW5539FFAtXhQJV1ZkF0C3FPYXWDHzm3IwpWJwLQAyxagtECxX/QaQ13MT8LU1asv3Q7O2CUiwvwhl7tnpZEh4Ou7B8fwSz1J/rILrLShBjyofd3NFWMYf4+hlYY+WNbd5ikptKwX/EwhCvFor+EGWN7Q8jzfR1P3st4gBbEx9nQmJtsWE2fyEGDKU/nEfZJmOxWdSuMveqxrKmcSEkJCTuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbyflegdQj6BmgtKV4GiR3a7X0MyYY+vShCAEuwbLRA=;
 b=lLd7ND/3fj0aZ4Xd19JNrVN+c4pigtsUdaMAmvclpzzsGrn+ie/GIQf3hqq8qZGMLzC24JN6KbDaAMsW01YGwdZ01B50KOz4jrK/gBg3f9ing7h5igXL/li/T3tQ3C73UF3P84MtT8M75ff+lJD0VCQW/wX3nHwMYrt26mdIQRivuVz6pjYqStJXaneVHtoX74X5UHvEfwskDnb0G/SkLVA3P+iEyCy2DgR0q9wJibrd9Q6OB5rAgYLyFMLmWhAOVtmiPbVAawV4EKKVPNtYVCgDKQMdQUYzIJp2SVK2oZ3d7nuso5lRpSpC3ka3P24UH+meTcF9yOBkNotKSBfvuw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0080.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 12:17:49 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 12:17:49 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH 1/5] parseopt: extract subcommand handling from parse_options_step()
Date: Sun,  8 Mar 2026 21:17:21 +0900
Message-ID:
 <SY0P300MB0801422323C4C4185B9617A1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308121725.2333643-2-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 3dc78c96-1887-4741-4f7c-08de7d0cb6de
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|51005399006|12121999013|15080799012|23021999003|19110799012|8060799015|461199028|41001999006|5072599009|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AsjeiXmM0xpWFzmEapVXQoYkyz7OKiD+9D/SQDfL0ZZDL1ul3sjcoS3l5z77?=
 =?us-ascii?Q?aHmWCjG8Qrq/Zo8otdI8ZBUgy/pOEiq7mNv/So2AvSQn/JYmumr3agfwztI6?=
 =?us-ascii?Q?zDzuoqSxuBa6BZraLUaKtxKV+IHvNgmaD7DNcP8ozK+NdBZ+/dUVeyNbKxNi?=
 =?us-ascii?Q?uXDH6MZVHhMapn8eafFY9e33Tdigrqcu1yVLpSSgTf9w4plAjLzDyJpgTGa4?=
 =?us-ascii?Q?If0BeCMx6WoM5F/r1kQ8b0BYSVBn914/DKcoI8XsY45hVTVA6uqJYZD7I14i?=
 =?us-ascii?Q?0UW2U+eYvXQGRvyWmhGIUrcLZTIH7NXarBrAfMnUYkvAyHiymHqg7aR3cXay?=
 =?us-ascii?Q?8AHycdFtk624vScOtaE2jj0OklcDeVhYexYALrYTLJ9bC3MHfV0EuS/oSOVx?=
 =?us-ascii?Q?ACdur9QmkfE/rEyrGVa5pbI+gBM+PxoiYmLrs1tzdIE1uBkkuN9lzb1bP+Hv?=
 =?us-ascii?Q?vbFnZy4JqSzOgfSciPaaoweUTsDo96rbgkv7UFe9yzZyp6z/QX4BFHMKfObf?=
 =?us-ascii?Q?NW2xA8GSQYcB/DXyrM9MzDpC/bTJZnb0gLDuY0OPpnNB00FscrDiVP5jdc/6?=
 =?us-ascii?Q?w2YEkFRO3m7uRZqVgbkB1ReeEIXJ3PTABY407nNLHxMKcC8n7vK3BjP2ghRf?=
 =?us-ascii?Q?lO1/lor+52eDq6BMjzKNKyTkg7IZWWhOrGlVh3CGilE7Mq1H6xrqAXSca78v?=
 =?us-ascii?Q?NOv9QyIdV071b1apxx5gfNK7goHWVHtHFJnTFHQEm+7WG990ecB9xx2AIfIE?=
 =?us-ascii?Q?HluDQeYvIXGVuNxFZY4wIHan8ZZNAmeRkFVbKS+juHKHF77tnu2Jug1tgjAd?=
 =?us-ascii?Q?6IkSgGrJxX7CjJ/mj2S8KqCCiC3sXCgAg0Xo0jAS+gxTKXmcvUJBHGJNwGeZ?=
 =?us-ascii?Q?JElPLaIsa2iBF+g2c/T0Uu3Y3WAVZn4kHe+OS0KHckqfnGNNHKHtC+Uc4Cje?=
 =?us-ascii?Q?EV9UDzrjK0LQW2sVC05Ezz3oI1EnwYYu13DYDTn0m2hy63IYExztC29zvNwv?=
 =?us-ascii?Q?jzl+m1qqazwEbEhJoMWvB0nnfw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dvaV4pOK9CKT0LW7GSQiCAPTSCti+/ImN/oj270ZffswdZ7RTbUsforvw9Rs?=
 =?us-ascii?Q?bT3QoGdMcvRz9OFilaF2UXKwoG50W66GMQhbOjahBq2oVdg+2ERpp1U3HLPj?=
 =?us-ascii?Q?CgCtMmqEa4Cbw7m1sflDt79BCgsBo0t/ShS+vakXmDKIWQ1vLIAg7WVXzYQr?=
 =?us-ascii?Q?1N2GeHhNGSC0Vv1oeZdhUZvEpn8SOo2IThBDR3Ucdq/4HvxIzihQtPG1Lhtp?=
 =?us-ascii?Q?6yXt3bTfPfG97rU8GYum7rE3SClNMfcJvsPnAkikmSMWFIWdfTcb6L5oVHF9?=
 =?us-ascii?Q?Ezd/UgroQW/iYXQnkSvMhs7cIlxQpb1XJ/zTGCBWtkAb0jRivCe6ttFGUnTE?=
 =?us-ascii?Q?Fh98xoMGUUYrkdvi8Q2HVBNcIchz+cUkkQbLH2IbQBk8NDILIJ0TfzJDBwoG?=
 =?us-ascii?Q?AlsprvwM21Zx90DyIAuyaaizwX/b4nXOzdJ8HrVOIVd4/CkQpsrO/lXksxaB?=
 =?us-ascii?Q?K8eRhJExcpLtkNh2SjRY/LSrjFEpi0QqmIOPaiqXo2vqW4ORdpov082EFLxN?=
 =?us-ascii?Q?PuQ89z4ZP4ss93/olmM9tVaHewuv9VzAg3utARqfLcUY+HVsHGNMD91aB/rp?=
 =?us-ascii?Q?+CfptxwLeBahSCDcoF/f643zx5AuxVsHBgimYQ1F9L8kt0oISxvov595lD/k?=
 =?us-ascii?Q?U3lLtP+CSkgQeGB8ZY5Gin2Y+cb22Vxoh612WCY/GqlPNzQ4rwppQvn+iejj?=
 =?us-ascii?Q?mx1CCALe/DaS9o+EZ4UPEwQ/kIUSxqHeUI9WiLgg5DlKqZOCz3z7SpEnM7Ym?=
 =?us-ascii?Q?KbOkML12HB0h8H9Qv/yUs5qvyCcb0b8BUpQ/zOgRBKiYAjiOM3OnmWO5qAFT?=
 =?us-ascii?Q?/UUCX2o/US1AwB2xBZ2GhIb6zqiED9WIOHRetbcM6cgCrnI7y1wu7PwKgcAc?=
 =?us-ascii?Q?cih8dAemi08zw4hQwIYPFPdbGlYDXVlXMzHmg3xryeC8n1MujIIpo09VA5nP?=
 =?us-ascii?Q?aRpX64UwV3fUJM8zWuP0j9fN7yHcJ4E9STOSgbfhrkBa3BM//boz6bxQcUE1?=
 =?us-ascii?Q?VYZOK39ecLitRG2vrBN22jWCiflysDhlAejhYDdDKaMY8IFlDG//8IfNcJqo?=
 =?us-ascii?Q?tfjtIj1f+mUe04y19qwuj6hwTEI+ZxGJYYTiKVcA97zI8GUDbjkrVomNq7qs?=
 =?us-ascii?Q?itAu4Nwumup+YstMBGveTGGxRV/AajWG96RGBnA2rnL/Yn+RRaFMctpxOTkf?=
 =?us-ascii?Q?fPtt49jdJ+lV86Kd8YUlQuiSDyboaE8c4+TT2hU1ag8vjJel0YDmgdrF50wd?=
 =?us-ascii?Q?5PN5T61AO0KWaKX08l8iSaxUnOo4RPLev6ukzVp09ABKXzAQfUvOtbaI91Bw?=
 =?us-ascii?Q?cwOJvLPSMz6A2ZFyIyUGlMVSBvPxqd8EdX53rK2fmtSe4E1H9FIHBqMSrDSJ?=
 =?us-ascii?Q?D3T2j6l2Yi3riC/5kKNqOi2vMnkV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc78c96-1887-4741-4f7c-08de7d0cb6de
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:17:49.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0080

Move the subcommand branch out of parse_options_step() into a new
handle_subcommand() helper. Also, make parse_subcommand() return a
simple success/failure status.

This removes the switch over impossible parse_opt_result values and
makes the non-option path easier to follow and maintain.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 parse-options.c | 75 ++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c9cafc21b903..6bb0c5697099 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -605,17 +605,43 @@ static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
 	return PARSE_OPT_ERROR;
 }
 
-static enum parse_opt_result parse_subcommand(const char *arg,
-					      const struct option *options)
+static int parse_subcommand(const char *arg, const struct option *options)
 {
-	for (; options->type != OPTION_END; options++)
-		if (options->type == OPTION_SUBCOMMAND &&
-		    !strcmp(options->long_name, arg)) {
-			*(parse_opt_subcommand_fn **)options->value = options->subcommand_fn;
-			return PARSE_OPT_SUBCOMMAND;
-		}
+	for (; options->type != OPTION_END; options++) {
+		if (options->type != OPTION_SUBCOMMAND ||
+		    strcmp(options->long_name, arg))
+			continue;
 
-	return PARSE_OPT_UNKNOWN;
+		parse_opt_subcommand_fn **opt_val = options->value;
+		*opt_val = options->subcommand_fn;
+
+		return 0;
+	}
+
+	return -1;
+}
+
+static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
+					       const char *arg,
+					       const struct option *options,
+					       const char * const usagestr[])
+{
+	int err = parse_subcommand(arg, options);
+
+	if (!err)
+		return PARSE_OPT_SUBCOMMAND;
+
+	/*
+	 * arg is neither a short or long option nor a subcommand.  Since this
+	 * command has a default operation mode, we have to treat this arg and
+	 * all remaining args as args meant to that default operation mode.
+	 * So we are done parsing.
+	 */
+	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
+		return PARSE_OPT_DONE;
+
+	error(_("unknown subcommand: `%s'"), arg);
+	usage_with_options(usagestr, options);
 }
 
 static void check_typos(const char *arg, const struct option *options)
@@ -990,37 +1016,16 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
+
 			if (!ctx->has_subcommands) {
 				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
 					return PARSE_OPT_NON_OPTION;
 				ctx->out[ctx->cpidx++] = ctx->argv[0];
 				continue;
-			}
-			switch (parse_subcommand(arg, options)) {
-			case PARSE_OPT_SUBCOMMAND:
-				return PARSE_OPT_SUBCOMMAND;
-			case PARSE_OPT_UNKNOWN:
-				if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
-					/*
-					 * arg is neither a short or long
-					 * option nor a subcommand.  Since
-					 * this command has a default
-					 * operation mode, we have to treat
-					 * this arg and all remaining args
-					 * as args meant to that default
-					 * operation mode.
-					 * So we are done parsing.
-					 */
-					return PARSE_OPT_DONE;
-				error(_("unknown subcommand: `%s'"), arg);
-				usage_with_options(usagestr, options);
-			case PARSE_OPT_COMPLETE:
-			case PARSE_OPT_HELP:
-			case PARSE_OPT_ERROR:
-			case PARSE_OPT_DONE:
-			case PARSE_OPT_NON_OPTION:
-				/* Impossible. */
-				BUG("parse_subcommand() cannot return these");
+
+			} else {
+				return handle_subcommand(ctx, arg,
+							 options, usagestr);
 			}
 		}
 
-- 
2.53.0

