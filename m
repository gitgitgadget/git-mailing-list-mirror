Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C148C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiCVSZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbiCVSY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F78F997
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so9595359wrr.9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=Fep8wKJi05oR1j2xfKPO4QQpP5vwL62wvm8weTkIToGEgq8KQtFR2O3q1UQmU3jCEF
         FbJyJswonHTOhFgiwzVTVFT7ckQutklclENrY4rAlZlqZoNKfxPb7U74djN1/B4p6dXo
         Q6FJSkQJOOx2NNG9yqHEhvs1tIOTG2C4zFyGP893qCP6dNL0jSmfSJkt2O5AeqKwd7Iz
         Gh1uHfLLPmeRr7pttmNbpT522lxQeMHBY6VMbMMmjA50qeuiojOuTdBQXCisTBhP1dVt
         19BiBjUXp6WiN1wzbyGcBMlTMIlp9Ck8EZlwuHdNvXeFTmGJ+nhoNLzHYBtDTOioVLxU
         1S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9iru4da4j21im3N2Gig/H0t8AHc+fLOds26HUAcaQ6U=;
        b=M+BwpB2+rvcbIhjbxICPZll+HSN+DS4Qkfxapk3UDNQ59pasUy/cKEk19icfJnrpj6
         KnrYW1GXzhU3ppO+V7jMZINt84nzgWKxxW6S0OzNbn7ggkPA0bgXs3FIpb9Z6250BVIU
         1QJVluF62rGd1gAKcUn1xSsLD6cD4epCqSXBlEcH7OVsYzBdt4u8BfGggtO3ddi0aKjf
         6AHZVftsDFRl1OPfghAJUgHvtQOVbt4bUGAVDuEBCfjYeD73TSGxgr3rw1iEQmppQ8mp
         2gxQIbP1+MJWW3/T2W5uDn7uZK5JOsxtTSWunfiU+TbKL9BvvYNjmQiO3yFMgkgb7aw9
         xCxw==
X-Gm-Message-State: AOAM530lXYa3PN4Ny7U7eYX4bBH7iJxV7BQsgeKc5/7X/41/2ak3j8kN
        z2SMX3Fgml9EJQOYt7155UEEK9R1izA=
X-Google-Smtp-Source: ABdhPJxLahBXJD9USo9eQCchUaAXs2kghFaP9AvOhQwKWHFujSg9DxGZ3a5F7/Iz7d4QFqSzy8CH/g==
X-Received: by 2002:adf:8003:0:b0:1f1:d81b:d752 with SMTP id 3-20020adf8003000000b001f1d81bd752mr23275906wrk.429.1647973400144;
        Tue, 22 Mar 2022 11:23:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b00203e5c9aa09sm22556221wrf.27.2022.03.22.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:18 -0700 (PDT)
Message-Id: <1d2877efda0fce9103598ad92c2cf7d618bb72a0.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:40 +0000
Subject: [PATCH v3 07/27] fsmonitor-settings: stub in macOS-specific
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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

