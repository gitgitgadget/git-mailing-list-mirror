Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00DE81F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031758AbeEZNzs (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:55:48 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46952 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031655AbeEZNzo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:44 -0400
Received: by mail-wr0-f170.google.com with SMTP id v13-v6so1822792wrp.13
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2knQNxygcWVGA9/HyODoHJurzs5rmfCP07BkRG2U8iA=;
        b=gCjexpCM5jrBb1aXPbJcgHQWzub/ilb6nYO1gaftmiFOrk+r72gFZJhttX3Zmkp0RF
         XC60HT2A+Br+HH8cn4Zl/PHsaMUkrRtJTts6SuDjH81fYaX3KG54NsVHHc0LsPrvFw63
         Sv5rRyLS4XqeqX0vfe+jGFPbaRTBkX6FswFS7Z3m0X0TN4hf9FOP7gwt0eg9gSCk+bfS
         v9TDSsraw76JqIPyLuL+Vit19DTTWyehcUiWejeTUZWXmtfue0pCjKn0vTUEf0dOoKiX
         jlv+HEtjCZvtiC85Pg5hmKsqD82XUQvtpyQBfBDfzZZr6PtWKBCoABU4LL0Ss2VNfRbS
         fbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2knQNxygcWVGA9/HyODoHJurzs5rmfCP07BkRG2U8iA=;
        b=oXyhmbV4u97jpeGCU7SjJY8dwpGdgUutGIdPRVm/NxMJEd3cI/0VKANkrWCGfDuxKc
         0GOvk2pO8XD5SJz7klTU/8hVbgBN8zf6B8V74hTkke5pbhjeBv2WU+kFJRqDlicRCZLI
         h9F7+gWQ6VK8RT+5sMmhcQ1XxVlwVWGr0/bBFoM/IJvslNs+6R4P7Ws/yCcoGUxMIFA8
         xccCPMurAzIi631O6KyEBT2PbkgwExs4xZHYU0+UuMi16WgRzrDnt8yTcLcphWIpBp31
         IbAAkY7+IL4nZ2OCknu3NIqBAL1zJoLmE0WMTz7yj5n8HY+ZQuslnZph17MhEbLFg2WU
         3OYQ==
X-Gm-Message-State: ALKqPwfln47MSTpE5Hzqj933jvIB0YeBOcsiEiJhfKaVs3E5lkUJVJT3
        elkdsGrCeXxpICgUjdfEoBY=
X-Google-Smtp-Source: ADUXVKI3KgDjT+QEGHsf7ODRV1+1RANXH3YN5WUXJqp6xGMNqwhFJRfH8GEamOCLEnYWqg6k+DaKvw==
X-Received: by 2002:a19:9f8e:: with SMTP id i136-v6mr3636249lfe.5.1527342942786;
        Sat, 26 May 2018 06:55:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/11] help: add --config to list all available config
Date:   Sat, 26 May 2018 15:55:24 +0200
Message-Id: <20180526135531.4516-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it helps to list all available config vars so the user can
search for something they want. The config man page can also be used
but it's harder to search if you want to focus on the variable name,
for example.

This is not the best way to collect the available config since it's
not precise. Ideally we should have a centralized list of config in C
code (pretty much like 'struct option'), but that's a lot more work.
This will do for now.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-help.txt |  5 ++++
 advice.c                   |  9 ++++++
 builtin/branch.c           |  3 ++
 builtin/clean.c            |  3 ++
 builtin/commit.c           |  3 ++
 builtin/help.c             |  9 ++++++
 diff.c                     |  3 ++
 fsck.c                     | 12 ++++++++
 generate-cmdlist.sh        | 19 +++++++++++++
 grep.c                     |  3 ++
 help.c                     | 56 ++++++++++++++++++++++++++++++++++++++
 help.h                     | 45 +++++++++++++++++++++++++++++-
 log-tree.c                 |  3 ++
 13 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index a40fc38d8b..83d25d825a 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -45,6 +45,11 @@ OPTIONS
 	When used with `--verbose` print description for all recognized
 	commands.
 
+-c::
+--config::
+	List all available configuration variables. This is a short
+	summary of the list in linkgit:git-config[1].
+
 -g::
 --guides::
 	Prints a list of useful guides on the standard output. This
diff --git a/advice.c b/advice.c
index 370a56d054..cf6c673ed7 100644
--- a/advice.c
+++ b/advice.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "help.h"
 
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
@@ -131,6 +132,14 @@ int git_default_advice_config(const char *var, const char *value)
 	return 0;
 }
 
+void list_config_advices(struct string_list *list, const char *prefix)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
+		list_config_item(list, prefix, advice_config[i].name);
+}
+
 int error_resolve_conflict(const char *me)
 {
 	if (!strcmp(me, "cherry-pick"))
diff --git a/builtin/branch.c b/builtin/branch.c
index 09232576b6..ddc48ca931 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -22,6 +22,7 @@
 #include "wt-status.h"
 #include "ref-filter.h"
 #include "worktree.h"
+#include "help.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -67,6 +68,8 @@ static const char *color_branch_slots[] = {
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
+define_list_config_array(color_branch_slots);
+
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
diff --git a/builtin/clean.c b/builtin/clean.c
index 0ccd95e693..ab402c204c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,6 +16,7 @@
 #include "column.h"
 #include "color.h"
 #include "pathspec.h"
+#include "help.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -91,6 +92,8 @@ struct menu_stuff {
 	void *stuff;
 };
 
+define_list_config_array(color_interactive_slots);
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
diff --git a/builtin/commit.c b/builtin/commit.c
index 2b43a6c48a..9bcbb0c25c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -32,6 +32,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "mailmap.h"
+#include "help.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1195,6 +1196,8 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix,
 	return commitable ? 0 : 1;
 }
 
+define_list_config_array_extra(color_status_slots, {"added"});
+
 static int parse_status_slot(const char *slot)
 {
 	if (!strcasecmp(slot, "added"))
diff --git a/builtin/help.c b/builtin/help.c
index 58e0a5507f..ccb206e1d4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -37,6 +37,7 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
+static int show_config;
 static int verbose;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
@@ -45,6 +46,7 @@ static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
+	OPT_BOOL('c', "config", &show_config, N_("print all configuration variable names")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -444,6 +446,13 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		list_commands(colopts, &main_cmds, &other_cmds);
 	}
 
+	if (show_config) {
+		setup_pager();
+		list_config_help();
+		printf("\n%s\n", _("'git help config' for more information"));
+		return 0;
+	}
+
 	if (show_guides)
 		list_common_guides_help();
 
diff --git a/diff.c b/diff.c
index 2e5e1404a5..c79f18869a 100644
--- a/diff.c
+++ b/diff.c
@@ -22,6 +22,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "help.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -93,6 +94,8 @@ static NORETURN void die_want_option(const char *option_name)
 	die(_("option '%s' requires a value"), option_name);
 }
 
+define_list_config_array_extra(color_diff_slots, {"plain"});
+
 static int parse_diff_color_slot(const char *var)
 {
 	if (!strcasecmp(var, "plain"))
diff --git a/fsck.c b/fsck.c
index e2a6f33891..b65ff2d856 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,6 +10,7 @@
 #include "utf8.h"
 #include "sha1-array.h"
 #include "decorate.h"
+#include "help.h"
 
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -120,6 +121,17 @@ static int parse_msg_id(const char *text)
 	return -1;
 }
 
+void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
+{
+	int i;
+
+	prepare_msg_ids();
+
+	/* TODO: we can do better by producing camelCase names */
+	for (i = 0; i < FSCK_MSG_MAX; i++)
+		list_config_item(list, prefix, msg_id_info[i].downcased);
+}
+
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 8d6d8b45ce..c4124acbe7 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -76,6 +76,23 @@ print_command_list () {
 	echo "};"
 }
 
+print_config_list () {
+	cat <<EOF
+static const char *config_name_list[] = {
+EOF
+	grep '^[a-zA-Z].*\..*::$' Documentation/config.txt |
+	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
+	sort |
+	while read line
+	do
+		echo "	\"$line\","
+	done
+	cat <<EOF
+	NULL,
+};
+EOF
+}
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
@@ -88,3 +105,5 @@ echo
 define_category_names "$1"
 echo
 print_command_list "$1"
+echo
+print_config_list
diff --git a/grep.c b/grep.c
index d94e2c4aeb..7c1b8e2e8b 100644
--- a/grep.c
+++ b/grep.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "quote.h"
+#include "help.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -80,6 +81,8 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 	die("bad %s argument: %s", opt, arg);
 }
 
+define_list_config_array_extra(color_grep_slots, {"match"});
+
 /*
  * Read the configuration file once and store it in
  * the grep_defaults template.
diff --git a/help.c b/help.c
index dd35fcc133..f078dfebad 100644
--- a/help.c
+++ b/help.c
@@ -409,6 +409,62 @@ void list_common_guides_help(void)
 	putchar('\n');
 }
 
+struct slot_expansion {
+	const char *prefix;
+	const char *placeholder;
+	void (*fn)(struct string_list *list, const char *prefix);
+	int found;
+};
+
+void list_config_help(void)
+{
+	struct slot_expansion slot_expansions[] = {
+		{ "advice", "*", list_config_advices },
+		{ "color.branch", "<slot>", list_config_color_branch_slots },
+		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
+		{ "color.diff", "<slot>", list_config_color_diff_slots },
+		{ "color.grep", "<slot>", list_config_color_grep_slots },
+		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
+		{ "color.status", "<slot>", list_config_color_status_slots },
+		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ NULL, NULL, NULL }
+	};
+	const char **p;
+	struct slot_expansion *e;
+	struct string_list keys = STRING_LIST_INIT_DUP;
+	int i;
+
+	for (p = config_name_list; *p; p++) {
+		const char *var = *p;
+		struct strbuf sb = STRBUF_INIT;
+
+		for (e = slot_expansions; e->prefix; e++) {
+
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
+			if (!strcasecmp(var, sb.buf)) {
+				e->fn(&keys, e->prefix);
+				e->found++;
+				break;
+			}
+		}
+		strbuf_release(&sb);
+		if (!e->prefix)
+			string_list_append(&keys, var);
+	}
+
+	for (e = slot_expansions; e->prefix; e++)
+		if (!e->found)
+			BUG("slot_expansion %s.%s is not used",
+			    e->prefix, e->placeholder);
+
+	string_list_sort(&keys);
+	for (i = 0; i < keys.nr; i++)
+		puts(keys.items[i].string);
+	string_list_clear(&keys, 0);
+}
+
 void list_all_cmds_help(void)
 {
 	print_cmd_by_category(main_categories);
diff --git a/help.h b/help.h
index 3b38292a1b..b46fe6ee73 100644
--- a/help.h
+++ b/help.h
@@ -1,7 +1,8 @@
 #ifndef HELP_H
 #define HELP_H
 
-struct string_list;
+#include "string-list.h"
+#include "strbuf.h"
 
 struct cmdnames {
 	int alloc;
@@ -21,6 +22,7 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
 extern void list_common_guides_help(void);
+extern void list_config_help(void);
 
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
@@ -42,4 +44,45 @@ extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, stru
  * ref to the command, to give suggested "correct" refs.
  */
 extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
+
+static inline void list_config_item(struct string_list *list,
+				    const char *prefix,
+				    const char *str)
+{
+	string_list_append_nodup(list, xstrfmt("%s.%s", prefix, str));
+}
+
+#define define_list_config_array(array)					\
+void list_config_##array(struct string_list *list, const char *prefix)	\
+{									\
+	int i;								\
+	for (i = 0; i < ARRAY_SIZE(array); i++)				\
+		if (array[i])						\
+			list_config_item(list, prefix, array[i]);	\
+}									\
+struct string_list
+
+#define define_list_config_array_extra(array, values)			\
+void list_config_##array(struct string_list *list, const char *prefix)	\
+{									\
+	int i;								\
+	static const char *extra[] = values;				\
+	for (i = 0; i < ARRAY_SIZE(extra); i++)				\
+		list_config_item(list, prefix, extra[i]);		\
+	for (i = 0; i < ARRAY_SIZE(array); i++)				\
+		if (array[i])						\
+			list_config_item(list, prefix, array[i]);	\
+}									\
+struct string_list
+
+/* These are actually scattered over many C files */
+void list_config_advices(struct string_list *list, const char *prefix);
+void list_config_color_branch_slots(struct string_list *list, const char *prefix);
+void list_config_color_decorate_slots(struct string_list *list, const char *prefix);
+void list_config_color_diff_slots(struct string_list *list, const char *prefix);
+void list_config_color_grep_slots(struct string_list *list, const char *prefix);
+void list_config_color_interactive_slots(struct string_list *list, const char *prefix);
+void list_config_color_status_slots(struct string_list *list, const char *prefix);
+void list_config_fsck_msg_ids(struct string_list *list, const char *prefix);
+
 #endif /* HELP_H */
diff --git a/log-tree.c b/log-tree.c
index 33be7f7a3d..284ce0e3c5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,6 +12,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "line-log.h"
+#include "help.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -42,6 +43,8 @@ static const char *decorate_get_color(int decorate_use_color, enum decoration_ty
 	return "";
 }
 
+define_list_config_array(color_decorate_slots);
+
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value)
 {
 	int slot = LOOKUP_CONFIG(color_decorate_slots, slot_name);
-- 
2.17.0.705.g3525833791

