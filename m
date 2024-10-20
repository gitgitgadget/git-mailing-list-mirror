Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87184C7D
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431818; cv=none; b=qXqWGvy1MiuLIPmxYuv6JBwGHETzT2B/TLjhHCck0RRkFfwzgVcT1YymCbbal3Cn8zkiCHSlvYIbhiYcmZ8I9BKWqrdlvE7ZpXeCSxmo9dGU85eSMn6dxKx9XQHP4CMnqOH8GkHBhvjCFb5ekY3VufiRItuUm6QaLL4aRXDyHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431818; c=relaxed/simple;
	bh=zLVu1qS1hxVc0YoiHi8BI0EWZT6cXsyiAF4G0R9l/dc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WF5ffnVSiS3+8w2koNpCKeTp7GBI2gO8JbkkSKItzdLiuYgH9HSkg9fVKfDXZRKcBZ/qKKkro41nquHwT080ymzx5VTABNGmNz0W7IjKeL2bbXsLYZfiwpeWfptEUv/v8EuGjncrjj/S9OEMbu5XgBNYarpmrWi7/FPP/3T4BA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5985sG2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5985sG2"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0c40849cso555832466b.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431813; x=1730036613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/NgjZqUCjxi6kZdruvjsmuGmW0vtc/+U/w5uGnLZKc=;
        b=M5985sG2S8tj9dMA4xlIcTW8Plrw+ggirBMumxYKj/KtmSpNgKaEAqCTnjQHR9E1LU
         0IW0xGvPHBBLD+CgjFNrKELZbjVKpSBN3KucS288dZ7PZzv51kvUHv3NXMD9QJrJp0RU
         J8EQLS13XVJnsS+Vv+C82uI02fhgwC/vvhVl8TMIkSWiu9/NuZBTWew52GzcUJONQKM2
         r8wGPuYO1H/OED/jKgH4tRknd3Ap73WHRrWkKBWAkxnNMmb8U0F3ygZTjJRFsUbcXSww
         JIB549VZ9zV3IQWU1sr2YdtS7qo2z7H0LbRWNeMRIPmeyb7g3dHjMIdOzmW9+ZUOOo/D
         Rp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431813; x=1730036613;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/NgjZqUCjxi6kZdruvjsmuGmW0vtc/+U/w5uGnLZKc=;
        b=UcMnkVTEHiKUo3BveN1vE0MIIBk+I5dtvUfkHX5prC4FukA/3APnw0dla/2lEGibH6
         XXpNTeO8SEw4fHl+mRb23owX7e0tp1m46aDz0xEmyCKMWMBX73h57h3rEHhj8hMXlWVC
         qgKlHbDBOTeHLIZ5lnYUmjZRQWehUsq77uMMdNa0aflYN6YMn8BKuL3WH86IN3y61PrH
         Tt5QFnSwl3ymuPSgx8mQ1E8kFVQTMwGYpJGl+1l3ViYorTqRcpANnDNNrlY7AHp6hyPs
         mW7zioyM5agY5FUCINxCM3WpA9gZRfsv+sF0ZkaGyzVQ1Sxi8Qva0MdeutEGuXHRrVC4
         6qWQ==
X-Gm-Message-State: AOJu0Yxxpurto/0ImKrnM+8KvRSdoiOiND+iXxfz3idC0AGj5zXi7ctY
	iwNnjl0xK0ltv9vDBhXBlmG9HdnuwL12MxsYHQ8OR3afsi35xAyuOeNgTw==
X-Google-Smtp-Source: AGHT+IH5xz9O0WePfE+Oi7WO/oWACExqcI4Lw5kiEKLtc5/1xk4h0CyT5158uZ69RG43MbMTQqEdlw==
X-Received: by 2002:a17:907:7b82:b0:a99:d6e1:6044 with SMTP id a640c23a62f3a-a9a6996d1aamr685762766b.3.1729431813079;
        Sun, 20 Oct 2024 06:43:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6579sm92294366b.41.2024.10.20.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:32 -0700 (PDT)
Message-Id: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:13 +0000
Subject: [PATCH v2 00/17] pack-objects: add --path-walk option for better deltas
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
    Derrick Stolee <stolee@gmail.com>

This is a reviewable series introducing the path-walk API and its
application within the 'git pack-objects --path-walk' machinery. This API
was previously discussed in the path-walk RFC [1] and the patch series
around the --full-name-hash option (branch ds/pack-name-hash-tweak) [2].
This series conflicts with ds/pack-name-hash-tweak, but that was on hold
because it did not seem as critical based on community interest.

[1]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com

[2]
https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.com

The primary motivation for this feature is its use to shrink the packfile
created by 'git push' when there are many name-hash collisions. This need
was discovered in several Javascript repositories that use the beachball
tool [3] to generate CHANGELOG.md and CHANGELOG.json files. When a batch of
these files are created at the same time and pushed to a release branch, the
'git pack-objects' process has many collisions among these files and delta
bases are selected poorly.

[3] https://github.com/microsoft/beachball

In some cases, 'git push' is pushing 60-100 MB when the new path-walk
algorithm will identify better delta bases and pack the same objects into a
thin pack less than 1 MB. This was the most extreme example we could find
and is present in a private monorepo. However, the microsoft/fluentui repo
[4] is a good example for demonstrating similar improvements. The patch
descriptions frequently refer to this repo and which commit should be
checked out to reproduce this behavior.

[4] https://github.com/microsoft/fluentui

The path-walk API is a new way to walk objects. Traditionally, the revision
API walks objects by visiting a commit, then visiting its root tree and
recursing through trees to visit reachable objects that were not previously
visited. The path-walk API visits objects in batches based on the path
walked from a root tree to that object. (Only the first discovered path is
chosen; this avoids certain kinds of Git bombs.)

This has an immediate application to 'git pack-objects'.

When using the traditional revision API to walk objects, each object is
emitted with an associated path. Since this path may appear for many objects
spread across the full list, a heuristic is used: the "name-hash" is stored
for that object instead of the full path name. This name-hash will group
objects at the same path together, but also has a form of "locality" to
group likely-similar objects together. When there are few collisions in the
name-hash function, this helps compress objects that appear at the same path
as well as help compress objects across different paths that have similar
suffixes. When there are many versions of the same path, then finding delta
bases across that family of objects is very important. When there are few
versions of the same path, then finding cross-name delta bases is also
important. The former is important for clones and repacks while the latter
is important for shallow clones. They can both be important for pushes. In
all cases, this approach is fraught when there are many name-hash collisions
as the window size becomes a limiting factor for finding quality delta
bases.

When using the path-walk API to walk objects, we group objects by the same
path from the start. We don't need to store the path name, since we have the
objects already in a group. We can compute deltas within that group and then
use the name-hash approach to resort the object list and look for
opportunistic cross-path deltas. Thus, the path-walk approach allows finding
delta bases at least as good as the traditional revision API approach.
(Caveat: if we assume delta reuse and the existing deltas were computed with
the revision API approach, then the path-walk API approach may result in
slightly worse delta compression. The performance tests in this series use
--no-reuse-delta for this reason.)

Once 'git pack-objects --path-walk' exists, we have a few ways to take
advantage of it in other places:

 * The new 'pack.usePathWalk' config option will assume the --path-walk
   option. This allows 'git push' to assume this value and get the effect we
   want. This is similar to the 'pack.useSparse' config option that uses a
   similar path-based walk to limit the set of boundary objects.

 * 'git repack' learns a '--path-walk' option to pass to its child 'git
   pack-objects' process. This is also implied by 'pack.usePathWalk' but
   allows for testing without modifying repository config.

I'll repeat the following table of repacking results when using 'git repack
-adf [--path-walk]' on a set of repositories with many name-hash collisions.
Only the microsoft/fluentui repository is publicly available for testing, so
the others are left as Repo B/C/D.

| Repo     | Standard Repack | With --path-walk |
|----------|-----------------|------------------|
| fluentui |         438 MB  |          148 MB  |
| Repo B   |       6,255 MB  |          778 MB  |
| Repo C   |      37,737 MB  |        6,158 MB  |
| Repo D   |     130,049 MB  |        4,432 MB  |


While this series is replacing ds/pack-name-hash-tweak and its introduction
of the --full-name-hash option, it is worth comparing that option to the
--path-walk option.

 * The --full-name-hash option is a much smaller code change, as it drops
   into the existing uses of the name-hash function.

 * The --full-name-hash option is more likely to integrate with server-side
   features such as delta islands and reachability bitmaps due to not
   changing the object walk. It was already noted that the .bitmap files
   store name-hash values, so there is some compatibility required to
   integrate with bitmaps. The --path-walk option will be more difficult to
   integrate with those options (at least during a repack), but maybe is not
   impossible; the --path-walk option will not work when reading
   reachability bitmaps, since we are avoiding walking trees entirely.

 * The --full-name-hash option is good when there are many name-hash
   collisions and many versions of the paths with those collisions. When
   creating a shallow clone or certain kinds of pushes, the --full-name-hash
   option is much worse at finding cross-path delta bases since it loses the
   locality of the standard name-hash function. The --path-walk option
   includes a second pass of delta computation using the standard name-hash
   function and thus finds good cross-path delta bases when they improve
   upon the same-path delta bases.

There are a few differences from the RFC version of this series:

 1. The last two patches refactor the approach to perform delta calculations
    by path after the object walk and then allows those delta calculations
    to happen in a threaded manner.

 2. Both 'git pack-objects' and 'git repack' are removed from the t0450
    exclusion list.

 3. The path-walk API has improved technical documentation that is extended
    as its functionality is expanded.

 4. Various bugs have been patched with matching tests. The new 'test-tool
    path-walk' helper allows for careful testing of the API separately from
    its use within other commands.


Updates in v2
=============

I'm sending this v2 to request some review feedback on the series. I'm sorry
it's so long.

There are two updates in this version:

 * Fixed a performance issue in the presence of many annotated tags. This is
   caught by p5313 when run on a repo with 10,000+ annotated tags.
 * The Scalar config was previously wrong and should be pack.usePathWalk,
   not push.usePathWalk.

Thanks, - Stolee

Derrick Stolee (17):
  path-walk: introduce an object walk by path
  t6601: add helper for testing path-walk API
  path-walk: allow consumer to specify object types
  path-walk: allow visiting tags
  revision: create mark_trees_uninteresting_dense()
  path-walk: add prune_all_uninteresting option
  pack-objects: extract should_attempt_deltas()
  pack-objects: add --path-walk option
  pack-objects: update usage to match docs
  p5313: add performance tests for --path-walk
  pack-objects: introduce GIT_TEST_PACK_PATH_WALK
  repack: add --path-walk option
  repack: update usage to match docs
  pack-objects: enable --path-walk via config
  scalar: enable path-walk during push via config
  pack-objects: refactor path-walk delta phase
  pack-objects: thread the path-based compression

 Documentation/config/feature.txt          |   4 +
 Documentation/config/pack.txt             |   8 +
 Documentation/git-pack-objects.txt        |  23 +-
 Documentation/git-repack.txt              |  17 +-
 Documentation/technical/api-path-walk.txt |  73 ++++
 Makefile                                  |   2 +
 builtin/pack-objects.c                    | 410 ++++++++++++++++++++--
 builtin/repack.c                          |   9 +-
 ci/run-build-and-tests.sh                 |   1 +
 pack-objects.h                            |  12 +
 path-walk.c                               | 406 +++++++++++++++++++++
 path-walk.h                               |  64 ++++
 repo-settings.c                           |   3 +
 repo-settings.h                           |   1 +
 revision.c                                |  15 +
 revision.h                                |   1 +
 scalar.c                                  |   1 +
 t/README                                  |   4 +
 t/helper/test-path-walk.c                 | 114 ++++++
 t/helper/test-tool.c                      |   1 +
 t/helper/test-tool.h                      |   1 +
 t/perf/p5313-pack-objects.sh              |  77 ++++
 t/t0411-clone-from-partial.sh             |   6 +
 t/t0450/txt-help-mismatches               |   2 -
 t/t5300-pack-object.sh                    |  21 ++
 t/t5306-pack-nobase.sh                    |   5 +
 t/t5310-pack-bitmaps.sh                   |  13 +-
 t/t5316-pack-delta-depth.sh               |   9 +-
 t/t5332-multi-pack-reuse.sh               |   7 +
 t/t6601-path-walk.sh                      | 301 ++++++++++++++++
 t/t7406-submodule-update.sh               |   4 +
 31 files changed, 1565 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/technical/api-path-walk.txt
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h
 create mode 100644 t/helper/test-path-walk.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/t6601-path-walk.sh


base-commit: e9356ba3ea2a6754281ff7697b3e5a1697b21e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1813%2Fderrickstolee%2Fpath-walk-upstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1813/derrickstolee/path-walk-upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1813

Range-diff vs v1:

  1:  98bdc94a773 =  1:  98bdc94a773 path-walk: introduce an object walk by path
  2:  a00ab0c62c9 =  2:  a00ab0c62c9 t6601: add helper for testing path-walk API
  3:  14375d19392 =  3:  14375d19392 path-walk: allow consumer to specify object types
  4:  6f48cddadc0 !  4:  c321f58c62d path-walk: allow visiting tags
     @@ path-walk.c: int walk_objects_by_path(struct path_walk_info *info)
      +			if (obj->type == OBJ_COMMIT || obj->flags & SEEN)
      +				continue;
      +
     -+			obj->flags |= SEEN;
     -+
      +			while (obj->type == OBJ_TAG) {
      +				struct tag *tag = lookup_tag(info->revs->repo,
      +							     &obj->oid);
     -+				if (oid_array_lookup(&tags, &obj->oid) < 0)
     ++				if (!(obj->flags & SEEN)) {
     ++					obj->flags |= SEEN;
      +					oid_array_append(&tags, &obj->oid);
     ++				}
      +				obj = tag->tagged;
      +			}
      +
     ++			if ((obj->flags & SEEN))
     ++				continue;
     ++			obj->flags |= SEEN;
     ++
      +			switch (obj->type) {
      +			case OBJ_TREE:
     -+				if (info->trees &&
     -+				    oid_array_lookup(&root_tree_list->oids, &obj->oid) < 0)
     ++				if (info->trees)
      +					oid_array_append(&root_tree_list->oids, &obj->oid);
      +				break;
      +
      +			case OBJ_BLOB:
     -+				if (info->blobs &&
     -+				    oid_array_lookup(&tagged_blob_list, &obj->oid) < 0)
     ++				if (info->blobs)
      +					oid_array_append(&tagged_blob_list, &obj->oid);
      +				break;
      +
  5:  cd98447f7c8 =  5:  6e89fb219b5 revision: create mark_trees_uninteresting_dense()
  6:  214e10a9984 =  6:  238d7d95715 path-walk: add prune_all_uninteresting option
  7:  cd360ad1040 =  7:  3fdb57edbc5 pack-objects: extract should_attempt_deltas()
  8:  f8ee11d3003 =  8:  a0475c7cba8 pack-objects: add --path-walk option
  9:  eaeb40980f4 =  9:  73c8b61e87b pack-objects: update usage to match docs
 10:  3113ead1e01 = 10:  21dc3723c36 p5313: add performance tests for --path-walk
 11:  211a16ae889 = 11:  6f96b1c227a pack-objects: introduce GIT_TEST_PACK_PATH_WALK
 12:  507ed0f6f90 = 12:  834c9ea2709 repack: add --path-walk option
 13:  eae96e8214f = 13:  6ef8d67af4b repack: update usage to match docs
 14:  2a9ae02217f = 14:  1db90e361ba pack-objects: enable --path-walk via config
 15:  adcb3167809 ! 15:  0f3040b4b90 scalar: enable path-walk during push via config
     @@ scalar.c: static int set_recommended_config(int reconfigure)
       		{ "core.autoCRLF", "false" },
       		{ "core.safeCRLF", "false" },
       		{ "fetch.showForcedUpdates", "false" },
     -+		{ "push.usePathWalk", "true" },
     ++		{ "pack.usePathWalk", "true" },
       		{ NULL, NULL },
       	};
       	int i;
 16:  c3f24dc3647 = 16:  030d8ec238e pack-objects: refactor path-walk delta phase
 17:  264affbf058 = 17:  fddc320eb0b pack-objects: thread the path-based compression

-- 
gitgitgadget
