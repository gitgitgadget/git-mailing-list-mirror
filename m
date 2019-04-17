Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0418620248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfDQOdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33504 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732399AbfDQOdF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so32301714wrp.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=DY07e9PPVvIVd8Yay3ITj5bup5JnWTRw+gbpILnff3Y=;
        b=UK6KM7D3QiQn1JCF6VFiMOPG8XmDaqcgZrrepG3EP0BxxFtDEeIJufVvjh1zT3Uehn
         TZCDo0zyi5GW5srz7elR/Yyrh50FZGLd1be8ocw7eBT37DPZCaADax37L0/N4/zCGCpj
         H3vwsyxItrX6IvCfCIKO/Y27TqRvvUG9qPhsKk7yg/lz7YDllqSIo3dnB/CrfLH5Ep8d
         F1jOaxWYmiTWWy2+K4JcEI8V4nRp5EI4xl5hMdT8Ph72hi1kT4Ky97V0xYGLSv82nCUY
         5PgFFVh2tOvqyU71Rt9rG84oobikNzFVf4ea63QiYqEgmmGEu50gWmGQinBrZ0V9DyJn
         /9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=DY07e9PPVvIVd8Yay3ITj5bup5JnWTRw+gbpILnff3Y=;
        b=m80/kJ99peXT4ldJ8e7PBWNqCT/L8pg/Ozw3lBD6ZSraS71ZbEd0y8tJ1Xh3c0Ajnj
         HOhtuB/EpF+pNkd8foQf+eM/XJj6giYDmuM3XUt+kmIhcvo5z22OSgXn3HtoU8co0Z36
         QW4ckzZIAwBCm1zC2EeKOOJzpUtt2LjYPLTENy5+j5EYi8o5TXc7dbKNkwFU7h/HLGkf
         jEvzCKMpV7Q3NHUcvQ17Lv0EyB1kzK7sE0lYLz513l6TuoZiI1nmQ43EmlzZUsqNdJhf
         Gw8FDYslhBQRTaeZwXVQqeARXeP7wAxr2RguHMg847GzK7yWGBchwtpEt/spX/LH2QWR
         lnVA==
X-Gm-Message-State: APjAAAW+/Y3Rh1BoSGX492uYlntPR2a8+P8aoQybRVz1cJlkYpCCdU1k
        hETuV1Uid+ghm1AskM/t9naaJxDsjus=
X-Google-Smtp-Source: APXvYqwHqLoTiBV8R5ofd24YOyAZn5Zh/gff7xogWntmM2uMdfgGEIVWpzWqZ/MecV34Pk7MBSjvPw==
X-Received: by 2002:adf:fe41:: with SMTP id m1mr58274640wrs.220.1555511583135;
        Wed, 17 Apr 2019 07:33:03 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:33:02 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 05/12] rebase -i: combine rebase--interactive.c with rebase.c
Date:   Wed, 17 Apr 2019 15:30:37 +0100
Message-Id: <20190417143044.17655-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In order to run `rebase -i` without forking `rebase--interactive` it
will be convenient to have all the code from rebase--interactive.c in
rebase.c. This is a straight forward copy of the code from
rebase--interactive.c, it will be simplified slightly in the next
commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Makefile                      |   1 -
 builtin/rebase--interactive.c | 377 ----------------------------------
 builtin/rebase.c              | 367 +++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+), 378 deletions(-)
 delete mode 100644 builtin/rebase--interactive.c

diff --git a/Makefile b/Makefile
index 537493822b..c644089244 100644
--- a/Makefile
+++ b/Makefile
@@ -1130,7 +1130,6 @@ BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/range-diff.o
 BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/rebase.o
-BUILTIN_OBJS += builtin/rebase--interactive.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
deleted file mode 100644
index d1a4ac1b84..0000000000
--- a/builtin/rebase--interactive.c
+++ /dev/null
@@ -1,377 +0,0 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
-#include "builtin.h"
-#include "cache.h"
-#include "config.h"
-#include "parse-options.h"
-#include "sequencer.h"
-#include "rebase-interactive.h"
-#include "argv-array.h"
-#include "refs.h"
-#include "rerere.h"
-#include "run-command.h"
-
-static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
-static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
-static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
-
-static int add_exec_commands(struct string_list *commands)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-					&todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	todo_list_add_exec_commands(&todo_list, commands);
-	res = todo_list_write_to_file(the_repository, &todo_list,
-				      todo_file, NULL, NULL, -1, 0);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
-static int rearrange_squash_in_todo_file(void)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-					&todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_rearrange_squash(&todo_list);
-	if (!res)
-		res = todo_list_write_to_file(the_repository, &todo_list,
-					      todo_file, NULL, NULL, -1, 0);
-
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
-static int transform_todo_file(unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT;
-	int res;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-					&todo_list)) {
-		todo_list_release(&todo_list);
-		return error(_("unusable todo list: '%s'"), todo_file);
-	}
-
-	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
-				      NULL, NULL, -1, flags);
-	todo_list_release(&todo_list);
-
-	if (res)
-		return error_errno(_("could not write '%s'."), todo_file);
-	return 0;
-}
-
-static int edit_todo_file(unsigned flags)
-{
-	const char *todo_file = rebase_path_todo();
-	struct todo_list todo_list = TODO_LIST_INIT,
-		new_todo = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
-		return error_errno(_("could not read '%s'."), todo_file);
-
-	strbuf_stripspace(&todo_list.buf, 1);
-	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
-	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
-					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
-		res = error_errno(_("could not write '%s'"), todo_file);
-
-	todo_list_release(&todo_list);
-	todo_list_release(&new_todo);
-
-	return res;
-}
-
-static int get_revision_ranges(const char *upstream, const char *onto,
-			       const char **head_hash,
-			       char **revisions, char **shortrevisions)
-{
-	const char *base_rev = upstream ? upstream : onto, *shorthead;
-	struct object_id orig_head;
-
-	if (get_oid("HEAD", &orig_head))
-		return error(_("no HEAD?"));
-
-	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
-	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
-
-	shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
-
-	if (upstream) {
-		const char *shortrev;
-		struct object_id rev_oid;
-
-		get_oid(base_rev, &rev_oid);
-		shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
-
-		*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
-	} else
-		*shortrevisions = xstrdup(shorthead);
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
-static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
-				 const char *switch_to, const char *upstream,
-				 const char *onto, const char *onto_name,
-				 const char *squash_onto, const char *head_name,
-				 const char *restrict_revision, char *raw_strategies,
-				 struct string_list *commands, unsigned autosquash)
-{
-	int ret;
-	const char *head_hash = NULL;
-	char *revisions = NULL, *shortrevisions = NULL;
-	struct argv_array make_script_args = ARGV_ARRAY_INIT;
-	struct todo_list todo_list = TODO_LIST_INIT;
-
-	if (prepare_branch_to_be_rebased(the_repository, opts, switch_to))
-		return -1;
-
-	if (get_revision_ranges(upstream, onto, &head_hash,
-				&revisions, &shortrevisions))
-		return -1;
-
-	if (raw_strategies)
-		parse_strategy_opts(opts, raw_strategies);
-
-	if (init_basic_state(opts, head_name, onto, head_hash)) {
-		free(revisions);
-		free(shortrevisions);
-
-		return -1;
-	}
-
-	if (!upstream && squash_onto)
-		write_file(path_squash_onto(), "%s\n", squash_onto);
-
-	argv_array_pushl(&make_script_args, "", revisions, NULL);
-	if (restrict_revision)
-		argv_array_push(&make_script_args, restrict_revision);
-
-	ret = sequencer_make_script(the_repository, &todo_list.buf,
-				    make_script_args.argc, make_script_args.argv,
-				    flags);
-
-	if (ret)
-		error(_("could not generate todo list"));
-	else {
-		discard_cache();
-		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
-						&todo_list))
-			BUG("unusable todo list");
-
-		ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
-				      onto, head_hash, commands, autosquash, &todo_list);
-	}
-
-	free(revisions);
-	free(shortrevisions);
-	todo_list_release(&todo_list);
-	argv_array_clear(&make_script_args);
-
-	return ret;
-}
-
-static const char * const builtin_rebase_interactive_usage[] = {
-	N_("git rebase--interactive [<options>]"),
-	NULL
-};
-
-int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
-{
-	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
-	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
-		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
-		*switch_to = NULL, *cmd = NULL;
-	struct string_list commands = STRING_LIST_INIT_DUP;
-	char *raw_strategies = NULL;
-	enum {
-		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
-		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
-	} command = 0;
-	struct option options[] = {
-		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
-		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
-		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
-			 N_("allow commits with empty messages")),
-		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
-		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
-			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "autosquash", &autosquash,
-			 N_("move commits that begin with squash!/fixup!")),
-		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
-		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
-		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
-			    CONTINUE),
-		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
-		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
-			    EDIT_TODO),
-		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
-			    SHOW_CURRENT_PATCH),
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
-		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
-		OPT_STRING(0, "restrict-revision", &restrict_revision,
-			   N_("restrict-revision"), N_("restrict revision")),
-		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
-			   N_("squash onto")),
-		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
-			   N_("the upstream commit")),
-		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
-		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign, N_("key-id"),
-			N_("GPG-sign commits"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
-			   N_("rebase strategy")),
-		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
-			   N_("strategy options")),
-		OPT_STRING(0, "switch-to", &switch_to, N_("switch-to"),
-			   N_("the branch or commit to checkout")),
-		OPT_STRING(0, "onto-name", &onto_name, N_("onto-name"), N_("onto name")),
-		OPT_STRING(0, "cmd", &cmd, N_("cmd"), N_("the command to run")),
-		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
-		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
-			 N_("automatically re-schedule any `exec` that fails")),
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
-	if (argc == 1)
-		usage_with_options(builtin_rebase_interactive_usage, options);
-
-	argc = parse_options(argc, argv, NULL, options,
-			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
-
-	opts.gpg_sign = xstrdup_or_null(opts.gpg_sign);
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
-	if (cmd && *cmd) {
-		string_list_split(&commands, cmd, '\n', -1);
-
-		/* rebase.c adds a new line to cmd after every command,
-		 * so here the last command is always empty */
-		string_list_remove_empty_items(&commands, 0);
-	}
-
-	switch (command) {
-	case NONE:
-		if (!onto && !upstream)
-			die(_("a base commit must be provided with --upstream or --onto"));
-
-		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
-					    onto_name, squash_onto, head_name, restrict_revision,
-					    raw_strategies, &commands, autosquash);
-		break;
-	case SKIP: {
-		struct string_list merge_rr = STRING_LIST_INIT_DUP;
-
-		rerere_clear(the_repository, &merge_rr);
-		/* fallthrough */
-	case CONTINUE:
-		ret = sequencer_continue(the_repository, &opts);
-		break;
-	}
-	case EDIT_TODO:
-		ret = edit_todo_file(flags);
-		break;
-	case SHOW_CURRENT_PATCH: {
-		struct child_process cmd = CHILD_PROCESS_INIT;
-
-		cmd.git_cmd = 1;
-		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
-		ret = run_command(&cmd);
-
-		break;
-	}
-	case SHORTEN_OIDS:
-	case EXPAND_OIDS:
-		ret = transform_todo_file(flags);
-		break;
-	case CHECK_TODO_LIST:
-		ret = check_todo_list_from_file(the_repository);
-		break;
-	case REARRANGE_SQUASH:
-		ret = rearrange_squash_in_todo_file();
-		break;
-	case ADD_EXEC:
-		ret = add_exec_commands(&commands);
-		break;
-	default:
-		BUG("invalid command '%d'", command);
-	}
-
-	string_list_clear(&commands, 0);
-	return !!ret;
-}
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e7b8122003..57a3c9caf1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -25,6 +25,8 @@
 #include "commit-reach.h"
 #include "rerere.h"
 #include "branch.h"
+#include "sequencer.h"
+#include "rebase-interactive.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -35,6 +37,9 @@ static char const * const builtin_rebase_usage[] = {
 	NULL
 };
 
+static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
+static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 static GIT_PATH_FUNC(apply_dir, "rebase-apply")
 static GIT_PATH_FUNC(merge_dir, "rebase-merge")
 
@@ -46,6 +51,368 @@ enum rebase_type {
 	REBASE_PRESERVE_MERGES
 };
 
+static int add_exec_commands(struct string_list *commands)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	todo_list_add_exec_commands(&todo_list, commands);
+	res = todo_list_write_to_file(the_repository, &todo_list,
+				      todo_file, NULL, NULL, -1, 0);
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
+static int rearrange_squash_in_todo_file(void)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_rearrange_squash(&todo_list);
+	if (!res)
+		res = todo_list_write_to_file(the_repository, &todo_list,
+					      todo_file, NULL, NULL, -1, 0);
+
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
+static int transform_todo_file(unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int res;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+					&todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
+				      NULL, NULL, -1, flags);
+	todo_list_release(&todo_list);
+
+	if (res)
+		return error_errno(_("could not write '%s'."), todo_file);
+	return 0;
+}
+
+static int edit_todo_file(unsigned flags)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT,
+		new_todo = TODO_LIST_INIT;
+	int res = 0;
+
+	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&todo_list.buf, 1);
+	res = edit_todo_list(the_repository, &todo_list, &new_todo, NULL, NULL, flags);
+	if (!res && todo_list_write_to_file(the_repository, &new_todo, todo_file,
+					    NULL, NULL, -1, flags & ~(TODO_LIST_SHORTEN_IDS)))
+		res = error_errno(_("could not write '%s'"), todo_file);
+
+	todo_list_release(&todo_list);
+	todo_list_release(&new_todo);
+
+	return res;
+}
+
+static int get_revision_ranges(const char *upstream, const char *onto,
+			       const char **head_hash,
+			       char **revisions, char **shortrevisions)
+{
+	const char *base_rev = upstream ? upstream : onto, *shorthead;
+	struct object_id orig_head;
+
+	if (get_oid("HEAD", &orig_head))
+		return error(_("no HEAD?"));
+
+	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
+	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+
+	shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
+
+	if (upstream) {
+		const char *shortrev;
+		struct object_id rev_oid;
+
+		get_oid(base_rev, &rev_oid);
+		shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
+
+		*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
+	} else
+		*shortrevisions = xstrdup(shorthead);
+
+	return 0;
+}
+
+static int init_basic_state(struct replay_opts *opts, const char *head_name,
+			    const char *onto, const char *orig_head)
+{
+	FILE *interactive;
+
+	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
+		return error_errno(_("could not create temporary %s"), path_state_dir());
+
+	delete_reflog("REBASE_HEAD");
+
+	interactive = fopen(path_interactive(), "w");
+	if (!interactive)
+		return error_errno(_("could not mark as interactive"));
+	fclose(interactive);
+
+	return write_basic_state(opts, head_name, onto, orig_head);
+}
+
+static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
+				 const char *switch_to, const char *upstream,
+				 const char *onto, const char *onto_name,
+				 const char *squash_onto, const char *head_name,
+				 const char *restrict_revision, char *raw_strategies,
+				 struct string_list *commands, unsigned autosquash)
+{
+	int ret;
+	const char *head_hash = NULL;
+	char *revisions = NULL, *shortrevisions = NULL;
+	struct argv_array make_script_args = ARGV_ARRAY_INIT;
+	struct todo_list todo_list = TODO_LIST_INIT;
+
+	if (prepare_branch_to_be_rebased(the_repository, opts, switch_to))
+		return -1;
+
+	if (get_revision_ranges(upstream, onto, &head_hash,
+				&revisions, &shortrevisions))
+		return -1;
+
+	if (raw_strategies)
+		parse_strategy_opts(opts, raw_strategies);
+
+	if (init_basic_state(opts, head_name, onto, head_hash)) {
+		free(revisions);
+		free(shortrevisions);
+
+		return -1;
+	}
+
+	if (!upstream && squash_onto)
+		write_file(path_squash_onto(), "%s\n", squash_onto);
+
+	argv_array_pushl(&make_script_args, "", revisions, NULL);
+	if (restrict_revision)
+		argv_array_push(&make_script_args, restrict_revision);
+
+	ret = sequencer_make_script(the_repository, &todo_list.buf,
+				    make_script_args.argc, make_script_args.argv,
+				    flags);
+
+	if (ret)
+		error(_("could not generate todo list"));
+	else {
+		discard_cache();
+		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
+						&todo_list))
+			BUG("unusable todo list");
+
+		ret = complete_action(the_repository, opts, flags, shortrevisions, onto_name,
+				      onto, head_hash, commands, autosquash, &todo_list);
+	}
+
+	free(revisions);
+	free(shortrevisions);
+	todo_list_release(&todo_list);
+	argv_array_clear(&make_script_args);
+
+	return ret;
+}
+
+static const char * const builtin_rebase_interactive_usage[] = {
+	N_("git rebase--interactive [<options>]"),
+	NULL
+};
+
+int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
+{
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret = 0;
+	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
+		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
+		*switch_to = NULL, *cmd = NULL;
+	struct string_list commands = STRING_LIST_INIT_DUP;
+	char *raw_strategies = NULL;
+	enum {
+		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
+		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
+	} command = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
+		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
+		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
+			 N_("allow commits with empty messages")),
+		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
+		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
+			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits that begin with squash!/fixup!")),
+		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
+		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
+		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
+			    CONTINUE),
+		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
+		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
+			    EDIT_TODO),
+		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
+			    SHOW_CURRENT_PATCH),
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
+		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
+		OPT_STRING(0, "restrict-revision", &restrict_revision,
+			   N_("restrict-revision"), N_("restrict revision")),
+		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
+			   N_("squash onto")),
+		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
+			   N_("the upstream commit")),
+		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
+		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign, N_("key-id"),
+			N_("GPG-sign commits"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
+			   N_("rebase strategy")),
+		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
+			   N_("strategy options")),
+		OPT_STRING(0, "switch-to", &switch_to, N_("switch-to"),
+			   N_("the branch or commit to checkout")),
+		OPT_STRING(0, "onto-name", &onto_name, N_("onto-name"), N_("onto name")),
+		OPT_STRING(0, "cmd", &cmd, N_("cmd"), N_("the command to run")),
+		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
+		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
+			 N_("automatically re-schedule any `exec` that fails")),
+		OPT_END()
+	};
+
+	sequencer_init_config(&opts);
+	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
+
+	opts.action = REPLAY_INTERACTIVE_REBASE;
+	opts.allow_ff = 1;
+	opts.allow_empty = 1;
+
+	if (argc == 1)
+		usage_with_options(builtin_rebase_interactive_usage, options);
+
+	argc = parse_options(argc, argv, NULL, options,
+			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
+
+	opts.gpg_sign = xstrdup_or_null(opts.gpg_sign);
+
+	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
+	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
+	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
+	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+
+	if (rebase_cousins >= 0 && !rebase_merges)
+		warning(_("--[no-]rebase-cousins has no effect without "
+			  "--rebase-merges"));
+
+	if (cmd && *cmd) {
+		string_list_split(&commands, cmd, '\n', -1);
+
+		/* rebase.c adds a new line to cmd after every command,
+		 * so here the last command is always empty */
+		string_list_remove_empty_items(&commands, 0);
+	}
+
+	switch (command) {
+	case NONE:
+		if (!onto && !upstream)
+			die(_("a base commit must be provided with --upstream or --onto"));
+
+		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
+					    onto_name, squash_onto, head_name, restrict_revision,
+					    raw_strategies, &commands, autosquash);
+		break;
+	case SKIP: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+
+		rerere_clear(the_repository, &merge_rr);
+		/* fallthrough */
+	case CONTINUE:
+		ret = sequencer_continue(the_repository, &opts);
+		break;
+	}
+	case EDIT_TODO:
+		ret = edit_todo_file(flags);
+		break;
+	case SHOW_CURRENT_PATCH: {
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		cmd.git_cmd = 1;
+		argv_array_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		ret = run_command(&cmd);
+
+		break;
+	}
+	case SHORTEN_OIDS:
+	case EXPAND_OIDS:
+		ret = transform_todo_file(flags);
+		break;
+	case CHECK_TODO_LIST:
+		ret = check_todo_list_from_file(the_repository);
+		break;
+	case REARRANGE_SQUASH:
+		ret = rearrange_squash_in_todo_file();
+		break;
+	case ADD_EXEC:
+		ret = add_exec_commands(&commands);
+		break;
+	default:
+		BUG("invalid command '%d'", command);
+	}
+
+	string_list_clear(&commands, 0);
+	return !!ret;
+}
+
 static int use_builtin_rebase(void)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-- 
2.21.0

