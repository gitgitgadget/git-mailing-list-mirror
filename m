Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EFD529
	for <git@vger.kernel.org>; Tue, 13 May 2025 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107269; cv=none; b=epUJQ58aIL7nxrodDzJlmUIytyY5JH0kbyA+y7ZcxdUKLLqHy0Zu+F61I1ijHwFF2Z/AlJ4WHukkwb/MzHcYBfslhpl/A6BRGX0TX0JGZlfrrgFpEuLces5VRYgi/U5wFLQIrB/p5dU1CloA5g6pvFPGAGxctJSYaNNNQeEfjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107269; c=relaxed/simple;
	bh=oG8IwcH4AuUXZDaq4KMye1FWCpz8gYFJOawuEH/IELo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNUxRxdHuMLeuUOTUSWvQPZUYkrT1pFmnzn3fpGk39SvfS04/UvxQeX6ayo5CrbTbW8CM5vPw+omQa/kk+shYkL9h9SrZZEqSEHNyewREWpefnxn5L1O1LwsJksbVEzlfkJS9lrHeXXABSXkFyPalD79O8m70agBmD81Mhrh0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGgRV6Ng; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGgRV6Ng"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d96d16b375so24504305ab.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 20:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747107267; x=1747712067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Q6FvvwH71vXSdICcUtj+GlrgfTpBBzxP8qcalkYvw=;
        b=YGgRV6Ngekbe1fKfWR0qjECsQVkcYrO8hMx0SoRr9FioJRyfCl5oARjcmWAN88Vedk
         fp40LcjHQMreTFo1g+QSHepzlALVSknKqODUxvT5k9aGosvrmAcJ0SniBHPsptUhqqv5
         iTf1xD4Qg3wmH/5R3/Av1bpfCoz5k3FJBKbyn4v8AsedUQZr7SV+5BMNvnyQUEggrLzD
         EaXWjXJ6BtzzK8v8PTNX6wx5QuJIKECp4QDIyuov4qf7o6mybgGtZOoedxbSDJTdBQZn
         xulqQwD7xYf0b3kdVVPoLtlGAKfzUvWrnrAbHEzkJtIxP1+w6vXAFtBRDFgVzhmOIvX2
         QLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747107267; x=1747712067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Q6FvvwH71vXSdICcUtj+GlrgfTpBBzxP8qcalkYvw=;
        b=w15iVMQsvfmUA+dnUTc/nplhEsmmsL/FIw0fYeeEocVpOVHEzgnCLK6VgeDG+GgP1a
         17sii51/ZwXIOBoyLwhJa935m2i1eUsiWF9auQpdJkPuIjVNZftnY7ZSwwxzX9kT2oGu
         Eep48ITSNI3X35U5A2WtBm7pbBYpfGgBOhHZrusKvXqKlR+gyvQbWVPUrfIJS+Q4gatb
         RjkB2jok3/LThKn0SabkNerWyRxP+YFCymVnsJ/JJN3gbMMyGccKAoqGJLo9H2o5p0wQ
         fTEqHaDduCEMUlfThrIYJaHuozyH5tZjmVBt9lmAFHmXCe3+F1AiKS+JhkqYtFRi/Ltx
         /wFw==
X-Gm-Message-State: AOJu0Yy9oPsV8RTaCacpUSmtNFk9zNUDjY6K1ER38qvu4l6qWrLD0bC1
	ZLWIIOHOct70Hdz5rI8hPCv7c6DI4r+Av4okgS2ADNp0cRJF3RGufxRLE7Y+H6ZKqiV5JyKj4Ni
	s3vetdgX9QGcAHPa8dW0Xb1DdJRw=
X-Gm-Gg: ASbGnctM2ZjbW2IJQ27tAH93zUFrNKA2bbtKYpOTROkjN8hjTV4cX09TNSvs1EPvtjf
	xDpvYIyhqltIvzhKj8Qenk6PAsYQSb7FdiFektAPf2eMsDNp2qhsF9J+0AGESNUV9uq8i8QbXap
	KayE9tWTQ4jWOfkNOOyPmIkx7eY1rc+7t6zns22MGi8GSG7P1QZIEuYVuxWHHfDIgasw==
X-Google-Smtp-Source: AGHT+IFeVzyHP9p6JaBtYbxaiyfM0FH0q049Ej9pGOchvaHRgOt7Vol/QJ+1oz7j2VwWA2sab8iRuIqehuejFq6LDvo=
X-Received: by 2002:a05:6e02:12cb:b0:3d3:fcff:edae with SMTP id
 e9e14a558f8ab-3da7e1e2508mr190146695ab.3.1747107266667; Mon, 12 May 2025
 20:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744757204.git.me@ttaylorr.com>
 <58891101f377267df120dc4a9edea2997296dbec.1744757204.git.me@ttaylorr.com>
 <CABPp-BHOSiOSFeqTutAqznTCO6Fh-kM7d2B-jF+LU1iTQzOTOw@mail.gmail.com> <aAAsIUqkqCqjoFHf@nand.local>
In-Reply-To: <aAAsIUqkqCqjoFHf@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 20:34:14 -0700
X-Gm-Features: AX0GCFsXpJ2VZJvj3ZwN9YE8p3IDuXhnY2TismuVU-twsIB9I1FxLOmDFGtCpl8
Message-ID: <CABPp-BE-tSPPJp2mpAKL8J9Ye2AhejG+x-XP9AF-mvCVNZ2+WA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] repack: exclude cruft pack(s) from the MIDX where possible
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:16=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Apr 15, 2025 at 10:56:59PM -0700, Elijah Newren wrote:
> > On Tue, Apr 15, 2025 at 3:47=E2=80=AFPM Taylor Blau <me@ttaylorr.com> w=
rote:
> > >
> > > In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
> > > geometric repack, 2022-05-20), repack began adding cruft pack(s) to t=
he
> > > MIDX with '--write-midx' to ensure that the resulting MIDX was always
> > > closed under reachability in order to generate reachability bitmaps.
> > >
> > > Suppose (prior to this patch) you have a once-unreachable object pack=
ed
> > > in a cruft pack, which later on becomes reachable from one or more
> > > objects in a geometrically repacked pack. That once-unreachable objec=
t
> > > *won't* appear in the new pack, since the cruft pack was specified as
> > > neither included nor excluded to 'pack-objects --stdin-packs'.
> >
> > But immediately prior to this patch you implemented
> > --stdin-packs=3Dfollow, so the once-unreachable object would actually
> > appear in the pack if that new option was used.  The "(prior to this
> > patch)" addition was meant to help clarify here, but to me it doesn't
> > succeed.  (If it had been "(prior to this series)" it would have
> > clarified that we aren't yet using the new feature from the previous
> > patch.)  Perhaps you meant that geometric repacking doesn't use
> > --stdin-packs=3Dfollow currently, and therefore the once-unreachable
> > object won't be in the new pack, but if so I think it would be helpful
> > to call that out explicitly so the reader can more easily follow which
> > hypothetical state you are discussing.
>
> Yeah, I am referring to the state of the world from repack's perspective
> here. It is the case that prior to this patch (9/9) we don't use
> '--stdin-packs=3Dfollow' from the repack code when invoking pack-objects,
> but I can sympathize with the confusion that this creates since the
> distinction between the new mode existing and having real-life callers
> from other builtins is subtle.

Okay, but can we simply call out that --stdin-packs=3Dfollow is not yet
used by default in the commit message to make clear that we're talking
about the state without it?

And while we're at it, fix up the end of the paragraph as I mentioned befor=
e?

So, something like:

While the previous patch added the --stdin-packs=3Dfollow option to
pack-objects, it is not on by default.  Imagine you have a
once-unreachable object packed in a cruft pack, which later on becomes
reachable from one or more objects in a geometrically repacked
pack. That once-unreachable object *won't* appear in the new pack, since
the cruft pack was specified as neither included nor excluded to
'pack-objects --stdin-packs' (and `--stdin-packs=3Dfollow` is not on). If
the new pack is included in a MIDX without the cruft pack, then trying
to generate bitmaps for that MIDX may fail. This happens when the bitmap
selection process picks one or more commits which reach the
once-unreachable objects.  Commit ddee3703b3 ensures that the MIDX will
be closed under reachability by including cruft pack(s); without them,
we would fail to generate a MIDX bitmap.

> >
> > The comma between objects and commit seems insufficient.  To me, that
> > feels like a contrasting thought that should start a new sentence.
> > Perhaps the last three lines could read something like:
> >
> > """
> > once-unreachable objects.  Commit ddee3703b3 ensures that the MIDX will
> > be closed under reachability by including cruft pack(s); without them,
> > we would fail to generate a
> > MIDX bitmap.
> > """
>
> I think swapping the comma for a semi-colon would have worked as well.

I didn't feel as strongly about this second suggestion, but
incorporated it into the alternate wording I provided above for the
full paragraph since I think it's still an improvement.

As a sidenote, though, it's not just a comma and semicolon swap --
there's also the addition of a full stop and some extra clarifying
words.

> I'm going to leave it as-is unless you feel strongly about it, if that's
> alright with you.

I originally read this thinking that you were only turning down fixing
the second issue I raised, not the first.  Sorry for misunderstanding.
I would like to see a fix for the first issue I raised, at least.

Besides, since Junio didn't take your fixup 2/9 patch, I think you
should re-roll at a minimum to get a correct 2/9 out there (seen still
has the broken one).  And, if you're re-rolling the series, it'd be
really nice to incorporate the suggestions above in 9/9.  If you do
that, I'll put my stamp on the series and encourage Junio to merge it.
:-)
