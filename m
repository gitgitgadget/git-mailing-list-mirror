Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80681C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbiCASpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiCASo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA066213
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a13-20020a05600c348d00b0038188b8bbf6so1764819wmq.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YFlE5oosPtaRdiA2tsjEzIscA11MI8VGLhJl8C2HPaU=;
        b=Q4GuNxVaH5LQB1/yaXZLQnTTD9Uye3bWJBwrvNYnW45VrCuiG2YZLgnmyjIaGr6DfD
         +B0pGSY0q5FuJ6dRmplIFPlU34QG9AzwSAHzaMj6nCPhZV8+Q4SFHI9nen3hp5JDrW5O
         CcLG0kN3ShvgeBnTGRedvrXUgpVi41RWfPZiVHML3PcxZcKhjBiN+MbpO5cFcejqKIR6
         jTYIiqxK+fDHuGcFQfI923spSqXSMEOI1FiqTqrzUylrPbhzxtx7pKAaD2v3BMqiFC1T
         BkRuw8vM+aUBOldseyXUj8a8o+BlHaw/zhgKsKTJt9c7p3ICU6KGgIjIPX0fS0BOyyVd
         zBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YFlE5oosPtaRdiA2tsjEzIscA11MI8VGLhJl8C2HPaU=;
        b=6s1m55rlhP1Eih3Iuf42TjJOLny+xNjdg1ikoOEANviC/1mk7QNhGeAxebdCFHvcBC
         i2FYQ0FmPmox9/5eWhptZqD74y3GYPkr9NvpJrmCtjQQsgpWDUmzVKKgIFwfkCrEThBD
         NoLM3cOh2NqH1nr0/468z8bYb1NH7eg1rX6tjjpFsfsR0IGHC0p5ydIvUIChat/XOkuc
         r5lE6zwDG0Rq+uR2r2o0VhoOSxsGhqXn4Zm5WmSiAnK/H+QZJF1gKQ59tiFhtmnK4Jx3
         k98/CzJ0aIWk53tF4qaWpJBTRKsOKa5ZpiDOdjOknQ3awqJSJ8uxvxrVN//zS+LHRybL
         D5AQ==
X-Gm-Message-State: AOAM532GJPPIEciw5TYefShSF9kD4LZ1JczBOCfPHjt7pVH550EV5NQ0
        IghasbtNHKz+up559JGnTCqxBJnfmNg=
X-Google-Smtp-Source: ABdhPJwHkZNQA3Tt7HuqmQHB0swuzjHykEeb44SRE2NoLHRbpuSjlwoZaSuwliEK9URdj3qsYc79CA==
X-Received: by 2002:a05:600c:1c1c:b0:381:45b4:3f69 with SMTP id j28-20020a05600c1c1c00b0038145b43f69mr13169778wms.86.1646160236261;
        Tue, 01 Mar 2022 10:43:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b0038167e239a2sm4017646wmq.19.2022.03.01.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:55 -0800 (PST)
Message-Id: <b0c9c9c7a4005e2aa2a587fe5bc5588bf5a32d65.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:27 +0000
Subject: [PATCH v6 25/30] t/perf/p7519: add fsmonitor--daemon test cases
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
 t/perf/p7519-fsmonitor.sh | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index aed7b1146b0..a1c552129cc 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -182,7 +182,10 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite () {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -293,4 +296,28 @@ test_expect_success "setup without fsmonitor" '
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
+	trace_start fsmonitor--daemon--server
+	git fsmonitor--daemon start
+
+	trace_start fsmonitor--daemon--client
+
+	git config core.fsmonitor true
+	git update-index --fsmonitor
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

