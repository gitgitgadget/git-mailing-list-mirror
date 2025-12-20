Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F46150997
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766249498; cv=none; b=KkKxbxRFkA32QgBQa+4EkAA3oSU96PqEosNA5EHgSxq4zCsyFmImdu1DExvK2Sz1242zE/YcT7NyZ6gOexmehWSn27KReEwSvsFRJ/Lu+ikoPwQ85ByOb6BpkcNX0DROHicUBSVJIf26Uc05yaMFbxxzWymxpQqRc2cXjGcSGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766249498; c=relaxed/simple;
	bh=tQ4xBFVGh9lUSDRsGFosyhAAfQc3N3I5l7PjrzD/yIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7Qgt6HRa1jF/SIEmGco3JSUH9G5dy54HJIIeThF00NDYOzM0fivCBAtKBwZ1KnvXjW5FoSE0qD6UWrF97uCAF9nXA+spfmPTArk3WJNaO3WucnCmQwZazsIew6YrFwZrrXD9eENzBwuzLvXBJAsxffH2dFqo0H3MSGYt+CORcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB9qMtGo; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB9qMtGo"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so1864375fac.2
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 08:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766249495; x=1766854295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBPu0juVR1dKTa6BYNquRo18H4mp9x91dh2AWmChiO0=;
        b=XB9qMtGoIjE+X3MMi1DPofmIABdGPp0HhOl28nWLiFzqlOczBiBGFa+8TfhRbtPGHK
         DKLgwlKpOdffQfLm49r3qzy/hirdVOXf9QI5FaY3Ycn61AygWoXk6PFfSUz7OffvD0o1
         uGUmRCIDa9EQ80gHL/6Y0D0mdqEsMyO1D38yeRSgplt4gEUOs+WX0HP+u/0uPIomyQNn
         9S+zG25SrG+QpA/s+jeTXK04X0x20wLWSdHOh2QFnsav+1y99s92xHBqtNJT9Sy0CHmO
         Nj9B0SNa1mZJ38b2FzXP872NmQK8TMaJH+lmMu65a0aKq6HEtBwUA50BQSd4OiyBJtlu
         QJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766249495; x=1766854295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBPu0juVR1dKTa6BYNquRo18H4mp9x91dh2AWmChiO0=;
        b=cmvbtYqGvmmBR8GMrs6YJJtZTWypE50VfSplrhgca4xYDBm6Lvj/yX8JPGQUs0u4mD
         p+/BjZFLNnwIesbWRtbDEhV8KfAreAS1Z98RXrE+/AcxE0AD/txzJ1mq9R+GybkbaJYH
         pGb37om88XlLDdQA0YzkBJJdWawKJCnftOBQM7kOs3DTFiwH/IX7spe17c//Y2B5jvbD
         X7fkt+8RrYwuUgpzfVl4Xpo3+2KzNbi7G/4yFYEmDenL8j1Oqt1tpFvBYkqUUCuEEqcy
         O7zeBl1mJA3f7FYlHmJLMKx7I6R/nAd+Z52znHfRAVCTOyLwJZR5401+49bQtP0zprYb
         E+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWGQctu77gDqEWQXyRoFo96d+0OR9RQYFsCClHlisRfte0IbzFbHggQ9+kKv1WM42kkoio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyM4b3bvtiQFO8zhgttAxMww3aedAxkwU++1bQE6+mt6HHcf0E
	sVDcM+YYbBjhmcWDOmQtwWYdf5U9D5dREEUX8DZypmbdzDykgjeY6cJa4VxHFgL31ghLg/cUx3T
	7stVLICrcNPu6dFkc1lnKLQ8zzcgYlUs=
X-Gm-Gg: AY/fxX7a2t5cqlmB6sJ94dKMi7EV4TIxGlEY8kcm4CyRjVFLON4DS40bmm9d7W+wykn
	PktU6jeL76wDdkPMVE5u9vft4lykS7HBkEO2GjdthvIUTmLsUT/FR17HXS3JSXXPKB5/y3QL+gJ
	yfR8XoUhWvTfn+RvgsVLu0Xf8MwL1zi6fDG7eVjcCU/eDimzUUtowMWHtePb3U7nCPunskVwT1U
	JiDpNjaFT/IuXVt7P7C/YSXN+45uVG3jjiSrcRPd1yrnZ7hmMl1BbaNbqvWms1SdOdOZ69MCHnO
	3IP+HlkhSaHjlLB72xgVKCA9s8Lf
X-Google-Smtp-Source: AGHT+IEL2ej4CDU+GT1RSF/AhLujm8jSsjiGWWEfnCXQL0c8hOTjXyJk2AuRrY/I9FnxzgFGNETto7ENV0iDfCHBCII=
X-Received: by 2002:a4a:d84b:0:b0:659:9a49:8fbc with SMTP id
 006d021491bc7-65d0eb2ffcdmr2294177eaf.53.1766249495271; Sat, 20 Dec 2025
 08:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com> <xmqqms3qh13e.fsf@gitster.g>
 <aUVDax0PbkaXGB61@pks.im> <CABPp-BGE1PC0RhpkfABUL74Yade6HkMQd35bv0my9A2+1VY6AA@mail.gmail.com>
In-Reply-To: <CABPp-BGE1PC0RhpkfABUL74Yade6HkMQd35bv0my9A2+1VY6AA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 20 Dec 2025 08:51:23 -0800
X-Gm-Features: AQt7F2oLeAew9Gwq936c7MRv_uRI9YE0NHMl-M5tb0XLyHygzNc1fgaOJWNTSr0
Message-ID: <CABPp-BG9h1xxp9b2UfE00EaKozk5kGAUELe-Od139amZdAa47g@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 8:30=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Fri, Dec 19, 2025 at 4:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> [...]
> > Okay, so the majority of folks here seem to favor rewriting all
> > dependent branches, which is also the default that JJ uses here, and
> > git-replay(1) does it, too.
> >
> > There is one major difference between git-replay(1) and git-history(1)
> > though: the former works with revision ranges, whereas the latter does
> > not. By using revision ranges we avoid the problem I have mentioned in =
a
> > different branch of this discussion, which is that we have no easy way
> > to figure out which branches we'd have to touch in the first place. Thi=
s
> > is because we simply walk the revision range there and then look at
> > which of our references point into that range. That's simple enough.
> >
> > But in our case we're not working with ranges, we are working with a
> > singular commit.
>
> I don't understand the distinction at all.  `git replay edit` also
> took a single commit, and then implemented the obvious (and jj-like)
> behavior of rewriting all branches that descended from that commit.
>
> > In my head this meant that we'd have to basically do a
> > revision walk that starts from all of our branches so that we can figur=
e
> > out which of them would eventually reach the commit that we are about t=
o
> > rewrite.
>
> Yes, and it's only a few lines of code, as I showed earlier.
>
> > And that of course doesn't scale.
>
> That's quite an assumption about scaling; I don't believe it.  Under
> what conditions would this be slow enough for users to notice and be
> bothered?  commit-graphs not enabled + weird local clone with
> thousands of local branches?  Also, isn't jj specifically designed for
> large repositories and with scaling in mind, and yet this is their
> default behavior?
>
> More importantly, this is being used to justify a large principle of
> least astonishment violation (disconnecting branches with shared
> history), so we'd not only need to show that walking all branches was
> slower enough for users to notice, but slower enough that the negative
> user performance experience offsets the negative user experience from
> the astonishing behavior.  Typically, spending extra cycles to provide
> users with good warnings/errors is a good use of time, especially when
> it'll take them far longer to discover and recover from negative
> surprises.

A quick clarification in case I'm misunderstood above:

When I talk about rewriting branches descended from the commit, I am
specifically talking about refs/heads/*, not refs/remotes/origin/* or
refs/tags/* or anything else.  Because:
  * I suspect we'll soon implement an "immutable branches" concept, so
that e.g. a request to modify a commit in the history of "main" would
result in an error (by default).  This leads to the idea that we're
just rewriting the user's local stuff they have on top of the
immutable history, i.e. their local branches.
  * refs/tags/* are designed to be immutable, obviously.  In fact, we
might want to automatically include tags in the set of "immutable
branches" by default.
  * refs/remotes/* are designed to match what the corresponding remote
had, not to be independently rewritten.  We'd really mess people up if
we changed that.
  * The fact that users created local branches means they are marking
those parts of history as a relevant area of interest
  * While it could be that some of refs/remotes/origin/* have shared
history with whatever commit is being reworded/split/edited, so too
could branches that were never pushed.  I think focusing on the
branches of interest to the user (i.e. their local branches) makes
sense.
