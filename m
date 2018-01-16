Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA471F406
	for <e@80x24.org>; Tue, 16 Jan 2018 10:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeAPKhV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 05:37:21 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34631 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeAPKhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 05:37:19 -0500
Received: by mail-pl0-f65.google.com with SMTP id d21so5806516pll.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 02:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/TuP05fmg708vCTb142Um72yzzKVGB//UnsXNKSrTE=;
        b=n2Ag1IzlD9M0SpZ9omm36Yi287U8Udmr0lVdcgkjC9MYeJpA2bgmB0Z/DZlvvu7aRh
         Iu7stye9rlyN9RIWcM45xoIRb/3WpBaDun7sAufj4bIm/dj1PU7K95i3K7QB1+5ed/94
         DotI9TZV6C0DZeloNbCxJopj+cx1dAbSrR20K5ecVJQ+6f4GJr07wLSl/Uu+IuYNEav/
         spxpxqFc/vJedCipN19Jdjf1kkDkOqZO1lzqTAlzZ+TmDDmYobV44GS97lbj44NnlzIJ
         58+IZLXdTU+F4gTe9CzCFE1XCJ6ddHvPHduEjykO5YkcgPhi+H5M3KlgGGqftbPYhnbX
         M5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/TuP05fmg708vCTb142Um72yzzKVGB//UnsXNKSrTE=;
        b=IbiMFrcYjXjTm9nz0sxBYybfM1OikXdLM1Cw412r5bgXyRr3T+4rj3oFECVXCWuT5j
         lCBM88eOFSqcWcNK6wR1l41+wIy3SrbPIfDCBgZeYXHshnoJ3KDK+Y8NYY+gcKD1vg9n
         6yJhN1evk72vQSxacq3r91dAkrm2ULnrtWORHM7c9usCO6kLEsn2J9hJiqku0s5XdBue
         cH1N0+qrS60mHTqyfeoeDLYYqDEj2ZbJNxTiIcaSvy0bzI/zA/UGxb/P8sQhRqjI3Ipn
         /QhwglIjrwL+O50LSPiLduoStdJd6RVg7hSJ74c5LqShTwZkU0kjy2Qj0SmnOyYkjKYw
         gn7g==
X-Gm-Message-State: AKwxytehrr63sZs2N7YH07Qw39h7DWwDVDrGChaw7RAhqJv2JPHaTpVL
        /ZgRJkWpLw+4vP6LdDVeY5d5kA==
X-Google-Smtp-Source: ACJfBovzfnRTwlKBMITvOo7kg+EhaXBsB7+yFU8zZuPMBBzHQv+9qTiAYjvVswZnZLf6ACbnHCJ1rw==
X-Received: by 10.84.229.68 with SMTP id d4mr9522512pln.117.1516099037717;
        Tue, 16 Jan 2018 02:37:17 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id j29sm3137290pgn.47.2018.01.16.02.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 02:37:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Jan 2018 17:37:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] parse-options: support --git-completion-helper
Date:   Tue, 16 Jan 2018 17:36:59 +0700
Message-Id: <20180116103700.4505-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180116103700.4505-1-pclouds@gmail.com>
References: <20180116103700.4505-1-pclouds@gmail.com>
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
options could be hidden with the new "NO_GITCOMP" flag.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 37 +++++++++++++++++++++++++++++++++++++
 parse-options.h |  6 ++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index fca7159646..6c542f44cf 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -425,6 +425,35 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
+static int show_gitcomp(struct parse_opt_ctx_t *ctx, const struct option *opts)
+{
+	for (; opts->type != OPTION_END; opts++) {
+		const char *suffix;
+
+		if (!opts->long_name)
+			continue;
+		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NO_GITCOMP))
+			continue;
+
+		switch (opts->type) {
+		case OPTION_GROUP:
+			continue;
+		case OPTION_STRING:
+		case OPTION_FILENAME:
+		case OPTION_INTEGER:
+		case OPTION_MAGNITUDE:
+			if (!(opts->flags & PARSE_OPT_OPTARG))
+				suffix = "=";
+			break;
+		default:
+			suffix = "";
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
@@ -434,6 +463,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const char * const usagestr[])
 {
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
+	int internal_gitcomp = !(ctx->flags & PARSE_OPT_NO_INTERNAL_GITCOMP);
 	int err = 0;
 
 	/* we must reset ->opt, unknown short option leave it dangling */
@@ -455,6 +485,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
 			goto show_usage;
 
+		/* lone --git-completion-helper is asked by git-completion.bash */
+		if (internal_gitcomp && ctx->total == 1 &&
+		    !strcmp(arg + 1, "-git-completion-helper"))
+			goto show_git_comp;
+
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
 			switch (parse_short_opt(ctx, options)) {
@@ -521,6 +556,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 	err = 1;
  show_usage:
 	return usage_with_options_internal(ctx, usagestr, options, 0, err);
+ show_git_comp:
+	return show_gitcomp(ctx, options);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
diff --git a/parse-options.h b/parse-options.h
index af711227ae..8a3389b05b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -27,7 +27,8 @@ enum parse_opt_flags {
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 	PARSE_OPT_KEEP_ARGV0 = 4,
 	PARSE_OPT_KEEP_UNKNOWN = 8,
-	PARSE_OPT_NO_INTERNAL_HELP = 16
+	PARSE_OPT_NO_INTERNAL_HELP = 16,
+	PARSE_OPT_NO_INTERNAL_GITCOMP = 32
 };
 
 enum parse_opt_option_flags {
@@ -38,7 +39,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256
+	PARSE_OPT_SHELL_EVAL = 256,
+	PARSE_OPT_NO_GITCOMP = 512
 };
 
 struct option;
-- 
2.15.1.600.g899a5f85c6

