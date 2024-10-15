Received: from mail.hq6.me (hq6.me [104.236.142.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373C2036E2
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.236.142.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017819; cv=none; b=L8ecTgHck45HSKZKwkzkTFxMxmNTL8ONw/NNug3jYjzdnFiGiM34OtUWRVhykPMmqug1dSATt0W9BjoFPFuOWp7kY/GV6wRtjAOeLW9Jb9eQrI4gSOSc3E5hr54iFhzuUKXxWbfLLj9DrlEpiGzg7fqy3edQgJgosa1eVLkeWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017819; c=relaxed/simple;
	bh=eWILzSHCjLsudxRTlkMwqu1HwLW+6elOKOFU7QmfGPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCje0XMX2tSIovutRer1Sg+Bh/uTE8lToE93xnuZkvOuRXwynMmDaBU0bni6fwh9256ikd7B7q4Xvwm9rUk7l18pnxlLKmembWaETtKyfltymcufDSDhrDGAcICD55Cj1k/mERb+pLC7ox2EBRf6dPHxaPaYlJniUT8+QoeNfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me; spf=pass smtp.mailfrom=hq6.me; dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b=QupY2zmV; arc=none smtp.client-ip=104.236.142.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hq6.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b="QupY2zmV"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id 2245F120A37
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hq6.me; s=mail;
	t=1729017817; bh=eWILzSHCjLsudxRTlkMwqu1HwLW+6elOKOFU7QmfGPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QupY2zmVr0K320K8D5Jandam5oPeM1A9W69YJ/Lew0SA8+es2ZZACXDzeJNj0m8NR
	 BVMWT4MauQSYm9I+///rlQ6TI7sUBpLyMokWwptdEwSTagkl3UjcRHqVv3NxVdGt7x
	 vAfyPaKzwfyqwxU35x11sV/oseRbBkVlZmugQi2nOtc0C+csOXs7M2dWHUnKVyOREF
	 K5RVunmZ5zNdDvQQuLmoU2qnj+v0cIVOiO+OiS3bTvW5XeIwfL9O8Rpfa1DiFUYLLw
	 C1UZfyGS2PmwNA1w7jwGw5L7wgHx+ThBXLjD0yttb1tg+jAP4fz9EkxcglLjcX/Ppz
	 OAsZnoXyeAOLw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288a5765bb9so68648fac.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:43:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YwUeH0gCFck8J4ccLGc1CDr+lQr6bOLSPtUHe4fJVQQqoGuPB6S
	AtUY3CfxtBCv+S+KN2NTrXfOWQilJ+0PKzoNW3I3rMHZoTEYFqYlRJVtfYX+y0BcnOms3fdoVVg
	VEhKMFlldR3E5oc6qBd3G90g0K8k=
X-Google-Smtp-Source: AGHT+IH42gLbGlktyxroWVWYfrfsFaT9PG35qJGfzoFUBTAJF1mj76YNgdGVeNEoCI6EEAXIv082SOQw1WkyqizWTt0=
X-Received: by 2002:a05:6871:5224:b0:285:82b3:6313 with SMTP id
 586e51a60fabf-288f402566cmr46254fac.6.1729017816577; Tue, 15 Oct 2024
 11:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8bsPCWkqDFSqWwJ3gQt7O2g1okodb_Q-NbbkTq9bc7M=zU1A@mail.gmail.com>
 <22391e5d-c6fa-4b33-a12a-b63bbb979d81@app.fastmail.com>
In-Reply-To: <22391e5d-c6fa-4b33-a12a-b63bbb979d81@app.fastmail.com>
From: Henry Qin <root@hq6.me>
Date: Tue, 15 Oct 2024 11:43:10 -0700
X-Gmail-Original-Message-ID: <CAO8bsPDiVLei4uc96jv2BnhQapo2NaFLu-MbdBMmdCKVtFuyZA@mail.gmail.com>
Message-ID: <CAO8bsPDiVLei4uc96jv2BnhQapo2NaFLu-MbdBMmdCKVtFuyZA@mail.gmail.com>
Subject: Re: Feature Request: Document the log format string equivalent of
 built-in formats
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for backlinking!
I had intended to link my SO question and then forgot.

That matches what I saw from reading the code as well.
As far as I could tell, the `pretty_print_commit` function only calls
`repo_format_commit_message` when `pp->fmt =3D=3D CMIT_FMT_USERFORMAT`,
and not at all the built-in formats.

Thus, we cannot infer the correct format string equivalent by simply
reading the code, which is another reason why I think it's worth
documenting the closest format string equivalent and its limitations.
Ideally, the format string is powerful enough to replicate the
built-in formats, but if it is not, then that is also worth
documenting explicitly.

References:
https://github.com/git/git/blob/ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f/pr=
etty.c#L2282
https://github.com/git/git/blob/ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f/pr=
etty.c#L2294

On Tue, Oct 15, 2024 at 11:06=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> Backlink:
>
> https://stackoverflow.com/questions/79089206/is-it-possible-to-fully-repl=
icate-the-default-behavior-of-git-log-with-a-format
>
> I took a look at the code before today with search terms like
>
>     CMIT_FMT_DEFAULT
>     CMIT_FMT_MEDIUM,
>
> And it looked to me that at least parts of it were implemented using
> regular code branching.  I was thinking that maybe the built-in formats
> were defined just using the formatting primitives.  But it didn=E2=80=99t=
 look
> like that to me.
