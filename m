Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E791F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeAXJyb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:31 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43111 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbeAXJy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:28 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so4548951ita.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osApZHollG2kzv7XOgCpK28iTNAEo5YPMvxC8pjp2gE=;
        b=G7zNP87voq5hMoqeO8KQQ3PZeLPqRNwtbcDX9oNMCwZZI7JNE6Umigmx8/NPmxVdrN
         eh4Jp/bPSKCg7doyngVOMNFiUX34cA3DqA5W0xhcY//NRIW1Tg2uc5/eWNLoiR/WHMy3
         n7JgC3tPRXdUHnsSLgpW6twe0SX1BMuBAO9+r4QIo6Q3Jyq8/43F5JDXIvx/HZFoY18S
         7PADu4RQ/a3t41haGfYoKwAjtqAMyyCl5Ygcgh2U+Ig7qgT9oB77Wxr8ys5UfXLwtoLR
         rGbGFFOoGnEdzpUPr6i2QUZbXjBBWxw0ClJXhbj8hfcpsYDaO9eTfh/emwKr9+aU//tU
         H1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osApZHollG2kzv7XOgCpK28iTNAEo5YPMvxC8pjp2gE=;
        b=aZWgsOcWDIGrM2XSfAsyp6P8ri4l0JndckLDzDfpvMRQUnT3nm7yxTEU4WegNpOS5O
         hRui55QNFqOLlHOuyhq7iJ4F6RNlb1nghSgu/4m/YJ+NWXo4kdXFrE4TxAMiFVwGtRsH
         qdwlZ4maElKKIhX4bmufWU6idjgsSndir3z8KhrAeFZbioAp9P6dFc13fO8+wBo2mr/A
         yzBmqGFBdpLi2lpEQnhJOUYANnhqFJoG0ZmVj+xJABHA3x+jV4Gj4mc4XqC5zKAs7SeJ
         yc7eFsUJIIatslMpRsY0hGJE5qvQWgzlnx60wxhb3vR/6tCQ0J267BL1iwCFvTUiWtUs
         TIug==
X-Gm-Message-State: AKwxytcepvgJzGboWXTWH60rdupoY0BAIcpbl356BBjTHK7FgG9pdXeJ
        Fvteqlbq7gHWd9VNoQugnmU5Lw==
X-Google-Smtp-Source: AH8x226VUGZYY5oiRbHZrbUhc0p8CysXRvOibs9GSPqqy/hhU26hRQadIEfgTUb+b9mRonMWjqktxQ==
X-Received: by 10.36.179.67 with SMTP id z3mr8329862iti.67.1516787667051;
        Wed, 24 Jan 2018 01:54:27 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id t96sm10742802ioe.40.2018.01.24.01.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/7] worktree move: new command
Date:   Wed, 24 Jan 2018 16:53:53 +0700
Message-Id: <20180124095357.19645-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124095357.19645-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command allows to relocate linked worktrees. Main worktree cannot
(yet) be moved.

There are two options to move the main worktree, but both have
complications, so it's not implemented yet. Anyway the options are:

- convert the main worktree to a linked one and move it away, leave
  the git repository where it is. The repo essentially becomes bare
  after this move.

- move the repository with the main worktree. The tricky part is make
  sure all file descriptors to the repository are closed, or it may
  fail on Windows.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         |  7 ++++-
 builtin/worktree.c                     | 50 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 31 +++++++++++++++++++++
 4 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41585f535d..5d115b855a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
+'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree unlock' <worktree>
 
@@ -79,6 +80,11 @@ files from being pruned automatically. This also prevents it from
 being moved or deleted. Optionally, specify a reason for the lock
 with `--reason`.
 
+move::
+
+Move a working tree to a new location. Note that the main working tree
+cannot be moved.
+
 prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
@@ -281,7 +287,6 @@ performed manually, such as:
 
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
-- `mv` to move or rename a working tree and update its administrative files
 
 GIT
 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..2faa95430a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,6 +17,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<branch>]"),
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
+	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
 	N_("git worktree unlock <path>"),
 	NULL
@@ -605,6 +606,53 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static int move_worktree(int ac, const char **av, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf dst = STRBUF_INIT;
+	struct strbuf errmsg = STRBUF_INIT;
+	const char *reason;
+	char *path;
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac != 2)
+		usage_with_options(worktree_usage, options);
+
+	path = prefix_filename(prefix, av[1]);
+	strbuf_addstr(&dst, path);
+	free(path);
+	if (file_exists(dst.buf))
+		die(_("target '%s' already exists"), av[1]);
+
+	worktrees = get_worktrees(0);
+	wt = find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working tree"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working tree"), av[0]);
+	reason = is_worktree_locked(wt);
+	if (reason) {
+		if (*reason)
+			die(_("cannot move a locked working tree, lock reason: %s"),
+			    reason);
+		die(_("cannot move a locked working tree"));
+	}
+	if (validate_worktree(wt, &errmsg))
+		die(_("validation failed, cannot move working tree:\n%s"),
+		    errmsg.buf);
+	strbuf_release(&errmsg);
+
+	if (rename(wt->path, dst.buf) == -1)
+		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
+
+	update_worktree_location(wt, dst.buf);
+
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -627,5 +675,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return lock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "unlock"))
 		return unlock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "move"))
+		return move_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..b87d387686 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3087,7 +3087,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock prune unlock"
+	local subcommands="add list lock move prune unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 8298aaf97f..bef420a086 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -59,4 +59,35 @@ test_expect_success 'unlock worktree twice' '
 	test_path_is_missing .git/worktrees/source/locked
 '
 
+test_expect_success 'move non-worktree' '
+	mkdir abc &&
+	test_must_fail git worktree move abc def
+'
+
+test_expect_success 'move locked worktree' '
+	git worktree lock source &&
+	test_must_fail git worktree move source destination &&
+	git worktree unlock source
+'
+
+test_expect_success 'move worktree' '
+	toplevel="$(pwd)" &&
+	git worktree move source destination &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $toplevel
+	worktree $toplevel/destination
+	worktree $toplevel/elsewhere
+	EOF
+	test_cmp expected actual &&
+	git -C destination log --format=%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'move main worktree' '
+	test_must_fail git worktree move . def
+'
+
 test_done
-- 
2.16.0.47.g3d9b0fac3a

