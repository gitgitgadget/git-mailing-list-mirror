Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DAEC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJNS2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNS2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 14:28:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D421D2F49
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:28:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n9so3657884wms.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NcK76NwrJjWQFZ2ydrUWUiJqmmCzS6Hx6oSwDMI0Yo=;
        b=i5bI6CzcnLl/5xhzsNz82elDdB4xBl/pbo73yt+J5aNSgAJWDZvyFqvZlpajUZ+PzL
         haZ2KbGK9GH1FY+vbSGzp1bzPvQRQBMrkJbsIFYgd5RRulza/I752qy6GYauQB1xskB0
         akSqF9inrV5phtE7mJI5bKOBsAAyr2SjGaqXZMKsbSLE9ggE9U7bXmt6MnVqOB/BYaW9
         tAYZcFKAHXm1/xpNhm/Y1kljKRSZlM24GgHthF3IrIOyVv7XY3mRceMuN+kOU8u7sbFT
         DKzQaiyvUMw96KkEThhaRiJKYQnieyN9PSLaDlwJHREU5P9PxNDFUHdZeQuZL/sZJlZl
         xbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NcK76NwrJjWQFZ2ydrUWUiJqmmCzS6Hx6oSwDMI0Yo=;
        b=jxFadvfat60uPgeVYHrXDCmnfodJRs4pTSQYvHUYQadwaWNCIaeBqhY9vkbT17QgH9
         mPb8neMiKkM/lNpjdZL4T8h6jGh3nyPXsqOVdx9yUQMQSO6uhTYkzgGGsQve6Lz5k7n+
         6IewVENnUeC0ZlZu+CffmwFE+TC9SLpHtcmztNl8sB/It49Od5ArKvS3Y9jmTJeGJJBA
         BLWEF3pErCCBG1eWxd9C7kyseYPnlGsFv2D2IBJnbLrFF9CQJizMuQzyXdwXRROrJ7j5
         /GrdGhU1WD3JgRj9j555x/zIzwfClEy5guM7MekhjMENFEY25BOB1MvDpWHOpbSzYMKU
         JDJg==
X-Gm-Message-State: ACrzQf2qKSti294X9DGxBwaI9YZMLBYonxePz7o0tEaG8nDz5q7PnV0h
        EBHz2pxj+P1FZUuoTuibDX6M9Z9LDaE=
X-Google-Smtp-Source: AMsMyM5HdC/rtjvWUPY1dZrh9ai+Cp2iT9ZD6znurysja5dYEjdTcikaOwoQ+S0gvN1b6KyfghsESg==
X-Received: by 2002:a05:600c:689b:b0:3c2:fd6e:1fe5 with SMTP id fn27-20020a05600c689b00b003c2fd6e1fe5mr4543661wmb.99.1665772131343;
        Fri, 14 Oct 2022 11:28:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b003b5054c6f87sm2706171wmc.21.2022.10.14.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:28:50 -0700 (PDT)
Message-Id: <pull.1362.v4.git.git.1665772130030.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
References: <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
From:   "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 18:28:49 +0000
Subject: [PATCH v4] [OUTREACHY] t1002: modernize outdated conditional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        nsengaw4c <nsengiyumvawilberforce@gmail.com>,
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

Signed-off-by: Nsengiyumva  Wilberforce <nsengiyumvawilberforce@gmail.com>
---
    [OUTREACHY]cleaning t1002-read-tree-m-u-2way.sh
    
    This is an update in t1002-read-tree-m-u-2way.sh. all the tests that use
    the unusual construct: if read_tree_u_must_succeed -m -u $treeH $treeM;
    then false; else :; fi have been updated to ! read_tree_u_must_succeed
    -m -u $treeH $treeM "I am an outreachy applicant" CC: Christian Couder
    christian.couder@gmail.com, Hariom verma hariom18599@gmail.com
    Signed-off-by: wilberforce nsengiyumvawilberforce@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1362%2Fnsengiyumva-wilberforce%2Ft1002_usual_construct_updated-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1362/nsengiyumva-wilberforce/t1002_usual_construct_updated-v4
Pull-Request: https://github.com/git/git/pull/1362

Range-diff vs v3:

 1:  d019ce50dc9 ! 1:  c0109d947d4 [OUTREACHY] t1002: modernize outdated conditional
     @@ Commit message
      
              ! expression
      
     -    Cc: Christian Couder  <christian.couder@gmail.com>
     -    Cc: Hariom Verma <hariom18599@gmail.com>
          Signed-off-by: Nsengiyumva  Wilberforce <nsengiyumvawilberforce@gmail.com>
      
       ## t/t1002-read-tree-m-u-2way.sh ##


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
