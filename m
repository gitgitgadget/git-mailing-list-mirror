Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A4224AF0
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746804422; cv=none; b=kfpHR1d2y0NsdvSEvHhZEJeKXdD1fz/z5Nxj7HNMtsvGwL1rCsE3tx4OIpa8tJ5M8UyOtc1KF6CKtz5V+das7VQ1JnxAQ+jX5NCAjfsew1jBrLfvzkq9/mYtd+aBJqLESqJq9bFquvo66REhvoGXcPf4GyCDoxiYW14WtkY9ggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746804422; c=relaxed/simple;
	bh=hOttSo4p8+EPQUGqJ1SmUb0nQjr1GLZT62Ong9/m2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTpfSkXxe9/aeH/xSmLpRTR4ZhfJOeTjUMwncBSw6Ec8Kpud6XoOXby3xJAF7OBH0XXbIPMssZWkS7lVcXB9qZl3j27AwQo+YKiI97bUwdMVPwMRqBAIG/eoAZ51rw3ZKdy/wExXkxFlTYMHOcETtSmMKeb3VcPnKZ8R2v30AHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGMeFA/6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGMeFA/6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b200047a6a5so1565143a12.0
        for <git@vger.kernel.org>; Fri, 09 May 2025 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746804420; x=1747409220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+HgYuXpN6bVDgAE3qAa1Xyk7V3c21W7oKOmsHvxdhM=;
        b=cGMeFA/614B9RrOYHy2qYyP6rP/VMDUjyfVgZsR09JVux/Gbb1rhvyHqqBhibWCOtK
         6cRk9b2smPi7WgCIoP2VLIjoTl+i5HfBh3A1ccS1r/SK6NIwJy+kAM/dQNV5aournQ4s
         rE18LpozcRek6H1Dy641RtGAOm2woKH+rB/DzqrLGIEgHm0YvxguHfJMVAqSE5vjEdGw
         NDa2hVBE0ZAqkySFKGRHyJGI6iBYdraZ8VWvIovwrOkDCyYNpCNPHjQFCMmctzQnhkg7
         4MbUXptPEXaUQIhnjZncJ+wDR0nQNDUAy9fpPyzDJNikcqlNgn+/pWKkSLJT+DAe0iHJ
         Gc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746804420; x=1747409220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+HgYuXpN6bVDgAE3qAa1Xyk7V3c21W7oKOmsHvxdhM=;
        b=WvLgUdNCRnqQhXRsznvRjQNAp6WppqF0y7wnTaXgTPCGuowzh/NC/L/n/8GFmg6DGZ
         HX32107yv4HuKEV6PvqAbBLj9vJUoyig/wIBVVvVQXA3T+nRaynoT7O8y4tuyKbsSBBV
         3lTzldXmrzg+T351XqZMezNpzzACkvd6iCjz82o2lfZlRWHh5hiAQkHrF3CbKSedtkPK
         DdfMw1pdaUCoC5nXJRG7UOoqMRVAhaO6cl+tgAA7+vlkBrPgTBUJMiihg6ub3lQuCgRi
         6HYfHSWD7mAyUHQAgEjOlj5viKnpuFFzwRBmHiB4RAbSXk+3DgAbX/+GzV919QkQb+3Z
         gLrA==
X-Forwarded-Encrypted: i=1; AJvYcCV4N/Ti8FLasdbdOsR1mTflEip7HQVaceFVFqFcg9K+kB6g6zMKaov76mTT0EL55BZ/dkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0XbjmKJac0PCSwSGyJWWvsnCFYNxwuNUKDknXmwsKO05WBaN
	aGKe+QB8FKhm672q5HZXhBaTn3DU7n8cWQkoKbnSeqz2W7ZtSw1/hDs+u3Xa
X-Gm-Gg: ASbGncvxOyNSO6q9kgJKYBT309FzgRl3BrA7+CCMv09tiLtVTT+9SI/sjeuu54M/ZT0
	Ib7Lhvp1XEu1dwr27+bBevE2FlKEdisHjP3qhOsGD+hPxpMXWHB1mPRydG0k8RUJA5jVE0j8B/X
	z4xN/IK1wLM2sdL9X+H/v3G2oIdIA+134BwbjNjfXM3tQSAsrmHwPmYR5GvXJI+G1laefoGo4fm
	7uQ3+4yUITnokY3vWfKD3cgFtuDEqEstn32U34C00a43+/EicIaWHkuYsVrAXikUdrt00OTwkDz
	meEduJTSFniJIkRbkucwYYLoT9DMa6q/hk7T
X-Google-Smtp-Source: AGHT+IFrwsajQORDI4MTmpXVqR7eHTW7ZJQTboppnpw7Y0yRzBr0D/z3T6z6wt1tXykJPMBScB8cTg==
X-Received: by 2002:a17:902:cccc:b0:223:4d5e:7592 with SMTP id d9443c01a7336-22e847b0172mr117447605ad.21.1746804420073;
        Fri, 09 May 2025 08:27:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7741e76sm18635485ad.98.2025.05.09.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:26:59 -0700 (PDT)
Date: Fri, 9 May 2025 23:26:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/4] align the behavior when opening "packed-refs"
Message-ID: <aB4ewBsxnq0Yv3Fd@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBtzn4nwLsI9p5Cp@ArchLinux>
 <xmqqv7qc9grt.fsf@gitster.g>
 <20250508200802.GC18229@coredump.intra.peff.net>
 <xmqqzffm4zx5.fsf@gitster.g>
 <20250508203350.GG18229@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508203350.GG18229@coredump.intra.peff.net>

On Thu, May 08, 2025 at 04:33:50PM -0400, Jeff King wrote:
> On Thu, May 08, 2025 at 01:20:54PM -0700, Junio C Hamano wrote:
> 
> > > I left a few comments that I think bear addressing (or at least some
> > > discussion).
> > 
> > I found both of your points very good ones, especially the "why are
> > we making an in-core copy anyway later?"
> > 
> > Which may probably mean that munmap_temporary_snapshot() is not the
> > helper function we want in the code path, so one of the preliminary
> > refactoring patches can be removed.
> 
> Yep.
> 

Right, I will remove this patch in the next version.

> > Even on mmap-incapable platforms, we have enough emulation in
> > git_mmap() and git_munmap(), and this code path that wants to read a
> > packed-refs file just mmap(), do its thing, and then munmap(),
> > without worrying anything about "ah, temporary, so we need to make
> > an in-core copy for ourselves".
> 
> Hmm, yeah. I had thought that somebody could explicitly set
> mmap_strategy themselves via config, in which case we'd want to avoid
> calling git_mmap() on systems where it actually does mmap. But it
> doesn't look like we have any mechanism for setting the config. So
> MMAP_NONE happens only when NO_MMAP is set.
> 
>   I briefly wondered if the existing code could be simplified to get rid
>   of MMAP_NONE, since it could also rely on git_mmap() to make an
>   in-memory copy. But it gets weird with MMAP_PREVENTS_DELETE and
>   NO_MMAP combined, since then we make a pointless extra copy (one to
>   fake-mmap, and one into the new buffer). OTOH, I'd expect those to be
>   mutually exclusive.
> 
>   I kind of wonder with MMAP_TEMPORARY why we bother mapping at all and
>   not just reading into a buffer. Maybe it's more efficient?
> 

I am also confused about this. If we eventually would allocate a buffer,
it is wired that we map in the first place.

>   Probably not worth revisiting all of this old code, though. And
>   anyway, because of the SMALL_FILE_SIZE check, we couldn't even
>   simplify away the read_in_full() code.
> 

Right, I will try to clean the code later. At now, I think we need to
concentrate on using `mmap`. I will add this into my TODOs. Thanks for
the suggestion.

> -Peff

Thanks,
Jialuo
