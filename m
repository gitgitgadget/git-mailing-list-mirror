Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFF620248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfCQMvT (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so9501844pgp.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6mr7mNF7iYUXLUxjMPdHq9oyfx7Y+2w1evcDMpNS7M=;
        b=L6RtAH6QeBaFuFiivyJcOVFx/uUUSYEL/ib+kzTZbQDjeYAp5ZtCDWuB8OeZbCafvf
         NAm3e6MqYBc/nuDUjAvQQnpQP43hU030kDUqPaMzlly+ADS8JuqxfvroUaQlDzOyEQQj
         xJObb/j6LbUTK6Y2PcGa3ewni3dWDu9M3HiuLJYxCeocdaoMlEa7QNXkbxrd9vPqC+11
         N7AmpzTdJFwFoonQv6rFRfeV0JTBUjKWV3pvAwSugl5zSY0EJAQ5JSL8hbH/fU3dEuVR
         WQ5vncAuzDWaHmcA+RgcQy7igP7NfY17waSt74VIBQTk3gzjSaiv68R3ND5mU3xumrgt
         Ed3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6mr7mNF7iYUXLUxjMPdHq9oyfx7Y+2w1evcDMpNS7M=;
        b=TErlFqSSsXPLpRWbugWp5lLQ7Qhp0909e58C/k+/1WDSGL6P8xYrGhj2dnPV4stjO1
         0JL6JP0eCKN4HFqYirBMv/IWTPXT6Uvc6nZ1lgfnhymtAZzJ1wPr06PXb6+tREkXJsNr
         9NX1YpG/xV791c2vnItOEcQ4QERHw5R+71TdZR06Df6UeVQegqqsMSdDsU0KAYR0Ft+I
         UUZD/e1Ul5BPeXBkwFekZSqWa8AlOEMk+Mai7Rc3AKZBalr4KBRwFlw7P2EjaRFVbxLr
         Sd3e5RnOAZkhL1UVutHfIcPK1rd3Z01LW4gbOIH6NyjbI4yJXaJoyAOhSvEYggD76acW
         3+LQ==
X-Gm-Message-State: APjAAAUpGDDfLZtOiaoVywuhjDUZkuU9qA6xV+aOzYOX89XLcEgXqsf6
        HhB05TRd5mPXQu00iqQYhco=
X-Google-Smtp-Source: APXvYqyTMvgYIdyK47GfWtYeWNpiulVWmXYJGSy6YypR8qURph5zw8yxdhHrwMIw/x2YhJVPLQClWw==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2mr14570201pls.65.1552827077885;
        Sun, 17 Mar 2019 05:51:17 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id j6sm13394102pfe.79.2019.03.17.05.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:11 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 16/26] switch: stop accepting pathspec
Date:   Sun, 17 Mar 2019 19:49:16 +0700
Message-Id: <20190317124926.17137-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
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
index 85fc60f5f2..2c4cab6406 100644
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
2.21.0.548.gd3c7d92dc2

