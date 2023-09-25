Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C6CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjIYLUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIYLUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72576C6
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405361bba99so56875775e9.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640841; x=1696245641; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPKLJZTdAYy4gPLlzGrI2QiJBuM0Y1QSVxRETjMYcVQ=;
        b=YizxMxe1lbuKi695G9zow9OEbgCaCZXaDJObXbg1tXSffgUyvQDJS3jf/n+dYEBJW6
         Bo/6FNn3rUMc2377enFI1KRJLEktsn0KO7MYGKaldGFo6D52mG+fbOgxTn/X9cmjA/u0
         HiJ3Z2SOkSACSL+iQ6mjUkcWj8X1r9VeKGNdTh03yNu/LUTw+AmQ3YQedHqh27y53/m6
         AM9lI9DHarnHjprbclirjzKn6NyWHjpoMXesuGYZE50UxfqouOr4iBleHGkrnorUfCAk
         FRSePTjRNHBb2ShCSQq+7q1p9Dsgy1ZHE0PwmnHPy/KXEkVvb/iAHaXSf7ocvFwJu/Ga
         v3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640841; x=1696245641;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPKLJZTdAYy4gPLlzGrI2QiJBuM0Y1QSVxRETjMYcVQ=;
        b=gcSyEiqLb9duJZvtTggJeJx14kTj+AzlSym0jpoV1f2nFAN6cAxyNKuEq1CzegCo8E
         fIc7c2Gr8AXsdpPeYn6AlwGV/wBEdUgHeoRDKeFTirUcd1VnyUpudKKdnYtic2CrXh/Y
         tsirOFbrMl9XSgeomoDJLKPA5YrBAxraIn4Lm2c/cVYhQ1L6yNcZmkcqXIxn/D/sQRtT
         l+lJURoTTS/YTE5OBkLK4OfVJy4+rueIV9NGgZORqrVH15el8Lt4h85zror0JP8bvN6b
         jszWeogXXt94963b73xNhVO1TKnoILuuUCN2wQtH2KoK7eBUNlNtRFthw3xTW2i204sN
         tRbw==
X-Gm-Message-State: AOJu0YzWPzDXpvQilYEYtcnxaWKTfhEuY+JUYRzk0Oemz3mjLTmDn0nU
        VMuFBP8K0cFSZD/bfPcptrWl3WoviZQ=
X-Google-Smtp-Source: AGHT+IESUkHFUUWEG6+l0P9C+t4VrcKqMxfBY+TZtajFOzm3335DiadDL0/gTjE3KYNC2ipUd7c/yQ==
X-Received: by 2002:adf:a1d2:0:b0:323:1df0:c039 with SMTP id v18-20020adfa1d2000000b003231df0c039mr3047611wrv.56.1695640840816;
        Mon, 25 Sep 2023 04:20:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003fc01189b0dsm11900315wmk.42.2023.09.25.04.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:40 -0700 (PDT)
Message-ID: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:29 +0000
Subject: [PATCH v3 0/7] CMake(Visual C) support for js/doc-unit-tests
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent patch series that adds proper unit testing to Git requires a
couple of add-on patches to make it work with the CMake build on Windows
(Visual C). This patch series aims to provide that support.

This patch series is based on js/doc-unit-tests.

Changes since v2:

 * Thanks to Phillip Wood's prodding, I managed to avoid the "Empty
   Namespace" problem in Visual Studio's Test Explorer.

Changes since v1:

 * The code added to test-lib.c now avoids using a strbuf.
 * The unit tests are now also handled via CTest.
 * While at it, I cleaned up a little in the CTest-related definitions.

Johannes Schindelin (7):
  cmake: also build unit tests
  unit-tests: do not mistake `.pdb` files for being executable
  unit-tests: do show relative file paths
  artifacts-tar: when including `.dll` files, don't forget the
    unit-tests
  cmake: fix typo in variable name
  cmake: use test names instead of full paths
  cmake: handle also unit tests

 Makefile                            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 38 ++++++++++++++++++---
 t/Makefile                          |  2 +-
 t/unit-tests/test-lib.c             | 52 ++++++++++++++++++++++++++---
 4 files changed, 84 insertions(+), 10 deletions(-)


base-commit: 03f9bc407975bba86d1d1807519d76e1693ff66f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1579%2Fdscho%2Fdoc-unit-tests-and-cmake-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1579/dscho/doc-unit-tests-and-cmake-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1579

Range-diff vs v2:

 1:  2cc1c03d851 = 1:  2cc1c03d851 cmake: also build unit tests
 2:  90db3d5d41f = 2:  90db3d5d41f unit-tests: do not mistake `.pdb` files for being executable
 3:  f0b804129e8 = 3:  f0b804129e8 unit-tests: do show relative file paths
 4:  a70339f57a7 = 4:  a70339f57a7 artifacts-tar: when including `.dll` files, don't forget the unit-tests
 5:  75a74571fbe = 5:  75a74571fbe cmake: fix typo in variable name
 6:  41228df1b46 ! 6:  0a2d08b91e5 cmake: use test names instead of full paths
     @@ Commit message
          dots confuse the Test Explorer and it uses a large part of the path as
          "namespace".
      
     -    Let's just use `t.<name>` instead. This still adds an ugly "Empty
     -    Namespace" layer by default, but at least the ugly absolute path is now
     -    gone.
     +    Let's just use `t.suite.<name>` instead. This presents the tests in
     +    Visual Studio's Test Explorer in the following form by default (i.e.
     +    unless the user changes the view via the "Group by" menu):
     +
     +            ◢ ◈ git
     +             ◢ ◈ t
     +              ◢ ◈ suite
     +                 ◈ t0000-basic
     +                 ◈ t0001-init
     +                 ◈ t0002-gitfile
     +                 [...]
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ contrib/buildsystems/CMakeLists.txt: file(GLOB test_scripts "${CMAKE_SOURCE_DIR}
       foreach(tsh ${test_scripts})
      -	add_test(NAME ${tsh}
      +	string(REGEX REPLACE ".*/(.*)\\.sh" "\\1" test_name ${tsh})
     -+	add_test(NAME "t.${test_name}"
     ++	add_test(NAME "t.suite.${test_name}"
       		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
       		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
       endforeach()
     @@ contrib/buildsystems/CMakeLists.txt: file(GLOB test_scripts "${CMAKE_SOURCE_DIR}
       # This test script takes an extremely long time and is known to time out even
       # on fast machines because it requires in excess of one hour to run
      -set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
     -+set_tests_properties("t.t7112-reset-submodule" PROPERTIES TIMEOUT 4000)
     ++set_tests_properties("t.suite.t7112-reset-submodule" PROPERTIES TIMEOUT 4000)
       
       endif()#BUILD_TESTING
 7:  003d44e9f0d ! 7:  64707240a4e cmake: handle also unit tests
     @@ contrib/buildsystems/CMakeLists.txt: foreach(unit_test ${unit_test_PROGRAMS})
      +	#
      +	# All other unit tests should be run.
      +	if(NOT ${unit_test} STREQUAL "t-basic")
     -+		add_test(NAME "unit-tests.${unit_test}"
     ++		add_test(NAME "t.unit-tests.${unit_test}"
      +			COMMAND "./${unit_test}"
      +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t/unit-tests)
      +	endif()

-- 
gitgitgadget
