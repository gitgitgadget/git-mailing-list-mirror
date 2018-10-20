Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9E41F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJTUtz (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44811 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id v6-v6so33058521ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTjYxrSwO8jrgynBbPNG5rPb56mQrgQjDDUAm8MIGIg=;
        b=ecFY/HpQRGOtB/BPwoet1EsocAG3osM1Vht3QlvrpYrjg7pT04SGAfTztkAolQjEXR
         sn3ou1Cr1r//mWQDUXx4Jhhp0fn3AgFsv1H7Mu8KS9CjfyR9e5cy2/VpmUkpTtmWX7k6
         Js/Gts+rbYNa9WbE8+WqIfIJ0ApktIq6laWRUa8wksnx/43Pl1YbH2lkzov7pd5k665C
         rOpA7gyxPCjCvVN4/NphU2OaqpC+1j4aNHsb3Qxi4wCQUnvVjxQs3csO1pllNTtYrm51
         JxiG+lvn3aiKmzxjyAVwEMCsewPse6y6TdIXdNz+w13PPOet4/F6c9rYwFqUTukLev3l
         nJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTjYxrSwO8jrgynBbPNG5rPb56mQrgQjDDUAm8MIGIg=;
        b=t44cR+C3QQJ2B9dtcWx7EjRZ8Qz30Tx5BJLHctljto5RU+WrxVC2+zWNyuqttrIzQd
         x2B3uO+A7O6+oiP/hz81+Qbo3lq+rgBkWMA0ieB4h38+riCzUpm/Ou5NqcxX0IZ1e/on
         Erc5eqxW+FFeD6dKpslNs5yaYtRUna1MYr5X3pAMsQcDo9etWswPl1oJHuzw6uR376sa
         0L6X94RRuQ8q7pevG7zm5B2nXdk9/m+Hzx5tOsEjiPwbSUc7dfJCepg/ihKcTlxoH/sp
         z29cc/slZvHeu9s+3NIWTNp6Gm1FP42SWjZg4E/Sps50laPsdfRXShJcn774ygHLcRWy
         DE5w==
X-Gm-Message-State: ABuFfoiGa2eIvLoXYVcJMY3825RBJW+leFT0A3yXwIUPmiYMZrOHF59B
        2xN1xQ7oLTQ+wWIxBHiWJb5sPjDc
X-Google-Smtp-Source: ACcGV63Uk7skrjO8baucGkf/kiax9yzm9J6dopN7474nQj6dbH3Hp3bwlRNyktHUN7ngCfk4q1cOfw==
X-Received: by 2002:a2e:5215:: with SMTP id g21-v6mr25001371ljb.144.1540039172348;
        Sat, 20 Oct 2018 05:39:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 25/59] config.txt: move guitool.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:14 +0200
Message-Id: <20181020123848.2785-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt         | 51 +-------------------------------
 Documentation/guitool-config.txt | 50 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/guitool-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index adab71fd94..93ec85ab6e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -345,56 +345,7 @@ include::gpg-config.txt[]
 
 include::gui-config.txt[]
 
-guitool.<name>.cmd::
-	Specifies the shell command line to execute when the corresponding item
-	of the linkgit:git-gui[1] `Tools` menu is invoked. This option is
-	mandatory for every tool. The command is executed from the root of
-	the working directory, and in the environment it receives the name of
-	the tool as `GIT_GUITOOL`, the name of the currently selected file as
-	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
-	the head is detached, 'CUR_BRANCH' is empty).
-
-guitool.<name>.needsFile::
-	Run the tool only if a diff is selected in the GUI. It guarantees
-	that 'FILENAME' is not empty.
-
-guitool.<name>.noConsole::
-	Run the command silently, without creating a window to display its
-	output.
-
-guitool.<name>.noRescan::
-	Don't rescan the working directory for changes after the tool
-	finishes execution.
-
-guitool.<name>.confirm::
-	Show a confirmation dialog before actually running the tool.
-
-guitool.<name>.argPrompt::
-	Request a string argument from the user, and pass it to the tool
-	through the `ARGS` environment variable. Since requesting an
-	argument implies confirmation, the 'confirm' option has no effect
-	if this is enabled. If the option is set to 'true', 'yes', or '1',
-	the dialog uses a built-in generic prompt; otherwise the exact
-	value of the variable is used.
-
-guitool.<name>.revPrompt::
-	Request a single valid revision from the user, and set the
-	`REVISION` environment variable. In other aspects this option
-	is similar to 'argPrompt', and can be used together with it.
-
-guitool.<name>.revUnmerged::
-	Show only unmerged branches in the 'revPrompt' subdialog.
-	This is useful for tools similar to merge or rebase, but not
-	for things like checkout or reset.
-
-guitool.<name>.title::
-	Specifies the title to use for the prompt dialog. The default
-	is the tool name.
-
-guitool.<name>.prompt::
-	Specifies the general prompt string to display at the top of
-	the dialog, before subsections for 'argPrompt' and 'revPrompt'.
-	The default value includes the actual command.
+include::guitool-config.txt[]
 
 help.browser::
 	Specify the browser that will be used to display help in the
diff --git a/Documentation/guitool-config.txt b/Documentation/guitool-config.txt
new file mode 100644
index 0000000000..43fb9466ff
--- /dev/null
+++ b/Documentation/guitool-config.txt
@@ -0,0 +1,50 @@
+guitool.<name>.cmd::
+	Specifies the shell command line to execute when the corresponding item
+	of the linkgit:git-gui[1] `Tools` menu is invoked. This option is
+	mandatory for every tool. The command is executed from the root of
+	the working directory, and in the environment it receives the name of
+	the tool as `GIT_GUITOOL`, the name of the currently selected file as
+	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
+	the head is detached, 'CUR_BRANCH' is empty).
+
+guitool.<name>.needsFile::
+	Run the tool only if a diff is selected in the GUI. It guarantees
+	that 'FILENAME' is not empty.
+
+guitool.<name>.noConsole::
+	Run the command silently, without creating a window to display its
+	output.
+
+guitool.<name>.noRescan::
+	Don't rescan the working directory for changes after the tool
+	finishes execution.
+
+guitool.<name>.confirm::
+	Show a confirmation dialog before actually running the tool.
+
+guitool.<name>.argPrompt::
+	Request a string argument from the user, and pass it to the tool
+	through the `ARGS` environment variable. Since requesting an
+	argument implies confirmation, the 'confirm' option has no effect
+	if this is enabled. If the option is set to 'true', 'yes', or '1',
+	the dialog uses a built-in generic prompt; otherwise the exact
+	value of the variable is used.
+
+guitool.<name>.revPrompt::
+	Request a single valid revision from the user, and set the
+	`REVISION` environment variable. In other aspects this option
+	is similar to 'argPrompt', and can be used together with it.
+
+guitool.<name>.revUnmerged::
+	Show only unmerged branches in the 'revPrompt' subdialog.
+	This is useful for tools similar to merge or rebase, but not
+	for things like checkout or reset.
+
+guitool.<name>.title::
+	Specifies the title to use for the prompt dialog. The default
+	is the tool name.
+
+guitool.<name>.prompt::
+	Specifies the general prompt string to display at the top of
+	the dialog, before subsections for 'argPrompt' and 'revPrompt'.
+	The default value includes the actual command.
-- 
2.19.1.647.g708186aaf9

