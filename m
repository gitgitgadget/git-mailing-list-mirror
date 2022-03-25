Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB2C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiCYTeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiCYTdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C4199532
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q20so4976949wmq.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=a+oVr66FK/2EZrWnjOdpNbe4cugLjbu7MslzyO6DxNXWvclfXh2zXTE91LGQGBQGwg
         THNN/QJe9xGToPqkU/UNmih+Hole0MvGqFsGoMrrvNsFa/1pOJPqIah8xM2q4T/aTwiz
         eBbyxPPNIzkKEth98YQSbT34XswvirmhDyKaU24DwvXeVYm65meEQuDTIoKjyHRAhg8h
         PciHT8BsQUeV2xjUw6Ytg/N4sf89nA+ZhvHQwinvuD7zUF542rFrlMR23Ra4zugjG2r7
         MqJVqw0UvNkiVDCwNn2KilObdjLiya9UT8omBwMBgFQkD72ITPOvGn0zuDqhOy8COsIE
         TFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JoyUcWYc53GOiCIk4ZkiWSvvHTSDt24PFwNxe1AnEQQ=;
        b=Oszt/xUrN9KosE/jLOJT47JW5ptUcqMCu5a0y5zEJc8bIWozrsYV1u2gyfSzlH5x6t
         +eZ35TwdZr4PH5HHq5QkyEr+TLDISPJib0Y4GkB0v2/D3nqFfz1wGtfZuZbTk63Zjqsl
         kj5qjCqgh3Po6DkDZ3jJn3pamAa96+MaCEkSlPHzyLxT0lN+AgLVK5hNCBkuA6INzfFE
         ys+v0EAP+Y8XVHoYU55+mjWPPZ9sPKnYpAW7iy6WK+gdnGG47HtpxGvBAHiIrsEy1Lab
         gA+yWIpM2JUyu4OaA+ZzHT/qJD4CYqyprYoeoBYflnxfCpjcZH1o3FIgT3QK3NErA/j1
         /kpg==
X-Gm-Message-State: AOAM530JPUH7iqwyJrhpn+dM/snoD1CqsHb4iDDkKubbCHyebrNMu2Mz
        wq9FiBc974MMcA4KM8VMWBAr/XIPW7Y=
X-Google-Smtp-Source: ABdhPJzwrH7lH6upRV1rXL68wjFMqse0jBButbnfscWzr/qeh/NY74vDtgkodEGusuJRX+los3A9hQ==
X-Received: by 2002:a05:600c:3b02:b0:38c:9148:70dc with SMTP id m2-20020a05600c3b0200b0038c914870dcmr11123419wms.104.1648231405106;
        Fri, 25 Mar 2022 11:03:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0038c8dbdc1a3sm4839917wmg.38.2022.03.25.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:24 -0700 (PDT)
Message-Id: <2f8a42fdb93623053256939fdbb45cf02fb1c5c9.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:52 +0000
Subject: [PATCH v9 09/30] compat/fsmonitor/fsm-listen-darwin: stub in backend
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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

