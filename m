Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8E54919
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007230; cv=none; b=bU53TGKLpT+XcaiiRmwz6z3fXX/n1tmJqFF+xrp+eBNfHEb0JYLs3QYgciKSxuF7S4yEhX3sNV3qILRJpKA6sZc3hvwqkAlXlZqtI1YS/MT1Ybiqypl1z3WDl7SLn/z8Bn3M1fE8p0jHpjGPY1wdfQ4SuIsji8OsRtho90IUN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007230; c=relaxed/simple;
	bh=IOpgd1/MIaHBA94mbdf/bPas+E1GmGePXYIAzmBoE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr//3r5U0psoOEXBrjLfMm4PUEZsWAaMteHlDj8QHnQg/u1pnQ4CDdPVBjdHdAWgZlnHp+AjQLWPr9yqNUgduxMOJCtgLGyfCV1HqXFdI8eWMhXTxeD2IIoZigLdsoFPQO6cHgNFSXf+iltYSaoiMMvLvvpmHZyS9/4PsUXUPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ArIEZqv9; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ArIEZqv9"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-615038fc5baso7847667b3.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712007228; x=1712612028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQH6cYgPQyBojibaEZOAAK2Nz1q5e/V/E0Lve0VYOQg=;
        b=ArIEZqv9ZgHVowgpJeSwQ4SZGubd0fD1Fyp65cDZbiWMb1Yrjp8DNLBLBOHoonsT4Z
         GqP6vS7Dk1kEtiS7mbjW7Lh6QHxGNkFOLpUJtOZMXncBRgsOrVxqEjclJGIdxfc2RnZZ
         hsX/Z6udAyjPIyKXncXoBHNZAax4lGXc6ItWZMq7dDadbHqiMRzlXDpAciHzzvv0l12l
         iY7o/c2Yid8uvWzrZIcStlztbT/jRjIB6x9kBl1VVSKAD9Hzmoik5tEd6e6GM1HSPoKw
         Ai/pksGKzpPS2OSIO2jBlZIyYPtnE5LGxxZDvhUKBQ/7FnjxS43vJ7j4bVsWa64MQHJR
         TYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712007228; x=1712612028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQH6cYgPQyBojibaEZOAAK2Nz1q5e/V/E0Lve0VYOQg=;
        b=Ty0kD8KyNusbqWG0wNFAIoyfJWVp/ynvio8xsjC8O98tJK+5XhNro+SStOyZZnTxDH
         nNX7M5EYl5pE2ih3tG97hpIRGSAT4OHFc+hFt0LDcywER92T/1rFpSxxCJwuHaYjTavi
         o9r7Yf98SkNXKkloom05/m2Lk1tPz2DtgICNBdzJsfXw+UnLIvlC3FGnAvGX5KpaLpnT
         wb/frpLTO3bGv2wx2OULMrxHlNvYmgpwBBV6sJReVt0zlPmIKJGNkEww52c7xxJjGbwY
         ksExyQetYjJLWVkXGGlvtHuNJZX1Q0X5OANEzyy9L0+6+8Dp9bTMcw5xojpU7eCtDYMT
         zSvw==
X-Forwarded-Encrypted: i=1; AJvYcCW0fYje2b7IntYxlFZQgvcZ7L4ktF8z/JUW8PkXk/qDDHjwaVBPPJjlXMQO9umvOeIVH8VJHsiD34QxReLd08FL2yt4
X-Gm-Message-State: AOJu0YxSsIdmWOZc2dofePV7XFKHLSwDD+IiZAjQrdnlqcQOC2mql3f3
	s4yJQRvXYwbuU1x7eYitQt1XTRP6G2u9ET/pOjbzWD3+8pZLOEVZhbPioKyYjiY=
X-Google-Smtp-Source: AGHT+IF7qEXbWZ9ATXUB9S1V6zV6aZFWX5HUmufGDIWKHKmZqkAYeSAT8mLUzVHLbe4s3YOLJOIUeQ==
X-Received: by 2002:a81:9b03:0:b0:615:47b:5afe with SMTP id s3-20020a819b03000000b00615047b5afemr1903755ywg.51.1712007228014;
        Mon, 01 Apr 2024 14:33:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a201800b0078a45b214e8sm3767098qka.83.2024.04.01.14.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:33:47 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:33:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <ZgsoOnle3CC8DqUR@nand.local>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
 <xmqq8r27nhwo.fsf@gitster.g>
 <ZgPIEgFGVokYWc-H@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgPIEgFGVokYWc-H@tanuki>

On Wed, Mar 27, 2024 at 08:17:38AM +0100, Patrick Steinhardt wrote:
> On Sun, Mar 24, 2024 at 07:51:03PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > I am more worried about how the file is used and maintained.  Some
> > > things to think about while in the "spurred discussion" I can think
> > > of are:
> > > ...
> > >  - Is the project big enough to require this (especially for the
> > >    purpose of (1)), or would
> > >
> > >    $ git shortlog -n --no-merges --since=24.months -- path-to-file
> > >
> > >    be sufficient and more importantly the value that it will keep
> > >    current automatically outweigh the benefit of having this file
> > >    that can go stale?  To answer this question, we'd need to know
> > >    the turnover rates of past project contributors, of course.  If
> > >    it is too high, having such a list may help for (1) and (3)
> > >    above.
>
> I don't think of this as "big enough to require this". I rather think
> about the onboarding experience for new folks here. Sure, we can ask
> them to "Please run git-shortlog(1) to figure out whom to Cc". But if we
> instead provide a nice script that does it for them then we make their
> lifes easier.

Do you think that the script in contrib/contacts does a sufficient job
at this?

I admit that I am not a frequent user of it (mostly because I end up
either having a good sense of who I want to review patches ahead of
time, and/or I end up just running 'shortlog'), so I can't vouch for its
accuracy.

But from running it on a handful of patches just now locally while
replying to your email, it seems to do a reasonable job at identifying a
good set of candidate reviewers.

Perhaps we haven't been as good at advertising this script as we could
be, and that's why it isn't as widely used as it could be? I'm not sure.

Thanks,
Taylor
