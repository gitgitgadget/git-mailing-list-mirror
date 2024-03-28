Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FA7C0B5
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621275; cv=none; b=BXUf5H55IVM0mOzUMrsqpDHycHAm9sNe1ak5ZbLEH99ED705nz23i4vOI5MazjqmlK7esjoBeYUArutu3ej5SFN/dkrGKg1Mq7Zg2rDpHxLrcfR7BaU2F5Fg2tQA0WrJL6zb/7CJlAf91ugk2ppo1tgQEGEFBwV5OJxEsy3kuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621275; c=relaxed/simple;
	bh=9EvsvwW4svKmn6hfua68baAamr31s1J+XXFW7GKOup8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZoKTHLI7e9+7Exy6ydUrAvtapdyYDxDMoVwYAOc7WIlG6E4aIxN2WeSlE3y2WMYGWVWXELrxLa9KGTfYvjD/k52CAWG+oAH5m7x4gYYV2zuiTivA93T72OeNp+mIsCizvofFNpoFQl1Mg3zgxin0K+CQZ6Xo/gy+cVG5fcPjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69625f89aa2so6076656d6.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 03:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711621272; x=1712226072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k4HMRegsWoD0Vl23N1VbW2usjhHV40bJ+S2b6QURd4=;
        b=DReC94NI3AgL4BmQhzOVkH5WS1gqR/61k4WMbvc5bWj8Lb/p9VbKse4+pLHXaBAND5
         bqwRU3JeuecVZy5hnJ5U+/aLtDXRlKziTqiw0ip7wNLweQFpTadUxgCJlTsCf9bQKSjy
         DvtoXqJWd94V6s/yeGDZhzWEN9MhKck5UT6ghAvanZt1/Dno52d1xgCfgxs10pmNaa6O
         TLSNwbl+o45mjC3fsIO1hanoZaTVwBkB4Y4NMMcrHYM7Jq+m7ob5+DmO1tftNpM/sgvU
         JPXLK6IUEOa613fVsoSnFcm+7xygQxYLRCVRFxwRCHjILcm/H48huTxo/2+PmcCRH9MH
         91eg==
X-Forwarded-Encrypted: i=1; AJvYcCXH1Y1LfKjvEvLb7vLS0tFo5Mce4uuLEuh0iL28QhG6CsVAsZCnx5+No7XD34I1ZzTRTtVGhDqLDz1tnUO6P75/+ABC
X-Gm-Message-State: AOJu0Yx+9ozMHaSxB+eef6B83aBG86ixocFXMRBm/r4eSt+KHMa7xDUk
	9YukpYlRZqCTrTrpYYLux3T6tQ+929qsYBBHABbgj+zvnB0d5T+POAlFNkexTEhHKtt7nBBz1i8
	d/MvndCLg5gepdH+BJtHgw+VsA54=
X-Google-Smtp-Source: AGHT+IFhKwc3v9Y5KwYa8FoUp3I3+3drjCqvdhXw6lS/ub65tBuhHFP/AuzIoiOPdfel5UVkCF4TxpxyO79dUhp/Ak0=
X-Received: by 2002:ad4:5507:0:b0:696:990b:dfeb with SMTP id
 pz7-20020ad45507000000b00696990bdfebmr1989691qvb.16.1711621272396; Thu, 28
 Mar 2024 03:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
 <202ed891463c134904b89a0d746d85bb62338d52.1711318739.git.gitgitgadget@gmail.com>
 <20240328100658.GA883510@coredump.intra.peff.net>
In-Reply-To: <20240328100658.GA883510@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Mar 2024 06:21:00 -0400
Message-ID: <CAPig+cSEJA9DiiGL3eFekkicMoaEET=2Tm-RkW+p65f7Q=2L3g@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: allow literal and emphasis format in doc vs help tests
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 6:07=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Sun, Mar 24, 2024 at 10:18:57PM +0000, Jean-No=C3=ABl Avila via GitGit=
Gadget wrote:
> > +                     s/{empty}\|_\|`//g;
>
> It looks like this doesn't work in the macos CI jobs. E.g., this run:
>
> I think the issue is that "|" alternation is not portable. In GNU sed,
> doing "\|" with BRE is enough, but in BSD sed you need to enable ERE
> with "-E". I'm not sure how portable that is (we do seem to have at
> least one instance in t6030, so maybe it's OK). The most basic
> alternative is just splitting it like:

After reading a patch very recently which used `sed -E`, but before
responding that it was not portable and wouldn't work on macOS, I did
a bit of research and was surprised to find that it is POSIX, and that
(at least) relatively recent macOS does support it. I recall that I
also spotted the existing instance in t6030, thus didn't respond after
all.

>   s/{empty}//g;
>   s/[_`]//g;

That said, I'm not sure how recently macOS started supporting `sed
-E`, so what you propose here may be a good idea anyhow; and it's
certainly going to be more portable done this way.
