Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C6EC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 03:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbiBHDZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 22:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbiBHDZV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 22:25:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC39C043188
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 19:25:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso1303903pjm.4
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 19:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfjEKO75d3BGuaYHCigCpbo6VY7kWSXcDoS3Xsfy0qc=;
        b=JwW4f8nH0tMt4L2j6H1dI4bvUMNe/FhIZfDO7dsDFKhU47+DYiR3SN4kA0CaSuO3SZ
         bdm5jui0K4ocEbob+Jcc+pdnmLkHW3DmbYIVGwb9qxgyuHQiq8IXV79iiTcexUCNn5Gc
         um0Z6CUimbBLPxUr24ksbPlx/E3/c6vU/KeUQCRu9jqlFZC1Y/l8H5yF0t250I3lGnx8
         NI2yIxiwRux6V5WmtY8g4WkTnntuKY3wG/wz+how7F7A4YvrxmPqO1y9AX271unbKxo3
         YWCNcN3AgP3Zx8w5mUvYOba5L5CoiJpK2mtfE3+SXBC4f3oeSf8ce9DeVlItYFoZ0hUy
         oTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfjEKO75d3BGuaYHCigCpbo6VY7kWSXcDoS3Xsfy0qc=;
        b=kzFAeVMxucvylfoOT6vi/C6hSMVY+eQzAAU71AAW00P50jdtndqWr0NNefPd3MsZE7
         wIc5137N1gDSD5UokVUJF1yBr48K66xRoGVQaf4YlUST63989ul1uz1qhFqN0JlP6ldQ
         OFyPcAVrPL4AyeXFfIZArt7CGWq2JEX36kPEIALq/yc9IBOBT55LFggcUS7YQpcWV/oL
         t7UpNLf0GXz2OxJFXEJaecdh+98+kp4UQHo8GNwj2JPn+H3dnijvivnTRDBL0QBXo609
         PJzcHvPV+6E/ny7RiV4GMfBCga6bmn9jGF9iZkdTsZ3VqTMALn5MfyK82frsl48LcdbX
         1DOw==
X-Gm-Message-State: AOAM530D1q5IDCyXeetNONZ7j8osLc3EEHK23PuqD9NaTlsRJlFEdVgW
        FQTtjGQ8pzG2Ft0m4+O8sdRIdKGJMxiu7g==
X-Google-Smtp-Source: ABdhPJw9mMlf25Wk6Z14cjdG42I3JSE/TnYt0JrA15wyv9hdpcM3OkwOSzMk6WlmcX75+64Fk+GoDA==
X-Received: by 2002:a17:90b:2404:: with SMTP id nr4mr2160553pjb.223.1644290720600;
        Mon, 07 Feb 2022 19:25:20 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.108])
        by smtp.gmail.com with ESMTPSA id o21sm9571707pgl.19.2022.02.07.19.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:25:20 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 2/2] t/lib-read-tree-m-3way: indent with tabs
Date:   Tue,  8 Feb 2022 11:24:50 +0800
Message-Id: <20220208032450.46604-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208032450.46604-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220208032450.46604-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, our shell scripts
(including tests) are to use tabs for indentation, but this script
uses 4-column indent with space. Fix this.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/lib-read-tree-m-3way.sh | 96 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
index 3c17cb7f80..2da25b3144 100644
--- a/t/lib-read-tree-m-3way.sh
+++ b/t/lib-read-tree-m-3way.sh
@@ -3,9 +3,9 @@
 mkdir Z
 for a in N D M
 do
-    for b in N D M
-    do
-        p=$a$b
+	for b in N D M
+	do
+		p=$a$b
 	echo This is $p from the original tree. >$p
 	echo This is Z/$p from the original tree. >Z/$p
 	test_expect_success "adding test file $p and Z/$p" '
@@ -16,7 +16,7 @@ do
 done
 echo This is SS from the original tree. >SS
 test_expect_success 'adding test file SS' '
-    git update-index --add SS
+	git update-index --add SS
 '
 cat >TT <<\EOF
 This is a trivial merge sample text.
@@ -31,10 +31,10 @@ the word, expected to be upcased by Branch B.
 This concludes the trivial merge sample file.
 EOF
 test_expect_success 'adding test file TT' '
-    git update-index --add TT
+	git update-index --add TT
 '
 test_expect_success 'prepare initial tree' '
-    tree_O=$(git write-tree)
+	tree_O=$(git write-tree)
 '
 
 ################################################################
@@ -46,46 +46,46 @@ test_expect_success 'prepare initial tree' '
 to_remove=$(echo D? Z/D?)
 rm -f $to_remove
 test_expect_success 'change in branch A (removal)' '
-    git update-index --remove $to_remove
+	git update-index --remove $to_remove
 '
 
 for p in M? Z/M?
 do
-    echo This is modified $p in the branch A. >$p
-    test_expect_success 'change in branch A (modification)' '
-        git update-index $p
-    '
+	echo This is modified $p in the branch A. >$p
+	test_expect_success 'change in branch A (modification)' '
+		git update-index $p
+	'
 done
 
 for p in AN AA Z/AN Z/AA
 do
-    echo This is added $p in the branch A. >$p
-    test_expect_success 'change in branch A (addition)' '
-	    git update-index --add $p
-    '
+	echo This is added $p in the branch A. >$p
+	test_expect_success 'change in branch A (addition)' '
+		git update-index --add $p
+	'
 done
 
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
 test_expect_success 'change in branch A (addition)' '
-    git update-index --add LL &&
-    git update-index SS
+	git update-index --add LL &&
+	git update-index SS
 '
 mv TT TT-
 sed -e '/Branch A/s/word/WORD/g' <TT- >TT
 rm -f TT-
 test_expect_success 'change in branch A (edit)' '
-    git update-index TT
+	git update-index TT
 '
 
 mkdir DF
 echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
 test_expect_success 'change in branch A (change file to directory)' '
-    git update-index --add DF/DF
+	git update-index --add DF/DF
 '
 
 test_expect_success 'recording branch A tree' '
-    tree_A=$(git write-tree)
+	tree_A=$(git write-tree)
 '
 
 ################################################################
@@ -95,64 +95,64 @@ test_expect_success 'recording branch A tree' '
 rm -rf [NDMASLT][NDMASLT] Z DF
 mkdir Z
 test_expect_success 'reading original tree and checking out' '
-    git read-tree $tree_O &&
-    git checkout-index -a
+	git read-tree $tree_O &&
+	git checkout-index -a
 '
 
 to_remove=$(echo ?D Z/?D)
 rm -f $to_remove
 test_expect_success 'change in branch B (removal)' '
-    git update-index --remove $to_remove
+	git update-index --remove $to_remove
 '
 
 for p in ?M Z/?M
 do
-    echo This is modified $p in the branch B. >$p
-    test_expect_success 'change in branch B (modification)' '
-	    git update-index $p
-    '
+	echo This is modified $p in the branch B. >$p
+	test_expect_success 'change in branch B (modification)' '
+		git update-index $p
+	'
 done
 
 for p in NA AA Z/NA Z/AA
 do
-    echo This is added $p in the branch B. >$p
-    test_expect_success 'change in branch B (addition)' '
-	    git update-index --add $p
-    '
+	echo This is added $p in the branch B. >$p
+	test_expect_success 'change in branch B (addition)' '
+		git update-index --add $p
+	'
 done
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
 test_expect_success 'change in branch B (addition and modification)' '
-    git update-index --add LL &&
-    git update-index SS
+	git update-index --add LL &&
+	git update-index SS
 '
 mv TT TT-
 sed -e '/Branch B/s/word/WORD/g' <TT- >TT
 rm -f TT-
 test_expect_success 'change in branch B (modification)' '
-    git update-index TT
+	git update-index TT
 '
 
 echo Branch B makes a file at DF. >DF
 test_expect_success 'change in branch B (addition of a file to conflict with directory)' '
-    git update-index --add DF
+	git update-index --add DF
 '
 
 test_expect_success 'recording branch B tree' '
-    tree_B=$(git write-tree)
+	tree_B=$(git write-tree)
 '
 
 test_expect_success 'keep contents of 3 trees for easy access' '
-    rm -f .git/index &&
-    git read-tree $tree_O &&
-    mkdir .orig-O &&
-    git checkout-index --prefix=.orig-O/ -f -q -a &&
-    rm -f .git/index &&
-    git read-tree $tree_A &&
-    mkdir .orig-A &&
-    git checkout-index --prefix=.orig-A/ -f -q -a &&
-    rm -f .git/index &&
-    git read-tree $tree_B &&
-    mkdir .orig-B &&
-    git checkout-index --prefix=.orig-B/ -f -q -a
+	rm -f .git/index &&
+	git read-tree $tree_O &&
+	mkdir .orig-O &&
+	git checkout-index --prefix=.orig-O/ -f -q -a &&
+	rm -f .git/index &&
+	git read-tree $tree_A &&
+	mkdir .orig-A &&
+	git checkout-index --prefix=.orig-A/ -f -q -a &&
+	rm -f .git/index &&
+	git read-tree $tree_B &&
+	mkdir .orig-B &&
+	git checkout-index --prefix=.orig-B/ -f -q -a
 '
-- 
2.35.1

