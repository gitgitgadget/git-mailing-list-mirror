Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F491FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbcFYIKa (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:10:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32811 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbcFYIKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:10:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id l188so23981475lfe.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:10:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXS1NyrBniTE9nLHprTaz0Zv8a7aeIFIMiH7DPnMKoM=;
        b=Jr3kKf5+n1AxSJag0Y2cCIhJuhieTDquMaT4OJgYV/8MM/56olFo4RzkLkiN3HI+9E
         v5LLR4wumXXZuMjMfHWTzhE/lvg4t13Z+ZcZQJnXzr97z40yp8yEQhxJ/mq7O8oyW1FL
         hpLDv6pAC/0wO0i/LLty57Zn1LzmD08pejK6c6SUGXSFtsJCI/PhLI1G9KENtsC6ONpy
         07a4iivC6aNXFfKvjX5VOrpg2wQ6ZyAqC0bPA6siqraoNWBe6Jwm0sW/TjNHGHpm6g69
         +AtAXH+yfNkQ9v3Unh4AtiI3AjFAb7q00PwJW3nt5A1pAl1zvrmQ9n4/N0nm03UtQRDE
         LgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXS1NyrBniTE9nLHprTaz0Zv8a7aeIFIMiH7DPnMKoM=;
        b=DuG6TCbG36xlztPPZgzlBaKo65I02/DS9wfBI0gXBFLQWsnv/febsV6WpI3wMBoEhg
         R+Wp19cuT2cAweMaPiqV5yDq0buuW5Ip/20RtwVA0UIrqMfVgBf8OVSczNYhHBoRDO2n
         0nYdmNCEKYLaqelF/C8MQRAB4oyhkHRKfFuGDzTRXU2qAIz5bQRSUjC3/i6TLWYtmnDN
         Zb3XuosCLZu3fDd1GKveLE+adYP3c3hKNMTatjHfdp5aYlQDK3GeqEyaNWb2LgZ72gnC
         vdotFLYgg87BexO2VXIn82djVUDZsCvYsp36riDjJPv9ptJlhwwa+SQRvCartlZg4yJd
         do3Q==
X-Gm-Message-State: ALyK8tIEKZvFppTKDLJBRJW2Ypz7/iVv+6sOYPvKKDeQVmysMdnCFFbhxhmZ3gi4lB6Fcg==
X-Received: by 10.46.32.73 with SMTP id g70mr2493338ljg.28.1466841290081;
        Sat, 25 Jun 2016 00:54:50 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:49 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/10] worktree: add "remove" command
Date:	Sat, 25 Jun 2016 09:54:33 +0200
Message-Id: <20160625075433.4608-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt         | 21 +++++----
 builtin/worktree.c                     | 78 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash |  5 ++-
 t/t2028-worktree-move.sh               | 26 ++++++++++++
 4 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b842136..2d2fe57 100644
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
index 443a5ae..873840a 100644
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
@@ -600,6 +601,81 @@ static int move_worktree(int ac, const char **av, const char *prefix)
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
@@ -622,5 +698,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 		return unlock_worktree(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "move"))
 		return move_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "remove"))
+		return remove_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b2028e2..c2981cf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2597,7 +2597,7 @@ _git_whatchanged ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock move prune unlock"
+	local subcommands="add list lock move prune remove unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2615,6 +2615,9 @@ _git_worktree ()
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
index 3cf5305..d98e542 100755
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
2.8.2.526.g02eed6d

