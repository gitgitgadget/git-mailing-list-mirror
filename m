Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01E18A93F
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785008143; cv=pass; b=hlODzCdyGr/E2CSmaRbTjC+N2cw0QXT/EJgadwY76rdJGa/hzmlKytUXJzeEPi6RodJrCoiZczJUHmKxk5uODhOCi8/I7TVTruQpgoUPEFmwGnpAbwEuzI1aovbhaT5TI41hQz7ptnmBs3hDdnpG/DLa3jTfn1rEI8AHFrUGxVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785008143; c=relaxed/simple;
	bh=EJw7JhDHQvASsAInHY1vMlHgVL1lAxS4aWTUaouMnSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJYlF0ng7sAb1GFISwhHlvSMcMlusdT3VuNPKL7erPuEN3V69UftbloznYp+EaozkXVNLUNXbBvXXMiSJ444zNGJ5EJ/NEoYmSP0QX7sVGNp11GQ4JHaxpcGtGxOUXl1zFe768AQRjCJwxqSSIaYknTWqmcDasI/VOHfXv78pu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUdjx0Px; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUdjx0Px"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1301874a91.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 12:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785008142; cv=none;
        d=google.com; s=arc-20260327;
        b=LFol0o7Rlwk1wcCrwt9vcloZ7HY6Qa4enegoFPVgVvk8/mRzkRGsvhbYaPdi94iMSS
         s+I16ZVP/j3OzSBeAQbYKfHFQG1wMu8d9dUSC4Ma7CljKZ//2o1Km1oHnPxz+VLQx/Rl
         bTF9uG0TSm/jeGd0kJZNgsqMXedNntV6TWcZc/s1dF91SHHXr27I8MhP1S5aUkyHqoY2
         dkctrtQN6yOXJkezTVK9KIRb3dLTirzsWHrmQ0R2vajt+0nYcXm161h/gryqrlDS6VeH
         TRdeTuk0ENzLGpHs31gUsIKRa0o1D+dVvxckmMJ73AKkgwkaWykg1GXAt4TDMbh1X6qq
         wRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gkq2jRHk8vRB0n/bZrC693fYAzDfhcEbFI1+SrKjxLM=;
        fh=rxXce4A1BYmBKDcyAP6CTTeBLAKxymZR1D9vVH84xcg=;
        b=QttmhVGxJLxsJa6cXQFB2e/QR3zBsb0CPpFcHIUgPeGEkkTh/oTj2vDHuvNa3Y/6bI
         qY1/HKXs5oHPfdZMETKxa8CxFwK4kaHFJM4rSdgpc+cnJB5+HhLKQg6P8l4bIBAV7HZs
         829nuKU4+5ZfG6FdNVPTGBfUOT8Q4yPo5j0SJp2rB6xu/Rr4evBpWjikNKh/a2r7qBC9
         E/As9JSYqRjUP5sN3YtiNZZDHD+q42nrVFF6iJEEF2MIqgj+axoNdOj4dEIk4RDiLD4w
         7i0sUfAvGcmM7GY947Z4CEXNFNrOSk/fj2vg0NgNnVzRIsnOBG9/s8bbbnadLG3R/m7S
         drMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785008142; x=1785612942; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gkq2jRHk8vRB0n/bZrC693fYAzDfhcEbFI1+SrKjxLM=;
        b=dUdjx0PxDPzWl59qSahrjyE+nPo/48TYqm3arnZ9VkTvpFWXNCVtVS4TY6L1VY6bb5
         AB05iiQB/NDA6K6oMA2XjLQiE5ibyVGAf+4jV0VgXtLhR7hRAcdCpL898u37z4rcxL0j
         71KXBTtA96U9N4DxbcuvwFd+41tXpWVYXxJQD+erv05fYGCwojveiQdibmav5eVuA/uS
         Dg6RAGxqXAWt4QE1SC9JZi7hzQcvwCpSNM0K4ipEIF7GVxWe++be/yVQdF2dHOr/ijOp
         rSx0w05d6ADpNjXbUMrIvZN6iHeRibYVAnZZG3KU2jasOFTVu/mbg9q//tiIvs4ONWg1
         PjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785008142; x=1785612942;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gkq2jRHk8vRB0n/bZrC693fYAzDfhcEbFI1+SrKjxLM=;
        b=sRIBXJxiesy1426CJ7nG9+FKuPC6er0aSUOHfdcZInSXuw4HPKoUV2qQuVF12hqKfF
         zj/0eZVmlJcZLDcP495VQEUTa40oTlGTTpduJ/UXidi8a2hThF1J7PJmNjBT7QoiVOEu
         e0ic5GcClFr9/x/b56ZhI2LNrhW4De9NkBFZzgLK+oCSeSkFw7RZ9RZiSnDmkax0MNfL
         uFIubRAqUzWaOP+noLsXEDqvlZC62v/j2Ai4Ta4qENbu9oiLWLUlNCs6aDxUu+SmS/wh
         gHiCpERbtStoocs5H0kyq3RZ2BmhaZLW1U0S8mmuO9poxkMjMDxn1/Tw0cxxZrPuHN01
         I9xw==
X-Gm-Message-State: AOJu0Yysq02GY4T3zTv6YaMMhDzftvo8t/p2U1v5lq0Jl3DZIOr0nDk/
	WHDck8Iz54vCEHUfJ6yvrlrneQJJHLgjHFA8mJyJEXo3soGKpLIyWZZjR1OgL+sKO7WRrxqp1SJ
	GI3RGn+TtnWA4USNDs1CVas5ZPLOPq8w=
X-Gm-Gg: AR+sD134a9XKnRSDxfu4+wcCfkzhQGNezQ6KVfa4jgN8Iw5jaSJnFE17EJd2VDPT5MH
	ire8l5W4+o4KyS+BvF1fI8tRkVXI4dCDwWaSGX2u6pTMVzy5MizqNs9IEMiykgrgm+wpGxr3OB5
	sYMgNWO00J+e7CAx4CFSNCX+BTWTp8mbT5vKq6+lFinoJsp+L7wSf16bjAJTfe9fRbyuYKyJlP+
	dZjnxgMpDnOW1zfBPVYF0CsjVgy/zq+jT7+AWNWlJ2HH8JN4N8NxHQblrSF1yUwv3JWBTh2Fblb
	ygdO/NQ10yFGp3alJQ7KGEElWnysTqvtqeG9ZzVqnB5yFnzeXEXR0UVcRpsIoNuCVugsISVhO6T
	lrKweo5SR6hP8xonc
X-Received: by 2002:a05:6a21:7314:b0:3bf:9b3d:61bb with SMTP id
 adf61e73a8af0-3c67d9d3a12mr3021284637.16.1785008141564; Sat, 25 Jul 2026
 12:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-8-r.siddharth.shrimali@gmail.com> <e8d63121-fedc-49da-ad1a-0cbcf1a35a0b@gmail.com>
In-Reply-To: <e8d63121-fedc-49da-ad1a-0cbcf1a35a0b@gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 26 Jul 2026 01:05:05 +0530
X-Gm-Features: AUfX_mzYfn9FAKErOxTHPg9Bwb-7VY6PThHhrDTRuQT6mfxYwASzFBjRxNRFQGU
Message-ID: <CAGWgyh8qYJzSX-SVNiQLVp8zuDHPpjXukEngY1_0WbF8NtyYdw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] repack-promisor: record dropped objects in a drop log
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	me@ttaylorr.com, ps@pks.im, johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jul 2026 at 01:11, Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
> Recording all promisor remotes for now looks OK to me with that
> NEEDSWORK. I would not block this on remote-object-info.
>
>
> > +      * is currently no way to determine that locally. it would require
> > +      * asking the remote whether it has the object. A "remote-object-info"
> > +      * command is being added to the "git cat-file --batch" protocol for
> > +      * this kind of query. Once it is merged in the codebase, this should
> > +      * record the exact promisor remote that has each dropped object.
> > +      */
> > +     for (pr = repo_promisor_remote_find(repo, NULL); pr; pr = pr->next) {
> > +             if (remotes.len)
> > +                     strbuf_addch(&remotes, ',');
> > +             strbuf_addstr(&remotes, pr->name);
> > +     }
> > +
> > +     path = repo_git_path(repo, "objects/info/promisor-dropped");
>
>
> If we keep it, it would be nice to document this path (for example in
> gitrepository-layout) and to have a small test that a real drop appends
> a line.

sounds good, when the log is finalized, whether as a min.  version now
or alongside the
error-path change later, I can document objects/info/promisor-dropped in
gitrepository-layout then

Thanks,
Siddharth Shrimali
