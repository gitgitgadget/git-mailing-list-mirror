Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C82BAF7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978847; cv=none; b=Ryih68g6DJOUvvrenAT+unGKb9YIp6nEkx7r+0m0so5hZjy3i+i3uJb7cyFGlukKmS1TZsm/OE2cW6oa6fJyJWBoSJX4xuGjw8ijIId+LpzVD7bRIG/8/gkKTMcQnchu5g8xAhRP/jrIssVnWfdE5bqkkBF2Osu/GgzCLU2fURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978847; c=relaxed/simple;
	bh=8E5jtWErwqKAepZRZkepA3TLWs1bQ50P8YmsZL+ksGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kkDRGtde5oUI+BammrwBgfLi1bPTrbtYX+LX+X8QWSa1sGC2huUwp67qNKwQQPKQuyQL79tCgmMQxdDK/FfjXnpN6hu6vkju1/sscsIvaW6Nnxz/9z2VG8SOTRvuLq4GAoruIO5lUceudRNBH67pCzjX996KA2Oe65i6LiCbWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=B9QnxirK; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="B9QnxirK"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-896f9397ecdso65821436d6.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978844; x=1772583644; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIaU9nJagaGUTscyIVYvHjKRVC+QKbXLsKigdUksYN0=;
        b=B9QnxirKJuuIm/09tKbbfqihgBLXYU68OXA7jSsnu3qYwxczavseQosiV9C99Us9g+
         rzkFuv8br9bxuPcbY9oEK8UzpeJ+N/F1hkRONDZmG/NyQ0DtxYrbMr07g0NEo6kEgpA7
         9+gMfGgZVN1XkWbAi1gGJkrVmE7bdAdSLK0rp5L+hFO/Q3H0BOwis9ANIB8Giaas2NoW
         iOlToCaYJO6pp/6PS4K8Z4tS3jJMVvU2Z3cHIP/gDrsNah3iJH6HciR81h+HBRPaZAha
         JLIklO4zRqNrew+j0c7qbzV3KgA37pwGmlsmecut8qHw7BKRBK5wvGqn20Qa8K1YQ9M4
         dl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978844; x=1772583644;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIaU9nJagaGUTscyIVYvHjKRVC+QKbXLsKigdUksYN0=;
        b=WVO90C/ouQoiI8jVZzzE/BPoDYG9BTNLodS5iHf2pGuzQbL5t8tXj9k8/NDXGFoshU
         d0aYpx++7OQ2S5RGCSsCEP8/woaiNJxpuSf9t3SkxEvwl6Y8Jp7l4lsKE0jQahjiU7kZ
         5valomffxFnrq7ATBfMvUsb6aNZe9yMqiZSAPRPHqpRpLoebaVVagf/e9edAkqf3696o
         cKB0bWdNVTQ3MF9jOJCpqYjfqXs9SlYgreDHq4tPU2+zuARIgCiulTjV0IqI/mlglBo0
         li+tOVgogEHKsBp9fo0M3NWeeF02N3/caL6ck7uRxoWiNgnydT7Kf8622LGJETBVcBa7
         EiLw==
X-Gm-Message-State: AOJu0YzdHzKOPQHdCyfyphfDq0JlrVjlVOQftn/N7UlRcjeQjYYjWwb0
	kbw0RQTx3L3y0NX6YNOUv+k57lCknxMpL12fF//5YRPrDRI80PhYTM0CDKwcNOm3yB8xzzOA0aA
	VH85ho8CfX5M9
X-Gm-Gg: ATEYQzw8UNXw74VNAdTfDY+QPAmE/fOzZJRsqzGtctPjXpdq75Ir2PbsGd6GY13kbaH
	nvJw0SWdHdCotUF/yhp7e6DHVlkAS8LBZts/c3OZt/gUIJG2HmYM3zbcnLFEJkd1Bbw75P/+Kc5
	1yDNcMJQezURY2GbZ1PVS6iOVsFecGOAu4zSf4q/KjLnRN1gRTM2222UpB2yJ5Ni3P82cWLSjcD
	NxNvpQDkGY/Vdf8sgz9UEh6srYdoSHoYKoGO/6u9hc9vQU/tIRBAw0IsO20LHveX+I7R63pw1PD
	RFpIXiqOkn/FYK/qBiIcljj5tf/fziYVV3biwYtSTP1WQQLMQMU0uL3EUrgeDQ4jLtIfOJWSGLV
	jCpX1YiEQOCt58oIoK5jV4MwYQcoKF7ZKf2400fQNCIgdrdIIm2ZLJpx/3btnUfuwTw/UBsMUVu
	23b6z/y3DFoG7DllfDSP7DjHUwwHy9gkaO4TeVAunbVNmcIyjbTIOQSNRDQh1XQiC9O7j5KnQEH
	2oJnG0aNWzCsT4GCfrglJNB/Y8nmw==
X-Received: by 2002:a05:6214:300f:b0:895:d97:a2ba with SMTP id 6a1803df08f44-89979dacf9cmr205508586d6.67.1771978844397;
        Tue, 24 Feb 2026 16:20:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b1231063sm16823426d6.27.2026.02.24.16.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:20:44 -0800 (PST)
Date: Tue, 24 Feb 2026 19:20:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 00/14] repack: incremental MIDX/bitmap-based repacking
Message-ID: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

[NOTE: this series has not yet been tested thoroughly and is based on
the v3 of 'tb/incremental-midx-part-3.2', which is d54da84bd9d (midx:
enable reachability bitmaps during MIDX compaction, 2026-02-24).

I suspect that there will be non-trivial changes to the approach in this
series based on feedback, hence the RFC.]

Note to the maintainer:

 * This series is based on 'tb/incremental-midx-part-3.2', I suggest
   queueing as 'tb/incremental-midx-part-3.3'.

OVERVIEW
========

This series implements the third and final major component for an
incremental MIDX/bitmap-based repacking strategy. As a refresher, those
are:

 1. Refactoring code out of builtin/repack.c into individual compilation
    units outside of the builtin directory.

 2. Implementing MIDX layer compaction, i.e., the ability to combine a
    contiguous sequence of MIDX layers in an existing chain and replace
    them with a single layer representing the union of objects/packs
    among the compacted layers.

 3. (this series) An incremental repacking strategy that, unlike our
    current '--geometric' approach, does not rely on periodic
    all-into-one repacks.

BACKGROUND
==========

Today, a '--geometric' repack with '--write-midx' rewrites the entire
MIDX (and, when enabled, its reachability bitmap) on every invocation.
For most repositories this is acceptable. In large monorepos, these
costs can add up significantly, especially when those repositories are
repacked frequently.

The incremental MIDX support introduced in the earlier parts of this
effort allows us to append new layers to a MIDX chain without rewriting
anything. Combined with the support for MIDX compaction in 3.2, we now
have all of the building blocks needed to maintain an incrementally
growing and shrinking MIDX chain as part of the repack cycle.

STRATEGY
========

The incremental repacking strategy implemented in this series works
(roughly) as follows:

 1. Repack non-MIDX'd packs using an ordinary '--geometric' repack,
    optionally including packs from the tip MIDX layer if and only if it
    contains more than 'repack.midxNewLayerThreshold' number of packs.

 2. Prepare to write a new MIDX layer containing the freshly written
    pack(s) (and any surviving packs from the tip layer, if it was
    rewritten).

 3. Perform a compaction pass over adjacent MIDX layers to restore a
    geometric progression on object count among layers in the chain
    (determined by 'repack.midxSplitFactor').

 4. Write the new MIDX chain, link it into place, and remove redundant
    layers.

In effect, this approach encourages MIDX chains where:

 * older layers contain fewer, larger packs, and

 * newer layers contain many smaller packs.

As a result of the compaction pass, we prevent the chain itself from
ever growing too long.

This roughly matches the description of this algorithm I gave at Git
Merge last year, which is covered on slides 80-131 of this presentation:

    https://ttaylorr.com/presentations/git-merge-2025.pdf

THIS SERIES
===========

This series is organized roughly as follows:

 * The first three patches perform small-ish quality-of-life refactors
   within the MIDX machinery.

 * The next two patches introduce `--checksum-only` and `--base`
   options for `git multi-pack-index write` and `compact`, which are
   needed by the incremental repacking machinery to assemble MIDX
   chains without prematurely updating the chain file.

 * The next six patches prepare the repack infrastructure and pack
   geometry code for the new repacking strategy.

 * The final three patches introduce the new repacking machinery, expose
   it to users, and then extend it to work with non-geometric repacks in
   that order. The first two are the substantive patches of this series.

WHERE WE'RE AT
==============

This series delivers the final substantive component of this overall
effort to enable the new repacking strategy implemented here. There are
a couple of (comparatively much smaller) items that will be useful as
follow-on items, including:

 * "Reachability-infused" geometric repacking to emit small cruft packs
   to introduce other ways to update the set of cruft objects beyond a
   whole-repository traversal.

 * Richer bitmap configuration to determine which bitmap(s) to carry
   forward between adjacent MIDX layers when doing an incremental
   repack, to prevent an endless accumulation of reachability bitmaps.

Like I mentioned earlier, I think that both of those are significantly
smaller challenges than this and the previous series. As a general note,
I am going on vacation for two weeks starting this Friday (2026-02-24)
and will be away from the list.

I'll plan on picking up any review from this series as well as the two
other topics listed above as soon as I get back.

Thanks in advance for your review!

Taylor Blau (14):
  midx: use `string_list` for retained MIDX files
  strvec: introduce `strvec_init_alloc()`
  midx: use `strvec` for `keep_hashes`
  midx: introduce `--checksum-only` for incremental MIDX writes
  midx: support custom `--base` for incremental MIDX writes
  repack: track the ODB source via existing_packs
  midx: expose `midx_layer_contains_pack()`
  repack-midx: factor out `repack_prepare_midx_command()`
  repack-midx: extract `repack_fill_midx_stdin_packs()`
  repack-geometry: prepare for incremental MIDX repacking
  builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
  repack: implement incremental MIDX repacking
  repack: introduce `--write-midx=incremental`
  repack: allow `--write-midx=incremental` without `--geometric`

 Documentation/config/repack.adoc        |  18 +
 Documentation/git-multi-pack-index.adoc |  19 +-
 Documentation/git-repack.adoc           |  44 +-
 builtin/multi-pack-index.c              |  48 +-
 builtin/repack.c                        |  90 ++-
 midx-write.c                            | 119 ++--
 midx.c                                  | 104 ++--
 midx.h                                  |  11 +-
 repack-geometry.c                       |  50 +-
 repack-midx.c                           | 704 +++++++++++++++++++++++-
 repack.c                                |  23 +-
 repack.h                                |  25 +-
 strvec.c                                |   7 +
 strvec.h                                |   5 +
 t/meson.build                           |   1 +
 t/t5334-incremental-multi-pack-index.sh |  47 ++
 t/t5335-compact-multi-pack-index.sh     | 105 ++++
 t/t7705-repack-incremental-midx.sh      | 461 ++++++++++++++++
 18 files changed, 1730 insertions(+), 151 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh


base-commit: ac6221686db11ba802ced8ea6b8b2fa8388b21b2
-- 
2.53.0.185.g29bc4dff628
