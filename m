Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2239526D
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266032; cv=none; b=YF/8YGPDmHLkJnWxvymSXQYYG0aZTtHr4psgODBh+MQ6EQlReHl80gWXBh2yWY5EwtDDbGbYZ3387G2nFOB7GIxL/HvfUO6Vdbm3bJbrbx9yc8ezrWIq2bHHmznZnGpwITCAHnAZzN5viKaxpFnkHB8EBqXIQsfqkeR6WgtMmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266032; c=relaxed/simple;
	bh=s25eBXbrsvs9FdyawuF3SgjRFs5BKRFXxSkakzttaZA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bBssvnTSA3QamWyP2l/uJSSBsZ6yKTUEyRfSo6q2NdtPLfYwwanmY0kuD4ZttIlmZzifuLWiwhaUG6iuOBjR3RHp9vvmxb/B8qPjZPLGs55uypmGnDTGlMjDkFo2nwM9TCPzlbc3XudwcYuIxboyIY9VvO/xwDVoDfS8Yp5ivlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djJNs0Mn; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djJNs0Mn"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12a693cdf29so2975906c88.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266030; x=1774870830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9b7Nh1yar/C2vzSyBZCLVF79D8rLKMpxrgX0WBHAdI=;
        b=djJNs0MnQ1DebDiqi1+inHzRyzmNpWBTl1bWBqNTMQvxq1vOEomVeKJTVXsrFqmu0e
         QIxGx1hIgzfuR3IofTGWtj9I0WoMX/0fmnZimuZVvopQqwPxurDge+Zb8Gkg24qGrdsk
         x5gJ+FZzwOoVtGiLB95OdTfPRwHz8dd4rZBej6028fvN0JTx9J4Xwt9XTkQ6dB3Kvgn2
         xHVjnuqXG+s2tQVSf/6ij4yYoJADxY1Y79XoNYfUZ5YgwOHz5GzLzqj6xtpAXjOsVmRU
         7495/u5b2iarmQaG7QgIyNslGlcKgL0q10ga+E0sXcjd6vT/Ei7+N81yEDvR9OzxZsrs
         m22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266030; x=1774870830;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9b7Nh1yar/C2vzSyBZCLVF79D8rLKMpxrgX0WBHAdI=;
        b=Smm4JLf98GvrVeYXbUGw7ofMLTpo3Hmb2LwEKqlOwJfZshmhCmNjDbQYgLMWP3noBc
         8L6aQOdDkRBaCmpjOUfem1Oj8LqTwaYEY/LZAyoNrl/TUcKLOc1nAa/twSsI6LaWIs8g
         V6ZO+OlqBeelBClPejMygl9F+IkWNZNmv2yS0rjEoWxLzWmtyZDmJ7kQwexctTwCqtp0
         AZeZJjGVpPoi0XGBB/yIvonUJHsp+WSAv8IKg0yWsZU1pDWcAWf8d4cmrdOGLF6fiqhn
         wYXP/n5BvV8cnueSHvRgKlwQnkBfedIxFEL7lwu2Z9QdiWoPJ6pm1Fvb2rKGhZHIcFvq
         lX6g==
X-Gm-Message-State: AOJu0YyIj0iMJB9pHx3RmnlfVH57iw2k9eohIRm+yf1gzGx26be8cWIY
	Aq4CZ+ZcfTscz1LMgcVF4JS+66vzS+OJzT6kGD9sDGMZqO5IEyl8PFF40dnG1Q==
X-Gm-Gg: ATEYQzwD/pwFvi+9nqXQTCUXntBrZYyduKnB/2iL2hjaXYarhJtgls6b3X5zl3I6oci
	sTENYR411ijTGn9wOu+XDyY6BXv6gJG9eUlw/bdMeNL4X/eGrX59v3xltk4Gw/olWmRMPk/wkLl
	3cRlvYLec6DfM8Z707fF5QcWYpqD6SH0kpPnDVxmVgNOpuRSbQRZQ/Ev1boob5I+zfVkdcyhk8h
	lU58O4Tu4E22Bl5Z+BAFSiAaZGl727j7X50FhE0S6P9S+LrQ7Owa+2PaWniDEMgeYQMGN3yGnHQ
	Gb8YIJZ4twLCbFFG52ko8lUdjKcHbxVRMN0fN8tVETswEBZxRILWF7bPO0XRlyWKtYXw8H1dpbQ
	UmwpBprqdpPKPvk34ggDEjdfA8yB8mNZuBK7r+w+NVGT0kDSyFouDu3lXKcDdMhfGsSczBeCps7
	pvkQaFZIsyd6DkFCrLqp78v1O/whYmFjqW5MGVNA==
X-Received: by 2002:a05:7022:492:b0:119:e569:f86d with SMTP id a92af1059eb24-12a72326a74mr4516720c88.10.1774266029700;
        Mon, 23 Mar 2026 04:40:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733b49afsm9432220c88.2.2026.03.23.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:29 -0700 (PDT)
Message-Id: <1168edfb96c739581dd510f86bf1dbf5e28603e6.1774266019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:18 +0000
Subject: [PATCH v2 5/6] path-walk: support wildcard pathspecs for blob
 filtering
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
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Previously, walk_objects_by_path() silently ignored pathspecs containing
wildcards or magic by clearing them. This caused all blobs to be
downloaded regardless of the given pathspec. Wildcard pathspecs like
"d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
during 'git backfill').

Support wildcard pathspecs by making two changes:

 1. Add an 'exact_pathspecs' flag to path_walk_context. When the
    pathspec has no wildcards or magic, set this flag and use the
    existing fast-path prefix matching in add_tree_entries(). When
    wildcards are present, skip that block since prefix matching
    cannot handle glob patterns.

 2. Add a match_pathspec() check in walk_path() to filter out blobs
    whose full path does not match the pathspec. This provides the
    actual blob-level filtering for wildcard pathspecs.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c         | 22 +++++++++++++---------
 t/t5620-backfill.sh |  7 +++----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 0d640e2f24..6b83e0e1d5 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -63,6 +63,8 @@ struct path_walk_context {
 	 */
 	struct prio_queue path_stack;
 	struct strset path_stack_pushed;
+
+	unsigned exact_pathspecs:1;
 };
 
 static int compare_by_type(const void *one, const void *two, void *cb_data)
@@ -207,7 +209,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				 match != MATCHED)
 				continue;
 		}
-		if (ctx->revs->prune_data.nr) {
+		if (ctx->revs->prune_data.nr && ctx->exact_pathspecs) {
 			struct pathspec *pd = &ctx->revs->prune_data;
 			bool found = false;
 
@@ -303,6 +305,13 @@ static int walk_path(struct path_walk_context *ctx,
 			return 0;
 	}
 
+	if (list->type == OBJ_BLOB &&
+	    ctx->revs->prune_data.nr &&
+	    !match_pathspec(ctx->repo->index, &ctx->revs->prune_data,
+			   path, strlen(path), 0,
+			   NULL, 0))
+		return 0;
+
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
 	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
@@ -511,14 +520,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 		info->revs->tag_objects = 1;
 
 	if (ctx.revs->prune_data.nr) {
-		/*
-		 * Only exact prefix pathspecs are currently supported.
-		 * Clear any wildcard or magic pathspecs to avoid
-		 * incorrect prefix matching.
-		 */
-		if (ctx.revs->prune_data.has_wildcard ||
-		    ctx.revs->prune_data.magic)
-			clear_pathspec(&ctx.revs->prune_data);
+		if (!ctx.revs->prune_data.has_wildcard &&
+		    !ctx.revs->prune_data.magic)
+			ctx.exact_pathspecs = 1;
 	}
 
 	/* Insert a single list for the root tree into the paths. */
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 52f6484ca1..c6f54ee91c 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -307,12 +307,11 @@ test_expect_success 'backfill with wildcard pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# TODO: The wildcard pathspec should limit downloaded blobs,
-	# but currently all blobs are downloaded.
-	git -C backfill-path backfill HEAD -- "d/file.*.txt" &&
+	git -C backfill-path backfill HEAD -- "d/file.*.txt" 2>err &&
+	test_must_be_empty err &&
 
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 0 missing
+	test_line_count = 40 missing
 '
 
 test_expect_success 'backfill with --all' '
-- 
gitgitgadget

