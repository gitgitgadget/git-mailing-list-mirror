Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6CB200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeEGRxC (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42970 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeEGRxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id u21-v6so41884221lfu.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjilRRYx4u9oeIedE3D1cwcLubB8pukt9jI7T8hj7EQ=;
        b=lDxdNxVOhjUU6V8voGekR30IIujX+52K4XX+pcYWv806wfkcwizqHiqztmLlKQy7yA
         QNyvpLZY1+QDwrDq919gjgW22mvxwur5+tEFiZa0Qbs8bK93riLFV/cSCW0G5km4zW+R
         ScE5TAHs2HZXenBJDtedFmufse8HgR8eDF3RPQvIHeaIFkf0MT9fWqG2woLX2JkcZMW6
         mY0Ic6M8i8fdcRgHAf1HmXXEJEbbY//q1B8BKsQwvP+xxuxZT17/dl4ceLWq4pRNb+MD
         OGI2XAVo56zD8DMHrZ4UGg3h/u8F/Ojrb4aZfGXflj5fPYYYKQeDlajd/2L4vnCT4hm9
         Dtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjilRRYx4u9oeIedE3D1cwcLubB8pukt9jI7T8hj7EQ=;
        b=oTWtSO/d0h0aBxaXv4kiveS/Uk2kNfzsURpltRR5hzba+Tui3g7b8IYDuuJRrgmqFd
         /2h9Ly4E7jlyO4j9dbHWrWy+gD6UG/T54yLHAXZIqDzlaHig5gY+x1VA0+p5qouDsimD
         Y6UqFo8k37EP7TL7pgyrsuxBOdd6knAeeS2BpmUbFHZgf1CzZu7iXxuSBWH9NPObpV8h
         Kl/dZ+bPou4CsWe/UIa4oPRM5jlbsnoP+yPmjQUc5Pelsa/FTQtdMDCN9s/rrSezdNOh
         JNW7OMR4QsnbGdj1FhKfOlotV8FITAk/8CT/+3NqiUsQeYHGfjQ0n+TUhdUQD7i0CuEZ
         Q3gw==
X-Gm-Message-State: ALQs6tDr/fhBntp9kCYVu+xJEETUJCNDKeMdC4XSJLR+T1U7RWvb+SLt
        hO6PN+kdKm/Vqm1V+LFXAO0=
X-Google-Smtp-Source: AB8JxZp83axIUeaFk0utoh/gSuoEHYv8doOCPi1GtTfCKQWRUYHUq9SqnsTsAihkuIawazEaXNQAOA==
X-Received: by 2002:a19:a688:: with SMTP id p130-v6mr8360986lfe.4.1525715579629;
        Mon, 07 May 2018 10:52:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:52:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 00/13] Keep all info in command-list.txt in git binary
Date:   Mon,  7 May 2018 19:52:09 +0200
Message-Id: <20180507175222.12114-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 is now "feature complete". v6 adds

- documentation in command-list.txt so people know how to update it
- support for config key completion.commands, which consists
  of extra commands. It could also be used for excluding some
  commands.

Interdiff

diff --git a/command-list.txt b/command-list.txt
index 40776b9587..3e21ddfcfb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,47 @@
+# Command classification list
+# ---------------------------
+# All supported commands, builtin or external, must be described in
+# here. This info is used to list commands in various places. Each
+# command is on one line followed by one or more attributes.
+#
+# The first attribute group is mandatory and indicates the command
+# type. This group includes:
+#
+#   mainporcelain
+#   ancillarymanipulators
+#   ancillaryinterrogators
+#   foreignscminterface
+#   plumbingmanipulators
+#   plumbinginterrogators
+#   synchingrepositories
+#   synchelpers
+#   purehelpers
+#
+# The type names are self explanatory. But if you want to see what
+# command belongs to what group to get a better picture, have a look
+# at "git" man page, "GIT COMMANDS" section.
+#
+# Commands of type mainporcelain can also optionally have one of these
+# attributes:
+#
+#   init
+#   worktree
+#   info
+#   history
+#   remote
+#
+# These commands are considered "common" and will show up in "git
+# help" output in groups. Uncommon porcelain commands must not
+# specify any of these attributes.
+#
+# "complete" attribute is used to mark that the command should be
+# completable by git-completion.bash. Note that by default,
+# mainporcelain commands are completable so you don't need this
+# attribute.
+#
+# While not true commands, guides are also specified here, which can
+# only have "guide" attribute and nothing else.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 908692ea52..0fd29803d5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -38,6 +38,38 @@
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
 #     completion (e.g., completing "foo" when "origin/foo" exists).
+#
+#   GIT_COMPLETION_CMD_GROUPS
+#
+#     When set, "git --list-cmds=$GIT_COMPLETION_CMD_GROUPS" will be
+#     used to get the list of completable commands. The default is
+#     "mainporcelain,others,list-complete" (in English: all porcelain
+#     commands and external ones are included. Certain non-porcelain
+#     commands are also marked for completion in command-list.txt).
+#     You could for example complete all commands with
+#
+#         GIT_COMPLETION_CMD_GROUPS=main,others
+#
+#     Or you could go with defaults add some extra commands specified
+#     in the configuration variable completion.commands [1] with
+#
+#         GIT_COMPLETION_CMD_GROUPS=mainporcelain,others,list-complete,config
+#
+#     Or go completely custom group with
+#
+#         GIT_COMPLETION_CMD_GROUPS=config
+#
+#     Or you could even play with other command categories found in
+#     command-list.txt.
+#
+#     [1] Note that completion.commands should not be per-repository
+#         since the command list is generated once and cached.
+#
+#         completion.commands could be used to exclude commands as
+#         well.  If a command in this list begins with '-', then it
+#         will be excluded from the list of commands gathered by the
+#         groups specified before "config" in
+#         $GIT_COMPLETION_CMD_GROUPS.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -840,6 +872,9 @@ __git_commands () {
 		if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 		then
 			printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
+		elif test -n "$GIT_COMPLETION_CMD_GROUPS"
+		then
+			git --list-cmds="$GIT_COMPLETION_CMD_GROUPS"
 		else
 			git --list-cmds=list-mainporcelain,others,list-complete
 		fi
diff --git a/git.c b/git.c
index 1c8b0c93e1..fd08911e11 100644
--- a/git.c
+++ b/git.c
@@ -36,27 +36,30 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(unsigned int exclude_option, char sep);
+static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
 static int list_cmds(const char *spec)
 {
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int i;
+
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
 		int len = sep - spec;
 
 		if (len == 8 && !strncmp(spec, "builtins", 8))
-			list_builtins(0, '\n');
-		else if (len == 8 && !strncmp(spec, "parseopt", 8))
-			list_builtins(NO_PARSEOPT, ' ');
+			list_builtins(&list, 0);
 		else if (len == 4 && !strncmp(spec, "main", 4))
-			list_all_main_cmds();
+			list_all_main_cmds(&list);
 		else if (len == 6 && !strncmp(spec, "others", 6))
-			list_all_other_cmds();
+			list_all_other_cmds(&list);
+		else if (len == 6 && !strncmp(spec, "config", 6))
+			list_cmds_by_config(&list);
 		else if (len > 5 && !strncmp(spec, "list-", 5)) {
 			struct strbuf sb = STRBUF_INIT;
 
 			strbuf_add(&sb, spec + 5, len - 5);
-			list_cmds_by_category(sb.buf);
+			list_cmds_by_category(&list, sb.buf);
 			strbuf_release(&sb);
 		}
 		else
@@ -65,6 +68,9 @@ static int list_cmds(const char *spec)
 		if (*spec == ',')
 			spec++;
 	}
+	for (i = 0; i < list.nr; i++)
+		puts(list.items[i].string);
+	string_list_clear(&list, 0);
 	return 0;
 }
 
@@ -254,7 +260,18 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argv)++;
 			(*argc)--;
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
-			exit(list_cmds(cmd));
+			if (!strcmp(cmd, "parseopt")) {
+				struct string_list list = STRING_LIST_INIT_DUP;
+				int i;
+
+				list_builtins(&list, NO_PARSEOPT);
+				for (i = 0; i < list.nr; i++)
+					printf("%s ", list.items[i].string);
+				string_list_clear(&list, 0);
+				exit(0);
+			} else {
+				exit(list_cmds(cmd));
+			}
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
@@ -534,14 +551,14 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(unsigned int exclude_option, char sep)
+static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (exclude_option &&
 		    (commands[i].option & exclude_option))
 			continue;
-		printf("%s%c", commands[i].cmd, sep);
+		string_list_append(out, commands[i].cmd);
 	}
 }
 
diff --git a/help.c b/help.c
index 78ab40a0eb..abf87205b2 100644
--- a/help.c
+++ b/help.c
@@ -310,7 +310,7 @@ void list_common_cmds_help(void)
 	print_cmd_by_category(common_categories);
 }
 
-void list_all_main_cmds(void)
+void list_all_main_cmds(struct string_list *list)
 {
 	struct cmdnames main_cmds, other_cmds;
 	int i;
@@ -320,13 +320,13 @@ void list_all_main_cmds(void)
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	for (i = 0; i < main_cmds.cnt; i++)
-		puts(main_cmds.names[i]->name);
+		string_list_append(list, main_cmds.names[i]->name);
 
 	clean_cmdnames(&main_cmds);
 	clean_cmdnames(&other_cmds);
 }
 
-void list_all_other_cmds(void)
+void list_all_other_cmds(struct string_list *list)
 {
 	struct cmdnames main_cmds, other_cmds;
 	int i;
@@ -336,13 +336,14 @@ void list_all_other_cmds(void)
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	for (i = 0; i < other_cmds.cnt; i++)
-		puts(other_cmds.names[i]->name);
+		string_list_append(list, other_cmds.names[i]->name);
 
 	clean_cmdnames(&main_cmds);
 	clean_cmdnames(&other_cmds);
 }
 
-void list_cmds_by_category(const char *cat)
+void list_cmds_by_category(struct string_list *list,
+			   const char *cat)
 {
 	int i, n = ARRAY_SIZE(command_list);
 	uint32_t cat_id = 0;
@@ -359,8 +360,42 @@ void list_cmds_by_category(const char *cat)
 	for (i = 0; i < n; i++) {
 		struct cmdname_help *cmd = command_list + i;
 
-		if (cmd->category & cat_id)
-			puts(drop_prefix(cmd->name, cmd->category));
+		if (!(cmd->category & cat_id))
+			continue;
+		string_list_append(list, drop_prefix(cmd->name, cmd->category));
+	}
+}
+
+void list_cmds_by_config(struct string_list *list)
+{
+	const char *cmd_list;
+
+	/*
+	 * There's no actual repository setup at this point (and even
+	 * if there is, we don't really care; only global config
+	 * matters). If we accidentally set up a repository, it's ok
+	 * too since the caller (git --list-cmds=) should exit shortly
+	 * anyway.
+	 */
+	if (git_config_get_string_const("completion.commands", &cmd_list))
+		return;
+
+	string_list_sort(list);
+	string_list_remove_duplicates(list, 0);
+
+	while (*cmd_list) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *p = strchrnul(cmd_list, ' ');
+
+		strbuf_add(&sb, cmd_list, p - cmd_list);
+		if (*cmd_list == '-')
+			string_list_remove(list, cmd_list + 1, 0);
+		else
+			string_list_insert(list, sb.buf);
+		strbuf_release(&sb);
+		while (*p == ' ')
+			p++;
+		cmd_list = p;
 	}
 }
 
diff --git a/help.h b/help.h
index 5d27368fe4..3b38292a1b 100644
--- a/help.h
+++ b/help.h
@@ -1,6 +1,8 @@
 #ifndef HELP_H
 #define HELP_H
 
+struct string_list;
+
 struct cmdnames {
 	int alloc;
 	int cnt;
@@ -19,9 +21,12 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
 extern void list_common_guides_help(void);
-extern void list_all_main_cmds(void);
-extern void list_all_other_cmds(void);
-extern void list_cmds_by_category(const char *category);
+
+extern void list_all_main_cmds(struct string_list *list);
+extern void list_all_other_cmds(struct string_list *list);
+extern void list_cmds_by_category(struct string_list *list,
+				  const char *category);
+extern void list_cmds_by_config(struct string_list *list);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,

Nguyễn Thái Ngọc Duy (13):
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
  completion: allow to customize the completable command list

 .gitignore                             |   2 +-
 Documentation/git-help.txt             |   4 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitmodules.txt           |   2 +-
 Documentation/gitrevisions.txt         |   2 +-
 Makefile                               |  16 +-
 builtin/help.c                         |  39 +---
 command-list.txt                       | 111 ++++++++---
 contrib/completion/git-completion.bash | 169 ++++++++---------
 generate-cmdlist.sh                    | 126 ++++++++-----
 git.c                                  |  61 ++++++-
 help.c                                 | 244 ++++++++++++++++++++++---
 help.h                                 |  10 +
 t/t0012-help.sh                        |  26 ++-
 t/t9902-completion.sh                  |   5 +-
 15 files changed, 565 insertions(+), 254 deletions(-)

-- 
2.17.0.705.g3525833791

