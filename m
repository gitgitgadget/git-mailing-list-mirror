Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD025C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiEYPBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbiEYPBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B962AFAE1
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x12so6254117wrg.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=PHO7zm8vGB1/UuLRwUdMKPBwMgVW64ivQ4svTT7nc0D/lb+A6+wK7yb/UrIjGv3JLl
         3WbCiD8HnXFQZN66oRLP0blQ6BWcZN0WinllNDcwSdn61Ocgwhltwmzy8Mq5gfhUyUQ1
         8IDSLuetNVF1iHm00LjbPiHo81cdi753SJFE4ASle9skBbCz1dBkQNn1BraerRc9T24h
         NVYin+OWldm1CwGGnN99mqvUA68G7kgq5AisxnGVirKtfTAzvYBFtvKE1tnxTZGT5Lt8
         jHyybh0pWGmNQHx4+GovHSS3fARb+dArFiKgg6PNd1WNXoU46AgF0CrV3KI8/a46/bej
         PgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=EEpdWGpBAv4X7LfzcS88JiSsjjQ37CmL31OzSbOaa7SdIlnZ7sP3LbshrgZqxyIw4Q
         rpLPS9/WjPvoGtGdPNtIH67ODL05/NIf6wSbmtXVgko3Xxn/I2YeChlz5TsP6eA1Zj4g
         PjOzh5k3mDPzbM8sesn9epSQtbnsDSJhxbV7UgPusoKBs9OvT44kuPKdMcdU0EnXyZP/
         5qwxXCqu5ysthOuelKhYXPbnlSa92Gn1Jv4rPVZmM5S58oyBSdAOBxCxT2p3eqKxHyap
         GWRLr4VgleIc2uOcx+xGst0XsO7yaRCQXZ3nJkbBAedYrkBEyjtk14Glz0aHIKBubqRy
         LD/w==
X-Gm-Message-State: AOAM531AWuzU8I4eKDoZPVerB17BWYYEixHhaTGgHzZyrq6d2bvrdZYU
        u9eTjUQv5VaTZpMXHdrE9TkoWiAEZ7k=
X-Google-Smtp-Source: ABdhPJxd9DKUGoe9/RLYRo3kypEOCjt92PZF77xtouwF3e9Eb5x8LwaIxLFVNdZgxlsSEOKLFAmZjQ==
X-Received: by 2002:adf:e10d:0:b0:20c:dc8f:e5a5 with SMTP id t13-20020adfe10d000000b0020cdc8fe5a5mr27630875wrz.265.1653490876817;
        Wed, 25 May 2022 08:01:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000184a00b0020e615bab7bsm2654871wri.7.2022.05.25.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:16 -0700 (PDT)
Message-Id: <51b266b06e1739f09d785787c93fc3e346f47332.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:36 +0000
Subject: [PATCH v8 14/30] fsmonitor--daemon: prepare for adding health thread
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

Refactor daemon thread startup to make it easier to start
a third thread class to monitor the health of the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index db297649daf..90fa9d09efb 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1174,6 +1174,8 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 		 */
 		.uds_disallow_chdir = 0
 	};
+	int listener_started = 0;
+	int err = 0;
 
 	/*
 	 * Start the IPC thread pool before the we've started the file
@@ -1194,15 +1196,20 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	if (pthread_create(&state->listener_thread, NULL,
 			   fsm_listen__thread_proc, state) < 0) {
 		ipc_server_stop_async(state->ipc_server_data);
-		ipc_server_await(state->ipc_server_data);
-
-		return error(_("could not start fsmonitor listener thread"));
+		err = error(_("could not start fsmonitor listener thread"));
+		goto cleanup;
 	}
+	listener_started = 1;
 
 	/*
 	 * The daemon is now fully functional in background threads.
+	 * Our primary thread should now just wait while the threads
+	 * do all the work.
+	 */
+cleanup:
+	/*
 	 * Wait for the IPC thread pool to shutdown (whether by client
-	 * request or from filesystem activity).
+	 * request, from filesystem activity, or an error).
 	 */
 	ipc_server_await(state->ipc_server_data);
 
@@ -1211,10 +1218,16 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 	 * event from the IPC thread pool, but it doesn't hurt to tell
 	 * it again.  And wait for it to shutdown.
 	 */
-	fsm_listen__stop_async(state);
-	pthread_join(state->listener_thread, NULL);
+	if (listener_started) {
+		fsm_listen__stop_async(state);
+		pthread_join(state->listener_thread, NULL);
+	}
 
-	return state->error_code;
+	if (err)
+		return err;
+	if (state->error_code)
+		return state->error_code;
+	return 0;
 }
 
 static int fsmonitor_run_daemon(void)
-- 
gitgitgadget

