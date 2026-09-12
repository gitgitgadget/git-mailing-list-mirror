Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C93346A0B
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177580; cv=none; b=eIB8zux7r4GQ/NTAS6uUndk1UiBUT6sqLhicsj/NXeMyXjEeskZ4zwecvq1jFAR7YP66Q6G5OAi14wXXitMDtF+493NP8loO4arvSy1VQvec0LwlCduwDyXkNtqs/S/G2yHUskssm6fZsEb5JRphko2l1SBNwKIRw/bC6Lq1628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177580; c=relaxed/simple;
	bh=1katPlKx9+yArZnDuy9QLuImpcJYIMcv5lqkx5Q7T1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEhi6kiX7AfWHs05tfWmBbswYwaKrkBGTuf5DQcaz9PBtwE+gfL3ITrFoVqVTvwGRVYauOT1+6IvS2hEA5xOiDt7WWQd9xWmbyhWHy0jOn5Z4LmT+RhIAKMsw4YFa6RZYJIYwT5JL/GbQEy73e4o6FufesJ4FMEiWwho/F5hNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYe49z2w; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYe49z2w"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so358353a91.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789177575; x=1789782375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4L60RGgmJFVg1YXGk4KGGuJMo3BVi1+CZFNQt9y+ylc=;
        b=bYe49z2wHGVfrXGl7+ugQFATJn7r5C0E2nWX+JQc+cITFp+k2mVwKMkqMi8lgEkeTZ
         27g25FgVqA++BSaEqVC5f9EMpbiG5gx3ktTOK3jajJBLSBiE6cg5jCZEKIDcEpUBNaFo
         OJyxqcVIVPzCATsFU3YK0oM69gAsaHWfXSAuBx28sfo9yxVeF+AnISPylc6+JsPk2WpH
         K2xgEFMFgR8NM45ekeQwc1oK2hv942vOWa5f11mQrdHd6f3nZbYNzCbvyNl7guo3MwiO
         xfLy9VjgPDSKKBwxIEuQAnob7JfpufcmEYcg03VkwfUv7xrR6DIQTFIVrkOlOqQUFbRu
         se+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789177575; x=1789782375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4L60RGgmJFVg1YXGk4KGGuJMo3BVi1+CZFNQt9y+ylc=;
        b=bn8AoQ4XRZpxUGuP9JBumzLHBqNHM/GgDrmBx+sBZxIamt4whq3Wdew8f3sUr/YuHP
         7vg2Ju5+VZ7fG60OORxmuNHxViOaI1GGBJSuZpe9JotJGZ6hhAKgfoX/70HeOEeG7eQy
         du2MkTlBOnTtQyf5IQiP79lIp+F3hUtv++QXa4hDti/WBEkzL9oamVYZ7ic14hUNhr1i
         aykKbLbIwRyIExNyp/pAE2lt45w8l4GLX4OVle8nSocDNAMXNTbFOZpKd2PYX/5pnzg0
         lwOKGwd4Onf1T0Hp8lB/EL0GQ2mn4oJ0nBWVU2wwT9paVtmCdAambUPtF/C3DablMmgd
         yu7Q==
X-Gm-Message-State: AFuF++mM7B2/sa50F0DdrsxOHRXEBuUdwTcHETF0TBqvw/1z1IDY7v15
	NGZwRoWLhol148fT8NA9XFOri4MGteY1krQVIYkqynaVlcbkl9BOXFme1G2eQw==
X-Gm-Gg: AYBFou087N1/18Q8/4GP6oXL/bgnW5XEzWDlayGKKGQsuHguzz28vW5DWRxrMbFr+XA
	YgqKZS+1YpvyVNSotnuNk0EKp625FPIwdRLwNSJNbuGUENETRDDsSoSa2thMqs7xI8agtah03f3
	bJxsz0kQ5btNOqsbh5hLQVd6RBsrlxyhsgPzh4AlU0ZWUNhL1a6tMmoPL8ZFUmZI+T1epSrxMoa
	RGKuq6SgrWVmjmM/bpKNY05eNWG+C21I2YOWQ9lnD/mhecouJi1ycZ0GDqVz7gHrNOOafBPQ7QL
	fIWdAmvWnZareAWgU7V3+Y0bKlpjbpHju/eEGcRGBe/UFMRTCdhaU1f6AkifLpVrElAFMSUi6AU
	Ox3L3xxiR4yaAX76pHwl/3H765/zrVqC6HCZhi5giY+VxNqRpRtGGbbN4RkYcpEIBZI/X4GoqCu
	pOcSeCkyVNHJz5kZ6zzWoexn5CMpyQse6VJ7CcHjQLYxVW4tRTQP9eEKwn80dH9m9ziJdKjvykX
	1GLSHKmSy3E2BE=
X-Received: by 2002:a17:90b:498c:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39d9bc6a1admr11061002a91.2.1789177574483;
        Fri, 11 Sep 2026 18:46:14 -0700 (PDT)
Received: from tiny1 ([2601:646:8601:e250::afa4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm9952831eec.31.2026.09.11.18.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:46:13 -0700 (PDT)
From: Ariel Keselman <skariel@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Ariel Keselman <skariel@gmail.com>
Subject: [PATCH v3] refs/files: avoid packed-refs lock for root ref deletion
Date: Fri, 11 Sep 2026 18:46:09 -0700
Message-ID: <20260912014609.535922-1-skariel@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deleting a root ref queues a packed-ref transaction in the files
backend, even though root refs cannot be packed. For example, holding
.git/packed-refs.lock makes "git update-ref --no-deref -d AUTO_MERGE"
fail, whether or not AUTO_MERGE exists.

This also affects post-commit cleanup, which deletes AUTO_MERGE after
updating HEAD. In a linked worktree with read-only shared metadata,
commit succeeds but cleanup reports a packed-refs.lock error. Deleting
CHERRY_PICK_HEAD and REVERT_HEAD is affected as well.

Skip the packed transaction for root-ref deletions. Keep loose-ref
locking and packed-ref deletion for other refs unchanged.

Signed-off-by: Ariel Keselman <skariel@gmail.com>
---
Thanks for the review, Patrick.

Changes since v2:
- Run pack-refs after creating AUTO_MERGE and verify that it remains loose.
- Compare the state of all refs around the failed mixed transaction.
- Feed the deletes directly to update-ref and omit the optional transaction
  commands.
- Drop the redundant test summary from the commit message.

AI assistance was used to generate the patch, tests, and commit message,
including this revision.

The full test suite and all 249 unit tests pass. t0600 also passes with
SHA-256 (one platform-dependent skip).

 refs/files-backend.c        |  8 +++++---
 t/t0600-reffiles-backend.sh | 40 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4c7858787..0333d5d355 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2981,10 +2981,12 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
-		    !(update->flags & REF_IS_PRUNING)) {
+		    !(update->flags & REF_IS_PRUNING) &&
+		    !is_root_ref(update->refname)) {
 			/*
-			 * This reference has to be deleted from
-			 * packed-refs if it exists there.
+			 * This reference has to be deleted from packed-refs if it
+			 * exists there. Root refs are never packed, so we do not
+			 * have to delete them from packed-refs.
 			 */
 			if (!packed_transaction) {
 				packed_transaction = ref_store_transaction_begin(
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 74bfa2e9ba..560caf56b0 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -519,4 +519,44 @@ test_expect_success 'symref transaction supports false symlink config' '
 	test_cmp expect actual
 '
 
+test_expect_success 'deleting a root ref does not lock packed-refs' '
+	test_when_finished "rm -rf root-ref" &&
+	git init root-ref &&
+	(
+		cd root-ref &&
+		test_commit initial &&
+		git update-ref AUTO_MERGE HEAD &&
+		git pack-refs --all &&
+		test_path_is_file .git/AUTO_MERGE &&
+		cp .git/packed-refs expect &&
+		: >.git/packed-refs.lock &&
+		git update-ref --no-deref -d AUTO_MERGE &&
+		test_path_is_missing .git/AUTO_MERGE &&
+		test_path_is_file .git/packed-refs.lock &&
+		test_cmp expect .git/packed-refs
+	)
+'
+
+test_expect_success 'deleting root and packed refs in one transaction requires packed-refs lock' '
+	test_when_finished "rm -rf root-ref" &&
+	git init root-ref &&
+	(
+		cd root-ref &&
+		test_commit initial &&
+		git update-ref refs/heads/packed-branch HEAD &&
+		git pack-refs --all &&
+		test_path_is_missing .git/refs/heads/packed-branch &&
+		git update-ref AUTO_MERGE HEAD &&
+		git refs list --include-root-refs >expect &&
+		: >.git/packed-refs.lock &&
+		test_must_fail git update-ref --no-deref --stdin 2>err <<-EOF &&
+		delete AUTO_MERGE
+		delete refs/heads/packed-branch
+		EOF
+		test_grep "Unable to create .*packed-refs.lock" err &&
+		git refs list --include-root-refs >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

Range-diff against v2:
1:  370bb6441b ! 1:  e035ce46b4 refs/files: avoid packed-refs lock for root ref deletion
    @@ Commit message
         Skip the packed transaction for root-ref deletions. Keep loose-ref
         locking and packed-ref deletion for other refs unchanged.
     
    -    Test deleting a root ref with packed-refs.lock held, and check that a
    -    transaction deleting both a root ref and a packed branch still fails
    -    without changing either ref.
    -
         Signed-off-by: Ariel Keselman <skariel@gmail.com>
     
      ## refs/files-backend.c ##
    @@ t/t0600-reffiles-backend.sh: test_expect_success 'symref transaction supports fa
     +	(
     +		cd root-ref &&
     +		test_commit initial &&
    ++		git update-ref AUTO_MERGE HEAD &&
     +		git pack-refs --all &&
    ++		test_path_is_file .git/AUTO_MERGE &&
     +		cp .git/packed-refs expect &&
    -+		git update-ref AUTO_MERGE HEAD &&
     +		: >.git/packed-refs.lock &&
     +		git update-ref --no-deref -d AUTO_MERGE &&
     +		test_path_is_missing .git/AUTO_MERGE &&
    @@ t/t0600-reffiles-backend.sh: test_expect_success 'symref transaction supports fa
     +		git pack-refs --all &&
     +		test_path_is_missing .git/refs/heads/packed-branch &&
     +		git update-ref AUTO_MERGE HEAD &&
    -+		git rev-parse AUTO_MERGE refs/heads/packed-branch >expect &&
    -+		cat >stdin <<-EOF &&
    -+		start
    ++		git refs list --include-root-refs >expect &&
    ++		: >.git/packed-refs.lock &&
    ++		test_must_fail git update-ref --no-deref --stdin 2>err <<-EOF &&
     +		delete AUTO_MERGE
     +		delete refs/heads/packed-branch
    -+		prepare
    -+		commit
     +		EOF
    -+		: >.git/packed-refs.lock &&
    -+		test_must_fail git update-ref --no-deref --stdin <stdin 2>err &&
     +		test_grep "Unable to create .*packed-refs.lock" err &&
    -+		git rev-parse AUTO_MERGE refs/heads/packed-branch >actual &&
    ++		git refs list --include-root-refs >actual &&
     +		test_cmp expect actual
     +	)
     +'
-- 
2.55.0

