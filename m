Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99B3A5E84
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259685; cv=none; b=do44b6QIXQHQcQqJVhCBb6IEm0h0mE0pjVWKI44AMiHytQDJw8WICTSxEA9ThvioNiBlA+neQciWWpA2vw7vDwtjWQHoEnAyMZSN0PMQ5Z5uSFqduW7ZH3gb6Ym6HDkxzRWHKZLbcnV5xeVgal0ITdI9qKcguRysLj5g8xOKfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259685; c=relaxed/simple;
	bh=Q0d/Ef20dtkIcmHwRxMxOenO8jPGAB86/tXyNZ1E4aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KfUDwTvpqpzE8dU/5MIYHaXAWMI1uj3AUwF16jejP+GmOolTAVcEAWWomlY+5PtanVEIEFjWPtW+ndkRl/E5FIEo4nAA4jq2iXPCk8wkHDfG/iI78iSmwm85mIqoJKvtzx6E2sWEtCf4H9nouoncCgfbeeCKS3nefRpx3RnKaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irs9+h80; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irs9+h80"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8dbbc6c16b2so874627185a.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259682; x=1776864482; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=irs9+h80r9EUObxG2F3Bokm5AuGXbO7h6IatzbefbGqdC/bHw0U6O50PUNh7q6tIpa
         L8mfJqX7ticnRnJioGf5+/NisJbWT2j1go64QLvPupPDYPTA3nijhzHNxd7azn+s1Bxt
         gW9m4q88cdQettMCGODP2KSICRg2IbrvEOCjEW/UvcNkljes64lQBTi3y7U3tOPPaux9
         IEpghyVMS9oBocx8BKYinWKZJD8B7U2yz7iEBsTbwz1zYy1YEqopDsxEvSYoJgvjPWw4
         tcMlc0qQI++nB6mP57FRu1yCKIUoPjxGk46n92s5zr5zb9B9n8Maz9J0iCiZ2giiRc50
         sjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259682; x=1776864482;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=HkSNhakEJS7wKKUqpy34yQ0A1Y//JyW9AthnDet7sL8nAAzGvz7dUMbqlmNIohIeP3
         OzZHBXyierxRTveUz8HYHXMP26/+qx/yCKGp+XgJMOVtJrckN/ZbRhHY/spaC/Ffax+x
         dVQuPjgcf59XXQOoBFuiFgfOTaZ5RCJhdz+Ucwi8LqA0OuJxM1qHazaPkN/eJsA2JfkE
         P77+XEvLXsC0xKffRYYkF8KQDbtaW5ckq28pTSEWWR1P0P7GtgHxp3ifFl7SHueNjuM0
         W2T+uVk4QeDbTmdFzN/VoavVo6PpDtcKrS7RlAZ1LhdksLRmTs2FqJ2kZ4bjVgkgY3xw
         7KuQ==
X-Gm-Message-State: AOJu0YySs19xb5SEDmAIz7K+qycitblU/CsIHi35cQd09pSM7yhMe3er
	Q2NzcuOkKK9jzCvcfM0NPe+WFst/XmnWUHLt4oUfq9UM+Z9sufnV4bY0DQ96hQ==
X-Gm-Gg: AeBDiesmgRqpmYUimAsYX3byay21P8iQfCEkch2b/RbZGSkzbkpzAM+0QHvTE1+IThi
	G+6RMoyqDRtCkqUURYKito4RICpzWdkTdvyRekVp84dFngX1ES6nvHlBRJGlzb/LoAXtN+HMF2C
	cw6w7jOaIFlIbwfTxTKB4EGZsKMJ+Hx31VP04KsFHmLt/VXOrgsv+X7P80KVFfav/bKULVmslYF
	cPBl+bJr9G8EC8CG+k+Vngin0AsDAh65jKYxKEPSco2dEtQsUCt8Cucv6I7VrOwZLhQVTmYB9hZ
	QlGrMZuHJ2ZAcI6ff9x0Gj9BAPWAC+J/ATMBwLsnjy521UiNZiXBW0jKLlprpFJqLZOZV+dMCuJ
	Lf05pYuLkibyCLMD4cFjt6BJqx3FAi0cb2bzo755498gAIj2XQ3JGaOCmh6eXPGtihgA58RzET9
	eV50LZK/xDUBpNP3AIt1Kb5D+bzw==
X-Received: by 2002:a05:620a:44d0:b0:8d6:e3ff:16b8 with SMTP id af79cd13be357-8dc439f32f1mr3121085285a.6.1776259682247;
        Wed, 15 Apr 2026 06:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33bf5bsm118921385a.15.2026.04.15.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:28:01 -0700 (PDT)
Message-Id: <ada3f1888bca69347406aa8188714399d819b3d8.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:37 +0000
Subject: [PATCH v15 13/13] fsmonitor: convert shown khash to strset in
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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
