Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BC620248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfCMTUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:20:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36607 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfCMTUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:20:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so2557911edi.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 12:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jLod+ebWUcNfhxNyeoLvCoxtXNPZqb9mjKeAhPzKQAY=;
        b=bMqw333PFFpXaUOT9aKdZmZaadb4W5hapZotJZi3LkeOY2e8fCKEfPuN447hsp2iHw
         YPtMMH6BQBIrHJYgaRUcoYYDy9YCj3m+1/yegN2ihDcjVOa4Qf1BelRVEDfoRkLCm7lg
         Sc0dTifLl4A70Gj2ltLH5aF12Ty3n/a4wzFdala4oHRO8G2q323xVo4cqqyUhOj+Mjyf
         g6TbgM5aqm5SF4OqeQ+GraqcnVeuI0w0rPG9PNxt2c6M8VCnmOt9+5Bk3CvvZBdA6Sxi
         FpepQbQjS2ZxkG95E23h0FOcrG4/Oghef3LMOHJQqX0V7LlYvYyMgCtdObadUutHMZpl
         cJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jLod+ebWUcNfhxNyeoLvCoxtXNPZqb9mjKeAhPzKQAY=;
        b=ngPCUQHSeEl2KQBbjJOfNG8w/6blJvHYXTrFudRX8i2//b/x7f7+8BMINIjVdf2la7
         GXEFubODL41/XBqbMDya2Ciok1kGAhCvHpgshNmWMFfQ2ZUV+nI/0D5JgAc2WBy4M4p2
         M+MmeU5NxXfUAZXy8baSGX9K7i81NsLAyLN674H5SoOuA17OZn9aAJ7GwDaCvJFlnN1y
         gnEsWHMFADhLKbC8ZUHJsqmqTI1ektVA9NKPi3BuHhSNywMdoeSSB7Ik8FGHEoveDVtn
         j/KuqhO1WyLUF9h7tFGKbN83ZmzMIzEBGcfVCuhI61FGW29+xfwaZb4dWlwXNlTmGQkj
         Iguw==
X-Gm-Message-State: APjAAAWHUkom0z06nAcJi4AfV1+HaHBwAjtenTNozfTPyH8cXkYwpE1c
        U/zppc0vT6bxSkPZedEhmp9nvWTX
X-Google-Smtp-Source: APXvYqzPqzMIVRvYu0HvvlkfgfsTGD+bfKO+oVKGVf2wIeJtzpQPeQ3vE2+c5hnZa3BEAJccEsx+zQ==
X-Received: by 2002:a50:d55a:: with SMTP id f26mr8887193edj.292.1552504815209;
        Wed, 13 Mar 2019 12:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm810385edr.60.2019.03.13.12.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:20:14 -0700 (PDT)
Date:   Wed, 13 Mar 2019 12:20:14 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 19:20:12 GMT
Message-Id: <9f6eb60eeeccf920af83652899c5bc2d40e2092f.1552504812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.163.git.gitgitgadget@gmail.com>
References: <pull.163.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] difftool: allow running outside Git worktrees with
 --no-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As far as this developer can tell, the conversion from a Perl script to
a built-in caused the regression in the difftool that it no longer runs
outside of a Git worktree (with `--no-index`, of course).

It is a bit embarrassing that it took over two years after retiring the
Perl version to discover this regression, but at least we now know, and
can do something, about it.

This fixes https://github.com/git-for-windows/git/issues/2123

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c  | 20 +++++++++++++++++---
 git.c               |  2 +-
 t/t7800-difftool.sh | 10 ++++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 31eece0c8d..d08ef31f04 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -690,7 +690,7 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0;
+	    tool_help = 0, i, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
@@ -727,8 +727,22 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (tool_help)
 		return print_tool_help();
 
-	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+	for (i = 0; i < argc; i++)
+		if (!strcmp(argv[i], "--"))
+			break;
+		else if (!strcmp(argv[i], "--no-index")) {
+			no_index = 1;
+			break;
+		}
+
+	if (!no_index && !startup_info->have_repository)
+		die(_("difftool requires worktree or --no-index"));
+
+	if (!no_index){
+		setup_work_tree();
+		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+	}
 
 	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
 		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
diff --git a/git.c b/git.c
index 2014aab6b8..46365ed86a 100644
--- a/git.c
+++ b/git.c
@@ -491,7 +491,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
-	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
+	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bb9a7f4ff9..4907627656 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -705,4 +705,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'outside worktree' '
+	mkdir outside &&
+	echo 1 >outside/1 &&
+	echo 2 >outside/2 &&
+	test_expect_code 1 env GIT_CEILING_DIRECTORIES="$(pwd)" git \
+		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
+		-C outside difftool --no-prompt --no-index 1 2 >out &&
+	test "1 2" = "$(cat out)"
+'
+
 test_done
-- 
gitgitgadget
