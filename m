Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B3C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 06:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiEXGi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiEXGiy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 02:38:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E076295DD3
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:38:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z15so393661wrg.11
        for <git@vger.kernel.org>; Mon, 23 May 2022 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=agfffC1EWWDgzcKTGFal/q5kCT//8ky54V4ZIn3AaN4=;
        b=EcK/vRsi5IxFxsbhto36fbRdeKX/HARODBIboU/SbQ5H7muSa/zChgqxKOwDLa1GDX
         p7yXhwulYYeOTfEk0vQbIzhh7Otn6OstiKWokhgPZD0Px+I0OezA/aTWI/TSkc2JhD+7
         goXfy12+lwzYld/YnA5tdRU9VWg6wWAU2YBbyBMj7AgZXjYt+l//g27O24gIUr8PtTm1
         mHLMhc5Ck0HTYa6UB8TV+NPc/+Vg8qDICSY21DD7AAjdRUvvrmnwwX+tYYX4fPG3OJoR
         8rMrvPVecVkNkIc0RgxG5pMqMAwOVdkIehQTWT6f1QaPpW7sJPkUgt5JRl/G+1oeznsQ
         NBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=agfffC1EWWDgzcKTGFal/q5kCT//8ky54V4ZIn3AaN4=;
        b=jTjsdIvBeeMrrYjaG8v5fntp4xZxBInxFocsuDg5RWw+EAJGF4mXqY0U0KixockE6P
         pCbCM6kgrIsJdMXn80hsViEdzc7kYN+1+RgF+uwJ2Bsd48uu3XKvbeDiI9g3Gq2DCGt3
         I102KHS4yzreIbsGZoJFoUCAi5JrbER1Wo3rRcTgJx8e0UGiP6paQbPHGl3+QJ+LiPpD
         aOWvo4OQzESiwHymvT90x++gaXmZGndRk9xQErstw75zdPIrFSQeJmjoTr8ar+9K6jUm
         lVkG7w56yGYW/akO/LyxgjRfbFp+dfEXY7Rz6+kAXLFgN7oHbvpwPpV05TjfQOrvg1Zo
         9aOA==
X-Gm-Message-State: AOAM530IrwmF1LcQEFFrVXCq3/hw6aNNbj+k14j6dD4EqHxqik7VC2St
        P65cKqAZq92/kB4CtTT3HGgfR+8lnzQ=
X-Google-Smtp-Source: ABdhPJwP8qev3mikXwIYIr+zxfVqQE+GoX5WZzuItNle99i8gkpUaoVDiMomYiOoPCKn53KegOI0/A==
X-Received: by 2002:a5d:648f:0:b0:20f:cc1a:3f75 with SMTP id o15-20020a5d648f000000b0020fcc1a3f75mr11274771wri.660.1653374331098;
        Mon, 23 May 2022 23:38:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b003973b9d0447sm1190975wmr.36.2022.05.23.23.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:38:50 -0700 (PDT)
Message-Id: <29cb31e5c502149192c6beb56bf8b372a40711e0.1653374328.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1267.v2.git.git.1653374328.gitgitgadget@gmail.com>
References: <pull.1267.git.git.1652846305514.gitgitgadget@gmail.com>
        <pull.1267.v2.git.git.1653374328.gitgitgadget@gmail.com>
From:   "Yuyi Wang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 06:38:47 +0000
Subject: [PATCH v2 1/2] Fix CMakeLists.txt on Linux.
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

CMakeLists.txt didn't follow the grammar of `set`, and it will fail when
setting `USE_VCPKG` off on non-Windows platforms.

When the platform is Linux, the Makefile adds `compat/linux/procinfo.o`
to `COMPAT_OBJS`, but the CMakeLists.txt didn't add
`compat/linux/procinfo.c` to `compat_SOURCES`. It would cause linkage
error.

Signed-off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 185f56f414f..7f333e303c2 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -54,7 +54,7 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
 option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
 if(NOT WIN32)
-	set(USE_VCPKG OFF CACHE BOOL FORCE)
+	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
 endif()
 
 if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
@@ -277,7 +277,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
+	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
-- 
gitgitgadget

