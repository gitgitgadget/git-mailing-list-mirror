Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA438DF49
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352197; cv=none; b=oa/GMg+cgEZXjAUqJEf1zMSdfNGxFWxl8HvElO6f5oEAea9ke1PzuTXm4WDHt/0omdG/qxPjFKiFlf9odaQf8ztOFoIF1LpS84KuoTC0pa7CDREQ5zwCo/1DkXUXJhRWlS73F8UcvJ2gz5td8ftoFD/T+6W2mLprHXDDT4CCIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352197; c=relaxed/simple;
	bh=RzUMPyRSi1XUObqMqWVqk8aYDPxkrieeJdW2qoicmoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFMCNO55U9/2Nu0j/trWcPiBJtCHdFOq1S79ycO59zvgm2y7wVP0zhuZKK8KUsCOflegWpaPg2hZIdRytlhy/xRxjUE7POKry8fFhIN/w+UWkDHnZs4sca9VJhURqoaWgu1wSn5G+6wGSi68XGOc7er/9rGpov7VoZXPcfkXVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR89YEiB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR89YEiB"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso9278690a12.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745352193; x=1745956993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzUMPyRSi1XUObqMqWVqk8aYDPxkrieeJdW2qoicmoU=;
        b=hR89YEiBmZYLzHqRYqjWyTPsnoVPShU5jkjb//X/5pZyXqkXwPG+yl+m0ZFDrsHfxU
         DlH1H/m8E8ru47bzp3Q4Hv4ZU0cf5Rdp4N9BC9fvj0XTLkyAj0K0jOT5lLf5ugVSrfR4
         NraQ4oH9Ji730IiOzuWzax6T25T0q6rwApykGL2Wq98AkNZRNWMq1vuRWGErwcJpfnni
         D3tEruMFHbLOcnr+Uw1d1nXpMKlJRTXDHClO5VW1C5ZFtBUKTGhFcMBrnNfLSvXFAUAQ
         7uLJ/yLBONupT6RaPpRSb9G3/70vNYjDdj2/TDjnah7C7035Jf7e/X85pwv6Qfcmk18Y
         1zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352193; x=1745956993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzUMPyRSi1XUObqMqWVqk8aYDPxkrieeJdW2qoicmoU=;
        b=Na9FLimAFKefUEs+hOzqzQjUdeWqv1Wu8M2G+pS7rWdiOqOxt9ZgphAmoXr6fOUhVg
         Ppyw7nESYym7PrIR0LUWnVZEEEYbt2dGZGLyico+nep2bgotp0xgVoVte2MEJtzhbpi1
         4D8mnlno7Yd2+4fhF7+tFTJlFaXlXQdWnGzIqZW0t2Q8Zx84b//oJ7q3hfZ7cfF9g3Uy
         jzE65yTbLJQ+RUJRL0mPlYuf1QxHgYZH1OtruqugqXVQDG9b0evi7dfu9RQW96PkFbJR
         58BCooEKLsIJPRHwshgOhRxe6PdXh7SZqwY/xVIT90YyVkEJFBZ5pUSh1EQGnqgP9A8P
         /hzg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/Q4i1ymUA//2w49veK+X/Eu8EJTz8d/eBWOdlWKQycS94kheMaVt7GSpnbYP00RWxyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5tTuIiDcxVn1V+xGJu9sZgShmJdyrLz92IsnwvYBNyGMlRY1
	jhm2SdiVmRZdpwy9JNpgxEIAtlIDaVDLb+zxAGyngNks9MvRf4+YkushHR2MeV94Szb8ndYiyaQ
	2HuVGxQlBHfw2iVNvt/VSYS276A4=
X-Gm-Gg: ASbGncuC8jexW1IgqoyeGXX0U9tBTDAHQVQFV0lCCqmbDwpJLhV6PcQWJ0yczGCqKSd
	sBsk65aM8bKHBnPx9jFop28q5osErfoqGwvARKWA/ytBonpgkfVcp6f/TkyCUzys755QEGINPaT
	I3LpAR956ZVd2L/8cJeNXD2Yd70L8TDnZ7LXe1vT1BPDlCRIL9iKLJ4PWa3+fI7eQ4Sw==
X-Google-Smtp-Source: AGHT+IEJgH21niWKkonFXesO7bnn+BE8VHpFjhPPotttMj2VtnqdEWamD+4STDGwRlmUKqb3yf6FHW5zRbEROCmvgkc=
X-Received: by 2002:a05:6402:3552:b0:5f1:e466:660 with SMTP id
 4fb4d7f45d1cf-5f62851ef46mr14065908a12.5.1745352193050; Tue, 22 Apr 2025
 13:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
 <xmqqbjvgr11y.fsf@gitster.g> <CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
 <xmqq34gsp9tr.fsf@gitster.g> <CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
 <CAMMLpeQvJUZJuwvK-H=M_FFedpgazGOPH=7wvPCg3U8RrxEtkA@mail.gmail.com>
 <CALnO6CDZ=rq_eZESzi++VFk081ddosHMpKQV4QHNFJbnsOMAzg@mail.gmail.com> <CAMMLpeSgSTU+SVeU6A_9LJvjVbho+QC8HpNQtKJvFic98xKvJQ@mail.gmail.com>
In-Reply-To: <CAMMLpeSgSTU+SVeU6A_9LJvjVbho+QC8HpNQtKJvFic98xKvJQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 22 Apr 2025 16:03:02 -0400
X-Gm-Features: ATxdqUHRGAk3249D8D3zs-8qx3vXhN73c-WDcyKiFSQvGUyg_7RTB6vcajJeBxo
Message-ID: <CALnO6CDb8_V9T3o+ON-8BZHcuf83UNGp23zxJKMc-rcGY=M1iA@mail.gmail.com>
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Felipe Contreras <felipe.contreras@gmail.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:56=E2=80=AFAM Alex Henrie <alexhenrie24@gmail.com=
> wrote:
[snip]
> > > On Wed, Feb 5, 2025 at 2:14=E2=80=AFPM D. Ben Knoble
> > > <ben.knoble+github@gmail.com> wrote:
> > >
> > > > Is there, then, an existing combination that means roughly to treat
> > > > `git pull` with no other options like this:
> > > > - if not rebasing, forbid merging and be equivalent to --ff-only
> > > > - if rebasing is requested (because of branch.name.rebase or --reba=
se
> > > > or =E2=80=A6?), allow it
> > >
> > > I think what we're missing is a branch.<name>.ffOnly option to make a
> > > particular branch fast-forward only. Such an option would be
> > > especially useful for the master branch, but you could set it on all
> > > of your branches except the ones that you want to rebase. We could
> > > even have a branch.autoSetupFfOnly option to turn on ffOnly
> > > automatically for new branches.
> >
> > That is probably something that is missing, and might solve the
> > problem, but I don't know that these in particular are something I
> > need (read: want to implement).
> >
> > How do you (and Junio, and others) feel about
> > pull.ff=3DonlyUnlessOverridden? The meaning would be "like --ff-only
> > except when branch.<name>.rebase says otherwise."
> >
> > The name of the value can be workshopped (I initially thought of
> > "override" as a short value, but it may be too short to convey its
> > intended meaning). Perhaps "onlyOr[Branch]Rebase"?
> >
> > I think this would be a smaller change that meets my needs without
> > changing the meaning of ff=3Donly.
>
> In my opinion, the matrix of which pull options override which pull
> options is already too hard to understand. Rather than add a new
> dimension to pull.ff, I would much prefer to fill in the gap that is
> the lack of a per-branch fast-forward setting. It might be more work
> in the short term, but it's an investment:
> pull.ff=3DonlyUnlessOverridden would only address your particular use
> case, but a per-branch setting could address many others. For example,
> the user could set branch.autoSetupRebase=3Dtrue to make every branch
> rebase by default, but override it with branch.master.ff=3Donly to make
> the master branch fast-forward only. Or the user could have
> branch.<name>.rebase set to either true or false as appropriate for
> each branch, but temporarily set branch.<name>.ff=3Donly when they are
> in the middle of work on a branch and don't want to accidentally bring
> in upstream changes that would interrupt their work.
>
> If you think that you can write the patch to implement
> pull.ff=3DonlyUnlessOverridden on your own, I think you're capable of
> implementing branch.<name>.ff=3D(true|false|only) and
> branch.autoSetupFf=3D(true|false|only). Use the code for the existing
> branch.<name>.rebase and branch.autoSetupRebase options as a guide,
> and people like me are available on the mailing list to support you.
>
> -Alex

I actually did start working on this by first writing documentation; I
got about as far as saying that branch.<name>.rebase overrides
branch.<name>.ff when pulling unless it is only and that
branch.<name>.ff overrides merge.ff before I realized that I was
constructing a complex decision-matrix of how config and CLI options
affect what happens, and it's already overwhelming enough=E2=80=A6

It would actually be nice to spell out the matrix somewhere, but I can
do that in a blog post if I ever find time. I'll leave it to others to
increase the complexity of that matrix :)
