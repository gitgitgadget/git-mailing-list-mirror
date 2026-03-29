Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC52367D9
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797891; cv=none; b=fXTUbIAxtU7S3fVN3pGm5gGiiwJeld2ZZSBEivLIHe+pdkHBVe81Wz1BqaT92S4cas8/BHogYx8kMKvC4IyRoyRvUkLJ/UOCZXPeGItI3BOe5LVsCBn/wRpqsI7mGe1uGl3MbhzYtMttqxuiWEEf5Y3igLErdAyWyIcDmy/5dqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797891; c=relaxed/simple;
	bh=fDkKum9vUBMU+zYOWcnxxqyZErtze5bpKe/oevCwJP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmBDibt7EDf2ssLH43sXxxAjJZ60cUXo/8znetuY0o7R6CoF2hc/V7nQdHoXigMRVjgRnaTu8gOVG96i/sQuzgzixDBpS+Fq5cTKU8sRSlDcuACU0FxoYivxwLzPMIK/fG3wYNWhU2rueqrgQWwtIVKch0WMR/aD1u0PeTqP7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVkVlTVV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVkVlTVV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b24fede2acso1948055ad.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774797889; x=1775402689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IP+vT6H8pVYwFJVdGNjhwlBwkWVARJAtfEX7raFAZUM=;
        b=aVkVlTVVKOVUxU/sZ6jX4HFm4aWxEJlb5O3LZ87GRgEsnRt3+KIFiPwEKPyZbZdD1p
         pKC/EMqIlKzxjbI0idHznME3ErPcuzUXQRfqwfuVMLLMJ7sNcrOKv4WmeyVOhN1x+55H
         sbWb2BqdkiIRVL8MQ8q0ijhSRg0YVrNf07j5enJ1s8fhdfZepf+Cc9FOl8nR60+Utvxo
         1r2b1DiXzgGa12zK7BzzyVgwdN0p55f6RCim5q45AvYeA3qVJD2UZDLU12cv1HFalJlU
         r5Z8pKJiGgtpBeV73LsYnlCU6gKQ2Xg48/9oFzMkjcdsAVnk8/BN8ED+Qa6UHFzR/v2i
         mAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774797889; x=1775402689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IP+vT6H8pVYwFJVdGNjhwlBwkWVARJAtfEX7raFAZUM=;
        b=OIy8qH4tb5CDVtMw1HNztmftLknDGeJ5FFmXRQNNiyqKzeaKHy1UgVCnYXpJDt4DiO
         pk6ADT5+MW3I6wZBCdezQ5rrAVMTRWB9hCxDTpiBIbvbj8B1GEGJ5mLxLP3+FygRm32C
         1oIpfZKiX8bczxxfvp47PcKzoKJ8v5Dx+4EG1V1b2EVOq1cXB/7s3YXVplNjuDV7EAPK
         T8+77AGXMPf2EOBOybCGNc03M0KWCFsugyirh3s2cAEYxQfHGPoSjLLwakzP4M8QJNi2
         FxRuUuMUobysXNgJmwuCdAqbT6eBRSYWxjy+EB8Rj1wTC25vtULWENFpyDI7ZovVeP58
         cB2Q==
X-Gm-Message-State: AOJu0YyX9fsNi6IA3zZ02++Whec+dRNWtrAiACkPt155mqLhtkji1dhD
	OzHeNZqd8UqDPmRbNJz9RmV9/cLEINgPEhez9V5eORf11EcOIgZSEuOGIBEDPvAw
X-Gm-Gg: ATEYQzyk7fno32U7wBHVKSxAK1LLJgVO6xMFR+f/+jDQAepqvTavulMKbMrHx74cZqD
	LnxaLM9YNANsQcVOzlLmBxVqJtQIpzOUZqMyBnNmLB2b2da8VpfxxkcOwEgSeQNI0bmlDf/9qOg
	sJlgMUZatgOdxghyjMyN5U2x933KHJjK8abeHTPfgPi63mQQlV0XW4epTQ2In0L8zs957vsgqR1
	MfwREH3u3h5fCC6jRr+gN4QKUGFea0KC7qCs4vv3B+YqloECENzKhIULynU2UjGAdIErIxEtSPS
	XzmoCoyTHmjqMD2KrHjTpDEZYTX9GRRj24daJDncTBTsqvNfVw09PuDAFIKqk+WjJ38bR8I1vzd
	j10olMcjCm1BZjFFV/0ViNne+vNlBrobWH002ak99gE/RzHFWRwslSK/M+/A9vmpyon69wOFSkl
	+PflMsPlZWogesnT2oPqdwUtRu1D1xGnTiKJOIwUtLRbHDpMO0iJkaLZvYUxWgW4iOWbYn+/dCh
	iuukSO+Kw==
X-Received: by 2002:a17:903:2285:b0:2b2:5256:9ce7 with SMTP id d9443c01a7336-2b252569f5cmr7392065ad.36.1774797889457;
        Sun, 29 Mar 2026 08:24:49 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5f5bsm53475155ad.82.2026.03.29.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 08:24:48 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH] backfill: add --[no-]progress option
Date: Mon, 30 Mar 2026 00:24:43 +0900
Message-ID: <20260329152443.525493-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'git backfill' is silent when downloading missing objects, giving
no feedback during potentially long-running operations on large
repositories. By contrast, 'git fetch', 'git gc', and
'git index-pack' all support --[no-]progress.

Add a --[no-]progress option to 'git backfill' by:

 - Calling display_progress() in download_batch() to advance the
   counter after each batch is fetched.
 - Defaulting to showing progress when stderr is a terminal
   (isatty(2)), matching the behaviour of 'git fetch'.
 - Allowing the user to override the default via --[no-]progress.

nit: progress.h was already included but unused, this commit puts
it to use.

Add tests to verify that:
 - --progress shows "Downloading batches" on stderr.
 - --no-progress suppresses output even on a TTY.
 - No flag on a non-TTY is silent (isatty default).

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 builtin/backfill.c  | 16 ++++++++++++++++
 t/t5620-backfill.sh | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e9a33e81be..27a301f9b2 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -35,6 +35,9 @@ struct backfill_context {
 	struct oid_array current_batch;
 	size_t min_batch_size;
 	int sparse;
+	int show_progress;
+	size_t batches_requested;
+	struct progress *progress;
 };
 
 static void backfill_context_clear(struct backfill_context *ctx)
@@ -54,6 +57,7 @@ static void download_batch(struct backfill_context *ctx)
 	 * avoid possible duplicate downloads of the same objects.
 	 */
 	odb_reprepare(ctx->repo->objects);
+	display_progress(ctx->progress, ++ctx->batches_requested);
 }
 
 static int fill_missing_blobs(const char *path UNUSED,
@@ -120,12 +124,15 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.current_batch = OID_ARRAY_INIT,
 		.min_batch_size = 50000,
 		.sparse = 0,
+		.show_progress = -1,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
 			     N_("Minimum number of objects to request at a time")),
 		OPT_BOOL(0, "sparse", &ctx.sparse,
 			 N_("Restrict the missing objects to the current sparse-checkout")),
+		OPT_BOOL(0, "progress", &ctx.show_progress,
+			 N_("show progress while downloading missing objects")),
 		OPT_END(),
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -141,7 +148,16 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	if (ctx.sparse < 0)
 		ctx.sparse = cfg->apply_sparse_checkout;
 
+	if (ctx.show_progress < 0)
+		ctx.show_progress = isatty(2);
+
+	if (ctx.show_progress)
+		ctx.progress = start_progress(ctx.repo, _("Downloading batches"), 0);
+
 	result = do_backfill(&ctx);
+	if (ctx.show_progress)
+		stop_progress(&ctx.progress);
+
 	backfill_context_clear(&ctx);
 	return result;
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..ff67e8ecea 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -77,6 +77,30 @@ test_expect_success 'do partial clone 2, backfill min batch size' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'backfill --progress shows progress' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" clone-progress &&
+	git -C clone-progress backfill --progress 2>err &&
+	test_grep "Downloading batches" err
+'
+
+test_expect_success 'backfill --no-progress is silent' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" clone-no-progress &&
+	git -C clone-no-progress backfill --no-progress 2>err &&
+	test_grep ! "Downloading batches" err
+'
+
+test_expect_success 'backfill no flag on non-TTY is silent' '
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" clone-notty &&
+	git -C clone-notty backfill 2>err &&
+	test_grep ! "Downloading batches" err
+'
+
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&
-- 
2.43.0

