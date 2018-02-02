Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7621F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeBBE6D (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:58:03 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36410 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBBE6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:58:01 -0500
Received: by mail-pf0-f194.google.com with SMTP id k5so683155pff.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mE1RiuDulU8tk7IMJTNwXG4uu+wKspfOG2e6kXm1PKU=;
        b=tmJeb02VaRUyumfapbV+DveU3x1HqwOaLWDznIPvI3HHiVgDDczTqzVDw8RQXA0mcz
         i6GAHcINhSfTQ9DYtCILABdqDbOW6AVbg7Bw4UMxdwVIq0yVIgwWuHh6YUbFOs0eS5Mm
         qNUb7Xube7Jp3XS2XcXs/fXC0MutRuzIUbbUzFpHMxRcMnXtRfV9V7asBr29JWFX+o6M
         sa0vEpZuqXXCpSuMWWFMU5nLXvGAFBXHluGWCXkpz7MPVgA34FX6Lc+23KIDLEUwAZI0
         gwNGvIpuZFwvYvoJeiKMJ3AKQQe8sc/p16W3fItYljiuWtw2+B7DrH1Yv9/coUguSLhn
         NvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mE1RiuDulU8tk7IMJTNwXG4uu+wKspfOG2e6kXm1PKU=;
        b=ULRaRY9RDylnHJ8d5rct57KiuSR6bVhk4iaAYy+sVKirFjWJodDM+IiAAD1Sw3hwog
         8S+sxI9t4jkvm4yG36xZ7JeDX4WnWl90bs3aM/gdIA6zGV9QGvzXWou5I9nkEoapgVtS
         1rPBQWFkY9sppMS5BQMsITMxbGG7TZUk3Voz7sjBxW8aAsOHoOe4JMm32qh0isFo9Rrx
         pFCgubkFavsZf5Yf9DK9YSBUi0yVPEIE0nEBBj/HT5XN7wqOtefGQPVgmnG/aJcbivp6
         COtldSWZPM2H405LBtKwzemRrw/fnovmrgK4DJw7f7v0YF/73B0znLwxpZdaFOytdfJD
         UH0w==
X-Gm-Message-State: AKwxytcKTggU+earAdACEizAom9LXDPa9Q4c3VfCvV0B5Q+VpQJGFCW/
        Csh/dcvz12rRwEs6AUJ2IbZgkRJ0
X-Google-Smtp-Source: AH8x224u28yTOKHqiNqtu6JO831CKH6DlrnZVHnD6KUqktsTtxcStrMu8QFdz8H7MuWfFxBVQsNAvw==
X-Received: by 10.98.182.16 with SMTP id j16mr7913398pff.220.1517547480506;
        Thu, 01 Feb 2018 20:58:00 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.200])
        by smtp.gmail.com with ESMTPSA id e3sm1496467pfb.143.2018.02.01.20.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:57:59 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 2/5] submodule foreach: document '$sm_path' instead of '$path'
Date:   Fri,  2 Feb 2018 10:27:42 +0530
Message-Id: <20180202045745.5076-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202045745.5076-1-pc44800@gmail.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..a23baef62 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,12 +183,14 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
+	The command has access to the variables $name, $sm_path, $sha1 and
 	$toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$sm_path is the path of the submodule as recorded in the superproject,
+	$sha1 is the commit as recorded in the superproject, and
+	$toplevel is the absolute path to the top-level of the superproject.
+	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
+	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-- 
2.15.1

