Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207EB1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbeEJOT7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45497 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965516AbeEJOTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id q2-v6so3199572lfc.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXHkMB4Z15bHac3ZlLA00B5lHrzt0Sj3frH/xNA5Img=;
        b=SVqHZw8990urcD7DTHeBfc9+zUq4GSVH5O6/HlTp3UQ6t80++5Hggarkjc4DtqEm+o
         eNqGFc8maQgx9IwnzeCxGqcMiJ0EQk0vMoquoLZSdyhq1VgDbs1UKUEXK7x74CwGzF+a
         LWSbz+ZlsfuWDtxNkLnGa/nl5HZW1+aXl4xACR0/L9ROBrACuClhqIp8geJlzrIIFb/Z
         oOxGcHgne5mlYdbkf+EXUsyxOzulswRRjKYNRtLLBhRvZxXFLbKC+WO0ytWnfVGdTpyz
         SGZsjV0VsC17omPgkUpAkN0+k8Hx8dsNtuxBXwYKcZbwJIP81d22D4BZrpLKj9kdlyWY
         e20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXHkMB4Z15bHac3ZlLA00B5lHrzt0Sj3frH/xNA5Img=;
        b=BQZqtiglyqa8BWorGQf/KvSUgYYeIzm3Lu/BMcIPQiHSfYTNzeJ2c5lkp3sy00XpGO
         B+SX6C8KTogNvRX8Qtkq9M0xhzb5OgMfd/EOZED+c3pr8wdKEOi9RfxQnbsFfzTidi9h
         EPxvu47NymCH1V3i33ROqex1TvWaFdBs+5d5TQOCEFrSCLgi7mlzpfSl5MO6hVXa8QVT
         0GNLURh21sGXtfy2skB2AHjXwUNYs5Q/5PobjAEr/VvQYdLY84ba03xjiFr9x0Hkao2M
         jxKqgeKGNTD2RX+F5t+x74pjuQP6Xe9Zy2jWQTgsGrfrGyJwNprq1gsR+W6M+wspS0HG
         NaXA==
X-Gm-Message-State: ALKqPwdC2MCoa3jF4ECzW+jeqRHuocXJ+BnIE1jc6MZVa63XeAx3a8JE
        EvBJRLZ5U0t1oJaZF0k9Egsm6g==
X-Google-Smtp-Source: AB8JxZotH+Rar13u1DTZY8QtYmw904tAXJhTNQfO9zPvdwMIGoqiSoSLeAy31RcNbTuaWlxrTlrhaA==
X-Received: by 2002:a2e:7d1a:: with SMTP id y26-v6mr1274597ljc.135.1525961975786;
        Thu, 10 May 2018 07:19:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/9] help: add --config to list all available config
Date:   Thu, 10 May 2018 16:19:22 +0200
Message-Id: <20180510141927.23590-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-help.txt |  5 ++++
 advice.c                   |  9 +++++++
 builtin/branch.c           |  6 +++++
 builtin/clean.c            |  6 +++++
 builtin/commit.c           |  7 ++++++
 builtin/help.c             |  9 +++++++
 diff.c                     |  7 ++++++
 fsck.c                     | 11 +++++++++
 generate-cmdlist.sh        | 20 ++++++++++++++++
 grep.c                     |  7 ++++++
 help.c                     | 48 ++++++++++++++++++++++++++++++++++++++
 help.h                     | 18 ++++++++++++++
 log-tree.c                 |  6 +++++
 13 files changed, 159 insertions(+)

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
index 406efc183b..b211ebc588 100644
--- a/advice.c
+++ b/advice.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "help.h"
 
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
@@ -84,6 +85,14 @@ int git_default_advice_config(const char *var, const char *value)
 	return 0;
 }
 
+void list_advices(const char *prefix)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
+		printf("%s.%s\n", prefix, advice_config[i].name);
+}
+
 int error_resolve_conflict(const char *me)
 {
 	if (!strcmp(me, "cherry-pick"))
diff --git a/builtin/branch.c b/builtin/branch.c
index b41f332589..23bbdcb301 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -22,6 +22,7 @@
 #include "wt-status.h"
 #include "ref-filter.h"
 #include "worktree.h"
+#include "help.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -67,6 +68,11 @@ static const char *color_branch_slots[] = {
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
+void list_color_branch_slots(const char *prefix)
+{
+	PRINT_ARRAY(prefix, color_branch_slots);
+}
+
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
diff --git a/builtin/clean.c b/builtin/clean.c
index 0ccd95e693..72cea1537e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,6 +16,7 @@
 #include "column.h"
 #include "color.h"
 #include "pathspec.h"
+#include "help.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -91,6 +92,11 @@ struct menu_stuff {
 	void *stuff;
 };
 
+void list_color_interactive_slots(const char *prefix)
+{
+	PRINT_ARRAY(prefix, color_interactive_slots);
+}
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
diff --git a/builtin/commit.c b/builtin/commit.c
index bee5825bd2..41c3c4f5cd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -32,6 +32,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "mailmap.h"
+#include "help.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1194,6 +1195,12 @@ static int parse_status_slot(const char *slot)
 	return LOOKUP_CONFIG(color_status_slots, slot);
 }
 
+void list_color_status_slots(const char *prefix)
+{
+	printf("%s.%s\n", prefix, "added");
+	PRINT_ARRAY(prefix, color_status_slots);
+}
+
 static int git_status_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
diff --git a/builtin/help.c b/builtin/help.c
index 5727fb5e51..a1153cf473 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,6 +36,7 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
+static int show_config;
 static int verbose;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
@@ -44,6 +45,7 @@ static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
+	OPT_BOOL('c', "config", &show_config, N_("print list recognized config variables")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -443,6 +445,13 @@ int cmd_help(int argc, const char **argv, const char *prefix)
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
index 6f781a2c57..5cae59ec1a 100644
--- a/diff.c
+++ b/diff.c
@@ -22,6 +22,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "help.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -100,6 +101,12 @@ static int parse_diff_color_slot(const char *var)
 	return LOOKUP_CONFIG(color_diff_slots, var);
 }
 
+void list_color_diff_slots(const char *prefix)
+{
+	printf("%s.%s\n", prefix, "plain");
+	PRINT_ARRAY(prefix, color_diff_slots);
+}
+
 static int parse_dirstat_params(struct diff_options *options, const char *params_string,
 				struct strbuf *errmsg)
 {
diff --git a/fsck.c b/fsck.c
index f2534abd44..b9f5e7b3f1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,6 +10,7 @@
 #include "utf8.h"
 #include "sha1-array.h"
 #include "decorate.h"
+#include "help.h"
 
 #define FSCK_FATAL -1
 #define FSCK_INFO -2
@@ -118,6 +119,16 @@ static int parse_msg_id(const char *text)
 	return -1;
 }
 
+void list_fsck_msg_ids(const char *prefix)
+{
+	int i;
+
+	prepare_msg_ids();
+	/* TODO: we can do better by producing camelCase names */
+	for (i = 0; i < FSCK_MSG_MAX; i++)
+		printf("%s.%s\n", prefix, msg_id_info[i].downcased);
+}
+
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 8d6d8b45ce..25d4516f1f 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -76,6 +76,24 @@ print_command_list () {
 	echo "};"
 }
 
+print_config_list() {
+	cat <<EOF
+static const char *config_name_list[] = {
+EOF
+	grep '^[a-zA-Z].*\..*::$' Documentation/config.txt |
+	grep -v deprecated |
+	sed 's/::$//; s/,  */\n/g' |
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
@@ -88,3 +106,5 @@ echo
 define_category_names "$1"
 echo
 print_command_list "$1"
+echo
+print_config_list
diff --git a/grep.c b/grep.c
index 2f7ebe60f6..da6dc9af4f 100644
--- a/grep.c
+++ b/grep.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "commit.h"
 #include "quote.h"
+#include "help.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -133,6 +134,12 @@ int grep_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+void list_color_grep_slots(const char *prefix)
+{
+	printf("%s.%s\n", prefix, "match");
+	PRINT_ARRAY(prefix, color_grep_slots);
+}
+
 /*
  * Initialize one instance of grep_opt and copy the
  * default values from the template we read the configuration
diff --git a/help.c b/help.c
index abf87205b2..b10c8b0230 100644
--- a/help.c
+++ b/help.c
@@ -409,6 +409,54 @@ void list_common_guides_help(void)
 	putchar('\n');
 }
 
+struct slot_expansion {
+	const char *prefix;
+	const char *placeholder;
+	void (*fn)(const char *prefix);
+	int found;
+};
+
+void list_config_help(void)
+{
+	struct slot_expansion slot_expansions[] = {
+		{ "advice", "*", list_advices },
+		{ "color.branch", "<slot>", list_color_branch_slots },
+		{ "color.decorate", "<slot>", list_color_decorate_slots },
+		{ "color.diff", "<slot>", list_color_diff_slots },
+		{ "color.grep", "<slot>", list_color_grep_slots },
+		{ "color.interactive", "<slot>", list_color_interactive_slots },
+		{ "color.status", "<slot>", list_color_status_slots },
+		{ "fsck", "<msg-id>", list_fsck_msg_ids },
+		{ "receive.fsck", "<msg-id>", list_fsck_msg_ids },
+		{ NULL, NULL, NULL }
+	};
+	const char **p;
+	struct slot_expansion *e;
+
+	for (p = config_name_list; *p; p++) {
+		const char *var = *p;
+
+		for (e = slot_expansions; e->prefix; e++) {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
+			if (strcasecmp(var, sb.buf))
+				continue;
+			e->fn(e->prefix);
+			strbuf_release(&sb);
+			e->found++;
+			break;
+		}
+		if (!e->prefix)
+			puts(var);
+	}
+
+	for (e = slot_expansions; e->prefix; e++)
+		if (!e->found)
+			BUG("slot_expansion %s.%s is not used",
+			    e->prefix, e->placeholder);
+}
+
 void list_all_cmds_help(void)
 {
 	print_cmd_by_category(main_categories);
diff --git a/help.h b/help.h
index 3b38292a1b..d7d1409718 100644
--- a/help.h
+++ b/help.h
@@ -21,6 +21,7 @@ static inline void mput_char(char c, unsigned int num)
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
 extern void list_common_guides_help(void);
+extern void list_config_help(void);
 
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
@@ -42,4 +43,21 @@ extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, stru
  * ref to the command, to give suggested "correct" refs.
  */
 extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
+
+/* These are actually scattered over many C files */
+#define PRINT_ARRAY(prefix, array)  {					\
+		int i;							\
+		for (i = 0; i < ARRAY_SIZE(array); i++)			\
+			if (array[i])					\
+				printf("%s.%s\n", prefix, array[i]);	\
+	}
+void list_advices(const char *prefix);
+void list_color_branch_slots(const char *prefix);
+void list_color_decorate_slots(const char *prefix);
+void list_color_diff_slots(const char *prefix);
+void list_color_grep_slots(const char *prefix);
+void list_color_interactive_slots(const char *prefix);
+void list_color_status_slots(const char *prefix);
+void list_fsck_msg_ids(const char *prefix);
+
 #endif /* HELP_H */
diff --git a/log-tree.c b/log-tree.c
index 093efb477e..19cfebd231 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,6 +12,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "line-log.h"
+#include "help.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -42,6 +43,11 @@ static const char *decorate_get_color(int decorate_use_color, enum decoration_ty
 	return "";
 }
 
+void list_color_decorate_slots(const char *prefix)
+{
+	PRINT_ARRAY(prefix, color_decorate_slots);
+}
+
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value)
 {
 	int slot = LOOKUP_CONFIG(color_decorate_slots, slot_name);
-- 
2.17.0.705.g3525833791

