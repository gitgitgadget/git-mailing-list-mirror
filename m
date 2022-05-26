Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C7DC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiEZVtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbiEZVte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF969EAB94
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z15so3626100wrg.11
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=c5K+153HDYmcUQ/dYPPaSvXR+vsOug5/BOlSfTt7Ipa1tE/5z626eb7vvUhUjPAy8w
         GO+tVehFqJ83B/MTIWZlNHORvJ9cL88Z/eBqHj43PRJnv2glKUi4Sw2RrhpeTL17KHMJ
         cvEW3i21P5tJap6V9+0sebVnjTAAVBraev3wlwiDk0gc68xgqSWYvULCRhXoh3KMcWP6
         gRKFrffZ/MwuPOChEes1I98n10bk0hVS4/37D7GoU4U/m+zutpMqD7KPJtC5HuUHEr5C
         9Wok8R7fGmx+KFMEPVPWw2Tvlc5frRyMV4BH2kctMAtdTJNjJFl2znuMXJkmWkFsqh/+
         dtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=n7xEqInUCh59L1JxHZ880Wauvxh6uiJGD0AxFG6NLtWx4hyL8Oan7kQmDtY6cO+J7y
         mDFJ9UFgUcPpeWpWYt69fxKPKocaIfkOscKpPOCMn6eKZda3y7ZoT+UuIgsctcU0ID/3
         jAkJSG3F7dD4VIvp43KaWrvhT8HRm+NgM9q9mqzMYNksf7IaPAxgIvgsVT/vk/fy7Kr3
         N/yp5mcntKXx1CNsvco5IY13CVw+9Z+XQprVGbQpDV/LCDpCea0gov5quSKiKlQxrMf/
         3HvF+oiBS3aqmj+gHb8fe76g+mb5mJWmlRW36vNZ4gVwFHnqwkdaoFQEjOwqcmWU0FhJ
         L1Ww==
X-Gm-Message-State: AOAM5318PS+25LNpLY26lL3B79CyrJm8ZciveNGgu+KLQwTyXpt4HxU1
        sJbRt4sXlSHGHIfJq2Zhaee6Jdo1eJg=
X-Google-Smtp-Source: ABdhPJzrI2ML646V3HInBVsC8JtWvbG/tUHIbrCBHnrHnL8nLzjBxFR+wOJkzGzGe3G/LGWYqLXiaw==
X-Received: by 2002:a05:6000:1814:b0:20f:f977:a2c6 with SMTP id m20-20020a056000181400b0020ff977a2c6mr10114564wrh.445.1653601762924;
        Thu, 26 May 2022 14:49:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd15-20020a05600c1f0f00b0039466988f6csm276538wmb.31.2022.05.26.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:22 -0700 (PDT)
Message-Id: <f710d305dd41eb14039dc45fbe58d20e7427af66.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:11 +0000
Subject: [PATCH v9 17/30] fsm-health-win32: add polling framework to monitor
 daemon health
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

Extend the Windows version of the "health" thread to periodically
inspect the system and shutdown if warranted.

This commit updates the thread's wait loop to use a timeout and
defines a (currently empty) table of functions to poll the system.

A later commit will add functions to the table to actually
inspect the system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-health-win32.c | 65 ++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 94b1d020f25..24fc612bf02 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -4,6 +4,24 @@
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 
+/*
+ * Every minute wake up and test our health.
+ */
+#define WAIT_FREQ_MS (60 * 1000)
+
+/*
+ * State machine states for each of the interval functions
+ * used for polling our health.
+ */
+enum interval_fn_ctx {
+	CTX_INIT = 0,
+	CTX_TERM,
+	CTX_TIMER
+};
+
+typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
+			  enum interval_fn_ctx ctx);
+
 struct fsm_health_data
 {
 	HANDLE hEventShutdown;
@@ -42,18 +60,61 @@ void fsm_health__dtor(struct fsmonitor_daemon_state *state)
 	FREE_AND_NULL(state->health_data);
 }
 
+/*
+ * A table of the polling functions.
+ */
+static interval_fn *table[] = {
+	NULL, /* must be last */
+};
+
+/*
+ * Call all of the polling functions in the table.
+ * Shortcut and return first error.
+ *
+ * Return 0 if all succeeded.
+ */
+static int call_all(struct fsmonitor_daemon_state *state,
+		    enum interval_fn_ctx ctx)
+{
+	int k;
+
+	for (k = 0; table[k]; k++) {
+		int r = table[k](state, ctx);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 void fsm_health__loop(struct fsmonitor_daemon_state *state)
 {
 	struct fsm_health_data *data = state->health_data;
+	int r;
+
+	r = call_all(state, CTX_INIT);
+	if (r < 0)
+		goto force_error_stop;
+	if (r > 0)
+		goto force_shutdown;
 
 	for (;;) {
 		DWORD dwWait = WaitForMultipleObjects(data->nr_handles,
 						      data->hHandles,
-						      FALSE, INFINITE);
+						      FALSE, WAIT_FREQ_MS);
 
 		if (dwWait == WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
 			goto clean_shutdown;
 
+		if (dwWait == WAIT_TIMEOUT) {
+			r = call_all(state, CTX_TIMER);
+			if (r < 0)
+				goto force_error_stop;
+			if (r > 0)
+				goto force_shutdown;
+			continue;
+		}
+
 		error(_("health thread wait failed [GLE %ld]"),
 		      GetLastError());
 		goto force_error_stop;
@@ -61,8 +122,10 @@ void fsm_health__loop(struct fsmonitor_daemon_state *state)
 
 force_error_stop:
 	state->health_error_code = -1;
+force_shutdown:
 	ipc_server_stop_async(state->ipc_server_data);
 clean_shutdown:
+	call_all(state, CTX_TERM);
 	return;
 }
 
-- 
gitgitgadget

