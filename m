Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801351898FB
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815850; cv=none; b=IFe6ufs9aIhbsNo8a+nvPcRxPrm/f/3NGpEpbTC/N/Jh6WDy9nMTLMTN0DeAfk4AVk47YofOxAwwzmqHpT8IRPY9ZScrZ0fDmE4YtC5/rXYP0g7KQA8XS5R61mm5GM7WhFLu0ezAIZ9zu/lh/q8ji6ZBByHp/eO6GB1XJ5Tu1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815850; c=relaxed/simple;
	bh=GYhhGIiJw5kW04MOIKOxdQTaCmSFknyFTZuk1IaqgbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmfAvGanPVWDMG68uE4rvjrxLpgVW0la7dJl55vduI67F/bYIrfvoTI9k4u1Ugmye7g6SO76/NyXZH3xev5w83r2At0r6ZtiO5nxmrH6O6h2g+NZ4EyDztnlmCaVmistGu4rkU+H1A8pxiLQg05HK3LVbu7jFTEjrzMqZfzqAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYLUS0Mo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYLUS0Mo"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769b16d4fbso38599461cf.2
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815847; x=1745420647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jR9wUhU7wfBr0H+SCVHAlHxHWB9/kG7uOcvZVNC+TAQ=;
        b=iYLUS0MoGQo4afQ08z80ggpXf5tiVmxfrux73sR3INXXRlLr53/+tpa5GU6XPbA7NI
         CJt16+lWTXHObBkrD+K9w1rFjg/kNnUyT5CGebaNPA2zxYdlkzm5Nbu1OOmDV5539/cY
         T2CLWkhWDOpLE649EFit9vz0zgfOBmOZd9P8jGsEBZoERU1MIMSvX3Jk/IJzPvmaeZtV
         kqIvLlFe7mFNgy+8N44psCDJBQTvlmym2/5mzCdgSPF5tkQwoC49VwTXx2aAnUjjAYW1
         S6d9a1fdcTv04IQ8zD+1xaa0/dcNIAiqqenqut6i/ksBGeKW94CWMuCMz9veipwp4eDV
         twsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815847; x=1745420647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR9wUhU7wfBr0H+SCVHAlHxHWB9/kG7uOcvZVNC+TAQ=;
        b=Dxeo8Tt/y1rE5BdJSF/CgsonovrmiaNorsh2ul2iCZ921zLfqoLcYxj1XNONR+YBTb
         GthomTjeVfMCwjksE0AnncMPNpwJiVINiz5JMKNtDjtgAl+Y5VKImojEztiPOXGvuqhZ
         qJabLVQ1n+62dUZvpUTu70g9ix1CkBXZxGOWikloUV/5F+cBx6CWMZJAHTNP7ujYDDCO
         0x8y+NN6oT6K2mnuR5A/le5Dkh/PRSv3wujfh7cVQrflFqeG1dCwBc4H3D0TqTrQALSh
         Sx9DqGCuh7eY4sV9phkWfJdYEwQeD+MU3DC/8Xf0pyv+CFLX4ssMtQbfL/DQfr9bbh5s
         shcA==
X-Gm-Message-State: AOJu0YzU3MBI+iaxyudSo0U+xK9f1zQSfRcEA15qWODsa78ciC4qhqYy
	ln97Zp0zE4HZjyp0h54jrRY91x2GFNbz/6xsATijqiOpcWQ54hW3VT10PwSnFtv1Dhz3z1k8uKh
	orWVkSRb+xUmMOj6DlsoBEA84+w==
X-Gm-Gg: ASbGncvli1mIQjYgV/aWT/v5qTSpRILLnQ63v/+T4GoOPYXG4nY9jHesqWnu45gIwqa
	AlUZzwFBeGJ7FLgBdZ8QAWhB6cSbEj0rBbHbmmS58NoAOEnq911Pavxyc9VbcUPRL3O89u6In/g
	rCe1Yrfyswp/BvNy+apxPQxKN087lBwQ==
X-Google-Smtp-Source: AGHT+IGldRgm3VFdRSlqXRKqAaykh/exabwARtPtyyCev1kzMB6Tso7sP90EBSm3JrxqKga5CZJqJ/aQ5xgBoHvGIao=
X-Received: by 2002:ac8:5945:0:b0:476:b764:e315 with SMTP id
 d75a77b69052e-47ad8168d6amr26304241cf.52.1744815847174; Wed, 16 Apr 2025
 08:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250412061957.81747-1-anthonywang03@icloud.com> <20250412061957.81747-2-anthonywang03@icloud.com>
 <xmqqjz7lo4o4.fsf@gitster.g>
In-Reply-To: <xmqqjz7lo4o4.fsf@gitster.g>
From: Anthony Wang <anthonywang513@gmail.com>
Date: Wed, 16 Apr 2025 17:03:55 +0200
X-Gm-Features: ATxdqUFI2Aq3ulgA8ZK-3QvsiPBHoTfIdmOOZIofkYGUqB_i5ascNVDGXnfbiv4
Message-ID: <CAOSofod9m7wHafP5=_tcMYW_oN9_icSmVX7rQioUkc_RC6pVYw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v6 1/1] t9811: be more precise to check importing
 of tags
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, shejialuo@gmail.com, 
	christian.couder@gmail.com, shyamthakkar001@gmail.com, 
	sunshine@sunshineco.com, Anthony Wang <anthonywang03@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Anthony Wang <anthonywang513@gmail.com> writes:
>
> > The tests use grep to search the output of `git tag` for tagnames they
> > expect to exist, which can incorrectly pass if an unxpected tag
> > has the expected tag as its substring. We fix this by using `git
> > show-ref --verify` instead.
> >
> > Additionally, we add a negative test to verify that a possible
> > uninteded tag does not show up in the imported repository.
> >
> > This change also fixes the original problem, where piping the
> > output of `git tag` caused the exit codes to be lost.
>
> The word "original" is misleading; perhaps phase it as "additional"
> instead?
>
> That is because not allowing to notice potential breakage by hiding
> the exit status behind pipes is just as bad as falsely taking a
> partial tagname match as success, and there is no reason to call one
> "original" problem, implying the other problem(s) are different.
>
> Other than that, looks excellent.
>
> Thanks.
>

Changed and resubmitted the patch. Thank you for the guidance on this
microproject, I appreciate the help as I am still new to open-source, and
I now understand the workflow and style of Git much better.

>
> > Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
> > ---
> >  t/t9811-git-p4-label-import.sh | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-impo=
rt.sh
> > index 5ac5383fb7..39856629c0 100755
> > --- a/t/t9811-git-p4-label-import.sh
> > +++ b/t/t9811-git-p4-label-import.sh
> > @@ -95,9 +95,9 @@ test_expect_success 'two labels on the same changelis=
t' '
> >               cd "$git" &&
> >               git p4 sync --import-labels &&
> >
> > -             git tag | grep TAG_F1 &&
> > -             git tag | grep -q TAG_F1_1 &&
> > -             git tag | grep -q TAG_F1_2 &&
> > +             git show-ref --verify refs/tags/TAG_F1_1 &&
> > +             git show-ref --verify refs/tags/TAG_F1_2 &&
> > +             test_must_fail git show-ref --verify refs/tags/TAG_F1_ONL=
Y &&
> >
> >               cd main &&
> >
> > @@ -207,8 +207,7 @@ test_expect_success 'use git config to enable impor=
t/export of tags' '
> >               git tag CFG_A_GIT_TAG &&
> >               git p4 rebase --verbose &&
> >               git p4 submit --verbose &&
> > -             git tag &&
> > -             git tag | grep TAG_F1_1
> > +             git show-ref --verify refs/tags/TAG_F1_1 &&
> >       ) &&
> >       (
> >               cd "$cli" &&
