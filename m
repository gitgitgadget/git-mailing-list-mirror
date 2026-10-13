Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B05172C1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906502; cv=none; b=p3ZeZGO9CnuDllxzV9RH6yyoa+JOVLkR6q4KcaHW2m2htAEoEW3BgF7T/NS/q3LANzewQv8jtFqMbOyI5hKYEUHAf+y4ZdYsbDY8uwLic/Fjr7AKiKyYa2RJ1XdJeE+bIDYGikVxWI00BeJQeyEM4yafauRUmtF5v7pQXK4DNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906502; c=relaxed/simple;
	bh=NvHlSPspj5ZxmcMc1NLz/QlQG1ZmSio3/dAQTNL0WV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2ca6LqAIoFn/9FqgOv/2WiTa9nJAsEpSlb9SCzFWfY71p/Fxuu7VSQotGYnC3TE6qWhxT0MRfg9OKGnYpUoY+RZ8UWrIx6Z7XMeBLZo/WjGgnHe/F7mUOILO1spHGfSyyA+D5haQMddOCOV6IwXKwojkCm9aciwghkob9pIQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP9NIxU8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP9NIxU8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so356435e9.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906499; x=1792511299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mrQRhSZQGZVQwrutnSZ5G+EVg+/dExjsxUmu+5TFBwc=;
        b=UP9NIxU8SE87LaKujNeWVx5DALrK88/IarvJzU1czzj8SZ7Bt7S7uTjviq4lOdkGff
         Y+6j8UbeEyqcXW8PWyw8rdF+3WtgkGlySSnizidYFbh1JXtxmkHjMwavL1nBFaeX0nrK
         uxhnNQv3ztDNT7n76SN8i0n5BsvDnqj3BHUd7QHJZMtLnWKC7siPtMHY5wANc5L7MUp6
         Me/iyHU05KgPzk8PGXYzVFJaW2ATHYidBwwrtPhDqMM934N2c8oOj+x6tYX2wURcOcSz
         6E24g1gUpbUwgCfZvWO1nyfzks2K7B4gNNsUIxy/ISn1HZj81bsKn2bipBoqBGINDJZF
         uB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906499; x=1792511299;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrQRhSZQGZVQwrutnSZ5G+EVg+/dExjsxUmu+5TFBwc=;
        b=hZRPGTxmzv/BdzMtTiBEVrAze75FSB6+1cnp3Y3+PuBGx3N5TIMGNWShvRBVCpTPuC
         MbFe9OrjTOr1EiR/86MkCuunhX+GOtQtwfrTOVd3M+aTMOUGMsGoeKGXp2h0lqNqxTxX
         aLCtYOKcY3npjeLYrkNO9H19FvhFoz7+AkAD4ajpedQoUfWZreJYUipwi8CCgiI5D4w1
         2e6gVMrm7CEc82A8uspVHdh/tFmLtMISDQ5BwVS9L35vhH+f5itv3fLOpyONtC5dPHaB
         j2VgxgLScREfA25IFLAxN8Z1oPKsuTKRGJLe+WLf7qIV6DCPamZC9MhdnWFPBcFnfo+u
         J6qg==
X-Gm-Message-State: AFq9FYJEtqaiwUXSinlDmiAXyxqB5cAojqcAb79FVA02+bc+GEzDsqaQ
	NxUZnMOntRVEwYCRJSlBiamsatqDukcufCMiV3eUQ2I80u2jphxHFZFNkcrJcA==
X-Gm-Gg: AYBFou3eY45TAU/IzrIpBnAoFDRNBSOi54iQpnRJg8rVeV88ehzbcdBZyHetn84txBY
	JbH1FRzR2xzSNvW7exlpX5zZ2hYyWhkHTSOtTNJEnRcfj1feQ19SZc8GaobbvVqb89cT4EnUL24
	aQy2UBqIpvToEBOKKAVlpXKNu7RoFIR9iV8QliS8rX/tkaL6Lj34um9qNeBF4si8SqDagFpKYi0
	3BIeRJQaqVaB0iqQEVq9PDyrkkh4cXnxTZmroL2M3Bf9hJBcJ8yGUYBf27r8h6zvmjp04HrSpOr
	bRCFudKd+j5NTJPq7eT6cW5hCJKxRJ1JaASkxJpoGLQcyxWxH+R0dTJq1QHkjZRf/hIkbuKD7LP
	h5MZbzalRumo51yecG5Qgk8XehvqVTDtj8CXwstvzT/W8Oq/RSq45hniEBFOO6kuB0+CE2KRO+I
	CjP3D/zV8cwVuTEJ62f9WFiFak6P4hLFqAqOUMLKsoRP+7G3F5nHXqM9QdaIS1rEHID3VQjDTqV
	g==
X-Received: by 2002:a05:600c:524a:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-4a18e4a4f2amr256787535e9.6.1791906499267;
        Tue, 13 Oct 2026 08:48:19 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm5603561f8f.54.2026.10.13.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:48:18 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] checkout -m <path>: cache merge settings
Date: Tue, 13 Oct 2026 16:47:54 +0100
Message-ID: <36f3808d2fbfc1761f61b0108235ae6ab3e35320.1791906474.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791906474.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk> <cover.1791906474.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Lookup the conflict style and normalization config settings once and
cache the results, rather than looking up the same data for every path
that is being merged. While looking up the config settings each time is
fairly inexpensive, the next commit will start reading the conflict
labels to use from a file and we want to avoid doing that more than
once.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/checkout.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bdd2d816b6..ac66de23f9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -310,9 +310,22 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
+struct checkout_merged_data {
+	int conflict_style;
+	int renormalize;
+};
+
+static void checkout_merged_prepare(struct checkout_merged_data *data)
+{
+	int renormalize = 0;
+
+	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
+	data->renormalize = renormalize;
+}
+
 static int checkout_merged(int pos, const struct checkout *state,
 			   int *nr_checkouts, struct mem_pool *ce_mem_pool,
-			   int conflict_style)
+			   struct checkout_merged_data *data)
 {
 	struct cache_entry *ce = the_repository->index->cache[pos];
 	const char *path = ce->name;
@@ -324,7 +337,6 @@ static int checkout_merged(int pos, const struct checkout *state,
 	struct object_id threeway[3];
 	unsigned mode = 0;
 	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
-	int renormalize = 0;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < the_repository->index->cache_nr) {
@@ -345,9 +357,8 @@ static int checkout_merged(int pos, const struct checkout *state,
 	read_mmblob(&ours, the_repository->objects, &threeway[1]);
 	read_mmblob(&theirs, the_repository->objects, &threeway[2]);
 
-	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
-	ll_opts.renormalize = renormalize;
-	ll_opts.conflict_style = conflict_style;
+	ll_opts.renormalize = data->renormalize;
+	ll_opts.conflict_style = data->conflict_style;
 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
 				&ours, "ours", &theirs, "theirs",
 				state->istate, &ll_opts);
@@ -446,6 +457,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	int pos;
 	int pc_workers, pc_threshold;
 	struct mem_pool ce_mem_pool;
+	struct checkout_merged_data checkout_merged_data = {0};
 
 	state.force = 1;
 	state.refresh_cache = 1;
@@ -462,6 +474,10 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	if (pc_workers > 1)
 		init_parallel_checkout();
 
+	if (opts->merge) {
+		checkout_merged_prepare(&checkout_merged_data);
+		checkout_merged_data.conflict_style = opts->conflict_style;
+	}
 	for (pos = 0; pos < the_repository->index->cache_nr; pos++) {
 		struct cache_entry *ce = the_repository->index->cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -479,7 +495,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 				errs |= checkout_merged(pos, &state,
 							&nr_unmerged,
 							&ce_mem_pool,
-							opts->conflict_style);
+							&checkout_merged_data);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
-- 
2.56.0.134.g299a3c16181

