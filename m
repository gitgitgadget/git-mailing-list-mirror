Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E144C20248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCQMul (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:50:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32843 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMul (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:50:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so9424376pfd.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TP1E4MNaDr37ejKWhM68QxCPE84ouBd1MxbFAPpDSP8=;
        b=WoJUf4Eqapn4T/ardj8wNFPGpahijxL2Jy+uQtN6VyuGygmQv3Jg//qV3oLlSrCFST
         I3Eo+aFNoAQvlmKOC5ojncmU7dgF4snm+b2DBZpn6LPoSryqj6ZsD5buAE7zURHmTvnt
         wUdCDh3epUdlVnggKHjiflzUjujSLDQvRKdxxzVRP2kZdec/nbSeOpHp9MKNQgJoMl8F
         PD03jJn4jJoe6a70AOQhxMZYvf84urbyKOLjTXOfLpoAt/YFtNVgTSHlCIf7MTe4Is2I
         BN81a+VFy68CqUZgMO3VOPLZyWwZ9JnYDgR3E1Fk8vHJt+dycnKlFWgvZ2Rg8hyK/0w8
         7CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TP1E4MNaDr37ejKWhM68QxCPE84ouBd1MxbFAPpDSP8=;
        b=nc5vlASN2AotS+SmQv5wG8TZcQgOsJmgc0VL+rJAArl/R8SJlGygpvzzflyTtvpLmW
         fIzbKXaKetZ1yJPatFlQ/pTZxI7HX8ErP9RyG+eVOt+RKgcdy4SGcANAvrkSN5khZeOq
         PkXFK5ImUeEMCVmjoBEH+nh5dG7waalN43pDNmbY9CVewfT6Qj/rsrlgcK9nEoIzMo3T
         tgKNl8dGxrkcJthXxPo00GBYL9zRiNR2HRbIzvfd0FtniLUaCubJ4peXo9BOcHY/GBTS
         HFEZcOVv/cUllZiZIQPggiWpRYrtgIVnHV6Q5218sLaAoIVkJ4Sa4gNU6WlYr6z5WBco
         bqHg==
X-Gm-Message-State: APjAAAUJ2y/kRwMdiHKSXjs655t8qy6s8JcEnOYkNjtJ2Mdf8BbUbPe+
        IJHwMtoKZzc/yBrmR+7G4Kc=
X-Google-Smtp-Source: APXvYqxzrsksAtcpaOxy59BhrvKETq0E7xzFXiNR/7QudcxeTKAnaiRW411krC3FIVu4wKcBRdHe/w==
X-Received: by 2002:a63:f91b:: with SMTP id h27mr12842881pgi.399.1552827040712;
        Sun, 17 Mar 2019 05:50:40 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i25sm7677703pfd.52.2019.03.17.05.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:50:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:50:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 10/26] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
Date:   Sun, 17 Mar 2019 19:49:10 +0700
Message-Id: <20190317124926.17137-11-pclouds@gmail.com>
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

These local variables are referenced by struct option[]. This struct
will soon be broken down, moved away and we can't rely on local
variables anymore. Move these two to struct checkout_opts in
preparation for that.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 963f10b05b..b6fc1fc69f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -47,6 +47,8 @@ struct checkout_opts {
 	int show_progress;
 	int count_checkout_paths;
 	int overlay_mode;
+	int no_dwim_new_local_branch;
+
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -58,6 +60,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+	char *conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -1344,8 +1347,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts real_opts;
 	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
-	char *conflict_style = NULL;
-	int dwim_new_local_branch, no_dwim_new_local_branch = 0;
+	int dwim_new_local_branch;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
@@ -1370,12 +1372,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_BOOL(0, "no-guess", &no_dwim_new_local_branch,
+		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
 			 N_("do not second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
@@ -1393,6 +1395,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts->prefix = prefix;
 	opts->show_progress = -1;
 	opts->overlay_mode = -1;
+	opts->no_dwim_new_local_branch = 0;
 
 	git_config(git_checkout_config, opts);
 
@@ -1401,7 +1404,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	dwim_new_local_branch = !no_dwim_new_local_branch;
+	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
@@ -1409,9 +1412,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts->show_progress = isatty(2);
 	}
 
-	if (conflict_style) {
+	if (opts->conflict_style) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-- 
2.21.0.548.gd3c7d92dc2

