Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAE2E1EF4
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710801; cv=none; b=qiphaERTH4Ix1BdLSzoX6YweJnYER3GUPbkHdVOV1X0si5RE4zFeFHz8s4cYJEtLkoQmiR9uQyYgBQMcFI1SrZbGPlg0LhXG2PKf63cWAv4zMddW3AxRJhgKJBdnqTf/KxwcCWbL2AyYqkIMAiXodktGcswUWECOwZOkXz87Wbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710801; c=relaxed/simple;
	bh=Q0d/Ef20dtkIcmHwRxMxOenO8jPGAB86/tXyNZ1E4aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qZkVUb8GR9WuFtCv+oqPH2teJFeMQUYQe9mT9Tvo9IDeY0VxyY8xMQ8cRBMNd2WBCGZnC0UVB2aQ3x2vNe/7k9cfKP8j5UwHhJIRLUv5nb1qFA7mxZeYC6BHT7GBxqtQqil2kGoi6oWrPx6OdAueBdl/u3ZsnBQVLuWQAed53aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQQa995w; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQQa995w"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d4f78fc9f6so48592185a.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710798; x=1776315598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=kQQa995wH7HWsx0vrdjm1KepBEutPDBMGIXJrodKCRl9Flq5g7YMFKvPO1iiHm98ZG
         eKENAe9AuxyVrR1AXq1D7A+JtlMroWkEesw3z8MRJOhojHem6/ZPZrOg6XqXPqpLDriq
         WYxgxtw/lejdm+U5W6WNXpGPi9DivwNFMHH/QCZWodrFL2VWdHXvq/GvYdt5kb1+M9on
         AtKh6beZdvBiA6d2KesrUGv/W6IOILU3htds+SC69hayhoCDWPwUSB1Zj8H9IilTCHOg
         h49MrK3+I2Ml1fzVpfn8JBYlxGcWCeJLhjmrqX9+yzveSNvQzVczY8WbbS52GvjS9b4j
         r7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710798; x=1776315598;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=LcRZ/B1yprbdeSWP6oslAQPI9cGT0+bIjvWFmZMN0Rb+yibEZi2wWdLlYMPRd8w8NB
         xVbEe8CejsF0+UzdXo81QZCh4LTIsa4VRkAHLj5ndiIqTf6uKC4V8rHiRfnpon8zXp5z
         0iWV7uLTefxqdWhDQpNkXhJQ/zuJjTmRL66eWAFY2r2piL8z6JwmKSSPQO3htd/VVTzw
         rRSZBDkZ24RzuvQSgwbzJI5euk+ddCOZRzzZB8fDBtmOJKb/48ke1cKpnwLGDva5bCAY
         YTFgZj0yPIa178norViVKBpQfrDxNwxLP1W5L92SM1Kaq0KTX8a2025yoz+33DtFvLMJ
         F0hg==
X-Gm-Message-State: AOJu0YxpzHbsdvOYZ3yaOo+xHZOpypJv9LPPXBorMi2Im9WlNFyqVfJ2
	ts3+AJ/ZiCchFv6xLBBBrVK6+iGXSJOKrouzXTzVnjNrAW7/KF59APfmhbaqsQ==
X-Gm-Gg: AeBDievAaQmr5qAUO6lgIdUInfpRck/RqchHCBks/ArFLrlDtGbCAkBu/zxOLxUpmlV
	SAYF0bHoTt8YNAHCYIuyV+31Zgh9Xrwmr2ronBrfH2w1dB/JRi29hatF88gPaTkj/vBbP2XryB9
	/1rNz8grNEaaS0lZklBeCFzXHUwUUsqHhcvs4a9hk0/7IiFMXhd4GlVhUBiknIZT1PsmD8qpxv4
	dXUFHz2EjBKHIuevRNRbQZRlrSRDA87UF/PqpBEJEj5LIJEiEBOc7804YpC+zypI/U+28gw936M
	SIXSJiTGKgYK8iCw+B2eSj484Eq8rkw6MzmyJdgwFqSR75HEfYLIiZfNOCqp9ene0OoHyaxZwkb
	lbHUfbgwMDkhPo1PybKosqF7ejG+O0FKTWAKHz1hQ154tJJxPIfpMah45VJlBjFyEGmihIwktxr
	H6Z9lVh5Nliz3WzJ2a16h+AjbQZ8A=
X-Received: by 2002:a05:620a:4610:b0:8cf:d1fa:7b3d with SMTP id af79cd13be357-8dc3b03d1a7mr339574785a.10.1775710798172;
        Wed, 08 Apr 2026 21:59:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d410c51119sm1448317385a.34.2026.04.08.21.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:57 -0700 (PDT)
Message-Id: <2085b21e23a4522e1848f6256a48817bd9d7ee09.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:35 +0000
Subject: [PATCH v14 13/13] fsmonitor: convert shown khash to strset in
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
index 53d8ad1f0d..f920cf3a82 100644
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
