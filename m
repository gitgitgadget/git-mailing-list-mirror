Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0BB1F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbeBLJuu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:50 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:51719 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933379AbeBLJuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:22 -0500
Received: by mail-it0-f67.google.com with SMTP id 193so3092714iti.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8R2grBjNdrB1N0qmVcJyFe9N3S11o4oIxEL3NyzZGhE=;
        b=qzbSnUIKxWt28x9XXE5S9S03v5Owt7WL59eXa6jJpObWQWj2b7BLL2QQFwWM5eeTUT
         Ks7H2Y0N/jhkoJWASaOObH7yuAXgQPAPhnpYUFhgNDHvJnzSlE+RYDwMWXrWKvrvGOxW
         dAbyzE0p5auu/jWqUPJpg35PucHV2hJ9iwVSFD9gVRdhbwLKkRGCFlJxsCBrqoRB7Btr
         7LhVBw2sX7sIIHoqV4hi8FbwidF9RHMFyS8uClQs3iA3zxqvSw7mwTQbkIPAr/2HvKcr
         ToPO4PP0TYAmDwUb/wympSX99YmNfE6Xg0BO5hzTM7KjOTApyKoNRAC/z3S+S8nYaJB9
         BcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8R2grBjNdrB1N0qmVcJyFe9N3S11o4oIxEL3NyzZGhE=;
        b=Xe3Y4Ld9WS4om0KqxkH8bwt+mjtZOax6JjKwxbWqJEwpr89WUMoS4OzbDE6XBWLTUB
         3OxXFSycmeCDlj7HnPyydFJjPwoe3r0Ytu9049EVu9t186Xl9PU1yJqyRV0KF9JIC7eW
         u80ZfFsEFfcjrLt9ftU2MgTg01TL4jdPbIbUdL9/6/CbsrmymRZvNe0BZWGEKrSDBpwV
         bcVcMevZZ43I9+kfB1z3bEPXsi6IrAq3ukcGIONBAq9LcRp+wh8D1Tt7jzI0zQwlEF6z
         YMi+wT9POWW4+x/3jK5B3r3KAj3iLZbEkxdZ6tKF2SJXZZbn9AiBcVx+WbtgxG7EYGgt
         kFRw==
X-Gm-Message-State: APf1xPCJF6w627RO7lJuQmqH6YDRJP0mX8c1Z5vxbh094AtCSYF9f/5D
        Fku2xiMkg4PDm3nnLQCfB2Cwyw==
X-Google-Smtp-Source: AH8x224TKzqS+K7Rj/KU8IVXFV04mGq+K8P1P/8t0Tja1gZSX4sec2KvHuTP3K0KXA1wN2ATRD4Ehg==
X-Received: by 10.36.117.150 with SMTP id y144mr4593246itc.141.1518429021706;
        Mon, 12 Feb 2018 01:50:21 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id y6sm9430227iod.7.2018.02.12.01.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:50:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/7] worktree move: new command
Date:   Mon, 12 Feb 2018 16:49:36 +0700
Message-Id: <20180212094940.23834-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180212094940.23834-1-pclouds@gmail.com>
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
 Documentation/git-worktree.txt         | 13 ++++---
 builtin/worktree.c                     | 53 ++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 26 +++++++++++++
 4 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41585f535d..4fa1dd3a48 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
+'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree unlock' <worktree>
 
@@ -34,10 +35,6 @@ The working tree's administrative files in the repository (see
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
 
-If you move a linked working tree, you need to manually update the
-administrative files so that they do not get pruned automatically. See
-section "DETAILS" for more information.
-
 If a linked working tree is stored on a portable device or network share
 which is not always mounted, you can prevent its administrative files from
 being pruned by issuing the `git worktree lock` command, optionally
@@ -79,6 +76,11 @@ files from being pruned automatically. This also prevents it from
 being moved or deleted. Optionally, specify a reason for the lock
 with `--reason`.
 
+move::
+
+Move a working tree to a new location. Note that the main working tree
+cannot be moved.
+
 prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
@@ -196,7 +198,7 @@ thumb is do not make any assumption about whether a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
 
-If you move a linked working tree, you need to update the 'gitdir' file
+If you manually move a linked working tree, you need to update the 'gitdir' file
 in the entry's directory. For example, if a linked working tree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
@@ -281,7 +283,6 @@ performed manually, such as:
 
 - `remove` to remove a linked working tree and its administrative files (and
   warn if the working tree is dirty)
-- `mv` to move or rename a working tree and update its administrative files
 
 GIT
 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..8b9482d1e5 100644
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
@@ -605,6 +606,56 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
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
+
+	worktrees = get_worktrees(0);
+	wt = find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working tree"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working tree"), av[0]);
+	if (file_exists(dst.buf))
+		die(_("target '%s' already exists"), av[1]);
+
+	reason = is_worktree_locked(wt);
+	if (reason) {
+		if (*reason)
+			die(_("cannot move a locked working tree, lock reason: %s"),
+			    reason);
+		die(_("cannot move a locked working tree"));
+	}
+	if (validate_worktree(wt, &errmsg))
+		die(_("validation failed, cannot move working tree: %s"),
+		    errmsg.buf);
+	strbuf_release(&errmsg);
+
+	if (rename(wt->path, dst.buf) == -1)
+		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
+
+	update_worktree_location(wt, dst.buf);
+
+	strbuf_release(&dst);
+	free_worktrees(worktrees);
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -627,5 +678,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
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
index 8298aaf97f..0f8abc0854 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -59,4 +59,30 @@ test_expect_success 'unlock worktree twice' '
 	test_path_is_missing .git/worktrees/source/locked
 '
 
+test_expect_success 'move non-worktree' '
+	mkdir abc &&
+	test_must_fail git worktree move abc def
+'
+
+test_expect_success 'move locked worktree' '
+	git worktree lock source &&
+	test_when_finished "git worktree unlock source" &&
+	test_must_fail git worktree move source destination
+'
+
+test_expect_success 'move worktree' '
+	toplevel="$(pwd)" &&
+	git worktree move source destination &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree.*/destination" &&
+	! git worktree list --porcelain | grep "^worktree.*/source" >empty &&
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
2.16.1.399.g632f88eed1

