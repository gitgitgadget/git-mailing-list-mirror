Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4153CC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiEXM5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiEXM5G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:57:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5EA27FF6
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:57:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so25619817wrg.3
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ohLXGhobcU2vqHS8m5UZwb3Ogos8LmnUjzMW7L+PSMI=;
        b=Espo18ER5Tlk+L0ok8lkB29Z987VWTnGALxrWsuT5ctZoq6GE1kojJ0skkbeJWutUL
         nJoFF8NdgO94+Opyvmi+UxsvdVwzeQ4dOXeB3T2lts8spC64TTsfBODLt1jabIvPs7+6
         p4LxTfQ0aIrEmxbl3BiaRpsUgLkRVpqYpQv3VFPJEOUXPARH15Nx7RcKU2rHtPop2azp
         gE8VOGHulMglV5+4r3AaSMF23hCrM34zr2QS+plSRceu0mHRyrPiZXGBLf7fDeFaoR1s
         Dr+oBYWubDq2idgqoYBMz8vZ1iqMhg3VseAbUgwZSqcKfQeWVDAdREOniJso6D/rs1I/
         cnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ohLXGhobcU2vqHS8m5UZwb3Ogos8LmnUjzMW7L+PSMI=;
        b=Vb7TaPuwGtb0/hQ4KXPOUWZIyQuFLlxKpfF5zPiVmCSgGtgx8T3mOVdHAEWAsLRVrz
         4tn/I1uBA0sUylHBx1nOvRJCHVgYDwfdCfo0MXovX8jlrfTMDGUnpszvJo4SMZaCcVob
         aapNZuowF2Mc3G7zYdk6d0MIFt9UX/9NNyJpy8Q/wSJDdRl2yT4D5qelpESSic0mfVez
         iYwmnATqLIcHjmDG3nufrKBXZ2/VFgHkk1+z3r0733wNW9wygqJ+oNNNtLRfYdtkJVlX
         iDW3DGIU1YzOUjJIWFrc5aIIgqT4+m8MuoCCcgl5ZLxTslPOaxojA/S2m7NNnA74/MOg
         2Cbw==
X-Gm-Message-State: AOAM530NbXi27nOj4+LHmyfFVqxCOpNl3fmyvw+Ei4r3kXHQO27/or4C
        yaIOYIfEPh+PGN41szgPUz85lS+ynqk=
X-Google-Smtp-Source: ABdhPJwCjKNW2+47rGN0Ta2ZQK0Lj+/uADTRSZ1i/BTc83gedSwJZqjnBvMrVuUNm9OkwnvFq/Y4fQ==
X-Received: by 2002:a05:6000:1145:b0:20d:12f9:82c2 with SMTP id d5-20020a056000114500b0020d12f982c2mr23229605wrx.680.1653397022662;
        Tue, 24 May 2022 05:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020adfb1d1000000b0020c5253d926sm12430119wra.114.2022.05.24.05.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 05:57:02 -0700 (PDT)
Message-Id: <pull.1269.git.git.1653397021384.gitgitgadget@gmail.com>
From:   "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 12:57:01 +0000
Subject: [PATCH] Remove (_)UNICODE def on Windows in CMakeLists.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>,
        Yuyi Wang <Strawberry_Str@hotmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yuyi Wang <Strawberry_Str@hotmail.com>

`UNICODE` and `_UNICODE` are not required when building git on Windows.
Actually, they should not be predefined at all.

There're 2 evidences that `(_)UNICODE` is supposed to be nonexist:

compat/win32/trace2_win32_process_info.c:83: It uses jw_array_string
which accepts pe32.szExeFile as const char*.

t/helper/test-drop-caches.c:16: Calling to GetCurrentDirectory with
Buffer as char*.

The autotools build system never defines `UNICODE` and `_UNICODE` and
builds on Windows well.

Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
---
    Remove (_)UNICODE def on Windows in CMakeLists.txt

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1269%2FBerrysoft%2Fcmake%2Fwincompat-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1269/Berrysoft/cmake/wincompat-v1
Pull-Request: https://github.com/git/git/pull/1269

 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 185f56f414f..d52d973ab0d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -260,7 +260,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
-				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
+				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
 	list(APPEND compat_SOURCES
 		compat/mingw.c
 		compat/winansi.c

base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
-- 
gitgitgadget
