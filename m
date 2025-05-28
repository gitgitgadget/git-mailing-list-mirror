Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168C322B
	for <git@vger.kernel.org>; Wed, 28 May 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399862; cv=none; b=BsAyE5y06iIX2EMp/XhFUIxKQ6BknuHePsi64TwMIzW7R6n3jUrUPalGz7Mt47t7doasYm2B1r1gFqXxFRZUYIQVeOYuHlgAZX+ffXd6XHcbgcs3agjlPkg8DefeM/9jZk9po3NMtBCGrEpHEN16t7/8Fm/FEHfzroJETG2ABzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399862; c=relaxed/simple;
	bh=d6SgpoKsWQhFdhBjWvSauqwUdHQRZHztZubUjqGMhpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUOXlOYQVCfjREUHAFunvWe2ftY0UAL3K1a1KJDQM8F6Ru8cNhkBMI40oO5i5F8/xCM95WSB4BzxmCBLUnUVjtcDr95v0nvnWnnmkbwqXUVba1XH9khARUJVTnhuqt8G+sw/vBWD8UdBBn+Lcm7uHcUFsAg6Y6jQ1BfKV8LaxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AD9+J9bP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AD9+J9bP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8d663fa22so52407996d6.0
        for <git@vger.kernel.org>; Tue, 27 May 2025 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748399859; x=1749004659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJfRk55cepJJkPynBqhInHz+8Bod9ogJlBPEBP8wfY0=;
        b=AD9+J9bPkzBhP2B/GPKthHM4RvxipP/7uRTZcs/NBHlE/LkpaTZC6lt5e9YAEAGQaF
         08yy/odhK2DiFMCqpT8sXFM1uI7/lMtgnlXG3sSgqX/J+bkuTEXXWP5JeVA16lgMhO4w
         En1C5SMc0Y7snck4ZQxM8iWY4h79JqI3VTfljPAH7xuf1oVvLWgQ6ZAFOLsIyb28qOuk
         m5emcvk0jAf6cay1j+FGSCoptfDvs6ev02LU7ncvk9eq/L9h6Pv5Yj0su5HmlkaJrtNP
         syihwQpaFptVCaiai4X1zTmEVoR8u5ZiD/JpsDpYYb2x3aXW+TXVRKYnF0X5DU3ExYZk
         PVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748399859; x=1749004659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJfRk55cepJJkPynBqhInHz+8Bod9ogJlBPEBP8wfY0=;
        b=HA9R1C0rduiCTEAMQP4w7gB2/JubJe24wYUgLcgIYR1OqKs7w8zsvuwgip8NSNDZRg
         OQmzysWSeothg4jRBAJFXLshGj9HBemREGCuohqq0K2HqRpUyrRX8lVEKRz3H4LXQO1L
         w9DYL3UNZxMsoFTPLvaaQvYvuMnc7vMpEeqHDHW7K7ufvQOOkBhKeAMmCPgOktrK9Kwi
         sE/HWBiZr9LcIsu/WwljmU2mwWrMISKcNpGgvXth84019gfGIWQADvp8muAe5ds6iP+0
         m29wz4cewc9mgDJGL4TLSrwlkxWEkAYW/EHEnNdto/sgGTMgRUSc4Y0tcEKI+oLaZvbw
         d23g==
X-Gm-Message-State: AOJu0YzmXYQuMyl4c4s0Oc4KXgz63fUrd5FSf8ppBmZ+zA5luB5t9hVa
	Ybd6NT+YNjpOFxcgIQq9dQB1tlWxhk6vV5wAdE5SjpNp/68T8QwH3aPKPYqS/AZOvQrAS5aU2jg
	H9Hed
X-Gm-Gg: ASbGncsp0SDA8wqGm6gXRhBDryAdrzQVUMabuHaanR7BOMk4jzSorbtq+OCD0ZJka4A
	omHqntOfx/l18dOvUqRCVOHt7G97mjNQWesOkxB3dWFZiLgYppHAtBjbhlNHpYPYFHvOjWB1uRz
	h8Wjvem5BpMof/TVQ2CbeuP4GtQYzyQmG208btEOdB2KST+xXZ+3WTo8ZR7T7fEP35FbnDQLnO8
	X7s5cdDzkXCGCJVF6rcu4m8EQPZS8Eup4dmRW2L1Jm++wcpquRayys+pxxyY00+RsN3BGCLBl+g
	hfUIU91zYaZbKSK7Ljg/I6KC5yI8wpOWykGnbWG//V1ZOK2ID+euL8mMjVmkF/z0Ntie2HAuBud
	5rssyTuEWB2wVyuv/yIkVhE4D9UDHlzmL6g==
X-Google-Smtp-Source: AGHT+IGjwokroYjGfEThzWZlBYY1jA1GW+aaNEHOk0Iw8trIs392iJRBMVKKUcM2eLxz3CVydgI5BQ==
X-Received: by 2002:a05:6214:486:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fac0542d7fmr8239266d6.23.1748399858734;
        Tue, 27 May 2025 19:37:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fac0bc7c86sm1239286d6.99.2025.05.27.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 19:37:38 -0700 (PDT)
Date: Tue, 27 May 2025 22:37:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2025, #08; Tue, 27)
Message-ID: <aDZ28C8bqnstJ68r@nand.local>
References: <xmqqfrgptv10.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrgptv10.fsf@gitster.g>

On Tue, May 27, 2025 at 05:54:03PM -0700, Junio C Hamano wrote:
> * tb/prepare-midx-pack-cleanup (2025-05-27) 6 commits
>  - midx: return a `packed_git` pointer from `prepare_midx_pack()`
>  - midx-write.c: extract inner loop from fill_packs_from_midx()
>  - midx-write.c: simplify fill_packs_from_midx()
>  - midx-write.c: guard against incremental MIDXs in want_included_pack()
>  - pack-bitmap.c: fix broken warning() when missing MIDX'd pack
>  - Merge branch 'ps/midx-negative-packfile-cache' into tb/prepare-midx-pack-cleanup
>  (this branch uses ps/midx-negative-packfile-cache.)
>
>  Improvement on Multi-pack-index API.
>
>  Comments?
>  source: <cover.1748198489.git.me@ttaylorr.com>

I'm planning on sending out a new round of this tomorrow morning (CDT)
based on some of Patrick's feedback. That should hopefully be in good
enough shape to start merging down.

> * ps/midx-negative-packfile-cache (2025-05-20) 2 commits
>  - midx: stop repeatedly looking up nonexistent packfiles
>  - packfile: explain ordering of how we look up auxiliary pack files
>  (this branch is used by tb/prepare-midx-pack-cleanup.)
>
>  When a stale .midx file refers to .pack files that no longer exist,
>  we ended up checking for these non-existent files repeatedly, which
>  has been optimized by memoizing the non-existence.
>
>  Will merge to 'next'?
>  source: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>

Yeah, this one looks good to me.

> * tb/midx-avoid-cruft-packs (2025-04-15) 9 commits
>  - repack: exclude cruft pack(s) from the MIDX where possible
>  - pack-objects: introduce '--stdin-packs=follow'
>  - pack-objects: swap 'show_{object,commit}_pack_hint'
>  - pack-objects: fix typo in 'show_object_pack_hint()'
>  - pack-objects: perform name-hash traversal for unpacked objects
>  - pack-objects: declare 'rev_info' for '--stdin-packs' earlier
>  - pack-objects: factor out handling '--stdin-packs'
>  - pack-objects: limit scope in 'add_object_entry_from_pack()'
>  - pack-objects: use standard option incompatibility functions
>
>  "pack-objects" has been taught to avoid pointing into objects in
>  cruft packs from midx.
>
>  Expecting a (hopefully small and final) reroll?
>  cf.<CABPp-BEukTWwsuC7MMR8D5_UAhyw-LgT=DsPKAWeR_ZmVVhjzQ@mail.gmail.com>
>  source: <cover.1744757204.git.me@ttaylorr.com>

I have a couple of minor tweaks that have been sitting in my queue for
too long. I'll plan on sending those out tomorrow morning as well.

> * tb/pack-bitmap-lookup-tables (2025-04-17) 4 commits
>  - t/perf/lib-bitmap.sh: avoid test_perf during setup
>  - t/perf: avoid testing bitmaps without lookup table
>  - p5312: removed duplicate performance test script
>  - pack-bitmap: write lookup table extension by default
>
>  Enable lookup tables extension in pack bitmap (and midx bitmap) by
>  default.
>
>  Comments?
>  source: <cover.1744924321.git.me@ttaylorr.com>

Let's drop this one for now. There's enough left for this one that I
would rather focus on polishing the release now that we are on the eve
of -rc0.

> * ds/path-walk-2 (2025-05-16) 13 commits
>  - pack-objects: allow --shallow and --path-walk
>  - path-walk: add new 'edge_aggressive' option
>  - pack-objects: thread the path-based compression
>  - pack-objects: refactor path-walk delta phase
>  - scalar: enable path-walk during push via config
>  - pack-objects: enable --path-walk via config
>  - repack: add --path-walk option
>  - t5538: add tests to confirm deltas in shallow pushes
>  - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
>  - p5313: add performance tests for --path-walk
>  - pack-objects: update usage to match docs
>  - pack-objects: add --path-walk option
>  - pack-objects: extract should_attempt_deltas()
>
>  "git pack-objects" learns to find delta bases from blobs at the
>  same path, using the --path-walk API.
>
>  Comments?
>  source: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>

I expect that this one should be ready to go, but I'd like to give it a
read through with fresh(er) eyes tomorrow before declaring victory here.

Thanks,
Taylor
