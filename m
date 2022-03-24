Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CFC43217
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351914AbiCXQxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352204AbiCXQxO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EB954AF
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p189so3100573wmp.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jLD5/kKpi8DMO5qU1ej4+CHxgwvkoymtmnde3SN53k4=;
        b=fZexassmfrHfdLt/0Ee8jf+lKIqoOjCCqe9vNMOebPKyp8iGPk89Zlx0YeNOwQxeXH
         4Zi2/3ZdS+JLNQABNoo1JEZ2/Zt8eJctxFbprxONUB/1lHgq9W8nCf4DbDRaru2ckI98
         CcqkAgd/eKB067tW3IpjnAyfnL19ZTC8ZlFoUuyru6MmOINTQBA5WzxERO6lRxgD1Rsb
         DStDYU6GWGrrkuxVclB94uFWN5EcpPMwWiVkBYuuXzGhRfJH01VriJ9ASNTJPaL6bEXx
         MKlLvKFWHn4WnMNGxN3JcZhrAsbBLR7F81Cu1efVi6daNS7D6rgbjIXp0dX7LwLUuvWx
         ByHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jLD5/kKpi8DMO5qU1ej4+CHxgwvkoymtmnde3SN53k4=;
        b=zMlB4YqsQaBQzJ5V39nyyuqrD1LfeW4g0M6ru/oJum/Hng3yPna94/+WS0S/ls9Rku
         84UIH3jsGkXCsvn8xR56rU2/ljIU+WmvZWii1V8I8APZ11SP10lf3k3h3Mff0uPnTmcW
         YQ2366ER+uEfjr7Wi47Y6mtv4i3CvbVn306bm6wcZccqzKmDzSKSFs5bixN6R3IQmv5W
         70unAScTiosE3OKX4rGMivgafuCLAp62UECa6kvZfM/IPZNFH1ZQbCekRYz4Bg9+2GdS
         8OQxRUUXDdMQpUaXXIzH9uqPE8nJWPRQkx5kT/U4wwiv3EHoc6HnoyL7zE1GsYuVsZPE
         Rm0A==
X-Gm-Message-State: AOAM532+QwAB1nupHPZL6fAG14llUsv1cqtMpp0RizK/ad1lo0jrnAhr
        GGxg4wmLFNbrP1BHYo4C3CZqLspaTZ8=
X-Google-Smtp-Source: ABdhPJzk72f2XXd0H1pvB8UoB3RSQicKGk4lFp5BQDNczKaza85v5IdW/BHlkmCIkTYFmKfX3QmJUw==
X-Received: by 2002:a05:600c:3d9a:b0:38c:a579:844a with SMTP id bi26-20020a05600c3d9a00b0038ca579844amr5463088wmb.121.1648140700932;
        Thu, 24 Mar 2022 09:51:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d6612000000b00203fbd39059sm3101121wru.42.2022.03.24.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:40 -0700 (PDT)
Message-Id: <d8ebac2a9b2f0dc3c1857a36b75da7d80abf06d2.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:07 +0000
Subject: [PATCH v4 14/27] fsmonitor--daemon: prepare for adding health thread
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
index 1b7c757f583..14cd2d5eb52 100644
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

