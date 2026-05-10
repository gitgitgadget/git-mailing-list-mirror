Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E627732
	for <git@vger.kernel.org>; Sun, 10 May 2026 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778381182; cv=pass; b=jgyGwjfF9/R9ygViJkRUVj0658h5215jid3HlBbhMQcsCo8RXEkVjv6sUhQ5sebtnKgp4CiloMrwi5LwK/s01a2v3OHSY/dfNhEUeGmvmOFvI/SXcOTrShHyr4e6xgbtvn64nEi2ZTZyNs5xIfBmd/xV2ZmCPHIPtqimIHG3Vqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778381182; c=relaxed/simple;
	bh=/OVXb4Xa810h05MaRmOMFinlg+PJ8MVkseDhPGDSCqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzthmoGfczSOdmwaSc96UAyZ2dUxzR/NHYsGtP6Z5m3p+JYqPUviCHZA288QUI81IMna3vf8QTjAapiDKSnISN7Fa/XgEoL/3Axtog5sR8dc0uh34cCrGbsCSZbkdkltBoWf3xCuS39O2Xu8KDBG55PcXYiJureI4R9OLLopLZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQqu6nnk; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQqu6nnk"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47c35be02fdso1240989b6e.3
        for <git@vger.kernel.org>; Sat, 09 May 2026 19:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778381180; cv=none;
        d=google.com; s=arc-20240605;
        b=WwK6Y7h3FI1fiDM4I2cSWMzTD53jYVNKX+xLCfnk9ySVJYS7oRAAaEhVAT1ZIAEJYh
         ngCo96Y+ZaNG3HtOXAJPNChehOwX4sl6xCFYlRuVCM7PjQRGAxUC9OkCF+CiTK2tIfEx
         PqYlEiM07JCtETabR9WiQk7R75v1ioJSB7ylaXtaxVyLJ460ynKpKyGcanwJA8YNyusg
         FLPbTdALd8nxxNcDnzcJtqnBb/wKI6uqgoMLkbSQWkatdzDFsqD48Ul0wcjDjUmWmTW7
         DTRP1ewl6t6ahuPGK5HnjKC8MquVnYQsB/6NHFIaX1oy/IrQWgttY9tovSjF+WJlOY11
         epSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPsKfivaXBqiX5eYIUNSjCcWpUIzlkC9G+CHFdE+sIQ=;
        fh=HMHWR2ORGLmQTI4vOHJz8YgXPneMwjx67lQKctaL/Q4=;
        b=j6wJAv9rVcaNapzFK1+fFu8wP1wYhTMN1iXwfeFfRYC5g3XXX0pJrimOamwbkDS+LD
         odF93G31socEQ/SPF5LsDxxLX1RoCt6biH31Ud3DFDUfb0KSfPiq+xBXcX/sk/3fkhUS
         x6ZID0ivysW7783qXcT/FrdE8CEl2N+Uy3hSPzvll7YSa4oinEKoc6dNWkF9FBfOyglx
         NV/0qjHo0LMtaq0p2aUpDcWzGs1gl2W3zTzQZKtdbyEdeaiLCFJWCpMGlpksJbEk0eFj
         6caWAvCx+iTE+ZOJSaCP2w0LZ+NxyqsCME7medHUFJ+kwApLiH91nW7oP2x0i3SUWyff
         ArYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778381180; x=1778985980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPsKfivaXBqiX5eYIUNSjCcWpUIzlkC9G+CHFdE+sIQ=;
        b=XQqu6nnk9peO8G71zQQD6dj8Q2JrZpvbrVzdyBtmeNhw9auJLllxyplyXfiwZT9bs5
         THKEmoomxW7D5MSWPLZtiW6EjsynaRkT7PCcrHuTq7ulmfOhjOTsqKeeYQWIgJnv6H6c
         D1e17xSdtONPj9T09qdG3nJwXHCWYMrTVdN5Pu8I9VkJ5WlDHfFYitgzAE8G+iq5UQyr
         AQ15YXLwGjrYyvf8XCzNECqoSufnVI+OXINFoG4FlwjCP4O8Cpe5RPvAZvgfy20HAaJN
         85wK25ny58ric3nTG90rOfs9kLHe1yeGQ6qDBt9p+kMpfp4uOL61DZM/A/R93x0N2O6U
         2b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778381180; x=1778985980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPsKfivaXBqiX5eYIUNSjCcWpUIzlkC9G+CHFdE+sIQ=;
        b=SyHVutlaap8EtK4vHzsoHcpwtUZhvZfEj0cQMSnnQhneX5wDtQZhi9qqjvr8qsTX1K
         qWbSSPx8k9CktISYO91gs420Olda3baZMCh4tToesLtaMdJcvA3OBvOMysvncyHJ95HL
         uUuP1WlQ+7x7ToYad3IIPKLj1exoUNrxdLd1IoNwUXtcO/XOOo9ExoTWcXukyGQk9OQX
         wr8XiFGjBr0Sdztt45SMaNoE6BcoiyHSismO7jb8NREEkAs13LumSwPlR3BvY1mhuoT9
         +LZ9K1hahqEkhjI+cdUCbTq+Zq7ojiA5L/vqx6wiKOHfFDH/vueWmD6Q3Zg9G3/WnO3D
         VUgA==
X-Forwarded-Encrypted: i=1; AFNElJ88Bv3BxJ4uVMw8NtPxeA+ebKQsEFFEmpSdZs/h1MNSFt7EH1KEwCRpIhsnbz90UuWHFyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI6lJPgxPPzsoj+AvjaFAvLTKamXLBCKZ+AEW0pp25jRP9RrI/
	I3HmsArdP1R73XlTzlUjUmDUuWheDBVKi1ekyQ/2R+aMBkHkaPS0b5Fk3h4YiDQq5fJlCg4SV7A
	7lRkEBMqZAV/vtcUHnvSD5M66K7GG5ligzw==
X-Gm-Gg: Acq92OFMIcL4kCZXxLjJR88JcPDA8muJXP+VlumTGk2M4NfUFxzmuFbKgGABZldArTy
	xmlASlKFz81EyaVstxuPumVg8rJ85EPCYNsvJE7N17EKRGMr9jsj+GxTr+KClsGPHsRz10TJhwf
	ltJQaRYmhQ74d082X5FHeZG7or+Zc82AzLAKL7WCAQlLXLL044luNOBlLX6yqCt0lzwMWv01HFF
	cVPb0gjpxWMSGO41+mg1gHUIGRYwLigYp6I+2ZksUgv0DuSKmc23HCzbMGaLNaVQMeWTuuFzoe4
	r9TRYeKXJUxNtE3OoEsOSdwJVdPjJHd18pOZxuWs
X-Received: by 2002:a05:6871:d605:b0:423:7f5:1a6 with SMTP id
 586e51a60fabf-4358922b96bmr2436854fac.30.1778381179949; Sat, 09 May 2026
 19:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com> <xmqqv7cw9ixu.fsf@gitster.g>
In-Reply-To: <xmqqv7cw9ixu.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sat, 9 May 2026 19:46:08 -0700
X-Gm-Features: AVHnY4K6sQ_bFbh_7gdLECC-OCpq9pteVWZycY2KLJBOXS-ZOrlWTjUDOCj-Hxk
Message-ID: <CAC2Qwm+iXYC_L7aYTpcPc2QpDh4VQW79gNBsUOZhSHkNv-y+Ew@mail.gmail.com>
Subject: Re: [PATCH 0/4] diff: reject negative context values
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 6:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Negative values for -U and --inter-hunk-context are silently accepted
> > and produce structurally invalid diff output.
> >
> > Malformed hunk headers:
> >
> > $ wc -l GIT-VERSION-GEN
> > 106
> > $ git log -1 -p -U-500 -- GIT-VERSION-GEN | grep '^@@'
> > @@ -503,999- +503,999- @@
>
> It may not matter in the cover letter, but why do you need ~60
> whitespace characters at the end of the command line, and many other
> lines in the message?
>

Apologies, this is a mistake I made between formatting my cover letter
and moving
it to GitGitGadget. I will clean up the cover letter and be more
careful about that in
the future. Thank you for pointing this out.

>
>
> >
> >
> > Line 503 of a 106-line file, count "999-" is not a valid integer.
> >
> > Overlapping hunks that cannot be applied:
> >
> > $ git log -1 -p -U3 --inter-hunk-context=3D100 791aeddfa2 \
> >     -- git-compat-util.h | git apply --check --reverse
> > (success)
> >
> > $ git log -1 -p -U3 --inter-hunk-context=3D-100 791aeddfa2 \
> >     -- git-compat-util.h | git apply --check --reverse
> > error: patch failed: git-compat-util.h:118
> > error: git-compat-util.h: patch does not apply
> >
> >
> > Both options were originally parsed via opt_arg() which gated on
> > isdigit(), making negative values impossible. When they were converted
> > to OPT_INTEGER_F / OPT_CALLBACK in d473e2e0e8 (diff.c: convert
> > -U|--unified, 2019-01-27) and 16ed6c97cc (diff-parseopt: convert
> > --inter-hunk-context, 2019-03-24), the implicit rejection was lost.
> > PARSE_OPT_NONEG was added but only prevents the --no-* boolean form,
> > not negative numeric arguments.
> >
> > This series restores the original invariant with stronger guarantees:
> >
> > 1/4  diff: reject negative values for --inter-hunk-context
> >      Change type to unsigned int, switch to OPT_UNSIGNED.
> >
> > 2/4  diff: reject negative values for -U/--unified
> >      Change type to unsigned int, add range check in callback.
> >
> > 3/4  xdiff: guard against negative context lengths
> >      BUG() in xdl_get_hunk() as defense in depth.
> >
> > 4/4  parse-options: clarify PARSE_OPT_NONEG does not reject
> >      negative numbers
> >      Documentation fix.
> >
> >
> > The config variables diff.context and diff.interHunkContext have
> > always rejected negative values. This series brings the CLI options in =
line.
> >
> > Michael Montalbo (4):
> >   diff: reject negative values for --inter-hunk-context
> >   diff: reject negative values for -U/--unified
> >   xdiff: guard against negative context lengths
> >   parse-options: clarify PARSE_OPT_NONEG does not reject negative
> >     numbers
> >
> >  diff.c                             | 25 ++++++++++++++-----------
> >  diff.h                             |  4 ++--
> >  parse-options.h                    |  5 ++++-
> >  t/t4032-diff-inter-hunk-context.sh |  6 ++++++
> >  t/t4055-diff-context.sh            |  5 +++++
> >  xdiff/xemit.c                      | 16 ++++++++++++----
> >  6 files changed, 43 insertions(+), 18 deletions(-)
> >
> >
> > base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2105%=
2Fmmontalbo%2Fmm%2Freject-negative-interhunk-context-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2105/mmo=
ntalbo/mm/reject-negative-interhunk-context-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2105
