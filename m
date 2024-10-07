Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8813B797
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328761; cv=none; b=FGXR4gb5zD/z7B/7AnlI9ErcQYSQBJLkO4E+Q7LqM9KtuBhX1HJdOvqLGTQFRd8a9QECSKLetcxoG0DYQqVJyI9w6IFKDClUBTbEMedWZdzDvKKbm/7eJoyIVu7IQiDRP6AQLVogdZY3Fb4i10yUERKoWwXkFQMb1ny04SjH9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328761; c=relaxed/simple;
	bh=yUolhNecDO8uvNPhbmFIljUWeVWaZmMyoOjmDl9xqDY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=I0DNwHGNhOxCGPku9NL50GwuuiFe1w+9sx7/aCxoYX8v780R/2gruPVA1VtDn+kW8ssuswVZ9skul9ordjjRXpyurBEKNCpOrN/L2Z0UUH1hmC5eUITIswBQHZLt4XsDvbRJzicgFSzo2foIBpo/O9/oxf+z+0kmikEdYfkjEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYfPOXcL; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYfPOXcL"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso55039501fa.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728328757; x=1728933557; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lBUaqbQfp7ddRU6W4kFwSUVGXeLyA3j5i74r1igtMZo=;
        b=CYfPOXcLYX8SbJOd0kaGpuNqNUPmmPn54V52rvQFmim9/UkGq+xVelsLkJKq6NJ4gN
         xjwT7ekoLuobgkQdK8UUDtoJ69oBprSEDa5J9r47+HQOJxqPDfCTRc0tIA6VVc9Hw3g9
         zMhzim5XzkECda7WoJrWIDOjAE7H/EyjPu+zE5PWSCGkiNDO4X6XfnDzDeCtggvgjVZQ
         asqlphLGdsZ9VcyZIsmjyGW7zh90kw2/Fc8x00ieANBcnOG0zwXs9F55Fj3Y82Ak1Qku
         rBtnfEoWZwVr6nj3xuXkgMAcKIFdlQd6TJ9TCxagYKkNvQ/DbGNDq7bUXcYaxZpjt/Yf
         E5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728328757; x=1728933557;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBUaqbQfp7ddRU6W4kFwSUVGXeLyA3j5i74r1igtMZo=;
        b=hVofxCDsjUl9aFA1LENO+tJoTobOzrIIB5XE6LSosF0MO809bLLtImwzi7bz5yRr4S
         YZEG7hYPjjRvuAml5pqwFaP3HwWdv6P9bS+Qg/5uXrAkgLVIq8vutL565w5HPhY11xdf
         AnzBOJtVD8rw21x/AAXpyAAXCepsYIjnjnutsB4ep6szDSHrb/fcfJN/bJZ18FLBbCel
         wkqTSt6W8ET6xiCFhy4Qh7CxH6fjuKMDX/yDsVPlwXLxYgin8OCC6ONW1xbjRTMJg0sC
         4Tpfh7538fOIeWO7C9zy5e/74aDsUns25qITG0ReTgTizTkSeBUkI9aC5OFAJvbCrOIS
         /dvg==
X-Gm-Message-State: AOJu0YxeiPPMx0EGd8JUFBMkXiuyJHuS63urxxp9w2Gbe8R/N0T3J0d6
	gt3B4dwD2w3psHqjsTN2B8+jTLfVhcFwrduwV3JruCtTMMpUf4rtShM6/Q==
X-Google-Smtp-Source: AGHT+IGkKY6EXFEGbM9V1VAUF4HzuolUTmw3WMTLOzWhhivOzPZMim0DNA0l7KrN33AezqR2ABN3qQ==
X-Received: by 2002:a2e:a543:0:b0:2fa:d177:13e6 with SMTP id 38308e7fff4ca-2faf3c416f8mr60289051fa.21.1728328756788;
        Mon, 07 Oct 2024 12:19:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a7e87sm3492325a12.24.2024.10.07.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:19:16 -0700 (PDT)
Message-Id: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 19:19:15 +0000
Subject: [PATCH] t7300-clean.sh: use test_path_* helper functions
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
Cc: Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>,
    Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

The test_path_* helper functions provide error messages which show the cause
of the test failures. Hence they are used to replace every instance of
test - [def] uses in the script.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
    [Outreachy] [PATCH] t7300-clean.sh: replace instances of test - [def]
    with test_path_* helper functions.
    
    The test_path_* helper functions provide error messages which show the
    cause of the test failure should a failure occur. This is more useful
    and helpful when debugging errors.
    
    Signed-off-by: Abraham Samuel Adekunle abrahamadekunle50@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1811%2Fdevdekunle%2Fupdate_tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1811/devdekunle/update_tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1811

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
