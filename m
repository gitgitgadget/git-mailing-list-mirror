Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE16846D
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429936; cv=none; b=ahH6Uq59A4LcWGM/1VRwXHzoa7QR9FfI0bcBYk3T1hhM/1vnM+TjzUAIaFAjk7/fxVIOmEX9E9sRkXIPuOdZXQNuuKTZY9ijXGdMW3iaJK1judWDGfw41PlpaGhOUbe8hmViZVWkV5Tl1+9lyw+WAh++M66pg00QEnpT83jizf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429936; c=relaxed/simple;
	bh=SO2L/8rhieviiiRyx/DnHo0S8JDlOwHLc7iRJeh4ty8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JibEkGUavHKqm7rChniNLUTRKlp030iMegw88wS/NLJCWVCecKoAyP73F1KZyop7e+yj7SE1By8GMTNwwn79TY4eDt3dS2JyxPr9+q8GPD6mVvIvBuhm88W3GBtf6vjAhkulIczVQptT9OaqPBIuUD0aM4O+/ETFbM7N6B16fkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AOu1h7vv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AOu1h7vv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55500d08cso28763185a.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742429933; x=1743034733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxTuABOtEDCuEvk7F2ZO3KIEfjmOIEUJoRvS6JHaNZE=;
        b=AOu1h7vvsGPNMyHMaEBs6a7fAILAiZfKgpsZYYqb+1gYQzzfwt4cumfViq7nK4ojon
         g1V6qM/xO5OcCVyMIwgjQeeEtK2EUDk3O6jUOZOhv83438J4K46RNj2sQ1jeSxj6I9Tz
         XXB2h4etYT0GYB2THXpjTrBmzOMvFg0BRrv8gaLMcq0LrViqR8R3E7AGh6/zUF+a5Jg5
         Tox8DgGA+++Hr6nBop4DG/7s6XtxqToxOiW9EpMdqPuyKCEPWtr2n1mkcwv/isByoHNu
         YsqCvXA0bUjVtjzDGPs9J4TjbdPG1NMkUX9m2wb3MZEaREOWJ29g5Bv0zQgLJpF24EBr
         iwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429933; x=1743034733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxTuABOtEDCuEvk7F2ZO3KIEfjmOIEUJoRvS6JHaNZE=;
        b=nS9dTDqI9lzDbfmCFWVjpwus9vXTpmnHvOUD2cDXRRwJo06AZ2/eY7skQa93y9p+OF
         EFETru9dMCItBOZayqPY9AwzJdHe/AhOd4ylZsvJz+77vUGUR00jE79pj7KUd5rH0BTE
         CzToVgs3L2HE4ZPhIgrp6ATdfUQFD5kFGh5KHCxd/gS5x2bmoiiVDLCUrjRI+h/MJgqe
         4qGwNLdgE7TnIuUl+sres0sq8Afq5pbnQxJBD0je/1//bIvCcfWXK2bvProX1DVISWTU
         EqSx0gZrlz9SKCnNQf9lomMfU5CevLJ798W5FuOrC95Fqurts/bKQtqVoNFNCldjgRRB
         Bddg==
X-Gm-Message-State: AOJu0YzAeBXaJsZLIRvh+iEGMbGHqKe3BnGWAPK8fVJ4x2/7ZiFkV8e1
	FjMEKuC0HzzM+eVTZXDHVpTGdqP4jLi8u/WP8+ourD8hFDzHDa5f3wF9Qh0xG6g=
X-Gm-Gg: ASbGncsbhYlG8YLq4dh8U0eN6AHSN0MKo6gSYcIRldrlZBX8QLwen14uaXDX37YoEIX
	F+kY+SMClho/HxQxGqM47WAZ/oQHk5C55H/teZmShfG3MohJI90wrQg6KcCqC9B/iauFkCxRtB6
	ztRPEv4tdPOAg/DUlv7ablSqJpTYoHKqMDuYzDhsy3A75g2mYmBtP4U1Ta3trmppe/pa97i1K+f
	+x6dg5JKH1f/nzdDNl5NMsEDKSV/iFfZ8qhsdyQpJr1paeZmYhvrdyl664z1XnwrB3seAu5T+By
	nQkJiCPQlvLFjmoqSxqwvc6A8c6nP6s+kyd0ZxAJkzDaNVMXxFfF9dPndQm6kF5NJdBsIwrWO35
	KNujjo29DpW+A0cxJDL/Y44kF6XE=
X-Google-Smtp-Source: AGHT+IGOA/VH3rvfYl05R1VL6Pj/zSOqkii6NurNqQfi7GgLnmezX33EL6Ettv5ZAOmKrHg9MADtGg==
X-Received: by 2002:a05:620a:608c:b0:7c0:bb3f:e285 with SMTP id af79cd13be357-7c5a839699fmr669821885a.24.1742429933565;
        Wed, 19 Mar 2025 17:18:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c7d869sm918607185a.39.2025.03.19.17.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:18:53 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:18:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/13] midx: incremental multi-pack indexes, part two
Message-ID: <Z9te7BVGeU6VCo8Y@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <20250318022134.GD1473033@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318022134.GD1473033@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 10:21:34PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:12PM -0400, Taylor Blau wrote:
>
> > This is a new round of my series to implement bitmap support for
> > incremental multi-pack indexes (MIDXs). It has been rebased on current
> > 'master', which is 683c54c999 (Git 2.49, 2025-03-14) at the time of
> > writing.
>
> I read over this and didn't find anything objectionable (I left a few
> comments here and there). I think I've said this before with big
> bitmap/midx series: the biggest issue is that it's hard to know what you
> might have missed. Especially in terms of corner cases. So it all looks
> reasonable to me (including the overall design), but ultimately I think
> it's more fruitful to put it through the paces on real-looking data than
> it is to try to go over every inch of the midx code with a fine-tooth
> comb. And I'd guess the eventual fate here is for this code to get
> exercise on GitHub, which would help with that shaking out.

Thanks for reviewing it, and sorry that this series is so dense to begin
with.

I agree that the proof is really in the pudding here, and the best way
to confirm that we squashed everything is by putting real usage through
the new paths and seeing what shakes out.

I think the main thing that I was hoping for here were two things:

  1. That others thought the overall design and approach are sane, and
     that we're not painting ourselves into a corner.

  2. That we are unlikely to regress non-incremental bitmap usage.

> So mainly I tried to look for things that might hurt the non-incremental
> cases, and didn't see anything (modulo one or two questions about
> micro-optimizations, though I expect the answer there is "nothing big
> enough to measure"). So if this can progress towards the "shaking out"
> phase, and has the potential to hurt only people who turn on the new
> feature, that seems like a good path to me.

...and that's exactly what I got :-).

I'll send a small reroll shortly that addresses the comments from you
and Elijah (thanks, Elijah!) and I'll look forward to hearing what you
think of that round.

Thanks,
Taylor
