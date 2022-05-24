Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53BC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 06:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiEXGix (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 02:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiEXGiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 02:38:52 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AE79394
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:38:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h14so24233327wrc.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y9d4GMoW25UvrnGUJ44DQ5pI+oyUaDADOWrLNZJuqtk=;
        b=VT38Eq6P9EdS/Le/kf6bTP3HTOdbNULD9ZzXLjzZ8T+mvZugY89jeOvGSbJDgFYjwx
         p0n5Qy2xHOIlumLbdzs13FFGvx3NkCAiRL4GbfNsn/bp5A7iZJUGFQ4Y+fZbnHX4d+tH
         qkQMnXYRWyKJMqrLokWWb1IxBRSfU3KCm+HiH9zhfFkfdiX2JvWHSVLbw+97/ycmHJTq
         6s2NLxKAJuu/S7/v+I4bVWKUvPENo606Sp0jdYbZNPMN4WUg2g3aHF2LIBPyJlHahgxN
         SEqsT61LakZ1P0Je05XhHz9/xFJWa5PTfVNB9qt4BHqY/pB6bsDWypY8bB+FKVxaOjhb
         FQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y9d4GMoW25UvrnGUJ44DQ5pI+oyUaDADOWrLNZJuqtk=;
        b=DY0DAUzcPHcGJO9GJJogai+fuJuRCEmjXlunX9aEnpkOfJhTS0fTeNfF2XwKZGeBfx
         xZ379uBumr8m9Qgmi6N6ZBE/fBVSE5N6KFfXi47UknWhyF+qCeU9YCHjMJGps04m1RLg
         /F9vYMbjLWOZ5CHIvQzTF6W6k4cpaNa6EpvMZmLhYjBZRxsnyyNtv9gDKJcVH4gcoywq
         4QvOCgNT8XDzVMNJNMVhjd72IMoIMFc5k+OKYO/EwTVrAjjQagxJlS8gwY5IC/8Opd4w
         ZqHA5b+0ZIcaz7+mP0tKFRH++RmUDQBCCAcaRz7ytY9h7Q4cKuQvVj62ySEyrdGZGQGw
         7rcA==
X-Gm-Message-State: AOAM532fyI4Nv3AxXoB62eLhFPxJa0OI1Tg361RCxwRt9+yiueI+yD1m
        rI6W1GAWgmjnp6581F84NZfg/HfnfpE=
X-Google-Smtp-Source: ABdhPJw8N5X+s5bUHbB1L0nK4LzcyBN3i1+5TeFE8JJlyS3njfYfCdtxDNpxlO+9rOPKZPqwE3NOBw==
X-Received: by 2002:a5d:6781:0:b0:20e:58b7:85c0 with SMTP id v1-20020a5d6781000000b0020e58b785c0mr21809570wru.328.1653374329944;
        Mon, 23 May 2022 23:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b00397402ae674sm1152330wme.11.2022.05.23.23.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:38:48 -0700 (PDT)
Message-Id: <pull.1267.v2.git.git.1653374328.gitgitgadget@gmail.com>
In-Reply-To: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
References: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
From:   "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 06:38:46 +0000
Subject: [PATCH v2 0/2] Add pcre2 support for cmake build system.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pcre2 is dealt with pkg-config.

Yuyi Wang (2):
  Fix CMakeLists.txt on Linux.
  Add pcre2 support for cmake build system.

 contrib/buildsystems/CMakeLists.txt | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)


base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1267%2FBerrysoft%2Fcmake%2Fpcre2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1267/Berrysoft/cmake/pcre2-v2
Pull-Request: https://github.com/git/git/pull/1267

Range-diff vs v1:

 -:  ----------- > 1:  29cb31e5c50 Fix CMakeLists.txt on Linux.
 1:  679e5dd46d0 ! 2:  b828585b205 Add pcre2 support for cmake build system.
     @@ Commit message
      
          This commit fixes one of the TODOs listed in the CMakeLists.txt.
      
     -    There's also some small fix to ensure it builds successfully.
     +    As pcre2 doesn't provide cmake find module, we find it with pkgconf.
     +    This patch also works with vcpkg on Windows, with pkgconf and pcre2
     +    installed.
     +
     +    Pkgconf and pcre2 is detected automatically just like curl, expat
     +    and iconv. The output of CMake indicates whether pcre2 is found.
      
          Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
      
       ## contrib/buildsystems/CMakeLists.txt ##
     -@@ contrib/buildsystems/CMakeLists.txt: set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
     - 
     - option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
     - if(NOT WIN32)
     --	set(USE_VCPKG OFF CACHE BOOL FORCE)
     -+	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
     - endif()
     - 
     - if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
      @@ contrib/buildsystems/CMakeLists.txt: project(git
       
       #TODO gitk git-gui gitweb
     @@ contrib/buildsystems/CMakeLists.txt: endif()
       
       
       if(WIN32 AND NOT MSVC)#not required for visual studio builds
     -@@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     - 
     - elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
     - 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
     --	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
     -+	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
     - endif()
     - 
     - if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
      @@ contrib/buildsystems/CMakeLists.txt: endif()
       if(Iconv_FOUND)
       	target_link_libraries(common-main ${Iconv_LIBRARIES})
       endif()
      +if(PCRE2_FOUND)
      +	target_link_libraries(common-main ${PCRE2_LIBRARIES})
     ++	target_link_directories(common-main PUBLIC ${PCRE2_LIBRARY_DIRS})
      +endif()
       if(WIN32)
       	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)

-- 
gitgitgadget
