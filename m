Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24D1D5ABA
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912690; cv=none; b=i6PcBCESS4OHyYVCqhVbW91DWcXag7anOtZtX3/yxGLW8I66CO266Fmx6JAcgL/JiVbZB8l380jwCOi07yKuYfwR4186VIQcV4VB6Fgfhuvj9Q8OK3LKYeYyo3e71lyrzVEXmrp6eDvEjZ9nX+T+tOXj5abWKbALfI2RyVSn4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912690; c=relaxed/simple;
	bh=c+LDf0292/IWj/QULWNZDPVRf7+5qzb7UXOZhcz/weo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=moZckShc152KemRk3zKRCqXViDoawrIFX7mmJO2sZmmoGkogGRoktjLk831W3TnyD9QyV0ijE2wA7RL9PzYGqm6ZLi0IvRjIJfQgYIPEnD/qXOVq1XhaIPpCKznAx3+NcF/SKMqh40m2ieWPj4gFJD/9liS0Z6FWDvZD0Fd+aZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5rvXv0x; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5rvXv0x"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b457d93c155so1239337066b.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759912686; x=1760517486; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhOVLzFWPeIGSQ18Dgg6JqjhTi7zjzLkU6+GmIGHsg0=;
        b=X5rvXv0xFPjh0uv+VYUvBRywXxuCIwGbYrSkI1vCbSf1SjJo5cs7SXCkMPeNpeaxfb
         LEY5tMcOnHsSSrU4ydGUFyRop6FdNhkgrm4dmtVTDhT/1ModyxgFUob9Q1mmlhQHy8iG
         kIGYiNLPYTKa5EgUCFVs8/gUokq/VTAYIpx8nIASXDIC6K0lfCrIUNl1xanOFPN+AsGU
         0Q2ddK1WMwM83g7uQI3d1Z1N9lGUWf49BnewJ10ULQ7YUf+E+sowJGBCW8C7+3fagYe5
         J8R53GoZFuhbh+ZTrrOgomCZN8h2c7PfKxdSvUfrp/SMctSvfTgFciQWeSt0H1Dyu2E0
         CKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912686; x=1760517486;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhOVLzFWPeIGSQ18Dgg6JqjhTi7zjzLkU6+GmIGHsg0=;
        b=ECM5FpVL+OVJX7QjVBOu5TU0RQ8mX1szysymqaW85plIu+WZZzabIbcSPX7j8XDJlJ
         297PRezQDMBQBSkUx/+KQu1h4bfUhYo1EofiIKr6TZNymx91kOLKMJEiVOb2uTE/7SKz
         vsI5WVXDmh/+kRC/IiR961P0VVpWBqc+fECVHSqQX4xzICE7mvB1AR9kyVs8+03LF9oq
         qrcC5h11FslmDrEStY2i7rk5A4guDgg9Y9LJjhJXv1pORupdacw8UEYHr1TorVSnJzpd
         Bq8Bjs2jxECJGaX++Xuy3vwGmV1CXTeeGq7GphGwLM3/aXxu9LHrls1+2iohGUWD+lX0
         phwA==
X-Forwarded-Encrypted: i=1; AJvYcCUQP7z9uKqY9oCQSp1I5RG5xwfrKcrSNdXdF8/Km03LN3xc9BLFTnRtdYcN0lGfD1jHxiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjNltreAPXnxKfdlwyhycZTf6RoUHZaZRNFF3HJHHG3sGxB1C
	ErxK/KQA9pnroWaV65B3vA5NRi/x4aKkBOttzT2IXwjAittKskDFptvGFKJYLSsT6+QHFyHCSWz
	bHgm2xvOWZc2wNexztmfKyWQjlrNGC6g=
X-Gm-Gg: ASbGncv7MXoY7KzszEiH1zbpERkti3d2vI3W5Oa/Xg4X6xV0GAZOvuof8zCqpbOSdgA
	XqywOsSt2M0qpyU7VXKtp/0E/jjG+DhKDiMWLnrHi57Wvl5bgRIi0L26ziyQWC9snhR8FFfmTCr
	+wg9l0zj94GCvH9fXJhcdBANSGWBaCF3hox2/zJseZKzBLF7u7oldzy7Fy1pGe9wGcwPSX1v+6M
	+2ZT1XQnytQAAE+idWTYQ5EaOqt2N4=
X-Google-Smtp-Source: AGHT+IFxPgBW9f+F4FzDvwtwEWO+HoMK6G6uPnW39yXseIL60GzPh9ozEH2d0Uttwwm7wsucxseuqUgNKRscVmGh5Ys=
X-Received: by 2002:a17:907:86a6:b0:b41:27ca:6701 with SMTP id
 a640c23a62f3a-b50aa7a0d0cmr281935766b.24.1759912686156; Wed, 08 Oct 2025
 01:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net> <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
 <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
In-Reply-To: <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 10:37:53 +0200
X-Gm-Features: AS18NWCW_hdVEG0qn_oB6GV-A_FU_XM4rgT1NtZ3Rl9RlsCyoMaseL-LycKzoxo
Message-ID: <CAP8UFD34TrBa-GV1wUpvhO9K+qjHpXF4gr=afY2nsXiNL_-S+Q@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 12:20=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-10-03 at 20:48:40, Elijah Newren wrote:
> > Would this mean that you wanted to ban contributions like d12166d3c8bb
> > (Merge branch 'en/docfixes', 2023-10-23), available on the list over
> > at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@gm=
ail.com/
> > ?   We don't need to go theoretical, I've already contributed such a
> > patch series before -- 2 years ago -- and it was merged.  Granted,
> > that was entirely documentation, and I called out the usage of AI in
> > the cover letter, and I manually checked every change (discarding many
> > of them) and split it into commits on my own, could easily explain any
> > change and why it was good, etc.  And I was upfront about all of it.
>
> I think the main problem here is that we don't know the copyright
> status of LLM outputs.

It's very unlikely that whatever is decided about the copyright status
of LLM outputs will fundamentally change copyright law. So for example
small changes, or changes where a human has been involved a lot, or
changes that are very specific, and so on, are very likely acceptable.

> It is not uncommon for them to produce output
> that reflects their training input and we see evidence of that in, for
> instance, the New York Times lawsuit against OpenAI.

You might say something very similar about people contributing proprietary =
code:

"It is not uncommon to have people copy-paste some proprietary code
into an open source project and we see evidence of that in such and
such incidents."

So it's just fine to accept some degree of risk. We have to accept it
anyway. Saying "we will ban everything AI generated" will not make the
risk disappear either.

> As I said, the situation is very unclear legally, with active litigation
> in multiple countries, and we have to comply with pretty much every
> country's laws in this situation.  Whether something is legal in the
> United States, where you're located, is completely irrelevant to whether
> it is legal in Canada, where I'm located, or Germany or the UK, where we
> have other contributors.  We also have to consider whether it's legal in
> all of the countries that Git is distributed in, which includes every
> country in which Debian has a mirror[0], even countries under
> international sanctions, such as Iran, Russia, and Belarus.

I don't quite agree with this. Theoretically if the official mirrors
are only in a few countries, then only the laws in these few countries
(+ US law as the Conservancy is US based) might be really legally
relevant for the project. Then it's the responsibility of
distributions or people cloning/downloading the software to check that
it's legal in the countries they distribute or clone/download it.

In practice we should pay attention a bit to make sure we don't create
obvious legal problems for too many people, but if some countries
decide to have laws that are too stupid and ban too many things, we
could decide that we should definitely not pay attention to those
laws.

> It doesn't matter if the person using AI has indemnification, either,
> since that only covers civil matters, and at least in the U.S. and
> Canada, knowingly violating copyright is also a criminal offence.
>
> The sign-off process is designed to clearly state that a person has the
> ability to contribute code under the license and I don't think, as
> things stand, it's possible to make that assertion with code or
> documentation generated from an LLM except in very limited
> circumstances.

I think in practice those "very limited circumstances" can cover a lot
of different things though. Do we really want to enter into a legal
debate over what
https://en.wikipedia.org/wiki/Sc%C3%A8nes_%C3%A0_faire means for
software for example? Or about allowing or disallowing translation of
documentation or commit messages based on the fact that the tools used
for translation use an LLM or not?

I have given a lot of examples of what is very likely acceptable.
Elijah has given a very good concrete example showing why we should
not outright ban AI too. If you think they are not good examples
please tell it clearly. Otherwise I think you cannot keep saying that
they are related to "very limited circumstances".

> I don't allow LLM-generated code in my personal projects
> that require sign-off for that reason, and neither does QEMU[1].  I
> don't think I could honestly assert either (a) or (b) in the DCO with
> LLM-generated code because it's not clear to me whether "I have the
> right to submit it under the=E2=80=A6license."
>
> To quote the QEMU policy:
>
>   To satisfy the DCO, the patch contributor has to fully understand the
>   copyright and license status of content they are contributing to QEMU. =
With AI
>   content generators, the copyright and license status of the output is
>   ill-defined with no generally accepted, settled legal foundation.
>
>   Where the training material is known, it is common for it to include la=
rge
>   volumes of material under restrictive licensing/copyright terms. Even w=
here
>   the training material is all known to be under open source licenses, it=
 is
>   likely to be under a variety of terms, not all of which will be compati=
ble
>   with QEMU's licensing requirements.

The QEMU policy was discussed in the previous version already.

> I remember the SCO situation with Linux and how it really created a lot
> of uncertainty with Linux because SCO created FUD around Linux licensing
> and how that led to the DCO being created.  I am aware of the fact that
> many open source contributors are very unhappy that their code has been
> used to train LLMs without retaining credits and copyright notices or
> honouring the license terms[2].

I don't think it's very relevant for your position on this. On the
contrary, if LLMs have been trained mostly with open source code, then
if they produce copyrighted output, that output is more likely to be
compatible with the GPL. It has even been suggested (and discussed in
this thread) that some AIs should be trained only with open source
material (for example MIT licensed material?) so that we could stop
worrying about including it. If that happens, there would be no reason
to outright ban AI generated content, right?

> And I have spent many years working
> with non-profits[3], where I have always been taught that we should
> avoid even the appearance of impropriety.

Adding a section restricting AI use, even if it doesn't go as far as
you would like, is already a first step in the direction you want. If
this gets merged, you can always send patches on top to make it more
restrictive.

> It may matter less what the situation actually ends up being legally
> (although it could end up being quite bad) and more whether someone can
> imply or suggest that Git is not being distributed in compliance with
> the license or contains infringing code, which could effectively make it
> undistributable because nobody wants to take that risk.  And litigation,
> even if Git and its contributors are successful, can be extraordinarily
> expensive.

There are already legal risks anyway (see above).
