Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4D320A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdKZTmm (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:42:42 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35166 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbdKZTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:42:39 -0500
Received: by mail-wm0-f67.google.com with SMTP id w73so2175287wmw.0
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FN6Ljdpl4tRErIBAiA1+fJplHz6A7N1a5MuHQ+yG8eg=;
        b=LhpcIheXO+TxTNJjL5V1f3IxNvmsMXweCmCOP/TVtBdqPaFc9o7EtYEVwprKrNrKkD
         cQUcBi0H4yzL0rgQYSz54YzlDFDx0kQ4nNNTXflhvCvt4HbJR6LhiTDfZ1Kdca9/7/Du
         PcmAd5LeIzzzzZoA/xbVmwBAwFmdoe8lcBCNKqTw4DNm2DQd0CTZMpfWM4AN4Cj52Ol4
         8Zk4R6IxRim8DTHoAVhq1FraOZOqbxm24TrXD1u/kEJU1WqLNGXFO+A7zoclYsCMyswq
         ohhobOsEluh7pBGffE04MSLVphmKGdTRjuu3NGqNbWh0IlCOFNb4EZqX2d/RWG9ZP/OG
         /WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FN6Ljdpl4tRErIBAiA1+fJplHz6A7N1a5MuHQ+yG8eg=;
        b=idn2Ni7ImgxB0UnU96EpibgbveJ1rrxR42GcQVMQR37gGFsxpvkxMeoe8d8WkQIbSg
         mYt8VBBtJR5YnSwdrUWsQj46Wn5Rq0F+TaH8fz3Gt160QSYrcI0PA58NZpILD4+KAeOa
         nurewnLt2p/vRfNJyho4Ejbbcx1SHcHTdNtnPTIdYJ1ymB4/BS7PedDRIR7HGsflTlY+
         4LfPuow7xdti75LEl+PGwiV+flYHq4Vo5mewMEDzX/pntPDz0k5HLqPWmg+exNsZtEqA
         Reqs55yv16xIIa15Chvi4Gqyv8/qD4NkaL5hurSD8qJfudyqvtHKo17/oY2OlQZ8mgdc
         yCGg==
X-Gm-Message-State: AJaThX4Fjx8Ph+pcRXMCr/aUVH7yqlVUkBIp8IffGAXpcXefuvb9F47o
        tsPMHHZ0MEpL2UdwUkdtaW9vXfrH
X-Google-Smtp-Source: AGs4zMayZ66KGaAezGLIxS7wyCVUu1YVZoG/tEAK+ipC1G0EFfq1M8CqKbA2xK3gy0EDE51Qa/JVPA==
X-Received: by 10.28.149.203 with SMTP id x194mr14239401wmd.145.1511725358308;
        Sun, 26 Nov 2017 11:42:38 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id s195sm18239728wmb.33.2017.11.26.11.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 11:42:37 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 6/6] add worktree.guessRemote config option
Date:   Sun, 26 Nov 2017 19:43:56 +0000
Message-Id: <20171126194356.16187-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126194356.16187-1-t.gummerer@gmail.com>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users might want to have the --guess-remote option introduced in
the previous commit on by default, so they don't have to type it out
every time they create a new worktree.

Add a config option worktree.guessRemote that allows users to configure
the default behaviour for themselves.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config.txt       | 10 ++++++++++
 Documentation/git-worktree.txt |  3 +++
 builtin/worktree.c             | 14 +++++++++++++-
 t/t2025-worktree-add.sh        | 31 +++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f65fa9234..4966d90ebb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3425,3 +3425,13 @@ web.browser::
 	Specify a web browser that may be used by some commands.
 	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
 	may use it.
+
+worktree.guessRemote::
+	With `add`, if no branch argument, and neither of `-b` nor
+	`-B` nor `--detach` are given, the command defaults to
+	creating a new branch from HEAD.  If `worktree.guessRemote` is
+	set to true, `worktree add` tries to find a remote-tracking
+	branch whose name uniquely matches the new branch name.  If
+	such a branch exists, it is checked out and set as "upstream"
+	for the new branch.  If no such match can be found, it falls
+	back to creating a new branch from the current HEAD.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a81cfb2229..fd841886ef 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -121,6 +121,9 @@ OPTIONS
 	in exactly one remote matching the basename of the path, base
 	the new branch on the remote-tracking branch, and mark the
 	remote-tracking branch as "upstream" from the new branch.
++
+This can also be set up as the default behaviour by using the
+`worktree.guessRemote` config option.
 
 --[no-]track::
 	When creating a new branch, if `<commit-ish>` is a branch,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 15cb1600ee..426aea8761 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -33,8 +33,19 @@ struct add_opts {
 
 static int show_only;
 static int verbose;
+static int guess_remote;
 static timestamp_t expire;
 
+static int git_worktree_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "worktree.guessremote")) {
+		guess_remote = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
@@ -343,7 +354,6 @@ static int add(int ac, const char **av, const char *prefix)
 	char *path;
 	const char *branch;
 	const char *opt_track = NULL;
-	int guess_remote = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -361,6 +371,8 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_worktree_config, NULL);
+
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index d25c774cb7..6ce9b9c070 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -413,4 +413,35 @@ test_expect_success 'git worktree add --guess-remote sets up tracking' '
 	)
 '
 
+test_expect_success 'git worktree add with worktree.guessRemote sets up tracking' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config worktree.guessRemote true &&
+		git worktree add ../foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_a foo &&
+		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
+test_expect_success 'git worktree --no-guess-remote option overrides config' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config worktree.guessRemote true &&
+		git worktree add --no-guess-remote ../foo
+	) &&
+	(
+		cd foo &&
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
 test_done
-- 
2.15.0.426.gb06021eeb

