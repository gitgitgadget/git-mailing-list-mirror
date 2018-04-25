Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1439B1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755511AbeDYQb5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39852 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755201AbeDYQbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:40 -0400
Received: by mail-lf0-f66.google.com with SMTP id j193-v6so3371904lfg.6
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrPjJ9Iemn7y0njKn/9fVeqPXZykdxDzi+qOYUELGr4=;
        b=muLXutg9Q33iCJ8GhMs8I63Clge9g2epspCERKwCpM4GmZQBzv7/YaiwfsQxMj+XW3
         mjOvJg87hKBJc9YE6HcSgroIC75MwHZFwXSfFzES8olpG8Vonj00ToNY4vqlf2bLLgp1
         aZxP57n0F9x2ynU9jXTyHRVQ2K53Qy2jTjSfaraZsXLe1tSj9WIT9iFwmXTPSknMIQgW
         GIeFqKbgCF/83RBPNRxNebtBDEhXmuKEkrBCbwdD8JQK1zUASWkeUU9+1hdkUs2TK0pk
         ZQCsDdurB6fKj20PVZQxH+zgZkxYAXl0wHkP1FiYgTySNQu8LwJl3qfrvwIBOKGMM+i/
         tIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrPjJ9Iemn7y0njKn/9fVeqPXZykdxDzi+qOYUELGr4=;
        b=DrmE2fy9DJfixRDItAYSVMTf/xpsXQJhAlguLu8uGjpVZjYRuYPnygJhiGjAY/B9Ds
         3jmittJXE22pDik1Sgu7oXCQs/2l5Z85eGS6oJnGxblLnuw0QXv0AhWbr83RCBIA6vpw
         0pQB2ptr2L1BMARFH9CJ4EXVBi7j7mayYNZ69JCKNWImZaRKf4Y/x6bCyXt+smrul6hW
         8wtNlya6YFh5QUHdqJW1VIxeVruOJRONW9VqTWf6/r3BvycvPvy+GVntLZMlaagxf+9I
         yeEobG5AvLeBhYbl1KGa4MxazUT8ASrCZ5EM3e5Bpgu6wK88B/XitqooULZbRbzQUfmx
         4H4w==
X-Gm-Message-State: ALQs6tC7Q1ahqXSpkciat+O6euxH9DHf1lCyen8Ih/1MeK3F41vYWpN7
        ol21+FH2evQsPoBtGswKx/w=
X-Google-Smtp-Source: AIpwx4+DD0zMToc6ByJJyBGMDnJmo83vnwJ0Owvg21qP6oW5W1E8y1ACPeRbxUxak4Zk5G97JcBVGw==
X-Received: by 10.46.156.204 with SMTP id g12mr21234976ljj.141.1524673899272;
        Wed, 25 Apr 2018 09:31:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:38 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 10/12] help: use command-list.txt for the source of guides
Date:   Wed, 25 Apr 2018 18:31:05 +0200
Message-Id: <20180425163107.10399-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
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
potentially lets us lists guides in git.txt, but I'll leave that for
now.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitattributes.txt |  2 +-
 Documentation/gitmodules.txt    |  2 +-
 Documentation/gitrevisions.txt  |  2 +-
 Makefile                        |  2 +-
 builtin/help.c                  | 32 --------------------------------
 command-list.txt                |  8 ++++++++
 help.c                          | 14 +++++++++++++-
 help.h                          |  1 +
 8 files changed, 26 insertions(+), 37 deletions(-)

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
index 3bd23201a6..a57bcb64a1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -139,3 +139,11 @@ gitweb                                  ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
+gitattributes                           guide
+giteveryday                             guide
+gitglossary                             guide
+gitignore                               guide
+gitmodules                              guide
+gitrevisions                            guide
+gittutorial                             guide
+gitworkflows                            guide
diff --git a/help.c b/help.c
index 1f27d94661..d5a2aff4cb 100644
--- a/help.c
+++ b/help.c
@@ -55,7 +55,9 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 
 		cmds[nr] = *cmd;
 
-		if (skip_prefix(cmd->name, "git-", &name))
+		if (skip_prefix(cmd->name, "git-", &name) ||
+		    (mask == CAT_guide &&
+		     skip_prefix(cmd->name, "git", &name)))
 			cmds[nr].name = name;
 
 		nr++;
@@ -335,6 +337,16 @@ void list_cmds_by_category(const char *cat)
 			puts(command_list[i].name);
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
index 118b7d9947..71b1542896 100644
--- a/help.h
+++ b/help.h
@@ -18,6 +18,7 @@ static inline void mput_char(char c, unsigned int num)
 
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
+extern void list_common_guides_help(void);
 extern void list_all_cmds(void);
 extern void list_cmds_by_category(const char *category);
 extern const char *help_unknown_cmd(const char *cmd);
-- 
2.17.0.519.gb89679a4aa

