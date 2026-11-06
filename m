Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000878;
	b=q9iItIF+HNVGWTQdqOlu59Z+N1pd9w/AsH3QONemATcoJJTCto99ZocHXKDFCyOrBxWG
	 7xIa/IKmF3VFAIWzIOu4hyO4E2qjQnDeTpIAo9fZxirDJWg16nihzdxgI2y3D+aoZK+Fr
	 U47RaBSRX9Mj0ZCKfrlTTrgJLvf12UJ7SGNC1pteMNSfl3h9jnx8g8OEiIWTzVBk8/o6U
	 lp4wyE4gyJpE7B+515xxPC9aGSA/CvNAardO5LfCWKJB6tHDL+JAePmw8wjpZ/nYpuHHq
	 e6JX25MdvPbb6fq2CYAG2bpyDuFsAZzKYEL2qD9TSV4QCy877dfDRBlBHixWtV33fLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
	b=GroFmWH/gEem/Sh+5yLzRiMHkAHWsdMh662pUWYta5HcXZT5nsbNneuC+iD+fTfKIk4x
	 krILO8GvMAegrwaHlJ074MX2iusuIiw4WoGvz9IN+/o1KD4yElGiRtbgSkrRHyffcjyxT
	 v74IUd+pCPj04eM96Y3XFj7VLIq9Rtf0rQGJPydCjSdHU3f3f+xlTUs+cwH4x+xure6oT
	 W2CX/2Wgsb9FPN9vvwEzLFDPMlrKm2Ixsgr+9F4u55YxTMLAzfACTqLFaH99cjs8VNkkp
	 0qhGMv4XG6uqFp2ynpahSX9pPOXYFqWcd/a6U5dg8y79JlQ386yHgbzPxqfrTjhQbIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXTBQiq8;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6A606A33E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F6A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KXTBQiq8
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso1773215e9.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 13:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000876; x=1794605676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
        b=KXTBQiq8px4EF0oZZt9fSVtRkZARQb/kpz9b0/fi6CtKWCw1ebebiwlr/GyZO57rb/
         n4bZzids9xvsG/URsaYsRhrCsJaRSyqAeO7BLj/x4Voxi2iLrAfOGqnle82SVxddz0hE
         5eXHLyX2ChxRGmHaguE4lIxqHVgz9d8AE29FFLQ/Y2FSiwP3AjkYH0jHML9sZZ7tGDpr
         FWKOsu/UmpoXAW3sGp1CxZiQozzfXYjNJ1J1JrhngYFjubAdk72YEdk6fsDcQcRFp24L
         lmiodmBHeFr7iJzAPKdreAHJn6K3SgOJIbis7FYY7znoJf8w1wp125Y9Pr58MIL4mNLx
         T2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000876; x=1794605676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
        b=VlMat3lzFtx5nHhK35XIvQo6YeS4viabivL3xvKVYPxNLFZEtCzQN33yYSmNKy99IH
         g1baqF6uveVIuvONvakurCVxGBEY2UAXVJR2zNN167yxbviIKb9AwX8xUm4TRvSeaek0
         coeAklWQELARSebLnlfq3cA9rZz6NeKsqM/EfPpNK8nXJzGQKkaLkadU4IRo4+oCAy+r
         65Y45/Bu1UBzh5McNHZjs2ZT3HvJ0NDzUL209Z3uIazm4+Gf2DPaCIVSJ9G03NxXV+VZ
         10etTBZgUAPXtHCDZdDdKgx5O/XNzJWEMawqoDh/Zt2eY9dh3lDUQWXzwE3Mbq/23vRo
         6HAA==
X-Gm-Message-State: APuU4Z+JCxdEGh37tIQbqjmFSp+xskpQ8kqmOWEcHPqcTiv910/aQjap
	iPLTMIePkSWGRfey9o/gjWU7r9gjUQNTB2dD7curHz+fjSAlMDQS2sOGhYJaeQYS
X-Gm-Gg: AYBFou13FpibD2ITyHcdj64RwoO+fhO1chA7Y8xIe2N0uRPZd1SQUO+k1+iqNM9bi7N
	DVGpQvciwQNVke2Sqky3hFA6nBVPcbVeQXxDvw7S1ht/eRwGSvN2PNqArfSjSFhE+eybtG58cZZ
	97q70Q/+erAaCszfftKI47pbZvAJr4ejvwAYpqgFhfPtnMptRsgcjzEVojqDpNcb/Zs5qewR92R
	qXlo7WZ0XxswB7xCEpkP5AhHO5i0/5+Pl9/g06tOE4StWYkfLGAnneAI4l54bi/rnrYiyZKoPGF
	0BKfYzRWIckkPXFHCPp9VCXtNYsuUAEaGAOabe6kuYZiIiLvc+iR0At4T7LwPLSKSpehzx3Y7Sx
	02Gu5X3gFkLySjYsU2NLW+2sJ+u6XTPBjL5XyDGpbxLSkfdblit+KRf77NnszMdwQsZP0J2YgBs
	ZfCkywEpTBeOKTDkOLCBb/lX5S0+jXfyJecl4pTKCpHM2yYRSW0f81Ftewv5YJ2qJjuAnWQpybG
	6zGSF3SYA76qEa0cn7yV21YM3VDHRbIRs5DtIMfs49W+1NJBroUrN6dpupG1qtdAZvPN601gMmk
	8sd/CGj57BkGVFzNqc9YJmam5FiJ3nCX1WbBYZRuZkqQNElNzjjOZYtlUjsoobOLSB0dXDbYHgf
	QgcoLH3/hqvqRbw9kevEHlw==
X-Received: by 2002:a05:600c:608a:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4b6d82b2c9cmr68929675e9.0.1794000876096;
        Fri, 06 Nov 2026 13:34:36 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271867sm9994385e9.6.2026.11.06.13.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:34:35 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 5/5] t: stop calling root refs pseudorefs
Date: Fri,  6 Nov 2026 21:31:08 +0000
Message-ID: <d8a825d8cc17ab99a287901fc4cb43642b66ed2b.1794000450.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794000450.git.andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several test titles and comments still use "pseudoref" in its old sense
of any ref outside of "refs/", which the glossary now calls root refs.

Replace "pseudoref" with "root ref" there. In t1400 and t4013, rename
the root refs that the tests create from PSEUDOREF to ROOT_REF_HEAD and
from REVERSE to REVERSE_HEAD, so that they follow the naming rules for
root refs. This includes renaming the expected output file in t4013.

Some tests also still refer to FETCH_HEAD and MERGE_HEAD as "special
refs", which was the previous term for "pseudorefs". Correct them.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 t/show-ref-exists-tests.sh                    |  4 +-
 t/t0600-reffiles-backend.sh                   |  2 +-
 t/t0610-reftable-basics.sh                    |  2 +-
 t/t1400-update-ref.sh                         | 66 +++++++++----------
 t/t1403-show-ref.sh                           |  2 +-
 t/t1460-refs-migrate.sh                       |  4 +-
 t/t4013-diff-various.sh                       |  6 +-
 ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |  2 +-
 t/t6302-for-each-ref-filter.sh                |  4 +-
 t/t9902-completion.sh                         |  4 +-
 10 files changed, 48 insertions(+), 48 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE => diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)

diff --git a/t/show-ref-exists-tests.sh b/t/show-ref-exists-tests.sh
index 1351f690eb..d4a021a0c6 100644
--- a/t/show-ref-exists-tests.sh
+++ b/t/show-ref-exists-tests.sh
@@ -64,11 +64,11 @@ test_expect_success '--exists with directory fails with generic error' '
 	test_cmp expect err
 '
 
-test_expect_success '--exists with non-existent special ref' '
+test_expect_success '--exists with non-existent pseudoref' '
 	test_expect_code 2 ${git_show_ref_exists} FETCH_HEAD
 '
 
-test_expect_success '--exists with existing special ref' '
+test_expect_success '--exists with existing pseudoref' '
 	test_when_finished "rm .git/FETCH_HEAD" &&
 	git rev-parse HEAD >.git/FETCH_HEAD &&
 	${git_show_ref_exists} FETCH_HEAD
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 62b0851852..26385aab7d 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -267,7 +267,7 @@ test_expect_success 'setup worktree' '
 	)
 '
 
-# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
+# Some refs (refs/bisect/*, root refs) are kept per worktree, so they should
 # only appear in the for-each-reflog output if it is called from the correct
 # worktree, which is exercised in this test. This test is poorly written for
 # multiple reasons: 1) it creates invalidly formatted log entries. 2) it uses
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index a702745839..01a0310762 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -1156,7 +1156,7 @@ test_expect_success 'worktree: adds worktree with detached HEAD' '
 	test_cmp expect actual
 '
 
-test_expect_success 'fetch: accessing FETCH_HEAD special ref works' '
+test_expect_success 'fetch: accessing FETCH_HEAD pseudoref works' '
 	test_when_finished "rm -rf repo sub" &&
 
 	git init sub &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1a164c96f9..95a617254b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -503,61 +503,61 @@ test_expect_success 'git cat-file blob main@{2005-05-26 23:42}:F (expect OTHER)'
 	test OTHER = $(git cat-file blob "main@{2005-05-26 23:42}:F")
 '
 
-# Test adding and deleting pseudorefs
+# Test adding and deleting root refs
 
-test_expect_success 'given old value for missing pseudoref, do not create' '
-	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
-	test_must_fail git rev-parse PSEUDOREF &&
+test_expect_success 'given old value for missing root ref, do not create' '
+	test_must_fail git update-ref ROOT_REF_HEAD $A $B 2>err &&
+	test_must_fail git rev-parse ROOT_REF_HEAD &&
 	test_grep "unable to resolve reference" err
 '
 
-test_expect_success 'create pseudoref' '
-	git update-ref PSEUDOREF $A &&
-	test $A = $(git show-ref -s --verify PSEUDOREF)
+test_expect_success 'create root ref' '
+	git update-ref ROOT_REF_HEAD $A &&
+	test $A = $(git show-ref -s --verify ROOT_REF_HEAD)
 '
 
-test_expect_success 'overwrite pseudoref with no old value given' '
-	git update-ref PSEUDOREF $B &&
-	test $B = $(git show-ref -s --verify PSEUDOREF)
+test_expect_success 'overwrite root ref with no old value given' '
+	git update-ref ROOT_REF_HEAD $B &&
+	test $B = $(git show-ref -s --verify ROOT_REF_HEAD)
 '
 
-test_expect_success 'overwrite pseudoref with correct old value' '
-	git update-ref PSEUDOREF $C $B &&
-	test $C = $(git show-ref -s --verify PSEUDOREF)
+test_expect_success 'overwrite root ref with correct old value' '
+	git update-ref ROOT_REF_HEAD $C $B &&
+	test $C = $(git show-ref -s --verify ROOT_REF_HEAD)
 '
 
-test_expect_success 'do not overwrite pseudoref with wrong old value' '
-	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
-	test $C = $(git show-ref -s --verify PSEUDOREF) &&
+test_expect_success 'do not overwrite root ref with wrong old value' '
+	test_must_fail git update-ref ROOT_REF_HEAD $D $E 2>err &&
+	test $C = $(git show-ref -s --verify ROOT_REF_HEAD) &&
 	test_grep "cannot lock ref.*expected" err
 '
 
-test_expect_success 'delete pseudoref' '
-	git update-ref -d PSEUDOREF &&
-	test_must_fail git show-ref -s --verify PSEUDOREF
+test_expect_success 'delete root ref' '
+	git update-ref -d ROOT_REF_HEAD &&
+	test_must_fail git show-ref -s --verify ROOT_REF_HEAD
 '
 
-test_expect_success 'do not delete pseudoref with wrong old value' '
-	git update-ref PSEUDOREF $A &&
-	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
-	test $A = $(git show-ref -s --verify PSEUDOREF) &&
+test_expect_success 'do not delete root ref with wrong old value' '
+	git update-ref ROOT_REF_HEAD $A &&
+	test_must_fail git update-ref -d ROOT_REF_HEAD $B 2>err &&
+	test $A = $(git show-ref -s --verify ROOT_REF_HEAD) &&
 	test_grep "cannot lock ref.*expected" err
 '
 
-test_expect_success 'delete pseudoref with correct old value' '
-	git update-ref -d PSEUDOREF $A &&
-	test_must_fail git show-ref -s --verify PSEUDOREF
+test_expect_success 'delete root ref with correct old value' '
+	git update-ref -d ROOT_REF_HEAD $A &&
+	test_must_fail git show-ref -s --verify ROOT_REF_HEAD
 '
 
-test_expect_success 'create pseudoref with old OID zero' '
-	git update-ref PSEUDOREF $A $Z &&
-	test $A = $(git show-ref -s --verify PSEUDOREF)
+test_expect_success 'create root ref with old OID zero' '
+	git update-ref ROOT_REF_HEAD $A $Z &&
+	test $A = $(git show-ref -s --verify ROOT_REF_HEAD)
 '
 
-test_expect_success 'do not overwrite pseudoref with old OID zero' '
-	test_when_finished git update-ref -d PSEUDOREF &&
-	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
-	test $A = $(git show-ref -s --verify PSEUDOREF) &&
+test_expect_success 'do not overwrite root ref with old OID zero' '
+	test_when_finished git update-ref -d ROOT_REF_HEAD &&
+	test_must_fail git update-ref ROOT_REF_HEAD $B $Z 2>err &&
+	test $A = $(git show-ref -s --verify ROOT_REF_HEAD) &&
 	test_grep "already exists" err
 '
 
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 226b3ec0e8..38648fd560 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -181,7 +181,7 @@ test_expect_success 'show-ref --verify HEAD' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'show-ref --verify pseudorefs' '
+test_expect_success 'show-ref --verify root refs' '
 	git update-ref CHERRY_PICK_HEAD HEAD $ZERO_OID &&
 	test_when_finished "git update-ref -d CHERRY_PICK_HEAD" &&
 	git show-ref -s --verify HEAD >actual &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index ecf6411288..1f59d820a0 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -170,7 +170,7 @@ do
 			test_cmp expect actual
 		'
 
-		test_expect_success "$from_format -> $to_format: pseudo-refs" '
+		test_expect_success "$from_format -> $to_format: root refs" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
@@ -178,7 +178,7 @@ do
 			test_migration repo "$to_format"
 		'
 
-		test_expect_success "$from_format -> $to_format: special refs are left alone" '
+		test_expect_success "$from_format -> $to_format: pseudorefs are left alone" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 21c9ad7c5d..43a9bf6d7c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -115,10 +115,10 @@ test_expect_success setup '
 	git checkout -f main &&
 
 	# Same merge as main, but with parents reversed. Hide it in a
-	# pseudo-ref to avoid impacting tests with --all.
+	# root ref to avoid impacting tests with --all.
 	commit=$(echo reverse |
 		 git commit-tree -p main^2 -p main^1 main^{tree}) &&
-	git update-ref REVERSE $commit &&
+	git update-ref REVERSE_HEAD $commit &&
 
 	git config diff.renames false &&
 
@@ -328,7 +328,7 @@ diff-tree --cc --stat --summary main
 diff-tree -c --stat --summary side
 diff-tree --cc --stat --summary side
 diff-tree --cc --shortstat main
-diff-tree --cc --summary REVERSE
+diff-tree --cc --summary REVERSE_HEAD
 # improved by Timo's patch
 diff-tree --cc --patch-with-stat main
 # improved by Timo's patch
diff --git a/t/t4013/diff.diff-tree_--cc_--summary_REVERSE b/t/t4013/diff.diff-tree_--cc_--summary_REVERSE_HEAD
similarity index 73%
rename from t/t4013/diff.diff-tree_--cc_--summary_REVERSE
rename to t/t4013/diff.diff-tree_--cc_--summary_REVERSE_HEAD
index e208dd5682..0f86ae60db 100644
--- a/t/t4013/diff.diff-tree_--cc_--summary_REVERSE
+++ b/t/t4013/diff.diff-tree_--cc_--summary_REVERSE_HEAD
@@ -1,4 +1,4 @@
-$ git diff-tree --cc --summary REVERSE
+$ git diff-tree --cc --summary REVERSE_HEAD
 2562325a7ee916efb2481da93073b82cec801cbc
  create mode 100644 file1
  delete mode 100644 file2
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..14f6d7e597 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup some history and refs' '
 	git update-ref refs/odd/spot main
 '
 
-test_expect_success '--include-root-refs pattern prints pseudorefs' '
+test_expect_success '--include-root-refs pattern prints root refs' '
 	cat >expect <<-\EOF &&
 	HEAD
 	ORIG_HEAD
@@ -52,7 +52,7 @@ test_expect_success '--include-root-refs pattern prints pseudorefs' '
 	test_cmp expect actual
 '
 
-test_expect_success '--include-root-refs pattern does not print special refs' '
+test_expect_success '--include-root-refs pattern does not print pseudorefs' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f6de74054a..1cb55f9301 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2693,13 +2693,13 @@ test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGN
 	)
 '
 
-test_expect_success 'checkout completes pseudo refs' '
+test_expect_success 'checkout completes root refs' '
 	test_completion "git checkout H" <<-\EOF
 	HEAD Z
 	EOF
 '
 
-test_expect_success 'checkout completes pseudo refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
+test_expect_success 'checkout completes root refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
 	(
 		GIT_COMPLETION_IGNORE_CASE=1 &&
 		test_completion "git checkout h" <<-\EOF
-- 
2.56.0

