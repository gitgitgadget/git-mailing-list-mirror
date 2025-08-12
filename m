Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA727FB15
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009711; cv=none; b=sxBb2OOwy5zYJQsD/890vHXQ/ksdqb6PPxfkrmmln/QWWgUyJZUMEz3jfmSXVR+1KzXPtywxKr55lqqCg8NkrKCu0juUwBIqsmWJ7pLPdNxJXO3Rt8YPYQD1769LdD0Yf+Cxl1LVuxG/660oJZGzAOKBekawVUd0ohzuHSs/+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009711; c=relaxed/simple;
	bh=3NBVnX1bG81+kOwxGGY2rJtYddFeVzT/ep00t8yqAv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwvmeSKjC1N57J3hIAC534dCGi4EX2VbafGzNJwn9emA7k3kqGi/tZMThCb34rlJ9xEupaAYKcPwC/11mvyftmIDQrDbIe/w+hXCjKuaicJMzmhgbPm1xl0myDnJVjGdxxeJRP7ruMHdZNiRj5dI7twzFRkIn508nNdz9cl5hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FyN9yFTx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FyN9yFTx"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88182bb2336so152684739f.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1755009708; x=1755614508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDef9phjX29dWB3ega6u8FCbDC14EAm8PpFcTx7BAGM=;
        b=FyN9yFTxi8tWcey1ArpDXaEF56W0pxDRgyeLGwOVB8pN69XG14RGlqkEqzGR9tdiSt
         ix92I9DSz5aqbLWSBacQkE70hWBhMPEEfnv8A4C+a4RTsM2FaY/gcx6QnWQ6zH3JO1ja
         qGvLwA2Dsk3468rRT4JHJOsSZgRWSQ8TsPI13JylDM3WlmGfEvl9whqkSQAJwBAqexS3
         ASELuDGHxd7N1GXg/uVWoc6CHs3CwLVMgfkRTvBlKRYRZRQN3uAFoEgDAvIXgr1W47+W
         Wez62huArT9ypYLGHb11SsXJ9Tzu0hL9HfuwaG4psZH013PSD75XUzKDISEmV4YTu9BK
         TAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009708; x=1755614508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDef9phjX29dWB3ega6u8FCbDC14EAm8PpFcTx7BAGM=;
        b=Le5jf2AUF20bnf/Uxvlm1mP+P3kfuKpdwxJcvSsa09aupduHqIMt48l/hMza3dR2vk
         oboBih/PnB8YTtjtnPVaX9BjR6oP1lPRHHJ3Y4jMV45MnGZ+ZmFwm8ZpY+Cw1bQIlLOX
         59k9t/mWQ80EI1t9xzAEDFMZRjOBO7OJdOwrxGWDsq/FRwVHa8mf0zeMcT96Wwl7mHzQ
         bxR8FEVgeGiE0+H4ZCwfxWL/+SGV+V7z+A/6pbMzzjcxOb72RS6cRhu1bFAVjY8H1fiz
         wcFa1EizfBm7ire49KR+jrV1PITDRnMgIiuz5I3ZRJJjFplgFld+916tX003gAnjzmLP
         v/zg==
X-Forwarded-Encrypted: i=1; AJvYcCV5233XStRlBF3UTfRzbN9fRvIf4ZspXbqBV8HJL1BZk4x5Fzcfo8MfzsdlOm/aMLJodxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfCSJtJ+r7bicGhDJBaV964zVmlrS/x+pzauzs8IDWUhW52Vm
	vEiaHe0glKxDYxKppxBNH6a2eN19vfDLPOkRP+TZ97VItTRXO2VwkSLyT6NbV6Tpqbg=
X-Gm-Gg: ASbGnct21/g46aWSJoGTkTEVGcvRM24DcHT+hC+sHribTaH6aHJNMRr2Cl9SGifQXHR
	8nHKsFlzyQf718sgDvuRlo03esvhTDxunfFDNyT+P1bJbmxD3XfBmKUSZBaM/F5GPPiEpH5BISd
	Y0ZlksqEHd2dj1sHcDAB6D2d8rumgX/9NflHbEJ6X8VFPdUwtTwC8OPBCi0+e7PlBZmidza6DlB
	pwfEsQGZEOfsrxNcbwBCQm+I9Lf9OO8TDjbqQllSqqq+Z4W626YLN5M4SbIJdqsfuhS0R6Aptb6
	hQNff4o23OJrf8Te1bhqokiF75tMmPScVDktofChAxzY9Fgzaly6q89my4+rTjYz4LDGaFOuQMF
	Ys9HibtuZ6L/aMexL+T1DvBrSWEBPL3QLwNw5n0yhTenpqkRTpc42TozzKTyKAOnl9Om6XlX9VB
	vqFbxT
X-Google-Smtp-Source: AGHT+IG3inlQgVXdxV25lhyXhvyV4GrfplEAyC0YhfvkyZZkAe6zUzuO3J6kspbS4TXI9rln1tEH0A==
X-Received: by 2002:a05:6e02:12e2:b0:3e5:408b:b748 with SMTP id e9e14a558f8ab-3e5659772d6mr538895ab.16.1755009708377;
        Tue, 12 Aug 2025 07:41:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ae9cbb664sm3108224173.94.2025.08.12.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:41:47 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:41:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #05; Mon, 11)
Message-ID: <aJtSqgJ7w02Ox74w@nand.local>
References: <xmqqwm79x7ra.fsf@gitster.g>
 <aJs5Gee3ZVCJX8dk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJs5Gee3ZVCJX8dk@pks.im>

On Tue, Aug 12, 2025 at 02:52:41PM +0200, Patrick Steinhardt wrote:
> > * ps/commit-graph-wo-globals (2025-08-07) 10 commits
> >  - commit-graph: stop passing in redundant repository
> >  - commit-graph: stop using `the_repository`
> >  - commit-graph: stop using `the_hash_algo`
> >  - commit-graph: refactor `parse_commit_graph()` to take a repository
> >  - commit-graph: store the hash algorithm instead of its length
> >  - commit-graph: stop using `the_hash_algo` via macros
> >  - commit-graph: fix sign comparison warnings
> >  - commit-graph: fix type for some write options
> >  - commit-graph: stop using signed integers to count Bloom filters
> >  - trace2: introduce function to trace unsigned integers
> >
> >  Remove dependency on the_repository and other globals from the
> >  commit-graph code, and other changes unrelated to de-globaling.
> >
> >  Will merge to 'next'?
> >  source: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
>
> I don't intend to reroll this series for now. As long as you are happy
> with the signedness-related patches I think this should be ready.

I am still not sold on the first four of these patches, and I share
Junio's concern[1] that the "int -> unsigned int" changes are not well
justified.

As a practical concern, the "max_commits" and "size_mult" values should
never come even close to INT_MAX, so I am not sure that the wider range
is giving us all that much. I am a little more convinced by the Bloom
filter changes, but since they are purely for debugging and also
exceedingly unlikely to exceed the signed INT_MAX, I do not think they
are absolutely necessary.

That said, I don't feel strongly enough about the lack of justification
here to hold up this series[^2], so I am fine with it moving forward if
both you and Junio are happy with it as-is. But I am left wanting a
stronger justification for the first half of the changes.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqpld6kb4t.fsf@gitster.g

[^2]: I don't want to waste the list's time debating a signed-ness
conversion when we have much bigger fish to fry, but I also do not want
to deviate too far from our usual standards, either.
