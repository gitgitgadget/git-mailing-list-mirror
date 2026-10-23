Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740379;
	b=CwN+4oFIvqESu25x4O7Nvm7+AeLKaAHF3L90yOcUCNHSf+1sDEj4NHwuijJ3F5Dn5cPD
	 plfzQ4BJIBX3xUhhZKM3vVCnYxXUk0bkAsUkWpPIvxwqe3qN/BOFfPVWUn3bajCLK4Yip
	 FGEUCJu28A9bRjbf9K09TvKIQ32F2PyXQY/V2cGj385Z19a9U3IX22yqUMM3DM/L6fN3p
	 zpQd9QRWIASkXwYxpFSvY0VBoojB1Glx9GthR7oBN52ra+e8bfLI6WdwE9DQA+VlpNadZ
	 EaQZOr7ggMgFJ2MnzpFoEH1RVFQYkQQS1cCwQbSZ8VhVAJULZZm0dZMOyGrSyfxyaWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fY4ioWpbqKnJCYU9Nk8GZ1Hygj5yGnWsGnvtV0IXkaA=;
	b=rpPQXlBruYTLxzZxuyYS96epjYlB3ODnArGTk4cnLPts094sz2Ts/Lg88ZwneX+S6GjO
	 wd1GnZSek6qkw4n+GLTMgYXNIq2AjZx/5maIQt3fYviXBlPuXIVGc154pw1c5dLv9533d
	 jWa8TYBhLJt9dueeUYHtavusoANf1yBUMycJGH9/J8H/sZqqrr5GdObYAlPI4FA9Fp3kU
	 idcCb3K74OQY16M5hwiswcayN6d9X0gLHGmul54Q/wpfMumkLOf1M/0w4FeDczkQuHjVw
	 RIDuJI0Qf20ofOkGW4SbERPMcKCrZahXVToTq4Sq96S0f5NrmzZlsnk4xGPDooEcZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zuz4o9B9;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1A606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA1A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zuz4o9B9
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4be28b82so427913f8f.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740376; x=1793345176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fY4ioWpbqKnJCYU9Nk8GZ1Hygj5yGnWsGnvtV0IXkaA=;
        b=Zuz4o9B9lps6W2kNVDFooTf8BkMJWj4vuxTOynkk53XZrH1bA4caX2Ps8bAZqMXRlj
         JHlMdxWxRoWTtW0+iOK36OmjrZ/wZQ1Mrvw1sYiBirZMAOUBtA+sTwIbZVOHaYScb5bH
         ZZlXpcSG9XfnbICvet43ntfT4FRKTYVDNIRFlrOont2W4UJkVI57imQfWGhSW854DVHU
         DGoJheMnFx6uV0PJbyQV/How7AxvKGDK2tgwDS+KlUPwuK52d95QiBSSSWnWj1FmklIg
         NnyKWKtgGktdDQKUglvOTY8GQs1bxGt4TpUlvyUN/uzvQ1/KoeIfl9nRYb/pmN2rCvHk
         yhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740376; x=1793345176;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fY4ioWpbqKnJCYU9Nk8GZ1Hygj5yGnWsGnvtV0IXkaA=;
        b=VMMx59dEClR/cnMEHFknyWntTGjZolhbzRPlHKhhIB1ePZp2Dyl9HpsZ01UJzEP9yU
         sSgabnxqvpZtwypwVDugTDIQJtkUTPmRe2qyTEQoedA1pCGFPzeKTNnKaOwF/VlQTYdW
         XL2PvF5lzGGHrsmemd+xi3y6I1LzhM9iyK6Nq5pEh82fx0Tt6psiKGPMY6g8CFf+pE4U
         aZrVqeRx3RBD8PG2JpiXXoAMg+euhbq2i8PGptkDAGTQ9D2tZb61Gxe67KnfEy6a7SuI
         waC5ZdfHURwgHjq7dU47oRHb/CzZID6KvzFKbx8KNZrGSzl6Q0QN2S3bSdmnx14DfbSd
         rdiw==
X-Gm-Message-State: AFq9FYIg5w5esc/vG9lJqJkTzBEBrk0p8KY1TMNV1upun84eVQECodFL
	QOsRRHpHW/4kqzgKRx2WvZRL4gWY6fA7elRlwg//wRLxZ4QlPmp7F9pKtGtT1Q==
X-Gm-Gg: AYBFou37PAu9HUoIjWgI+Lxyarq2xB8w9SIfd4UW76slO7LlisB6qYmXPwwWcqOtQRj
	0799nkXFRBz4VC4TJsEwJeQCDxSmQx4s+caeOKj6x3SlYn1gOij4blnngab0Z8hkRILT4Q/wXye
	02/nED++io3pezsYaips6+DupVhEuq47mYfycKXx9ewP7tgAE3zuu3A1lzYaQb237ghvcbG6dZJ
	1kvjqal3jNtv7Yg/KQ3lNcg5jIomYo4wOZj4OEhEY1AfARkdRk2M3282T03wdsNDU3dbnj4Txqf
	7IKU1qTMAMvjH/ddAsJg3FKOQNt6FCGdwFoLeHnYk9Z4KLd57hWKgaNmUUq3YtbNG7I4lfrG3pg
	Zgui/ykMhMFBWh+nFr9j00bKGvnpFRwFcPBi+JBrXrHQbIB9h8yCdTiatNvEONScGxVi5Yrm0db
	/NBhWs77BBGOUrPCpBDLoJ1bBzApvo5jGnq2LscRu0wiGuuWWRqHbrhJJej7UzgwLW+lRGTNSzQ
	NFoCfuZTMuc/i9DN4MdESJJMI8SXSIBST/3nLkkfDA49xDidRawxGNDrxNNPFCrxEIZRtMBpexv
	Zh1zNsm5gi/GDInBwrnn9M0BKrZXKePpiLtNgse6TfwCre7kKGuNFIfWR+Fux7NaFCxntyc9cNn
	xrdq6RlHtO/ZtYhzs4qtlBhLQdeLiTaPDZ2yg0Jbu0ohJW9BkUZp/25l8Kp+xvP8rEQ==
X-Received: by 2002:a05:6000:4382:b0:48e:38e:3102 with SMTP id ffacd0b85a97d-48e3859af6dmr2139672f8f.29.1792740375376;
        Fri, 23 Oct 2026 00:26:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 00/13] SHA-1/SHA-256 interoperability, part 3: pack index v3
Date: Fri, 23 Oct 2026 09:25:45 +0200
Message-ID: <20261023072559.3204273-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is the next part of brian m. carlson's SHA-1/SHA-256
interoperability work.

It adds support for reading and writing pack index v3, which stores
object IDs in both the main and the compatibility hash
algorithms. Interoperability needs it so that packed objects can be
mapped between algorithms, the same way the loose object map already
does for loose objects.

## Base

This MR targets `master` at 47fdf2208c (The 7th batch, 2026-10-19).

## Origin of the patches

Patches 1-9 and 11-12 are the first 11 commits of brian's
`sha256-interop-part-2` branch (https://github.com/bk2204/git.git,
b175380036), which brian suggested for upstreaming [1].

Patch 10 is a new patch I inserted to validate pack index v3
tables.

Patch 13, which copies pack index v3 documentation, comes from his
full `sha256-interop` branch.

All patches except patch 10 are authored by brian.

[1]: https://lore.kernel.org/git/asV1oB_avuEbgRVe@fruit.crustytoothpaste.net/

## Previous work and naming of this series

Previously, brian sent the following to the mailing list:

 - A patch series called `bc/sha1-256-interop-01` merged at 98401c10fc
   (Merge branch 'bc/sha1-256-interop-01', 2025-10-22).

 - A patch series called `bc/sha1-256-interop-02` merged at 8194f1795b
   (Merge branch 'bc/sha1-256-interop-02', 2026-03-12).

So this series is called "part 3" even though it comes mostly from
brian's `sha256-interop-part-2` branch.

## Overview of the patches

 - Patches 1-5 add `odb_map_oid()` and `odb_write_oid_map()`, backed
   by two new `struct odb_source` callbacks, `map_oid()` and
   `write_oid_map()`, which the "files", "loose" and "packed" backends
   implement.

 - Patches 6-12 implement pack index v3 writing (pack-write,
   index-pack) and reading (packfile), and use it to look up compat
   object IDs in packs.

 - Patch 13 copies the pack index v3 format documentation into
   `gitformat-pack(5)`.

## Changes compared to brian's branch

My `Signed-off-by: ...` was added to all the patches. AI assistance
(mostly Claude Opus 5.5) was used.

 - Patches 1 and 4 are adapted to `ps/odb-files-alternates`. There is
   now a single `odb->source`, so `odb_map_oid()` and
   `odb_write_oid_map()` just dispatch to it. The files backend checks
   each of its object directories in turn (main directory first, then
   alternates) and writes mappings into the main directory, like it
   does for objects. The `read_alternates` callbacks are dropped, as
   the topic removed them.

 - In patch 4, the commit message was improved to describe how the
   "files" backend looks up and writes mappings.

 - In patch 4, the `odb/source.h` comments about the flags of the
   `map_oid()` and `write_oid_map()` callbacks have been fixed. They
   wrongly said the flags were unused.

 - In patch 6, the `QSORT()` that was added to
   `builtin/pack-objects.c` is dropped. It sorted `to_pack.nr_objects`
   entries while only the first `nr_written` were set, and it was
   redundant anyway, as `write_idx_file()` always sorts the array by
   object ID before returning. The comment of `write_idx_file()` and
   the commit message now say so.

 - In patch 6, when asked to reject duplicate objects (`--strict`),
   the v3 writer now looks for them in the arrays sorted by object ID,
   where duplicates are adjacent: it compares main object IDs in the
   array sorted by main object ID, and compatibility object IDs in the
   array sorted by compatibility object ID. (Previously, the main
   object IDs were only compared between entries that are next to each
   other in pack order, so without a compatibility algorithm, a pack
   containing objects A, B, A, B was accepted. With a compatibility
   algorithm, the check over the array sorted by compatibility object
   ID compared main object IDs, so it did not detect two different
   objects with the same compatibility object ID.)

 - In patch 7, `index-pack` no longer passes `OBJ_MAP_WRITE` when
   recording the compat object IDs it computes, so they stay in memory
   as the commit message and the code comment say, like in brian's
   full `sha256-interop` branch.

 - In patches 7 and 8, the compat hash contexts are initialized with
   `git_hash_init()` instead of the raw `init_fn()` callback, as since
   9e396aa553 (hash: check ctx->active flag in all wrapper functions,
   2026-07-07), `git_hash_update()` refuses contexts that were not
   initialized that way. Without this,
   `git index-pack --index-version=3` and adding a large file both hit
   a `BUG()` in a repository with a compatibility algorithm.

 - Patch 7 adds a test to t5308 to check that `index-pack --strict`
   rejects duplicate objects when writing a v3 index.

 - Patches 7, 8, 11 and 12 now also add tests to t1016 for the
   problems fixed in them, which were not covered before. They use a
   new small `create_compat_repo()` helper introduced in patch 7.

 - In patch 9, a few fixes have been implemented:

  - `bsearch_pack_v3()` now reports an object as not found, instead of
    dividing by zero, when looking it up in an algorithm for which a
    v3 index has no data.
  
  - The `munmap()` calls on errors in `load_idx()` are removed, as the
    caller already unmaps the file, like for older index versions.

  - The main algorithm is retrieved from the hash size instead of the
    repository, so that it works without a repository, for example in
    the fuzzer.

 - Patch 10 is new. It validates pack index v3 tables, mostly in
   `load_idx()`:

  - The header length, the trailer offset, the format entries and the
    position of all tables are checked against the file size.
  
  - Duplicate formats and invalid short name lengths are rejected.

  - When building the reverse index from a v3 index, the 8-byte
    offsets are now checked to lie within the index.

  - The positions read from the order maps are also checked against
    the number of objects when they are used: an invalid one now makes
    Git die() with a "corrupt index?" error, or makes a lookup report
    the object as not found, instead of reading outside the index. A
    test for this is added to t5313.

 - In patch 11, mapping now skips packs that don't have a v3 index,
   and `nth_packed_object_id_algop()` fails instead of returning bytes
   from the wrong table when an index cannot provide the requested
   mapping. Previously, in a compat repo, a packed object whose
   mapping was not in the loose object map got a wrong compat object
   ID.

 - In patch 12, looking up objects by an abbreviated compatibility
   object ID now reads the object IDs, and the offsets, at the
   positions of the table sorted by that algorithm, through
   `nth_packed_object_id_algop()` and a new
   `nth_packed_object_offset_algop()`. (Previously the main object ID
   at that position was compared against the compat prefix, so such
   lookups returned wrong or missing results.)

 - In patch 12, the compatibility algorithm is also skipped for packs
   with an index older than v3, which only store main object IDs. So
   when looking up a prefix in any algorithm, the callback no longer
   fires twice for the same object in such packs.

 - Patch 13 now says that a v3 index has 1 or 2 object formats (both
   the reader and the writer accept a single one), and it points to
   the hash function transition document for the "Loose objects and
   unreachable objects" section, which this document doesn't have.

Except that I added my `Signed-off-by: ...` to them, patches 2, 3 and
5 are unchanged.

## Things not yet implemented

 - The test suite can't run with `GIT_TEST_DEFAULT_HASH=sha256:sha1`
   yet, because accepting `<algo>:<compat>` in `GIT_DEFAULT_HASH`
   comes later in brian's series.

 - Index v3 is not yet automatically selected in compat repos, and
   `show-index` can't read v3 yet. Both come later in brian's series.

 - In a compat repo, `git index-pack` can only compute the compat
   object ID of a commit, tree or tag if the objects it references
   already have a mapping. As packs usually list commits before their
   trees and parents, indexing a pack that brings new objects, for
   example from a fetch, fails with "unable to map tree … in commit
   object". brian's full `sha256-interop` branch handles this in later
   commits, starting with "builtin/index-pack: map straggling
   objects", by converting such objects after the whole pack has been
   read, in dependency order.

 - Resolving an abbreviated compatibility object ID only works with
   commands like `git cat-file` or
   `git rev-parse --output-object-format=<compat>`, not with a plain
   `git rev-parse`, and the packed `find_abbrev_len()` callback
   doesn't handle compatibility object IDs yet.

 - A multi-pack-index only stores main object IDs, so abbreviated
   compatibility object IDs of objects in packs covered by a
   multi-pack-index are not found. The t1016 test for abbreviated
   compatibility object IDs therefore disables
   `GIT_TEST_MULTI_PACK_INDEX`.

 - In the "files" backend, `odb_map_oid()` doesn't re-read
   info/alternates before retrying. `read_object_info()` doesn't
   either on master, but Patrick's "PATCH 0/4 odb/files: reload
   alternates on retry again" series [2] restores that for
   it. `odb_map_oid()` should follow the same logic once that series
   is merged. I have started working on this.

 - No protocol support yet.

[2] https://lore.kernel.org/git/20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im/

## Changes compared to v1

Thanks to Junio for his comments on this series.

The only change compared to v1 is that I added my `Signed-off-by: ...`
to patches 2, 3 and 5 (that are otherwise unchanged compared to
brian's original patches).

## Range-diff against brian's original work

 1:  4e1f77f06a !  1:  1f24f793f0 loose: allow looking up in object map with source
    @@ Commit message
         future.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## loose.c ##
     @@ loose.c: int repo_add_loose_object_map(struct odb_source_loose *loose,
    @@ loose.c: int repo_add_loose_object_map(struct odb_source_loose *loose,
      			      const struct git_hash_algo *to,
      			      struct object_id *dest)
      {
    - 	struct odb_source *source;
    + 	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
     -	kh_oid_map_t *map;
     -	khiter_t pos;
      
    - 	for (source = repo->objects->sources; source; source = source->next) {
    - 		struct odb_source_files *files = odb_source_files_downcast(source);
    --		struct loose_object_map *loose_map = files->loose->map;
    + 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
    +-		struct loose_object_map *loose_map = dir->loose->map;
     -		if (!loose_map)
     +		int ret;
     +
    -+		if (!files->loose)
    ++		if (!dir->loose)
      			continue;
     -		map = (to == repo->compat_hash_algo) ?
     -			loose_map->to_compat :
    @@ loose.c: int repo_add_loose_object_map(struct odb_source_loose *loose,
     -			oidcpy(dest, kh_value(map, pos));
     -			return 0;
     -		}
    -+		ret = source_loose_object_map_oid(files->loose, src, to, dest);
    ++		ret = source_loose_object_map_oid(dir->loose, src, to, dest);
     +		if (ret != -1)
     +			return ret;
      	}
 2:  b36496537a !  2:  042aed1783 loose: rename repo_add_loose_object_map
    @@ Commit message
         database abstraction in a future commit.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## loose.c ##
     @@ loose.c: static int write_one_object(struct odb_source_loose *loose,
 3:  cb123eb81b !  3:  9da3b460cb loose: add a flag to control whether we write mapped OIDs
    @@ Commit message
         so pick 1 << 6 as the write bit to avoid conflicts.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## loose.c ##
     @@ loose.c: static int write_one_object(struct odb_source_loose *loose,
 4:  4b74282d13 !  4:  45fe8d6076 odb: implement interoperability functions
    @@ Metadata
      ## Commit message ##
         odb: implement interoperability functions
     
    -    An object database running with a compatibility algorithm needs a way to
    -    map object IDs from one algorithm to another and to write mappings into
    -    the repository.  Add these functions and implement them for our loose
    -    and packed backends so that we can use them in the future.
    +    An object database running with a compatibility algorithm needs a way
    +    to map object IDs from one algorithm to another and to write mappings
    +    into the repository.  Add these functions and implement them for the
    +    "files" backend and for the "loose" and "packed" sources it is made of,
    +    so that we can use them in the future.
     
    -    Note that the packed backends don't write any information, since that
    +    Like when reading objects, the "files" backend looks up mappings in all
    +    of its object directories. It starts with the main one and continues
    +    with alternates, which is what the loose object map code already does.
    +
    +    If a mapping is not found in a directory, the loose object map of that
    +    directory is reloaded and checked again, as another process may have
    +    written new mappings in the meantime. New mappings are only written
    +    into the main object directory, which is also where new objects are
    +    written.
    +
    +    Note that the "packed" sources don't write any information, since that
         will be written when we index the pack, and they don't currently read
         any information, since we don't yet have support for pack index v3,
         which we'll need to read this properly.  This functionality will come
         in a future commit.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## odb.c ##
     @@ odb.c: int odb_count_objects(struct object_database *odb,
    @@ odb.c: int odb_count_objects(struct object_database *odb,
     +		struct object_id *dest,
     +		enum odb_map_oid_flags flags)
     +{
    -+	struct odb_source *source;
    -+	int ret;
    -+
    -+	odb_prepare_alternates(odb, NULL);
    -+	for (source = odb->sources; source; source = source->next) {
    -+		ret = odb_source_map_oid(source, src, to, dest, flags);
    -+		if (ret != -1)
    -+			return ret;
    -+	}
    -+	return -1;
    ++	return odb_source_map_oid(odb->source, src, to, dest, flags);
     +}
     +
     +int odb_write_oid_map(struct object_database *odb,
    @@ odb.c: int odb_count_objects(struct object_database *odb,
     +		      const struct object_id *compat_oid,
     +		      enum odb_write_oid_map_flags flags)
     +{
    -+	struct odb_source *source;
    -+
    -+	odb_prepare_alternates(odb, NULL);
    -+	for (source = odb->sources; source; source = source->next)
    -+		if (!odb_source_write_oid_map(source, oid, compat_oid, flags))
    -+			return 0;
    -+	return -1;
    ++	return odb_source_write_oid_map(odb->source, oid, compat_oid, flags);
     +}
    ++
      /*
       * Return the slot of the most-significant bit set in "val". There are various
       * ways to do this quickly with fls() or __builtin_clzl(), but speed is
    @@ odb/source-files.c
      #include "object-file.h"
      #include "odb.h"
      #include "odb/source.h"
    -@@ odb/source-files.c: static int odb_source_files_fsck(struct odb_source *source,
    - 	return ret;
    +@@ odb/source-files.c: struct odb_files_dir *odb_source_files_find_dir(struct object_database *odb, con
    + 	return dir;
      }
      
     +static int odb_source_files_map_oid(struct odb_source *source,
    @@ odb/source-files.c: static int odb_source_files_fsck(struct odb_source *source,
     +				    enum odb_map_oid_flags flags)
     +{
     +	struct odb_source_files *files = odb_source_files_downcast(source);
    -+	int ret;
    -+	ret = odb_source_map_oid(&files->loose->base, src, to, dest, flags);
    -+	if (ret != -1)
    -+		return ret;
    -+	ret = odb_source_map_oid(&files->packed->base, src, to, dest, flags);
    -+	if (ret != -1)
    -+		return ret;
    -+	return odb_source_map_oid(&files->loose->base, src, to, dest, flags | ODB_MAP_OID_RELOAD);
    ++
    ++	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
    ++		int ret;
    ++
    ++		ret = odb_source_map_oid(&dir->loose->base, src, to, dest, flags);
    ++		if (ret != -1)
    ++			return ret;
    ++		ret = odb_source_map_oid(&dir->packed->base, src, to, dest, flags);
    ++		if (ret != -1)
    ++			return ret;
    ++		ret = odb_source_map_oid(&dir->loose->base, src, to, dest,
    ++					 flags | ODB_MAP_OID_RELOAD);
    ++		if (ret != -1)
    ++			return ret;
    ++	}
    ++
    ++	return -1;
     +}
     +
     +static inline int odb_source_files_write_oid_map(struct odb_source *source,
    @@ odb/source-files.c: static int odb_source_files_fsck(struct odb_source *source,
     +						 enum odb_write_oid_map_flags flags)
     +{
     +	struct odb_source_files *files = odb_source_files_downcast(source);
    -+	return odb_source_write_oid_map(&files->loose->base, oid, compat_oid, flags);
    ++	return odb_source_write_oid_map(&files->dirs->loose->base, oid, compat_oid, flags);
     +}
     +
      struct odb_source_files *odb_source_files_new(struct object_database *odb,
    - 					      const char *path,
    - 					      bool local)
    + 					      enum odb_new_flags flags)
    + {
     @@ odb/source-files.c: struct odb_source_files *odb_source_files_new(struct object_database *odb,
    + 	files->base.write_object = odb_source_files_write_object;
      	files->base.write_object_stream = odb_source_files_write_object_stream;
      	files->base.begin_transaction = odb_source_files_begin_transaction;
    - 	files->base.read_alternates = odb_source_files_read_alternates;
     +	files->base.map_oid = odb_source_files_map_oid;
     +	files->base.write_oid_map = odb_source_files_write_oid_map;
      	files->base.optimize = odb_source_files_optimize;
    @@ odb/source-loose.c: static void odb_source_loose_reparent(const char *old_cwd,
     +	 * let's reload the map to see if the object has appeared.
     +	 */
     +	if (flags & ODB_MAP_OID_RELOAD)
    -+		repo_read_loose_object_map(source->odb->repo);
    ++		loose_object_map_load(loose);
     +	return source_loose_object_map_oid(loose, src, to, dest);
     +}
     +
    @@ odb/source-loose.c: static void odb_source_loose_reparent(const char *old_cwd,
      {
      	struct odb_source_loose *loose = odb_source_loose_downcast(source);
     @@ odb/source-loose.c: struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
    + 	loose->base.write_object = odb_source_loose_write_object;
      	loose->base.write_object_stream = odb_source_loose_write_object_stream;
      	loose->base.begin_transaction = odb_source_loose_begin_transaction;
    - 	loose->base.read_alternates = odb_source_loose_read_alternates;
     +	loose->base.map_oid = odb_source_loose_map_oid;
     +	loose->base.write_oid_map = odb_source_loose_write_oid_map;
      
    @@ odb/source-packed.c: static void odb_source_packed_close(struct odb_source *sour
      {
      	struct odb_source_packed *packed = odb_source_packed_downcast(source);
     @@ odb/source-packed.c: struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
    + 	packed->base.write_object = odb_source_packed_write_object;
      	packed->base.write_object_stream = odb_source_packed_write_object_stream;
      	packed->base.begin_transaction = odb_source_packed_begin_transaction;
    - 	packed->base.read_alternates = odb_source_packed_read_alternates;
     +	packed->base.map_oid = odb_source_packed_map_oid;
     +	packed->base.write_oid_map = odb_source_packed_write_oid_map;
      
    @@ odb/source.h: struct odb_source {
     +	/*
     +	 * This callback is expected to provide the mapping of an object from
     +	 * the algorithm specified in src to the algorithm specified in to,
    -+	 * leaving the result in dest.  flags is required, but so far unused; it
    -+	 * should be set to 0.
    ++	 * leaving the result in dest.  flags is a combination of `enum
    ++	 * odb_map_oid_flags` values: with ODB_MAP_OID_RELOAD, the source should
    ++	 * reload its mapping data before the lookup, as another process may
    ++	 * have written new mappings in the meantime.
     +	 *
     +	 * The algo field in src must point to a valid algorithm (specifically,
     +	 * it must not be zero).  to must likewise point to a valid algorithm;
    @@ odb/source.h: struct odb_source {
     +
     +	/*
     +	 * This callback is expected to write a mapping of an object between oid
    -+	 * and compat_oid. flags is required, but so far unused; it should be
    -+	 * set to 0.
    ++	 * and compat_oid.  flags is a combination of `enum
    ++	 * odb_write_oid_map_flags` values: with ODB_WRITE_OID_MAP_WRITE, the
    ++	 * mapping should be persisted to disk; otherwise it may only be kept in
    ++	 * memory.
     +	 *
     +	 * The algo fields in oid and compat_oid must point to valid algorithms
     +	 * (specifically, they must not be zero).
 5:  c5781631c6 !  5:  69dc3ffea6 object-file-convert: implement mapping in terms of object DB
    @@ Commit message
         issues.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## object-file-convert.c ##
     @@
 6:  885edd8636 !  6:  c2123917c7 pack-write: add support for pack index v3
    @@ Commit message
         doing so will break the tests.  In a future commit, once we can read it,
         we'll enable it by default when a compatibility algorithm is enabled.
     
    -    Since we're not sorting the array unconditionally in write_idx_file, be
    -    sure to sort it where necessary.
    +    Index v3 needs the objects both in pack order and sorted by object ID,
    +    so when writing a v3 index, sort copies of the array instead of the
    +    array itself.  Callers, like the bitmap code in pack-objects, rely on
    +    the array being sorted by object ID when write_idx_file() returns,
    +    though, so sort it before returning in that case too.
     
    -    Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    When asked to reject duplicate objects using `--strict`, look for them
    +    in the arrays sorted by object ID, where duplicates are adjacent.
     
    - ## builtin/pack-objects.c ##
    -@@
    -  */
    - static struct packing_data to_pack;
    - 
    -+static int oid_compare(const void *_a, const void *_b)
    -+{
    -+	struct pack_idx_entry *a = *(struct pack_idx_entry **)_a;
    -+	struct pack_idx_entry *b = *(struct pack_idx_entry **)_b;
    -+	return oidcmp(&a->oid, &b->oid);
    -+}
    -+
    - static inline struct object_entry *oe_delta(
    - 		const struct packing_data *pack,
    - 		const struct object_entry *e)
    -@@ builtin/pack-objects.c: static void write_pack_file(void)
    - 			if (write_bitmap_index) {
    - 				size_t tmpname_len = tmpname.len;
    - 
    -+				QSORT(written_list, to_pack.nr_objects, oid_compare);
    -+
    - 				strbuf_addstr(&tmpname, "bitmap");
    - 				stop_progress(&progress_state);
    - 
    +    Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## pack-write.c ##
     @@ pack-write.c: void reset_pack_idx_option(struct pack_idx_option *opts)
    @@ pack-write.c: static int need_large_offset(off_t offset, const struct pack_idx_o
     - * The *sha1 contains the pack content SHA1 hash.
     - * The objects array passed in will be sorted by SHA1 on exit.
     + * The *hash contains the pack content hash.
    -+ * The objects array passed in should be in pack order and may be sorted (or
    -+ * not) on return.
    ++ * The objects array passed in should be in pack order and will be sorted by
    ++ * object ID on return.
       */
      const char *write_idx_file(struct repository *repo,
      			   const char *index_name, struct pack_idx_entry **objects,
    @@ pack-write.c: const char *write_idx_file(struct repository *repo,
     +		for (i = 0; i < nr_objects; i++) {
     +			struct pack_idx_entry *obj = *list++;
     +			hashwrite(f, obj->oid.hash, short_name_len[0]);
    ++			if ((opts->flags & WRITE_IDX_STRICT) &&
    ++			    (i && oideq(&list[-2]->oid, &obj->oid)))
    ++				die("The same object %s appears twice in the pack",
    ++				    oid_to_hex(&obj->oid));
     +		}
     +	} else {
     +		/*
    @@ pack-write.c: const char *write_idx_file(struct repository *repo,
      	for (i = 0; i < nr_objects; i++) {
      		struct pack_idx_entry *obj = *list++;
      		if (index_version < 2)
    -@@ pack-write.c: const char *write_idx_file(struct repository *repo,
    + 			hashwrite_be32(f, obj->offset);
    + 		hashwrite(f, obj->oid.hash, repo->hash_algo->rawsz);
    +-		if ((opts->flags & WRITE_IDX_STRICT) &&
    ++		if ((opts->flags & WRITE_IDX_STRICT) && index_version < 3 &&
    + 		    (i && oideq(&list[-2]->oid, &obj->oid)))
    + 			die("The same object %s appears twice in the pack",
      			    oid_to_hex(&obj->oid));
      	}
      
    @@ pack-write.c: const char *write_idx_file(struct repository *repo,
     +			struct pack_idx_entry *obj = *list++;
     +			hashwrite(f, obj->compat_oid.hash, short_name_len[1]);
     +			if ((opts->flags & WRITE_IDX_STRICT) &&
    -+			    (i && oideq(&list[-2]->oid, &obj->oid)))
    ++			    (i && oideq(&list[-2]->compat_oid, &obj->compat_oid)))
     +				die("The same object %s appears twice in the pack",
     +				    oid_to_hex(&obj->compat_oid));
     +		}
    @@ pack-write.c: const char *write_idx_file(struct repository *repo,
     +		for (i = 0; i < nr_objects; i++) {
     +			struct pack_idx_entry *obj = *list++;
     +			hashwrite(f, obj->compat_oid.hash, compat->rawsz);
    -+			if ((opts->flags & WRITE_IDX_STRICT) &&
    -+			    (i && oideq(&list[-2]->oid, &obj->oid)))
    -+				die("The same object %s appears twice in the pack",
    -+				    oid_to_hex(&obj->compat_oid));
     +		}
     +
     +		/* write the sorted-to-pack index */
 7:  fe70d52c3a !  7:  8ced7b7a0b builtin: populate pack index v3 fields when indexing
    @@ Commit message
         and release the mutex between the conversion and writing to the map
         because hashing may be slow.
     
    +    Add a test in t1016 to check that index-pack can write a v3 index in a
    +    repository with a compatibility algorithm, and a test that it rejects
    +    packs with duplicate objects when writing a v3 index with `--strict`.
    +
    +    Also add a create_compat_repo() helper in t1016 to refactor common
    +    code.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## builtin/index-pack.c ##
     @@
    @@ builtin/index-pack.c: static void *unpack_entry_data(off_t offset, size_t size,
      		git_hash_update(&c, hdr, hdrlen);
     -	} else
     +		if (compat && compat_oid) {
    -+			compat->init_fn(&c_compat);
    ++			git_hash_init(&c_compat, compat);
     +			if (type == OBJ_BLOB)
    -+				compat->update_fn(&c_compat, hdr, hdrlen);
    ++				git_hash_update(&c_compat, hdr, hdrlen);
     +		}
     +	} else {
      		oid = NULL;
    @@ builtin/index-pack.c: static void *unpack_entry_data(off_t offset, size_t size,
     +		}
     +		git_hash_final_oid(compat_oid, &c_compat);
     +		repo_lock();
    -+		odb_write_oid_map(the_repository->objects, oid, compat_oid, OBJ_MAP_WRITE);
    ++		odb_write_oid_map(the_repository->objects, oid, compat_oid, 0);
     +		repo_unlock();
     +	}
      	return buf == fixed_buf ? NULL : buf;
    @@ builtin/index-pack.c: static struct base_data *resolve_delta(struct object_entry
     +		repo_lock();
     +		odb_write_oid_map(the_repository->objects,
     +				  &delta_obj->idx.oid,
    -+				  &delta_obj->idx.compat_oid,
    -+				  OBJ_MAP_WRITE);
    ++				  &delta_obj->idx.compat_oid, 0);
     +		repo_unlock();
     +		strbuf_release(&outbuf);
     +	}
    @@ builtin/pack-objects.c: static int option_parse_index_version(const struct optio
      		die(_("unsupported index version %s"), val);
      	if (*c == ',' && c[1])
      		popts->off32_limit = strtoul(c+1, &c, 0);
    +
    + ## t/t1016-compatObjectFormat.sh ##
    +@@ t/t1016-compatObjectFormat.sh: compat_hash () {
    + 	esac
    + }
    + 
    ++create_compat_repo () {
    ++	local hash="$1"
    ++	local repo="$2"
    ++
    ++	git init --object-format="$hash" "$repo" &&
    ++	git -C "$repo" config set core.repositoryformatversion 1 &&
    ++	git -C "$repo" config set extensions.compatObjectFormat $(compat_hash "$hash")
    ++}
    ++
    + hello_oid () {
    + 	case "$1" in
    + 	"sha1")
    +@@ t/t1016-compatObjectFormat.sh: do
    + 		for repo in alt borrow
    + 		do
    + 			test_when_finished "rm -rf $repo" &&
    +-			git init --object-format=$hash $repo &&
    +-			git -C $repo config set core.repositoryformatversion 1 &&
    +-			git -C $repo config set extensions.compatObjectFormat $(compat_hash $hash) || exit 1
    ++			create_compat_repo $hash $repo || exit 1
    + 		done &&
    + 
    + 		git -C alt commit --allow-empty --message A &&
    +@@ t/t1016-compatObjectFormat.sh: do
    + 		git -C borrow rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
    + 		test_cmp expect actual
    + 	'
    ++
    ++	test_expect_success 'index-pack writes pack index v3' '
    ++		test_when_finished "rm -rf v3-repo v3.idx" &&
    ++		create_compat_repo $hash v3-repo &&
    ++		echo content >v3-repo/file &&
    ++		git -C v3-repo add file &&
    ++		git -C v3-repo commit --message A &&
    ++		git -C v3-repo commit --allow-empty --message B &&
    ++		git -C v3-repo repack -a -d &&
    ++		pack=$(echo v3-repo/.git/objects/pack/pack-*.pack) &&
    ++		git -C v3-repo index-pack --index-version=3 \
    ++			-o "$(pwd)/v3.idx" "$(pwd)/$pack" &&
    ++		echo "ff 74 4f 63 00 00 00 03 " >expect &&
    ++		test_copy_bytes 8 <v3.idx | test-tool hexdump >actual &&
    ++		test_cmp expect actual
    ++	'
    + done
    + cd "$base"
    + 
    +
    + ## t/t5308-pack-detect-duplicates.sh ##
    +@@ t/t5308-pack-detect-duplicates.sh: test_expect_success 'index-pack can reject packs with duplicates' '
    + 	test_expect_code 1 git cat-file -e $LO_SHA1
    + '
    + 
    ++test_expect_success 'index-pack can reject packs with duplicates with index v3' '
    ++	clear_packs &&
    ++	create_pack dups.pack 2 &&
    ++	test_must_fail git index-pack --strict --index-version=3 --stdin <dups.pack &&
    ++	test_expect_code 1 git cat-file -e $LO_SHA1
    ++'
    ++
    + test_done
 8:  cb593fd7dd !  8:  75e70ed1c1 object-file: handle compatibility algorithm
    @@ Commit message
         the main algorithm or we will incorrectly store the null OID in the
         index we create.  Do so here to avoid corrupting the repository.
     
    +    Add a test that adds a large file in a repository with a compatibility
    +    algorithm.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## object-file.c ##
     @@ object-file.c: static int hash_stream(struct odb_stream *stream,
    @@ object-file.c: static int odb_transaction_files_write_object_stream(struct odb_t
      	git_hash_init(&ctx, transaction->base.source->odb->repo->hash_algo);
      	git_hash_update(&ctx, obuf, header_len);
     +	if (compat) {
    -+		compat->init_fn(&compat_ctx);
    ++		git_hash_init(&compat_ctx, compat);
     +		git_hash_update(&compat_ctx, obuf, header_len);
     +	}
      
    @@ object-file.c: static int odb_transaction_files_write_object_stream(struct odb_t
      		ALLOC_GROW(state->written,
      			   state->nr_written + 1,
      			   state->alloc_written);
    +
    + ## t/t1016-compatObjectFormat.sh ##
    +@@ t/t1016-compatObjectFormat.sh: do
    + 		test_copy_bytes 8 <v3.idx | test-tool hexdump >actual &&
    + 		test_cmp expect actual
    + 	'
    ++
    ++	test_expect_success 'add a large file streamed into a pack' '
    ++		test_when_finished "rm -rf large-repo" &&
    ++		create_compat_repo $hash large-repo &&
    ++		git -C large-repo config set core.bigFileThreshold 1k &&
    ++		test-tool genrandom large 5000 >large-repo/large &&
    ++		git -C large-repo add large &&
    ++		ls large-repo/.git/objects/pack/pack-*.pack &&
    ++		git -C large-repo hash-object large >expect &&
    ++		git -C large-repo rev-parse :large >actual &&
    ++		test_cmp expect actual &&
    ++		git -C large-repo cat-file blob :large >actual &&
    ++		test_cmp large-repo/large actual
    ++	'
    + done
    + cd "$base"
    + 
 9:  c401efada9 !  9:  036a8fa8cc packfile: add support for reading pack index v3
    @@ Commit message
         larger.  We can then use it when finding the offset into the file, since
         it will be generic over both v2 and v3 indices.
     
    +    A v3 index may contain data for only one hash algorithm, so just fail if
    +    we look up an object ID in an algorithm for which the index has no data.
    +
         In the pack revindex, we use the order map for the algorithm in question
         to look up the proper offset into the pack index, since we're iterating
         over objects in the offset table, which is sorted by object ID, not pack
    @@ Commit message
         formats can't represent the SHA-1 values.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
    @@ packfile.c: int load_idx(const char *path, const unsigned int hashsz, void *idx_
      			return error("pack too large for current definition of off_t in %s", path);
      		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
     +	} else if (version == 3) {
    -+		uint32_t hdrlen, num_formats, trailer_offset;
    ++		uint32_t hdrlen, num_formats, trailer_offset, main_algo;
     +		const uint32_t *q = index;
     +		int i;
     +
     +		hdrlen = ntohl(*q++);
    -+		if (idx_size < hdrlen) {
    -+			munmap(idx_map, idx_size);
    ++		if (idx_size < hdrlen)
     +			return error("v3 index has truncated header");
    -+		}
     +
     +		nr = ntohl(*q++);
     +		num_formats = ntohl(*q++);
    -+		if (num_formats < 1 || num_formats > ARRAY_SIZE(p->formats)) {
    -+			munmap(idx_map, idx_size);
    ++		if (num_formats < 1 || num_formats > ARRAY_SIZE(p->formats))
     +			return error("too many formats for v3 index");
    -+		}
     +		memset(p->formats, 0, sizeof(p->formats));
     +		for (i = 0; i < num_formats; i++) {
     +			uint32_t format_id = ntohl(*q++);
     +			uint32_t format = hash_algo_by_id(format_id);
     +			struct packed_git_format *pfp;
     +
    -+			if (format == GIT_HASH_UNKNOWN) {
    -+				munmap(idx_map, idx_size);
    ++			if (format == GIT_HASH_UNKNOWN)
     +				return error("v3 index with unknown format_id 0x%08x", format_id);
    -+			}
     +			/*
     +			 * We store at the value of the constant minus 1 to
     +			 * avoid having to store a useless entry at offset 0.
    @@ packfile.c: int load_idx(const char *path, const unsigned int hashsz, void *idx_
     +			if (!i)
     +				p->crc_offset = pfp->order_map_offset + nr * 4;
     +		}
    -+		if (!p->formats[p->repo->hash_algo - hash_algos - 1].data_offset) {
    -+			munmap(idx_map, idx_size);
    ++		main_algo = hash_algo_by_length(hashsz);
    ++		if (main_algo == GIT_HASH_UNKNOWN ||
    ++		    !p->formats[main_algo - 1].data_offset)
     +			return error("v3 index with missing data for this repository's algorithm");
    -+		}
     +		trailer_offset = get_be64(q);
    -+		if (trailer_offset + 2 * hashsz != idx_size) {
    -+			munmap(idx_map, idx_size);
    ++		if (trailer_offset + 2 * hashsz != idx_size)
     +			return error("v3 index with bad size\n");
    -+		}
      	}
      
      	p->index_version = version;
    @@ packfile.c: void *unpack_entry(struct repository *r, struct packed_git *p, off_t
     +	const struct packed_git_format *pfp = &p->formats[algo - 1];
     +	const unsigned char *data = p->index_data;
     +
    ++	/* This index has no data for the algorithm of the object ID. */
    ++	if (!pfp->data_offset) {
    ++		if (result)
    ++			*result = 0;
    ++		return 0;
    ++	}
    ++
     +	return bsearch_hash_v3(oid->hash, data + pfp->full_oid_offset,
     +			       (const uint32_t *)(data + pfp->order_map_offset),
     +			       data + pfp->data_offset,
 -:  ---------- > 10:  5e8aaa8329 packfile: validate pack index v3 tables
10:  cbfbb56596 ! 11:  4d575f34ed loose: map object IDs using pack index v3
    @@ Commit message
         In order to do so, let's add a variant of nth_packed_object_id that
         handles an arbitrary hash algorithm.
     
    +    Only pack index v3 stores object IDs in more than one algorithm, so
    +    skip packs with an older index when mapping.
    +
    +    Also make the new variant fail when the index cannot provide the
    +    requested object ID, for example because it has no data for one of the
    +    algorithms.
    +
    +    Add a test in t1016 to check that packed objects are mapped using a v3
    +    index, but not using a v2 index, when the loose object map has no entry
    +    for them.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## odb/source-packed.c ##
     @@ odb/source-packed.c: static void odb_source_packed_close(struct odb_source *source)
    @@ odb/source-packed.c: static void odb_source_packed_close(struct odb_source *sour
     +
     +		if (open_pack_index(p) || !p->num_objects)
     +			continue;
    ++		/* Only v3 indices store object IDs in both algorithms. */
    ++		if (p->index_version < 3)
    ++			continue;
     +		if (!bsearch_pack(src, p, &off))
     +			continue;
    -+		return nth_packed_object_id_algop(dest, p, off, src_algo, to);
    ++		if (nth_packed_object_id_algop(dest, p, off, src_algo, to))
    ++			continue;
    ++		return 0;
     +	}
      	return -1;
      }
    @@ packfile.c: int bsearch_pack(const struct object_id *oid, const struct packed_gi
      		if (open_pack_index(p))
      			return -1;
     @@ packfile.c: int nth_packed_object_id(struct object_id *oid,
    + 	}
    + 	if (n >= p->num_objects)
    + 		return -1;
    ++	if (p->index_version < 3 && (src != dest || dest != p->repo->hash_algo))
    ++		return -1; /* older indices only store main object IDs */
      	if (p->index_version == 1) {
      		index += 4 * 256;
      		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
    @@ packfile.c: int nth_packed_object_id(struct object_id *oid,
     +		int algo = hash_algo_by_ptr(dest);
      		const struct packed_git_format *pfp = &p->formats[algo-1];
     -		oidread(oid, index + pfp->full_oid_offset + (hashsz * n), p->repo->hash_algo);
    -+		uint32_t pack_order_idx = nth_packed_object_pack_order_algop(p, n, src);
    ++		uint32_t pack_order_idx;
    ++
    ++		if (!pfp->data_offset ||
    ++		    !p->formats[hash_algo_by_ptr(src) - 1].data_offset)
    ++			return -1; /* no data for one of the algorithms */
    ++		pack_order_idx = nth_packed_object_pack_order_algop(p, n, src);
     +		oidread(oid, index + st_add(pfp->full_oid_offset, st_mult(hashsz, pack_order_idx)), dest);
      	}
      	return 0;
    @@ packfile.h: int bsearch_pack(const struct object_id *oid, const struct packed_gi
      /*
       * Return the offset of the nth object within the specified packfile.
       * The index must already be opened.
    +
    + ## t/t1016-compatObjectFormat.sh ##
    +@@ t/t1016-compatObjectFormat.sh: do
    + 		git -C large-repo cat-file blob :large >actual &&
    + 		test_cmp large-repo/large actual
    + 	'
    ++
    ++	test_expect_success 'packed objects are only mapped using pack index v3' '
    ++		test_when_finished "rm -rf map-repo v3.idx loose-object-idx" &&
    ++		create_compat_repo $hash map-repo &&
    ++		echo content >map-repo/file &&
    ++		git -C map-repo add file &&
    ++		git -C map-repo commit --message A &&
    ++		oid=$(git -C map-repo rev-parse HEAD) &&
    ++		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >expect &&
    ++		git -C map-repo repack -a -d &&
    ++		pack=$(echo map-repo/.git/objects/pack/pack-*.pack) &&
    ++		git -C map-repo index-pack --index-version=3 \
    ++			-o "$(pwd)/v3.idx" "$(pwd)/$pack" &&
    ++		mv map-repo/.git/objects/loose-object-idx loose-object-idx &&
    ++
    ++		# A v2 index only has object IDs in the main algorithm, so it
    ++		# must not provide a mapping.
    ++		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
    ++		! test_cmp expect actual &&
    ++		test $(wc -c <actual) -ne $(($(test_oid --hash=$(compat_hash $hash) hexsz) + 1)) &&
    ++
    ++		# A v3 index provides it.
    ++		rm -f "${pack%.pack}.idx" "${pack%.pack}.rev" &&
    ++		mv v3.idx "${pack%.pack}.idx" &&
    ++		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
    ++		test_cmp expect actual
    ++	'
    + done
    + cd "$base"
    + 
11:  f60e1e2c0d ! 12:  ce5de5c8c5 packfile: allow looking up compat object IDs in packs
    @@ Commit message
         it is easier to understand as two statements.  The compiler will
         optimize it appropriately.
     
    +    When looking up an object ID, we find positions in the table sorted by
    +    that object ID's algorithm. So read the object IDs there for that
    +    algorithm with nth_packed_object_id_algop(), and add
    +    nth_packed_object_offset_algop() to get their offsets.
    +
    +    Skip the compatibility algorithm for packs with an index older than v3,
    +    as these only store object IDs in the main algorithm.
    +
    +    Add a test that looks up an abbreviated compatibility object ID of a
    +    packed object.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## odb/source-packed.c ##
     @@ odb/source-packed.c: static int for_each_prefixed_object_in_pack(
    @@ odb/source-packed.c: static int for_each_prefixed_object_in_pack(
     +		    (!p->repo->compat_hash_algo ||
     +		     algop != p->repo->compat_hash_algo))
     +			continue;
    -+
    ++		if (p->index_version < 3 && algop != p->repo->hash_algo)
    ++			continue;
     +
     +		oidcpy(&wanted, opts->prefix);
     +		wanted.algo = algo;
    @@ odb/source-packed.c: static int for_each_prefixed_object_in_pack(
     +		for (i = first; i < num; i++) {
     +			struct object_id oid;
     +
    -+			nth_packed_object_id(&oid, p, i);
    -+			if (!match_hash(len, opts->prefix->hash, oid.hash))
    ++			if (nth_packed_object_id_algop(&oid, p, i, algop, algop) ||
    ++			    !match_hash(len, opts->prefix->hash, oid.hash))
     +				break;
     +
     +			if (data->request) {
     +				struct object_info oi = *data->request;
    -+				off_t offset = nth_packed_object_offset(p, i);
    ++				off_t offset = nth_packed_object_offset_algop(p, i, algop);
     +
     +				ret = packed_object_info(source, p, offset, &oi);
     +				if (ret)
    @@ odb/source-packed.c: static int for_each_prefixed_object_in_pack(
      		}
      	}
      
    +
    + ## packfile.c ##
    +@@ packfile.c: void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
    + }
    + 
    + off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
    ++{
    ++	return nth_packed_object_offset_algop(p, n, p->repo->hash_algo);
    ++}
    ++
    ++off_t nth_packed_object_offset_algop(const struct packed_git *p, uint32_t n,
    ++				     const struct git_hash_algo *algop)
    + {
    + 	const unsigned char *index = p->index_data;
    + 	const unsigned int hashsz = p->repo->hash_algo->rawsz;
    ++
    ++	if (p->index_version < 3 && algop != p->repo->hash_algo)
    ++		BUG("pack index v%d only stores main object IDs",
    ++		    p->index_version);
    ++
    + 	if (p->index_version == 1) {
    + 		index += 4 * 256;
    + 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
    + 	} else {
    + 		uint32_t off;
    + 		if (p->index_version == 3)
    +-			n = nth_packed_object_pack_order_algop(p, n, p->repo->hash_algo);
    ++			n = nth_packed_object_pack_order_algop(p, n, algop);
    + 		index += st_add(p->crc_offset, st_mult(p->num_objects, 4));
    + 		off = ntohl(*((uint32_t *)(index + st_mult(4, n))));
    + 		if (!(off & 0x80000000))
    +
    + ## packfile.h ##
    +@@ packfile.h: int nth_packed_object_id_algop(struct object_id *, struct packed_git *,
    +  */
    + off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
    + 
    ++/*
    ++ * The same as nth_packed_object_offset, but the nth object is counted in
    ++ * algop. For indices older than v3, algop must be the main algorithm.
    ++ */
    ++off_t nth_packed_object_offset_algop(const struct packed_git *, uint32_t n,
    ++				     const struct git_hash_algo *algop);
    ++
    + /*
    +  * Return the index into pack order of the nth object within the specified
    +  * packfile.  The index must already be opened and it must be a v3 index.
    +
    + ## t/t1016-compatObjectFormat.sh ##
    +@@ t/t1016-compatObjectFormat.sh: do
    + 		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
    + 		test_cmp expect actual
    + 	'
    ++
    ++	test_expect_success 'abbreviated compat object IDs are found using pack index v3' '
    ++		test_when_finished "rm -rf abbrev-repo v3.idx" &&
    ++		create_compat_repo $hash abbrev-repo &&
    ++		echo content >abbrev-repo/file &&
    ++		git -C abbrev-repo add file &&
    ++		git -C abbrev-repo commit --message A &&
    ++		compat_oid=$(git -C abbrev-repo rev-parse --output-object-format=$(compat_hash $hash) HEAD) &&
    ++		abbrev=$(echo $compat_oid | cut -c 1-12) &&
    ++
    ++		# A multi-pack-index only stores object IDs in the main
    ++		# algorithm.
    ++		GIT_TEST_MULTI_PACK_INDEX=0 git -C abbrev-repo repack -a -d &&
    ++		pack=$(echo abbrev-repo/.git/objects/pack/pack-*.pack) &&
    ++		git -C abbrev-repo index-pack --index-version=3 \
    ++			-o "$(pwd)/v3.idx" "$(pwd)/$pack" &&
    ++		rm abbrev-repo/.git/objects/loose-object-idx &&
    ++
    ++		# A v2 index only has object IDs in the main algorithm.
    ++		test_must_fail git -C abbrev-repo cat-file -t $abbrev &&
    ++
    ++		rm -f "${pack%.pack}.idx" "${pack%.pack}.rev" &&
    ++		mv v3.idx "${pack%.pack}.idx" &&
    ++		echo commit >expect &&
    ++		git -C abbrev-repo cat-file -t $abbrev >actual &&
    ++		test_cmp expect actual &&
    ++		echo $compat_oid >expect &&
    ++		git -C abbrev-repo rev-parse --output-object-format=$(compat_hash $hash) $abbrev >actual &&
    ++		test_cmp expect actual
    ++	'
    + done
    + cd "$base"
    + 
12:  6afaf2ff9e ! 13:  50f515b9aa doc: move pack index v3 documentation
    @@ Commit message
         compatibility.
     
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/gitformat-pack.adoc ##
     @@ Documentation/gitformat-pack.adoc: Pack file entry: <+
    @@ Documentation/gitformat-pack.adoc: Pack file entry: <+
     +    * 4-byte length of the header section, including the signature and
     +      version number
     +    * 4-byte number of objects contained in the pack
    -+    * 4-byte number of object formats in this pack index: 2
    ++    * 4-byte number of object formats in this pack index: 1 or 2
     +    * For each object format:
     +      ** 4-byte format identifier (e.g., 'sha1' for SHA-1)
     +      ** 4-byte length in bytes of shortened object names. This is the
    @@ Documentation/gitformat-pack.adoc: Pack file entry: <+
     +    * 8-byte offset to the trailer from the beginning of this file.
     +    * Zero or more additional key/value pairs (4-byte key, 4-byte
     +      value). Only one key is supported: 'PSRC'. See the "Loose objects
    -+      and unreachable objects" section for supported values and how this
    -+      is used.  All other keys are reserved. Readers must ignore
    ++      and unreachable objects" section of the hash function transition
    ++      document (`Documentation/technical/hash-function-transition.adoc`)
    ++      for supported values and how this is used.  All other keys are reserved. Readers must ignore
     +      unrecognized keys.
     +  - Zero or more NUL bytes. This can optionally be used to improve the
     +    alignment of the full object name table below.


Christian Couder (1):
  packfile: validate pack index v3 tables

brian m. carlson (12):
  loose: allow looking up in object map with source
  loose: rename repo_add_loose_object_map
  loose: add a flag to control whether we write mapped OIDs
  odb: implement interoperability functions
  object-file-convert: implement mapping in terms of object DB
  pack-write: add support for pack index v3
  builtin: populate pack index v3 fields when indexing
  object-file: handle compatibility algorithm
  packfile: add support for reading pack index v3
  loose: map object IDs using pack index v3
  packfile: allow looking up compat object IDs in packs
  doc: move pack index v3 documentation

 Documentation/gitformat-pack.adoc |  75 +++++++++
 builtin/index-pack.c              | 107 +++++++++++-
 builtin/pack-objects.c            |   8 +-
 hash-lookup.c                     |  50 +++++-
 hash-lookup.h                     |  19 ++-
 loose.c                           |  50 ++++--
 loose.h                           |  15 +-
 object-file-convert.c             |  14 +-
 object-file.c                     |  18 +-
 odb.c                             |  17 ++
 odb.h                             |  24 +++
 odb/source-files.c                |  38 +++++
 odb/source-loose.c                |  31 +++-
 odb/source-packed.c               | 124 ++++++++++----
 odb/source.h                      |  65 ++++++++
 pack-check.c                      |   4 +-
 pack-revindex.c                   |  24 ++-
 pack-write.c                      | 263 ++++++++++++++++++++++++++----
 pack.h                            |   2 +
 packfile.c                        | 185 +++++++++++++++++++--
 packfile.h                        |  33 ++++
 t/t1016-compatObjectFormat.sh     | 100 +++++++++++-
 t/t5302-pack-index.sh             |  71 ++++----
 t/t5308-pack-detect-duplicates.sh |   7 +
 t/t5313-pack-bounds-checks.sh     |  17 ++
 25 files changed, 1193 insertions(+), 168 deletions(-)

-- 
2.56.0.215.g47fdf2208c

