Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06647A0C2
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523196; cv=none; b=KvAM2PkSJacNlt4JJcaz1Poxd4jv3W2zRRh5JzvTdyWCaK4PHEnNGJTujEdghX/m+DQcImdyCc6kDchoXdiHUQD8/rQYLkTNcIcVTETmN7IEOfkVx78/0g7SXMIdNujZkFlOhL1IFpjldSoy41SydLcXoU+jyEATw0x/sY0eaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523196; c=relaxed/simple;
	bh=bfWgM8pHmZbfVDturMsl4HCeCYbBtqdj3WaFRV2wlWI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=scANgqYkSy441nbCn+wGs7f9fxOGgOuRS9+jPniU5/5jcVkj+0bFG2JjdeALFUXJueshq/f3r6vkhFB2ORAN1IpoHuONqzvnyn7N3dfYD9LMw9eOC0Ua8+Fc0OJ+JV+WW6UMNwWALYXa8e+rUFm4WdeM72acwczxmVAIFu987Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af+ZK/BT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af+ZK/BT"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7b37d84a6b3so45179977b3.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523192; x=1779127992; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8n1x3DSGggVLn/2K14iP5EkRdbHg7vcGe7mUosFLTk=;
        b=Af+ZK/BT48Lxuo+Sy5FiBE6rjLYQSC0df02Q5mzbEQIeYwzMgsJJuO2XNPSj6V/96j
         I2pAvQPGk6JNI9FP28fmSsTSQDX3Zi1jaTwZYPy0I95BnMPw6BV28Nfdj8OnN7MIW7/g
         WZF+fZv9NkySBc6+Ld/45rkHlx24jhSJ3UXLlNHYws1SjAdTVMnJeHpQRt5Lxr62YZM4
         HkeCWg5G1yQzHQCpadJA6bZ30zjcWXtTktTCyzg4u4RUlEMdoFRKfbAYaSsLpMrieeeq
         aZJgeI8qGS+ZGYFEpB0AkaQhHfr62FRAo1OjKSwCCTQxBlXENC9uOTMEwmsGl8MyMiVP
         0uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523192; x=1779127992;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P8n1x3DSGggVLn/2K14iP5EkRdbHg7vcGe7mUosFLTk=;
        b=TgQRaiIH2KTCS/LBJ7e+omSItXZShU8zSAMyLbrHwH85MtgYvKTUwPXs0TRw0Zp78q
         v0bLoRtqoCYXh2YnqcMBtVfJn6QtaUdhPEktHV0KLohTz4BtCOVYjvqagJwLJGaXlEyr
         G92FTc39c4oK0IBrZo2HRGjdsCy+KV79l3dC3EJ44THTcD1zGXZGVTbqkgy+ySZw2+w9
         0HPdAxGeJGsQwpjpocLyBrBY+YEuHpBl/6XCdNNk4DyebPmLn8dYtRdfhKe309/yWwFC
         /Fts/gDVKXm4JlQ6Dqi89ZSC3xrpGWJQm+dVYhB3aXg2mPwRoppW+F37TjQAIxLtJEgT
         o4ww==
X-Gm-Message-State: AOJu0Yxv6IYlzyWQ+ecCFhACQRMo+jS3lxVdeVYEANK9O4b/f48LuiMA
	NAJhaiNQ+jfXkpCkoB/YNeuWF+xKYQaI2uoBoDKExqixOK23Uu7usFdbMajwXg==
X-Gm-Gg: Acq92OHzGxr0fUN8D9Ywz+eYUgPbB9J+RJqT3jNbrheLm+c48em5wnjVe14jvmlJ87x
	OaPE8ZLGmKFiSzJBymE8Xjwr89n+KdRJ1U9i9OlQsdmrdXtT+XwYywOXUW9pVsbMObfE/4cQ3yu
	618041H8EtEOsiFFtCIGXbbF1nGg475KwHmflmZnixBXrztcT0hBdIGxBsHjMI0LiF4Zbh0Huye
	ncwFZa1uc5i8mKCF3VMARR663WxxJmaFzFVehR8plQQmjNi9n9nc7DWgvSRVDxzSm3I3ulp0tpF
	ykw1yIA9UOUSP/QlQdGKqWS+HjTUhwrZZz+6N0WFAnZN2108DsdoVFwUiV53vZ3bqHSQ1YkiSvs
	V4h0Gr562Sgrc+4im+oJ7I/p8P2i3/bXwVBX+t/GiWGn4qqk2je6aex5cEeTuvrODWkzlnrXPxK
	VYEB57D1FIp7Tf3U3F93kR5fG55w==
X-Received: by 2002:a05:690c:6d83:b0:7bd:73f3:7a67 with SMTP id 00721157ae682-7c104dab235mr102061727b3.28.1778523191055;
        Mon, 11 May 2026 11:13:11 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66528237sm150077107b3.5.2026.05.11.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:10 -0700 (PDT)
Message-Id: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:12:57 +0000
Subject: [PATCH v3 00/12] pack-objects: integrate --path-walk and some --filter options
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

P.S. I've CC'd the folks who were on the original path-walk feature thread
[1]

[1]
https://lore.kernel.org/git/pull.1819.git.1741571455.gitgitgadget@gmail.com/

[2] https://lore.kernel.org/git/cover.1777853408.git.me@ttaylorr.com/

[3]
https://github.com/derrickstolee/git/compare/path-walk-filters...derrickstolee:git:path-walk-bitmaps

Derrick Stolee (9):
  t5620: make test work with path-walk var
  pack-objects: pass --objects with --path-walk
  t/perf: add pack-objects filter and path-walk benchmark
  path-walk: always emit directly-requested objects
  path-walk: support blobless filter
  backfill: die on incompatible filter options
  path-walk: support blob size limit filter
  path-walk: add pl_sparse_trees to control tree pruning
  pack-objects: support sparse:oid filter with path-walk

Taylor Blau (3):
  path-walk: support `tree:0` filter
  path-walk: support `object:type` filter
  path-walk: support `combine` filter

 Documentation/git-backfill.adoc            |   4 +
 Documentation/git-pack-objects.adoc        |   8 +-
 Documentation/technical/api-path-walk.adoc |   7 +
 builtin/backfill.c                         |   8 +-
 builtin/pack-objects.c                     |  23 +-
 path-walk.c                                | 260 ++++++++++-
 path-walk.h                                |  31 ++
 t/helper/test-path-walk.c                  |  17 +-
 t/perf/p5315-pack-objects-filter.sh        | 129 ++++++
 t/t5317-pack-objects-filter-objects.sh     | 125 +++++
 t/t5620-backfill.sh                        |   8 +
 t/t6601-path-walk.sh                       | 516 +++++++++++++++++++++
 12 files changed, 1093 insertions(+), 43 deletions(-)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh


base-commit: a1ad4a0fca14cdeb55ab9fb065551b15cafa8a4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2101%2Fderrickstolee%2Fpath-walk-filters-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2101/derrickstolee/path-walk-filters-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2101

Range-diff vs v2:

  -:  ---------- >  1:  0840110116 t5620: make test work with path-walk var
  1:  b361680338 =  2:  5cc6383380 pack-objects: pass --objects with --path-walk
  2:  9ea81aa726 =  3:  77329cf8f4 t/perf: add pack-objects filter and path-walk benchmark
  -:  ---------- >  4:  50933cccf5 path-walk: always emit directly-requested objects
  3:  ed4d277a2c !  5:  b2deb7f819 path-walk: support blobless filter
     @@ Commit message
      
          Update the test helper (test-path-walk) to accept --filter=<spec>
          as a test-tool option (before '--'), applying it to revs after
     -    setup_revisions() to avoid the --objects requirement check.
     +    setup_revisions() to avoid the --objects requirement check. We can also
     +    revert recent GIT_TEST_PACK_PATH_WALK overrides in t5620.
      
          Also switch test-path-walk from REV_INFO_INIT with manual repo
          assignment to repo_init_revisions(), which properly initializes
     @@ t/helper/test-path-walk.c: int cmd__path_walk(int argc, const char **argv)
       	return res;
       }
      
     + ## t/t5620-backfill.sh ##
     +@@ t/t5620-backfill.sh: test_expect_success 'backfill with prefix pathspec' '
     + 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
     + 	test_line_count = 48 missing &&
     + 
     +-	# If we enable --path-walk here, we will get a warning overs stderr
     +-	# due to incompatibilities with --filter.
     +-	GIT_TEST_PACK_PATH_WALK=0 \
     + 	git -C backfill-path backfill HEAD -- d/f 2>err &&
     + 	test_must_be_empty err &&
     + 
     +@@ t/t5620-backfill.sh: test_expect_success 'backfill with multiple pathspecs' '
     + 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
     + 	test_line_count = 48 missing &&
     + 
     +-	# If we enable --path-walk here, we will get a warning overs stderr
     +-	# due to incompatibilities with --filter.
     +-	GIT_TEST_PACK_PATH_WALK=0 \
     + 	git -C backfill-path backfill HEAD -- d/f a 2>err &&
     + 	test_must_be_empty err &&
     + 
     +@@ t/t5620-backfill.sh: test_expect_success 'backfill with wildcard pathspec' '
     + 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
     + 	test_line_count = 48 missing &&
     + 
     +-	# If we enable --path-walk here, we will get a warning overs stderr
     +-	# due to incompatibilities with --filter.
     +-	GIT_TEST_PACK_PATH_WALK=0 \
     + 	git -C backfill-path backfill HEAD -- "d/file.*.txt" 2>err &&
     + 	test_must_be_empty err &&
     + 
     +
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_expect_success 'trees are reported exactly once' '
       	test_line_count = 1 out-filtered
     @@ t/t6601-path-walk.sh: test_expect_success 'trees are reported exactly once' '
      +	1:tag:/tags:$(git rev-parse refs/tags/fourth)
      +	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
      +	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
     -+	2:tree::$(git rev-parse topic^{tree})
     -+	2:tree::$(git rev-parse base^{tree})
     -+	2:tree::$(git rev-parse base~1^{tree})
     -+	2:tree::$(git rev-parse base~2^{tree})
     -+	2:tree::$(git rev-parse refs/tags/tree-tag^{})
     -+	2:tree::$(git rev-parse refs/tags/tree-tag2^{})
     -+	3:tree:a/:$(git rev-parse base:a)
     -+	4:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     -+	5:tree:left/:$(git rev-parse base:left)
     -+	5:tree:left/:$(git rev-parse base~2:left)
     -+	6:tree:right/:$(git rev-parse topic:right)
     -+	6:tree:right/:$(git rev-parse base~1:right)
     -+	6:tree:right/:$(git rev-parse base~2:right)
     -+	blobs:0
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree::$(git rev-parse topic^{tree})
     ++	3:tree::$(git rev-parse base^{tree})
     ++	3:tree::$(git rev-parse base~1^{tree})
     ++	3:tree::$(git rev-parse base~2^{tree})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     ++	4:tree:a/:$(git rev-parse base:a)
     ++	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	6:tree:left/:$(git rev-parse base:left)
     ++	6:tree:left/:$(git rev-parse base~2:left)
     ++	7:tree:right/:$(git rev-parse topic:right)
     ++	7:tree:right/:$(git rev-parse base~1:right)
     ++	7:tree:right/:$(git rev-parse base~2:right)
     ++	blobs:2
      +	commits:4
      +	tags:7
      +	trees:13
  4:  da4c19af42 =  6:  da191e29e6 backfill: die on incompatible filter options
  5:  d309345fec !  7:  a1ab70405d path-walk: support blob size limit filter
     @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
       ignored in the presence of `--path-walk`. Whe `--path-walk` option
      -supports the `--filter=<spec>` form `blob:none`.
     -+supports the `--filter=<spec>` form `blob:none` and `blob:limit=<n>`.
     ++supports the `--filter=<spec>` forms `blob:none` and `blob:limit=<n>`.
       
       
       DELTA ISLANDS
     @@ path-walk.c
       #include "oid-array.h"
       #include "path.h"
      @@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     - 	/* Evaluate function pointer on this data, if requested. */
     - 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
     - 	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
     + 	/*
     + 	 * Evaluate function pointer on this data, if requested.
     + 	 * Ignore object type filters for tagged objects (path starts
     +-	 * with `/`).
     ++	 * with `/`), first for blobs and then other types.
     + 	 */
     +-	if ((list->type == OBJ_TREE && (ctx->info->trees || path_is_for_direct_objects(path))) ||
     +-	    (list->type == OBJ_BLOB && (ctx->info->blobs || path_is_for_direct_objects(path))) ||
      -	    (list->type == OBJ_TAG && ctx->info->tags))
     --		ret = ctx->info->path_fn(path, &list->oids, list->type,
     --					ctx->info->path_fn_data);
     -+	    (list->type == OBJ_TAG && ctx->info->tags)) {
     -+		struct oid_array *oids = &list->oids;
     ++	if (list->type == OBJ_BLOB &&
     ++	    ctx->info->blob_limit &&
     ++	    !path_is_for_direct_objects(path)) {
      +		struct oid_array filtered = OID_ARRAY_INIT;
      +
     -+		if (list->type == OBJ_BLOB && ctx->info->blob_limit) {
     -+			for (size_t i = 0; i < list->oids.nr; i++) {
     -+				unsigned long size;
     ++		for (size_t i = 0; i < list->oids.nr; i++) {
     ++			unsigned long size;
      +
     -+				if (odb_read_object_info(ctx->repo->objects,
     -+							 &list->oids.oid[i],
     -+							 &size) != OBJ_BLOB ||
     -+				    size < ctx->info->blob_limit)
     -+					oid_array_append(&filtered,
     -+							 &list->oids.oid[i]);
     -+			}
     -+			oids = &filtered;
     ++			if (odb_read_object_info(ctx->repo->objects,
     ++						 &list->oids.oid[i],
     ++						 &size) != OBJ_BLOB ||
     ++				size < ctx->info->blob_limit)
     ++				oid_array_append(&filtered,
     ++						 &list->oids.oid[i]);
      +		}
      +
     -+		if (oids->nr)
     -+			ret = ctx->info->path_fn(path, oids, list->type,
     ++		if (filtered.nr)
     ++			ret = ctx->info->path_fn(path, &filtered, list->type,
      +						 ctx->info->path_fn_data);
      +		oid_array_clear(&filtered);
     ++	} else if (path_is_for_direct_objects(path) ||
     ++		   (list->type == OBJ_TREE && ctx->info->trees) ||
     ++		   (list->type == OBJ_BLOB && ctx->info->blobs) ||
     ++		   (list->type == OBJ_TAG && ctx->info->tags)) {
     + 		ret = ctx->info->path_fn(path, &list->oids, list->type,
     + 					ctx->info->path_fn_data);
      +	}
       
       	/* Expand data for children. */
     @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       
      +	case LOFC_BLOB_LIMIT:
      +		if (info) {
     -+			if (!options->blob_limit_value) {
     ++			if (!options->blob_limit_value)
      +				info->blobs = 0;
     -+			} else {
     ++			else
      +				info->blob_limit = options->blob_limit_value;
     -+			}
      +			list_objects_filter_release(options);
      +		}
      +		return 1;
     @@ path-walk.h: struct path_walk_info {
       
      +	/**
      +	 * If non-zero, specifies a maximum blob size. Blobs with a
     -+	 * size equal to or greater than this limit will be omitted
     -+	 * from the walk. Blobs smaller than the limit (or blobs
     -+	 * whose size cannot be determined) are still visited.
     ++	 * size equal to or greater than this limit will not be
     ++	 * emitted unless included in 'pending'.
      +	 */
      +	unsigned long blob_limit;
      +
     @@ t/t6601-path-walk.sh: test_expect_success 'topic only, blob:none filter' '
      +	1:tag:/tags:$(git rev-parse refs/tags/fourth)
      +	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
      +	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
     -+	2:tree::$(git rev-parse topic^{tree})
     -+	2:tree::$(git rev-parse base^{tree})
     -+	2:tree::$(git rev-parse base~1^{tree})
     -+	2:tree::$(git rev-parse base~2^{tree})
     -+	2:tree::$(git rev-parse refs/tags/tree-tag^{})
     -+	2:tree::$(git rev-parse refs/tags/tree-tag2^{})
     -+	3:tree:a/:$(git rev-parse base:a)
     -+	4:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     -+	5:tree:left/:$(git rev-parse base:left)
     -+	5:tree:left/:$(git rev-parse base~2:left)
     -+	6:tree:right/:$(git rev-parse topic:right)
     -+	6:tree:right/:$(git rev-parse base~1:right)
     -+	6:tree:right/:$(git rev-parse base~2:right)
     -+	blobs:0
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree::$(git rev-parse topic^{tree})
     ++	3:tree::$(git rev-parse base^{tree})
     ++	3:tree::$(git rev-parse base~1^{tree})
     ++	3:tree::$(git rev-parse base~2^{tree})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     ++	4:tree:a/:$(git rev-parse base:a)
     ++	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	6:tree:left/:$(git rev-parse base:left)
     ++	6:tree:left/:$(git rev-parse base~2:left)
     ++	7:tree:right/:$(git rev-parse topic:right)
     ++	7:tree:right/:$(git rev-parse base~1:right)
     ++	7:tree:right/:$(git rev-parse base~2:right)
     ++	blobs:2
      +	commits:4
      +	tags:7
      +	trees:13
     @@ t/t6601-path-walk.sh: test_expect_success 'topic only, blob:none filter' '
      +	1:tag:/tags:$(git rev-parse refs/tags/fourth)
      +	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
      +	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
     -+	2:tree::$(git rev-parse topic^{tree})
     -+	2:tree::$(git rev-parse base^{tree})
     -+	2:tree::$(git rev-parse base~1^{tree})
     -+	2:tree::$(git rev-parse base~2^{tree})
     -+	2:tree::$(git rev-parse refs/tags/tree-tag^{})
     -+	2:tree::$(git rev-parse refs/tags/tree-tag2^{})
     -+	3:blob:a:$(git rev-parse base~2:a)
     -+	4:tree:a/:$(git rev-parse base:a)
     -+	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     -+	6:tree:left/:$(git rev-parse base:left)
     -+	6:tree:left/:$(git rev-parse base~2:left)
     -+	7:blob:left/b:$(git rev-parse base~2:left/b)
     -+	8:tree:right/:$(git rev-parse topic:right)
     -+	8:tree:right/:$(git rev-parse base~1:right)
     -+	8:tree:right/:$(git rev-parse base~2:right)
     -+	9:blob:right/c:$(git rev-parse base~2:right/c)
     -+	10:blob:right/d:$(git rev-parse base~1:right/d)
     -+	blobs:4
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree::$(git rev-parse topic^{tree})
     ++	3:tree::$(git rev-parse base^{tree})
     ++	3:tree::$(git rev-parse base~1^{tree})
     ++	3:tree::$(git rev-parse base~2^{tree})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag^{})
     ++	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
     ++	4:blob:a:$(git rev-parse base~2:a)
     ++	5:tree:a/:$(git rev-parse base:a)
     ++	6:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
     ++	7:tree:left/:$(git rev-parse base:left)
     ++	7:tree:left/:$(git rev-parse base~2:left)
     ++	8:blob:left/b:$(git rev-parse base~2:left/b)
     ++	9:tree:right/:$(git rev-parse topic:right)
     ++	9:tree:right/:$(git rev-parse base~1:right)
     ++	9:tree:right/:$(git rev-parse base~2:right)
     ++	10:blob:right/c:$(git rev-parse base~2:right/c)
     ++	11:blob:right/d:$(git rev-parse base~1:right/d)
     ++	blobs:6
      +	commits:4
      +	tags:7
      +	trees:13
  6:  55ed02772b =  8:  2360a5be81 path-walk: add pl_sparse_trees to control tree pruning
  7:  dcb1a29d3a !  9:  d9f5a98830 pack-objects: support sparse:oid filter with path-walk
     @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1
       +
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
       ignored in the presence of `--path-walk`. Whe `--path-walk` option
     --supports the `--filter=<spec>` form `blob:none` and `blob:limit=<n>`.
     -+supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`, and
     +-supports the `--filter=<spec>` forms `blob:none` and `blob:limit=<n>`.
     ++supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
      +`sparse:<oid>`.
       
       
       DELTA ISLANDS
      
       ## builtin/pack-objects.c ##
     +@@ builtin/pack-objects.c: static int add_objects_by_path(const char *path,
     + 	return 0;
     + }
     + 
     +-static void get_object_list_path_walk(struct rev_info *revs)
     ++static int get_object_list_path_walk(struct rev_info *revs)
     + {
     + 	struct path_walk_info info = PATH_WALK_INFO_INIT;
     + 	unsigned int processed = 0;
      @@ builtin/pack-objects.c: static void get_object_list_path_walk(struct rev_info *revs)
       	result = walk_objects_by_path(&info);
       	trace2_region_leave("pack-objects", "path-walk", revs->repo);
       
     +-	if (result)
     +-		die(_("failed to pack objects via path-walk"));
      +	path_walk_info_clear(&info);
      +
     - 	if (result)
     - 		die(_("failed to pack objects via path-walk"));
     ++	return result;
       }
     + 
     + static void get_object_list(struct rev_info *revs, struct strvec *argv)
     +@@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, struct strvec *argv)
     + 		fn_show_object = show_object;
     + 
     + 	if (path_walk) {
     +-		get_object_list_path_walk(revs);
     +-	} else {
     ++		if (get_object_list_path_walk(revs)) {
     ++			warning(_("failed to pack objects via path-walk"));
     ++			path_walk = 0;
     ++		}
     ++	}
     ++
     ++	if (!path_walk) {
     + 		if (prepare_revision_walk(revs))
     + 			die(_("revision walk setup failed"));
     + 		mark_edges_uninteresting(revs, show_edge, sparse);
      
       ## path-walk.c ##
      @@
  8:  772cdcaeed ! 10:  c9efff0ea8 path-walk: support `tree:0` filter
     @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1
       +
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
       ignored in the presence of `--path-walk`. Whe `--path-walk` option
     --supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`, and
     +-supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
      -`sparse:<oid>`.
     -+supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`,
     ++supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
      +`tree:0`, and `sparse:<oid>`.
       
       
       DELTA ISLANDS
      
       ## path-walk.c ##
     +@@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     + 					ctx->info->path_fn_data);
     + 	}
     + 
     +-	/* Expand data for children. */
     +-	if (list->type == OBJ_TREE) {
     ++	/* Expand data for children, unless this is a direct-object path. */
     ++	if (list->type == OBJ_TREE && !path_is_for_direct_objects(path)) {
     + 		for (size_t i = 0; i < list->oids.nr; i++) {
     + 			ret |= add_tree_entries(ctx,
     + 					    path,
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     + {
     + 	struct type_and_oid_list *tags = NULL;
     + 	struct type_and_oid_list *tagged_blobs = NULL;
     ++	struct type_and_oid_list *tagged_trees = NULL;
     + 	struct type_and_oid_list *root_tree_list = NULL;
     + 
     + 	if (info->tags)
     + 		CALLOC_ARRAY(tags, 1);
     + 	CALLOC_ARRAY(tagged_blobs, 1);
     ++	if (!info->trees)
     ++		CALLOC_ARRAY(tagged_trees, 1);
     + 	root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
     + 
     + 	/*
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     + 
     + 		switch (obj->type) {
     + 		case OBJ_TREE:
     +-			if (pending->path) {
     ++			if (tagged_trees) {
     ++				/*
     ++				 * Trees are disabled but pending trees
     ++				 * should still be emitted. Collect them
     ++				 * into a "/tagged-trees" list that
     ++				 * bypasses the object type filter.
     ++				 */
     ++				oid_array_append(&tagged_trees->oids, &obj->oid);
     ++			} else if (pending->path) {
     + 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
     + 							    : xstrdup("");
     + 				add_path_to_list(ctx, path, OBJ_TREE, &obj->oid, 1);
     +@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     + 			free(tagged_blobs);
     + 		}
     + 	}
     ++	if (tagged_trees) {
     ++		if (tagged_trees->oids.nr) {
     ++			const char *tagged_tree_path = "/tagged-trees";
     ++			tagged_trees->type = OBJ_TREE;
     ++			tagged_trees->maybe_interesting = 1;
     ++			strmap_put(&ctx->paths_to_lists, tagged_tree_path, tagged_trees);
     ++			push_to_stack(ctx, tagged_tree_path);
     ++		} else {
     ++			oid_array_clear(&tagged_trees->oids);
     ++			free(tagged_trees);
     ++		}
     ++	}
     + 	if (tags) {
     + 		if (tags->oids.nr) {
     + 			const char *tag_path = "/tags";
      @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       		}
       		return 1;
     @@ t/t6601-path-walk.sh: test_expect_success 'all, blob:limit=3 filter' '
      +	1:tag:/tags:$(git rev-parse refs/tags/fourth)
      +	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
      +	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
     -+	blobs:0
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{tree})
     ++	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2)
     ++	blobs:2
      +	commits:4
      +	tags:7
     -+	trees:0
     ++	trees:2
      +	EOF
      +
      +	test_cmp_sorted expect out
  9:  c557f3c59d ! 11:  b221ea4712 path-walk: support `object:type` filter
     @@ Documentation/git-pack-objects.adoc
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
       ignored in the presence of `--path-walk`. Whe `--path-walk` option
     - supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`,
     + supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
      -`tree:0`, and `sparse:<oid>`.
      +`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
       
     @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1
       DELTA ISLANDS
      
       ## path-walk.c ##
     -@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     - 		CALLOC_ARRAY(tags, 1);
     - 	if (info->blobs)
     - 		CALLOC_ARRAY(tagged_blobs, 1);
     --	if (info->trees)
     -+	if (info->trees || info->blobs)
     - 		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
     - 
     - 	/*
     -@@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
     - 
     - 		switch (obj->type) {
     - 		case OBJ_TREE:
     --			if (!info->trees)
     -+			if (!info->trees && !info->blobs)
     - 				continue;
     - 			if (pending->path) {
     - 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
     +@@ path-walk.c: static int walk_path(struct path_walk_context *ctx,
     + 			ret = ctx->info->path_fn(path, &filtered, list->type,
     + 						 ctx->info->path_fn_data);
     + 		oid_array_clear(&filtered);
     +-	} else if (path_is_for_direct_objects(path) ||
     ++	} else if ((!ctx->info->strict_types && path_is_for_direct_objects(path)) ||
     + 		   (list->type == OBJ_TREE && ctx->info->trees) ||
     + 		   (list->type == OBJ_BLOB && ctx->info->blobs) ||
     + 		   (list->type == OBJ_TAG && ctx->info->tags)) {
      @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       		}
       		return 1;
     @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
      +			info->tags &= options->object_type == OBJ_TAG;
      +			info->trees &= options->object_type == OBJ_TREE;
      +			info->blobs &= options->object_type == OBJ_BLOB;
     ++			info->strict_types = 1;
      +			list_objects_filter_release(options);
      +		}
      +		return 1;
     @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       	case LOFC_SPARSE_OID:
       		if (info) {
       			struct object_id sparse_oid;
     -@@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
     - 	/*
     - 	 * Set these values before preparing the walk to catch
     - 	 * lightweight tags pointing to non-commits and indexed objects.
     -+	 *
     -+	 * Keep tree_objects set whenever blobs are wanted: blobs may
     -+	 * be reachable through trees that show up as pending objects
     -+	 * (e.g., via lightweight tags pointing to trees, or annotated
     -+	 * tags whose peeled target is a tree). Without tree_objects,
     -+	 * prepare_revision_walk() would discard those pending trees
     -+	 * and we would never descend into them.
     - 	 */
     - 	info->revs->blob_objects = info->blobs;
     --	info->revs->tree_objects = info->trees;
     -+	info->revs->tree_objects = info->trees || info->blobs;
     +
     + ## path-walk.h ##
     +@@ path-walk.h: struct path_walk_info {
     + 	int blobs;
     + 	int tags;
       
     - 	if (prepare_revision_walk(info->revs))
     - 		die(_("failed to setup revision walk"));
     ++	/**
     ++	 * If 'strict_types' is 0, then direct object requests will no longer
     ++	 * override the object type restrictions.
     ++	 */
     ++	int strict_types;
     ++
     + 	/**
     + 	 * If non-zero, specifies a maximum blob size. Blobs with a
     + 	 * size equal to or greater than this limit will not be
      
       ## t/t6601-path-walk.sh ##
      @@ t/t6601-path-walk.sh: test_expect_success 'tree:1 filter is rejected' '
     @@ t/t6601-path-walk.sh: test_expect_success 'tree:1 filter is rejected' '
      +	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
      +	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
      +	1:blob:a:$(git rev-parse base~2:a)
     -+	2:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
     -+	3:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
     -+	4:blob:left/b:$(git rev-parse base:left/b)
     -+	4:blob:left/b:$(git rev-parse base~2:left/b)
     -+	5:blob:right/c:$(git rev-parse base~2:right/c)
     -+	5:blob:right/c:$(git rev-parse topic:right/c)
     -+	6:blob:right/d:$(git rev-parse base~1:right/d)
     -+	blobs:10
     ++	2:blob:left/b:$(git rev-parse base:left/b)
     ++	2:blob:left/b:$(git rev-parse base~2:left/b)
     ++	3:blob:right/c:$(git rev-parse base~2:right/c)
     ++	3:blob:right/c:$(git rev-parse topic:right/c)
     ++	4:blob:right/d:$(git rev-parse base~1:right/d)
     ++	blobs:8
      +	commits:0
      +	tags:0
      +	trees:0
 10:  5423273edf ! 12:  16bd3c3161 path-walk: support `combine` filter
     @@ Commit message
             the standalone `sparse:oid` behavior.
      
          Implementation-wise, the existing `prepare_filters()` called
     -    `list_objects_filter_release()` inside each case branch. That works fine
     -    for top-level filters, but `combine` filters need to recurse over its
     -      child filters without releasing each one in turn (since the parent's
     -      release iterates the sub array). Split `prepare_filters()` into a
     -      recursive helper that performs only the mutation, plus a thin wrapper
     -      that calls the helper and then releases the top-level filter once.
     +    `list_objects_filter_release()` inside each case branch. That works fine for
     +    top-level filters, but `combine` filters need to recurse over its child
     +    filters without releasing each one in turn (since the parent's release
     +    iterates the sub array). Split `prepare_filters()` into a recursive helper
     +    that performs only the mutation, plus a thin wrapper that calls the helper
     +    and then releases the top-level filter once.
      
          The `LOFC_COMBINE` case in the helper just walks `sub_nr` and recurses;
          child filters are released by the wrapper's single
     -    `list_objects_filter_release()` call on the parent (which itself
     -    recursively releases each sub-filter, the same way it always has).
     +    `list_objects_filter_release()` call on the parent (which itself recursively
     +    releases each sub-filter, the same way it always has).
      
          If any sub-filter is unsupported (e.g. "tree:1", "sparse:<path>", or a
          not-yet-supported choice), the recursion bubbles a failure up and the
     @@ Documentation/git-pack-objects.adoc
      @@ Documentation/git-pack-objects.adoc: will be automatically changed to version `1`.
       Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
       ignored in the presence of `--path-walk`. Whe `--path-walk` option
     - supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`,
     + supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
      -`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
      +`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
      +types can be combined with the `combine:<spec>+<spec>` form.
     @@ path-walk.c: static int setup_pending_objects(struct path_walk_info *info,
       {
       	switch (options->choice) {
       	case LOFC_DISABLED:
     - 		return 1;
     - 
     - 	case LOFC_BLOB_NONE:
     --		if (info) {
     -+		if (info)
     - 			info->blobs = 0;
     --			list_objects_filter_release(options);
     --		}
     - 		return 1;
     - 
     - 	case LOFC_BLOB_LIMIT:
     +@@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       		if (info) {
     - 			if (!options->blob_limit_value) {
     + 			if (!options->blob_limit_value)
       				info->blobs = 0;
     --			} else {
     -+			} else if (!info->blob_limit ||
     -+				   options->blob_limit_value < info->blob_limit) {
     +-			else
     ++			else if (!info->blob_limit ||
     ++				 info->blob_limit > options->blob_limit_value)
       				info->blob_limit = options->blob_limit_value;
     - 			}
     --			list_objects_filter_release(options);
     + 			list_objects_filter_release(options);
       		}
     - 		return 1;
     - 
      @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       		if (info) {
       			info->trees = 0;
     @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       		}
       		return 1;
       
     -@@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
     - 			info->tags &= options->object_type == OBJ_TAG;
     - 			info->trees &= options->object_type == OBJ_TREE;
     - 			info->blobs &= options->object_type == OBJ_BLOB;
     --			list_objects_filter_release(options);
     - 		}
     - 		return 1;
     - 
      @@ path-walk.c: static int prepare_filters(struct path_walk_info *info,
       				warning(_("sparse filter is not cone-mode compatible"));
       				return 0;
     @@ t/t6601-path-walk.sh: test_expect_success 'all, object:type=blob filter' '
      +	1:tag:/tags:$(git rev-parse refs/tags/fourth)
      +	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
      +	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
     -+	blobs:0
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{tree})
     ++	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2)
     ++	blobs:2
      +	commits:4
      +	tags:7
     -+	trees:0
     ++	trees:2
      +	EOF
      +
      +	test_cmp_sorted expect out
     @@ t/t6601-path-walk.sh: test_expect_success 'all, object:type=blob filter' '
      +		-- --all >out &&
      +
      +	cat >expect <<-EOF &&
     -+	0:blob:a:$(git rev-parse base~2:a)
     -+	1:blob:left/b:$(git rev-parse base~2:left/b)
     -+	2:blob:right/c:$(git rev-parse base~2:right/c)
     -+	3:blob:right/d:$(git rev-parse base~1:right/d)
     -+	blobs:4
     ++	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
     ++	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
     ++	1:blob:a:$(git rev-parse base~2:a)
     ++	2:blob:left/b:$(git rev-parse base~2:left/b)
     ++	3:blob:right/c:$(git rev-parse base~2:right/c)
     ++	4:blob:right/d:$(git rev-parse base~1:right/d)
     ++	blobs:6
      +	commits:0
      +	tags:0
      +	trees:0

-- 
gitgitgadget
