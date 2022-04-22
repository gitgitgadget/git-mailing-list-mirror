Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC83C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiDVWjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiDVWiH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8821BBFAF
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t6so9321552wra.4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=Rhzsd3vv8B6JzHkQ/Hc3QGH/PdctqA/bymjlbQ5scXhkPH93FiOg4ciqqeC9FpQbo/
         fUWR5YeUj8xqCVFn/OZGizYuii/5LrqXsVWSkDvxJDgm6ShtKyPaij97KjWtd9dTEwDt
         Sh3MdwmfFVmE3WF9ui7mvo5Cf70VMquSxUCEB/1AHKsGndg09I1d0mW8Fuv/OeLHuu+b
         UQ1+JJjp1mU3U30hbG+8aIOb5ON8YyJZiDd3vNKmRk4WrwZ7gxDv1ACQ2CdbooLAH2Hn
         UK+KoC5odLiukmxMOsoHSde/ompbfxgTVT3L2/agDdFy5tgg+1/s/Pjk7urDMBQlhShm
         LqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=fr0OhUVXl+3mojbBQus4iGIMWY0HPPpYeHQEvDjl4cNLd8x12Xl5BGYIh3xCSiyN+J
         GvpqPydqHc9PcPyWGz8rG4XDzwnWK0irm9ZTuTNf8YWhyLZMbu8+C08WvNaQmEPOXio+
         47uqbVNhnhJEIN6Vm7IXtS6g4rjnMYkiqeG62vsR6j49I6G6+tbi728m55TfsrOnxqeb
         5KBsdRtGbGM+FHcAIMHvgwURz1XoZRHU/DMA0LbynYF4UcDQpXGb9RYJhBLNMHKLeWis
         h96ClCBROvBO7+Q+m/RqlWQVnfCckauLUe4PTYJzWZMrn0fT2sXH35imdqjLouVO+ISM
         nWeQ==
X-Gm-Message-State: AOAM530b8bRj6WrMvnrQe1GRCx52wq6gXI+LErnHMn7+MKrC4dsQPRUD
        cZinfIakLxXukSnkH5iQBi/Q1xQ63TA=
X-Google-Smtp-Source: ABdhPJwWMQYEbQlQmlhw6rVggE5TskfvRHsd2KflVtYnp58K9T8AXteuA10t57QFpvpHNLJn4cunOw==
X-Received: by 2002:a5d:40ca:0:b0:20a:cf97:f1b4 with SMTP id b10-20020a5d40ca000000b0020acf97f1b4mr1145063wrq.121.1650663010959;
        Fri, 22 Apr 2022 14:30:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b0039288e17458sm6346882wmg.19.2022.04.22.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:10 -0700 (PDT)
Message-Id: <ae90b99ea9b821cf9dbf307a56b3000578cb3391.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:40 +0000
Subject: [PATCH v6 14/28] fsmonitor--daemon: prepare for adding health thread
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

