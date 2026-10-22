Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704589;
	b=RW6Z2HjDpaemk0c5h+YokxJJR/X/j4baZXH9ahhca/lc4kfwi8j1Nc7ZDQYFB+/vBTPA
	 c7L6QxTreEtsE8s1hhdX55f4hpJB82BShDy0UkbgBapCny0kXmavyzzkkGlRbKBzLycLB
	 Z3ApPP3AAnf7mM+ddKTvbTG6SlolGf8iTMuSgf03UATZH4kI45gui6QhaxicgUliBcxLZ
	 ThtVZwIj7zkolG4StR/jXW8f3b/mRLYdjf6ECmDEe633JMYJ7Zlrm41pPzP0OKMFcwf32
	 Y+nwbGIj9C97FmHVW+9poES4sJ3KT4Yo08b13JrRZSO7QnkBgsd9xKUu02NXIHRwzmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
	b=Lw1vMYHuxKZoCKvQ2Lrhq8D7AyDCUDJvkXIZFDozJJCVgKjVu34NFpiJ86dTx5hMTW4z
	 s6TmVuFFqvRqfLJ9uQ19wa/oZQ5IujlyeDtBYzbCPGaAR3cBORDfopnfaYpb2JW5aEyou
	 hzxPPlDBROv6D5ut9WZqzCGQaEy/aqr6c/ONezkIutRb8aA8Eh46+JdiMx+10PVJjVJ7f
	 vvpUQUqchsbZ9r07h9qLSKkU/ldkEnIfJbb6ivUE6S0HBWGaxkTmrmD4hZ1mYQi8xpUE0
	 do0TMqyiIsqcR0qM3tA+soPFci7hqpxIXIy8wG6BDFWWJoHaKIhjNb+wq35YN6EpawQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPT5fEbI;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC925606A32A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC925606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPT5fEbI
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20edd106so188714f8f.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704587; x=1793309387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
        b=OPT5fEbIf5MrgVRt1Y+rptXRJcPzs6TRK90WSEzHskhNToI5HnJ3NXR1H2tk1cRvBe
         y9e8T73OU7Zk8q2rz1TLRLHzeQDKwQtE4V6ER1wd2DbZkx7jUskQYld8UYcHSjAwk1+c
         IQJVoDysbm0Br0ul6AuX3K9NPnIBBbN46BZVdg62m65BSol4/lI2/xwRbgXYE6yW7ycK
         4AGyWjDbozRqZTTA8gzBzuVoxXo3Jd3BK6adGamqwl5x0upBEJXF0sQDtCcuJ9YCk5AW
         7s14z49hCDcCd3ILKlVBqiQ53b6DB3UBtEak9QoQG/IeqJsuC0auU448PWDSGa1EqMWI
         gyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704587; x=1793309387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SFJ3gGmsGLiMyMckIW3Qeqb7GmMmfNA9P8epgI6afVU=;
        b=Xi8Ty0pLYHGwr7jwJLB1i0HvNZW71lOLwKqOhORpnIAeei1ndTbj8A7I9qFkdX6VDR
         YrP3yY553sw/0rEQ9+d8VEOYB4mw+/3tWJPHtBLl6RjWkomdNrDwuv5SvgoJbB+3lEBc
         bSs1lkyaz8R+5ww/IpBnPA8cVjmKdcu9QqvYfaIEQzScXQjLV/f1etoqjQyz1tgdDDqU
         cJQcPZyAGVlJWgNX2cGU4+xDWcEKFYMBGF82K5t95wGy9gl7NHG62ac2Q25dAMnhWGp5
         FO7PBr6aZdzWqYgOwDj7pszzEkrl1Hy3iwyLy0g/cplnQitDfo+j9IFKuT/XW1VpyrpZ
         s5fw==
X-Gm-Message-State: AFq9FYIWiapw6EX8xnkkyjmexPpiXtGpJ99qb/yLCOeh+9QRGFqTZ8LS
	S5Ft8K7KbR0M5UYSjWDOFhaRV7scz2iPrR8tcLsWt1Fmkbz5lp5TGbbkZKXZyCJY
X-Gm-Gg: AYBFou2eVwucf+Deb/9QeNxklvrBxOXpNezPF5TJ9dkB/jgfJGm9PGjJE10WXy/NQdY
	6mbfztTZSrnosU9t/kN75DJe+QS5f7Ndz7SUVbqT6Hx3whgaZwwAaRFVLnepvysc+GgmfDKT1Si
	+UpYjUyR0QWwc1CCP6GHy88u+aXCtKy+rqBWWUoDf1rannzQ56cQ9yMOvSXMekEARJPYfdo1zAH
	bbyVE9aGNNR/HB3YfYBLh6wdnPQ4uNl5dP8lDds6cgMlfMiXvF+Ozfis36Iwk+sJo/dKR/4y+Kt
	9HacKdn3XeoquBdb1XljuDPQ/WUlGn8DTuDA0pKAC4lS4DZnXYiLboRA6tLVkL+cUPi7j9ZsdT2
	ftArCAjy6Ak9jmS3LrSbrYpeXBwytm0feseKr7YBvWUZIyibEXH91xTVJd9jFGU2ryEmHCR/y6L
	Jqs60+SO1FO54CEdD9fzG47SYRUPacQ/w6LolbJSVRxCBy1rgJDYlESfZYQce89+0a5j3y7WjKD
	hlHAEHQ92KEMIlKjS5szhmkiBKFEClXHi63PaafYaYk1f3kzjoybiNWmO5XeVElMV70ZRZ/YZOY
	QsApnrgEV/IPhv2LQI5HzKKWOemC+chN1t6rch9C2qZszvCs
X-Received: by 2002:a05:6000:2c05:b0:48e:f10:ce6e with SMTP id ffacd0b85a97d-48e385891e6mr182179f8f.13.1792704587135;
        Thu, 22 Oct 2026 14:29:47 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38044e8fsm739355f8f.31.2026.10.22.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:29:46 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 5/5] t: stop calling root refs pseudorefs
Date: Thu, 22 Oct 2026 22:28:53 +0100
Message-ID: <20261022212903.177261-6-andy.koppe@gmail.com>
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

