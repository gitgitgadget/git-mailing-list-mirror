Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A2CC433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351934AbiCXQx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351890AbiCXQwf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11156B0D15
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t11so7483191wrm.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i8AAWLIhTvBsJbUUWF9sVC+yslqp1BHv6rf37oWZ/I8=;
        b=V1gVCkGeD89v9isoXoq3Xuzc/HamSUW+ji8yDVOugWNPWatcXRP4jXkdEqq2ujftlL
         0B14o3vnZsIAYejBwyCcbA0nO64/axzIbR6MQTWsUosHLX3xbA9BQVf7TQgKxbCfHJEw
         gZY1moB3IrDVDESUOqCFGG5TS5mWoRm0t4P1e4IhEWAr+tR6aeWo88nlDtHuCWkhFx1I
         u9xH0CWQcwccF2fWyvnamONrPTeD3tUzt1TSXzBQfelQ6elRZZksNd+HpFyGJljmcrtz
         C8XZ/kjPhHMxDJJt0BXXY9I+wSZxkNASLdTrO2oWt+4wwkfAKNr5hG0eWgQzoO2mLVFg
         FZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i8AAWLIhTvBsJbUUWF9sVC+yslqp1BHv6rf37oWZ/I8=;
        b=NXyqDfgoOIu+h/fFe9ve1oUBKtsZOyDGbWwl9+31P1jv3ezjKxcA+kY+WaWDPYujYR
         P3a/ifBMwdbp6yq0MqpaO/fiaR5774DTfYwY4d2nBA5c7v3++JxAyklEhB+L+m7Obx+i
         Re0HUo5fG5GJbSPw2f9/1AZ3bBK+SFgwl8MtloaVzMtRW4uy8r7YyVR3D0tjLd0fAtZi
         TDSKLvix5JndEGQ6JwxHOUks/iQ5KSiK8tvKMdMN/EM6PF1fpLWfCk0Z3fbVNp2rOiR7
         Hy686hH98KnJDodQunWAzkC8xXWT56GVvkKNMI3Ve1l5HFZqHJLT25UO9dnha3pqHKwf
         QqJQ==
X-Gm-Message-State: AOAM530wzZW+8G8MUuPmPXeMZ5hXxhcywWDLMo8Ty4c9bzpESB29i7Vo
        vUyttKHo4P9eMfZujkED/LFm/nEDsNM=
X-Google-Smtp-Source: ABdhPJygtF3KVlvZ+TRBfixoZ8wlE+tJTGjCukYj7rsZxwpNNuAA+DvuzuoQRhnuhzbuM2JDYreJ9g==
X-Received: by 2002:a05:6000:1d2:b0:204:7fc:d6c1 with SMTP id t18-20020a05600001d200b0020407fcd6c1mr5232496wrx.367.1648140621224;
        Thu, 24 Mar 2022 09:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d6d8d000000b00203d77cf7b0sm3484987wrs.74.2022.03.24.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:20 -0700 (PDT)
Message-Id: <6eaa5765ae1cb24e1beff465a374a14d2ede16a0.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:42 +0000
Subject: [PATCH v8 26/30] t/perf/p7519: add fsmonitor--daemon test cases
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
index a6c2a910e70..0b9129ca7bc 100755
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

