Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C881F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbeCEUFG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:05:06 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38475 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeCEUFF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:05:05 -0500
Received: by mail-pl0-f68.google.com with SMTP id m22-v6so6822225pls.5
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t5ZvmkvDCWzFhfQ52bTdfywoOCd5FZeKMk7Lu/Zu5sA=;
        b=qGgvYgQ1RwclbWDTyvGcCscsUKZ+Ifzyq+N4qWNR7gKUU+KC5VIwBJ7yEqh1EqeJgA
         GlQeeIAN9oMB4/36edlMJmXFhc0FZ3PdVkKU1+/ftCx3SHGI8URU6zNvmAxZiIYG/ln+
         F/VDfAfHLCBl5V0g7ai1i/GM7hsrMztiYe4QIC8LpemKJy6KEeNGEXW1c+qv1muMsC0v
         SYwz2l7YOL0WJyz2P1YKhs/Pmj0DqwxhAob/qFBBjVqhE/yLjNCFOgvL+OSPhED3P04e
         Bqqh1Xfo3J57MEckZ0KJ/gUFyXR6RXEiIJjAn+LtDYeYhwiTwnTPYkzbf1pYQtJ5VnI6
         rYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t5ZvmkvDCWzFhfQ52bTdfywoOCd5FZeKMk7Lu/Zu5sA=;
        b=XNAKvUSSq01BB+wyPa8GWNk+mX6UpvL2rEPj1Ier5PHCzDlmxsgQTf1DVHQGx/lH6V
         ZgdKP5JzLtCdPuEtvZv6EZRk8tDtAdSR/QEmftR4vwQSP3fPjFP4SWy4d1ENai7qnNRe
         3NkaqN+oQP6BdPWL0TNmsYDQlyYwn7DE8Q5JsXS9gQTP5qo49G1/zhOlu1w2LvoPWHsu
         5Q3C5kfUKZ//+tifBl7okueS3bjM4GF0QQM1nrYQ82s/7DggoKIPZIMmtxfHUiD/vk7l
         fMbEb7t5vCV6V0qfMBqNdQTf/978Q4v+d6FBD4qXY1erss8tvP/P+URGTwDqJyHbA45/
         C7Kw==
X-Gm-Message-State: APf1xPCGPumDSoGspur/CzpCMBD746IT25jDn2toCb735sWP2fkXisWo
        eji7FKqp2/E0lIZQLOEqNcMGzKRH
X-Google-Smtp-Source: AG47ELtBpRvM82K/L3vT60IHVA8oWMktxmzmKQgSbT8XE7bQXh84x4x5ocUTEIDPDm48hi8BWjCmdg==
X-Received: by 2002:a17:902:684a:: with SMTP id f10-v6mr14552134pln.129.1520280304320;
        Mon, 05 Mar 2018 12:05:04 -0800 (PST)
Received: from localhost.localdomain ([106.219.120.236])
        by smtp.gmail.com with ESMTPSA id u79sm33106262pfi.186.2018.03.05.12.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Mar 2018 12:05:03 -0800 (PST)
From:   SiddharthaMishra <sidm1999@gmail.com>
To:     git@vger.kernel.org
Cc:     SiddharthaMishra <sidm1999@gmail.com>
Subject: [GSoC] [PATCH] travis-ci: added clang static analysis
Date:   Tue,  6 Mar 2018 01:34:00 +0530
Message-Id: <20180305200400.3769-1-sidm1999@gmail.com>
X-Mailer: git-send-email 2.16.2.248.ge2408a6f7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added a job to run clang static code analysis on the master and maint branch

Signed-off-by: SiddharthaMishra <sidm1999@gmail.com>
---
 .travis.yml               | 17 ++++++++++++++++-
 ci/run-static-analysis.sh |  9 ++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 4684b3f4f..9b891d182 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -48,7 +48,7 @@ matrix:
       before_install:
       before_script:
       script: ci/run-linux32-docker.sh
-    - env: jobname=StaticAnalysis
+    - env: jobname=CocciStaticAnalysis
       os: linux
       compiler:
       addons:
@@ -59,6 +59,21 @@ matrix:
       before_script:
       script: ci/run-static-analysis.sh
       after_failure:
+    - if: branch IN (master, maint)
+      env: jobname=ClangStaticAnalysis
+      os: linux
+      compiler:
+      add_ons:
+        apt:
+          sources:
+          - ubuntu-toolchain-r-test
+          - llvm-toolchain-trusty
+          packages:
+          - clang
+      before_install:
+      before_script:
+      script: ci/run-static-analysis.sh
+      after_failure:
     - env: jobname=Documentation
       os: linux
       compiler:
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index fe4ee4e06..6ae032f54 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -5,6 +5,13 @@
 
 . ${0%/*}/lib-travisci.sh
 
-make coccicheck
+case "$jobname" in
+ClangStaticAnalysis)
+	scan-build -analyze-headers --status-bugs make
+	;;
+CocciStaticAnalysis)
+	make coccicheck
+	;;
+esac
 
 save_good_tree
-- 
2.16.2.248.ge2408a6f7.dirty

