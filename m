Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C65393DD3
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498121; cv=none; b=h4TK22BOz2+HrJeHLDrarGG80d9TxYGbFaRvZ/aY/Sa1BSbaYstNqShpGWM8kyP/ZgMcqP8QAOELbpM4fPOjpvLwg2OgazWOjdGfJqu+k1AIljecJuFYb3PYC50HlmhrwvdKhaIKyIdrEfVLfyO92u2QXveKN/TqnRFmQ3VGrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498121; c=relaxed/simple;
	bh=Q0d/Ef20dtkIcmHwRxMxOenO8jPGAB86/tXyNZ1E4aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E2RdVTEO4FcX3l+VuJK24K9gBLK++gwTlN6beUFUd7JfZ+2+RMbl034W8NQQMs6T0cqmMbK4HEiwf1vupvJOXyNA2SR9uUqcL7F8ZJbdC3gYIUWSEMVDm3s8hkR+tcy+r8UU1/VFA04HNNv5xTnV7oDRZsL8yIZ4X50NO1uNuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmTZM55f; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmTZM55f"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c0b72dac7so1399104c88.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498119; x=1776102919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=bmTZM55fseRfr7EuN42JvMgbsZs1Qo9Clog/Rin6imacjgoGp2/6uwmf7VQQihPy5f
         ATOC7cyWLepPpDvk1VSmycmIOjAr7QGQIG4d8kYlXudWdNfFjvg1u8617XOsGmsjUezF
         jqfGr8r9TP4G9UMi42ohppGiFdmVyln1KEngXOimOBUnhj+1+HJSiF61Y+CGTdHsxibq
         jwpOK7AwA9E+oflu12SoZlhRE2RdA2i0PqpgZqBum1MP950AGvJDcsMOci7dHEtptZML
         ngeKakK1ZRIsqXpH0eGTxQF9G102P93uoGKhH+oYq6hcB3Kltd6F7WAPNn4VPbCicStS
         Y5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498119; x=1776102919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=U+f7ZSydwAoPwpqsBs92gmgbON9JymPkj3xrm/7tOnyl30GNpLwgpIDtOkbqXPsaH+
         +kJ1ABsOnDAGxbjpXikh2uJKeOvsVjKq/te5oWc6Fd50ohJifvunfHA6tbX7ZXCZ3VhS
         BNslHAO4bN5HJ8CNqIXouiZeDxMqWeXI4IU0jrl5MI+GoUeYyOw95FhgpWO3iDxezta9
         1dqJ0U0/Xbq/nf8ZbejUcR3LxaoB2TWyZVCQXkGDeUCMEquPv/v8R0bSrmmrfiWJA4P/
         Ve/upm1XicX2X+OFdv2O7kmTf5QOfGWbdrn3yaT3wuLezcvvKvyHDqdyArCB0/ZdFuWy
         FJDw==
X-Gm-Message-State: AOJu0YxybtCqtLYPrKDQLs7o1GHxnLH9DXZMjHVmO4Bq84jqqAYnJmLf
	zu0YEaOvaU70LAWVKKfeUUetgy6SeJntSj6XA+I0t14kQtOPS8ByJaXoZSBMyA==
X-Gm-Gg: AeBDievw7LPOCy/7kwLK9Kuo1iqPAYr1Sy23gY1F+J6aeUfbqX6kJCAuV05CDf36cd4
	zD0eHHzQzSAcNkWA5JIvOvxEJJPjYdmuZiI0uby8CTByv9E1FuXAl+6P6NpUeuQDSFjGKDmuf3P
	Ko0O/vKSDVQb2xmJoZyciIkYOfNRyFV9VcX5OtPByJKcabQQbQssdQNXEJbUuLnOT6sYnEI99F6
	VFRmek+/n/xHG3eIZ9JzNEOiLuAZWmheYsTVqBMvyrra1P5VwPY7T2Fz8sbFVxl9opJA3CExwdU
	cZ1Bj6UiyXuhEFHBzExUO9mzosEElvSswoiDXt38H+5uBGzlwSJXIt/QIrxP2HjOnJuvJWvfiFO
	Vnby+aRelia7+wadQXxrA8HjTzlXW1ZSG0gBdMTmnEeo4+4+sc3zc2tWB40/OzVbivGqe5Rkpq8
	O1qMSnY2uv0PCe9LZirmG5Bd7zSAM=
X-Received: by 2002:a05:7022:325:b0:12b:ebb9:1c0b with SMTP id a92af1059eb24-12bfb77ecedmr6279989c88.31.1775498118989;
        Mon, 06 Apr 2026 10:55:18 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm10568563c88.2.2026.04.06.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:18 -0700 (PDT)
Message-Id: <a5fc9ad4156a6f6ccf954e9b2571774b2bbd2036.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:58 +0000
Subject: [PATCH v13 13/13] fsmonitor: convert shown khash to strset in
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
