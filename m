Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC2C433F5
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiC0Sw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiC0Sw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 14:52:29 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0465C9
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 11:50:49 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k7so10321384qvc.4
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDfcOct31U3ZEwsYob3Y8/Yzn8asDsmYfETpdORReHs=;
        b=BsUi8aO1NaKfSPQ8eRZSdSn5Jxz/OkIDoFBGYEABc0bm1RwZcWijCgNKlpCSWknUt6
         qPWiuMM8Slf1AOvvqlDw83T9xXt+MIMGuzb/YQHWAodLVkLs+gJ1d4UwWz6aWv3Hc+bJ
         zp9L06c1KAjt6dptxlpU89FYAPQk6JXGQhS8Z04qcJRs8vl0hy2LD9oQoEvr4kSH2daE
         mWWWQPPtHpD53QgroXKoWIIim4hfu0aIsKMxDyWcenxzN8HzU1PMue3gT2a1UOHqK8FO
         Gy8uysXDlrjPUdyD+QgQ3LaovhHswBKgbbLYFulmqsSqdt3N1sb5HZH0FnWr7DQoR0o4
         WVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDfcOct31U3ZEwsYob3Y8/Yzn8asDsmYfETpdORReHs=;
        b=IWnps9M3fL2sDyqI3lQv271jbv4d/g6SDeb/Hz5VQPHoBJubH2ECBHAoZ5xiCsQJWX
         CYkchRyzhSvqhnlPMvv72aPINXLf3teqOQOmX5bULCcqFlVMxhrYzwfG7zqT7f0Xy2JK
         Zm76rzN8CjH2DS6GhfwcSI/JgiyRXV6l3bI9f1nS6lbrUfr3l/kJSOIq1vLe2X1MV1Mk
         J7OidBBWB4Yombww07tIA7/tZ8m5tuGx1Qbc3jFQi3ViEDOXn8KVKYcoROBYsGQM0EMv
         /xtn1kSuawGlvHuFeFi5bLrQm/1VO3qZE7kezjimrPT6uJJffafvj4UhvPpaRjx9Hjeu
         Fe4w==
X-Gm-Message-State: AOAM532I7PU/lkgUfgz0wQiO09huQWRR7KmD7Cr5ZNrVcBJcec9zk6QQ
        hHXxEs0QpWwTWRqe9swawDrlY7otxosQKg==
X-Google-Smtp-Source: ABdhPJxobrPVRVn2nxNEd1A1onhFsB57kaD/SFY8wWezbonvsdGVCcwIWZRmJ7kEkQD6Lsc4LTABfA==
X-Received: by 2002:ad4:4f2b:0:b0:441:4092:c422 with SMTP id fc11-20020ad44f2b000000b004414092c422mr17456249qvb.126.1648407047661;
        Sun, 27 Mar 2022 11:50:47 -0700 (PDT)
Received: from localhost.localdomain (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 3-20020a370503000000b0067b03f03589sm6741637qkf.53.2022.03.27.11.50.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 27 Mar 2022 11:50:45 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>, gitster@pobox.com,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        rogi@skylittlesystem.org
Subject: [PATCH] fixup! vimdiff: add tool documentation
Date:   Sun, 27 Mar 2022 14:50:44 -0400
Message-Id: <20220327185044.20781-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
References: <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Use Asciidoc's syntax for "list continuation" and "open block" [1]
- Remove '-->' which mixes up the parser

[1] https://docs.asciidoctor.org/asciidoc/latest/lists/continuation/#list-continuation

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/mergetools/vimdiff.txt | 81 +++++++++++++++-------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
index 296bc76e98..1017527e7d 100644
--- a/Documentation/mergetools/vimdiff.txt
+++ b/Documentation/mergetools/vimdiff.txt
@@ -42,18 +42,20 @@ it):
 
 Let's see some examples to understand how it works:
 
-  * layout = "(LOCAL,BASE,REMOTE)/MERGED"
+* `layout = "(LOCAL,BASE,REMOTE)/MERGED"`
++
+--
+This is exactly the same as the default layout we have already seen.
 
-    This is exactly the same as the default layout we have already seen.
-
-    Note that "/" has precedence over "," and thus the parenthesis are not
-    needed in this case. The next layout definition is equivalent:
+Note that "/" has precedence over "," and thus the parenthesis are not
+needed in this case. The next layout definition is equivalent:
 
         layout = "LOCAL,BASE,REMOTE / MERGED"
-
-  * layout = "LOCAL,MERGED,REMOTE"
-
-    If, for some reason, we are not interested in the "BASE" buffer.
+--
+* `layout = "LOCAL,MERGED,REMOTE"`
++
+--
+If, for some reason, we are not interested in the "BASE" buffer.
 
            ------------------------------------------
            |             |           |              |
@@ -62,12 +64,13 @@ Let's see some examples to understand how it works:
            |             |           |              |
            |             |           |              |
            ------------------------------------------
-
-  * layout = "MERGED"
-
-    Only the "MERGED" buffer will be shown. Note, however, that all the other
-    ones are still loaded in vim, and you can access them with the "buffers"
-    command. 
+--
+* `layout = "MERGED"`
++
+--
+Only the "MERGED" buffer will be shown. Note, however, that all the other
+ones are still loaded in vim, and you can access them with the "buffers"
+command.
 
            ------------------------------------------
            |                                        |
@@ -76,12 +79,13 @@ Let's see some examples to understand how it works:
            |                                        |
            |                                        |
            ------------------------------------------
-
-  * layout = "@LOCAL,REMOTE"
-
-    When "MERGED" is not present in the layout, you must "mark" one of the
-    buffers with an asterisk. That will become the buffer you need to edit and
-    save after resolving the conflicts.
+--
+* `layout = "@LOCAL,REMOTE"`
++
+--
+When "MERGED" is not present in the layout, you must "mark" one of the
+buffers with an asterisk. That will become the buffer you need to edit and
+save after resolving the conflicts.
 
            ------------------------------------------
            |                   |                    |
@@ -92,12 +96,13 @@ Let's see some examples to understand how it works:
            |                   |                    |
            |                   |                    |
            ------------------------------------------
-
-  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"
-
-    Three tabs will open: the first one is a copy of the default layout, while
-    the other two only show the differences between "BASE" and "LOCAL" and
-    "BASE" and "REMOTE" respectively.
+--
+* `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE"`
++
+--
+Three tabs will open: the first one is a copy of the default layout, while
+the other two only show the differences between "BASE" and "LOCAL" and
+"BASE" and "REMOTE" respectively.
  
            ------------------------------------------
            | <TAB #1> |  TAB #2  |  TAB #3  |       |
@@ -134,11 +139,12 @@ Let's see some examples to understand how it works:
            |                   |                    |
            |                   |                    |
            ------------------------------------------
-
-  * layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"
-
-    Same as the previous example, but adds a fourth tab with the same
-    information as the first tab, with a different layout.
+--
+* `layout = "LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL/BASE/REMOTE),MERGED"`
++
+--
+Same as the previous example, but adds a fourth tab with the same
+information as the first tab, with a different layout.
  
            ---------------------------------------------
            |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
@@ -150,8 +156,9 @@ Let's see some examples to understand how it works:
            |       REMOTE        |                     |
            ---------------------------------------------
 
-    Note how in the third tab definition we need to use parenthesis to make ","
-    have precedence over "/".
+Note how in the third tab definition we need to use parenthesis to make ","
+have precedence over "/".
+--
 
 Variants
 ^^^^^^^^
@@ -173,9 +180,9 @@ In other words, using `--tool=[g,n,]vimdiffx` is the same as using
 `--tool=[g,n,]vimdiff` and setting configuration variable
 `mergetool.[g,n,]vimdiff.layout` to... 
 
-  * x=1 --> "@LOCAL, REMOTE"
-  * x=2 --> "LOCAL, MERGED, REMOTE"
-  * x=3 --> "MERGED"
+  * `x=1`: `"@LOCAL, REMOTE"`
+  * `x=2`: `"LOCAL, MERGED, REMOTE"`
+  * `x=3`: `"MERGED"`
 
 Example: using `--tool=gvimdiff2` will open `gvim` with three columns (LOCAL,
 MERGED and REMOTE).
-- 
2.29.2

