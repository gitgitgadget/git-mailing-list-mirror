Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521208;
	b=fI/Q2dSb13dbMjdkdwljfh9IUdeuuj+3G7Vpg+QArymox7LHSeK/nVwDeHSwUQ6rMlxg
	 328rdGc4zit6HV4QBIgzFNqnD8gBXIblnOghH4YC+0jwh4nBR0UCcqWKvp/lUn2EDcHCs
	 P4QPJqbnN7heaXBkIAtIgKDhJscgDrK7hxb55Qf+eCKPmgg76vyomJWpNqo5fnArgjFCN
	 ky7DZAOWiewdPAReYsu2ySO8LnWYJij0QKFvCuqtrvHtBlCXNPXl91TCREbqD9f7FUlUu
	 TPUxM+NSibYKWLyuhIw05UULpd4UkIsRffn+5Wm60iUR0ufW2uUH/whTggMXCTzA1jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
	b=IP6/+eW9tlCKJypplcJQCtwl43fEUgWsPeS9oQi5+JnIpOCcAWrV9OsFRcPJkebjyg0D
	 +MC+Aquvs9C6TZgk44rNYiyxwXnTB+ZFKP5PPies0ZQHFAMsV+z+G3Vmq11j6qFZ/oEJB
	 0tGmswStguFuM9NhaN2pIrH7mOx+K30Dq3WVU1kldDeGtW2GrGQRxiJXX8B0kxpWHFfEy
	 gH1dk8zjnuN7XoS0XYQ8aldrPgEExCK7AF1QK2hs8WYLxmXWNPSTli3bjPfW6XoLK28Et
	 DeBR3FXwwuGIeuo9fRqbAjTcPQXmq5vI+dhdE6sIyQ8tYpErjMeJ6xeEaou6WzeBkLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqZfVC5W;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B35606A332
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21B35606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JqZfVC5W
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso1616645e9.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521207; x=1795126007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
        b=JqZfVC5WOs9W5IFm/tMrGJZLPfTYluCkuSI4bQN/0ktEioyeJezqK7AbE9IlKHGwQL
         PQWMUUso4gTAaFRxWQyGuZxhOTLjZwczKR+NDqagplcJume3FdOjmQEpyRF2mIDu90Hn
         bl9x1GJ3KnO5d6wKFTVKuazf9cxwIxd7o9stUR6lJ8ljKB6VL78yTvSAsZcCL6G93aWe
         q8T4p+IWEoMCvg2ksP1NLUYZZWn6IGUW2WcME4vmMjYO7nfi6tDhuIXOV73C2oy0Lcvp
         GdmcdiRhSsOqkIZuOfemDmv8dd/Swnj/gFk+WYuO70tMGR/yKcF3ZX93/Eii9hh2RDxH
         4AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521207; x=1795126007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
        b=HP8PU3wAcRqLjSjgOd1brncdJ27XD5IBOpAoIxtXAusSgKLxEn4Lq4X2/EBZeO1yg4
         iI0pDoxY8xC+MVY0bzFXQUNCyRAJ10Ke3keD2V+LEC7UEIAl9JU8mDtTtfL1/NYMnT7a
         3F/Ml1wu5MIYmwnxm03cG6KIs8jKUZhtTf/GI35QBL/uH8m4C9adgA/BnW3w7yxCyF1+
         RTD0/yPPXZRq0DWuwpx1PdTgf1la+AI6r74n5lAqAzrl2oTynRJb5lKmivSH2pyXATk2
         3YZ1B9SGcbeh6tUvAWm3AVVz7YZTI5id4eaZxVQwZlrfebH8vB9asPm6EYPVbQ4LfeSo
         ieZA==
X-Gm-Message-State: APuU4Z82eosdr+CWAGXQjlB/kTbwLa8G5AdLmMoNkxrm2olaH9TuuoR+
	3bdZXhTwvav70eaOP72sgAGv61tmUcywydn2LaWH6slskcduDH1FMWw8VOuJV0SK
X-Gm-Gg: AYBFou30Pp+jMjwKNMoIC9g/BHYNEcrC8HGvkyKgRcj6HO3VJyOYzNLsm4re76bmjbM
	hXtO69Yhe0UnX/JAeEMK1jQrnATVh1v14p6uH/k5v0ItXHXiZPBeV+7hb6xWj9vgNO3Zck2zh9h
	cQfB1UugFjd/6XoGxjcItsnkMSRr5X/Xqai3sqLC3ovoszmG02gMovlGU3MtczMyT+aZNHJDwiI
	afBACxU2HocbzPooOd4vOMbTNDiljVuYbFN3LYSIsnWxu+qF6vAmvJsRdQtj0sqER8ZCPSeS2tZ
	nc+e3HzFGuzrgIuUrDeILa6MTX0WUP0klWtKujUgchORq+43vr4ZEvlEeIkHUGqv8cTA6pqqrox
	P1KXy0wPrTTiAYTXPlboLe2mM4l+S1dZQOeByBozEXP4r7+izvEFDimngxIOP8P6o0cBDQd++Vs
	haemit87F5NqZ4ROCwdAFOdBoskVb8zxK7WfzkUxRvah/zGDVfGXgPmf//n2plmlUtL8JfbO/6U
	TI4mBPTSuEflqOTWPdSDwvRMySE7bJHbfR5jtMIPYjW0FpVkyJB2STxhAFI+fTULqeLKr4j7CVL
	nHgzNMTHwRoX3KpT6VUEOpGyfkGPLmEFjORQeVxwZf6+2cXQZbuKafoXPjyf5m3DUVLqFCgivh5
	sZX2+I4OUsSbAB1bLX5ABug==
X-Received: by 2002:a05:600c:4e45:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb55a84b08mr11560785e9.16.1794521206542;
        Thu, 12 Nov 2026 14:06:46 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29daa5sm106098995e9.12.2026.11.12.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:06:46 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v4 5/5] t: stop calling root refs pseudorefs
Date: Thu, 12 Nov 2026 22:05:41 +0000
Message-ID: <368ea8b6bcf8006173107eada8dac4aad9178ff9.1794520948.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794520948.git.andy.koppe@gmail.com>
References: <cover.1794000450.git.andy.koppe@gmail.com> <cover.1794520948.git.andy.koppe@gmail.com>
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

