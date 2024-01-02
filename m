Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C615AEA
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrBKGFRI"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33677fb38a3so9819838f8f.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704222142; x=1704826942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoaxULxUGSv8wKeSdFT45DFNNciKUXbvaMAzVxEKodM=;
        b=WrBKGFRI1RatYiQYIyMqIZRiZ8FgYG84XpDFHEEtVf6NahQ5P0iPQKbQB+QFqesTQ2
         o69Nursy1zzyIzY2YQ4uZ9JmyYCJC/xFxR1Az+50ijsh0fQHZrErRmgXQ6FGA8UJFj5Y
         eLC8vTK6B3dVCzmNbqmsLZSve9vS8Ly+pLd6Di/wqgnwk1txT4J18PhFLfkIMlAmnJGM
         yzEdn8m/Z/1vVnc5ZduUP2TxMvr00Vp9PLvS8Er00lcckiAVlK6htRdk5QTlT3rvOMrh
         EFRbVYRhIJNift7qHdXqaini+TT1NEr4x8AcMOjy1+NoJp4ttzr2E0vqfi0i5WSw0Hms
         vvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704222142; x=1704826942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoaxULxUGSv8wKeSdFT45DFNNciKUXbvaMAzVxEKodM=;
        b=nOnYccljCGpFF9TuYJcfR8/egu3HvTK3fPiZgrjxUYL+EvHyhwx//aDqh+zsjFHy/s
         mB6jXutypxPXbk8dIw0JzkxTeT1Nk+RxWcdRsm5oAhKY03ydsy0fsmt4vp7elmCE/W7r
         GhIz7R44/k3aIQlt2TYNvuxjWcTffBI+WHGhNv7VUImO0CdvAmmqjW5QseZYZXEC7NhW
         kHc9x32TF9ylNTDc70fkM8MfzVQLfQ/WUjocpA+G5O7L9YNcMxFrgSPjuFoHXboDsfkU
         HltGTB44dZ/DCctWe3PolxWnjgTzmCRvqF/1FuEuyitSckVkKxaVo1M4BN1qNupj/jnz
         YhiQ==
X-Gm-Message-State: AOJu0Yzm0m5T1L3o6WSfotYfGAIonaBD5M/xyfjYR83WsuP+JxT4GFMx
	rqRxmfw7ZcDZcovCLNecDjHug8eykE9Ynv7FAd8=
X-Google-Smtp-Source: AGHT+IEyqYoGlUr+lwOFcWB1chaL1Zp4LcHxmFG3o98IM3STEBJBFy8phDKIchjK4t4u7YsRFQXWoacCF9mE0vUnExQ=
X-Received: by 2002:a5d:608b:0:b0:336:9689:bc3a with SMTP id
 w11-20020a5d608b000000b003369689bc3amr8838281wrt.94.1704222142188; Tue, 02
 Jan 2024 11:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101150336.89098-1-carenas@gmail.com> <55309061-5996-4f70-8e6b-b341fc632ddf@web.de>
In-Reply-To: <55309061-5996-4f70-8e6b-b341fc632ddf@web.de>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 2 Jan 2024 11:02:10 -0800
Message-ID: <CAPUEspgbVx6wbp4UNjjxFO8iNJw3i2FnJxNwn4pk5EbaAP-7gQ@mail.gmail.com>
Subject: Re: [RFC PATCH] grep: default to posix digits with -P
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 1, 2024 at 9:18=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
> Am 01.01.24 um 16:03 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> > @@ -321,17 +327,22 @@ static void compile_pcre2_pattern(struct grep_pat=
 *p, const struct grep_opt *opt
> >               }
> >               options |=3D PCRE2_CASELESS;
> >       }
> > -     if (!opt->ignore_locale && is_utf8_locale() && !literal)
> > -             options |=3D (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID=
_UTF);
> > +     if (!opt->ignore_locale && is_utf8_locale() && !literal) {
> > +             options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> >
> > -#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
> > -     /*
> > -      * Work around a JIT bug related to invalid Unicode character han=
dling
> > -      * fixed in 10.35:
> > -      * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
> > -      */
> > -     options &=3D ~PCRE2_UCP;
> > +#ifdef GIT_PCRE2_VERSION_10_35_OR_HIGHER
> > +             /*
> > +              * Work around a JIT bug related to invalid Unicode chara=
cter handling
> > +              * fixed in 10.35:
> > +              * https://github.com/PCRE2Project/pcre2/commit/c21bd9775=
47d
> > +              */
> > +             options |=3D PCRE2_UCP;
> > +#ifdef GIT_PCRE2_VERSION_10_43_OR_HIGHER
> > +             if (!opt->perl_digit)
> > +                     xoptions |=3D (PCRE2_EXTRA_ASCII_BSD | PCRE2_EXTR=
A_ASCII_DIGIT);
> >  #endif
> > +#endif
>
> Why do we need that extra level of indentation?

I was just trying to simplify the code by including all the logic in
one single set.

The original lack of indentation that was introduced by later fixes to
the code was IMHO also misguided since the obvious "objective" as set
in the original code that added PCRE2_UCP was that it should be used
whenever UTF was also in use as shown by
acabd2048ee0ee53728100408970ab45a6dab65e.

Of course, we soon found out that the original implementation of
PCRE2_MATCH_INVALID_UTF that came with PCRE2 10.34 was buggy and so an
exception was introduced in 14b9a044798ebb3858a1f1a1377309a3d6054ac8.

Note that the problematic code is only relevant when JIT is also
enabled, but JIT is almost always enabled.

> The old code turned PCRE2_UCP on by default and turned it off for older
> versions. The new code enables PCRE2_UCP only for newer versions.  The
> result should be the same, no?  So why change that part at all?

Because it gets us a little closer to the real reason why we need to
disable UCP for anything older than 10.35, and that is that there is a
bug there that is ONLY relevant if we are using JIT.

My hope though is that with the release of 10.43 (currently in RC1),
10.34 will become irrelevant soon enough and this whole code could be
cleaned up further.

> But the comment is now off, isn't it?  The workaround was turning
> PCRE2_UCP off for older versions (because those were broken), not
> turning it on for newer versions (because it would be required by some
> unfixed regression).

The comment was never correct, because it was turning it off, because
the combination of JIT + MATCH_INVALID_UTF (which was released in
10.34) + UCP is broken.

> Do we need to nest the checks for GIT_PCRE2_VERSION_10_35_OR_HIGHER and
> GIT_PCRE2_VERSION_10_43_OR_HIGHER?  Keeping them separate would help
> keep the #ifdef parts as short as possible and maintainable
> independently.

I thought that nesting them would make it simpler to maintain, since
there are somehow connected anyway.

The additional flags that are added in PCRE 10.43 are ONLY needed and
useful on top of PCRE2_UCP, which itself only makes sense on top of
UTF.

> > @@ -27,13 +34,13 @@ do
> >       if ! test_have_prereq PERF_GREP_ENGINES_THREADS
> >       then
> >               test_perf "grep -P '$pattern'" --prereq PCRE "
> > -                     git -P grep -f pat || :
> > +                     git grep -P -f pat || :
> >               "
> >       else
> >               for threads in $GIT_PERF_GREP_THREADS
> >               do
> >                       test_perf "grep -P '$pattern' with $threads threa=
ds" --prereq PTHREADS,PCRE "
> > -                             git -c grep.threads=3D$threads -P grep -f=
 pat || :
> > +                             git -c grep.threads=3D$threads grep -P -f=
 pat || :
>
> What's going on here?  You remove the -P option of git (--no-pager) and
> add the -P option of git grep (--perl-regexp).  So this perf test never
> tested PCRE despite its name?  Seems worth a separate patch.

My original code was a dud.  This would make that at least more obvious,

> Do the performance numbers in acabd2048e (grep: correctly identify utf-8
> characters with \{b,w} in -P, 2023-01-08) still hold up in that light?

FWIW the performance numbers still hold up, but just because I did the
tests independently using hyperfine, and indeed when I did the first
version of this patch, I had a nice reproducible description that
showed how to get 20% better performance while searching the git
repository itself for something like 4 digits (as used in Copyright
dates).

My idea was to reply to my own post with instructions on how to test
this, which basically require to also compile the recently released
10.43RC1 and build against that.

Indeed, AFAIK the test would fail if built with an older version of
PCRE, but wasn't sure if making a prerequisite that hardcoded the
version in test-tool might be the best approach to prevent that,
especially with all the libification work.

Carlo

PS. your reply got lost somehow in my SPAM folder, so I apologize for
the late reply
