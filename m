Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3A2F12D4
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820454; cv=none; b=FD3y3dXsEhghV7dIu5WvvIZYD9EE5UP5dRdwcvk3R3ICP9s+iWl7afednbo+9TVBA4cYl960MrXVg2Iy7C2hP0AEtZQDrUzQ3yfrWGm81VAqmvt1ukwO+8V3HNaLsy5Y4bJoOi9Bh+S0Mx8zSRLSU3FclI5NRj2arVmKQGG7leY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820454; c=relaxed/simple;
	bh=C6wwIgmOZUovcqK/MxIbpNvLRiyxmx3XqX4ZVJlNA7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DGWBv+rdUSLvL0ORhuk1WRc7qrQ9WxpspeMirAW40QWbwQRKcElPSxy4ZV39qWTRLxVYBURYd9Xbl8D38sNr/n1pa55KMdpkk4LMOEyL2xi3+x97aFB+6LclthTpO/6BggY+A6a/ZCKOwPnfLPjRnBvZcwoHuvvqa12EEyjd7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LEpTFLRU; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LEpTFLRU"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6501d242e3fso185545d50.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820452; x=1775425252; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZ7YCKb1Snk05THTWTAC9s4MHlhvgSuydROvN+RFJZk=;
        b=LEpTFLRUSrgk5AJEcqdNp+ou3pgLaL2XF2Zww7HYSxINoUvRJ4khCCdSr1H+QuxgKA
         i4OgkjfWuOaEeSOlZj0TTCYusR5XHGjPTXiYUcPjGlaXkKDshilFUohgCO1myC6xGYxh
         fY18fMXhZ4mm4e6UeeJMHC1oqeRnWD0Jjm2oXEvULSapSf/4fNVweOkLGcIpVOie+n67
         +6jTnCgXTvs985MM8gj54QQQjNHpJDFJESmyG6XgXvJRAOG1joQrYc6YnrSnsp40j6Ep
         n6S7/25EmvBlhOQ8NwInHOuBJOsRrP3yLg57zBDJBr2qb3QBT0YagaY05hoQg7CtDEkn
         X74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820452; x=1775425252;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ7YCKb1Snk05THTWTAC9s4MHlhvgSuydROvN+RFJZk=;
        b=QkVftMGw9RbwBmpipXI1SE0GdFds2b4CESITPV6E8oto3HkOUs/t0fn3bdcbO6O7wR
         4CuiSiv24XrglF4JaP/P/jXEScq7WekioXsycFgOuBbXDmZqyN2M474JckLmlqtAJvNc
         OrpSiCu4hwQ+2f8R3Vy3ZLdQqsbKXZ9dSQ8jsG78UOYtQB8wVS3fEJQfqHIxgl5dK+CA
         gFRgtM9KDyUJhCLu0XksnuvlagpaooMWPXSj28FyBIr45FvAeKfD+eZFCvTRGWasPMIF
         P+AP/Lq0soTJlOBdBKSucpo11MnpbtC9N3avb84PySRVBIReZuGw8GPg3OFb1qgGkod0
         cNIQ==
X-Gm-Message-State: AOJu0Yx53ll8b78fPL+qhskqjVk+rLdwpxaodKhoapjMwuqR48Sc4xzT
	MdZvnnbkkoy+IkRUOmpDbSha5crGATQ7togf2G8jXNUYfmjqVpAyUY/8MUfmVIZ6NvsnAEJFE54
	6yPzAoltFIdEq
X-Gm-Gg: ATEYQzxUCLVA72SblOqSSSPrmYvj0it3VbGCrKBGMntRlUiaO/AFgXecq0Va+8Z8vH6
	oV7J97+sjjSA88tbKR/1qVv8Dd9AFKzg4yMhbAaoGB5maDjgI0sldVUT/eoBJqgWv/fO9KZmz0O
	2qIp8iPd/R7rRpGTSh3Q70LJ2/DX/kNCSoaplA9NWnEBZcAh1mRnKGjwggmTrgTBiJkBmWkpr4r
	B+6ohMde4C0rUhl5/oBq2gAjSQEKNNWJLdRH2YJQ/CkHtqdZL+x7XdzYnggwAErWEP/QAuOmaqG
	2ytGSaJtOlh+dj96y84IVzrIR7JbFtbmZ2Qsqu13WS5Nj3c20qWNSoR1dHQO+sPAVrLDNgU8mp9
	92+WYIqQZhoKSVQDdthX98F00NO226iUvTf+aiaRP06b/ybdZ21oDs0d4UsLC8BVlzupAdah2sa
	pXx0p91fb+OND/1iXV1HjBZ9g4ykNyudEqrGYOX25qMH3w2pWU9IcBNh9eDnMOs4KyuaFTzOARN
	/nfjrxMfKMUYrjEPuLg9wglvPpSPw==
X-Received: by 2002:a05:690c:e:b0:79a:b861:e33f with SMTP id 00721157ae682-79bddd29958mr108879137b3.19.1774820451548;
        Sun, 29 Mar 2026 14:40:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cba76dd1bsm26355487b3.44.2026.03.29.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:40:51 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:40:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Note to the maintainer:

 * Now that tb/incremental-midx-part-3.2 is merged, this series is
   rebased on current 'master', which is 5361983c075 (The 22nd batch,
   2026-03-27) at the time of writing.

 * I suggest queueing as 'tb/incremental-midx-part-3.3'.

The below is a nearly identical cover letter to the one I sent for the
RFC-version[1] of this series. The only changes between the RFC version
and this one are:

 * A new commit to correctly handle certain cases when optimizing out
   MIDX writes.

 * Defined `strvec_init()` as a special case of `strvec_init_alloc()`
   based on feedback from Junio.

 * Minor ODB source-related fallout as a consequence of rebasing.

 * Add trace2 instrumentation to help follow what repack is doing in
   response to different packing configurations.

 * Fix various memory leaks.

The original cover letter is below:

------------------------------------------------------------------------

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
smaller challenges than this and the previous series.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1771978829.git.me@ttaylorr.com/

Taylor Blau (16):
  midx-write: handle noop writes when converting incremental chains
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
  packfile: ensure `close_pack_revindex()` frees in-memory revindex
  repack: implement incremental MIDX repacking
  repack: introduce `--write-midx=incremental`
  repack: allow `--write-midx=incremental` without `--geometric`

 Documentation/config/repack.adoc        |  18 +
 Documentation/git-multi-pack-index.adoc |  19 +-
 Documentation/git-repack.adoc           |  44 +-
 builtin/multi-pack-index.c              |  48 +-
 builtin/repack.c                        |  90 ++-
 midx-write.c                            | 137 +++--
 midx.c                                  | 106 ++--
 midx.h                                  |  11 +-
 packfile.c                              |   2 +
 repack-geometry.c                       |  50 +-
 repack-midx.c                           | 717 +++++++++++++++++++++++-
 repack.c                                |  23 +-
 repack.h                                |  25 +-
 strvec.c                                |  15 +-
 strvec.h                                |   5 +
 t/meson.build                           |   1 +
 t/t5334-incremental-multi-pack-index.sh |  63 +++
 t/t5335-compact-multi-pack-index.sh     | 113 ++++
 t/t7705-repack-incremental-midx.sh      | 461 +++++++++++++++
 19 files changed, 1792 insertions(+), 156 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh


base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0.729.g817728289e1.dirty
