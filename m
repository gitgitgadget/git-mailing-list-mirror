Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131CB3933F2
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326076; cv=none; b=LLfj4CQKZdpVIDIHty/ypN1CfcwB5bJBi9E39yIXxkCQLSIgc6SmDWX7Pqba7+zJqxeGSm8igRmS0eF4/ocsbNIziRP4D0kOkzvniyUyE3YakJaMKkarTKERRZhj9W5k9rRgCdXV5u3T5PM24qyxscIBQqsifp/YcWlhKTDbleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326076; c=relaxed/simple;
	bh=eNXZ7UGa88Xagi/u4bv8QwjRJngUa6OJzYYnlKqBZKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sno9oYLHBWY8j2VCAtxtLteAeJvOjTHDLImpnk9oL3B9/dJycuMTMc3wKUu6p2GAGT9SDBRlTwPO6Ta0y2LknLx0kQIjZZBKv9I74J/MXUbhvXkQEZ3EjhUsEnpM3lUtgOCXE+Kx5qdcIzP1ejTRhrCv7IcFXzzgzeZkvjtqp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HosKMTIq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HosKMTIq"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78e6dc6d6d7so39827677b3.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768326074; x=1768930874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCLJjGb6gQBAxGrXfuX/W3OTEefV4Pe+Q4+3IUBQUdw=;
        b=HosKMTIqNZIxg0WA59j1KCt67eWOIoy87DshCvwmPZcCYJcIvBFsKC2EwQsGC5Eykg
         vDN6kQwSe+q+N3Wd0PTvEI/NY/4TA0M1Xjo1/IX1k8jYlUsS0LlLX1h6ffcJ+rkXOPga
         u6M4SscGpUw46b3VkX0sR8Ehzt/+h3RWAMy6HHUw1Sw7m2zxEDU71JhkZTd5BvYC90tq
         FwrJwOnQtq/8WYMqgUhoJXODV0iOTg2Gjcw7Ii4om1NC6041i3z5HN+aiczm9dK6pX7V
         pIxQQtUSTHToyrmGPbmCa1vhdyUIcD4FubPetC3Nrq6KctdTatGk0pTwfj6sKSGmKlXp
         1GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768326074; x=1768930874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCLJjGb6gQBAxGrXfuX/W3OTEefV4Pe+Q4+3IUBQUdw=;
        b=sriueiHk1nH1YZoAFXKGkKogkpH6Pv1KlnO2ZL3NvPmsdgvz92BhRrS3Ulb8Xfo0Cu
         dxcsodGStpAGDaCUWisVBbFmvsNEcQDbuTA4Rtdv3lk7UuEKurXEv83PHZCoprIO40S+
         XCe06yd/Y4cpMCHWjf9xa7eESory8KP5h6a2pE/TSmMlyXXafL9RXEkWAdikc/Gu9Fdf
         4dmSOhwFKofTPi1jOW9nS2+Ussc/+c9zVTIW3JeMZG16IYR5nvGz9Kpafzinvnhl+XNE
         sgXz1LY5ecbzTZOjeZqY8cgpVh0awGsh+WO9FTN2OTBh/xv/UME53GtxxKtdxcpNrWSE
         eH7w==
X-Forwarded-Encrypted: i=1; AJvYcCVL57D3lcomLtXyv2OJwZAquWyCLvWnUbhgQHzqEhFKCP8TN6D6k2MaLHKI2ReGzNbXFSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtOxHHVY1duJ9ozBAD9izVwfOMy5uoe3KvM9SyxpbdyyQT8K5
	cjcjToXNnczk+d+rKbfdkVL5YLhEjE5nfKSo/NN095kGzpkf7K9v7U+KJxgczvatIyrrGKRm9YA
	kbGFsaTlEUgeQ4Zz8CcFz2KTySAdlRwCIZLUrqBs=
X-Gm-Gg: AY/fxX42Bl7WK5rPW4OiaJPEXM+ttEoXUlB1PhRNIL191Wc8j0rGpPpq0QsiaG1wmJ+
	bRns4dvtL+/8NfZS4q8VFScZ6bBYVcFsplklrBIRk+ufPkK85E2pMHVrJsNYhgypB6pmTyrxELt
	ChSUUvqhlJqZk9x8EqwxX/IxWuPSsHFNOXmSpd6TFqp4RFiA/ZWh8V8dkxdwwuzllu7P/XHsiVm
	kUIY7Q2KQdtCoh1t9n5EoxNXOADcP8BW6SVBXzNTwCdzcqNQo2Mjrk337JX55JAq860Iy8=
X-Received: by 2002:a05:690e:1507:b0:644:6f03:b3be with SMTP id
 956f58d0204a3-64901aacb12mr29401d50.1.1768326073946; Tue, 13 Jan 2026
 09:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWPFxQloyfx8x0ED@MAC.fritz.box> <fefb3d25-3723-4e10-893a-620fbdc0cc45@app.fastmail.com>
 <20260113171030.GB265671@coredump.intra.peff.net>
In-Reply-To: <20260113171030.GB265671@coredump.intra.peff.net>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 13 Jan 2026 23:11:02 +0530
X-Gm-Features: AZwV_Qgv7KI9RkO4zGhtzSwiaBY3EMBVULkDlYItZ7ngLnkFHzMUEvMZNRYovBo
Message-ID: <CALE2CrQ415Ewm_F-DLZu=JY2BTWofmGgorEOa0D=USr5d510SQ@mail.gmail.com>
Subject: Re: Difficulties using git rebase. Help, please!
To: Alan Mackenzie <acm@muc.de>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

That was me. Glad it helped, and I am happy you got the rebase working.

Rebasing against the merge base instead of the moving
origin/linux-6.13.y branch avoids pulling in all the upstream
stable commits.

Best,
Pushkar

On Tue, Jan 13, 2026 at 10:41=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 12, 2026 at 05:08:52PM +0100, Kristoffer Haugsbakk wrote:
>
> > On Sun, Jan 11, 2026, at 16:46, Alan Mackenzie wrote:
> > >[snip]
> > >     $ git rebase --onto master origin/linux-6.13.y HEAD
> > >
> > > ..  This didn't work well.  In particular, I got a conflict in a file=
 that
> > > I had never changed.  Why?
> > >
> > > Well, I corrected the conflicts in that file, git add'ed it, git reba=
se
> > > --continue'd, then got another conflict in a file I'd never touched.
> > > Same again.  After the third such conflict, I gave up with git rebase
> > > --abort.
> > >
> > > Criticism: there doesn't appear to be a --dry-run option in git rebas=
e,
> > > with which one can see how many files will be conflicted.  Instead th=
ey
> > > are notified one at a time, drip, drip, drip, .... to the user.  In m=
y
> > > case there might have been four conflicted files, there might have be=
en a
> > > thousand.  Either I'm missing something, or git rebase is missing
> > > something, hopefully the former.
> >
> > Just a dry-run? I would use `git merge-tree HEAD
> > origin/linux-6.13.y`. Then you get to see what files are conflicted
> > without stepping through anything.
>
> Minor pedantry, but: those are not quite the same thing[1]. You may have
> conflicts in the rebase that would not be seen by merging the endpoints
> (in the simplest case, imagine a series which makes a change and then
> reverts it).
>
> I do think it's a good approximation, though. But that also points to
> why OP's request for a --dry-run can't be fulfilled: we can't know what
> conflicts we'll see in patch 2 until we know what the tree state is
> after applying patch 1. If there are conflicts in patch 1, we don't know
> what that state is until the user resolves them.
>
> -Peff
>
> [1] If you want to dive into the world of rebase vs merge conflicts,
>     check out Michael Haggerty's imerge tool:
>
>       https://github.com/mhagger/git-imerge
>
>     and some of the associated blog posts and presentations. It can make
>     big ugly rebases/merges easier to deal with.
>
