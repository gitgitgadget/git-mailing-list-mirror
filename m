Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03E16EBE9
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682434; cv=none; b=ckCV0q1LzYZT3xUEKLXaze+UohJ+Pengv97L42S5i7tAM4b8yObrL5yzZf4y9IYjbZ/SWqI0MY+ty5vXmx62HJ6r+dcFgRvGeBz5v81M3bUgu/S2FgDAxFy0lyvmL2ihhQuthLGh5Lyxpn8UgYx3AmtSwWLmYOqc+vwKugXKICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682434; c=relaxed/simple;
	bh=LCFpdrxTXf0cxfc+gXcZ2QLF32j2VuAgoliti5IUxJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRmBZgKA8vOmpNbt5m1sVuezfDaCuypFTEhczrw/OO29JRt0L37i8kp5QNnsAWEJi/w3bx9LIJsQUnxUvPlL4wsyU0fM0veBZIftRvgVr27J8LlaMll9z3NXClyYoyWBxhwl+ItyCpDmO6jAz/YSbQ5XzYy4jzmVxtSbdVexds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aodOCco9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aodOCco9"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539973829e7so346465e87.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727682430; x=1728287230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCFpdrxTXf0cxfc+gXcZ2QLF32j2VuAgoliti5IUxJ0=;
        b=aodOCco9vwcAp9C4YqFjFX4JJxJeflBOAxSVpiGarreQ+qdgB2WV3WzD/lw5c4wP0f
         yAVpyUgxftTxlZqNZdGagSPhToX1QHo5Kt/goNizfTv0aQ7ig5Uj340B9kZP52iChQzR
         yALHrBIds2k67RcMwoUvLjOMW5y0lnyAuWhql4HMcKfYcSCcgRME0fS7W4w89lWo46Mw
         4BiN2VPUH+6clnecqqrOrSMRXzdBoEyBGWmPwlC2HUwtc2202ybzH8jpeT66b+e9S68+
         v4lKBVJbldXZTWgvuj63G1pN8si0iZB9k7nTR0c/rkDHdTcEq0tM9PZoXlprK7PyZImF
         it2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682430; x=1728287230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCFpdrxTXf0cxfc+gXcZ2QLF32j2VuAgoliti5IUxJ0=;
        b=Y7euF9kI55wOpnjw+zQ/M88Fst8hDjqbDYuS48IF4PSaVoOmanBdBIy5XfdbH2Z+vp
         W3FF51V6FM58axS4L7psV8VrFcCHFkJOryGTcHyEhv+X78OIjW2lAUO6MAxWuI/3sjDz
         jTKNSH5UzmHDQE3JLAYdHKNymOu48yRjrU2VucRD4gqmao3IF8wVArrhUdmoB4k8kG6N
         UhzO7JvHqi67UEcPnOXNsPX+FqtcCjzXfWGdCxrmThI/RIcWUQ5gZNvoGmbUaegGyQ06
         dx6W2/e1TrIVvmEA85D+5D/5Vls2kIG5sv5/g5UIDBmDRYHUS5DHRpZrtBrkfTbBGGiD
         Qjaw==
X-Gm-Message-State: AOJu0YzwNCFHYkkBoNsAjPMkN4fAb6dmPg8hgMWzHmatEDl1aR3/bb2Y
	JhYYzx15SZ23pQG9NzUa4+NKarP0zTeQPrAMfF2L/H0ke8pfWT80ERsaWhtp5oMtbynCuYbHB6J
	0Aw/43334wbzzwnImE3pj5JPbhvU=
X-Google-Smtp-Source: AGHT+IENs5grXkO7JxVtK3/4c2KOmNOPZJBI4cAX6AL3RvddaR5eXSoSUkvuvC/5+c5wZx3p+yqCI4PcFcOxyVKIhNo=
X-Received: by 2002:a05:6512:23a7:b0:539:92b6:6d30 with SMTP id
 2adb3069b0e04-53992b66e56mr1684318e87.29.1727682429728; Mon, 30 Sep 2024
 00:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de> <CAP2yMa+PtRADLB2ZL4U3S8X+87Ddz4UZQNMmtEvV5p9nyoq5SA@mail.gmail.com>
In-Reply-To: <CAP2yMa+PtRADLB2ZL4U3S8X+87Ddz4UZQNMmtEvV5p9nyoq5SA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 30 Sep 2024 09:46:57 +0200
Message-ID: <CAP8UFD0uUJ3Ztwy+GDQe_tjf5KnHLyqW-2eDLf+qErF2dFgs-Q@mail.gmail.com>
Subject: Re: git-scm.com is now a static website
To: Scott Chacon <schacon@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>, Victoria Dye <vdye@github.com>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Todd Zullinger <tmz@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 29, 2024 at 10:42=E2=80=AFAM Scott Chacon <schacon@gmail.com> w=
rote:
> On Wed, Sep 25, 2024 at 12:07=E2=80=AFAM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:

> > almost 400 weeks after Matt Burke started the process with
> > https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migratin=
g
> > Git's home page away from being a Rails app to being a static website t=
hat
> > is hosted on GitHub pages instead, today marks the day when Git's home
> > page at https://git-scm.com/ has finally moved. Or actually: yesterday
> > (because I took so long writing this email that I ended up sending it
> > after midnight).

Congrats and thanks for making it happen!

> The simple thing would be to solve issues like this by just removing
> this specific content, but we could also work on a perhaps more
> valuable project to rethink the website content entirely. Why are
> people coming to git-scm.com? What information are they looking for?
> How could we answer those questions most efficiently?
>
> This is essentially what my first version of git-scm.com was trying to
> do when I registered the domain and launched the first version 16
> years ago as an alternative to git.or.cz:
>
> https://lore.kernel.org/git/d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@=
mail.gmail.com/
>
> But as I said, the answers to these questions are very different today
> than they were 16 years ago.
>
> The version I helped launch 12 years ago (essentially the exact same
> site that exists there today) was trying to do the same thing -
> determine what people are coming to the site for and give them that
> information as quickly and easily as possible:
>
> https://lore.kernel.org/git/CAP2yMaJy=3D1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQ=
QgE0PcVA@mail.gmail.com/

Thanks for your previous work on the website and for this background
information!

> I would love to take another crack at this, I'm happy to put some
> design resources and further engineering (built off the great work
> Johannes has done here) into the project. It would be great to get
> some feedback from this group as to what they think would be most
> valuable for people today.

Glad that you are willing to put more effort on the website!

> For example, I think the book contents and the man-page hosting has
> been incredibly valuable. I still use those resources today from
> Google searches. I feel like perhaps the Guides section could be
> structured and presented better - there is some great documentation
> there. I have been talking to Apress on and off about a third edition,
> perhaps a revamp of that content is also overdue - the last edition of
> that was published in 2014.
>
> I think the entire "About" section should be totally rethought.
>
> Perhaps adding something about different use cases - large files for
> game development, etc. There is no mention of LFS or partial cloning
> or anything here.

I agree that having content about those topics could help. It would
perhaps avoid companies and projects around Git duplicating such kind
of content on their respective websites.

> There is no information currently on any forge or hosting options,
> which seems silly. I think at the time I was trying to avoid
> "advertising" for GitHub, but it would be nice for people to know all
> the options for hosting their code, just as we have a client section.
> Even more CLI clients and tools, rather than just GUIs - things like
> git-absorb, stacked git, etc.

I think it would be a good idea to improve on this too, but care
should be taken to keep a level playing field for all tools, solutions
and companies.

> Perhaps more videos - there is so much great content on YouTube we
> could link to. Right now it's like Linus's talk, my old Google talk
> and 4 Matt McCullough tutorials.
>
> I would love to pull in Git Rev News as a blog on git-scm.com, and/or
> link to Taylor's regular posts about what's new in the new versions.
> It's such great content and would be nice to have more visible.

About Taylor's regular posts on GitHub's website, GitLab decided some
time ago to also have their own news about new Git versions:

https://about.gitlab.com/blog/2024/07/29/whats-new-in-git-2-46-0/
https://about.gitlab.com/blog/2024/04/30/whats-new-in-git-2-45-0/
https://about.gitlab.com/blog/2024/02/26/gitlabs-contributions-to-git-2-44-=
0/
https://about.gitlab.com/blog/2024/01/11/the-contributions-we-made-to-the-g=
it-2-43-release/

That's because when writing for one company's blog, people tend to
overemphasize what that company contributed, and to emphasize less
what other companies (especially competitors) contributed. I think
this is normal and not specific to GitHub by the way.

Anyway if only GitHub's version of what happened would be shown by the
Git project, it would seem like the Git project would endorse it in
some ways which would not be fair.

> Honestly, this whole website would be nice to incorporate:
> https://git.github.io/rev_news/

I would have hoped it would be the whole https://git.github.io/ (Git
Developer Pages) site instead of just the Git Rev News part of it.
There are basically 3 parts to the Git Developer Pages: Git Rev News
related pages, the Hacking Git page and the mentoring program pages,
and I think it would not make much sense to move only parts of them to
git-scm.com as they are all related to trying to encourage people to
participate in Git's development. We could either move them all to
subsections of https://git-scm.com/community or perhaps create a high
level https://git-scm.com/developer or
https://git-scm.com/development. One big advantage in deprecating the
whole Git Developer Pages site would be to avoid issues with style
sheets, with layouts on mobile phones, etc on 2 different websites
instead of just one. We would need to keep the Git Developer Pages
site on for some time and add redirects for most pages of it though.

I have created the following issue to discuss this:

https://github.com/git/git.github.io/issues/729

but I am Ok with discussing it here if people prefer.

> In the end, I'm happy to put some work into this, or perhaps work with
> Johannes and Taylor and Matt and whomever else is maintaining the site
> now.

Thanks,
Christian.
