Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02FC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 07:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJNHrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 03:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNHrc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 03:47:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C7122751
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 00:47:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a10so6256591wrm.12
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADT+ODF0ZwN5qpy4V3WkvK+XzBuxCVY6SaTaDctQC28=;
        b=VbHl9Bi/mVIlVOci5xeLlIKadR8/fTX+aM1A6VP9EvwP7HrkkooMhwag8G7s03s6WZ
         lV6nHz0y/mPLT8MmadWKFzQmVi+WihgUwOWzk8F7UAp1qCLuK0T0ZcG1KC7OI+mUkUeA
         Pq8AqafKVjDJI31yMH9Bi1PuAL+GrSnwcui5msU+fORp8QbPgZsm/WxF5SE9PtsiW1+0
         YKikAotbRYPpC9U2Qa103tQoap7SGCC5cgFyT1bkDauSm28MfKIVwUVi9DtIsZ4wbSYJ
         rN17njxpdZdjqwmN7nvf/dX/XVDZGPWXzLpf+EjYz6KMEFfiz17KTb6eSA7ANsIV+m7g
         TL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADT+ODF0ZwN5qpy4V3WkvK+XzBuxCVY6SaTaDctQC28=;
        b=oZ1kfRSagRT1B4J0EdXSPLRkQyd1T7RfgJh6JGR67DqBNYuNT8FqeV40AjyY2Uo8BT
         LmJAuv9MBIN3Q6Syo3R71Cmi25BCypokOOIM97Q/2sIfb1wXKbfTvEmr8dqdKHcQ4wgz
         tLgQueQ58jqBKa2CCKIE8r0kLLgPcuW6YNtpqj4l3oX2wc3SE9yMevB+I6fpB+SaiwV4
         iGJnjZhXpO1gUNT/Q3IGufBjm6Xqywl+iYd9y4sfRTuY/bnhe4TClbVnKb4vLshIsK+8
         4mxypcJNntLXEe9xByKnkBPrk9vbC8r7y3y+LbZeiPGSOCt8KcBQnQjN+Kx3VgjCKTtk
         xRRA==
X-Gm-Message-State: ACrzQf372GcOE/LMoSCP+xdSgUZRO08CBK3jszUk+En54wOzCjS3ufms
        cVM6rk/VBCY9L84A9Ih2SRUhp/rtIu0=
X-Google-Smtp-Source: AMsMyM5yn8wdWCDtdOeyc5P8Oqk3CbHtLhTi+NnJvJvJX64nOh1Zb+9SVmyt7DTE2VAT5AeYdz6Pkg==
X-Received: by 2002:a5d:500b:0:b0:232:1343:8686 with SMTP id e11-20020a5d500b000000b0023213438686mr2358851wrt.285.1665733648692;
        Fri, 14 Oct 2022 00:47:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003b49bd61b19sm6080928wmm.15.2022.10.14.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 00:47:28 -0700 (PDT)
Message-Id: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.git.git.1665713184304.gitgitgadget@gmail.com>
References: <pull.1362.git.git.1665713184304.gitgitgadget@gmail.com>
From:   "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 07:47:27 +0000
Subject: [PATCH v2] [OUTREACHY] t1002: modernize outdated conditional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>

Tests in this script use an unusual and hard to reason about
conditional construct

    if expression; then false; else :; fi

Change them to use more idiomatic construct:

    ! expression

Cc: Christian Couder  <christian.couder@gmail.com>
Cc: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Nsengiyumva  Wilberfore <nsengiyumvawilberforce@gmail.com>
---
    [OUTREACHY]cleaning t1002-read-tree-m-u-2way.sh
    
    This is an update in t1002-read-tree-m-u-2way.sh. all the tests that use
    the unusual construct: if read_tree_u_must_succeed -m -u $treeH $treeM;
    then false; else :; fi have been updated to ! read_tree_u_must_succeed
    -m -u $treeH $treeM "I am an outreachy applicant" CC: Christian Couder
    christian.couder@gmail.com, Hariom verma hariom18599@gmail.com
    Signed-off-by: wilberforce nsengiyumvawilberforce@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1362%2Fnsengiyumva-wilberforce%2Ft1002_usual_construct_updated-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1362/nsengiyumva-wilberforce/t1002_usual_construct_updated-v2
Pull-Request: https://github.com/git/git/pull/1362

Range-diff vs v1:

 1:  b2ed686bc94 ! 1:  8a9cd66d7d9 [OUTREACHY] t1002: modernize outdated conditional
     @@
       ## Metadata ##
     -Author: wilberforce <nsengiyumvawilberforce@gmail.com>
     +Author: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
      
       ## Commit message ##
          [OUTREACHY] t1002: modernize outdated conditional
     @@ Commit message
      
          Cc: Christian Couder  <christian.couder@gmail.com>
          Cc: Hariom Verma <hariom18599@gmail.com>
     -    Signed-off-by: Nsengiyumva  wilberfore <nsengiyumvawilberforce@gmail.com>
     +    Signed-off-by: Nsengiyumva  Wilberfore <nsengiyumvawilberforce@gmail.com>
      
       ## t/t1002-read-tree-m-u-2way.sh ##
      @@ t/t1002-read-tree-m-u-2way.sh: test_expect_success \


 t/t1002-read-tree-m-u-2way.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index bd5313caec9..cdc077ce12d 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -154,7 +154,7 @@ test_expect_success \
      read_tree_u_must_succeed --reset -u $treeH &&
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 test_expect_success \
     '9 - conflicting addition.' \
@@ -163,7 +163,7 @@ test_expect_success \
      echo frotz frotz >frotz &&
      git update-index --add frotz &&
      echo frotz >frotz &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 test_expect_success \
     '10 - path removed.' \
@@ -186,7 +186,7 @@ test_expect_success \
      echo rezrov >rezrov &&
      git update-index --add rezrov &&
      echo rezrov rezrov >rezrov &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 test_expect_success \
     '12 - unmatching local changes being removed.' \
@@ -194,7 +194,7 @@ test_expect_success \
      read_tree_u_must_succeed --reset -u $treeH &&
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 test_expect_success \
     '13 - unmatching local changes being removed.' \
@@ -203,7 +203,7 @@ test_expect_success \
      echo rezrov rezrov >rezrov &&
      git update-index --add rezrov &&
      echo rezrov >rezrov &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 cat >expected <<EOF
 -100644 X 0	nitfol
@@ -251,7 +251,7 @@ test_expect_success \
      read_tree_u_must_succeed --reset -u $treeH &&
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 test_expect_success \
     '17 - conflicting local change.' \
@@ -260,7 +260,7 @@ test_expect_success \
      echo bozbar bozbar >bozbar &&
      git update-index --add bozbar &&
      echo bozbar bozbar bozbar >bozbar &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 test_expect_success \
     '18 - local change already having a good result.' \
@@ -316,7 +316,7 @@ test_expect_success \
      echo bozbar >bozbar &&
      git update-index --add bozbar &&
      echo gnusto gnusto >bozbar &&
-     if read_tree_u_must_succeed -m -u $treeH $treeM; then false; else :; fi'
+     ! read_tree_u_must_succeed -m -u $treeH $treeM'
 
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \

base-commit: d420dda0576340909c3faff364cfbd1485f70376
-- 
gitgitgadget
