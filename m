Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A2A1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJ0PEa (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39204 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeJ0PE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id a28-v6so82296ljd.6
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qp2fBJjjIsrsxpWd2IOIqlK7/Ctv5GdpBjMWlrNpPQg=;
        b=ahfvBQUZccop95qKlDVpXmtMF+/RWoSeUqU3sLoNkZtf58OylviC3fUoq7WCqJ7rVJ
         c6Few/JIvHOFipJfilcglrSTBDefImfeZicFLddYvzjkV+e+5Pqkq2WYqOOncOHgDkU0
         G9SDJiC/sGeo3wyQG9i1j02TFuTyv9QW++RIpbiTfEIbpAE7YoEHKFkQpfhg8qs/pL+T
         gsnLfH0RCCpLP5FXpIJ1Ia1ovs2v2isPjsZv6WQWQtJJ/3b/FN7XzTHMWONS3WCLS2Vb
         DS1zV0zlNqAlI/zAeY0sHCuo54HPvijdrnWv0Oc2L323OP1yXOUzxq5FGcvM2KmNmjGk
         CcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qp2fBJjjIsrsxpWd2IOIqlK7/Ctv5GdpBjMWlrNpPQg=;
        b=PzM4Uhrq6r/HQ/5VaZD5BMiPmXDCDrLePoaov1Zv5Y7xLD73N8BXqHb+dCROHhEiDT
         3y/fczqMoiEpfM5MytpxNaEqjD9HB8BxvlVT1N0Rh2hWZHgEBJlAjHI9btTNWinQI7X7
         WbYgG1eFUlEjtO/J0fQaD0R2V+IdCQNNdyqYWqdJOUEvCCZ3HRUFXRCCySxM3AQFBvTL
         jr1P/kbbCXfdTU+E38iSs5qpNFPTOqFofzuOiiHDCW7t78S4Ksniu2GGihCuZDY1juBE
         hk3n65JD0aoXPCve+rchPskd34zrLBTvzYLRoFTpT5xa4LeUAF18YkJijp3iCz/giHF1
         JrAw==
X-Gm-Message-State: AGRZ1gKs4Khw3jlNBaXSeLu3F8AshH9LBDh0qvpW51QwvtGsvtTdVMjt
        O0u5c2lQjYXkB/+Xx5KWWf1Zc/h6
X-Google-Smtp-Source: AJdET5dOTtFV7yoWzqCIVcybQBTeQKv6pHQK2i8w+hZKNeRjnDEUs2hySr67TKWuCStM67Ebpu9Nkw==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr4033604ljc.37.1540621473410;
        Fri, 26 Oct 2018 23:24:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 32/78] config.txt: move guitool.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:05 +0200
Message-Id: <20181027062351.30446-33-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
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
 Documentation/config/guitool.txt | 50 +++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/config/guitool.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 093a71e5d1..dda5812a8a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -345,56 +345,7 @@ include::config/gpg.txt[]
 
 include::config/gui.txt[]
 
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
+include::config/guitool.txt[]
 
 help.browser::
 	Specify the browser that will be used to display help in the
diff --git a/Documentation/config/guitool.txt b/Documentation/config/guitool.txt
new file mode 100644
index 0000000000..43fb9466ff
--- /dev/null
+++ b/Documentation/config/guitool.txt
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

