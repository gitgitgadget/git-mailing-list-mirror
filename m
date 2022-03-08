Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4319EC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350666AbiCHWQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350648AbiCHWQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44B57485
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k24so244570wrd.7
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=X7T/uH16BNRrhwq1p9PPN+g62AYM7KW/USnueA3FV6MgzlYBG+pTyEN5SKuzJO8T/4
         CaBoLbWJuJB06sIs97CxGnXyjknnFDNCaL16i8Ujyi1CZyCMsM1EkOsqq3lkbiBEp41t
         LDLv5cls07zeuBDPbmR7lv4tCK6xnnyk7r7WHKtorjddyUBTWZ9uycjZmyX6qBqfFRK9
         FiXbPUZPesdYyBcQj1eiOkdg4PjnuSfcCAmuhSq3hjzM86Rk7+Mo5XcunHnO86czxs2t
         rqAuQpwUYyCWxHTz4zUMQY/8rClPuvkQPPdUlQKUwc5GZ9XEv9cxjC3x6W0RzGo2JhHQ
         kHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=lOMW9ApCLq+KWLGBg1LVbrmVagoCRlTH9Vc5Orp9hJ3Ig2sYRjIFA3LbbC42cKh6an
         YHgJTHOAX1w8ejYJWTM7Vvvx8VhkFAFx5KpIJ64Uu89CaIv8UhfKSSIldWkOCjdyQiFA
         SpgfSDLE6LuHKymZAUbq0E4B9SRAXO/EvYKKK3Tbey0QefktiGj9jzK065iz2E+31sZo
         +MHFIhzKE+36pW+dXBSfXqovkkthSNVRJ7uhQub8+19wHk1VIxVSTA5+ScDT5ONOx+Mh
         LbnEIcW/mp/68yMIODcdo64I+K5nMoef8/1pWdQE0kiJ5ZVcHzoGp0fAKHyCTHjq+g9i
         kKGA==
X-Gm-Message-State: AOAM533QiBqWNpK0Ln5xqv7YyEaiHa0PWlTLHyNNlE9emOvf/HsBRbTT
        C0YTs9UITPQyyBdJNy03Vxc5z9mijgk=
X-Google-Smtp-Source: ABdhPJxujSQJfLLUhgLULefnd2D/nuO3yrcwfsA0XeejcD3l9MhYptwoh24K4hfNvF+ggZ0pCiHm5Q==
X-Received: by 2002:a05:6000:186d:b0:1e8:49fc:69ce with SMTP id d13-20020a056000186d00b001e849fc69cemr13801476wri.80.1646777737792;
        Tue, 08 Mar 2022 14:15:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm89942wrv.79.2022.03.08.14.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:37 -0800 (PST)
Message-Id: <c1802410410b5de3fb9037cfe6e2bb073d53feca.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:07 +0000
Subject: [PATCH v2 07/27] fsmonitor-settings: stub in macOS-specific
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

