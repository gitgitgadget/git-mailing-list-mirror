Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85E61F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfBHJFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36170 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfBHJFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so1319295pgm.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GAOB9CM0amlSfcvnmP2lwCXYP1jCHLdLlJhKiejyR8=;
        b=cZkscH/CU1F3DYr+pzrOeiq6v2X5BHmOqp8eWnNz6Cit1OyL3PqrrWPQUhgtc0j8/V
         fOb2mKmwL7/ETw8Aqvi+g4e/XSfaI5PU6mINFUVIZBVAGjpfM3L6b+O+Bp7LPzubOPnF
         EUNhTpL1d7L66Z6tqaSm68N+Yz6xlJvVAKW4kk3gSPWGLfATE2vb1PZsdXkElaLcvQro
         GElQGny/pKUf/SQSDc6Kv0jCy0vD7xCd0N8o7DYWr0wdkKiElwKt5YShJ8eXT08fAkHV
         irf4+mOo/zFLhD1Noq6Xo4T0SXuMUoCeAd+grvzXdGltC7d3KMNY/9oUb/7bD4gHe7OX
         BVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GAOB9CM0amlSfcvnmP2lwCXYP1jCHLdLlJhKiejyR8=;
        b=rvLiTufPaxRVWnLqLokX2Tx6mrsVFN4cW9ANt5IahVwm2QFoPylojnd9l1wjkKYg8A
         JQEJ9HNdGgKa7Xw9jMlOt4L9VWz4+u6e72C6rjaUSPBGtjiX36X+vj8rC+xRnAtSBC9P
         xugdnAC0WWdhGnFZVBNisHuo+/TCxgkrNffPhOObK4lmbOReZ2FdGoU/+j/1IderNGG9
         syT+haxe/IdbhFz5FDAw3oXgl94FxVS5Clb6g4zhNmIzvlJNnl0wRiS26SLwL1Q8eojc
         XrtjXsKt5Aig0QOJuDnveZTlbu6wAkA1oOI+v6B8P4M46iU0M+L/qZ7tjwaeC0Un8WZA
         g26Q==
X-Gm-Message-State: AHQUAua5gsIA763yoVUYIIkbhZ6lux33qdb5nmPuVZqnoueM25KGypxz
        7wuvr5JrL004yx/q0MA7Qx0=
X-Google-Smtp-Source: AHgI3IbK2IJBghEXEYMUoKEdzjKF69h6W+BoqVDmYKha3KgpzBXUQlb30QTTo5wXGb3of8PORRfjzQ==
X-Received: by 2002:a65:6151:: with SMTP id o17mr2074670pgv.285.1549616724492;
        Fri, 08 Feb 2019 01:05:24 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y21sm93027pfi.150.2019.02.08.01.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/19] switch: stop accepting pathspec
Date:   Fri,  8 Feb 2019 16:03:53 +0700
Message-Id: <20190208090401.14793-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is about switching branch (or creating a new one) and
should not accept pathspec. This helps simplify ambiguation
handling. The other two ("git checkout" and "git restore") of
course do accept pathspec as before.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f7d8fa7caa..4822d5c5d7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -52,6 +52,7 @@ struct checkout_opts {
 	int count_checkout_paths;
 	int overlay_mode;
 	int no_dwim_new_local_branch;
+	int accept_pathspec;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1162,10 +1163,16 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!argc)
 		return 0;
 
+	if (!opts->accept_pathspec) {
+		if (argc > 1)
+			die(_("only one reference expected"));
+		has_dash_dash = 1; /* helps disambiguate */
+	}
+
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
@@ -1199,11 +1206,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		/*
-		 * Accept "git checkout foo" and "git checkout foo --"
-		 * as candidates for dwim.
+		 * Accept "git checkout foo", "git checkout foo --"
+		 * and "git switch foo" as candidates for dwim.
 		 */
 		if (!(argc == 1 && !has_dash_dash) &&
-		    !(argc == 2 && has_dash_dash))
+		    !(argc == 2 && has_dash_dash) &&
+		    opts->accept_pathspec)
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
@@ -1248,7 +1256,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		if (argc)
 			verify_non_filename(opts->prefix, arg);
-	} else {
+	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
 		argc--;
@@ -1564,6 +1572,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1591,6 +1600,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.1.682.gd5861c6d90

