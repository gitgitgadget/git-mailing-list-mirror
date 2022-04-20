Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F68C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382166AbiDTUq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382137AbiDTUqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C03E38D8D
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x18so3896749wrc.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=Xd3T1wtfrkOobolx0CZMbgpl6r/AExFm+3TfWFlIWLetI/bVBWr9ga85j5gVYwAr46
         T5vos5qt6TA/QoHwSvOl+MmZgWZgZEa3M1QDI7b/em8rHqRygxCqOPsL3vGm6e1smMQ1
         F3JFOdF6fRrKUE1PlzVsdI17Do46G0UZkRjkt1+LqAgWvFU38aoo+aUKf3YIaQcqPQrE
         PNqK5e74eWSoUS782X3FlEg+Yw5Qv9Zm2SMoKL0bJrtMO+Cf+4Zu0PCLbtnaWbo0gnxl
         nvGbFNRTyJkgaU86QwQyhgkkEG9gGpdgGtR0tbmHN6otwaM1G5rqNyOzynV7jkq9yWlN
         18eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=dQBLh0BsNFRpTMKO806aYfELt3aWRZIPvFwqyT6II2H66ZE5Bbn+5Cu11ud/FWXF+d
         LrMpQmg6/CQNBHmfEmzoBQghrPr/1bzZqFHXUqWI3hADGyZJKomNUn7iwER643XwmXBQ
         5U87c7syMnaqqsPlMA2a0+8L3csRH2+SMyS1+XsMEFBTeXuZjDf83SmdUhdFfPcPSfGk
         fmN/1jHtDDmjcnE2pUEDW4z4WErWAyg541SzOS1F3lmrPDppAqdU6fycSqUhkTlnPYI/
         5qYNv4UXiu+5SoliNq3pZ8avBcN29KPlZ3IY66OOO78bZWgHFEdx9kduiYZyIEDoIDhm
         8CFg==
X-Gm-Message-State: AOAM532le0ViVWnz48LDwlGocG5EA/XZqNcVy2bZ1EScnOrkWrqTosBt
        yhP7UL5h2a0qpCxZ7kYYLsUaiTy5RRY=
X-Google-Smtp-Source: ABdhPJwpEdgoYm+ZlgBdDSYSSbJ9Q2kP9IhMAmwwVxbq31o36b1ZUYqJr4TgMyt731qvJCusQ9YjwA==
X-Received: by 2002:a5d:4ec1:0:b0:207:b1c0:a417 with SMTP id s1-20020a5d4ec1000000b00207b1c0a417mr16390232wrv.561.1650487410501;
        Wed, 20 Apr 2022 13:43:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6091000000b00207a89b952asm648193wrt.77.2022.04.20.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:30 -0700 (PDT)
Message-Id: <94ae2e424f183344a19c76cc5bb481b64be3f31f.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:57 +0000
Subject: [PATCH v5 07/28] fsmonitor-settings: stub in macOS-specific
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

