Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2C31F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDOQp7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:45:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39263 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbeDOQpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:53 -0400
Received: by mail-lf0-f65.google.com with SMTP id p142-v6so18735085lfd.6
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBJ12yJfe2IxuRpfQ12OxMQ7FsDWKuLK5tmpQezznPo=;
        b=HXV6JXkeKNtse80L+UWGATt8fKNpjvA/LqAkKCxEUWMe31/ZkIWFkrULwI5b8AUSkY
         FfjX9DM9YZYmJKMYgiwJh7Jjbcur+xemWEf/Hl0KAf99b8InIQF9WQv0QizYjU68qlEI
         +bxngY/VLN/S9EBpskjtDYqtMwNvMxLUtnrpx115GqMScGjs9IUDCOV+7++uPG+M9vHm
         GJ3R7bekXb9q9LDR3uw/XsqRbjOGBXUWajrj748bPUjMvRXPk4E0MoaeM9VpCZx9lDqc
         zuhZW6nuIqsfV4+GXrz7xGnUUrd3KFpLGDFpzUN2bIsNyOaQk0rJrsdn0EdEDYocF4K9
         /xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBJ12yJfe2IxuRpfQ12OxMQ7FsDWKuLK5tmpQezznPo=;
        b=NGX/v+CzOcF1og9ZRr1QGsNRZ1mNAjVxYeXPlUQ1UxrkbWTAL+lV5Ts9Td7+HnmLA0
         j38uK1AbLcsg0xuvJk+xlM/sirdAGgCAo7Dnx88DIq/bQMQdlHbaOI5KOSozU2uImJMj
         NmVs4+POaLxl8zRXy7SuFemOwruth+9guVRJpfBFhGTv8jk9qutVi+dFWPBfUcfek67q
         aucjAgye4R1RXbik58g3c94kFnG3w451GREXl8LZlBOQpnVIScc6utnTBKg93uu0u+iA
         mohx8UgQk1X+AWkZ/gfr/6doisdoMbM5+WJhPY7S+RljtzS4/VZ+dfLWnVT8cC83J4jh
         RImQ==
X-Gm-Message-State: ALQs6tC6QWvFYJz+q5xJXRtjRDMzY6rbkG0U1crsX/ptnuNRO4HHWVkT
        xBnHEfI9IHSZQJ4N160yhVvOoQ==
X-Google-Smtp-Source: AIpwx4/Zrr/uZBtkDf18z3owOjKOivkT1cBjFTGo+F1bLQymBFf3RjhBQL1yOCoAkpmoRtC6yad9bQ==
X-Received: by 2002:a19:8d0d:: with SMTP id p13-v6mr13279298lfd.126.1523810751854;
        Sun, 15 Apr 2018 09:45:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] help: use command-list.txt for the source of guides
Date:   Sun, 15 Apr 2018 18:42:38 +0200
Message-Id: <20180415164238.9107-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415164238.9107-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180415164238.9107-1-pclouds@gmail.com>
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
 builtin/help.c                  | 32 --------------------------------
 command-list.txt                |  8 ++++++++
 generate-cmdlist.sh             |  6 +++++-
 help.c                          | 22 ++++++++++++++++++++++
 help.h                          |  1 +
 8 files changed, 39 insertions(+), 36 deletions(-)

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
index a1fad28fd8..0809a19184 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -149,3 +149,11 @@ gitweb                                  ancillaryinterrogators
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
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index e0893e979a..e35f3e357b 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -67,7 +67,11 @@ command_list "$1" |
 sort |
 while read cmd category tags
 do
-	name=${cmd/git-}
+	if [ "$category" = guide ]; then
+		name=${cmd/git}
+	else
+		name=${cmd/git-}
+	fi
 	sed -n '
 		/^NAME/,/'"$cmd"'/H
 		${
diff --git a/help.c b/help.c
index 7f72051641..a44f4a113e 100644
--- a/help.c
+++ b/help.c
@@ -313,6 +313,28 @@ static void list_commands_by_category(int cat, struct cmdname_help *cmds,
 	}
 }
 
+void list_common_guides_help(void)
+{
+	int i, longest = 0;
+	int nr = ARRAY_SIZE(command_list);
+	struct cmdname_help *cmds = command_list;
+
+	QSORT(cmds, nr, cmd_category_cmp);
+
+	for (i = 0; i < nr; i++) {
+		struct cmdname_help *cmd = cmds + i;
+
+		if (cmd->category != CAT_guide)
+			continue;
+		if (longest < strlen(cmd->name))
+			longest = strlen(cmd->name);
+	}
+
+	puts(_("The common Git guides are:\n"));
+	list_commands_by_category(CAT_guide, cmds, nr, longest);
+	putchar('\n');
+}
+
 void list_all_cmds_help(void)
 {
 	int i, longest = 0;
diff --git a/help.h b/help.h
index 62449f1b7e..de094e9e65 100644
--- a/help.h
+++ b/help.h
@@ -18,6 +18,7 @@ static inline void mput_char(char c, unsigned int num)
 
 extern void list_common_cmds_help(void);
 extern void list_all_cmds_help(void);
+extern void list_common_guides_help(void);
 extern void list_all_cmds(void);
 extern void list_porcelain_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
-- 
2.17.0.367.g5dd2e386c3

