Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F372079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966364AbcKLCY6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:58 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34755 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938615AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so2827448pgc.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hA9XEyTY2SE4211PwHxyL50XmjBU5VOOzJGIaxSxFbg=;
        b=DWFseaMKIndZRmhvWyUPSsbYODLueDpdBs/vdZ7mzFKfuMfTSQWv6cVc+I5dhVt3t3
         2j2uetlBoNOYxGmeCbTI3wuvRGF3KFDAWuGu/OcNNGIQwlAbRznkA20aKjVWJYgsJD8J
         SBhhCBB5EG9BrL7LviiYqE1VKL2tkOqzsZSXeC4BvXz1/yvWZ0XDwF3pcYifpwCNcjjL
         e3kTM5R/s3iqnxLTTTNquJNmK36axoTurF6IX+HvGEvTKda9823arsNLIFGuLNClr3ew
         sQZDGYm8U6Q8aL0GHEn+uH+q2aUweiwmukNdqEUUTUTt29R2MMDNEd7eE3QJ0QD2Yq62
         bkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hA9XEyTY2SE4211PwHxyL50XmjBU5VOOzJGIaxSxFbg=;
        b=B3/y9s7cfayqtduqeR6zEBRZ4oLoZn2BpcQCsN4GS2E6gtYLOD5F5P6G5DaUUounLO
         ShmsO/Vql5YeYoSD6j0facMsaftwEB7/U3VAVph9KHL3qOsoU2pIKrbOe36f+lNlWVV+
         ITVNxOQvhnrF+Gsy0JlpMZ/Ebsa2l/0YCM0+BEv7HGF+ufWXMvmpKqxt89esUPYnpTyA
         w1u6ptH1m+bQoXp49ZqGz3hlO+e+5yMCk7y/naztZ24jSZvgTrfn6jdSpWpS7qCtOXjh
         A6eauZcXVUSlDeNGnSoFuIhlZB8dwL40LO2Zwkscqw/rnZp2xANl+lWKHypfD2l4Js8T
         ooyg==
X-Gm-Message-State: ABUngvdix+FGGCBvpFmOelf7+06Wp2fQZrjqAvqiEkKDw/+lM2iPRAS/vWdsZTr94DS9vQ==
X-Received: by 10.98.71.218 with SMTP id p87mr12907203pfi.125.1478917475084;
        Fri, 11 Nov 2016 18:24:35 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id u17sm18072633pfi.1.2016.11.11.18.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:24:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/11] worktree remove: new command
Date:   Sat, 12 Nov 2016 09:23:37 +0700
Message-Id: <20161112022337.13317-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         | 21 +++++----
 builtin/worktree.c                     | 78 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh               | 26 ++++++++++++
 4 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 81f4fee..df0d551 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree remove' [--force] <worktree>
 'git worktree unlock' <worktree>
 
 DESCRIPTION
@@ -81,6 +82,13 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+remove::
+
+Remove a working tree. Only clean working trees (no untracked files
+and no modification in tracked files) can be removed. Unclean working
+trees can be removed with `--force`. The main working tree cannot be
+removed.
+
 unlock::
 
 Unlock a working tree, allowing it to be pruned, moved or deleted.
@@ -90,9 +98,10 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when `<branch>`
-	is already checked out by another working tree. This option overrides
-	that safeguard.
+	By default, `add` refuses to create a new working tree when
+	`<branch>` is already checked out by another working tree and
+	`remove` refuses to remove an unclean working tree. This option
+	overrides that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
@@ -253,12 +262,6 @@ Multiple checkout in general is still experimental, and the support
 for submodules is incomplete. It is NOT recommended to make multiple
 checkouts of a superproject.
 
-git-worktree could provide more automation for tasks currently
-performed manually, such as:
-
-- `remove` to remove a linked working tree and its administrative files (and
-  warn if the working tree is dirty)
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 11be345..60a6199 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,6 +17,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree remove [<options>] <worktree>"),
 	N_("git worktree unlock <path>"),
 	NULL
 };
@@ -621,6 +622,81 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	return update_worktree_location(wt, dst.buf);
 }
 
+static int remove_worktree(int ac, const char **av, const char *prefix)
+{
+	int force = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "force", &force,
+			 N_("force removing even if the worktree is dirty")),
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf sb = STRBUF_INIT;
+	const char *reason;
+	int ret = 0;
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac != 1)
+		usage_with_options(worktree_usage, options);
+
+	worktrees = get_worktrees();
+	wt = find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	if ((reason = is_worktree_locked(wt))) {
+		if (*reason)
+			die(_("already locked, reason: %s"), reason);
+		die(_("already locked, no reason"));
+	}
+	if (validate_worktree(wt, 0))
+		return -1;
+
+	if (!force) {
+		struct argv_array child_env = ARGV_ARRAY_INIT;
+		struct child_process cp;
+		char buf[1];
+
+		argv_array_pushf(&child_env, "%s=%s/.git",
+				 GIT_DIR_ENVIRONMENT, wt->path);
+		argv_array_pushf(&child_env, "%s=%s",
+				 GIT_WORK_TREE_ENVIRONMENT, wt->path);
+		memset(&cp, 0, sizeof(cp));
+		argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
+		cp.env = child_env.argv;
+		cp.git_cmd = 1;
+		cp.dir = wt->path;
+		cp.out = -1;
+		ret = start_command(&cp);
+		if (ret)
+			die_errno(_("failed to run git-status on '%s', code %d"),
+				  av[0], ret);
+		ret = xread(cp.out, buf, sizeof(buf));
+		if (ret)
+			die(_("'%s' is dirty, use --force to delete it"), av[0]);
+		close(cp.out);
+		ret = finish_command(&cp);
+		if (ret)
+			die_errno(_("failed to run git-status on '%s', code %d"),
+				  av[0], ret);
+	}
+	strbuf_addstr(&sb, wt->path);
+	if (remove_dir_recursively(&sb, 0)) {
+		error_errno(_("failed to delete '%s'"), sb.buf);
+		ret = -1;
+	}
+	strbuf_reset(&sb);
+	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
+	if (remove_dir_recursively(&sb, 0)) {
+		error_errno(_("failed to delete '%s'"), sb.buf);
+		ret = -1;
+	}
+	strbuf_release(&sb);
+	free_worktrees(worktrees);
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -645,5 +721,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return unlock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "move"))
 		return move_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "remove"))
+		return remove_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 613e03b..f6855af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2715,7 +2715,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock move prune unlock"
+	local subcommands="add list lock move prune remove unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2733,6 +2733,9 @@ _git_worktree ()
 		prune,--*)
 			__gitcomp "--dry-run --expire --verbose"
 			;;
+		remove,--*)
+			__gitcomp "--force"
+			;;
 		*)
 			;;
 		esac
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 74070bd..084acc6 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -89,4 +89,30 @@ test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
 
+test_expect_success 'remove main worktree' '
+	test_must_fail git worktree remove .
+'
+
+test_expect_success 'remove locked worktree' '
+	git worktree lock destination &&
+	test_must_fail git worktree remove destination &&
+	git worktree unlock destination
+'
+
+test_expect_success 'remove worktree with dirty tracked file' '
+	echo dirty >>destination/init.t &&
+	test_must_fail git worktree remove destination
+'
+
+test_expect_success 'remove worktree with untracked file' '
+	git -C destination checkout init.t &&
+	: >destination/untracked &&
+	test_must_fail git worktree remove destination
+'
+
+test_expect_success 'force remove worktree with untracked file' '
+	git worktree remove --force destination &&
+	test_path_is_missing destination
+'
+
 test_done
-- 
2.8.2.524.g6ff3d78

