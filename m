Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD811FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 02:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdBIC3o (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 21:29:44 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36441 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdBIC3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 21:29:43 -0500
Received: by mail-pg0-f51.google.com with SMTP id v184so53097568pgv.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 18:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r2urWpFQc8SC8ah9BLxJkXV+sMJN9hmks7O2T/JSqhU=;
        b=qd+ZJkxKH8jvUfNx1Jc3XaDIlcoKAOtX1ZFH5Fd+nCTdWSqZMQhXu3i32MZXZfyR+H
         U96vN+grhMmnwgYACGqyNxnGH7Km8GbY5rlr9MzZYWK5fwhVgCMyfNn1gdhJ6UPunk6X
         lsSv+mkpuLBzRJeijqVDSOUsYnnYz8KieGBxF2SiYTPSD+AAjtcKw5vHAqlNgPkfEVQs
         PMIFpdkb0SgGKNHCiWZLjgMyM5kz58PPG+/1tPmG0Zvz0klYWuRPvaiqsL47WViQj/bx
         y4kfkGOKiVLKCsFgWxWHPvy3jq8CGvbbwP+xwXloFgQH/U9OpXR4RjzpKOmDtYEcvdQ2
         QVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r2urWpFQc8SC8ah9BLxJkXV+sMJN9hmks7O2T/JSqhU=;
        b=GsuzjeK7eFUQvJuktCHvB1HgcOZ3jk2g7qhgclwypFFYTGZ3mLw7G9fdgjDZ3lbGNm
         ABWEB/7CdSGpnn6RwuUpC089gUNEaI+vtltyb/sRg26dUWpbbu1yI9Fc7By9RCeEl53d
         e7r9m3RMZlWltmK8vYYxY4DKIA3lZXq86t7GszhSyq0/MscOd5cJjArWO9ivOXM/Mk1Z
         ugpsFc4SFCz8p7sRKfkke80eLDO3P9U8+1FyzwbI7KgCqszbOk8LZ2uFcGqeKl/+UVaD
         lQ8BPQxVE72pciz3Bgj+TGJG1Ok4fxqgYI2vWH0W33pMryfzN5IvFRXxGJHNR6/9Jet6
         utyw==
X-Gm-Message-State: AMke39kreqJx2Ij1uUabXGJwISwJqPZTp/WXxgJ5IQWWlyOa4ZPJM1P2QgZ85Dn8W4ljgl4w
X-Received: by 10.99.67.6 with SMTP id q6mr704859pga.156.1486603777064;
        Wed, 08 Feb 2017 17:29:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:684e:2fd8:5eea:9943])
        by smtp.gmail.com with ESMTPSA id z77sm23360339pfk.47.2017.02.08.17.29.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 17:29:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation: unify bottom "part of git suite" lines
Date:   Wed,  8 Feb 2017 17:29:30 -0800
Message-Id: <20170209012930.9943-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.1.g018cb5e6f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have 168 man pages that mention they are part of Git, you
can check yourself easily via:
  $ git grep "Part of the linkgit:git\[1\] suite" |wc -l
  168
However some have a trailing period, i.e.
  $ git grep "Part of the linkgit:git\[1\] suite." |wc -l
  8

Unify the bottom line in all man pages to not end with a period.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitcore-tutorial.txt     | 2 +-
 Documentation/gitcvs-migration.txt     | 2 +-
 Documentation/gitdiffcore.txt          | 2 +-
 Documentation/gitglossary.txt          | 2 +-
 Documentation/gitrepository-layout.txt | 2 +-
 Documentation/gittutorial-2.txt        | 2 +-
 Documentation/gittutorial.txt          | 2 +-
 Documentation/gitworkflows.txt         | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 22309cfb48..3a0ec8c53a 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1658,4 +1658,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 4c6143c511..1cd1283d0f 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -203,4 +203,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 08cf62278e..46bc6d077c 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -288,4 +288,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index 212e254adc..571f640f5c 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -24,4 +24,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index a5f99cbb11..f51ed4e37c 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -289,4 +289,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 30d2119565..e0976f6017 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -433,4 +433,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index b3b58d324e..794b83393e 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -674,4 +674,4 @@ link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index f16c414ea7..177610e44e 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -477,4 +477,4 @@ linkgit:git-am[1]
 
 GIT
 ---
-Part of the linkgit:git[1] suite.
+Part of the linkgit:git[1] suite
-- 
2.12.0.rc0.1.g018cb5e6f4

