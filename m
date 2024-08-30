Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3BBA3D
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060624; cv=none; b=CJAaPTkorcJdEK/rzHDSXaxBmCzuj5dPPFMbKa+uIMzrmd/dGYsME0gFANFC/5moc6Ni1wBPUJtg2ogZK/UnIZo9zTvJySoHuFfxch6fMGCJfBYent3iS8zvmXVP9x5S7LQYSmHwCS8GA9MYzhoMrCYre8D0yjSMMOMZbsZpPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060624; c=relaxed/simple;
	bh=0u2k/eVNvp25d8e9HZ+fr7vkNpOoXzbYkExYmUQ4pUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzlxZuP/bSqPdGBiRxp1ugCOuxA9ND2ahe68GfbqyKgoEL/bxdLgBZb9X5rMUbGhTow3/d1X+rs0+jtADJezJjrFPfxexvhiaEnQmQY+uFh7Ojj1m95bshvv+GvkmXfDh1BltUdAycjNvktmeVUJBYDFeU1xyUA+gVHBzzjM4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45680350696so2332431cf.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 16:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725060621; x=1725665421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM7Zi1l9whJ8ehgKkHCYBzwYZzwTicYI8ZBTfSB6QoA=;
        b=q3GjD7IXm876G1q4fPEVI7KMeK39V0xtSca4lR9tEIbDO7mfqsDl9fQgNRwil/Ui7I
         L6EiR0YJcQs4q4qsEqTCKKSwQ783H54c/TJ7hH97yv4ASGUALQLhPhk6xIHkk+jsHQ5N
         vyoySvY4psQy1S/N0A+c1fhXOhzS2jwgAH5nW5hGQJBscXrNHw2HrtURwLaPihaBmIJ4
         av+5h8SnRnrL8YuKWH/uQl64+dqAbsQqiTTTJH0cHUITnRoS4j5e304fxWwg3nPGMu+e
         YqoA3iinMxB7U+d021pFLtd7nHCD80MCmjDtWMOsPob3s5oQbkvDUcY0vAoPzxAuSSeD
         Bc4A==
X-Forwarded-Encrypted: i=1; AJvYcCXGKuB+sVcid4LCz9HCsny+ZYDthQUr2/aQ+E9PNQQ2nIacw4ggAAjij0/pZcwZHjOQ350=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfn287Kya0Aam7+WWfmSi9l+B5zGLiz2iMy7IK2Hd6uQHcM7n
	JDT1nuoI2tCvnE/HQOJGiSeaad0atzc6NT7vUbbc5nnLCHSLXuC41qf0dRM/nmaAS8t3GcSs7RF
	ejHeqe4jLWegK8Wke3YvrQX3IIoLJdt0/7aw=
X-Google-Smtp-Source: AGHT+IH8qPoeENnTdfAAxEihiIXJo2+G5Obe5ct2bOPtSuBqiwHMgjqigy3FSLoN0rLQs1UKuKSyEaRoE6nlnDDd8Vc=
X-Received: by 2002:a05:6214:c45:b0:6bf:7d51:e497 with SMTP id
 6a1803df08f44-6c3495fbf78mr23158266d6.2.1725060620974; Fri, 30 Aug 2024
 16:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-3-ericsunshine@charter.net> <xmqqv7zjwcgq.fsf@gitster.g>
In-Reply-To: <xmqqv7zjwcgq.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 30 Aug 2024 19:30:09 -0400
Message-ID: <CAPig+cSZ8Sot9oq+rmzBTmQU-Fnay92roTO=Mk0uT+-JUzMcXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:55=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <ericsunshine@charter.net> writes:
> > When chainlint detects a problem in a test definition, it highlights th=
e
> > offending code with an "?!ERR ...?!" annotation. The rather curious "?!=
"
> > delimiter was chosen to draw the reader's attention to the problem area=
.
> >
> > Later, chainlint learned to color its output when sent to a terminal.
> > Problem annotations are colored with a red background which stands out
> > well from surrounding text, thus easily draws the reader's attention. A=
s
> > such, the additional "?!" decoration became superfluous (when output is
> > colored), however the decoration was retained since it serves as a good
> > needle when using the terminal's search feature to "jump" to the next
> > problem.
> >
> > Nevertheless, the "?!" decoration is noisy and ugly and makes it
> > unnecessarily difficult for the reader to pluck the problem description
> > from the annotation. For instance, it is easier to see at a glance what
> > the problem is in:
> >     ERR missing '&&'
> > than in the noisier:
> >     ?!ERR missing '&&'?!
> > Therefore drop the "!?" decoration when output is colored (but retain i=
t
> > otherwise).
>
> Wait.  That does not qualify "Therefore".
>
> We talked about a "good needle" and then complained how ugly the
> string that was happened to be chosen as good needle is.  That is
> not enough to explain why it is justified to "lose" the needle.  The
> only thing you justified is to move away from the ugly pattern, as a
> typical "terminal's search feature" does not give us an easy way to
> "jump to the next text painted yellow".
>
> > Note that the preceding change gave all problem annotations a uniform
> > "ERR" prefix which serves as a reasonably suitable replacement needle
> > when searching in a terminal, so loss of "?!" in the output should not
> > be overly problematic.
>
> Drop this separate paragraph, promote its contents up from "Note"
> status and as a proper part of the previous sentence in its rewrite,
> something like:
>
>     Since the errors are all uniformly prefixed with "ERR", which
>     can be used as the "good needle" instead, lose the "!?"
>     decoration when output is colored.
>
> to replace "Therefore" and everything that follow.

Perhaps the following would make for a more palatable commit message?

    When chainlint detects a problem in a test definition, it
    highlights the offending code with a "?!...?!" annotation. The
    rather curious "?!" decoration was chosen to draw the reader's
    attention to the problem area and to act as a good "needle" when
    using the terminal's search feature to "jump" to the next problem.

    Later, chainlint learned to color its output when sent to a
    terminal. Problem annotations are colored with a red background
    which stands out well from surrounding text, thus easily draws the
    reader's attention. Together with the preceding change which gave
    all problem annotations a uniform "ERR" prefix, the noisy "?!"
    decoration has become superfluous as a search "needle" so omit it
    when output is colored.

> > @@ -663,7 +666,7 @@ sub check_test {
> >       $checked =3D~ s/(\s) \?!/$1?!/mg;
> >       $checked =3D~ s/\?! (\s)/?!$1/mg;
> > -     $checked =3D~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
> > +     $checked =3D~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;
>
> Hmph.  With $erropen and $errclose, I was hoping that we can shed
> the reliance on the "?!" mark even internally.

Good point. Just above the shown context:

    $checked .=3D substr($body, $start, $pos - $start) . " ?!ERR $err?! ";

unconditionally adds the "?!" decorations even when the output is
colored, and then the:

    $checked =3D~ s/\?!([^?]+)\?!/$erropen$1$errclose/mg;

removes them. It would be nice to add the "?!" decoration only when
not coloring output, however, together with the explicit space added
before and after "?!...?!" by:

    $checked .=3D substr($body, $start, $pos - $start) . " ?!ERR $err?! ";

the related:

    $checked =3D~ s/(\s) \?!/$1?!/mg;
    $checked =3D~ s/\?! (\s)/?!$1/mg;

ensure, for aesthetic reasons, that there is one, and only one, space
before and after the annotation.

It may be possible to do something like this instead (untested), but
I'm not sure it's worth the complexity:

    $checked .=3D substr($body, $start, $pos - $start);
    $checked .=3D ' ' unless $checked =3D~ /\s$/;
    $checked .=3D "$erropenERR $err$errclose";
    $checked .=3D ' ' unless $pos + 1 >=3D length($body) ||
        substr($body, $pos + 1, 1) =3D~ /\s/;

> This is especially
> true that in the early part of this sub, the problem description was
> very much structured piece of data, not something the consuming code
> need to pick out of an already formatted text like this, risking to
> get confused by the payload (i.e. the text that came from the
> problematic test script inside "substr($body, $start, $pos-$start)"
> may contain anything, including "?!", right?).

As first implemented, there was no structured "problem description".
chainlint originally just output a stream of raw parse tokens (not the
original test text), and when a problem was discovered the "?!...?!"
annotations were embedded directly in the output stream. This was
still the case even when colored output was implemented[1]; in fact,
the annotations were colored after-the-fact by searching for "?!...?!"
in the output stream. It was only when chainlint was taught to output
the original test text verbatim[2] that problem descriptions became
structured data.

I was never overly concerned about "?!" appearing as part of the
actual payload, partly because it is an unusual character sequence to
be present in shell code anyhow (indeed, it only appears in t5510),
partly because it requires "?!" to be doubled up (i.e. "?!...?!"), and
partly because this processing kicks in only when a linting problem is
actually discovered,

[1]: 7c04aa7390 (chainlint: colorize problem annotations and test
delimiters, 2022-09-13)
[2]: 73c768dae9 (chainlint: annotate original test definition rather
than token stream, 2022-11-08)
