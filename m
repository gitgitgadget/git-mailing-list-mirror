Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA60327204
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786173951; cv=pass; b=S85NI+mQSWgUULhJGvcQT0fvRopem3qima7PH5Wze0N2o8kwYsRt03ucioWM8lGczXuuEN39owZ0N6YRHERZIlkUZyfOppjRlPYQVxn7wMkm1faONeXcd5pGuNbZYJ6Dtro8DqtU7uJzhh1tcS/hNlAdTzHPzj5qVDEwp/O18SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786173951; c=relaxed/simple;
	bh=1DTrmA6XEwNTfUdd91R+xJFuRqi9z05tENNdIJlmXms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI6aFN69X/36ynOlYWF6ul+FyeZ8IJ7yRM8kwJLNVlnze5Q5y3BV4UPDlcxUmb9HeAGKeWio7VH2A+8Ft6/5QQy3/f0KN7SAGFLxmaKYgp5SKkoTTJCa2ifzPHCqXp2HmuzpnL9KlTdKVGWVSAAM1vOOR+cthpDUfpBtGW/X4UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4QknvnW; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4QknvnW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4ab70b882c5so146064b6e.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 00:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786173949; cv=none;
        d=google.com; s=arc-20260327;
        b=XciURNa8PQONW4iUdeWLWFCja5VblHY9ghvna8dYVZdCct/fa8CVpbzgzeixVasSTZ
         clWv7eWMfgPd46kI3sfilKg/q+uMcrBgLQbGFSoW26hzku30qhbAwbkaio9nJz7heDAy
         3hfcm21a47jRKUzfDtT+G4/TkYnLUwXGcHSOC35Lwib15qOPvwJ3Ok6XJCOindd4dxsm
         0UKbvqAL2qU6tT5SHWK4E5ABbe/HYDgTmnUAw5l299VSHrcFsqQu2aM5f3WkOXLDn4IU
         yZ/+oODBcbxBkfTWw61HJWQrwL/5GZTSiUTWyRoPUnozAdnveuuvCmfcScfnJgnWVLbK
         /Vfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gopXJGC+F7F0lswtQUxidagtboo03YxaXAezr+Qqj5Q=;
        fh=dzZik3sWO5Hm7VdeOg6TogxYFNxNltXRHvX8714ZSR8=;
        b=eX4NExDZzIcq8meM9sy1Bo4wyolBB91AiSxDCA4tGRXnhvE8LflTDRTe1uoTIpbDWM
         fZ4FXg8S+2libI6DzYL4qT5tX4ZTkdn6hznZDxIdQlKwa9y4eWVA4sws+vTMJjclK1UQ
         iFjckM2npIlk8RXVNPdOVRq4Pmq4uiUv5SxL97Vs9m7Hr6rYjwgzzsfTTM9lRWklqNPP
         dZ4oo+KarH6GmMKAs+gM51LSyuWTZ7vUWHto5WCjl5/4Orhg/pHwE0gxYQ5m3/WbCgUK
         yRD1GpHZuE0Qb4k0u5T7I23M2jgsDgCesu2oR6I9wpBDk5+z/HkYUUqCZksU48F2zbc/
         0AOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786173949; x=1786778749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gopXJGC+F7F0lswtQUxidagtboo03YxaXAezr+Qqj5Q=;
        b=I4QknvnW8Rvz6dUGO7DdFzeJdmSZ0Q6zR9qjOoct1rxDRToq7pJkuSyB1R/n8lAfv8
         svKYmS+BCbW+89C+qsRO65dtRpIoDqMogX2doTjBqUnnpbR3vJVB1A2aZgkeoOWXi6F5
         cczdG+H6QN7nu5WjkntbicqIp4+aipdHTwIT/6f2Fs0uXpqnP327Q6D5GP4YL5XPtMyP
         EThHhkdyeUPvrY+81fjM5ayRTpJkhx5nr+bZIdyX1Xm1I1sXniaDeBFz+TT4EF1NRQY5
         +RWKEnNGCcfacE1CRFjumcsN1lGlhVOTJSeqVh4AJ8RHCbmCf6MU80rXGrm4+gNFKdjf
         I+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786173949; x=1786778749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gopXJGC+F7F0lswtQUxidagtboo03YxaXAezr+Qqj5Q=;
        b=ZQBr/Yg6VGPQF9o+j/5EOvl8Nj4awfE5Dxfb5PwJIkr/nbswSrVVAaVdvizr3/qdUG
         YP2Jts1E91ZWbPLLav2kKTrV7rgN6hGzzuxkH7NX+uUp4pXsAoKMZ3ssbVk9VF12pSsw
         xiu+VExU4znnBcpJ/qxK05Yx2fp4PV/qbpzbKNgxIFG7ZP0KbUCuFkbKJR0MFBawdto3
         6lkE56GPsPiSwYdFH4ikmq/BJQqG4XIa3TryIu+tKyMmloMdYxGqgwTm4lPxJhKj7qy6
         zsnRpeeDnlN7xXKFDOGUa0IumJKKQ2RxKrVFwtS0O3UQZN0RqYfz14eq/O0y//l19kfg
         TWqg==
X-Gm-Message-State: AOJu0YyyfvRct5MR9Ak9Gnjpl42YzNEhAcaCCX36y4oCSHm+ueDgcS4x
	mnzKKLHc12G0Y5NLvNxaC1lZRlVbhyGsnLMF7YWvUc524MR/aclW7rmWBeV9eJgxypVZdSDThGs
	NOila02HvOamkaGKheekAvyQATHf5Hsk=
X-Gm-Gg: AR+sD13djI+i0g8T1B64I1/2HK2ibaJWkkjRWoWVzYpiGDZxmYm1tLQxdO1p2VG2Z1W
	TdlPc0IEA7twsx4wNw/IhRZIFFix8nT7xWkgxd+WdzlZzPSGQAFzH3+fLcsKiDRt9Ex2+EbFEQ0
	ABU3lFWGrPOZQCFowY7Er0yyANawBaxTpitOabUN//y1Hs7wX8zJb0ldVr/xiD3iPI0WvzKk13e
	RRJtwSEkKEiQn/7FYfKtplyMJqFGAmtbAnExF+3c4KawUT1531YEc0zpZXyoHaGNqsJtttwmggv
	ygBmus6M+FY4mg1Afla6xkbxdfW3jF/fuMpe8z5x9ZulO0qMPnxVMokS+0PGNodiMekyS9CEyr2
	saWDr5D033FSyZCfH1KjyRcaNDk2KdKdkse6AtGq9QtnoRyz7a3pdtXWWMaPWygw=
X-Received: by 2002:a05:6808:d4d:b0:497:8f1:df07 with SMTP id
 5614622812f47-4afadf2fd74mr15376226b6e.7.1786173949583; Sat, 08 Aug 2026
 00:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com> <20260804100355.1299498-12-christian.couder@gmail.com>
In-Reply-To: <20260804100355.1299498-12-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Aug 2026 00:25:37 -0700
X-Gm-Features: AUfX_myfJUktvGk5o6mYc1xI31vhwvS90iwTFMk-a1Y_zJXzqGA4J3K-9HH29kA
Message-ID: <CABPp-BFfF+Vd6RY3pG=FVUH_93YZULfhcXdWCv6zcRSABfGBQQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] fast-import: use parse_options() for command
 line options
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Previous commits have started to use the parse-options API to display
> output from `git fast-import -h` and `git fast-import --help-all` and
> to prepare for parsing the command line options using this API.
>
> Let's now actually use the API to parse command line options.
>
> This brings a number of changes that are mostly beneficial:
>
>   - The `--alias`, `--get-mark`, `--cat-blob`, `--ls` and `--notes`
>     options are no longer accepted on the command line. They were
>     previously accepted as no-ops because parse_argv() fell through to
>     parse_one_feature(). They are not documented in the OPTIONS section
>     and are only meaningful as in-stream feature assertions, so
>     accepting them on the command line was an accident of code sharing
>     dating back to 9c8398f0c9 (fast-import: add option command,
>     2009-12-04).
>
>   - Abbreviated options like `--dep=3D5` now work since parse_options()
>     allows unambiguous prefixes.
>
>   - As `--cat-blob` is an abbreviation of `--cat-blob-fd`, using the
>     former on the command line will fail with "option `cat-blob-fd'
>     requires a value" unlike the other four options that are not
>     accepted anymore on the command line (see above).
>
>   - The error messages for some options might differ a bit.
>
>   - The code is shorter and more standard.

I think the list might be missing three behavioral changes:

1) A bare "--" (or a trailing "--") is now accepted and the command
reads the stream normally, whereas the base treated it as a usage
error:

        printf '' | git fast-import --   # before: 129 (usage), after: 0

The old parse_argv() broke on "--" and then did "if (i !=3D state->argc)
usage_with_options(...)"; parse_options() instead consumes "--" as the
end-of-options marker and returns just argv0.  Harmless /
conventional, just unlisted.

2) Value-taking options now also accept the space-separated "--opt
value" form (e.g. "--depth 5", "--max-pack-size 1m", "--date-format
raw"), not just "--opt=3Dvalue".   Also expected parse_options()
behavior and a nice improvement.

3) The handling of "--allow-unsafe-features" has changed and might
trip users up.

Because the "feature" lines at the top of the stream are processed
before parse_argv() runs, cmd_fast_import() does an early scan just to
learn whether unsafe features are permitted:

        for (int i =3D 1; i < argc; i++) {
                const char *arg =3D argv[i];
                if (*arg !=3D '-' || !strcmp(arg, "--"))
                        break;
                if (!strcmp(arg, "--allow-unsafe-features"))
                        state.allow_unsafe_features =3D 1;
        }

That scan (a) matches only the exact spelling and (b) stops at the
first token not starting with '-'.  In the base that was fine, because
the old parse_argv loop was equally strict (exact spelling,
"--opt=3Dvalue" only).
But now that parse_options() also accepts unambiguous abbreviations
and space-separated values, the two passes disagree.  With an unsafe
feature line in the stream:

    # (A) old-style spelling, still fine:
    printf 'feature import-marks-if-exists=3D/nope\n' |
      git fast-import --depth=3D5 --allow-unsafe-features
    # -> exit 0

    # (B) space-separated value, newly accepted by parse_options():
    printf 'feature import-marks-if-exists=3D/nope\n' |
      git fast-import --depth 5 --allow-unsafe-features
    # -> fatal: feature 'import-marks-if-exists' forbidden ... (128)

    # (C) abbreviation, newly accepted by parse_options():
    printf 'feature import-marks-if-exists=3D/nope\n' |
      git fast-import --allow-unsafe
    # -> fatal: feature 'import-marks-if-exists' forbidden ... (128)

In (B) the early scan breaks on the bare "5" (it can't tell "5" is
--depth's argument) and never reaches --allow-unsafe-features; in (C)
the abbreviation isn't recognized by the strcmp().  Yet in both cases
parse_options() itself accepts the option ("git fast-import
--allow-unsafe" alone exits 0), so it's only the in-stream feature
that gets rejected.

This errs on the safe side (it refuses an unsafe feature rather than
allowing one), and it's a minor inconsistency, but it might surprise
users.  At a minimum, it should probably be documented as a
shortcoming or TODO or something.  One possible solution is a
dedicated parse_options() pass for just --allow-unsafe-features;
another might be just requiring --allow-unsafe-features to be the
*first* argument.  Thoughts?


Anyway, other than the above list of three additional behavioral
changes, the rest of the patch looks right.  Thanks for tackling
modernizing this command.
