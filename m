Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE972DC789
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959576; cv=none; b=WMri8LIpy6h1vMiAL8h/5IHyZx4r5nQN5AyLIlYuf3iGLsWY5qBmUcTDrwoHPkF1I0p++8p7H1VVwSiiDQAaCTN/v5cftmO1Q8Vb2uC0nNn+TldCda5dH9ogNqJPT3T7iD92SjComgKahzmrnNm2DvYy4T1s3Ujau2lBJ43aVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959576; c=relaxed/simple;
	bh=8SRJqGdhs3KsPckabWG4uOZIdHqv7VdKIKGvVk4gilo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc8UCO35IzyCgvMgHpjYUbFtK2KqC3hb2nUnPMfG7TnVWTl3GyLERvDiLfYVZH5GfNr5g43vxWSKo8i6mHRYUld7EhgYtO21mjaO652/5pqspr45eULWJSbq8GoNRl1gYK+a7P0PhXb+WdKU9HLnncmtv7WYEpSZ+b00v/d4IhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=W5XIqtVc; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="W5XIqtVc"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb40149037so650549185a.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959573; x=1772564373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHVpdSskKxZwkm3oV/Xh6v6QrOaESg3n9+JA6ZMWCpg=;
        b=W5XIqtVc2o8xWVY3Hobj/giKXH/+x6y9+M2zxNGaXyDpULd/e+QWFut7zkP3ICe1pW
         Js8RyYIgP/9q57AI4/OecCGJZsEhZZxe4sYE4ZtTfpVph+lM54aJHhoZlXVAA57/eAcQ
         3m+xudPa1SRV1BumUIpkmyA3AVh78quQdqvBoG8DX6n0vQxvkC2T0I5X1GFwyQzEpNYW
         b87FbP2kQ9UCMvKgVG3jbwP8l2BsEusmnPZCk/x0rbgLWdsomOSGwHAyXf82H2FVepwe
         ovNUEyC9Hs8FHISC0iWPMaS4Wr4qmOobR26X9lJMUjPcEqDjcOlvd9Li+5siZ8cJf4js
         KLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959573; x=1772564373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHVpdSskKxZwkm3oV/Xh6v6QrOaESg3n9+JA6ZMWCpg=;
        b=M2BoUDphHZ9Kv2qA5j6pq+LiSHULqP0rrwvuhG5xmo7bRsx66JEbv+W2bi1z+Yd911
         EdkOwB7amnc9jVYuqTNzQYtXyahDls5spPLiymR9ixW8nnCMO5BGEzO1ntRjo7wOm6pi
         OSjDZM7xJtY8W0vLnucI5sR4y0v8Fj4CH5/pNmMo+hDiNFRuAalSk7QSOj2TntjbIWro
         y+1uPxz/V8ES65lpxDbsEZqqT8RkmMhkdsC95dcuu7Il9WNcqJ0H5fOHSPjpd61nU4cB
         0anBhfRtGtL1upvM6gJNCLsYyfobS371ERXGackhpKWEtAu3YcNKxkZW9q5XuTb2i1MV
         mcuQ==
X-Gm-Message-State: AOJu0Yyp75zOmEycI2ucxY3YLAaZKr0WOq/NGzk6ihnasv4k23CjQuIu
	AcZ8KNCW4iKYYujF+eKMxSK2TERIwAGrXbxNOH/jAM5UpGN5x4aauYdAfdbq940YUF+UbMxuZdb
	wIPVupehWV+oH
X-Gm-Gg: AZuq6aLZCzIaRFeJptR6iAY5OTr3XY4LEWdBKj45BouiA5pFOPcxZ6gDaqNisE11Hhx
	UMijhw2ASKa6iZC60ha6r/fnew6yHMEABq1hf1HJd6QIf9igPY1RSLXjLGvCsLVsaknOz9GzRYV
	K7u0mhCQfPsEZlVWJN+e8n5I4YzCs0Oh6ytK3BfGLtrns0Qosbjy/CD8DMZkhjE48DNDTnbTUos
	4qViXqQiHOY/0mLXSzTPLSS7z04b7yRCnZP18bl3gu/+aWpBGOS5J+ZUQuu7ThItJjpw1tf7+T6
	TqM9SffpJKxXl4G9lHdXcZlFdcyN64z3SMy0STvjD4ZPhbuZBLLUUE4q9oLxn/D+8gqW6U+3jxR
	Yd1/4RTGVJh11LpKkjYecl1/XnIDXv9mj+02/mGsY6au4zdSxaGEEszV+kEvGcftRx/hTY9qZoh
	AhUR2umnpdnwpkTUmlxlkvQ/2KofegvEMhRcNoy9+TGoOEgJpxw22SW5tblhFNXj+b8155yzUJk
	obolknYVLa0bS+rFsSXseM/rMvtdQ==
X-Received: by 2002:a05:620a:199b:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8cb8ca94d09mr1783732085a.79.1771959572953;
        Tue, 24 Feb 2026 10:59:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d05fa3csm998061885a.12.2026.02.24.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:32 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/17] midx: incremental MIDX/bitmap layer compaction
Message-ID: <cover.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

[Note to the maintainer: this is based on 'master', which is 7c02d39fc2e
(The 6th batch, 2026-02-20) at the time of writing.]

This is a tiny reroll of my series to implement MIDX layer compaction
adjusted in response to reviewer feedback.

As usual, a range-diff is included below for convenience. The main
changes since last time are as follows:

 - Some typo and documentation fixes around the new "midx.version"
   setting.

 - Bugfix when adding objects from MIDXs in the compaction range by
   fanout layer where we recur beyond the lower end of the compaction
   boundary.

 - Drop u32_add().

I think that this should be fairly close to done, at which point I can
send the next series (tb/incremental-midx-part-3.3) which introduces the
new compaction-based repacking strategy on top of the tools introduced
in this series.

Like Peff wrote in his review of the last round, the proof here will be
in the pudding, and I am sure that as we continue to test and use these
patches we'll find and fix interesting bugs. But these changes are all
fairly well isolated to the compaction logic itself, so the risk of
regression among any existing use-cases should be low.

The original cover letter may be found here[1].

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1765053054.git.me@ttaylorr.com/

Taylor Blau (17):
  midx: mark `get_midx_checksum()` arguments as const
  midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
  midx: introduce `midx_get_checksum_hex()`
  builtin/multi-pack-index.c: make '--progress' a common option
  git-multi-pack-index(1): remove non-existent incompatibility
  git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
  t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
  midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
  midx-write.c: introduce `struct write_midx_opts`
  midx: do not require packs to be sorted in lexicographic order
  midx-write.c: introduce `midx_pack_perm()` helper
  midx-write.c: extract `fill_pack_from_midx()`
  midx-write.c: enumerate `pack_int_id` values directly
  midx-write.c: factor fanout layering from `compute_sorted_entries()`
  t/helper/test-read-midx.c: plug memory leak when selecting layer
  midx: implement MIDX compaction
  midx: enable reachability bitmaps during MIDX compaction

 Documentation/git-multi-pack-index.adoc |  27 +-
 Documentation/gitformat-pack.adoc       |   8 +-
 builtin/multi-pack-index.c              |  91 +++-
 midx-write.c                            | 525 ++++++++++++++++++------
 midx.c                                  |  39 +-
 midx.h                                  |  12 +-
 pack-bitmap.c                           |   9 +-
 pack-revindex.c                         |   4 +-
 t/helper/test-read-midx.c               |  21 +-
 t/meson.build                           |   1 +
 t/t0450/adoc-help-mismatches            |   1 -
 t/t5319-multi-pack-index.sh             |  18 +-
 t/t5335-compact-multi-pack-index.sh     | 293 +++++++++++++
 13 files changed, 891 insertions(+), 158 deletions(-)
 create mode 100755 t/t5335-compact-multi-pack-index.sh

Range-diff against v2:
 1:  2e549ea6443 =  1:  61045c604c0 midx: mark `get_midx_checksum()` arguments as const
 2:  7255adafe70 =  2:  61dd8e65d1a midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
 3:  25b628fda97 =  3:  cc5c7783062 midx: introduce `midx_get_checksum_hex()`
 4:  2aedd72db8c =  4:  016420264d2 builtin/multi-pack-index.c: make '--progress' a common option
 5:  a00598a36a3 =  5:  feb9ca5538e git-multi-pack-index(1): remove non-existent incompatibility
 6:  92e6d868a45 =  6:  1e86068046d git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
 7:  ff599c11f68 =  7:  06a96e16c37 t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
 8:  315a0ea2985 =  8:  84d9d1ef7ba midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
 9:  af174e22e1e =  9:  132e823e758 midx-write.c: introduce `struct write_midx_opts`
10:  72bcd4ed6c7 ! 10:  3682bfd0e08 midx: do not require packs to be sorted in lexicographic order
    @@ Commit message
         lazily instantiate a `pack_names_sorted` array on the MIDX, which will
         be used to implement the binary search over pack names.
     
    -    Because this change produces MIDXs which may not be correctly read with
    -    external tools or older versions of Git. Though older versions of Git
    -    know how to gracefully degrade and ignore any MIDX(s) they consider
    -    corrupt, external tools may not be as robust. To avoid unintentionally
    -    breaking any such tools, guard this change behind a version bump in the
    -    MIDX's on-disk format.
    +    This change produces MIDXs which may not be correctly read with external
    +    tools or older versions of Git. Though older versions of Git know how to
    +    gracefully degrade and ignore any MIDX(s) they consider corrupt,
    +    external tools may not be as robust. To avoid unintentionally breaking
    +    any such tools, guard this change behind a version bump in the MIDX's
    +    on-disk format.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ Documentation/gitformat-pack.adoc: HEADER:
      
      	1-byte version number:
     -	    Git only writes or recognizes version 1.
    -+	    Git only writes version 2, but recognizes versions 1 and 2.
    ++	    Git writes the version specified by the "midx.version"
    ++	    configuration option, which defaults to 2. It recognizes
    ++	    both versions 1 and 2.
      
      	1-byte Object Id Version
      	    We infer the length of object IDs (OIDs) from this value:
11:  c0c1769464b <  -:  ----------- git-compat-util.h: introduce `u32_add()`
12:  c11214a51f0 = 11:  7f99d3d728a midx-write.c: introduce `midx_pack_perm()` helper
13:  b9244a04297 = 12:  f3952f7db36 midx-write.c: extract `fill_pack_from_midx()`
14:  c6f8d323477 = 13:  238bd203eaa midx-write.c: enumerate `pack_int_id` values directly
15:  e71aa575463 = 14:  3a139575b15 midx-write.c: factor fanout layering from `compute_sorted_entries()`
16:  dbbcb494563 = 15:  505c8d72aa1 t/helper/test-read-midx.c: plug memory leak when selecting layer
17:  13336e864f4 ! 16:  19c983138c7 midx: implement MIDX compaction
    @@ Commit message
            `pack_int_id`'s (as opposed to the index at which each pack appears
            in `ctx.info`).
     
    +       Note that we cannot reuse `midx_fanout_add_midx_fanout()` directly
    +       here, as it unconditionally recurs through the `->base_midx`. Factor
    +       out a `_1()` variant that operates on a single layer, reimplement
    +       the existing function in terms of it, and use the new variant from
    +       `midx_fanout_add_compact()`.
    +
    +       Since we are sorting the list of objects ourselves, the order we add
    +       them in does not matter.
    +
          - When writing out the new 'multi-pack-index-chain' file, discard any
            layers in the compaction range, replacing them with the newly written
            layer, instead of keeping them and placing the new layer at the end
    @@ midx-write.c: struct write_midx_context {
      	return ctx->pack_perm[orig_pack_int_id];
      }
      
    +@@ midx-write.c: static void midx_fanout_sort(struct midx_fanout *fanout)
    + 	QSORT(fanout->entries, fanout->nr, midx_oid_compare);
    + }
    + 
    +-static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    +-					struct multi_pack_index *m,
    +-					uint32_t cur_fanout,
    +-					uint32_t preferred_pack)
    ++static void midx_fanout_add_midx_fanout_1(struct midx_fanout *fanout,
    ++					  struct multi_pack_index *m,
    ++					  uint32_t cur_fanout,
    ++					  uint32_t preferred_pack)
    + {
    + 	uint32_t start = m->num_objects_in_base, end;
    + 	uint32_t cur_object;
    + 
    +-	if (m->base_midx)
    +-		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
    +-					    preferred_pack);
    +-
    + 	if (cur_fanout)
    + 		start += ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
    + 	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
    +@@ midx-write.c: static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    + 	}
    + }
    + 
    ++static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    ++					struct multi_pack_index *m,
    ++					uint32_t cur_fanout,
    ++					uint32_t preferred_pack)
    ++{
    ++	if (m->base_midx)
    ++		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
    ++					    preferred_pack);
    ++	midx_fanout_add_midx_fanout_1(fanout, m, cur_fanout, preferred_pack);
    ++}
    ++
    + static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
    + 					struct pack_info *info,
    + 					uint32_t cur_pack,
     @@ midx-write.c: static void midx_fanout_add(struct midx_fanout *fanout,
      					    cur_fanout);
      }
    @@ midx-write.c: static void midx_fanout_add(struct midx_fanout *fanout,
     +	ASSERT(ctx->compact);
     +
     +	while (m && m != ctx->compact_from->base_midx) {
    -+		midx_fanout_add_midx_fanout(fanout, m, cur_fanout,
    -+					    NO_PREFERRED_PACK);
    ++		midx_fanout_add_midx_fanout_1(fanout, m, cur_fanout,
    ++					      NO_PREFERRED_PACK);
     +		m = m->base_midx;
     +	}
     +}
    @@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx)
     +
     +	ASSERT(from && to);
     +
    -+	nr = u32_add(to->num_packs, to->num_packs_in_base);
    ++	if (unsigned_add_overflows(to->num_packs, to->num_packs_in_base))
    ++		die(_("too many packs, unable to compact"));
    ++
    ++	nr = to->num_packs + to->num_packs_in_base;
     +	if (nr < from->num_packs_in_base)
     +		BUG("unexpected number of packs in base during compaction: "
     +		    "%"PRIu32" < %"PRIu32, nr, from->num_packs_in_base);
18:  b599f1ad4b0 = 17:  ac6221686db midx: enable reachability bitmaps during MIDX compaction

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
2.53.0.171.gde83996e422
