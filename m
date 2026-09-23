Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31E63F0A85
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151052; cv=pass; b=Bm6XoxMia2bKxL+Y35kYYpKGUuCHKfyZea7aZWyUDWv3Cg/WvWiHvhS4W/wdgqw6MLZJEiARQJM3GD4HboCMQ5uOQU/HeSfIBH8uGJfq4rQTJK2r8icuHysDuQDjX2oSlHNu3XZSVkuBffBdC+B5npCyXYQ/j5WzktWgd9bfi1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151052; c=relaxed/simple;
	bh=xh82fcqUmGMsKD1HZVnGPSzyfhihpBI/lAJlGcOEJkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMYqq4ehKkQpzMyNzTu+lFs3gv98dGgfNR+xK1Kj67AglOwc3s2JVifN5BjqZGSPFJ0jgsYcDawfUabz6DHiVvU4+lu4NP7VikL06yJjUwfuM2/fEYtu/6+whbpE6CqQkCTTDO78Ah9mWrzOZQsGUBA+ze0LtmI3lL6Qh1aEbIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+SGqITt; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+SGqITt"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-143859f5737so882083c88.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790151049; cv=none;
        d=google.com; s=arc-20260327;
        b=Fcdj2f4lmbgvEoCPw3ubWFBLVHcqIRg0SQBQN5H9ouNejOh6V9jyOOd5yG/TDumvqQ
         abK1/6A8lzPYgt6bdVA+OtHZ542AgK2IGLq3HuT0E7y27z660E5HJANXgP0jW+qOK2B/
         wcMyc+89SOUaDXyDTWtC2dgZ78MzzoTR0SkXaFArHmxVBx5Ep+sv6l/Mqrxfv7MbAo2P
         dR16s0BC+ErYOuQK0Lk8ccapTFnILOYiZzjS2f8qxPiR3G5VmOGn68UbCK7J94TAt1Kv
         SqQ9ZdJ+JMjNLJdiL2TTY3qToSFI6StudGFk8S6exdp3qNmJ71o96IyzD9rRXYxyIs4B
         WDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SnJpNyHNUB6WDNYpt2EEOmpaBHoAcEgMo+mVNLhF+GI=;
        fh=xgj+vSGq/gGUery/oIClRsu4cMrai2x0EL1nksSCsY4=;
        b=pWVvL5nJHf7Nveq5eINe50zNPJ8yMuLn1G4xb8DsqTtnh/gvdtMlB3pc9o8EIZyNKD
         uFN5oLAfxYK6AQmaPdl3aXaj91aHHFfl4NjROosZoPqN7Egii3YNI8dPf047P39blesE
         IrT36/78k664lp1wyAtW645M6sviVqkMbV4eavHyZkRMkywIsgALlZvx4u+YLqwr+TjK
         6ehHATkqebCq4V+8WK3U6YTUOurhRJKq/gcrELrZPvR6X4DK7l8i8iUd2lkt9YuTzKra
         hwnDlDgPU9BXE6tosAITFy7dFyLiStWeXq7Uw58M79uDcpLAInmYwEpaFxsapFPU+CjA
         E0uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790151049; x=1790755849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SnJpNyHNUB6WDNYpt2EEOmpaBHoAcEgMo+mVNLhF+GI=;
        b=Y+SGqITtV+swlWpVcyCmnzY5Mql5TcTC9PBE/WE+oglbFTiOFUKVcwTt4xIqORiodZ
         4rRTOALXy44xfaLnBKOcGCU/EORb+3zKXG1kdMD0effEOimIo1ETixpDJtzb6uZBOAyP
         EeTwx37Omwd+EU+Pbhwd7fV9NrrP1P8TtB6QxU1ydlI606m7rkQuqI8VpmEv1D2AJY/4
         LzmxfB9NiFn636fd/eRiS3LaYSZ+3jU2Pg6ZboL07p0L0Ue/tzn6XWzcErNVIUcEGw+O
         E2Cyrp5/rK7SBDkBN8O4/dlMmIzZAHwVtfDO7dL+N9zOAGaNnOrZ9rS1Tz+VZ6sOvytF
         bQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151049; x=1790755849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnJpNyHNUB6WDNYpt2EEOmpaBHoAcEgMo+mVNLhF+GI=;
        b=UjOAfUSe/pyIMI4Us0189vnucktX1SGnrYi+yiZsB8UFDjnB+DXKKx6lfIzXGH1TTr
         9hxQsVtq5J36lC7ijO/rc8EPQ/iGPG9FJ5ZN2O1iTyxOU/jBnegZZpN6i1+YzZK9g5Ha
         2iAfr1JOqRahsavKPV9X0MVmWqpLSoU/VkD7kNSNSMj/+6RkzcS1PiUZ7uHGE+E96XIr
         diUWQQtqP82YRGVgNQxHvhOeHZUTPswtAt6J9ppNUiYglkfHmArnp+Z7rHBJDGOBJreN
         8yBWunn373Vlx1G5E53j+i2I4VsBjqXkXrk3zKE2p2EBLbOEoQkFg97MtzptsBo1ntg8
         IHfQ==
X-Gm-Message-State: AFuF++mBLPGPgmEIoB8EB5RDUNUpKCH52dUqobEbmcfHOWEwJ0VvuU2i
	Iei+qbrSt8HdCjlom2FBRDmvwXBxnLJmX80gds1cKiCcnLusG+RZcE94day7IH2x4vPcXldCxSI
	MnloNUWBznM7p5EzzPUdqBahLJuNnx2g=
X-Gm-Gg: AYBFou1WJj6kaC+OYDKN5nlPUy/EmmzMW1ch9OsLJUEy2zQjSnkovFMaYbc50w071Qx
	SP1x9/22LvcINQI92NOOM32bXsECD8sshGHIuFnABJ8Sa00A0PdJNbX675QAx1fFkB459cGLFJ/
	x2OgwvEtUJtI1iP2uzTYkxtcqQRE40DH+xIfjgfU+VtnhSPEbXFXrpAWC+2HABeuyFsjaBHFZpt
	Jaf1wTBWkpQbY56pwa/2aUnTceusO9IdKLpgizmKJ05yK3oYLtIDzCUY5BEi0VBQz9pCO0BApsd
	JXGcu3k6Etbpc0idLbECcC0rK77cOpJE78nW9tJdRszGD2Td/57RDrxDLYvwidDyzWkp3K0UVLi
	esfOQpiCajizqB8uW4GISZHYUQSxd43UOueV6Q/yXUnoExpHUd6v31a7Gg4tCG1tmtvkvwajkSV
	s9riRi8xQpBXflIRloA+KAASKiYoBaz9Ub3Jt5m48=
X-Received: by 2002:a05:701b:42d3:20b0:144:c12b:dfc7 with SMTP id
 a92af1059eb24-144f91b1609mr2164436c88.45.1790151049268; Wed, 23 Sep 2026
 01:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902161047.476753-1-christian.couder@gmail.com>
 <20260902161047.476753-2-christian.couder@gmail.com> <xmqqy0djfgmt.fsf@gitster.g>
In-Reply-To: <xmqqy0djfgmt.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Sep 2026 10:10:37 +0200
X-Gm-Features: AcwNN1X5Yjlj2JTLFf4-3d1QS1B8iqJxwEtA-RxiY8e5VbrDqtYU7M36eLHw09w
Message-ID: <CAP8UFD0KP+e4EYVAKW1+6n3og1nzi_+Utr59Vgo8Fz0G=WZ-Qw@mail.gmail.com>
Subject: Re: [PATCH 1/6] parse-options: add early_scan_options()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > So users must spell these specific options in full. This restriction
> > could be lifted in the future though, once the scanner is adapted to
> > accept a command's full option array, as this would give it the
> > complete context needed for safe abbreviation matching.
>
> It is unfortunate that end-users cannot tell if they are dealing
> with a system before of after "once the scanner is adapted"
> happened, so they must be trained to always spell the options in
> full to make use of the commands that use this feature.  It at least
> does not regress relative to the ad-hoc early scanners these selected
> commands have that do not even understand what they are parsing, so
> it may not be too bad.
>
> Stepping back a bit, the burden on programmers to use this would be
> to write in a separate notation what options there are in addition
> to what they feed the real parse_options(), which cuts both ways in
> the sense that because this does not take parse_options(), commands
> that do not use parse_options() can still use it, but those that do
> already use parse_options() need additional work to use eary_scan.
>
> And then once the scanner is adapted to accept the full option array,
> the programmers only need to discard the struct early_scan_option[]
> they wrote and replace it with the struct option[] they already have?
> Or would the calling convention to the scanner also change when it
> happens (oother than replacing the pointer to struct early_scan_option[]
> with another pointer to struct option[])?

I agree that what was implemented in v1 (to be able to accommodate
early scans that do not use parse_options()) didn't bring much
practical value, was a bit complex and required some churn when the
early scan would have been converted to use parse_options(). So, in
the v2 I just sent, it addresses only the early scan where
parse_options() is used, which simplifies a lot of things.

> > +static const struct early_scan_option *
> > +find_early_scan_option(const char *arg,
> > +                    const struct early_scan_option *options,
> > +                    const char **value)
>
> Because you return one single element from the incoming array of
> options, it is mildly misleading to call the variable/parameter
> "options" here and everywhere else.  Let's stick to "arrays are
> named singular, so that option[4] names 4th option" convention.

Right, I have changed the argument to `const struct option *option`.

> > +{
> > +     if (!skip_prefix(arg, "--", &arg))
> > +             return NULL;
> > +
> > +     for (; options->name; options++) {
> > +             const char *rest;
> > +
> > +             if (!skip_prefix(arg, options->name, &rest))
> > +                     continue;
>
> "--option" on the command line, after getting stripped the leading
> "--", may begin with "option", and that name may be in the option[]
> table, in which case ...
>
> > +             if (!*rest) {
> > +                     *value =3D NULL;
> > +                     return options;
> > +             }
>
> ... we found a hit.  But shouldn't option->takes_value be consulted
> before we return to signal the caller that the next arg is an option
> value before we return from here?  It looks a bit uneven as we do
> that for stuck form "--option=3Dvalue" here.

Yeah, we found that `arg` exactly matches this option whether or not
it takes a value, but the value is not here.

Whether the next argument has to be skipped is decided by the caller:

  if (parse_options_takes_argument(opt) && !value && i + 1 < argc)
      value =3D argv[++i];

find_early_scan_option() cannot do that itself, as it has neither
argv, argc nor the current index.

So signalling to the caller would be redundant, because the caller
already holds the matched option and can ask directly.

But maybe I should add a comment on the line before `if (!*rest) {`
saying that skipping a separate value is the caller's job?

> > +             /* Only an option taking a value can be stuck to one. */
> > +             if (*rest =3D=3D '=3D' && options->takes_value) {
> > +                     *value =3D rest + 1;
> > +                     return options;
> > +             }
>
> And if the option[] table had "opt", then "--option" on the command
> line may begin with "--opt" but "ion" is an excess that is not a
> stuck value, so we do not consider it as a match.  OK.

Now using `takes_value` in the `*rest =3D=3D '=3D'` case wasn't quite right=
,
as parse_options_takes_argument() returns 0 for PARSE_OPT_OPTARG and
PARSE_OPT_LASTARG_DEFAULT, but parse_options() does accept a stuck
value for both.

So in v2 we use the same condition parse_options() uses:

  /* Only an option that can take a value may have one stuck to it. */
  if (*rest =3D=3D '=3D' && !(opt->flags & PARSE_OPT_NOARG)) {
      *value =3D rest + 1;
      return opt;
  }

> > +     }
> > +     return NULL;
> > +}
>
> If we are to write a separate function anyway, I wonder how much
> more work to write a early_scan_option() parser that does take a
> real "struct option[]" array.  Its elements already know if they
> take a value or not.  For expediency, it may be OK to start by
> simplified parser that does not handle unique prefix and other
> complexities like callback functions of the real parser, but at
> least it would reduce the burden on the programmers quite a bit if
> we used the real struct option[] array, I suspect.

This is what v2 does, and I agree that it simplifies things.
