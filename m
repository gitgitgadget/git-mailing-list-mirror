Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799083A9636
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786102898; cv=pass; b=jDSyQcdxuwXnf05+ExHpNrEencp8qOq+IAz14D0rlxDCjFLOJTO2HhHuJbKHVacmR+hd1fYflQzsb7zyg8E+yXHPpzgftV95anA/UE82FhroiQS7qfUYZlvA25JybdlUtfwxztcsyUD6MOObMOynVctouEtHjmI73tIeQu6WzVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786102898; c=relaxed/simple;
	bh=qMivnjAFlCmPpR1B+xg8aCg7p+N8jzC7eNNY6k+0FRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge4/k2Q6SXd90wG1+c3sgqPVA+XS1u1oZisVsnoGqvCDOE1cNPb14l5skShTK+F04VDVjbUn6lfdYA9X6NXVTf1REBrd6F22s4KH7xsjEU4z0xMOHadLwBXkDrKO/IqDHk0pkZsYUYw4LHTi/HkUFMWsQv6WXe03xqmClcjA76I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=bzdaRIin; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="bzdaRIin"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dbcb505578so31268097b3.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 04:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102882; cv=none;
        d=google.com; s=arc-20260327;
        b=dCpuyWPggkXOkmR/OrRAZ7MQRVYe+jg1XbTd8FIQY5k8MquT0bx/m3TnYEVGjtfCfd
         H28tEaghTwrcNQeYhXixTuU0bOBECT0P3hJYG4abz+b8jejQ+VN/GQSEBMZ1Dq5ip2VI
         +8lhJCXa4ukgQnRZMFedcR0z3d3ADK8UJSFWaPN1kNhGXdbiM+lOPjxHj9zNcrTDFVej
         D7AY2460L+EPhl37fiB3JmiW5h4sxowDpz7MlZOxNxkOzsUbuM9XLwcfw06Y9h2FRfA4
         c2TcyIsefUD2ASnj76nI5xrWDud7e49SoFY9meb53Bv5j6Dykl8/uGoUUgdLVdAyS41c
         WcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TBXl3mwK7ASxgFWERR1U8e+fQ0Rjcw1FgkxxKkb8rIU=;
        fh=GEPRzH8vi/3SwJlHLsbGO+lU6CxPmUC+LT8JY4AErgw=;
        b=Aw4wMALLkRiD0IubvXxlGwOSs3JteXMOxwnqRhqdX1LYyxKXjt89pX+al49yKRKhU6
         dcawljHA3pbaZACGVgTG6/ugh68Gp3EvN1LcFFBDI6BVhZebXWrtPZghQblTdi+/57fd
         AV2QrAfwQBDO4ylgLXaW3rc5nmehnJQ5WPQn3JbB+2Ame9KbxR5yQazjkxwrkONTIZ0B
         /2d9IMbjC1MihO6kzoYMhhxGWiC3tJduPU1zLiyP7ZeH/y39jzUeggBK5wzBQkTbtkbk
         iPs7LJVLQIQpl2Ri96+uKo/ts9ieDyj2QDy87grkaAWpLHfzvwtQD4MAPuSGAIs1YDLc
         4AUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786102882; x=1786707682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBXl3mwK7ASxgFWERR1U8e+fQ0Rjcw1FgkxxKkb8rIU=;
        b=bzdaRIinav+8Pi9SE2C3EH8ljeB4Deom2cjPl3g46ecjzcAIpVdxq/5yjeFoZQQxFa
         5Wqa6YXNLdtcfvVpVFNGDY/8Z85ZhSnr0F6AcGd+NkMW1m+gak5RMLCVlBTZLwLcqRcD
         F4CCtcgtBO8FH5wy3CtYRbWqTzPEDwuqGID/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786102882; x=1786707682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TBXl3mwK7ASxgFWERR1U8e+fQ0Rjcw1FgkxxKkb8rIU=;
        b=T0/V71+DDvkajfgN815R/lRmc8jE5tH9/SE2yLe9sLp6/9alAxj129GMT0Nyv03Wg0
         sfVHoFDSde0YFFVoFfjtJRg0ZJj7GfNInlZQNIfrIRRxaKrDA2XZq/7i3+PtoVh0jmAd
         YcvQVx7905hWJyNvSJstD0EGKkNXHZgrT+IWLSpSVMbJhoShRQoeIZXDPQozVn9Ods+U
         Q1DNdBB8MVuG+TSMXGYUujR+gmVU4cLtf633ispQME2LbcxrGlAeZtmepTZp4dKjuNUp
         YCSzgm2eL2pJKoAlqY7WV5MyyuMIN2DjNDwZiRU5OQNrGkbVMshd7pGM7SaE50ZhOORE
         wKxw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2dZe5GGOqHq42UBiROwmP4ghzddgN5BbN4RekzZK9sZ/hAI5ir4ip8j+uFzI86g6frtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHL1SHZDMD3KkzzzutUWfxqPSS1prjpPZDDm0dV46kb5YgB68x
	aWWQf9Rj27Chj7at0pe1yi8ENMs3SVS/z1a5FI1pTwrBsRqpiciPIVNn+3OPxOnyg6iBd725yj1
	ZNJ9vMM/asbD+rTHVGgKGGa6VVDArdkAYaAavBrlKlQ==
X-Gm-Gg: AR+sD11MuaiOHBqITP6R9OOtd0UgtFys2tMNOaNQQ3+avE9NabkrL515Kp+w4oE6GBg
	pCttcd/XqyFwH+EC1mIQCiD18kdtMZWHd01zN79GEcnM0WD68TZfgepp/MJpHu/wouQOfmAeBNP
	SMS6tHaUZM/GjMKdWv6f7oKHnjkn+SeS1zAKPtiAyVLeiQW2o3EGiPjuv0/FilzNlCgapEyaGGM
	6dkwRpjK/y7oqqqbNS4+vPX/xTNVGouEyMKubJykqy9hsH6tGrVTdvzdbcO/mz9hHAqYoqqzl3u
	ivzDu8zD8vpDwEK86mvPCWDvaiX/tfCUQ1i/EQuQ9Fg=
X-Received: by 2002:a05:690c:e3c7:b0:823:2ad3:d392 with SMTP id
 00721157ae682-824463282efmr12594717b3.31.1786102882203; Fri, 07 Aug 2026
 04:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
 <CABPp-BHp=-fA1Mwo3zqNAROjjdZ4gCq8G7h=e80qLfzrAb3VxQ@mail.gmail.com>
In-Reply-To: <CABPp-BHp=-fA1Mwo3zqNAROjjdZ4gCq8G7h=e80qLfzrAb3VxQ@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 7 Aug 2026 13:41:10 +0200
X-Gm-Features: AUfX_mzJW4Mq9uc_Ubhn8BZOrH2YWDzLAMnUru26NdgWdcKKfaheOmemXVahGKk
Message-ID: <CAL71e4O6gyc_DSX40AEUOxyv4zCxtW4wdiJzwG6zaJbRS9Q39A@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] t6099, t6600: add side-exhaustion regression tests
To: Elijah Newren <newren@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 05:01, Elijah Newren <newren@gmail.com> wrote:
>
> > +Graph shape (parents are below children):
> > +
> > +   A ----------- X
> > +   |\           /|
> > +   | B---------/ |
> > +   | |           |
> > +   e2 \         f2
> > +   |   |         |
> > +   e1 d1        f1
> > +    \  |        /
> > +     \ |       /
> > +      \|      /
> > +       C
> > +
> > +A and X are the two tips.
> > +B and C are both reachable from A and X.
> > +B reaches C through d1.
> > +Only B should appear in merge-base --all output.
>
> Was this graph created in an editor using a variable width font?  In a
> fixed width font, it makes one assume that C is not an ancestor of X,
> but instead that C and f1 will likely eventually converge on common
> history.  One might need to know what your original variable width
> font was in order to see it right.  The description below if very
> helpful, but could we replace the graph with:
>
>    A ----- X
>    |\     /|
>    | B---/ |
>    |  \    |
>    e2  \   f2
>    |   |   |
>    e1  d1  f1
>     \  |  /
>      \ | /
>       \|/
>        C
>
> ?

I don't _quite_ remember how my ascii art ended up in this shape,
I must have either have corrupted it along the way, or I considered
it good enough to illustrate it even if does not look fully
connected. The graph topology originally came from Stolee's
counter-example in the original discussion thread but it looked
prettier there.

Regardless, I will try to clean it up for v8, perhaps by copying
your suggestion verbatim.

Thanks,
Kristofer
