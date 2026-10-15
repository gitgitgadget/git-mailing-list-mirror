Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D13C0601
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100631; cv=none; b=NhQAYa4zDzs+sRraiXuHF1/n85xmS1olQJCf/Xi+TO7XiBxYOqQHvqmKz68/cZ5UKkLndKTW/rj1c8jw1/3vdJURlU05Y+uEN/uw37Tq2ZrZ1X3pEk3QNgNUm3WqltpxKyuBy9pmxkB74Iu0hOkRObk/VDZO76TjF+v273iJqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100631; c=relaxed/simple;
	bh=hNRDzrl+nnMV8mvrefwn4tSbD5reY+tHYQsTNo8fTdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpMCmGH4LX0tL3zXNa0sSL7Jf29idkvP11QCrEk/K6AurNLS7CB1KaMoQea9e86w/oLK/mcZKouGoOePOiuxMG3OE5UHE37zYUB6QhpmaXpkInvNpbTCJRvI0EJhyMDpYmVdNpBHaQ4pckOwDMIa/BB8Yx6TfvOJK0PryOrTALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA417waG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA417waG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso1014878266b.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792100628; x=1792705428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K574x24Lt53EaOHFyyCemxToXX9+YVxh7N05ey+AxSw=;
        b=QA417waGOzjpClReVUxXWo1NeYCDg/CMj5jtpihfOF9wa2jdDU4q2RDS2dnb5pW0gr
         LAXmGPrBism+UZbtykpImFh9f3dVb2mFPM2BUy85izCh/fn9l/bcqX0CHQiMpl2VFHcn
         r+XE1NnARzOQHbHFVDl4Zrd4aNwwIrWLBvdJ8AQafnkl/0x/gXg9ngK5jT4U779J7Wx4
         avsfHAXUqhq0YK/YxdVqRfYKiKJUPTRMit8DPDE9Qy+TqK0sh8dZ/Z2wfbfiHfXxbxCJ
         DDA6CjCMSK1g/ANXHcPVip3tdK7wpiZlTc/DtxUraXOD0H2nMbt2P9+VZfxSlw7kSFyd
         gdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100628; x=1792705428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K574x24Lt53EaOHFyyCemxToXX9+YVxh7N05ey+AxSw=;
        b=2ePQ13pIEg1kLGRD9oc0DjsfPawd/adCJ5lOpuxiM4SMvuokiHHnpF2EvZboGBKfjG
         BvGQWIwhwwl9Zp4Gcqy7gAdI7kLBQBRqTCSh+xxoFCb8R+RAmRFXNyHbryBqc4a2Q89U
         UPjB5uKMed0f4BjlIVZ2J1C/0xTECsJ7xyDxvrlshJ0NzQ/eP1yO9O+CXn9SwKprmAds
         NnSisRgAP0GvavPNuIuc1/modfsFnLqrPVTvH5GZLoxC2LTtxODU9+ZvNzwB+VMSvTKY
         I22Uynfpf3mVbsvH4a4JohrRqROkqYKkPeT6S+PdKwRkJvW0fH66OH+bDOhtFKkzaWeQ
         595A==
X-Gm-Message-State: AFq9FYIxEKXY69W/PDk4XnpaqbjMLgEJWvVIttxghTsSNpXPMxB5a2VP
	2wAfWqylptmtBZtEUsUT8HHDw9vUDD9m6OaXW+2UlcaCVqB0ZfhObtzJ1JuM4Q==
X-Gm-Gg: AYBFou0jhAwl1rxabc6esod7ufFQiPFJRDX4/LqhCmXBYWR+V9juUWgutO5LDVhER0R
	jacnePka0hsfVnPq+Xv79Dkf2UoRs/SeP05ER3+M4pjD5hYtlCZZAXnUICFQoYxdO5O9qzoFp/s
	3lsN3UIOSq5xYfPJJ/HUyfgwVsopUQBYMlQALRo9w93Md0LYpNnzHuuDNYe2p58qPRopk1l4zwo
	oiXtCwN/X9fhIzavy6jnpbDuqjCTbmp/bc2ZPzT2Vrlw2YNpdDuRIzOFbxo51zt9q9EMZLJLaNE
	f4m+NhJydjyGc/Y7g3baGjzcGgNgXVJVzfD0sZHJZMK3L9ufl4hYdPZJkwlPDedMtEZdidx0ZiW
	ufQoadPRi0Rr0/WKfNDjt5hBzaT1lnVaEiISsi57Popj2cFmGvLlkgxuMVBbADz5t80FBocglvo
	NllpAqJ3qTPDjWoiXzPKPVREco7aGnjBnYrIE7BZfncHEjf//8z1/IxVNSeb/7rvIGonjQ/VCkS
	ibbSoXP73bcQeZu5cNlv9zj8E0kmpYScorNRoyj
X-Received: by 2002:a17:907:6e90:b0:c2d:ca32:2176 with SMTP id a640c23a62f3a-c31a9fd2ca0mr1968030166b.8.1792100628355;
        Thu, 15 Oct 2026 14:43:48 -0700 (PDT)
Received: from prometheus.tail8f5cca.ts.net ([85.11.110.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb4896sm4402266b.80.2026.10.15.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:43:47 -0700 (PDT)
From: Szymon Wilczek <swilczek.lx@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Szymon Wilczek <swilczek.lx@gmail.com>
Subject: [PATCH] cache-tree: do not die when the index is locked
Date: Thu, 15 Oct 2026 23:42:42 +0200
Message-ID: <20261015214242.1196722-1-swilczek.lx@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`write_index_as_tree()` locks the index with `LOCK_DIE_ON_ERROR`, even
though we only need the lock for the optional write-back of the updated
cache-tree. As the comment next to `write_locked_index()` already notes,
failing to write the index here is fine.

Since 356ee4659b (sequencer: try to commit without forking 'git commit',
2017-11-24), `try_to_commit()` calls `write_index_as_tree()` in-process
right after the pick has updated the index and written
`CHERRY_PICK_HEAD`. Before that commit the `die()` happened in a `git
commit` child process, and the sequencer stopped cleanly with its state
saved. Now, if a background `git status` holds `index.lock` at that
moment, we die before writing `rebase-merge/message`, and a subsequent
`git rebase --continue` refuses to run:

    error: you have staged changes in your working tree

Drop `LOCK_DIE_ON_ERROR` so that we take the lock gently, just like
other callers that only refresh the index, and skip writing the index
when the lock is held by someone else. This also lets `git write-tree`
and `git am` proceed while another process holds the lock.

Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
---
I ran into this while rebasing a ~120-commit branch with Magit open,
which runs `git status` in the background. To recover from the
half-picked state, I had to commit the pick manually with
`git commit -C CHERRY_PICK_HEAD` before running `git rebase --continue`.

This can be reproduced within a few tries by rebasing a long branch
while running `git status --porcelain` in a loop, or triggered every
time in gdb:

    break try_to_commit
    run
    shell touch .git/index.lock
    continue

If the lock is taken slightly earlier, during `do_recursive_merge()`,
the pick still fails, but that path reports an error and reschedules the
pick, so `git rebase --continue` works there.

 cache-tree.c          | 10 +++++++---
 t/t0090-cache-tree.sh | 13 +++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index b8cbb5da22..1bea880912 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -809,11 +809,15 @@ struct tree *write_in_core_index_as_tree(struct repository *repo,
 
 int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
-	int entries, was_valid;
+	int entries, was_valid, fd;
 	struct lock_file lock_file = LOCK_INIT;
 	int ret;
 
-	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	/*
+	 * The lock only protects the cache-tree write-back below; if somebody
+	 * else holds it, compute the tree without updating the index.
+	 */
+	fd = hold_lock_file_for_update(&lock_file, index_path, 0);
 
 	entries = read_index_from(index_state, index_path,
 				  repo_get_git_dir(index_state->repo));
@@ -828,7 +832,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 
 	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
 					   prefix);
-	if (!ret && !was_valid) {
+	if (!ret && !was_valid && 0 <= fd) {
 		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 0964718d7f..4b7547e108 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -286,4 +286,17 @@ test_expect_success 'cache-tree is used by write-tree when valid' '
 	test_grep ! region_enter.*cache_tree.*update trace.output
 '
 
+test_expect_success 'write-tree succeeds while the index is locked' '
+	test_when_finished "rm -f .git/index.lock" &&
+	test_commit locked &&
+	>uncommitted &&
+	git add uncommitted &&
+	>.git/index.lock &&
+	git write-tree >actual &&
+	test_path_is_file .git/index.lock &&
+	rm .git/index.lock &&
+	git write-tree >expect &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
2.56.0

