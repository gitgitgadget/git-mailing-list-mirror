Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DB020248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfCTLsi (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37109 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCTLsh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so1772441pfr.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TBATZcC9BN4zxj/mXAHdQlMKZmVPFPE1YF5xpIyEjjw=;
        b=P6frXlsD/p2h+4Z1YxW5np+pQsI4sc5k2ZMnK7kLvjsDbuGkToLY4SVR0Eo7CqRhKO
         XXJASX0pr2D1lL1Saw67KHxQPm1gGGJ59yE+wgwNzjg8Qgy2QWv6rs6GDT4ou/EA7EQH
         rZG0Q2Zsn6APsP1uHPFwprkYolAJNg1I6N30w+0zbmRSG4qo2fyhPGIm8F/yK8Jlhfr3
         lG1JGSYAMZKMYo/a9CT6lE5vlaKj9TWLF8644g9mDJoy1GEH5puQgEqy8luyTcs+Mj+y
         s/FIUN7HSGzEbCLf0vpALJOMRm9ld8CUPeMvgfBj7wOgDv48++Gv56kCGr7RT74NAbvR
         W/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TBATZcC9BN4zxj/mXAHdQlMKZmVPFPE1YF5xpIyEjjw=;
        b=ugaGQ6UlgUmyX3R+RSJYHgEAtUxod70bUJnh7uPq+JObdr3hpzO5lhhsS6/A0hCXNy
         Vg8W+E/eOC5ewR4mICgQaT23Qvix9KDFjdXO7dmkD2mxBjLKekeGp2h7XmuuLNopWFBg
         0b8jlOdnlFXnufcttKTlL3KUSRULnns2RruGD6aKhaIFk3VK37Lwdlb57WXgkQtDczti
         +On3aT9EyaLS5QVLhuCdHXghEpSjgYQzh1t4Mtpm9ufYGuTQwwqlx1DlyDQ9FYt7g618
         admZnNt9aBg9u6f/mQwUgvvBuKOwoC6uqnv+Y7wmD59te3TQNDxrdwsXzEw3+nrqs7YB
         qA+A==
X-Gm-Message-State: APjAAAV4OuVTEzIKrdAhpR2cllJIfFMhFvhCTce9jNby0zX7evrYtwMh
        8wJVQ66sc3awZtqNcmBKKFUQ6K6S
X-Google-Smtp-Source: APXvYqweyYSagxv6cMM1yZYFn0hAKEkj8T0hgQD9IfVB5lVyaxJEVTvCRxBMuAArEJEn/y4TOLJTOg==
X-Received: by 2002:a17:902:29aa:: with SMTP id h39mr7871226plb.190.1553082517256;
        Wed, 20 Mar 2019 04:48:37 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i126sm3704530pfc.101.2019.03.20.04.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/20] range-diff: use parse_options() instead of diff_opt_parse()
Date:   Wed, 20 Mar 2019 18:47:01 +0700
Message-Id: <20190320114703.18659-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff's internal option parsing is now done with 'struct option', which
makes it possible to combine all diff options to range-diff and parse
everything all at once. Parsing code becomes simpler, and we get a
looong 'git range-diff -h'

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/range-diff.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f01a0be851..784bd19321 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -16,42 +16,27 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	int simple_color = -1;
-	struct option options[] = {
+	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_END()
 	};
-	int i, j, res = 0;
+	struct option *options;
+	int res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	repo_diff_setup(the_repository, &diffopt);
 
+	options = parse_options_concat(range_diff_options, diffopt.parseopts);
 	argc = parse_options(argc, argv, NULL, options,
-			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
-
-	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
-		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+			     builtin_range_diff_usage, 0);
 
-		if (!c)
-			argv[j++] = argv[i++];
-		else
-			i += c;
-	}
-	while (i < argc)
-		argv[j++] = argv[i++];
-	argc = j;
 	diff_setup_done(&diffopt);
 
-	/* Make sure that there are no unparsed options */
-	argc = parse_options(argc, argv, NULL,
-			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
-			     builtin_range_diff_usage, 0);
-
 	/* force color when --dual-color was used */
 	if (!simple_color)
 		diffopt.use_color = 1;
@@ -90,6 +75,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		error(_("need two commit ranges"));
 		usage_with_options(builtin_range_diff_usage, options);
 	}
+	FREE_AND_NULL(options);
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
 			      simple_color < 1, &diffopt);
-- 
2.21.0.548.gd3c7d92dc2

