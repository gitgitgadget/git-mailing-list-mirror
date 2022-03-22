Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7CC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiCVSZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiCVSZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA45390CC8
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d7so24639141wrb.7
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ej7vjoBKufi5X7KtDia+Ocl0y26c4e3iM4lYXqh6QBQ=;
        b=L6t+uIHS4oh2vUxOlTRAJ6B6oPAJyoOhEykrUguDAduXQq0ramvHeYP5NOJ3EX+zKZ
         XV5RBhiA2YZCc4jAvGK+QECs9GYQvzaJTIZTxyCWtW+LD3yXEmVX85WndSasKb0a6qCy
         WVJhY6HoOwtVGJit/EWyXvhrdUTBd2O7i8oeHJ9SGtXBUOyMbH6NjdcU5lbA/P4FBXm+
         7lox50YVaVBaUudGZehxvaRH8zKVpHtvQ//Li5HouLiaTq3NJXTz0G7fxM62FqFzK9nF
         IbqB7N0fqsoTT2cASBhf0ItIjdUbXi2u+jB0pIk/qny2c8iaSz+2S1Tnwea0gyEMJm4d
         z3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ej7vjoBKufi5X7KtDia+Ocl0y26c4e3iM4lYXqh6QBQ=;
        b=g4yP+YjhGthud1rUKvFzHjE8qkUwqojvBTKVKh8Xgb9mKKaKJ+f541zXzManhqVJB8
         Eod3sclCYRv7KEeYZEjHcS+LHTg0SXTn0y0a1F4jZFvxG63V6wv93oXqUsfp0MQQUH/Y
         FcxkT4wgsu/9ozkAUWBNoycJeVIGClkzfE7rQnReQQPUutmdX6YVYgP9w5AHAW4u5JeZ
         0RLT0B/aNBHUMrf4fAiaGCmyTiwxOfus00nCxGhnFS+YTY+BEoRUfvP/ihG2peuc+cxV
         pJjd5JMC4xWVMtINxFIbgKJULHBIRkT7OieZ2qTzYU/YW1zWPqqkeCOcj6+/8yCoP2KN
         jvcA==
X-Gm-Message-State: AOAM530S0d6hHf3KiaZopFUg3rJwAkpH7mVJdhpuP5yvtW7Y2gYi6/0h
        tgBmofQLP13/ixOCa7e2x+ijSUPOqho=
X-Google-Smtp-Source: ABdhPJzydzQnz1Fmvo38GENgZHYMADUekqpF48OZ13FdM02n7MBdccYidAkXogq2PEJFpUlCfCVxPA==
X-Received: by 2002:a5d:5846:0:b0:204:1a79:f1ab with SMTP id i6-20020a5d5846000000b002041a79f1abmr7055805wrf.520.1647973417276;
        Tue, 22 Mar 2022 11:23:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm5931143wrs.26.2022.03.22.11.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:36 -0700 (PDT)
Message-Id: <087af5dfb6315849b0079d8f6df9bc2da7682653.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:47 +0000
Subject: [PATCH v3 14/27] fsmonitor--daemon: prepare for adding health thread
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
index f17d5ed84c8..8033916aa63 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1175,6 +1175,8 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
 		 */
 		.uds_disallow_chdir = 0
 	};
+	int listener_started = 0;
+	int err = 0;
 
 	/*
 	 * Start the IPC thread pool before the we've started the file
@@ -1195,15 +1197,20 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
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
 
@@ -1212,10 +1219,16 @@ static int fsmonitor_run_daemon_1(struct fsmonitor_daemon_state *state)
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

