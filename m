Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D81C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 02:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJNCGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 22:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJNCGa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 22:06:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24F718C414
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 19:06:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so5452473wrj.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=In5JSCPXiTpPO9nE0wVqi/kKAaNVSvdrefDOcKzbqW8=;
        b=o33yMEbUUyEwPv/y0adQkiY2uiDPXnkNysQ3eztFvqQoowVouJity7xR8qC/2UXRhj
         9EhVpVxSNnyygVtx0ghi00ewDcCjIaw9+D+jbWNYl2UnLCGNUxd+Mf50lK43qgbBI8Yh
         5M69YRQtG/45TsqwICsI3X8y6qglcjla0yLVmBzW62L2vVHvONb2VtljjRFQ/8/A1fYh
         w0LJRaxLwK4l3vakQNv6DFCLkD6Tic6fneXDkK06PqcMXrxpYvK6Fk+0UabyLZ5lwjDO
         U4Jg0sCmjxjJOYfrcCk6ee57KqrsRpVOAo+vSf4kcdC+wub0mKohNeULySVOg2zzGS1g
         OjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=In5JSCPXiTpPO9nE0wVqi/kKAaNVSvdrefDOcKzbqW8=;
        b=UEJYXHAtbjVJ5lDjG4GZMAMZeYSrrktPYnQjiBEQlB/xKCusB068vIekMUf+KA/NmI
         Y+Fz0OYeIhyT9SHecXC3ZKLqeF6zLYpfVWPJpw3azZz9kcKEkdHvCODvILxgwcdEG+sa
         0U26Xqh28/q1354GtsjcF2SnLtDRe+hMsSvNX+wVrNhp1TOJq3uZ6EGonC/L0tZEXg+4
         QHBq0y+BbdQGNl4rav6TmtLyNEBfDRjkVp2461Jexa3PHXW8jX8bMhkLwTLTM4D65Mtw
         1sz6yi6n+cvwuRzx6Cqi4CATpOVQ+FJuKNcI54fjSZPBb3Z7wHwD8Mjul7GA/IqSsi9k
         5oQw==
X-Gm-Message-State: ACrzQf2HzSrK4qVoaxr69/ENbL5zAtg+/e1e0cYQnukTBHQUQEXdE2jW
        VIxpcWBRKg7onfQFbttHyzL6qS24ZGE=
X-Google-Smtp-Source: AMsMyM5Ps7kaJBGiJSA7z/JABmxcUYQCoYRmCVXDHE7fWKVWOJa/rl4UUrkCBLEgH+FfTBLgF9ztTw==
X-Received: by 2002:a5d:6901:0:b0:22f:b097:7de6 with SMTP id t1-20020a5d6901000000b0022fb0977de6mr1749586wru.373.1665713186560;
        Thu, 13 Oct 2022 19:06:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a5d6247000000b0022c906ffedasm808665wrv.70.2022.10.13.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 19:06:25 -0700 (PDT)
Message-Id: <pull.1362.git.git.1665713184304.gitgitgadget@gmail.com>
From:   "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 02:06:24 +0000
Subject: [PATCH] [OUTREACHY] t1002: modernize outdated conditional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        wilberforce <nsengiyumvawilberforce@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: wilberforce <nsengiyumvawilberforce@gmail.com>

Tests in this script use an unusual and hard to reason about
conditional construct

    if expression; then false; else :; fi

Change them to use more idiomatic construct:

    ! expression

Cc: Christian Couder  <christian.couder@gmail.com>
Cc: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Nsengiyumva  wilberfore <nsengiyumvawilberforce@gmail.com>
---
    [OUTREACHY]cleaning t1002-read-tree-m-u-2way.sh
    
    This is an update in t1002-read-tree-m-u-2way.sh. all the tests that use
    the unusual construct: if read_tree_u_must_succeed -m -u $treeH $treeM;
    then false; else :; fi have been updated to ! read_tree_u_must_succeed
    -m -u $treeH $treeM "I am an outreachy applicant" CC: Christian Couder
    christian.couder@gmail.com, Hariom verma hariom18599@gmail.com
    Signed-off-by: wilberforce nsengiyumvawilberforce@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1362%2Fnsengiyumva-wilberforce%2Ft1002_usual_construct_updated-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1362/nsengiyumva-wilberforce/t1002_usual_construct_updated-v1
Pull-Request: https://github.com/git/git/pull/1362

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
