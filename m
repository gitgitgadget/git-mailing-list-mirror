Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8951C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351881AbiCXQwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351852AbiCXQvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B88B0A46
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r7so3102296wmq.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=FgUe45bFHOgWcirMC8JGwDfig9kQ1bdgkUMClFx6A4erJUiO7KLYyT3DAOuY6P44kV
         cIkHqoOo5qBll4eNYM3OI14JuWnHtFqqD6iI02ipefszGOpRZTlgDkEqTk4qu5VnpOnM
         BNXIRC4KVSS847lVDYUI9XNiAPVRL4X4wEKKgDdWYNGeeRCLOvtuTehK6FtmrO7DW3di
         Jjd1rJLkjSja56pBprHkisA/SXcDDYWiW18VYj7KLKuPHV6icbousPcFOU4SFf7HdShp
         Ahmp/4jeCwc7dtXMjqOpN/pOT5qDEszkk5uPL1slwxraseN8NSyuQ104y2yf4+VRhiGW
         7N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=4RaE6ZyzxEdfAY+MMDEamqZKDAubUY13mdpuJgHslObufUApMsE7Q+t2xu88LSIYgK
         LRN+Kayb1JtkGBJxou93VDmSC4VxxmodO9EGYXiHHzAWzRmXz/MGeOLKPj0kTk0NPuaa
         a9XWM5YhExkAgLx2PxoeXtGyhJcO0q2H4tKfz+tlny2j6WSiQ1K1RxNqRKJjetMyvU91
         tHFzsn2JoIsFYCvm5qWYYKjabBdkDmomHQU00jG3JD42ctP1I73dTCOBzx09ytRzOt+P
         ZdHMX2Ak6iVPF+MZiEmtLYofb/yZdJHugAyjUkr8CnemE/2g1KYGsiRCI3Qs+p7nf7k5
         nd9A==
X-Gm-Message-State: AOAM533wjdoVO/j5R4o81ZG+Ariy2U7oKZNJZI4RijLLyznaAtLfQkP/
        e+XawQvJEmrgF9sudWpDD89HMYf7Zrk=
X-Google-Smtp-Source: ABdhPJxyH5Jb5V/gPact6EZKh5Otu8QUmgPc94kqOCUea9TwUAgpXConZrk0SjCvM6JsCQyljcFXcA==
X-Received: by 2002:a05:600c:3d8d:b0:38c:6f6e:e61a with SMTP id bi13-20020a05600c3d8d00b0038c6f6ee61amr14703330wmb.101.1648140600206;
        Thu, 24 Mar 2022 09:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm5733306wmq.41.2022.03.24.09.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:49:59 -0700 (PDT)
Message-Id: <2f8a42fdb93623053256939fdbb45cf02fb1c5c9.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:25 +0000
Subject: [PATCH v8 09/30] compat/fsmonitor/fsm-listen-darwin: stub in backend
 for Darwin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty implementation of fsmonitor--daemon
backend for Darwin (aka MacOS).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 20 ++++++++++++++++++++
 config.mak.uname                     | 10 ++++++++++
 contrib/buildsystems/CMakeLists.txt  |  3 +++
 3 files changed, 33 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-listen-darwin.c

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
new file mode 100644
index 00000000000..c84e3344ab9
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -0,0 +1,20 @@
+#include "cache.h"
+#include "fsmonitor.h"
+#include "fsm-listen.h"
+
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	return -1;
+}
+
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsm_listen__loop(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/config.mak.uname b/config.mak.uname
index 26074f56bed..501970902da 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -157,6 +157,16 @@ ifeq ($(uname_S),Darwin)
 			MSGFMT = /usr/local/opt/gettext/bin/msgfmt
 		endif
 	endif
+
+	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
+	# Unix domain sockets and PThreads.
+	ifndef NO_PTHREADS
+	ifndef NO_UNIX_SOCKETS
+	FSMONITOR_DAEMON_BACKEND = darwin
+	endif
+	endif
+
+	BASIC_LDFLAGS += -framework CoreServices
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0963629db7f..ee0d7257b77 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -289,6 +289,9 @@ if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
 		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
 	endif()
 endif()
 
-- 
gitgitgadget

