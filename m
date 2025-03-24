Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F249261579
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829782; cv=none; b=gWzmP4mYaelV5br9ZQxKYegC9ZZMdeZU2XI+Q7Dhn3ovawlSL/Qb/LvwExO5aAa2dDvGmCkbeLM49X5O+HY7x9ZY2+ftxBzONa4PESilVy9sCJWwfcEn2pH3rG+zS1mpIHJvsvPf+0AY+riwfzvLzxFVRENhdWjj71KJyArx3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829782; c=relaxed/simple;
	bh=Ozk8IgfyJ3mcAMG+bQI5fsfUHfSlUppBKuNxEYcjTMg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jUWD+Zel+XpJt0zN+rCMBx9dwHB5i55428SZAtN2/Bt1SyV9N4hoglaXv5fTssFAue0hj1MdJS7+g+23mZ0XdBx4J9DqoNjBC4cPgDhNa2BDvA/4S23YNles2HQ98pvRwr+0tApiTx8tz3ywOToM/+0QFzkMFbX5kKuMQKY2mUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5g1+MUm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5g1+MUm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso34121205e9.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829778; x=1743434578; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+R5Z7dwj3AKQVsEvyHHmOXdY2/pssak2gAENUwGf0k=;
        b=F5g1+MUmOdUmF4G2MNI4gmN0iWMohWre+CJbniRvKFKnWDXfBS4glFAbppxQNdAp1Y
         MifMXki2c61dnG4IN4ANXjrBPwnaiA97UqSxAkNjLWloz8E+B9Uu4kZNwQo6f7CJlnKd
         t+t7szx+PqxEOgef9jgpEXqy7nd5mvKi5Ijqxv/6PkPVIZOVJ2FmZ+unrb3CnpcgiKmc
         Gc6fzPXQNiV/N5xvvEyvubvq9rZzidqI1+dfIb58XkH3rjfaECfu6M0GC3/GtQB7U9Cf
         WjR/lHwSd+CFYutuKfLzgytFPSBIb9Z/OItoWOcPgubGPLtSVcWHhEFLYVJq9E7lXinl
         SHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829778; x=1743434578;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+R5Z7dwj3AKQVsEvyHHmOXdY2/pssak2gAENUwGf0k=;
        b=NpiZAbVt1j4S31Q1kCW4eRV7E624GsuaR3yTdU/wf7ppR/5W39PUCBMf8ty4eb5ZOd
         X3HNJhllsnLfnPl2laqSPjY9ka4zM2zBeslmsKrhzGtMMg6mioweX+11UyNwv0J+tOIT
         fE7sJmgYGv++967utpsTFhW4npliPyK6ByDUmXqfgDUoZDCt7WV4eHBt4EXqZEeco6rC
         DlPiiiR5aaZmY25DtnlXMw4NxonuqawtUVyBI7cjQajnRHXHL1zDjxsib4mHAiCUoZCQ
         E8JOuTyimKM43vP3k4dW51EoTrTe3FAPWPhvyooQPlC4kklVhx2BMvfOHe+sQNbOQ/7F
         pD0g==
X-Gm-Message-State: AOJu0YzoKEADAf4ghr2skQ2c/vkG3u3gqpA+wIxyRDbD8homRI6jK5UM
	h7h2a9qJ1mtPLY8/Ttt7Vu5lLE0R35J7rkaXHUx5gMBXI66fcKON+ZI6hA==
X-Gm-Gg: ASbGncvU6e/kXfzy0wHAlVA/oj8ZIQWkuOsAJpR1AdT2I6OJ6Sl7wodwnHVebI65SGi
	rbWNSAlk7R+sKUHvqbtkI3dQUBcnLohFRnWiOobnTcs2s9HhJy0pyR9Ii2Gh7JDZQg9m/SKyXhz
	fkx5/NGOuUzrLobZolZnfZrXqr/pDX82dl8puFmh/klsakha30/uR63WF0AFmViTCDfHWNpEetD
	3h2YvHSMy3ZSXEYoZ+XzjfiaTxTqmqRawfbClaMcNTg4TjA5YwFFNuwTWCksL+zp5xTkzJ6cXpp
	CXD8FCOLQZQl1+myBQu+McplLUoNgw4rIiZFi/xkDjfWTg==
X-Google-Smtp-Source: AGHT+IEK1th9Fct5ZoKISJ2TbFqfIeMC1dq2agpjpw0dTLxJIjjet141JzcmtY7/BvCHJHXcd7YMyg==
X-Received: by 2002:a05:600c:8411:b0:43c:e9d0:9ee5 with SMTP id 5b1f17b1804b1-43d68a4df4emr27624595e9.18.1742829776968;
        Mon, 24 Mar 2025 08:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f55750sm178041215e9.21.2025.03.24.08.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:56 -0700 (PDT)
Message-Id: <0d49bb3d30add66676280ec7fabed12351d5b3ac.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:41 +0000
Subject: [PATCH v2 05/13] pack-objects: introduce GIT_TEST_PACK_PATH_WALK
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There are many tests that validate whether 'git pack-objects' works as
expected. Instead of duplicating these tests, add a new test environment
variable, GIT_TEST_PACK_PATH_WALK, that implies --path-walk by default
when specified.

This was useful in testing the implementation of the --path-walk
implementation, especially in conjunction with test such as:

 - t0411-clone-from-partial.sh : One test fetches from a repo that does
   not have the boundary objects. This causes the path-based walk to
   fail. Disable the variable for this test.

 - t5306-pack-nobase.sh : Similar to t0411, one test fetches from a repo
   without a boundary object.

 - t5310-pack-bitmaps.sh : One test compares the case when packing with
   bitmaps to the case when packing without them. Since we disable the
   test variable when writing bitmaps, this causes a difference in the
   object list (the --path-walk option adds an extra object). Specify
   --no-path-walk in both processes for the comparison. Another test
   checks for a specific delta base, but when computing dynamically
   without using bitmaps, the base object it too small to be considered
   in the delta calculations so no base is used.

 - t5316-pack-delta-depth.sh : This script cares about certain delta
   choices and their chain lengths. The --path-walk option changes how
   these chains are selected, and thus changes the results of this test.

 - t5322-pack-objects-sparse.sh : This demonstrates the effectiveness of
   the --sparse option and how it combines with --path-walk.

 - t5332-multi-pack-reuse.sh : This test verifies that the preferred
   pack is used for delta reuse when possible. The --path-walk option is
   not currently aware of the preferred pack at all, so finds a
   different delta base.

 - t7406-submodule-update.sh : When using the variable, the --depth
   option collides with the --path-walk feature, resulting in a warning
   message. Disable the variable so this warning does not appear.

I want to call out one specific test change that is only temporary:

 - t5530-upload-pack-error.sh : One test cares specifically about an
   "unable to read" error message. Since the current implementation
   performs delta calculations within the path-walk API callback, a
   different "unable to get size" error message appears. When this
   is changed in a future refactoring, this test change can be reverted.

Similar to GIT_TEST_NAME_HASH_VERSION, we do not add this option to the
linux-TEST-vars CI build as that's already an overloaded build.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c        | 12 ++++++++++--
 t/README                      |  4 ++++
 t/t0411-clone-from-partial.sh |  6 ++++++
 t/t5306-pack-nobase.sh        |  5 +++++
 t/t5310-pack-bitmaps.sh       | 13 +++++++++++--
 t/t5316-pack-delta-depth.sh   |  9 ++++++---
 t/t5332-multi-pack-reuse.sh   |  7 +++++++
 t/t5530-upload-pack-error.sh  |  6 ++++++
 t/t7406-submodule-update.sh   |  3 +++
 9 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 75a6545cca1..a6b8a78d42a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -226,7 +226,7 @@ static int delta_search_threads;
 static int pack_to_stdout;
 static int sparse;
 static int thin;
-static int path_walk;
+static int path_walk = -1;
 static int num_preferred_base;
 static struct progress *progress_state;
 
@@ -4230,7 +4230,7 @@ static int add_objects_by_path(const char *path,
 		struct object_id *oid = &oids->oid[i];
 
 		/* Skip objects that do not exist locally. */
-		if (exclude_promisor_objects &&
+		if ((exclude_promisor_objects || arg_missing_action != MA_ERROR) &&
 		    oid_object_info_extended(the_repository, oid, &oi,
 					     OBJECT_INFO_FOR_PREFETCH) < 0)
 			continue;
@@ -4648,6 +4648,14 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (path_walk < 0) {
+		if (use_bitmap_index > 0 ||
+		    !use_internal_rev_list)
+			path_walk = 0;
+		else
+			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
+	}
+
 	if (depth < 0)
 		depth = 0;
 	if (depth >= (1 << OE_DEPTH_BITS)) {
diff --git a/t/README b/t/README
index 53e5b4a7107..ae06e628815 100644
--- a/t/README
+++ b/t/README
@@ -415,6 +415,10 @@ GIT_TEST_PACK_SPARSE=<boolean> if disabled will default the pack-objects
 builtin to use the non-sparse object walk. This can still be overridden by
 the --sparse command-line argument.
 
+GIT_TEST_PACK_PATH_WALK=<boolean> if enabled will default the pack-objects
+builtin to use the path-walk API for the object walk. This can still be
+overridden by the --no-path-walk command-line argument.
+
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index 196fc617843..9e6bca56255 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -59,6 +59,12 @@ test_expect_success 'pack-objects should fetch from promisor remote and execute
 
 test_expect_success 'clone from promisor remote does not lazy-fetch by default' '
 	rm -f script-executed &&
+
+	# The --path-walk feature of "git pack-objects" is not
+	# compatible with this kind of fetch from an incomplete repo.
+	GIT_TEST_PACK_PATH_WALK=0 &&
+	export GIT_TEST_PACK_PATH_WALK &&
+
 	test_must_fail git clone evil no-lazy 2>err &&
 	test_grep "lazy fetching disabled" err &&
 	test_path_is_missing script-executed
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index 805d60ff317..609399d54fb 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -59,6 +59,11 @@ test_expect_success 'indirectly clone patch_clone' '
 	 git pull ../.git &&
 	 test $(git rev-parse HEAD) = $B &&
 
+	# The --path-walk feature of "git pack-objects" is not
+	# compatible with this kind of fetch from an incomplete repo.
+	GIT_TEST_PACK_PATH_WALK=0 &&
+	export GIT_TEST_PACK_PATH_WALK &&
+
 	 git pull ../patch_clone/.git &&
 	 test $(git rev-parse HEAD) = $C
 	)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 621bbbdd26e..e01df807a62 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -158,8 +158,9 @@ test_bitmap_cases () {
 		ls .git/objects/pack/ | grep bitmap >output &&
 		test_line_count = 1 output &&
 		# verify equivalent packs are generated with/without using bitmap index
-		packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
-		packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+		# Be careful to not use the path-walk option in either case.
+		packasha1=$(git pack-objects --no-use-bitmap-index --no-path-walk --all packa </dev/null) &&
+		packbsha1=$(git pack-objects --use-bitmap-index --no-path-walk --all packb </dev/null) &&
 		list_packed_objects packa-$packasha1.idx >packa.objects &&
 		list_packed_objects packb-$packbsha1.idx >packb.objects &&
 		test_cmp packa.objects packb.objects
@@ -388,6 +389,14 @@ test_bitmap_cases () {
 		git init --bare client.git &&
 		(
 			cd client.git &&
+
+			# This test relies on reusing a delta, but if the
+			# path-walk machinery is engaged, the base object
+			# is considered too small to use during the
+			# dynamic computation, so is not used.
+			GIT_TEST_PACK_PATH_WALK=0 &&
+			export GIT_TEST_PACK_PATH_WALK &&
+
 			git config transfer.unpackLimit 1 &&
 			git fetch .. delta-reuse-old:delta-reuse-old &&
 			git fetch .. delta-reuse-new:delta-reuse-new &&
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 32cf4227451..167c3a35234 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -89,15 +89,18 @@ max_chain() {
 # adjusted (or scrapped if the heuristics have become too unreliable)
 test_expect_success 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
-	# not computing a new long chain.
-	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
+	# not computing a new long chain. (Also avoid the --path-walk
+	# option as it may break delta chains.)
+	pack=$(git pack-objects --all --window=0 --no-path-walk </dev/null pack) &&
 	echo 9 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '--depth limits depth' '
-	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
+	# Avoid --path-walk to avoid breaking delta chains across path
+	# boundaries.
+	pack=$(git pack-objects --all --depth=5 --no-path-walk </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 57cad7708f8..395d09444ce 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -7,6 +7,13 @@ test_description='pack-objects multi-pack reuse'
 
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
+
+# The --path-walk option does not consider the preferred pack
+# at all for reusing deltas, so this variable changes the
+# behavior of this test, if enabled.
+GIT_TEST_PACK_PATH_WALK=0
+export GIT_TEST_PACK_PATH_WALK
+
 objdir=.git/objects
 packdir=$objdir/pack
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 558eedf25a4..8eb6fea839a 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -34,6 +34,12 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
 	hexsz=$(test_oid hexsz) &&
 	printf "%04xwant %s\n00000009done\n0000" \
 		$(($hexsz + 10)) $head >input &&
+
+	# The current implementation of path-walk causes a different
+	# error message. This will be changed by a future refactoring.
+	GIT_TEST_PACK_PATH_WALK=0 &&
+	export GIT_TEST_PACK_PATH_WALK &&
+
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	test_grep "unable to read" output.err &&
 	test_grep "pack-objects died" output.err
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index c562bad042a..ab76d4b6dc4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1095,12 +1095,15 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	(cd super5 &&
 	 # This test var can mess with the stderr output checked in this test.
 	 GIT_TEST_NAME_HASH_VERSION=1 \
+	 GIT_TEST_PACK_PATH_WALK=0 \
 		git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err
 	) &&
 	git clone super4 super6 &&
 	(cd super6 &&
+	 # This test variable will create a "warning" message to stderr
+	 GIT_TEST_PACK_PATH_WALK=0 \
 	 git submodule update --init --depth=1 submodule3 >out 2>err &&
 	 test_file_not_empty out &&
 	 test_file_not_empty err
-- 
gitgitgadget

