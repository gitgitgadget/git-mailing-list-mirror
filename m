Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8260EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJNIBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNIBr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:01:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA51B94F4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:01:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f11so6325396wrm.6
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHoYupJRYh7xdqzcfzGtVybXf6tZA6pQM7XoF/ollJw=;
        b=m6YYvfHdiNg925WfQsdTYKF/wHJEqcQ42r2ID6c1oB8+Zjt2jioo4Sw7KKUv42w+zF
         GkIAPX0DcTqfsH+ThSnVKGyHjzlu4EWzs7PIz6m6OiWzKYtfa9FGi2yMjjMUM4Tuiegi
         6FNzl6IBrCq4A4kx4ghaTkVhtwM9EdiHFuCQcK86N60ZCTm5R+OHFQUxJyywrbMJgQRa
         56PsGk660THuaigDXwnS2rHwP1QbfHh/u6E9XG8VKtL5kzvpof+MOReqERKbqr8jRrlY
         8nQRUPjFpo8WCl5NRmbkgVSakDQ1cSFpbl0aX9He+h25zVUIb1Z/lc68nCazkYTUhGSs
         QN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHoYupJRYh7xdqzcfzGtVybXf6tZA6pQM7XoF/ollJw=;
        b=7KCeTzBM1/cqlgzVVvHA211pO4lJDMMfz34cMp17OEWOk7c5j/UipuOKRxKuX/AWiV
         YdFZpAiqJf735GW2SPofO5vAjINPni1ZKigGGpQ//YBIQGgJK/1fKahgr3hsfUYemTon
         N2c+gnPOFDkuMGUGywxDjVlhl+IKVgDL7pLTMSHgPtUkrvoVFNh0uiztuFs8rLE1dkOc
         k8u7U5qsMBwwye9Rl+KPj+BOQoo+166XYOqY/xKhREZXtquzVuX/buKIlCqYGR9fdrfV
         H03Zrw2bdkLgV6S2h/kHF+Qrhrr2mddJDkU03cuYc5294WsXCE7DvoRSKhlwFGr3cWPj
         5wug==
X-Gm-Message-State: ACrzQf1vkrf/X+HWmYe9nkLl+widJt2Lms01ja/s5BnltI1k2/rQ0N+R
        uXHF2YQE/f+bazGkB1bdyj3agOxvVu8=
X-Google-Smtp-Source: AMsMyM5aj3KbA9P+F+vDZb0gE8yXHOjGkXT975KGsrQLHOCJX6XY4MYbKVc0yWkMYeP/qP5o3AJ1XQ==
X-Received: by 2002:adf:d204:0:b0:22e:397:d489 with SMTP id j4-20020adfd204000000b0022e0397d489mr2310138wrh.639.1665734503601;
        Fri, 14 Oct 2022 01:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9-20020a056000054900b0022ac672654dsm1337148wrf.58.2022.10.14.01.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:01:43 -0700 (PDT)
Message-Id: <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
From:   "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:01:42 +0000
Subject: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
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
Signed-off-by: Nsengiyumva  Wilberforce <nsengiyumvawilberforce@gmail.com>
---
    [OUTREACHY]cleaning t1002-read-tree-m-u-2way.sh
    
    This is an update in t1002-read-tree-m-u-2way.sh. all the tests that use
    the unusual construct: if read_tree_u_must_succeed -m -u $treeH $treeM;
    then false; else :; fi have been updated to ! read_tree_u_must_succeed
    -m -u $treeH $treeM "I am an outreachy applicant" CC: Christian Couder
    christian.couder@gmail.com, Hariom verma hariom18599@gmail.com
    Signed-off-by: wilberforce nsengiyumvawilberforce@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1362%2Fnsengiyumva-wilberforce%2Ft1002_usual_construct_updated-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1362/nsengiyumva-wilberforce/t1002_usual_construct_updated-v3
Pull-Request: https://github.com/git/git/pull/1362

Range-diff vs v2:

 1:  8a9cd66d7d9 ! 1:  d019ce50dc9 [OUTREACHY] t1002: modernize outdated conditional
     @@ Commit message
      
          Cc: Christian Couder  <christian.couder@gmail.com>
          Cc: Hariom Verma <hariom18599@gmail.com>
     -    Signed-off-by: Nsengiyumva  Wilberfore <nsengiyumvawilberforce@gmail.com>
     +    Signed-off-by: Nsengiyumva  Wilberforce <nsengiyumvawilberforce@gmail.com>
      
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
