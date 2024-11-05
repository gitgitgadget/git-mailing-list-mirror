Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2E6BFC0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775917; cv=none; b=Da13K6vRAcbwWv5IEshuGv+nU4E0YVQVfKaQpjO8yt/BtT5kDNp9FNjspl8euj8fXXR3FN7XV3iJIi3kDARATpPfljn8X7MyxDeO7D4pUMnzH74qgV9CSL1iogh4MbJaqKyHx0MP7nA+Y6YQICl66Pj2R9Wl50UF44p9kkXNQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775917; c=relaxed/simple;
	bh=eAo96qY6/EbSNcuQ2FZIHjOU94K0gCO+1nRUlcO+Zyw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C79v1ryenUiEnkfD6ZBNnzU9RbNdcJkh+7lhHQrdTCBTRsQFDHeornccNbrjyrH+QRndQBEn1U21il0Cc5HUzeOt3XnPhscGBRSt/5iDVf3uarzuDwrgsy0xKJi+wdFOkIJQG12h0/MCihA/hbbQLhvZGcdIhpDxqjS46FxNP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZuGncV2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZuGncV2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431481433bdso43775195e9.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775913; x=1731380713; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nci9vv6OQD8LWYJR589D2UrzLcX5tEFQKizvZ3JWrIQ=;
        b=cZuGncV25UlXS6VAu5bNyzSLUIMJgZlEz8gZQ9+JH6Xlpk1Yg/Nt0g/HJUfDv9LUwA
         FJ0eIVqyQjHiCAYXrqFtpIApRtDEEmEjLkBFePQuZqiehFRKIi1J6U5lHtLcEDQSr7Ql
         jyLLRfX8LfWcOKV2nrm7n3LK3kyZ03vUFIN0CkrVNwgLhUzjNGptY3An9eZQRy2EnPG9
         F9JMxwHycoxu2Bbpw0OgC7d6L+jbxWrf/ZzIIa6ZD8bDhH0ok0/2ixtXo01hde8qmPaH
         u5Yr5VM3P2fUUaJPyN2BiUlesYjZoEeOXVxgDmThEd5E/kKhIlMcwMvrLPnVJ2Rg4nD4
         VhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775913; x=1731380713;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nci9vv6OQD8LWYJR589D2UrzLcX5tEFQKizvZ3JWrIQ=;
        b=c16dOjQ409of4/amVqdj61lmanz4iFa2gvd/XZr/ffq6FLFng+PgMU2gb8vps/Im2W
         r2ZM2nM4CamZWr3U53gic0XqAebtZo/U7Bb96FREOyEEyoOjD+MmIs4cwyF7VqrxIKkP
         Mu5Mfm6KLTZmC7Lb5FF52+7SdhL968zWpC+xMuNgBnGYtMsojbC3e8o7bx65FNNiuS7z
         Gb4YD96XDU2lX/xnQfbYM9Fi0FjCy+kEDvps4/ruXpHILPd+bGvTDyWwW4T3zMzO569Q
         CwxOwwP1wKKf35fC6037N8Iy6GlZrXDyT+snA9tIIOl8rSNtBFe0QewekYBa64YJOANY
         Yw+Q==
X-Gm-Message-State: AOJu0Yz5tzDlukDX9xU/4Bdu6FzwNIO0hJY/xuOWCmrsQu2IEnW0n0IN
	EUUNGA+y3sMilO3XsQchM5ZwYRojO+nrODqraAykL1t10pyUkehNMt3w7w==
X-Google-Smtp-Source: AGHT+IExd+H7U1QMbzZASroT+/cIBIi9KVI3PgVFJGwm5+4Na6gtWj1YZA5eNU+7JShN25dBOqk79A==
X-Received: by 2002:a05:600c:a09:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-4327b6fda39mr147306535e9.10.1730775912759;
        Mon, 04 Nov 2024 19:05:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9caae6sm201031135e9.44.2024.11.04.19.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:11 -0800 (PST)
Message-Id: <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:03 +0000
Subject: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new environment variable to opt-in to the --full-name-hash option
in 'git pack-objects'. This allows for extra testing of the feature
without repeating all of the test scenarios.

But this option isn't free. There are a few tests that change behavior
with the variable enabled.

First, there are a few tests that are very sensitive to certain delta
bases being picked. These are both involving the generation of thin
bundles and then counting their objects via 'git index-pack --fix-thin'
which pulls the delta base into the new packfile. For these tests,
disable the option as a decent long-term option.

Second, there are two tests in t5616-partial-clone.sh that I believe are
actually broken scenarios. While the client is set up to clone the
'promisor-server' repo via a treeless partial clone filter (tree:0),
that filter does not translate to the 'server' repo. Thus, fetching from
these repos causes the server to think that the client has all reachable
trees and blobs from the commits advertised as 'haves'. This leads the
server to providing a thin pack assuming those objects as delta bases.
Changing the name-hash algorithm presents new delta bases and thus
breaks the expectations of these tests. An alternative could be to set
up 'server' as a promisor server with the correct filter enabled. This
may also point out more issues with partial clone being set up as a
remote-based filtering mechanism and not a repository-wide setting. For
now, do the minimal change to make the test work by disabling the test
variable.

Third, there are some tests that compare the exact output of a 'git
pack-objects' process when using bitmaps. The warning that disables the
--full-name-hash option causes these tests to fail. Disable the
environment variable to get around this issue.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c          |  7 +++++--
 ci/run-build-and-tests.sh       |  1 +
 t/README                        |  4 ++++
 t/t5310-pack-bitmaps.sh         |  3 +++
 t/t5333-pseudo-merge-bitmaps.sh |  4 ++++
 t/t5510-fetch.sh                |  7 ++++++-
 t/t5616-partial-clone.sh        | 26 ++++++++++++++++++++++++--
 t/t6020-bundle-misc.sh          |  6 +++++-
 t/t7406-submodule-update.sh     |  2 ++
 t/t7700-repack.sh               |  6 ++++++
 10 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 85595dfcd88..7cb6f0e0942 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,7 +266,7 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
-static int use_full_name_hash;
+static int use_full_name_hash = -1;
 
 static inline uint32_t pack_name_hash_fn(const char *name)
 {
@@ -4586,7 +4586,10 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
-	if (write_bitmap_index && use_full_name_hash) {
+	if (use_full_name_hash < 0)
+		use_full_name_hash = git_env_bool("GIT_TEST_FULL_NAME_HASH", 0);
+
+	if (write_bitmap_index && use_full_name_hash > 0) {
 		warning(_("currently, the --full-name-hash option is incompatible with --write-bitmap-index"));
 		use_full_name_hash = 0;
 	}
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20f..75b40f07bbd 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -30,6 +30,7 @@ linux-TEST-vars)
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	export GIT_TEST_FULL_NAME_HASH=1
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
diff --git a/t/README b/t/README
index 8c0319b58e5..fe3f89b5b28 100644
--- a/t/README
+++ b/t/README
@@ -492,6 +492,10 @@ a test and then fails then the whole test run will abort. This can help to make
 sure the expected tests are executed and not silently skipped when their
 dependency breaks or is simply not present in a new environment.
 
+GIT_TEST_FULL_NAME_HASH=<boolean>, when true, sets the default name-hash
+function in 'git pack-objects' to be the one used by the --full-name-hash
+option.
+
 Naming Tests
 ------------
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7044c7d7c6d..caa3c125548 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -420,6 +420,9 @@ test_bitmap_cases () {
 			cat >expect <<-\EOF &&
 			error: missing value for '\''pack.preferbitmaptips'\''
 			EOF
+
+			# Disable --full-name-hash test due to stderr comparison.
+			GIT_TEST_FULL_NAME_HASH=0 \
 			git repack -adb 2>actual &&
 			test_cmp expect actual
 		)
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index eca4a1eb8c6..0c7c3e33986 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -209,6 +209,10 @@ test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
 '
 
 test_expect_success 'out of order thresholds are rejected' '
+	# Disable this option to avoid stderr message
+	GIT_TEST_FULL_NAME_HASH=0 &&
+	export GIT_TEST_FULL_NAME_HASH &&
+
 	test_must_fail git \
 		-c bitmapPseudoMerge.test.pattern="refs/*" \
 		-c bitmapPseudoMerge.test.threshold=1.month.ago \
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c5..be79c72495e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1062,7 +1062,12 @@ test_expect_success 'all boundary commits are excluded' '
 	test_tick &&
 	git merge otherside &&
 	ad=$(git log --no-walk --format=%ad HEAD) &&
-	git bundle create twoside-boundary.bdl main --since="$ad" &&
+
+	# If the --full-name-hash function is used here, then no delta
+	# pair is found and the bundle does not expand to three objects
+	# when fixing the thin object.
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git bundle create twoside-boundary.bdl main --since="$ad" &&
 	test_bundle_object_count --thin twoside-boundary.bdl 3
 '
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f7..425aa8d8789 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -516,7 +516,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --full-name-hash option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" withot any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify the assumption that the client needed to fetch the delta base
@@ -535,7 +546,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big blob (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --full-name-hash option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_FULL_NAME_HASH=1, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" withot any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 34b5cd62c20..553a20d10e9 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -247,7 +247,11 @@ test_expect_success 'create bundle with --since option' '
 	EOF
 	test_cmp expect actual &&
 
-	git bundle create since.bdl \
+	# If the --full-name-hash option is used, then one fewer
+	# delta base is found and this counts a different number
+	# of objects after performing --fix-thin.
+	GIT_TEST_FULL_NAME_HASH=0 \
+		git bundle create since.bdl \
 		--since "Thu Apr 7 15:27:00 2005 -0700" \
 		--all &&
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0f0c86f9cb2..03f8c976720 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1094,6 +1094,8 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	) &&
 	git clone super4 super5 &&
 	(cd super5 &&
+	 # This test var can mess with the stderr output checked in this test.
+	 GIT_TEST_FULL_NAME_HASH=0 \
 	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index fc2cc9d37be..e3787bacdad 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -309,6 +309,9 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
+
+	# Disable --full-name-hash test due to stderr comparison.
+	GIT_TEST_FULL_NAME_HASH=0 \
 	git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
@@ -320,6 +323,9 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	blob=$(test-tool genrandom big $((1024*1024)) |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
+
+	# Disable --full-name-hash test due to stderr comparison.
+	GIT_TEST_FULL_NAME_HASH=0 \
 	git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
-- 
gitgitgadget

