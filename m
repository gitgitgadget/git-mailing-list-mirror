Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010009.outbound.protection.outlook.com [52.103.73.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14B3D3321
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860393; cv=fail; b=Ib338Q6JHYcQydo3252uGKdsQMdXRR6yVtdLVKgPrZgjyziyrRSDYT4Fu03yQqrgmiOpElRiE7tZEdVc82CbWsy8K81ySe/9/CHr3vPtGLjaWqNvx5o+wqeFF2D47EUSOdERqx+DIN6wwfzov489eIM7dCCjYT5P+F+oGJLHIAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860393; c=relaxed/simple;
	bh=JcPrsnePazJof9W9hJqmKWDexczokOAeJ3i9vBYBAP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=df2E3YdfClWmVlarhdMEph5bonaB/OZUVz+VppO1ccvB0gz3gWiExCb+YibjKro4GVbUHQK90NW6QTpa8EMAtedcCdPaX0Xqo4xmELEw6sdtPKPk2zfrOyotai8ESYmCAjTLKsTLtUQA6H8P30jLGnG4Cv8afWnIJSqANUI83rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ePjODUNh; arc=fail smtp.client-ip=52.103.73.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ePjODUNh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGPYc2Fpk/JGgL6qv2pVkLfYIfBEM/8JnyrTvQplDiWlrrWgfBqxCfnSgT4Ec+iaqeaMBSDgZgbjyqEkufer4yVgZGFMcL+ypyZNoNVn2nhzIzCEvqy25zTJboForafBU1KKE4/1MtQAury0NqdH5Sgvjf0E3e2cGCRS1OP0zM2rTzssWfwsIbluV3pm0rWxNZMHJnOAkSwcaDXCHFgzhaBc9CSfi0P/4lX8zZGCNY/3FikzRpAgnIOQdGfsJ4efXVtUBeHJHirQnLV+4FZPFIVrzIgL1Js6BERglEJ2hNBl8jGnmo8KdFVUmH0PN355Kio1/oJi0mM1Mq84+sPXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhgvGpXzYvGxyMAfpWL9uZVmWuK+vaYQQ/kcv9u+Mm8=;
 b=AbnVSbPnVa8MYZBVIMGz1Chr/tER7KAjkjnCp+8sP3pikEr64UA9sOSxZUqB/5AFW2Jg9iIuwtDLuZa6OXgGpmt+GquBh2Es1kB4glAKyc0CpwMJID3pjMP200mZcixNXzr0aDKJRJZhB5ANtNe2eWZe8h0g2tDgzLyh7l31mWhzlzyCf3XPaLMT0HtAzc9F1JZzwwwKL59uURlxUW+RgDGAH0UVT122Kb7HnG/m63OoselchNTldbdtsvEdBMbevbdrFmy00eEa5PcW7CG6lDJDtCpBBxzIySJ0XIs19By3Sj/RBd87vuD6RSbhrlDc7vXyRajQja3bGAnXquoYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhgvGpXzYvGxyMAfpWL9uZVmWuK+vaYQQ/kcv9u+Mm8=;
 b=ePjODUNh/lPsWpFVXCgoVLMXzkCeBixmqO4UIwd1SNZx1sK8/23KMa0qv9WtRsQO9HNCJ3fUWhgslTbrvKI19jSMMhASKBnR15Eq0rTDccK29OLwfA76uUUryBZdhg/gSRJonDj6DNNp00Bbjhaiz+/9OIefDkvfczHuxxq1iPx8vgKg6zeAhMdZVjN9wYjPqld+8+JAKHqOoxVtEh2FQtwA2h775qvHbZur1AbeJH2CFZpQb0ppuALcxxAJ4i2BR194+M4cIsnyR2N01f8UDEOF70jdq1vUDQ/CpmFdbDzJldFO8zmHkc8bUAAaEojAMKH30gwU66ADUZrd7N18LQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0355.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 12:19:47 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:47 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 01/10] parseopt: extract subcommand handling from parse_options_step()
Date: Wed, 22 Apr 2026 21:18:01 +0900
Message-ID:
 <SY0P300MB0801E48CB82BBAD8946BA37BCE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-2-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0355:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fd8436-ade5-4bd8-172c-08dea0697179
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|12121999013|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ch3YTs39tAE8enYLgIfo+hFTqlDwjnF8XpvE/gtnfczFHSD6mZb2L99PMvZR?=
 =?us-ascii?Q?Bv56wbUx985sJ4KzsosNXgJoaqifom6wrmL0H5w2TMBJuiBTgsEVWCSPgPoE?=
 =?us-ascii?Q?mgu14LSkdJMRLDR3MBZj8D3v1hCAfVyaGPpI0vDuakYcdFqoPW/ervc1t137?=
 =?us-ascii?Q?KwgiooHdSPItz3ei0rsqXRg/1aKBey5QPJew8yaBG/XpOPWQ58RDYSM8MMMb?=
 =?us-ascii?Q?9Hpt9wWOfZtW/RTV+elqf6tzXtuSN5mefmIAgzNzeadMvLaWxxN9ITVwaOGe?=
 =?us-ascii?Q?Wi0+aVXIk4g3pxIFc3vrHx0KL/kcWrhsWER5NWWHlM2Mxp3G3T81fzmFyEuQ?=
 =?us-ascii?Q?f3AgNnW+bsBkKBnTrSdd23HSYZLpWVXm+vH9aei0tJcqRcOTpcp2u7zIR9kn?=
 =?us-ascii?Q?r1eHPrMnFdNCjy3OXifMlXJpjiIDj0opf6NuIN5H/s7dy5RV9evXTx6TCpHQ?=
 =?us-ascii?Q?B7tGt9fB9rHc7ozPGgalIsm5krmBAZZllebEIKHPKh/ob7Em0NSPEus/c+OV?=
 =?us-ascii?Q?R8hF/CBGO+yCNbmOX85Bx6DgX9Vb7WIR60wS5xerhc9SmtencUc4c34OhNJn?=
 =?us-ascii?Q?Sop/XHBSL6lNT2GESQA7enakHVTXGaxEUK/vfEkdDxtp/YXsPL/biOLCsIvM?=
 =?us-ascii?Q?mE1/fisvJyJ82OmeZaW7ddIQAm0LB/dXtiiBM+vhRUQyRn4gIcvW8j/uoVBB?=
 =?us-ascii?Q?Mam06xYIJD9gyy2SRqND3iafceyjpo1U869vUdHjllhlJ/C48oC/M2Y8eScQ?=
 =?us-ascii?Q?49tugi1zHnW3+0K9s4ys0b66zAkNTCN2IPvrPLVsDyKjSCxy7IjBmJWeWJiv?=
 =?us-ascii?Q?KrlFs5VQs/fh8PVA/1C4V5V3+0vmVyOHrBmREPB144YbYwiD51Lybm0b9m67?=
 =?us-ascii?Q?9fF2XkduO35VBDlQLpFnfl8gSy0NBCRmMItslzRhJhZW6UG47WrGKKbDzwkv?=
 =?us-ascii?Q?t+iiZBTBLFHpPE0+pCqbAPid19u3/ySUSoq+XLdFxKDvjjroFQtIt+OQB0iP?=
 =?us-ascii?Q?ZoF5OB5klYYmALY2HkTM5INiNunUGcHXwErJtb0/p3S0WWpbGzUkdKnLKtfQ?=
 =?us-ascii?Q?mpxZ1dQy?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Bt7PEB2uG9sy1eavS2zWFrpSmg2R7hP6pIRRHNBp9difU+NxB+rRSNRpHYS?=
 =?us-ascii?Q?XkAqh0SGdhZk29qLGC5Pez5mmT2dWSQYlEyQI+yoAUwgb1V0JrnjDV+TZ14k?=
 =?us-ascii?Q?OEIVog6IJYEHNK1nr6OxidXslLw+ws+vQo2Wru3mdJijyIvPBrxw+APwdSDq?=
 =?us-ascii?Q?LHAW5uW7A59wu9SFvnIW4V0YAWRNmiv5CKbIQuy/vc37ESwGu4WynnLyDkHl?=
 =?us-ascii?Q?QlQZYtYyjJkB63CGCbH80m4JiOy4PuhB7OjRcSIboacluSK0kcve7kjLsAGC?=
 =?us-ascii?Q?zM5EC4EF8eR5I86yv4EXDFX9KCFd4MsrSh1PKa1lbayh4qDQ1QCGGkESrFnJ?=
 =?us-ascii?Q?vMgld9+mWN70PhNPkxWAhJ37Z/iTxCRxncu8G+X/20fMMJgHIuihnDAKJQn/?=
 =?us-ascii?Q?68/54TJHlfBURL6JbqxworPThgRigI0VCmnEzeihu3fKx/yLCcxX6utoHDpC?=
 =?us-ascii?Q?30VOs8G5bQzuPkZGES3lKviodkvLmcpFN1BIQXrggGqHQ5mR9ZJskAzi0LZW?=
 =?us-ascii?Q?sHLwiM48kjXk36TbeHTGjH2I2Q/oWaYVKsGH6kLsSusTe/ZIWXZIHNAwuEbw?=
 =?us-ascii?Q?y5Q1/h52YWVWeUwZf/jhxIw1DVWsnGfkH1pR4sMR30o3tBlT95XPR8NBamMb?=
 =?us-ascii?Q?Ut4pJ0Qww9A3bj8PzSJY444w8Vyx2aZI8485O8YAdzzPKeaagoumQTta9sDK?=
 =?us-ascii?Q?3lm1wemF806kvSZMrz8Y21Pgn3beJIeb6PqaUTjToe/3ORLyofxE+ckMkZWT?=
 =?us-ascii?Q?vaxcu+DTKhHxVOhGnCH7+feCs68EhM5NDxOdl5HngUqRHFN4JnjI7ICwEi8+?=
 =?us-ascii?Q?5SaUWKCAVzqzIphQLV14JDcbTf0Q4PM69apSnImWNoNoxnIgatwSSSXyxvMG?=
 =?us-ascii?Q?HJyXuXLIO5B7KtXs8lJfRAUFsKrTt5yGIiXtfnZSExEfIFKEeU2b5RvjZ7OS?=
 =?us-ascii?Q?+cnNDq2k+Y13uEOsYcA9/spESdow4Lvwk99OG8zDV3X+PZnZXnyAJ6CL6WF+?=
 =?us-ascii?Q?ih/0/qzJce+ijGrKEbMjchIJ52AJmHnZJY0qYhJ7Bt6/XT6MpzGZWgAzShS0?=
 =?us-ascii?Q?KAB2I6/EbqgYIqv0Q3bBjSha0cWeTwIpz7DXHYuRcvXEE+SwVPSB6HlN50DW?=
 =?us-ascii?Q?tP38xHhRXFmwGrLyabyCcz8KiY8b6SFoR5GHZ1v/SvAIlNBM6lNzSBkw1qWk?=
 =?us-ascii?Q?h8eV7FpyUXs6oJdfz3FrmbFAvfFWUo3eKz/n6uCDNZvIGT+efFkZ9v+dhwtV?=
 =?us-ascii?Q?eG+DwltrA84XXw/IrKtoE6eZ8iWySiQXWZ4XDxInwHPAvtuYMYRn2kCFxGGz?=
 =?us-ascii?Q?nDV5zCEXcuwBnhgE+QPsBmQ9LFmHbKZaSojLNoJ0s0uCRDRsuYAniBpEk2vG?=
 =?us-ascii?Q?Nm46jWPXQVB4Er1yFaaasAmSoCzH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fd8436-ade5-4bd8-172c-08dea0697179
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:47.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0355

Move the subcommand branch out of parse_options_step() into a new
handle_subcommand() helper. Also, make parse_subcommand() return a
simple success/failure status.

This removes the switch over impossible parse_opt_result values and
makes the non-option path easier to follow and maintain.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 parse-options.c | 87 ++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a676da86f5d6..803ce2ba4443 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -606,17 +606,44 @@ static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
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
+		parse_opt_subcommand_fn **opt_val;
 
-	return PARSE_OPT_UNKNOWN;
+		if (options->type != OPTION_SUBCOMMAND ||
+		    strcmp(options->long_name, arg))
+			continue;
+
+		opt_val = options->value;
+		*opt_val = options->subcommand_fn;
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
@@ -1011,38 +1038,16 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
-			if (!ctx->has_subcommands) {
-				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-					return PARSE_OPT_NON_OPTION;
-				ctx->out[ctx->cpidx++] = ctx->argv[0];
-				continue;
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
-			}
+
+			if (ctx->has_subcommands)
+				return handle_subcommand(ctx, arg, options,
+							 usagestr);
+
+			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
+				return PARSE_OPT_NON_OPTION;
+
+			ctx->out[ctx->cpidx++] = ctx->argv[0];
+			continue;
 		}
 
 		/* lone -h asks for help */
-- 
2.53.0

