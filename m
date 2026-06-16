Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13535839C
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583567; cv=pass; b=rDjGw2Es4E3kP6YhGgkTBLWhBLoqS9oKMfQbfgsjJaqCA9uyYfnL4pUfJuNkRtsOFyesWNIv5oUeJ2j6X23Ke6sE5iZUyJUVurWSneMDbLemFTEYoxSbGJGlE4D1gtdjAWiJsv3nTprbZLFO/f5peP7tmsDfSp59/35GYgfUTz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583567; c=relaxed/simple;
	bh=SYNvLWatuWUBg53jH65PK/1N7Q9gyHzFovqHASHqkKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6HnAvvg8vIHueIfsBoJkKbJogAHeOTygufFqBgtS7TxDVC2ebPCV33lMBhZjiZvm8OYWuVzmUSZvFtXZkBcZjrj571f8RVTjd4MGuHLZ+1xkWytuAtnkyQKeAL5Tnq5dcjYUNuHaC9nFYZj8BvyobAqrD9ZoJ6e2AA1ODAVADA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqOiqCL3; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqOiqCL3"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-660390a8999so4379173d50.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781583565; cv=none;
        d=google.com; s=arc-20240605;
        b=UOeCgHxgbww/Tz446S3KbQ+/o5/sT2mzVa1ZzOOJwLgf/yT1qwrqjxzMcSMvhILQUN
         7S80o02T509D6lcmPzyG+5YTGvYqHdGebhytRiJRAO4Cy559OvUvMFUPBZPoYfNtMcC6
         /Q7Q4lgz0MqkTgEbKnM+Ylj0i4IDwPW01HrAusTc2kOTEJgblEyGF1DTY6vwSPHeTWwp
         l4hSL6kC6isPmih4l0zxBZy8VFDwAit5DH0tbHTzLwWWyl6FKQMeVCarOXSaYh8R2AD6
         qtDYFvTarLTKOZA+wA5qzFdcS4UBjLOZMfgC3+3mtUkRzDf1Hv3A/wSHwnmfDhxYhqZE
         V4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YataI2kI5H8/+fyaQpsNNmyseaOSaJZ8n04w+H86d7s=;
        fh=BB2t2fnz0EobgBkcsubrt6cUgswygpqsDgtm3fvlvkA=;
        b=bmFqT1NOPt2x5j1yDB/1KPfMRmAnXoKJ/CXN976ccQltBElw9Lilocyn2fjpgiRuEr
         W8ufpMPJd8/UrY+n2DEOusrGJv3FVgD0/Qs74ZiPRrhwi95s7aDyKYXI5+nOwYnb3vYc
         spmCC00SrLszHMVUNfAd/gpMtMVPzf3gaxFDlEINV/R+1DvGO3ksULXAfmH/RDNXykb5
         BxCxWcQesBBcWYj/MhxkuMbJFTOZLJL1Fv9h3y117CTvFsbEycN1oAKNgG8lbGMM74Xu
         LFmwsaTB31SRHeLVK4Y6a1SPvASw7AuCxUpW/ChkDN8SzDZfSaRBFMhv+LREu8rYUUvW
         Oiag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781583565; x=1782188365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YataI2kI5H8/+fyaQpsNNmyseaOSaJZ8n04w+H86d7s=;
        b=HqOiqCL3ftOhLlsG1ausdLmNZllLoYh3ZoSmpsChz2eprXTtDkgJSzuZJpz+Qol5Ky
         MllZTfkih+0c6pWqpzk3AMNvKahbR6kk5URoEIa32XdJ91o4/0HVK6RHwGo8SonDK7XX
         Eir2tw1H8Bq3JxRmxuW3cHmrzmFkQkwvHpImesiQT8MMk3ixRTN7OPJvOAQ+590m1J84
         tFXUnA6DB676Vi15jU+1on/tVs5q1xgihugMMlOG9aDTUfX8slBNLhTEZz9enZstb3bY
         zMvgmG+zvyzAIErPzeyS7irQARmXbsIK34bSDF35/w7teFRhUEwJndT3cZUVtgkalVjm
         XlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583565; x=1782188365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YataI2kI5H8/+fyaQpsNNmyseaOSaJZ8n04w+H86d7s=;
        b=WarflzdIcgLHGsYyNqNAIloG4G7oi/eywoDlvRJ/0X6xNTMBmw5FFdCZdYV1Z03+6j
         uSwZHGNCTvrHsPi12OkPZp/uFFkMzq6BUo4ArxlwS1avZQrLerORqbyjk+/wylAM1WAc
         h3w8fFzc62TMY9NmfCk7agjtCMjK+J9W4Vvg+I3zHP5tPyJ9t23+UbVow36WQp7z2WJs
         UAmxL3FpaR1aT4CnU5kCPXJddKV2uQ1MARLl8YZRxU04vRl5MuWv+zYutd1aOqNPZYSu
         RKYAQOVXiLt8UYDRbRlZ1c1MmXVzOzidUPo5eh/UqUdjEqHe5UjBhQrSY/Us6/RFZSqF
         Xi1A==
X-Gm-Message-State: AOJu0Yzzq9ISLo7qvLbhZvIQztIXEOwN7+1TlLDiP2jE3sdMFzHWSKWu
	WgPi6IgLXd4jhy8wNyw9mVg8EtFeBL2/Ze/VjaQsDXB2zyLhkcoJP2sUiUPAgGteiBea10kj5gb
	2j9kL1hq8QuWcMse14wzlHJ+ALAHRGBo=
X-Gm-Gg: Acq92OHz1IWJfvWrs3/r/bZ8Aumkh8+5OGBXNbNBWxnNyxBL6ZZR2R2zv43e+NpGL8r
	RCVobhOPP9N9lg5Q2T1mOL7aU/JW6ud6xAg7ni/RIIDgA+tXyHJDHNprZmDEl29qKjkMdXX6XiZ
	N51LsPLOFwUEiAoFdcnSsQHMgqYcYyiOOywTx6nPEGO+caFEVI/89AZES/QOdS4T7DnzBhG7RXB
	0quH4RpU9QX9wg7lcTvNarzbCJyw6KOJDy93N/nTAmFRqXnl/NFj2ETFmHnHWvrzLUfhdwNj31c
	SEfsKYvWWO8yA7Je+LxjOxUAASTklYg5G3owUk4SSbaz0Vbn9PlyOcqd+K+J5sHOQUbAjn4QVkj
	krUV5PYQMRfl7UcQLExmW1FF5mA==
X-Received: by 2002:a05:690e:4384:b0:660:ef1e:5efa with SMTP id
 956f58d0204a3-662850c2501mr9677555d50.40.1781583565143; Mon, 15 Jun 2026
 21:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-3-jayatheerthkulkarni2005@gmail.com> <ajAy1it6CGDQzVes@denethor>
In-Reply-To: <ajAy1it6CGDQzVes@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 16 Jun 2026 09:49:11 +0530
X-Gm-Features: AVVi8CfF80T6HpPVm5AMSQq0A3nKjjZQUgh2rrZCrmEO015ZEAhmNKBT2nivcLM
Message-ID: <CA+rGoLf6Tj-j0r3cCReBaKK5bGFUALJ638-yPi2GSoRML0kbgA@mail.gmail.com>
Subject: Re: [GSoC Patch v4 2/4] rev-parse: use append_formatted_path() for
 path formatting
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, 
	phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Justin,

>
> Without context, it might be a bit confusing to readers as to why we
> override PATH_FORMAT_DEFAULT without our own provided default. It may be
> worth leaving a comment to provide some breadcrumbs.
>
> The rest of this patch looks good to me.

That makes sense.
That's a minor change.
I will add proper comments!


> > Add a test helper test_repo_info_path that creates isolated
> > repositories per test case to prevent state leaks, captures the repo
> > root before changing directories to avoid eval, and accepts an optional
> > init_command to cover environment variable overrides such as
> > GIT_COMMON_DIR and GIT_DIR.
>
> I'm not sure this last paragraph in the log message provides much value.
> To me it's a bit verbose and focuses mostly on what the test helper is
> doing. Maybe we can just omit this section? If we want to have a note
> though maybe we could say something like:
>
>   Each path key is expected to have an absolute and relative form. To
>   reduce duplication, a test_repo_info_path helper function is
>   introduced to configure and exercise both cases.
>

Now that I think about it
Maybe removing it is a better option.

I mean the patch itself contains the test and it has comments explaining
the test itself.

I am gonna remove the last para in the next series.
Thanks for pointing that out!


> > +test_repo_info_path () {
> > +     label=3D$1
> > +     field_name=3D$2
> > +     repo_name=3D$3
> > +     expect_absolute_suffix=3D$4
> > +     expect_relative=3D$5
> > +     init_command=3D$6
>
> I may be overthinking it, but I can't help but feel this test helper is
> overly complicated. I wonder if we can simlify and reduce the number of
> arguments. For example, could we programatically construct the label
> from the field name and init_command instead of explicitly passing it?
>

That=E2=80=99s a fair question
But I personally don't think the helper is overly complicated.
I think a lot of the current helper can be mapped with test_repo_info's
structure itself.

The existing helper uses a very similar 5-argument signature (label,
init_command, repo_name, key, expected_value)
and separates the setup step from the assertion steps.

Regarding the labels, I'd prefer to keep them explicitly passed in.
Programmatically constructing the label from the init_command could
result in messy
or hard-to-read test descriptions in the console output,
and having explicit strings makes it much easier to debug when a
specific test fails.


> > +     absolute_root=3D"$repo_name-absolute"
> > +     relative_root=3D"$repo_name-relative"
> > +
> > +     test_expect_success "setup: $label" '
> > +             git init "$absolute_root" &&
> > +             git init "$relative_root" &&
> > +             mkdir -p "$absolute_root/sub" "$relative_root/sub"
> > +     '
>
> Do really need this setup test case? Could we instead embed the setup in
> both test cases below? Something like:
>
>         test_when_finished rm -rf repo &&
>         git init repo &&
>         (
>           mkdir repo/sub &&
>           cd repo/sub &&
>           ...
>         )
>

That's a much more elegant way to handle it.
I will incorporate this in v5!

> With something like this, each test case is responsible to creating its
> own repo and cleaning it up when finished. Then we could avoid have to
> provide a separate repo name for each set of test cases and remove the
> repo_name argument.
>

True,
Thanks!


> > +test_repo_info_path 'commondir standard' 'commondir' 'commondir-std' \
> > +     '.git' '../.git'
> > +
> > +test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' 'commo=
ndir' \
> > +     'commondir-envs' 'custom-common' '../custom-common' \
> > +     'GIT_COMMON_DIR=3D"$ROOT/custom-common" && export GIT_COMMON_DIR =
&&
> > +      GIT_DIR=3D"../.git" && export GIT_DIR &&
> > +      git init --bare "$ROOT/custom-common"'
> > +
> > +test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
> > +     'commondir-only-gitdir' '.git' '../.git' \
>
> For each of these test cases, the `expect_absolute_suffix` and
> `expect_relative` and exactly the same. This also appears to be the case
> for the test cases in the next patch. Do these really need to be
> configurable at all? Can we just embed them directly in each test case
> assertion? Or maybe future keys will need this to be configurable?
>

You're right that passing both is completely redundant!
However, the path does still need to be configurable because the directory
name changes between test cases (e.g., `.git` in the standard case vs.
`custom-common` when GIT_COMMON_DIR is exported).

Since the relative path is always just `../` appended to the directory name=
,
I will condense these two arguments into a single `expected_dir` argument i=
n v5.
The helper will then just construct `$ROOT/$expected_dir` and
`../$expected_dir` internally.

> > +     'GIT_DIR=3D"../.git" && export GIT_DIR'
> > +
> >  test_done
>
> Overall the rest of the patch looks good to me.
>

Thanks again!
These are helpful.

Regards,
- K Jayatheerth
