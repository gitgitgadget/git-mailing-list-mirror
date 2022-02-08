Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8840AC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 03:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346423AbiBHDZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 22:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbiBHDZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 22:25:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32FC043188
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 19:25:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4so9021298pjh.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 19:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+euvjeixzwrepvLrmccjvtf8zX8Ng93DdyGAs9Ih98=;
        b=LVpQPK9mZrEdqAtCP/MGRzRnCJTfy2kD8/thpSqjcB1QqsM8C4SY9P3NKAAarz6tSk
         a76s5jwXIGhGh+dpaLINTlkmPu+e1pLzcfyewvYSKkShOk1QlhiJeD7tTCVmuaI7etQw
         /+O5sg0fU8guegNs9UoHRPGJ6g6X1fzadtXbdSDQdeFtjIHoO6+LcccuZ+FqmiJb3kqt
         qZu9DkAibIfATt8AzhXUpTjyc0LrSURpndJ6JiXk79eoelCbBI+jhGLyCLY7i/mIwpfQ
         5DWGcWlKtzmm2ywAn/RFgyLKIUOJbyp/hbmkr4Cdcg3D+gB8HLj/aICtIDHo1l3F1PNp
         8MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+euvjeixzwrepvLrmccjvtf8zX8Ng93DdyGAs9Ih98=;
        b=o83DglZ8DMC0nMcJW+ReGS82y5BjQP9UkEpkyYqp5YSEehf+23Rum58WXaDGU/+nYa
         uK5LfUE54vNDMbBt5cP6lun3hh//LuZdudpIDBSWBQHENi4oME4AKK5CCPD0Afpua7vy
         KOUGLq8oxoDoE5eZDyD5rG0hkeCHCehSWHSHZ1Bymd9B/PJcKmTs1Bg3kqXZTznC8eo1
         7v71Wj5e9Q85v02BkltC/nz+pjzEz5pzUuEQwWEFTdAS2bigbCtifTwnkAJMDn1/UPpb
         xWaMO92STT+orI/e8bNFgq2wEwtyrEM2TifWSRGVjAqmtmhtsNc8MCVzK9gSVNDvmeMw
         wjEg==
X-Gm-Message-State: AOAM532UPQc18Nlf/K4L8VisURO7rAD7PnkZjOdSw2kqc+aw3BGrtmYO
        kFe3ze2IhVS4WSFf8AP8ZsI=
X-Google-Smtp-Source: ABdhPJwac9hkz1kudX5LGlEqclGuJCDOgCHrlHYN19v9A6AO3sN2nOLrZPCVhOtVa5pwmELFLvCaFw==
X-Received: by 2002:a17:90b:255:: with SMTP id fz21mr2224460pjb.226.1644290717509;
        Mon, 07 Feb 2022 19:25:17 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.108])
        by smtp.gmail.com with ESMTPSA id o21sm9571707pgl.19.2022.02.07.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:25:17 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 1/2] t/lib-read-tree-m-3way: modernize style
Date:   Tue,  8 Feb 2022 11:24:49 +0800
Message-Id: <20220208032450.46604-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208032450.46604-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220208032450.46604-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many invocations of the test commands (e.g. test_expect_success
or test_expect_failure) in this
file are written in old style where the command, an optional
prerequisite, the test title, and the executable script string
are written on separate lines, with the executable script string
begins on its own line, and these lines are pasted together
with backslashes as necessary.

An invocation of the test command in modern
test scripts however writes the prerequisite and the title
on the same line as the test command itself,
and ends the line with a single quote that begins the
executable script string.

It is worth notice that albeit all executable script strings
are changed to use single quotes (for modern style uniformity),
some of the test titles are kept untouched, e.g.

-	test_expect_success \
-	    "adding test file $p and Z/$p" \
-	    'git update-index --add $p &&
-	    git update-index --add Z/$p'
+	test_expect_success "adding test file $p and Z/$p" '
+	    git update-index --add $p &&
+	    git update-index --add Z/$p
+    '

see the "adding test file $p and Z/$p" part.

This is because the test title is simply echo'd/print'd, and
double quotes are necessary for "$p" interpolation; however,
the test body (executable script string) gets eval'd, and
single quotes are acceptable in this case.

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
2.35.1

