Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854D11F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI1EVV (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43229 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeI1EVU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id z14-v6so4208804wrs.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKQn2L4qWuK4XT2mV6t1AnAxTCmSklApVUKfZmPRPSo=;
        b=nVCY/KixD3J+7jak78eVnr+xAIX5jdKlQIrKPTTGPcvx9S8yuXuqM2b88xXGTpoxZR
         Di2MuBRc8qbJHdgo5GoecimWa3M+fmYC85PUbAd0B4yWQatMb5DhWLHPZ51y8sIwG/pM
         RF7caR48IyamExexJ8fPTvPIXj6eiWMQWJPifm/k7TGgPfQfc5Lh6j30lk14pLe4GCGW
         3OWU+M3jyfy2V0YFzV5zMRbsm7cIs1ATuhJ5kNzD0CI4FqceIj/PcR5nJwNwpFbDM+an
         CMAtMI4kHvW+YV5pospYEfNIuQkCbY8BvVc1k1YM0IdENMNhUJ9PuNPwZctbffOEp8+v
         qFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKQn2L4qWuK4XT2mV6t1AnAxTCmSklApVUKfZmPRPSo=;
        b=KGD8oB4THrChcuUOSb9OW5tntgA3BqNN/ulfQzw+vT8wADNPTGvZ49FdHRPOvwN2BU
         wQXRF+ZXmU6x+zWgx1y/Nd8Mb/iq+A1AwDm6UGDAJ1N7i/UPLzll0aILmqG17+cuuCYS
         EhNQraUf2S1yxkb630oa2l7ChLtugbbHhHPWV9QYyusyLFnBgVL9f/1Ic+OUSmganZjY
         z4G6yR3UgNfb315Vsa947Dlh4ui1B8m6BjZ6kweSukEIHzFJgoLe9u68meruasWWGHCc
         BJHcgGPdkbkJKdyI4RCywbflBNs2iQG0wBlVwzO0P3Dm7OmWnsSCH/6c/Wy6S+OIMUeT
         rLgw==
X-Gm-Message-State: ABuFfoi3X4fzHHSoa8rKi77NWbljhbf7tmVhJD/W+0P34FeM18T+nCwZ
        N/DO1e5IL4DScH2EPOFgR+H4GaF0
X-Google-Smtp-Source: ACcGV60bP4ZehERjRNSqU5Eb+2kB9e6P1G+1GT3QE0gozWuvmsI8uEcAv7MTjCpsDj79NVndBjHWpQ==
X-Received: by 2002:adf:bd10:: with SMTP id j16-v6mr9768115wrh.267.1538085653788;
        Thu, 27 Sep 2018 15:00:53 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:53 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 20/20] rebase -i: move rebase--helper modes to rebase--interactive
Date:   Thu, 27 Sep 2018 23:56:10 +0200
Message-Id: <20180927215610.32210-21-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the rebase--helper modes still used by
git-rebase--preserve-merges.sh (`--shorten-ids`, `--expand-ids`,
`--check-todo-list`, `--rearrange-squash` and `--add-exec-commands`) to
rebase--interactive.c.

git-rebase--preserve-merges.sh is modified accordingly, and
rebase--helper.c is removed as it is useless now.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
The changes are due to the rebase, no real changes otherwise.

 .gitignore                     |   1 -
 Makefile                       |   1 -
 builtin.h                      |   1 -
 builtin/rebase--helper.c       | 226 ---------------------------------
 builtin/rebase--interactive.c  |  27 +++-
 git-rebase--preserve-merges.sh |  10 +-
 git.c                          |   1 -
 7 files changed, 31 insertions(+), 236 deletions(-)
 delete mode 100644 builtin/rebase--helper.c

diff --git a/.gitignore b/.gitignore
index 9d1363a1eb..1c0394f576 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,7 +118,6 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
-/git-rebase--helper
 /git-rebase--interactive
 /git-rebase--merge
 /git-rebase--preserve-merges
diff --git a/Makefile b/Makefile
index dc26276747..ec4ee78b3f 100644
--- a/Makefile
+++ b/Makefile
@@ -1081,7 +1081,6 @@ BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/range-diff.o
 BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/rebase--interactive.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
diff --git a/builtin.h b/builtin.h
index b79265d3d4..f6a7d82d73 100644
--- a/builtin.h
+++ b/builtin.h
@@ -205,7 +205,6 @@ extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_range_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
-extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
deleted file mode 100644
index f8128037d3..0000000000
--- a/builtin/rebase--helper.c
+++ /dev/null
@@ -1,226 +0,0 @@
-#include "builtin.h"
-#include "cache.h"
-#include "config.h"
-#include "parse-options.h"
-#include "sequencer.h"
-#include "rebase-interactive.h"
-#include "argv-array.h"
-#include "refs.h"
-#include "rerere.h"
-#include "alias.h"
-
-static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
-static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
-static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
-
-static int get_revision_ranges(const char *upstream, const char *onto,
-			       const char **head_hash,
-			       char **revisions, char **shortrevisions)
-{
-	const char *base_rev = upstream ? upstream : onto;
-	struct object_id orig_head;
-
-	if (get_oid("HEAD", &orig_head))
-		return error(_("no HEAD?"));
-
-	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
-
-	if (revisions)
-		*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
-	if (shortrevisions) {
-		const char *shorthead;
-
-		shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
-
-		if (upstream) {
-			const char *shortrev;
-			struct object_id rev_oid;
-
-			get_oid(base_rev, &rev_oid);
-			shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
-
-			*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
-		} else
-			*shortrevisions = xstrdup(shorthead);
-	}
-
-	return 0;
-}
-
-static int init_basic_state(struct replay_opts *opts, const char *head_name,
-			    const char *onto, const char *orig_head)
-{
-	FILE *interactive;
-
-	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
-		return error_errno(_("could not create temporary %s"), path_state_dir());
-
-	delete_reflog("REBASE_HEAD");
-
-	interactive = fopen(path_interactive(), "w");
-	if (!interactive)
-		return error_errno(_("could not mark as interactive"));
-	fclose(interactive);
-
-	return write_basic_state(opts, head_name, onto, orig_head);
-}
-
-static const char * const builtin_rebase_helper_usage[] = {
-	N_("git rebase--helper [<options>]"),
-	NULL
-};
-
-int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
-{
-	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1, ret;
-	const char *head_hash = NULL, *onto = NULL, *restrict_revision = NULL,
-		*squash_onto = NULL, *upstream = NULL, *head_name = NULL;
-	char *raw_strategies = NULL;
-	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
-		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
-		COMPLETE_ACTION, INIT_BASIC_STATE
-	} command = 0;
-	struct option options[] = {
-		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
-		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
-		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
-			N_("allow commits with empty messages")),
-		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
-		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
-			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "autosquash", &autosquash,
-			 N_("move commits that begin with squash!/fixup!")),
-		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
-		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
-		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
-				CONTINUE),
-		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
-				ABORT),
-		OPT_CMDMODE(0, "make-script", &command,
-			N_("make rebase script"), MAKE_SCRIPT),
-		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
-		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand commit ids in the todo list"), EXPAND_OIDS),
-		OPT_CMDMODE(0, "check-todo-list", &command,
-			N_("check the todo list"), CHECK_TODO_LIST),
-		OPT_CMDMODE(0, "rearrange-squash", &command,
-			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
-		OPT_CMDMODE(0, "add-exec-commands", &command,
-			N_("insert exec commands in todo list"), ADD_EXEC),
-		OPT_CMDMODE(0, "edit-todo", &command,
-			    N_("edit the todo list during an interactive rebase"),
-			    EDIT_TODO),
-		OPT_CMDMODE(0, "prepare-branch", &command,
-			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
-		OPT_CMDMODE(0, "complete-action", &command,
-			    N_("complete the action"), COMPLETE_ACTION),
-		OPT_CMDMODE(0, "init-basic-state", &command,
-			    N_("initialise the rebase state"), INIT_BASIC_STATE),
-		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
-		OPT_STRING(0, "restrict-revision", &restrict_revision,
-			   N_("restrict-revision"), N_("restrict revision")),
-		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
-			   N_("squash onto")),
-		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
-			   N_("the upstream commit")),
-		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
-		OPT_STRING('S', "gpg-sign", &opts.gpg_sign, N_("gpg-sign"),
-			   N_("GPG-sign commits")),
-		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
-			   N_("rebase strategy")),
-		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
-			   N_("strategy options")),
-		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
-		OPT_END()
-	};
-
-	sequencer_init_config(&opts);
-	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
-
-	opts.action = REPLAY_INTERACTIVE_REBASE;
-	opts.allow_ff = 1;
-	opts.allow_empty = 1;
-
-	argc = parse_options(argc, argv, NULL, options,
-			builtin_rebase_helper_usage, PARSE_OPT_KEEP_ARGV0);
-
-	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
-	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
-	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
-	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
-	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
-
-	if (rebase_cousins >= 0 && !rebase_merges)
-		warning(_("--[no-]rebase-cousins has no effect without "
-			  "--rebase-merges"));
-
-	if (command == CONTINUE && argc == 1)
-		return !!sequencer_continue(&opts);
-	if (command == ABORT && argc == 1)
-		return !!sequencer_remove_state(&opts);
-	if (command == MAKE_SCRIPT && argc == 1) {
-		char *revisions = NULL;
-		struct argv_array make_script_args = ARGV_ARRAY_INIT;
-
-		if (!upstream && squash_onto)
-			write_file(path_squash_onto(), "%s\n", squash_onto);
-
-		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions, NULL);
-		if (ret)
-			return ret;
-
-		argv_array_pushl(&make_script_args, "", revisions, NULL);
-		if (restrict_revision)
-			argv_array_push(&make_script_args, restrict_revision);
-
-		ret = sequencer_make_script(stdout,
-					    make_script_args.argc, make_script_args.argv,
-					    flags);
-
-		free(revisions);
-		argv_array_clear(&make_script_args);
-
-		return !!ret;
-	}
-	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
-		return !!transform_todos(flags);
-	if (command == CHECK_TODO_LIST && argc == 1)
-		return !!check_todo_list();
-	if (command == REARRANGE_SQUASH && argc == 1)
-		return !!rearrange_squash();
-	if (command == ADD_EXEC && argc == 2)
-		return !!sequencer_add_exec_commands(argv[1]);
-	if (command == EDIT_TODO && argc == 1)
-		return !!edit_todo_list(flags);
-	if (command == PREPARE_BRANCH && argc == 2)
-		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
-	if (command == COMPLETE_ACTION && argc == 3) {
-		char *shortrevisions = NULL;
-
-		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, &shortrevisions);
-		if (ret)
-			return ret;
-
-		ret = complete_action(&opts, flags, shortrevisions, argv[1], onto,
-				      head_hash, argv[2], autosquash);
-
-		free(shortrevisions);
-		return !!ret;
-	}
-	if (command == INIT_BASIC_STATE) {
-		if (raw_strategies)
-			parse_strategy_opts(&opts, raw_strategies);
-
-		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, NULL);
-		if (ret)
-			return ret;
-
-		return !!init_basic_state(&opts, head_name, onto, head_hash);
-	}
-
-	usage_with_options(builtin_rebase_helper_usage, options);
-}
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index aaf13c9621..a2ab68ed06 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -140,7 +140,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		*switch_to = NULL, *cmd = NULL;
 	char *raw_strategies = NULL;
 	enum {
-		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH
+		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
+		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -161,6 +162,16 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
 			    SHOW_CURRENT_PATCH),
+		OPT_CMDMODE(0, "shorten-ids", &command,
+			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
+		OPT_CMDMODE(0, "expand-ids", &command,
+			N_("expand commit ids in the todo list"), EXPAND_OIDS),
+		OPT_CMDMODE(0, "check-todo-list", &command,
+			N_("check the todo list"), CHECK_TODO_LIST),
+		OPT_CMDMODE(0, "rearrange-squash", &command,
+			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
+		OPT_CMDMODE(0, "add-exec-commands", &command,
+			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
 		OPT_STRING(0, "restrict-revision", &restrict_revision,
 			   N_("restrict-revision"), N_("restrict revision")),
@@ -203,6 +214,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (rebase_cousins >= 0 && !rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
@@ -238,6 +250,19 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 		break;
 	}
+	case SHORTEN_OIDS:
+	case EXPAND_OIDS:
+		ret = transform_todos(flags);
+		break;
+	case CHECK_TODO_LIST:
+		ret = check_todo_list();
+		break;
+	case REARRANGE_SQUASH:
+		ret = rearrange_squash();
+		break;
+	case ADD_EXEC:
+		ret = sequencer_add_exec_commands(cmd);
+		break;
 	default:
 		BUG("invalid command '%d'", command);
 	}
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index c214c5e4d6..afbb65765d 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -711,11 +711,11 @@ do_rest () {
 }
 
 expand_todo_ids() {
-	git rebase--helper --expand-ids
+	git rebase--interactive --expand-ids
 }
 
 collapse_todo_ids() {
-	git rebase--helper --shorten-ids
+	git rebase--interactive --shorten-ids
 }
 
 # Switch to the branch in $into and notify it in the reflog
@@ -876,8 +876,8 @@ init_revisions_and_shortrevisions () {
 
 complete_action() {
 	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
+	test -z "$autosquash" || git rebase--interactive --rearrange-squash || exit
+	test -n "$cmd" && git rebase--interactive --add-exec-commands --cmd "$cmd"
 
 	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
 	todocount=${todocount##* }
@@ -912,7 +912,7 @@ However, if you remove everything, the rebase will be aborted.
 	has_action "$todo" ||
 		return 2
 
-	git rebase--helper --check-todo-list || {
+	git rebase--interactive --check-todo-list || {
 		ret=$?
 		checkout_onto
 		exit $ret
diff --git a/git.c b/git.c
index 2ffafefac3..e00e421e6f 100644
--- a/git.c
+++ b/git.c
@@ -524,7 +524,6 @@ static struct cmd_struct commands[] = {
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
-	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
2.19.0

