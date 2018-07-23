Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6B81F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbeGWOyT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47080 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbeGWOyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so431402pgv.13
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9bFd3gjeCIItAqEuYT/FWKUIK7J3MNEz+NnVCjblLKA=;
        b=Vy55aSfikzTQDJMdXdnUwLXKuc7n1FrHpXnQmSmRxVU74YM5p5FpDnNAQCLZ1djAgs
         B5peBNdrpDfEzRvvzqnSDREdtMorP2eedpEoaX8nc3ECnMVzzwTm4Rn1/wQEoj2X6NfH
         o0tDrubDZIdCUF30jg7RbGyHVsFV1pIbar558VfCvypVSltfsafYbJ/snwbN8sPuQ5va
         ZhvY11VWVQb24xLQzV75JXbvKTTVv8lTxRFg/DG7aHJ+KuS0SvHMytRKrcH0siDeNDA4
         0fxhoVQtC9gohNEhokedcNkdHdSuB9pMXWByPo/msUnBtjMuInE3ToXl6rXGlLW8CpDr
         MRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9bFd3gjeCIItAqEuYT/FWKUIK7J3MNEz+NnVCjblLKA=;
        b=jh5pqXvLI0Vn7ainqibaSfLaJNczn+WlnqQl87yAwm1JYHFeW1aXMO+rQtgVDe1lE9
         sCQhj+HiHPLI3mM8i8SdROt8+6/P6fUaMlgZQDhj85Or51tTPU+rSjXGUteUsuDzGZxy
         kXYvQlJjAWbpYjlu6xQYMOYMXnUCiJ+78qty1PolJKlZ5NIdBnbH+nf/E9gtBmpuvSvS
         iTorkUYT5VPFCY8o1ZjjuIcMFqNO7j4GZQY3gOdg9jqvqx2R9UluDWVhZp64d/yUl19T
         q2Eoi7GVrACelYVl5KlgdSTB50NE1mWjjo2YPU2PRonzknQ5pBrKy9BIuLpJBkVTaqyo
         41Kw==
X-Gm-Message-State: AOUpUlGna8IvCiyVZ8g6PZIrEtKJtUrqq91w+6ZPdjdYpwH96tBHc90x
        MFuWAiSt4zHZ9QO565FD3xHKTMcX
X-Google-Smtp-Source: AAOMgpeu/yANVeyJAafaPS3F6XQ6FCk0dTc6CWwGYhNOQTeX72Pfmi0JlDQDe4C+AwtyvEONQN8Bqg==
X-Received: by 2002:a62:43c8:: with SMTP id l69-v6mr13505737pfi.196.1532353975447;
        Mon, 23 Jul 2018 06:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id j191-v6sm15237388pfc.136.2018.07.23.06.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:54 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:54 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:41 GMT
Message-Id: <06dcf6d974b67afcd599daa79b5820160ac42ed2.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/9] vscode: only overwrite C/C++ settings
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

The C/C++ settings are special, as they are the only generated VS Code
configurations that *will* change over the course of Git's development,
e.g. when a new constant is defined.

Therefore, let's only update the C/C++ settings, also to prevent user
modifications from being overwritten.

Ideally, we would keep user modifications in the C/C++ settings, but
that would require parsing JSON, a task for which a Unix shell script is
distinctly unsuited. So we write out .new files instead, and warn the
user if they may want to reconcile their changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/vscode/init.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index 494a51ac5..ba9469226 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -13,7 +13,7 @@ die "Could not create .vscode/"
 
 # General settings
 
-cat >.vscode/settings.json <<\EOF ||
+cat >.vscode/settings.json.new <<\EOF ||
 {
     "C_Cpp.intelliSenseEngine": "Default",
     "C_Cpp.intelliSenseEngineFallback": "Disabled",
@@ -51,7 +51,7 @@ esac
 
 # Default build task
 
-cat >.vscode/tasks.json <<EOF ||
+cat >.vscode/tasks.json.new <<EOF ||
 {
     // See https://go.microsoft.com/fwlink/?LinkId=733558
     // for the documentation about the tasks.json format
@@ -73,7 +73,7 @@ die "Could not install default build task"
 
 # Debugger settings
 
-cat >.vscode/launch.json <<EOF ||
+cat >.vscode/launch.json.new <<EOF ||
 {
     // Use IntelliSense to learn about possible attributes.
     // Hover to view descriptions of existing attributes.
@@ -175,3 +175,20 @@ vscode-init:
 	echo '}'
 EOF
 die "Could not write settings for the C/C++ extension"
+
+for file in .vscode/settings.json .vscode/tasks.json .vscode/launch.json
+do
+	if test -f $file
+	then
+		if git diff --no-index --quiet --exit-code $file $file.new
+		then
+			rm $file.new
+		else
+			printf "The file $file.new has these changes:\n\n"
+			git --no-pager diff --no-index $file $file.new
+			printf "\n\nMaybe \`mv $file.new $file\`?\n\n"
+		fi
+	else
+		mv $file.new $file
+	fi
+done
-- 
gitgitgadget

