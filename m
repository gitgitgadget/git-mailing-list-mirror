Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358B41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfBGKeu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38273 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBGKeu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so4311122pgc.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0daa3NeKn4AqsTiEzcRHYU1GYlwzA9M2Rfdmgg9w4O8=;
        b=LxJAvHxZH1bZjYDWmOWV2nvhvH+D+hjRoF4Bt/Idq/BRbLj3xNB1/TGTo167GKG8W6
         mV4AluU9xq7Pw1zmUXgDnaBNEoI6Te5bzxSNRtB5lU8J/NNPDKElMjNG7yWsNyZqzeY/
         rchgST1ki0I5vfzfOgs7niTLVn6cyVUll1H2KvG8L9QKisET8ilM3+0EMMpjNJdCHnMm
         7UMfJxTeaRmF9pntaxA7WzDpAggSKC9Y3WZWAnfLR9/fmyTfhtAUO93/fv6ai0sVsKfM
         LxpK5XMjvodRwXjPKwIOCw2QFlOOAR3bUuuCOLR2BsMW2ntRvX6Gq7TZ3LG8qWQYBuyT
         ETYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0daa3NeKn4AqsTiEzcRHYU1GYlwzA9M2Rfdmgg9w4O8=;
        b=KVmnpDPhglq0Ml5vsB8e5BTLpWY3Lq/P27+X1uW2hvltxFRm2yTpsRHdarR4kdsfHX
         SPwOve4+21HQgLLPYXfp24L/7YwXnEk/AoyyLfzkZ27MC4jrdYFehoQH7EET5zB+UsFJ
         THOv3F4UVz4DvFgNnmMT8Sg51b6t/x8sZMyPTf5NQqHimzd5GFSdyJEKr1JES/VUfZct
         5SNmAH1Zb4q2h9+A4P5bmf7AXPIXBxcYnJrQi4O+1N0oojnzskh/TP9AT7qeZsq2qb7d
         iQnrrhkablj1La09fXu8/U0NTNFtVSLZKU7NmxgZtywuUi/Rm9+B1fmPp2ZYEsshEwcN
         Y6Sw==
X-Gm-Message-State: AHQUAuajrAX0tpXT2D1vQqDVjCIEURE73AnHkeNOiCI3VYYDFOkj74sW
        voDvgAW3AUSnKnYVDrZDpkqJh0Ll
X-Google-Smtp-Source: AHgI3IYFBmp8rj5AFGoWo3C3TqiIkqJxxDFe4N/4Xy36MP+yD6R+cDQegFHfwoAIkBf88n8bdTKDfg==
X-Received: by 2002:aa7:87c3:: with SMTP id i3mr3253902pfo.245.1549535688924;
        Thu, 07 Feb 2019 02:34:48 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y20sm3517475pfd.161.2019.02.07.02.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/21] diff.c: convert -B|--break-rewrites
Date:   Thu,  7 Feb 2019 17:33:18 +0700
Message-Id: <20190207103326.10693-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 62 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/diff.c b/diff.c
index 8df396cb9a..d2139082b7 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,30 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_break_rewrites(const struct option *opt,
+				   const char *arg, int unset)
+{
+	int *break_opt = opt->value;
+	int opt1, opt2;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "";
+	opt1 = parse_rename_score(&arg);
+	if (*arg == 0)
+		opt2 = 0;
+	else if (*arg != '/')
+		return error(_("%s expects <n>/<m> form"), opt->long_name);
+	else {
+		arg++;
+		opt2 = parse_rename_score(&arg);
+	}
+	if (*arg != 0)
+		return error(_("%s expects <n>/<m> form"), opt->long_name);
+	*break_opt = opt1 | (opt2 << 16);
+	return 0;
+}
+
 static int diff_opt_char(const struct option *opt,
 			 const char *arg, int unset)
 {
@@ -5011,6 +5035,12 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("specify the character to indicate a context instead of ' '"),
 			       PARSE_OPT_NONEG, diff_opt_char),
 
+		OPT_GROUP(N_("Diff rename options")),
+		OPT_CALLBACK_F('B', "break-rewrites", &options->break_opt, N_("<n>[/<m>]"),
+			       N_("break complete rewrite changes into pairs of delete and create"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_break_rewrites),
+
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
@@ -5044,12 +5074,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* renames options */
-	if (starts_with(arg, "-B") ||
-		 skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
-		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
-			return error("invalid argument to -B: %s", arg+2);
-	}
-	else if (starts_with(arg, "-M") ||
+	if (starts_with(arg, "-M") ||
 		 skip_to_optional_arg(arg, "--find-renames", NULL)) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -M: %s", arg+2);
@@ -5328,17 +5353,14 @@ int parse_rename_score(const char **cp_p)
 
 static int diff_scoreopt_parse(const char *opt)
 {
-	int opt1, opt2, cmd;
+	int opt1, cmd;
 
 	if (*opt++ != '-')
 		return -1;
 	cmd = *opt++;
 	if (cmd == '-') {
 		/* convert the long-form arguments into short-form versions */
-		if (skip_prefix(opt, "break-rewrites", &opt)) {
-			if (*opt == 0 || *opt++ == '=')
-				cmd = 'B';
-		} else if (skip_prefix(opt, "find-copies", &opt)) {
+		if (skip_prefix(opt, "find-copies", &opt)) {
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
 		} else if (skip_prefix(opt, "find-renames", &opt)) {
@@ -5346,25 +5368,13 @@ static int diff_scoreopt_parse(const char *opt)
 				cmd = 'M';
 		}
 	}
-	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
-		return -1; /* that is not a -M, -C, or -B option */
+	if (cmd != 'M' && cmd != 'C')
+		return -1; /* that is not a -M, or -C option */
 
 	opt1 = parse_rename_score(&opt);
-	if (cmd != 'B')
-		opt2 = 0;
-	else {
-		if (*opt == 0)
-			opt2 = 0;
-		else if (*opt != '/')
-			return -1; /* we expect -B80/99 or -B80 */
-		else {
-			opt++;
-			opt2 = parse_rename_score(&opt);
-		}
-	}
 	if (*opt != 0)
 		return -1;
-	return opt1 | (opt2 << 16);
+	return opt1;
 }
 
 struct diff_queue_struct diff_queued_diff;
-- 
2.20.1.682.gd5861c6d90

