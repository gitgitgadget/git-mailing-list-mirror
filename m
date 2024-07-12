Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E82D627
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720816455; cv=none; b=okJiC34Lfr8i+M2nSll0gNVM6inuOwZsLV0yqJbmCD9SdDl2i357Ox2gsCAzdZONQr0oq99Dzy7TM8p3XwUzsKFBPGHqtj1XnRoEppGYOVZ9nVWdvFR4DYn7hXI9mQy1eStHc6a9Z7UhzWGpD34Gw7HzyY0bUUv5HhaoIq743V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720816455; c=relaxed/simple;
	bh=81GfMqiX442cJhhBN9tKk9bqmwvSXjbZeXjEkM4Dyrc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pHw4D+MiBzkqV5Cjuahrduq9NsrkEsGmLBJU3XMmj2+ngHCYDXpkVA1ruw4jL3u/NWy6kKTWvga5zVhYT+kJ/Isz1XbOK8Go9bnE/2aIGSNHX1AFBha52M8KDFxZWo0eGt1KxOFrLbbIZXye7R8cv+pBeiWxyCV8MaB6CMGxFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJemYW4L; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJemYW4L"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36785e72a48so1303491f8f.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 13:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720816452; x=1721421252; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2WlUcyRhwplk7TLU8TMfq9cws7IeNP+Z3NDPa85+0VE=;
        b=XJemYW4Lqwdp+4YnEtwwtZmg9vI+0a8dV11VqfO8T+ofDdsrUNCVXq8X0dcqPHxJ3Q
         ViPCWGDFo/xi7sVWqby5C3COMYEdprTHYRI+O3Nj6iayj1c4cc3uAGaiUwvu6tjrgOU9
         ndjaFeoxv2v7GWYsNioen7KtZ+Pd+Unm1c21Av4sz1GYuKLQPMRUPgAnpnqZPgFoB4fC
         NiWiaDvYy9UBxD9j0ToucRgREWocUpBC9yi6xCf7BBnGS89sI0OlrprvvHFSQfpQz4fG
         WzauGdQg2KdEFDQP7NsaftqUXGowD3dDnewWSPebbZTvAaoILm6SSeHCVJ3rxPzqbu1f
         oshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720816452; x=1721421252;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WlUcyRhwplk7TLU8TMfq9cws7IeNP+Z3NDPa85+0VE=;
        b=vUP7B3DJ6QJhU+wbAekhLW7Oi3UlE6PsUT7mFNjD7zB4ALf8tvUsfz7Tm6CZ4FAb0Y
         PUEwNsmxw9g3XCXegrtGG8mXwbsiNZu0AhCSSkMVdkB/ffCuWNDBv/us0kDLXTmgd4X1
         38UnkA6ZsstHv2b0+lW5FGwr2uIa+5yaycxDWX27HuqW03q8H0qS+6+VipZFmbhfbDls
         JQMOrYrtdLkAa2wR/hEwSybZL19d+7nxPiVHxBb7W1cbNJyHistYj0uOGNse3acf146C
         z+XsFb1E1A+7oEuAXhoecpVI5G/g0nswUoI3AnG2tSWHpJkGw39XzdY5qiXDUFxRW8jQ
         /RMA==
X-Gm-Message-State: AOJu0YwEZrxhZjBorrzyQgF6cQaPrJjPH2r73blTcxD28i5jgcV1EC1B
	T9ZV5bxjjQjsFfKriiFuHgGnIRVQk5dcSReyt6GK2AkIZCIekOAy1ZIjLQ==
X-Google-Smtp-Source: AGHT+IG9ZBjwLmjjGdREQUTxtnq5jE+sJe47NH34Mkn1SfYVj04RZKHPBe1TXxrNZigXQ0aBoF/22g==
X-Received: by 2002:a5d:5f47:0:b0:35f:d70:6193 with SMTP id ffacd0b85a97d-367cea96353mr11329724f8f.41.1720816451743;
        Fri, 12 Jul 2024 13:34:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7deeasm11129273f8f.8.2024.07.12.13.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:34:11 -0700 (PDT)
Message-Id: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Jul 2024 20:34:10 +0000
Subject: [PATCH] cmake: fix build of `t-oidtree`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When the `oidtree` test helper was turned into a unit test, a new
`lib-oid` source file was added as dependency. This was only done in the
Makefile so far, but also needs to be done in the CMake definition.

This is a companion of ed548408723d (t/: migrate helper/test-oidtree.c
to unit-tests/t-oidtree.c, 2024-06-08).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: fix build of t-oidtree
    
    This is based on the gt/unit-test-oidtree branch.
    
    /cc "Ghanshyam Thakkar" shyamthakkar001@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1761%2Fdscho%2Fcmake-vs-t-oidtree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1761/dscho/cmake-vs-t-oidtree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1761

 contrib/buildsystems/CMakeLists.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f9c33585c6..832f46b316b 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -976,11 +976,12 @@ list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 
 #unit-tests
 add_library(unit-test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
+add_library(unit-test-lib-oid OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/lib-oid.c)
 
 parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
 foreach(unit_test ${unit_test_PROGRAMS})
 	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
-	target_link_libraries("${unit_test}" unit-test-lib common-main)
+	target_link_libraries("${unit_test}" unit-test-lib unit-test-lib-oid common-main)
 	set_target_properties("${unit_test}"
 		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 	if(MSVC)

base-commit: ed548408723d6e969160279398cc47f88f5700bc
-- 
gitgitgadget
