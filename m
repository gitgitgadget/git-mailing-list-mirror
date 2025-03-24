Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285612A1BA
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829777; cv=none; b=i4pOakEcVlGODgGfdzbIU9uBk7uutWogo7VLWztjmWTcoOluZovgJTb9sqA6nqbK5/ahzMDPlKkZvC7Fuj5eN4KUdc6G5td1ZD/kwfGg87wPonfZQiSUfbdt2tA3ZVqnBBJytzVIyqm92MlkrxoKMD3eDeRJZJ1obUeo/gD/RNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829777; c=relaxed/simple;
	bh=/n2PkO0/pg4Nd6jRhwndI0HoCifmRY983spdeav0YC0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DNMUYdSKcskq9TSQXPIkEXvEksT0Llbcp/DnbbUuDFKTjH+uyUWaVUxnapGzL/ZZXwU4UNnps1KRmUfjJPS2e2pn+YfnKTGo+3EuVRBf+RMPppNsdqlidXs3FEKSUjgmFXclZdAIodeSyzOUtjfUd26pBmmsruMeOXyVxprsAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiZs5QSF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiZs5QSF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso33969815e9.3
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829773; x=1743434573; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9il9U7GoFjU1OasmvyqLXLsW7kaw6bYguDBJGeIHVLI=;
        b=jiZs5QSF5ukQyM2dFddCF9HbfoYGHg/UzeTiH5S9Ipuua6Si5XXQD6GUvHzhwp8UZL
         ie7leKCh26QKtPwGZrFtBJNnFfFOfnXsjlC3Pe3/0zU4aOy/KX1tTSb9xvg0PWXG5DQJ
         Rpaw82k6Kjr7T/nAEmegEroK0PZ4+mq06qLa0AdDymKcfnoJKk70UnSd7x36GLvTpM6L
         tujLcTPuovCy9F9ZFF1mnlTfFfHq6jl/iV+TgSevQlcF1+aKMyeJmtOyigOfMNzw+rJR
         nHoZpFLcIpd9ib0tqncdhqzbD9y2yI+LBMI+eAcn/aF5SA0hI6bzRcIlR0Cgzz8Bh7u4
         f7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829773; x=1743434573;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9il9U7GoFjU1OasmvyqLXLsW7kaw6bYguDBJGeIHVLI=;
        b=cljyzsrhlt3ctVtexNx09dMCxQohEJf/Rp4yxtmfj7t6tgi5mqT+2w7jqe67YT7YlB
         72YUFgEGSGwy3qqZjfXIoXRMfE5cx/UFCQYQNzfYqGfWiWprhzeDeWYReCLrA9MpENow
         IrN0l6KTCyoa5gZNReDTpQYfXJXp+SVXGYdDdihUuCLhmLgIjITCgsGvvo+8PqlSBeYC
         fplg0h5y+O2iEGRQ/AWyfAr+K6e4GExeYcmjm/WrMOxooY6Sm552cBrjkf7UUPAmjlu5
         yBBREvl6JQoJA/uhhRR2g4kaKswxGOy3RMKS6+I9iBi2gmZKlNotar8mHlmRXFhK5+RG
         lVnA==
X-Gm-Message-State: AOJu0Yy1rGFjcDyPXBeDHPKp5vZq8Fi6b9A954AbPkolaLGNxJtTAFOc
	eeiB70H4nQLWfkRk8IOsU+a22ZurakQdspSQq66NQh+Qc4y3Okd5GB5KHg==
X-Gm-Gg: ASbGncsmHNMr2Opj83EQkZ3i+DysrZJq1PdxFTjXqu9xOJ6eTM5qj7rGQM9XujTlr+5
	aZ1Y3i+4JG6aKInF5jbmh4auRZWbv0ZefvKYEyLQ9DEup6BmOm95fhRA5ZKfimCJtCUGtVG3cQX
	eNNWrccMy423Hvey0nZL+T5ZmnOIV2TIxzX3OfnxlMsDY8fjMbBHhIDkfnxKTRp8xK5PhU0a17a
	nff6bbmAphLZmlkDXr2QktQ6cIh6Rsfx+v5Lttj8Iw53r1y1pccy64zT99go5qSFxEAE9mtkB0t
	LFuG+vxfWDBw8dOovjUJo4qVgGV/yIlw17M5P21Q1fgwjw==
X-Google-Smtp-Source: AGHT+IGo6BhbJt2Z5t1+vvZuMc0+YBIvDXDRwU7IU5iplQDVDFo/znmnXC5SQZ+us8dwV9z4LkdZkw==
X-Received: by 2002:a05:600c:1e04:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43d62c6121dmr46991125e9.9.1742829772519;
        Mon, 24 Mar 2025 08:22:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceae03sm128710235e9.8.2025.03.24.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:52 -0700 (PDT)
Message-Id: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:36 +0000
Subject: [PATCH v2 00/13] PATH WALK II: Add --path-walk option to 'git pack-objects'
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
    Derrick Stolee <stolee@gmail.com>

Here is a full submission of the --path-walk feature for 'git pack-objects'
and 'git repack'. It's been discussed in an RFC [1], as a future application
for the path walk API [2], and is updated now that --name-hash-version=2
exists (as a replacement for the --full-name-hash option from the RFC) [3].

[1]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

[2]
https://lore.kernel.org/git/pull.1818.git.1730356023.gitgitgadget@gmail.com

[3]
https://lore.kernel.org/git/pull.1813.git.1728396723.gitgitgadget@gmail.com

This patch series does the following:

 1. Add a new '--path-walk' option to 'git pack-objects' that uses the
    path-walk API instead of the revision API to collect objects for delta
    compression.

 2. Add a new '--path-walk' option to 'git repack' to pass this option along
    to 'git pack-objects'.

 3. Add a new 'pack.usePathWalk' config option to opt into this option
    implicitly, such as in 'git push'.

 4. Optimize the '--path-walk' option using threading so it better competes
    with the existing multi-threaded delta compression mechanism.

 5. Update the path-walk API with a new 'edge_aggressive' option that pairs
    close to the --edge-aggressive option in the revision API. This is
    useful when creating thin packs inside shallow clones.

This feature works by using the path-walk API to emit groups of objects that
appear at the same path. These groups are tracked so they can be tested for
delta compression with each other, and then after those groups are tested a
second pass using the name-hash attempts to find better (or first time)
deltas across path boundaries. This second pass is much faster than a fresh
pass since the existing deltas are used as a limit for the size of
potentially new deltas, short-circuiting the checks when the delta size
exceeds the current-best.

The benefits of the --path-walk feature first come into play when the name
hash functions have many collisions, so sorting by name hash value leads to
unhelpful groupings of objects. Many of these benefits are improved by
--name-hash-version=2, but collisions still exist with any hash-based
approach. There are also performance benefits in some cases due to the
isolation of delta compression testing within path groups.

All of the benefits of the --path-walk feature are less dramatic when
compared to --name-hash-version=2, but they can still exist in many cases. I
have also seen some cases where --name-hash-version=2 compresses better than
--path-walk with --name-hash-version=1, but these options can be combined to
get the best of both worlds.

Detailed statistics are provided within patch messages, but a few are
highlighted here:

The microsoft/fluentui is a public Javascript repo that suffers from many of
the name hash collisions as internal repositories I've worked with. Here is
a comparison of the compressed size and end-to-end time of the repack:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             439.4M      87.24s
Hash v2             161.7M      21.51s
Path Walk           142.5M      28.16s


Less dramatic, but perhaps more standardly structured is the nodejs/node
repository, with these stats:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                739.9M      71.18s
Hash v2                764.6M      67.82s
Path Walk              698.0M      75.10s


Even the Linux kernel repository gains some benefits, even though the number
of hash collisions is relatively low due to a preference for short
filenames:

Repack Method       Pack Size       Time
------------------------------------------
Hash v1                  2.5G     554.41s
Hash v2                  2.5G     549.62s
Path Walk                2.2G     559.00s


The drawbacks of the --path-walk feature is that it will be harder to
integrate it with bitmap features, specifically delta islands. This is not
insurmountable, but would require more work, such as a revision walk to
paint objects with reachability information before using that during delta
computations.

However, there should still be significant benefits to Git clients trying to
save space and improve local performance.

This feature was shipped with similar features in microsoft/git as of
v2.47.0.vfs.0.3 [4]. This was used in CI machines for an internal monorepo
that had significant repository growth due to constructing a batch of
beachball [5] CHANGELOG.[md|json] files and pushing them to a release
branch. These pushes were frequently 70-200 MB due to poor delta
compression. Using the 'pack.usePathWalk=true' config, these pushes dropped
in size by 100x while improving performance. Since these CI machines were
working with a shallow clone, the 'edge_aggressive' changes were required to
enable the path-walk option.

[4] https://github.com/microsoft/git/releases/tag/v2.47.0.vfs.0.3

[5] https://github.com/microsoft/beachball


Updates in v2
=============

 * Re-added a dropped comment when moving code in patch 1.
 * Updated documentation to include interaction with --use-bitmap-index.
 * An UNUSED parameter is now used, reducing the use of global variables
   slightly.

Thanks, -Stolee

Derrick Stolee (13):
  pack-objects: extract should_attempt_deltas()
  pack-objects: add --path-walk option
  pack-objects: update usage to match docs
  p5313: add performance tests for --path-walk
  pack-objects: introduce GIT_TEST_PACK_PATH_WALK
  t5538: add tests to confirm deltas in shallow pushes
  repack: add --path-walk option
  pack-objects: enable --path-walk via config
  scalar: enable path-walk during push via config
  pack-objects: refactor path-walk delta phase
  pack-objects: thread the path-based compression
  path-walk: add new 'edge_aggressive' option
  pack-objects: allow --shallow and --path-walk

 Documentation/config/feature.adoc          |   4 +
 Documentation/config/pack.adoc             |   8 +
 Documentation/git-pack-objects.adoc        |  26 +-
 Documentation/git-repack.adoc              |  14 +-
 Documentation/technical/api-path-walk.adoc |   9 +
 builtin/pack-objects.c                     | 414 +++++++++++++++++++--
 builtin/repack.c                           |   7 +-
 pack-objects.h                             |  12 +
 path-walk.c                                |   6 +-
 path-walk.h                                |   7 +
 repo-settings.c                            |   3 +
 repo-settings.h                            |   1 +
 scalar.c                                   |   1 +
 t/README                                   |   4 +
 t/helper/test-path-walk.c                  |   2 +
 t/perf/p5313-pack-objects.sh               |  37 +-
 t/t0411-clone-from-partial.sh              |   6 +
 t/t0450/adoc-help-mismatches               |   1 -
 t/t5300-pack-object.sh                     |  19 +
 t/t5306-pack-nobase.sh                     |   5 +
 t/t5310-pack-bitmaps.sh                    |  13 +-
 t/t5316-pack-delta-depth.sh                |   9 +-
 t/t5332-multi-pack-reuse.sh                |   7 +
 t/t5538-push-shallow.sh                    |  34 ++
 t/t6601-path-walk.sh                       |  20 +
 t/t7406-submodule-update.sh                |   3 +
 26 files changed, 605 insertions(+), 67 deletions(-)


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1819%2Fderrickstolee%2Fpath-walk-upstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1819/derrickstolee/path-walk-upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1819

Range-diff vs v1:

  1:  a2ed1f2d4e3 !  1:  57c1cc20de0 pack-objects: extract should_attempt_deltas()
     @@ builtin/pack-objects.c: static int add_ref_tag(const char *tag UNUSED, const cha
      +static int should_attempt_deltas(struct object_entry *entry)
      +{
      +	if (DELTA(entry))
     ++		/* This happens if we decided to reuse existing
     ++		 * delta from a pack. "reuse_delta &&" is implied.
     ++		 */
      +		return 0;
      +
      +	if (!entry->type_valid ||
  2:  9b31dc87bb6 !  2:  a271d6245c2 pack-objects: add --path-walk option
     @@ Documentation/git-pack-objects.adoc: many different directories. At the moment,
      +	especially in the presence of filenames that cause collisions in
      +	Git's default name-hash algorithm. Due to changing how the objects
      +	are walked, this option is not compatible with `--delta-islands`,
     -+	`--shallow`, or `--filter`.
     ++	`--shallow`, or `--filter`. The `--use-bitmap-index` option will
     ++	be ignored in the presence of `--path-walk.`
      +
       
       DELTA ISLANDS
  3:  bc678acb109 =  3:  dcff01392ff pack-objects: update usage to match docs
  4:  de848ebff74 =  4:  97a0b52ccee p5313: add performance tests for --path-walk
  5:  4bfd438b5fa =  5:  0d49bb3d30a pack-objects: introduce GIT_TEST_PACK_PATH_WALK
  6:  cfee2136e92 =  6:  ddf804e606a t5538: add tests to confirm deltas in shallow pushes
  7:  1e75f068281 =  7:  11767e7653e repack: add --path-walk option
  8:  073cb44a47c =  8:  dd66a5b46f2 pack-objects: enable --path-walk via config
  9:  fd9a335329e =  9:  e5624c379d5 scalar: enable path-walk during push via config
 10:  c047fbd7f27 ! 10:  622439d7855 pack-objects: refactor path-walk delta phase
     @@ builtin/pack-objects.c: static int should_attempt_deltas(struct object_entry *en
       	return 1;
       }
       
     -+static void find_deltas_for_region(struct object_entry *list UNUSED,
     ++static void find_deltas_for_region(struct object_entry *list,
      +				   struct packing_region *region,
      +				   unsigned int *processed)
      +{
     @@ builtin/pack-objects.c: static int should_attempt_deltas(struct object_entry *en
      +
      +	ALLOC_ARRAY(delta_list, region->nr);
      +	for (uint32_t i = 0; i < region->nr; i++) {
     -+		struct object_entry *entry = to_pack.objects + region->start + i;
     ++		struct object_entry *entry = list + region->start + i;
      +		if (should_attempt_deltas(entry))
      +			delta_list[delta_list_nr++] = entry;
      +	}
     @@ pack-objects.h: struct object_entry {
       	uint32_t nr_objects, nr_alloc;
       
      +	struct packing_region *regions;
     -+	uint32_t nr_regions, nr_regions_alloc;
     ++	uint64_t nr_regions, nr_regions_alloc;
      +
       	int32_t *index;
       	uint32_t index_size;
 11:  cf990b90b34 = 11:  ae73d26319a pack-objects: thread the path-based compression
 12:  bc9383ef11c = 12:  c45f35c204e path-walk: add new 'edge_aggressive' option
 13:  2eb92507213 = 13:  d5484ebd942 pack-objects: allow --shallow and --path-walk

-- 
gitgitgadget
