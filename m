Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49B1FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097237; cv=none; b=IEYk9bQG06hvs6ZCwd81PEuud9UhJszM5UNzS5uWQyKf+0cUqRl7NKPHSWJJ5o6rGQS7z4KDvnOX1hXiB2VB6SWbuxQFyCCSpkAf6vL7qE9hRzDK3trgrGEsN45o19eOS1dSVAPtuRPals1lJgnpVSOKlgxBRMms9iBw2VJjA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097237; c=relaxed/simple;
	bh=vy2TxLhQXvG2snvXDR2BSogxZksVKNRosI5nYjfaBfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u8MaH/3Gcrku16HprE44DuwXnO0qosuvWgwF+0vu5upK4JIWqM9X7CZn45QYVlDwbQ4oo+pw+B2N9B/fTPnQmEw1RnrKKOU6Oy3zQbCgcI62QgsKUhEK+w4/aZNTckvFDsbCEi/eVfwv0YzRK7P6GmErNkJrhLOpJv9/FQ8ieKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=c59Dt7o7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="c59Dt7o7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-73b4e3d0756so49641127b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097233; x=1759702033; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtjvUne8HF5la7p67dJhKrtQIkL2OkknoRefNP+cdZ4=;
        b=c59Dt7o7PAJJVfxsmmi1bls+6S7sSAXfqt2qBOzW+MtLjjBp+Rvq0liiyfuP5EkLps
         2CCCcx6nLMmnz0cA/i+LMq/Lv4FCRP57QGSleD1h/yK5g2ohUQoXcAp7n5j82Kcra2LI
         lZLefuulAsAEBDgmESY3/T7Uh/0AToFYYIdihJYOCQ5mgy5Eq2PByvCH6xEWeXBbb3LK
         D12ooIOXFxcqp26eyA/bQYNmaZMIbd5wh2Bx6UcYcUzFBu3m/B/KLc3FzLtYq4tzSkh1
         P/VXn61fCOCzlXRQXf1SJeaPx8/LJYwH1dNOyWnqIK7/P4hN//7gzkJyBHlcCvF7U0Mx
         HWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097233; x=1759702033;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtjvUne8HF5la7p67dJhKrtQIkL2OkknoRefNP+cdZ4=;
        b=b6Bz3ALPbAPqWNJgmJP2YTwIgEazu6Er6XsIpdgaOSv3UVR0KBJr+o+vl7hhEfSMiK
         /UD0Nqoc80xG5RXqgZjTYFxR4tuW4KBesiHk940KSzlm/b3MxLAHmrzOUenZEArGImdf
         3xgDl/oi5/Kk/pDWZhZUQc3bq5msjLcQDJoZEu52OMRvgHacyuQf9voPVKh5RwsiIsQD
         mpXHyEmu+JzDcgty4Y+DXqE3VNlyaUKwOhZqDweX2nZ8DIqmnwdwjYPMN5PI2urO6TRo
         Szl5sDgmTs8v9E0kU/S0V2ySjCJVrGwvqrcUqdbsQVW6c4Pi/KzBR23NxVC9Xk1YO2VW
         HYcw==
X-Gm-Message-State: AOJu0Yx2TPGXzxr72mewNIUNaxzPuyEK7K3sT97XLGjy+pRniyZh6BdI
	BrHL1s8exmEWmkyfW1+quGXMc87LZQyUWfJkbKGlNOP4BfpSOO2YLmovbfDzX2x7vX01STE3l4q
	PcgNT6MQ=
X-Gm-Gg: ASbGncuf97UUYmvCspbWBf9ntedDrTAb0Lwgs9J2wodv3X3F2pw78BgffzltKS0BUfP
	9y50fMNCqKjVCfH2azUpyS+S6gn9YtrwHWPpY/EQS+ffJoikhgk7k5u0YTWwaEOFkPCKAKorcXm
	O1Ab91p1pFeV0O+kO4UE8Lp3LW5EjA0W4SPnILSEn/Lvi8mOS7HDxew/+p41wmEphQ1ForjySWE
	Y5r90fnJH4QwTY6VrqXnIb28IzFmUMlJ5SVrf211GCJmmou6A6QBHnaPufzdLmTZdwh47JWx4AY
	kI7RnzBFtdvZ/5vSIRTyPOnIuqB1pgfKAGrfMNOja0jXKv8HoLHovNJeZXsX8QYNNnpZhe3uXf4
	Lh2b2532A7FACliVfN3HDyrK4YKAj8UWgJz3sRqb4JuYSeTIhv6ZCuPNqS9fHc80m1A1BNitQ99
	7IOTSfno/sikb/RLXh4lSv2WjBwQ==
X-Google-Smtp-Source: AGHT+IH/Qk810VUgracMFyNyaSwk3rsob0fbBVCqM+rcsyG5wYuUMD+32N+iTYS0qPEdyQ5i7yWShw==
X-Received: by 2002:a05:690e:254d:b0:62a:83f3:a575 with SMTP id 956f58d0204a3-6361a751bddmr11643855d50.8.1759097232938;
        Sun, 28 Sep 2025 15:07:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38393c958sm2931445276.26.2025.09.28.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:12 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 00/49] repack: prepare for incremental MIDX-based repacking
Message-ID: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Note(s) to the maintainer:

 * This series depends on ps/packfile-store at dd52a29b78 (packfile:
   refactor `get_packed_git_mru()` to work on packfile store,
   2025-09-23).

 * This series is split out of my local copy of
   tb/incremental-midx-part-3. I suggest queueing it as
   tb/incremental-midx-part-3.1 ;-).

When developing an incremental MIDX/bitmap-based repacking strategy, I
thought that it might be useful to clean up builtin/repack.c before
adding any amount of new functionality.

At more than 1,700+ lines of code, the 'repack' builtin has grown quite
unwieldy over the years. It has quite a bit of repack-related
functionality, all implemented within the builtin itself. It knows how
to: manage cruft packs, perform geometric repacking, write new MIDXs,
repack promisor objects, keep track of existing packs, and much more.

This series moves the vast majority of the builtin's functionality into
several new compilation units, all grouped under a new repack.h API:

 * repack.c
 * repack-cruft.c
 * repack-filtered.c
 * repack-geometry.c
 * repack-midx.c
 * repack-promisor.c

Moving this code around was less than straightforward, hence the length
of this series. Likewise, since the repacking code can be rather
fragile, I chose to go slower here than I otherwise would have (e.g.,
almost all code movement changes are strict moves with no rewrites in
between).

The structure of the series is roughly as follows:

 - The first 10 patches reduce the usage of the_repository, and
   the_hash_algo. They don't quite get us to being able to compile
   without USE_THE_REPOSITORY_VARIABLE for reasons described in the last
   commit of this section.

 - The next four commits introduces the new repack.o compilation unit,
   and moves a fairly isolated component of the repack builtin.

 - The next five commits move the existing_packs API from out of the
   builtin into the repack.h API.

 - The next five move the generated_pack API.

 - The next two move the repack_promisor_objects() API.

 - The next four move the pack_geometry API.

 - The next nine move various MIDX-related functionality out of the
   builtin.

 - The next nine move remaining functions that write packs out of the
   repack builtin.

 - The final commit cleans up the list of `#include`s within the
   builtin.

My hope is that this produces a series that is easier to review, despite
its rather long length. Each individual commit tries to do as little as
possible, and most will benefit from being reviewed with --color-moved.
The result, in my opinion, is a 'builtin/repack.c' is much cleaner than
it was when we started.

Nothing in this series is a strict requirement for implementing a
repacking strategy based on incremental MIDX/bitmaps. But since the new
functionality required for that is lengthy in and of itself, having a
clean slate to start from seemed worthwhile to me.

Thanks in advance for your review!

Taylor Blau (49):
  builtin/repack.c: avoid "the_repository" in `cmd_repack()`
  builtin/repack.c: avoid "the_repository" in existing packs API
  builtin/repack.c: avoid "the_repository" when taking a ref snapshot
  builtin/repack.c: avoid "the_repository" when removing packs
  builtin/repack.c: avoid "the_repository" when repacking promisor
    objects
  builtin/repack.c: avoid "the_hash_algo" when deleting packs
  builtin/repack.c: avoid "the_hash_algo" in `write_oid()`
  builtin/repack: avoid "the_hash_algo" in `repack_promisor_objects()`
  builtin/repack.c: avoid "the_hash_algo" in `finish_pack_objects_cmd()`
  builtin/repack.c: avoid using `hash_to_hex()` in pack geometry
  repack: introduce new compilation unit
  builtin/repack.c: pass both pack_objects args to repack_config
  repack: move 'delta_base_offset' to 'struct pack_objects_args'
  repack: remove 'prepare_pack_objects' from the builtin
  builtin/repack.c: rename many 'struct existing_packs' functions
  repack: remove 'remove_redundant_pack' from the builtin
  builtin/repack.c: pass "packdir" when removing packs
  builtin/repack.c: avoid unnecessary numeric casts in existing_packs
  repack: remove 'existing_packs' API from the builtin
  builtin/repack.c: rename "struct generated_pack_data"
  builtin/repack.c: factor our "generated_pack_install"
  builtin/repack.c: pass "packtmp" to `generated_pack_populate()`
  builtin/repack.c: provide pack locations to `generated_pack_install()`
  repack: remove 'generated_pack' API from the builtin
  builtin/repack.c: pass "packtmp" to `repack_promisor_objects()`
  builtin/repack.c: remove "repack_promisor_objects()" from the builtin
  builtin/repack.c: rename various pack_geometry functions
  builtin/repack.c: pass 'pack_kept_objects' to `pack_geometry_init()`
  builtin/repack.c: pass 'packdir' to `pack_geometry_remove_redundant()`
  repack: remove pack_geometry API from the builtin
  builtin/repack.c: remove ref snapshotting from builtin
  builtin/repack.c: extract opts struct for
    'write_midx_included_packs()'
  builtin/repack.c: use a string_list for 'midx_pack_names'
  repack: keep track of MIDX pack names using existing_packs
  builtin/repack.c: reorder `remove_redundant_bitmaps()`
  builtin/repack.c: inline `remove_redundant_bitmaps()`
  builtin/repack.c: pass `repack_write_midx_opts` to
    `midx_included_packs`
  builtin/repack.c: inline packs within `write_midx_included_packs()`
  repack: 'write_midx_included_packs' API from the builtin
  builtin/repack.c: introduce `struct write_pack_opts`
  builtin/repack.c: use `write_pack_opts` within `write_cruft_pack()`
  repack: move `find_pack_prefix()` out of the builtin
  repack: extract `write_pack_opts_is_local()`
  builtin/repack.c: pass `write_pack_opts` to
    `finish_pack_objects_cmd()`
  repack: move `finish_pack_objects_cmd()` out of the builtin
  repack: move `pack_kept_objects` to `struct pack_objects_args`
  repack: move `write_filtered_pack()` out of the builtin
  repack: move `write_cruft_pack()` out of the builtin
  builtin/repack.c: clean up unused `#include`s

 Makefile          |    6 +
 builtin/repack.c  | 1348 +++------------------------------------------
 meson.build       |    6 +
 repack-cruft.c    |   99 ++++
 repack-filtered.c |   51 ++
 repack-geometry.c |  232 ++++++++
 repack-midx.c     |  372 +++++++++++++
 repack-promisor.c |  102 ++++
 repack.c          |  361 ++++++++++++
 repack.h          |  146 +++++
 10 files changed, 1461 insertions(+), 1262 deletions(-)
 create mode 100644 repack-cruft.c
 create mode 100644 repack-filtered.c
 create mode 100644 repack-geometry.c
 create mode 100644 repack-midx.c
 create mode 100644 repack-promisor.c
 create mode 100644 repack.c
 create mode 100644 repack.h


base-commit: dd52a29b78d80e425be660f3b443a42e0374a7d1
-- 
2.51.0.243.g16eca91f2c0
