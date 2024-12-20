Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694A227B96
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715211; cv=none; b=F5GaMS0N29mvesCBIF1qdgtvRn1nc6XuqKqnkMynH4oIGKNGsrEIz4Rlpc2evBUOZgJJhb1coBqg1KkUdakIDITI1V4QWZ7uDhrN9evEpiDfHMadOE5iz3S8I7G7Cjb4nvHkgjYOoNhlbm3SiLUJTAnmf0SD2Qbvrp5LZk+c2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715211; c=relaxed/simple;
	bh=PD/GmFLcKggC1qbGjlL55ynYlu4KttinED/uMaqLfjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n7qd8fh1sknPyuKLDHBVx5gt5IasJQ3tA1hnpwILZ2HzKY9EyPzDnV95h0W8B9YbmUB7h3GVyq1E3S4FmT5pT6LoSJg46YgcQLEq04BsH/436JDU/tuCuiLf1x6s0t+R366O0ZVPWk5TZLYqsqMSjMMVOs67KT4IhxLh3+ryMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGVRzXl0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGVRzXl0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso16066035e9.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734715207; x=1735320007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0LFr3ooUQraWDVML6JNpyrTNlyccu5JAAjtEKcBwiU=;
        b=fGVRzXl00ygNDKEvF68dDDTxqvJvaQKGZOliT1TsrTUV0KNNjPzOCgOi5/3doK6qDG
         VW/mkpxWRnaMQCDTnUCJD7yspyqbINyFe/2WTABQ544hnjH3Ou8V9Vhp63mRvVzH+724
         LF/RDuag84ngAyN5mVJpEkwj2he8JBvRDr0M4Kw1kNd/x4Ova0thhY6DsKsidI5ORaRS
         3+KSEzuG5anUNIsJUKJDQjcPjNOTvCFCEAySFjsAlVRWjDReXF7R3jKdBH8xoZltpGUQ
         4mwSb792nL8NLiSXiwipFIJksyptUxUZ4BgevxzvD4pv5h/xgViTH2wUKcADYK+yYiCP
         QwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715207; x=1735320007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0LFr3ooUQraWDVML6JNpyrTNlyccu5JAAjtEKcBwiU=;
        b=v0B/5l8pvyhhe7b6RiAMn5tT6oKn2fjeE0XW3xwbPH5cLlsGbNuPr7MfYyJrM29Fk6
         IbCuqRQbqu/mrnKr24cwFP8J2FD5KHbI1S7YP2L3y8NO2CzNo3hPgBNTYx+f8KUC7ovf
         8TLvJNq8GDxFdkUIhRz2DPl2P+veqR7rUmezeaTxVR8gvxr0AnI053L5hoelhdGQQDnr
         ekJoZ/4tOYjzetoqtrdaQcDtzd4zpgsIFTydUzu/3mhUpNZN2qIHylopMvpOYZEXRdGv
         zj4yx4TGsEgEyfC8OwU7BWcVkmSCXJe3zVB1CGJktnAzmIzjGSx8JP+lSZJOSVptf54t
         MZSg==
X-Gm-Message-State: AOJu0YwoWBwn7bSD2s6FwBA9ILiScVBz5yrge29QnHl64/1df0f24wbs
	nZIbk972T/9+PaG+EIlHc1cFgBz5KFVRXFE9SubRSwPqSvGvbQq/vB2GlQ==
X-Gm-Gg: ASbGncuGcZWwxxNG3i2VuM+rgmT52bJ890UupcbHw4/wocQBEvVp2vadnmuZ6rWUx95
	bSFikwUFf+Eu93IEGoRQWYtThKaNGxKjOB4Mhqz9r6o+TWDOFbqS0vvFz1BsgSD2nruOaEIOHCn
	ARI3uoxjAJYRZpkzgDd714101CWBpNk4+M52cVou9ZfrUcoYtuFEEsS4cQODdDxDdVxPJmJVfO1
	yyDY4c2SsxEFlnXu2euypAgAH7yLqv2PIUyG2NdvFCtfzXc3erQ5L+9kw==
X-Google-Smtp-Source: AGHT+IHCBTxNkpo9upX2Hnf6sZfHV6QGQVBjQuBBYQOA4kd+eY1DM7EW0De0I3VNHDQGx3QzkZHuQQ==
X-Received: by 2002:a05:6000:2cf:b0:385:ec9b:e442 with SMTP id ffacd0b85a97d-38a223fd5a2mr3777085f8f.40.1734715207255;
        Fri, 20 Dec 2024 09:20:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm4600516f8f.45.2024.12.20.09.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:20:06 -0800 (PST)
Message-Id: <3d63954f318e5133630b1f579a399a123e434cf8.1734715194.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
References: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 17:19:54 +0000
Subject: [PATCH v3 8/8] pack-objects: add third name hash version
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

The '--name-hash-version=<n>' option in 'git pack-objects' was
introduced to allow for specifying an alternative name hash function
when organizing objects for delta compression. The pack_name_hash_v2()
function was designed to break some collisions while also preserving
some amount of locality for cross-path deltas.

However, in some repositories, that effort to preserve locality results
in enough collisions that it causes issues with full repacks.

Create a third name hash function and extend the '--name-hash-version'
option in 'git pack-objects' and 'git repack' to understand it. This
hash version abandons all efforts for locality and focuses on creating a
somewhat uniformly-distributed hash function to minimize collisions.

We can observe the effect of this collision avoidance in a large
internal monorepo that suffered from collisions in the previous
versions. The updates to p5314-name-hash.sh show these results:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                       227.3K
5314.2: distinct hash value: v1              72.3K
5314.3: maximum multiplicity: v1             14.4K
5314.4: distinct hash value: v2             166.5K
5314.5: maximum multiplicity: v2               138
5314.6: distinct hash value: v3             227.3K
5314.7: maximum multiplicity: v3                 2

These results demonstrate that of the 227,000+ paths, nearly all of them
find distinct hash values. The maximum multiplicity is 2, improved from
138 in the v2 hash function. The v2 hash function also had only 166K
distinct values, so it had a wide spread of collisions.

A more modest improvement is available in the open source fluentui repo
[1] with these results:

Test                               this tree
--------------------------------------------------
5314.1: paths at head                        19.5K
5314.2: distinct hash value: v1               8.2K
5314.3: maximum multiplicity: v1               279
5314.4: distinct hash value: v2              17.8K
5314.5: maximum multiplicity: v2                44
5314.6: distinct hash value: v3              19.5K
5314.7: maximum multiplicity: v3                 1

[1] https://github.com/microsoft/fluentui

However, it is important to demonstrate the effectiveness of this
function in the context of compressing a repository. We can use
p5313-pack-objects.sh to measure these changes. I will use a simplified
table summarizing the output of that performance test.

 | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
 |-----------|---------|---------|---------|---------|---------|---------|
 | Thin Pack |  0.37 s |  0.12 s |  0.07 s |   1.2 M |  22.0 K |  20.4 K |
 | Big Pack  |  2.04 s |  2.80 s |  1.40 s |  20.4 M |  25.9 M |  19.2 M |
 | Shallow   |  1.41 s |  1.77 s |  1.27 s |  34.4 M |  33.7 M |  34.8 M |
 | Repack    | 95.70 s | 33.68 s | 20.88 s | 439.3 M | 160.5 M | 169.1 M |

Here, there are some performance improvements on a time basis, and the
thin and big packs are somewhat smaller in v3. The shallow and repacked
packs are somewhat bigger, though, compared to v2.

Two repositories that have very few collisions in the v1 name hash are
the Git and Linux repositories. Here are their stats for p5313:

Git:

 | Test      | V1 Time | V2 Time | V3 Time | V1 Size | V2 Size | V3 Size |
 |-----------|---------|---------|---------|---------|---------|---------|
 | Thin Pack |  0.02 s |  0.02 s |  0.02 s |   1.1 K |   1.1 K |  15.3 K |
 | Big Pack  |  1.69 s |  1.95 s |  1.67 s |  13.5 M |  14.5 M |  14.9 M |
 | Shallow   |  1.26 s |  1.29 s |  1.16 s |  12.0 M |  12.2 M |  12.5 M |
 | Repack    | 29.51 s | 29.01 s | 29.08 s | 237.7 M | 238.2 M | 237.7 M |

Linux:

 | Test      | V1 Time  | V2 Time  | V3 Time  | V1 Size | V2 Size | V3 Size |
 |-----------|----------|----------|----------|---------|---------|---------|
 | Thin Pack |   0.17 s |   0.07 s |   0.07 s |   4.6 K |   4.6 K |   6.8 K |
 | Big Pack  |  17.88 s |  12.35 s |  12.14 s | 201.1 M | 149.1 M | 160.4 M |
 | Shallow   |  11.05 s |  22.94 s |  22.16 s | 269.2 M | 273.8 M | 271.8 M |
 | Repack    | 727.39 s | 566.95 s | 539.33 s |   2.5 G |   2.5 G |   2.6 G |

These repositories make good use of the cross-path deltas that come
about from the v1 name hash function, so they already had mixed results
with the v2 function. The v3 function is generally worse for these
repositories.

An internal Javascript-based repository with name hash collisions
similar to the fluentui repo has these results:

 | Test      | V1 Time   | V2 Time  | V3 Time  | V1 Size | V2 Size | V3 Size |
 |-----------|-----------|----------|----------|---------|---------|---------|
 | Thin Pack |    8.28 s |   7.28 s |   0.04 s |  16.8 K |  16.8 K |   3.2 K |
 | Big Pack  |   12.81 s |  11.66 s |   2.52 s |  29.1 M |  29.1 M |  30.6 M |
 | Shallow   |    4.86 s |   4.06 s |   3.77 s |  42.5 M |  44.1 M |  45.7 M |
 | Repack    | 3126.50 s | 496.33 s | 306.86 s |   6.2 G | 855.6 M | 838.2 M |

This repository is also listed as "Repo B" in the repacking size table
below, along with other Javascript repos that have many name hash
collisions with the v1 name hash:

 | Repo     | V1 Size   | V2 Size | V3 Size |
 |----------|-----------|---------|---------|
 | fluentui |     440 M |   161 M |   170 M |
 | Repo B   |   6,248 M |   856 M |   840 M |
 | Repo C   |  37,278 M | 6,921 M | 6,755 M |
 | Repo D   | 131,204 M | 7,463 M | 7,124 M |

While the fluentui repo had an increase in size using the v3 name hash,
the others had modest improvements over the v2 name hash. But those
modest improvements are dwarfed by the difference from v1 to v2, so it
is unlikely that the regression seen in the other scenarios (packfiles
that are not from full repacks) will be worth using v3 over v2. That is,
unless there are enough collisions even with v2 that the full repack
scenario has larger improvements than these.

When using GIT_TEST_NAME_HASH_VERSION=3, there are some necessary
changes to t5616-partial-clone.sh since the server now picks different
delta bases that the client does not have (and does not then fetch
dynamically). These changes are a minimal patch and the functionality
should be fixed in other changes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt |  9 +++++++++
 builtin/pack-objects.c             |  5 ++++-
 pack-objects.h                     | 26 ++++++++++++++++++++++++++
 t/helper/test-name-hash.c          |  1 +
 t/perf/p5313-pack-objects.sh       |  2 +-
 t/perf/p5314-name-hash.sh          |  2 +-
 t/t5300-pack-object.sh             |  4 ++--
 t/t5310-pack-bitmaps.sh            | 14 +++++++-------
 t/t5616-partial-clone.sh           | 26 ++++++++++++++++++++++++--
 9 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 7f69ae4855f..9fe25c53415 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -374,6 +374,15 @@ breaking most of the collisions from a similarly-named file appearing in
 many different directories. At the moment, this version is not allowed
 when writing reachability bitmap files with `--write-bitmap-index` and it
 will be automatically changed to version `1`.
++
+The name hash version `3` abandons the locality features of versions `1`
+and `2` in favor of minimizing collisions. The goal here is to separate
+objects by their full path and abandon hope for cross-path delta
+compression. For this reason, this option is preferred for repacking large
+repositories with many versions and many name hash collisions when using
+the first two versions. At the moment, this version is not allowed when
+writing reachability bitmap files with `--write-bitmap-index` and it will
+be automatically changed to version `1`.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4d10baf7ac9..8297af1a272 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -270,7 +270,7 @@ static int name_hash_version = -1;
 
 static void validate_name_hash_version(void)
 {
-	if (name_hash_version < 1 || name_hash_version > 2)
+	if (name_hash_version < 1 || name_hash_version > 3)
 		die(_("invalid --name-hash-version option: %d"), name_hash_version);
 }
 
@@ -292,6 +292,9 @@ static inline uint32_t pack_name_hash_fn(const char *name)
 	case 2:
 		return pack_name_hash_v2((const unsigned char *)name);
 
+	case 3:
+		return pack_name_hash_v3(name);
+
 	default:
 		BUG("invalid name-hash version: %d", name_hash_version);
 	}
diff --git a/pack-objects.h b/pack-objects.h
index 681c1116486..2b20a56fc99 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -235,6 +235,32 @@ static inline uint32_t pack_name_hash_v2(const unsigned char *name)
 	return (base >> 6) ^ hash;
 }
 
+static inline uint32_t pack_name_hash_v3(const char *name)
+{
+	/*
+	 * This 'bigp' value is a large prime, at least 25% of the max
+	 * value of an uint32_t. Multiplying by this value (modulo 2^32)
+	 * causes the 32 bits to change pseudo-randomly.
+	 */
+	const uint32_t bigp = 1234572167U;
+	uint32_t c, hash = bigp;
+
+	if (!name)
+		return 0;
+
+	/*
+	 * Do the simplest thing that will resemble pseudo-randomness: add
+	 * random multiples of a large prime number with a binary shift.
+	 * The goal is not to be cryptographic, but to be generally
+	 * uniformly distributed.
+	 */
+	while ((c = *name++) != 0) {
+		hash += c * bigp;
+		hash = (hash >> 5) | (hash << 27);
+	}
+	return hash;
+}
+
 static inline enum object_type oe_type(const struct object_entry *e)
 {
 	return e->type_valid ? e->type_ : OBJ_BAD;
diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
index af1d52de101..cc5acd58a65 100644
--- a/t/helper/test-name-hash.c
+++ b/t/helper/test-name-hash.c
@@ -15,6 +15,7 @@ int cmd__name_hash(int argc UNUSED, const char **argv UNUSED)
 	while (!strbuf_getline(&line, stdin)) {
 		printf("%10u ", pack_name_hash(line.buf));
 		printf("%10u ", pack_name_hash_v2((unsigned const char *)line.buf));
+		printf("%10u ", pack_name_hash_v3(line.buf));
 		printf("%s\n", line.buf);
 	}
 
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index be5229a0ecd..493872e656d 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -25,7 +25,7 @@ test_expect_success 'create rev input' '
 	EOF
 '
 
-for version in 1 2
+for version in 1 2 3
 do
 	export version
 
diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
index 4ef0ba77114..e58a218d1ae 100755
--- a/t/perf/p5314-name-hash.sh
+++ b/t/perf/p5314-name-hash.sh
@@ -14,7 +14,7 @@ test_size 'paths at head' '
 	test-tool name-hash <path-list >name-hashes
 '
 
-for version in 1 2
+for version in 1 2 3
 do
 	test_size "distinct hash value: v$version" '
 		awk "{ print \$$version; }" <name-hashes | sort | \
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 97fe9e561c6..279a9deca9f 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -680,13 +680,13 @@ test_expect_success 'valid and invalid --name-hash-versions' '
 	# Valid values are hard to verify other than "do not fail".
 	# Performance tests will be more valuable to validate these versions.
 	# Negative values are converted to version 1.
-	for value in -1 1 2
+	for value in -1 1 2 3
 	do
 		git pack-objects base --all --name-hash-version=$value || return 1
 	done &&
 
 	# Invalid values have clear post-conditions.
-	for value in 0 3
+	for value in 0 4
 	do
 		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
 		test_grep "invalid --name-hash-version option" err || return 1
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 871ce01401a..2bf75e2a5d0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -45,13 +45,13 @@ test_expect_success 'name-hash value stability' '
 	test-tool name-hash <names >out &&
 
 	cat >expect <<-\EOF &&
-	2582249472 1763573760 first
-	2289942528 1188134912 second
-	2300837888 1130758144 third
-	2544516325 3963087891 a/one-long-enough-for-collisions
-	2544516325 4013419539 b/two-long-enough-for-collisions
-	1420111091 1709547268 many/parts/to/this/path/enough/to/collide/in/v2
-	1420111091 1709547268 enough/parts/to/this/path/enough/to/collide/in/v2
+	2582249472 1763573760 3109209818 first
+	2289942528 1188134912 3781118409 second
+	2300837888 1130758144 3028707182 third
+	2544516325 3963087891 3586976147 a/one-long-enough-for-collisions
+	2544516325 4013419539 1701624798 b/two-long-enough-for-collisions
+	1420111091 1709547268 2676129939 many/parts/to/this/path/enough/to/collide/in/v2
+	1420111091 1709547268 2740459187 enough/parts/to/this/path/enough/to/collide/in/v2
 	EOF
 
 	test_cmp expect out
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f7..4e7863af9e0 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -516,7 +516,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big tree (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --name-hash-version option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=3, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" without any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+		GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify the assumption that the client needed to fetch the delta base
@@ -535,7 +546,18 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	# Exercise to make sure it works. Git will not fetch anything from the
 	# promisor remote other than for the big blob (because it needs to
 	# resolve the delta).
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
+	#
+	# TODO: the --name-hash-verion option is disabled here, since this test
+	# is fundamentally broken! When GIT_TEST_NAME_HASH_VERSION=3, the server
+	# recognizes delta bases in a different way and then sends a _blob_ to
+	# the client with a delta base that the client does not have! This is
+	# because the client is cloned from "promisor-server" with tree:0 but
+	# is now fetching from "server" without any filter. This is violating the
+	# promise to the server that all reachable objects exist and could be
+	# used as delta bases!
+	GIT_TRACE_PACKET="$(pwd)/trace" \
+		GIT_TEST_NAME_HASH_VERSION=1 \
+		git -C client \
 		fetch "file://$(pwd)/server" main &&
 
 	# Verify that protocol version 2 was used.
-- 
gitgitgadget
