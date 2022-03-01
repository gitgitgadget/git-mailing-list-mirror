Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C643C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiCASpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiCASo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2F41F9C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e10so4375801wro.13
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=Gn8eIb7NmGyFDyWQ/XWLPVed/s0afzP+fhZ1iM9UB71jgkOGZ0dWCqSbOJtfUMf9H9
         W036ZU423wiwi+zrLEsbfg60u2gkezKbCpQJaSVBvDIHR9ndqLxBi8rjQ54WrJR4rajR
         IeSWUh2ofvb/y6MsjxwadQWNmtHBIP16hq0Ypt6FN/veIkTRdRYXtI3e3woXz6k355SE
         drXV5L3MnCIAhhogjHJ+eT2znLnE7j9O9zyERTsPv4wIsuYguSoPuV1ur+xIqLsXhO6v
         HYqoN4Eysk5V5bANjxs8unxyjX9d2eG+ZIUDNpMsXfC27DJ+eIYeCTbORYXQxGrimMLF
         eDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=cw8Jqeqq8VykJss+TpuSbVS1734BIuyttQsgBqpv2YFoKkKQ9369vd3fH7SNGa1GUS
         k0xC5WbDYe+b+4QDcsSJdA3oDL7Y9ViPuHug+9mrWCMNK4fEpNKH+cRADByCpewGe1Oh
         XMDohPTrmvLoCjq9wXgfX3UWkudJ1kB56gRq1q/xHPsb1sBcYTFndNN4/Dvo6okwVwXS
         BFababazppjFED3SWXraJU415z6PIrhqLAUfqK1YGEn9Lrock2XDdADhtQhSET99miMz
         OIYT4Oc9y1pFvaG8SUV8Z6NxBJgkdxYqcJFBn2h80ik4Amz+wu3x5AieH9EydP1F+lDc
         UHxA==
X-Gm-Message-State: AOAM532nWMNx/mSX0DegKH28azWGr2lAqDJQvhZPyUyzFK9e1Ah1usze
        SFE+md7tXx2NMQJov6ldeXWC3FSHDeI=
X-Google-Smtp-Source: ABdhPJyogS5+YIYV+QhYlNVc60aFvkeeF8tti8/bBAe0GVCEoQxnVVKdQH3/U9aR4Igkr1KF742SdQ==
X-Received: by 2002:a5d:4a0c:0:b0:1ef:5a8d:efe5 with SMTP id m12-20020a5d4a0c000000b001ef5a8defe5mr18266491wrq.354.1646160222486;
        Tue, 01 Mar 2022 10:43:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b00381614e5b60sm3589591wmq.34.2022.03.01.10.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:42 -0800 (PST)
Message-Id: <f12192212702b2ee4543b666136143cf18522a3a.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:11 +0000
Subject: [PATCH v6 09/30] compat/fsmonitor/fsm-listen-darwin: stub in backend
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

