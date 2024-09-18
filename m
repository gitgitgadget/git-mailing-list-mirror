Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C318654
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687774; cv=none; b=j0nTdsi+kf/Mt6B91SOQJ8iPUT4BDLQF9VFiNkd7XDPSb6f4QqpzREbi8UMBVhGVKtKJ+1mIxuGi5ztTZYFaiM0qKETsXNOO9dFQ8CGyeFcTMiKUsP7M6UIdo8xaBf/lER3TrRe/O7n2A8vPDBogzzufXFpPB4MJ/M9kE5Y6s6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687774; c=relaxed/simple;
	bh=tXc49s2u1wHi0SaRje3Uc/421UMRNIlihHoBwJezJSU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Fzndrd+222NppB3zj/X52imzohtWUsFL5HlSzpxe4GiEFPQmq4rSUK7zR20FXvhgYRh1+q9UROWdstrFF0uYAEBkYsDMAdZXtuPvpGim6T7kFceVbfB0Vt1cLDM3nniafITBMFkryPPr8opU4ZcLfjbqNuISM0xF8PDRK2N7e6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZQKPhB9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZQKPhB9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so39259e87.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726687771; x=1727292571; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t2r27h7gjjXuZqOJmqn2acSpsdEtjZWoRvZg4BZ0zhg=;
        b=JZQKPhB9uB1vuTIPv0EkwmzQ24acolDSq4/b527DM7iYCLGyYyJFZNWGvPE9FXroUr
         OqgsbOpvq+EF1qEBDpivs2RHL4kIir/WBD+0+/dx6gMhONOb6Lad9aMrwRJTfao+WLso
         wUACe6zeqf4UC0cqFMZYY/EqgZEzvldK4K3eUwBs6XkyO3UjtLc3khj/8JPB5897yqH6
         x6IVkcssOUjHAEkQKSC1OC9cJJU5qfbxLzdqgZynSPFWO5H4aoG/R9q9KKlO3At56+5u
         boMHP3UhDxLk+iQ+weUsYz31MN9rqvmawDX/FlB/MgQLaMZRN6pfttT4h39AFNNs/vSV
         itTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726687771; x=1727292571;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2r27h7gjjXuZqOJmqn2acSpsdEtjZWoRvZg4BZ0zhg=;
        b=Rg5wp5YQe3pkV2fTbcDrrJ13UAcrvyEcp82qNGGLUJabNBUd9ciZxXuepIg6nr43yn
         9kd3j6Wz2glcWtfOV98j3xM+ouLS4CHyuBKatbBPShljCfEUckYkuKxLnduwWnxTOK6r
         lG91cI93pOIl0rcIVMf1Hf2Uzc1AcdXTq054V0mz0q6c/Q/sizZuSqNINH19eIkBMaar
         5pLz2Q7jdbPVUO46Zer56GSrQD5zkkBb4DCF74FD8BG+1yKqWp4XiMwof7Npl5Nep5zf
         fdlEfbM3kdqaqKm8/MG4+8PMZ7XCu634EoWna9yaAYK0NWjJaqy5dsGDpTc6+tWbDx0O
         PEnw==
X-Gm-Message-State: AOJu0Ywz6MMYeCLT8JjR/bMYpZRwsA/e5BXGtAPnOnKfJhofvuId7vgG
	A77gN2cJZNJvbW0SeESfSc+A7fFHJEqrt8y67NJBxK9x2aA7N3WmI2/FoA==
X-Google-Smtp-Source: AGHT+IF9VWhkpZEYwT34UxqkIXNhzYbu9FdqlLMfFxqfz+4rc0OmNcKZLGbH+qa9QXy32srFpOHuuw==
X-Received: by 2002:a05:6512:124e:b0:534:3cdc:dbfe with SMTP id 2adb3069b0e04-5367fee526cmr8588023e87.28.1726687770548;
        Wed, 18 Sep 2024 12:29:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e2asm5219975a12.73.2024.09.18.12.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:29:30 -0700 (PDT)
Message-Id: <pull.1797.git.1726687769585.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 19:29:29 +0000
Subject: [PATCH] cmake: generalize the handling of the `UNIT_TEST_OBJS` list
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

In a15d4465a991 (cmake: also build unit tests, 2023-09-25), I
accommodated the CMake definition. Seeing that a `UNIT_TEST_OBJS` list
was introduced that was built by transforming the `UNIT_TEST_PROGRAMS`
list and then adding a single, hard-coded file
("t/unit-tests/test-lib.c"), I decided to hard-code that in the CMake
definition, too.

The reason why I hard-coded it instead of imitating the
`parse_makefile_for_sources()` paradigm that was used elsewhere when
using the `Makefile` as source of truth for given lists of files: This
function expects _only_ hard-coded values, and that transformed
`UNIT_TEST_PROGRAMS` list complicated everything.

In 872721538c26 (cmake: fix build of `t-oidtree`, 2024-07-12), I
accommodated the CMake definition again, after seeing that the
`UNIT_TEST_OBJS` was still defined via that transformed list but now
appending _two_ hard-coded files ("t/unit-tests/lib-oid.c" joined the
fray).

In 428672a3b16 (Makefile: stop listing test library objects twice,
2024-09-16), the `Makefile` was changed so that `UNIT_TEST_OBJS` is
finally only constructed using hard-coded file names just like the other
`*_OBJS` variables. I missed that and therefore did not adjust the CMake
definition. Besides, the code was working, so there was no real need to
adjust it.

With a4f50bb1e9b (t/unit-tests: introduce reftable library, 2024-09-16),
however, the `UNIT_TEST_OBJS` list became a trio, and the CMake
definition has to be adjusted again. Now that we can use the
`parse_makefile_for_sources()` function without many complications,
let's do that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: generalize the handling of the UNIT_TEST_OBJS list
    
    This is an add-on for ps/reftable-exclude to let it build with CMake and
    Visual C.
    
    This patch on its own does not actually fix vs-build; The patch "cmake:
    stop looking for REFTABLE_TEST_OBJS in the Makefile" which I submitted
    in
    https://lore.kernel.org/git/pull.1796.git.1726687400286.gitgitgadget@gmail.com
    is also needed for a successful vs-build.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1797%2Fdscho%2Freftable-exclude%2Bcmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1797/dscho/reftable-exclude+cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1797

 contrib/buildsystems/CMakeLists.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 832f46b316b..249c72075bb 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -975,13 +975,14 @@ parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
 list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 
 #unit-tests
-add_library(unit-test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
-add_library(unit-test-lib-oid OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/lib-oid.c)
+parse_makefile_for_sources(unit-test_SOURCES "UNIT_TEST_OBJS")
+list(TRANSFORM unit-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
+add_library(unit-test-lib STATIC ${unit-test_SOURCES})
 
 parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
 foreach(unit_test ${unit_test_PROGRAMS})
 	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
-	target_link_libraries("${unit_test}" unit-test-lib unit-test-lib-oid common-main)
+	target_link_libraries("${unit_test}" unit-test-lib common-main)
 	set_target_properties("${unit_test}"
 		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
 	if(MSVC)

base-commit: 18695250667912d8278e76dce453706c3d488173
-- 
gitgitgadget
