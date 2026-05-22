Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492682DC79F
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474282; cv=none; b=Zb9OujBUc+lyhqJ/dUOlwenGXHzZNYhU/jTY6w+SMv3g00BIm+9uipgbt5V3XVGLbyrbniBZm9RHVPHrT9zB6fiK0YBUWIQNZoHn6xL6GI8tsbEnifnQgLewvD56Z40iDizvSKRO5E+jHfRn+7oR/BRhkPjzve6H3WZZOaYNm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474282; c=relaxed/simple;
	bh=qLXIW+X46p8nprT7/yZzguyAI92+y0Mj0QHgd02QZas=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SBl9AiKR7FweYFj7Vx6xCkW75lOr4bcAK8zOsYgvg8OdmvsKdtdW/HAklcOM3wmeWVTtO31oNZrbryNXHo8j2Z+CI/XcRk3PHd2AAN5VtyeHQVtAw9a1SRS1R6FhRIfxenlk8tPMABaMqQ10z03z9xsPFhX0dVlngjxhEislp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DamQ1rKB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DamQ1rKB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e63771eb0so75706021cf.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474279; x=1780079079; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV74UAOFRWnnfUGgNwM8O/S2hoIkMxojFeyCVCOmfCs=;
        b=DamQ1rKBbeiDtaSEmP91JM0bCGDbpKK8SbOwow4AnBubkFpvI5y+sYYR+0pglPL5Xt
         cg7Dpa64zozlG/aV+WcMd2FcoIFOxOJJ7Pz7T51D+Zo1UUcynzFstVPM1bprI6+flETU
         gDd/6z27hIBTiohfEGhMnLdeH8PFIn1FIWXTIQKSShfOzRn4iYfHep7yIAoGUpXyZKzl
         43RyTf1ywLeZEX7+59lYbzYhUOQePZHk9aHGr0v9PU4T13Gcxn3r/IAIY5aQCtGyOm8Q
         hv130qckCRV4Z089fp+jnQubV+SoMpDi4CO5+nFdGtjNgu1tQCaifmlJIi7If+fVoDst
         D1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474279; x=1780079079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV74UAOFRWnnfUGgNwM8O/S2hoIkMxojFeyCVCOmfCs=;
        b=RCYpEwSBWabhJOimOIxwDnOEQbPnxU4miOvM3Gop3TTX/5QF7nCYZQQ/P0WnKok/SV
         AzWSb4taaHUNOAUo/5iGbh0Bm2+GR8tw10YVNYcgggeZo/gb1i4t34SzQYOffKkVQ0aq
         dI8y4FHZSge1rjz1xFg1PayC7beldb++R/x8U7usLopfTjcVRlB5qZvLSWWcINEVwX+N
         jlksu9qEBrdZFZBvzAp8YGfnFPngta+G7un1LWMT+U7rv251l1Ey4xg7juPLqxA9vXYh
         UiliI7nbfDHE90koduAQt6l3mUDurGBvUhx+Am9lfHets+vIHHLxXXyfRR0SB7+aN1w1
         FiSA==
X-Gm-Message-State: AOJu0YzPUVHLX35+qF0GS5KFRQnDq58ni9Z8+sLpvrFP+xW+uznrKQtI
	XtAgY1eR1WpfKioUt0KUbB0Gvi3DVixXxY+tfcA8Jpn89aoR5bjH88ehpn8ecA==
X-Gm-Gg: Acq92OGw+hDD0NH7kkoPN1m8w7wEx5cwtcZj1jsEAvkwbKU/rSG4udRl76IzKeUjHv/
	V+xYaEGL40+v7nspb6nZPx+uqMK7P/J+PJ8K7FwmTN+BPOs/kSj3MViLLiIXJZgDZnWFSoL4JeI
	zv8u0Vob+o110YlXoV13Q/0LU2YzzYzZGQSKs+InZOLWufL9LXlkATZ7dOzspJKf2uhWqe5+Dvn
	bpvgDfxn38UhAigfXc0NTH0GdNBI9LkkvvZTR/0TquEWYjuDVHXSv7+9mhJSRwwT8Yh/VbODGUR
	p1gc2HPTOxgKSMYHajJqup0k1CNFXbmWlUfzpUiLIRxzDV7KKMJSwwjo1EzCnR9/EWApXF9nSA+
	OFQR77Z+/v+G4oEiOmYFoi/ceGdgJLYinaH9KQxTJFRp44ZTPUUUAcryDJI1FKy6xsCYgSRAIFk
	WJv/O87egrhWmPl6TiijltwbVZKuc=
X-Received: by 2002:ac8:7c4c:0:b0:50e:60d7:b272 with SMTP id d75a77b69052e-516d4395683mr69912051cf.41.1779474279089;
        Fri, 22 May 2026 11:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c9212esm21242921cf.19.2026.05.22.11.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:38 -0700 (PDT)
Message-Id: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:24 +0000
Subject: [PATCH v5 00/13] pack-objects: integrate --path-walk and some --filter options
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


UPDATES IN V5
=============

Small adjustments to the performance test script.

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
 t/perf/p5315-pack-objects-filter.sh        | 129 +++++
 t/t5317-pack-objects-filter-objects.sh     | 125 +++++
 t/t5620-backfill.sh                        |   8 +
 t/t6601-path-walk.sh                       | 572 +++++++++++++++++++--
 12 files changed, 1124 insertions(+), 78 deletions(-)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh


base-commit: a1ad4a0fca14cdeb55ab9fb065551b15cafa8a4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2101%2Fderrickstolee%2Fpath-walk-filters-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2101/derrickstolee/path-walk-filters-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2101

Range-diff vs v4:

  1:  0840110116 =  1:  0840110116 t5620: make test work with path-walk var
  2:  d7c87545f3 =  2:  d7c87545f3 pack-objects: pass --objects with --path-walk
  3:  fb8a0f9c43 !  3:  697ef716d2 t/perf: add pack-objects filter and path-walk benchmark
     @@ t/perf/p5315-pack-objects-filter.sh (new)
      +		awk "{print \$4;}" >top-dirs &&
      +	top_nr=$(wc -l <top-dirs) &&
      +
     -+	>depth2-dirs &&
      +	while read tdir
      +	do
     -+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
     -+	done <top-dirs >depth2-dirs.raw &&
     -+	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&
     ++		git ls-tree -d --format="$tdir/%(path)" "HEAD:$tdir" || return 1
     ++	done <top-dirs >depth2-dirs &&
      +
      +	d2_nr=$(wc -l <depth2-dirs) &&
      +
  4:  e77c8a6bbc =  4:  91845bcef0 path-walk: always emit directly-requested objects
  5:  f4904f81e0 =  5:  fdb9361198 path-walk: support blobless filter
  6:  f37467e46f =  6:  89726faf7e backfill: die on incompatible filter options
  7:  133c1b156c =  7:  3884d4737f path-walk: support blob size limit filter
  8:  0f517be8e3 =  8:  31b4ef0fa1 path-walk: add pl_sparse_trees to control tree pruning
  9:  b4dc09ab69 =  9:  7d8f0aa036 pack-objects: support sparse:oid filter with path-walk
 10:  0b1eed0790 = 10:  a68676d0de t6601: tag otherwise-unreachable trees
 11:  b23244c4c2 = 11:  b0db73c6cc path-walk: support `tree:0` filter
 12:  7e1e503361 = 12:  6845988f50 path-walk: support `object:type` filter
 13:  a615b1a707 = 13:  d33d899251 path-walk: support `combine` filter

-- 
gitgitgadget
