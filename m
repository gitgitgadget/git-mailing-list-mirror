Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480571862
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011846; cv=fail; b=ou0PdrExjiYpG8rDWdBDooNRPRO8xQpomTpJcTqdlRro1M6NjTN1NS1crEw4h/M2VZnsGk8Kak75taL8rsyQf/i8pwODI+hlCVdRjLJhimmBjCgK1++k3qlHlezcwtNOHlps0PvFZxh/yHLGFZ8vRVJhWpRt9VaQLNltnwM7Z28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011846; c=relaxed/simple;
	bh=Q21q7eXi1Zd/Ui3a9xJi/tfkz8tH96VLJ9zUDHYzeeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCIjIAaJ+1HGndtNRUxaMWJpVY3Ug109b7z6AwGspO7zZjRKIOq1RQ0dWDAsN7PLebyjQzwrb4lCvOUop0g1GTPMTuJTFZ754EO4icqqj28z5BUrlfs1vpm4l+IxjOkGl72UsvN1t6mh3nB2rJMp4BnyxhsMsXM1ah325hr+geE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nhpbsL/b; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nhpbsL/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxECZo4ovYFaYGQs21HI/E12RdCRhQ09GXkNzhKkJTfzFcAQgN1p4zXVdEG5h3rYIL1NzMcvtNpMxc+kg9FVa+ctot8Fu1kk+kaHX8gfmDCJ2DG1RmvZTGb6Js6Zj/uXTmAJm1W3ehk16EauoAV6liolSyz2ncUC5NgINPsiN+7R77QX2NPGsETdpUnJsvcVRsfsAnuq9luDRWulbT2UZnWjLvOGUii60PhVdQDy62n+L/6ZNUyNvgQDz67JHMINf9sAE+Lzl+x9h0cWI4Ar8MVJfatSjkupPeXhkqayINW/6B61tyjIBRyxQZI4jsDIYKSc/DCUc+2NZ3l1khmGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfW0LkeKnayHadoAWJOuHEJV8o/zraURU/B07/drje8=;
 b=SpJOeS0YuUeTy3pT9B5rYtbihDGOy4CJHOfUbdDcou7YutrP31LzDYfx0M8wLl872SixK+wdNzx1lgx+3ardiDKA4+2pKE0CltXASTHI3BUvjg6kjA6q5Lm+iq2YJZ66EzKabRjg9RXEzqRboRaRzM9/+tAXb+OymTFAxSSqdGAqeVO/ZGADNOb5kOeA6UMdHMZGRoigxVip3Sjv2O5xivvXwoBG7CvMLBI2N4MLWPVwW3B4OmrWZ9ZnGSWAf82RFUW2W1Uk8lUGwLPureqdR8aCEO4QSRBD5hSGvKZ+4/gV5HTzBGP2ZMD3p96jHniMgRpJ8wbYitHG1KR70JU+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfW0LkeKnayHadoAWJOuHEJV8o/zraURU/B07/drje8=;
 b=nhpbsL/bWn5mJELT9By0PB/Sp6k3IL6ybRurpmyCb0nzOKUjp3lXDDr+hgK6PIZ6GVOnWxdFh178tJSobkGQEazy/xXu6SBNFfa3UzlGyOaEAj6LkMDqsT4imJ3A6qoT+qS31Bfn2CMuOhvZY5LlvhGsTmqvNaj0L/yDqxUyM+/h5ri1Leb92/E/9J2rSehU876NEyuSvPL9kZ8heMU4O6IEx0u6LDkbkqbevdWDfq+czsQ3KYJ9BCZPjYdYXpXa0E8h3CBb4hJMNbqS0YIOgVOLui9GKX64LV66qze88Z2Zrkg7NmNBKvcKvZAoNkoMnoV2bRI2e3H9md0MWXzwYw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by ME0P300MB0653.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 8 Mar
 2026 23:17:21 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 23:17:21 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v2 4/5] parseopt: enable subcommand autocorrect for remote and notes
Date: Mon,  9 Mar 2026 08:16:58 +0900
Message-ID:
 <SY0P300MB08016D8AAA50C3DBB83FF794CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308231659.2354924-5-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: cb4c0d01-f98e-41bf-21b9-08de7d68d964
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|51005399006|41001999006|8060799015|25031999004|23021999003|15080799012|10092599007|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJEc2bBKM/A4ZNUXHcsS+tlrNkhd4IsxLzotsJiq3MnRHmnPCyNTR27kG/Ha?=
 =?us-ascii?Q?ItqKCnl0RbWeXD0Q7AhDtOgOI0jBWVFcMKlq67dA5bX6rTurUwWVGSvOCxrA?=
 =?us-ascii?Q?2tcq5c+I1yE0Ha/TDdi66xoL14/GrVGVsTL2+GvtC1KGVcymDGVWQ2gYsDEu?=
 =?us-ascii?Q?FeaCEzfNeFJLF15mhxf5QcSK6DE41jdJASBZT6XVvETwby7nM8gfiEC/JvnE?=
 =?us-ascii?Q?v21BgHwyh0IaHaoP4VKH0YpaUdaIRI8ZObOUXdNSkcPoKgtrXycTWWp4TeIp?=
 =?us-ascii?Q?XfVB5P9Ts2bqUTUx/36gxZICVOeoTvtcDySjCYX8d3ACxfI7s7lm5+KPHUz9?=
 =?us-ascii?Q?PpQyrasDmIo5CjQ+qnz0hL4hITzzFhL7d4wwdsMRDWOfO0FA66xLDN3o7EIi?=
 =?us-ascii?Q?wLR72SYDHXApFutBU3HzqrvuIbOcROOpAmAD4xxRsqYw34totJi2RiVOUqPT?=
 =?us-ascii?Q?HJTFCFl3gzkF238MHEtKzzGo6bhmiH2d8pREsAiAsSs8O1VScGET6WZBpRyf?=
 =?us-ascii?Q?/h1wWKz5a3xtsLIkWKtHu4i9+wdH1+wY8jhkJb6ECVWjX7J046IsXVnqAULd?=
 =?us-ascii?Q?Ho0kGU+TlVjkxXKS7pqnIjQRT1mNiArH/xtE7/Xa3aHYS+tlI9sALWXDIZHW?=
 =?us-ascii?Q?aNGa353ZPa/5VshWb5G9m88++ilEEG+htPNYoS61F8McasXsQ1u2iTgUr1fQ?=
 =?us-ascii?Q?Ua246Sb9NvxHVDgeukmVd23UyGUL/Qx8jIICbTBPrRhh3p2bF7a6GuB2ds91?=
 =?us-ascii?Q?oTorts3DAfWOQ7hHlo0sNZplPCb1Z4hoIeWWCBfdutVflE97cm1mz7w/KYYQ?=
 =?us-ascii?Q?VVNHefDr/5moPimBeBci70e1WYzFok9/3CYp1JGOh6zqUdEYRKThzGZMZLsM?=
 =?us-ascii?Q?/X7ACCBbgzKLnZ7kddTHxv/D/d4jkkd0+URHUak9qdG06N5b8wb3Orrxinms?=
 =?us-ascii?Q?iUHrvPcdc46h0QPAHg+3vqPyENrRqTVxAVEtDZN9ZGzFYN9Vy1XcQcVHVe4i?=
 =?us-ascii?Q?MBplFRZ38I1B8zcJcSpenEhxWdWC2fVfSk4rUKSZc9l8VEg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELPziSYF7HbH6DCjjIzLnfICncEdY1/rIdf2YcEKjM1EfBDRQEpRCQ9erz44?=
 =?us-ascii?Q?w05z2XX6Y4WBO7NAb6TAJ55OHuPPyMuCX58wyOn0bWDnOM5ROds0b5GfKf1c?=
 =?us-ascii?Q?7DU+QSaDywmL6VFojGUEdnaYLmwbl/8OvnDPq0/tl3rF0LP+xesH8LsPm+gY?=
 =?us-ascii?Q?k7j8PFfCUpNDpbInIMJKV2Rz6JpDfJQSdidO9Sj0kQdbpqlT9w1RQmyN2Ggy?=
 =?us-ascii?Q?FjOjIz0ESrqXc/hSOuZmO6Spz/7tIzyfna6jJ2GJLKqJI716tEsUi2nZ1Sxr?=
 =?us-ascii?Q?WH/As6i5KcX8TKkzW23DhQLUY0WYKjTI8Q6Hwu6r3Jmkf+dT5vmOPpXi9TWS?=
 =?us-ascii?Q?PzJjQ8uY338Cy2YL4uwmnC3cL/X9LWfiVJ9BXb4SwiVE1mKZzVp19VGTmzDe?=
 =?us-ascii?Q?WIBCvP8lXnKWf7B5T305fDfSlMv5PIQEs4S45wktIrFW1UsrgSd2qL1rjBXz?=
 =?us-ascii?Q?8q6UpYlRsQgpISNdKPG3hvc4rpBjpA/PuhKxyOyh+ScblcKcPcZu9PVps8GY?=
 =?us-ascii?Q?47tM6+BzRQ+wjfSwMcVW5madNwWHhYXq+Njdk7DNtXFEzH90OgHGOz9UjlCV?=
 =?us-ascii?Q?hp3mq6wjFw4ghRrAD0Z5tLp+3lyMPmygYuYYiv45/d4iWEHexWc9pqdP3qWF?=
 =?us-ascii?Q?P0qM8hEjjnmVzdBcRJ6wXaWNubwgTpS6SI8ItAFnCg4xMhGoTMmGZagBF4bc?=
 =?us-ascii?Q?W/bjEzgYp3jCBTqp8OQntEuP02nOlHEm0aP2/G4B6e5LC+ymBJX6dmkWy4pb?=
 =?us-ascii?Q?LKPi6mx3lCyR4Gi/idez7FcsO+f2LdXSjUvvTBZuw8CSK47RGYw7ASo/O5Bi?=
 =?us-ascii?Q?cSCQsbGSiYAVCO+TmGepRWRGh7O6uiXl2JAE11t7i75xj2/WQbhQ0dXVJiAr?=
 =?us-ascii?Q?mxHJauwA1e8w7oHCLL8q59CQVv3GqFMXLxggt7YE3ALs113a1Gq7Ei07DQll?=
 =?us-ascii?Q?bNbbCtLRmPmjSopOtfAvS0UUxkDQuxySjhpl6HQ/lcz5u/RBB8DhEcHqKRgw?=
 =?us-ascii?Q?b1VHII2EZTfgfqxJ+C27fbQHwr3BE3tiT4eVJe9J+t7MwLwWUxNrWnWCqGd+?=
 =?us-ascii?Q?jQPWiLUke0Gh82yTAhjvBxQjjsMHpL88S+ej02meH88qgSLKgg02JqOU5OMa?=
 =?us-ascii?Q?2rmADY6UgKOnW/ttKyVPcpzzDbCaVwYjWJDLHn2uCIxA9mvecer5Y6pizmEF?=
 =?us-ascii?Q?SwUynVdxufyVOWYh8OAvApNqxGRnxJJORvnEFnOCAJAMuaXkJCvQ7Goaa5E+?=
 =?us-ascii?Q?mJm19vE+I+OvkCZWoc32AvOfpcQ+vfeFxXqFcSZLMRR6WtoY2n2LfrW4SVeG?=
 =?us-ascii?Q?/3kI5cI2/QAVONjucywiNp81BLwMOwgTYIfj6/tM3VysLQfMbsnnUvwH1x9K?=
 =?us-ascii?Q?84ow76ynWL9zz2FEwFZZ3U4u7GdJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4c0d01-f98e-41bf-21b9-08de7d68d964
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 23:17:21.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0653

Add PARSE_OPT_SUBCOMMAND_AUTOCORR to enable autocorrection for
subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL.

Use it for git-remote and git-notes, so mistyped subcommands can be
automatically corrected, and builtin entry points no longer need
to handle missing subcommand error path themselves.

This is safe for these two builtins, because they either resolve to a
single subcommand or take no subcommand at all. This means that if the
subcommand parser encounters an unknown argument, it must be a mistyped
subcommand.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 builtin/notes.c  | 10 +++-------
 builtin/remote.c | 12 ++++--------
 parse-options.c  | 16 +++++++++-------
 parse-options.h  |  1 +
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9af602bdd7b4..087eb898a441 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1149,14 +1149,10 @@ int cmd_notes(int argc,
 
 	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
-	if (!fn) {
-		if (argc) {
-			error(_("unknown subcommand: `%s'"), argv[0]);
-			usage_with_options(git_notes_usage, options);
-		}
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_SUBCOMMAND_AUTOCORR);
+	if (!fn)
 		fn = list;
-	}
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
diff --git a/builtin/remote.c b/builtin/remote.c
index ace390c671d6..d1d6244a662a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1949,15 +1949,11 @@ int cmd_remote(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, builtin_remote_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_SUBCOMMAND_AUTOCORR);
 
-	if (fn) {
+	if (fn)
 		return !!fn(argc, argv, prefix, repo);
-	} else {
-		if (argc) {
-			error(_("unknown subcommand: `%s'"), argv[0]);
-			usage_with_options(builtin_remote_usage, options);
-		}
+	else
 		return !!show_all();
-	}
 }
diff --git a/parse-options.c b/parse-options.c
index cbbb04b9997a..b7c818e818fe 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -691,14 +691,16 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (!err)
 		return PARSE_OPT_SUBCOMMAND;
 
-	/*
-	 * arg is neither a short or long option nor a subcommand.  Since this
-	 * command has a default operation mode, we have to treat this arg and
-	 * all remaining args as args meant to that default operation mode.
-	 * So we are done parsing.
-	 */
-	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
+	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL &&
+	    !(ctx->flags & PARSE_OPT_SUBCOMMAND_AUTOCORR)) {
+		/*
+		 * arg is neither a short or long option nor a subcommand.
+		 * Since this command has a default operation mode, we have to
+		 * treat this arg and all remaining args as args meant to that
+		 * default operation mode.  So we are done parsing.
+		 */
 		return PARSE_OPT_DONE;
+	}
 
 	struct string_list cmds = STRING_LIST_INIT_NODUP;
 
diff --git a/parse-options.h b/parse-options.h
index 706de9729f6b..f29ac337893c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -40,6 +40,7 @@ enum parse_opt_flags {
 	PARSE_OPT_ONE_SHOT = 1 << 5,
 	PARSE_OPT_SHELL_EVAL = 1 << 6,
 	PARSE_OPT_SUBCOMMAND_OPTIONAL = 1 << 7,
+	PARSE_OPT_SUBCOMMAND_AUTOCORR = 1 << 8,
 };
 
 enum parse_opt_option_flags {
-- 
2.53.0

