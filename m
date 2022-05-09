Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D1C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiEIR7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiEIR7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC172D9ED9
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq17so28330588ejb.4
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5NuB9Cq8CdO6mnkkizzjF/Ypp3s2cgXldHw4jFLszmg=;
        b=WBAvq1hiOUB7xEqN1P6DTd9LrFiDi6WNO5zCNzB6JjZ0WkpKChmLHWnDJnBbgw9EI1
         uJTqEhUlQidtjFKE3pj8lD4SCcsodiI2dvZ+1Cw1Xb3zPU33569t8t8WLeacRW0R1GUe
         2L73p4RmkTGMv8IdWjF8GvUiko16Om2Dsl6SdE+FtjefqRAw6QPtrj8BK7UhIyeZm5d9
         PzMNpfhCs3NL67+et2Gi9+UN+mH0w4WdwUW7bq5nlY6RruUlHUjt3uQNDekxDe7IYAOf
         Mx4YFiv6sDlYu8Mh/ktqwAlv4+R0Ztgl/ItPTnQKE1a6UH+RBODfluvTmaSXxihkUfFa
         aZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NuB9Cq8CdO6mnkkizzjF/Ypp3s2cgXldHw4jFLszmg=;
        b=g+RDzbGrEHt4BtnRfVXu/k8MKW+NZFriGpLaHGt8GXBQu2vucpr2yiCU4vCP/b4TVr
         V5Djvd2rGUgu6iN4GcqmtlsanIIf3Kqp1FrWwT+TFkxEkMVtkVDsSqkpJ7qfH6AG8XSF
         hnrdXbFjqo7OyvzZVPn6z5whXGHdBYSqOyJZuF3qZ4lxj3gJ+uiJ7TPBnfEhsX1bAWES
         BQv9foj3A9AZVAuAKyAp+AQC8dJPCIUj6jA4VFXYW4L67AeqFvBn9r69djO3B0mwwNRG
         aR1MpmIuEy0slQWfbnbDGCL7UVp8DqrulKqjYlZ6rTiduH0dg5Lb7l9mMXw30E2EDB+p
         Zg1g==
X-Gm-Message-State: AOAM533El0PcIHMLFFpMIpB3LFcPo5mBOXBFtTWA8vyKw8h2wH6as8+/
        IDCNihxZx3mhSwjDmtkBmek+RLyOp3c=
X-Google-Smtp-Source: ABdhPJxvrpFdxgfpjPOnqlsGFWL4xwNgOAcFUvzjdutob1u5h8JeD0yJ91xKm9kcuA2MQ/GaeoJX7g==
X-Received: by 2002:a17:907:7e92:b0:6f4:c553:c734 with SMTP id qb18-20020a1709077e9200b006f4c553c734mr15833043ejc.286.1652118912475;
        Mon, 09 May 2022 10:55:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:12 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 12/15] t0066: rename subtest descriptions
Date:   Mon,  9 May 2022 20:51:56 +0300
Message-Id: <20220509175159.2948802-13-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the structure of dir-iterator tests by renaming subtest
descriptions. This makes the introduction of new tests for future
iteration schemes easier, as they will share similar naming, only
differentiating over the iteration scheme part of the description
that the subtest is testing for.

These structured subtest descriptions also help when running the tests.
It's easier to understand what's tested and in case a test fails find
out which iteration scheme failed.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 49 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 52b0217bde..8ab8811fb5 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -9,7 +9,7 @@ test_expect_success 'setup -- dir with a single file' '
 	mkdir dir1 &&
 	>dir1/a
 '
-test_expect_success 'iteration of dir with a file' '
+test_expect_success 'dirs-before of dir with a file' '
 	cat >expected-out <<-EOF &&
 	[f] (a) [a] ./dir1/a
 	EOF
@@ -21,7 +21,7 @@ test_expect_success 'iteration of dir with a file' '
 test_expect_success 'setup -- dir with a single dir' '
 	mkdir -p dir2/a
 '
-test_expect_success 'iteration of dir with a single dir' '
+test_expect_success 'dirs-before of dir with a single dir' '
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir2/a
 	EOF
@@ -33,7 +33,7 @@ test_expect_success 'iteration of dir with a single dir' '
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
 	mkdir -p dir3/a
 '
-test_expect_success POSIXPERM,SANITY 'iteration of dir w/ dir w/o perms' '
+test_expect_success POSIXPERM,SANITY 'dirs-before of dir w/ dir w/o perms' '
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir3/a
 	EOF
@@ -45,7 +45,7 @@ test_expect_success POSIXPERM,SANITY 'iteration of dir w/ dir w/o perms' '
 
 	chmod 755 dir3/a
 '
-test_expect_success POSIXPERM,SANITY 'pedantic iteration of dir w/ dir w/o perms' '
+test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of dir w/ dir w/o perms' '
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir3/a
 	dir_iterator_advance failure: EACCES
@@ -67,7 +67,7 @@ test_expect_success 'setup -- dir w/ five files' '
 	>dir4/d &&
 	>dir4/e
 '
-test_expect_success 'iteration of dir w/ five files' '
+test_expect_success 'dirs-before of dir w/ five files' '
 	cat >expected-sorted-out <<-EOF &&
 	[f] (a) [a] ./dir4/a
 	[f] (b) [b] ./dir4/b
@@ -86,7 +86,7 @@ test_expect_success 'setup -- dir w/ dir w/ a file' '
 	mkdir -p dir5/a &&
 	>dir5/a/b
 '
-test_expect_success 'iteration of dir w/ dir w/ a file' '
+test_expect_success 'dirs-before of dir w/ dir w/ a file' '
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir5/a
 	[f] (a/b) [b] ./dir5/a/b
@@ -100,7 +100,7 @@ test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
 	mkdir -p dir6/a/b/c &&
 	>dir6/a/b/c/d
 '
-test_expect_success 'dir-iterator should list files in the correct order' '
+test_expect_success 'dirs-before of dir w/ three nested dirs w/ file' '
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir6/a
 	[d] (a/b) [b] ./dir6/a/b
@@ -119,7 +119,7 @@ test_expect_success POSIXPERM,SANITY \
 	>dir7/a/b/c/d
 '
 test_expect_success POSIXPERM,SANITY \
-'iteration of dir w/ three nested dirs w/ file, second w/o perms' '
+'dirs-before of dir w/ three nested dirs w/ file, second w/o perms' '
 
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir7/a
@@ -134,7 +134,7 @@ test_expect_success POSIXPERM,SANITY \
 	chmod 755 dir7/a/b
 '
 test_expect_success POSIXPERM,SANITY \
-'pedantic iteration of dir w/ three nested dirs w/ file, second w/o perms' '
+'pedantic dirs-before of dir w/ three nested dirs w/ file, second w/o perms' '
 
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir7/a
@@ -156,7 +156,7 @@ test_expect_success 'setup -- dir w/ two dirs each w/ file' '
 	mkdir dir8/c &&
 	>dir8/c/d
 '
-test_expect_success 'iteration of dir w/ two dirs each w/ file' '
+test_expect_success 'dirs-before of dir w/ two dirs each w/ file' '
 	cat >expected-out1 <<-EOF &&
 	[d] (a) [a] ./dir8/a
 	[f] (a/b) [b] ./dir8/a/b
@@ -185,7 +185,7 @@ test_expect_success 'setup -- dir w/ two dirs, one w/ two and one w/ one files'
 	>dir9/d/e
 '
 test_expect_success \
-'iteration of dir w/ two dirs, one w/ two and one w/ one files' '
+'dirs-before of dir w/ two dirs, one w/ two and one w/ one files' '
 
 	cat >expected-out1 <<-EOF &&
 	[d] (a) [a] ./dir9/a
@@ -231,7 +231,7 @@ test_expect_success 'setup -- dir w/ two nested dirs, each w/ file' '
 	mkdir dir10/a/c &&
 	>dir10/a/c/d
 '
-test_expect_success 'iteration of dir w/ two nested dirs, each w/ file' '
+test_expect_success 'dirs-before of dir w/ two nested dirs, each w/ file' '
 	cat >expected-out1 <<-EOF &&
 	[d] (a) [a] ./dir10/a
 	[f] (a/b) [b] ./dir10/a/b
@@ -262,7 +262,7 @@ test_expect_success 'setup -- dir w/ complex structure' '
 	>dir11/a/e &&
 	>dir11/d/e/d/a
 '
-test_expect_success 'dir-iterator should iterate through all files' '
+test_expect_success 'dirs-before of dir w/ complex structure' '
 	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir11/a
 	[d] (a/b) [b] ./dir11/a/b
@@ -287,7 +287,7 @@ test_expect_success POSIXPERM,SANITY 'setup -- dir w/o perms' '
 	mkdir -p dir12/a &&
 	>dir12/a/b
 '
-test_expect_success POSIXPERM,SANITY 'iteration of root dir w/o perms' '
+test_expect_success POSIXPERM,SANITY 'dirs-before of root dir w/o perms' '
 	cat >expected-out <<-EOF &&
 	dir_iterator_begin failure: EACCES
 	EOF
@@ -299,7 +299,7 @@ test_expect_success POSIXPERM,SANITY 'iteration of root dir w/o perms' '
 
 	chmod 755 dir12
 '
-test_expect_success POSIXPERM,SANITY 'pedantic iteration of root dir w/o perms' '
+test_expect_success POSIXPERM,SANITY 'pedantic dirs-before of root dir w/o perms' '
 	cat >expected-out <<-EOF &&
 	dir_iterator_begin failure: EACCES
 	EOF
@@ -334,7 +334,9 @@ test_expect_success POSIXPERM,SANITY 'setup -- dir w/ dir w/o perms w/ file' '
 	mkdir -p dir13/a &&
 	>dir13/a/b
 '
-test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
+test_expect_success POSIXPERM,SANITY \
+'dirs-before of dir w/ dir w/o perms w/ file' '
+
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir13/a
 	EOF
@@ -346,7 +348,9 @@ test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by defau
 
 	chmod 755 dir13/a
 '
-test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
+test_expect_success POSIXPERM,SANITY \
+'pedantic dirs-before of dir w/ dir w/o perms w/ file' '
+
 	cat >expected-out <<-EOF &&
 	[d] (a) [a] ./dir13/a
 	dir_iterator_advance failure: EACCES
@@ -367,7 +371,7 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
 	ln -s d dir14/a/e &&
 	ln -s ../b dir14/a/f
 '
-test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
+test_expect_success SYMLINKS 'dirs-before of dir w/ symlinks w/o cycle' '
 	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir14/a
 	[d] (b) [b] ./dir14/b
@@ -382,7 +386,9 @@ test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default
 
 	test_cmp expected-sorted-out actual-sorted-out
 '
-test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
+test_expect_success SYMLINKS \
+'follow-symlinks dirs-before of dir w/ symlinks w/o cycle' '
+
 	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir14/a
 	[d] (a/f) [f] ./dir14/a/f
@@ -406,8 +412,7 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
 	ln -s ../ dir15/a/b/e &&
 	ln -s ../../ dir15/a/b/f
 '
-test_expect_success SYMLINKS 'iteration of dir w/ symlinks w/ cycle' '
-
+test_expect_success SYMLINKS 'dirs-before of dir w/ symlinks w/ cycle' '
 	cat >expected-sorted-out <<-EOF &&
 	[d] (a) [a] ./dir15/a
 	[d] (a/b) [b] ./dir15/a/b
@@ -423,7 +428,7 @@ test_expect_success SYMLINKS 'iteration of dir w/ symlinks w/ cycle' '
 	test_cmp expected-sorted-out actual-sorted-out
 '
 test_expect_success SYMLINKS \
-'pedantic follow-symlinks iteration of dir w/ symlinks w/ cycle' '
+'pedantic follow-symlinks dirs-before of dir w/ symlinks w/ cycle' '
 
 	cat >expected-tailed-out <<-EOF &&
 	dir_iterator_advance failure: ELOOP
-- 
2.36.1

