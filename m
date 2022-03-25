Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD55C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiCYTbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiCYTbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:31:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037F20DB2F
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:06:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pv16so17245975ejb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=diJ2kF8fCXK8fuWsFs2qoSTo98Y5oZz+kxAWbs2iN34=;
        b=pRYQXi2+9XRJ6ar6k5xapqu7x1y7F9D+ZOiuOtG4yNVidyWQsQjuWT6YVwQvD1+mlC
         GE9VcqmOawBDYslznFGfwt9/hyUoRMi2sTSJH0VTVsaW7WFFDjQwCsks/xiSMXPdbNJW
         HMaezf2ilxkste4uCAvis2DqkwbdaTFCR/R5DgAwFevJKmVxBPTrW0WagZMfCani7OVB
         4Vlr4k/uKuiq6LIQNsTNJhPGNr+YLIyAZ+K2nloePUK32KZmudhOF9MN1ecc9D7qLDwO
         6sqa3PDkDjKPkX7rJBVo2rK3N6Km+LTeOcwZ6f+3+TPTm+wTk9+QgP+0tu8SujYNKBPr
         uZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=diJ2kF8fCXK8fuWsFs2qoSTo98Y5oZz+kxAWbs2iN34=;
        b=5HCSlZslVWC9mRD7dabd2hC0OVpPyEnUAlCQi5Q+2IjQPndpb+ObLSDcP6YyiD4mOE
         69IRWwmu9/xpmlGTVZr0hYgw6Rd8L+YawTwg2E1Vahc05xvc2zillXIV+ELIRo8yOZB8
         JRKwe40z8GmSdtOKFhQ0WUqtcpxpuxQPcwq7ab3FrMHS/ry3GocomQd4BTDJsOiW071a
         ray0mxBscQ70WahCmyMzg4gWoDVfdo8E4Z+7GdCmAjkFqKDNvaxmCLnhopVfOzr7savF
         AKnyBheFoyFQz+HuXKmeYv8HYluaM3T9pbsnwxscIL/VSIkI9vA8d+9KVXQBc2iQQMvF
         HIPw==
X-Gm-Message-State: AOAM530IRdEg2HjCD94jt7YECbXfoAdq6qFeyGYcdG20gZRq5nO0Idwa
        2QizHb/eLG/J7WSnJ6dNjuT/I02+cDU=
X-Google-Smtp-Source: ABdhPJzCWJSikK/lGO1UYeTf0E1YqrSYdFi3eZkH8kfaHhAyfLa68jRbO/cMgRCB5q5rN+NHascYOg==
X-Received: by 2002:adf:ba8f:0:b0:1e9:4afb:179b with SMTP id p15-20020adfba8f000000b001e94afb179bmr10366594wrg.57.1648231409296;
        Fri, 25 Mar 2022 11:03:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b0038ced37c182sm1713789wmg.35.2022.03.25.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:28 -0700 (PDT)
Message-Id: <53e06b4ae5d0eb1d3c2cb6a61ffd14abc36f6534.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:56 +0000
Subject: [PATCH v9 13/30] fsmonitor--daemon: define token-ids
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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
index 1ce00b7c150..1c7c156288d 100644
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

