Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574297;
	b=B6JDFm5WKtd4K3tXhbzL8Fta7s2UwnVcC2xwOUZZMC9L+sUQR6Gwvu4HnQOq6bQg2JBC
	 N1I9nHfYre+Ike28Gu2B+GHEHmSZ/cp8EWoYbtbZnz2/1uPdWsBT6pODAKjaC3XXdzt29
	 0qvzjGl8xGLhMeL/7r0k09ZgPV5e+Y07e2pm5j1vneZFl6LeX1meABbNdjqHoVb+ekDpv
	 qMUsdXalmii2uYLgmcA4cyTa4cMjjAHARNxdVPKoQEWAMKkbp1WKp7//aIUCC4TwpiB2v
	 hVw8cTbNeHPVNATOHr4jclboNrhx3wgeOTxdh2cRN+pz9BV99CYzAuatSWQdly281QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tbE08Zv9joNPLKw4IeurPIeNpBRFZ3sqRWiN18fOC9s=;
	b=lZcl7PuKh208TZB0YrY8ayeWdcSxkKu17HXGNoOWat8zTwfgeClCyKLAFXCxy+kh5Z1S
	 Pz5NX8aEIxXkEdez3+jS1P5hFbk7r39ngi3z0rba30oz0NLT3m96ddRMcknGOa0UYS30j
	 b3m56LnR+nqTT7hR4HxSBG5jujIlrkHyWQRhsv+hGnmfXXaEDKrrvi8MYxZOmecjZOqDN
	 KBKJgxUAWahbGMNiK1YEpgi2JxfOcmzGobDO7H19aDj0csuUm7FMbmUJPvakm0ChFjJqg
	 CDv8Rh/2biGcUkfgOYpQjAVA6yaZyHBvGuYoo3Qx4GFfZ7/8cWEqkATjc/8HDmzlXGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8LnF8NY;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E83606A32D
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E83606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8LnF8NY
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so15341115e9.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574281; x=1794179081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbE08Zv9joNPLKw4IeurPIeNpBRFZ3sqRWiN18fOC9s=;
        b=p8LnF8NYsVMNhg83QgUfAapgZHQzWfAoPtF4TYZf0Ao150hMMSWeoG7VptMpDaNB1W
         l50BWKdq0kzoe2R8ftD+sDN7i4NftDD94PoPt042ZOlZjGP2Kdgv03sPJzjtcglO6J0i
         KFAePMfbXWV/QExkgzoXFmffJP1GRXo/EfgtRbGt00Sk/pshAiWgpjc50P1aF+ZfjTpK
         4cpJB5gO6+BQABSVt82pNYvTs3NE04M4ZZkaMjAN+6njOMae8BUJFa1ans9fd3JO+5I0
         LIVzlM+7qMG2tIVmMvz5vJibAF6kHSpzI2nlUSu+yWHn/AyUc/ovA78pfBElwHTmyXnN
         pmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574281; x=1794179081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbE08Zv9joNPLKw4IeurPIeNpBRFZ3sqRWiN18fOC9s=;
        b=fQPjNVYaztPZIgyAxccZ1Nt7FNivP31FAJqsvcIavOKSfG/xbC2oDXzT4ekc8QlR17
         ToDk6uQ38XVwF2IqhdTp7BNmSl/WqhJl3ysr/Laz3TWDPqufy19PE52ufAdp8pAK/Ito
         p+3gJhKuAYJ8l9QbPzUcc8FYls4ULZhjoWJrKpPNbhoM1MGicrvGDE2hN5jufaXey4kH
         oArWnDr57XeNsXevmTJZQ+d5xBqONYUM2O81DLy0QX1BCBpHDjGEWCDF5PhieGS0ZO1b
         IyRi2qOEk/0jZHpXbW1pUTksppo1jGS2G9Kd7kcbSmm5u4UJpmvrVCAJWiT888fgDzfo
         Lr2w==
X-Gm-Message-State: AFq9FYIIm8Ibuw8JpHH7CdBtPY+QtC+AWPTGhacmedZ/Nl6/MDV1f20U
	LsGloaNNDErcpdPOkwtnQeuhtKlcjBfyY290hOK7EJki+biDNltmQrDjizRDXw32
X-Gm-Gg: AYBFou0ogvOVW9jE5wnSLgZlYVgT1NVFkQtfBBsrhqGT2uFra9c/xkMrs2ID/AXDvgl
	CoLeQMTK/Y0L1EBNDn1niRRGw+BbzqvI0HqEQWkV/icIuw7PapHtiibloiA1Hfn27DwQG9df598
	HCfM7MiRsUGutiA25PjaH5oYYyiuH4eSmq9oQYH2rMuGxvdvBQkg5xzfmpJCEsmmeci7BjM34ZH
	Ike+JDZXOn8kHzySrinB3x5Q6DP0PT4VHN3d/j8KPluMnMUfB6SJyzJiyX+v2KLd/UU5VYTQykP
	+/mh7W0pjjflCb26IXrG6QUFvN7wDOx6kBE/EcZZ1kk4tE3HPGYRSfZ7JHRypbfS8JDLVoHOa5k
	zuiBNKZLGVmml0xT7aQYqX/LaqqKqlIe9/e6/1qP9Kiuo0C+anPeLyJwbfHWbEM5/Uf/EhmfhhC
	YpuPzzy2Ft8Fg2dW0kMgu874tQ/lyqeejXuTz1pNkewEzKnQqWJX019jY9gmhPKdVdNSPsGQwx6
	PsXkR9fZOsv4AbfDkRTEIxaCFPEugBQIZQIV5+kyXYt5NCMWqa5xOj630mrO2PGzZs8KRj0J8sg
	MG2oaeN1F9tVZhWGFiOCWjnikrcwPivqTdQNZSuNAX8zHOWS9U6XPrxPdwn353Fq8vq69a3EUkW
	Kuh+SxoO8joKX+kL1y1opz+kDNlCqwQWoptKPzbI1gXo=
X-Received: by 2002:a05:600c:a4e:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4ac187a766bmr191513845e9.21.1793574281291;
        Sun, 01 Nov 2026 15:04:41 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm135151125e9.4.2026.11.01.15.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:04:40 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 5/5] t: stop calling root refs pseudorefs
Date: Sun,  1 Nov 2026 23:03:23 +0000
Message-ID: <20261101230326.3675597-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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
index a2fc257f98..5a6d6fef55 100755
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

