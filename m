Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F91C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiCVSDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiCVSDF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:03:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACEC694A3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so23549004wru.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9JSDLi5Gp1X8rRCImQhlLxXUzakXhemwEeFJsqwHKJ8=;
        b=VDeOxQgcTqa7AdlmiiMIFiZ8wiGav4Dl+UG3ZEBLwRIWSN9Q/iySYpvlCE+XaQjOw0
         QkNkB5CtbJr4hIvd+oLVIW63m01xYz8PP+5yDhQ/Eo4sw1UYYGMwthu2ZLCRBS56fWxy
         4D05WP6mJlygAoaaB+2xfCMRM1GG8HGo5ZydxG4Sv4eXusk9Ck5zx82ivIHiQt4RWRuT
         gZwChbQXjcdNj9ub76x02Hegzx/chm9e4l2cuzPoaqcWcv6TJ6eMRHBUplyZml2boO/F
         0MkXsW0FSUe5wkVJ0tEVoyUXAVh60gkz9xHdaeHOggSdCrn/DU77y90nX2JcBWUtGZK9
         V0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9JSDLi5Gp1X8rRCImQhlLxXUzakXhemwEeFJsqwHKJ8=;
        b=FD/ag/0efVK1PkOcHLtjo2gBNa+ddHndu/nb+0iUSfBcJaAfyawmUfj6bubqHokKEm
         QXU8m9W9ksf3dRKN4sRJRyJEN96uQb1Vhl/zuZ5CyqzNlJs66OeE7wcwFErqyNO1ZnGc
         8AykpvcPY/TViaLkm4IAv/27HYOsuBMO3VvMjs0g5XAisH/Bkd5yk2Jvp4JGmIF9q0dr
         exHFcjTUj9SiBwrn2E2Bw4bpVJgp7OP8JVKvtkFFV7eVKoJwWHnkEn6PIM2MViVPDD3l
         fr51FvrnU+t0qfTQl8s/wrkn2iScnnnlL1FvvN+T7ExW9RAHbIodb24GDWjU+1ePiRv9
         suHQ==
X-Gm-Message-State: AOAM531RNAcQA++wkjEa3BuncVzclW3mhdocmVdzwG3RWs+aErPa/i+O
        0pQGeqDxMh3VUMr5Ck+b6OBOohM30gE=
X-Google-Smtp-Source: ABdhPJy1gjd8im/Ob7ld2tnmG5lt0FVd6WL2yfqSvqq5H/fJFoFAw9EVYrejKrE7LGR1Ksxzo4768w==
X-Received: by 2002:adf:efd2:0:b0:203:db42:c56c with SMTP id i18-20020adfefd2000000b00203db42c56cmr23596772wrp.698.1647972053101;
        Tue, 22 Mar 2022 11:00:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10-20020a056000144a00b00203df06cf9bsm16820656wrx.106.2022.03.22.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:51 -0700 (PDT)
Message-Id: <d5ca2df31c835ab802b6ebfb26685449bfb0e9f2.1647972011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:06 +0000
Subject: [PATCH v7 25/29] t/perf/p7519: add fsmonitor--daemon test cases
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

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/perf/p7519-fsmonitor.sh | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 0611e533951..3b232e386b9 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -141,7 +141,7 @@ test_expect_success "one time repo setup" '
 	fi
 '
 
-setup_for_fsmonitor () {
+setup_for_fsmonitor_hook () {
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$INTEGRATION_PATH"
 	then
@@ -182,7 +182,11 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite () {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"
+	then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -261,11 +265,11 @@ test_fsmonitor_suite () {
 trace_start fsmonitor-watchman
 if test -n "$GIT_PERF_7519_FSMONITOR"; then
 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
-		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
+		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor_hook'
 		test_fsmonitor_suite
 	done
 else
-	test_expect_success "setup for fsmonitor" 'setup_for_fsmonitor'
+	test_expect_success "setup for fsmonitor hook" 'setup_for_fsmonitor_hook'
 	test_fsmonitor_suite
 fi
 
@@ -293,4 +297,30 @@ test_expect_success "setup without fsmonitor" '
 test_fsmonitor_suite
 trace_stop
 
+#
+# Run a full set of perf tests using the built-in fsmonitor--daemon.
+# It does not use the Hook API, so it has a different setup.
+# Explicitly start the daemon here and before we start client commands
+# so that we can later add custom tracing.
+#
+if test_have_prereq FSMONITOR_DAEMON
+then
+	USE_FSMONITOR_DAEMON=t
+
+	test_expect_success "setup for builtin fsmonitor" '
+		trace_start fsmonitor--daemon--server &&
+		git fsmonitor--daemon start &&
+
+		trace_start fsmonitor--daemon--client &&
+
+		git config core.fsmonitor true &&
+		git update-index --fsmonitor
+	'
+
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget

