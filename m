Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34442217648
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707372; cv=none; b=cLL3GNeo33FcchFYDyvxuDVUhW3u8AWUjBrQVh8QyIghe5lbk3ShYamoYUU1XoHHompxR0/9IJpDhkjRsxBhKI7CKthfHV/1tUhVXGwXB3+coOUJWrcxCJevDSr7Ap4AtAdyBoZ7msHnh8N1IkCvW1gzkdJkNfe2m3EYSK7zdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707372; c=relaxed/simple;
	bh=GM+3LGL9KkNR/BDf27/V19xa5Ev1NhX2EMlINAF1cPA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LHO1+ORGvHUHN/ZIqJjCNHaNOzdSEBKotVVrQ8EM/dmz0ik9ocrr3qBDisPLvw2BU6a0UeuPnt31CxMlhkw4EpGahezQ2RSEUzfLUvHn1Yy0Bvm4LmVW/vtoIFABbBed0LaGWKBU4Q0oILajQ7CBIGetXZze4PdZn+R8jh9frUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nApCRRb2; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nApCRRb2"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0b7eda342so1830735eec.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707370; x=1774312170; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFIal9GeQN88ndsSirxjXRZ6fpyJAo4oE1UiiY9xQ3U=;
        b=nApCRRb2pMl2GNeXQd5YueIm+crptIF0NfdiFqVkwPbBgltf/MP+rlljR2CbTLYCR8
         ZtWHondEfvTXWT1j0+fT+lBpP4eOTiVu/dbdCSrIMHfYoEdxpGyFr1NW53qF/rbYcsc+
         lMJkwJRYsjepqq3gYy3hMroDtQmTmJceQy/NkCd//WVhFCwYcJfSzvBCPJOoZJpDMZfY
         2liLCRgxF9BerQhipAPJxcI/wymrY7fJq7Sl0tvFP+2Em6KiXeO9EBetSbMsOIaOgscw
         PqxbiHRIRYSag5Xf+JegESrgCpJ/bye5O2dpRILrrRrUgN/W6oYITjecxXm3rEaL+PF5
         v7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707370; x=1774312170;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFIal9GeQN88ndsSirxjXRZ6fpyJAo4oE1UiiY9xQ3U=;
        b=GQJEJOZNYYSxKXGki/bKNzne5YdBvHdW+DSAlvO5kDzx9Zc7AOsTOaJeamMHTluRx9
         JNACjs8sdbnRooE6SVlq3HgjB961A0cZRSS9MkPX6vHli0v36sti9nDFumgsft7Xm30W
         HNr/HYnzOUUYpZ8EcCiPZmkBT5cF1SnOVPip1jXAMy+TNTtw1WIQta4xr1vOSvLnmEhV
         st5vlpUCfbSxO1Ea1+8Dxqfrm847C2610LHEXFgxlLu1njMn0wko4muyOP9BSvDibZW/
         4yZ80IdKJXTnlrVR2d61ygnIGQ2R7q8tS+IWT0GI3xTWk3HT5RWDHgOipJW3a2v+cMxQ
         JKPw==
X-Gm-Message-State: AOJu0YyFkGgCl2FIcjvBBBsqzVuCvPWHpAP0hN3l3X7VZ6k6181QGMn5
	VEk8hNZPsBmL3wsP+0nSaP/odMdHyzczCwi57yLFYyoDU1CtDaSFYWPY3a518Q==
X-Gm-Gg: ATEYQzxpTLKLvWx05fm1imZs6EZrf1EAi5ErEcTTyCj4P4TSl2AgeEaD4OumnnUz/v7
	eYp7ixaysondEeM47jcguqe9HORVqSEtYYmde8J0O5QU0OULWo1uuWUZpVgdKarcYhv00EVwrwQ
	Qp4VbKauEy4ewTJ8T8F+FQD46zfE27v/ft9mNiDs7298LnfTIgVyUdfud4p/Ki4RDkV431IBnFs
	wpSyetWmJohwH7aLBoa1yj187XSfmaKtbtTiLgIctKP7E0vazWH93R11IqsQy2p1WJZUFkAqa1L
	X8UFnISX3zKG84Z7vCiPAJmArEKwsO0ObU+fRECYFB/c9In0pKM6DnTed1mYJ1wUZEbNNrqiwYS
	LB2AzSSTV7zbV5JpKcukwfbGGKMra8VHmjvHCoZWAXLNuICol2IWgrRGi2mDcokb0Km5W260FCs
	w3Ab8cqp9KZbhOj8oOWC5erqgRLg==
X-Received: by 2002:a05:7300:6420:b0:2c0:ca48:30f1 with SMTP id 5a478bee46e88-2c0ca483b82mr1764106eec.30.1773707369790;
        Mon, 16 Mar 2026 17:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3eec8fsm16869747eec.13.2026.03.16.17.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:29 -0700 (PDT)
Message-Id: <beb1c92554c76907315a4d1a7983226d2bf5a828.1773707361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 00:29:21 +0000
Subject: [PATCH 5/5] path-walk: support wildcard pathspecs for blob filtering
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Previously, walk_objects_by_path() silently ignored pathspecs containing
wildcards or magic by clearing them. This caused all blobs to be
downloaded regardless of the given pathspec. Wildcard pathspecs like
"d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
during 'git backfill').

Support wildcard pathspecs by making three changes:

 1. Add an 'exact_pathspecs' flag to path_walk_context. When the
    pathspec has no wildcards or magic, set this flag and use the
    existing fast-path prefix matching in add_tree_entries(). When
    wildcards are present, skip that block since prefix matching
    cannot handle glob patterns.

 2. Disable revision-level commit pruning (revs->prune = 0) for
    wildcard pathspecs. The revision walk uses the pathspec to filter
    commits via TREESAME detection. For exact prefix pathspecs this
    works well, but wildcard pathspecs may fail to match through
    TREESAME because fnmatch with WM_PATHNAME does not cross directory
    boundaries. Disabling pruning ensures all commits are visited and
    their trees are available for the path-walk to filter.

 3. Add a match_pathspec() check in walk_path() to filter out blobs
    whose full path does not match the pathspec. This provides the
    actual blob-level filtering for wildcard pathspecs.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
 path-walk.c         | 22 ++++++++++++++--------
 t/t5620-backfill.sh |  7 +++----
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index e1ad4b0208..67fb0f7572 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -62,6 +62,8 @@ struct path_walk_context {
 	 */
 	struct prio_queue path_stack;
 	struct strset path_stack_pushed;
+
+	unsigned exact_pathspecs:1;
 };
 
 static int compare_by_type(const void *one, const void *two, void *cb_data)
@@ -206,7 +208,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				 match != MATCHED)
 				continue;
 		}
-		if (ctx->revs->prune_data.nr) {
+		if (ctx->revs->prune_data.nr && ctx->exact_pathspecs) {
 			struct pathspec *pd = &ctx->revs->prune_data;
 			bool found = false;
 
@@ -317,6 +319,13 @@ static int walk_path(struct path_walk_context *ctx,
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
@@ -525,15 +534,12 @@ int walk_objects_by_path(struct path_walk_info *info)
 		info->revs->tag_objects = 1;
 
 	if (ctx.revs->prune_data.nr) {
-		/*
-		 * Only exact prefix pathspecs are currently supported.
-		 * Clear any wildcard or magic pathspecs to avoid
-		 * incorrect prefix matching.
-		 */
 		struct pathspec *pd = &ctx.revs->prune_data;
 
-		if (pd->has_wildcard || pd->magic)
-			pd->nr = 0;
+		if (!pd->has_wildcard && !pd->magic)
+			ctx.exact_pathspecs = 1;
+		else
+			ctx.revs->prune = 0;
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
