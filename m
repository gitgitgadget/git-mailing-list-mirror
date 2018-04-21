Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43AD1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeDUQyl (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41199 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbeDUQyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id o123-v6so6629070lfe.8
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3OIJsD23PPxisVVjS3wbneFkfYzfiiATSKaTjqacjU=;
        b=YxR/5unkamtq+PZSZDcxKfkmjsLvwUzzL7In/Q/PT3l3LkUqKALhuf2V3KI+etQvic
         iuZOWuRQpXFEaddKiZZt+8Jxupkjg6Wvp7vuQe6VctGuru6/PYqwa3GaU5Ir53yJdMB0
         uhT3XrGt+djDqoxU5KwU1MI14zxgV4cUuO/u3ZY/9Ic1vk+pTzslRnpU1A5aMhpqNtZ5
         Ba2Vp0yAerklqyIaY1BhhwGUHfFpT/7VmuQXI1ZFAIwo4o5h07Y8mIw+zcmJkl9L1up+
         NZObv92xDuyeHn+UBEqR+0qc+bwx5cBx5qoRlV+8UEp7olYIEhFYpUJAnNiF7ViVqkKc
         ExSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3OIJsD23PPxisVVjS3wbneFkfYzfiiATSKaTjqacjU=;
        b=E6QktgfkaH68S3D+Cc+8+55JuR58Db0wz3vLZIod9xAT49dqnrnfA1BH7V2sXgQ7j9
         XnDuxcNHZjfMSlc8sYVOQ2gTUAUBA9KAkeg2VbjBBlqV1Q0xHvPEPIYbGod6h86PfohH
         ESigz1H7Th9vuDwKChyFi44DL/64ADslITijsolfSoyNCVC4eqeLqrVaocPFmKqpLw4d
         cYhhSFW7m6rhsfy1j6QX/i0UyCWRSALJ/LjXU+t6IsFDtQvNTdCbgzDc/69mVx3oJ7ae
         X74EFrJxZU7Fe7EvDdYbKryyrWKXpP9DWB0mMWnStx1y2KqQE00aQh9tehactrPxqcL4
         q6Tg==
X-Gm-Message-State: ALQs6tDDcU61Yqg5Vpjg5GhwFifMp3c5NcGZ/CdtaX4dgMj2mWqtk71x
        h3KNQuz2VDbN2GesKVuf40M=
X-Google-Smtp-Source: AIpwx48dYdXhh5vIKYD1C9Wl+o+mcqQT+IGOjZi4UBS6AxSr82bu3NNuVUE0RYQCeg7tRvIsIsUYzQ==
X-Received: by 10.46.151.70 with SMTP id f6mr10206283ljj.140.1524329676455;
        Sat, 21 Apr 2018 09:54:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 6/6] help: use command-list.txt for the source of guides
Date:   Sat, 21 Apr 2018 18:54:14 +0200
Message-Id: <20180421165414.30051-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
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
index 2c81d8db74..1835f1a928 100644
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
index 05722b1392..86d59419b3 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -58,7 +58,11 @@ command_list "$1" |
 sort |
 while read cmd category tags
 do
-	prefix=git-
+	if [ "$category" = guide ]; then
+		prefix=git
+	else
+		prefix=git-
+	fi
 	name=$(echo $cmd | sed "s/^${prefix}//")
 	sed -n '
 		/^NAME/,/'"$cmd"'/H
diff --git a/help.c b/help.c
index ae5281601a..88127fdd6f 100644
--- a/help.c
+++ b/help.c
@@ -314,6 +314,28 @@ static void list_commands_by_category(int cat, struct cmdname_help *cmds,
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

