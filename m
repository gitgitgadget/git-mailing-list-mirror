Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8623A9AD
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673402; cv=none; b=uZeJxEDK75bQXhz15ccvWPpvsM7zmGSCqp8fQyoIbvWhGeQl5wfV9VeXPd4UC6iiHuq9LV9RmBneHQH7Gt+m5XUmYC9QJTMayjSNAVK+s/LSc5NpAdz1uwxJoBUVvkYEB+gYjmMVa/UVl8f1NpFoj9QGybMLsH2tafwhhgpgkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673402; c=relaxed/simple;
	bh=zWNzExDQDpllDbjXRZO+uHXwmYibKapVL6EwXj9C7IY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SsWDL8drNFi+br4IuI1KGoWmGcgBcIC9QRhGy+gVtq0E661RweQ8uWRN8anPLr9Dsiq/wN7M0pPBYclUZyuxhGoq8+Utd9QoDrdyI0Lp6AwA7lJzRvAa2jGBos3qd83nNJT+uL9Rb3BchlQD1qn8Ju840vE6i4NDekB0oZi8oMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU7L02L6; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU7L02L6"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899f5d337f7so44847066d6.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673400; x=1773278200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDeiv6howeC2ELq4Mp7JxtU/RGYCudmcQdK6m6JarKg=;
        b=UU7L02L6/oDrhn5WZys5FnNUoqfyZtNft3tKe65Y65LPhKBbLWr5VTuIJPQE0F+RcB
         xcbxWXKlGV49iPLqT89fK5zL8Lfj8Kq/WBhT1VWY6ccMKt4jKmIytea9bN9hyNjff9m7
         kt+KhJMqmDtjM2mrzEViYD/ec6+vMQkNVa6CltZUdznoZNXn7tX9hZtiZEq0OrQVreDK
         9a1c28DMX6SOEP0NaXU0nXYzRTdRC2kgT8XjXWz/YTZcqcH6RL+dCKu6Eo4AQYM0/O3o
         typKR8k53d37Xv5lj/f2SJRCNwGae8yHM5GORl3fqVeUufleH0QJI4Ae3cxCJotL9hi4
         10eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673400; x=1773278200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDeiv6howeC2ELq4Mp7JxtU/RGYCudmcQdK6m6JarKg=;
        b=FVB1/ON0xBbc/buZX/bey1NEIn+hEBNGO9hxmbl57oYm511tsphuT8pSv5Ge7kZLei
         nQ5uCNCcv2qNIuGzTrNzvHWkT2dvhLIob9KRcApta3NGjSqNj3+FywoXzfCb7sj7Q3V/
         qzcCGmHZ4bKsgSKzPOwh3YMazQacrjiIx9SsotTK/5+/WFB2+Hm1mnq+PyR/+7wBNxVu
         6MfXVf4ISKJoRjweUTFjZN3shgw/74Jf1c/vAhdsxNLRip1g0vMD5gfRKr1cil2FG4d3
         TFUI62ZQlYEHOVFfRs0NFEw2irOWYDz81nkdXPJniVO4qetN8Tc8jc0guSs4w+sF8Q9l
         +KTQ==
X-Gm-Message-State: AOJu0YyCOCGEahpgIBF+XTz4yzH4z3ce6jT7RIPxKQa+RNv1fDqGxd0G
	/57oQ4XRBagvu6q5RgEUToayUaepljVK2TqYhbBXrLV/s8jZYk9T5UGjBdMNGAPP
X-Gm-Gg: ATEYQzwWd3fG0Aoea7KWnJFPEFplDi+qMl0h5a7ewpa1NEnspTU/LFz+9F/hB/+oK4A
	e5r4xo/PMQBe6EX0FITAd2E7vKLunauTEdIj4cjC8U+8uJHBo7uKSxUr5QA9bEfjq5LAzknYBqY
	1eTzPvHaByLBa19cIjfNFFSXFgV20e2f8Q4gR3LZbmOmx0beZ9/MKFAO0I3zb3AES8Tp4E5KrtG
	m1RbLxR7eXj7s+5KpSm6Rdt//KuZBgiM0Z2za/g1x03vquZ08fMKt4a9jgXDpegySb8PDxE/Shx
	JDKsSOy+bZ6wvfoJfHGVZAg8C11PVyZr3XG46v7dQjGk7Dr3lDCdhoEi7dbjwMs2PU7+K5uJwxP
	1zxl3c8xxg+RhSMT7XVeG7U9ZhWUKGj5RAVmbzT/bH9Nzk6updpdZDJ+GyzicQfflLeNJ52oWsa
	pCa+S6bJw9p6Q0+VpYuGfVtO8=
X-Received: by 2002:a05:6214:2521:b0:899:a586:2923 with SMTP id 6a1803df08f44-89a2490098cmr8401506d6.28.1772673399563;
        Wed, 04 Mar 2026 17:16:39 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf677448sm1712969785a.19.2026.03.04.17.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:38 -0800 (PST)
Message-Id: <8ea20aab4c71454c5abebbecfdef451eb4146ed5.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:18 +0000
Subject: [PATCH v10 12/12] fsmonitor: convert shown khash to strset in
 do_handle_client
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Replace the khash-based string set used for deduplicating pathnames
in do_handle_client() with a strset, which provides a cleaner
interface for the same purpose.

Since the paths are interned strings from the batch data, use
strdup_strings=0 to avoid unnecessary copies.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 299de2e4e2..b4b2a304e5 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -16,7 +16,7 @@
 #include "fsmonitor--daemon.h"
 
 #include "simple-ipc.h"
-#include "khash.h"
+#include "strmap.h"
 #include "run-command.h"
 #include "trace.h"
 #include "trace2.h"
@@ -674,8 +674,6 @@ static int fsmonitor_parse_client_token(const char *buf_token,
 	return 0;
 }
 
-KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal)
-
 static int do_handle_client(struct fsmonitor_daemon_state *state,
 			    const char *command,
 			    ipc_server_reply_cb *reply,
@@ -692,8 +690,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown = NULL;
-	int hash_ret;
+	struct strset shown = STRSET_INIT;
 	int do_trivial = 0;
 	int do_flush = 0;
 	int do_cookie = 0;
@@ -882,14 +879,14 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	 * so walk the batch list backwards from the current head back
 	 * to the batch (sequence number) they named.
 	 *
-	 * We use khash to de-dup the list of pathnames.
+	 * We use a strset to de-dup the list of pathnames.
 	 *
 	 * NEEDSWORK: each batch contains a list of interned strings,
 	 * so we only need to do pointer comparisons here to build the
 	 * hash table.  Currently, we're still comparing the string
 	 * values.
 	 */
-	shown = kh_init_str();
+	strset_init_with_options(&shown, NULL, 0);
 	for (batch = batch_head;
 	     batch && batch->batch_seq_nr > requested_oldest_seq_nr;
 	     batch = batch->next) {
@@ -899,11 +896,9 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			const char *s = batch->interned_paths[k];
 			size_t s_len;
 
-			if (kh_get_str(shown, s) != kh_end(shown))
+			if (!strset_add(&shown, s))
 				duplicates++;
 			else {
-				kh_put_str(shown, s, &hash_ret);
-
 				trace_printf_key(&trace_fsmonitor,
 						 "send[%"PRIuMAX"]: %s",
 						 count, s);
@@ -973,7 +968,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
-	kh_destroy_str(shown);
+	strset_clear(&shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);
-- 
gitgitgadget
