Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18AE21F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBULRf (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37431 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULRe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so13612978pfh.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCPBEqBaZhwujG3R7wWeThIiOsXE1NPjaQURPeeq2fs=;
        b=YZSSsUco21L6T7RHPWkd8IW0lOZSAnKxRlxXSDJFpiSh9mMrz8jwfLn7BZAoNHTwSv
         8kwsq2vpMLTsY2tXhuu0qi2HhOHUmKyerdpKNMPgnvgfyw2JlhyetRV8CA9xZd2igrl3
         gD1sxBQPrvtngM3o+rF6+j9jjfhSTp/QQeEtHHQf77IlI6mEJPlOvMk06Am3Ceasfe/V
         QqlPmQw3kTQBs37JfxIACRebb4LE8eDH/WluzgsUa7cgSHUWfUJbnt3MZY55ndShVnd/
         Qnvk4PcQVxHFEP4rGiepwpmlOq8DD+IOMJmehQ4LwJzc0dnEoVVLjoFItiSzdXC/nSzq
         yg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCPBEqBaZhwujG3R7wWeThIiOsXE1NPjaQURPeeq2fs=;
        b=nNDVxpc0Uz91VfbGNT3Wgg6zS3tfyNrVKrClUvDyvr8k38qClAFP8NEIXo2A14Iio1
         FM5smkKby+DtO8iJ8bgUgoevv2YBavgMfKyhW9ZSGa7EARRTy12bNfKMXNskuuZLtP+t
         asaFACAye34xJnIbteI4EBKS3gR5GEPoyCpqsf8UvVBNe9RtVa0QnCYNGwEjsysb44ZT
         YsL2l2ZWc9wScsvc86DGAasKaPNQM2FjED7XVph63CCCWzW6aWmrAIxsHfcY9AE6g9sX
         GkSx4vOfDCBWfTZx9JLlp08XaFk2kai2gDv69Aa5Oy1qW1Gp2jA1KYfVwJoI1Z1QM5Bx
         RNNw==
X-Gm-Message-State: AHQUAuav6QNOatWx63M+yq4s7EqosD/o03CY5h+yEO4TaGT4ZowPFDFe
        bmB6qb4YTTBVY0r+chdK+fvMa2DZ
X-Google-Smtp-Source: AHgI3IbpKofrZ236c43cNZuhXbdTgkALw9J+4ar8wywRg2uWgYgX07EKmlTXm1s2fiaFfI7/S2QTxw==
X-Received: by 2002:aa7:8150:: with SMTP id d16mr17015938pfn.172.1550747853552;
        Thu, 21 Feb 2019 03:17:33 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u184sm616809pgd.13.2019.02.21.03.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 12/21] diff-parseopt: convert --output-*
Date:   Thu, 21 Feb 2019 18:16:12 +0700
Message-Id: <20190221111621.27180-13-pclouds@gmail.com>
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

This also validates that the user specifies a single character in
--output-indicator-*, not a string.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 10 +++++
 diff.c                         | 71 +++++++++++++++++++++++++---------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7b81b852ca..56b731eae5 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -41,6 +41,16 @@ ifndef::git-format-patch[]
 	Implies `-p`.
 endif::git-format-patch[]
 
+--output=<file>::
+	Output to a specific file instead of stdout.
+
+--output-indicator-new=<char>::
+--output-indicator-old=<char>::
+--output-indicator-context=<char>::
+	Specify the character used to indicate new, old or context
+	lines in the generated patch. Normally they are '+', '-' and
+	' ' respectively.
+
 ifndef::git-format-patch[]
 --raw::
 ifndef::git-log[]
diff --git a/diff.c b/diff.c
index b24f6825a1..8df396cb9a 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,19 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_char(const struct option *opt,
+			 const char *arg, int unset)
+{
+	char *value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (arg[1])
+		return error(_("%s expects a character, got '%s'"),
+			     opt->long_name, arg);
+	*value = arg[0];
+	return 0;
+}
+
 static int diff_opt_compact_summary(const struct option *opt,
 				    const char *arg, int unset)
 {
@@ -4872,6 +4885,23 @@ static int diff_opt_dirstat(const struct option *opt,
 	return 0;
 }
 
+static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
+					     const struct option *opt,
+					     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	char *path;
+
+	BUG_ON_OPT_NEG(unset);
+	path = prefix_filename(ctx->prefix, arg);
+	options->file = xfopen(path, "w");
+	options->close_file = 1;
+	if (options->use_color != GIT_COLOR_ALWAYS)
+		options->use_color = GIT_COLOR_NEVER;
+	free(path);
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4965,6 +4995,27 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
 			       N_("generate compact summary in diffstat"),
 			       PARSE_OPT_NOARG, diff_opt_compact_summary),
+		OPT_CALLBACK_F(0, "output-indicator-new",
+			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
+			       N_("<char>"),
+			       N_("specify the character to indicate a new line instead of '+'"),
+			       PARSE_OPT_NONEG, diff_opt_char),
+		OPT_CALLBACK_F(0, "output-indicator-old",
+			       &options->output_indicators[OUTPUT_INDICATOR_OLD],
+			       N_("<char>"),
+			       N_("specify the character to indicate an old line instead of '-'"),
+			       PARSE_OPT_NONEG, diff_opt_char),
+		OPT_CALLBACK_F(0, "output-indicator-context",
+			       &options->output_indicators[OUTPUT_INDICATOR_CONTEXT],
+			       N_("<char>"),
+			       N_("specify the character to indicate a context instead of ' '"),
+			       PARSE_OPT_NONEG, diff_opt_char),
+
+		OPT_GROUP(N_("Diff other options")),
+		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
+		  N_("Output to a specific file"),
+		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
+
 		OPT_END()
 	};
 
@@ -4992,16 +5043,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* Output format options */
-	if (skip_prefix(arg, "--output-indicator-new=", &arg))
-		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
-	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
-		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
-	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
-		options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = arg[0];
-
 	/* renames options */
-	else if (starts_with(arg, "-B") ||
+	if (starts_with(arg, "-B") ||
 		 skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -B: %s", arg+2);
@@ -5242,15 +5285,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-	else if ((argcount = parse_long_opt("output", av, &optarg))) {
-		char *path = prefix_filename(prefix, optarg);
-		options->file = xfopen(path, "w");
-		options->close_file = 1;
-		if (options->use_color != GIT_COLOR_ALWAYS)
-			options->use_color = GIT_COLOR_NEVER;
-		free(path);
-		return argcount;
-	} else
+	else
 		return 0;
 	return 1;
 }
-- 
2.21.0.rc1.337.gdf7f8d0522

