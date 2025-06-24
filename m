Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066726AA98
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807683; cv=none; b=cV80TQ22m+u9spQHK3pWGw6HBBfQeptzsKiuFRvSLNcmqKt4599YPxRt+mGdIqDd/Kx/5t8dYcoiCLyo13XCqL2qv2CbN550cl2iZyRLgcXv3roem7suZKgkwDpvtJLqOO9l7vsqXCFq3frbrO8KPJkKFokKZQ6mTaQymz4n8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807683; c=relaxed/simple;
	bh=BA56PsxMteRysF9xxf+BgBdMfQf5ofm7grYdU5BS0Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qabiscvIyT4bWI8EaLrIK5cHrLvQrKu9XkwyI6DkntRDZxlk9RX74Fckj8Tkqaa203rUl46dpq1RsHQpLKWc4J0lXcRCPINUU5IG5aSWGoJGBFj0D4OF4OnPPfy/zVig7RXsOCXE5BY5RVicSGoAP9Qg0LsFE43cf0qGxrm67tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqzEQ4YZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqzEQ4YZ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55350d0eedeso1135818e87.2
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750807680; x=1751412480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA56PsxMteRysF9xxf+BgBdMfQf5ofm7grYdU5BS0Ew=;
        b=WqzEQ4YZ3G58w5a80rOg9fWVaPLw0Kj/cHSTMGSUoVrGa83uMbGRwcysP0ofLVIxzW
         RnKdLHcrDRcUlqBV+eDnMXXuJkVw2GiycpLcJOMC6Ek0zGqIOBLjNQjK/9popccqHPWJ
         LtEnZluiwaG96/3D4poY3GLTwH3qTl9hjwv//MmzZQOMc2q2UjWCufGCGqdkRSkcWirJ
         YSGlBrDLwGQJdS7/JQrgjBxzQ1mlBLF+mTiYyHnUH2BQo8RO0H5l0D+m5aR5x0TKyggX
         XoijEW3f2nEhI4XDlbnLXzPS5luKypfE/mns3h95y16PbXkf8rszN5N9Pazdj9IwCpjS
         p/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807680; x=1751412480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA56PsxMteRysF9xxf+BgBdMfQf5ofm7grYdU5BS0Ew=;
        b=X0S3sw3VYma1D6x+ibUXd2nLnawlOV/xoHWTSMKuWo4UjTziTEHW7xfjRvKI7Cxdlh
         PVV6Jn4tsJw9hCLBoJPUOwHNywBr2n6kArC5b8bIOwt4izTKMkBdE3q7C1SC52Xc4FnR
         Pw2P8ivE07Q1vB/F+jtVMfhifogzTmkpp3MP7nIkfT9DtcQfgvpNnVVq9eMIGaOj10ir
         Twd/argj6tACaM55EvqjTcNOhg914iMquC3Y/rO1r1LbWiW5lE2DBo25lJfWlxPQg4ta
         KWYFbbYsdJdm3O19wf0JKS37OvP78iOAd+hevTz0nJWBQRghgTHvpJtSjqCZAs9VvySq
         ChOA==
X-Forwarded-Encrypted: i=1; AJvYcCXlOF7Pv/RufNSWdRvT+J2eytRalq9Pd4pmB/YA2tUIEAMRlDEXo4IOJyEWyHBIoaKC+U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRB2rYGZH1ufvJZFRlBmDm6P0NUHpYqUwb8il9fTPEjagRveNb
	MqsGmX62O52519/iLweT7xXFWZ3wB5F7xKxH05v2c+xVJat1vv4NMneELFWN1mnOgtG1IPiQlfR
	Pwpv28h87FaJM/zgiovLrcajiNWC25aY=
X-Gm-Gg: ASbGnctnfxkXLgwk46whrCT5WvYpsrS1J2t4YQdKxR+IiP0AWkU6Y0SjJ16ifMHWxME
	NR5NwAFjdkSxrKy4Ht6spAq/6Ls7yOyV0ixtUBPmKK89M0fGXUgAGOr6IS3hHZ8B+cLnn6UWueJ
	0FcP5pkSjUfReXgr3GjyLZ+tXWVz6ELTByjfwSTmKe0j5l
X-Google-Smtp-Source: AGHT+IHZCCI/UjBcM8gzEQeQkicFGjIOx1Xb7T8Ajcj3iUYBx0D3K4n5lCFZcZyC9eGrSX2BKpJJeCgzF5wOc6Zk+oM=
X-Received: by 2002:a05:6512:3d8b:b0:553:37da:2bad with SMTP id
 2adb3069b0e04-554fdf56c43mr177483e87.38.1750807679824; Tue, 24 Jun 2025
 16:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
 <xmqqv7ol177p.fsf@gitster.g> <neeiqdzggdukyfd5metm56nq6tnperhcnzvgvt4e6idw52rxeg@qrwzjoexs35e>
In-Reply-To: <neeiqdzggdukyfd5metm56nq6tnperhcnzvgvt4e6idw52rxeg@qrwzjoexs35e>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 24 Jun 2025 16:27:46 -0700
X-Gm-Features: AX0GCFsJjZdgaNIHs4I3J1zrXfVo_cs5_YzuANAAbXZ5Vrrs9QZHQkkoYLGt5EM
Message-ID: <CAPx1GveWK55UWksUXNUf2wU3o88SLyXF0LGFHAX4_b3-cBa=Bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] daemon: use sigaction() to install child_handler()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 3:29=E2=80=AFPM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
> I didn'r address it because I didn't knew where to put it, but removing
> the signal handler isn't possible, because as soon as we do, EINTR is no
> longer "returned" by `poll()` on the systems that allowed that as an
> exception to SA_RESTART rules ...

Yes, the signal handling stuff in POSIX is messy for Hysterical Raisins.

If we go back to V6/V7 Unix we only had three options:

 * signal is default-handled, or
 * signal is ignored, or
 * signal is caught: receipt of signal calls user-supplied function.

and the disposition of the signal was always reset to default if
caught, so the user function had to call signal() again. Which was
sort of OK but had the obvious race flaw, if the signal is delivered
twice, before the user function could be re-armed, well, Too Bad.

4.1BSD and 2.9BSD Unix added the "reliable signal" mechanism through a
magic library (-ljobs), with several new system calls internally,
which morphed into the more-standard-ish 4.2BSD `sigvec` system call,
which in turn morphed into the POSIX `sigaction` call. But this still
retained the three basic options: default, ignore, or
catch-at-user-function. So you have to have a function, even if it
doesn't do anything.

Meanwhile System III programmers discovered the problem with
child-is-ready-to-be-reaped signals (SIGCLD in that variant) getting
lost because a SIGCLD handler could not re-catch the signal in time,
and "solved" it by a horrible hack that (they claimed) required no
user intervention. Given that a user program using SIGCLD already had
a handler -- let's call it `child_exited` -- that called
`signal(SIGCLD, child_exited)` somewhere within the handler, the hack
was to have the OS *re-generate* the signal if there was currently a
collectable zombie.

This of course depended strongly on the actual code in `child_exited`,
which *had to* call `wait` once *before* calling `signal` to re-arm
the signal. Otherwise you get infinite recursion. But in fact the
program(s?) that they cared about did call `signal` at the end, rather
than at the start, of their handler(s).

POSIX took `sigvec` and added flags, like `SA_RESTART` and
`SA_RESETHAND`, but otherwise maintained a lot of backwards
compatibility with both schemes by making a lot of behavior optional.
So now you have to over-specify things.

People keep trying to fix the klunky interface over time, but history
is just too messy...

Chris
