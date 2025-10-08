Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124C2BE653
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759896637; cv=none; b=Ozqtjv4y+s/sL0AiOfMYfkNXxOAlvNtENDh6L5+TH9STisBAVt1zl2y1wnZAx2UWpDS7wNWqUYy9QCmRJ9OrBLh6cYsq8UhtfHNHFvlOAoO8sHGWeW3EerDSBZLW1j6JtZKpq4BC6+77ZbHuQbRZvLpvWe8htCh2AU4FGjwJTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759896637; c=relaxed/simple;
	bh=7JuEIX2x6fmzMC+OT28Fh4VBacl2JukVDcrW69EBIxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aynllvpww/fCFe/o3HgrKg7o9iJ1Wced/hpjgyu1yFk03R8MWn9CQtHR0efCxtGXXJAXc5rOa87iseXhugS2P0ObGS6RbasrDuLs+HQe3rjKajZoGcF1NTripUc5KIRYWev1w7932NHqQXyLFZidzwfS1mJk+mXKXgoec+FjQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvHOKJvE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvHOKJvE"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42f69f5db55so39830525ab.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 21:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759896635; x=1760501435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so/eZ3pvN23ra6Wk74aWvNBnvMj/U5qec9+BX1fFjd0=;
        b=mvHOKJvELSRLzCB+iu3GaFAajeenL365BnuqTHt7JJCY6Nuzul46SoWiX2eZNVXkih
         zXloazQjVGTgVxRlWzcs0fXHePB4MQ071cv5Lx3xoG9XXCNJsyRWqTcYpc7Gtm7lRgDY
         4qaZH75m6u9abuI+A+/V7R5S9CU0UoL1dO+49Jgdbqip1/Z6jHuwV/mU1xfGsCAeLa9H
         hyjsGEnuVSvf2xlaswkN2oUu7GRDhK3El8KogjGdZ94q0gCCtIb8uq96g8j3h2iOQlgI
         bW+hNOswcIMrSCsyVvIxGwSv6iulb/84kclKHcpMdwveeTh7wKrlISk674AQ2EBPNnM2
         CUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759896635; x=1760501435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so/eZ3pvN23ra6Wk74aWvNBnvMj/U5qec9+BX1fFjd0=;
        b=KRsNbJKEqoclvsLmNekxAyJHv/+gkYyEhdmxBz/enTDclRJLjw0/sqBFSXtqpC41kc
         +kXUIMH94NNHAXAELataFXh/via3GSrJ1L8OBud35zC9+yzJPuzmtGT2aLZE3F6eFUXP
         c54RrcnLi2QEs/gRliNs3UaRi6OnzH8zzMuaqpMDqqwNV9n3O1/Gj51d7Ez7TqUffXGY
         4ErDZxPJSdiV8+iwGoeurarhS/FMKoda4Y/DjcWid9Xbch8b8h8bNWWYMckWVQwouZsJ
         a96Vw68ZmyuymcZI36CUWW8+AFinaSwi3FaS/iOT0J4Z1bJYeHEhUvEEPgpiw621hdIl
         mmzQ==
X-Gm-Message-State: AOJu0YxSKAP/LjCDfAihrYCUkDBHXa2+A2Kp8lWso2hRDR0eg1MlXMpH
	Lii8x/9N7GSCrme96NO1IsDwDyNcpVqN6Yubhb6aB7zbSmj5hXXhDMBwgHxKJjLCjhcqtPvz7Rp
	CbgXcc1Y1ppkFOHtQJ+Sslvs678Anj0Yo3uA5
X-Gm-Gg: ASbGncsQ8/eIHPyJo+/qM1DZG6gqiFHDWxsef3mnbj4atiFqIW292S3LLHMtX/2ARcm
	rKw6EyLFE2c9kIyzARb0G5k0EuO+Dh6nLPIdn/XaD+/ETU83JIOtyJ7lcM/CLL3o2bsQCgbmwRs
	76lglTPrBM4y4Bd5Yme4zjJGJAN5rEbtxTqEZ93EdkRt6Fbyqxvbmzo8UfknJC8aqotfzeFM8WW
	r+gjRwjhXrGPNYE2kivYpvnlrLqQl1OA1cOJPcVNrSyvJXO9h8NhYPsdA3GvjrD
X-Google-Smtp-Source: AGHT+IETXNg2FnAhznts2/CdO3FZgrz+Y1xbf6+kagZ/p/ixEEUm0dgKJzYjrjDNmBaKE16ITt3z47GPu5n8HiicKxc=
X-Received: by 2002:a05:6e02:2783:b0:424:866:ec6d with SMTP id
 e9e14a558f8ab-42f8736d251mr19139295ab.12.1759896634890; Tue, 07 Oct 2025
 21:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqqzvfmwcx.fsf@gitster.g>
In-Reply-To: <xmqqqzvfmwcx.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 21:10:23 -0700
X-Gm-Features: AS18NWCZGIaF6HMFfOVqOm-skiyxMQJcQpLSoyQVgHWTtZ33BwNgBpC3Nun35vs
Message-ID: <CABPp-BEPYFua9XvNBbn3kzEksyqrrTKfViMtG3=-=YSEU3Jdrg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2025, #02; Mon, 6)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> --------------------------------------------------
> [Cooking]
>
> * tb/incremental-midx-part-3.1 (2025-09-29) 51 commits
>  - SQUASH??? play well with other topics by preemptively including "repos=
itory.h"
>  - builtin/repack.c: clean up unused `#include`s
>  - repack: move `write_cruft_pack()` out of the builtin
>  - repack: move `write_filtered_pack()` out of the builtin
>  - repack: move `pack_kept_objects` to `struct pack_objects_args`
>  - repack: move `finish_pack_objects_cmd()` out of the builtin
>  - builtin/repack.c: pass `write_pack_opts` to `finish_pack_objects_cmd()=
`
>  - repack: extract `write_pack_opts_is_local()`
>  - repack: move `find_pack_prefix()` out of the builtin
>  - builtin/repack.c: use `write_pack_opts` within `write_cruft_pack()`
>  - builtin/repack.c: introduce `struct write_pack_opts`
>  - repack: 'write_midx_included_packs' API from the builtin
>  - builtin/repack.c: inline packs within `write_midx_included_packs()`
>  - builtin/repack.c: pass `repack_write_midx_opts` to `midx_included_pack=
s`
>  - builtin/repack.c: inline `remove_redundant_bitmaps()`
>  - builtin/repack.c: reorder `remove_redundant_bitmaps()`
>  - repack: keep track of MIDX pack names using existing_packs
>  - builtin/repack.c: use a string_list for 'midx_pack_names'
>  - builtin/repack.c: extract opts struct for 'write_midx_included_packs()=
'
>  - builtin/repack.c: remove ref snapshotting from builtin
>  - repack: remove pack_geometry API from the builtin
>  - builtin/repack.c: pass 'packdir' to `pack_geometry_remove_redundant()`
>  - builtin/repack.c: pass 'pack_kept_objects' to `pack_geometry_init()`
>  - builtin/repack.c: rename various pack_geometry functions
>  - builtin/repack.c: remove "repack_promisor_objects()" from the builtin
>  - builtin/repack.c: pass "packtmp" to `repack_promisor_objects()`
>  - repack: remove 'generated_pack' API from the builtin
>  - builtin/repack.c: provide pack locations to `generated_pack_install()`
>  - builtin/repack.c: pass "packtmp" to `generated_pack_populate()`
>  - builtin/repack.c: factor our "generated_pack_install"
>  - builtin/repack.c: rename "struct generated_pack_data"
>  - repack: remove 'existing_packs' API from the builtin
>  - builtin/repack.c: avoid unnecessary numeric casts in existing_packs
>  - builtin/repack.c: pass "packdir" when removing packs
>  - repack: remove 'remove_redundant_pack' from the builtin
>  - builtin/repack.c: rename many 'struct existing_packs' functions
>  - repack: remove 'prepare_pack_objects' from the builtin
>  - repack: move 'delta_base_offset' to 'struct pack_objects_args'
>  - builtin/repack.c: pass both pack_objects args to repack_config
>  - repack: introduce new compilation unit
>  - builtin/repack.c: avoid using `hash_to_hex()` in pack geometry
>  - builtin/repack.c: avoid "the_hash_algo" in `finish_pack_objects_cmd()`
>  - builtin/repack: avoid "the_hash_algo" in `repack_promisor_objects()`
>  - builtin/repack.c: avoid "the_hash_algo" in `write_oid()`
>  - builtin/repack.c: avoid "the_hash_algo" when deleting packs
>  - builtin/repack.c: avoid "the_repository" when repacking promisor objec=
ts
>  - builtin/repack.c: avoid "the_repository" when removing packs
>  - builtin/repack.c: avoid "the_repository" when taking a ref snapshot
>  - builtin/repack.c: avoid "the_repository" in existing packs API
>  - builtin/repack.c: avoid "the_repository" in `cmd_repack()`
>  - Merge branch 'ps/packfile-store' into tb/incremental-midx-part-3.1
>  (this branch uses ps/packfile-store.)
>
>  Comments?
>  source: <cover.1759097191.git.me@ttaylorr.com>

I'll try to take a look...

> * cc/doc-submitting-patches-with-ai (2025-10-01) 1 commit
>  - SubmittingPatches: add section about AI
>
>  AI guidelines.
>
>  Perhaps we should adopt what QEMU uses for simplicity?
>  cf. <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
>  source: <20251001140310.527097-1-christian.couder@gmail.com>

I preferred the version Christian sent out over the QEMU adaptation...

> * rj/doc-technical-fixes (2025-10-02) 3 commits
>  - doc: commit-graph.adoc: fix up some formatting
>  - doc: sparse-checkout.adoc: fix asciidoc warnings
>  - doc: remembering-renames.adoc: fix asciidoc warnings
>  (this branch uses rj/doc-missing-technical-docs.)
>
>  Documenation mark-up fixes.
>
>  Comments?
>  source: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>

Documenation -> Documentation

Ramsay commented that he had a small fixup to send after waiting for
more feedback (https://lore.kernel.org/git/436fb507-6764-46f4-abb1-34c82e27=
b808@ramsayjones.plus.com/),
so maybe mark as waiting for a re-roll?

The series looked fine to me, I just feel bad for causing so much work
for him.  Are the things in Documentation/technical/ meant to be
pretty-formatted and distributed anywhere?  I assumed the audience was
fellow git developers and the original .txt file (that someone else
renamed to .adoc) was the preferred viewing format.

> * kh/doc-patch-id-markup-fix (2025-09-29) 1 commit
>  - doc: patch-id: fix accidental literal blocks
>
>  Documenaotin mark-up fix.
>
>  Will merge to 'next'?
>  source: <v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name>

I think Documentation is determined to be misspelled in your release
notes, in various exciting ways.  :-)

> * sa/replay-atomic-ref-updates (2025-09-26) 1 commit
>  - replay: make atomic ref updates the default behavior
>  (this branch is used by ps/history.)
>
>  "git replay" (experimental) learned to perform ref updates itself
>  in a transaction by default, instead of emitting where each refs
>  should point at and leaving the actual update to another command.
>
>  Comments?
>  source: <20250926230838.35870-2-siddharthasthana31@gmail.com>

Maybe mark as expecting a reroll?  Christian, Phillip, and I all left
several comments, and Siddharth responded to each of us saying he'd
incorporate the feedback into the next round.

> * bc/sha1-256-interop-01 (2025-10-02) 9 commits
>  - t1010: use BROKEN_OBJECTS prerequisite
>  - t: allow specifying compatibility hash
>  - fsck: consider gpgsig headers expected in tags
>  - rev-parse: allow printing compatibility hash
>  - docs: add documentation for loose objects
>  - docs: improve ambiguous areas of pack format documentation
>  - docs: reflect actual double signature for tags
>  - docs: update offset order for pack index v3
>  - docs: update pack index v3 format
>
>  The beginning of SHA1-SHA256 interoperability work.
>
>  Will merge to 'next'?
>  source: <20251002223855.1022847-1-sandals@crustytoothpaste.net>

brian said he was planning on sending a v3
(https://lore.kernel.org/git/aOA6z-kFCd78XtxX@fruit.crustytoothpaste.net/),
so maybe not yet?

> * en/xdiff-cleanup (2025-09-26) 12 commits
>  - xdiff: change type of xdfile_t.changed from char to bool
>  - xdiff: add macros DISCARD(0), KEEP(1), INVESTIGATE(2) in xprepare.c
>  - xdiff: rename rchg -> changed in xdfile_t
>  - xdiff: delete chastore from xdfile_t
>  - xdiff: delete fields ha, line, size in xdlclass_t in favor of an xreco=
rd_t
>  - xdiff: delete redundant array xdfile_t.ha
>  - xdiff: delete struct diffdata_t
>  - xdiff: delete local variables that alias fields in xrecord_t
>  - xdiff: delete superfluous function xdl_get_rec() in xemit
>  - xdiff: delete unnecessary fields from xrecord_t and xdfile_t
>  - xdiff: delete local variables and initialize/free xdfile_t directly
>  - xdiff: delete static forward declarations in xprepare
>
>  A lot of code clean-up of xdiff.
>  Split out of a larger topic.
>
>  Will merge to 'next'?
>  source: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>

I think so; I stopped an earlier almost merge down to next
(https://lore.kernel.org/git/CABPp-BH-oaV+fJ4u50oofy54ycE5oKoYJ6O1XgEt_JfDS=
gXvxg@mail.gmail.com/)...and
then seemingly sparked an awful lot of other reviews as well (or maybe
people just were intrigued by something in the rerolls).  Either way,
the topic seems to have been quiet for a few weeks now, and I think
the topic looks ready to merge down now.

> * ds/sparse-checkout-clean (2025-09-12) 7 commits
>   (merged to 'next' on 2025-09-25 at 00b296f153)
>  + t: expand tests around sparse merges and clean
>  + sparse-index: point users to new 'clean' action
>  + sparse-checkout: add --verbose option to 'clean'
>  + dir: add generic "walk all files" helper
>  + sparse-checkout: match some 'clean' behavior
>  + sparse-checkout: add basics of 'clean' command
>  + sparse-checkout: remove use of the_repository
>
>  "git sparse-checkout" subcommand learned a new "clean" action to
>  prune otherwise unused working-tree files that are outside the
>  areas of interest.
>
>  On hold.
>  cf. <3537e220-44b6-4e37-a568-cef34a2fddfd@gmail.com>
>  source: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>

I think it's almost ready, it just needs a few messages improved; I
commented on a couple patches and the cover letter.
