Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6359C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiEWUNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiEWUNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AB8CB05
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i82-20020a1c3b55000000b00397391910d5so233952wma.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=M9wwwy5psJJ7V2CvckoTDDN6Yw+sL//RAX5KpNDYfbym+P0iR4JsfOm/3MLUbQHVjj
         k/NOYLsCQjQ+AAgM39RPleTa+4xbZGSWBmSqIxF2P8CaCuB+xxGszr9TAXL3naIokcnZ
         en9TBmk/brCjHBL4qasgv/WKMXM/1HGPfgxhi44EOR/rBpUDCGb0fIPKD5QUtLtTug8d
         a4d4hWQqFOE2GxdCxbyOPt/LMu3rg79SRM45t7i6eK4GoCZBd8joO9FgZNn0ZW2hOh5J
         BnygWEzOHvEKON7mTB/qCS74QH5DxSSq/9PG7KnKQ4wrk1JsLyt9nqlVq18c8iWxQIad
         iiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=FvtbvPZ48iCdtdh3BEwsLKWwQ1ql30Wq5/39f4RzAjrOTKefF+vjZmoY8h+lFbXnlA
         MXgJq7ucd/JQjBQqD/aMUV4qcECocNFOzGlgBA4j11UD7juTZbUbvULGVpByV/mRDmB3
         u4yjQEiVHjaJiBd2iiQ4bhhoIut8waDYB8sITulG3R3g7fqLwKP5GjrVtozCULkNibfe
         CkBxB001wTsY5MhiQYnC2roJEwrD6RPlKtZzDDCzgiL0OLoFgyUUED9OkuzSwP8T+8SP
         gA1FK03DpGbCg7tvbyWKywnNLfaxvyvGA+GlD65rkiwUIHpk84Fa5csdaaZZM8ispn3U
         3LlA==
X-Gm-Message-State: AOAM530LES0wayOIBD7IEfkKuvtYZMK8snIQ9knGHbyVKWS6NQKa7lZ5
        CuWXWMApwcwkjE80hufT9TiCAZNaZqA=
X-Google-Smtp-Source: ABdhPJwHT88zhM8riRSRrBfMRBrT8h7G8d2X8bgdVLy6F9iVSMK/WtD2ZVSshZQ89TTGILwqesbGqA==
X-Received: by 2002:a05:600c:511a:b0:397:50b9:f5be with SMTP id o26-20020a05600c511a00b0039750b9f5bemr647767wms.188.1653336779215;
        Mon, 23 May 2022 13:12:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020adfaa4b000000b0020fc6590a12sm6219733wrd.41.2022.05.23.13.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:58 -0700 (PDT)
Message-Id: <f7ef7dcffc88f95dcf8fbca4d6e24648d52152c7.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:22 +0000
Subject: [PATCH v7 07/30] fsmonitor-settings: stub in macOS-specific
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

