Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30B5C43219
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 06:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiBBGwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 01:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244727AbiBBGwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F30BC061774
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 22:43:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so3312638pjy.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 22:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/QpEBagOqUuEyK4GiwYp5g36E97M1oHePxNs4Fw8i4=;
        b=ASGzAMtg3ZoPbyx1Zn+xB+0BT1oYt2q4nQH48fQODlnakKZovsQWaDl5rK0My7kL3z
         ExBrhkpulWegaHDHNI2keW6FDTUV35dI0Mvh9BBzh4dyvHn//ySLecmFvKqeou4DM1jz
         Y3DczouvuLZfxvdlGSnXLUWEB/sqM73uu3S7ap26tdiuXm6ohGjKj7T4TnOzFknT4j6+
         ptr5yCUw1q2OclMYhSzTMOn/yeSa+CL4A02ioWiN5r2ZN+g7P2BVoB8th2WaE8KrGqyH
         IP/paDpiO1wmHTj5AJw5hXVpXkHBiyHOm1/bPzRNiQrLZg+G/nuswAgnjTA2xaIGhEfQ
         BjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/QpEBagOqUuEyK4GiwYp5g36E97M1oHePxNs4Fw8i4=;
        b=rM20i/31yK8lvN3RXVTvMK3qQM1JJWY0G+Ev0pobPGJeWE5Yvf/5elnXu5RXAN0AlT
         fe9WbpzgcCZGxw8gIolFwQz/jnlYUlUB7cX5OFPAwTbu0eYDVkvrmlCvNqF6CkbpAO8J
         hJodCh6WkZdeA4ZKXGJqYiCUzLdCesxDbs73Ar4+z8mUO5EhcFZG7I8hLVSo7ZlQt2g0
         rE93rgUJv+bu2Hwk7UPGocVHHp7DEmrMT3drZ+xvJVEcezqy6bTg91tpcLzHCMrKZU7b
         hKtjgXpBT1/n1s8stNzkoHLgpYYnvViQ0HvQ8uY+7rHIbAmZ2lbA89eQJodUS4Hy/KnS
         15Lw==
X-Gm-Message-State: AOAM531vkwfigNPvwS5I7O6fKohlPPPJROTzAlKwG1yAOulnpAD4TC8S
        7geBetCZEKAB6G4119ZegNIn+IRKoqgQcA==
X-Google-Smtp-Source: ABdhPJysVGaZe80FZAA77fqdTzvZiefAeZxqi46nMtnOKgHL5N8u5hBzcySjNK6HXlQ+mbDmKVbDeA==
X-Received: by 2002:a17:90a:eb10:: with SMTP id j16mr6516283pjz.27.1643784198437;
        Tue, 01 Feb 2022 22:43:18 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.106])
        by smtp.gmail.com with ESMTPSA id z1sm21255084pfh.137.2022.02.01.22.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 22:43:17 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: [PATCH v3 1/2] t/lib-read-tree-m-3way: modernize style
Date:   Wed,  2 Feb 2022 14:42:59 +0800
Message-Id: <20220202064300.3601-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many invocations of the test_expect_success command in this
file are written in old style where the command, an optional
prerequisite, and the test title are written on separate
lines, and the executable script string begins on its own
line, and these lines are pasted together with backslashes
as necessary.

An invocation of the test_expect_success command in modern
test scripts however writes the prerequisite and the title
on the same line as the test_expect_success command itself,
and ends the line with a single quote that begins the
executable script string.

Update the style for uniformity.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
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

