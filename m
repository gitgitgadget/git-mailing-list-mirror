Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4872EC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiCASp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiCASoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2B2A24B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c192so8031554wma.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RhlYIwHUBo47mOG4YPeLwxrjGp3T3Jj14AUKPUXNhbc=;
        b=nFytLpr8peM8e+86tHqtI9QeX5uIc6xrBiOHUObPKnKF4dKxKp0XVysoepIVf1mN3D
         S3mclGs5yZcx/i76/vjal+LLisAsirIT70pAEVdKjWUuC4L9dFjMA5i7nwvKA0G6BmDK
         46BSxdY4HvyeIdgJAiLAtGHwBxcIgw2M6fnmZCeRSeqckrHD2rXBzlL2mKNsUf27Jl5R
         /5c4SUse2F007WlFiiv+vZ75TH7jOosdk+9cE3+6YHMOO//0QL04A8ViwnBbxIduyrAb
         FVxe5d9ZxuO5bIeYoZEcp5jRKXJbo7+aP5A5umss5tE8c2906zQ4EnDoURkyY5rjv+z4
         D9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RhlYIwHUBo47mOG4YPeLwxrjGp3T3Jj14AUKPUXNhbc=;
        b=QbeWysEa1qL5NAKJgIJATz2C2HgkAJDgq1YupAA3+l7It/UCmwM5Ea8R2W8hjvZ4U6
         pKG5BZWbTrI9SJitgYSZLHag/vrlBOJpUFnSvXjXKNYHF4rwRpn91/dVfGv7slbI5i8/
         Ff68IqG+Mc7IAB9RaMakQ1AYn9vtpqrMYUWE2XHZF8q86RMurCGLohlI9aZoqD4Fp562
         HDppv54bU44TsbCVAq/5TQL8yUHnGvtUPurjD6qhHO0Hm6TooupIWskDCs411P6Ur11M
         3lSh3FkUnSAJ8wwGds/Dl5KbPz834JQoCYM+sFYzV2+47Qah1BA6Kuzq4r+PZkRY3oBL
         CT8g==
X-Gm-Message-State: AOAM53382oODgMko1IzXI4xDjGvJ6qrWUNEQECeUiXoKdXhrs6PctQ1i
        48wo1U/9iMTbIiIZK6r6iXOz5P3czeY=
X-Google-Smtp-Source: ABdhPJyrALlyS1VcXd+LzZpHO1W2RW68sjX5knFqjKSxjsAH3yEIyYyeQRIX8wW2Z5TkitKnCMCBkQ==
X-Received: by 2002:a1c:a7ce:0:b0:380:eb26:f41a with SMTP id q197-20020a1ca7ce000000b00380eb26f41amr18112668wme.105.1646160230240;
        Tue, 01 Mar 2022 10:43:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b001a65e479d20sm13644863wrb.83.2022.03.01.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:49 -0800 (PST)
Message-Id: <0896e72e2b8e23354de9d476fbda55008a11de68.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:20 +0000
Subject: [PATCH v6 18/30] fsmonitor--daemon: implement handle_client callback
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

Teach fsmonitor--daemon to respond to IPC requests from client
Git processes and respond with a list of modified pathnames
relative to the provided token.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 312 +++++++++++++++++++++++++++++++++++-
 1 file changed, 310 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7c44b979035..65c1ef7d4bf 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,6 +7,7 @@
 #include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
 #include "khash.h"
+#include "pkt-line.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
 	N_("git fsmonitor--daemon start [<options>]"),
@@ -364,6 +365,311 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
 	pthread_mutex_unlock(&state->main_lock);
 }
 
+/*
+ * Format an opaque token string to send to the client.
+ */
+static void with_lock__format_response_token(
+	struct strbuf *response_token,
+	const struct strbuf *response_token_id,
+	const struct fsmonitor_batch *batch)
+{
+	/* assert current thread holding state->main_lock */
+
+	strbuf_reset(response_token);
+	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
+		    response_token_id->buf, batch->batch_seq_nr);
+}
+
+/*
+ * Parse an opaque token from the client.
+ * Returns -1 on error.
+ */
+static int fsmonitor_parse_client_token(const char *buf_token,
+					struct strbuf *requested_token_id,
+					uint64_t *seq_nr)
+{
+	const char *p;
+	char *p_end;
+
+	strbuf_reset(requested_token_id);
+	*seq_nr = 0;
+
+	if (!skip_prefix(buf_token, "builtin:", &p))
+		return -1;
+
+	while (*p && *p != ':')
+		strbuf_addch(requested_token_id, *p++);
+	if (!*p++)
+		return -1;
+
+	*seq_nr = (uint64_t)strtoumax(p, &p_end, 10);
+	if (*p_end)
+		return -1;
+
+	return 0;
+}
+
+KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal)
+
+static int do_handle_client(struct fsmonitor_daemon_state *state,
+			    const char *command,
+			    ipc_server_reply_cb *reply,
+			    struct ipc_server_reply_data *reply_data)
+{
+	struct fsmonitor_token_data *token_data = NULL;
+	struct strbuf response_token = STRBUF_INIT;
+	struct strbuf requested_token_id = STRBUF_INIT;
+	struct strbuf payload = STRBUF_INIT;
+	uint64_t requested_oldest_seq_nr = 0;
+	uint64_t total_response_len = 0;
+	const char *p;
+	const struct fsmonitor_batch *batch_head;
+	const struct fsmonitor_batch *batch;
+	intmax_t count = 0, duplicates = 0;
+	kh_str_t *shown;
+	int hash_ret;
+	int do_trivial = 0;
+	int do_flush = 0;
+
+	/*
+	 * We expect `command` to be of the form:
+	 *
+	 * <command> := quit NUL
+	 *            | flush NUL
+	 *            | <V1-time-since-epoch-ns> NUL
+	 *            | <V2-opaque-fsmonitor-token> NUL
+	 */
+
+	if (!strcmp(command, "quit")) {
+		/*
+		 * A client has requested over the socket/pipe that the
+		 * daemon shutdown.
+		 *
+		 * Tell the IPC thread pool to shutdown (which completes
+		 * the await in the main thread (which can stop the
+		 * fsmonitor listener thread)).
+		 *
+		 * There is no reply to the client.
+		 */
+		return SIMPLE_IPC_QUIT;
+
+	} else if (!strcmp(command, "flush")) {
+		/*
+		 * Flush all of our cached data and generate a new token
+		 * just like if we lost sync with the filesystem.
+		 *
+		 * Then send a trivial response using the new token.
+		 */
+		do_flush = 1;
+		do_trivial = 1;
+
+	} else if (!skip_prefix(command, "builtin:", &p)) {
+		/* assume V1 timestamp or garbage */
+
+		char *p_end;
+
+		strtoumax(command, &p_end, 10);
+		trace_printf_key(&trace_fsmonitor,
+				 ((*p_end) ?
+				  "fsmonitor: invalid command line '%s'" :
+				  "fsmonitor: unsupported V1 protocol '%s'"),
+				 command);
+		do_trivial = 1;
+
+	} else {
+		/* We have "builtin:*" */
+		if (fsmonitor_parse_client_token(command, &requested_token_id,
+						 &requested_oldest_seq_nr)) {
+			trace_printf_key(&trace_fsmonitor,
+					 "fsmonitor: invalid V2 protocol token '%s'",
+					 command);
+			do_trivial = 1;
+
+		} else {
+			/*
+			 * We have a V2 valid token:
+			 *     "builtin:<token_id>:<seq_nr>"
+			 */
+		}
+	}
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (!state->current_token_data)
+		BUG("fsmonitor state does not have a current token");
+
+	if (do_flush)
+		with_lock__do_force_resync(state);
+
+	/*
+	 * We mark the current head of the batch list as "pinned" so
+	 * that the listener thread will treat this item as read-only
+	 * (and prevent any more paths from being added to it) from
+	 * now on.
+	 */
+	token_data = state->current_token_data;
+	batch_head = token_data->batch_head;
+	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
+
+	/*
+	 * FSMonitor Protocol V2 requires that we send a response header
+	 * with a "new current token" and then all of the paths that changed
+	 * since the "requested token".  We send the seq_nr of the just-pinned
+	 * head batch so that future requests from a client will be relative
+	 * to it.
+	 */
+	with_lock__format_response_token(&response_token,
+					 &token_data->token_id, batch_head);
+
+	reply(reply_data, response_token.buf, response_token.len + 1);
+	total_response_len += response_token.len + 1;
+
+	trace2_data_string("fsmonitor", the_repository, "response/token",
+			   response_token.buf);
+	trace_printf_key(&trace_fsmonitor, "response token: %s",
+			 response_token.buf);
+
+	if (!do_trivial) {
+		if (strcmp(requested_token_id.buf, token_data->token_id.buf)) {
+			/*
+			 * The client last spoke to a different daemon
+			 * instance -OR- the daemon had to resync with
+			 * the filesystem (and lost events), so reject.
+			 */
+			trace2_data_string("fsmonitor", the_repository,
+					   "response/token", "different");
+			do_trivial = 1;
+
+		} else if (requested_oldest_seq_nr <
+			   token_data->batch_tail->batch_seq_nr) {
+			/*
+			 * The client wants older events than we have for
+			 * this token_id.  This means that the end of our
+			 * batch list was truncated and we cannot give the
+			 * client a complete snapshot relative to their
+			 * request.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "client requested truncated data");
+			do_trivial = 1;
+		}
+	}
+
+	if (do_trivial) {
+		pthread_mutex_unlock(&state->main_lock);
+
+		reply(reply_data, "/", 2);
+
+		trace2_data_intmax("fsmonitor", the_repository,
+				   "response/trivial", 1);
+
+		strbuf_release(&response_token);
+		strbuf_release(&requested_token_id);
+		return 0;
+	}
+
+	/*
+	 * We're going to hold onto a pointer to the current
+	 * token-data while we walk the list of batches of files.
+	 * During this time, we will NOT be under the lock.
+	 * So we ref-count it.
+	 *
+	 * This allows the listener thread to continue prepending
+	 * new batches of items to the token-data (which we'll ignore).
+	 *
+	 * AND it allows the listener thread to do a token-reset
+	 * (and install a new `current_token_data`).
+	 */
+	token_data->client_ref_count++;
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	/*
+	 * The client request is relative to the token that they sent,
+	 * so walk the batch list backwards from the current head back
+	 * to the batch (sequence number) they named.
+	 *
+	 * We use khash to de-dup the list of pathnames.
+	 *
+	 * NEEDSWORK: each batch contains a list of interned strings,
+	 * so we only need to do pointer comparisons here to build the
+	 * hash table.  Currently, we're still comparing the string
+	 * values.
+	 */
+	shown = kh_init_str();
+	for (batch = batch_head;
+	     batch && batch->batch_seq_nr > requested_oldest_seq_nr;
+	     batch = batch->next) {
+		size_t k;
+
+		for (k = 0; k < batch->nr; k++) {
+			const char *s = batch->interned_paths[k];
+			size_t s_len;
+
+			if (kh_get_str(shown, s) != kh_end(shown))
+				duplicates++;
+			else {
+				kh_put_str(shown, s, &hash_ret);
+
+				trace_printf_key(&trace_fsmonitor,
+						 "send[%"PRIuMAX"]: %s",
+						 count, s);
+
+				/* Each path gets written with a trailing NUL */
+				s_len = strlen(s) + 1;
+
+				if (payload.len + s_len >=
+				    LARGE_PACKET_DATA_MAX) {
+					reply(reply_data, payload.buf,
+					      payload.len);
+					total_response_len += payload.len;
+					strbuf_reset(&payload);
+				}
+
+				strbuf_add(&payload, s, s_len);
+				count++;
+			}
+		}
+	}
+
+	if (payload.len) {
+		reply(reply_data, payload.buf, payload.len);
+		total_response_len += payload.len;
+	}
+
+	kh_release_str(shown);
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (token_data->client_ref_count > 0)
+		token_data->client_ref_count--;
+
+	if (token_data->client_ref_count == 0) {
+		if (token_data != state->current_token_data) {
+			/*
+			 * The listener thread did a token-reset while we were
+			 * walking the batch list.  Therefore, this token is
+			 * stale and can be discarded completely.  If we are
+			 * the last reader thread using this token, we own
+			 * that work.
+			 */
+			fsmonitor_free_token_data(token_data);
+		}
+	}
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
+	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
+	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
+
+	strbuf_release(&response_token);
+	strbuf_release(&requested_token_id);
+	strbuf_release(&payload);
+
+	return 0;
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data,
@@ -371,7 +677,7 @@ static int handle_client(void *data,
 			 ipc_server_reply_cb *reply,
 			 struct ipc_server_reply_data *reply_data)
 {
-	/* struct fsmonitor_daemon_state *state = data; */
+	struct fsmonitor_daemon_state *state = data;
 	int result;
 
 	/*
@@ -382,10 +688,12 @@ static int handle_client(void *data,
 	if (command_len != strlen(command))
 		BUG("FSMonitor assumes text messages");
 
+	trace_printf_key(&trace_fsmonitor, "requested token: %s", command);
+
 	trace2_region_enter("fsmonitor", "handle_client", the_repository);
 	trace2_data_string("fsmonitor", the_repository, "request", command);
 
-	result = 0; /* TODO Do something here. */
+	result = do_handle_client(state, command, reply, reply_data);
 
 	trace2_region_leave("fsmonitor", "handle_client", the_repository);
 
-- 
gitgitgadget

