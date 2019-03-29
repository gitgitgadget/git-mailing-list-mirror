Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A391D20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfC2Klf (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44325 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfC2Klf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so1019908pgj.11
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F58eeXPHDX6JWVzQMW6NVTpmaLcUiVLjVqUt//F0Bog=;
        b=sF/61tf9uwjZgEXGTJwK3gywi8Wc50TF03SiCvEZYXDDIw3yMi7pb2jW6c8u5BERvP
         mM737/CkN/MdVxSqhK1x3UiZ6toy098iolIGqk6VXzda/+IANuEo/sAkJZLInuOdgecY
         DJtXwJ8xGn2/XV2B3XCcDGYdkrHPIUFPRiKAgLoOUj/PkROXXHrW4/mZX8z7MOrgevan
         KcNNbdyKSpATdj34qMhlhUocdA+9Pc9VybkPSWGAaWkxbcLQ8x8meEuJdQkWdhGMd6UA
         OIMgEdybhFK4S2RpfqGQypS/4El44cQyPIS8WziUKUGB/h+qpD0gPoJeVSbsnQ+ZsL6o
         gUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F58eeXPHDX6JWVzQMW6NVTpmaLcUiVLjVqUt//F0Bog=;
        b=GNni2AaGr6eYSWEdCsefqF5H7JHqpa+ECk8ae8fHjDUOPmNpROsuhwK6xJZaLgpBV1
         zntE3COn8pHIzDWsoIY3Whe/uA2mqemEiEMFN2i36WjP1zbAX2kZSXDG9OkVQ7R3pQmX
         q8cHsiSpVbdkR2JzI22jmne9H7GfAqPz5ZK+97krd/RF67q/vTzsGEMTQJU4kuOvT1kq
         gMsC//L4lXrmafWJTTuR5XIHq1Kw3SJ83QmlIiSyhO0tEvjNWRwjf6/2/tMc4rOeCO0P
         uP7yFGqfQg9LTrBmusTJF3VpGpQkPMpPraaR0uulLOrSN517ireOUEFqjf8tNaHhAel3
         iMiA==
X-Gm-Message-State: APjAAAV6tcanbRd8Z9p4wyXRyTsXhLncccHBfD4iArQRx2mohWNM51/Q
        R/R8PyhPrUGUPb01X0Yblbc=
X-Google-Smtp-Source: APXvYqx0OdZghXNg0976dkEULJCjHl/4nmHvE/c0zaX29s5CXRh/66OhOnrypTWy/RSheQF9/TARyA==
X-Received: by 2002:a63:2b41:: with SMTP id r62mr3543649pgr.403.1553856094845;
        Fri, 29 Mar 2019 03:41:34 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id f192sm2865757pfc.180.2019.03.29.03.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 17/27] switch: stop accepting pathspec
Date:   Fri, 29 Mar 2019 17:39:09 +0700
Message-Id: <20190329103919.15642-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
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
index d63116b686..0584dc484d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -54,6 +54,7 @@ struct checkout_opts {
 	int overlay_mode;
 	int no_dwim_new_local_branch;
 	int discard_changes;
+	int accept_pathspec;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1176,10 +1177,16 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1213,11 +1220,12 @@ static int parse_branchname_arg(int argc, const char **argv,
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
@@ -1262,7 +1270,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		if (argc)
 			verify_non_filename(opts->prefix, arg);
-	} else {
+	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
 		argc--;
@@ -1585,6 +1593,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1614,6 +1623,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.479.g47ac719cd3

