Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F19C1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfA0AgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39309 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AgN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so6369243pfc.6
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mi+TnwHoqRYCz/eHLC4xneuVI2CjzmuxZSv0E66l2O4=;
        b=iAX8YQY2bEL5T/EJVmWkVgZVZCiXUA8XIQBvgjnQLTv47y3g2QeO6fafOFeVtV4ewM
         Ty65arRA3g6UTfOVEd91oMy9Pbab7VyV+Bxm6nkKo24oQ+nkXIAcWXFROfVFq76fccwF
         PzgaVrRpI6ayPC7FPKLDazu6DxnIuzbPmQifjUNAkK+vLSCauYvjN02aD+StNxwkrWOP
         pqiuDiG34Jabe7usBp2cbS2C+d6R/ORPk1HTIASKV/zH863ULmtThFQv0Va49YoV16X6
         f7K7vHIBj/3XZtI4MpPT8P+Y1reaaujGSS8Cyk7i3dSAaeA8+s7Zqe3SIAIcjRYJlTq+
         yylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mi+TnwHoqRYCz/eHLC4xneuVI2CjzmuxZSv0E66l2O4=;
        b=lF7jODmuoj378dF9C5FmVcVZkvu9eZYPNaJ3EJgzlq1vlt4JmFZV8LrxVMwUFIGTol
         1aZ8K7DFKwiAcYj/pFpqBO5mJgGFQZEEWF0+xDZI0EbYpkHtBTdHI/XKWtA0O6lahtbF
         npFDA4aVvetbxWMlkzEIJSU6pmYfQnNZraIL90vj2cXQ+7x2zawviYsOeQ1B+z4jp/Pi
         9venGmjMYge99IXCjmqd/uHrSVly3AnMPyTg8K65NXqUpDzNU2XdjRU96VIf/DaGt6FE
         AxQpQf+EdD0H5fRdoXSYUDXYH5gelES48QlfxIuKoYEbC1o6aw5w1cakJJQGOEsA7L+q
         s5hg==
X-Gm-Message-State: AJcUukfc1t9WYSmneQ0ifzKSfsEp6KV18SvkpiHWsxsK5gFb5hyMvTK6
        VTwBWb8QgFxcPLeTn3rM3wNQfkdn
X-Google-Smtp-Source: ALg8bN6Vw026Hxp+EUyO8R07mQyphq8b2g9QKw3IzQpdHVHZ1peR8EDvc0ET61tYdVfDckdw1vERfA==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr14972545pgj.341.1548549372628;
        Sat, 26 Jan 2019 16:36:12 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m20sm31261526pgv.93.2019.01.26.16.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/14] parse-options: add one-shot mode
Date:   Sun, 27 Jan 2019 07:35:23 +0700
Message-Id: <20190127003535.28341-3-pclouds@gmail.com>
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

This is to help reimplement diff_opt_parse() using parse_options().
The behavior of parse_options() is changed to be the same as the
other:

- no argv0 in argv[], everything can be processed
- argv[] must not be updated, it's the caller's job to do that
- return the number of arguments processed
- leave all unknown options / non-options alone (this one can already
  be achieved with PARSE_OPT_KEEP_UNKNOWN and
  PARSE_OPT_STOP_AT_NON_OPTION)

This mode is NOT supposed to stay here for long. It's to help
converting diff/rev option parsing. Once that work is over and we can
just use parse_options() throughout the code base, this will be
deleted.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 26 ++++++++++++++++++++++----
 parse-options.h | 17 +++++++++++++----
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 9f84bacce6..740ae5438f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -416,15 +416,24 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 const struct option *options, int flags)
 {
 	memset(ctx, 0, sizeof(*ctx));
-	ctx->argc = ctx->total = argc - 1;
-	ctx->argv = argv + 1;
-	ctx->out  = argv;
+	ctx->argc = argc;
+	ctx->argv = argv;
+	if (!(flags & PARSE_OPT_ONE_SHOT)) {
+		ctx->argc--;
+		ctx->argv++;
+	}
+	ctx->total = ctx->argc;
+	ctx->out   = argv;
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
-	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
+	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
+	    !(flags & PARSE_OPT_ONE_SHOT))
 		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+	if ((flags & PARSE_OPT_ONE_SHOT) &&
+	    (flags & PARSE_OPT_KEEP_ARGV0))
+		BUG("Can't keep argv0 if you don't have it");
 	parse_options_check(options);
 }
 
@@ -536,6 +545,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	for (; ctx->argc; ctx->argc--, ctx->argv++) {
 		const char *arg = ctx->argv[0];
 
+		if (ctx->flags & PARSE_OPT_ONE_SHOT &&
+		    ctx->argc != ctx->total)
+			break;
+
 		if (*arg != '-' || !arg[1]) {
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
@@ -610,6 +623,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 		continue;
 unknown:
+		if (ctx->flags & PARSE_OPT_ONE_SHOT)
+			break;
 		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN))
 			return PARSE_OPT_UNKNOWN;
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
@@ -623,6 +638,9 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
 {
+	if (ctx->flags & PARSE_OPT_ONE_SHOT)
+		return ctx->total - ctx->argc;
+
 	MOVE_ARRAY(ctx->out + ctx->cpidx, ctx->argv, ctx->argc);
 	ctx->out[ctx->cpidx + ctx->argc] = NULL;
 	return ctx->cpidx + ctx->argc;
diff --git a/parse-options.h b/parse-options.h
index f5e7ec7d23..d663b83973 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -27,7 +27,8 @@ enum parse_opt_flags {
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 	PARSE_OPT_KEEP_ARGV0 = 4,
 	PARSE_OPT_KEEP_UNKNOWN = 8,
-	PARSE_OPT_NO_INTERNAL_HELP = 16
+	PARSE_OPT_NO_INTERNAL_HELP = 16,
+	PARSE_OPT_ONE_SHOT = 32
 };
 
 enum parse_opt_option_flags {
@@ -169,10 +170,18 @@ struct option {
 	  N_("no-op (backward compatibility)"),		\
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
 
-/* parse_options() will filter out the processed options and leave the
- * non-option arguments in argv[]. usagestr strings should be marked
- * for translation with N_().
+/*
+ * parse_options() will filter out the processed options and leave the
+ * non-option arguments in argv[]. argv0 is assumed program name and
+ * skipped.
+ *
+ * usagestr strings should be marked for translation with N_().
+ *
  * Returns the number of arguments left in argv[].
+ *
+ * In one-shot mode, argv0 is not a program name, argv[] is left
+ * untouched and parse_options() returns the number of options
+ * processed.
  */
 int parse_options(int argc, const char **argv, const char *prefix,
 		  const struct option *options,
-- 
2.20.1.560.g70ca8b83ee

