Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335ED1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfBULRk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40286 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so13592940pfo.7
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ewaq1kI/Jr3F1GWGzVU4IXs35xSV8NqNiU3WZvnDUx4=;
        b=DlG+mzSzEtZOdshktB8hgFQB+vyD0+Uj6TMbiTgE6O8f4pVllRY5UZ7Y1Cv8Upl/y3
         hlZxqNwE7nura5XSSpKRPAzoCctlbR7CBHENvKYtb9nIDc6nEVH/SmksK2Tr6Yb3CAZC
         b6XcrqvbhBBtQVeNz2RBbFYh/hgZojibXx8924WI4Vj9Lu/EGqNuNi3804l1+F98zw/a
         qDCx0LgObr9gt//l4UIIK+cmgpO++E9SAcrYsNtvwqrbN6A3/NeErsXNm8yOSQ4OvAwl
         +he09TmxUOnEcqoEPbbqQX+hHG91CgL8tJuJOzuFLfflEuG+DgmlRzGDJowinlFFcHcb
         PjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ewaq1kI/Jr3F1GWGzVU4IXs35xSV8NqNiU3WZvnDUx4=;
        b=hBSUvOffiBdG5TxXcw30LTMese+FWvXghgMw9szmsUK3mvJ0i9q7XoonbM83vib+Ep
         lc8rlVdc/LpS9PXUQ5d8IBtT7RtXVaPrZy5hGHkchkz3UGs//JeR2XpwNXK5R6JpqmRh
         +0N3iZEQqNYgb1EpncDswOSeaiQP8zVuSMzagCWCwNGI3c5nyrfQPzTDLexNOmvJldEA
         UtPQrDWpUg8d2LxeIrfC/D5zaDqD+vuL+zwKdm0MkFxR59eHqUVYYiGzdDdFeVVDTaMi
         qddL6UV+aK4oIMf6OceTTCcuwQZfaE/N1gy+JM570cb70KeZ3ALafPPfXeJtqUqVep18
         zjug==
X-Gm-Message-State: AHQUAua8gEk1o4iAVc+QFnQXdE5tyQtEkQO3T5aKJbeYY4E63CmlBp5s
        j2ndP/ZdrVSdEdzFG8FbouAruL7E
X-Google-Smtp-Source: AHgI3IY3o3gIqN2gHGjAWk5xzglRv5Yl/ghafaMclx3ZniXi71vpDnj4HfCmdPit8cCQu9U4oz3Xeg==
X-Received: by 2002:a63:5813:: with SMTP id m19mr34017447pgb.294.1550747858846;
        Thu, 21 Feb 2019 03:17:38 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f6sm34171320pfc.88.2019.02.21.03.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 13/21] diff-parseopt: convert -B|--break-rewrites
Date:   Thu, 21 Feb 2019 18:16:13 +0700
Message-Id: <20190221111621.27180-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221111621.27180-1-pclouds@gmail.com>
References: <20190216113655.25728-1-pclouds@gmail.com>
 <20190221111621.27180-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.21.0.rc1.337.gdf7f8d0522

