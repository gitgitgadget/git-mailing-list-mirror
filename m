Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36C1428E7
	for <git@vger.kernel.org>; Sat, 10 May 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746904926; cv=none; b=WZ2+XLrfD4GhnNTizjkJGroW3yzG4IjIxz8uUcIZz/mSf+JfpjPa6qDVvYBfUG2R7QK11vMOCDSES3cKUX9A0lY/GTZtuT8FAzlJkXezxS1K155JM0qIeWUAXCXb/Iun7V4zBaZCmguqVL6A/W5HFMH3A1sgOnZlCr9Ic2ZoDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746904926; c=relaxed/simple;
	bh=9owZrS8s3BuAZqRaBFn9o+RcnI2zIlgVYEOiF4kVv+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJIrkqU4S3rNQWZoEqq/zZKdPVJI/h39TTHAa9ZppzOdNk3duvUTZQJ6w0M3e3qJjyPDChuc8KY3qHqPpMCOF0Dgxow4asWIMniA4a0ckV++SFBuU5cT/7NaHqeGm2IgmVnk0OFC8LIwzRPToSj/Do26MGO6Q5ktiFzP7jSt3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThOgA8l7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThOgA8l7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso637302166b.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746904922; x=1747509722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mm35DYe4HKOYxJWsB5SA8WCUYv0F7RBEV+wgPCLVx/k=;
        b=ThOgA8l7fyF80axHWtBHNVOO4HTy58QQtRhYzZZRtQdQjcakL3xiPF7mTtURBNm8OY
         UtlpefGhgJ4hzfhSONwwsvC3iGCE0AOtQt6GabegWE5VzidLGN4lfG2LsSUA0ZUyMTp9
         Ge2SwgU67CKyjfWr+cBfhhExL2PXFhfhdGliH997RFYaVkdELex7B3S9UDgLStYUvOSk
         KnCV/TPQ9SOX+Dt3hQXAPe7QslspTTvTlP4zlVjmquqC3hq7Ggr0THIpSdJ3lMiVkUHG
         5HslXAHQrHg2MFy4QHytS4mYX0rM1gZYLnCmTXCq3Kiu98QyNHZi6kgOwR2g0/sdxlYZ
         Qd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746904922; x=1747509722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mm35DYe4HKOYxJWsB5SA8WCUYv0F7RBEV+wgPCLVx/k=;
        b=Jc4w2JZ5U7gOCgJCj8lo2J+GStcH2sIH6gd66CD/0Z64qmIBG95WHMNS2h83/U4W7V
         c02noV3B+t/pEKzr1iBizUslRxXdDmwOAo3jSKCrHGWEcCgB1yY/VyMhX1DRfvJiD4qQ
         H5BKmxkJZ4HO5GurXFFbSmgRrKRNM0xNDNvLFguCKnCbWUh81eMxkwhNOy7haMs7gMvP
         X7y/pxPJYr2vhBqiqVjGRckUAsOavG1GHVU1TjKGn5gogJX0i3hq/qqtAnva8ydvr5Zc
         evStoJi1anSV44vi/qte0ExDYqotUMUcINTICcjPm+UGnW9liH24M6DUNeSvVyQb8ZTo
         /FFg==
X-Forwarded-Encrypted: i=1; AJvYcCVMKcSkNbtr1wq4s3yCowXYDusk0Rdru8DljXd3EdqVxhjvjD+HGT1Yz6QW85KPdpcD1Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxZuvWTPrSvzr4cGqMYGuYAm/AKGjWK/lwcOys1UvMkvthjZZ
	KMWCdeLd0ZukUpooTb1eyMwkrffu29p7AfnVzdWwoIJiet95Xc5S8q103lAby+uERHcNPkhh5Ij
	wLAa5IDYMzJoNDxHkpNL3FrSpgvCSmcEBDz4=
X-Gm-Gg: ASbGncvUsnbjs/XlJlse58Ap94BU4TL1PfmKER6vHeMCsqt/E4DCMH3ZgDA9rgl3WxS
	nfV5eAd8CuOWMl98dewEvHsx08I2Qd0Pnoy/xC9sinGKMiGKXq8u0eoxuul3z2oTQFqX5LA04yb
	urMFaIDyyoFmob+NIR+Tl0cg0lWrywk3yD5sGHM7ogbOoyA/jHs4Ty+XqyReWvzAiruw==
X-Google-Smtp-Source: AGHT+IGZS1mnki27JsJogd7nZ0g/AqQKhz6/7pyMeZuI5i2cGOIFKFbkDFExbx81TG9ojwKaJgHYYjnZMmbPbqm62ik=
X-Received: by 2002:a17:906:6a01:b0:ad1:79e0:12ed with SMTP id
 a640c23a62f3a-ad2192889famr755362166b.50.1746904922217; Sat, 10 May 2025
 12:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
 <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com> <20250509175921.N7Sy9%taahol@utu.fi>
In-Reply-To: <20250509175921.N7Sy9%taahol@utu.fi>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 May 2025 15:21:51 -0400
X-Gm-Features: AX0GCFtK6BtHSfYu4_g9QD3mPa0dtZKTgo1BwcUWV_PHji7FZeNKDKeSbte-Jw4
Message-ID: <CALnO6CCqo5C-h_Lh7XrYinieXstgcddSTX70tTvLvhyVNTcdCA@mail.gmail.com>
Subject: Re: Bug report for pull --rebase
To: Tuomas Ahola <taahol@utu.fi>
Cc: Mr Bill <billc56196@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(With apologies to duplicate recipients; missed "Reply All")

On Fri, May 9, 2025 at 1:59=E2=80=AFPM Tuomas Ahola <taahol@utu.fi> wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> wrote:
>
> > On Tue, May 6, 2025 at 5:44=E2=80=AFPM Mr Bill <billc56196@gmail.com> w=
rote:
> > >
> > >
> > > Hi, I ran across this doing a pull --rebase using the current master
> > > version of git
> > >
> > > This happens on Slackware linux, using git HEAD, version 2.35.8, and =
2.46.2
> > >
> > > I have a clone of the ffmpeg video package, with a few custom commits=
 on
> > > top of it,
> > > I periodically fetch and "pull --rebase" to update the underlying ffm=
peg
> > > code.
> > > I tried this recently, and my custom commits disappeared.
> > >
> > >
> > > I looked further with a small test, and it looks like this is happeni=
ng:
> > >
> > > The setup:
> > >     "base" repo with a few commits (A, B, C)
> > >     "clone_1" cloned from "base", with a few extra commits (F, G)
> > >     "clone_2" cloned from "clone_1"
> > >
> > > Add a few more commits for base (D, E)
> > >
> > > Then use "git remote set-url origin" to point "clone_2" to "base"
> > >
> > > Then, in "clone_2" do "pull --rebase"; the F and G commits disappear.
> > >
> > > Then, in "clone_1" do "pull --rebase"; the F and G commits are retain=
ed.
> >
> > Thanks for including a script! I modified it (uploaded to
> > https://gist.github.com/benknoble/7a5eecd522b48669c2a5207e2ed9b7ee to
> > avoid problems with my mailer) to be suitable for use with bisect.
> >
> > I put the script at /tmp/bugreport/doit next to a clone of the Git
> > source code, then (in the Git source repo) started a --first-parent
> > bisect between 2.49 and 2.0 with the ../doit script as the runner;
>
> Hello!
>
> I think I found something related.  Let=E2=80=99s test on your Git fork:
>
> ```
> $ git clone https://github.com/benknoble/git.git git && cd git
> $ git checkout next
> $ git remote set-url origin "https://github.com/git/git.git"
> $ git remote add upstream "https://github.com/git/git.git"
> $ git fetch origin next
> $ git fetch upstream next
> ```
>
> Now these yield different results:
>
> ```
> $ git merge-base --fork-point origin/next @
> e0522318ac56aeb88f14e72ba2db25912e9972de
> $ git merge-base --fork-point upstream/next @
> ```
>
> Which looks like a bug to me.
> --
> Tuomas Ahola

I think I'm confused: are you suggesting that the merge-base output
affects my bisection or is indicative of the cause of the failure?

(Also note that I don't keep my fork's master/seen/etc. branches up to
date very often.)

--=20
D. Ben Knoble
