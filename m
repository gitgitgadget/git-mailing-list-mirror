Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628461FA8F2
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587709; cv=none; b=pNjUdeCnLT7wBrFl5J91c3Ntsuj/fEPAgSb2P1R14U2dqoBrwmZbxQRLKo3zi9xy4yrUiLLkqvfmU4MD6YBTbq/+AZA5PRlcJSTkctiss8V0XYEjRzYNpii1ZKGnPXX1Vo4uPwQPDcrtnXWuKgHfKK7CCduqdwa5yN2CUNMfNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587709; c=relaxed/simple;
	bh=/yWxogSwhk1U+GfnM/4PYdHLj5RSODTKauV436/2UVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYVTJoW3gN0grr1Ni2rGzNepusRJutTNMJ60L3oUBhSX7pNWhkGvY5DsXNpIVl77cC6LqOnr01F30H6fAYIDymAxqJsxD1cn4QmPmPo3v545ZbRO2HGTSIJrAwh0I1nRFCLRIR8+jmkfnVkAAb0k8M+tZP49iw+3T/ilCjsbFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46784a8fef2so808771cf.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 21:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587706; x=1735192506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbYA24E+SfeQbGjG6LmkyhMW475eagH7zJofAdswU/I=;
        b=DKG2E1ZIcQRMTR23oOKTBouZ0uXFPXlLJvQS83C++IDDmg2jWHS7hohYz/MhBeSXUW
         UoddW3IkyQ+K6BzLr/yYVWXxCYEdeVXnj/JHvjglvUzRstHUifqFTNhHhy2dhu2vvs99
         mORzpQ5drEItjxEiu+5F2e/2SvpwvSp0AGjgKCA87xe3sEc9SbmqzBgyjP9VKkdPOOH5
         d4OIjF3JDpzD02QddRShwVTi+jWvVWhIQYmMNUX+cdX6KcmUpb+dY+ZVvb/45jU7s9Zm
         2ExCE1er01oLeRTmYo9Cm+XH8sEIClsyuS+i+2wz8rMPzzOD/fIy/1QVDK/xi2DYa3qY
         zHYA==
X-Forwarded-Encrypted: i=1; AJvYcCUhdL2g87raDoaUf8aKwR+zEhBiYzh1falntt+VnkXu4kU6vQRmmw+Nt2FIhyL0zBSfdsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/WkqAAHPsLDNH8FmqViK6aZh9NZprE9+C7U0QQCYPTCIs9rQ
	OZIIgGc6kGu66xSCeFIChmrgTtE5eP8eW/rBfZDMlRyiBdpclnrPMjJJeRzLOSQOpmgi52x0+YJ
	/6omAMzMmOgydilq7hAITP0BMlJE=
X-Gm-Gg: ASbGncsASeKyurwqtZa9OhNK18GnsrX0TeOZ25RJo3IP7EEjf62o3Qen3AxS1dfRiuj
	8gak4Vaq9fcbQKDFBX9624nJY1KyJSnQT90veqeV39V13GbdxJIxls53eB6CC2g7leeEYGGs=
X-Google-Smtp-Source: AGHT+IFVe+Pr6LboRYH8lEcASvi4qLWPVJ8yoV6qdqLS58AQnsUkphaR2Ymo5Ux6cqJAWTAsc07l8831TH4X4ON62D4=
X-Received: by 2002:a05:6214:2aa6:b0:6d8:cd76:a44d with SMTP id
 6a1803df08f44-6dd090a81a4mr33650766d6.0.1734587706199; Wed, 18 Dec 2024
 21:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
 <Z2LOpOxu0oAY0DW3@ArchLinux> <CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
 <xmqqv7vgo4u7.fsf@gitster.g>
In-Reply-To: <xmqqv7vgo4u7.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Dec 2024 00:54:55 -0500
Message-ID: <CAPig+cTf=Lm_yNWQPq2SKfuROhSMMwNVXNmXhags43SRKonwxA@mail.gmail.com>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, AreaZR via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	AreaZR <gfunni234@gmail.com>, Seija Kijin <doremylover123@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Wed, Dec 18, 2024 at 8:30=E2=80=AFAM shejialuo <shejialuo@gmail.com>=
 wrote:
> >> On Wed, Dec 18, 2024 at 02:20:45AM +0000, AreaZR via GitGitGadget wrot=
e:
> >> >               if (is_main_worktree(worktrees[i]))
> >> >                       continue;
> >> >               ret =3D 1;
> >> > +             break;
> >>
> >> So, when we find a linked worktree, we just return the value. From my
> >> perspective, if we decide to optimize like this way, we could drop the
> >> loop because the first element of the result of `get_worktrees` is the
> >> main worktree. And we could just check whether the "worktrees[1]" is
> >> NULL to do above.
> >
> > You're correct. get_worktrees() guarantees that the main worktree (or
> > bare repository) is the first item in the list, so merely checking
> > whether `worktrees[1]` is non-NULL would be sufficient to answer
> > whether linked worktrees are present; no looping is required.
>
> Would many other callers potentially want to know if the repository
> has more than one worktree?  It looks to me that the has_worktrees()
> helper function in refs.c is a sign that the worktree API is missing
> a function.  Calling get_worktrees() to prepare a list of worktrees
> and then counting the result, only to see if there are more than
> one, sounds a bit wasteful if we need to do so too often.

If the need to answer this question does become common, then I can
imagine a function being added to the worktree API which tries to be
smart about it by only calling readdir() -- and validating a
.git/worktrees/<id>/ metainformation -- enough times to be able to
answer the question.

However, although I haven't audited the code, I suspect the question
"are there any linked worktrees" is rare, possibly only asked by
`refs.c`. And in that case, it is asked only at the start of a
refs-migration operation. Moreover, it appears that even that case of
asking the question is probably temporary, existing only until someone
extends the migration logic to work correctly in the presence of
worktrees. (I'm sure Patrick can shed more light on this, though.)
