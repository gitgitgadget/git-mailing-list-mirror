Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FEF1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfA0Agm (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0Agl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so5681258pgq.8
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8NtUzn6U8ttA/Z0NNmJcw4ThCxA2iYJCOa2CongQNI=;
        b=svoegjkMSl8iWjwcQvWo39NTAx256dLGhzAZSguj43ls1lK2MFPfUB7p6Am8hXPx/u
         2HRX964qvx71XSQCUKrKizj79QXKduXTyPjhRO6O5zc3qXC427HPwGD0iR6Mm8XJrqwc
         MTSoHHFy1OD+r9ZIR/ZY/j92QvQ+44wPnO25PbtPQo1KF2xU8O60AJHnF7qB1Ri8D385
         hd6P+DVptRAKdonwWjh1bULG2mS6loExx6u88aTi/W4fuSU1UE5KbYZrqB/qA0LMYLow
         IQ61Q7NSY6bQ1zhQORpK8IX0u66r7U+SW1VXDvsdL2Iudbgdk1Kc0yqyl/pWzXYWEbfP
         AokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8NtUzn6U8ttA/Z0NNmJcw4ThCxA2iYJCOa2CongQNI=;
        b=I5R/4iPAXQNDV5bBmJdLkSai5/EAFA+oN7JygJS9CvtENBMOlpllGCXTX4s7K/EprT
         TjEZnJjMEAMJfEVWh8pYFPv1HwfHgFkuQ1KAybpW37kaaD9LkXmzwc5lwBQyjtVmgEf6
         A7kcwEu1S9tQDLLMk5fyQITWKrg24LltjwO982iYcFPB/laEzxXSRN0HgQ8acwm3x3ec
         3dX55aYFvIdY67/F62pCgTT3JJOdGcA0jZ9n3VW+dBbmSo7cjUc/DtdZPzOLBODKBQwp
         /jynobI7RVEKgabheDvQDqnhZD74E/e+Ts/e6k6fnnRg7wbvu5/OP9j5xszTiUGVfTlo
         X97g==
X-Gm-Message-State: AJcUukeEFuCOs3QId+yQALFqMFl7ktEGTQ8OTZ7/p4g75EizErRr8Qqc
        0laXsu1+3eKAPGQqovMCHflMJ2sm
X-Google-Smtp-Source: ALg8bN6VVGyAj2ybyo8DP8dBm9AiuvWmTeTTFGiZ2r71nXh2BgKeH90wr8SAUBUEXpNea/wm9ygFxg==
X-Received: by 2002:a62:5f07:: with SMTP id t7mr16547426pfb.108.1548549400790;
        Sat, 26 Jan 2019 16:36:40 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 12sm36426367pgt.33.2019.01.26.16.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/14] parse-options: allow ll_callback with OPTION_CALLBACK
Date:   Sun, 27 Jan 2019 07:35:28 +0700
Message-Id: <20190127003535.28341-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OPTION_CALLBACK is much simpler/safer to use, but parse_opt_cb does
not allow access to parse_opt_ctx_t, which sometimes is useful
(e.g. to obtain the prefix).

Extending parse_opt_cb to take parse_opt_cb could result in a lot of
changes. Instead let's just allow ll_callback to be used with
OPTION_CALLBACK. The user will have to be careful, not to change
anything in ctx, or return wrong result code. But that's the price for
ll_callback.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c        |  2 ++
 builtin/update-index.c | 20 +++++++++++++++-----
 parse-options-cb.c     |  4 +++-
 parse-options.c        | 42 ++++++++++++++++++++++++++++--------------
 parse-options.h        |  5 +++--
 5 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index de64d7850e..563a16f38a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -114,11 +114,13 @@ static int option_parse_message(const struct option *opt,
 
 static enum parse_opt_result option_read_message(struct parse_opt_ctx_t *ctx,
 						 const struct option *opt,
+						 const char *arg_not_used,
 						 int unset)
 {
 	struct strbuf *buf = opt->value;
 	const char *arg;
 
+	BUG_ON_OPT_ARG(arg_not_used);
 	if (unset)
 		BUG("-F cannot be negated");
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 21c84e5590..7abde20169 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -848,13 +848,15 @@ static int parse_new_style_cacheinfo(const char *arg,
 }
 
 static enum parse_opt_result cacheinfo_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	struct object_id oid;
 	unsigned int mode;
 	const char *path;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
 		if (add_cacheinfo(mode, &oid, path, 0))
@@ -874,11 +876,13 @@ static enum parse_opt_result cacheinfo_callback(
 }
 
 static enum parse_opt_result stdin_cacheinfo_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *nul_term_line = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
@@ -888,11 +892,13 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 }
 
 static enum parse_opt_result stdin_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *read_from_stdin = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
@@ -901,12 +907,14 @@ static enum parse_opt_result stdin_callback(
 }
 
 static enum parse_opt_result unresolve_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
@@ -920,12 +928,14 @@ static enum parse_opt_result unresolve_callback(
 }
 
 static enum parse_opt_result reupdate_callback(
-	struct parse_opt_ctx_t *ctx, const struct option *opt, int unset)
+	struct parse_opt_ctx_t *ctx, const struct option *opt,
+	const char *arg, int unset)
 {
 	int *has_errors = opt->value;
 	const char *prefix = startup_info->prefix;
 
 	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
 	setup_work_tree();
diff --git a/parse-options-cb.c b/parse-options-cb.c
index ec01ef722b..2733393546 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -171,8 +171,10 @@ int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
  * parse_options().
  */
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
-					   const struct option *opt, int unset)
+					   const struct option *opt,
+					   const char *arg, int unset)
 {
+	BUG_ON_OPT_ARG(arg);
 	return PARSE_OPT_UNKNOWN;
 }
 
diff --git a/parse-options.c b/parse-options.c
index 50c340474c..cec74522e5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -95,7 +95,7 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 
 	switch (opt->type) {
 	case OPTION_LOWLEVEL_CALLBACK:
-		return opt->ll_callback(p, opt, unset);
+		return opt->ll_callback(p, opt, NULL, unset);
 
 	case OPTION_BIT:
 		if (unset)
@@ -161,16 +161,27 @@ static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
 		return err;
 
 	case OPTION_CALLBACK:
+	{
+		const char *p_arg = NULL;
+		int p_unset;
+
 		if (unset)
-			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
-		if (opt->flags & PARSE_OPT_NOARG)
-			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
-		if (get_arg(p, opt, flags, &arg))
+			p_unset = 1;
+		else if (opt->flags & PARSE_OPT_NOARG)
+			p_unset = 0;
+		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+			p_unset = 0;
+		else if (get_arg(p, opt, flags, &arg))
 			return -1;
-		return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
-
+		else {
+			p_unset = 0;
+			p_arg = arg;
+		}
+		if (opt->callback)
+			return (*opt->callback)(opt, p_arg, p_unset) ? (-1) : 0;
+		else
+			return (*opt->ll_callback)(p, opt, p_arg, p_unset);
+	}
 	case OPTION_INTEGER:
 		if (unset) {
 			*(int *)opt->value = 0;
@@ -238,7 +249,10 @@ static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
 			len++;
 		arg = xmemdupz(p->opt, len);
 		p->opt = p->opt[len] ? p->opt + len : NULL;
-		rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
+		if (numopt->callback)
+			rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
+		else
+			rc = (*numopt->ll_callback)(p, numopt, arg, 0);
 		free(arg);
 		return rc;
 	}
@@ -414,10 +428,10 @@ static void parse_options_check(const struct option *opts)
 				err |= optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
-			if (!opts->callback)
-				BUG("OPTION_CALLBACK needs a callback");
-			if (opts->ll_callback)
-				BUG("OPTION_CALLBACK needs no ll_callback");
+			if (!opts->callback && !opts->ll_callback)
+				BUG("OPTION_CALLBACK needs one callback");
+			if (opts->callback && opts->ll_callback)
+				BUG("OPTION_CALLBACK can't have two callbacks");
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
 			if (!opts->ll_callback)
diff --git a/parse-options.h b/parse-options.h
index 4e49185027..ce75278804 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -50,7 +50,8 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
 struct parse_opt_ctx_t;
 typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
-					      const struct option *opt, int unset);
+					      const struct option *opt,
+					      const char *arg, int unset);
 
 /*
  * `type`::
@@ -267,7 +268,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
-int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, int);
+int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 
-- 
2.20.1.560.g70ca8b83ee

