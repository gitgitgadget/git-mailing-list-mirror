Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277E3595C
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256668; cv=none; b=Eo1g1wIZJdcWV2tmcZPlOrjJm7Ytav6NX286uTaRBDlqF3ovKGUr45RVsccx8dsaYaUEHHDTHle/FQgQZOR0R2rWMWVd0BpH/BKGMFF0YVytCYn35swe5l8jfVQNin9cFwXKOnej6HWsIZC7m44q4cpjPtYm5SoabE3rJSwP+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256668; c=relaxed/simple;
	bh=W9yBfAbW9m1Spin90fu/AyZJGiWnRCZKZogQCISlLUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+E8leT7QgWqo82AHwDR1Jd/n+O0Fs1n+iApQD78tsTWf1p32WObpKNpUyABqpTXlBzoFYOJOezpdFMVqvJOINSOtOo8f7sEcE//PeKXBPCk/ObL9Qox76aZyak5H98qmF+4uhjsXxHej6H2PdWcEkdxyGAk0k+wXyX/r7Xu5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Yxbc7hGY; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Yxbc7hGY"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88432e29adcso159245939f.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756256666; x=1756861466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmL4rXgvwo2JevC2tLNux38KqvdnlnoxbdVHVj+5+oE=;
        b=Yxbc7hGY9Ms8OtiSiQtakYJYXCr3miozdUPYxOUMVc6nrYjp8qfoHuPFTTZxRBiAU2
         k9c9kYrvmNyIPlHlSWAWt5pcbq4A+f543LgROTyxam4LQ0GYMm/mHvXY4ab0r4z9+N5u
         kYMC/D2/ls0xNilUI8AYQzHQu9fQnPY3yTXutjMOvxE6W+zSBjJ42ex5KLl0Kp+2YLEk
         91xx0/ZkPq5JUsmM6x6Sm5LgWB+XVRfcsknvnmp+Kmoa2kJ89OWD3fZ/S9zS8APUGE9w
         FNTLogwrtVCinsNIXGav50mny8YPOqpXS1So/fK2kl1GVCo/aywI03tLVF2dpWcxHHz6
         okNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256666; x=1756861466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmL4rXgvwo2JevC2tLNux38KqvdnlnoxbdVHVj+5+oE=;
        b=Ny8TXpCwWSR1tSEY6NEfgoiHnSfWvBziChB4bp4SEAI6euT4GR4Hguv3uxJ9A6cUGS
         6T9c5xKOzGOWLrbgIOD8es8V0aFf9ych1NqUq1wHzXQQp/1/OKwp+AZvfJFszo05Igt+
         OKaCtlmZucudF/nRmzOFgFTh6WEPJNHR2PpuetuGZhNf4v4FZmCHQifdtKgPL4YwSw4z
         jnfL0vErRPlitfq0J6ouGWoK1gBUHyw9WtHxuUJ32DgeSC55CBrHktVKNj7JHj2dMISP
         pZETED7MVuBlqLjJzmd9oCcMhGYBVNeZdu+S5BbNcjKRlcroWTStAsbl+HcKXG82+KQZ
         mZsw==
X-Gm-Message-State: AOJu0YzobIVmeqmPnUIOWlUURmrklktn+NnZIsk+wKcYx5zoRGXdLdx0
	E6/LEJLzrpBWN1bDPB2YABsEIRkyYXQveQdX4Noc2Y5z9TO5Wq958TNHz3ewXL/hIII=
X-Gm-Gg: ASbGncvoeCzqGhGtu3QbvhXraTGe0Ea+JDLmnSke+Ey5k8rgOvuvtDpIjiUvUjviowL
	Joswz0A2ZGdP3no8CtICqkhdWZYwv2z6RV+KebsFl5SHr2VoFkY0I3KJbg5rB5QVrtx+/p9EbMi
	ulipLXKbCTRnJ0I5gEjJDi0U9mtOkMyNwAOtcC0MymTBA5hvQGdJpPDo25iq8sf1CWtZDzEI3dx
	fOqWaCsVyEGWVepyS6pQ2e9euA+3IPSOrGJTtbu1Etp7bV8aZ3pF9zezOa5vYTP50T/a+eG6UB1
	WtUZKoCDw970OKUcQqmxe5gAtJGXRovscVU72vCZ9XF3/ZzpcYosCzR33b86cPnKLUqenaDwOwu
	j1vGe7NUVw4SMvXcyd/CcFZV8Jfc2LTdD1lYuaVbnW/xJQFOekycoQGb1mOvLE5D28gtnl/uFxH
	ikDBFg1JfXMAvlokdAK7ZNXwr9Tg==
X-Google-Smtp-Source: AGHT+IHHrNxI8Z6qUXus9Tnn4BP5r7rikJEdzMbFPYl6PcUV0OCbPWOwQh0b1FAFy1tS+DlEBHklzQ==
X-Received: by 2002:a05:6e02:3e02:b0:3ec:2275:244c with SMTP id e9e14a558f8ab-3ec22752632mr144519085ab.0.1756256665761;
        Tue, 26 Aug 2025 18:04:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3eadc1e5c84sm65596315ab.50.2025.08.26.18.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:04:25 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:04:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 11/16] packfile: always add packfiles to MRU when
 adding a pack
Message-ID: <aK5ZmNxE4zhNt7Zg@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-11-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-11-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:09AM +0200, Patrick Steinhardt wrote:
> When adding a packfile to it store we add it both to the list and map of
> packfiles, but we don't append it to the most-recently-used list of
> packs. We do know to add the packfile to the MRU list as soon as we
> access any of its objects, but in between we're being inconistent. It
> doesn't help that there are some subsystems that _do_ add the packfile
> to the MRU after having added it, which only adds to the confusion.
>
> Refactor the code so that we unconditionally add packfiles to the MRU
> when adding them to a packfile store.

I am a little confused why prepare_midx_pack() wants to add packs to the
MRU cache so eagerly, and the commit which introduced that behavior
(commit af96fe3392 (midx: add packs to packed_git linked list,
2019-04-29)) doesn't focus on that area in detail.

(Note that commit af96fe3392 *does* discuss a separate cache's behavior
regarding the open file descriptor limit, but that LRU cache is a
different one than the MRU cache we're discussing here.)

What I do wonder about is why af96fe3392 adds packs to the MRU cache in
the first place. As far as I can tell, we never move MIDX'd packs to
the front of the MRU cache at all. There are two spots that call
list_move() on the MRU cache, which are:

 - packfile.c::find_pack_entry(), which enumerates MIDX'd
   packs in a separate loop earlier on in the function, and ignores
   packs in the MRU cache whose p->multi_pack_index bit is set.

 - builtin/pack-objects.c::want_object_in_pack_mtime(), which also
   enumerates MIDX'd packs in a separate loop, though it does not
   explicitly ignore packs in the MRU cache with the multi_pack_index
   bit set.

In practice, though, I think these two are equivalent, since
want_object_in_pack_mtime() will return before it gets to the MRU cache
if it found the object in a MIDX'd pack.

So I don't think we need to be adding MIDX'd packs to the MRU cache in
the first place.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  midx.c     | 4 +---
>  packfile.c | 1 +
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 95e74c79c1..3cfe7884ad 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -476,10 +476,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  					struct packed_git, packmap_ent);
>  	if (!p) {
>  		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
> -		if (p) {
> +		if (p)
>  			packfile_store_add_pack(r->objects->packfiles, p);
> -			list_add_tail(&p->mru, &r->objects->packfiles->mru);
> -		}

All of that aside, this portion of the diff is preserving the existing
behavior, since it inlines the list_add_tail() call within
packfile_store_add_pack(). OK.

> diff --git a/packfile.c b/packfile.c
> index c885046d9f..a79d0fc1fa 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -790,6 +790,7 @@ void packfile_store_add_pack(struct packfile_store *store,
>
>  	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
>  	hashmap_add(&store->map, &pack->packmap_ent);
> +	list_add_tail(&pack->mru, &store->mru);

But this spot makes me a little unsure. There are callers of what is now
packfile_store_add_pack() that *don't* immediately add the pack to the
MRU cache (e.g., packfile.c::prepare_pack()). I think that behavior is
intentional, since we don't necessarily want to have packs in the MRU
cache which haven't actually received an object lookup yet.

So I am not sure I understand the full extent of this change. I think it
might be worth investigating the eagerness of prepare_midx_pack() to add
packs to the MRU cache, and perhaps drop that behavior altogether, which
I think would obviate the need for this patch in the series.

Thanks,
Taylor
