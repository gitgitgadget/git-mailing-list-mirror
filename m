Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66AC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 06:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiEXGjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 02:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiEXGiz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 02:38:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295D79394
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:38:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k30so24223549wrd.5
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KeherYkL96JuUfB8U+hNx+ZYpmvHBL6l0fr+7XQLM1o=;
        b=p9iRLtEBA6caTy8IgbmBOTzHOye4Tcpo8obJtinNp+au1Ypjvbiw4dToAe+MzYa3Kl
         FvIuvxtbVZqPhX1MHMmDeT5vh+NHNi+GVTmGUKuDfZ6FlQFjzE27WiNYXI6l6e9uukGb
         iNg0IEIM2n4gTJVRDdggI6CVzi0nqu3oQvOzYRdU0z9PMbcvoBuesW9KmCrmZ9/LldPG
         cM7vOigXSnGjB6aobmytZWKsOdGrrEzmEl8bOJf39euckS/RLJtjCyGo1MhHeJaR1AxM
         2ANFVoizxdHguujPh7qGzGBR5/xSSTlr8MuPaYhW7zbbkjo5X8D5Hbvs9Qbro9Xwdl/V
         hYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KeherYkL96JuUfB8U+hNx+ZYpmvHBL6l0fr+7XQLM1o=;
        b=UWAYckIOTKCusnKPd/bakmDrihrEm72y5DClRuYCk/w7giFuNG+5hP7kTBkI+3Ervy
         8eLHXMkQYSU9G1jrfJMWannn5wCXxGcm6D5nLv71aMwJc15zINhJYsF/PHF5jN2tTGE+
         FOGmBNtiqOQwkYMETyuQV00YcGGGok6srK781+sVf5HU9wmqCIlaVbWkE9PhNBdWXTzV
         rmoowMIrC/aJiBNcQkyVGs52++D55JOSuk6dCzyQ6pVOjADTYBuzTmDvtGE4ZelBGN/L
         4imJM4SY3wA6OLndaWdRsaqwtA0XVsXClVp4tHgcX1CxJAsjOrZrXwUFW16JcVWRFQMd
         hNxg==
X-Gm-Message-State: AOAM531Bg7CUHbjW9PeoHxsI/bB3FUNLD1zMYjtBhAvBCnBQkViAKsL7
        XHabLybExNQK47EmjmJ92Jv/ikc5oz0=
X-Google-Smtp-Source: ABdhPJxP6SY5gEIaNJJsasqHGrYvGKppMAHWiaDJz+/El8HARsfgPNsswyLu4SFai+BHrIK1bCiLBw==
X-Received: by 2002:a05:6000:15c5:b0:20c:ff53:e24a with SMTP id y5-20020a05600015c500b0020cff53e24amr22489809wry.396.1653374332403;
        Mon, 23 May 2022 23:38:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u22-20020adfa196000000b0020c5253d8dcsm12186560wru.40.2022.05.23.23.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:38:51 -0700 (PDT)
Message-Id: <b828585b2050b3ce114abf304a60bb7eaecd8b14.1653374328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1267.v2.git.git.1653374328.gitgitgadget@gmail.com>
References: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
        <pull.1267.v2.git.git.1653374328.gitgitgadget@gmail.com>
From:   "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 06:38:48 +0000
Subject: [PATCH v2 2/2] Add pcre2 support for cmake build system.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yuyi Wang <Strawberry_Str@hotmail.com>

This commit fixes one of the TODOs listed in the CMakeLists.txt.

As pcre2 doesn't provide cmake find module, we find it with pkgconf.
This patch also works with vcpkg on Windows, with pkgconf and pcre2
installed.

Pkgconf and pcre2 is detected automatically just like curl, expat
and iconv. The output of CMake indicates whether pcre2 is found.

Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 7f333e303c2..2844dd6c88d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -108,7 +108,6 @@ project(git
 
 #TODO gitk git-gui gitweb
 #TODO Enable NLS on windows natively
-#TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
@@ -160,6 +159,14 @@ if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID ST
 	find_package(Intl)
 endif()
 
+find_package(PkgConfig)
+if(PkgConfig_FOUND)
+	pkg_check_modules(PCRE2 libpcre2-8)
+	if(PCRE2_FOUND)
+		add_compile_definitions(USE_LIBPCRE2)
+	endif()
+endif()
+
 if(NOT Intl_FOUND)
 	add_compile_definitions(NO_GETTEXT)
 	if(NOT Iconv_FOUND)
@@ -180,6 +187,9 @@ endif()
 if(Intl_FOUND)
 	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
 endif()
+if(PCRE2_FOUND)
+	include_directories(SYSTEM ${PCRE2_INCLUDE_DIRS})
+endif()
 
 
 if(WIN32 AND NOT MSVC)#not required for visual studio builds
@@ -700,6 +710,10 @@ endif()
 if(Iconv_FOUND)
 	target_link_libraries(common-main ${Iconv_LIBRARIES})
 endif()
+if(PCRE2_FOUND)
+	target_link_libraries(common-main ${PCRE2_LIBRARIES})
+	target_link_directories(common-main PUBLIC ${PCRE2_LIBRARY_DIRS})
+endif()
 if(WIN32)
 	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
 	add_dependencies(common-main git-rc)
-- 
gitgitgadget
