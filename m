Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB8165F08
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390142; cv=none; b=YMRtSy2U/xapCQ61Q5H0HWpU6G6ttpAHywECP/jPpXOueZZTCBSTdHFTG2EDXPoEQBawcSDu5IradSWErui4EToXRXlQO1uNGhzi5BC7+MQLL+CvuL2hHMr5PiHxQg5/StzRagvAio2E/sjqYxQJHxYr5bJkjo6FJP1d0uyTbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390142; c=relaxed/simple;
	bh=KpQJCAsshA5sNPQnqroUngWw6sYYoidnnDB4GVL5MnI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OPmvMOHwaRIrFhHLM8xcwy/KXtXjfeqgVk22t8L3sSMSOT8KpQotg8Nm4+22+0FveXqdlp+RBX3bpQjQ57CLNyBfiBKi9oItMny3sa+Vt3IQP2FZaVpcSNv7UhkKPBiEVsKeQwMSPYTxjRf3YPuS2EHxzupIoaUJpiNto65gduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqD+Kbuf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqD+Kbuf"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a997736106fso56535866b.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728390137; x=1728994937; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjpmhwGYjDOKnXya6d4hdOF3FZg1jcQDG5cYfLqNXiQ=;
        b=aqD+Kbuf2eQJ8sUHpGPNyqHzZNdIZ2/p2mBgrgary7OKDaXxXD3fHDHYBiQHkHD4Zc
         YexoM+YRlKatuMgtXF/S9WEoMP0LR1n2kuIrMZQB+LdfA0qTkBJTKKd0MlsI214gAsNi
         NRBvU/BZ5uKY6Iaw3m9xtzDAwPNU/e2l000zt597p671EV4lFrQIXwZ/RSqzRwGFVg7w
         Ms8+9GIgI7eduA2W9B6jpRcsmUrOT0Rnhup+cWJ7whkCJ7ncfJlLyhbm1E8kDTQm4Hbu
         0BWblPVx//G9wyt12VhyF1pai5Tef7IMXQ7jdokiGGNZvcxJ2SxVk15ZGe85OrYcr9JO
         10VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390137; x=1728994937;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjpmhwGYjDOKnXya6d4hdOF3FZg1jcQDG5cYfLqNXiQ=;
        b=c9Yp/1hluvCjMKRgCvndOLREYWy7RCVVwZp1AY4PdlCUq3S8nyt5tZZNx+GD8HiDXQ
         xWPUj3oYoou03N2gf2iaHGS9g9o2dLNBAl9Uwf0qd9tlcETk9UBmo8Z0qzcGhOCJ2v4H
         8okN3nXGrJUu+6miiBxOs1ZkKFROhx2ONFmGNI36HBeyC8RXfzlARreTHqfRIAqcXmCE
         szWMgrkOCn4P0bOBazRtrGv9zeE74XqNtobbYfvS/LoIg/21fXKyqsKsqO0pD627Zg2P
         19+W0VS8cyl2nKZ4Mxuj+lM6CCxlsJiv2a/In5pXYuVRiqLj/mCBx0w37mOraBLaPna1
         JPDQ==
X-Gm-Message-State: AOJu0YwyoYM7C6C6yMsMiGlAaKndB1ySCpG/nd/RBBjMsXUGpr86qHDp
	iYdZR5z9FmhSMr+pyeBrY04fY5Bdese4Qv1elnXXIJouksSYbt37Jqwbzg==
X-Google-Smtp-Source: AGHT+IHLvsqM8o93pG5NePDc0jhNqrFbO6z0VVHDPcnWi07c7OuR4+LDTwlah2kcQndhPmcwnFj8Nw==
X-Received: by 2002:a17:907:7fa6:b0:a99:61d1:34a2 with SMTP id a640c23a62f3a-a9961d14dbcmr419125566b.37.1728390137090;
        Tue, 08 Oct 2024 05:22:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f7bf7b8sm306014366b.66.2024.10.08.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:22:16 -0700 (PDT)
Message-Id: <pull.1811.v2.git.1728390135644.gitgitgadget@gmail.com>
In-Reply-To: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 12:22:15 +0000
Subject: [PATCH v2] t7300-clean.sh: use test_path_* helper functions for error
 logging
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>,
    Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

This test script uses "test - [def]", but when a test fails because
the file passed to it does not exist,
it fails silently without an error message.
Use test_path_* helper functions, which are designed to give better
error messages when their expectations are not met.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
    [Outreachy][PATCH] t7300-clean.sh: use test_path_* helper functions for
    error logging
    
    This test script uses "test - [def]", but when a test fails because the
    file passed to it does not exist, it fails silently without an error
    message.
    
    Use test_path_* helper functions, which are designed to give better
    error messages when their expectations are not met.
    
    I have added a mechanical validation that applies the same
    transformation done in this patch, when the script is passed to a sed
    script as shown below
    
    #!/bin/bash
    sed -e 's/^\(	*\)test -f /\1test_path_is_file /' \
        -e 's/^\(	*\)test -d /\1test_path_is_dir /' \
        -e 's/^\(	*\)test -e /\1test_path_exists /' \
        -e 's/^\(	*\)! test -[edf] /\1test_path_is_missing /' \
        -e 's/^\(	*\)test ! -[edf] /\1test_path_is_missing /' \
           "$1" >foo.sh
    
    
    Reviewers can use the sed script to transform the original test script
    and compare the results in foo.sh with the results of applying this
    patch You will see an instance of "! (test -e 3)" which was manually
    replaced with "test_path_is_missing", and everything else should match.
    I have carefully studied the instances where "test ! - [df] foo" were
    used in the script to make sure that the test instances were expecting a
    file or a directory to not exist as the case may be before replacing
    with "test_path_is_missing".
    
    Signed-off-by: Abraham Samuel Adekunle abrahamadekunle50@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1811%2Fdevdekunle%2Fupdate_tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1811/devdekunle/update_tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1811

Range-diff vs v1:

 1:  fef842b7013 ! 1:  62d57156dcf t7300-clean.sh: use test_path_* helper functions
     @@ Metadata
      Author: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
      
       ## Commit message ##
     -    t7300-clean.sh: use test_path_* helper functions
     +    t7300-clean.sh: use test_path_* helper functions for error logging
      
     -    The test_path_* helper functions provide error messages which show the cause
     -    of the test failures. Hence they are used to replace every instance of
     -    test - [def] uses in the script.
     +    This test script uses "test - [def]", but when a test fails because
     +    the file passed to it does not exist,
     +    it fails silently without an error message.
     +    Use test_path_* helper functions, which are designed to give better
     +    error messages when their expectations are not met.
      
          Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
      


 t/t7300-clean.sh | 370 +++++++++++++++++++++++------------------------
 1 file changed, 185 insertions(+), 185 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0aae0dee670..5c97eb0dfe9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -29,15 +29,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so &&
 	git update-index --no-skip-worktree .gitignore &&
 	git checkout .gitignore
 '
@@ -47,15 +47,15 @@ test_expect_success 'git clean' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -64,15 +64,15 @@ test_expect_success 'git clean src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -81,15 +81,15 @@ test_expect_success 'git clean src/ src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ src/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -98,16 +98,16 @@ test_expect_success 'git clean with prefix' '
 	mkdir -p build docs src/test &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
 	(cd src/ && git clean) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f src/test/1.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/test/1.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -163,16 +163,16 @@ test_expect_success 'git clean -d with prefix and path' '
 	mkdir -p build docs src/feature &&
 	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
 	(cd src/ && git clean -d feature/) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test ! -f src/feature/file.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/feature/file.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -182,16 +182,16 @@ test_expect_success SYMLINKS 'git clean symbolic link' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	ln -s docs/manual.txt src/part4.c &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f src/part4.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -199,13 +199,13 @@ test_expect_success 'git clean with wildcard' '
 
 	touch a.clean b.clean other.c &&
 	git clean "*.clean" &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.clean &&
-	test ! -f b.clean &&
-	test -f other.c
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.clean &&
+	test_path_is_missing b.clean &&
+	test_path_is_file other.c
 
 '
 
@@ -214,15 +214,15 @@ test_expect_success 'git clean -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -231,15 +231,15 @@ test_expect_success 'git clean -d' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -d docs &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing docs &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -248,16 +248,16 @@ test_expect_success 'git clean -d src/ examples/' '
 	mkdir -p build docs examples &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
 	git clean -d src/ examples/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f examples/1.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing examples/1.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -266,15 +266,15 @@ test_expect_success 'git clean -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -x &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -283,15 +283,15 @@ test_expect_success 'git clean -d -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -d docs &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing docs &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -300,15 +300,15 @@ test_expect_success 'git clean -d -x with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x -e src &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f src/part3.c &&
-	test ! -d docs &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing docs &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -317,15 +317,15 @@ test_expect_success 'git clean -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -X &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -334,15 +334,15 @@ test_expect_success 'git clean -d -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -351,15 +351,15 @@ test_expect_success 'git clean -d -X with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X -e src &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -382,29 +382,29 @@ test_expect_success 'clean.requireForce and -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
 test_expect_success 'clean.requireForce and -f' '
 
 	git clean -f &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -453,11 +453,11 @@ test_expect_success 'nested git work tree' '
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -d &&
-	test -f foo/.git/index &&
-	test -f foo/hello.world &&
-	test -f baz/boo/.git/index &&
-	test -f baz/boo/deeper.world &&
-	! test -d bar
+	test_path_is_file foo/.git/index &&
+	test_path_is_file foo/hello.world &&
+	test_path_is_file baz/boo/.git/index &&
+	test_path_is_file baz/boo/deeper.world &&
+	test_path_is_missing bar
 '
 
 test_expect_success 'should clean things that almost look like git but are not' '
@@ -624,9 +624,9 @@ test_expect_success 'force removal of nested git work tree' '
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -f -d &&
-	! test -d foo &&
-	! test -d bar &&
-	! test -d baz
+	test_path_is_missing foo &&
+	test_path_is_missing bar &&
+	test_path_is_missing baz
 '
 
 test_expect_success 'git clean -e' '
@@ -638,10 +638,10 @@ test_expect_success 'git clean -e' '
 		touch known 1 2 3 &&
 		git add known &&
 		git clean -f -e 1 -e 2 &&
-		test -e 1 &&
-		test -e 2 &&
-		! (test -e 3) &&
-		test -e known
+		test_path_exists 1 &&
+		test_path_exists 2 &&
+		test_path_is_missing 3 &&
+		test_path_exists known
 	)
 '
 
@@ -649,7 +649,7 @@ test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
 	mkdir foo &&
 	chmod a= foo &&
 	git clean -dfx foo &&
-	! test -d foo
+	test_path_is_missing foo
 '
 
 test_expect_success 'git clean -d respects pathspecs (dir is prefix of pathspec)' '

base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
-- 
gitgitgadget
