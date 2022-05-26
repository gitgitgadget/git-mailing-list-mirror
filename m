Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2311C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbiEZVte (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348784AbiEZVtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21A860C9
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j25so3641154wrb.6
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=JPx+38Vt4wDW8fTjh75zpe/O1MUbEU1cxbv1W4oLIkHzATajcKuJkYTLjRRW0CrooR
         8T6c2niCtVl3P1FFi62yWBJQqpoWf8swmYDJ+snGKHtFt3DQZGZ26A+lWURfdmuQu8GZ
         Eci2VS3KfbivKEVWNsn/JoxNCY8BB78qOy985QII0Ykn2pIYPb6TNGz9roIn4aRaylhV
         Vc6jkeKls695ucReptirHcAhmGiDmwgfN8ZaDK1IImpfVL9j0zV7EZwf3+y5NKJOMKHL
         WW94bLf/dwD5GSZpZIL9cRDhLZj+Bc+TgMDQFFicqfvVKROmjoKRPxbqc0mwy+6l8cE4
         wsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=wbPxmg7iouXIeDpAOFjwPu7fnnm8016M8Rc1c5G+z+Ty5Td1IugNkpWI2mLlBLg9Uu
         JU/BLKIV42CZkcBm1ldFYIORpowEwazDZJeLE4eTdhdxi7e0q+BHyiUFFhmVv7sQXh12
         lLPIrhEUL89uQSgmOWksO4zLh/bVChzdDD5DcN0AoPT+rePzT56VRyzXZY43UheL8pDM
         tCEwxLI/o3WwsrpWcLDoyHDutGMit/vPwAJO0drij4LUFCHsezQ5PG9Mvwy8Kcdcmedp
         sUZgROzIcDdVFiNDttPYHJPkznDoP7fOEuPyfs5leYNyDu+LrqOLmMV1C0zke5DoEymH
         hHCQ==
X-Gm-Message-State: AOAM533c4kkD22jU5nxDKOm06BFwdvzJtlelQzTUk2dItdzlDDxYPXk7
        P90QijZvnkIIlnIhbWgEt62z/L6NItI=
X-Google-Smtp-Source: ABdhPJw9YacS1RoPN+Xpz1oi7xNvbycsThmF2ydBNVJQQx3FBCaIKdVB4aChw4HnjPEOIFRz6u7Wew==
X-Received: by 2002:adf:e491:0:b0:210:c71:dd15 with SMTP id i17-20020adfe491000000b002100c71dd15mr3833827wrm.538.1653601752164;
        Thu, 26 May 2022 14:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b0039750c39fc5sm10444878wmr.3.2022.05.26.14.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:11 -0700 (PDT)
Message-Id: <2b6e8b0b241314e3f5d4dde9d81fb8ccc3c854c6.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:01 +0000
Subject: [PATCH v9 07/30] fsmonitor-settings: stub in macOS-specific
 incompatibility checking
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-settings-darwin.c | 9 +++++++++
 config.mak.uname                       | 1 +
 contrib/buildsystems/CMakeLists.txt    | 3 +++
 3 files changed, 13 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
new file mode 100644
index 00000000000..7fce32a3c5b
--- /dev/null
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -0,0 +1,9 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+#include "fsmonitor-settings.h"
+
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
+{
+	return FSMONITOR_REASON_OK;
+}
diff --git a/config.mak.uname b/config.mak.uname
index cf224768ad6..cf911d141f2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -163,6 +163,7 @@ ifeq ($(uname_S),Darwin)
 	ifndef NO_PTHREADS
 	ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
+	FSMONITOR_OS_SETTINGS = darwin
 	endif
 	endif
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 16705da2000..b8f9f7a0388 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -295,6 +295,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
+
+		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
 	endif()
 endif()
 
-- 
gitgitgadget

