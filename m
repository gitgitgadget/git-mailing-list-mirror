Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD7191F75
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004565; cv=none; b=lvmqvzixA3TemEr5QdiATJd0ACCib8VBBdLL8dwFrL+9xkAqztOrwIN4mnmziRa3BMTWILRTl5qC4ICyW40P6bfomLzkUS5JRg4FusqbLCy7k5oWtxT/0u052meS97Ff7HYJlaVAhnhW1trf9swH4Zl1lNr0+NjtDKeXKDS/0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004565; c=relaxed/simple;
	bh=VtOdlvqqF9l8YmxreVq58WPte6MgMGN6jaiW6SR/aVs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pTWCl1cUFaS63GamLfonHUechS6Vx9tNGkAoe7hLFpfng94RhWigstiWBePGWbPh75rTnQOxxSQSP+lDt8tMWPR7q45PStb20dlXa33um6qkgKcG8kMHQq3LCy2dyOjIxR3FL7Ps9nnqJQD+Ji7e2M9jUh0E3mYgqdQdrBMxwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyforpPZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyforpPZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43635796b48so30980805e9.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 11:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004560; x=1738609360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JftDG29tZaDaYyUdfTo570aq5S7mDB8kQuEqkFJx6s=;
        b=kyforpPZhPaoKIPJY2mboDuOpxIUY3mP5xuSkY181U0rG/RXuHSH36faYrbHlOtU3t
         LwGWQE7BjRTcutKAgyCtvI4g0w7T0DuFL3u6RbA3lpw4cwHz76UPB3jluHC2D8tnZvoO
         G+pL5VETmsyto0b6RMCRkYgZ16oDB3fc7YyZxFIqT74cGgdwzYFGPUJNvRyTydVMq5q1
         nhldYUz0rrD0KpDW/JflRoxSD0IWrFGCJRFPl716ad49ZVViiEvaCU3c20k0cM3k3Szu
         JurCe48ZTNHhhFTx5hKInBWk86GPcKfEqB0wx+wiGUvumHyCGqj/wOxXWH03GBcP2lYL
         HpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004560; x=1738609360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JftDG29tZaDaYyUdfTo570aq5S7mDB8kQuEqkFJx6s=;
        b=mPf91Lw+3Zbko4dhKqk0Hn6TIugoVpGqHcY/KqR51rDNFKLsNcWB5pv5mc8i53cpvR
         a2Z1JkzLdtvTCjSggFChD8tDtmTEupPMIZ/KyOsFd9MgiTWs0Ogpu5xFK48x7AAvXeVR
         y5Cmy8EWTbQmlVvs8Ny1bxEMYpEl66Qkfze/Hna/6wwkM3QJiE8Z6pIlKEahaYkw/UjF
         v01TqGwASa5URr0bk3u/7bAW6h+RtJkWcopKgwJH2bDK/e1mmM0z/PUOtyWyMCkJyNGh
         GS0C3VT9RvTFx6ZE8HembunVgd+lOxoZf3aaSxh5LE2mXsxdlYH4sykoapa/l3JrY3lh
         utxg==
X-Gm-Message-State: AOJu0Ywo4Cu4xmhCt1txqbsELNh0mN/3gqXKdqfc1218d0DX8O8a+J82
	IAcCaIj+yGaEB43O61dlxyZQz0GLvBYLckmdBvWcYyo+v+y5Wt3711oF7Q==
X-Gm-Gg: ASbGncui1+IZ/mrCJCjHEfopiupUsMj4EjVG0m+FOzmSp8AlYxZo+lNdYWldATWpCyU
	bpIgTLBont5VLtzD+J+JKPT2igVPS4bp1hM9zsdUlhXjHxnPHBSON+WcPqmTVtWQO7pepnHip9J
	6mruEsruBeQeEepbyhxam8y96lIftwgKr/rLQP4g66mD9q+sHQGujwupOd7UIIODhGoYLsdgkQD
	8UsTU4AEYXiaAEW5zjSAsTVOBAs7g5LxV8gPYKbhnyTChWLQSQWcIdg1yJaYt6c1Bv5JMvXkQlb
	giRqrNokFawo5T1T
X-Google-Smtp-Source: AGHT+IGaKruSQ5hFUe7wQHblEXdJL3IJxtt6t4P1PxjLGROLVmQE29KLx/oSqigCW9tJ60Pvit12MQ==
X-Received: by 2002:a05:600c:1d95:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-438d596dc8bmr4108915e9.8.1738004559636;
        Mon, 27 Jan 2025 11:02:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa599sm148100595e9.7.2025.01.27.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:02:39 -0800 (PST)
Message-Id: <7ee1845144fda5b8192dfa13eaab3cbd669b39ed.1738004555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
	<pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 19:02:29 +0000
Subject: [PATCH v4 2/7] pack-objects: add --name-hash-version option
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

The previous change introduced a new pack_name_hash_v2() function that
intends to satisfy much of the hash locality features of the existing
pack_name_hash() function while also distinguishing paths with similar
final components of their paths.

This change adds a new --name-hash-version option for 'git pack-objects'
to allow users to select their preferred function version. This use of
an integer version allows for future expansion and a direct way to later
store a name hash version in the .bitmap format.

For now, let's consider how effective this mechanism is when repacking a
repository with different name hash versions. Specifically, we will
execute 'git pack-objects' the same way a 'git repack -adf' process
would, except we include --name-hash-version=<n> for testing.

On the Git repository, we do not expect much difference. All path names
are short. This is backed by our results:

| Stage                 | Pack Size | Repack Time |
|-----------------------|-----------|-------------|
| After clone           | 260 MB    | N/A         |
| --name-hash-version=1 | 127 MB    | 129s        |
| --name-hash-version=2 | 127 MB    | 112s        |

This example demonstrates how there is some natural overhead coming from
the cloned copy because the server is hosting many forks and has not
optimized for exactly this set of reachable objects. But the full repack
has similar characteristics for both versions.

Let's consider some repositories that are hitting too many collisions
with version 1. First, let's explore the kinds of paths that are
commonly causing these collisions:

 * "/CHANGELOG.json" is 15 characters, and is created by the beachball
   [1] tool. Only the final character of the parent directory can
   differentiate different versions of this file, but also only the two
   most-significant digits. If that character is a letter, then this is
   always a collision. Similar issues occur with the similar
   "/CHANGELOG.md" path, though there is more opportunity for
   differences In the parent directory.

 * Localization files frequently have common filenames but
   differentiates via parent directories. In C#, the name
   "/strings.resx.lcl" is used for these localization files and they
   will all collide in name-hash.

[1] https://github.com/microsoft/beachball

I've come across many other examples where some internal tool uses a
common name across multiple directories and is causing Git to repack
poorly due to name-hash collisions.

One open-source example is the fluentui [2] repo, which  uses beachball
to generate CHANGELOG.json and CHANGELOG.md files, and these files have
very poor delta characteristics when comparing against versions across
parent directories.

| Stage                 | Pack Size | Repack Time |
|-----------------------|-----------|-------------|
| After clone           | 694 MB    | N/A         |
| --name-hash-version=1 | 438 MB    | 728s        |
| --name-hash-version=2 | 168 MB    | 142s        |

[2] https://github.com/microsoft/fluentui

In this example, we see significant gains in the compressed packfile
size as well as the time taken to compute the packfile.

Using a collection of repositories that use the beachball tool, I was
able to make similar comparisions with dramatic results. While the
fluentui repo is public, the others are private so cannot be shared for
reproduction. The results are so significant that I find it important to
share here:

| Repo     | --name-hash-version=1 | --name-hash-version=2 |
|----------|-----------------------|-----------------------|
| fluentui |               440 MB  |               161 MB  |
| Repo B   |             6,248 MB  |               856 MB  |
| Repo C   |            37,278 MB  |             6,755 MB  |
| Repo D   |           131,204 MB  |             7,463 MB  |

Future changes could include making --name-hash-version implied by a config
value or even implied by default during a full repack.

It is important to point out that the name hash value is stored in the
.bitmap file format, so we must force --name-hash-version=1 when bitmaps
are being read or written. Later, the bitmap format could be updated to
be aware of the name hash version so deltas can be quickly computed
across the bitmapped/not-bitmapped boundary. To promote the safety of
this parameter, the validate_name_hash_version() method will die() if
the given name-hash version is incorrect and will disable newer versions
if not yet compatible with other features, such as --write-bitmap-index.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.txt | 32 +++++++++++++++++-
 builtin/pack-objects.c             | 52 +++++++++++++++++++++++++++---
 t/t5300-pack-object.sh             | 31 ++++++++++++++++++
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e32404c6aae..7f69ae4855f 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--cruft] [--cruft-expiration=<time>]
 	[--stdout [--filter=<filter-spec>] | <base-name>]
-	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
+	[--shallow] [--keep-true-parents] [--[no-]sparse]
+	[--name-hash-version=<n>] < <object-list>
 
 
 DESCRIPTION
@@ -345,6 +346,35 @@ raise an error.
 	Restrict delta matches based on "islands". See DELTA ISLANDS
 	below.
 
+--name-hash-version=<n>::
+	While performing delta compression, Git groups objects that may be
+	similar based on heuristics using the path to that object. While
+	grouping objects by an exact path match is good for paths with
+	many versions, there are benefits for finding delta pairs across
+	different full paths. Git collects objects by type and then by a
+	"name hash" of the path and then by size, hoping to group objects
+	that will compress well together.
++
+The default name hash version is `1`, which prioritizes hash locality by
+considering the final bytes of the path as providing the maximum magnitude
+to the hash function. This version excels at distinguishing short paths
+and finding renames across directories. However, the hash function depends
+primarily on the final 16 bytes of the path. If there are many paths in
+the repo that have the same final 16 bytes and differ only by parent
+directory, then this name-hash may lead to too many collisions and cause
+poor results. At the moment, this version is required when writing
+reachability bitmap files with `--write-bitmap-index`.
++
+The name hash version `2` has similar locality features as version `1`,
+except it considers each path component separately and overlays the hashes
+with a shift. This still prioritizes the final bytes of the path, but also
+"salts" the lower bits of the hash using the parent directory names. This
+method allows for some of the locality benefits of version `1` while
+breaking most of the collisions from a similarly-named file appearing in
+many different directories. At the moment, this version is not allowed
+when writing reachability bitmap files with `--write-bitmap-index` and it
+will be automatically changed to version `1`.
+
 
 DELTA ISLANDS
 -------------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08007142671..e65d4793edf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,6 +266,35 @@ struct configured_exclusion {
 static struct oidmap configured_exclusions;
 
 static struct oidset excluded_by_config;
+static int name_hash_version = 1;
+
+/**
+ * Check whether the name_hash_version chosen by user input is apporpriate,
+ * and also validate whether it is appropriate with other features.
+ */
+static void validate_name_hash_version(void)
+{
+	if (name_hash_version < 1 || name_hash_version > 2)
+		die(_("invalid --name-hash-version option: %d"), name_hash_version);
+	if (write_bitmap_index && name_hash_version != 1) {
+		warning(_("currently, --write-bitmap-index requires --name-hash-version=1"));
+		name_hash_version = 1;
+	}
+}
+
+static inline uint32_t pack_name_hash_fn(const char *name)
+{
+	switch (name_hash_version) {
+	case 1:
+		return pack_name_hash(name);
+
+	case 2:
+		return pack_name_hash_v2((const unsigned char *)name);
+
+	default:
+		BUG("invalid name-hash version: %d", name_hash_version);
+	}
+}
 
 /*
  * stats
@@ -1698,7 +1727,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
 		return 0;
 	}
 
-	create_object_entry(oid, type, pack_name_hash(name),
+	create_object_entry(oid, type, pack_name_hash_fn(name),
 			    exclude, name && no_try_delta(name),
 			    found_pack, found_offset);
 	return 1;
@@ -1912,7 +1941,7 @@ static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	size_t cmplen;
-	unsigned hash = pack_name_hash(name);
+	unsigned hash = pack_name_hash_fn(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
@@ -3422,7 +3451,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * here using a now in order to perhaps improve the delta selection
 	 * process.
 	 */
-	oe->hash = pack_name_hash(name);
+	oe->hash = pack_name_hash_fn(name);
 	oe->no_try_delta = name && no_try_delta(name);
 
 	stdin_packs_hints_nr++;
@@ -3572,7 +3601,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	entry = packlist_find(&to_pack, oid);
 	if (entry) {
 		if (name) {
-			entry->hash = pack_name_hash(name);
+			entry->hash = pack_name_hash_fn(name);
 			entry->no_try_delta = no_try_delta(name);
 		}
 	} else {
@@ -3595,7 +3624,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			return;
 		}
 
-		entry = create_object_entry(oid, type, pack_name_hash(name),
+		entry = create_object_entry(oid, type, pack_name_hash_fn(name),
 					    0, name && no_try_delta(name),
 					    pack, offset);
 	}
@@ -4069,6 +4098,15 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
+	/*
+	 * For now, force the name-hash version to be 1 since that
+	 * is the version implied by the bitmap format. Later, the
+	 * format can include this version explicitly in its format,
+	 * allowing readers to know the version that was used during
+	 * the bitmap write.
+	 */
+	name_hash_version = 1;
+
 	if (pack_options_allow_reuse())
 		reuse_partial_packfile_from_bitmap(bitmap_git,
 						   &reuse_packfiles,
@@ -4429,6 +4467,8 @@ int cmd_pack_objects(int argc,
 		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
 				N_("protocol"),
 				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+		OPT_INTEGER(0, "name-hash-version", &name_hash_version,
+			 N_("use the specified name-hash function to group similar objects")),
 		OPT_END(),
 	};
 
@@ -4576,6 +4616,8 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
+	validate_name_hash_version();
+
 	if (use_delta_islands)
 		strvec_push(&rp, "--topo-order");
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a5..4270eabe8b7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -674,4 +674,35 @@ do
 	'
 done
 
+test_expect_success 'valid and invalid --name-hash-versions' '
+	# Valid values are hard to verify other than "do not fail".
+	# Performance tests will be more valuable to validate these versions.
+	for value in 1 2
+	do
+		git pack-objects base --all --name-hash-version=$value || return 1
+	done &&
+
+	# Invalid values have clear post-conditions.
+	for value in -1 0 3
+	do
+		test_must_fail git pack-objects base --all --name-hash-version=$value 2>err &&
+		test_grep "invalid --name-hash-version option" err || return 1
+	done
+'
+
+# The following test is not necessarily a permanent choice, but since we do not
+# have a "name hash version" bit in the .bitmap file format, we cannot write the
+# hash values into the .bitmap file without risking breakage later.
+#
+# TODO: Make these compatible in the future and replace this test with the
+# expected behavior when both are specified.
+test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompatible' '
+	git pack-objects base --all --name-hash-version=2 --write-bitmap-index 2>err &&
+	test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err &&
+
+	# --stdout option silently removes --write-bitmap-index
+	git pack-objects --stdout --all --name-hash-version=2 --write-bitmap-index >out 2>err &&
+	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
+'
+
 test_done
-- 
gitgitgadget

