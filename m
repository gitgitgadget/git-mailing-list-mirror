Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A42F8E8C
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228215; cv=none; b=RdAefZ3W5l5Rh6ssDjqc0A/k153hqwrTFnvWtJgXzdY5lD6GEWtwIeuyS//HZwGCJxqFFqSlXqT9yZQyT0mri00oBB87SWpt0I01E8BriUsEKpEhW8J+Hq3cGU4u4h1IGv97XueektNBbQnNmGWRUNMupsAft23UXBBIv/RQRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228215; c=relaxed/simple;
	bh=MIPQqRuIHiQA/iI4ia8HuJL3Qu1QeF9wpCeUR61BvxI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=c6BEW5/zRvSVe5pSTKQt9Xx/OVoh5GTWrGL4jGEjj+HiKtBLhJuO9c14W8DGfuzcpfe+ZhDTK+eVj/y/zRTw6+2eQzVQzgtR/nf4CnvPCl/HNp757iXsU04+88EpVFiySLm5Qcx0Cuzgnh6ssXhdd0c/J11hWAudcPpsY3oKES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYC/8nqG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYC/8nqG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5eb0fabaso17008361cf.0
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228212; x=1778833012; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QQ8V6NvNV45+XTvxKhMqywvZtD7XAqgIql8k/2Js1s=;
        b=pYC/8nqGnKZdU2/1ANN3mfDfNnsV9fYfjXRoW0bJ7H8RWK3EFl55i+VzSZowqpuSa4
         2cyYwUCtnDRNtxb2DlLhaIg/IhFEJtqTw97KFATeQAbdozOXmwb6ERY3pc++79bTmbyb
         XPVyC6skr/EkuIW52+sUm0BuTjaJEBl0gqWy26exuNxrkyRhoZkdLZbSFIo05SO4utcQ
         Y9sznkBGkkXXz78xpuRqdrTE0P9MyYEhXFjHixWLUPy3OORZ1u8qdy8EvsCP6mem8zPJ
         XKccOP7SEBHmIkiAqC0S/H4v7Y1HPB4VnlV+OpOjwggrDywBbzocwz48Pri4E3BIYj5C
         TrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228212; x=1778833012;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4QQ8V6NvNV45+XTvxKhMqywvZtD7XAqgIql8k/2Js1s=;
        b=hHmyyLQusilhTMqRkySkLOMsgPtxmbU93aeXpkUKO2721wzQwigOsyDX28yxyRWgYO
         qVY+1qNmDSGx8M0rhJyfzjpth6eQZOd0VSx013c1XwaYeR0F4ygDuej16stPVo6JIlgL
         KQ77gJrV4JC5zrfFpxJMFrJtJ1idnVz0lcScV/w3rddgt3U4r2c+mnw1hV1n+RFXSvcr
         g1+ZrxDvyEfPxVnj8LP9xiDuQZ8vYz1uz6OxukcH/2eKwXnASRuWbVoweMTrBAct8Aiv
         /CN1+AdOtK7wYOv5ZN5hb5bM3N6bwHHhl8VZvMJB9phZEKsg31PVRFhu6Fm9XxjXIzSb
         ud0g==
X-Gm-Message-State: AOJu0Yx+AU+vnG6NBsrruz/X4dHryRoDet5p8kr30Xd6KGA2BlDzBFi7
	CGt/r7LjVSjJg67ujS14n9sVmuZFNMbafoK4HGoCLwRiCFrGtCbqe88cmaxTbg==
X-Gm-Gg: AeBDieul0Me7wQAh6V7LIlFQFujdUP3jxxAbAl7g2MvhBCVY+wy1YmJFT6Ptdm7mrmT
	FDZRkY70kRngHDbtNzqAmyUCD0a5Px2DcTPNvRAOVYRY2SATpHKM78xPK8gAW8QpSwRN5gIprqY
	fNAR2DivoKVA6ik8OcsM5IbAQiF6L4nobQ3zYEaUFZUp/VEc4RyLNwJTEG+ab4PLCA7/VdkhnQz
	6veQs17X9MepPeDN3uzWj2me+odkA5VRDhupWK9QTlnvF6Hs5jGeqqDWOIC9bnQ4K6Tmfw4tbNh
	N6w/LkLmSOf7577eBwrIZZlaIbF4BHcqTk4dv3jxSKmHQWCUogNAS8opzdoaPXWI3imEquCUVHb
	3QiBCUMNjaycWA/OhH3TQAhEBML3ZdVRHxCzFEQ4KMH1w4eRY7gzJ05oeHm7wGyPaL7YiNwMRkG
	6KE1TdSkyQNaSIe/TJemHYFHE9Yw==
X-Received: by 2002:a05:622a:4a8e:b0:50f:dd9f:1223 with SMTP id d75a77b69052e-514621e0040mr165352871cf.44.1778228211547;
        Fri, 08 May 2026 01:16:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7e3f4fsm10343651cf.21.2026.05.08.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:16:50 -0700 (PDT)
Message-Id: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:38 +0000
Subject: [PATCH v3 00/11] Handle cloning of objects larger than 4GB on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, unsigned long is 32-bit even on 64-bit systems. This causes
multiple problems when Git handles objects larger than 4GB. This patch
series is a very targeted fix for a very early part of the problem: it
addresses the most fundamental truncation points that prevent a >4GB object
from surviving a clone at all.

Specifically, this fixes:

 * zlib's uLong wrapping and triggering BUG() assertions in the git_zstream
   wrapper
 * Object sizes being truncated in pack streaming, delta headers, and
   index-pack/unpack-objects
 * pack-objects re-encoding reused pack entries with a truncated size,
   producing corrupt packs on the wire

Many other code paths still use unsigned long for object sizes (e.g.,
cat-file -s, object_info.sizep, the delta machinery) and will need their own
conversions. This series does not attempt to fix those.

Based on work by @LordKiRon in git-for-windows/git#6076.

For testing, add a test helper that synthesizes a pack with a >4GB blob and
regression tests that clone it via both the unpack-objects and index-pack
code paths using file:// transport. Since these test cases are quite slow
(even after optimizing the pack generation part, the git clone test has no
chance but to hash 2x4GB of data), they are marked as EXPENSIVE. To ensure
that they are passing well in advance of any release, the CI is changed to
run them in the CI builds of relatively infrequent integration branch
updates.

Changes since v2:

 * Now uses the proper data type for the varint decoding value (thanks,
   Torsten!)
 * The callers that now would silently narrow size_t to unsigned long
   properly check and error out instead (thanks, Torsten!)

Changes since v1:

 * dramatically accelerated the test helper that generates 4GB pack files,
   via two separate strategies:
   1. using the "unsafe" SHA-1 for the blob OID computation.
   2. using pre-computed "Lego blocks" to construct the 4GB packs needed in
      the test cases, where the size (and therefore the involved OIDs) are
      well-known in advance.
 * even with these improvements, the actual git clone is still slow (of
   course, because it cannot use any of those shortcuts), therefore the
   tests are marked as EXPENSIVE.
 * to exercise those tests nevertheless, the last patch lets all EXPENSIVE
   test cases be run for the integration branches other than seen.

Johannes Schindelin (11):
  index-pack, unpack-objects: use size_t for object size
  git-zlib: handle data streams larger than 4GB
  odb, packfile: use size_t for streaming object sizes
  delta, packfile: use size_t for delta header sizes
  test-tool: add a helper to synthesize large packfiles
  t5608: add regression test for >4GB object clone
  test-tool synthesize: use the unsafe hash for speed
  test-tool synthesize: precompute pack for 4 GiB + 1
  test-tool synthesize: add precomputed SHA-256 pack for 4 GiB + 1
  t5608: mark >4GB tests as EXPENSIVE
  ci: run expensive tests on push builds to integration branches

 Makefile                     |   1 +
 builtin/index-pack.c         |   8 +-
 builtin/pack-objects.c       |  34 ++-
 builtin/unpack-objects.c     |   4 +-
 ci/lib.sh                    |   9 +
 compat/zlib-compat.h         |   2 +
 delta.h                      |  14 +-
 git-zlib.c                   |  25 +-
 git-zlib.h                   |   4 +-
 object-file.c                |  12 +-
 odb/streaming.c              |  13 +-
 odb/streaming.h              |   2 +-
 oss-fuzz/fuzz-pack-headers.c |   2 +-
 pack-bitmap.c                |   2 +-
 pack-check.c                 |   6 +-
 packfile.c                   |  57 ++--
 packfile.h                   |   4 +-
 t/helper/meson.build         |   1 +
 t/helper/test-synthesize.c   | 541 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5608-clone-2gb.sh         |  37 +++
 22 files changed, 724 insertions(+), 56 deletions(-)
 create mode 100644 t/helper/test-synthesize.c


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2102%2Fdscho%2Ffix-large-clones-on-windows-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2102/dscho/fix-large-clones-on-windows-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2102

Range-diff vs v2:

  1:  dc660106ea !  1:  311cdc601d index-pack, unpack-objects: use size_t for object size
     @@ Commit message
          64-bit platforms, and ensuring the shift arithmetic occurs in 64-bit
          space.
      
     +    Declare the per-byte continuation variable `c` as size_t as well,
     +    matching the canonical varint decoder unpack_object_header_buffer()
     +    in packfile.c. With c as size_t the expression (c & 0x7f) << shift
     +    is naturally size_t-typed, so the explicit cast that an earlier
     +    iteration carried at the use site is no longer needed.
     +
     +    While at it, add the same overflow guard that
     +    unpack_object_header_buffer() carries: if the cumulative shift would
     +    exceed bitsizeof(size_t) - 7, refuse the input rather than invoking
     +    undefined behavior. Unlike unpack_object_header_buffer(), which
     +    labels this case "bad object header", report it as the platform
     +    limit it actually is: a header may be perfectly well-formed and
     +    still encode a size we cannot represent locally (notably on a
     +    32-bit build consuming a packfile produced on a 64-bit host).
     +
          This was originally authored by LordKiRon <https://github.com/LordKiRon>,
          who preferred not to reveal their real name and therefore agreed that I
          take over authorship.
      
     +    Helped-by: Torsten Bögershausen <tboegi@web.de>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static void *unpack_raw_entry(struct object_entry *obj,
       {
       	unsigned char *p;
      -	unsigned long size, c;
     -+	size_t size;
     -+	unsigned long c;
     ++	size_t size, c;
       	off_t base_offset;
       	unsigned shift;
       	void *data;
      @@ builtin/index-pack.c: static void *unpack_raw_entry(struct object_entry *obj,
     + 	size = (c & 15);
     + 	shift = 4;
     + 	while (c & 0x80) {
     ++		if ((bitsizeof(size_t) - 7) < shift)
     ++			die(_("object size too large for this platform"));
       		p = fill(1);
       		c = *p;
       		use(1);
     --		size += (c & 0x7f) << shift;
     -+		size += ((size_t)c & 0x7f) << shift;
     - 		shift += 7;
     - 	}
     - 	obj->size = size;
      
       ## builtin/unpack-objects.c ##
      @@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
     @@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
       	unsigned shift;
       	unsigned char *pack;
      -	unsigned long size, c;
     -+	size_t size;
     -+	unsigned long c;
     ++	size_t size, c;
       	enum object_type type;
       
       	obj_list[nr].offset = consumed_bytes;
      @@ builtin/unpack-objects.c: static void unpack_one(unsigned nr)
     + 	size = (c & 15);
     + 	shift = 4;
     + 	while (c & 0x80) {
     ++		if ((bitsizeof(size_t) - 7) < shift)
     ++			die(_("object size too large for this platform"));
       		pack = fill(1);
       		c = *pack;
       		use(1);
     --		size += (c & 0x7f) << shift;
     -+		size += ((size_t)c & 0x7f) << shift;
     - 		shift += 7;
     - 	}
     - 
  2:  92f4327b1f =  2:  c611913194 git-zlib: handle data streams larger than 4GB
  3:  3a539061c5 !  3:  b789f57de9 odb, packfile: use size_t for streaming object sizes
     @@ Commit message
          temporary variables where the types differ, with comments noting the
          truncation limitation for code paths that still use unsigned long.
      
     +    Widening the producers to size_t in this way introduces a handful of
     +    silent size_t -> unsigned long narrowings on Windows, all in
     +    builtin/pack-objects.c, where the consumers are still typed
     +    unsigned long. Make those narrowings explicit with
     +    cast_size_t_to_ulong() so they assert loudly the moment an object
     +    actually exceeds ULONG_MAX bytes:
     +
     +      - oe_get_size_slow() returns unsigned long but holds a size_t
     +        locally; cast at the return.
     +      - write_reuse_object() passes a size_t into check_pack_inflate(),
     +        whose expect parameter is unsigned long; cast at the call.
     +      - check_object() routes a size_t through SET_SIZE() and
     +        SET_DELTA_SIZE(), both of which take unsigned long via
     +        oe_set_size() / oe_set_delta_size(); cast at the three call
     +        sites in the OBJ_OFS_DELTA / OBJ_REF_DELTA branches and in the
     +        non-delta default arm.
     +
     +    The cast-only treatment is deliberately a stop-gap. Properly
     +    widening oe_set_size, oe_get_size_slow's return type,
     +    check_pack_inflate's expect parameter, object_info.sizep,
     +    patch_delta, and the OE_SIZE_BITS bit-fields cascades into a series
     +    that is too large to be reviewable, so the proper widening is
     +    deferred to a follow-up topic. Until then,
     +    cast_size_t_to_ulong() at least makes the truncation explicit at
     +    the source: it documents the boundary, and on a 64-bit non-Windows
     +    platform it is a no-op.
     +
          This was originally authored by LordKiRon <https://github.com/LordKiRon>,
          who preferred not to reveal their real name and therefore agreed that I
          take over authorship.
      
     +    Helped-by: Torsten Bögershausen <tboegi@web.de>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/pack-objects.c ##
     @@ builtin/pack-objects.c: static off_t write_reuse_object(struct hashfile *f, stru
       
       	if (DELTA(entry))
       		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
     +@@ builtin/pack-objects.c: static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
     + 	datalen -= entry->in_pack_header_size;
     + 
     + 	if (!pack_to_stdout && p->index_version == 1 &&
     +-	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
     ++	    check_pack_inflate(p, &w_curs, offset, datalen,
     ++			       cast_size_t_to_ulong(entry_size))) {
     + 		error(_("corrupt packed object for %s"),
     + 		      oid_to_hex(&entry->idx.oid));
     + 		unuse_pack(&w_curs);
      @@ builtin/pack-objects.c: static void write_reused_pack_one(struct packed_git *reuse_packfile,
       {
       	off_t offset, next, cur;
     @@ builtin/pack-objects.c: static void check_object(struct object_entry *entry, uin
       
       		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
       
     +@@ builtin/pack-objects.c: static void check_object(struct object_entry *entry, uint32_t object_index)
     + 		default:
     + 			/* Not a delta hence we've already got all we need. */
     + 			oe_set_type(entry, entry->in_pack_type);
     +-			SET_SIZE(entry, in_pack_size);
     ++			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
     + 			entry->in_pack_header_size = used;
     + 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
     + 				goto give_up;
     +@@ builtin/pack-objects.c: static void check_object(struct object_entry *entry, uint32_t object_index)
     + 		if (have_base &&
     + 		    can_reuse_delta(&base_ref, entry, &base_entry)) {
     + 			oe_set_type(entry, entry->in_pack_type);
     +-			SET_SIZE(entry, in_pack_size); /* delta size */
     +-			SET_DELTA_SIZE(entry, in_pack_size);
     ++			SET_SIZE(entry, cast_size_t_to_ulong(in_pack_size)); /* delta size */
     ++			SET_DELTA_SIZE(entry, cast_size_t_to_ulong(in_pack_size));
     + 
     + 			if (base_entry) {
     + 				SET_DELTA(entry, base_entry);
      @@ builtin/pack-objects.c: unsigned long oe_get_size_slow(struct packing_data *pack,
       	struct pack_window *w_curs;
       	unsigned char *buf;
     @@ builtin/pack-objects.c: unsigned long oe_get_size_slow(struct packing_data *pack
       	}
       
       	p = oe_in_pack(pack, e);
     +@@ builtin/pack-objects.c: unsigned long oe_get_size_slow(struct packing_data *pack,
     + 
     + 	unuse_pack(&w_curs);
     + 	packing_data_unlock(&to_pack);
     +-	return size;
     ++	return cast_size_t_to_ulong(size);
     + }
     + 
     + static int try_delta(struct unpacked *trg, struct unpacked *src,
      
       ## object-file.c ##
      @@ object-file.c: int odb_source_loose_read_object_stream(struct odb_read_stream **out,
  4:  3274cba862 =  4:  8e87a4e71f delta, packfile: use size_t for delta header sizes
  5:  afa74a3a2b =  5:  34fec4a32d test-tool: add a helper to synthesize large packfiles
  6:  a3019888d8 =  6:  88f992903f t5608: add regression test for >4GB object clone
  7:  859e93e7a9 =  7:  4f207c8a47 test-tool synthesize: use the unsafe hash for speed
  8:  29b9a74e91 =  8:  2751c21c6e test-tool synthesize: precompute pack for 4 GiB + 1
  9:  8e6e720804 =  9:  3a006d96c3 test-tool synthesize: add precomputed SHA-256 pack for 4 GiB + 1
 10:  5b44410b2f = 10:  86c09af4f5 t5608: mark >4GB tests as EXPENSIVE
 11:  1eaaa7fad7 = 11:  2159f6a271 ci: run expensive tests on push builds to integration branches

-- 
gitgitgadget
