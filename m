Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F5D20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbdKZTmq (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:42:46 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46488 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdKZTmi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:42:38 -0500
Received: by mail-wr0-f193.google.com with SMTP id r2so18027719wra.13
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i62+opjJY+XwC+EPDDJ1/HhxnmHI5oB3vhPkUnlUx8Q=;
        b=kuCsIqmrsuO3RK+NH7YqNrQ5/Y6eSHGUkzwMh7z/s/isWkOpfQlDntn1keu9lR8GH7
         ovcid3IC56wfby9JgRTvE+K3zQq4hT+YG0aNO9mxN0XiaX8xMfrLyFHDCMGqzRwB0iMA
         IclH9GwAAEMBFJGsBmGPvu8A/kZt+7VXotm3pg0FI6yEs0x8ruUeCc8e/BnOInBAzA94
         xTeOnpdheZa8lNR+1l+rWhry6v7JeNGx8Ba/+DyE61rq8hT3A1ZfSh6w1+7uoiE7izBX
         HpuWef0Ap0Bh1tT8CfXaU78E3JQguJfNPYYPHHuQ91y1w7xlpbXhzJfS/2d9ElyMXYPe
         yUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i62+opjJY+XwC+EPDDJ1/HhxnmHI5oB3vhPkUnlUx8Q=;
        b=WjMeM3Heuvu7UAOCWaObf14b2xVZq1rTvKC6PE6xiUixaFw3f9sziWgZUBeQNG/4qK
         Ykjz03BTIQ0pARKV3O7vQd3AporACXmv+8sMe3+9oW21H0BSoeK+A00SHbcFufg0cqhF
         vvL/Wo2JE1VjBarJe8S/fklo+1N15O3i7+IQ73GsBtwU0fI792GV8nqAdFgVHqa7qJSA
         c/8sAOf6J7qq0hxB8Y3KvEZwrJpbx/mfQrKt69DckUj1qujGy9dBkdbMuL1B7nJtgWVw
         bzwj8R7N5q5dHliwc8d8Ry3pbZm8MoBicxWDfTJzigkuZe7bJOu5QYokuJiabgbJcNCv
         glJg==
X-Gm-Message-State: AJaThX7KvZJ6xMu2MPsQpJGqE5iguR1ZyDuiG50u53Oli/NDEutWL6XK
        EQXBaFrsq24M2zPSNLbaBV0MRYm8
X-Google-Smtp-Source: AGs4zMaZ70lSeM5hqNxeFRqvlYN5UCBwJkBp6st/q8S0qG0ceTyhgAwkjRV4Gl+ZNNMk2mX5Qjio3g==
X-Received: by 10.223.164.81 with SMTP id e17mr29732450wra.16.1511725357113;
        Sun, 26 Nov 2017 11:42:37 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v9sm15649850wre.12.2017.11.26.11.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 11:42:36 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 5/6] worktree: add --guess-remote flag to add subcommand
Date:   Sun, 26 Nov 2017 19:43:55 +0000
Message-Id: <20171126194356.16187-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126194356.16187-1-t.gummerer@gmail.com>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path>' creates a new branch named after the
basename of the <path>, that matches the HEAD of whichever worktree we
were on when calling "git worktree add <path>".

It's sometimes useful to have 'git worktree add <path> behave more like
the dwim machinery in 'git checkout <new-branch>', i.e. check if the new
branch name uniquely matches the branch name of a remote-tracking
branch, and if so check out that branch and set the upstream to the
remote-tracking branch.

Add a new --guess-remote option that enables exactly that behaviour.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  7 +++++++
 builtin/worktree.c             | 10 ++++++++++
 t/t2025-worktree-add.sh        | 29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3044d305a6..a81cfb2229 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -115,6 +115,13 @@ OPTIONS
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--[no-]guess-remote::
+	With `add`, instead of creating a new branch from HEAD when
+	`<commit-ish>` is not given, if there exists a tracking branch
+	in exactly one remote matching the basename of the path, base
+	the new branch on the remote-tracking branch, and mark the
+	remote-tracking branch as "upstream" from the new branch.
+
 --[no-]track::
 	When creating a new branch, if `<commit-ish>` is a branch,
 	mark it as "upstream" from the new branch.  This is the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7021d02585..15cb1600ee 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -343,6 +343,7 @@ static int add(int ac, const char **av, const char *prefix)
 	char *path;
 	const char *branch;
 	const char *opt_track = NULL;
+	int guess_remote = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -355,6 +356,8 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
 			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
+		OPT_BOOL(0, "guess-remote", &guess_remote,
+			 N_("try to match the new branch name with a remote-tracking branch")),
 		OPT_END()
 	};
 
@@ -389,6 +392,13 @@ static int add(int ac, const char **av, const char *prefix)
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
+		if (guess_remote) {
+			struct object_id oid;
+			const char *remote =
+				unique_tracking_name(opts.new_branch, &oid);
+			if (remote)
+				branch = remote;
+		}
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 96ebc63d04..d25c774cb7 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -384,4 +384,33 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success 'git worktree add does not match remote' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git worktree add ../foo
+	) &&
+	(
+		cd foo &&
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
+test_expect_success 'git worktree add --guess-remote sets up tracking' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git worktree add --guess-remote ../foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_a foo &&
+		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
 test_done
-- 
2.15.0.426.gb06021eeb

