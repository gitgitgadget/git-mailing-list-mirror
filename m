Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A51B5A4
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480872; cv=none; b=FjklDQJ1Luj6I0+9q8/MOt+VSm2ecjyB37B0idVTVT9YFJk1iY8sDSk15h/QavOnSqcFqNKeTrAr3P7zuNLzLttxNof0mmuqeb8qkMwuQ2uHyWSJwTZoGlkY/x5Pqc3ZQZQjWtQ62cVyUjumN3C59UpMf/IskBlKfv5vRj2f0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480872; c=relaxed/simple;
	bh=BNGw10RvStCoDNqkrdiPBbiCPRcEOy8YMaSAD2ZfrA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLfF+yLPEmdUx3/GTjTtYT2mtDVRpOVWz8d69qN38nQCB/oJudHw/uXZ/bK8ml/F2jG/1a32vtoYXGOu+xPfnpWwCR0hyYvqXG07U+JKKI1WXG+WTT6i/fi6owDhM6nBHIhQ2HzC2vJhxu4+X2U9+G03NPlloDprvAjL11obi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69932305c09so18038846d6.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 02:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480869; x=1713085669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9GDJr94auucfebEjt2U8jWqhQ2xDdzYNDgWxBz03jI=;
        b=Jc7AZmVUj8UjhDLqO+eF65j7X0yrqNIqiFa5DI1SkZH0DaPp4FZlYfHjVsRTceKPyW
         yVDwEefNbtb5NHVOfv+Yzv+rJDxbcnS6EnYV3qHHy0HO2dfLLXejKt7bCcn4POgr92dH
         5wuaNRAaZv2Zi/K12BE5rsnf4t86JNZsrpw+/3Qe+r4bfMCa342gYOhK48KizNAnmTHI
         OAuAZ3F+/b0CrTf5z4PGEVfMdZ4X7ekrBYTA4pqo+aMPAt77bMfUhsRusnkK6uLk24Uz
         ijHPeyk5eyYfB7slLsOeOZP8GUsH4+RqpjGL+3jCiR2hVpGHwv3DLYA2DzLNRfquPAj1
         pxSA==
X-Gm-Message-State: AOJu0Yw88dFUuMwsF0DIl8Fs+/5T+FKqO4ENyRKLXvBWfmEbb1ola+rr
	RpAUz6T/6dwTSnCZ72N25ChLC1kM+LyJR0Gi1uiZtMCxL2gkIiqcaEmu/vpwZbYgVIspFd3og3s
	BKHu+pgrnJj27i0+fvd/vVUiUSCiFGHoYDZw=
X-Google-Smtp-Source: AGHT+IGI+obJ4pMbb7NLo7L+5J5+wps06XSeeL5upH/a94ylMHEUBHenCQzR0F87hXcH912b1qfnWD+0CFoEIFgRFyw=
X-Received: by 2002:a05:6214:2385:b0:699:148c:b600 with SMTP id
 fw5-20020a056214238500b00699148cb600mr6096385qvb.22.1712480869181; Sun, 07
 Apr 2024 02:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <20240407051031.6018-2-leduyquang753@gmail.com> <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
 <CACXAH50jwngEQLF612FMyZ36yB5Nd7vVHS98KMWYjXqcNzvpwg@mail.gmail.com>
In-Reply-To: <CACXAH50jwngEQLF612FMyZ36yB5Nd7vVHS98KMWYjXqcNzvpwg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Apr 2024 05:07:37 -0400
Message-ID: <CAPig+cSD7ONA-MUt=dxt5nh2FQ1nJjbcdDb0ko0j0sBrr0reqg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
To: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 3:04=E2=80=AFAM Quang L=C3=AA Duy <leduyquang753@gma=
il.com> wrote:
> On Sun, Apr 7, 2024 at 12:47=E2=80=AFPM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > > +       return graph->connected_region_state =3D=3D CONNECTED_REGION_=
NEW_REGION || (graph->num_parents >=3D 3 &&
> > > +       graph->connected_region_state =3D (graph->connected_region_st=
ate !=3D CONNECTED_REGION_FIRST_COMMIT &&
> > > +               graph->num_new_columns =3D=3D 0) ? CONNECTED_REGION_N=
EW_REGION : CONNECTED_REGION_USE_CURRENT;
> >
> > Style: overly long lines
>
> May I ask how am I expected to place the line breaks? The Linux kernel st=
yle
> guide I consulted
> (https://www.kernel.org/doc/html/v4.10/process/coding-style.html) doesn't=
 seem
> to go into too much detail on this.

I don't have a precise answer other than "use good taste". One
reasonably solid rule is that when wrapping at `&&` and `||`, those
operators should appear at the end of the line rather than the
beginning of the next line. So, a possible wrapping for these two
cases might be:

    return graph->connected_region_state =3D=3D CONNECTED_REGION_NEW_REGION=
 ||
        (graph->num_parents >=3D 3 &&
        graph->commit_index < (graph->num_columns - 1) &&
        graph->expansion_row < graph_num_expansion_rows(graph));

    graph->connected_region_state =3D
        (graph->connected_region_state !=3D CONNECTED_REGION_FIRST_COMMIT &=
&
        graph->num_new_columns =3D=3D 0) ?
        CONNECTED_REGION_NEW_REGION : CONNECTED_REGION_USE_CURRENT;

Since this enum is private to the C file and not part of an expressive
public API, another possibility for reducing the line length is to
shorten some of the names. For instance:

    enum connected_region_state {
        CONNREG_FIRST_COMMIT,
        CONNREG_USE_CURRENT,
        CONNREG_NEW_REGION
    };

> > > +static void graph_output_separator_line(struct git_graph *graph, str=
uct graph_line *line)
> > > +{
> > > +       /*
> > > +        * This function adds a row that separates two disconnected g=
raphs,
> > > +        * as the appearance of multiple separate commits on top of e=
ach other
> > > +        * may cause a misunderstanding that they belong to a timelin=
e.
> > > +        */
> >
> > This comment seems to explain the purpose of the function itself. As
> > such, it should precede the function definition rather than being
> > embedded within it.
>
> I just followed what the surrounding code did (particularly in the origin=
al
> `graph_output_pre_commit_line` function), but on second look that functio=
nality
> comment seems to only serve as context for the sentence below that so OK.

Indeed, looking at graph_output_pre_commit_line(), the comment seems
to be explaining the reason for the assert() in that function, whereas
the comment you wrote here seems to be explaining the purpose of the
function itself.

> > > +       assert(graph->connected_region_state =3D=3D CONNECTED_REGION_=
NEW_REGION);
> >
> > We tend to use BUG() rather than assert():
>
> Same thing, I just followed that `graph_output_pre_commit_line` did. So I=
 should
> forgo the consistency here? Or is that usage of `assert` in the existing =
code
> also to be updated?

I see what you mean, now that I'm looking at graph.c. Since assert()
is used so heavily in this file already (and there are no BUG()
invocations at all), it probably makes sense to be consistent and use
assert() here, as well. Adding a sentence to the commit message
explaining that you're using assert() for consistency rather than
BUG() will be helpful to reviewers.

While it might be a nice cleanup to eventually swap out assert() in
favor of BUG(), we should leave that for another day in order to keep
this patch well-focused. (We don't want to add a bunch of "while at
it, let's also change this" items, thus losing focus on what you
actually want to achieve.)

> > > +       /*
> > > +        * Output the row.
> > > +        */
> > > +       graph_line_addstr(line, "---");
> >
> > The code itself is obvious enough without the comment, so the comment
> > is mere noise, thus should be dropped.
>
> Also same thing that I followed for consistency.

Understandable. In this case, I don't personally feel that this
comment is adding any value, thus would drop it, but others (including
yourself) may feel differently.

> > Modern test style is to perform all actions inside the
> > test_expect_success body itself, so:
> >
> >     test_expect_success 'all commits' '
> >         cat >expect <<-\EOF
> >         ...
> >         EOF
> >         test_cmp_graph a b c d e
> >     '
> >
> > Note the use of <<- to allow you to indent the here-doc body.
>
> This is also because I followed what `t4202-log.sh` did, but if that repr=
esents
> outdated practice then I'll change.

Understood.

Generally speaking, when adding new tests, we do want to follow modern
practice; that's especially true when creating a brand new test
script, but even when adding new tests to an existing script.

If you're modifying an existing test, then being consistent with the
surrounding code is a good idea. Consistency may also be reasonable
sometimes when inserting a new test into a block of existing
closely-related tests. Saying so in the commit message will help
reviewers understand.
