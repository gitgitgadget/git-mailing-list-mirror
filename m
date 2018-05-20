Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B4A1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeETSkW (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:40:22 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44328 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeETSkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id h197-v6so20752749lfg.11
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYiq4A/i2WkjS8Pmv2NiEliMz71XHxDr6DM8Ml+mp8o=;
        b=BCGTA2bG1Y/L3AXwyoo8fd9HapeJtAFZJB766zEPSDBEW9EHkaOY2oKGbEGDU0HI0S
         lmQjApl4w+cvBsnUCU4eeZUv7BHUsKxYxeH8GU8Poqtoaoipf6cJgrifYnTHIIjOsF7Y
         0NqL2FXqrhr4vAloBOsIR3A4r7tiejwF5FKCc0s/k7KqcU7ZzzhDI8Cm1sDKiOQmlG5K
         yRI3ZMAFOzTcaIN6QON9nRlBn10Yi8JjdIIx0xPJhTfdnM17O7Am3jE03vYGYVnVrIhP
         W/Q2HSrMpAHKetlcNTHnQ9hPdkqvL6lYTgFDJvPZTVpYyp8GT4jTeZ07HpUP1pBMqeAg
         5fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYiq4A/i2WkjS8Pmv2NiEliMz71XHxDr6DM8Ml+mp8o=;
        b=mkLIgVkdegHKuMh1FMduhhQXYSeGy7hUv0g+/RLM49bxNf2LA35ka7t5QOzNnG+8Sa
         J0M9+DOOaUhi7UrZQYkDiCh9hUlLZ+jQIttHatnYTfMNDLhkRuGzyTooGiz2CZhnZEjD
         cLYDk9QoxAwXYiPPkozY72Cz1TF5EwXDpl88fJg5FFSGxTn05tIsRS4ofT0p2A2IXDoT
         l/63aLF4RE2m5VQzwc8E67ylIzEWVFV8PgzSck/yRDuKD15IpkloHhwbGTjm8zvrpDKY
         LUh2BiH48WMf96KSCMPKE1wGupIX2EzKi0/wp8XUHPnfJIzpNTmaY9J6iXQYVaoN7tnF
         yxkw==
X-Gm-Message-State: ALKqPwf4E4IgILs0ud9w5jwPs5Su0QOs6xw5nH6QnxPwzJOiy0KAGhKJ
        ZPOzxwd726pee8/2mldErowBPQ==
X-Google-Smtp-Source: AB8JxZpVelG6Q56g1crZU2pdIXV9pG3RghrZJ0wwGtZ0WPL95J0QyKMF00kOiqdu5t+c9dQYl0u+7Q==
X-Received: by 2002:a19:ccc3:: with SMTP id c186-v6mr26330267lfg.82.1526841619099;
        Sun, 20 May 2018 11:40:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/17] nd/command-list updates
Date:   Sun, 20 May 2018 20:39:52 +0200
Message-Id: <20180520184009.976-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519042752.8666-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It turns out this series is not done as I thought it was :)

v2 makes it possible to write

    gitcomp "$(git --list-cmds=...)"

which is really nice and very close to what gitcomp_builtin does.
Other changes are

- support --list-cmds=alias and --list-cmds=nohelpers so that we could
  do the above
- a bit more document about --list-cmds
- $GIT_COMPLETION_CMD_GROUPS is dropped. I think it just causes more
  confusion and complete.commands should be enough in most cases
- name-rev is no longer compleable
- "git help <tab>" does not show truly external commands anymore
  (those that are in $PATH but not in libexec and very unlikely to
  have a man page)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 91f7eaed7b..9e81dcf867 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1345,13 +1345,11 @@ credentialCache.ignoreSIGHUP::
 
 completion.commands::
 	This is only used by git-completion.bash to add or remove
-	commands from the complete list. Normally only porcelain
-	commands and a few select others are in the complete list. You
+	commands from the list of completed commands. Normally only
+	porcelain commands and a few select others are completed. You
 	can add more commands, separated by space, in this
 	variable. Prefixing the command with '-' will remove it from
 	the existing list.
-+
-This variable should not be per-repository.
 
 include::diff-config.txt[]
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4767860e72..6f7eddf847 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -163,6 +163,16 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
+--list-cmds=group[,group...]::
+	List commands by group. This is an internal/experimental
+	option and may change or be removed in the future. Supported
+	groups are: builtins, parseopt (builtin commands that use
+	parse-options), main (all commands in libexec directory),
+	others (all other commands in `$PATH` that have git- prefix),
+	list-<category> (see categories in command-list.txt),
+	nohelpers (exclude helper commands), alias and config
+	(retrieve command list from config variable completion.commands)
+
 GIT COMMANDS
 ------------
 
diff --git a/alias.c b/alias.c
index bf146e5263..a7e4e57130 100644
--- a/alias.c
+++ b/alias.c
@@ -1,9 +1,12 @@
 #include "cache.h"
+#include "alias.h"
 #include "config.h"
+#include "string-list.h"
 
 struct config_alias_data {
 	const char *alias;
 	char *v;
+	struct string_list *list;
 };
 
 static int config_alias_cb(const char *key, const char *value, void *d)
@@ -11,8 +14,16 @@ static int config_alias_cb(const char *key, const char *value, void *d)
 	struct config_alias_data *data = d;
 	const char *p;
 
-	if (skip_prefix(key, "alias.", &p) && !strcasecmp(p, data->alias))
-		return git_config_string((const char **)&data->v, key, value);
+	if (!skip_prefix(key, "alias.", &p))
+		return 0;
+
+	if (data->alias) {
+		if (!strcasecmp(p, data->alias))
+			return git_config_string((const char **)&data->v,
+						 key, value);
+	} else if (data->list) {
+		string_list_append(data->list, p);
+	}
 
 	return 0;
 }
@@ -26,6 +37,13 @@ char *alias_lookup(const char *alias)
 	return data.v;
 }
 
+void list_aliases(struct string_list *list)
+{
+	struct config_alias_data data = { NULL, NULL, list };
+
+	read_early_config(config_alias_cb, &data);
+}
+
 #define SPLIT_CMDLINE_BAD_ENDING 1
 #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
 static const char *split_cmdline_errors[] = {
diff --git a/alias.h b/alias.h
new file mode 100644
index 0000000000..79933f2457
--- /dev/null
+++ b/alias.h
@@ -0,0 +1,12 @@
+#ifndef __ALIAS_H__
+#define __ALIAS_H__
+
+struct string_list;
+
+char *alias_lookup(const char *alias);
+int split_cmdline(char *cmdline, const char ***argv);
+/* Takes a negative value returned by split_cmdline */
+const char *split_cmdline_strerror(int cmdline_errno);
+void list_aliases(struct string_list *list);
+
+#endif
diff --git a/builtin/help.c b/builtin/help.c
index 5727fb5e51..6b4b3df90d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -9,6 +9,7 @@
 #include "run-command.h"
 #include "column.h"
 #include "help.h"
+#include "alias.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
diff --git a/builtin/merge.c b/builtin/merge.c
index 9db5a2cf16..e3681cd850 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -34,6 +34,7 @@
 #include "string-list.h"
 #include "packfile.h"
 #include "tag.h"
+#include "alias.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/cache.h b/cache.h
index bbaf5c349a..111116ea13 100644
--- a/cache.h
+++ b/cache.h
@@ -1835,11 +1835,6 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
 
-char *alias_lookup(const char *alias);
-int split_cmdline(char *cmdline, const char ***argv);
-/* Takes a negative value returned by split_cmdline */
-const char *split_cmdline_strerror(int cmdline_errno);
-
 /* setup.c */
 struct startup_info {
 	int have_repository;
diff --git a/command-list.txt b/command-list.txt
index 8462ea475f..e505a1e34c 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -125,7 +125,7 @@ git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
 git-mv                                  mainporcelain           worktree
-git-name-rev                            plumbinginterrogators           complete
+git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
 git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
diff --git a/connect.c b/connect.c
index c3a014c5ba..ff078d28dc 100644
--- a/connect.c
+++ b/connect.c
@@ -13,6 +13,7 @@
 #include "transport.h"
 #include "strbuf.h"
 #include "protocol.h"
+#include "alias.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f237eb0ff4..e5b2ccbdd2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -38,29 +38,6 @@
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
 #     completion (e.g., completing "foo" when "origin/foo" exists).
-#
-#   GIT_COMPLETION_CMD_GROUPS
-#
-#     When set, "git --list-cmds=$GIT_COMPLETION_CMD_GROUPS" will be
-#     used to get the list of completable commands. The default is
-#     "mainporcelain,others,list-complete" (in English: all porcelain
-#     commands and external ones are included. Certain non-porcelain
-#     commands are also marked for completion in command-list.txt).
-#     You could for example complete all commands with
-#
-#         GIT_COMPLETION_CMD_GROUPS=main,others
-#
-#     Or you could go with main porcelain only and extra commands in
-#     the configuration variable completion.commands with
-#
-#         GIT_COMPLETION_CMD_GROUPS=mainporcelain,config
-#
-#     Or go completely custom group with
-#
-#         GIT_COMPLETION_CMD_GROUPS=config
-#
-#     Or you could even play with other command categories found in
-#     command-list.txt.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -857,66 +834,11 @@ __git_complete_strategy ()
 	return 1
 }
 
-# __git_commands requires 1 argument:
-# 1: the command group, either "all" or "porcelain"
-__git_commands () {
-	case "$1" in
-	porcelain)
-		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
-		then
-			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
-		elif test -n "$GIT_COMPLETION_CMD_GROUPS"
-		then
-			git --list-cmds="$GIT_COMPLETION_CMD_GROUPS"
-		else
-			git --list-cmds=list-mainporcelain,others,list-complete,config
-		fi
-		;;
-	all)
-		if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
-		then
-			printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST"
-		else
-			git --list-cmds=main,others
-		fi
-		;;
-	esac
-}
-
-__git_list_commands ()
-{
-	local i IFS=" "$'\n'
-	for i in $(__git_commands $1)
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		*) echo $i;;
-		esac
-	done
-}
-
-__git_list_all_commands ()
-{
-	__git_list_commands all
-}
-
 __git_all_commands=
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=$(__git_list_all_commands)
-}
-
-__git_list_porcelain_commands ()
-{
-	__git_list_commands porcelain
-}
-
-__git_porcelain_commands=
-__git_compute_porcelain_commands ()
-{
-	test -n "$__git_porcelain_commands" ||
-	__git_porcelain_commands=$(__git_list_porcelain_commands)
+	__git_all_commands=$(git --list-cmds=main,others,alias,nohelpers)
 }
 
 # Lists all set config variables starting with the given section prefix,
@@ -934,11 +856,6 @@ __git_pretty_aliases ()
 	__git_get_config_variables "pretty"
 }
 
-__git_aliases ()
-{
-	__git_get_config_variables "alias"
-}
-
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
@@ -1538,13 +1455,6 @@ _git_grep ()
 	__git_complete_refs
 }
 
-__git_all_guides=
-__git_compute_all_guides ()
-{
-	test -n "$__git_all_guides" ||
-	__git_all_guides=$(git --list-cmds=list-guide)
-}
-
 _git_help ()
 {
 	case "$cur" in
@@ -1553,11 +1463,12 @@ _git_help ()
 		return
 		;;
 	esac
-	__git_compute_all_commands
-	__git_compute_all_guides
-	__gitcomp "$__git_all_commands $(__git_aliases) $__git_all_guides
-		gitk
-		"
+	if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
+	then
+		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(git --list-cmds=alias,list-guide) gitk"
+	else
+		__gitcomp "$(git --list-cmds=main,nohelpers,alias,list-guide) gitk"
+	fi
 }
 
 _git_init ()
@@ -3096,8 +3007,14 @@ __git_main ()
 			--help
 			"
 			;;
-		*)     __git_compute_porcelain_commands
-		       __gitcomp "$__git_porcelain_commands $(__git_aliases)" ;;
+		*)
+			if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+			then
+				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+			else
+				__gitcomp "$(git --list-cmds=list-mainporcelain,others,nohelpers,alias,list-complete,config)"
+			fi
+			;;
 		esac
 		return
 	fi
diff --git a/git.c b/git.c
index ea4feedd0b..447dac0e71 100644
--- a/git.c
+++ b/git.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "help.h"
 #include "run-command.h"
+#include "alias.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
@@ -38,6 +39,18 @@ static int use_pager = -1;
 
 static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
+static void exclude_helpers_from_list(struct string_list *list)
+{
+	int i = 0;
+
+	while (i < list->nr) {
+		if (strstr(list->items[i].string, "--"))
+			unsorted_string_list_delete_item(list, i, 0);
+		else
+			i++;
+	}
+}
+
 static int match_token(const char *spec, int len, const char *token)
 {
 	int token_len = strlen(token);
@@ -60,6 +73,10 @@ static int list_cmds(const char *spec)
 			list_all_main_cmds(&list);
 		else if (match_token(spec, len, "others"))
 			list_all_other_cmds(&list);
+		else if (match_token(spec, len, "nohelpers"))
+			exclude_helpers_from_list(&list);
+		else if (match_token(spec, len, "alias"))
+			list_aliases(&list);
 		else if (match_token(spec, len, "config"))
 			list_cmds_by_config(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
diff --git a/pager.c b/pager.c
index 92b23e6cd1..1f4688fa03 100644
--- a/pager.c
+++ b/pager.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "alias.h"
 
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
diff --git a/sequencer.c b/sequencer.c
index 667f35ebdf..1288a36ebd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "alias.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
diff --git a/shell.c b/shell.c
index 234b2d4f16..3ce77b8e34 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "alias.h"
 
 #define COMMAND_DIR "git-shell-commands"
 #define HELP_COMMAND COMMAND_DIR "/help"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2f16679380..5863b1acac 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1192,17 +1192,6 @@ test_expect_success '__git_pretty_aliases' '
 	test_cmp expect actual
 '
 
-test_expect_success '__git_aliases' '
-	cat >expect <<-EOF &&
-	ci
-	co
-	EOF
-	test_config alias.ci commit &&
-	test_config alias.co checkout &&
-	__git_aliases >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
@@ -1511,13 +1500,6 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_success 'sourcing the completion script clears cached porcelain commands' '
-	__git_compute_porcelain_commands &&
-	verbose test -n "$__git_porcelain_commands" &&
-	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
-	verbose test -z "$__git_porcelain_commands"
-'
-
 test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&


Nguyễn Thái Ngọc Duy (17):
  generate-cmds.sh: factor out synopsis extract code
  generate-cmds.sh: export all commands to command-list.h
  help: use command-list.h for common command list
  Remove common-cmds.h
  git.c: convert --list-* to --list-cmds=*
  git --list-cmds: collect command list in a string_list
  completion: implement and use --list-cmds=main,others
  git: support --list-cmds=list-<category>
  help: add "-a --verbose" to list all commands with synopsis
  help: use command-list.txt for the source of guides
  command-list.txt: documentation and guide line
  completion: let git provide the completable command list
  completion: reduce completable command list
  Move declaration for alias.c to alias.h
  completion: add and use --list-cmds=nohelpers
  completion: add and use --list-cmds=alias
  completion: allow to customize the completable command list

 .gitignore                             |   2 +-
 Documentation/config.txt               |   8 +
 Documentation/git-help.txt             |   4 +-
 Documentation/git.txt                  |  10 +
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 Makefile                               |  16 +-
 alias.c                                |  22 ++-
 alias.h                                |  12 ++
 builtin/help.c                         |  40 +---
 builtin/merge.c                        |   1 +
 cache.h                                |   5 -
 command-list.txt                       | 110 ++++++++---
 connect.c                              |   1 +
 contrib/completion/git-completion.bash | 147 ++-------------
 generate-cmdlist.sh                    | 126 ++++++++-----
 git.c                                  |  85 ++++++++-
 help.c                                 | 244 ++++++++++++++++++++++---
 help.h                                 |  10 +
 pager.c                                |   1 +
 sequencer.c                            |   1 +
 shell.c                                |   1 +
 t/t0012-help.sh                        |  26 ++-
 t/t9902-completion.sh                  |  23 +--
 25 files changed, 589 insertions(+), 312 deletions(-)
 create mode 100644 alias.h

-- 
2.17.0.705.g3525833791

