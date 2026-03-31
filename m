Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B6385509
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937993; cv=none; b=oU82Bb33TwK3DFFs3QgfXzTOA3GYKVG3Pf99cZAxE1P5e7iqz59otJj25yJRjvQotCkPTU+fMS9rVAm7VLBPi/LkRbmEF8OOdWJ4hKcQu3gGROOdqjhXy6O7RjfzQyiS0MzM2+sufdJNJWzPeOqu7nqJ9JSGu4UHrK6SZxEJ0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937993; c=relaxed/simple;
	bh=Q0d/Ef20dtkIcmHwRxMxOenO8jPGAB86/tXyNZ1E4aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Twh+hbV4ZcvxjmY6r1xxFl9x9IMWZZL/A2EK0YSFFYyrk2nC+xb7fktmBLB8lAs9BChFk2LkLZrKZcyQhOUcOm5OxbPoeuQ4sFQNWwFjiA9wZpBrQfinhB66UD1ENZ5qQOXKun5VlR7EXec42oqc/bp/HPCQMWfDJy2OSDNILqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJEkXn9N; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJEkXn9N"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-46aa216a5edso1659914b6e.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937990; x=1775542790; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=gJEkXn9NbbQxKrU3pl3Qn6e1T7o1li9ra4UKgnRVgiNeePe7Ryssb9gS7E3WzrakV8
         WqIxfaYHRhAq1GtTZC3MYGWezqIyxtuFr3JwBLXod3cD9RlQ5ipSwFuXjGCeAAs1GYVN
         sH6oFHG4OUdBl463Xa3s6RsYbZc2lrK70+DPrP/ykXo5544khievgbBRpLc8WotGNia0
         KlfjeQtRCVYXEsIz17omlMXjvSTh61iC801Q7MeSE7uppkcKir13YYZW57uuqAtccNpc
         8n2r2Tvou8+fZoqd8iX4fcRh9F0EaY+PC1gsQqhx0+4aeCAgi2xosMws3/sWXIRZTFRL
         K3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937990; x=1775542790;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+Mc1QEWcey+40oZe1Jt9GSTSctxikuciu1qFE2Rp4A=;
        b=P6BVEDFlzc5kFTHPoXCQvPlkWBMjDR1a3JwFacWIR38tnT/nI+N2U3rMVHpE14kHjf
         bvW/HXxQ0/3JYHMg4FXaSZTykpGb/jq224DnWrg3PDHvfPlHCPfzCj5k21AoZqK/Mcst
         Dt2medDxokkGb277Ox03OLBVhrCv/N+Uca4nCwxXkk7yYpsOeWgJJ6Zjo55FmFERQN26
         AHXDJcZAFny27kLM1vc4CCCtiE/eiG8ftM4ENFfKsnKbiv71C6O6ouiq/9ds518MYFQg
         j+yFWuh71DCrB86EucpehAP9rYjPcsLc+7MUOuvBwOpj3BHP5sShA2kcjGZc5UmjlB0P
         HgWQ==
X-Gm-Message-State: AOJu0Yyp0I/zCLFQJuyvYTEgfzkgpwDsFklmfR+irZ41oQ0cMMTkj9cl
	lt79XXGYJxkV18qi8nJcdZsjM+LJLUicwb9B4UsG18WrE1RMp3JxKMF7PuVH6H0k
X-Gm-Gg: ATEYQzz94QRcyxq044NrIUfnC//uHwxEewPvneRdDMXbIF7RBXJpyw8Aep0aLdXQ1aN
	z716dn/dmUSGHk3TedcGbVnDGs3jQwoMAC4IGx/iL5vOFZ0nh0RcX6FHQFYz/qXOQ2AJMquJm6c
	c1bdmHtngmVZRhQXTh17zxTcXYZFEI1we1507Y10IHNuICaQQUOlZpqMir6uw9CcGd+nLBU2Gz+
	0EW9uKP6tXmmLWd7D8uzmekw9TWXWw4Ynn3ZAVgv3nWR2bCMPfU5i6OVBq7Ehzn8heb3FCr7CV1
	1aEAScUSUQCbbCxZ8WWfFXfoC5nWVb2QLGoOSJehAdOtr47tXBtJk0WrihrzEo3cKDhcacCyX+u
	JrszyTtbbHY9BqWSwtmvpqnn30G+Iw9uJLpV+UtrNiz7QLTfzKhidAbaoc3YwtBLGql7DevbiDD
	JGTbdIX3qDmCsDn6GpIyK1tgvjmyYdS0CJ1mmbyA==
X-Received: by 2002:a05:6808:11d0:b0:46a:72dc:28c9 with SMTP id 5614622812f47-46a8a4217a5mr7661110b6e.15.1774937990135;
        Mon, 30 Mar 2026 23:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa036505dsm6249257b6e.10.2026.03.30.23.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:48 -0700 (PDT)
Message-Id: <8fa6a74e0df89452b25f8755fcd3290fcd8f1e2d.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:17 +0000
Subject: [PATCH v12 12/13] fsmonitor: convert shown khash to strset in
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

