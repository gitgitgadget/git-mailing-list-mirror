Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FDF2459FD
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419135; cv=none; b=WJvJJg/0tABNSIP4pg4i2KpuiKKa2z1tCmoD8/J97IYaYcl/6pLQg1MfsdDqjao3ho10nOgnCrEBAqQgkfRyvgQoswcc7z6phc7lQNW2SyzaqhqcFuwuExslcgqPU/dtJ5o5cFJhUs4he7UH6wks9GWgsIl2bLKzeGLWz+DKvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419135; c=relaxed/simple;
	bh=tPrmGyfPfzkgzOqeIIvYYIWTMFqYfc7kSDtg+OlNtno=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bl1UJZ7dlAPRLYP7zHhWSyuSuCUeXIL3I1wtZy0uncb/9cuIqQd3OyhGQrMp60aYP3mrp2oHL91DwOQ5DIwsQwpS0iuSxEPTlfv+pzC61dlvT1cfJIfxH0G5yNvQ8d0wB7t/A+7QH0aQEwmM/qEJkiI7I/VDX5MtOycwNi6TiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKIIIbGN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKIIIbGN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso17980805e9.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419131; x=1748023931; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOBv3nu5p6a6VVSCmuK3hKCpultvlk316rIpFUoF8lg=;
        b=RKIIIbGNp7iDwdziZrWL+vs1JxnpMoVQ56flwEEyFoWiJ8AxPv2H1gKI9FAEmfLCoV
         go7f5+JM9J01KlRPOPiZJ6Te58Mkjeap3YHCHX+mJvaoM1z0IAeaQmSvthmaNGZSCzq6
         YbM1Asfrngoyt52NiJs/P5MQfYA57KBx4r88b/LywMTYHZD01/2UZsV9EH++/AQolBnN
         JD6VeGUD6FcukgtNnlj1yiz4uK9wPCE/nX0g20PoJTsDC3aX5VajKvPivrMjBj7hmm1M
         BJYBIsQjSbQKzx2pRbFpe7f5X0MCvOGZ+MJbwDF03ztMf/L8tZxApOg1PZE+g71cZEB7
         uiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419131; x=1748023931;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOBv3nu5p6a6VVSCmuK3hKCpultvlk316rIpFUoF8lg=;
        b=tuyZFpdGgCT4n5fhtFuemtJdyCz9OmTkWZ/X7r5wRMCtIbmJHkV1D00Cf7XVlpzXcW
         PX3yLJqOty/8DEeELe5lYJcQEs5fRg9jlL3qLsZdRjrpusBm1SmJPOnpJ9hheJv2X8AX
         fi/eznGW+zzxjZQCMTrQC32EiOKPazfjdvhWrTcrl4CzGFk1SqRyW+QxHrnIR1Cn6Q8Y
         ir7t99sJ4SK/8kvfSxAyXA8pL0CZ5dq3KsPNfqQOKiUgyXbNv/sa2+7hLjX09K6z2DKt
         5+JLq/3+oEfmVQXf968WFbHZs4VF3tg08t8V1sYOgfefk93hU176A1EVhZ5StKIP2TD2
         aw+Q==
X-Gm-Message-State: AOJu0Yz3iq5hBV5kzDwSsbANoYss/zbTvXNL5n7cNl2jIWY0TlB2mS3y
	bF7MG9SCAmNGnJQ4RPRHefMkxlTzRlvk0FZDS0Dgk6TReMb/B+mq5SRca8gXPw==
X-Gm-Gg: ASbGncsxpuoZVO6Rk1kKfgJcWRK7qV2FORbv0vEeDJAAf6tLThCypwFmKG4s3vkGZ4q
	aY9HyIVL2VLt6qe0mdZoLVCEx5e08KJ8xJoacAZWNc4ZIE73TVWR5l/Xm0jXfu35bH0JYeUcQuS
	mgm1fteFcHEMzYSsabPjRGF5/t7O0rQd2qmcGHdF/av1ZxprlrpuEyIAt4amzzBGOikviyghs51
	0M4AZmLoGs9kypnNQByJFaTOs9O/5gV95l9DCjhVW2prpVAfJxcdY/i4KI0IGBgGGaHGM+5s/MS
	EV2+uEaF3b9IjKw9I45w6woa0Qpm6qoeBh2lVWX742gHVQmhe7/4
X-Google-Smtp-Source: AGHT+IGVE1G1O60MZfdH3n5IFQcd9ydW9+Hse3HqjUF6Uin4zLpimyFelHt8Eav1kqxyrqLHgcNRWA==
X-Received: by 2002:a5d:64cf:0:b0:3a2:5c7:7a84 with SMTP id ffacd0b85a97d-3a35ffd2931mr3837643f8f.40.1747419130605;
        Fri, 16 May 2025 11:12:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583ff7sm40883935e9.26.2025.05.16.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:09 -0700 (PDT)
Message-Id: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:50 +0000
Subject: [PATCH v3 00/13] PATH WALK II: Add --path-walk option to 'git pack-objects'
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


Updates in v3
=============

Thanks for the review, Taylor. Sorry for my delay in getting back to your
feedback.

 * Documentation has been edited slightly for simplicity.
 * is_oid_interesting() was swapped to is_oid_uninteresting()
 * sub_list_size renamed to sub_list_nr
 * Several uint32_t and uint64_t variables were converted to size_t.
 * Several 'unsigned int' variables were required to stay as-is, for now,
   until a refactor can be done.
 * An unnecessary update of tag_objects was removed.
 * The logic and error message around incompatible options is simpler.
 * Tests are expanded, especially around config options.
 * Fixed commit message typos.
 * Extra care around ALLOC_ARRAY() to avoid a zero- or negative-length
   array.

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
 Documentation/config/pack.adoc             |   4 +
 Documentation/git-pack-objects.adoc        |  25 +-
 Documentation/git-repack.adoc              |   5 +-
 Documentation/technical/api-path-walk.adoc |   9 +
 builtin/pack-objects.c                     | 425 +++++++++++++++++++--
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
 t/t5516-fetch-push.sh                      |  10 +
 t/t5538-push-shallow.sh                    |  41 ++
 t/t6601-path-walk.sh                       |  20 +
 t/t7406-submodule-update.sh                |   3 +
 27 files changed, 620 insertions(+), 66 deletions(-)


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1819%2Fderrickstolee%2Fpath-walk-upstream-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1819/derrickstolee/path-walk-upstream-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1819

Range-diff vs v2:

  1:  57c1cc20de0 =  1:  57c1cc20de0 pack-objects: extract should_attempt_deltas()
  2:  a271d6245c2 !  2:  e3ea17e326e pack-objects: add --path-walk option
     @@ Documentation/git-pack-objects.adoc: many different directories. At the moment,
       will be automatically changed to version `1`.
       
      +--path-walk::
     -+	By default, `git pack-objects` walks objects in an order that
     -+	presents trees and blobs in an order unrelated to the path they
     -+	appear relative to a commit's root tree. The `--path-walk` option
     -+	enables a different walking algorithm that organizes trees and
     -+	blobs by path. This has the potential to improve delta compression
     -+	especially in the presence of filenames that cause collisions in
     -+	Git's default name-hash algorithm. Due to changing how the objects
     -+	are walked, this option is not compatible with `--delta-islands`,
     -+	`--shallow`, or `--filter`. The `--use-bitmap-index` option will
     -+	be ignored in the presence of `--path-walk.`
     ++	Perform compression by first organizing objects by path, then a
     ++	second pass that compresses across paths as normal. This has the
     ++	potential to improve delta compression especially in the presence
     ++	of filenames that cause collisions in Git's default name-hash
     ++	algorithm.
     +++
     ++Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
     ++`--use-bitmap-index` option will be ignored in the presence of
     ++`--path-walk.`
      +
       
       DELTA ISLANDS
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
       	}
       }
       
     -+static inline int is_oid_interesting(struct repository *repo,
     -+				     struct object_id *oid)
     ++static inline int is_oid_uninteresting(struct repository *repo,
     ++				       struct object_id *oid)
      +{
      +	struct object *o = lookup_object(repo, oid);
     -+	return o && !(o->flags & UNINTERESTING);
     ++	return !o || (o->flags & UNINTERESTING);
      +}
      +
      +static int add_objects_by_path(const char *path,
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      +			       enum object_type type,
      +			       void *data)
      +{
     -+	struct object_entry **delta_list;
     ++	struct object_entry **delta_list = NULL;
      +	size_t oe_start = to_pack.nr_objects;
      +	size_t oe_end;
     -+	unsigned int sub_list_size;
     ++	unsigned int sub_list_nr;
      +	unsigned int *processed = data;
      +
      +	/*
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      +					     OBJECT_INFO_FOR_PREFETCH) < 0)
      +			continue;
      +
     -+		exclude = !is_oid_interesting(the_repository, oid);
     ++		exclude = is_oid_uninteresting(the_repository, oid);
      +
      +		if (exclude && !thin)
      +			continue;
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      +	if (oe_end == oe_start || !window)
      +		return 0;
      +
     -+	sub_list_size = 0;
     -+	ALLOC_ARRAY(delta_list, oe_end - oe_start);
     ++	sub_list_nr = 0;
     ++	if (oe_end > oe_start)
     ++		ALLOC_ARRAY(delta_list, oe_end - oe_start);
      +
      +	for (size_t i = 0; i < oe_end - oe_start; i++) {
      +		struct object_entry *entry = to_pack.objects + oe_start + i;
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      +		if (!should_attempt_deltas(entry))
      +			continue;
      +
     -+		delta_list[sub_list_size++] = entry;
     ++		delta_list[sub_list_nr++] = entry;
      +	}
      +
      +	/*
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      +	 * consider creating a list of regions in the full to_pack.objects array
      +	 * that could be picked up by the threaded delta computation.
      +	 */
     -+	if (sub_list_size && window) {
     -+		QSORT(delta_list, sub_list_size, type_size_sort);
     -+		find_deltas(delta_list, &sub_list_size, window, depth, processed);
     ++	if (sub_list_nr && window) {
     ++		QSORT(delta_list, sub_list_nr, type_size_sort);
     ++		find_deltas(delta_list, &sub_list_nr, window, depth, processed);
      +	}
      +
      +	free(delta_list);
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
      +	info.revs = revs;
      +	info.path_fn = add_objects_by_path;
      +	info.path_fn_data = &processed;
     -+	revs->tag_objects = 1;
      +
      +	/*
      +	 * Allow the --[no-]sparse option to be interesting here, if only
     @@ builtin/pack-objects.c: static void mark_bitmap_preferred_tips(void)
       {
       	struct setup_revision_opt s_r_opt = {
      @@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, int ac, const char **av)
     - 
     - 	warn_on_object_refname_ambiguity = save_warning;
     - 
     --	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
     -+	if (use_bitmap_index && !path_walk && !get_object_list_from_bitmap(revs))
     - 		return;
     - 
     - 	if (use_delta_islands)
     -@@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, int ac, const char **av)
       	if (write_bitmap_index)
       		mark_bitmap_preferred_tips();
       
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	strvec_push(&rp, "pack-objects");
      -	if (thin) {
      +
     -+	if (path_walk && filter_options.choice) {
     -+		warning(_("cannot use --filter with --path-walk"));
     -+		path_walk = 0;
     -+	}
     -+	if (path_walk && use_delta_islands) {
     -+		warning(_("cannot use delta islands with --path-walk"));
     -+		path_walk = 0;
     -+	}
     -+	if (path_walk && shallow) {
     -+		warning(_("cannot use --shallow with --path-walk"));
     -+		path_walk = 0;
     ++	if (path_walk) {
     ++		const char *option = NULL;
     ++		if (filter_options.choice)
     ++			option = "--filter";
     ++		else if (use_delta_islands)
     ++			option = "--delta-islands";
     ++		else if (shallow)
     ++			option = "--shallow";
     ++
     ++		if (option) {
     ++			warning(_("cannot use %s with %s"),
     ++				option, "--path-walk");
     ++			path_walk = 0;
     ++		}
      +	}
      +	if (path_walk) {
      +		strvec_push(&rp, "--boundary");
  3:  dcff01392ff =  3:  6d65fce5cc3 pack-objects: update usage to match docs
  4:  97a0b52ccee !  4:  ad65148558e p5313: add performance tests for --path-walk
     @@ Commit message
          additions are made to the path walk API.
      
          The cases where the --path-walk option really shines is when the default
     -    name-hash is overwhelmed with collisions. An open source example can be
     -    found in the microsoft/fluentui repo [1] at a certain commit [2].
     +    name-hash is overwhelmed with unhelpful collisions. An open source
     +    example can be found in the microsoft/fluentui repo [1] at a certain
     +    commit [2].
      
          [1] https://github.com/microsoft/fluentui
          [2] e70848ebac1cd720875bccaa3026f4a9ed700e08
  5:  0d49bb3d30a !  5:  6ed6d4e3382 pack-objects: introduce GIT_TEST_PACK_PATH_WALK
     @@ Commit message
          when specified.
      
          This was useful in testing the implementation of the --path-walk
     -    implementation, especially in conjunction with test such as:
     +    implementation, helping to find tests that are overly specific to the
     +    default object walk. These include:
      
           - t0411-clone-from-partial.sh : One test fetches from a repo that does
             not have the boundary objects. This causes the path-based walk to
  6:  ddf804e606a !  6:  19c6651183a t5538: add tests to confirm deltas in shallow pushes
     @@ t/t5538-push-shallow.sh: EOF
      +	git -C deltas checkout -b deltas &&
      +	test_seq 1 1000 >deltas/a &&
      +	git -C deltas commit -a -m "bigger a" &&
     -+	GIT_TRACE2_PERF="$(pwd)/trace.txt" \
      +	GIT_PROGRESS_DELAY=0 git -C deltas push --progress origin deltas 2>err &&
      +
      +	test_grep "Enumerating objects: 5, done" err &&
  7:  11767e7653e !  7:  7f9e6a077bc repack: add --path-walk option
     @@ Documentation/git-repack.adoc: linkgit:git-multi-pack-index[1]).
       	See linkgit:git-pack-objects[1] for full details.
       
      +--path-walk::
     -+	This option passes the `--path-walk` option to the underlying
     -+	`git pack-options` process (see linkgit:git-pack-objects[1]).
     -+	By default, `git pack-objects` walks objects in an order that
     -+	presents trees and blobs in an order unrelated to the path they
     -+	appear relative to a commit's root tree. The `--path-walk` option
     -+	enables a different walking algorithm that organizes trees and
     -+	blobs by path. This has the potential to improve delta compression
     -+	especially in the presence of filenames that cause collisions in
     -+	Git's default name-hash algorithm. Due to changing how the objects
     -+	are walked, this option is not compatible with `--delta-islands`
     -+	or `--filter`.
     ++	Pass the `--path-walk` option to the underlying `git pack-objects`
     ++	process. See linkgit:git-pack-objects[1] for full details.
       
       CONFIGURATION
       -------------
  8:  dd66a5b46f2 !  8:  b98e71d6d54 pack-objects: enable --path-walk via config
     @@ Commit message
          settings infrastructure to make the new "pack.usePathWalk" config enabled by
          "feature.experimental" and "feature.manyFiles".
      
     +    In order to test that this config works, add a new trace2 region around
     +    the path walk code that can be checked by a 'git push' command.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/feature.adoc ##
     @@ Documentation/config/pack.adoc: pack.useSparse::
       	`true`.
       
      +pack.usePathWalk::
     -+	When true, git will default to using the '--path-walk' option in
     -+	'git pack-objects' when the '--revs' option is present. This
     -+	algorithm groups objects by path to maximize the ability to
     -+	compute delta chains across historical versions of the same
     -+	object. This may disable other options, such as using bitmaps to
     -+	enumerate objects.
     ++	Enable the `--path-walk` option by default for `git pack-objects`
     ++	processes. See linkgit:git-pack-objects[1] for full details.
      +
       pack.preferBitmapTips::
       	When selecting which commits will receive bitmaps, prefer a
       	commit at the tip of any reference that is a suffix of any value
      
       ## builtin/pack-objects.c ##
     +@@
     + #include "blob.h"
     + #include "tree.h"
     + #include "path-walk.h"
     ++#include "trace2.h"
     + 
     + /*
     +  * Objects we are going to pack are collected in the `to_pack` structure.
     +@@ builtin/pack-objects.c: static void get_object_list_path_walk(struct rev_info *revs)
     + {
     + 	struct path_walk_info info = PATH_WALK_INFO_INIT;
     + 	unsigned int processed = 0;
     ++	int result;
     + 
     + 	info.revs = revs;
     + 	info.path_fn = add_objects_by_path;
     +@@ builtin/pack-objects.c: static void get_object_list_path_walk(struct rev_info *revs)
     + 	 */
     + 	info.prune_all_uninteresting = sparse;
     + 
     +-	if (walk_objects_by_path(&info))
     ++	trace2_region_enter("pack-objects", "path-walk", revs->repo);
     ++	result = walk_objects_by_path(&info);
     ++	trace2_region_leave("pack-objects", "path-walk", revs->repo);
     ++
     ++	if (result)
     + 		die(_("failed to pack objects via path-walk"));
     + }
     + 
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       		if (use_bitmap_index > 0 ||
       		    !use_internal_rev_list)
     @@ repo-settings.h: struct repo_settings {
       	enum fetch_negotiation_setting fetch_negotiation_algorithm;
       
       	int core_multi_pack_index;
     +
     + ## t/t5516-fetch-push.sh ##
     +@@ t/t5516-fetch-push.sh: test_expect_success 'push with config push.useBitmaps' '
     + 		--thin --delta-base-offset -q --no-use-bitmap-index <false
     + '
     + 
     ++test_expect_success 'push with config pack.usePathWalk=true' '
     ++	mk_test testrepo heads/main &&
     ++	git checkout main &&
     ++	test_config pack.usePathWalk true &&
     ++	GIT_TRACE2_EVENT="$(pwd)/path-walk.txt" \
     ++	git push --quiet testrepo main:test &&
     ++
     ++	test_region pack-objects path-walk path-walk.txt
     ++'
     ++
     + test_done
  9:  e5624c379d5 =  9:  8e1d141a1f8 scalar: enable path-walk during push via config
 10:  622439d7855 ! 10:  2c1d8479872 pack-objects: refactor path-walk delta phase
     @@ Commit message
          This presents a new progress indicator that can be used in tests to
          verify that this stage is happening.
      
     -    The current implementation is not integrated with threads, but could be
     -    done in a future update.
     +    The current implementation is not integrated with threads, but we are
     +    setting it up to arrive in the next change.
      
          Since we do not attempt to sort objects by size until after exploring
          all trees, we can remove the previous change to t5530 due to a different
     @@ builtin/pack-objects.c: static int should_attempt_deltas(struct object_entry *en
      +				   unsigned int *processed)
      +{
      +	struct object_entry **delta_list;
     -+	uint32_t delta_list_nr = 0;
     ++	unsigned int delta_list_nr = 0;
      +
      +	ALLOC_ARRAY(delta_list, region->nr);
     -+	for (uint32_t i = 0; i < region->nr; i++) {
     ++	for (size_t i = 0; i < region->nr; i++) {
      +		struct object_entry *entry = list + region->start + i;
      +		if (should_attempt_deltas(entry))
      +			delta_list[delta_list_nr++] = entry;
     @@ builtin/pack-objects.c: static int should_attempt_deltas(struct object_entry *en
      +
      +static void find_deltas_by_region(struct object_entry *list,
      +				  struct packing_region *regions,
     -+				  uint32_t start, uint32_t nr)
     ++				  size_t start, size_t nr)
      +{
      +	unsigned int processed = 0;
     -+	uint32_t progress_nr;
     ++	size_t progress_nr;
      +
      +	if (!nr)
      +		return;
     @@ builtin/pack-objects.c: static int add_objects_by_path(const char *path,
       			       enum object_type type,
       			       void *data)
       {
     --	struct object_entry **delta_list;
     +-	struct object_entry **delta_list = NULL;
       	size_t oe_start = to_pack.nr_objects;
       	size_t oe_end;
     --	unsigned int sub_list_size;
     +-	unsigned int sub_list_nr;
       	unsigned int *processed = data;
       
       	/*
     @@ builtin/pack-objects.c: static int add_objects_by_path(const char *path,
       	if (oe_end == oe_start || !window)
       		return 0;
       
     --	sub_list_size = 0;
     --	ALLOC_ARRAY(delta_list, oe_end - oe_start);
     --
     --	for (size_t i = 0; i < oe_end - oe_start; i++) {
     --		struct object_entry *entry = to_pack.objects + oe_start + i;
     +-	sub_list_nr = 0;
     +-	if (oe_end > oe_start)
     +-		ALLOC_ARRAY(delta_list, oe_end - oe_start);
      +	ALLOC_GROW(to_pack.regions,
      +		   to_pack.nr_regions + 1,
      +		   to_pack.nr_regions_alloc);
       
     --		if (!should_attempt_deltas(entry))
     --			continue;
     --
     --		delta_list[sub_list_size++] = entry;
     --	}
     +-	for (size_t i = 0; i < oe_end - oe_start; i++) {
     +-		struct object_entry *entry = to_pack.objects + oe_start + i;
      +	to_pack.regions[to_pack.nr_regions].start = oe_start;
      +	to_pack.regions[to_pack.nr_regions].nr = oe_end - oe_start;
      +	to_pack.nr_regions++;
       
     +-		if (!should_attempt_deltas(entry))
     +-			continue;
     ++	*processed += oids->nr;
     ++	display_progress(progress_state, *processed);
     + 
     +-		delta_list[sub_list_nr++] = entry;
     +-	}
     +-
      -	/*
      -	 * Find delta bases among this list of objects that all match the same
      -	 * path. This causes the delta compression to be interleaved in the
     @@ builtin/pack-objects.c: static int add_objects_by_path(const char *path,
      -	 * consider creating a list of regions in the full to_pack.objects array
      -	 * that could be picked up by the threaded delta computation.
      -	 */
     --	if (sub_list_size && window) {
     --		QSORT(delta_list, sub_list_size, type_size_sort);
     --		find_deltas(delta_list, &sub_list_size, window, depth, processed);
     +-	if (sub_list_nr && window) {
     +-		QSORT(delta_list, sub_list_nr, type_size_sort);
     +-		find_deltas(delta_list, &sub_list_nr, window, depth, processed);
      -	}
     -+	*processed += oids->nr;
     -+	display_progress(progress_state, *processed);
     - 
     +-
      -	free(delta_list);
       	return 0;
       }
     @@ pack-objects.h: struct object_entry {
      + * as given by a starting index and a number of elements.
      + */
      +struct packing_region {
     -+	uint32_t start;
     -+	uint32_t nr;
     ++	size_t start;
     ++	size_t nr;
      +};
      +
       struct packing_data {
     @@ pack-objects.h: struct object_entry {
       	uint32_t nr_objects, nr_alloc;
       
      +	struct packing_region *regions;
     -+	uint64_t nr_regions, nr_regions_alloc;
     ++	size_t nr_regions, nr_regions_alloc;
      +
       	int32_t *index;
       	uint32_t index_size;
 11:  ae73d26319a ! 11:  623913f284e pack-objects: thread the path-based compression
     @@ Commit message
          overall time improves enough to outperform the --name-hash-version=1
          case. These time improvements correlate with repositories with data
          shapes that significantly improve their data size as well. The
     -    --path-walk feature frequently takes longer than --name-hash-verison=2,
     -    trading some extrac computation for some additional compression. The
     +    --path-walk feature frequently takes longer than --name-hash-version=2,
     +    trading some extra computation for some additional compression. The
          natural place where this additional computation comes from is the two
          compression passes that --path-walk takes, though the first pass is
          naturally faster due to the path boundaries avoiding a number of delta
     @@ builtin/pack-objects.c: static void find_deltas_by_region(struct object_entry *l
      +	}
      +
      +	if (progress > pack_to_stdout)
     -+		fprintf_ln(stderr, _("Path-based delta compression using up to %d threads"),
     ++		fprintf_ln(stderr,
     ++			   Q_("Path-based delta compression using up to %d thread",
     ++			      "Path-based delta compression using up to %d threads",
     ++			      delta_search_threads),
      +			   delta_search_threads);
      +	CALLOC_ARRAY(p, delta_search_threads);
      +
 12:  c45f35c204e = 12:  a14d447d35e path-walk: add new 'edge_aggressive' option
 13:  d5484ebd942 ! 13:  18241d38207 pack-objects: allow --shallow and --path-walk
     @@ builtin/pack-objects.c: static void get_object_list_path_walk(struct rev_info *r
       	info.prune_all_uninteresting = sparse;
      +	info.edge_aggressive = shallow;
       
     - 	if (walk_objects_by_path(&info))
     - 		die(_("failed to pack objects via path-walk"));
     + 	trace2_region_enter("pack-objects", "path-walk", revs->repo);
     + 	result = walk_objects_by_path(&info);
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       		     struct repository *repo UNUSED)
       {
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
       	struct strvec rp = STRVEC_INIT;
       	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc,
     - 		warning(_("cannot use delta islands with --path-walk"));
     - 		path_walk = 0;
     - 	}
     --	if (path_walk && shallow) {
     --		warning(_("cannot use --shallow with --path-walk"));
     --		path_walk = 0;
     --	}
     - 	if (path_walk) {
     - 		strvec_push(&rp, "--boundary");
     - 		 /*
     + 			option = "--filter";
     + 		else if (use_delta_islands)
     + 			option = "--delta-islands";
     +-		else if (shallow)
     +-			option = "--shallow";
     + 
     + 		if (option) {
     + 			warning(_("cannot use %s with %s"),
     +
     + ## t/t5538-push-shallow.sh ##
     +@@ t/t5538-push-shallow.sh: test_expect_success 'push new commit from shallow clone has good deltas' '
     + 
     + 	# If the delta base is found, then this message uses "bytes".
     + 	# If the delta base is not found, then this message uses "KiB".
     +-	test_grep "Writing objects: .* bytes" err
     ++	test_grep "Writing objects: .* bytes" err &&
     ++
     ++	git -C deltas commit --amend -m "changed message" &&
     ++	GIT_TRACE2_EVENT="$(pwd)/config-push.txt" \
     ++	GIT_PROGRESS_DELAY=0 git -C deltas -c pack.usePathWalk=true \
     ++		push --progress -f origin deltas 2>err &&
     ++
     ++	test_grep "Enumerating objects: 1, done" err &&
     ++	test_region pack-objects path-walk config-push.txt
     + '
     + 
     + test_done

-- 
gitgitgadget
