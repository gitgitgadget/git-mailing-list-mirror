Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D97B1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKCDwA (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 23:52:00 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46978 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfKCDwA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 23:52:00 -0400
Received: by mail-wr1-f47.google.com with SMTP id b3so7590641wrs.13
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m4UBiYH5sVex3FnAeO4SQ92ETnsP44LyX0CJKvpHeKk=;
        b=RrJFsxz/AG9eKpbWe/8atZMxFvTrSswHFGgLpDlujQSikUSk1sRMOxtziNcCftiegg
         pw/eGJ89rVOoRuQFfkg1f7EihvNf7bXaoibeQNuGDt5lLDfN13Ef+MQ4pXJhFYe1QW5W
         PVDGss1RcbqwWiu0h33IppGwJuq5D9a/lbczSiqPkP2iVN9ZvnPyifpODdjME9tkDVxC
         62vffFUZXrJan49pogMyslDBRyz6+0MpTlJw3Oc2ul6MCiNEEQQhsFxpwObNxPBZAMK9
         j7IkPNYGITiZN70Ac79hl3JaxzYKg6FkMs4+WKwyajJ8p1s2+1F4tNN0LSgZl+/VJ4Vf
         YBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m4UBiYH5sVex3FnAeO4SQ92ETnsP44LyX0CJKvpHeKk=;
        b=UwUby7LACNMJ7tFNWCoEnzp5o4hRiIQx6OScchegWsYMSzg7OHmQVMqemrrjXmgwSL
         9s5crVVUplk0hpKrJtB12APJBmLmURkpwhHVY4vpXaZUoeSve1w5/nbNQ2+vVs6+4YLB
         6FhteN43R5t64yP7B9UYP6zce5E+WiABAnroOWuD1YZogEgBslYjwJZpVxRkslwjpzAX
         KhQcBaLnhtB9gmf0TEEQlzO6WynJPaJP+EnJvXaezz9Y/LMMycklNS8ACBRalGFfx5kq
         ayaze3ZEbHeC/RoPhZoF5sysQyJMZSbEvE0sL5RB4+OigpmHqThhXkV1zpBdfyBiS5L6
         8vWw==
X-Gm-Message-State: APjAAAUkI7BpkoAKbmpXSY7YHM9ztVAN4+Bz91g0++UgEiQeMOwlAuIC
        0Eo1fm7rXGMyicmL6ega9lJka+WR
X-Google-Smtp-Source: APXvYqwHC/Srpr4eGiyn/x9I1SwjrCD75OO5qPGUMws7rd8mOlpl0BUr/OK7q4w2ERmLcGGv6ecx+g==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr16492153wrv.168.1572753116601;
        Sat, 02 Nov 2019 20:51:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm6148196wrm.7.2019.11.02.20.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 20:51:56 -0700 (PDT)
Message-Id: <6e164528059529fe07a53f0cfceb22a388a6758b.1572753114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.442.git.1572753114.gitgitgadget@gmail.com>
References: <pull.442.git.1572753114.gitgitgadget@gmail.com>
From:   "Abimbola via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 03:51:50 +0000
Subject: [PATCH 1/5] remove-annotate: change cmd_annotate to cmd_blame
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abimbola Olaitan <craftwordltd@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abimbola <craftwordltd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abimbola <craftwordltd@gmail.com>

Changing this command is to remove the annotate.c file which does almost
the same thing as blame.c. git annotate will invoc blame directly

Signed-off-by: Abimbola <craftwordltd@gmail.com>
---
 git.c | 143 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 82 insertions(+), 61 deletions(-)

diff --git a/git.c b/git.c
index ce6ab0ece2..84042846b5 100644
--- a/git.c
+++ b/git.c
@@ -5,17 +5,17 @@
 #include "run-command.h"
 #include "alias.h"
 
-#define RUN_SETUP		(1<<0)
-#define RUN_SETUP_GENTLY	(1<<1)
-#define USE_PAGER		(1<<2)
+#define RUN_SETUP (1 << 0)
+#define RUN_SETUP_GENTLY (1 << 1)
+#define USE_PAGER (1 << 2)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE		(1<<3)
-#define SUPPORT_SUPER_PREFIX	(1<<4)
-#define DELAY_PAGER_CONFIG	(1<<5)
-#define NO_PARSEOPT		(1<<6) /* parse-options is not used */
+#define NEED_WORK_TREE (1 << 3)
+#define SUPPORT_SUPER_PREFIX (1 << 4)
+#define DELAY_PAGER_CONFIG (1 << 5)
+#define NO_PARSEOPT (1 << 6) /* parse-options is not used */
 
 struct cmd_struct {
 	const char *cmd;
@@ -23,22 +23,23 @@ struct cmd_struct {
 	unsigned int option;
 };
 
-const char git_usage_string[] =
-	N_("git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
-	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
-	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	   "           <command> [<args>]");
+const char git_usage_string[] = N_(
+	"git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
+	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
+	"           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
+	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
+	"           <command> [<args>]");
 
-const char git_more_info_string[] =
-	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
-	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
-	   "to read about a specific subcommand or concept.\n"
-	   "See 'git help git' for an overview of the system.");
+const char git_more_info_string[] = N_(
+	"'git help -a' and 'git help -g' list available subcommands and some\n"
+	"concept guides. See 'git help <command>' or 'git help <concept>'\n"
+	"to read about a specific subcommand or concept.\n"
+	"See 'git help git' for an overview of the system.");
 
 static int use_pager = -1;
 
-static void list_builtins(struct string_list *list, unsigned int exclude_option);
+static void list_builtins(struct string_list *list,
+			  unsigned int exclude_option);
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
@@ -66,9 +67,9 @@ static int list_cmds(const char *spec)
 	int nongit;
 
 	/*
-	* Set up the repository so we can pick up any repo-level config (like
-	* completion.commands).
-	*/
+	 * Set up the repository so we can pick up any repo-level config (like
+	 * completion.commands).
+	 */
 	setup_git_directory_gently(&nongit);
 
 	while (*spec) {
@@ -93,8 +94,7 @@ static int list_cmds(const char *spec)
 			strbuf_add(&sb, spec + 5, len - 5);
 			list_cmds_by_category(&list, sb.buf);
 			strbuf_release(&sb);
-		}
-		else
+		} else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
 		if (*spec == ',')
@@ -183,7 +183,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --git-dir\n" ));
+				fprintf(stderr,
+					_("no directory given for --git-dir\n"));
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -197,7 +198,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--namespace")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no namespace given for --namespace\n" ));
+				fprintf(stderr,
+					_("no namespace given for --namespace\n"));
 				usage(git_usage_string);
 			}
 			setenv(GIT_NAMESPACE_ENVIRONMENT, (*argv)[1], 1);
@@ -211,7 +213,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --work-tree\n" ));
+				fprintf(stderr,
+					_("no directory given for --work-tree\n"));
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -225,7 +228,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--super-prefix")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no prefix given for --super-prefix\n" ));
+				fprintf(stderr,
+					_("no prefix given for --super-prefix\n"));
 				usage(git_usage_string);
 			}
 			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, (*argv)[1], 1);
@@ -247,7 +251,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-c")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("-c expects a configuration string\n" ));
+				fprintf(stderr,
+					_("-c expects a configuration string\n"));
 				usage(git_usage_string);
 			}
 			git_config_push_parameter((*argv)[1]);
@@ -280,17 +285,20 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
+			set_alternate_shallow_file(the_repository, (*argv)[0],
+						   1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for -C\n" ));
+				fprintf(stderr,
+					_("no directory given for -C\n"));
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
 				if (chdir((*argv)[1]))
-					die_errno("cannot change to '%s'", (*argv)[1]);
+					die_errno("cannot change to '%s'",
+						  (*argv)[1]);
 				if (envchanged)
 					*envchanged = 1;
 			}
@@ -354,7 +362,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			trace2_cmd_name("_run_shell_alias_");
 
 			ret = run_command(&child);
-			if (ret >= 0)   /* normal exit */
+			if (ret >= 0) /* normal exit */
 				exit(ret);
 
 			die_errno(_("while expanding alias '%s': '%s'"),
@@ -378,8 +386,7 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
-		trace_argv_printf(new_argv,
-				  "trace: alias expansion: %s =>",
+		trace_argv_printf(new_argv, "trace: alias expansion: %s =>",
 				  alias_command);
 
 		REALLOC_ARRAY(new_argv, count + *argcp);
@@ -416,14 +423,16 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
+		if (use_pager == -1 &&
+		    p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
 
 		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
-		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
+		    startup_info->have_repository) /* get_git_dir() may set up
+						      repo, avoid that */
 			trace_repo_setup(prefix);
 	}
 	commit_pager_choice();
@@ -467,7 +476,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
-	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
+	{ "annotate", cmd_blame, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
@@ -478,10 +487,9 @@ static struct cmd_struct commands[] = {
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
+	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
-	{ "checkout-index", cmd_checkout_index,
-		RUN_SETUP | NEED_WORK_TREE},
+	{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE },
 	{ "cherry", cmd_cherry, RUN_SETUP },
 	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
@@ -495,7 +503,8 @@ static struct cmd_struct commands[] = {
 	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "describe", cmd_describe, RUN_SETUP },
 	{ "diff", cmd_diff, NO_PARSEOPT },
-	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "diff-files", cmd_diff_files,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
@@ -528,10 +537,14 @@ static struct cmd_struct commands[] = {
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
 	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
-	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-ours", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-recursive-theirs", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
+	{ "merge-subtree", cmd_merge_recursive,
+	  RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
@@ -549,9 +562,10 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
-	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
-	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
+	{ "rebase--interactive", cmd_rebase__interactive,
+	  RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
@@ -581,7 +595,8 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
+	{ "submodule--helper", cmd_submodule__helper,
+	  RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
@@ -623,8 +638,7 @@ static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (exclude_option &&
-		    (commands[i].option & exclude_option))
+		if (exclude_option && (commands[i].option & exclude_option))
 			continue;
 		string_list_append(out, commands[i].cmd);
 	}
@@ -752,7 +766,8 @@ static int run_argv(int *argcp, const char ***argv)
 			trace2_cmd_name("_run_git_alias_");
 
 			if (get_super_prefix())
-				die("%s doesn't support --super-prefix", **argv);
+				die("%s doesn't support --super-prefix",
+				    **argv);
 
 			commit_pager_choice();
 
@@ -764,10 +779,13 @@ static int run_argv(int *argcp, const char ***argv)
 
 			/*
 			 * if we fail because the command is not found, it is
-			 * OK to return. Otherwise, we just pass along the status code.
+			 * OK to return. Otherwise, we just pass along the
+			 * status code.
 			 */
-			i = run_command_v_opt_tr2(args.argv, RUN_SILENT_EXEC_FAILURE |
-						  RUN_CLEAN_ON_EXIT, "git_alias");
+			i = run_command_v_opt_tr2(args.argv,
+						  RUN_SILENT_EXEC_FAILURE |
+							  RUN_CLEAN_ON_EXIT,
+						  "git_alias");
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
 			die("could not execute builtin %s", **argv);
@@ -781,7 +799,8 @@ static int run_argv(int *argcp, const char ***argv)
 			int i;
 			struct strbuf sb = STRBUF_INIT;
 			for (i = 0; i < cmd_list.nr; i++) {
-				struct string_list_item *item = &cmd_list.items[i];
+				struct string_list_item *item =
+					&cmd_list.items[i];
 
 				strbuf_addf(&sb, "\n  %s", item->string);
 				if (item == seen)
@@ -790,7 +809,8 @@ static int run_argv(int *argcp, const char ***argv)
 					strbuf_addstr(&sb, " ==>");
 			}
 			die(_("alias loop detected: expansion of '%s' does"
-			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
+			      " not terminate:%s"),
+			    cmd_list.items[0].string, sb.buf);
 		}
 
 		string_list_append(&cmd_list, *argv[0]);
@@ -872,8 +892,9 @@ int cmd_main(int argc, const char **argv)
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
-			fprintf(stderr, _("expansion of alias '%s' failed; "
-					  "'%s' is not a git command\n"),
+			fprintf(stderr,
+				_("expansion of alias '%s' failed; "
+				  "'%s' is not a git command\n"),
 				cmd, argv[0]);
 			exit(1);
 		}
@@ -884,8 +905,8 @@ int cmd_main(int argc, const char **argv)
 			break;
 	}
 
-	fprintf(stderr, _("failed to run command '%s': %s\n"),
-		cmd, strerror(errno));
+	fprintf(stderr, _("failed to run command '%s': %s\n"), cmd,
+		strerror(errno));
 
 	return 1;
 }
-- 
gitgitgadget

