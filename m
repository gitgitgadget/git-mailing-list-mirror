Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18E1CB505
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687281; cv=none; b=H8i1/4fMkmwgUZ+lOwO6fTFWrDv+XLNeuCJ4gsshouVinyWFC2OyP9O7GpjnnfzlP+d/RwBblkIfYokqhw+P+rphV/et0dQwdpiBva5LV68shFDdRGrlbUvniamCf7EYMnrGCLKKqxG0aDghay37AOv4MVFUdjZbgxVWfhqJgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687281; c=relaxed/simple;
	bh=d71gpBwZeAwnv9IcXNB+YWoxjcHJJ5uX6ATSbmC3Lw0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bLEsD7Q04WqchO65WS7yhsAXupk0L0kdQJQjbV00QSFzhh4Jd3o4EarWdP+kOrfouqBjzWIMZrV38s/oVC+dzQrIALxaTPkWsMGaKIpuJsELTZs287KjaBE/qwRt+wWsQUS2kB/OhirdVdFdE/gcwdiz+BNnNTXPsJGv9kT0KRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrKStVSu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrKStVSu"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so2332966b.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726687278; x=1727292078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk5smPu4YsOI4xUKw7gAHOdg+V0uBBROfKDlHjW7X/M=;
        b=PrKStVSuQhxylWNj66A6MotnbDQtxZQ8LqVGAtSQg/Bn3Fy/OC1RtuTWKQR4QGcKGh
         YqftbxjfpZnL/oc3ntgOxdgPoEZgTKjg7b9cMaCtwmCFRc7pMkizTix+LmwJSwT837VT
         4jT33v17xAq62bzsxcHd8Oa/T0Bt5TGxied/hVKIcCy+sh5DLy7z6qKxctjK+kLUOZuz
         RWJS87mgfgzdoYv76uwiC8OHNnbMEDOweWm2Z8GY10mQFVgpU3e5jIN7VL1zSUQNRY4X
         +j9tA3uWoLt6bmTfwydgBF7FIuUIyT5LqXnfuciTny3lwmRG1Fs37F20S2RRbeLES+LR
         fphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726687278; x=1727292078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uk5smPu4YsOI4xUKw7gAHOdg+V0uBBROfKDlHjW7X/M=;
        b=Dzs3rBjZVucq7CN8T+X/8/WCcCN/AZQzqbwUJr/W3Aht7VRZQ1faZJeprYAvZR4TyA
         QqwVOSwaLl/VqK+KmbbomP6QIUpgtxwWBGKCJSQZoWNzflJnOi++wr3uCuHJxKc9YSSV
         b5y6K52tisezAsE74LGZ02mBa/2HwnTzz8CFNfebGXaGl77AVApKC1A/DvupSOdqYtUq
         WvRbVAP9MD9iMXZ+Jkm3cYQ9vSrDgDCmGRCR4kyLotkHX9ZcggrgywtNUI/hA00Zm2oy
         Xx/Nlmx2XmgOR0UvWvajwAGE124SOAbggBBS9mLLdsau/NI1Hl0myt+4HiM6qkyCVWoJ
         /HYg==
X-Gm-Message-State: AOJu0YxQnmq3sI3GOpOpU23CB5XIHY/vXpOTpTcXz+ZiXGfuGuqLghUE
	tZa/wvw3nITZ1ZkdvjzGVom12VotE6M/vkssHKxu9v5eh1q09elk/fd2nQ==
X-Google-Smtp-Source: AGHT+IFitFQI/zzPBg3CCH5H1PMlUo2aM6nnhswA3UE8oi8et+m4OLpeio4czAu1hMsBVFrVoVlzBg==
X-Received: by 2002:a17:907:3e86:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a9029671639mr2452790166b.60.1726687277642;
        Wed, 18 Sep 2024 12:21:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061116d67sm629259166b.94.2024.09.18.12.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:21:16 -0700 (PDT)
Message-Id: <pull.1795.git.1726687276169.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 19:21:16 +0000
Subject: [PATCH] cmake: rename clar-related variables to avoid confusion
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

In c3de556a841f (Makefile: rename clar-related variables to avoid
confusion, 2024-09-10) some `Makefile` variables were renamed that were
partially used by the CMake definition. Adapt the latter to the new lay
of the land.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: rename clar-related variables to avoid confusion
    
    This is an add-on for ps/clar-unit-tests to let it build with CMake and
    Visual C.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1795%2Fdscho%2Fclar-unit-tests%2Bcmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1795/dscho/clar-unit-tests+cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1795

 contrib/buildsystems/CMakeLists.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 608fd3fe709..7890bc40c5f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1004,14 +1004,14 @@ foreach(unit_test ${unit_test_PROGRAMS})
 	endif()
 endforeach()
 
-parse_makefile_for_scripts(unit_tests_SUITES "UNIT_TESTS_SUITES" "")
+parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
 
 set(clar_decls "")
 set(clar_cbs "")
 set(clar_cbs_count 0)
 set(clar_suites "static struct clar_suite _clar_suites[] = {\n")
-list(LENGTH unit_tests_SUITES clar_suites_count)
-foreach(suite ${unit_tests_SUITES})
+list(LENGTH clar_test_SUITES clar_suites_count)
+foreach(suite ${clar_test_SUITES})
 	file(STRINGS "${CMAKE_SOURCE_DIR}/t/unit-tests/${suite}.c" decls
 		REGEX "^void test_${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*\\(void\\)$")
 
@@ -1042,9 +1042,9 @@ string(APPEND clar_suites
 file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${clar_decls}")
 file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar_cbs}" "${clar_suites}")
 
-list(TRANSFORM unit_tests_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
-list(TRANSFORM unit_tests_SUITES APPEND ".c")
-add_library(unit-tests-lib ${unit_tests_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
+list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
+list(TRANSFORM clar_test_SUITES APPEND ".c")
+add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
 target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
 add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
 target_link_libraries(unit-tests unit-tests-lib common-main)

base-commit: c3de556a841f132832f742d1c4d3a2618ee3b355
-- 
gitgitgadget
