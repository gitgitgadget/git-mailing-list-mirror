Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AC8C32774
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347121AbiHRVlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbiHRVlC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:41:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832AEBD4FB
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so1626253wms.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=yzuv2QdF3zhXvvaGFJV0cq1X+N533hHlFfCUZvCGatQ=;
        b=P65jm6sx+GE+yO1ThFGDwWSTCuA9SMEkIbOalIyiUPmfVD1ks7JfzEVKzCsmyHtu8S
         QeO1ycQ4LqTaX52p9N+1SzbZ6HiuhFvSF9mfb6DNv7yGw7RPiXWvrERaMfUhoXf9I1wL
         gRpbojU+MZ0lEnUbJyTMtSiVUCUhNKxijnfVWrat66GSPNR6l3UGOQf9InGGPxs3hSkb
         YUTJVLZG00Cs79OvqQIIcRpjPyQFN3MgNwxrtXHugFcLQ6Dt2QZ2xJN2hRV04xanfJPI
         JXMulTdPcaFKpXuDQH80T7aqkT5WRCUG6hYW+2hXIFC+6Qtmjz8iOwjDUzMHidNLBkYN
         DA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=yzuv2QdF3zhXvvaGFJV0cq1X+N533hHlFfCUZvCGatQ=;
        b=8QiPidnM/UL5+NZvGJuv+cX5Y0YlDuvCLshnkeqU0cbBMf0RnpoEmftMEZRv5T786E
         nkBQSBDmCOy+DMIcs+AAfrYZvqowcUvVI88fXhp+Ar8PN+/UAM032HcuK1Qsn71kc0UU
         NjAHPA13U/6k9G0kdKmJF+I1rgMSiFGMuyfBHlnrzA/U93GnkqvpXY5NioJgVo0i36no
         e+yP6euhgaqdWuW8TGE7QyHlAMwd+W5myQaHSRZfBQmAiicRYsLcVPcgapV7YkWnOStr
         AzmgTJpHYN6kWyg0Wlh11i6M3w6W2XV1mmy12yDgsMplbtBA9nRQk4hl/+/e+x9JHsll
         Kx2A==
X-Gm-Message-State: ACgBeo266xYIHQcnGrwUBZRadyXgr2XG0UBGezB3A0WTdOGobYgidZfR
        0iXGcicQHdsedQFTphlf+DRkMomegZo=
X-Google-Smtp-Source: AA6agR72yJRjLrpFcOlzv0tvv8xcHBWIWZEBTHI+H74GGhF3w2d+G7CNG5LBBIEsfuSD4My+HfJOWg==
X-Received: by 2002:a05:600c:4f01:b0:3a6:12a6:8d7 with SMTP id l1-20020a05600c4f0100b003a612a608d7mr5956663wmq.107.1660858860914;
        Thu, 18 Aug 2022 14:41:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm3798830wmq.42.2022.08.18.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:41:00 -0700 (PDT)
Message-Id: <fb379fd2097b1e4b18428d791b9bcd48571d7b73.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:51 +0000
Subject: [PATCH v3 6/8] scalar: enable built-in FSMonitor on `register`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Using the built-in FSMonitor makes many common commands quite a bit
faster. So let's teach the `scalar register` command to enable the
built-in FSMonitor and kick-start the fsmonitor--daemon process (for
convenience).

For simplicity, we only support the built-in FSMonitor (and no external
file system monitor such as e.g. Watchman).

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c          | 30 ++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 836a4c48fab..73cd5b1fd0c 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -7,6 +7,9 @@
 #include "parse-options.h"
 #include "config.h"
 #include "run-command.h"
+#include "simple-ipc.h"
+#include "fsmonitor-ipc.h"
+#include "fsmonitor-settings.h"
 #include "refs.h"
 #include "dir.h"
 #include "packfile.h"
@@ -109,6 +112,12 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 	return res;
 }
 
+static int have_fsmonitor_support(void)
+{
+	return fsmonitor_ipc__is_supported() &&
+	       fsm_settings__get_reason(the_repository) == FSMONITOR_REASON_OK;
+}
+
 static int set_recommended_config(int reconfigure)
 {
 	struct scalar_config config[] = {
@@ -170,6 +179,13 @@ static int set_recommended_config(int reconfigure)
 				     config[i].key, config[i].value);
 	}
 
+	if (have_fsmonitor_support()) {
+		struct scalar_config fsmonitor = { "core.fsmonitor", "true" };
+		if (set_scalar_config(&fsmonitor, reconfigure))
+			return error(_("could not configure %s=%s"),
+				     fsmonitor.key, fsmonitor.value);
+	}
+
 	/*
 	 * The `log.excludeDecoration` setting is special because it allows
 	 * for multiple values.
@@ -218,6 +234,16 @@ static int add_or_remove_enlistment(int add)
 		       "scalar.repo", the_repository->worktree, NULL);
 }
 
+static int start_fsmonitor_daemon(void)
+{
+	assert(have_fsmonitor_support());
+
+	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
+		return run_git("fsmonitor--daemon", "start", NULL);
+
+	return 0;
+}
+
 static int register_dir(void)
 {
 	if (add_or_remove_enlistment(1))
@@ -229,6 +255,10 @@ static int register_dir(void)
 	if (toggle_maintenance(1))
 		return error(_("could not turn on maintenance"));
 
+	if (have_fsmonitor_support() && start_fsmonitor_daemon()) {
+		return error(_("could not start the FSMonitor daemon"));
+	}
+
 	return 0;
 }
 
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index c069cffebfe..365eab9b54f 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -102,6 +102,14 @@ test_expect_success 'scalar enlistments need a worktree' '
 	grep "Scalar enlistments require a worktree" err
 '
 
+test_expect_success FSMONITOR_DAEMON 'scalar register starts fsmon daemon' '
+	git init test/src &&
+	test_must_fail git -C test/src fsmonitor--daemon status &&
+	scalar register test/src &&
+	git -C test/src fsmonitor--daemon status &&
+	test_cmp_config -C test/src true core.fsmonitor
+'
+
 test_expect_success 'scalar unregister' '
 	git init vanish/src &&
 	scalar register vanish/src &&
-- 
gitgitgadget

