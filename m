Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F61372EC1
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792624; cv=pass; b=TEgG/Dts/7nkZJsXe58lZ9LX7iv0R8r3M4LJq8lVwNxMM9kZtHyCtSIKt9Mg2qI1sj64EEYBeDqv1RohdNhYn7bsLLW3lAUNfgOX77RPRTSVYyKmNwD2o1ilmy5noiU805XdgHWqeNlRADLuTcG4Ljc79OhpEYAPQFtJtxHsJJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792624; c=relaxed/simple;
	bh=WwTumreNxnLjK9IZYZRncierTX76uJW9oNTcuJlNtA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQv+kgj3uzrpt37mgLCq3CIMXVW95NDWfphvqHdzt+hrJDkjmBK2RUxXgv2cxtfDZmdu3QqKTxX7BbI9u3c1NYlCGhVOQNG/I2a7SJmsmCBvATATlOvvfBeVjNGf2PIRtc7mCwGtUp9iG+YDaTOchzkPnKldLFvMb1Rpmt0DVj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwZ7iY7Y; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwZ7iY7Y"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dd7070699eso1241112eaf.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 01:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791792622; cv=none;
        d=google.com; s=arc-20260327;
        b=KkRO9fVKx1Z9cYhYEYBkQwzaX7BThW7CCPx3b/vXNCWPi9ScuO7xQyPuNUdY6dsY9f
         +aLG/bpwt+RSvulVAxR+BtoITaRF0LD1y0xymP1lfofKcit6xHNq09yv0Ko4vztir++J
         ggC8ClNFRPHZPPcgzOlrHDrLUxbtJH6Dh/J1SdCieQWNJkQTUxD51inph11WPXYX5+0m
         p8/uHaSNNRIN/zZ+cVqA+LYUkXtJsrrKGDpAWLPv4yaloEQhako2kNIyyY5wMOJElOVx
         vzV7XeR3AuAYgH8J8HUPzRL9b3LAScsyzlTInVdzoWF8ah7dOBGvO0rx54E9VJnqvSpH
         behg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwE7ECaHYPIz1HdTLd4eNWSoedlEKn6mspx4g7wnmUo=;
        fh=AkwqM3nf6GiSuNMkyvTMJn2XhHysb/LIuV09ali4XeU=;
        b=WBJj3QO+RBb1nETXDLWxpMbrmgh4muRWu/zIEkMb9gGgJQaFWEWukkyt+dFsBde6wR
         tiwg8Tit39pwf5SV0d7OaGDRPNFJMHcZGblZTZ+nuks2ONoS2wtSc9aam7n1TXsYu3BI
         tzH0DRlG34jxa6VQBNlIhyVSvmEH+aswBSnD3IQvuv+hBVVRpoxDzQf8bwSnvCsvdsXJ
         Qmxp+qPVMjhNpY0jN2P6fs2jnu7GykAPp+RsF4S6ljtL9SDBhg2IuKUkOh6jvdu971/t
         o6n3BwrA6XiHF6/D6AK3aurMQplM4AK278AULgdpWCbwr/3Qb2LzVDsZu3IhK2U30gBv
         f77g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792622; x=1792397422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kwE7ECaHYPIz1HdTLd4eNWSoedlEKn6mspx4g7wnmUo=;
        b=PwZ7iY7YFqpVjru1EaIO+exzmSTHyjn4KG0ovqIalFQiwvJoMkJdz+3hch2X6EyMtz
         G9QETZBjkqNr+pD+nT3i8h4ifvuDUQ/typiqp392oVv1Etb+/DZM8AJOiS6VHrbGcBDG
         sGayixrxaD6Us+PFs5FcLw83MFkTHyMvVeYIePgmIDCFTzkh6cXy9Z+XSQ9/ir09txKt
         gzAZxi0JsFWLOxIC5oS8sg5HAiBvoDw3hqCLi7spugR44ix1r+DJdoYVsveiwZJDoFUM
         7srjxlkJAT3zTMf6HHObDQkm4pEfchYcHKRT2P8tWi1TIKQgozvLN2YMGxW/jN+EhRre
         m56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792622; x=1792397422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kwE7ECaHYPIz1HdTLd4eNWSoedlEKn6mspx4g7wnmUo=;
        b=PquZzW19PMwGnYsmohZ5fa1VXOtZKht1wyFUtq9pNCtXG319UYeNa+mQtBI/RLckcz
         0ijUMgpkfViGZgXRJWtle0bSGZrZwNR6Txm74wETNr/G+kocb/y4N99iJsE2xptctSIs
         LEskpb1Re616pMvtWxvoGusfu0RocVFGNPtupGrI2SaEoNQSBVGdm8JpdhACZRnLW55K
         w2MPxl1+FGMxbQtEL26CTmg9fDkWkLD+F6iFZgcHbvXGOU57pfdgPKjY30gLDgzMbDo1
         l7xhii+TA3qsE58zF5qZmV7rw8PWcynrR5vwHImh5HBxVAyNPZXX0QZ4dVkwVdVcdjLG
         0wVQ==
X-Gm-Message-State: AFq9FYLTRN/9FNsXFedD2e1zAlb19yOh37oqY4YbkImDd7cy2r+FYuBh
	jPFIXJOOQAkfIWCI/ij6EyMIm93IiICifBdqNozRwZcW1q/ilh8pw8rMYcWzDEe75CkGMfCqPEf
	LySPBqlgnebeNLmpTYVZH2UMVl8LFRLY=
X-Gm-Gg: AYBFou1LyJbBwuR3XIJqbaHIL5kAURwj4GG6hY2nQfg/im8gL0d4xpH+kcIlafXzXkT
	SBU1wyklgXA/cdN0nixqqxnvcAY+nJW4ZP9JfiIIbrHE7BGYvIxtIbjxsSzNNfM2XAQ42kMCUyj
	oeTWMzePjmFwm5+mnsWvWCnrapT6EeDb5x6+H4HlxfaFgpHt0XYnFjJo2FYXDs4bzqfymLgim57
	VzbGatDOorLC+gPeR89LApux+79H2vKMiu+FDIDq5vlPfVRL435Og3vFLHyq+8BjPOMCDHHKNmH
	UjPJRgKc9DW4GMCNtR8F9uqFTo9O4vJpMfzwOi7J0JdEt343L1rEso0VPxQ98vjIqVmP1cNpojf
	zF3sxa6nv7g8NZLi6pO58NNUXBEGAf3MPMVNxR+jzXZ95WsUhw1iUkYe1SFoPpxmDjHsZSBjriW
	RYUKibAjZ8drWpUBffx+GPiUiJd6+4YcevB3X3sU3nu4mcLOR6Zw==
X-Received: by 2002:a05:6820:7098:20b0:6f5:f71c:1acf with SMTP id
 006d021491bc7-6f5f71c1d5emr1186749eaf.58.1791792621826; Mon, 12 Oct 2026
 01:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902161047.476753-1-christian.couder@gmail.com>
 <20260923080928.1534413-1-christian.couder@gmail.com> <20260923080928.1534413-3-christian.couder@gmail.com>
 <84f9d1c9-30b7-4d8b-82d6-9afd16d0ab08@gmail.com>
In-Reply-To: <84f9d1c9-30b7-4d8b-82d6-9afd16d0ab08@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 12 Oct 2026 10:10:08 +0200
X-Gm-Features: AclHuK9Aguckw75fPajVMbAd2degmtYzQFxZmOtO7RhKsZ-TqeCYD2IFhUG9tEY
Message-ID: <CAP8UFD36NaMvQy_nsWDMZRjN5wfEkgKE9j6GvzzfHQHLLF77DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] parse-options: add early_scan_options()
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:13=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 9/23/26 13:39, Christian Couder wrote:
> >
>  > [ snip ]
>  >
> > One consequence of staying simple is that abbreviated options are
> > still not matched, even though the scan is now given the command's
> > full option array. Resolving them the way parse_options() does would
> > mean duplicating the ambiguity detection that parse_long_opt()
> > performs. So the scan can fail to see an option that parse_options()
> > would accept, and its callers have to cope with that, typically by
> > erring on the safe side. This and the other differences with
> > parse_options() are documented in "parse-options.h".
> >
>
> I think not handling abbreviations could also have another potential
> problem. Consider a command as follows:
>
>   $ git fast-import --quiet --export-pack --allow-unsafe-features
>
> Here `--export-pack` is an abbreviation of `--export-pack-edges`. So,
> the arg next to it should ideally be considered as a value for it but
> given the correct "ignore" logic, we will happily interpret is an
> argument which misaligns with parse_options()'s behaviour.

Right, thanks for pointing this out. In the v3 I have just sent,
abbreviations are handled properly, using the same code that
parse_options() uses.

> In the ideal world, we could say such weird names for files is unlikely
> and this isn't such a big concern. But given it is the scope of this
> series to make early scan more reliable, I think we should consider how
> to handle this better.
>
> Would it make sense to actually err on the safe side and just stop
> walking the args as soon as we notice an unrecognized argument? This
> will the ensure the walk never misinterpret a value for an argument.

This is another improvement in v3. We err on the safe side and just
stop the early scan as soon as something is not recognized. Thanks for
this suggestion too.

> > diff --git a/parse-options.c b/parse-options.c
> > index a132c1ea12..559dad9061 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> >
>  > [ snip ]
>  >
> > +int early_scan_options(int argc, const char **argv,
> > +                    const struct option *option,
> > +                    enum early_scan_flags flags,
> > +                    early_scan_fn *fn, void *data)
> > +{
> > +     for (int i =3D 0; i < argc; i++) {
> > +             const char *arg =3D argv[i];
> > +             const char *value;
> > +             const struct option *opt;
> > +             int pos =3D i;
> > +
> > +             /*
> > +              * parse_options() always stops parsing options at these,
> > +              * whatever its flags, so nothing after them is an option=
.
> > +              */
> > +             if (!strcmp(arg, "--") || !strcmp(arg, "--end-of-options"=
))
> > +                     return i;
> > +
> > +             opt =3D find_early_scan_option(arg, option, &value);
> > +             if (!opt) {
> > +                     if ((flags & EARLY_SCAN_STOP_AT_NON_OPTION) &&
> > +                         (*arg !=3D '-' || !arg[1]))
> > +                             return i;
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * When an option takes a value, but that value is not
> > +              * stuck to it with '=3D', then the next argument is the
> > +              * value and it has to be skipped so that it isn't
> > +              * taken for an option itself.
> > +              */
> > +             if (parse_options_takes_argument(opt) && !value && i + 1 =
< argc)
> > +                     value =3D argv[++i];
> > +
>
> The 'i +1 < argc' part is an appropriate guard to have. But this means a
> command such as the following:
>
>    test-tool early-scan-options --wanted-value
>
> ... would reult in 'value' being NULL. I suppose this is kind of
> expected for the early scan code and is not something we need to worry
> about?

You were right to ask because it was actually worth worrying about a
bit. The early scan reported an option that parse_options() would
reject.

But now in v3, the scan stops at such an option instead of reporting
it, except when an option with PARSE_OPT_LASTARG_DEFAULT is the last
argument. In that special case, parse_options() uses the option's
default value, so the scan similarly still reports the option, with a
NULL value meaning "the default". Both cases are documented in
"parse-options.h" and tested.

> > +             if (opt->flags & PARSE_OPT_EARLY && fn(opt, value, pos, d=
ata))
> > +                     return i;
> > +     }
> > +
> > +     return argc;
> > +}
> > +
> >   static int usage_argh(const struct option *opts, FILE *outfile)
> >   {
> >       const char *s;
> > diff --git a/parse-options.h b/parse-options.h
> > index f29e73f85c..3ef64744a4 100644
> > --- a/parse-options.h
> > +++ b/parse-options.h
>  >
> > [ snip ]
> >
> > +/*
> > + * Scan `argv` for the options described by `option`, calling `fn` for
> > + * each of those that have PARSE_OPT_EARLY set. `argv` is not
> > + * modified.
> > + *
> > + * `fn` may be NULL when no option has PARSE_OPT_EARLY set, which is
> > + * useful to only find out where the scan stops.
> > + *
> > + * The scan always stops at "--" and at "--end-of-options", as
> > + * parse_options() always stops parsing options there too, whatever it=
s
> > + * flags. PARSE_OPT_KEEP_DASHDASH and PARSE_OPT_KEEP_UNKNOWN_OPT only
> > + * decide if the terminator is left in argv, not if it terminates.
> > + *
> > + * Returns the index at which the scan stopped, which is `argc` when t=
he
> > + * whole array was scanned.
> > + *
>
> As for the return index, when the callback stops the scan the index
> returned is that of the option's value rather than the option itself.
> Would it be better to capture this more clearly?
>
> Also, would it be helpful to also have a test for this?

Right. The index returned in that case was the index of the last
argument consumed, while in all the other cases it was the index of
the first argument not consumed (the "--", the non-option, etc), which
was not consistent.

In v3, early_scan_options() always returns the index of the first
argument not consumed by the scan. So if it found an option it was
looking for, this is the index of the next argument after the option
and its value if any.

A "--stop-at-found" option has been added to the test helper to test
this. Thanks.

> > + * This scan is for now deliberately much simpler than
> > + * parse_options(), so it differs from it in the following ways:
> > + *
> > + *  - Only the long form of an option is matched, and it has to be
> > + *    spelled in full: short options and abbreviations are ignored.
> > + *
> > + *  - Negated forms ("--no-<name>") are not matched. This is harmless,
> > + *    as they never take a value to skip.
> > + *
> > + *  - Options with PARSE_OPT_OPTARG or PARSE_OPT_LASTARG_DEFAULT are
> > + *    treated as not taking a separate value.
> > + *
> > + *  - OPTION_SUBCOMMAND entries are skipped.
> > + *
> > + *  - OPTION_ALIAS entries are not resolved to the option they stand
> > + *    for.
> > + *
> > + * So the scan can fail to see an option that parse_options() would
> > + * accept, and callers have to cope with that, typically by erring on
> > + * the safe side.
> > + */
> > +int early_scan_options(int argc, const char **argv,
> > +                    const struct option *option,
> > +                    enum early_scan_flags flags,
> > +                    early_scan_fn *fn, void *data);
>  >
> > [ snip ]>
> > diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> > index 449fff4d34..b796d96b9a 100755
> >
>  > [ snip ]> +
> > +test_expect_success 'early_scan_options() takes values from struct opt=
ion' '
> > +     test-tool early-scan-options --number --wanted >actual &&
> > +     cat >expect <<-\EOF &&
> > +     stopped at: 2 of 2
> > +     EOF
> > +     test_cmp expect actual &&
> > +     test-tool early-scan-options --number=3D5 --wanted >actual &&
> > +     cat >expect <<-\EOF &&
> > +     found: wanted at 1
> > +     stopped at: 2 of 2
> > +     EOF
> > +     test_cmp expect actual
> > +'
>
> Compared to others, I'm not quite sure this test is testing something
> special. Do we need it?

No. It was a leftover from v1.

The `--number --wanted` test was still interesting to check that the
value of an OPTION_INTEGER option is skipped, so it was moved into the
"skips the value of other options" test, and this one was removed.

> > +test_expect_success 'early_scan_options() does not skip an optional va=
lue' '
> > +     test-tool early-scan-options --optarg --wanted >actual &&
> > +     cat >expect <<-\EOF &&
> > +     found: wanted at 1
> > +     stopped at: 2 of 2
> > +     EOF
> > +     test_cmp expect actual &&
> > +     test-tool early-scan-options --lastarg --wanted >actual &&
> > +     cat >expect <<-\EOF &&
> > +     found: wanted at 1
> > +     stopped at: 2 of 2
> > +     EOF
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'early_scan_options() matches a stuck optional val=
ue' '
> > +     test-tool early-scan-options --early-optarg=3Done >actual &&
> > +     cat >expect <<-\EOF &&
> > +     found: early-optarg at 0 value: one
> > +     stopped at: 1 of 1
> > +     EOF
> > +     test_cmp expect actual &&
> > +     test-tool early-scan-options --early-lastarg=3Dtwo >actual &&
> > +     cat >expect <<-\EOF &&
> > +     found: early-lastarg at 0 value: two
> > +     stopped at: 1 of 1
> > +     EOF
> > +     test_cmp expect actual
> > +'
>
> Would the following be a useful part to also add to the above?
>
>           test-tool early-scan-options --optarg=3D5 --wanted >actual &&
>           cat >expect <<-\EOF &&
>           found: wanted at 1
>           stopped at: 2 of 2
>           EOF
>           test_cmp expect actual

Yes, thanks. I added it to the "does not skip an optional value" test.
