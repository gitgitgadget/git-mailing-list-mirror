Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B41DC1A5
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164526; cv=none; b=LKhlnteSOnvQSOZCZSKRnevqlJKyP+GV5v7Znaj5JZCMSn4VmFRDHv4c1ThShq2olCLwTOAoD/IpvUJgEJX/ugX6qJJPfYaHZqsO4KRNYyVN9CucxMb1yQsqkPb4i5PAKoWXDDeHt5Y3GGiAv1cHp06gkuy2nasrFXcFkx4xBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164526; c=relaxed/simple;
	bh=pdftGWR2wkDueuSEPFxImY0oQ0rI771Kxqcqh8gGNOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBLviPXYVB1F8C82v+0bsqXYaQyLsLkO6ZnKBRLrOWyd//aHEV+AULfpSRUIvsaHzj7AFt/6TVAit5kbZicdDFtB8QHXf32p9yb8ZXaRHdkf2H3N2qpWmzLgJc+XwK4QzbNjaAhMPXQAQKCWYeUYUt5hUzLAzG00ft252ccUJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcY6nGNj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcY6nGNj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314b316495so8406915e9.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729164520; x=1729769320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKfhZhurT9AMbToSk/jgVuwJpNW9Sk0jXXNaQtmczto=;
        b=KcY6nGNjp2fOUprIzSH+Zie/XxG7jTttnxv1XzrQyyEHi0OPUUCrI+7vEjd2m/37fx
         I72WAhPMKyAF62BBSns4ssOSre8gTMxT0RpRn/dol6y56abPqA1f9b7APfB5I6HAZ+4H
         4itCQWX0JN80tajbog+7LIDHssWyxKxIxU/qdDWzmdSMwvfsfbSOwZv6i3itDLx6KS8j
         A9b3et2QvIOehedZfmwcEiRv10FhFQGVaPzNnpcHgSWTSqRkp8jZhVPqJ1/+q19rMYDv
         VNbfjGtm7Cfqb3CKTgcwu/74R7jQlUQKFFoz9UAND369VS2px0yuSbKRYzas1Do1JRnn
         1qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164520; x=1729769320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKfhZhurT9AMbToSk/jgVuwJpNW9Sk0jXXNaQtmczto=;
        b=YU2HIEXVTgHmqlF+pnc9YRK0uAtvvCUGWPzRbWWRmk1JIiikT9arsyh8bRpqDuSU8t
         Nb1EBBKetjYgv6w87ZUTHBap7TK3aR72/R01CnBnZzJRlf39yVNqWFu+i7/33h8aXW0C
         5ezITKCCU2/z7k+Lrz7fsDaRoG7Z2N/+mDIgY+9mon/hZlNroNRRKukfgwx5PPjadTLg
         la192id8XuZi8ThjMoWVriFLM1oFoGTf+Sl9IPyhilwCYlEZyiV3tElf1SGhtRPELup2
         YhkDW6sjIoUz3mq48y0xTFqBmxek8ffHn2FW8n6N+1nu8gGl7ICpvb9DO9y/PMbjJlkt
         d+Gg==
X-Gm-Message-State: AOJu0Yy7r1YlR0uCVcgq1h6e/Du1UQqGfGvEk7m3EoIPy0jTMQTZfx+K
	WTxnjXgSASgGkkodWSqhvdrEGozMkRc5PmjOv9+PVT1DiIdwUhG0yNQPDw==
X-Google-Smtp-Source: AGHT+IHQcFoqk9TMyyxaupRUskNXQeylegm3B0bOBDvaXnx1FLkU3a94FKy/TUtwUTlLe4e114IccQ==
X-Received: by 2002:a7b:cd8d:0:b0:431:5194:1687 with SMTP id 5b1f17b1804b1-4315194172dmr42903255e9.18.1729164519819;
        Thu, 17 Oct 2024 04:28:39 -0700 (PDT)
Received: from void.void ([141.226.9.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c39c78sm23324685e9.20.2024.10.17.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:28:39 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] t: fix typos
Date: Thu, 17 Oct 2024 14:28:35 +0300
Message-Id: <20241017112835.10100-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation, comments, etc.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
Synced with:
  - Merge branch 'la/trailer-info' into seen.

Tested:
  - ubuntu-latest, GitHub Actions.

 t/t0000-basic.sh                         | 4 ++--
 t/t0021-conversion.sh                    | 4 ++--
 t/t0212/parse_events.perl                | 2 +-
 t/t0600-reffiles-backend.sh              | 2 +-
 t/t1016-compatObjectFormat.sh            | 2 +-
 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 t/t1400-update-ref.sh                    | 4 ++--
 t/t1506-rev-parse-diagnosis.sh           | 2 +-
 t/t2082-parallel-checkout-attributes.sh  | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 98b81e4d63..35c5c2b4f9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -684,7 +684,7 @@ test_expect_success 'subtest: tests respect lazy prerequisites' '
 	write_and_run_sub_test_lib_test lazy-prereqs <<-\EOF &&
 
 	test_lazy_prereq LAZY_TRUE true
-	test_expect_success LAZY_TRUE "lazy prereq is satisifed" "true"
+	test_expect_success LAZY_TRUE "lazy prereq is satisfied" "true"
 	test_expect_success !LAZY_TRUE "negative lazy prereq" "false"
 
 	test_lazy_prereq LAZY_FALSE false
@@ -695,7 +695,7 @@ test_expect_success 'subtest: tests respect lazy prerequisites' '
 	EOF
 
 	check_sub_test_lib_test lazy-prereqs <<-\EOF
-	ok 1 - lazy prereq is satisifed
+	ok 1 - lazy prereq is satisfied
 	ok 2 # skip negative lazy prereq (missing !LAZY_TRUE)
 	ok 3 # skip lazy prereq not satisfied (missing LAZY_FALSE)
 	ok 4 - negative false prereq
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index eeb2714d9d..9e6c6ee0d4 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -1116,11 +1116,11 @@ do
 		test_delayed_checkout_progress test_terminal git checkout $opt
 	'
 
-	test_expect_success PERL "delayed checkout ommits progress on non-tty ($mode checkout)" '
+	test_expect_success PERL "delayed checkout omits progress on non-tty ($mode checkout)" '
 		test_delayed_checkout_progress ! git checkout $opt
 	'
 
-	test_expect_success PERL,TTY "delayed checkout ommits progress with --quiet ($mode checkout)" '
+	test_expect_success PERL,TTY "delayed checkout omits progress with --quiet ($mode checkout)" '
 		test_delayed_checkout_progress ! test_terminal git checkout --quiet $opt
 	'
 
diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index 30a9f51e9f..7146476c69 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -204,7 +204,7 @@
     }
 
     # A series of potentially nested and threaded region and data events
-    # is fundamentally incompatibile with the type of summary record we
+    # is fundamentally incompatible with the type of summary record we
     # are building in this script.  Since they are intended for
     # perf-trace-like analysis rather than a result summary, we ignore
     # most of them here.
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 20df336cc3..bef2b70871 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -271,7 +271,7 @@ test_expect_success 'setup worktree' '
 # Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
 # only appear in the for-each-reflog output if it is called from the correct
 # worktree, which is exercised in this test. This test is poorly written for
-# mulitple reasons: 1) it creates invalidly formatted log entres. 2) it uses
+# multiple reasons: 1) it creates invalidly formatted log entries. 2) it uses
 # direct FS access for creating the reflogs. 3) PSEUDO-WT and refs/bisect/random
 # do not create reflogs by default, so it is not testing a realistic scenario.
 test_expect_success 'for_each_reflog()' '
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index be3206a16f..92024fe51d 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -117,7 +117,7 @@ do
 		git config extensions.objectformat $hash &&
 		git config extensions.compatobjectformat $(compat_hash $hash) &&
 		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
-		echo "Hellow World!" > hello &&
+		echo "Hello World!" > hello &&
 		eval hello_${hash}_oid=$(git hash-object hello) &&
 		git update-index --add hello &&
 		git commit -m "Initial commit" &&
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3d44bd7643..2157f37da3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -708,7 +708,7 @@ test_expect_success 'reset with wildcard pathspec' '
 	test_all_match git ls-files -s -- deep &&
 
 	# The following `git reset`s result in updating the index on files with
-	# `skip-worktree` enabled. To avoid failing due to discrepencies in reported
+	# `skip-worktree` enabled. To avoid failing due to discrepancies in reported
 	# "modified" files, `test_sparse_match` reset is performed separately from
 	# "full-checkout" reset, then the index contents of all repos are verified.
 
@@ -824,7 +824,7 @@ test_expect_success 'update-index --remove outside sparse definition' '
 	# Reset the state
 	test_all_match git reset --hard &&
 
-	# --force-remove supercedes --ignore-skip-worktree-entries, removing
+	# --force-remove supersedes --ignore-skip-worktree-entries, removing
 	# a skip-worktree file from the index (and disk) when both are specified
 	# with --remove
 	test_sparse_match git update-index --force-remove --ignore-skip-worktree-entries folder1/a &&
@@ -2081,7 +2081,7 @@ test_expect_success 'grep is not expanded' '
 test_expect_failure 'grep within submodules is not expanded' '
 	init_repos_as_submodules &&
 
-	# do not use ensure_not_expanded() here, becasue `grep` should be
+	# do not use ensure_not_expanded() here, because `grep` should be
 	# run in the superproject, not in "./sparse-index"
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 	git grep --cached --recurse-submodules a -- "*/folder1/*" &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index eb1691860d..bb057596f1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1838,10 +1838,10 @@ do
 
 	test_expect_success "stdin $type create dangling symref ref works" '
 		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
-		format_command $type "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
+		format_command $type "symref-create refs/heads/symref" "refs/heads/unknown" >stdin &&
 		git update-ref --stdin $type --no-deref <stdin &&
 		git symbolic-ref refs/heads/symref >expect &&
-		echo refs/heads/unkown >actual &&
+		echo refs/heads/unknown >actual &&
 		test_cmp expect actual
 	'
 
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index ef40511d89..a3464976e3 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -195,7 +195,7 @@ test_expect_success 'dotdot is not an empty set' '
 '
 
 test_expect_success 'dotdot does not peel endpoints' '
-	git tag -a -m "annote" annotated HEAD &&
+	git tag -a -m "annotate" annotated HEAD &&
 	A=$(git rev-parse annotated) &&
 	H=$(git rev-parse annotated^0) &&
 	{
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index aec55496eb..da06cafad7 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -91,7 +91,7 @@ test_expect_success 'parallel-checkout with eol conversions' '
 
 # Entries that require an external filter are not eligible for parallel
 # checkout. Check that both the parallel-eligible and non-eligible entries are
-# properly writen in a single checkout operation.
+# properly written in a single checkout operation.
 #
 test_expect_success 'parallel-checkout and external filter' '
 	set_checkout_config 2 0 &&
-- 
2.39.5

