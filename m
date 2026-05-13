Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207652FF147
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707141; cv=none; b=bp22Co5ZA2+LKrJz6TeHkNByq8o3b3rwK3cbMryG8wvgH3JgtKGUJqEs2SMxogUH4wtXhdQ28u6ZqG5r3I6wDvLZBeP2NHregzVvfX1jBajTAtlbuKsUaoHl7P8TBy00uTqVF7DesBjy88cMaB+lHITk6gUx59c4Iy+Xg5NUPq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707141; c=relaxed/simple;
	bh=8W5pOPh2KnihskEUmtjWoMxRP1xneKAHc86paXulCpY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j/wzulT0/N7uSN5j5sSonUzecv35dYIUz0HTDQmkVOtdFi19m25l6XenUFNNxbaBmppkXOD9KVkJx1arArd4ECqc4rVR4gPxIy248sSoUUe/0DeQc1OWQPWngsgATZdpCeAQpgkK1RhGbvcHaeL+NiC/8GWyQkJO2E+9XU/w4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2R5VJGx; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2R5VJGx"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c1a170a50so10178490c88.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707138; x=1779311938; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzypCXEwHgZSitI8le2+59lUfJsyl8YDLMdpZewab9w=;
        b=i2R5VJGxHroYkO2g9IkA2EOWwos0grJA8n3xHoM4Iwpkd1CzGsb0Tj5rPNXj4y5KlC
         OheyvpNeJlLhQosXh5n90D4fITUn6/8Z8t4BSNhCipwXk19bqs+uN7w5xz6f7apvz6yc
         8FTdqNK6acA1Q1LPVM3jAGlb8nsI9gwETKQCm6XaXsu1XRXr+znApJQ37Y0a454wVB9C
         c8hOWTnyVockHYxU0OzwMvtEXO0X/KjbswHTr2mCJq3hS54a3xL+PsBKEPXRgT8v0bo7
         9ojYygFZx6gb1GoGMRD4/0kc4IFACRoKLXa2q60XVBtUuACue3RFsQdvLQ4oCtkjOZ/m
         ZUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707138; x=1779311938;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzypCXEwHgZSitI8le2+59lUfJsyl8YDLMdpZewab9w=;
        b=XIDNIEIxkQs15moCoyV8sG9nf2yWRCMUae2jWGV0vl+H9TfqoP81ZBL8v36hn/gOOR
         BkrTl3b6qigFdmYyGBK7Qd+dhKEGo8wiOde+J4/HChTqoaCmh3ijvU432FOcXWJcXYLl
         CaUfcU8pr1rAIppbkoTGYIzz2PYF3hWfJUoSnmUXJS1oe0fs0cVzM6iqUhSOpnTAiuaH
         Y0FfK9JgTQtq4JMvv5Fp+OQMpQNOZXDNYwhMOs2rfOmwOJCTAudc0GOdI7JN27P60a0i
         g0niGz9eO3/O0SQECbqeAySTzmV3Ozi6Dz6YO02gmA1lqY1Urvd1ySwVJ0RqR7ZnNkk6
         8oaQ==
X-Gm-Message-State: AOJu0Yzz/HPkw2W/kxc1sfePuWxf+kyc1SoQdUGhd4xVR31KfiyWR9QR
	VT8o0naRFAE/V2//RYPVoN4CNpGe1jKWn0VBjSnWlrVpVNzqlYsF4yxY7iYCAQ==
X-Gm-Gg: Acq92OFfYExa6+fR9bNxi0qIeC6smCdjclLyde/ImrIq/EyZZRmWbTzlqgX62ABxQUJ
	XX/euFV3+cYx5lZcIUsgMZ/NNdlWIojfWXMEJiACGM+xxL/KQdPcTWjivuGnqMykrw+F8CmsLma
	fmJcc1oNUX9AUs47O+ZB/IrnQyxljOxPnxMs3WwOrxFbyBG+lga+8PUUzBed+knERMUbHXAvtWI
	JQ7Gx3/u+BIAhQdBsBD4QUIAP8HUACauPTcM+D+DrewCzB6towP5kJK8DZ+e7zCvl3wlGHc7pVA
	2YKDMdehJFyZyrLkXYEbm0nfcfmwa2/idOsvAjD+gApPDajh2mMvG/aUbWEwxaXEZXruKVincgN
	ovlf3FPDyC4h1YKBbnJRdEH+b3Y9y/vrZwpMPUoE5thIQL6HTIVckX+UtAO40f8K356aiBTNZ5L
	MO3fBEjaPGrFA5D5pQdRo13PKaREtPJlVWKe17
X-Received: by 2002:a05:7022:689c:b0:12d:de3f:f3e4 with SMTP id a92af1059eb24-1349ad94174mr2721448c88.36.1778707137177;
        Wed, 13 May 2026 14:18:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm1025320c88.9.2026.05.13.14.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:18:56 -0700 (PDT)
Message-Id: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:42 +0000
Subject: [PATCH v4 00/13] pack-objects: integrate --path-walk and some --filter options
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
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>

NOTE: This series is based on en/backfill-fixes-and-edges.

The 'git pack-objects' command has a '--path-walk' option that uses the
path-walk API instead of a typical revision walk to group objects into
chunks by path name instead of relying solely on name-hashes to group
similar files together. (It also does a second compression pass looking for
better deltas after the first pass that is focused within chunks per path.)

The '--path-walk' feature was not previously integrated with the '--filter'
feature, so a warning would appear and disable the path-walk API when a
filter is given. This patch series integrates these together in the
following ways:

 * --filter=blob:none updates the path-walk API options to skip blobs.
 * --filter=blob:limit=<size> adds a scan to a list of blob objects to
   remove objects that are too large.
 * --filter=sparse:<oid> adds a scan to the chunks to validate that the
   paths match the sparse-checkout patterns.

In particular, this last check is significantly faster than the previous
algorithm because it can check all objects at a given path simultaneously
instead of checking all sparse-checkout patterns for each discovered blob
object.

A subtlety must be added here, in that we must change how we mark an object
as "seen" during the path-walk. We may need to add an object to multiple
paths and only mark it as "seen" if it indeed matched the sparse-checkout
patterns as the path is accepted for emitting to the callback. This adds a
new filter that the "seen" objects must also be removed from later chunks to
avoid sending the same object as grouped to multiple chunks.

There's also a subtle detail here in that the path-walk API also prunes tree
paths based on cone-mode sparse-checkouts, to enable 'git backfill --sparse'
operating quickly for small sparse-checkout scopes. But the
--filter=sparse:<oid> feature doesn't prune trees!

As a future step, I do plan to recommend that we add a treesparse:<oid>
setting that does allow us to trim the tree set by cone-mode sparse
patterns. At the time that partial clone filters were being created, cone
mode sparse-checkout didn't exist and neither did the sparse index. Those
features together make a smaller tree set possible, assuming the user never
needs to change their scope. This would be a significant change so it is not
implemented here, though the git pack-objects integration would be quick
after this series completes.

Neither the sparse:<oid> or hypothetical treesparse:<oid> options are or
should necessarily be supported by Git servers. It's too expensive to
compute dynamically and it doesn't work well with reachability bitmaps. What
becomes possible with this change is that it becomes reasonably fast to
construct bundles with these filters that can bootstrap a working
environment with the full history of all files within a given
sparse-checkout scope.


Performance Results
===================

Since the '--path-walk' option is ignored in today's Git version when a
'--filter' is added, the performance matches the behavior without
'--path-walk'. For the tables below, you can compare the rows against each
other (time and then packfile size) for the mode without and then with
'--path-walk' as a representation of "before" and "after". (These tables are
repeated in the commit messages as new implementations improve specific
rows.)

I chose a number of open source repositories of various sizes and shapes:


git/git
=======

Test                                              HEAD
-------------------------------------------------------------------
5315.2: repack (no filter)                       27.73
5315.3: repack size (no filter)                 250.6M
5315.4: repack (no filter, --path-walk)          35.19
5315.5: repack size (no filter, --path-walk)    220.1M
5315.6: repack (blob:none)                       13.42
5315.7: repack size (blob:none)                 137.6M
5315.8: repack (blob:none, --path-walk)          20.98
5315.9: repack size (blob:none, --path-walk)    115.2M
5315.10: repack (sparse:oid)                     72.53
5315.11: repack size (sparse:oid)               187.5M
5315.12: repack (sparse:oid, --path-walk)        29.00
5315.13: repack size (sparse:oid, --path-walk)  161.0M



nodejs/node
===========

Test                                              HEAD
--------------------------------------------------------------------
5315.2: repack (no filter)                       75.53
5315.3: repack size (no filter)                   0.9G
5315.4: repack (no filter, --path-walk)          80.54
5315.5: repack size (no filter, --path-walk)    885.7M
5315.6: repack (blob:none)                       12.65
5315.7: repack size (blob:none)                 148.6M
5315.8: repack (blob:none, --path-walk)          17.60
5315.9: repack size (blob:none, --path-walk)    134.6M
5315.10: repack (sparse:oid)                    518.84
5315.11: repack size (sparse:oid)               153.4M
5315.12: repack (sparse:oid, --path-walk)        27.99
5315.13: repack size (sparse:oid, --path-walk)  139.4M



microsoft/fluentui
==================

Test                                              HEAD
--------------------------------------------------------------------
5315.2: repack (no filter)                      146.77
5315.3: repack size (no filter)                 562.1M
5315.4: repack (no filter, --path-walk)          72.82
5315.5: repack size (no filter, --path-walk)    172.6M
5315.6: repack (blob:none)                        4.84
5315.7: repack size (blob:none)                  62.7M
5315.8: repack (blob:none, --path-walk)           5.19
5315.9: repack size (blob:none, --path-walk)     59.9M
5315.10: repack (sparse:oid)                     59.95
5315.11: repack size (sparse:oid)                85.6M
5315.12: repack (sparse:oid, --path-walk)        15.16
5315.13: repack size (sparse:oid, --path-walk)   72.5M



microsoftdocs/azure-devops-docs
===============================

Test                                               HEAD
---------------------------------------------------------------------
5315.2: repack (no filter)                        4.41
5315.3: repack size (no filter)                   1.6G
5315.4: repack (no filter, --path-walk)           6.00
5315.5: repack size (no filter, --path-walk)      1.6G
5315.6: repack (blob:none)                        1.35
5315.7: repack size (blob:none)                  60.0M
5315.8: repack (blob:none, --path-walk)           1.23
5315.9: repack size (blob:none, --path-walk)     60.0M
5315.10: repack (sparse:oid)                    138.24
5315.11: repack size (sparse:oid)                84.4M
5315.12: repack (sparse:oid, --path-walk)         1.86
5315.13: repack size (sparse:oid, --path-walk)   84.4M



Performance conclusions
=======================

As seen in earlier series around the '--path-walk' feature, the space
savings can be valuable but is not always guaranteed. When the space savings
doesn't happen, then the time spent is generally slower because of the
two-pass mechanism. The microsoftdocs/azure-devops-docs repo demonstrates
this case quite clearly.

However, even in these cases the 'sparse:<oid>' filters are much faster
because of the ability to check an entire set of objects against the
sparse-checkout patterns only once.

Thanks, -Stolee


UPDATES IN V2
=============

 * Rebased onto en/backfill-fixes-and-edges to properly integrate with the
   incompatible rev-list options logic in that series.
 * Updated documentation as behavior changes. Credit to Taylor Blau for
   presenting these suggestions in his RFC [2].
 * Added three patches of Taylor's to extend more filter options.


UPDATES IN V3
=============

Upon realizing that the tests were not passing with
GIT_TEST_PACK_PATH_WALK=1, I spent a lot of time reworking each patch to
pass all tests with that variable enabled. This led to a lot of meaningful
changes:

 * A new patch updates t5620-backfill.sh because they are currently failing
   due to a check for quiet stderr checks. These changes are reverted later
   when the filters are integrated so the warning stops being written.
 * I move the logic for the path-walk API emitting "directly requested"
   objects (non-commits in the 'pending' list). This is substantial enough
   to be its own patch.
 * The filtering logic is pulled entirely within the path-walk API instead
   of needing integration within builtin/pack-objects.c.
 * The tree:0 filter had a lot to be desired when fetching missing objects,
   so is substantially updated.
 * The object-type filter requires a change to the typical direct-request
   behavior, including a new 'strict_types' member that prevents ever
   allowing objects against type.
 * The combine filter needed better logic around multiple blob size limits,
   to take the smaller of the two.
 * The t6601-path-walk.sh script has many test updates to better reflect the
   new behavior, as required by the other partial clone tests under
   GIT_TEST_PACK_PATH_WALK=1.
 * Doc updates for 'form' to 'forms' when multiple forms are supported.

I've also updated Taylor's bitmap-related patches into three commits on top
of this series (see [3]).


UPDATES IN V4
=============

Thanks, Taylor for the careful review.

 * Several typos are fixed.
 * The performance test is corrected for issues around piping Git commands
   and made more robust to the existence of submodules.
 * BIG: The tree:0 patch is significantly updated in this version. Taylor
   correctly smelled a problem with the new logic to emit the /tagged-trees
   object set, and that signaled that those trees were previously never
   emitted. I update the test to demonstrate that changing the data shape
   (including tagged trees that are otherwise-unreachable) doesn't change
   the test behavior, signaling a bug. The behavior change details all the
   complexities of visiting only directly-requested trees under a tree:0
   filter and recursing on all trees in other cases.

P.S. I've CC'd the folks who were on the original path-walk feature thread
[1]

[1]
https://lore.kernel.org/git/pull.1819.git.1741571455.gitgitgadget@gmail.com/

[2] https://lore.kernel.org/git/cover.1777853408.git.me@ttaylorr.com/

[3]
https://github.com/derrickstolee/git/compare/path-walk-filters...derrickstolee:git:path-walk-bitmaps

Derrick Stolee (10):
  t5620: make test work with path-walk var
  pack-objects: pass --objects with --path-walk
  t/perf: add pack-objects filter and path-walk benchmark
  path-walk: always emit directly-requested objects
  path-walk: support blobless filter
  backfill: die on incompatible filter options
  path-walk: support blob size limit filter
  path-walk: add pl_sparse_trees to control tree pruning
  pack-objects: support sparse:oid filter with path-walk
  t6601: tag otherwise-unreachable trees

Taylor Blau (3):
  path-walk: support `tree:0` filter
  path-walk: support `object:type` filter
  path-walk: support `combine` filter

 Documentation/git-backfill.adoc            |   4 +
 Documentation/git-pack-objects.adoc        |   8 +-
 Documentation/technical/api-path-walk.adoc |   7 +
 builtin/backfill.c                         |   8 +-
 builtin/pack-objects.c                     |  23 +-
 path-walk.c                                | 270 ++++++++--
 path-walk.h                                |  31 ++
 t/helper/test-path-walk.c                  |  17 +-
 t/perf/p5315-pack-objects-filter.sh        | 131 +++++
 t/t5317-pack-objects-filter-objects.sh     | 125 +++++
 t/t5620-backfill.sh                        |   8 +
 t/t6601-path-walk.sh                       | 572 +++++++++++++++++++--
 12 files changed, 1126 insertions(+), 78 deletions(-)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh


base-commit: a1ad4a0fca14cdeb55ab9fb065551b15cafa8a4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2101%2Fderrickstolee%2Fpath-walk-filters-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2101/derrickstolee/path-walk-filters-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2101

Range-diff vs v3:

  1:  0840110116 =  1:  0840110116 t5620: make test work with path-walk var
  2:  5cc6383380 !  2:  d7c87545f3 pack-objects: pass --objects with --path-walk
     @@ Commit message
          pack-objects: pass --objects with --path-walk
      
          When 'git pack-objects' has the --path-walk option enabled, it uses a
     -    different set of revision walk parameters than normal. For once,
     -    --objects was previously assumed by the path-walk API and was not needed
     -    to be added. We also needed --boundary to allow discovering
     -    UNINTERESTING objects to use as delta bases.
     +    different set of revision walk parameters than normal. For one,
     +    --objects was previously assumed by the path-walk API and could be
     +    omitted. We also needed --boundary to allow discovering UNINTERESTING
     +    objects to use as delta bases.
      
          We will be updating the path-walk API soon to work with some filter
          options. However, the revision machinery will trigger a fatal error:
  3:  77329cf8f4 !  3:  fb8a0f9c43 t/perf: add pack-objects filter and path-walk benchmark
     @@ t/perf/p5315-pack-objects-filter.sh (new)
      +	# directories at evenly-spaced positions so the choice is stable
      +	# and scales to repos of any shape.
      +
     -+	git ls-tree -d --name-only HEAD >top-dirs &&
     ++	git ls-tree -d HEAD >top-entries &&
     ++	grep "^040000" top-entries |
     ++		awk "{print \$4;}" >top-dirs &&
      +	top_nr=$(wc -l <top-dirs) &&
      +
      +	>depth2-dirs &&
      +	while read tdir
      +	do
     -+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null |
     -+		sed "s|^|$tdir/|" >>depth2-dirs || return 1
     -+	done <top-dirs &&
     ++		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
     ++	done <top-dirs >depth2-dirs.raw &&
     ++	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&
      +
      +	d2_nr=$(wc -l <depth2-dirs) &&
      +
  4:  50933cccf5 !  4:  e77c8a6bbc path-walk: always emit directly-requested objects
     @@ path-walk.c: static int add_tree_entries(struct path_walk_context *ctx,
      + */
      +static int path_is_for_direct_objects(const char *path)
      +{
     ++	ASSERT(path);
      +	return path[0] == '/';
      +}
      +
  5:  b2deb7f819 !  5:  f4904f81e0 path-walk: support blobless filter
     @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1
      -`--use-bitmap-index` option will be ignored in the presence of
      -`--path-walk.`
      +Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     -+ignored in the presence of `--path-walk`. Whe `--path-walk` option
     ++ignored in the presence of `--path-walk`. The `--path-walk` option
      +supports the `--filter=<spec>` form `blob:none`.
       
       
  6:  da191e29e6 =  6:  f37467e46f backfill: die on incompatible filter options
  7:  a1ab70405d !  7:  133c1b156c path-walk: support blob size limit filter
     @@ Documentation/git-pack-objects.adoc
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       +
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     - ignored in the presence of `--path-walk`. Whe `--path-walk` option
     + ignored in the presence of `--path-walk`. The `--path-walk` option
      -supports the `--filter=<spec>` form `blob:none`.
      +supports the `--filter=<spec>` forms `blob:none` and `blob:limit=<n>`.
       
  8:  2360a5be81 =  8:  0f517be8e3 path-walk: add pl_sparse_trees to control tree pruning
  9:  d9f5a98830 !  9:  b4dc09ab69 pack-objects: support sparse:oid filter with path-walk
     @@ Documentation/git-pack-objects.adoc
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       +
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     - ignored in the presence of `--path-walk`. Whe `--path-walk` option
     + ignored in the presence of `--path-walk`. The `--path-walk` option
      -supports the `--filter=<spec>` forms `blob:none` and `blob:limit=<n>`.
      +supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
      +`sparse:<oid>`.
  -:  ---------- > 10:  0b1eed0790 t6601: tag otherwise-unreachable trees
 10:  c9efff0ea8 ! 11:  b23244c4c2 path-walk: support `tree:0` filter
     @@ Commit message
          at all under `tree:0`, which matches the intended behavior of the
          filter.
      
     +    However, this requires first fixing some issues with how the path-walk
     +    API handles directly-requested trees _and_ trees requested through
     +    lightweight tags. These changes create substantial updates to
     +    t6601-path-walk.sh, which the previous change highlighted as a problem
     +    by tagging otherwise-unreachable trees and having them not appear in the
     +    output.
     +
          Non-zero tree-depth filters are not supported. Those depend on the depth
          at which a tree is visited, which is a path-walk concept the filter
          machinery doesn't currently share with the path-walk API. Reject them in
     @@ Documentation/git-pack-objects.adoc
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       +
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     - ignored in the presence of `--path-walk`. Whe `--path-walk` option
     + ignored in the presence of `--path-walk`. The `--path-walk` option
      -supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
      -`sparse:<oid>`.
      +supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
     @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
       
      -	/* Expand data for children. */
      -	if (list->type == OBJ_TREE) {
     -+	/* Expand data for children, unless this is a direct-object path. */
     -+	if (list->type == OBJ_TREE && !path_is_for_direct_objects(path)) {
     ++	/*
     ++	 * Expand tree children, except when the set is directly requested
     ++	 * _and_ we are otherwise filtering out trees.
     ++	 */
     ++	if (list->type == OBJ_TREE &&
     ++	    (!path_is_for_direct_objects(path) || ctx->info->trees)) {
     ++		/* Use root path if expanding from tagged/direct trees. */
     ++		const char *expand_path = !strcmp(path, "/tagged-trees")
     ++					  ? root_path : path;
       		for (size_t i = 0; i < list->oids.nr; i++) {
       			ret |= add_tree_entries(ctx,
     - 					    path,
     +-					    path,
     ++					    expand_path,
     + 					    &list->oids.oid[i]);
     + 		}
     + 	}
      @@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       {
       	struct type_and_oid_list *tags = NULL;
       	struct type_and_oid_list *tagged_blobs = NULL;
     +-	struct type_and_oid_list *root_tree_list = NULL;
      +	struct type_and_oid_list *tagged_trees = NULL;
     - 	struct type_and_oid_list *root_tree_list = NULL;
       
       	if (info->tags)
       		CALLOC_ARRAY(tags, 1);
       	CALLOC_ARRAY(tagged_blobs, 1);
     -+	if (!info->trees)
     -+		CALLOC_ARRAY(tagged_trees, 1);
     - 	root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
     +-	root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
     ++	CALLOC_ARRAY(tagged_trees, 1);
       
       	/*
     + 	 * Pending objects include:
      @@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       
       		switch (obj->type) {
       		case OBJ_TREE:
      -			if (pending->path) {
     -+			if (tagged_trees) {
     -+				/*
     -+				 * Trees are disabled but pending trees
     -+				 * should still be emitted. Collect them
     -+				 * into a "/tagged-trees" list that
     -+				 * bypasses the object type filter.
     -+				 */
     -+				oid_array_append(&tagged_trees->oids, &obj->oid);
     -+			} else if (pending->path) {
     - 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
     - 							    : xstrdup("");
     +-				char *path = *pending->path ? xstrfmt("%s/", pending->path)
     +-							    : xstrdup("");
     ++			if (pending->path && *pending->path) {
     ++				char *path = xstrfmt("%s/", pending->path);
       				add_path_to_list(ctx, path, OBJ_TREE, &obj->oid, 1);
     + 				free(path);
     ++			} else if (!pending->path || !info->trees) {
     ++				oid_array_append(&tagged_trees->oids, &obj->oid);
     + 			} else {
     +-				/* assume a root tree, such as a lightweight tag. */
     +-				oid_array_append(&root_tree_list->oids, &obj->oid);
     ++				add_path_to_list(ctx, root_path, OBJ_TREE,
     ++						 &obj->oid, 1);
     + 			}
     + 			break;
     + 
      @@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       			free(tagged_blobs);
       		}
     @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       			struct object_id sparse_oid;
      
       ## t/t6601-path-walk.sh ##
     +@@ t/t6601-path-walk.sh: test_expect_success 'all' '
     + 	3:tree::$(git rev-parse base^{tree})
     + 	3:tree::$(git rev-parse base~1^{tree})
     + 	3:tree::$(git rev-parse base~2^{tree})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     + 	4:blob:a:$(git rev-parse base~2:a)
     +-	5:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     +-	6:tree:a/:$(git rev-parse base:a)
     +-	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     +-	8:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
     +-	9:tree:left/:$(git rev-parse base:left)
     +-	9:tree:left/:$(git rev-parse base~2:left)
     +-	10:blob:left/b:$(git rev-parse base~2:left/b)
     +-	10:blob:left/b:$(git rev-parse base:left/b)
     +-	11:tree:right/:$(git rev-parse topic:right)
     +-	11:tree:right/:$(git rev-parse base~1:right)
     +-	11:tree:right/:$(git rev-parse base~2:right)
     +-	12:blob:right/c:$(git rev-parse base~2:right/c)
     +-	12:blob:right/c:$(git rev-parse topic:right/c)
     +-	13:blob:right/d:$(git rev-parse base~1:right/d)
     ++	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
     ++	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
     ++	6:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     ++	7:tree:a/:$(git rev-parse base:a)
     ++	8:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	9:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
     ++	10:tree:left/:$(git rev-parse base:left)
     ++	10:tree:left/:$(git rev-parse base~2:left)
     ++	11:blob:left/b:$(git rev-parse base~2:left/b)
     ++	11:blob:left/b:$(git rev-parse base:left/b)
     ++	12:tree:right/:$(git rev-parse topic:right)
     ++	12:tree:right/:$(git rev-parse base~1:right)
     ++	12:tree:right/:$(git rev-parse base~2:right)
     ++	13:blob:right/c:$(git rev-parse base~2:right/c)
     ++	13:blob:right/c:$(git rev-parse topic:right/c)
     ++	14:blob:right/d:$(git rev-parse base~1:right/d)
     + 	blobs:10
     + 	commits:4
     + 	tags:7
     +@@ t/t6601-path-walk.sh: test_expect_success 'all, blob:none filter' '
     + 	3:tree::$(git rev-parse base^{tree})
     + 	3:tree::$(git rev-parse base~1^{tree})
     + 	3:tree::$(git rev-parse base~2^{tree})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     +-	4:tree:a/:$(git rev-parse base:a)
     +-	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     +-	6:tree:left/:$(git rev-parse base:left)
     +-	6:tree:left/:$(git rev-parse base~2:left)
     +-	7:tree:right/:$(git rev-parse topic:right)
     +-	7:tree:right/:$(git rev-parse base~1:right)
     +-	7:tree:right/:$(git rev-parse base~2:right)
     ++	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
     ++	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
     ++	5:tree:a/:$(git rev-parse base:a)
     ++	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	7:tree:left/:$(git rev-parse base:left)
     ++	7:tree:left/:$(git rev-parse base~2:left)
     ++	8:tree:right/:$(git rev-parse topic:right)
     ++	8:tree:right/:$(git rev-parse base~1:right)
     ++	8:tree:right/:$(git rev-parse base~2:right)
     + 	blobs:2
     + 	commits:4
     + 	tags:7
     +@@ t/t6601-path-walk.sh: test_expect_success 'all, blob:limit=0 filter' '
     + 	3:tree::$(git rev-parse base^{tree})
     + 	3:tree::$(git rev-parse base~1^{tree})
     + 	3:tree::$(git rev-parse base~2^{tree})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     +-	4:tree:a/:$(git rev-parse base:a)
     +-	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     +-	6:tree:left/:$(git rev-parse base:left)
     +-	6:tree:left/:$(git rev-parse base~2:left)
     +-	7:tree:right/:$(git rev-parse topic:right)
     +-	7:tree:right/:$(git rev-parse base~1:right)
     +-	7:tree:right/:$(git rev-parse base~2:right)
     ++	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
     ++	4:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
     ++	5:tree:a/:$(git rev-parse base:a)
     ++	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	7:tree:left/:$(git rev-parse base:left)
     ++	7:tree:left/:$(git rev-parse base~2:left)
     ++	8:tree:right/:$(git rev-parse topic:right)
     ++	8:tree:right/:$(git rev-parse base~1:right)
     ++	8:tree:right/:$(git rev-parse base~2:right)
     + 	blobs:2
     + 	commits:4
     + 	tags:7
     +@@ t/t6601-path-walk.sh: test_expect_success 'all, blob:limit=3 filter' '
     + 	3:tree::$(git rev-parse base^{tree})
     + 	3:tree::$(git rev-parse base~1^{tree})
     + 	3:tree::$(git rev-parse base~2^{tree})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     + 	4:blob:a:$(git rev-parse base~2:a)
     +-	5:tree:a/:$(git rev-parse base:a)
     +-	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     +-	7:tree:left/:$(git rev-parse base:left)
     +-	7:tree:left/:$(git rev-parse base~2:left)
     +-	8:blob:left/b:$(git rev-parse base~2:left/b)
     +-	9:tree:right/:$(git rev-parse topic:right)
     +-	9:tree:right/:$(git rev-parse base~1:right)
     +-	9:tree:right/:$(git rev-parse base~2:right)
     +-	10:blob:right/c:$(git rev-parse base~2:right/c)
     +-	11:blob:right/d:$(git rev-parse base~1:right/d)
     ++	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
     ++	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
     ++	6:tree:a/:$(git rev-parse base:a)
     ++	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	8:tree:left/:$(git rev-parse base:left)
     ++	8:tree:left/:$(git rev-parse base~2:left)
     ++	9:blob:left/b:$(git rev-parse base~2:left/b)
     ++	10:tree:right/:$(git rev-parse topic:right)
     ++	10:tree:right/:$(git rev-parse base~1:right)
     ++	10:tree:right/:$(git rev-parse base~2:right)
     ++	11:blob:right/c:$(git rev-parse base~2:right/c)
     ++	12:blob:right/d:$(git rev-parse base~1:right/d)
     + 	blobs:6
     + 	commits:4
     + 	tags:7
      @@ t/t6601-path-walk.sh: test_expect_success 'all, blob:limit=3 filter' '
       	test_cmp_sorted expect out
       '
     @@ t/t6601-path-walk.sh: test_expect_success 'all, blob:limit=3 filter' '
       test_expect_success 'setup sparse filter blob' '
       	# Cone-mode patterns: include root, exclude all dirs, include left/
       	cat >patterns <<-\EOF &&
     +@@ t/t6601-path-walk.sh: test_expect_success 'all, sparse:oid filter' '
     + 	3:tree::$(git rev-parse base^{tree})
     + 	3:tree::$(git rev-parse base~1^{tree})
     + 	3:tree::$(git rev-parse base~2^{tree})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     +-	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     + 	4:blob:a:$(git rev-parse base~2:a)
     +-	5:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     +-	6:tree:a/:$(git rev-parse base:a)
     +-	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     +-	8:tree:left/:$(git rev-parse base:left)
     +-	8:tree:left/:$(git rev-parse base~2:left)
     +-	9:blob:left/b:$(git rev-parse base~2:left/b)
     +-	9:blob:left/b:$(git rev-parse base:left/b)
     +-	10:tree:right/:$(git rev-parse topic:right)
     +-	10:tree:right/:$(git rev-parse base~1:right)
     +-	10:tree:right/:$(git rev-parse base~2:right)
     ++	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
     ++	5:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
     ++	6:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     ++	7:tree:a/:$(git rev-parse base:a)
     ++	8:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	9:tree:left/:$(git rev-parse base:left)
     ++	9:tree:left/:$(git rev-parse base~2:left)
     ++	10:blob:left/b:$(git rev-parse base~2:left/b)
     ++	10:blob:left/b:$(git rev-parse base:left/b)
     ++	11:tree:right/:$(git rev-parse topic:right)
     ++	11:tree:right/:$(git rev-parse base~1:right)
     ++	11:tree:right/:$(git rev-parse base~2:right)
     + 	blobs:6
     + 	commits:4
     + 	tags:7
 11:  b221ea4712 ! 12:  7e1e503361 path-walk: support `object:type` filter
     @@ Commit message
       ## Documentation/git-pack-objects.adoc ##
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     - ignored in the presence of `--path-walk`. Whe `--path-walk` option
     + ignored in the presence of `--path-walk`. The `--path-walk` option
       supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
      -`tree:0`, and `sparse:<oid>`.
      +`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
     @@ t/t6601-path-walk.sh: test_expect_success 'tree:1 filter is rejected' '
      +	0:tree::$(git rev-parse base^{tree})
      +	0:tree::$(git rev-parse base~1^{tree})
      +	0:tree::$(git rev-parse base~2^{tree})
     -+	0:tree::$(git rev-parse refs/tags/tree-tag^{})
     -+	0:tree::$(git rev-parse refs/tags/tree-tag2^{})
     -+	1:tree:a/:$(git rev-parse base:a)
     -+	2:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     -+	3:tree:left/:$(git rev-parse base:left)
     -+	3:tree:left/:$(git rev-parse base~2:left)
     -+	4:tree:right/:$(git rev-parse topic:right)
     -+	4:tree:right/:$(git rev-parse base~1:right)
     -+	4:tree:right/:$(git rev-parse base~2:right)
     ++	1:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
     ++	1:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
     ++	2:tree:a/:$(git rev-parse base:a)
     ++	3:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	4:tree:left/:$(git rev-parse base:left)
     ++	4:tree:left/:$(git rev-parse base~2:left)
     ++	5:tree:right/:$(git rev-parse topic:right)
     ++	5:tree:right/:$(git rev-parse base~1:right)
     ++	5:tree:right/:$(git rev-parse base~2:right)
      +	blobs:0
      +	commits:0
      +	tags:0
 12:  16bd3c3161 ! 13:  a615b1a707 path-walk: support `combine` filter
     @@ Commit message
       ## Documentation/git-pack-objects.adoc ##
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     - ignored in the presence of `--path-walk`. Whe `--path-walk` option
     + ignored in the presence of `--path-walk`. The `--path-walk` option
       supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
      -`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
      +`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter

-- 
gitgitgadget
