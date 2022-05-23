Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E3C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiEWUOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiEWUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74250A88BA
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so22920174wrg.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=WOFDTd2vbb98BhkV9s/qLwhCJv4N7qWz09rqiT4KkPBe4n9SHO3L+V/x9PT+PFqUCV
         so9EfPrC+uUCWdzuesObEATs7HnwibCXgtKzlhuTE4eFncbDLTi1ngWUDD9O1k49ZjNZ
         ZC1BRc0EvTEy01ePR0Nl3+mFpWMCbs9hFJZlmBqV2ET2sFm0U2v+imrt6LxTndGSj8ZK
         52CU5wANR3P5yFuCjyW+8mnIv8Q3EVDUvCi4mUYdcXhcudJQkpV4MCTiJ0z6k/az2n6D
         82npAR1s2qrHH3vQPfppTHO6ad4MX1UDQ6KE4/oFTkRUbaG84QEATmAnG52Ym/imPpyl
         pJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mv6D24bMSysj3hV8m09u6C4BPD9U2eW4vus0bJo6UBo=;
        b=VunYzFyqUAnZ+K22xC0ZotuEtQS+k0w/oLascehIn4DXN+DDOi3ZmkkVBce5pHCb9+
         A5vgN+4RarEH4e0xKtl+aKZg3R3U7jm18/gscGmjLCRw9bQDdiyuIW6cAkaOQZLgttkg
         NdD5d5e9Hq0RnuSmBDbrDY8SihbTSWFAQgee+xNYf2xhX0vpKbFLFkI9IMfGcDDgL3IQ
         2+AJXP/xhSOX+sNsQ1aFCcVjY/Nkred2M5xiBz358/GSwH+LuzSqCd5QXqoR56614/2o
         5penEIa58TMWWm/AKSKToZuB7fZ3rMevV4vGvhv429+mBblKWspTDjzxs+FphgSmuftz
         7WJg==
X-Gm-Message-State: AOAM530U5sRMDiiXQCfZuqSBbB2iUivDQmnW31NKz22or5C2Dnuuiucl
        d0C4KD/hB8wPaW3gOrQEsyoYiikSQ7M=
X-Google-Smtp-Source: ABdhPJyaWMU/VRu7JN9PYB4g3NwLCXN9IwMpKg9yqymxMdi6qnjFm/yjlVMDuxObO2nWu2BVEdH5fw==
X-Received: by 2002:a5d:588d:0:b0:20e:e4f0:e3 with SMTP id n13-20020a5d588d000000b0020ee4f000e3mr14281127wrf.87.1653336790569;
        Mon, 23 May 2022 13:13:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020adf8bc5000000b0020e615bab7bsm11018576wra.7.2022.05.23.13.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:10 -0700 (PDT)
Message-Id: <46a5ae2a6353e1da3c3ba84c9a2b5e03d6eeae44.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:32 +0000
Subject: [PATCH v7 17/30] fsm-health-win32: add polling framework to monitor
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

