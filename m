Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0372120A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdK2UDa (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40087 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbdK2UD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id v19so8323970wmh.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DrUaWXDiEPyM6NcPIdbz+gE2t0BF7ftCPmJNdS+spow=;
        b=MurLjlKWZrDxuh7pGTPMCo5TVRyG+wK7rZNCXYLK22mejGmW7VTwLLOjO8mwMr8Ug6
         0SAK7YKt9wUlv7mFbxb9m1HTrlSvy8l0Pq8IpNHdmEBg1JgetAhRjByGn8eoP2j+OhFf
         CZmGmX8mXSuy5KX1v5L+cmXQNENAUrUoeutwe065BqJYrRDwHufvLTqtrmJfAwj6/7U1
         VVMl5Dj1ZPrVvxX+0V4mUKDC9FZDq99Rb4u/kEF9VSXG+Ms2vFKqCgpVC5YfdqlfkRbR
         mhnsU5BCm0sonDi/DPeXO8pQylCXzo3Tqi73TZjyTh6+dVywWUIWiA8hJFiBWdonCKyZ
         aGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DrUaWXDiEPyM6NcPIdbz+gE2t0BF7ftCPmJNdS+spow=;
        b=mB9NRzvChu8Rc3dAVEuKBo7/ciXemBjf22huIMzs4RbKrUZl6bu5nh2pOJmKs5plom
         3pEZcvV6d5mFINY5X3nK5cuzSW2DZG3Arr+ZbFYg5J+J8jULLZ8m694NbTopQOziSVJy
         hzfc+BiA+V4AwWL80b5XX5du3C4boSbHcgEV1IztymxfiMu7ZXiRmFc+Mgd/RVq5lmVN
         Me3bPmj2PgEG5/lTKrl/vDSlucdP6YTbTwKvnOwtEkMKSU+JTCXRSwTU3BKuKIfPEGw4
         QdenLtAvmSIyVZknCdM+v8da/MVozhQPf1X13ib8bgmGxb9CPoAU1zqmT4bBF2BG8Lbj
         f6yg==
X-Gm-Message-State: AJaThX76hFsnLR8nvmSpIrehz3Bfj4Nal/i0Q8VucArBxkLiin4oAQ2L
        HJJFqfgWaOgppnkT8e4/hE3oSlMc
X-Google-Smtp-Source: AGs4zMZkJITW77rvjBf8yOkucMHAihkk9/py0m+Nh1+jv6oOY5PHzIWZl9I+O3FfjbTvij/lgb2TxA==
X-Received: by 10.28.110.26 with SMTP id j26mr6874wmc.46.1511985805987;
        Wed, 29 Nov 2017 12:03:25 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d17sm938628wrc.14.2017.11.29.12.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:25 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 5/6] worktree: add --guess-remote flag to add subcommand
Date:   Wed, 29 Nov 2017 20:04:50 +0000
Message-Id: <20171129200451.16856-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171129200451.16856-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171129200451.16856-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path>' creates a new branch named after the
basename of the <path>, that matches the HEAD of whichever worktree we
were on when calling "git worktree add <path>".

It's sometimes useful to have 'git worktree add <path> behave more like
the dwim machinery in 'git checkout <new-branch>', i.e. check if the new
branch name, derived from the basename of the <path>, uniquely matches
the branch name of a remote-tracking branch, and if so check out that
branch and set the upstream to the remote-tracking branch.

Add a new --guess-remote option that enables exactly that behaviour.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  7 +++++++
 builtin/worktree.c             | 10 ++++++++++
 t/t2025-worktree-add.sh        | 29 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3044d305a6..a4ffee5e08 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -115,6 +115,13 @@ OPTIONS
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--[no-]guess-remote::
+	With `worktree add <path>`, withouth `<commit-ish>`, instead
+	of creating a new branch from HEAD, if there exists a tracking
+	branch in exactly one remote matching the basename of `<path>,
+	base the new branch on the remote-tracking branch, and mark
+	the remote-tracking branch as "upstream" from the new branch.
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

