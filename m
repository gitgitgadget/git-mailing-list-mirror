Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458B3932E4
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352024; cv=pass; b=o/YEyb+WHhJ62xkGwmalTk/iTYDWdj3rFi2+ochywEPMKQF9AVjzuP9dQELmyMIfj0VJozEjYP2+Id7bZwlwndmEioY9sFQIR+ZsdeJqLNd3Uk33+Y9mz6fadXGVK9VxBeQc0Cnaf90Go98wtT1e9qIIH0xK66tB/SzskoOrKpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352024; c=relaxed/simple;
	bh=wOXikgK8bmcunBoDayHKhUWn4ioAiSTVkZ58Ta8F8Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2fAcgNwNkB65gx2XXIKa3es8Yp3cij31lOZar6HS7of19jTvZJBvDeeQY8wT2VV7gZVsH+n2Rw/oyoMtlWGkkS740XwqQ9IaTUgOs4KxEWZE/qeIfyuSlu580ayVgxJzfFiZF/6e2pSqKjUzip0zwnrXLHI/NSkJLBOYMWcBqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2E96QkK; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2E96QkK"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c126fe7d0f3so409762866b.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 08:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352021; cv=none;
        d=google.com; s=arc-20260327;
        b=Ep93gVAgfjbdvNA0s4asmad9/QGnb3RSfEfiojAgw9A6RBBYrrMrQ2nQfllhY6S68T
         8A9tKtlkTCYfTKJ55sv60Mu+CjaeP61dUqZK5LK4uq0CoDWdribbX5xvSiQUlK5cDhHB
         cwFzh2ulMvrqNTb3eUndTBzJ+XvhrwI3SPuyHMPx0nNw+4bY/3JagjCH8ah7P4htt0m2
         I/GQav7OgDRzyB2Y2VaxM7Vo8vnDDBcngmcEdNwmX0iL+Cx3fefgK0Z0XHXdXVtifvDu
         UnMGmtuF981+XSd+2X9Sm5fPuEl4UW5TB12E7pJIu/xEsZIbPpyDUBh5Kls09IeYZvtH
         2IuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wOXikgK8bmcunBoDayHKhUWn4ioAiSTVkZ58Ta8F8Ls=;
        fh=f/uKFv9ZLSGi8+hkug7gVIVKOOZX2eJ2IV2eL8+Ayj0=;
        b=DgdXeN7BwlhhcFBH88Yg/ROlBDQWtk2F1aY+MOmvNPOn4w7sUh/BuQ9nzO/Lz3gU2V
         dEAnbe1J192+3+BDqZpYbQPgiAzA49VzHlFCNJyoE3nPWSRs1WcXcRDbP0+rG8qt8jkZ
         S0ixGPxrh7Tgs9J0tf5w0s7ASi+y2SWFz5wsjLS1N9v1oSr1gWPigzQqJi+bDpvsG77F
         mhcfXdPax4wRyY4m8DvQpcDQSEr9aPVZi1+/WFk+s1ly9kr5hzFuWrKO/wu1OtMSU7Wn
         IqojYwSzxa9AeODH9M9oD00uTa/bt4Yr7aEhGsrc5GVH8kKIl2RqIk7f/zLH7TB0GBE8
         /v0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783352021; x=1783956821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOXikgK8bmcunBoDayHKhUWn4ioAiSTVkZ58Ta8F8Ls=;
        b=K2E96QkK8zZv3pfsHk9gMGoXdh3PVTLZ2b92WgCq3tBumRkyAldD6MFqQa5RwbMk3y
         WJTs4k7n0ujrbSp20fofcjpZMVOBZe6GGdGPEH1qdD7BxB2xPmJC7RCaoyzJRBikPwib
         o1Vd5xSIJJ7Q4aRriYhFmkjaOoKt+aFO02vi/lBOJSFifhXCAGp7tIP+NYsRljrgh1s7
         owpgD9YG4kkBUCG10WS2d7IHhD1U4QdvK/hi/kVrDRUhAIqwUz7c1tIQ5sNsD/WR3Gqi
         nBjR2vlj2vIT1ZdcTqeK1g9c77H1QAP6Xrny0oBHZGSM49dhm6Dscm8k1TCUY/+vUKSw
         2n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352021; x=1783956821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOXikgK8bmcunBoDayHKhUWn4ioAiSTVkZ58Ta8F8Ls=;
        b=spn2MYW0PPhP/1x1H48Ab8gdtKZ/6Nn8bCkzqw43DIA9nwu49vQniV6wBGNI6L3HSM
         3aob7YMBme2RiFHiBodjBAxATCVzwORSrkDRvnatowgLsU6p3Z/kvyaALMAb75aCpW6T
         s1r8FEx6I6f4qcEbGao9pl8XB0oMzDo0n/Vo7rg+hekOLCH8/hLZxnZFvi2ax2g6uuHG
         TBsGT3odfXLfj7wgvwiDBmrlyyEwWTWRDGDeUXKVm1WlI8KloEa5p5K7Aiz5eWLI+cYu
         yR2u3TRq0xVfW/c7L7ap0eUoXx+OTADB591BS3dw0NO4uGj5LAXOYUNfEH9X1jjK5UaF
         m55A==
X-Forwarded-Encrypted: i=1; AHgh+RoSkBWOBul6VLWgtO5Yb8dYnl/gtq1sjZdYLlnKL+1RJe4ldCV77rEMGq3hJ+q0HqUsZR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNR4HS/yCvvccLSfyFxmWYSR4Fx6tr0YPTIeGBTuPGk9OWPet
	+2yX/wxw6DUMRRXHZY2oJ2q8H5b/sOoQlOftlSHpyJHv6OAOjNgM9czX1sro5/t518O7l1rwtME
	xouxe0qM6Zb7OnZcl5l7LRjdtllMSsCytwgnW
X-Gm-Gg: AfdE7cmgm4cAkjuydw2TjEFM+XUx6MPq9fGBgNjLG2O7Sv4/e3bqmZw5zEM5s62P5qQ
	s/B2Ov+mfM27zWwBAeNfCTKY6U8wvqTjaA3OpCO1mJspvG/u190ke7/HTPKamw5IHTHcBz2k1Eg
	SwDLx77yhLaW7glswLQLCdZnJRz7EQKD2alkMsWQeXEjIdS8wTwFTeVrLNVkhlgKFruL3YSgxKI
	LasQElL4UJoxNNjfRpvNG4FdFY5FakGkHFz9Jq4I7vpl36BeZeBauW2b1N7AIj7VgvfIlrAI1A8
	l66biPjzmE5C0RErqyS5N0EEAiSTSXxK5+40UlFw6Ir+FmJ8aEFVubeH/wXkcCQ4Pz3+C0JjQD7
	nTe3gOvC/NXY=
X-Received: by 2002:a17:907:c00b:b0:c12:4ddd:ade1 with SMTP id
 a640c23a62f3a-c15a67b8464mr66115066b.4.1783352021151; Mon, 06 Jul 2026
 08:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com>
 <CA+J6zkQFsTA3QfU5VVjQ=KhJCg_pCrTgW9zinAUC4D9YwsyOkQ@mail.gmail.com> <CAL71e4O1tLE_VSDeeZQ_p=8kAXvk9JQ9EqdPaYMZnNs+Xj+RYA@mail.gmail.com>
In-Reply-To: <CAL71e4O1tLE_VSDeeZQ_p=8kAXvk9JQ9EqdPaYMZnNs+Xj+RYA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 6 Jul 2026 21:03:12 +0530
X-Gm-Features: AVVi8CcmSl81WbuY0S-Vj7k7me38KrW7N2fYXb7x6ap07v5PBSKXxJVDTq1Xgcs
Message-ID: <CA+J6zkSrcJVcKmm0duTQwWcLxrsZ6eZkVgL=hQUQHegKGsWsxg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] graph: add a 2 commit buffer for lookahead
To: Kristofer Karlsson <krka@spotify.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 19:15, Kristofer Karlsson <krka@spotify.com> wrote:
>
> The hardcoded size-2 lookahead buffer was my suggestion,
> so I am responding inline with my thoughts although Pablo is
> the right person for making further changes (if any).
>
> On Mon, 6 Jul 2026, Chandra Pratap <chandrapratap3519@gmail.com> wrote:
> > Do we need to NULL out the retrieved buffer entries? If so, it is
> > worthwhile asserting that the entire buffer is NULLed out in the
> > !graph->lookahead_nr check above.
>
> You're right, it's not technically needed, and there are many places
> in the repo where stale data remains in buffers, and it would be possible
> to do that here too. I don't think it matters much in practice though,
> and NULLing them out would perhaps prevent some accidental reuse on bugs
> (NULL would crash instead).
>
> As for asserting: rather than checking that empty slots are NULL
> (which just verifies our own cleanup), it might be more useful to
> assert that a slot is non-NULL when lookahead_nr says it should be
> populated, i.e. assert on read rather than on empty. But even that
> may be overkill for a 2-element internal buffer.

True. But since we're already going through the pains of initializing the
buffer and NULLing it upon a pop, I'd much rather go the extra length
and verify what we're trying to do, shouldn't be that complicated anyway.

Whether that means checking for NULL here, on a push, or on a read
is something I don't feel strongly about, either is fine with me.

> > Not the best engineering practice, but I guess it is fine to constrain
> > the logic to _only_ a 2-entry buffer since that's what we'll always
> > deal with anyway.
>
> I did consider making it a proper ring buffer, but it felt like
> overkill (and I could not find any other existing ring buffer to
> piggy-back on in the repo), and the lookahead depth is
> structurally tied to the algorithm - we only ever need two more
> elements.
>
> It also helps that this is entirely internal to graph.c. If the
> buffer were part of a broader API, a less hardcoded approach
> would be more appropriate indeed.

Agreed.

> > We should use ARRAY_SIZE(graph->lookahead) instead of hardcoding
> > the value 2.
>
> Agreed, that is a nice improvement. What do you think Pablo?
>
> Thanks,
> Kristofer
