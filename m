Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233733859C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025324; cv=pass; b=t2CeaKagXJxkoQdJlybIHgQmjxTE8c83lFJuGbqbv+mRQT7rxHPbIlcaTLflc5sPZJpxnaki5OlGsqL/7jBEEDZfYI9LmRrRwYUDWnolwGdW8T+vkNeenDn/j7rA5csrRmF+VeN0yhZZdAtHt2tijGXNNRaqI6qUPPy8fqKdUGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025324; c=relaxed/simple;
	bh=Bcx8AHbM8Xe+4jTNK1g8MUG5BHrGNomiDFtFwkg8qOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS6vrj5z8Nbp30IkGQHWm41uy3DFfnk2aBy56NSCn7Qm5jBZH1jHN0S6H334xiZRDj0kvgrpFnPitM7VaJ6NzgIxawzTIpBloZHUpRJbFH2fRawdlpp15NEIZ0JHEQm8a27HFgPUhjbHKA19sD3jPZ2hS0WCAFVoXbpIoYm0SzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9FJ1YGP; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9FJ1YGP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5770951a91.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 10:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025323; cv=none;
        d=google.com; s=arc-20240605;
        b=NqV+IDzXoHGvYgdRDmJCnyu8d7oAVRoZjCW5Ppsw1xw9QbB0OMO3KqA/ZOnuNMDF3X
         zZ2l4mHzU85hAI1RTzgP5tdvebdsT1A4oWFC43UqqWKwyZnvlrM8Se27Py+tvYgWuzqR
         zE43OiXFVpHfSqlGmxFGfwlL7ZUDoBNpmG22wMMYIyGkIubovGBK4HkmCwLJ8ksXQcvH
         tRc9rjvlWCVnxwcGkCPFTbu6gVfwOscfw//AfKfro25NNyc2ESARXI8d6t5UTvPrO24E
         R3IGpP9Aag1gqSt6uyBTQ9zNNPIe/rnx9AP6UxN0JsILjMaSJC/eekvfpZ9iq6YsQXaU
         Jldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hdxZkrnwbpIaYeEXvxDcO0LJjIp5KM7TjJbTawM/4Mw=;
        fh=JXEs40DwwsDIICretIR6AhTxI8iOgnQYnwvLmc7A5fs=;
        b=O8ltHqv7lOx7s57+iG8Znz8DFB+WhDmihnFMzsIwReibQ8JxZddclMI1GRHAYD12ai
         4sUzxK0kXUuqBeA+JNwUvN+Tq4WLxqBXzSECRS7npDnJ9qhZG2DjWz2W2xtnR4MZoO7K
         cSKU7JyEnHnq5QBBQ+LTsVFqaJx6OtkSTbadwWr0Aa7ydkqzAstAugPht9crgEwHjuXn
         InO51Hq1/z2nanGfmBRm43itgmnm0dkyAacjPXjoMn55Wx7sdz0xEAsUgY6eiBkHSe8A
         2dCfm1/shQ+cHaDYzKIbkiEpgAGpI9QJC9P1pHV9Nakko8RfR2QQiS7+ZtOAbRahdP3l
         Ls3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781025323; x=1781630123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdxZkrnwbpIaYeEXvxDcO0LJjIp5KM7TjJbTawM/4Mw=;
        b=s9FJ1YGPFVsro2ixi0AxpbhIAthxmMZz43yms9WcA3Mm/LSmN91aUKpZ40xt7OGKR7
         7WS/PsN2SELIs5W9CDRQjUW5dqJDbZOlU3bJJSquV0+rgv4qSM9CtLdK/80X17e8DKIx
         DgfzHLn4w4n08SodAVEsN2ztDVzSZ9yCF+FZMHao3Luq52RwAoDnRL/8akokbMLEQJlv
         oz/Cb87kgwG8UwpXUda3QUMgL2JR7RkkaNSxyByvLiOeXWK2eG6Bi1CIJPcSdtiXW2FN
         C6gb4BILMj+rd9EsgM3/NZfuLO6IWStTnLwQ9RPjTOatCRb0/CpHhh1Wsx57rlAb5hMT
         Ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025323; x=1781630123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdxZkrnwbpIaYeEXvxDcO0LJjIp5KM7TjJbTawM/4Mw=;
        b=KusDadAiE5D0SuL+KEQP3n6RUy5BngLWuubo+zohJx8nFWHat26MnjCDMLBNBJnkRD
         /hhZvh/VcVZbliNpvIjCpEoXF6gLl0/0pRN7jsEbMd0tSQFo/R5/JNq0jrh0Wop1xw5H
         P3zdQwasNyxejvM1FBAsH34hhGp8Trn4ESqdAnaVfzOPnkCcWEY6K1f/MpYKkQkT/XZf
         g5gT9f6zlqLdk2n3klKwN2nSBu7pDZkOZPItCzdodoJaEQG//LiBOkgkAkc0qDpPvMDj
         tjv8VdVNacIR9FmcZ+7VazuLLCjPZJYjj+AeRO4buPLVJNG51nY6a6MyWOp05zyBbWzu
         k2Dg==
X-Gm-Message-State: AOJu0YyGsIarpFwLe7gugXDDeUWA9qfWwJPvu3fMOesIxUbhXlCo3Vit
	YofUjKOhsx8zfpmM4lpG47JGhCgZummRuDKkY+jgAg0MUCr+SD6mDCk2x3jGtHTihPlH4xVcVjF
	9g0OvqiHer34lUjqaHK0jcFX4Q8Meo6g=
X-Gm-Gg: Acq92OGymw5cHDu3FFwlPrWTyhnCoygJwhzgCD2n/4b3zrPkMWixnLnDxqzB823qCFy
	E2ahCeXWSkHwKrNMI8uR/SqJcS+vC3eDua5W2Kx927PvyfCpAn3NdWrOywZwdCYeh8pvXj/l2CS
	teP0LhXL3dpH5+aUk0Tr0Vbk5PxZs1YC9nWYBO/9Dt14Pry9EYUqjTWbDhqzGANrn6eIRIStsIe
	m77e89SkGdbSWc78BwIOPyYXE0YWBnjgr0jL5sr0eE7kULL1o1raCrdVdmI5iYH/5Luqllun/w9
	cBlmczuk61jwYrse7voKBXlVRxoyUgFW4BVTjEqJsl4q6sqzDKW7ReOPbTmUn1JGBXdwbK07wf4
	UrwS1MBk8s9nBF+jynhftdULxZB/rpQzFvJHnYQ==
X-Received: by 2002:a17:90b:2d4e:b0:369:7421:75c3 with SMTP id
 98e67ed59e1d1-370f096ab5emr20964974a91.16.1781025322618; Tue, 09 Jun 2026
 10:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
In-Reply-To: <20260609001134.GD358144@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 9 Jun 2026 13:15:11 -0400
X-Gm-Features: AVVi8CdXTdqLOG2C6OpwePuJHtHMtrsMmU-tl70K5Ujjr9HuMhNi9wEv7aO_y5k
Message-ID: <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
To: Jeff King <peff@peff.net>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:11=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:36:45PM -0400, D. Ben Knoble wrote:
>
> > I'd like to report and offer to help fix what I view as a serious perfo=
rmance
> > bug:
> >
> >     "git diff --no-ext-diff --quiet" performs about ~10x slower in a se=
condary
> >     worktree than in the main worktree.
>
> Hmm, I get the opposite effect: it is much faster in the worktree!
>
> I did:
>
>   git clone /path/to/linux.git
>   git -C linux worktree add --detach ../wt
>   hyperfine -L dir linux,wt 'git -C {dir} diff'
>
> which yielded:
>
>   Benchmark 1: git -C linux diff
>     Time (mean =C2=B1 =CF=83):     188.9 ms =C2=B1   2.5 ms    [User: 166=
.4 ms, System: 130.7 ms]
>     Range (min =E2=80=A6 max):   185.5 ms =E2=80=A6 194.8 ms    16 runs
>
>   Benchmark 2: git -C wt diff
>     Time (mean =C2=B1 =CF=83):      20.0 ms =C2=B1   1.5 ms    [User: 23.=
4 ms, System: 103.5 ms]
>     Range (min =E2=80=A6 max):    17.2 ms =E2=80=A6  24.6 ms    132 runs
>
>   Summary
>     git -C wt diff ran
>       9.43 =C2=B1 0.71 times faster than git -C linux diff
>
> Running:
>
>   perf record -g git -C wt --no-pager diff
>   perf record -g git -C linux --no-pager diff
>   perf diff
>
> implies that the slow case is spending a lot more time computing sha1s.
> Which implies that the entries are stat dirty. And indeed, if I run:
>
>   git -C linux update-index --refresh
>
> now they both take ~20ms.

Ah, TIL about --refresh. I suppose it could be nice if "git diff"
updated the index in this way, but that sounds like a band-aid. Maybe
creating a fresh worktree should do the equivalent to make sure it's
considered "fresh"?

(This also dropped my timings down to normal.)

At $DAYJOB, I _think_ some version of "git restore <stuff>" ended up
also updating the index.

> I wonder if it's just a racy-git problem? Many files are written in the
> same second as the index, so they end up with the same mtimes, and we
> have to err on the side of checking the contents.
>
> See Documentation/technical/racy-git.adoc for a larger discussion.
>
> So it is not really about worktrees at all, but just "bad luck" in
> generating that initial index (that goes away next time you actually
> make an index update that rewrites the whole thing).

Ah, that makes sense! I'm familiar with the raciness but didn't expect it h=
ere.

> I'd have thought USE_NSEC was the default these days, but looks like it
> isn't? Try building with that and I'll bet it goes away entirely.

Thanks, I'll take a look.

I can see on my Macbook that at least Meson does automatically set
either USE_ST_TIMESPEC or NO_NSEC automatically, but has no option to
enabled USE_NSEC and try that. I can probably write that patch (which
I'll do to test), and I can send it along with the "worktree add
should refresh the index" if you think that's an appropriate thing to
do.

> > PS I almost CC'd Peff and Patrick, whose names stood out in "git
> > shortlog builtin/{worktree,diff}* object-file* | sort -t\( -k2 -g",
> > but decided they'd be their own best judge of whether they can
> > understand what's going on? :)
>
> You might be interested in "git shortlog -ns". :)
>
> -Peff

Phew! Yeah, that's much nicer. Thanks! (When typing this out for
email, I even left out the "grep '^[^[:space:]]' |" filter :P)

--=20
D. Ben Knoble
