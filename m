Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57BC433F5
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354488AbiA3JoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 04:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354446AbiA3JoF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 04:44:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C5C061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:44:04 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p125so9414757pga.2
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zbklSFa7P+ux+f2E1wmq4WKW5FASwbp9EgzH+AkrbjY=;
        b=hjHbNMuFhFeJ/MkxWneh3V/9BVXpSI+0z10CclLrEQf+Qw6YBoogf7mc7XnIM++MEG
         AuBAfiqMnEgX5W+hzqNih5t5d3OwxdnN1RAWOVEvdjsOSTw6B0RXsq7cVz5fIB9zAXT/
         QZWDcwkBNC3WENEDgklj/mUkkw+/Ib6UcIj8c56X/lp3LG+DW4bjg7sV1L5yN/aFXdgg
         1LiFd8n68MRXt8QJ7tjv4gHjQVvJwiWTL+RF7aDqi6QmDvx1I9d1d3CUaJKeRYFvaZ4I
         m1QGUqiyHxPA3wCqOfkcY0Df+cuj1SEYlSGdjlw6JBX5VRCz4kBdaC3XGtPQZ5HVfFRb
         7IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zbklSFa7P+ux+f2E1wmq4WKW5FASwbp9EgzH+AkrbjY=;
        b=SZ+xxqoPrvyLnQ1S7SiLFc+Hg1RdFHeg9W1AJGaYPqzHUeTjR3CrpmCcz+Mz19ulNn
         cF7rfrpoWO8yMJJOlw4k1DWHVLbVGO4E8ERbxBfyNTEN9pI2a32E4CPfSZImYNSm6Fh1
         Jhr/LY9HryBgAyYH+4DMrcThSRb4/0aQkZgs9AG5sxa8rgveF/YUn8vaEihVflEfByqc
         vodWV8ztxpSy9KVkJvzAkF7ftyS62iH8RXrjqS51k5Gbfsg0HTUqMx8av9G86eDryy1a
         va8TPuQZozFpUbeo8XTYe3jqI6CE0jONimQu+nB5NWN7/yLYcLm8jpG+YO5zeL+a2dBT
         3R+A==
X-Gm-Message-State: AOAM531i68oi1q5qSFV32iGxL6YixqDoE9vGg4vhn8LaAD3e0VLJUhyP
        5vS7vVs3sWHdYCr+LSdTehe74K3GXmQ=
X-Google-Smtp-Source: ABdhPJzeGQKvTu/AIpQeb0MZHolyHkmYJ3nIYmSA3Oo+RgWVvIRtktAyuyswTaP2qTu/Hqtbh8rf9Q==
X-Received: by 2002:a05:6a00:2408:: with SMTP id z8mr14606420pfh.68.1643535844093;
        Sun, 30 Jan 2022 01:44:04 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.106])
        by smtp.gmail.com with ESMTPSA id il4sm8067888pjb.25.2022.01.30.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 01:44:03 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: [PATCH v2 1/2] t/lib-read-tree-m-3way: replace double quotes with single quotes
Date:   Sun, 30 Jan 2022 17:43:56 +0800
Message-Id: <20220130094357.515335-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---

This commit simply converts the old style (double quotes) to
a modern style (single quotes), e.g.

-test_expect_success \
-    'adding test file SS' \
-    'git update-index --add SS'
+test_expect_success 'adding test file SS' '
+    git update-index --add SS
+'

 t/lib-read-tree-m-3way.sh | 154 +++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
index 168329adbc..3c17cb7f80 100644
--- a/t/lib-read-tree-m-3way.sh
+++ b/t/lib-read-tree-m-3way.sh
@@ -8,16 +8,16 @@ do
         p=$a$b
 	echo This is $p from the original tree. >$p
 	echo This is Z/$p from the original tree. >Z/$p
-	test_expect_success \
-	    "adding test file $p and Z/$p" \
-	    'git update-index --add $p &&
-	    git update-index --add Z/$p'
+	test_expect_success "adding test file $p and Z/$p" '
+	    git update-index --add $p &&
+	    git update-index --add Z/$p
+    '
     done
 done
 echo This is SS from the original tree. >SS
-test_expect_success \
-    'adding test file SS' \
-    'git update-index --add SS'
+test_expect_success 'adding test file SS' '
+    git update-index --add SS
+'
 cat >TT <<\EOF
 This is a trivial merge sample text.
 Branch A is expected to upcase this word, here.
@@ -30,12 +30,12 @@ At the very end, here comes another line, that is
 the word, expected to be upcased by Branch B.
 This concludes the trivial merge sample file.
 EOF
-test_expect_success \
-    'adding test file TT' \
-    'git update-index --add TT'
-test_expect_success \
-    'prepare initial tree' \
-    'tree_O=$(git write-tree)'
+test_expect_success 'adding test file TT' '
+    git update-index --add TT
+'
+test_expect_success 'prepare initial tree' '
+    tree_O=$(git write-tree)
+'
 
 ################################################################
 # Branch A and B makes the changes according to the above matrix.
@@ -45,48 +45,48 @@ test_expect_success \
 
 to_remove=$(echo D? Z/D?)
 rm -f $to_remove
-test_expect_success \
-    'change in branch A (removal)' \
-    'git update-index --remove $to_remove'
+test_expect_success 'change in branch A (removal)' '
+    git update-index --remove $to_remove
+'
 
 for p in M? Z/M?
 do
     echo This is modified $p in the branch A. >$p
-    test_expect_success \
-	'change in branch A (modification)' \
-        "git update-index $p"
+    test_expect_success 'change in branch A (modification)' '
+        git update-index $p
+    '
 done
 
 for p in AN AA Z/AN Z/AA
 do
     echo This is added $p in the branch A. >$p
-    test_expect_success \
-	'change in branch A (addition)' \
-	"git update-index --add $p"
+    test_expect_success 'change in branch A (addition)' '
+	    git update-index --add $p
+    '
 done
 
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
-test_expect_success \
-    'change in branch A (addition)' \
-    'git update-index --add LL &&
-     git update-index SS'
+test_expect_success 'change in branch A (addition)' '
+    git update-index --add LL &&
+    git update-index SS
+'
 mv TT TT-
 sed -e '/Branch A/s/word/WORD/g' <TT- >TT
 rm -f TT-
-test_expect_success \
-    'change in branch A (edit)' \
-    'git update-index TT'
+test_expect_success 'change in branch A (edit)' '
+    git update-index TT
+'
 
 mkdir DF
 echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
-test_expect_success \
-    'change in branch A (change file to directory)' \
-    'git update-index --add DF/DF'
+test_expect_success 'change in branch A (change file to directory)' '
+    git update-index --add DF/DF
+'
 
-test_expect_success \
-    'recording branch A tree' \
-    'tree_A=$(git write-tree)'
+test_expect_success 'recording branch A tree' '
+    tree_A=$(git write-tree)
+'
 
 ################################################################
 # Branch B
@@ -94,65 +94,65 @@ test_expect_success \
 
 rm -rf [NDMASLT][NDMASLT] Z DF
 mkdir Z
-test_expect_success \
-    'reading original tree and checking out' \
-    'git read-tree $tree_O &&
-     git checkout-index -a'
+test_expect_success 'reading original tree and checking out' '
+    git read-tree $tree_O &&
+    git checkout-index -a
+'
 
 to_remove=$(echo ?D Z/?D)
 rm -f $to_remove
-test_expect_success \
-    'change in branch B (removal)' \
-    "git update-index --remove $to_remove"
+test_expect_success 'change in branch B (removal)' '
+    git update-index --remove $to_remove
+'
 
 for p in ?M Z/?M
 do
     echo This is modified $p in the branch B. >$p
-    test_expect_success \
-	'change in branch B (modification)' \
-	"git update-index $p"
+    test_expect_success 'change in branch B (modification)' '
+	    git update-index $p
+    '
 done
 
 for p in NA AA Z/NA Z/AA
 do
     echo This is added $p in the branch B. >$p
-    test_expect_success \
-	'change in branch B (addition)' \
-	"git update-index --add $p"
+    test_expect_success 'change in branch B (addition)' '
+	    git update-index --add $p
+    '
 done
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
-test_expect_success \
-    'change in branch B (addition and modification)' \
-    'git update-index --add LL &&
-     git update-index SS'
+test_expect_success 'change in branch B (addition and modification)' '
+    git update-index --add LL &&
+    git update-index SS
+'
 mv TT TT-
 sed -e '/Branch B/s/word/WORD/g' <TT- >TT
 rm -f TT-
-test_expect_success \
-    'change in branch B (modification)' \
-    'git update-index TT'
+test_expect_success 'change in branch B (modification)' '
+    git update-index TT
+'
 
 echo Branch B makes a file at DF. >DF
-test_expect_success \
-    'change in branch B (addition of a file to conflict with directory)' \
-    'git update-index --add DF'
-
-test_expect_success \
-    'recording branch B tree' \
-    'tree_B=$(git write-tree)'
-
-test_expect_success \
-    'keep contents of 3 trees for easy access' \
-    'rm -f .git/index &&
-     git read-tree $tree_O &&
-     mkdir .orig-O &&
-     git checkout-index --prefix=.orig-O/ -f -q -a &&
-     rm -f .git/index &&
-     git read-tree $tree_A &&
-     mkdir .orig-A &&
-     git checkout-index --prefix=.orig-A/ -f -q -a &&
-     rm -f .git/index &&
-     git read-tree $tree_B &&
-     mkdir .orig-B &&
-     git checkout-index --prefix=.orig-B/ -f -q -a'
+test_expect_success 'change in branch B (addition of a file to conflict with directory)' '
+    git update-index --add DF
+'
+
+test_expect_success 'recording branch B tree' '
+    tree_B=$(git write-tree)
+'
+
+test_expect_success 'keep contents of 3 trees for easy access' '
+    rm -f .git/index &&
+    git read-tree $tree_O &&
+    mkdir .orig-O &&
+    git checkout-index --prefix=.orig-O/ -f -q -a &&
+    rm -f .git/index &&
+    git read-tree $tree_A &&
+    mkdir .orig-A &&
+    git checkout-index --prefix=.orig-A/ -f -q -a &&
+    rm -f .git/index &&
+    git read-tree $tree_B &&
+    mkdir .orig-B &&
+    git checkout-index --prefix=.orig-B/ -f -q -a
+'
-- 
2.35.0

