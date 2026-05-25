Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1F1AAE28
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695604; cv=pass; b=fc+jl1e3Anr96uUeWc4IpEuRRI6QC0o9kiD7JFehOmTaaWFJ9TPHwpfP7y9vd2va9MvG6TMMV9snjYRK3YRTH6cOisNwzzmmvVgHrNFgjTc7lA5lSHFnNP2Srcv5jDufKP6f7JjpdOrlOmW5iwe5wKJBt42EiGPBKgUW9qFBe7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695604; c=relaxed/simple;
	bh=8ro1H/3LRqvmYDlrX99i+/X1QjEave2MUBx2ntaR7uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+gqJnLvyEl0NKJQLCitTJmLpAg4l8gJRNzh4LBstZ0tN2siZxvqp0cEAO9J1mrXkoMXlgIhEUryQuvET7Ns5p2odlxOovWWk1Fx8BDq9UM/6SnzVpOt4bSjQXsdUk8t1ThBelyQuU5bbtu5WFOUctPmRs/YKV54jmPlconKIPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=aTv2pCYI; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="aTv2pCYI"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bf1eaba464so85062267b3.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 00:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779695602; cv=none;
        d=google.com; s=arc-20240605;
        b=SVnJW18sBfAPOJITGL/dx+4l8fQJDgdIUcH4nvjqkxTwLKf5g6Kf7TpxZ3ndsbcokp
         k+ulVzC3rxoBFW0F4Cbx+mzWRfqjWmEOD+jT+ZpApC9SpVhKza5ZxitodM33X2Nx0/er
         cWBbbiKNbSkT2c5kVP5Iv/agBaFn9Oc3QyDaLC89kdoUJ0gr/J6eITibE0aUSSWgwstW
         F/8gX+heXvr2unsrq8GRCMfutn5p19wBtWA3GgkRaRfOyjdKnGurG1M6tD42K6tZlG7c
         MFMnDP6IgW0MtXMfT+pv+teOT5qunh/NMO27PE+vf+LxX2Yu7iuU4pWw07jnOcTjgwnm
         O/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HeLDcxOLOyuM/diD2LcSFHY/Mpm2wP375zT+OwyAL3A=;
        fh=mb7QjXbSwCASTsFk69IENETLs6mjpdpTRue20jMZ+wU=;
        b=LJXWMUCcjy+A4UBcvRcg7Rm6efn1jgikn5bIUFWr1+LfNQiu2cENuZT/z0JBXGHVmp
         LD6e72vpavrgbK66z+TK5NKGNZYmYJssEK6MNQIPlX0l1wDrzwlaoF0A8uFvRFjwPql4
         OTldGlLLjkUdd/VJivuJiOifOyzDbY7EN+dyo456gIcEikXemx8qCsWdDBMPWE1Fhs4j
         IyqxAJ7sgsEiXCOq3KPp5R22Fy9V8pxwhoYNlcOgkGUKbbwk6bY+i6/tmhOY6eIW4MF/
         kNp7ny6C+pUulCjqSGlKA/3Z0KweJzD0fOB2BIH6rPInwQUguNyUx0hpzHjmUJbHQgJb
         LG4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779695602; x=1780300402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HeLDcxOLOyuM/diD2LcSFHY/Mpm2wP375zT+OwyAL3A=;
        b=aTv2pCYI8eEzd6cyy+EPcC3qUeLSNCEpKWiZtsVcTcfl63zUoZEz1x1+yqTKdFGr+m
         53aVj5SmRnE3HI1eyqoSVNiKiOZn6UJ1kAw1UK0c6V4Ihv2YtPaBDxAqtEhUbnU/Jtf9
         D0jVzYMNjP/KOeqUgqvZTee17c87iXTDHsdjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779695602; x=1780300402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeLDcxOLOyuM/diD2LcSFHY/Mpm2wP375zT+OwyAL3A=;
        b=K9PReXjrJk1WX669C3crawbQ9vQ0sVih6RTZ0/4+cpaV50dJgiyU5fzkea3Gbca5ku
         NjmMTsqlhsWfJdazqLN3GHtXiehyW/QuuPYKOCyjrSDcyJfb/la6HwoXNf9HVvpYmQZB
         ijPeacwG9jFpZRnQA36LpdumCeRKSrymTSbNsTiX5Fa/NZ8qS37S8GVDA6XF3KFKZIHq
         G37CZYHMBu9fqNSMT6yAVfNCLpFugWFPB5LtB52I0w29KausFaKecjjBMEncVcmXHIWV
         iHLNT9A37hqj9SoBowGcdJ/C3OENRA/Bbgcv7/OC+ja7UE6IbA+8LfnixcO3HQPgmknQ
         kMng==
X-Forwarded-Encrypted: i=1; AFNElJ9YvdX7Z4Q9NsUX7FKSksgW0vpVYY8eQ6wH78wwqt/Yf4xPJZgby+neEURfYq0FikwsKaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sQFgDUmkDnZbPUMO0ytk+e47BhLO4PIchx3+LcYWHVaJ6xNq
	adoeUoUL9avDfMgmPiACdCsHnQaTlRnSIeqGwUIhxWuLJnajqMg1Td0h5bvmze6v/idrTTuBiOj
	5XRP8/8kKGL+VjRS2+fC3g0F4p5zeWQ2B7UWOYAVz1g==
X-Gm-Gg: Acq92OHIC7jWBM9bcoxrh3ITVT7AMxoXJG0M+HBwu8aAtqi0GHkrvYfQo0vDnpikjb7
	SLJ1do/bR2o9Z06rfIII9vgLNgQo/KSI8wqdJsRny3a/O4HmKbH+rdIKyj5YFDmudiSZp9C2Be2
	kEQIKwwl/VkTR45hpjRXSOZF6PNytlnbTh+xFQzgFDgenldJphCM0vDKKrxhEaRmg2wZov4za7A
	ViTz9pKxnAL6/ywPtksoFj6HhzQVpq0+BCdhaKbAaCqiQZdAxWlOEz8i2hwXBO2E44Jz63MTvFO
	t/mim6r1LYgGCm47IJWykbOzBdRUnw==
X-Received: by 2002:a05:690c:6908:b0:7bd:8ce4:92c with SMTP id
 00721157ae682-7d335fbccdamr152795227b3.31.1779695601771; Mon, 25 May 2026
 00:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
 <xmqqpl2kgyvy.fsf@gitster.g> <ca39c8ca-ca4c-4954-a1ab-633bfa55f64b@gmail.com>
 <CAL71e4NxpbM8QZYhVA_SSC4vDmAFv-Kpe6qDcurefgPkSSdSnQ@mail.gmail.com> <xmqqse7gez5l.fsf@gitster.g>
In-Reply-To: <xmqqse7gez5l.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 25 May 2026 09:53:09 +0200
X-Gm-Features: AVHnY4L7Bn7ioMk3_OYGi_65z4MIrAshBs_kFIgmhESb9wnQUQWdH3Zw6X83QZk
Message-ID: <CAL71e4ODJeCJctKg=3o9PKD6Rw3_xHnrjc+zT_MYFc=CdNc59A@mail.gmail.com>
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in paint_down_to_common
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good catch Jeff! I think it's possible that I missed the flag cleanup case
here, but it's also possible that I got lucky and it worked anyway.
That said, I think the observation in the other email thread/commit is key
here. I will reply back in that one, but it seems like this can all be
simplified using Jeff's idea with an amortized O(1) solution by caching a
known non-stale entry in the queue, and thus becomes obsolete. I will post
a new patchset when the discussion slows down.

As for general flag management, I will spend some more time thinking about it.
I don't fully trust static code analysis to work, but some cheap assertion
based model might give a nice trade-off.

Thanks for all the feedback!
- Kristofer

On Mon, 25 May 2026 at 09:17, Junio C Hamano <gitster@pobox.com> wrote:
>
> Kristofer Karlsson <krka@spotify.com> writes:
>
> > While doing the audit I noticed that reasoning about flag safety is
> > currently entirely manual. Would there be interest in something more
> > systematic (e.g. runtime registration/assertion, dynamic allocation or static
> > analysis of flag usage)? I have some local work on that already, but I was
> > not sure if this was something worth spending time on or not.
>
> If there weren't existing code that are so tied to their current
> uses of fixed flag bits and assumption that nobody else uses these
> bits outside their intended use, I'd love to have any of these.
> Uncolliding and unbounded number of usable bits per object that are
> *fast* to access would be good (and commit-slab was an attempt to
> introduce a framework that can be used as the basis for such a
> system).  Independent of that, if we can statically analyze the uses
> of these bits to prove that the same flag bits are never used at the
> same time for colliding purposes, that would really be valuable.
