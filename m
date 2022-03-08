Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350B1C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350699AbiCHWRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350675AbiCHWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A55A574B0
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r65so317305wma.2
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nSWrqMziCbYTA8ezg6FoHNOt/kcUNK4llsbMjZRGMhw=;
        b=dWVrE1Z5pYAu6GDMVhlTIbd54nRXvcp6CX2gXSI0jC9GpiuVjgxv6pzFOeakWIv7t4
         nYmgqwNVt8HujuTijPkqmDaIW9NyqcFYxkLiy4fNCEXLK0M21e1BmnhzpRIONcP9LCKS
         ch8/vGdhjy7o+rzjvaQPMX85/Tf3L8Jnry+KzWFMrtjUgHbcU9kmcY8YCyy6+zkBP0DO
         2+H12wDQE369Q6cQ9Z5tnoJ+ILxEPj377NEvP/x9BBj7RjhYEXX0CKorPeWZ+BWEFM93
         F0sL7AEObqWtvLa2N3L6r3ZA0nC48WX/KGHCFJdDFB1cSIwYy9pABfR7EEqOxz1lvXE4
         SqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nSWrqMziCbYTA8ezg6FoHNOt/kcUNK4llsbMjZRGMhw=;
        b=Zla6FQsvMBFOLgJDGn3PWjR5dGKIIyy6/mJPhpuLjkOqFeJmdhY9I/qh2rwYKzy6t8
         vXi8JJOu8jFv0IiYHV7R40KFUb6fYfkK3u/+BZUwNPDgCpJw0nRBTrmAXdYln2ZBZhhW
         X7OpPkAtsiGIfTeEF0lrAyJR+BV2KQikn3EIeFlXHr4pAWVmnIKb/skOjR8seARDfZhF
         WMZRcGGFNFjnA+vKOXJ35lhHWz8qUYqvkpXGeakeLan7pTP5zDHweo9ke2k3dab3N1at
         UP7Bpt65uA3fWBcCEfyrQeymi/ZliQUoqg2DzA0LNoOCFNQyggz3SIvMpcoYTyn/Cq0t
         lHfA==
X-Gm-Message-State: AOAM532b6MzHfHDXfHGPCPcQpLI3/DvkHkztSy1xcXyHgUolSU6W6ToD
        64A1t8nwpH6h/CeZPe0dFhBMa8qExgw=
X-Google-Smtp-Source: ABdhPJw8DPVMPyLaZRboDUXTH+jV9n/ZpH2NG+CEefcJQMl0gc5yM+1UTDPuILsiiinYsXZ/Kf221g==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id l9-20020a05600c4f0900b00389cf43eaf8mr1035315wmq.201.1646777743767;
        Tue, 08 Mar 2022 14:15:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d46c2000000b001f079ba0158sm91500wrs.60.2022.03.08.14.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:43 -0800 (PST)
Message-Id: <71673be2da5e87163ec95f5d99f0a22b698276e6.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:13 +0000
Subject: [PATCH v2 13/27] fsmonitor--daemon: prepare for adding health thread
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
index dbd37a2b3b8..d5a8fc2ddc2 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1168,6 +1168,8 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 		 */
 		.uds_disallow_chdir = 0
 	};
+	int listener_started = 0;
+	int err = 0;
 
 	/*
 	 * Start the IPC thread pool before the we've started the file
@@ -1188,15 +1190,20 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
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
 
@@ -1205,10 +1212,16 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
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

