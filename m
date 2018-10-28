Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089741F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeJ1Pf7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34828 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1Pf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so3739145lfi.2
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hfx0wHo+aJ95DheRDp+HrVz7WyEbzRBR3cUux7hu0I4=;
        b=lK//xKM7MoRPvNvHu80+CuCufCdzGk52QFj5klhf+n60cbsV6O2QwIl4NSO4v0dubD
         /higWU2qWifX+BQhUwHU0RzeLsiGLyFothDSHhna5ydgwPr65KH3ImG6AnSz9Gn2toT/
         1na+kFSkcGc/ZNm+UcxSfkgx9fF6Hdr/PpRx0ZYKeK5h7/YgOkqsX2elRDW0l8EKgrHx
         FAVbpTJVr4I72f0nZHnlDJTsphMksW4wOoNRuLUF8nUE1C6lkhLjbG787dTdalRaddcJ
         IR8iLhnUTBqguRXZ04qcxZgvop+1D71uzeG7WLQdROazkww5fbZZON/BjirsyXpqjH8e
         jLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hfx0wHo+aJ95DheRDp+HrVz7WyEbzRBR3cUux7hu0I4=;
        b=bl2XMaKZ3KTDH22Coo/g0WRiTuNrTWRjMmK+XzlFAzKIOM12FgIJRfGYpYzkLJpBKi
         ZAZBKhCcoidphUnpeEV5J67nVvGDQDyCkiemIbeUa+KwTk6Hzt6n3l1M1pBDWqrmvWzR
         On+nBYS5ch24wZc9mYj4C35AbNYJfQ7kH/8juYNLKS70t1pFyFlcwXTGc4DPQahOzIFu
         QM/NcfkPlRdqj+P/trc522Mhu1N6mLw8OIYtxe4Jotalx9V5u958DkXT1gTY2MAX0wCf
         6ocaC7YFQBZJnp6jZ1H4jkvF2yK3OGmqfErZJr/Xz5G8YeUantIlpjTs57d2258eh53f
         QPEQ==
X-Gm-Message-State: AGRZ1gJEn4T+YcUw3TLd+8i78flt1wfgnl3ggyD8iF9FnKnZqxE+xGs+
        eMRZ2RgJlsaL0Cc2d2of3krHE3iI
X-Google-Smtp-Source: AJdET5f2FWqLTVLdTjvoxu+g5mdNTArwCoSxXqaRSa8jVuEJe6CbXqIAnMuP8bouXmpJTWmbKFbZlw==
X-Received: by 2002:a19:59d3:: with SMTP id n202-v6mr5456397lfb.125.1540709534120;
        Sat, 27 Oct 2018 23:52:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/12] parse-options.c: mark more strings for translation
Date:   Sun, 28 Oct 2018 07:51:56 +0100
Message-Id: <20181028065157.26727-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c          | 18 +++++++++---------
 t/t0040-parse-options.sh |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0bf817193d..949aac287f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -197,7 +197,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	default:
-		die("should not happen, someone must be hit on the forehead");
+		BUG("opt->type %d should not happen, someone must be hit on the forehead", opt->type);
 	}
 }
 
@@ -319,8 +319,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 	}
 
 	if (ambiguous_option) {
-		error("Ambiguous option: %s "
-			"(could be --%s%s or --%s%s)",
+		error(_("ambiguous option: %s "
+			"(could be --%s%s or --%s%s)"),
 			arg,
 			(ambiguous_flags & OPT_UNSET) ?  "no-" : "",
 			ambiguous_option->long_name,
@@ -353,7 +353,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (starts_with(arg, "no-")) {
-		error ("did you mean `--%s` (with two dashes ?)", arg);
+		error(_("did you mean `--%s` (with two dashes ?)"), arg);
 		exit(129);
 	}
 
@@ -361,7 +361,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (starts_with(options->long_name, arg)) {
-			error ("did you mean `--%s` (with two dashes ?)", arg);
+			error(_("did you mean `--%s` (with two dashes ?)"), arg);
 			exit(129);
 		}
 	}
@@ -424,7 +424,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->flags = flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
-		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	parse_options_check(options);
 }
 
@@ -644,11 +644,11 @@ int parse_options(int argc, const char **argv, const char *prefix,
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
 		if (ctx.argv[0][1] == '-') {
-			error("unknown option `%s'", ctx.argv[0] + 2);
+			error(_("unknown option `%s'"), ctx.argv[0] + 2);
 		} else if (isascii(*ctx.opt)) {
-			error("unknown switch `%c'", *ctx.opt);
+			error(_("unknown switch `%c'"), *ctx.opt);
 		} else {
-			error("unknown non-ascii option in string: `%s'",
+			error(_("unknown non-ascii option in string: `%s'"),
 			      ctx.argv[0]);
 		}
 		usage_with_options(usagestr, options);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 17d0c18feb..e46b1e02f0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -228,7 +228,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	test_must_fail test-tool parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
-	test_cmp typo.err output.err
+	test_i18ncmp typo.err output.err
 '
 
 cat >typo.err <<\EOF
@@ -238,7 +238,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	test_must_fail test-tool parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
-	test_cmp typo.err output.err
+	test_i18ncmp typo.err output.err
 '
 
 test_expect_success 'keep some options as arguments' '
-- 
2.19.1.647.g708186aaf9

