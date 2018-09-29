Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32EE1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 06:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeI2Mfi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 08:35:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45890 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeI2Mfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 08:35:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id m80-v6so6454357lfi.12
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4p1hvNF5un3M1XmG4fgPfxhTo2DSpU/yp8NDTGDaw0Y=;
        b=mgI7pcC3dNkdWh+TYeiepgWpmbk3mEJhKdsQkanRYzAaECu7Bb5ARqL9fYdsokfThL
         owmK2lU7JLb/vKoLH1e7wQVH6A2RjY7X8jNFuo2JqPib9yd+fu2B352AfLXS0p9kJ9JA
         K+BVhLOroMmI+6PIl78zNdoNwxihgdbRtAk4QpxohLK+h1utw5J8Zg9GYfGixL7DmyTZ
         ++AUoSS/nGUJWcKAYxPZq5KKcokfpOpiiDgldOZ/h11RNfeWtFUykgtQvrLJ0GCRxFq+
         3HSBYv64s+qEhjMLp6W3syZk+FSQGS2GtRjmk7Bwj3kx7aqZNoEGZY1FFY1YOJH9HPIh
         nLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4p1hvNF5un3M1XmG4fgPfxhTo2DSpU/yp8NDTGDaw0Y=;
        b=CwQkH7oxRfL90D+/dFjtb4b+9fE4saMiTaAoh46zBtVrki28pgXMa39hLjKS/+vmZ5
         U690OaLJ6NmYlwfaqdNfx+FmzZ/DTtd/Bk3OIPvkX4F4tDBAp3ntPX9G97n3JlyQfElG
         b2Xn7Ob0dE4rB1/+lRkrxvB+7V9J3CgPuv4yYLrf3hh+QxyMgeY/eGVSIhiV8KO/rbMH
         ApV1kDZBYUsZ73Iu3j+iZwaLAdz4Rl++JMMwz+/jUHv11tNuL0bFeb8l8PTyIPx5pnaO
         jCg/6Mi9lmSb86DnnDVOiKxk5xVf2LeTIEDeYPy4aI9tz9+RJbmyJRGB+oKBiFYjEOnV
         6zOA==
X-Gm-Message-State: ABuFfoiDpYPi5UkcxWqX5cB8c+8lbI1CzNiAQ5SQrABAFxhDDyjMJJs/
        X7TmF5TL2/idLTbrCi5sivg=
X-Google-Smtp-Source: ACcGV63ZBOX5nrrbeWlnG65/aVMgWoHtWOwAjvhY2gAltBW3py6I9NSieBuV8w0F1K608mSa96+H8A==
X-Received: by 2002:a19:d713:: with SMTP id o19-v6mr805196lfg.114.1538201308517;
        Fri, 28 Sep 2018 23:08:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1348357ljd.48.2018.09.28.23.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 23:08:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] help -a: improve and make --verbose default
Date:   Sat, 29 Sep 2018 08:08:14 +0200
Message-Id: <20180929060814.22781-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180922174707.16498-1-pclouds@gmail.com>
References: <20180922174707.16498-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you type "git help" (or just "git") you are greeted with a list
with commonly used commands and their short description and are
suggested to use "git help -a" or "git help -g" for more details.

"git help -av" would be more friendly and inline with what is shown
with "git help" since it shows list of commands with description as
well, and commands are properly grouped.

"help -av" does not show everything "help -a" shows though. Add
external command section in "help -av" for this. While at there, add a
section for aliases as well (until now aliases have no UI, just "git
config").

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 makes 'help -av' default and the user would need to type 'help -a
 --no-verbose' to get the old printout back. 'help -av' also has
 external commands and aliases.

 Documentation/git-help.txt |  8 +++---
 builtin/help.c             |  2 +-
 help.c                     | 50 +++++++++++++++++++++++++++++++++++---
 t/t0012-help.sh            |  4 +--
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 83d25d825a..206e3aef64 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all [--verbose]] [-g|--guide]
+'git help' [-a|--all [--[no-]verbose]] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -42,8 +42,10 @@ OPTIONS
 --all::
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
-	When used with `--verbose` print description for all recognized
-	commands.
+
+--verbose::
+	When used with `--all` print description for all recognized
+	commands. This is the default.
 
 -c::
 --config::
diff --git a/builtin/help.c b/builtin/help.c
index 8d4f6dd301..d83dac2839 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -38,7 +38,7 @@ static const char *html_path;
 static int show_all = 0;
 static int show_guides = 0;
 static int show_config;
-static int verbose;
+static int verbose = 1;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
diff --git a/help.c b/help.c
index 96f6d221ed..4745b32299 100644
--- a/help.c
+++ b/help.c
@@ -98,7 +98,8 @@ static int cmd_name_cmp(const void *elem1, const void *elem2)
 	return strcmp(e1->name, e2->name);
 }
 
-static void print_cmd_by_category(const struct category_description *catdesc)
+static void print_cmd_by_category(const struct category_description *catdesc,
+				  int *longest_p)
 {
 	struct cmdname_help *cmds;
 	int longest = 0;
@@ -124,6 +125,8 @@ static void print_cmd_by_category(const struct category_description *catdesc)
 		print_command_list(cmds, mask, longest);
 	}
 	free(cmds);
+	if (longest_p)
+		*longest_p = longest;
 }
 
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
@@ -307,7 +310,7 @@ void list_commands(unsigned int colopts,
 void list_common_cmds_help(void)
 {
 	puts(_("These are common Git commands used in various situations:"));
-	print_cmd_by_category(common_categories);
+	print_cmd_by_category(common_categories, NULL);
 }
 
 void list_all_main_cmds(struct string_list *list)
@@ -405,7 +408,7 @@ void list_common_guides_help(void)
 		{ CAT_guide, N_("The common Git guides are:") },
 		{ 0, NULL }
 	};
-	print_cmd_by_category(catdesc);
+	print_cmd_by_category(catdesc, NULL);
 	putchar('\n');
 }
 
@@ -494,9 +497,48 @@ void list_config_help(int for_human)
 	string_list_clear(&keys, 0);
 }
 
+static int get_alias(const char *var, const char *value, void *data)
+{
+	struct string_list *list = data;
+
+	if (skip_prefix(var, "alias.", &var))
+		string_list_append(list, var)->util = xstrdup(value);
+
+	return 0;
+}
+
 void list_all_cmds_help(void)
 {
-	print_cmd_by_category(main_categories);
+	struct string_list others = STRING_LIST_INIT_DUP;
+	struct string_list alias_list = STRING_LIST_INIT_DUP;
+	struct cmdname_help *aliases;
+	int i, longest;
+
+	printf_ln(_("See 'git help <command>' to read about a specific subcommand"));
+	print_cmd_by_category(main_categories, &longest);
+
+	list_all_other_cmds(&others);
+	if (others.nr)
+		printf("\n%s\n", _("External commands"));
+	for (i = 0; i < others.nr; i++)
+		printf("   %s\n", others.items[i].string);
+	string_list_clear(&others, 0);
+
+	git_config(get_alias, &alias_list);
+	string_list_sort(&alias_list);
+	if (alias_list.nr) {
+		printf("\n%s\n", _("Command aliases"));
+		ALLOC_ARRAY(aliases, alias_list.nr + 1);
+		for (i = 0; i < alias_list.nr; i++) {
+			aliases[i].name = alias_list.items[i].string;
+			aliases[i].help = alias_list.items[i].util;
+			aliases[i].category = 1;
+		}
+		aliases[alias_list.nr].name = NULL;
+		print_command_list(aliases, 1, longest);
+		free(aliases);
+	}
+	string_list_clear(&alias_list, 1);
 }
 
 int is_in_cmdlist(struct cmdnames *c, const char *s)
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index bc27df7f38..e8ef7300ec 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -29,9 +29,9 @@ test_expect_success "setup" '
 # to verify
 test_expect_success 'basic help commands' '
 	git help >/dev/null &&
-	git help -a >/dev/null &&
+	git help -a --no-verbose >/dev/null &&
 	git help -g >/dev/null &&
-	git help -av >/dev/null
+	git help -a >/dev/null
 '
 
 test_expect_success "works for commands and guides by default" '
-- 
2.19.0.341.g3acb95d729

