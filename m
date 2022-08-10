Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE1C19F2A
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiHJPCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiHJPCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:02:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36075FE5
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1155340wma.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oqn06qcCx888JqXrAWFrPw6Pt3QXV7A7ysDTY/54nAY=;
        b=b/WWvmRybyi2AvO/dt+frZExxtOq9zJAl5MbcJezVSluzpHF01D6Yj/Y5AcCnQ5v8y
         MZuCToOFzaE/0NdJM2s2uMbXE24+pqbOzdfX/PN4b85up6nRuRkK/oMwMNBGzkWvgfXo
         6kOujjZsaa5/tKudIWAwRrUxqcB9iYfOBIeA4J55OmICQUvHz4S/6+896VC99XF8iNR4
         PlV13iyvnyHxJ1io17LKfnCXS5UGJ8gNBQse2xspvFU/MJMSAcK3bxYSYe58fazK/n62
         2QhhCfQPPpvqdaMd00FRllnzCfUoVIUDlReslC1mg1WlshDTAW2/HvZiRWJIfiAPeKME
         szDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oqn06qcCx888JqXrAWFrPw6Pt3QXV7A7ysDTY/54nAY=;
        b=adsZ3jYRAVqJDYai/J/GhxdXENKV5VQkkxj+rz3FaDl+1+cmoofIqec3hbb7mjPGNE
         ivt7Hz3QVyv3V0TUj0op+pmtUTbDFXyqMG+DyuqenccAGpxK7WgUVXCDnjjoiI+AJ1Bl
         ehjWmdy6r/8a1L0s63+QKFiFJrwRCtK+X8UgdIw3DVh+DvtuMN/ZqKHURLcbgo+huNwf
         SIjGVU+mIJGWIGN4PZmWzYbgdROOL6m2m3cQzZ73nZG8mCphsCLlahOezTkf+kIC+sKG
         99fgGFesrKwANQM/juPq8AJgrIDZBgE9puZwBsYcwm200wk3biHdSi416SYRDsI+AfrJ
         L79w==
X-Gm-Message-State: ACgBeo2Ang+yai95Sy13GhDTYUKVIITHUEycvC2lv4HdkJmCQer2DjLg
        1by1eYJNUqrnpoRCow1wLj9OMSvuzDo=
X-Google-Smtp-Source: AA6agR4w1flu6HRxH3r4F6xBXQ2Lm7wOui5bPjMbhWTx6x5Ypm4o9MDcmD5iHRF/6EBdMA6JznDXfQ==
X-Received: by 2002:a7b:ce10:0:b0:3a5:3f91:e2fb with SMTP id m16-20020a7bce10000000b003a53f91e2fbmr2855401wmc.138.1660143758149;
        Wed, 10 Aug 2022 08:02:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b002217339ce90sm13976926wrx.8.2022.08.10.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:02:37 -0700 (PDT)
Message-Id: <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 15:02:30 +0000
Subject: [PATCH 5/5] cmake: avoid editing t/test-lib.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 7f5397a07c6c (cmake: support for testing git when building out of the
source tree, 2020-06-26), we implemented support for running Git's test
scripts even after building Git in a different directory than the source
directory.

The way we did this was to edit the file `t/test-lib.sh` to override
`GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
directory.

This is unideal because it always leaves a tracked file marked as
modified, and it is all too easy to commit that change by mistake.

Let's change the strategy by teaching `t/test-lib.sh` to detect the
presence of a file called `GIT-BUILD-DIR` in the source directory. If it
exists, the contents are interpreted as the location to the _actual_
build directory. We then write this file as part of the CTest
definition.

To support building Git via a regular `make` invocation after building
it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
convenience, this is done as part of the Makefile rule that is already
run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
up to date).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                          |  1 +
 Makefile                            |  1 +
 contrib/buildsystems/CMakeLists.txt |  7 +------
 t/test-lib.sh                       | 11 ++++++++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index a4522157641..b72ddf09346 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@
 /fuzz_corpora
 /fuzz-pack-headers
 /fuzz-pack-idx
+/GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 04d0fd1fe60..9347ed90da7 100644
--- a/Makefile
+++ b/Makefile
@@ -3028,6 +3028,7 @@ else
 	@echo RUNTIME_PREFIX=\'false\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fe606c179f7..29d7e236ae1 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1067,14 +1067,9 @@ endif()
 #Make the tests work when building out of the source tree
 get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
 if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
-	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
-	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
 	#Setting the build directory in test-lib.sh before running tests
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
-		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
-		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
-		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
-		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
+		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
 	#misc copies
 	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55857af601b..4468ac51f25 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -42,7 +42,16 @@ then
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
 GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
-if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
+if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+then
+	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+	# On Windows, we must convert Windows paths lest they contain a colon
+	case "$(uname -s)" in
+	*MINGW*)
+		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
+		;;
+	esac
+elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
 	exit 1
-- 
gitgitgadget
