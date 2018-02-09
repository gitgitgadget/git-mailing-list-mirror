Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9571F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeBILCn (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:02:43 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34266 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeBILCm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:02:42 -0500
Received: by mail-pl0-f66.google.com with SMTP id q17so1324438pll.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A9ro4kRFsaP1bZ+MU39cLbcvhKUsdBsoByDBJTp/Q8s=;
        b=IPhhWBFKLc2iHSsMyjouXQn7ZJ+TRqK75QcNZh6YfH1G5oG/caX9WiA8RKCV0OzYvM
         mklp0cTPp3JBRgPW9dEP6ZP0zISkINlJb6Hy4W1pqSPZTjlIVuQT40QuxmTQqDb9TTIU
         z/kmVdOX50hyBwOglwtKZjS4017Y1Upu+JYIARhuJvPaxr+JEpvVV6QjL/Ua0SUoTnr6
         RHu0yaZzjAsDDmD7YQmp4zcInwozqjKnYqmYErzIt2jBz/M9m1AXwUKblBg5eiydOlZ/
         06TXyX8T6VZR3ed7xi5FgQF92/XJidKYsi8m+RkVJ8racDnTjFvRwGwOWPlo+8n9GxKA
         ntBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A9ro4kRFsaP1bZ+MU39cLbcvhKUsdBsoByDBJTp/Q8s=;
        b=fatPCL5Qiusorxf9tdkwlsIojX1IC/T56QW6VgtbaDaXlwpfThWEz4eDrvHAF8Aca5
         x5uhYf6FMmmHMIZ+SWKSQSsDXy5CwZDLqz19FaP77JQI2e2Pal65H6o0XiN0yMVaYYQU
         ThvRMiRb8+92woXOKgmudYyyxcxf3FR86VXdA6UvDcXgBsZX5xnIJTaS9okdiTUcGOMA
         fbARB+EHHFhq7XmdHNpS/3ek7LtbZMQfKg9OTwe3d4fF2wOSAfZL69dZv9AkojnABPOE
         /2xJGTVlyBiCFFuLWTDYfX6uilAGGqwyF0IBAm42rp0h4PSxDalejWitXSz3cFlfb3z4
         bTVw==
X-Gm-Message-State: APf1xPCXb3/Fnc5j8BN9bZnr06w2xq6OemsG0mEvdOcw79dG4w4jkJbT
        O4xMSSaWUryBsyJIwPu4mmtUew==
X-Google-Smtp-Source: AH8x2268eQc9rVUhNbMXhOxNcf/tgCCZ2n1pcg/DqV42OxWqCUqNNFjs7nhd0OWDFd9ioxaevXDV5g==
X-Received: by 2002:a17:902:6d09:: with SMTP id s9-v6mr2250983plk.176.1518174161616;
        Fri, 09 Feb 2018 03:02:41 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id g2sm4659951pgq.43.2018.02.09.03.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:02:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:02:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 01/42] parse-options: support --git-completion-helper
Date:   Fri,  9 Feb 2018 18:01:40 +0700
Message-Id: <20180209110221.27224-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is designed to be used by git-completion.bash. For many
simple cases, what we do in there is usually

    __gitcomp "lots of completion options"

which has to be manually updated when a new user-visible option is
added. With support from parse-options, we can write

    __gitcomp "$(git command --git-completion-helper)"

and get that list directly from the parser for free. Dangerous/Unpopular
options could be hidden with the new "NOCOMPLETE" flag.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 parse-options.h |  5 ++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index fca7159646..29f4defdd6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -425,6 +425,46 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
+/*
+ * TODO: we are not completing the --no-XXX form yet because there are
+ * many options that do not suppress it properly.
+ */
+static int show_gitcomp(struct parse_opt_ctx_t *ctx,
+			const struct option *opts)
+{
+	for (; opts->type != OPTION_END; opts++) {
+		const char *suffix = "";
+
+		if (!opts->long_name)
+			continue;
+		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+			continue;
+
+		switch (opts->type) {
+		case OPTION_GROUP:
+			continue;
+		case OPTION_STRING:
+		case OPTION_FILENAME:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+		case OPTION_CALLBACK:
+			if (opts->flags & PARSE_OPT_NOARG)
+				break;
+			if (opts->flags & PARSE_OPT_OPTARG)
+				break;
+			if (opts->flags & PARSE_OPT_LASTARG_DEFAULT)
+				break;
+			suffix = "=";
+			break;
+		default:
+			break;
+		}
+		printf(" --%s%s", opts->long_name, suffix);
+	}
+	fputc('\n', stdout);
+	exit(0);
+}
+
 static int usage_with_options_internal(struct parse_opt_ctx_t *,
 				       const char * const *,
 				       const struct option *, int, int);
@@ -455,6 +495,10 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
 			goto show_usage;
 
+		/* lone --git-completion-helper is asked by git-completion.bash */
+		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
+			return show_gitcomp(ctx, options);
+
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
diff --git a/parse-options.h b/parse-options.h
index af711227ae..a5caa0bb1d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -38,7 +38,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256
+	PARSE_OPT_SHELL_EVAL = 256,
+	PARSE_OPT_NOCOMPLETE = 512
 };
 
 struct option;
@@ -89,6 +90,8 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
+ *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
+ *			   by git-completion.bash. This option suppresses that.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK or
-- 
2.16.1.207.gedba492059

