Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916ED1F51C
	for <e@80x24.org>; Sun, 20 May 2018 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeETSlI (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 14:41:08 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38751 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeETSkc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 14:40:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id z142-v6so20767747lff.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CytcvYi6xndprx6d6BcYZHom78069XQzG0s5f4shChg=;
        b=uMT4Sn1jooHhWpzBD1hudHIE7V2CWN4owzuEEwNibDZg1Fw/n+2pqffUxf4nBe5UKN
         xOI8FeGRxLoEFC5oRGow52GrDofnpGw3AH3YmzqdMDX+wkCitlkU9ZPBsZOlUG/D5xzD
         LSAA2bQqD8KUuSTyQJEUaOqamMIFP+8Y7fm+OsD/DczWVP/hGNFAcjdtSwIhDnjQbq/n
         LUrnJ18TP0fXWBoZX3E1o/g7CYbSSsK9UPLj4Li/0ym3IK6wVIB4zPbsK5YYlPfrprqz
         wXK3BFCJaRp6Om/V2U6fA3msqDZggvb4/cXSLEVHQdVNrQFMCMtiBJTRdCdsU+koTxCL
         2Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CytcvYi6xndprx6d6BcYZHom78069XQzG0s5f4shChg=;
        b=i5isCR9huZKzdZnEf203zm/afBxo6MSo0UdrR73fUAdgmjBE9kD5YPY8D2hSCLxYIh
         ZzV4uPXqoBPoZvZ8TGn/9dY2fEz06i1toWBfHYQnBT2AoVspKSN5XARzV77TyrA345aF
         iJum7vqktHmXAPk7a6nEL2yQFrWl9MNuaTsUy0T2VsbEX9FDkwYmuFlowVpOEX4kNRG3
         IieXJjxHkL4VPCn5zC7gS7BoW7X05PR93VQVorPDd5mjmmjllPC4sBR6K/N0gnj3XbaX
         +KyhLVuqcA8ermgm3ULvYK0Z8Hl/RIYEEZ0tGcSQeQGKBKHGThvyRK3k4ZJkN1QVh9Ve
         76jw==
X-Gm-Message-State: ALKqPweudzLLBl5CrC0ORBBuybPIlcTrzFpv9b1yjnlzNTA0YQFJAuux
        L1OMbt3JQvHE+KLFXvREXlV+lw==
X-Google-Smtp-Source: AB8JxZqv6Ng/4ulgllUd6dsuv8F/tLEfWw+nA1rtJSxn/xgvsWwDJriegQjFPOIDLieVZNTGu7JQtA==
X-Received: by 2002:a19:5d43:: with SMTP id p3-v6mr9273260lfj.142.1526841630407;
        Sun, 20 May 2018 11:40:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2176906lji.39.2018.05.20.11.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 11:40:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/17] help: add "-a --verbose" to list all commands with synopsis
Date:   Sun, 20 May 2018 20:40:01 +0200
Message-Id: <20180520184009.976-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180520184009.976-1-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com>
 <20180520184009.976-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lists all recognized commands [1] by category. The group order
follows closely git.txt.

[1] We may actually show commands that are not built (e.g. if you set
NO_PERL you don't have git-instaweb but it's still listed here). I
ignore the problem because on Linux a git package could be split
anyway. The "git-core" package may not contain git-instaweb even if
it's built because it may end up in a separate package. We can't know
anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-help.txt |  4 +++-
 builtin/help.c             |  7 +++++++
 help.c                     | 16 ++++++++++++++++
 help.h                     |  2 ++
 t/t0012-help.sh            |  9 +++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 40d328a4b3..a40fc38d8b 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,7 +8,7 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all] [-g|--guide]
+'git help' [-a|--all [--verbose]] [-g|--guide]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
@@ -42,6 +42,8 @@ OPTIONS
 --all::
 	Prints all the available commands on the standard output. This
 	option overrides any given command or guide name.
+	When used with `--verbose` print description for all recognized
+	commands.
 
 -g::
 --guides::
diff --git a/builtin/help.c b/builtin/help.c
index 598867cfea..0e0af8426a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,6 +36,7 @@ static const char *html_path;
 
 static int show_all = 0;
 static int show_guides = 0;
+static int verbose;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
@@ -48,6 +49,7 @@ static struct option builtin_help_options[] = {
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
+	OPT__VERBOSE(&verbose, N_("print command description")),
 	OPT_END(),
 };
 
@@ -463,6 +465,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		git_config(git_help_config, NULL);
+		if (verbose) {
+			setup_pager();
+			list_all_cmds_help();
+			return 0;
+		}
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		load_command_list("git-", &main_cmds, &other_cmds);
 		list_commands(colopts, &main_cmds, &other_cmds);
diff --git a/help.c b/help.c
index 1117f7d1d1..c7df1d2338 100644
--- a/help.c
+++ b/help.c
@@ -27,6 +27,17 @@ static struct category_description common_categories[] = {
 	{ CAT_remote, N_("collaborate (see also: git help workflows)") },
 	{ 0, NULL }
 };
+static struct category_description main_categories[] = {
+	{ CAT_mainporcelain, N_("Main Porcelain Commands") },
+	{ CAT_ancillarymanipulators, N_("Ancillary Commands / Manipulators") },
+	{ CAT_ancillaryinterrogators, N_("Ancillary Commands / Interrogators") },
+	{ CAT_foreignscminterface, N_("Interacting with Others") },
+	{ CAT_plumbingmanipulators, N_("Low-level Commands / Manipulators") },
+	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
+	{ CAT_synchingrepositories, N_("Low-level Commands / Synching Repositories") },
+	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
+	{ 0, NULL }
+};
 
 static const char *drop_prefix(const char *name)
 {
@@ -352,6 +363,11 @@ void list_cmds_by_category(struct string_list *list,
 	}
 }
 
+void list_all_cmds_help(void)
+{
+	print_cmd_by_category(main_categories);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 734bba32d3..40917fc38c 100644
--- a/help.h
+++ b/help.h
@@ -19,6 +19,8 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds_help(void);
+
 extern void list_all_main_cmds(struct string_list *list);
 extern void list_all_other_cmds(struct string_list *list);
 extern void list_cmds_by_category(struct string_list *list,
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 3c91a9024a..060df24c2d 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -25,6 +25,15 @@ test_expect_success "setup" '
 	EOF
 '
 
+# make sure to exercise these code paths, the output is a bit tricky
+# to verify
+test_expect_success 'basic help commands' '
+	git help >/dev/null &&
+	git help -a >/dev/null &&
+	git help -g >/dev/null &&
+	git help -av >/dev/null
+'
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.17.0.705.g3525833791

