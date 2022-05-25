Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D86C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiEYPCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244948AbiEYPBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E426EE
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s28so30367568wrb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=PRw8FPAivf1H20GHcN+EjZvkU8FPOATe/G+l6/KMwT73zmNiBQz3pAWPKlFZbsFg7h
         dIuUwnfWLRF5/AispLRMYYReBvSbRU8n9k/dLWayKzpd7wYoRSfbvso9PWCb5nwLEf/1
         qvp43xmZYe3fQgyX/G4uNRV79meJROkcYEMJ2aiwBBtPqc+E9sdl7E67VKTk3Diuk9/k
         kKQ82/YLyfTBcWAVCIW79NWF/dyd6cdNYLK00Wp5mvq4Ky9KonUs/0/yPyHa9+XWPUyX
         uJYwGNLcxf3zlVhRKkQyF4Qb7gQ333sjepOQoBovo0VyQhvtskd7M9lDJJtoLU6m/IrD
         J9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=lVmI7jmFpHFRzXYNvsjedrZOs2T5bmQWsJR0sSyCIStXdmXUD/+bKlrK7iFy5sYcKW
         dudQ/jwEScG4PIbEa7y6pDw2ANciAT+27OlQHoUd9gBOsi3jJe0ynE5YfMKxzQwGbVle
         LHerlgym17w+sFUyUidOwrzLRD9VQl9VVBixco7dfbsWGUaxrUmyXd6myRlSl0nU3VlZ
         R6TL/4osxYYVtAHSTD6WKqr+PL5og4k1A33ynWQFi9VHb2ouyh7NYYB46MjcqHpJRkjG
         sMet4uyiGF3EDdRMgfj/SPoV+XR4dM5tquKl3V/aTpTesrTknp2Nrt4B+bTYl/EStg/G
         YSxA==
X-Gm-Message-State: AOAM531uGLx7E6XgEBeu8JLk0zOD66o4zqUIuJLBa2J06XaoTASrmTrc
        MrMBmt1IA/3zLU/eRpClSaqOZ6OFMfU=
X-Google-Smtp-Source: ABdhPJxgTXEqxwlskRL1ezfQiysne7q+kvSz70GopOw2SVgkMKlji7fjn2Zm/WJ0w8ZDp4LW1ccoHg==
X-Received: by 2002:a5d:5955:0:b0:20d:4b4:9879 with SMTP id e21-20020a5d5955000000b0020d04b49879mr26800300wri.550.1653490866158;
        Wed, 25 May 2022 08:01:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d55c7000000b0020c5253d8d3sm2278543wrw.31.2022.05.25.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:05 -0700 (PDT)
Message-Id: <f7ef7dcffc88f95dcf8fbca4d6e24648d52152c7.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:29 +0000
Subject: [PATCH v8 07/30] fsmonitor-settings: stub in macOS-specific
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

