Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77ED120248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCQMvA (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41092 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so9394331pfn.8
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIh9Ib98tZzaWSsmpSF2iVC4DUR7f6TqdjLe8hNarsE=;
        b=aisVHfK1hHAfFbbxPydnLkpkrbFaBqMNzKvMJijkJGkSk8k0jOKhtfAduDrOM4DLsX
         Uz1YOqi57eWg4UPQZNjIJ8BMiljJ89GEB2tOQjk1h2IzSLrfgirN2hK3d0QYmFuEIrzV
         3LKXBp6Qc67BpftBs736ckS6KaaRnzWWd1Plb8WvngC9JDYk9I0COeOX/ZGq4EW//qK0
         Oy4lQxuINHytR0122/TPXIJaDMJi82ZSHWL6oqqbtzDphjrcSU4TzFFsIZckD7HofEsL
         tYB2yo7oLqa1JKZOXGBcLFCguH6Em/ogcPpq7T86ptIM8LYvzV/+fUdz1cfeIeC/Mreh
         0PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIh9Ib98tZzaWSsmpSF2iVC4DUR7f6TqdjLe8hNarsE=;
        b=lftWjZKMKpddP2dNWo/dIL37DqGffUHGkjczZ3KF/JZ/vujBuyrbWmvAyWkHeueKNo
         pz3YM5G9FJjSofFYGzBLQZ7tj7QV+9QyctqBFHYvLCUlAo1itgnGBUAeFLtHtiFeScue
         +HSV5wBK/WzYZPADVm17GvLD2wkCONEOqWe5LpT0eBas2av8iRJ0gDnnJvsqU84S0VYv
         edqyU4jeEXIrEUPYY8GtBJVT5F2gq08JxccFtMpmrIjfPjHrfQgMeZvGPEKN9gEfQvL6
         zhLEEkZcjCSnVFwbJu6ww7eJTOlASmoNr1NvLb+f9ox4Kj1R3H5MT3uFlFDnZFgKQNlf
         N/tQ==
X-Gm-Message-State: APjAAAXDZkdcS5GddtXx0GV9O5Oa6DC99yN4XDDGtAfuQbuaj2sEqkiG
        06sgkwlU/xtojs3t7tahxRw=
X-Google-Smtp-Source: APXvYqyCtclTw2+qWWqNgGJNoB3iuNETlkHhNpY3SWDb3dPMZ1THcJU5BAMunSZkQLCruOP3rv9lig==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr901828pfo.90.1552827059291;
        Sun, 17 Mar 2019 05:50:59 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 23sm12262650pfn.2.2019.03.17.05.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 13/26] switch: better names for -b and -B
Date:   Sun, 17 Mar 2019 19:49:13 +0700
Message-Id: <20190317124926.17137-14-pclouds@gmail.com>
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

The shortcut of these options do not make much sense when used with
switch. And their descriptions are also tied to checkout. Move -b/-B
to cmd_checkout() and new -c/-C with the same functionality in
cmd_switch_branch()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index dd3c200cb5..400a0d5620 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1368,14 +1368,10 @@ static struct option *add_common_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-static struct option *add_switch_branch_options(struct checkout_opts *opts,
-						struct option *prevopts)
+static struct option *add_common_switch_branch_options(
+	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
-			   N_("create and checkout a new branch")),
-		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
-			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
@@ -1571,15 +1567,22 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option checkout_options[] = {
+		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+			   N_("create and checkout a new branch")),
+		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and checkout a branch")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
@@ -1592,14 +1595,21 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
 	struct option *options = NULL;
+	struct option switch_options[] = {
+		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
+		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and switch to a branch")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
 			    options, switch_branch_usage);
-- 
2.21.0.548.gd3c7d92dc2

