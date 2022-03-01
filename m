Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ADC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiCASpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbiCASox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC595D5FA
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r10so21974960wrp.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AlmY/gOlEO8HSZj05WOg2u+vIw14iQiErsBfdhO4tq4=;
        b=pTP5+EyUcfrqbj4xObHLNQen7u7pxkxAko2KmofNIxIznZjxdQEsW3ibRivR4SBVhW
         RSOiY//k2L3oWi6clde4l81sqnE6D//rGreH24BXPMj3bJjylLpS3DcOfp6FPUCloGHD
         esjIwNwtaDqNishoBWK31Rx0+F4+x/xkM0SAtUOq4dKn9FywQe0z7AFkcWSTbzpMS8KP
         uP33j2tD1OlPCCWLVBom2ailGrAVfTZAWAaK2FpqpQ4eRy3Zzuitg4ETF4CV6phKwR/R
         eVRrUnSsZCgZAYF+/Xw7FEdxSMw3rkVUsbvKYU2qNcs1K4eHzUHJBYHzbIReqwhfJeHQ
         pB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AlmY/gOlEO8HSZj05WOg2u+vIw14iQiErsBfdhO4tq4=;
        b=ZcknXNr1jmXRae7VsmLmx85vcVhz54nUOYxQZYwDas1dghF5dKKNB+hs21uF4RRJLu
         b5RSOcgZOCq93oIRVlNkUpJrJg5r/S33GJ3zdYILqWW36NWeuj5nJZQcH3fQBZBvXFVi
         hTo8qQqGRgcyMtrghn67gwSHXyTmYcmwG3jry0f0O4ummnZFGcIYkLbQPoOAWoz5yzSn
         CZ4D1pPgaVtpmWN56pX40d+hEv+H5ULwrfZfBTgaq0KkWm3ZmwvkomuvCTE+CHWPMVLX
         HUf6Ej7LFuAbs9F1ZVSCmke+IrfXB092OS/Q8+tizUD0bp4ub/47VMTrX6Yaxnd9uAcF
         Su6g==
X-Gm-Message-State: AOAM532d1WRJrKn/JXR4sN0g54QT5fIyl2cnD+BD3JJrv1pyN2kn+Ivf
        RZMl99O2PVkMDF+t73xP5r/3Pra3oTk=
X-Google-Smtp-Source: ABdhPJwpGkUj8YgF2KZQ90oL2KeH829x5SjPaDySlBcLHB3yTd6fWJS44JR7viDsYvrHf7M6H+g71A==
X-Received: by 2002:a05:6000:186d:b0:1e8:49fc:69ce with SMTP id d13-20020a056000186d00b001e849fc69cemr20397120wri.80.1646160225898;
        Tue, 01 Mar 2022 10:43:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q23-20020a1cf317000000b003815206a638sm3352589wmq.15.2022.03.01.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:45 -0800 (PST)
Message-Id: <c2f3668a866c3a795e15d8155aa9dcf2e7401658.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:15 +0000
Subject: [PATCH v6 13/30] fsmonitor--daemon: define token-ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to create token-ids and define the
overall token naming scheme.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 116 +++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index cb126883832..c8d1509d87d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -106,6 +106,120 @@ static int do_as_client__status(void)
 	}
 }
 
+/*
+ * Requests to and from a FSMonitor Protocol V2 provider use an opaque
+ * "token" as a virtual timestamp.  Clients can request a summary of all
+ * created/deleted/modified files relative to a token.  In the response,
+ * clients receive a new token for the next (relative) request.
+ *
+ *
+ * Token Format
+ * ============
+ *
+ * The contents of the token are private and provider-specific.
+ *
+ * For the built-in fsmonitor--daemon, we define a token as follows:
+ *
+ *     "builtin" ":" <token_id> ":" <sequence_nr>
+ *
+ * The "builtin" prefix is used as a namespace to avoid conflicts
+ * with other providers (such as Watchman).
+ *
+ * The <token_id> is an arbitrary OPAQUE string, such as a GUID,
+ * UUID, or {timestamp,pid}.  It is used to group all filesystem
+ * events that happened while the daemon was monitoring (and in-sync
+ * with the filesystem).
+ *
+ *     Unlike FSMonitor Protocol V1, it is not defined as a timestamp
+ *     and does not define less-than/greater-than relationships.
+ *     (There are too many race conditions to rely on file system
+ *     event timestamps.)
+ *
+ * The <sequence_nr> is a simple integer incremented whenever the
+ * daemon needs to make its state public.  For example, if 1000 file
+ * system events come in, but no clients have requested the data,
+ * the daemon can continue to accumulate file changes in the same
+ * bin and does not need to advance the sequence number.  However,
+ * as soon as a client does arrive, the daemon needs to start a new
+ * bin and increment the sequence number.
+ *
+ *     The sequence number serves as the boundary between 2 sets
+ *     of bins -- the older ones that the client has already seen
+ *     and the newer ones that it hasn't.
+ *
+ * When a new <token_id> is created, the <sequence_nr> is reset to
+ * zero.
+ *
+ *
+ * About Token Ids
+ * ===============
+ *
+ * A new token_id is created:
+ *
+ * [1] each time the daemon is started.
+ *
+ * [2] any time that the daemon must re-sync with the filesystem
+ *     (such as when the kernel drops or we miss events on a very
+ *     active volume).
+ *
+ * [3] in response to a client "flush" command (for dropped event
+ *     testing).
+ *
+ * When a new token_id is created, the daemon is free to discard all
+ * cached filesystem events associated with any previous token_ids.
+ * Events associated with a non-current token_id will never be sent
+ * to a client.  A token_id change implicitly means that the daemon
+ * has gap in its event history.
+ *
+ * Therefore, clients that present a token with a stale (non-current)
+ * token_id will always be given a trivial response.
+ */
+struct fsmonitor_token_data {
+	struct strbuf token_id;
+	struct fsmonitor_batch *batch_head;
+	struct fsmonitor_batch *batch_tail;
+	uint64_t client_ref_count;
+};
+
+static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
+{
+	static int test_env_value = -1;
+	static uint64_t flush_count = 0;
+	struct fsmonitor_token_data *token;
+
+	CALLOC_ARRAY(token, 1);
+
+	strbuf_init(&token->token_id, 0);
+	token->batch_head = NULL;
+	token->batch_tail = NULL;
+	token->client_ref_count = 0;
+
+	if (test_env_value < 0)
+		test_env_value = git_env_bool("GIT_TEST_FSMONITOR_TOKEN", 0);
+
+	if (!test_env_value) {
+		struct timeval tv;
+		struct tm tm;
+		time_t secs;
+
+		gettimeofday(&tv, NULL);
+		secs = tv.tv_sec;
+		gmtime_r(&secs, &tm);
+
+		strbuf_addf(&token->token_id,
+			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
+			    flush_count++,
+			    getpid(),
+			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			    tm.tm_hour, tm.tm_min, tm.tm_sec,
+			    (long)tv.tv_usec);
+	} else {
+		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);
+	}
+
+	return token;
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data,
@@ -298,7 +412,7 @@ static int fsmonitor_run_daemon(void)
 
 	pthread_mutex_init(&state.main_lock, NULL);
 	state.error_code = 0;
-	state.current_token_data = NULL;
+	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
 	strbuf_init(&state.path_worktree_watch, 0);
-- 
gitgitgadget

