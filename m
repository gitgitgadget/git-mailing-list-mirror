Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEF1A6836
	for <git@vger.kernel.org>; Sun, 10 May 2026 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778380899; cv=pass; b=q+aq1NLmKS+THHTsmnlV6cs1GM6eFxJ6jzRYHACGpc3NJL2Ixk0premBSJzXR5oWSEPbLYt5zr9ccxcaIBiGhktNwERVP40Dl4gRcWldoF15+6QF61GBtsrTScPi5/oYIiXaHXN1NSPIcb9POFeAS3ktwKM5jiEwyFoNoVJgprs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778380899; c=relaxed/simple;
	bh=nWFlawPMu2U5RdK5bueBHs5aDNC+MYS8v5Y77gqMW68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPBnTIQtFe15MJoDEv63PfByh/WTShXtdjY/tV2VDrpKbJA36aDBu7lnlL3tyc1cg1+UwkEXrN/YycnK8CAvcclY8oG1zsV9+Av3eOLMktn8ZDbTyid1S5/e5EAAx8qI4CyZ6Iq2PzgomueL3z5X8B9luBPaR2cfJjuduOZ9TbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0fbzqQk; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0fbzqQk"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-43496e6a964so2457601fac.2
        for <git@vger.kernel.org>; Sat, 09 May 2026 19:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778380897; cv=none;
        d=google.com; s=arc-20240605;
        b=harRFq7umO1VKgOKLJqEv2VXOVjp/xMCEt3QVmrOmK/6pGK7Cw+2PYIpjeU5KxdECW
         0we1Kxo/IcRpi7pDcYaqUnKnX5LGfQIUtgoPkzkRV6kVPDxj8VfH0FZQZoUYkMeZIGH5
         tPyk3hCZ6W5yNJ1NXI3uQZsj7I+EvZB332LuPBQVwW6oLP0pgrJAnFXWhHbloU55Vnr8
         nD36pq21Ipw0NX9mLe0QEAc/guYGK7iHs/ArJ6f+Vcfs7AilPpQLtX2AgHpoUjAthZRC
         MVhfUW+RlEDs0Uh+N2iioz2e5usHjr+lAw++NnY0cIjDUOhzaFaEQ/lhMTeqmiu4ztET
         tDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dFE+g2wbIRkjT+4rGt+m2kQIpWfLyqANJPhJTnk/mCw=;
        fh=rkAKhCMVxfViORA1hfsIfuMb7oNjoDXa7igEPGutphA=;
        b=HIfDxfhvsDpSlRlf58FAi0BP+4ki5XkToIIHkbrkElinpVHz3+kv62Rvg0bNSFzbQu
         g7/WaGvm9fA5AWdk9ttSrqcPQfOCNm87MBQeI9hf0Lc+wfqgvrS+7G2BryCqLlEOkFKv
         y0neVaa1xvUy24EXABbk3IKtdaexpVY+lubPkC/0t1J9v+bjqNAByhRgzXry3VtYHO4Q
         nE+bJYFpadzhtwO3zcov664RJkbmcPkyc8+k4WYIGIcZSNcGdS/1RpspSLI5M5I4S06y
         yfgH0VXT6bYwlqbAvTqP4nYyCkYQKP1BxsKunaWHxclszuBxh0pVZVbpdoWIzPeFipkQ
         m7ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778380897; x=1778985697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFE+g2wbIRkjT+4rGt+m2kQIpWfLyqANJPhJTnk/mCw=;
        b=m0fbzqQkq9MLHyRhQY7xcYg8y1xFPhfI/CTbbiFfQYfJGDRz2RzYkQ6UliCMwpZfq9
         b/PdTBVpa3H8OMNcNynmhK2kSepLXW2kmZsrSN0dg+lSNonFlc/AOXdr1TYJfDSOHjj4
         Yj71hrLV5ysWMVZAbFIb/loButtPFT3mC4xuLiWqIsUqtrTkxk3tWfvkVbjQAlMhQ/wI
         bddupO0XzqLuYOi+3+yq8RPgmuIfDPHtqEAK7gEy1rXU8OubIKstHVHA+4DtBM29ezXr
         mBiE3aXCqmVkQNwlAf08/PL7GdYTFaHZoawh3ici0qQlYTE2yGY810Hrq0xCZocKzLeh
         ZAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778380897; x=1778985697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFE+g2wbIRkjT+4rGt+m2kQIpWfLyqANJPhJTnk/mCw=;
        b=YCzRvHZs+oA7zDXCu1M4SZu6Hb8/cGrptyEdLONLY3/pFaqoZb4ynrMr7CxpzQoPeW
         MfWjEaGxLnPRuItPDt1NC0seGS77I1Q0yoLo7mn/aK34/8DfhBt9L+6oh+GaOHA8Unhr
         ZQwR8G5j/x1oHkm2EdttyMN8N79l8um53vsOIY5RvDcJMgzVHqB4QOYS05Ecur3SQn7U
         i4pJeqCEZwqQxZJHwF0/QpCEC2O0nsncy+saVETEuuk+uIcsnXhgU+LPlc0Trzp26/N9
         ueZD5sgExngfTI9hmYK87U0cP8uxpkb0R/yMrnwVsG2FEGMiZCHMpb1wqOH0xDJWfQC+
         BDdw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ur3j9spdxNSuUj2fBQQeXi5y5Kqk2rGzIUNHg65AgihWR0S/R/INFHqnfQOB08kkdzik=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcvn7zYpG1nZIpxTsPUTzmAiA0v73K6wDxAmUACp9WyXlQZIXn
	wGCx83vqb06DDw2nTnrjsXzr6Kd4IxIE8GtsETkkp833vESpMXaa/S5SHXET7eWNt7Himwt6FlQ
	wUs+1DpQrH5SlCczP5IzsoTvp41SF6TI=
X-Gm-Gg: Acq92OHcA86+TZ8ahCou3xI0AdzlaBtgNN8yWRA8j3DvQGlX0T76Kdfj0u9tgRxZ89V
	8FJekSeaQXmyEvS6ylREHhOboVMxN9pFl7V+dsSSlu0DSw10fliZn2weTrgUxmtubKR1wXboVvu
	RJLdWn0qfnnA3V3KilqLL0LxWXUNVyWy99slWbd9qCfvZM9EU5LzoPdBpztWMtn2EKNS3j8Wbkj
	AdV9tQVIh0g8QjNP4+Giwn0lEiodGicrt1ZPuiDgWoE0SBBVvfoShJr0RmP0LBrW7rd/CBIX6gJ
	JyuFVGsR4dvC7bkwf5MT5lJwZUzAU3ywLKrmBw3V
X-Received: by 2002:a05:6870:d250:b0:42f:caff:34e6 with SMTP id
 586e51a60fabf-434f66d5e48mr11105340fac.31.1778380897389; Sat, 09 May 2026
 19:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
 <05ff821e6ffec02a3bfc5aef542592de6a7add76.1778022144.git.gitgitgadget@gmail.com>
 <xmqq8q9sb5uc.fsf@gitster.g>
In-Reply-To: <xmqq8q9sb5uc.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 9 May 2026 19:41:25 -0700
X-Gm-Features: AVHnY4LdsoOKp25cXta1VmrYX6uX22uIDto-SkeKYZbMAb8kooHI2tTP3Aans-Q
Message-ID: <CAC2QwmLH19+LHNaP=13c9Ov8x1zXvyDmEhN69_RpbOY+OqEVZA@mail.gmail.com>
Subject: Re: [PATCH 4/4] parse-options: clarify PARSE_OPT_NONEG does not
 reject negative numbers
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 3:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Michael Montalbo <mmontalbo@gmail.com>
> >
> > The name "NONEG" can be misread as "no negative [values]" when it
> > actually means "no [boolean] negation" (the --no-* form).
> >
> > When --inter-hunk-context and -U/--unified were converted from a
> > custom parser to OPT_INTEGER_F with PARSE_OPT_NONEG in d473e2e0e8
> > and 16ed6c97cc, the implicit rejection of negative values (via
> > isdigit() in the old opt_arg() parser) was silently lost. The
> > previous commits in this series fix the resulting bugs.
>
> I do not think _NONEG has anything to do with the bug.  It was
> purely to reject --no-unified and --no-inter-hunk-context.
>

You are right this was a mistaken assumption on my part.

> And there was no change to remove PARSE_OPT_NONEG from anywhere and
> use OPT_UNSIGNED instead to fix any of the bugs fixed in this
> series, ...
>

Right, PARSE_OPT_NONEG is still enabled implicitly by OPT_UNSIGNED so
PARSE_OPT_NONEG really has no part in the story.

> >
> > Add a clarifying note to the flag documentation.
> >
> > Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> > ---
> >  parse-options.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/parse-options.h b/parse-options.h
> > index 706de9729f..c0a3a3dcae 100644
> > --- a/parse-options.h
> > +++ b/parse-options.h
> > @@ -116,7 +116,10 @@ typedef int parse_opt_subcommand_fn(int argc, cons=
t char **argv,
> >   *   mask of parse_opt_option_flags.
> >   *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOO=
LEANs)
> >   *   PARSE_OPT_NOARG: says that this option does not take an argument
> > - *   PARSE_OPT_NONEG: says that this option cannot be negated
> > + *   PARSE_OPT_NONEG: says that this option cannot be negated (i.e.
> > + *                   prevents --no-<option> boolean form). Does not re=
ject
> > + *                   negative numeric values like --option=3D-1. Use
> > + *                   OPT_UNSIGNED for options that must be non-negativ=
e.
>
> ... I do not think the two additional sentences are warranted.  Stop
> at clarifying what negated _means_ (i.e., rejects "--no-<option>"),
> without adding what negated does _not_ mean.
>

Ok, will remove the latter portion of the change in a follow-up.

>
> >   *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, an=
d
> >   *                     shown only in the full usage.
> >   *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the de=
fault
