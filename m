Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A622301
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711684; cv=none; b=sNwlDIMFZn7S7TPFOJXqTxc/VRhOPsXyCc8zBb9xKufinTlOkMorM0XVseCdMdHUZcNE1pfsqkDQewjp6sWnZ+zxTbOILxLxkCIqwxWum5Gi6HNO1fxEurHAeZqIUWXHbO038Qtaub2c1r3jXWItVuDQHeeuPUPxgV+dZ5EADO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711684; c=relaxed/simple;
	bh=MgGNl4TGa96Bxn8/CQ3K5CYeBvg0jqMXfvZw7j6uPgM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o8Qe4UuRztMpfr1cUN3fKmu8NQJd7/PpIT0EE8mmA2GfgPNMSUGioVfwAQxR1k9vBve3xsm9Smmu61rUT2r8s7QR5ZhhGcIfvLysLEOuzrZ/uwios+W5HiF2CYQjYRnQRL7S54h/3VmUaqPWCB//HShQRPqStNeWwIdsqiVAZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDXiF36C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDXiF36C"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43621d27adeso14697735e9.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711679; x=1735316479; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6odIyKzkUDJtHC9vVl/AuqsZnWL+pqvFJvudlELXmM=;
        b=DDXiF36CibNfFqoVRqUwxEKReoI2QtD+6xqjxHt/uGzCGxk+gZmzxFPHSF884w5Lwx
         3hTZSE7TRkq8exWKzk1nzkyoO1MI/vpF4yDUksjWpg+4/MYI8k6naa6icZ4UoQAmvfky
         sT6PbtstSw7/JxhZvJ3oL4F3KM3Ic6FD/u7sk/oC7BMMdrCE7nzxyWZ8QlzQIr4TazOd
         RN+ztCFA73uQjVVk9sKF7gH/QyENiUoX9QYPAbSm2c4+LQcgbwP3YtkISIQOo2RMLB8Z
         IYEffHeocxfnyvfwhnjxWk4TZ9u7HYbTQ6MByYNS2K52NrdVcuANkLBoi47khJ92Nd+7
         8NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711679; x=1735316479;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6odIyKzkUDJtHC9vVl/AuqsZnWL+pqvFJvudlELXmM=;
        b=WjiGvc01iWTKdDR94Ojc9f4yu95XFL8svfU5DYy7EqTiOP+TApyjL92nfkS4h6JLFF
         obHyNJVPDm8fLnUdg1MwL5YYdA3k6hJ9lxmQ+NIfknlnxb7irvQTACyH8w1Mes76eeR4
         kRtDMplGCAhJDIUckjgVdapIOOPl/KfqiL3kakAXO5Ive07mWa6JQYb7ABl9fGIdymAj
         7w+kvS4hXJZO1SuXAzPhe2Qge3lW4LVPcRSaVL3GKCbTUo/KAa9h1dgPpzDP5JLYSA7s
         GqmGJRVsZ+D+jymD2Ep3dzoLl7fwAWdp+HJS/48sxfyD1R+erol3Khv6D58z5SR3Tcot
         PWVg==
X-Gm-Message-State: AOJu0Yw20T3L4vkbDlJM+fNNRyA3Hmu15Tc42JBEegU9ipHpHVcK3C+v
	PUON31vT2J44a1Cf4y/aUGjfXaPLjxKiNgRK4pQjbfbVNSGig08FqxW3Jw==
X-Gm-Gg: ASbGncviHB2BSX2nhqC79SHTu8AeVbMa7kapdYuzAjZBWfk+G9OuRLADH6zAUJ1hO/m
	o/quJKosYSoQfq15VXDkJXT/aqqAKdelNeeAhdr4iHChkfoMGGLb3D12xi8fApBa315sW1I2tjq
	e53dPvL8AU4eeUK6H+HFkQttWBOoKXrAHKCmxzC8bijOaKQF4gJI2f+BXG9aQMIQMul1u9p8AFq
	1+fsg+La9ETVS/3T82jSZMgcqhL0rW2NILqdZI9i1LOP9tRBPDmO8uJIw==
X-Google-Smtp-Source: AGHT+IG2m2ejzIO46dqSLwE6MJ+97Azyu18HL4r0wrODa0vb7VmPm2VYFWCbRAnleUXv/bWamZ59lA==
X-Received: by 2002:a05:600c:3554:b0:434:a923:9310 with SMTP id 5b1f17b1804b1-43668646103mr34868365e9.15.1734711678700;
        Fri, 20 Dec 2024 08:21:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366a093cbfsm22353825e9.22.2024.12.20.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:21:17 -0800 (PST)
Message-Id: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:21:08 +0000
Subject: [PATCH v4 0/7] PATH WALK I: The path-walk API
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>


Introduction and relation to prior series
=========================================

This is a new series that rerolls the initial "path-walk API" patches of my
RFC [1] "Path-walk API and applications". This new API (in path-walk.c and
path-walk.h) presents a new way to walk objects such that trees and blobs
are walked in batches according to their path.

This also replaces the previous version of ds/path-walk that was being
reviewed in [2]. The consensus was that the series was too long/dense and
could use some reduction in size. This series takes the first few patches,
but also makes some updates (which will be described later).

[1]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/
[RFC] Path-walk API and applications

[2]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/
[PATCH v2 00/17] pack-objects: add --path-walk option for better deltas

This series only introduces the path-walk API, but does so to the full
complexity required to later add the integration with git pack-objects to
improve packing compression in both time and space for repositories with
many name hash collisions. The compression also at least improves for other
repositories, but may not always have an improvement in time.

Some of the changes that are present in this series that differ from the
previous version are motivated directly by discoveries made by testing the
feature in Git for Windows and microsoft/git forks that shipped these
features for fast delivery of these improvements to users who needed them.
That testing across many environments informed some things that needed to be
changed, and in this series those changes are checked by tests in the
t6601-path-walk.sh test script and the test-tool path-walk test helper.
Thus, the code being introduced in this series is covered by tests even
though it is not integrated into the git executable.


Discussion of follow-up applications
====================================

By splitting this series out into its own, I was able to reorganize the
patches such that each application can be build independently off of this
series. These are available as pending PRs in gitgitgadget/git:

 * Better delta compression with 'git pack-objects' [3]: This application
   allows an option in 'git pack-objects' to change how objects are walked
   in order to group objects with the same path for early delta compression
   before using the name hash sort to look for cross-path deltas. This helps
   significantly in repositories with many name-hash collisions. This
   reduces the size of 'git push' pacifies via a config option and reduces
   the total repo size in 'git repack'.

 * The 'git backfill' command [4]: This command downloads missing blobs in a
   bloodless partial clone. In order to save space and network bandwidth, it
   assumes that objects at a common path are likely to delta well with each
   other, so it downloads missing blobs in batches via the path-walk API.
   This presents a way to use blobless clones as a pseudo-resumable clone,
   since the initial clone of commits and trees is a smaller initial
   download and the batch size allows downloading blobs incrementally. When
   pairing this command with the sparse-checkout feature, the path-walk API
   is adjusted to focus on the paths within the sparse-checkout. This allows
   the user to only download the files they are likely to need when
   inspecting history within their scope without downloading the entire
   repository history.

 * The 'git survey' command [5]. This application begins the work to mimic
   the behavior of git-sizer, but to use internal data structures for better
   performance and careful understanding of how objects are stored. Using
   the path-walk API, paths with many versions can be considered in a batch
   and sorted into a list to report the paths that contribute most to the
   size of the repository. A version of this command was used to help
   confirm the issues with the name hash collisions. It was also used to
   diagnose why some repacks using the --path-walk option were taking more
   space than without for some repositories. (More on this later.)

Question for reviewers: I am prepped to send these three applications to the
mailing list, but I'll refrain for now to avoid causing too much noise for
folks. Would you like to see them on-list while this series is under review?
Or would you prefer to explore the PRs ([3] [4] and [5])?

[3] https://github.com/gitgitgadget/git/pull/1819
PATH WALK II: Add --path-walk option to 'git pack-objects'

[4] https://github.com/gitgitgadget/git/pull/1820
PATH WALK III: Add 'git backfill' command

[5] https://github.com/gitgitgadget/git/pull/1821
PATH WALK IV: Add 'git survey' command


Structure of the Patch Series
=============================

This patch series attempts to create the simplest version of the API in
patch 1, then build functionality incrementally. During the process, each
change will introduce an update to:

 * The path-walk API itself in path-walk.c and path-walk.h.
 * The documentation of the API in
   Documentation/technical/api-path-walk.txt.
 * The test script t/t6601-path-walk.sh.

The core of the API relies on using a 'struct rev_info' to define an initial
set of objects and some form of a commit walk to define what range of
objects to visit. Initially, only a subset of 'struct rev_info' options work
as expected. For example:

 * Patch 1 assumes that only commit objects are starting positions, but the
   focus is on exploring trees and blobs.
 * Patch 3 allows users to specify object types, which includes outputting
   the visited commits in a batch.
 * Annotated tags and indexed objects are considered in Patch 4. These are
   grouped because they both exist within the 'pending' object list.
 * UNINTERESTING objects are not considered until Patch 5.


Changes in v1 (since previous version)
======================================

There are a few hard-won learnings from previous versions of this series due
to testing this in the wild with many different repositories.

 * Initially, the 'git pack-objects --path-walk' feature was not tested with
   the '--shallow' option because it was expected that this option was for
   servers creating a pack containing shallow commits. However, this option
   is also used when pushing from a shallow clone, and this was a critical
   feature that we needed to reduce the size of commits pushed from
   automated environments that were bootstrapped by shallow clones. The crux
   of the change is in Patch 5 and how UNINTERESTING objects are handled. We
   no longer need to push the UNINTERESTING flag around the objects
   ourselves and can use existing logic in list-objects.c to do so. This
   allows using the --objects-edge-aggressive option when necessary to
   reduce the object count when pushing from a shallow clone. (The
   pack-objects series expands on tests to cover this integration point.)

 * When looking into cases where 'git repack -adf' outperformed 'git repack
   -adf --path-walk', I discovered that the issue did not reproduce in a
   bare repository. This is due to 'git repack' iterating over all indexed
   objects before walking commits. I had inadvertently put all indexed
   objects in their own category, leading to no good deltas with previous
   versions of those files; I had also not used the 'path' option from the
   pending list, so these objects had invalid name hash values. You will see
   in patch 4 that the pending list is handled quite differently and the
   '--indexed-objects' option is tested directly within t6601.

 * I added a new 'test_cmp_sorted' helper because I wanted to simplify some
   repeated sections of t6601.

 * Patch 1 has significantly more context than it did before.

 * Annotated tags are given a name of "/tags" to differentiate them slightly
   from root trees and commits.


Changes in v2
=============

 * Updated the test helper to output the batch number, allowing us to
   confirm that OIDs are grouped appropriately. This also signaled a few
   cases where the callback function was being called on an empty set.

 * This change has resulted in significant changes to the test data,
   including reordered lines and prepended batch numbers.

 * Thanks to Patrick for providing a recommended change to remove memory
   leaks from the test helper.


Changes in v3
=============

 * Updated test helper to use type_string(), which leads to a change to use
   lowercase strings in the test scripts. That will lead to the range-diff
   looking pretty terrible.

 * Added a new patch that changes the visit order of the path-walk API. The
   intention is to reduce memory pressure by emitting blob paths before
   recursing into tree paths. This also has the effect of visiting blobs and
   trees in lexicographic order instead of the reverse.


Changes in v4
=============

 * Several style fixes and function renames.

 * Better error handling, avoiding some die() statements.

 * Additional BUG() statements for "impossible" scenarios.

 * Optimizations around SEEN objects to avoid extra work. This does have
   some impact on paths that appear in the index but no other versions are
   discovered during the tree walk. This changes a test in t6601 and the
   timing of visiting the blob path "a" being delayed to the end.

 * The path_walk_info struct now has proper initializers and destructors,
   even though the current destructor is empty.

Thanks, -Stolee

Derrick Stolee (7):
  path-walk: introduce an object walk by path
  test-lib-functions: add test_cmp_sorted
  t6601: add helper for testing path-walk API
  path-walk: allow consumer to specify object types
  path-walk: visit tags and cached objects
  path-walk: mark trees and blobs as UNINTERESTING
  path-walk: reorder object visits

 Documentation/technical/api-path-walk.txt |  63 +++
 Makefile                                  |   2 +
 path-walk.c                               | 592 ++++++++++++++++++++++
 path-walk.h                               |  69 +++
 t/helper/test-path-walk.c                 | 112 ++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/t6601-path-walk.sh                      | 368 ++++++++++++++
 t/test-lib-functions.sh                   |  10 +
 9 files changed, 1218 insertions(+)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/t6601-path-walk.sh


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1818%2Fderrickstolee%2Fapi-upstream-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1818/derrickstolee/api-upstream-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1818

Range-diff vs v3:

 1:  b7e9b81e8b3 ! 1:  62f7aae477b path-walk: introduce an object walk by path
     @@ path-walk.c (new)
      +#include "tree.h"
      +#include "tree-walk.h"
      +
     -+struct type_and_oid_list
     -+{
     ++struct type_and_oid_list {
      +	enum object_type type;
      +	struct oid_array oids;
      +};
     @@ path-walk.c (new)
      +	string_list_append(&ctx->path_stack, path);
      +}
      +
     -+static int add_children(struct path_walk_context *ctx,
     -+			const char *base_path,
     -+			struct object_id *oid)
     ++static int add_tree_entries(struct path_walk_context *ctx,
     ++			    const char *base_path,
     ++			    struct object_id *oid)
      +{
      +	struct tree_desc desc;
      +	struct name_entry entry;
     @@ path-walk.c (new)
      +		      oid_to_hex(oid));
      +		return -1;
      +	} else if (parse_tree_gently(tree, 1)) {
     -+		die("bad tree object %s", oid_to_hex(oid));
     ++		error("bad tree object %s", oid_to_hex(oid));
     ++		return -1;
      +	}
      +
      +	strbuf_addstr(&path, base_path);
     @@ path-walk.c (new)
      +			struct blob *child = lookup_blob(ctx->repo, &entry.oid);
      +			o = child ? &child->object : NULL;
      +		} else {
     -+			/* Wrong type? */
     -+			continue;
     ++			BUG("invalid type for tree entry: %d", type);
      +		}
      +
     -+		if (!o) /* report error?*/
     ++		if (!o) {
     ++			error(_("failed to find object %s"),
     ++			      oid_to_hex(&o->oid));
     ++			return -1;
     ++		}
     ++
     ++		/* Skip this object if already seen. */
     ++		if (o->flags & SEEN)
      +			continue;
     ++		o->flags |= SEEN;
      +
      +		strbuf_setlen(&path, base_len);
      +		strbuf_add(&path, entry.path, entry.pathlen);
     @@ path-walk.c (new)
      +			strmap_put(&ctx->paths_to_lists, path.buf, list);
      +		}
      +		push_to_stack(ctx, path.buf);
     -+
     -+		/* Skip this object if already seen. */
     -+		if (o->flags & SEEN)
     -+			continue;
     -+		o->flags |= SEEN;
      +		oid_array_append(&list->oids, &entry.oid);
      +	}
      +
     @@ path-walk.c (new)
      +	/* Expand data for children. */
      +	if (list->type == OBJ_TREE) {
      +		for (size_t i = 0; i < list->oids.nr; i++) {
     -+			ret |= add_children(ctx,
     ++			ret |= add_tree_entries(ctx,
      +					    path,
      +					    &list->oids.oid[i]);
      +		}
     @@ path-walk.c (new)
      +	return ret;
      +}
      +
     -+static void clear_strmap(struct strmap *map)
     ++static void clear_paths_to_lists(struct strmap *map)
      +{
      +	struct hashmap_iter iter;
      +	struct strmap_entry *e;
     @@ path-walk.c (new)
      +		t = lookup_tree(info->revs->repo, oid);
      +
      +		if (!t) {
     -+			warning("could not find tree %s", oid_to_hex(oid));
     -+			continue;
     ++			error("could not find tree %s", oid_to_hex(oid));
     ++			return -1;
      +		}
      +
      +		if (t->object.flags & SEEN)
     @@ path-walk.c (new)
      +	trace2_data_intmax("path-walk", ctx.repo, "paths", paths_nr);
      +	trace2_region_leave("path-walk", "path-walk", info->revs->repo);
      +
     -+	clear_strmap(&ctx.paths_to_lists);
     ++	clear_paths_to_lists(&ctx.paths_to_lists);
      +	strset_clear(&ctx.path_stack_pushed);
      +	string_list_clear(&ctx.path_stack, 0);
      +	return ret;
     ++}
     ++
     ++void path_walk_info_init(struct path_walk_info *info)
     ++{
     ++	struct path_walk_info empty = PATH_WALK_INFO_INIT;
     ++	memcpy(info, &empty, sizeof(empty));
     ++}
     ++
     ++void path_walk_info_clear(struct path_walk_info *info UNUSED)
     ++{
     ++	/*
     ++	 * This destructor is empty for now, as info->revs
     ++	 * is not owned by 'struct path_walk_info'.
     ++	 */
      +}
      
       ## path-walk.h (new) ##
     @@ path-walk.h (new)
      +struct path_walk_info {
      +	/**
      +	 * revs provides the definitions for the commit walk, including
     -+	 * which commits are UNINTERESTING or not.
     ++	 * which commits are UNINTERESTING or not. This structure is
     ++	 * expected to be owned by the caller.
      +	 */
      +	struct rev_info *revs;
      +
     @@ path-walk.h (new)
      +
      +#define PATH_WALK_INFO_INIT { 0 }
      +
     ++void path_walk_info_init(struct path_walk_info *info);
     ++void path_walk_info_clear(struct path_walk_info *info);
     ++
      +/**
      + * Given the configuration of 'info', walk the commits based on 'info->revs' and
      + * call 'info->path_fn' on each discovered path.
 2:  cf2ed61b324 = 2:  8ad2a5e79a2 test-lib-functions: add test_cmp_sorted
 3:  54886fcb081 = 3:  2bc0538bce9 t6601: add helper for testing path-walk API
 4:  42e71e6285f ! 4:  db5c8611230 path-walk: allow consumer to specify object types
     @@ Documentation/technical/api-path-walk.txt: It is also important that you do not
       
      
       ## path-walk.c ##
     -@@ path-walk.c: static int add_children(struct path_walk_context *ctx,
     +@@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
       		if (S_ISGITLINK(entry.mode))
       			continue;
       
     @@ path-walk.h: struct path_walk_info {
      +	.commits = 1,		\
      +}
       
     - /**
     -  * Given the configuration of 'info', walk the commits based on 'info->revs' and
     + void path_walk_info_init(struct path_walk_info *info);
     + void path_walk_info_clear(struct path_walk_info *info);
      
       ## t/helper/test-path-walk.c ##
      @@ t/helper/test-path-walk.c: static const char * const path_walk_usage[] = {
 5:  a41f53f7ced ! 5:  6df56f465d7 path-walk: visit tags and cached objects
     @@ path-walk.c
       
      +static const char *root_path = "";
      +
     - struct type_and_oid_list
     - {
     + struct type_and_oid_list {
       	enum object_type type;
     + 	struct oid_array oids;
      @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
       
       	list = strmap_get(&ctx->paths_to_lists, path);
     @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
       		ret = ctx->info->path_fn(path, &list->oids, list->type,
       					ctx->info->path_fn_data);
       
     -@@ path-walk.c: static void clear_strmap(struct strmap *map)
     +@@ path-walk.c: static void clear_paths_to_lists(struct strmap *map)
       	strmap_init(map);
       }
       
     -+static void setup_pending_objects(struct path_walk_info *info,
     -+				  struct path_walk_context *ctx)
     ++static int setup_pending_objects(struct path_walk_info *info,
     ++				 struct path_walk_context *ctx)
      +{
      +	struct type_and_oid_list *tags = NULL;
      +	struct type_and_oid_list *tagged_blobs = NULL;
     @@ path-walk.c: static void clear_strmap(struct strmap *map)
      +		/* Navigate annotated tag object chains. */
      +		while (obj->type == OBJ_TAG) {
      +			struct tag *tag = lookup_tag(info->revs->repo, &obj->oid);
     -+			if (!tag)
     -+				break;
     ++			if (!tag) {
     ++				error(_("failed to find tag %s"),
     ++				      oid_to_hex(&obj->oid));
     ++				return -1;
     ++			}
      +			if (tag->object.flags & SEEN)
      +				break;
      +			tag->object.flags |= SEEN;
     @@ path-walk.c: static void clear_strmap(struct strmap *map)
      +			free(tags);
      +		}
      +	}
     ++
     ++	return 0;
      +}
      +
       /**
        * Given the configuration of 'info', walk the commits based on 'info->revs' and
        * call 'info->path_fn' on each discovered path.
     -@@ path-walk.c: static void clear_strmap(struct strmap *map)
     +@@ path-walk.c: static void clear_paths_to_lists(struct strmap *map)
        */
       int walk_objects_by_path(struct path_walk_info *info)
       {
      -	const char *root_path = "";
     - 	int ret = 0;
     +-	int ret = 0;
     ++	int ret;
       	size_t commits_nr = 0, paths_nr = 0;
       	struct commit *c;
     + 	struct type_and_oid_list *root_tree_list;
      @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       	CALLOC_ARRAY(commit_list, 1);
       	commit_list->type = OBJ_COMMIT;
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      +	info->revs->blob_objects = info->revs->tree_objects = 0;
      +
      +	trace2_region_enter("path-walk", "pending-walk", info->revs->repo);
     -+	setup_pending_objects(info, &ctx);
     ++	ret = setup_pending_objects(info, &ctx);
      +	trace2_region_leave("path-walk", "pending-walk", info->revs->repo);
     ++
     ++	if (ret)
     ++		return ret;
      +
       	while ((c = get_revision(info->revs))) {
       		struct object_id *oid;
     @@ path-walk.h: struct path_walk_info {
      +	.tags = 1,		\
       }
       
     - /**
     + void path_walk_info_init(struct path_walk_info *info);
      
       ## t/helper/test-path-walk.c ##
      @@ t/helper/test-path-walk.c: struct path_walk_test_data {
 6:  0f1e6c51b2c ! 6:  f2ffc32a303 path-walk: mark trees and blobs as UNINTERESTING
     @@ path-walk.c
       #include "object.h"
       #include "oid-array.h"
       #include "revision.h"
     -@@ path-walk.c: struct type_and_oid_list
     - {
     +@@ path-walk.c: static const char *root_path = "";
     + struct type_and_oid_list {
       	enum object_type type;
       	struct oid_array oids;
      +	int maybe_interesting;
       };
       
       #define TYPE_AND_OID_LIST_INIT { \
     -@@ path-walk.c: static int add_children(struct path_walk_context *ctx,
     - 		if (o->flags & SEEN)
     - 			continue;
     - 		o->flags |= SEEN;
     +@@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
     + 			strmap_put(&ctx->paths_to_lists, path.buf, list);
     + 		}
     + 		push_to_stack(ctx, path.buf);
      +
      +		if (!(o->flags & UNINTERESTING))
      +			list->maybe_interesting = 1;
     ++
       		oid_array_append(&list->oids, &entry.oid);
       	}
       
     @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
       	/* Evaluate function pointer on this data, if requested. */
       	if ((list->type == OBJ_TREE && ctx->info->trees) ||
       	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
     -@@ path-walk.c: static void clear_strmap(struct strmap *map)
     +@@ path-walk.c: static void clear_paths_to_lists(struct strmap *map)
       	strmap_init(map);
       }
       
     @@ path-walk.c: static void clear_strmap(struct strmap *map)
      +	oid_array_append(&edge_tree_list->oids, &t->object.oid);
      +}
      +
     - static void setup_pending_objects(struct path_walk_info *info,
     - 				  struct path_walk_context *ctx)
     + static int setup_pending_objects(struct path_walk_info *info,
     + 				 struct path_walk_context *ctx)
       {
     -@@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       		if (tagged_blobs->oids.nr) {
       			const char *tagged_blob_path = "/tagged-blobs";
       			tagged_blobs->type = OBJ_BLOB;
     @@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
       			push_to_stack(ctx, tagged_blob_path);
       			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
       		} else {
     -@@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       		if (tags->oids.nr) {
       			const char *tag_path = "/tags";
       			tags->type = OBJ_TAG;
 7:  e716672c041 ! 7:  ef543429ed9 path-walk: reorder object visits
     @@ path-walk.c: static void push_to_stack(struct path_walk_context *ctx,
      +	prio_queue_put(&ctx->path_stack, xstrdup(path));
       }
       
     - static int add_children(struct path_walk_context *ctx,
     -@@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
     + static int add_tree_entries(struct path_walk_context *ctx,
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       			const char *tagged_blob_path = "/tagged-blobs";
       			tagged_blobs->type = OBJ_BLOB;
       			tagged_blobs->maybe_interesting = 1;
     @@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
       		} else {
       			oid_array_clear(&tagged_blobs->oids);
       			free(tagged_blobs);
     -@@ path-walk.c: static void setup_pending_objects(struct path_walk_info *info,
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       			const char *tag_path = "/tags";
       			tags->type = OBJ_TAG;
       			tags->maybe_interesting = 1;
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       			ret = walk_path(&ctx, path);
      @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
       
     - 	clear_strmap(&ctx.paths_to_lists);
     + 	clear_paths_to_lists(&ctx.paths_to_lists);
       	strset_clear(&ctx.path_stack_pushed);
      -	string_list_clear(&ctx.path_stack, 0);
      +	clear_prio_queue(&ctx.path_stack);
       	return ret;
       }
     + 
      
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_expect_success 'all' '
     @@ t/t6601-path-walk.sh: test_expect_success 'all' '
       	commits:4
       	tags:7
      @@ t/t6601-path-walk.sh: test_expect_success 'branches and indexed objects mix well' '
     + 	1:tree::$(git rev-parse base^{tree})
       	1:tree::$(git rev-parse base~1^{tree})
       	1:tree::$(git rev-parse base~2^{tree})
     - 	2:blob:a:$(git rev-parse base~2:a)
     +-	2:blob:a:$(git rev-parse base~2:a)
      -	3:tree:right/:$(git rev-parse topic:right)
      -	3:tree:right/:$(git rev-parse base~1:right)
      -	3:tree:right/:$(git rev-parse base~2:right)
     @@ t/t6601-path-walk.sh: test_expect_success 'branches and indexed objects mix well
      -	7:blob:left/b:$(git rev-parse base:left/b)
      -	7:blob:left/b:$(git rev-parse base~2:left/b)
      -	8:tree:a/:$(git rev-parse refs/tags/third:a)
     -+	3:tree:a/:$(git rev-parse refs/tags/third:a)
     -+	4:tree:left/:$(git rev-parse base:left)
     -+	4:tree:left/:$(git rev-parse base~2:left)
     -+	5:blob:left/b:$(git rev-parse base:left/b)
     -+	5:blob:left/b:$(git rev-parse base~2:left/b)
     -+	6:tree:right/:$(git rev-parse topic:right)
     -+	6:tree:right/:$(git rev-parse base~1:right)
     -+	6:tree:right/:$(git rev-parse base~2:right)
     -+	7:blob:right/c:$(git rev-parse base~2:right/c)
     -+	7:blob:right/c:$(git rev-parse topic:right/c)
     -+	8:blob:right/d:$(git rev-parse base~1:right/d)
     -+	8:blob:right/d:$(git rev-parse :right/d)
     ++	2:tree:a/:$(git rev-parse refs/tags/third:a)
     ++	3:tree:left/:$(git rev-parse base:left)
     ++	3:tree:left/:$(git rev-parse base~2:left)
     ++	4:blob:left/b:$(git rev-parse base:left/b)
     ++	4:blob:left/b:$(git rev-parse base~2:left/b)
     ++	5:tree:right/:$(git rev-parse topic:right)
     ++	5:tree:right/:$(git rev-parse base~1:right)
     ++	5:tree:right/:$(git rev-parse base~2:right)
     ++	6:blob:right/c:$(git rev-parse base~2:right/c)
     ++	6:blob:right/c:$(git rev-parse topic:right/c)
     ++	7:blob:right/d:$(git rev-parse base~1:right/d)
     ++	7:blob:right/d:$(git rev-parse :right/d)
     ++	8:blob:a:$(git rev-parse base~2:a)
       	blobs:7
       	commits:4
       	tags:0

-- 
gitgitgadget
