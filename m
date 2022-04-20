Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98042C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382175AbiDTUrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382176AbiDTUqn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D55424BF
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so3824543wrh.11
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=Yu7L3KWzFCamvDNOlKM9W9rzPBFCKsl2tkhTtwdkkkfz81ZbX6VOj5HHtNT12rir7s
         22C93dX28TBYxcvHD7a28u6xcgVVgtKB24MAGbBGm/kTnmi2/0VITBKimBGNfAySrSY5
         fl1C3BwL30xnkuuTZToABC3U/WeBUU9HNp/4bGzYdGbEE7u+TtANCgAAetyPsahuVq7Y
         EflJLjAV7BvefgLIsmLXO1Exl7H76qaK5VVrHTVyXhTucp3zh0nWTqKAII0tOzKeeZVs
         x3fjAyio7br+2sXuxKJrmaT2sEQl0bZ0DARSF1leOITbWT9iSE5zZxcgY9O2FHxHPHMn
         VZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=ZmKx2XXxNpqngNIJIDA6TmKnUJz3qbFtL7VIRh0nGS0ZVaQwHjgPqhD1QWhMh9JwKJ
         cAQZ36u/mOjZ2zSKt9IiNgxgm3H2Mx4PINE6VXnjgiT1zMj46MEoK1X+hxaQe+IjXr+N
         oJz+MsrwCnOVnNIUCNHGSIs6bkzcq9GT3kw4u1ghbeKWHX0KF4IhXunKglWjqx5EoYiP
         3pBcAxlYveCSICFgEpl1KBelcNRbCPJHo28f2SS0oc0J4jDIFCDGvVnsOAv9LvLO09ow
         oIdxWAuDffWl/eCmjal2EAH3/jRAty6SNzd5Q6MEpRPeA+NhzMZZc/rIh4sxZ+YXTbi1
         2/bw==
X-Gm-Message-State: AOAM530+LxWhupotPnRzcvVjXCnDtQBhFNNUKAwNzOmnEd4NvW7VNr5H
        rg1YYH3xKAneCzRlFpmohy14uwI7uoI=
X-Google-Smtp-Source: ABdhPJyV3+hwIqH9EG/ZeKeSEPuahNNyR84i+6YpLcbos6lMYkwq7lQHv25zEnqnYTXzXdJuvkkHaA==
X-Received: by 2002:a5d:6205:0:b0:1e4:b3fd:9ba8 with SMTP id y5-20020a5d6205000000b001e4b3fd9ba8mr16655104wru.426.1650487422779;
        Wed, 20 Apr 2022 13:43:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b00207aa9eec98sm647892wrw.30.2022.04.20.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:42 -0700 (PDT)
Message-Id: <854fb5e3658156f93f76915aaf3d4a194145b3fb.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:07 +0000
Subject: [PATCH v5 17/28] fsm-health-win32: add polling framework to monitor
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

