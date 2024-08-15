Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88714D2B8
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760934; cv=none; b=eEldp3+uwTj1vz5rcsUPc1OE+IitQ2L9rJfjvxEjiTQdNIK0j02dU790zYPWngyun4OhoR3yF+i1+QYmLNU/MJDelBBEM7HY1bclytaXMr4xHKBgKVTrLI/gKM3c+LPqJUZrQBiMR/yU4E3zuxgaCPjjzRPxANPVlfQ94Wo2AG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760934; c=relaxed/simple;
	bh=bvYoXUdzYOVfzLfa+t1dhUUuSsF/2oRbbXJ513eKCTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwoXZ94cLHx8+obUzX++M0u1kjhbzoi0jQA1E5MqYWe7Ed6Rm/PBYLtUUFRXLHPwSOWr57ygw4th0RHoSHSip+kUlY65TQBH048NEBCRKsI4v0MzfVn1ClLcYSbYC/zChxO25KR6bpqq+r8vBheicSl6/85mrG7rgPq6bgcleEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Tw0O50Ow; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Tw0O50Ow"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-699ac6dbf24so13725447b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760931; x=1724365731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibO9SvteTshZVjSOf6j0kIBhXsI+QsauIFApu18VA3w=;
        b=Tw0O50OwKwYUO2njCCTvBruHIH6Jrwc5hkIY+s7DH7I9KK4Flq4AU8glon8KrJXdtX
         Xyccqq+vLNDkJLXy9OP3Ma828gpe71lkLAyPpX+nIBmYQdf28tapydRpvCarhwljyijm
         D8WcRXEzb8uA3o4b2pkzCFSuzgaaapj75tsG0X+t+0nChhUO1ZJCSDZpWFVRVj1cAAys
         3JV90V8a4aIEW4znZYOUriYVUgnKDghPmr3+yU7Sz1SXJCpT7PJfx7jKEWwn55vQOkV0
         8R65/bmlgEcib0HQj1+KjtWi3EXzl+8QPGbZweWuSb+RoFOXLQ5+nunbVkTDkP2zs7jr
         Vr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760931; x=1724365731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibO9SvteTshZVjSOf6j0kIBhXsI+QsauIFApu18VA3w=;
        b=kZdbpR+w1nSdVUjnd3Icw7WEX+sfGPoj5r0Zfr6ehTU9q81U3RURosNbc4Zq1RxcYJ
         iVYSUSlEH/Zk2yZI2crJvvfBxOlz/p0gOWVagTYJcpgTvv2Lhc3rBcegjjvz87absZVA
         PAduZLEXEUgKx813UubNUjQvoF/GPjYC9FEn/dwg4gBxVruZ6AAGosa0jLfTmY9iQCNk
         Bo9kw8Ec3wUReMMLzapuBI+bCiX31GDWbWbafbvmYHF1wMIMicSJjjfLY+N6FqElCj5R
         z3ZAYvglxj5DqjAS5r36xUSvzt1z6B+wyNsRKNO6yG3WsiAACQIoHKDXGD/wU7tyhqHi
         ALbg==
X-Gm-Message-State: AOJu0Yy985RVQW9hE4z0ase3kvpmVFJ+iU2D7t19reOSQNpH6z2QlcVR
	aI98WnvSfLKBsXb1B0BfKbbxrO1pWWdPeMJfuW0JU4AGO+Lxm0mdirUFTV+DI8HD+UQcrjWvc0D
	n
X-Google-Smtp-Source: AGHT+IFUEeqwm4uZ5VsLIx/iae3YBfwvSH3zqukJJRPUbqES5ewrJcxnSthmgd7UwpkOz/ebfFECug==
X-Received: by 2002:a05:690c:288:b0:6b0:4f2b:29f0 with SMTP id 00721157ae682-6b1ba9d7207mr11391667b3.29.1723760931221;
        Thu, 15 Aug 2024 15:28:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e1d938csm4087587b3.141.2024.08.15.15.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:28:50 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:28:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/13] midx: incremental multi-pack indexes, part two
Message-ID: <cover.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

== Changes since last time

[The first round did not include commit messages for four intermediate
commits which could benefit from additional description, which has been
corrected here. The code is unchanged from the previous round, and a
range-diff is below.]

== Original cover letter

This series is based on 'master', with an additional merge between
tb/incremental-midx-part-1[1] and my newer series to fix a handful of
bugs related to pseudo-merge bitmaps[2].

This is the second of three series to implement support for incremental
multi-pack indexes (MIDXs). This series brings support for bitmaps that
are tied to incremental MIDXs in addition to regular MIDX bitmaps.

The details are laid out in the commits themselves, but the high-level
approach is as follows:

  - Each layer in the incremental MIDX chain has its own corresponding
    *.bitmap file. Each bitmap contains commits / pseudo-merges which
    are selected only from the commits in that layer. Likewise, only
    that layer's objects are written in the type-level bitmaps.

  - The reachability traversal is only conducted on the top-most bitmap
    corresponding to the most recent layer in the incremental MIDX
    chain. Earlier layers may be consulted to retrieve commit /
    pseudo-merge reachability bitmaps, but only the top-most bitmap's
    "result" and "haves" fields are used.

  - In essence, the top-most bitmap is the only one that "matters", and
    earlier bitmaps are merely used to look up commit and pseudo-merge
    bitmaps from that layer.

  - Whenever we need to look at the type-level bitmaps corresponding to
    the whole incremental MIDX chain, a new "ewah_or_iterator" is used.
    This works in concept like a typical ewah_iterator, except works
    over many EWAH bitmaps in parallel, OR-ing their results together
    before returning them to the user.

    In effect, this allows us to treat the union of all type-level
    bitmaps (each of which only stores information about the objects its
    corresponding layer within the incremental MIDX chain) as a single
    type-level bitmap corresponding to all of the objects across every
    layer of the incremental MIDX chain.

The sum total of this series is that we are able to append new commits /
pseudo-merges to a repository's reachability bitmaps without having to
rewrite existing bitmaps, making the operation much cheaper to perform
in large repositories.

The series is laid out roughly as follows:

  - The first patch describes the technical details of incremental MIDX
    bitmaps.

  - The second patch adjusts the pack-revindex internals to prepare for
    incremental MIDX bitmaps.

  - The next seven patches adjust various components of the pack-bitmap
    internals to do the same.

  - The next three patches introduce and adjust callers to use the
    ewah_or_iterator (as above).

  - The final patch implements writing incremental MIDX bitmaps, and
    introduces tests.

After this series, the remaining goals for this project include being
able to compact contiguous runs of incremental MIDX layers into a single
layer to support growing the chain of MIDX layers without the chain
itself becoming too long.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1722958595.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/cover.1723743050.git.me@ttaylorr.com/

Taylor Blau (13):
  Documentation: describe incremental MIDX bitmaps
  pack-revindex: prepare for incremental MIDX bitmaps
  pack-bitmap.c: open and store incremental bitmap layers
  pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
  pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
  pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
  pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
  pack-bitmap.c: compute disk-usage with incremental MIDXs
  pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
  ewah: implement `struct ewah_or_iterator`
  pack-bitmap.c: keep track of each layer's type bitmaps
  pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
  midx: implement writing incremental MIDX bitmaps

 Documentation/technical/multi-pack-index.txt |  64 ++++
 builtin/pack-objects.c                       |   3 +-
 ewah/ewah_bitmap.c                           |  33 ++
 ewah/ewok.h                                  |  12 +
 midx-write.c                                 |  35 +-
 pack-bitmap-write.c                          |  65 +++-
 pack-bitmap.c                                | 328 ++++++++++++++-----
 pack-bitmap.h                                |   4 +-
 pack-revindex.c                              |  32 +-
 t/t5334-incremental-multi-pack-index.sh      |  84 +++++
 10 files changed, 548 insertions(+), 112 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  d1b8d11b37 Documentation: describe incremental MIDX bitmaps
 -:  ---------- >  2:  f5d0866e5c pack-revindex: prepare for incremental MIDX bitmaps
 -:  ---------- >  3:  43444efc21 pack-bitmap.c: open and store incremental bitmap layers
 -:  ---------- >  4:  4487130648 pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 1:  b7eae5dc61 !  5:  b720fe56da pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs

    +    Since we may ask for a pack_id that is in an earlier MIDX layer relative
    +    to the one corresponding to our bitmap, use nth_midxed_pack() instead of
    +    accessing the ->packs array directly.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-bitmap.c ##
 2:  01b8bd22cd !  6:  9716d022e0 pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs

    +    In a similar fashion as previous commits in the first phase of
    +    incremental MIDXs, enumerate not just the packs in the current
    +    incremental MIDX layer, but previous ones as well.
    +
    +    Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
    +    single pack from a MIDX, use the oldest layer's preferred pack as it is
    +    likely to contain the most amount of reusable sections.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-bitmap.c ##
 3:  928a4eabc8 !  7:  6baece3175 pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs

    +    Implement support for the special `--test-bitmap` mode of `git rev-list`
    +    when using incremental MIDXs.
    +
    +    The bitmap_test_data structure is extended to contain a "base" pointer
    +    that mirrors the structure of the bitmap chain that it is being used to
    +    test.
    +
    +    When we find a commit to test, we first chase down the ->base pointer to
    +    find the appropriate bitmap_test_data for the bitmap layer that the
    +    given commit is contained within, and then perform the test on that
    +    bitmap.
    +
    +    In order to implement this, light modifications are made to
    +    bitmap_for_commit() to reimplement it in terms of a new function,
    +    find_bitmap_for_commit(), which fills out a pointer which indicates the
    +    bitmap layer which contains the given commit.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-bitmap.c ##
 4:  129f55ac28 !  8:  5c909df38a pack-bitmap.c: compute disk-usage with incremental MIDXs
    @@ Metadata
      ## Commit message ##
         pack-bitmap.c: compute disk-usage with incremental MIDXs

    +    In a similar fashion as previous commits, use nth_midxed_pack() instead
    +    of accessing the MIDX's ->packs array directly to support incremental
    +    MIDXs.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-bitmap.c ##
 5:  81839fc1d1 =  9:  f9ae10fce9 pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 6:  63019e952a = 10:  04042981c1 ewah: implement `struct ewah_or_iterator`
 7:  01508e4ff5 = 11:  c4d543d43d pack-bitmap.c: keep track of each layer's type bitmaps
 8:  59a50a2ea2 = 12:  c6730b4107 pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 9:  da34cc9441 = 13:  afefb45557 midx: implement writing incremental MIDX bitmaps

base-commit: f28e4ef872c247b0b35f48b1c3d2c5f77753b908
--
2.46.0.86.ge766d390f0.dirty
