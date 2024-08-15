Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6F6F2E6
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755683; cv=none; b=snKqUYRVAkdN3toEk+xs0cmlxBrb736b7McQeGmIW31+2Nn3Zd9JXddcdhJQ0epJ0WHtonmvxPit4K5LdVoT0keZVQzGa1KQeF/hpGFMAcVVio/J5+EvGcvfWCeeBS84+Mr6xrCWJfPKJQV49DF19liW9AUlNrIGtJgrJ3ZBr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755683; c=relaxed/simple;
	bh=ShV4Ztu7+Ov098u2L+mER+eNp4PxAFTry1Asfo2be6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qhEUavZwDt43vhnQWyIQnbvdyKAupYBzqI9vrYJ9SbsrwjLMNfRn8OWHmF8FctIuB3D3UXPU5wPtaMbfUdskNRMCXt9TwDsUsx2+NpATNWsJeJEKBg4/Qer0ZGfnnctwPxb3IzxUELXSpBOfvipb7uSQPnakRD28N+AYaxxQBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1uojHppW; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1uojHppW"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1022566276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755680; x=1724360480; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6E5N/IX61n/NKQKkLL7lHmuaZoq0sivB7wR6KBbWo2I=;
        b=1uojHppWNuNr6KvwX01qd37jISLjgSQLWkkqNYlpid1BZcyJ+EPk2xz7O3KakZqn5L
         oLwRqJghXuSuFMKmg0kLdQ9113hUZ8tLI7WVhCFLAKL8eu++MnTOhqxHHit8So1qSP2m
         sZdrJ0y12Q5abvezqnG2OxQtRbyhaqEMJugf9mRHVcF5QJJeWJz8TBUivYOanZVNAmkT
         BUYnL2qPrBHvV82qK+dLGuvzjOmREUNmaQ20YxH8KmrwKidFhZH+0RA7WHjshMSdCuXu
         2fGmKfG/cC9SuN+uQbzMxQ3BRzNRkGlv27XnnigVzqfNN85rvDdHIUWxOSqwlZPr5pDI
         DjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755680; x=1724360480;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6E5N/IX61n/NKQKkLL7lHmuaZoq0sivB7wR6KBbWo2I=;
        b=BNLOg0KduKi1Raa3giNr/8rRQ+z6uV5Vv2ApY4b3jtpQ0s/86WwIQzHB1+mqJdXCJ9
         flCsm/WXqWVJO7QWZAJciFBfSkZ32siYAPe2gkA8z+4u7WudruY2AWf8BdrZlCchldhn
         /a8lDzu/Xbtxw2sux/56r/78xXdOnuVS5AwW0VRu+ofN3lYetc8Evmr0E+hETPCc58gI
         3iBGRaSaj1VfiQP+Sn4j6st+R7xJViMAslAHsQoZSLPjuDUBntWog2fL9vaircboN/Vg
         CANnOlrmRVKw6TTZNbIjlZ6FOzr1IWtBVv+pF5jdAR6uyxP4d3Za9UbHS7HUh8+i18Om
         6Dmg==
X-Gm-Message-State: AOJu0Yz0JwnvGnTVLBODrYq5pXlGJRmF+ZaVS2e4bdUHjUHIJPCJ9Voj
	KVwvlHVKVCIJ4F3BOCDyen+OIePr8nJ4+9BHI6dc+EZM+SQbd5EtLieW0GS37zfTWVN9xoIuDSz
	n
X-Google-Smtp-Source: AGHT+IF64ealEAVFV/CPfPbrJ45tx65CBYAscadv4i82cwYMsbBKiozdMWIrqQzf0qhDFddMPtBDSg==
X-Received: by 2002:a05:6902:250a:b0:e03:c692:c8b5 with SMTP id 3f1490d57ef6-e11acd76106mr411222276.19.1723755679863;
        Thu, 15 Aug 2024 14:01:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e11720092ddsm466941276.42.2024.08.15.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:19 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/13] midx: incremental multi-pack indexes, part two
Message-ID: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

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


base-commit: f28e4ef872c247b0b35f48b1c3d2c5f77753b908
-- 
2.46.0.86.ge766d390f0.dirty
