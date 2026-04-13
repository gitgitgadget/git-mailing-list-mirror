Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F061C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124601; cv=none; b=Oqpe7PYUHoPOpEmvX4ZhRsxDWm3a77WbkOxefB9nPbM6neVzQjs1mium/k6ieYESnwfToDegFwNAuK/wmuka7kxwfbyNT+pd+O/YhT8D/IncovAYo158U6kodYLcC/g3Lb+cqkA2uBiHtN8gxVWtyS0ziEf0f+UI0WAKNN4s+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124601; c=relaxed/simple;
	bh=7LZKCh5vDUgXSax/VikLnzMJrRA2As5wVsRUi8LrWhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hmV+WIPwpqiaHzg12PMsQNygZYCVF1S4FiZT98SqpglhOKeEtAAG+oQapn5KCAD3SkrPdIGR2C0NNl/bUmdzi5Nk91m6NUwc8/Zwramm1JRBNN0xN6FBYXTin1i3GDQgW9jchFOtllO0SEihOgbPi6OaIZM9pDye1WSbz2SrMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dGt9HCU7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dGt9HCU7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a2ee65171so59059297b3.2
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124599; x=1776729399; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJpCfobZUo9Pt4LA/hVYFLkC0tTiZCaKr1U0xhXhHX4=;
        b=dGt9HCU7aq4T299ixSfYvz1H8/tP4m+gBg+rdSvNtLZojv1lnVF14JuLOA2zlkuwk4
         pnQbm05S5urf//m/FPnEx0C5OcALOrmwr4y0SlzygJQnzpHJ4fH12GlNNmFaHOcE5FqY
         r1Yskw3JVAozv+4xkxXSanAt2tss2F6gYfJl/RHZO4YwYE8K2NvSN7019m5xApYcIf82
         T5RrD6lO9PuJuPyRyecLf9NQFIFvpmJrr6tzA9HKervb4+4l90/MjEO8pSnMwW6CA0yI
         QGf5lpoiwfzvNn8RMNp8GNHmowWanY0ZnfjsfXXgsswK/RMrZxAYI83Lsf5Kpy/B9TTE
         SRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124599; x=1776729399;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJpCfobZUo9Pt4LA/hVYFLkC0tTiZCaKr1U0xhXhHX4=;
        b=BMaFpYtZmO0S76ehsugPrPin58peNdYAdcPpTgy0y5zhf4i1Uov8pc4R6J/x1ZITv9
         6qx1d97W+xpbUIMQvxfF4iJpmDVSZC7cD47r920wVAnJRrggn8IhNRfNc4GriFJSnZVx
         aty+Amehd7Y5zv238zCRtB3GQ0RTxKKpQ99n1HE1VzX7ew9/QfMH0IyKaUNjwnqinoF/
         LAw3oEFrfMGsRgPytAWh7KqNOnwIP6H2YiiA5HcISSNfp/j0QWMx7ifsL2M3Oxc2XGgR
         QjUKVsRWHxqDSL+RMixa9bswm88yoUSqlES73yT+jNn6FPgjMV2bV/sf4lUVNTkMCHLh
         r8tQ==
X-Gm-Message-State: AOJu0Yyrm9K/MPCQHnN7G1tswqJK9OU4zXE3p9Grs8Kj6AVM6gzsxEst
	aLu7OAwxxCIRPyW0MjtQx7iYZGGpb07A2PGNNq0mM9pRQF5pA594CurHmYkoO/v/ee6nBCIeo//
	oFjXd2Sk=
X-Gm-Gg: AeBDietZTVPUR+pDKQlOaqFxFZfRyK2KomzveJn+EeuZ/UwQtdVC/m2hlFNq58w12VU
	rm06fJGvX5V7l5HfWBhO4G/UxGnAmzvyWYaumM1l1eiJPX8JAIY2RKlVMftedScEKmMbXa+tUlE
	+uC0L69/UYmKvbAUQb1S2t+T7kysxpc3qrkNl3vuR164LzvnyRNrh+m3rSJX4P5GZXAcFoDaT2l
	YXfx3FKjyj02W830OShF4Lr4BvfGgXoykqcN0Hi59W4nxgFxvJ/lyblJzZnv0KQn6Q9wGfYaNMJ
	jSi5i4iXClxykexbKPOGPJJqndDTE5hdWx4UAqCLgtKGO2EfKI+tEyfpy+yLsf3DhRHcFk+bVtb
	Bg3I2uirsBi5cahwwuaX/o8sooAUmVLxsQt16kGxy4JV6juGCGRitYuVqv8WnpIamNF1J9pki3N
	FrDBNWaLP0XHXz43TMmIKyDmgol1IalRxnQ/NsCOuZWBlfc154pVwU/8IBD8pfK5f6mKFx/A8ck
	Gg8+aw8R+4mEIhyssYoNOOzckMFFQeRekSzy8iBUcMtkav61pnBx9y0vIrqoihX0XpRQRAuORfM
	QCAnp5m1BZ+HZ9MbydwpbpyhjhE=
X-Received: by 2002:a05:690c:c511:b0:7a4:e4e5:3900 with SMTP id 00721157ae682-7af714762edmr162786197b3.31.1776124599007;
        Mon, 13 Apr 2026 16:56:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b2efe89b47sm21387987b3.10.2026.04.13.16.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:38 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/8] pack-bitmap: fix various pseudo-merge bugs
Message-ID: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series fixes several bugs in the pseudo-merge bitmap implementation
that caused the pseudo-merge application path to be effectively broken
during fill-in traversal.

Peff noticed that this code path was never triggered by the existing
test suite, and investigating that observation uncovered a handful of
bugs, some compounding.

The first two patches introduce test infrastructure: a 'bitmap write'
test helper that gives tests precise control over which commits receive
individual bitmaps, and a set of "test_expect_failure" tests
demonstrating each bug.

The next four patches fix the bugs in the per-commit pseudo-merge
lookup:

  - The pseudo-merge commit lookup table was sorted by OID rather than
    by bit position, causing the reader's binary search to fail.

  - The binary search in pseudo_merge_at() had its lo/hi updates
    swapped.

  - The extended pseudo-merge lookup path had three compounding bugs: a
    wrong entry-size calculation in the writer, a misinterpretation of
    extended table entries in the reader, and a silently-swallowed error
    check.

The final two patches fix issues in pseudo-merge group selection:

  - find_pseudo_merge_group_for_ref() did not parse commits before
    inspecting their dates, so all candidates had date == 0 and were
    unconditionally placed in the "stable" bucket.

  - The config validation for bitmapPseudoMerge.*.sampleRate accepted 0,
    which leads to a division by zero once the date classification is
    fixed and the unstable code path is exercised.

There is also a small fix for a regex leak when the pattern key is
overridden in config.

Thanks in advance for your review!

Taylor Blau (8):
  t/helper: add 'test-tool bitmap write' subcommand
  t5333: demonstrate various pseudo-merge bugs
  pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
  pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
  pack-bitmap: fix pseudo-merge lookup for shared commits
  pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
  pack-bitmap: reject pseudo-merge "sampleRate" of 0
  pack-bitmap: prevent pattern leak on pseudo-merge re-assignment

 pack-bitmap-write.c             |  23 +++-
 pseudo-merge.c                  |  19 ++-
 t/helper/test-bitmap.c          | 110 ++++++++++++++-
 t/t5310-pack-bitmaps.sh         |  24 ++++
 t/t5333-pseudo-merge-bitmaps.sh | 230 ++++++++++++++++++++++++++++++++
 5 files changed, 396 insertions(+), 10 deletions(-)


base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
-- 
2.54.0.rc1.73.g8f4e0170952
