Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A181C433FE
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiCVSDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbiCVSDG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:03:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE166FB9
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a1so23180708wrh.10
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ETiPx8EtU8HETsng6twaAPHkDFgjzi2tLgoFcjpscI=;
        b=pcd8ltDcsrg0G/RtrsVin5L6pbieTeHXWiuzzEMa8jOplNSaesDi3ZxXHVwFo8dzHp
         51NElsSQzJwfbGFl6B2Mn1YPLB7EHub7UYv5kXgDrOfragNBy6yQdn6LGaKQhR2jGGLs
         gHYicSiWKDnZw5IoYmzpt0wbUzbRRvn5GNf3xbfryIji73g1sHlr+CPuEmC7VGv+Fmtt
         Irxcm+rodjTJCfbzM0Q0jGu1gtV49t1q3zT3rAht+JjS1pkicdWuC2mb6VWCijMUeww8
         HF5k+0MstAGx7DDREkI5gR6JBIqoQulXs6rE+9TcKU6dlu3ZyQw7MOAbbg/5ylLY6kai
         Mctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ETiPx8EtU8HETsng6twaAPHkDFgjzi2tLgoFcjpscI=;
        b=JnYnUg6nGz383Fny/mVQAgBslSSqZp8+wcrHf5Y1XAAI9sntEf5eUtWhUKaGCntLzY
         csR5M+C2AsitjmlHYkJX9TGd1a4Jscus5pviQ3/3i3vIN+25hBsWkLipRHGFEiNWolO6
         Sp5hsbu/qdxuujShT/r4bwZ/u/ukXFQNouo4mBzHOfGBp7dpyfqQN5dhVLAwa5yfu9qb
         1W/Ht8IqWjaBeh4QxuLAnzHzugToB2q9u2+fDZJt2C7PeZ3ne81SrYcdNLFUnhW8CyPY
         vurGyL2cQoaK2dKF7lGnnV9rOFQod8Y4Zzr7J4JDsjxx6J8e1b2EoiBf4Cbq2qyFVH+o
         3iDw==
X-Gm-Message-State: AOAM530BRQ9H3fpl6VJ71l9VB5R4O50bHlHL5jUfd1nd7cXQhxtDJjR1
        rDC1oN5nlahary6vDzIBoLyr/xmZUag=
X-Google-Smtp-Source: ABdhPJxLKwy9crOCQ5zHLSQpHhlv7/wkFNgMQWAGjsXsq2WGRmeTcDnecSkv6cBjMr4laB4aSSpgXg==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr23873589wrz.690.1647972054891;
        Tue, 22 Mar 2022 11:00:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm2438035wri.111.2022.03.22.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:54 -0700 (PDT)
Message-Id: <42631259e89e0f5306befe17da519b2c34cdd207.1647972011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:07 +0000
Subject: [PATCH v7 26/29] fsmonitor--daemon: periodically truncate list of
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
index fc3aee0ada0..edd00379cca 100644
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

