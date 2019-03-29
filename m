Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B05120248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfC2Kk4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35153 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbfC2Kkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id p19so863752plo.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlLwA4fg/tAT9DsKty51YY6rh2QOBKxYWvFeQDic9/A=;
        b=GzorffW7i8TN1N0YxaWLkHqrsZy0Q1D/N5DNvFyUXFsUOVvy7yJaR1aShvcDaecF9H
         lhqGzZ8p8ZN2bkiTBXQUuh0zw/+BXj7wXISf5mGlNE486/LMcSrdsk8iMjRD7R4H7PkC
         nJ8MW1ws4h/H7uAKha9dNTwhu529dppz1uwmv7E6C7QLUok0m0b1z6hr/nQaP5Neh8ns
         bcFTA6TshAATH36yF5ld7unO+9AY5Yg/QghiGr7+htWpi5QN8262FBVUEpApN3zFCyUi
         poWJMS2OoiOFuGIaXPxcy4khLi7yYCZB/l36vUaMbF/c8+jPseW+TVZ0JLK7WNSO69Sj
         btYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlLwA4fg/tAT9DsKty51YY6rh2QOBKxYWvFeQDic9/A=;
        b=Tnq3jDiqfwHzfzVo7ogbAFcWv3aRi5B+eGFhysePFGomFOg8HgVInfID3GsE/AK9+K
         NCtu46aGkYtSGqQgX/icd5qVUiiZldQm4sYgXEnw3UeQL42X7S8BRUYsPqoFkfOR3Rux
         GT7D/msEK4yLzVoB7VZe/IEplVPtZz3CWYe347lJABI5iPq2IwYc8Bn885dWlPHohxi6
         J5UNz0Fg/hWQq3mbZXkMcVUCPvMaBa6gFRLecVxwBe4K7I+CykY0p9/g693wEoTCdAVB
         foqvbxr8umUYkvmEFNO6RllPM1y/Ya8ZwreyVLLGgSFXLSS+CQ1/8CbXC7sM1E3M/NLs
         tWnA==
X-Gm-Message-State: APjAAAVcXxbaBexwjX9crO+m6wZEsC6p/Z3Pz59QUDFCr4317qNsSbuK
        to2ITYBrQZkGcL+yUfXEhfc=
X-Google-Smtp-Source: APXvYqxZfKM1z4YU61vlaZLvLUHg1qJ6WF2ooqWnj0Cc7xZSsjgSJ02kXEE0BsTYSe9Aualb/QbJ2w==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr33834116pls.36.1553856054431;
        Fri, 29 Mar 2019 03:40:54 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id f9sm2393529pfd.10.2019.03.29.03.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 11/27] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
Date:   Fri, 29 Mar 2019 17:39:03 +0700
Message-Id: <20190329103919.15642-12-pclouds@gmail.com>
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

These local variables are referenced by struct option[]. This struct
will soon be broken down, moved away and we can't rely on local
variables anymore. Move these two to struct checkout_opts in
preparation for that.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b6de8401fe..93fc2a5815 100644
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
2.21.0.479.g47ac719cd3

