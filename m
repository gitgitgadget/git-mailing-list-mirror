Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0B279793
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419140; cv=none; b=mFC7hQpzx0gA100U4erQ9uVYun0UK/jHrk8xg3YIAxYVTcPIuYPybPNg+lHSRb1uM2Hwqkdl3PkJGMo00z/F6x/IRvwa1mnoI3UZSKRdl3O7akAjQSUY8TLr3ILpa1rjJzojfjM/uk+HpZYqF6GGtSxftp9x1XBbvlH41KRdHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419140; c=relaxed/simple;
	bh=yEPKY3FKkwyimBYSIk5dZIN630lfO3KRSuavgdiIGJw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q/QBLieqIhG0HCqZHlwqn7kjSPtfsLjmeYlwXl49PpgcBaNQupFFCdy9/RhWzwIr8gj97t0V1bgB80wRlryVI6i6CuAr8SLIJQ1959U7YgyG6Xor91/YrjTS32BMc4OXpRM1fkTfBrCzag43/BSerQJrq0UCdvXJt6s94e7bBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7mOxR46; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7mOxR46"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ede096d73so17110515e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419135; x=1748023935; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SALGZqgYKOgPafYYlYHHv2ldEIGold4kfTl9XpW3KE=;
        b=B7mOxR46pPD7RFPFFOz12n07IWPjXxyAbB5RTKsdPh57nJeHuiYiA2RbcqEs4zZihU
         0l+HqqtGSKxT6zNVbSvvuFGVGPtqpt/V718xcCoInmVliJcCajpiJLKkW13vqIpdzv+b
         9ONohcUOGE6IQROBqN+qdb/8VYlp7Fitwxqhkq8z5d0/CC67Lv0tGZVb7z4dxd5Ab+gE
         MetO64htphim6XfY5uCzdlChfOIMLvzOSAfsCVHxehuECTF8jbZWBEUxpchtXeiRqxfp
         99sZn6iG7Vi8A8wiQss4MsQOkUi/pwedSn94L6ingwqc6el3rEtnWkR2RqyXWPVqkSx9
         QDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419135; x=1748023935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SALGZqgYKOgPafYYlYHHv2ldEIGold4kfTl9XpW3KE=;
        b=MyCDSis1xsk0/boIb2kaUNRm1mmIy5P4IPVjMrGv9o+l95wuejsu3r6g3+MkWNeJTH
         U85dqCNJiErsy3EjjMRAaUP/Qvgvn+hLsEzlf2rSzRUkgoCKV8+p5XadLmqfNXFP4v4Z
         kfgxKcw+I6kclaZXHXoIv35bokeIobqupeKcb94Q/LTfvz0C90mxwKqDq6CjvjVQC4oy
         +aqIRZbaK5zI8dx++aIXanyPXci1BW+K4Qrw36fGJCF02Yx9awyDZiIGWlQN+yXa2TKK
         H0ilLs4DAgkpdrPvTEWK5M7BUNkdx+atfO+9DBY1kGd7qe0G0zLdW7pmmoiNoRhO4cMV
         GNOQ==
X-Gm-Message-State: AOJu0Yztk3X7AYH1saaZecHMQxQeanuhMf+/6rhe2OI6wFTTHmgrVVSr
	IEZdC9PeSdcN8QPkwitUXPm+T4AFimL+y4cqZ/fdqNXmgvKo/vBlEXob1pw73w==
X-Gm-Gg: ASbGnctawisN5NZ1bJRIzMT2ZYh72L7M61BxKLETFGHQrCJvmexRt4CfTc2X1PyHMEC
	CQJ5Y6n5MOwgc3TcbkvAb4ZnOpbBhP5rcQyFV28vyaGQ64His4kVEXTlC4ez/RxHnSY5lO3jnmm
	1cNZ3oSH8+XhjXvPVuxV0/VmgK4qwzG5M/FHjsqT7RBWC0ekMTZ314yiP2uOs79mV9JhRRZR3Ov
	cEf1+4BrTzVpWzsC5y26XZr2dKZUSiTnGTEGH9LsNbZZP6Pdx6L1kllraxnRsO5UFNckINWE+5f
	zbw73SyfEjQQ/FS977pGNLW5h9hHqiXDn453jCc0wZ26cCI2ghkk
X-Google-Smtp-Source: AGHT+IG/PG7P62OFN0G4pDS/9MxDLeSm47hQs/RqcuaawYbDPk3jEYXG6Cp3dhYmaN5FEJJzicSWDA==
X-Received: by 2002:a05:6000:1445:b0:3a3:643e:2542 with SMTP id ffacd0b85a97d-3a3643e256dmr1580524f8f.26.1747419135213;
        Fri, 16 May 2025 11:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b47sm3669929f8f.58.2025.05.16.11.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:13 -0700 (PDT)
Message-Id: <e3ea17e326e5997ffbd3fdae8c5e011c816c88ca.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:52 +0000
Subject: [PATCH v3 02/13] pack-objects: add --path-walk option
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

In order to more easily compute delta bases among objects that appear at
the exact same path, add a --path-walk option to 'git pack-objects'.

This option will use the path-walk API instead of the object walk given
by the revision machinery. Since objects will be provided in batches
representing a common path, those objects can be tested for delta bases
immediately instead of waiting for a sort of the full object list by
name-hash. This has multiple benefits, including avoiding collisions by
name-hash.

The objects marked as UNINTERESTING are included in these batches, so we
are guaranteeing some locality to find good delta bases.

After the individual passes are done on a per-path basis, the default
name-hash is used to find other opportunistic delta bases that did not
match exactly by the full path name.

The current implementation performs delta calculations while walking
objects, which is not ideal for a few reasons. First, this will cause
the "Enumerating objects" phase to be much longer than usual. Second, it
does not take advantage of threading during the path-scoped delta
calculations. Even with this lack of threading, the path-walk option is
sometimes faster than the usual approach. Future changes will refactor
this code to allow for threading, but that complexity is deferred until
later to keep this patch as simple as possible.

This new walk is incompatible with some features and is ignored by
others:

 * Object filters are not currently integrated with the path-walk API,
   such as sparse-checkout or tree depth. A blobless packfile could be
   integrated easily, but that is deferred for later.

 * Server-focused features such as delta islands, shallow packs, and
   using a bitmap index are incompatible with the path-walk API.

 * The path walk API is only compatible with the --revs option, not
   taking object lists or pack lists over stdin. These alternative ways
   to specify the objects currently ignores the --path-walk option
   without even a warning.

Future changes will create performance tests that demonstrate the power
of this approach.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc        |  13 +-
 Documentation/technical/api-path-walk.adoc |   1 +
 builtin/pack-objects.c                     | 148 +++++++++++++++++++--
 t/t5300-pack-object.sh                     |  15 +++
 4 files changed, 168 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 7f69ae4855f6..3b803d3a7830 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--cruft] [--cruft-expiration=<time>]
 	[--stdout [--filter=<filter-spec>] | <base-name>]
 	[--shallow] [--keep-true-parents] [--[no-]sparse]
-	[--name-hash-version=<n>] < <object-list>
+	[--name-hash-version=<n>] [--path-walk] < <object-list>
 
 
 DESCRIPTION
@@ -375,6 +375,17 @@ many different directories. At the moment, this version is not allowed
 when writing reachability bitmap files with `--write-bitmap-index` and it
 will be automatically changed to version `1`.
 
+--path-walk::
+	Perform compression by first organizing objects by path, then a
+	second pass that compresses across paths as normal. This has the
+	potential to improve delta compression especially in the presence
+	of filenames that cause collisions in Git's default name-hash
+	algorithm.
++
+Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
+`--use-bitmap-index` option will be ignored in the presence of
+`--path-walk.`
+
 
 DELTA ISLANDS
 -------------
diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index 3e089211fb4d..e522695dd9fa 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -69,4 +69,5 @@ Examples
 
 See example usages in:
 	`t/helper/test-path-walk.c`,
+	`builtin/pack-objects.c`,
 	`builtin/backfill.c`
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7805429f5d1c..bd0883890376 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -41,6 +41,9 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
+#include "blob.h"
+#include "tree.h"
+#include "path-walk.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -217,6 +220,7 @@ static int delta_search_threads;
 static int pack_to_stdout;
 static int sparse;
 static int thin;
+static int path_walk;
 static int num_preferred_base;
 static struct progress *progress_state;
 
@@ -4191,6 +4195,105 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
+static inline int is_oid_uninteresting(struct repository *repo,
+				       struct object_id *oid)
+{
+	struct object *o = lookup_object(repo, oid);
+	return !o || (o->flags & UNINTERESTING);
+}
+
+static int add_objects_by_path(const char *path,
+			       struct oid_array *oids,
+			       enum object_type type,
+			       void *data)
+{
+	struct object_entry **delta_list = NULL;
+	size_t oe_start = to_pack.nr_objects;
+	size_t oe_end;
+	unsigned int sub_list_nr;
+	unsigned int *processed = data;
+
+	/*
+	 * First, add all objects to the packing data, including the ones
+	 * marked UNINTERESTING (translated to 'exclude') as they can be
+	 * used as delta bases.
+	 */
+	for (size_t i = 0; i < oids->nr; i++) {
+		int exclude;
+		struct object_info oi = OBJECT_INFO_INIT;
+		struct object_id *oid = &oids->oid[i];
+
+		/* Skip objects that do not exist locally. */
+		if (exclude_promisor_objects &&
+		    oid_object_info_extended(the_repository, oid, &oi,
+					     OBJECT_INFO_FOR_PREFETCH) < 0)
+			continue;
+
+		exclude = is_oid_uninteresting(the_repository, oid);
+
+		if (exclude && !thin)
+			continue;
+
+		add_object_entry(oid, type, path, exclude);
+	}
+
+	oe_end = to_pack.nr_objects;
+
+	/* We can skip delta calculations if it is a no-op. */
+	if (oe_end == oe_start || !window)
+		return 0;
+
+	sub_list_nr = 0;
+	if (oe_end > oe_start)
+		ALLOC_ARRAY(delta_list, oe_end - oe_start);
+
+	for (size_t i = 0; i < oe_end - oe_start; i++) {
+		struct object_entry *entry = to_pack.objects + oe_start + i;
+
+		if (!should_attempt_deltas(entry))
+			continue;
+
+		delta_list[sub_list_nr++] = entry;
+	}
+
+	/*
+	 * Find delta bases among this list of objects that all match the same
+	 * path. This causes the delta compression to be interleaved in the
+	 * object walk, which can lead to confusing progress indicators. This is
+	 * also incompatible with threaded delta calculations. In the future,
+	 * consider creating a list of regions in the full to_pack.objects array
+	 * that could be picked up by the threaded delta computation.
+	 */
+	if (sub_list_nr && window) {
+		QSORT(delta_list, sub_list_nr, type_size_sort);
+		find_deltas(delta_list, &sub_list_nr, window, depth, processed);
+	}
+
+	free(delta_list);
+	return 0;
+}
+
+static void get_object_list_path_walk(struct rev_info *revs)
+{
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	unsigned int processed = 0;
+
+	info.revs = revs;
+	info.path_fn = add_objects_by_path;
+	info.path_fn_data = &processed;
+
+	/*
+	 * Allow the --[no-]sparse option to be interesting here, if only
+	 * for testing purposes. Paths with no interesting objects will not
+	 * contribute to the resulting pack, but only create noisy preferred
+	 * base objects.
+	 */
+	info.prune_all_uninteresting = sparse;
+
+	if (walk_objects_by_path(&info))
+		die(_("failed to pack objects via path-walk"));
+}
+
 static void get_object_list(struct rev_info *revs, int ac, const char **av)
 {
 	struct setup_revision_opt s_r_opt = {
@@ -4246,15 +4349,19 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	if (write_bitmap_index)
 		mark_bitmap_preferred_tips();
 
-	if (prepare_revision_walk(revs))
-		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(revs, show_edge, sparse);
-
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list(revs,
-			     show_commit, fn_show_object,
-			     NULL);
+
+	if (path_walk) {
+		get_object_list_path_walk(revs);
+	} else {
+		if (prepare_revision_walk(revs))
+			die(_("revision walk setup failed"));
+		mark_edges_uninteresting(revs, show_edge, sparse);
+		traverse_commit_list(revs,
+				show_commit, fn_show_object,
+				NULL);
+	}
 
 	if (unpack_unreachable_expiration) {
 		revs->ignore_missing_links = 1;
@@ -4464,6 +4571,8 @@ int cmd_pack_objects(int argc,
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
+		OPT_BOOL(0, "path-walk", &path_walk,
+			 N_("use the path-walk API to walk objects when possible")),
 		OPT_BOOL(0, "shallow", &shallow,
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
@@ -4549,7 +4658,30 @@ int cmd_pack_objects(int argc,
 		window = 0;
 
 	strvec_push(&rp, "pack-objects");
-	if (thin) {
+
+	if (path_walk) {
+		const char *option = NULL;
+		if (filter_options.choice)
+			option = "--filter";
+		else if (use_delta_islands)
+			option = "--delta-islands";
+		else if (shallow)
+			option = "--shallow";
+
+		if (option) {
+			warning(_("cannot use %s with %s"),
+				option, "--path-walk");
+			path_walk = 0;
+		}
+	}
+	if (path_walk) {
+		strvec_push(&rp, "--boundary");
+		 /*
+		  * We must disable the bitmaps because we are removing
+		  * the --objects / --objects-edge[-aggressive] options.
+		  */
+		use_bitmap_index = 0;
+	} else if (thin) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, shallow
 				? "--objects-edge-aggressive"
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 5ac8d39094b6..16420d128639 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -723,4 +723,19 @@ test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
 	! test_grep "currently, --write-bitmap-index requires --name-hash-version=1" err
 '
 
+test_expect_success '--path-walk pack everything' '
+	git -C server rev-parse HEAD >in &&
+	git -C server pack-objects --stdout --revs --path-walk <in >out.pack &&
+	git -C server index-pack --stdin <out.pack
+'
+
+test_expect_success '--path-walk thin pack' '
+	cat >in <<-EOF &&
+	$(git -C server rev-parse HEAD)
+	^$(git -C server rev-parse HEAD~2)
+	EOF
+	git -C server pack-objects --thin --stdout --revs --path-walk <in >out.pack &&
+	git -C server index-pack --fix-thin --stdin <out.pack
+'
+
 test_done
-- 
gitgitgadget

