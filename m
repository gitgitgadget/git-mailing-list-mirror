Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6230E853
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926085; cv=none; b=HbvagC5kvXY2IUvMF/4Quu+/KVSQB0IIxuuCzdIXpE5LSmVHnVzVr5MzKGsn5DYYC2DKwrNgmKiYJiPk8sXh9ZOGrVIXjBNEeUyU6J0m9/tP/ExqawlRrDYiZ+oyoeJJ7R8ZjqqGAgh9y+CbNskYm+J+doP/5kr5CHm1MhQT/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926085; c=relaxed/simple;
	bh=oKemrpH4nuZHCv3PYMlBiA5pfb32ZyRNDIeCARCy8l0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qkgalgYYYxNC/tQBveaQyjM69BK6/KLdDDFv8x5N6UMr/lFySxYtC+ENzbzihs/ZvjFncOXxByaOPuXWyZTX7A8sG21OOxdAiAdxRwPF715e+Mc6DqTcgx6w5lpy9GWgtmXXaLceNPNsAjR2HR7B+z4NtLAfxTLZeot99xa25CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFLKJrxs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFLKJrxs"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d560ede296so488561285a.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926081; x=1778530881; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImjDzvS2UskSas/z+0vPywvM5LQTiydtU8xeyByBcmg=;
        b=kFLKJrxsKZksFWqXatIoJ2FsPZUCZIghDu9KZC4NFGPWJUb3fpl1AfKuO2NUvhz/Rf
         Epho40fGzjesrk4wKS4dEZXPoQ3awVXq+La/eV05b5Ikmre0NPM8UBc0MQ4ZB5OxceCU
         6qgKkJ/KRmXWx6jMLDULCG0jz8L0HdiWMpIJkwzfV+QTC5C0EEzPHbl4dUJqBsBVIIcj
         fx9lIxdaNScuv/K91wtVkAs2Qb7EM4KIYPSP6TmMzaTFHDpJCZ3/TPnoVoPCEeAC3oIz
         wTiat+kYW9jwErbBFPf56HgYy4Ete1xksqELuOi2xR1b84oGNwQV2gUp3ifxhWlzNbnQ
         tzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926081; x=1778530881;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImjDzvS2UskSas/z+0vPywvM5LQTiydtU8xeyByBcmg=;
        b=h+dkGhDqqhufe0jPlY4+xZz6T8lgl9GuWV+whYHxJhKeFhL0kQp7WWAr4lwkkKSqJV
         i/AD3LarnAwICl3y/hZXpuWvX8FGRwdKDMXtS51QMOLxaY0WuMNxm3U/AjazYJHiI3HY
         ITG34F6fTjZMRHcrjMwWnt//fN/YkTrU6/8euSH04S4qc8Zb484al+0WRoFB5auvNM6e
         KcCCkOuqryTzAekWdVCukdCLlhaQykz5ub8+ojDt09eRVIZo8DoxRvFUH/2lOBboZAPb
         F8tiM1wwJQ3Uf7UhdpEjrkPVg0A0v9nzLpZ7kIob13UsbxcpET+gscUlB2NpqhUJs8Vr
         HweQ==
X-Gm-Message-State: AOJu0YydpA8nNUS1hmz1qZeV63/2FgalMF3K46iBLSpzXzEDmytLWluM
	lhJgUopSR5acK66KFK9EO/OnYW7VptLrO8SSTrbDsoPtSXD54IK+lhP7Cryd1g==
X-Gm-Gg: AeBDievXChhCF18yU8P/xuOjUB3YKw8mOEJFhpnDEaQ80juMIfviX5rgWdOPbAJJhZC
	qVbq4t8NuIy0FDmPnnW9TBLDOaWEULo0iORTI8TN3gALC5WwfVQbN42iWiH4xVh1TwGoEg6SzVB
	EmvUNxwqmSCQleRxOldPN52zWqGyud5ohj9worPaz8IvjhO0Ofz6aHAy1VZvcMeptEpo4jm+Nvt
	QjKLKTvU3I/8I2hxJGEDRBfKQw+gza7AzmCjG3vjTPeU+mSrtriLAx/49Fo2e9a4p6yfIKw/SKS
	nT214akacJdLMonGDSMz3wTiFS+28WaTDgxTqdz/r3NlEcVxdkQnfiVNZS7ZVQSjddV+lun5oE2
	5pAvYPPNKCVRhaEKus3gEbasyZe1O64dugEdy5HENmQvtlBMbIx+QNm+gA2Fp10lLWyrJ+ReMyh
	O6qg+lPMskR96aB+pmv0H55qFKKnR307vyRKZ5
X-Received: by 2002:a05:620a:2886:b0:8cd:7b0d:a6a5 with SMTP id af79cd13be357-8fd15fce425mr1664236885a.19.1777926081286;
        Mon, 04 May 2026 13:21:21 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29d72467sm1131783885a.21.2026.05.04.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:20 -0700 (PDT)
Message-Id: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:09 +0000
Subject: [PATCH v2 00/10] pack-objects: integrate --path-walk and some --filter options
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

P.S. I've CC'd the folks who were on the original path-walk feature thread
[1]

[1]
https://lore.kernel.org/git/pull.1819.git.1741571455.gitgitgadget@gmail.com/

[2] https://lore.kernel.org/git/cover.1777853408.git.me@ttaylorr.com/

Derrick Stolee (7):
  pack-objects: pass --objects with --path-walk
  t/perf: add pack-objects filter and path-walk benchmark
  path-walk: support blobless filter
  backfill: die on incompatible filter options
  path-walk: support blob size limit filter
  path-walk: add pl_sparse_trees to control tree pruning
  pack-objects: support sparse:oid filter with path-walk

Taylor Blau (3):
  path-walk: support `tree:0` filter
  path-walk: support `object:type` filter
  path-walk: support `combine` filter

 Documentation/git-backfill.adoc        |   4 +
 Documentation/git-pack-objects.adoc    |   8 +-
 builtin/backfill.c                     |   8 +-
 builtin/pack-objects.c                 |   9 +-
 path-walk.c                            | 201 +++++++++-
 path-walk.h                            |  21 ++
 t/helper/test-path-walk.c              |  17 +-
 t/perf/p5315-pack-objects-filter.sh    | 129 +++++++
 t/t5317-pack-objects-filter-objects.sh | 125 ++++++
 t/t5620-backfill.sh                    |   8 +
 t/t6601-path-walk.sh                   | 502 +++++++++++++++++++++++++
 11 files changed, 1007 insertions(+), 25 deletions(-)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh


base-commit: a1ad4a0fca14cdeb55ab9fb065551b15cafa8a4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2101%2Fderrickstolee%2Fpath-walk-filters-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2101/derrickstolee/path-walk-filters-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2101

Range-diff vs v1:

  1:  29d2797440 =  1:  b361680338 pack-objects: pass --objects with --path-walk
  2:  f364621815 =  2:  9ea81aa726 t/perf: add pack-objects filter and path-walk benchmark
  3:  b7e72d5dbb !  3:  ed4d277a2c path-walk: support blobless filter
     @@ Commit message
          passes. This data demonstrates that the feature is engaged and provides
          real compression benefits when --no-reuse-delta forces fresh deltas.
      
     +    Co-Authored-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/git-pack-objects.adoc ##
     +@@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
     + 	of filenames that cause collisions in Git's default name-hash
     + 	algorithm.
     + +
     +-Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
     +-`--use-bitmap-index` option will be ignored in the presence of
     +-`--path-walk.`
     ++Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     ++ignored in the presence of `--path-walk`. Whe `--path-walk` option
     ++supports the `--filter=<spec>` form `blob:none`.
     + 
     + 
     + DELTA ISLANDS
     +
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       
  4:  22db528d0c !  4:  da4c19af42 backfill: die on incompatible filter options
     @@ Commit message
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/backfill.c ##
     -@@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
     - 
     - 	if (argc > 1)
     - 		die(_("unrecognized argument: %s"), argv[1]);
     -+	if (!path_walk_filter_compatible(&ctx.revs.filter))
     +@@ builtin/backfill.c: static void reject_unsupported_rev_list_options(struct rev_info *revs)
     + 	if (revs->explicit_diff_merges)
     + 		die(_("'%s' cannot be used with 'git backfill'"),
     + 		    "--diff-merges");
     +-	if (revs->filter.choice)
     +-		die(_("'%s' cannot be used with 'git backfill'"),
     +-		    "--filter");
     ++	if (!path_walk_filter_compatible(&revs->filter))
      +		die(_("cannot backfill with these filter options"));
     + }
       
     - 	repo_config(repo, git_default_config, NULL);
     - 
     + static int do_backfill(struct backfill_context *ctx)
      
       ## t/t5620-backfill.sh ##
      @@ t/t5620-backfill.sh: test_expect_success 'backfill rejects unexpected arguments' '
  5:  2e786160bd !  5:  d309345fec path-walk: support blob size limit filter
     @@ Commit message
          (which exercises partial filtering within a batch where some blobs are
          kept and others are excluded).
      
     +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/git-pack-objects.adoc ##
     +@@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
     + +
     + Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     + ignored in the presence of `--path-walk`. Whe `--path-walk` option
     +-supports the `--filter=<spec>` form `blob:none`.
     ++supports the `--filter=<spec>` form `blob:none` and `blob:limit=<n>`.
     + 
     + 
     + DELTA ISLANDS
     +
       ## builtin/backfill.c ##
     -@@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
     - 		die(_("unrecognized argument: %s"), argv[1]);
     - 	if (!path_walk_filter_compatible(&ctx.revs.filter))
     +@@ builtin/backfill.c: static void reject_unsupported_rev_list_options(struct rev_info *revs)
     + 		    "--diff-merges");
     + 	if (!path_walk_filter_compatible(&revs->filter))
       		die(_("cannot backfill with these filter options"));
     -+	if (ctx.revs.filter.blob_limit_value)
     ++	if (revs->filter.blob_limit_value)
      +		die(_("cannot backfill with blob size limits"));
     + }
       
     - 	repo_config(repo, git_default_config, NULL);
     - 
     + static int do_backfill(struct backfill_context *ctx)
      
       ## path-walk.c ##
      @@
  6:  c5aca53b23 =  6:  55ed02772b path-walk: add pl_sparse_trees to control tree pruning
  7:  859bee39eb !  7:  dcb1a29d3a pack-objects: support sparse:oid filter with path-walk
     @@ Commit message
          and dramatic time savings (60% faster) by leveraging the path-walk's
          ability to skip blobs outside the sparse scope.
      
     +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Taylor Blaue <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/git-backfill.adoc ##
     +@@ Documentation/git-backfill.adoc: OPTIONS
     + +
     + You may also use commit-limiting options understood by
     + linkgit:git-rev-list[1] such as `--first-parent`, `--since`, or pathspecs.
     +++
     ++Most `--filter=<spec>` options don't work with the purpose of
     ++`git backfill`, but the `sparse:<oid>` filter is integrated to provide a
     ++focused set of paths to download, distinct from the `--sparse` option.
     + 
     + SEE ALSO
     + --------
     +
     + ## Documentation/git-pack-objects.adoc ##
     +@@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
     + +
     + Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
     + ignored in the presence of `--path-walk`. Whe `--path-walk` option
     +-supports the `--filter=<spec>` form `blob:none` and `blob:limit=<n>`.
     ++supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`, and
     ++`sparse:<oid>`.
     + 
     + 
     + DELTA ISLANDS
     +
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: static void get_object_list_path_walk(struct rev_info *revs)
       	result = walk_objects_by_path(&info);
  -:  ---------- >  8:  772cdcaeed path-walk: support `tree:0` filter
  -:  ---------- >  9:  c557f3c59d path-walk: support `object:type` filter
  -:  ---------- > 10:  5423273edf path-walk: support `combine` filter

-- 
gitgitgadget
