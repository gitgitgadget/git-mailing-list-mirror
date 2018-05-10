Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEFF01F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756927AbeEJIra (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40152 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756869AbeEJIrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:11 -0400
Received: by mail-lf0-f68.google.com with SMTP id p85-v6so1819805lfg.7
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5V1iv0DX/Xl40raU7t8Kq+JjT0oKl3Tb5po6VMLttQ=;
        b=IUiGvkKWAk7hGBTS1f/g0rNbds0peUMNZbL8f/0/cDXtf+gSICTUhMoYnw5vWjU0PZ
         L6Orj49Aowz2ItojNieOsE0ynXpnl47mLCBRMXpKu9VTqWdlxVbImfM7UDTZeIMMPpY3
         zP4jOinb42l/bUizwaOlhOcPXdcqkOsDg4K0Y3I+BT3OTJMUZhrGZFpTeaL9LQtgiY0A
         QX0bGi5BpdkBQ4o+m3sY029LN6D3Ybv12ADqltHJH97brDQayOWGNMWWJXMAQaNJlEyJ
         uF+QSMC/I4nhlvzPFm3XqQ5QDlJc2XkeevlmvoRyUjEby7tczYpHSl1ZeMDg32p5prMQ
         +9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5V1iv0DX/Xl40raU7t8Kq+JjT0oKl3Tb5po6VMLttQ=;
        b=qZEiMeUEe5TMhhHwCMTKTTM+gQKZxW+K1UZ2wb5JG6PTMFBGfPl0IgSPoRW2tr3lLw
         EzlMEQlcs6Ba3Kg4S8tgXotkhufU+n+pq9k60MaOv98h4syZZSODClEQO5ILhZaLikzS
         f77isLgiVQUP3Tit81LJf7ay/i+h1diiXhPRYHaB13ISakRmrpf/pbBOUMbcacYrfJ8C
         iLrfUPOeAis4Auq4I+WOkwwDvLi1DtZGJWogNxkjzMOO7IFJqFqcee/gnfsiyCHFJnRC
         DjNmhJNhwDA0PlCaqL6ONYbe/1M6OHM6aGEmnQRSPX8gPxv+xEuWkyWkXJRAVee2R7C7
         EftA==
X-Gm-Message-State: ALKqPwd0UhBeHKoY381jikyqwPVazO1Fvd1EUDOi045fQvLgaJaPUPFV
        FFfO+9FpkBHFVuQF0caJS8s=
X-Google-Smtp-Source: AB8JxZoca8CNypcbu9cy4ONft44CXeuApDtyXgP1v32Q5wpmnac0JU/MUcoP0FyCVhl5a82YxsL+PQ==
X-Received: by 2002:a2e:91d5:: with SMTP id u21-v6mr531588ljg.0.1525942029977;
        Thu, 10 May 2018 01:47:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 10/13] help: use command-list.txt for the source of guides
Date:   Thu, 10 May 2018 10:46:49 +0200
Message-Id: <20180510084652.25880-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The help command currently hard codes the list of guides and their
summary in C. Let's move this list to command-list.txt. This lets us
extract summary lines from Documentation/git*.txt. This also
potentially lets us list guides in git.txt, but I'll leave that for
now.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitattributes.txt        |  2 +-
 Documentation/gitmodules.txt           |  2 +-
 Documentation/gitrevisions.txt         |  2 +-
 Makefile                               |  2 +-
 builtin/help.c                         | 32 --------------------------
 command-list.txt                       | 16 +++++++++++++
 contrib/completion/git-completion.bash | 15 ++++++++----
 help.c                                 | 21 +++++++++++++----
 help.h                                 |  1 +
 t/t0012-help.sh                        |  6 +++++
 10 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1094fe2b5b..083c2f380d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -3,7 +3,7 @@ gitattributes(5)
 
 NAME
 ----
-gitattributes - defining attributes per path
+gitattributes - Defining attributes per path
 
 SYNOPSIS
 --------
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index db5d47eb19..4d63def206 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -3,7 +3,7 @@ gitmodules(5)
 
 NAME
 ----
-gitmodules - defining submodule properties
+gitmodules - Defining submodule properties
 
 SYNOPSIS
 --------
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index 27dec5b91d..1f6cceaefb 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -3,7 +3,7 @@ gitrevisions(7)
 
 NAME
 ----
-gitrevisions - specifying revisions and ranges for Git
+gitrevisions - Specifying revisions and ranges for Git
 
 SYNOPSIS
 --------
diff --git a/Makefile b/Makefile
index a60a78ee67..1efb751e46 100644
--- a/Makefile
+++ b/Makefile
@@ -1937,7 +1937,7 @@ $(BUILT_INS): git$X
 
 command-list.h: generate-cmdlist.sh command-list.txt
 
-command-list.h: $(wildcard Documentation/git-*.txt)
+command-list.h: $(wildcard Documentation/git*.txt)
 	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
diff --git a/builtin/help.c b/builtin/help.c
index 0e0af8426a..5727fb5e51 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -402,38 +402,6 @@ static void show_html_page(const char *git_cmd)
 	open_html(page_path.buf);
 }
 
-static struct {
-	const char *name;
-	const char *help;
-} common_guides[] = {
-	{ "attributes", N_("Defining attributes per path") },
-	{ "everyday", N_("Everyday Git With 20 Commands Or So") },
-	{ "glossary", N_("A Git glossary") },
-	{ "ignore", N_("Specifies intentionally untracked files to ignore") },
-	{ "modules", N_("Defining submodule properties") },
-	{ "revisions", N_("Specifying revisions and ranges for Git") },
-	{ "tutorial", N_("A tutorial introduction to Git (for version 1.5.1 or newer)") },
-	{ "workflows", N_("An overview of recommended workflows with Git") },
-};
-
-static void list_common_guides_help(void)
-{
-	int i, longest = 0;
-
-	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
-		if (longest < strlen(common_guides[i].name))
-			longest = strlen(common_guides[i].name);
-	}
-
-	puts(_("The common Git guides are:\n"));
-	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
-		printf("   %s   ", common_guides[i].name);
-		mput_char(' ', longest - strlen(common_guides[i].name));
-		puts(_(common_guides[i].help));
-	}
-	putchar('\n');
-}
-
 static const char *check_git_cmd(const char* cmd)
 {
 	char *alias;
diff --git a/command-list.txt b/command-list.txt
index 3bd23201a6..99ddc231c1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -139,3 +139,19 @@ gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
+gitattributes                           guide
+gitcli                                  guide
+gitcore-tutorial                        guide
+gitcvs-migration                        guide
+gitdiffcore                             guide
+giteveryday                             guide
+gitglossary                             guide
+githooks                                guide
+gitignore                               guide
+gitmodules                              guide
+gitnamespaces                           guide
+gitrepository-layout                    guide
+gitrevisions                            guide
+gittutorial-2                           guide
+gittutorial                             guide
+gitworkflows                            guide
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 62ca8641f4..4e724a5b76 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1575,6 +1575,13 @@ _git_grep ()
 	__git_complete_refs
 }
 
+__git_all_guides=
+__git_compute_all_guides ()
+{
+	test -n "$__git_all_guides" ||
+	__git_all_guides=$(git --list-cmds=list-guide)
+}
+
 _git_help ()
 {
 	case "$cur" in
@@ -1584,11 +1591,9 @@ _git_help ()
 		;;
 	esac
 	__git_compute_all_commands
-	__gitcomp "$__git_all_commands $(__git_aliases)
-		attributes cli core-tutorial cvs-migration
-		diffcore everyday gitk glossary hooks ignore modules
-		namespaces repository-layout revisions tutorial tutorial-2
-		workflows
+	__git_compute_all_guides
+	__gitcomp "$__git_all_commands $(__git_aliases) $__git_all_guides
+		gitk
 		"
 }
 
diff --git a/help.c b/help.c
index c7df1d2338..23924dd300 100644
--- a/help.c
+++ b/help.c
@@ -39,12 +39,14 @@ static struct category_description main_categories[] = {
 	{ 0, NULL }
 };
 
-static const char *drop_prefix(const char *name)
+static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
 
 	if (skip_prefix(name, "git-", &new_name))
 		return new_name;
+	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
+		return new_name;
 	return name;
 
 }
@@ -66,7 +68,7 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 			continue;
 
 		cmds[nr] = *cmd;
-		cmds[nr].name = drop_prefix(cmd->name);
+		cmds[nr].name = drop_prefix(cmd->name, cmd->category);
 
 		nr++;
 	}
@@ -358,11 +360,22 @@ void list_cmds_by_category(struct string_list *list,
 	for (i = 0; i < n; i++) {
 		struct cmdname_help *cmd = command_list + i;
 
-		if (cmd->category & cat_id)
-			string_list_append(list, drop_prefix(cmd->name));
+		if (!(cmd->category & cat_id))
+			continue;
+		string_list_append(list, drop_prefix(cmd->name, cmd->category));
 	}
 }
 
+void list_common_guides_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_guide, N_("The common Git guides are:") },
+		{ 0, NULL }
+	};
+	print_cmd_by_category(catdesc);
+	putchar('\n');
+}
+
 void list_all_cmds_help(void)
 {
 	print_cmd_by_category(main_categories);
diff --git a/help.h b/help.h
index 40917fc38c..b2293e99be 100644
--- a/help.h
+++ b/help.h
@@ -20,6 +20,7 @@ static inline void mput_char(char c, unsigned int num)
 
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
+extern void list_common_guides_help(void);
 
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 060df24c2d..bc27df7f38 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -66,6 +66,12 @@ test_expect_success 'git help' '
 	test_i18ngrep "^   commit " help.output &&
 	test_i18ngrep "^   fetch  " help.output
 '
+test_expect_success 'git help -g' '
+	git help -g >help.output &&
+	test_i18ngrep "^   attributes " help.output &&
+	test_i18ngrep "^   everyday   " help.output &&
+	test_i18ngrep "^   tutorial   " help.output
+'
 
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
-- 
2.17.0.705.g3525833791

