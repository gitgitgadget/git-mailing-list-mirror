Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA25207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031229AbdDTKLs (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33681 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031221AbdDTKLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:45 -0400
Received: by mail-io0-f195.google.com with SMTP id k87so14523469ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nhyPNsL8Fv4pp/lGOf59V4SJs8TnQTooL5SZiF90z4=;
        b=K4Zo4CaKJJ4VD4eNgV7VV9kjydlB9hJtId/DrksOLAywHSmVgfnRsloW0azP0A+sr4
         9Bf+t6mEPkMAaXmzEPTHMNl5lEJjcrqNQq6sR9aBGL5g9Vg+jGEeIEYuA5zdDLPN897M
         lYF1T/XtF72GN1j7eDz7vXx5NilIGHqPhJNjcISwTqiZbH+qr/ROSZMEUhfCfI1RkF92
         rDHkwX6PtghAzt3dE8omE1u99NTMZ2jVkMVHc8xrT0ha85dF9vqaKoAsXleftcrjBHEe
         0nykMO1dFjjg+l1DaS0nc90GsAPs/uQhNqimkV+wKqC540dffyMAIQQBtsIylRPPMrFs
         +YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nhyPNsL8Fv4pp/lGOf59V4SJs8TnQTooL5SZiF90z4=;
        b=drGfBWQPcfcVsTdv2xrbyfetjHGm+OHb/47JBywphnAZQHqoVy7TEGwQ3W+O22XjuG
         tVSQ3ZU7CqQUaTEXgeOt/TVzkyBpSsWuRLAx2dF0EYnfOGgaEJ8GxiI0JPvvrRoZtHXv
         J/0yVivW/33SO5xg9aCMygD0hz2P+HIVggaPESsftxEt5zrjp/t1fKFSyrdtcB5I5fhU
         jqtjjfHZmSCX5LSy/WYIfemM1ewNardbnOKN+sd6jWIeMKIQG0ycZP+ltyWudHcb7Uj/
         rFMpOpyqLlENA9XfQYUdrVOLLntHznV0A+h6jCKH0WZtit2Fh1FLqkOb3Ew3sb/uMwvx
         E3aw==
X-Gm-Message-State: AN3rC/72DUBaLStE9CPTDq45GxVhgXj7fG43DPNF+7B+QGunI46hx2Md
        9U5HzuF1vc83tA==
X-Received: by 10.98.70.76 with SMTP id t73mr7392210pfa.176.1492683104762;
        Thu, 20 Apr 2017 03:11:44 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id s3sm9585383pgn.29.2017.04.20.03.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/6] worktree remove: new command
Date:   Thu, 20 Apr 2017 17:10:24 +0700
Message-Id: <20170420101024.7593-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
References: <20170420101024.7593-1-pclouds@gmail.com>
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
 builtin/worktree.c                     | 79 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh               | 26 +++++++++++
 4 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b47a3247bb..020eeb157f 100644
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
index 825b3e9d9a..b5afba1646 100644
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
@@ -604,6 +605,82 @@ static int move_worktree(int ac, const char **av, const char *prefix)
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
+	worktrees = get_worktrees(0);
+	wt = find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+	reason = is_worktree_locked(wt);
+	if (reason) {
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
@@ -628,5 +705,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return unlock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "move"))
 		return move_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "remove"))
+		return remove_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 651809c52f..eb8cb7ecee 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3036,7 +3036,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock move prune unlock"
+	local subcommands="add list lock move prune remove unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -3054,6 +3054,9 @@ _git_worktree ()
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
index bef420a086..b3105eaaed 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -90,4 +90,30 @@ test_expect_success 'move main worktree' '
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
2.11.0.157.gd943d85

