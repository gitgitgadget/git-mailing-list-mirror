Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACBC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiLNTMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNTMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:12:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D41DDC7
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:12:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v7so12153321wmn.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TSmAOq8ulE7s4aJ1aHA6gVQ2wSgngaOrMUChh/Xqqo=;
        b=qvDnN2r5os6xPNjvRgmWDIV5clanFEg/0lOK21laihVAzGADGaKg92rVvCrng2jeui
         Y6ERTvR7aq8Djz/QUU4RwFLsVuD8bKowLMmzZZKWwMcb/wK0b0qQQ8w7TPoPoTPrusVJ
         lRuBOkaDZp9KBVjYGYe+6PAPblK57k3gQ1sSQ5lb/KzTnsSwJ0Hzb/GTIamgDOzUcIwG
         LMiAJO999lKvSlLYn+lSywdR6q+/W2stmjJZzasjwQgL1qYAfV7fC8ApuH4ndObPGNA4
         KAekC2CBWnW3Zl3gLtQ1utdVhu+Wm3wjeVmunVp8CL0z56LkjG8QSUu69W1O2hdK7VOw
         v1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TSmAOq8ulE7s4aJ1aHA6gVQ2wSgngaOrMUChh/Xqqo=;
        b=vAHmBaZrh0ONfULVY1ReGWGQvWxLl9nizFKP8YNGsAwWOdeOisEw8MJ/JVsZHEStG5
         2yMRI/LcYeEQEAIm3lIT212KbrqZmwAOJO+zeXbWPIKBssXYyAg3oM8RjeTN3atJ93eE
         ag4BOCDUqSDGmET5TIHrMGEjd5RwhhLMYet08kNyEO2q+qR6BitfsbPZi0eLZj5pMJaT
         H++8pKBDeCP1LLhMwHHCqzr/+RRus/zr9I6bVqi33broiezCeHJxh+JHs0aj7GaVbnNP
         +4uNb4+lFnWZ6sPYwx1M9aVzXN2NGMtDzGApchvdBqTXK6r+OLsMUG+7DanOyT1XuWpq
         2zTg==
X-Gm-Message-State: ANoB5pkmhfzk4yw5HGTSC4UxiLfTf7S8iLqLhrRHqmWYiL33PGuJwy8F
        5JCD/dtOhVF5JEmucfEdAr/0IEeOUDM=
X-Google-Smtp-Source: AA0mqf63dn7c2rxdNgFLu7jSgrKBxc/HY2jioccAqbOSpOcNXPLIMAisvEngzJOQihBTKlK8l65nCw==
X-Received: by 2002:a7b:cbd2:0:b0:3d2:191d:2420 with SMTP id n18-20020a7bcbd2000000b003d2191d2420mr13599341wmi.7.1671045155297;
        Wed, 14 Dec 2022 11:12:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c430b00b003c6b70a4d69sm3124169wme.42.2022.12.14.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:12:34 -0800 (PST)
Message-Id: <pull.1436.v2.git.1671045153981.gitgitgadget@gmail.com>
In-Reply-To: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Dec 2022 19:12:33 +0000
Subject: [PATCH v2] fsmonitor: eliminate call to deprecated FSEventStream
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhostetler@github.com>

Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
the suggested `FSEventStreamSetDispatchQueue()` function.

The MacOS version of the builtin FSMonitor feature uses the
`FSEventStreamScheduleWithRunLoop()` function to drive the event loop
and process FSEvents from the system.  This routine has now been
deprecated by Apple.  The MacOS 13 (Ventura) compiler tool chain now
generates a warning when compiling calls to this function.  In
DEVELOPER=1 mode, this now causes a compile error.

The `FSEventStreamSetDispatchQueue()` function is conceptually similar
and is the suggested replacement.  However, there are some subtle
thread-related differences.

Previously, the event stream would be processed by the
`fsm_listen__loop()` thread while it was in the `CFRunLoopRun()`
method.  (Conceptually, this was a blocking call on the lifetime of
the event stream where our thread drove the event loop and individual
events were handled by the `fsevent_callback()`.)

With the change, a "dispatch queue" is created and FSEvents will be
processed by a hidden queue-related thread (that calls the
`fsevent_callback()` on our behalf).  Our `fsm_listen__loop()` thread
maintains the original blocking model by waiting on a mutex/condition
variable pair while the hidden thread does all of the work.

While the deprecated API used by the original were introduced in
macOS 10.5 (Oct 2007), the API used by the updated code were
introduced back in macOS 10.6 (Aug 2009) and has been available
since then.  So this change _could_ break those who have happily
been using 10.5 (if there were such people), but these two dates
both predate the oldest versions of macOS Apple seems to support
anyway, so we should be safe.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
    fsmonitor: eliminate call to deprecated FSEventStream function
    
    This patch replaces the call to the now deprecated
    FSEventStreamScheduleWithRunLoop() function with
    FSEventStreamSetDispatchQueue() as suggested by the compiler warning in
    the MacOS version of FSMonitor.
    
    I have tested this on MacOS 13 on my Intel and M1 laptops. And it has
    passed all tests on the GGG CI builds. However, I don't have access to
    an older version of MacOS anymore. The docs say that this new (to us)
    function has been available since 10.6, so we should be OK using it on
    older versions of MacOS, but I cannot confirm that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1436%2Fjeffhostetler%2Ffsmonitor-macos-dispatch-queue-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1436/jeffhostetler/fsmonitor-macos-dispatch-queue-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1436

Range-diff vs v1:

 1:  9000f6f9073 ! 1:  9ef89416a7b fsmonitor: eliminate call to deprecated FSEventStream function
     @@ Commit message
          The MacOS version of the builtin FSMonitor feature uses the
          `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
          and process FSEvents from the system.  This routine has now been
     -    deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
     +    deprecated by Apple.  The MacOS 13 (Ventura) compiler tool chain now
          generates a warning when compiling calls to this function.  In
          DEVELOPER=1 mode, this now causes a compile error.
      
     @@ Commit message
          maintains the original blocking model by waiting on a mutex/condition
          variable pair while the hidden thread does all of the work.
      
     +    While the deprecated API used by the original were introduced in
     +    macOS 10.5 (Oct 2007), the API used by the updated code were
     +    introduced back in macOS 10.6 (Aug 2009) and has been available
     +    since then.  So this change _could_ break those who have happily
     +    been using 10.5 (if there were such people), but these two dates
     +    both predate the oldest versions of macOS Apple seems to support
     +    anyway, so we should be safe.
     +
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## compat/fsmonitor/fsm-darwin-gcc.h ##


 compat/fsmonitor/fsm-darwin-gcc.h    |  4 +---
 compat/fsmonitor/fsm-listen-darwin.c | 35 +++++++++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
index 1c75c3d48e7..3496e29b3a1 100644
--- a/compat/fsmonitor/fsm-darwin-gcc.h
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -80,9 +80,7 @@ void CFRunLoopRun(void);
 void CFRunLoopStop(CFRunLoopRef run_loop);
 CFRunLoopRef CFRunLoopGetCurrent(void);
 extern CFStringRef kCFRunLoopDefaultMode;
-void FSEventStreamScheduleWithRunLoop(FSEventStreamRef stream,
-				      CFRunLoopRef run_loop,
-				      CFStringRef run_loop_mode);
+void FSEventStreamSetDispatchQueue(FSEventStreamRef stream, dispatch_queue_t q);
 unsigned char FSEventStreamStart(FSEventStreamRef stream);
 void FSEventStreamStop(FSEventStreamRef stream);
 void FSEventStreamInvalidate(FSEventStreamRef stream);
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index cc9af1e3cb3..97a55a6f0a4 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -1,4 +1,5 @@
 #ifndef __clang__
+#include <dispatch/dispatch.h>
 #include "fsm-darwin-gcc.h"
 #else
 #include <CoreFoundation/CoreFoundation.h>
@@ -38,7 +39,9 @@ struct fsm_listen_data
 
 	FSEventStreamRef stream;
 
-	CFRunLoopRef rl;
+	dispatch_queue_t dq;
+	pthread_cond_t dq_finished;
+	pthread_mutex_t dq_lock;
 
 	enum shutdown_style {
 		SHUTDOWN_EVENT = 0,
@@ -379,8 +382,11 @@ force_shutdown:
 	fsmonitor_batch__free_list(batch);
 	string_list_clear(&cookie_list, 0);
 
+	pthread_mutex_lock(&data->dq_lock);
 	data->shutdown_style = FORCE_SHUTDOWN;
-	CFRunLoopStop(data->rl);
+	pthread_cond_broadcast(&data->dq_finished);
+	pthread_mutex_unlock(&data->dq_lock);
+
 	strbuf_release(&tmp);
 	return;
 }
@@ -441,10 +447,6 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
 	if (!data->stream)
 		goto failed;
 
-	/*
-	 * `data->rl` needs to be set inside the listener thread.
-	 */
-
 	return 0;
 
 failed:
@@ -471,6 +473,11 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
 		FSEventStreamRelease(data->stream);
 	}
 
+	if (data->dq)
+		dispatch_release(data->dq);
+	pthread_cond_destroy(&data->dq_finished);
+	pthread_mutex_destroy(&data->dq_lock);
+
 	FREE_AND_NULL(state->listen_data);
 }
 
@@ -479,9 +486,11 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 	struct fsm_listen_data *data;
 
 	data = state->listen_data;
-	data->shutdown_style = SHUTDOWN_EVENT;
 
-	CFRunLoopStop(data->rl);
+	pthread_mutex_lock(&data->dq_lock);
+	data->shutdown_style = SHUTDOWN_EVENT;
+	pthread_cond_broadcast(&data->dq_finished);
+	pthread_mutex_unlock(&data->dq_lock);
 }
 
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
@@ -490,9 +499,11 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 
 	data = state->listen_data;
 
-	data->rl = CFRunLoopGetCurrent();
+	pthread_mutex_init(&data->dq_lock, NULL);
+	pthread_cond_init(&data->dq_finished, NULL);
+	data->dq = dispatch_queue_create("FSMonitor", NULL);
 
-	FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
+	FSEventStreamSetDispatchQueue(data->stream, data->dq);
 	data->stream_scheduled = 1;
 
 	if (!FSEventStreamStart(data->stream)) {
@@ -501,7 +512,9 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 	}
 	data->stream_started = 1;
 
-	CFRunLoopRun();
+	pthread_mutex_lock(&data->dq_lock);
+	pthread_cond_wait(&data->dq_finished, &data->dq_lock);
+	pthread_mutex_unlock(&data->dq_lock);
 
 	switch (data->shutdown_style) {
 	case FORCE_ERROR_STOP:

base-commit: 7452749a781d84244ecd08c6f6ca7e5df67dfce8
-- 
gitgitgadget
