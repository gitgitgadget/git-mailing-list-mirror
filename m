Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88596BA3F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138158; cv=none; b=P4uVZJ/tKBWg7rTmDechp+2PinNNDjBbXPc0NaSIoe5Q3W3hIhui6ePvijV7AG0rLkouXKGNK54WgmJfnQYQI6o6FB393MArsm++hsho5a3L0ZAZaEnA59MdzZsU05Zhslc+LW7m8dICUi5E7VHfnVwM75JPaQCCaEchGx9fFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138158; c=relaxed/simple;
	bh=AkUCKNyCSzwtQ4+Zq7Gchy1LWFgleBfUP36ZNVvpgUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMjDkP68lisufXA1uOXP+8TOz6Y4udlFyXr6wJPMHdie7HZJ1Vdvc+sHutjWnrBrnDAlvx2xx/vrcUl6koCKfZl97EuoiHV0OXcKpGtTQUodJa6rIHtT8z39P3feauSvBUMXV3HPul6aGqdctLU/XDMiP+BH9d8LnGsh9glr1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gcbjvWR6; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gcbjvWR6"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72ce9790ab3so26121427b3.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760138155; x=1760742955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faVdqdCvuzwRUtOKW8yCPXcEBZaXCV3bQaUcjz7qwXw=;
        b=gcbjvWR68dzkPKhdfJiV93ELuabGFiG+lku4/OsuEaMRhV58x0oZj1mzyoY7+mJwQA
         MtIZe6rSbpae+OfHiaPzMCT8r1uwbcRiQ6ygj0QugpaZKGjTvE/LyLsifcNXjIexWyAn
         REEEC6zNVQcLD0De5hUqOGrNCgvkSdckcRjODjkgiWwpPWTXEDBsyuxJMsS+G3gm9cPD
         Ygxyh6LTRpmI4V9UtVt+gwareOngYOkcScm4uQ0GnreJJu57hzVTgu4QKZKhNiHGt/mf
         WuQT3nMRHISAcHdPlM4hOOm71UEcNptfAg2HjAu3JIs0o4tscnPfnuvWO21y3jMJuhQl
         naIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760138155; x=1760742955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faVdqdCvuzwRUtOKW8yCPXcEBZaXCV3bQaUcjz7qwXw=;
        b=j3JVpBBetc8KQVDhzjt3Qdi8E6RD+A7fKXWONjWZE245ioU+m13j021WRgToHjLmFS
         bgelbzhaOtIMUrc6Uv9ZanCrIF8m4rvqGfQD/MiViXQt4k8XLEWoaiXoG3uruPZz3+o1
         2CX9TAt4LFyWOPAJ6SQ6gmMmEA6fRR4y/SWQxiQW+p8gVD4f97t5G3mEsboXtItkV/by
         0pCrCXbtyUiK+cKB7ZD5x6M7BbiokG+FiEKVWqY0ELfLVthtDa230+gUriTXJaWD+v64
         6Cm2rfFwxiKWdIpN1p3QzdiDSlV4jn9FXwmR5rxdQ6gxFhm0M6jY+/+26r1je+Rk1EGc
         3Ijg==
X-Gm-Message-State: AOJu0YxxaWPVT3+ZaiahztrAPSE6h5P/78HG9qTkHxJmL4cJkRSi6asg
	xHU9JAGGLklunJxoYPp+/3Pp7axF+Kt/D7nc7glB1cPHnaSK43rveSb+B+yJwyhvfB0=
X-Gm-Gg: ASbGncsabpLPi9J6YN/9LncqY5z0OwBWQKp/xyvs8ChEUfXr6dsWLsPi96vLK+VYM6q
	SmAHACPu11U16MUR7AEeQqNkHsvo6ABMZBNBvuUb3t85OvcgvJMG1nz1ibJA2v4DUZwTiDlYY1k
	VPl6jkfYvtExEr/0Bga0EiYv/S8C9YLv4CsKCNQGr0fev66pZSlT5IHFLjSR9IPAqxDlcwdGZ2f
	qmdZNCf15bh63nkJNcqkiyPQnVBr7X7U5B6H6IBax+jKQ6mv4TMxY8uY0ARsWUJX7qo44PmczZe
	QFuG47kDdv8I+XHgFV/Yuk2S2frTJ7N+jkVyyu+YfssEvY9RXtyR7h+Ad9Om/DdCExFTlaijtmn
	BQgz8VwozQUlQbEb+lc8llcMXHBKVOkVgE0LxRRiJgWSudWZ6cVfzp5vDjgKZdltsli8wt06pgw
	IHjt+1dcCGg7/90ExZkO5iNi7mMixSVS0OqEssbfKsqdun
X-Google-Smtp-Source: AGHT+IE1l2qHjhEKmRADTOi6Sffd9ZDWdJJe+bxHNB2IY4RDTyXR1ub76QWmBBGMMy/l14v/ENPICA==
X-Received: by 2002:a05:690c:930f:10b0:781:64f:2b2c with SMTP id 00721157ae682-781064f34d8mr48634477b3.62.1760138155375;
        Fri, 10 Oct 2025 16:15:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7810727a16fsm8991937b3.53.2025.10.10.16.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 16:15:55 -0700 (PDT)
Date: Fri, 10 Oct 2025 19:15:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <aOmTqt4m/R/YrOGg@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <20251010062913.GJ1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010062913.GJ1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 02:29:13AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:07:10PM -0400, Taylor Blau wrote:
>
> > This series moves the vast majority of the builtin's functionality into
> > several new compilation units, all grouped under a new repack.h API:
> >
> >  * repack.c
> >  * repack-cruft.c
> >  * repack-filtered.c
> >  * repack-geometry.c
> >  * repack-midx.c
> >  * repack-promisor.c
>
> I've read up through patch 37. My eyes were starting to glaze over at
> that point, and it looked like the patches were starting to get more
> interesting, so I've saved the rest for another session.

Thanks for the review thus far!

> From what I read, the changes all look reasonable. I brought up a few
> small naming and interface questions, but I don't think there's anything
> incorrect here. And there may be diminishing returns in polishing an API
> which is realistically only going to be called from one place.
>
> The split you have seems reasonable. It's not quite as clean as one
> might hope (e.g., repack's existing_packs gets passed around to some of
> the other subsystems). But again, diminishing returns on trying to
> untangle it further.

Yeah, I think we could probably go on for quite a bit longer polishing
the naming, interfaces, etc. I tried to strike a balance in this series
to change as little as possible while still ending up with a
halfway-decent looking repack.h ;-).

As you noted, the repack code is extremely fragile/brittle. That is a
big part of why I both (a) took such an incremental approach as in this
series and (b) tried to avoid making too many changes as I moved code
around.

I think that (b) especially leaves us with an opportunity to clean these
interfaces up after this series has landed, and I intend on doing so. My
hope is that this series gives us a solid foundation to make those
changes on, as opposed to further hacking up builtin/repack.c ;-).

Thanks,
Taylor
