Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F281F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBGKep (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42848 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGKep (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id m6so1140734pfa.9
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6co4Ndthljc+PaKdnjotb/2fUnLmuk6OFWLCL8HMI4g=;
        b=pj/YYiFg2bGpRWuq3OHY8WH2nHa63z/RqL+nJBkjHB7iI6kfN9/qRLnRlKR5YannLq
         CtgKWIcb2iFhppthmSd9qBo1p3UrLcHYDE3Nv/R4q+imxxKI34wd4/3gUF2Z7za0pxSC
         PeSPfrnCUuzGnA57UnNngRTe5lxx3Yq2sMnR2itvYvyq6edWCxjjfA/qWD5qGGZV2Z+O
         h8COiH3+PyKqw0eNz7VjHC0WFsObXsBe68RJ7fujDmWv43TYaodUEcHQ2Ly9x0wGeTG/
         gheX6jhpw1griuA99vqJzMae7sXUXDYKPD0Cpk4hLmWEgCKnHIbBKJONJUwkw2xbEIdS
         KoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6co4Ndthljc+PaKdnjotb/2fUnLmuk6OFWLCL8HMI4g=;
        b=pfJhqgLnbZ1oRpaJLtZlEPsIIPj3Lrp91l02dgzk93ah2g75dd5zjFtT8LLkLA1GQt
         kK02Izlt2b3StFCudB8ZOOxOuwbLD5NJAvxlEZEeFOf0D1OAjUTkB2sz4Sld1V4qs3R9
         3YF8TEakuvHm7U4QW+R93maauRxFNVdc/Cu+KFJwC6DNoAGRht+N9+rWptKpSfU4sOXc
         thGUk4GZP/eOXAZk38IHqiiTzaLaGvoKGxdT6PtYD+ZlBExth4tzWxnQu6QNQ4+PCtG2
         4FwFxEwBI7ga98H9kYbPuPXAo+EGYXtVe5c+wX+FjVqFqrPDfiVFb2wMdgDWoSteXM3E
         M/lg==
X-Gm-Message-State: AHQUAuaa/sCf2hY8j27rD9KVuz1cJoQ/rPoi0Z6r9Hitv7h4Amw0V9zS
        She2v+/nGiU/IKtVavBUaLFAX3+z
X-Google-Smtp-Source: AHgI3Ia6Iyxfy8KNxmfQdj2SMj5LQedJxuyWfQFXIDEfnzyHkFSUjAw2KXoHABWC57paQGBVGyvbrw==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr3786208pgv.31.1549535683907;
        Thu, 07 Feb 2019 02:34:43 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d129sm21448919pfc.31.2019.02.07.02.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/21] diff.c: convert --output-*
Date:   Thu,  7 Feb 2019 17:33:17 +0700
Message-Id: <20190207103326.10693-13-pclouds@gmail.com>
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

This also validates that the user specifies a single character in
--output-indicator-*, not a string.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt | 10 +++++
 diff.c                         | 71 +++++++++++++++++++++++++---------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 058d93ec4f..d3e8d634b2 100644
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
2.20.1.682.gd5861c6d90

