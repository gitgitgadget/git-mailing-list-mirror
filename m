Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B63264A97
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150099; cv=pass; b=q2OyIR6lUIGBWDKkwQsvFpjfDSGUmhhFK0DaWHoS3ybdKBFQahRCMG8Gpdu2dnp9mVmg3YJvC/Rjj0VpTYWLGuzIoiObCQnX2/GDRID4cW1KEYWOGnZz9QX3D60saVMIZ/ZljVh40ouxmd5ab3ODKkUqrzMHrEpHMg1svrIa1vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150099; c=relaxed/simple;
	bh=GZAe3BcxqEPHySTLUdIQ62ATp0lZE6sVMwsXjiXrxWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6oM7leu8Yy/pbD6kQZwC+WhvnxgpFhcNBsM7RTQhEeiBcBSDMtUW8sSGGgQzG32od2zwW8QpapP4cnu2+g8/5ErQs5UnaTEKNGnr5JHP2m9f9gfoldHDPHlY0TRuLEqvm+VQUAC8s5JnfDo2kNNfKzWU5GMb1ZBuMdsXEx1Kow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7M2tgJ7; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7M2tgJ7"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3997a6196c5so31240171fa.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782150096; cv=none;
        d=google.com; s=arc-20240605;
        b=e4Uxa5L/tPNHESONqWsBJgL//1lnW74O7xqA3+cwIPR4+IeFOSj2RUfIP/FFMq3xU5
         /+LfuThUXN9PEe2Sg8MhEC8ZQxaFHx/pRXMsc4ybqmDH8mha2wp7a8ycFYp+XDrEiJ94
         N0xDNmYTOJzdkrePNkOFcWUsG4hcwoVJDiKmXkcuw7wIbC1tCrC4CbH5bhfv9rKW5SEe
         LyzUOjgvVlIbltxwtLXLbx4+CgZhWnqhk5ThYNM7q2063pPudzikmsQCsRAnrPvdKNY7
         Ee+wM9OwFeUkY87v6sjSbxWf8lovWVcucj9XebzYlXiXjKuXD0YZe0L/LD2vraiPnNdV
         A8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0V4Nli64cruP20EMYA+JTCWwlIWP+yDHzBDBWC8SBM=;
        fh=ABDus/bVxnrSX1FmS0+sMLvUJT4JUdpD0ZMktwB+82Q=;
        b=ll/8rmyg5HhZwCLd5nrbX40PSdOurAnTvngCd1S4vUF+xiQ3En5Km9qt9e8WgfSLR8
         4MDV5eXlq4IYkDSA/ytap0OTpbAp3172MM1Z+Qm53Ht7EtzccUuQK37VJFZe1BEWYXWp
         yl1YlK1WPooOTFyjmTXa2oefr6nawSNpg0nluRqGPw1PEihFQLsyjTYE5vNG6DdKrhzq
         3C8CRiSnGN1UYz9S3kI2eoqjJBB0aep+Y7ClAjo5BdwRt7eLZGjqD/usirCiGLOzYaEr
         RAlCk8yE30z2wHjfIYD++2jTKgDKzbRXuQprYmGO5JhvgVww3/EEqpnzbgtaPzAp6n2M
         VEYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782150095; x=1782754895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0V4Nli64cruP20EMYA+JTCWwlIWP+yDHzBDBWC8SBM=;
        b=Q7M2tgJ7DpkrVwRI+RilyddSZMgzEczazcRdFunH+yA8V7oYxiFs++8KoqsmrX1bTU
         LpcK0KLc0B4wioyWwuY5aVtVMw7mqeXvakLlhpS5VxtwIh40cGRZkxnoJCoHfBHrKbNJ
         webmheOniui834uqIvrF94kPQkgKlIisWmRK4UFzuNXBTE/OGqa26HQZPxq0T/yOanE0
         yHButedvC9+j4wS7O0D+Ii7cch1HSiF2aOf5H2Ue8w0z6hnaULzE9HT1a/kTRs449i+d
         XyPzt1VEAHD68rj9yHeN3lu8BeFcuchWkuDQY8aHQhIMoy9x9pm+GcvT/ansHbkhQ9in
         zF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150096; x=1782754896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0V4Nli64cruP20EMYA+JTCWwlIWP+yDHzBDBWC8SBM=;
        b=HivWr7+mqfaVm1FByNiiJ0TSoPKUw6SMEuWcU85eTvy9t7e07PEt5qDwetZQPU6PUL
         sV7oYP6/ITu/qhy32uC9k7201kt5Iw6BYMx8FSVZo6RitzydMxNNdQnipW/m4kTm4D8I
         GIk3EPqcGwmz764IboDedeWr2nOlyKS6dRCMCqWw0QQwoO1MdnsHjJg2NnkijEl+iuur
         Vkj6qJhGjwLc4qGSPxCfM0AM+EYWlhwbhVsKkmcf8gVQvCvTmL1MbL4+qryIt+wC/7Ga
         svhLGrV74uDSOqkodMFH4tsi8CfSc06PKCUlpBdolAv64HqhTwFqw5pKM9Wzn8bSA/G/
         xF1g==
X-Forwarded-Encrypted: i=1; AFNElJ+d+tSOVFhGVsBZqh44eicTzgGDL1n0AEUo9ec/knbSjfDZ8uVKlIFRz2kl5EhzrJseRUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZKydQPR7YgdQbsdUAPISE3yYP8Dr+OMxVATkaSiV4JDMXMv+x
	uOWXhG7OSEqKXWGUMf7m5rciwjRI6nlEZ2YrfN7ApZS18fjO1VQIdvian/p6IHR5cXKpSN7WwLq
	Nel780DFdvdG0a4TlI9saEhAES1B5fnc=
X-Gm-Gg: AfdE7cl/6OzL5QCfmciNYI3hk/XNzaX+TtNCqvG9zRLK/Sf/N7SkfJYQwfVIqDFeMUJ
	if7RlFta1W2y8XA/XvkKv3ASvoq+lpOIVKYJsljbe/q1vND0zhXFPZU2fR4mHMlXRT+V8K6Ck5y
	dvNH4/Suv4AtLuW9sjSnk9B1Z9/xfjyfqtm/ecfgTWYd2ixnEMUxpcTVLBNPeSDwoTPi8euGb/A
	XIzWXv+Nh7BQBdsfL4TpGnWKCfLkXVfaPVV3mEoB+BKIiThr3fFB6p+byMw/CkpQnsiabr7JdZ1
	jihnUY3Ai0u5uI2Ns05VlXba9mmgSpfMImfByG8QlyY+8fnXnRqxzqDzqBuMM3JpF548x5ylB/P
	VLHPf/bTibhvkoXY=
X-Received: by 2002:a2e:a27c:0:b0:396:8f6c:7711 with SMTP id
 38308e7fff4ca-3998a253f58mr29265011fa.7.1782150095119; Mon, 22 Jun 2026
 10:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
 <20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
 <xmqqtsqv6204.fsf@gitster.g> <xmqq1pdy36me.fsf@gitster.g>
In-Reply-To: <xmqq1pdy36me.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 22 Jun 2026 23:11:23 +0530
X-Gm-Features: AVVi8Cfv4AHVMhFVwWy_CqJ9KirKVPJR-Ypqn5uZaDYJjl07xBAV1mfU8biyhBk
Message-ID: <CA+rGoLcahV9pPqkSAKvz9o3g2cw2PsYXxzzwAC8XoseFzMB5rA@mail.gmail.com>
Subject: Re: [GSoC Patch v7 1/3] path: extract append_formatted_path() and use
 in rev-parse
To: Junio C Hamano <gitster@pobox.com>
Cc: a3205153416@gmail.com, git@vger.kernel.org, jltobler@gmail.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, 
	phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Junio,

On Mon, Jun 22, 2026 at 2:32=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> So, for the existing user of this logic, the preimage ...
>
> > -static void print_path(const char *path, const char *prefix, enum form=
at_type format, enum default_type def)
> >  {

...

> > -     free(cwd);
> >  }
>
> ... now becomes this postimage.
>

Yes that's right!

> > +static void print_path(const char *path, const char *prefix,
> > +                    enum format_type format, enum default_type def)
> >  {
> > +     struct strbuf sb =3D STRBUF_INIT;
> > +     enum path_format fmt;
> > +
> > +     if (format =3D=3D FORMAT_RELATIVE) {
> > +             fmt =3D PATH_FORMAT_RELATIVE;
> > +     } else if (format =3D=3D FORMAT_CANONICAL) {
> > +             fmt =3D PATH_FORMAT_CANONICAL;
> > +     } else /* FORMAT_DEFAULT */ {
> > +             switch (def) {
> > +             case DEFAULT_RELATIVE:
> > +                     fmt =3D PATH_FORMAT_RELATIVE;
> > +                     break;
> > +             case DEFAULT_RELATIVE_IF_SHARED:
> > +                     fmt =3D PATH_FORMAT_RELATIVE_IF_SHARED;
> > +                     break;
> > +             case DEFAULT_CANONICAL:
> > +                     fmt =3D PATH_FORMAT_CANONICAL;
> > +                     break;
> > +             case DEFAULT_UNMODIFIED:
> > +             default:
> > +                     fmt =3D PATH_FORMAT_UNMODIFIED;
> > +                     break;
> >               }
> >       }
> > +
> > +     append_formatted_path(&sb, path, prefix, fmt);
> > +     puts(sb.buf);
> > +
> > +     strbuf_release(&sb);
> >  }
>
> Mostly, the code translates FORMAT_FOO constants into the new
> PATH_FORMAT_FOO constants, and lets append_formatted_path() do the
> heavy lifting.
>
> It is a minor point, but wouldn't it make it simpler to handle
> format_default first?  I.e.,
>
>         if (format =3D=3D FORMAT_DEFAULT)
>                 switch (def) {
>                 case DEFAULT_RELATIVE:
>                         format =3D DEFAULT_RELATIVE;
>                         break;
>                 ...
>                 case DEFAULT_UNMODIFIED:
>                 default:
>                         format =3D DEFAULT_UNMODIFIED;
>                         break;
>         }
>         switch (format) {
>         case FORMAT_RELATIVE: fmt =3D PATH_FORMAT_RELATIVE; break;
>         case FORMAT_CANONICAL: fmt =3D PATH_FORMAT_CANONICAL; break;
>         ...
>         }
>
> Perhaps yes, perhaps not.  I dunno.
>

I see you have continued this point further
I am going to respond to this in detail there.

> > diff --git a/path.c b/path.c
> > index d7e17bf174..6d8e892ada 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
> >       return NULL;
> >  }
> >
> > +void append_formatted_path(struct strbuf *dest, const char *path,
> > +                        const char *prefix, enum path_format format)
> > +{
> > +     switch (format) {
> > +     case PATH_FORMAT_UNMODIFIED:
> > +             strbuf_addstr(dest, path);
> > +             break;
>
> In the orignal "print_path()", DEFAULT/UNMODIFIED did this "show
> unmodified".  OK.
>
> > +     case PATH_FORMAT_RELATIVE: {
> > +             struct strbuf relative_buf =3D STRBUF_INIT;
> > +             struct strbuf real_path =3D STRBUF_INIT;
> > +             struct strbuf real_prefix =3D STRBUF_INIT;
> > +             char *cwd =3D NULL;
> > +
> > +             /*
> > +              * We don't ever produce a relative path if prefix is NUL=
L,
> > +              * so set the prefix to the current directory so that we =
can
> > +              * produce a relative path whenever possible.
> > +              */
> > +             if (!prefix)
> > +                     prefix =3D cwd =3D xgetcwd();
>
> This is what was done in the original "print_path()" upfront, with
> a similar comment to explay why this happens.  Looking good.  Also
> we no longer call xgetcwd() when we do not need to, which is goodd.
>
> > +             if (!is_absolute_path(path)) {
> > +                     strbuf_realpath_forgiving(&real_path, path, 1);
> > +                     path =3D real_path.buf;
> > +             }
> > +             if (!is_absolute_path(prefix)) {
> > +                     strbuf_realpath_forgiving(&real_prefix, prefix, 1=
);
> > +                     prefix =3D real_prefix.buf;
> > +             }
>
> There used to be a comment explaining why we make realpath calls,
> which is now lost.  Perhaps what the comment said was so obvious
> that we are better off without it?  I offhand do not know.
>

When the logic was a single block, the comment felt necessary to
explain the flow.
By splitting it into explicit switch cases, the logic became a bit
more self-evident, so I removed it to reduce clutter.
I kept the other comments where the reasoning is less obvious.


> What is done to make the paths real is the same as before, which is
> good.
>
> > +             strbuf_addstr(dest, relative_path(path, prefix, &relative=
_buf));
> > +
> > +             strbuf_release(&relative_buf);
> > +             strbuf_release(&real_path);
> > +             strbuf_release(&real_prefix);
> > +             free(cwd);
> > +             break;
> > +     }
>
> OK.
>
> > +     case PATH_FORMAT_RELATIVE_IF_SHARED: {
> > +             struct strbuf relative_buf =3D STRBUF_INIT;
> > +
> > +             /*
> > +              * If we're using RELATIVE_IF_SHARED mode, then we want a=
n
> > +              * absolute path unless the two share a common prefix, so=
 don't
> > +              * default the prefix to the current working directory. D=
oing so
> > +              * would cause a relative path to always be produced if p=
ossible.
> > +              */

I thought this comment made sense keeping in for instance.

> Identical to the original, which is good.
> > +
> > +     case PATH_FORMAT_CANONICAL: {
> > +             struct strbuf canonical_buf =3D STRBUF_INIT;
> > +
> > +             strbuf_realpath_forgiving(&canonical_buf, path, 1);
> > +             strbuf_addbuf(dest, &canonical_buf);
> > +
> > +             strbuf_release(&canonical_buf);
> > +             break;
> > +     }
> > +
> > +     default:
> > +             BUG("unknown path_format value %d", format);
> > +     }
> > +}
>
> OK.
>
> > +/**
> > + * Format a path according to the specified formatting strategy and ap=
pend
> > + * the result to the given strbuf.
> > + *
> > + * `dest`   : The string buffer to append the formatted path to.
> > + * `path`   : The path string that needs to be formatted.
> > + * `prefix` : The directory prefix to calculate relative offsets again=
st.
> > + * Pass NULL to default to the current working directory where applica=
ble.
> > + * `format` : The formatting behavior rule to execute.
> > + */
> > +void append_formatted_path(struct strbuf *dest, const char *path,
> > +                        const char *prefix, enum path_format format);
> > +
>
> It is slightly unsatisfying that this function is defined to
> "append" to any existing value in the dest strbuf, rather than
> storing the result in the dest strbuf.  The original caller
> print_path() passes an empty strbuf to this helper, so it can let
> strbuf_realpath_*() functions to strbuf_reset() it (e.g.,
> abspath.c:get_root_part() called by strbuf_realpath_1(), wihch in
> turn is called by strbuf_realpath() and strbuf_realpath_forgiving())
> it freely, which means that use of temporary strbuf like
> canonical_buf only to copy it out to dest is wasteful and unneeded.
> But other callers we will have for this helper later may want to
> append to what they already have, so perhaps it is OK (on the other
> hand, we could say that preserving and appending is what these
> callers can do themselves).
>

Hmm, I thought about this for a while.

Then I looked at what ls-tree.c does(using an accumulator).
They already routinely use temporary `strbuf`s to calculate
relative/absolute paths before
appending them to their main output string.

Because callers who need to accumulate can easily do the preserving
and appending
themselves with a temporary buffer, there is no reason to force that
overhead into our helper.

I will change the semantics from "append" to "replace", rename the
helper back to `format_path()`.
I hope I am looking at ls-tree.c correctly here : )

Eliminate the wasteful `canonical_buf` allocations so we can pass the
destination buffer directly to functions like
`strbuf_realpath_forgiving()`.
This is a good suggestion actually, thanks!

> Otherwise, looking good as a no-op bug-to-bug compatible rewrite,
> with a slight optimization (to skip xgetcwd()).
>
> Thanks.

On Mon, Jun 22, 2026 at 9:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:

> > ...
> > It is a minor point, but wouldn't it make it simpler to handle
> > format_default first?  I.e.,
> >
> >       if (format =3D=3D FORMAT_DEFAULT)
> >               switch (def) {
> >               case DEFAULT_RELATIVE:
> >                       format =3D DEFAULT_RELATIVE;
> >                       break;
> >               ...
> >               case DEFAULT_UNMODIFIED:
> >               default:
> >                       format =3D DEFAULT_UNMODIFIED;
> >                       break;
> >       }
> >       switch (format) {
> >         case FORMAT_RELATIVE: fmt =3D PATH_FORMAT_RELATIVE; break;
> >       case FORMAT_CANONICAL: fmt =3D PATH_FORMAT_CANONICAL; break;
> >       ...
> >       }
> >
> > Perhaps yes, perhaps not.  I dunno.
>
> I do not consider the above an blocker, but it might make a
> difference if we are going to acquire more modes and formats, so
> once somebody tries to rewrite the logic and finds the resulting
> code harder to follow (or not easier to follow), I would be happy to
> see the above discarded ;-)
>

True, if new formats are introduced
this would instantly become sloppy.

I will change it to future proof since I am
looking to send v8 for append_formatted_path().

Although I would be surprised to see an example for a new format.

> >> +/**
> >> + * Format a path according to the specified formatting strategy and a=
ppend
> >> + * the result to the given strbuf.
> >> + *
> >> + * `dest`   : The string buffer to append the formatted path to.
> >> + * `path`   : The path string that needs to be formatted.
> >> + * `prefix` : The directory prefix to calculate relative offsets agai=
nst.
> >> + * Pass NULL to default to the current working directory where applic=
able.
> >> + * `format` : The formatting behavior rule to execute.
> >> + */
> >> +void append_formatted_path(struct strbuf *dest, const char *path,
> >> +                       const char *prefix, enum path_format format);
> >> +
> >
> > It is slightly unsatisfying that this function is defined to
> > "append" to any existing value in the dest strbuf, rather than
> > storing the result in the dest strbuf.  The original caller
> > print_path() passes an empty strbuf to this helper, so it can let
> > strbuf_realpath_*() functions to strbuf_reset() it (e.g.,
> > abspath.c:get_root_part() called by strbuf_realpath_1(), wihch in
> > turn is called by strbuf_realpath() and strbuf_realpath_forgiving())
> > it freely, which means that use of temporary strbuf like
> > canonical_buf only to copy it out to dest is wasteful and unneeded.
> > But other callers we will have for this helper later may want to
> > append to what they already have, so perhaps it is OK (on the other
> > hand, we could say that preserving and appending is what these
> > callers can do themselves).
>
> This one we may want to consider a bit more seriously, but it is
> entirely up to the future callers of the helper.  If it would make
> the callers much easier to write for this helper to have "append"
> semantics, I'd be happy to accept the semantics of the above as-is,
> but otherwise, I suspect it would be simpler to use if the helper is
> defined to replase dest with the result, instead of appending the
> result to dest.
>

I am still unsure if I am following ls-tree.c correctly.
If I am then I think it is a very good change to have for v8 as I
specified above.

> > Otherwise, looking good as a no-op bug-to-bug compatible rewrite,
> > with a slight optimization (to skip xgetcwd()).
>
> This part of the review does not change in any case.  The
> refactoring looks good.

Thank you ; )

Regards,
- K Jayatheerth
