Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F985C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiCASpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiCASo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957786622D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so21923080wrg.11
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eGVqXr10YN37Ri5pZmcpjgcOL550mL38kfNfCfBeJaY=;
        b=CvBLZB60iT9pN3xH8cXKwOYM1whtcBLlAP7Jcd0DdFitagi3HQOQzCivoXXZO9eXxF
         lJw6JRETncqVfGWVAJdi8zbtu7gIyJsX6WUd1+05Cztq3jCX6yg8foIZvolZhrKPHGzq
         qTBgrbJpBjIHzAYGlY4y+n5Dg14hJ/Kpzbhsv2cQy5kqSQLIscsAkt9M+C06REZGyE5U
         DXClMIFgCnfetcwWs83o3Vp6SiC8QVHFudoTndxLmGsGctM4gOIzeSfpC0vp2BO8j5Q3
         s4nL8sqeL7Ln7xHbgwMxszgR2xLFzz+rGY7EkqxXSPh7bWo1F1AQ+GrfppbTqlBHBgbH
         xEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eGVqXr10YN37Ri5pZmcpjgcOL550mL38kfNfCfBeJaY=;
        b=vy5sCdgPm/jTqH+0tUeLAu/C0sghVUik9+7PVMWOvyAbrcYTEMlf71tMatLcibm/xZ
         lm0jLfn0nARns5l7WqS/NqhSkZx0sr2QJuwKn6XCZglmesjzCJQUz/eIHiUnK6ReibsS
         HrA36IAFZ0iPumrdY4yKIIbdz+D3/SCHC9Pa0sdstL3SO2oa1JGDSzh7H372EBvXNuDN
         EnyiPotGna+OympkyYst3Fv1fseW8LBvvl0s6chBTOBsxXeRUJEm97c/5afZ3UuESJGQ
         mqe9I5mZkGWOmHiG0n88NDCtUVMZ1ZP6C8cE7Pu7artnE+H64YraOsACWgU7ON5y2DTn
         mUFg==
X-Gm-Message-State: AOAM530KSjnIIXUGEL78wbwJPsAykXFYcqbv2ElnBgCmkcN4FIU6+HTd
        XspMPWWTaPFavkUYR0AaZlKDd+1rU9Q=
X-Google-Smtp-Source: ABdhPJyYC5BlDEHlpa51XFNxFdW6KXXSGa4i0wwhR7zT+rQSCiNf2PIoApieO/N42+H4pPfrb6xi7A==
X-Received: by 2002:a05:6000:1888:b0:1e7:cd21:c24f with SMTP id a8-20020a056000188800b001e7cd21c24fmr20520276wri.308.1646160237003;
        Tue, 01 Mar 2022 10:43:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm14431957wrs.16.2022.03.01.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:56 -0800 (PST)
Message-Id: <64a5b7416702c8bec948a1c3e289e18f9b6f87d5.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:28 +0000
Subject: [PATCH v6 26/30] fsmonitor--daemon: periodically truncate list of
 modified files
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

Teach fsmonitor--daemon to periodically truncate the list of
modified files to save some memory.

Clients will ask for the set of changes relative to a token that they
found in the FSMN index extension in the index.  (This token is like a
point in time, but different).  Clients will then update the index to
contain the response token (so that subsequent commands will be
relative to this new token).

Therefore, the daemon can gradually truncate the in-memory list of
changed paths as they become obsolete (older than the previous token).
Since we may have multiple clients making concurrent requests with a
skew of tokens and clients may be racing to the talk to the daemon,
we lazily truncate the list.

We introduce a 5 minute delay and truncate batches 5 minutes after
they are considered obsolete.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 65c1ef7d4bf..6ca4f5959e6 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -312,6 +312,75 @@ static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
 			batch_src->interned_paths[k];
 }
 
+/*
+ * To keep the batch list from growing unbounded in response to filesystem
+ * activity, we try to truncate old batches from the end of the list as
+ * they become irrelevant.
+ *
+ * We assume that the .git/index will be updated with the most recent token
+ * any time the index is updated.  And future commands will only ask for
+ * recent changes *since* that new token.  So as tokens advance into the
+ * future, older batch items will never be requested/needed.  So we can
+ * truncate them without loss of functionality.
+ *
+ * However, multiple commands may be talking to the daemon concurrently
+ * or perform a slow command, so a little "token skew" is possible.
+ * Therefore, we want this to be a little bit lazy and have a generous
+ * delay.
+ *
+ * The current reader thread walked backwards in time from `token->batch_head`
+ * back to `batch_marker` somewhere in the middle of the batch list.
+ *
+ * Let's walk backwards in time from that marker an arbitrary delay
+ * and truncate the list there.  Note that these timestamps are completely
+ * artificial (based on when we pinned the batch item) and not on any
+ * filesystem activity.
+ *
+ * Return the obsolete portion of the list after we have removed it from
+ * the official list so that the caller can free it after leaving the lock.
+ */
+#define MY_TIME_DELAY_SECONDS (5 * 60) /* seconds */
+
+static struct fsmonitor_batch *with_lock__truncate_old_batches(
+	struct fsmonitor_daemon_state *state,
+	const struct fsmonitor_batch *batch_marker)
+{
+	/* assert current thread holding state->main_lock */
+
+	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *remainder;
+
+	if (!batch_marker)
+		return NULL;
+
+	trace_printf_key(&trace_fsmonitor, "Truncate: mark (%"PRIu64",%"PRIu64")",
+			 batch_marker->batch_seq_nr,
+			 (uint64_t)batch_marker->pinned_time);
+
+	for (batch = batch_marker; batch; batch = batch->next) {
+		time_t t;
+
+		if (!batch->pinned_time) /* an overflow batch */
+			continue;
+
+		t = batch->pinned_time + MY_TIME_DELAY_SECONDS;
+		if (t > batch_marker->pinned_time) /* too close to marker */
+			continue;
+
+		goto truncate_past_here;
+	}
+
+	return NULL;
+
+truncate_past_here:
+	state->current_token_data->batch_tail = (struct fsmonitor_batch *)batch;
+
+	remainder = ((struct fsmonitor_batch *)batch)->next;
+	((struct fsmonitor_batch *)batch)->next = NULL;
+
+	return remainder;
+}
+
 static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
 {
 	if (!token)
@@ -425,6 +494,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const char *p;
 	const struct fsmonitor_batch *batch_head;
 	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
 	kh_str_t *shown;
 	int hash_ret;
@@ -654,11 +724,29 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			 * that work.
 			 */
 			fsmonitor_free_token_data(token_data);
+		} else if (batch) {
+			/*
+			 * We are holding the lock and are the only
+			 * reader of the ref-counted portion of the
+			 * list, so we get the honor of seeing if the
+			 * list can be truncated to save memory.
+			 *
+			 * The main loop did not walk to the end of the
+			 * list, so this batch is the first item in the
+			 * batch-list that is older than the requested
+			 * end-point sequence number.  See if the tail
+			 * end of the list is obsolete.
+			 */
+			remainder = with_lock__truncate_old_batches(state,
+								    batch);
 		}
 	}
 
 	pthread_mutex_unlock(&state->main_lock);
 
+	if (remainder)
+		fsmonitor_batch__free_list(remainder);
+
 	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
-- 
gitgitgadget

