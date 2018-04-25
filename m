Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274C31F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbeDYQb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:58 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46972 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755498AbeDYQbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id v85-v6so4807123lfa.13
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujiuR8ygKOXQS86sQ0bOGqL1IS3Gsjyz7Ac95q2GI4I=;
        b=ekimJCMFb4Wt2fkAKm/JtpPiX7xuXjCo0Ho0Zn4dKc7vnVPYfp1pZ9h5cgOfsfqug0
         zpGQ3zrq9sYf+INe9eynLg1XclPr1AYb6MI8fXRMFNHdcFQcz6AxI07xKqTn1treaTQC
         uo530oeBi6PNtQua454FvYUYRQ+084K6EhyQf6tuq3c13+ehfzjcMiV19ETox7zrcGTS
         Xkqe9X77UDBE4AMl9GGHEHf4uwqAjpt9NaOZAqBvaR5hRbgvKPv67VVcuAIz/mkGDha0
         fphISnSKhwKIsKPd/efWe1dIOD7dVIWZv3rvlu7dps/w6KNhP5qyStVIVuJeyH2syTPc
         wyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujiuR8ygKOXQS86sQ0bOGqL1IS3Gsjyz7Ac95q2GI4I=;
        b=INHYCFyDAdUSfDirYgKJeBV7Wrlzkb7EN3nwfIdacxLmDew1BOFFnnqEo8ykHlRfv3
         djBY4ysfnDJxhtnAq0JiEi/7qNmwrpFSl4Kn6K6IrsHTTjkcoh+BdwrpAF6mwdCrWdgv
         O4HYq3q8kEUAt1wLH/gOFNpJJt+EKvAsjTEMoFGFlcXvY9Bvteaea8g39Mav5SgE/3rv
         J+8q/0fBMvvQrnUTPztvedhqndsmHzUEOy7n6kDQWiOnVi14CwCyzXNyYEIG8LB+lNHJ
         hmfFEqQJpygFOMn4IFzNR+nJ2JePAsGUIF/fa2SGN34Bhgihj8VNUPVnaowDgh9vjWJG
         4bVg==
X-Gm-Message-State: ALQs6tDltpP+dmf54VR+LkkoR5zhlsf04NIBA8Jj1yvj67mrjBWC19BU
        kXK3J/1Bh+plswyQSz2Sd0yI4g==
X-Google-Smtp-Source: AB8JxZo2tD5jTj9BJgUT7zxp8qb7L6X2pMQ0HhXbPo+/qsfc3Z7oCuKGUj6ZoCQ2pwIEUvwF3oN3cw==
X-Received: by 10.46.158.195 with SMTP id h3mr2760923ljk.1.1524673898154;
        Wed, 25 Apr 2018 09:31:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 09/12] help: add "-a --verbose" to list all commands with synopsis
Date:   Wed, 25 Apr 2018 18:31:04 +0200
Message-Id: <20180425163107.10399-10-pclouds@gmail.com>
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
 help.h                     |  1 +
 t/t0012-help.sh            |  9 +++++++++
 5 files changed, 36 insertions(+), 1 deletion(-)

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
index affa8e4343..1f27d94661 100644
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
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 {
@@ -324,6 +335,11 @@ void list_cmds_by_category(const char *cat)
 			puts(command_list[i].name);
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
index 3e30542927..118b7d9947 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds_help(void);
 extern void list_all_cmds(void);
 extern void list_cmds_by_category(const char *category);
 extern const char *help_unknown_cmd(const char *cmd);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index fd2a7f27dc..53208ab20e 100755
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
2.17.0.519.gb89679a4aa

