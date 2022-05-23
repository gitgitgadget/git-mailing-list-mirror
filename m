Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB23C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiEWUOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiEWUNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF4A7775
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t13so3722199wrg.9
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=Mx+k8WMEE1VRPcBuSzKs/Wzp7IwBQhuS2Rk2ei0NDi3PWUOG1SjklClgsPFiclUJwB
         M50CuEc/gJK909lXqoJtj6ReuAA5x4CruhBn/j6llS9jC9yb6s09s656oA2AfDMVT7Bi
         kVYQCHA7ZVvGg1Csa1CUpa7Um5SFGNaSzJozmkIytTO7u2Si7bFeGjYRWBU3ynlZqUS5
         wglXU/ukP1mNKGyM9devDZDW7ygxfGLHpvOIKaKGORKyPAIcRcK9D2aoMs8WTXxlH5oK
         JzlL6EQ3bcitP0q9oFeYbOQhMxjEmNfgkcKn93bPdPIUTxTE0AqRVVSyuXG9uWPBYmAi
         wUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9pd6ial0nEKbdJ3K7GTF9YvYqNRXvCcTnKwMvn0bh6Y=;
        b=ZyHRCBiZdvpqZZvpPM+TW7qmaEJHgzFgUH7Wpz0izK0gnqLu8Tuq+kU0wRGgMR3Np/
         cE426g/1MZYDjl4xPjuX2F1jFsZcoCGklePfy01O6Cb4orZeFpuH0V3JJXw7aGcL4pBO
         QitEG+pp9CuZN5Zna4bunaqrD0OvuzzVyJHPrK/Y64EsZigL2fV4Cd4fzUdZdjYXHvB6
         EVWvO1qp3UYT6oOpL/wUsJAfM8Pv3UKWK0f7tboLKkC3X//stb4Eg5mnLQ8rVI9IarxD
         CKhU5QbJJ3k+t4nfBQF8Y0Eyyp6ULHM5bV/see2z87DYTkjqqMSpATtzjxGVx/9JAEMm
         oC9w==
X-Gm-Message-State: AOAM533pjupoaP5t51MLTCjBmcXZHzHWN1dXBzqEobYEbGSi8iZg0JXV
        Fn4CqJwkFm9311AWZbs9LOCun3YYxpM=
X-Google-Smtp-Source: ABdhPJwY6Qlqx4mQpuLY/GAeWifwhCxvFTp9Rwv8kFQ8Kc9vruZtScqlYrMLCfAtWa9LsxsERfoSyg==
X-Received: by 2002:adf:dd06:0:b0:20d:c4b:e76f with SMTP id a6-20020adfdd06000000b0020d0c4be76fmr20116020wrm.581.1653336787128;
        Mon, 23 May 2022 13:13:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m67-20020a1c2646000000b00397071b10dfsm237572wmm.10.2022.05.23.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:06 -0700 (PDT)
Message-Id: <51b266b06e1739f09d785787c93fc3e346f47332.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:29 +0000
Subject: [PATCH v7 14/30] fsmonitor--daemon: prepare for adding health thread
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

