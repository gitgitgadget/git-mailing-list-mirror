Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B1C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349315AbiEZVtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349231AbiEZVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2EE8BB4
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x12so3663273wrg.2
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=AYEKItY8eXhGSc3a2UEuy4y9Hb5HusQOpQpW9RD12JgFHygNOvkjFGJ1trFqBqrxue
         c9pzXxmvi6m9is9QzfoeGly1Hctdkgx/u6/BYaTrrn0k+LOfzt/gzmN1dpeELn8msJHW
         JZepBGzX4O0jvLj78Aq98OrHcmlhd3vFwqejRuZdIMvhUkL+Jg3bH0G8JLXJznQDJ0am
         nNc6u4bS1TFr/N/uAX3EkV53T1IKyJ7LijAAC1Nv8SETIeEileBesgr12SduzUAys60P
         3ph3IaXVyxeNFo+WwyjNu4V+hoK8kS7ph0MHWAiky0e+ZmrwRtHchusiC2YGdHUdPkRn
         B63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=ciHr56SDHvrpYcGXhcT4Ozrn/0p+4qMxT6hcueSWZLp3TgTcBOFOWE3ovJo3ybIQS1
         eqR9+UJ2tC/yVVtY44pG2r4uD0p+32vwyWSQjiT54lo54+qmIEeuEqJK/IXGn9GVISxd
         oNlfDgY1OeZ1JG9BgNtPSp+MiiylVfAac219mDMOMlTqwFnMAS1vefKwWXBgXc84h5/1
         eT1boZq59i1kJVHz5tK647SAyQbwECusGVlFxE0QYLfvPn1LBQ52qDTYyHIBqBhxloH/
         w8RTCQJL9r59J0RM2FpE8grEtlVagt0ZI9R2aTaIx74c4v79abvElwFSj1N3hW7FCKja
         FW9w==
X-Gm-Message-State: AOAM530owkPUZdsCLws3AQ7Hi/RTq/G8ziFFZ6HvMDFd505Pg3gFVY4q
        qttxQVozFL/GIwAfV4jBWOH2mcD9DWM=
X-Google-Smtp-Source: ABdhPJzQc5/Z5A6AM8nCLGDIrAWh7UV8VOatP/TvsojrFgG7LP4AiX4028EjNeGoFBRdBzHGy2PROw==
X-Received: by 2002:a05:6000:160d:b0:20f:fb59:849e with SMTP id u13-20020a056000160d00b0020ffb59849emr9229520wrb.47.1653601759637;
        Thu, 26 May 2022 14:49:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n26-20020a7bc5da000000b00397473ae25esm249410wmk.34.2022.05.26.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:19 -0700 (PDT)
Message-Id: <6b271866f67ef6c7f3ffe76914f950c81aae053c.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:08 +0000
Subject: [PATCH v9 14/30] fsmonitor--daemon: prepare for adding health thread
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

