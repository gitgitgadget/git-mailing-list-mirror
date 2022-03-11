Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FFC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiCKWxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiCKWx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:53:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7272E3F2F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:29:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so21943779eje.10
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dkGBAIS2EimFjxXEvG/szjFqlEyS6PQw6zXKMdIxz1c=;
        b=lWYQuu/6phhjDi0VosrhjDc4juAXJoQytMa9Jyg3r+VWqSCHk4mCna5m8oztkXH4+F
         q8vAlL0NZAHCbBa5yyF2XDHr1reG6u0yEqX8Sh42F8zDURVtKv2IAOy3lG4Qw8zp3GWd
         xnJyXXDHBUZCvCgyqgLHEryC1uUxyh844y7xMVm1Sh+AuDOACp1TKTifc1koshTyCSfO
         iu9/yQ6a0QK0sTw3nsb+O8+fbyHK3I8UXa1D6U9ZdJsBa5Sd+oSxgzuSErB7uRcqIh/Y
         ndpkjnj0wcxIBxQSWZieeDZysbdq4PuH0VODYuy3/1NBp9IiAzbEL2oONPiMEZCwtTkK
         FUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dkGBAIS2EimFjxXEvG/szjFqlEyS6PQw6zXKMdIxz1c=;
        b=6s1DLl/HS1jgOZ0GBsNQiSoC8Q4pavIS9UluSMtjryOzNe7UqjFQnMlRtA+DVV2smI
         M0UhJ9fZ3D5PmJWjGNRAj4mDxdOric8LL49KkBWN14sVicu8byt5ccPLjH4e+dAz/n0b
         1HKdZkSFeb/Jzh28ZP77bKhiIH4lflg6TnbUTWV/X6PuPtqK4dt3BghT9XNnYIg6M0qe
         pSbY3s2o1eZs5lJSVp+iNjG9UrykJQHQtM2aqKmCN5423hO2oVCkYO19g6IhJX63AtSm
         I67Tl8Mn/jcbaM3IILoU0lxgxeo8KQXU0Qv7OQXVfv24hqWzUg72Menh8m/UrOKAjgxW
         qruA==
X-Gm-Message-State: AOAM530b2/Oi/xcGZIp/90ue8gqd/Vs86v5AMXKKpSWN+K2OcqS/NJSD
        6veL+BxgzeyQBYFd8Nva/mWFmfJr77U=
X-Google-Smtp-Source: ABdhPJwmNwcYBJd7MVO1q185eG2rZWk02pcAmZdyNzkbY4jzcl+1oVkH4pOzNnhcOOZ9BEHyV91oMg==
X-Received: by 2002:a05:6000:12cf:b0:1f0:6875:9577 with SMTP id l15-20020a05600012cf00b001f068759577mr8400562wrx.304.1647033309908;
        Fri, 11 Mar 2022 13:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7851476wmb.22.2022.03.11.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:09 -0800 (PST)
Message-Id: <3482fb79a517d4703b5aa888a8c3d4890d034cf7.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:54 +0000
Subject: [PATCH 07/16] t/perf/p7519: cleanup coding style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! t/perf/p7519: add fsmonitor--daemon test cases

Add "_hook" to name of shell function to set up for Watchman/hook test runs.

Fix code style of added "if then".

Add body of builtin test to a test_expect_success.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5f97edf6a11..7a7981b0e61 100755
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
@@ -182,8 +182,7 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite () {
-	if test -n "$USE_FSMONITOR_DAEMON"
-	then
+	if test -n "$USE_FSMONITOR_DAEMON"; then
 		DESC="builtin fsmonitor--daemon"
 	elif test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
@@ -264,11 +263,11 @@ test_fsmonitor_suite () {
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
 
@@ -306,13 +305,15 @@ if test_have_prereq FSMONITOR_DAEMON
 then
 	USE_FSMONITOR_DAEMON=t
 
-	trace_start fsmonitor--daemon--server
-	git fsmonitor--daemon start
+	test_expect_success "setup for builtin fsmonitor" '
+		trace_start fsmonitor--daemon--server &&
+		git fsmonitor--daemon start &&
 
-	trace_start fsmonitor--daemon--client
+		trace_start fsmonitor--daemon--client &&
 
-	git config core.fsmonitor true
-	git update-index --fsmonitor
+		git config core.fsmonitor true &&
+		git update-index --fsmonitor
+	'
 
 	test_fsmonitor_suite
 
-- 
gitgitgadget

