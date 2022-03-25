Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D02C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiCYTlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiCYThx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2611FDFEA
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a1so12082337wrh.10
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6IMoORViExxPGOqXM0jiWHBPtgaquTlkmrPOCTiquVM=;
        b=a03UnjZf1EDHR2ilcfsWF/9iYP/4LOm5hqTOC0MQVRNBkjZR/r45lPQw2LJjHYnNre
         zMagfivtjPP0GWz8f0VF5HWJq3WgonGaPCyiUmNX3YJOY9jAMOZRQvPy7ivzxNbkfq7T
         JEc2ECc1OZ6J2Zq2I2VAT4VzSdN5E7EClGMoJvSbGNyTfG67MxpEbDBT3+43I7TGQsQK
         nPRbmx+9DBCRIR6FKMLxegxHt3AD9ZVELnZkL0yYmrB/EMcfmd4NVEBzbOo6LFkWpwx8
         yA6xwjBf/Tazwu0Z3ZYb40wZ0/JHEu9uXb+3gQefwYoNkFKFlv6UYOF7laGGf0sK1vWA
         I9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6IMoORViExxPGOqXM0jiWHBPtgaquTlkmrPOCTiquVM=;
        b=KWkLmWEMet8WGeYc+661KtkHNMpdDu2Fg1EN4r+GfiDe7Oog3lEwemFFMpXTMqhY9e
         yCFuFwefTgdJMFvBYS2l8EdbBC8DgEOAITlcOPW1cmwwbh6lmyEk716m9Wct3HCZseq5
         IVSUL018WpgzUj8RYn7Qi3ltEeJPGmZ+uanH/Q01Yzsg+j/O2IyyAOWH1GVeTsp+0FQ2
         MGHF4qF3SJxXGEkD3mjbezXFMrucUN3PZupLqJuIEaWJc/+mhA5cEsznTOBDiJ8OR2QD
         hWneWFq15Sus1CxqtS6Aldj78c+WsXnp/no+YI/2NVgbjNswRklEjEmCj4ybt81c9b29
         Pedg==
X-Gm-Message-State: AOAM533pac9bbXz/uZUijBNnqu2FkO2QgfqGP6vnP67N3qhfAX/zagrU
        j0CsQ5axPnJW/KrjqxL3ZZSH1PvfzWU=
X-Google-Smtp-Source: ABdhPJzYb/b+jtV9oLWyBt693l7Fojn3Np1Vt7Bg/zzZoA/ppsx1j4z9zj66nCR6GglxkD16FvGODA==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr9896774wrc.294.1648231416166;
        Fri, 25 Mar 2022 11:03:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm5574119wrv.10.2022.03.25.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:35 -0700 (PDT)
Message-Id: <ed338777b561ca7c2bb6753b0408da7ea3a64435.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:02 +0000
Subject: [PATCH v9 19/30] help: include fsmonitor--daemon feature flag in
 version info
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

Add the "feature: fsmonitor--daemon" message to the output of
`git version --build-options`.

The builtin FSMonitor is only available on certain platforms and
even then only when certain Makefile flags are enabled, so print
a message in the verbose version output when it is available.

This can be used by test scripts for prereq testing.  Granted, tests
could just try `git fsmonitor--daemon status` and look for a 128 exit
code or grep for a "not supported" message on stderr, but these
methods are rather obscure.

The main advantage is that the feature message will automatically
appear in bug reports and other support requests.

This concept was also used during the development of Scalar for
similar reasons.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 help.c        | 4 ++++
 t/test-lib.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/help.c b/help.c
index 71444906ddf..9112a51e84b 100644
--- a/help.c
+++ b/help.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "prompt.h"
+#include "fsmonitor-ipc.h"
 
 struct category_description {
 	uint32_t category;
@@ -695,6 +696,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+
+		if (fsmonitor_ipc__is_supported())
+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 	}
 }
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b867..5d819c1bc11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1799,3 +1799,10 @@ test_lazy_prereq SHA1 '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+
+# Does this platform support `git fsmonitor--daemon`
+#
+test_lazy_prereq FSMONITOR_DAEMON '
+	git version --build-options >output &&
+	grep "feature: fsmonitor--daemon" output
+'
-- 
gitgitgadget

