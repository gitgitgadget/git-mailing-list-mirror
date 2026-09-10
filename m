Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7248CD61
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052135; cv=none; b=LYopZlWddArO0Cy4JTa8s0awUyrS8niCb5xUXLCRVXBtSryxZ3c7ER273N90EqhAdkGhINgBY5ElRrRl7eYw8gdCi5fa1csAE2JWvv90EsD1hlctbRvl5XT8JhRVkxmq8AvrsLBnA5yWIOCE+mvru7Go7VJS89OkNWiurzYVguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052135; c=relaxed/simple;
	bh=SkLApP0lm1iPMiXf1ITA45SHlSBeSiCKf2B/C/zm3kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvzKzbF3/z0ueA93m4nk9hGzplcH1HjA9N2qGW2CUhUaG3bFKJhBVKfjZ0NMvyWXZnsO/PVSvaiVMzMRrf/i8+r87dKzmdiXuVFxXAL4WpbS+aYlEwgAjj2w/XzUUm1SdLVpVfzxdEPTFWzxH/ehUORvLdz19mlxzskYoSCLgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjL4TXFv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjL4TXFv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso65453135ad.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789052133; x=1789656933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4e8zN/bC5Zdn2nAVqt7q/v9HqPC/mKjfI6wUsSNQ88k=;
        b=cjL4TXFvS5Dt+BAhkqFLGN2ddhdN9SYwi86j7f2oC+dka5+ids/d1NfQM2y3k05x/j
         Fv1ST8eYSXGKcQEcHuoQ4z3jEF+mTXPM75/2N2CRZ7tZsWGQud41PRM49gyz5ZIJrJgc
         1oVuGWn/muK2bWo5aWjCq4EekMMrP+Db14ZIFUZcU8JJiX1dg0jDb9LE65xkn9NhvVu5
         iIL0es+Oo8tsq6Oq6UN19EtX2+bLEbZDsL6ZxfTfGBZQVEwtPqi0TLglw/Pek7lGWp3/
         DOmrQLX7TYxWK1DcrjfpXWZiV0YTNqe4YX/ANRQjhCG26Ezl9XNl/y9p5ATzVWMfdbZF
         lctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789052133; x=1789656933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4e8zN/bC5Zdn2nAVqt7q/v9HqPC/mKjfI6wUsSNQ88k=;
        b=nD3QKPCia97yfV54qG2b4pRqU+BIxKWcl5M6UVgp70uU372fNedEJbwcspqyG32Xdb
         7Hs6jd8D6wWcU9nCjDP1y4jMhTmVej85VR47Om+epugpI8raoS8CkzD2ru8a1kyh1kcX
         845vNvSvWT3+74fCHwz3O423tMMHC/Pp6BVGOaZTNvJuBa/awyvrmc1bh9Sn3ws6x/Ws
         bLXFSUXRvdmUaAYmUWyg0gU4NAa0FrvLjffm9xim9wHgIBzdVJnEP8eGdT+6Y2YpUgj7
         cWcG7iDbGQmydrAyoUajtwQj9+s4eVUE7S1JYP+5OHcaiuhcflsAly4p/AQLAKISXV1a
         wcIA==
X-Gm-Message-State: AFuF++kqoVpc5AMi/Rj/iQpolR4HSPQ0Rk3yL0OiGKr1k2cw1Oq6bDUe
	b0EZe8VItWFPbh661aGBZAddK2guXnsndyt4PQHtYa1pAsOrOIq1AESUHB/SpA==
X-Gm-Gg: AYBFou2eK115NJ7cqqXQmycMylRglpIOle513hJgRX7+D+oqhjMS5/Uo5aZ0kH6in4P
	kyy4pId2FiwIcDacOiHfPo/ufNtnzoWKBuhL5dBOTXOQb8/5AQ9N1ov2hbQN1WN6iK1Lf2h/0aU
	eeCK0UvKqkkvDeEhAJ1K7//10st5JVxr7xo/EL3m/j50y0J7l7W5KtPFr6ODzjnN6DlljHkLKVK
	bzl4Tfo/59RYiyykmugJ+wit8pV8itIotIYCMwKVV7haFD6ReRDVbonsyXYqP2clI7CjVuseKh0
	cO1OltwG2Ds1E/lOe+BEF2ecFx5J5TBfN2jBmFnLFACdGoIVD/FYm0nsH9DlE3/WWBV6fIbsPMJ
	92nXw8iY2Ekk5JvZalw7Gvox6zAYXKOB1j1MyeaIhV+x281sFFoc4xMANVTKPrACXNBQkgQKVS+
	F7XDL3NdRbRESf+NI0L6N6wXEfBYQtikr3zsB2dIi3jyVoiusXCawuxPbakvLF+VtdOZRhbYEJZ
	+SXs7VFHc1fx+4=
X-Received: by 2002:a17:903:37c8:b0:2d9:50:a91b with SMTP id d9443c01a7336-2db12667eeemr613512975ad.16.1789052132902;
        Thu, 10 Sep 2026 07:55:32 -0700 (PDT)
Received: from tiny1 ([2601:646:8601:e250::afa4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm60017893eec.21.2026.09.10.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:55:32 -0700 (PDT)
From: Ariel Keselman <skariel@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Ariel Keselman <skariel@gmail.com>
Subject: [PATCH v2] refs/files: avoid packed-refs lock for root ref deletion
Date: Thu, 10 Sep 2026 07:55:28 -0700
Message-ID: <20260910145528.309340-1-skariel@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aqJr0ZB8qpthTEGT@pks.im>
References: <aqJr0ZB8qpthTEGT@pks.im>
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

Test deleting a root ref with packed-refs.lock held, and check that a
transaction deleting both a root ref and a packed branch still fails
without changing either ref.

Signed-off-by: Ariel Keselman <skariel@gmail.com>
---
Thanks for the review, Patrick.

Changes since v1:
- Keep the packed-ref deletion comment focused on its original purpose.
- Use one existing root ref and include a packed-refs file in the test.
- Drop the timeout overrides and redundant individual-ref cases.
- Add a transaction deleting a root ref and a packed branch together;
  check that a held packed-ref lock causes failure and preserves both refs.

AI assistance was used to generate the patch, tests, and commit message,
including this revision.

The root-ref deletion regression fails without the fix. With the fix,
123 test scripts / 4078 tests pass, along with 249 unit tests and t0600
with SHA-256 (one platform skip in t0600).

 refs/files-backend.c        |  8 ++++---
 t/t0600-reffiles-backend.sh | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

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
index 74bfa2e9ba..65ca19e84b 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -519,4 +519,47 @@ test_expect_success 'symref transaction supports false symlink config' '
 	test_cmp expect actual
 '
 
+test_expect_success 'deleting a root ref does not lock packed-refs' '
+	test_when_finished "rm -rf root-ref" &&
+	git init root-ref &&
+	(
+		cd root-ref &&
+		test_commit initial &&
+		git pack-refs --all &&
+		cp .git/packed-refs expect &&
+		git update-ref AUTO_MERGE HEAD &&
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
+		git rev-parse AUTO_MERGE refs/heads/packed-branch >expect &&
+		cat >stdin <<-EOF &&
+		start
+		delete AUTO_MERGE
+		delete refs/heads/packed-branch
+		prepare
+		commit
+		EOF
+		: >.git/packed-refs.lock &&
+		test_must_fail git update-ref --no-deref --stdin <stdin 2>err &&
+		test_grep "Unable to create .*packed-refs.lock" err &&
+		git rev-parse AUTO_MERGE refs/heads/packed-branch >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.55.0

