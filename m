Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD892226882
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715205; cv=none; b=XsWSuyg0f4qKXcDLhShUKvDmRooVkXZlJ9YntgDpPkN+rEjxrF5JndaD2Fb5Q6QiMOZoSKneENTgbb6ELWXPPb3HE8W1ousbE6cAstpXJt6KrHbctZImPPNeOREJWnyg2LmtyC+vSzKGfjAYtpwwNqgR4XoivwH2Kh3L5+rcB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715205; c=relaxed/simple;
	bh=Flm/exOjW+5n7ZCU9qfus1pG3yky1dqhYGK1TZS6Oiw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JaPTpYwwOlZtkA+xV/mHRFfRJgpOf9nuc7igOfIEY3jjsYbneR9qOPMZNH5GVGE5qqvKpTvRCjOyZQeGCDZYJ1+bUfLbNrBxG2UW4ASnXwMq1HThsxWsr9LXi7OImTZGGG2yR2yShClPnjzg1r0gbok1WMuZWv8MWANK32LXL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVYKMnvq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVYKMnvq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso15196915e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715202; x=1735320002; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWFMcweaC+NaRFw70Q0B+a4Ov7og0WpGEpBCarqcc1w=;
        b=SVYKMnvqwmXkARei+Y0uWEhAlkAsfV+ByZXtCIcNAbbQONvGtdgiqm5XTLum/cenLj
         vAgrYsWy71swFgqW6KrcXyJLOcux5sKWjYMICd2mFKyt8Ae5uG5zfDTlF5j0S30CM2vq
         k2Qewec3BEgS+Poa8b5FZCsUi2ftrppQrQ/plhZBbhBqRCn2vH4FQugx6eIgjmeiR/4B
         VXX9T0ytDGHbXg5bTcQPblG5y0zOeqraMjpfQ1PKQoweXM6XBt1dAdZdSldo35lc88J0
         Iu4jQjvGs1/x+qQZDHHTZ+SAoSuTCuf7f9qYYOmimrkQAEh41YPWnJrfNUR8hjGUi49q
         WbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715202; x=1735320002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWFMcweaC+NaRFw70Q0B+a4Ov7og0WpGEpBCarqcc1w=;
        b=XN3RZ0srzOuNztxMClEWNTj9A9M6T4403pdyJBZThAqX2NqYEExfsmo9/iGXYDaFsM
         61O37fcd19PRQ2gWZmDANxTtsoonRf4c9pS/sxAPD8tnLWFEiTJjXwcSgLXvbocfslvh
         D17h+dMLXG7j9hon+k6LciBTDYE7aYAX5mC+lIP4+pqpYidT1d82QWNAZXqQKM0skuuw
         5UWiWShIIcX6jYNXu3ypICUUZvmILpuEulNF32YyZRz6cVjB3ToEidfl4RfzpS27d5I0
         hSkGLh7WWEYCYGzljTENXlPCTjiI1tzLDLkWfKgTDTDY5MD0+4a7nJQ4S/kT/ziTHDrT
         UEeQ==
X-Gm-Message-State: AOJu0Yx+OHtKn8YopJqrj4krrbL7Rv6ba+wVtwwCRlUEh2s9qO8UKUS0
	PeP8Y/EwYJiZYWPvy7jfT1nCen6VrTV3KApqQXE/MUYBjuljDoqLJv7HUg==
X-Gm-Gg: ASbGncsL1CJjwMoLVOWRIT5aFB7BSsxZNFs2/dIYHXRNNc6Tifx0XXhof/yWxXVjVPx
	cVVZqtRO0PnWQfOSc01qE4DwczvMZk3k6kFRhWFvemxOyny41+JtzdULfT7X2l5Neg+rUHOMKSy
	nQ9Vsi/QUs9gvjEs/t+oArOK+geR9XC3zINZoTVpl4aJl2d3Lz5E3PvPvrJfXXSU22MjVJQYP3Y
	Rz/YWxGMeZzXVTPbINUtRKjKaOgRiw+McIIMkxEQX3RNgD+cwyZEX9TuA==
X-Google-Smtp-Source: AGHT+IEg3JanJnHtyGOCK39YfGtz4g4ZlXYxKrquKTh1xTqsl6GIrgxJLR1JzFsjbWGnMFo6bo/Ixw==
X-Received: by 2002:a05:600c:5354:b0:434:ff9d:a370 with SMTP id 5b1f17b1804b1-4366fcae4aemr20302315e9.0.1734715201410;
        Fri, 20 Dec 2024 09:20:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b441bbsm84159295e9.40.2024.12.20.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:20:00 -0800 (PST)
Message-Id: <86ff0d0a15e4263ccd541a9b8dcdb99438784a70.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:50 +0000
Subject: [PATCH v3 4/8] pack-objects: add GIT_TEST_NAME_HASH_VERSION
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new environment variable to opt-in to different values of the
--name-hash-version=<n> option in 'git pack-objects'. This allows for
extra testing of the feature without repeating all of the test
scenarios. Unlike many GIT_TEST_* variables, we are choosing to not add
this to the linux-TEST-vars CI build as that test run is already
overloaded. The behavior exposed by this test variable is of low risk
and should be sufficient to allow manual testing when an issue arises.

But this option isn't free. There are a few tests that change behavior
with the variable enabled.

First, there are a few tests that are very sensitive to certain delta
bases being picked. These are both involving the generation of thin
bundles and then counting their objects via 'git index-pack --fix-thin'
which pulls the delta base into the new packfile. For these tests,
disable the option as a decent long-term option.

Second, there are some tests that compare the exact output of a 'git
pack-objects' process when using bitmaps. The warning that ignores the
--name-hash-version=2 and forces version 1 causes these tests to fail.
Disable the environment variable to get around this issue.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c          |  5 ++++-
 t/README                        |  4 ++++
 t/t5300-pack-object.sh          |  7 +++++--
 t/t5310-pack-bitmaps.sh         |  5 ++++-
 t/t5333-pseudo-merge-bitmaps.sh |  4 ++++
 t/t5510-fetch.sh                |  7 ++++++-
 t/t6020-bundle-misc.sh          |  6 +++++-
 t/t7406-submodule-update.sh     |  4 +++-
 t/t7700-repack.sh               | 10 ++++++++--
 9 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 90ea19417bc..b19c3665003 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,7 +266,7 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
-static int name_hash_version = 1;
+static int name_hash_version = -1;
 
 static void validate_name_hash_version(void)
 {
@@ -4609,6 +4609,9 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
+	if (name_hash_version < 0)
+		name_hash_version = (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", 1);
+
 	validate_name_hash_version();
 	if (write_bitmap_index && name_hash_version != 1) {
 		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
diff --git a/t/README b/t/README
index 8c0319b58e5..e63d2360852 100644
--- a/t/README
+++ b/t/README
@@ -492,6 +492,10 @@ a test and then fails then the whole test run will abort. This can help to make
 sure the expected tests are executed and not silently skipped when their
 dependency breaks or is simply not present in a new environment.
 
+GIT_TEST_NAME_HASH_VERSION=<int>, when set, causes 'git pack-objects' to
+assume '--name-hash-version=<n>'.
+
+
 Naming Tests
 ------------
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4270eabe8b7..97fe9e561c6 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -675,15 +675,18 @@ do
 done
 
 test_expect_success 'valid and invalid --name-hash-versions' '
+	sane_unset GIT_TEST_NAME_HASH_VERSION &&
+
 	# Valid values are hard to verify other than "do not fail".
 	# Performance tests will be more valuable to validate these versions.
-	for value in 1 2
+	# Negative values are converted to version 1.
+	for value in -1 1 2
 	do
 		git pack-objects base --all --name-hash-version=$value || return 1
 	done &&
 
 	# Invalid values have clear post-conditions.
-	for value in -1 0 3
+	for value in 0 3
 	do
 		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
 		test_grep "invalid --name-hash-version option" err || return 1
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7044c7d7c6d..c30522b57fd 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -420,7 +420,10 @@ test_bitmap_cases () {
 			cat >expect <<-\EOF &&
 			error: missing value for '\''pack.preferbitmaptips'\''
 			EOF
-			git repack -adb 2>actual &&
+
+			# Disable name hash version adjustment due to stderr comparison.
+			GIT_TEST_NAME_HASH_VERSION=1 \
+				git repack -adb 2>actual &&
 			test_cmp expect actual
 		)
 	'
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index eca4a1eb8c6..b1553cbaf7f 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -209,6 +209,10 @@ test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
 '
 
 test_expect_success 'out of order thresholds are rejected' '
+	# Disable this option to avoid stderr message
+	GIT_TEST_NAME_HASH_VERSION=1 &&
+	export GIT_TEST_NAME_HASH_VERSION &&
+
 	test_must_fail git \
 		-c bitmapPseudoMerge.test.pattern="refs/*" \
 		-c bitmapPseudoMerge.test.threshold=1.month.ago \
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c5..1699c3a3bb8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1062,7 +1062,12 @@ test_expect_success 'all boundary commits are excluded' '
 	test_tick &&
 	git merge otherside &&
 	ad=$(git log --no-walk --format=%ad HEAD) &&
-	git bundle create twoside-boundary.bdl main --since="$ad" &&
+
+	# If the a different name hash function is used here, then no delta
+	# pair is found and the bundle does not expand to three objects
+	# when fixing the thin object.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git bundle create twoside-boundary.bdl main --since="$ad" &&
 	test_bundle_object_count --thin twoside-boundary.bdl 3
 '
 
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 34b5cd62c20..a1f18ae71f1 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -247,7 +247,11 @@ test_expect_success 'create bundle with --since option' '
 	EOF
 	test_cmp expect actual &&
 
-	git bundle create since.bdl \
+	# If a different name hash function is used, then one fewer
+	# delta base is found and this counts a different number
+	# of objects after performing --fix-thin.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git bundle create since.bdl \
 		--since "Thu Apr 7 15:27:00 2005 -0700" \
 		--all &&
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0f0c86f9cb2..ebd9941075a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1094,7 +1094,9 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	) &&
 	git clone super4 super5 &&
 	(cd super5 &&
-	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
+	 # This test var can mess with the stderr output checked in this test.
+	 GIT_TEST_NAME_HASH_VERSION=1 \
+		git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err
 	) &&
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index b9a5759e01d..16861f80c9c 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -309,7 +309,10 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
-	git -C bare.git repack -ad 2>stderr &&
+
+	# Disable --name-hash-version test due to stderr comparison.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
@@ -320,7 +323,10 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	blob=$(test-tool genrandom big $((1024*1024)) |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
-	git -C bare.git repack -ad 2>stderr &&
+
+	# Disable --name-hash-version test due to stderr comparison.
+	GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
-- 
gitgitgadget

