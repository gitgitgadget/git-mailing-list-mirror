Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3E01F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeAXJys (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:54:48 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:33530 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932775AbeAXJyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:54:44 -0500
Received: by mail-io0-f181.google.com with SMTP id n7so4241640iob.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sCvasza7chN0QikVLBKsOZ4TsdCU0JK7rMfFeAgv0o=;
        b=Mk6iRbLhCtNtaOFB8hEUXgLJwhhKiEPrlmEOLiVPKqlA+dAacne8/j7HbBH9Gp69ub
         h9i07bRGs9M8njHQXcAV1DGt0x2trCXsanS7fRt0h9xYKp7jmhskyAmkntVFlp6UvAtn
         gcb+kDdyGHIXh0cp2UHWNuVsUdnvbEtOJnB7suY3ZVbQ96Doo+fWUdTSJm/4MlzjeORt
         AAahFlirIv14Df10rwRNLmS2lNW+mXxcwCsJBE7/WbWfb4WzNfjHa40NmpqiMqgLiwuM
         23wDYIAFpWCYCa2dK7U7THgDBFilEKzy5LLyRg5HmywbN10I3hIUPFrfQPHvjktHDPB+
         xNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sCvasza7chN0QikVLBKsOZ4TsdCU0JK7rMfFeAgv0o=;
        b=BW/IVeIESIFDTv0E1kqRQqfszbJ0C2mOSzhvHZjjUXnK86FeIXLOhmw5nDl6S3Kg2z
         orSxbyXjLi+HlDOQ6AB64uYuEP86gszNo+dwLsCf+PbLWGjKHwEYPDGurUeygA2ixdU4
         Y0J8l/Yw8FTcwlFcjPRt/lXfAya96Req3eTkIqzB5Ebz0fKK3exGrpYa78Vl501wGoZI
         +LvzRY9prq8gih/Soz2OYmx4dse70JMAqBgHGWB5uW3QB+UDW1t4e/k6CEBZ/jjw81u2
         aE7R7d94yCubCK45nTrvkbcGCGO6xS3/NUuJFszg4Is0uO6b38EqX5xxf9ctwa46XgwP
         l72Q==
X-Gm-Message-State: AKwxytfDQR8HMtjRp7D4nou5UIk2RFezBBlUrhaa2rxdOpI8PB/rddkf
        STv6gl5OcUoRynSjZxV1B1GKGA==
X-Google-Smtp-Source: AH8x2263S/djBp7SdYRZzJxeSqyOZdjZYVwLrrplnS3V0Sv/x1zPbejsu/laVVYWT+Nq6vPlXfTGnA==
X-Received: by 10.107.212.11 with SMTP id l11mr7701794iog.101.1516787683694;
        Wed, 24 Jan 2018 01:54:43 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id j30sm9021638ioi.55.2018.01.24.01.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:54:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:54:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/7] worktree remove: new command
Date:   Wed, 24 Jan 2018 16:53:56 +0700
Message-Id: <20180124095357.19645-7-pclouds@gmail.com>
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

This command allows to delete a worktree. Like 'move' you cannot
remove the main worktree, or one with submodules inside [1].

For deleting $GIT_WORK_TREE, Untracked files or any staged entries are
considered precious and therefore prevent removal by default. Ignored
files are not precious.

When it comes to deleting $GIT_DIR, there's no "clean" check because
there should not be any valuable data in there, except:

- HEAD reflog. There is nothing we can do about this until somebody
  steps up and implements the ref graveyard.

- Detached HEAD. Technically it can still be recovered. Although it
  may be nice to warn about orphan commits like 'git checkout' does.

[1] We do 'git status' with --ignore-submodules=all for safety
    anyway. But this needs a closer look by submodule people before we
    can allow deletion. For example, if a submodule is totally clean,
    but its repo not absorbed to the main .git dir, then deleting
    worktree also deletes the valuable .submodule repo too.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         |  21 +++---
 builtin/worktree.c                     | 131 ++++++++++++++++++++++++++++++++-
 contrib/completion/git-completion.bash |   5 +-
 t/t2028-worktree-move.sh               |  26 +++++++
 4 files changed, 172 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 24bb69de50..6f83723d9a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree remove' [--force] <worktree>
 'git worktree unlock' <worktree>
 
 DESCRIPTION
@@ -89,6 +90,13 @@ prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
 
+remove::
+
+Remove a working tree. Only clean working trees (no untracked files
+and no modification in tracked files) can be removed. Unclean working
+trees or ones with submodules can be removed with `--force`. The main
+working tree cannot be removed.
+
 unlock::
 
 Unlock a working tree, allowing it to be pruned, moved or deleted.
@@ -98,9 +106,10 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when `<commit-ish>` is a branch name and
-	is already checked out by another working tree. This option overrides
-	that safeguard.
+	By default, `add` refuses to create a new working tree when
+	`<commit-ish>` is a branch name and is already checked out by
+	another working tree and `remove` refuses to remove an unclean
+	working tree. This option overrides that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
@@ -282,12 +291,6 @@ Multiple checkout in general is still experimental, and the support
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
index 15980a0a49..8b027375d7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -19,6 +19,7 @@ static const char * const worktree_usage[] = {
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree move <worktree> <new-path>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree remove [<options>] <worktree>"),
 	N_("git worktree unlock <path>"),
 	NULL
 };
@@ -624,7 +625,7 @@ static void validate_no_submodules(const struct worktree *wt)
 	discard_index(&istate);
 
 	if (found_submodules)
-		die(_("working trees containing submodules cannot be moved"));
+		die(_("working trees containing submodules cannot be moved or removed"));
 }
 
 static int move_worktree(int ac, const char **av, const char *prefix)
@@ -688,6 +689,132 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
+/*
+ * Note, "git status --porcelain" is used to determine if it's safe to
+ * delete a whole worktree. "git status" does not ignore user
+ * configuration, so if a normal "git status" shows "clean" for the
+ * user, then it's ok to remove it.
+ *
+ * This assumption may be a bad one. We may want to ignore
+ * (potentially bad) user settings and only delete a worktree when
+ * it's absolutely safe to do so from _our_ point of view because we
+ * know better.
+ */
+static void check_clean_worktree(struct worktree *wt,
+				 const char *original_path)
+{
+	struct argv_array child_env = ARGV_ARRAY_INIT;
+	struct child_process cp;
+	char buf[1];
+	int ret;
+
+	validate_no_submodules(wt);
+
+	argv_array_pushf(&child_env, "%s=%s/.git",
+			 GIT_DIR_ENVIRONMENT, wt->path);
+	argv_array_pushf(&child_env, "%s=%s",
+			 GIT_WORK_TREE_ENVIRONMENT, wt->path);
+	memset(&cp, 0, sizeof(cp));
+	argv_array_pushl(&cp.args, "status",
+			 "--porcelain", "--ignore-submodules=none",
+			 NULL);
+	cp.env = child_env.argv;
+	cp.git_cmd = 1;
+	cp.dir = wt->path;
+	cp.out = -1;
+	ret = start_command(&cp);
+	if (ret)
+		die_errno(_("failed to run git-status on '%s'"),
+			  original_path);
+	ret = xread(cp.out, buf, sizeof(buf));
+	if (ret)
+		die(_("'%s' is dirty, use --force to delete it"),
+		    original_path);
+	close(cp.out);
+	ret = finish_command(&cp);
+	if (ret)
+		die_errno(_("failed to run git-status on '%s', code %d"),
+			  original_path, ret);
+}
+
+static int delete_git_work_tree(struct worktree *wt)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, wt->path);
+	if (remove_dir_recursively(&sb, 0)) {
+		error_errno(_("failed to delete '%s'"), sb.buf);
+		ret = -1;
+	}
+	strbuf_release(&sb);
+
+	return ret;
+}
+
+static int delete_git_dir(struct worktree *wt)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
+	if (remove_dir_recursively(&sb, 0)) {
+		error_errno(_("failed to delete '%s'"), sb.buf);
+		ret = -1;
+	}
+	strbuf_release(&sb);
+	return ret;
+}
+
+static int remove_worktree(int ac, const char **av, const char *prefix)
+{
+	int force = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "force", &force,
+			 N_("force removing even if the worktree is dirty")),
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	struct strbuf errmsg = STRBUF_INIT;
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
+		die(_("'%s' is not a working tree"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working tree"), av[0]);
+	reason = is_worktree_locked(wt);
+	if (reason) {
+		if (*reason)
+			die(_("cannot remove a locked working tree, lock reason: %s"),
+			    reason);
+		die(_("cannot remove a locked working tree"));
+	}
+	if (validate_worktree(wt, &errmsg))
+		die(_("validation failed, cannot remove working tree:\n%s"),
+		    errmsg.buf);
+	strbuf_release(&errmsg);
+
+	if (!force)
+		check_clean_worktree(wt, av[0]);
+
+	ret |= delete_git_work_tree(wt);
+	/*
+	 * continue on even if ret is non-zero, there's no going back
+	 * from here.
+	 */
+	ret |= delete_git_dir(wt);
+
+	free_worktrees(worktrees);
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -712,5 +839,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return unlock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "move"))
 		return move_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "remove"))
+		return remove_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b87d387686..ff4a39631e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3087,7 +3087,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock move prune unlock"
+	local subcommands="add list lock move prune remove unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -3105,6 +3105,9 @@ _git_worktree ()
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
2.16.0.47.g3d9b0fac3a

