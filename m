Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CD79CD
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652499; cv=none; b=DoXaxqmLK3ZxJPwEkHJ7zOrh0Ejhyn/SpyszNOjzPUYDYxGeaHHkoUMOVo10yYTxX4ZcTzVHmTlw8Vm6vbfqI6LvtgfBvv81aeS0pSkM/o/Zm5Plu0VmbJFLelge3f0fQgI0ZJtrexbKPohAQG3KZ47ePnurt6yR/Ush++LL7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652499; c=relaxed/simple;
	bh=lVTrX7LIBpV2x6oFnHzEfdqMA41iYPnohgzts/FGNvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HssI8aZT5BBgwGFznjDvBWuTParNcPFvgEWGVKZ4iFYxIYmDiAv5eSRYK/TW4hoRBXs5u3cKXy7SQvy8h7RhAlCn1ntoOBxZNzpJwofB+9q4F8YCse18tPqrusgu9ldtop6/hSw9coiUXpa2EhZkJtqQuQzrTZfzr5FraUI9Ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pHDrKJOz; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pHDrKJOz"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e634c42a296so3617931276.3
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741652496; x=1742257296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AbJBB8E6S6l8AGFYm9RB9ldaHx0TakzyxGd0Q1EyH/M=;
        b=pHDrKJOzS3UvPVtMJv6b6cjtMMZaP1lubZJdgJO7WNvR356tOIFfRLS22YpMpKbmjw
         VtD7bz63PcM2Jy13WldZ2suGPUsFCjwqAw0FHpHK5Q9wzv7BHBudgij5ZYTisriBLKuB
         Ii2fPfpshXtxMh14B1j6aJfpdCX4SneRWGY5WQAdfyY024sNhswVBheegbREt999ou5e
         pjldbWjPfoHWZMeneZbu1GsNJBsiRJbATZYsTMB7xaYY1J3PlWDW9muht4sl9tlxYylE
         dLv/PjCUR0vp1150JO+LqKnOqWoy2B1nfy7Zkb3tsYFNCroy0oLSEYBUP5wYymD6e8pt
         4s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652496; x=1742257296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbJBB8E6S6l8AGFYm9RB9ldaHx0TakzyxGd0Q1EyH/M=;
        b=ZDDcSg17VtiTrCFcUMHNoIBln3dnUAe0Tqhgnosc73Oi93Csx/+zZD0Zd8hm/9sgdY
         LUat8943CZ03hrlQDjgi7zYxF9eTr6l0XjKjZygDztXRkAnh+XwdYGrRvgNar/8cZTgI
         gl44HwP9z6QOV86PQ4JEjqMkYj9rrZo6wrDL8WrUAlctX6FSd7havgrk3tCxvEsA1axv
         x3a4ZrsT7hzXGRNHvjdfY2Cad0t+OpX+Znbm/F3QEdvIq6bPFw4hs/eoQZ39w7x61pWW
         OcxIrQDkaGBarWge5gBZnXlxjd+AUbRQLd+eKvh0Hu8cIfJq5ehwnixNt780eT8ywX6t
         c1fg==
X-Gm-Message-State: AOJu0YyUIV7s/aK0pm6Eew0Voaw+x0BGk2QNrhLq5UWJeBkOD4DOLkQs
	KDtfg/7+0Jjjf7Zosi4bXLvE9CGFzZsynRexUsB5gefyLiED0hh/rg2u1ls2y4ICmhdqOjOrWiU
	sTZk=
X-Gm-Gg: ASbGncu4QqEgt3ydGwCIyFCQC+eTKBn7OUGNPwfK0dl5Vuv5jZyET54o0Tul7LiLcBB
	73gG4imoRzhw6kQgCsB64gfW+aJG4hdskzSXW96y0bIPRB4UQJAEkXx8rsEuTDbYudwoT1jcmHq
	7VxntbmcoDN3nV5QPYPPc5r+tcbO0yKWMtMEIr7W7OD2zXVLHJE+Kn25eC4ORr/AhlZb4uYe8Y1
	FYQjGcu/C4leVpN8L/ZAgTjxszjXyUDlkgbtgnxF3ShdFr3Y5Fhu4xKhCce0XRtDDigmxc6X+ek
	xAWUmo28oqEnxf6XMnmjUO7X98SfxStibStwgIFvJeexL9i4AXnXB92mjS7faEqRVdb20GfIdN/
	B9NzoF8BQD6yFLg5o
X-Google-Smtp-Source: AGHT+IEnHdazAEqH83nxGstf8whOY7i6ZconDKBg1+6h84awYH4qhhscZ4/N5jSqDOwTHjgSrED/0Q==
X-Received: by 2002:a05:6902:2193:b0:e5d:aeb7:6e5c with SMTP id 3f1490d57ef6-e63b51a971cmr1982085276.28.1741652496511;
        Mon, 10 Mar 2025 17:21:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b843c7dsm2436966276.24.2025.03.10.17.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:21:36 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:21:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft packs
Message-ID: <cover.1741648467.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1740680964.git.me@ttaylorr.com>

Here is a slightly larger reroll of my series to fix object freshening
when using multi-cruft packs that I have been meaning to send for a
couple of days.

I realized after sending the last round that not only was the first
commit from v1 flawed (for the reasons Patrick identified) but that
there is currently no way to grow a new cruft pack past the configured
limit.

Independent of this series suppose for example that we have two 100 MiB
packs, and the threshold is 200 MiB. We should able to in theory combine
those packs together. But we can't! The largest pack we'll make is
199MiB (and change), since builtin/pack-objects.c::write_one() will
refuse to write any object which would bust the limit given by
--max-pack-size.

This series resurrects the first patch from v1 after introducing a
behavior change for 'git pack-objects --cruft --max-pack-size'. When
given with '--cruft', '--max-pack-size' now allows pack-objects to grow
a pack *just* past the given limit by at most one object. This allows
packs to grow past their threshold and age out of the active generation
of cruft packs so they are no longer repacked with each 'git repack
--cruft'.

We're way too late into the -rc cycle for this to land in the
forthcoming release, but I wanted to get this off of my workstation
anyway to allow folks to review it as they have time.

As usual, there is a range-diff since last time. Thanks in advance for
your review!

Taylor Blau (6):
  t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
  t7704-repack-cruft.sh: consolidate `write_blob()`
  t/lib-cruft.sh: extract some cruft-related helpers
  pack-objects: generate cruft packs at most one object over threshold
  builtin/repack.c: simplify cruft pack aggregation
  builtin/pack-objects.c: freshen objects from existing cruft packs

 Documentation/config/pack.adoc      |   4 +
 Documentation/git-pack-objects.adoc |   4 +
 builtin/pack-objects.c              | 150 +++++++++--
 builtin/repack.c                    |  38 +--
 packfile.c                          |   3 +-
 packfile.h                          |   2 +
 t/lib-cruft.sh                      |  23 ++
 t/t5329-pack-objects-cruft.sh       | 317 +++++-------------------
 t/t7704-repack-cruft.sh             | 372 +++++++++++++++++++++++-----
 9 files changed, 544 insertions(+), 369 deletions(-)
 create mode 100644 t/lib-cruft.sh

Range-diff against v3:
-:  ---------- > 1:  390c3a6d85 t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
-:  ---------- > 2:  e7ebe6c460 t7704-repack-cruft.sh: consolidate `write_blob()`
-:  ---------- > 3:  aa7588f817 t/lib-cruft.sh: extract some cruft-related helpers
-:  ---------- > 4:  f2ca92245a pack-objects: generate cruft packs at most one object over threshold
-:  ---------- > 5:  12ddea7603 builtin/repack.c: simplify cruft pack aggregation
1:  c80188164e = 6:  d44a124c81 builtin/pack-objects.c: freshen objects from existing cruft packs

base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
-- 
2.49.0.rc2.6.g9a1eecd400
