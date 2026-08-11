Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAF305693
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437161; cv=pass; b=ikoO/vQ/ahEMVghbdzDR0Et3ZX7Z7XC1wnGUUpp9AsSOnaOyLqLqd+D9QwKNfctc0N6qaIp0fkSYhsAPGEIWu2Yz7PzeKj+386YPZ++PQY1RqmbABVp8rupf8Se4cLgOlLYF4DDiyPrSkzBo84c0PtZvqYp0YEmhwNon++/ZNjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437161; c=relaxed/simple;
	bh=aUCmLb5T+mxPk2umWT7xlgwi9Nl0jJVinTXxWTMCbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE/fVLiByyVHwEsQHROR75V0xUKTqEWAxBVJXoWkw3JpO3427Wejc+UYvvxgYgyYxOMXfZFLwM6i9DeA4QWRoxjo0lJAbhyR7WYJv9Rmvx5Xa1oUdr62ipHP/RPRxX4Mfsh7oBAroggoVhYVY2RmS8tnt0PdzQx9bWi4OMZuoAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA844S4z; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA844S4z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38101f85591so781738a91.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786437160; cv=none;
        d=google.com; s=arc-20260327;
        b=G+axbi2zZmGzbB4cf0I0xKRt2Y15TRCiWsblEeOvQAcZqDxAodlhKw2Z6is+hPmPIf
         NWz766d4+ayYXHd6JcOdpviiE2tGY0Aj7JaWOUC6G6I0q2hsZXKNDTFLBb8o4/Goavrq
         HWNO1/DS68+Y2/9wdb9A7rm9JgeNOFrc19eaMbioFwCTVAUfxrf3JLqLzAKVsDTTInAE
         1w4pv7vJw7rEEImQS5KySPOVTmzNxLagXZSselrDgLZxJwQPQfHpBifXajxe/+LJ3/1C
         sFfBCvQyrt4bMG0UtUqCxRIhlLJKkFsA2SMasiGgdRRknAnun/W63kXtPEiA0j185Jit
         MvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAcppQV7UlGr+QnmFYjZn5Lw1DGDbOe4UhWUgGpZFXo=;
        fh=KFNjeyWgmnf7cA85VfKAZ5S2SzPYhEM9Piv1MnIZ0+o=;
        b=eqpGZstBsRunigDrBRggAFuUXr/UyE1iJ25R5Hpu+7lIhTVcszvxasK2x4kHht7x+S
         rN865c+URickCgPsXqQI5Pi5d29NwB0Rj6wTxOqUBt68VJ9TRnC1+o25GBPhtJ4ObuxQ
         jDsp9fZqb8uFXwfxQ/4gjRL4wzAxcZ1Jk/Byy0CqYs0kI+7sr0/91ZWODCVjwj5Gj5It
         Cg30RZ9lHuUNGx3fd3X/mFFpvcQWmU0KelBFzviEcNiobaXO+8HyteGjTQA7PGMGZ/bZ
         ZDXjUYjg6qu5YWXA0af8Uy0TNCRwM/Jzm35rhFwKsEXM9lp1Fh855S3v+GbLMWp3QCGd
         wiAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437160; x=1787041960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mAcppQV7UlGr+QnmFYjZn5Lw1DGDbOe4UhWUgGpZFXo=;
        b=jA844S4zGyO7QOXo3dfYppD9Hqi9RtZo7GuPpjjC0DmlnAGrrxiIHM7qrns7OVVjJQ
         QbMI+UkWU850yjykuU8jaUHtD4UReKASiKceGvi2qLRamV0qU7QkC6bXxUJqXL8o9cJn
         lqRiM0AUjkmvnix1Mw+F80+yjReaz3S0aX8swAIWCi0Eyqv6dLfX7f9p2n2w2FVs4dME
         DxOgyF9lyNptTxLgpmjQa24l1/YS/9Ap8UYMob/JIDtKTQCyaYTKF0KEK2imPQM3bSgo
         Jab75s93dDPlUyXsWlvuo3eP14lw8hS45BiOaYTBpIR5hAH3KaBxduzyHnaaK1QMpBJh
         CqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437160; x=1787041960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAcppQV7UlGr+QnmFYjZn5Lw1DGDbOe4UhWUgGpZFXo=;
        b=GFOAO7azyMgrKQ6U+LXorU/zU8iZwuT0pL1G6BTrGvtQSwVFN8EK+wWrdr5rzVbISU
         OxIv8lfvAjw4K8MRbZLpxfoFCixhiRhZKh3J8tfxQOyX4bVY1XMWBMTLHft9i3l32+PE
         4Fpka6TT9rFaZbSaMQWD65r+wa7pg5Lclr6+IxMtmP88BIuhUGcyI45ITaJLSPCnxwg/
         051N6IeQC96KWh9IK6uSosXWHSJQAJzun+nbe/CTDl4E0mwTSsFPPspb1pjAF7tB2F84
         ezxzAaCgI/FLE4y4nX0msYVNRvFKHAWw+Sm1CAcYuCgabeyFq+CEqe30wGF3fhdpMTIZ
         /N6w==
X-Gm-Message-State: AOJu0YzBGsPrZFBX1wTFPrsmYE8d0WqQ3VZooIuaCdWMWb4jpXpLhtdi
	y20crOLbJye6GgfRipXf/PDdimJt7+MGZ/koPrZ4GzlcZp4gmFJ8VqVjk26WkUnrS3ioRqW+bzz
	ElYhUlZWDViehOYKZOZ7sgt5SdmgaSd4=
X-Gm-Gg: AR+sD12mrmIpg5VPexZIOwZRflEnZ0XWlfzQNWx+GJS/YUH0mwqBerUGuf//Xv1bHKs
	RdWpkkX/HfeEx6xd7QTYH+C0xbmHecmI0gsG/7rdn9yZkF7GVmTXmP6Gyv99AuU2gLtU/eqPcf1
	ngg6YhR8dFRNorKU35tNb261KHo+wv1wvxGMFG4n/Jln4rNIfVSq6LzGK5GJ2Rk1TVAtrgFQCDH
	9ZACSnM+DORuJlSgtDAjPNatkZIl9d3fGv9W7LKCGVSP8LOQ1ErvjuSgDiGIECM2B38F7H3vgR+
	nN1e5QYVQIIYOmpSoEi/NQ51jO8wVgz1HORtg0NzbNG7ZdEcJjNm8+8l7ExxRr+GPxskuQs5V+0
	T/8wS36FEq7eWLnWxVEOJobMAaaehMEfJAJu97ixnCpRk137ZnRbmcTdDHVLf0Q==
X-Received: by 2002:a17:90b:582e:b0:38e:7e9b:5fbc with SMTP id
 98e67ed59e1d1-392ed09f836mr779952a91.7.1786437159596; Tue, 11 Aug 2026
 01:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com> <20260804100355.1299498-12-christian.couder@gmail.com>
 <CABPp-BFfF+Vd6RY3pG=FVUH_93YZULfhcXdWCv6zcRSABfGBQQ@mail.gmail.com>
In-Reply-To: <CABPp-BFfF+Vd6RY3pG=FVUH_93YZULfhcXdWCv6zcRSABfGBQQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 11 Aug 2026 10:32:27 +0200
X-Gm-Features: AUfX_mwNTiJAMJf2HG1MyIcvej7jxrLxm1ZIaJUU1tN7-NbBCFZrz6OZpeuCUV0
Message-ID: <CAP8UFD01-NW21CQ2LfMZ1shKLOnzKL0U_UjzzS4PoGf4GKK8AQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] fast-import: use parse_options() for command
 line options
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 9:25=E2=80=AFAM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Previous commits have started to use the parse-options API to display
> > output from `git fast-import -h` and `git fast-import --help-all` and
> > to prepare for parsing the command line options using this API.
> >
> > Let's now actually use the API to parse command line options.
> >
> > This brings a number of changes that are mostly beneficial:
> >
> >   - The `--alias`, `--get-mark`, `--cat-blob`, `--ls` and `--notes`
> >     options are no longer accepted on the command line. They were
> >     previously accepted as no-ops because parse_argv() fell through to
> >     parse_one_feature(). They are not documented in the OPTIONS section
> >     and are only meaningful as in-stream feature assertions, so
> >     accepting them on the command line was an accident of code sharing
> >     dating back to 9c8398f0c9 (fast-import: add option command,
> >     2009-12-04).
> >
> >   - Abbreviated options like `--dep=3D5` now work since parse_options()
> >     allows unambiguous prefixes.
> >
> >   - As `--cat-blob` is an abbreviation of `--cat-blob-fd`, using the
> >     former on the command line will fail with "option `cat-blob-fd'
> >     requires a value" unlike the other four options that are not
> >     accepted anymore on the command line (see above).
> >
> >   - The error messages for some options might differ a bit.
> >
> >   - The code is shorter and more standard.
>
> I think the list might be missing three behavioral changes:
>
> 1) A bare "--" (or a trailing "--") is now accepted and the command
> reads the stream normally, whereas the base treated it as a usage
> error:
>
>         printf '' | git fast-import --   # before: 129 (usage), after: 0
>
> The old parse_argv() broke on "--" and then did "if (i !=3D state->argc)
> usage_with_options(...)"; parse_options() instead consumes "--" as the
> end-of-options marker and returns just argv0.  Harmless /
> conventional, just unlisted.
>
> 2) Value-taking options now also accept the space-separated "--opt
> value" form (e.g. "--depth 5", "--max-pack-size 1m", "--date-format
> raw"), not just "--opt=3Dvalue".   Also expected parse_options()
> behavior and a nice improvement.

Yeah, in v3 I have added the following to the commit message:

      - Value-taking options now also accept the space-separated
        `--opt value` form, like `--depth 5`, in addition to the
        `--opt=3Dvalue` form.

      - A bare or trailing `--` is now accepted and the stream is read
        normally, while it used to be a usage error.

> 3) The handling of "--allow-unsafe-features" has changed and might
> trip users up.
>
> Because the "feature" lines at the top of the stream are processed
> before parse_argv() runs, cmd_fast_import() does an early scan just to
> learn whether unsafe features are permitted:
>
>         for (int i =3D 1; i < argc; i++) {
>                 const char *arg =3D argv[i];
>                 if (*arg !=3D '-' || !strcmp(arg, "--"))
>                         break;
>                 if (!strcmp(arg, "--allow-unsafe-features"))
>                         state.allow_unsafe_features =3D 1;
>         }
>
> That scan (a) matches only the exact spelling and (b) stops at the
> first token not starting with '-'.  In the base that was fine, because
> the old parse_argv loop was equally strict (exact spelling,
> "--opt=3Dvalue" only).
> But now that parse_options() also accepts unambiguous abbreviations
> and space-separated values, the two passes disagree.  With an unsafe
> feature line in the stream:
>
>     # (A) old-style spelling, still fine:
>     printf 'feature import-marks-if-exists=3D/nope\n' |
>       git fast-import --depth=3D5 --allow-unsafe-features
>     # -> exit 0
>
>     # (B) space-separated value, newly accepted by parse_options():
>     printf 'feature import-marks-if-exists=3D/nope\n' |
>       git fast-import --depth 5 --allow-unsafe-features
>     # -> fatal: feature 'import-marks-if-exists' forbidden ... (128)
>
>     # (C) abbreviation, newly accepted by parse_options():
>     printf 'feature import-marks-if-exists=3D/nope\n' |
>       git fast-import --allow-unsafe
>     # -> fatal: feature 'import-marks-if-exists' forbidden ... (128)
>
> In (B) the early scan breaks on the bare "5" (it can't tell "5" is
> --depth's argument) and never reaches --allow-unsafe-features; in (C)
> the abbreviation isn't recognized by the strcmp().  Yet in both cases
> parse_options() itself accepts the option ("git fast-import
> --allow-unsafe" alone exits 0), so it's only the in-stream feature
> that gets rejected.
>
> This errs on the safe side (it refuses an unsafe feature rather than
> allowing one), and it's a minor inconsistency, but it might surprise
> users.  At a minimum, it should probably be documented as a
> shortcoming or TODO or something.  One possible solution is a
> dedicated parse_options() pass for just --allow-unsafe-features;
> another might be just requiring --allow-unsafe-features to be the
> *first* argument.  Thoughts?

Right, I prefer to document it for now while I plan to work on fixing
this in a more general way soon, as there are other places that have
similar problems.

In v3, I have added the following to the `--allow-unsafe-features`
option documentation in "Documentation/git-fast-import.adoc":

    Note that this option has to be spelled in full, and has to appear
    before any option whose value is separated from it by a space, for
    the unsafe `feature` commands in the stream to be allowed. So
    `--allow-unsafe` or `--depth 5 --allow-unsafe-features` still refuse
    them, while `--allow-unsafe-features --depth 5` and
    `--depth=3D5 --allow-unsafe-features` allow them.

and this NEEDSWORK in the code:

   * NEEDSWORK: This scan only matches the exact "--allow-unsafe-features"
   * spelling and stops at the first argument that doesn't start with a
   * dash. As parse_options() below also accepts unambiguous abbreviations
   * and values separated by a space from their option, the two disagree
   * for command lines like "--allow-unsafe" or "--depth 5
   * --allow-unsafe-features": parse_options() accepts the option, but
   * this scan doesn't see it, so unsafe features from the stream are
   * still refused. This errs on the safe side, but should be fixed by
   * teaching this scan about the options that take a value.

> Anyway, other than the above list of three additional behavioral
> changes, the rest of the patch looks right.  Thanks for tackling
> modernizing this command.

Thank you for the review.
