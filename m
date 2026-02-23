Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DA1AA1F4
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838009; cv=pass; b=YePlIk2WcTkdYvRfGjcITUDOAqK4rEHZQdLz3HMs/H3Qm0sblwiG56cWSRCsIhzWVgM5dHZB1qKyMMOn7GH93XUII1K9CQf/n6iEnyHcnQpva7+g8U3C5eQIe6iMdTp0/Qpo3u5sRZChO3VFC6I0i1scq4wK1OnMi/N5uuZu+UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838009; c=relaxed/simple;
	bh=Nhhdb6eax1jr+JU4nICoeYNzvL9oLHlf6e28gJ/1Hi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hubyfdK0/YBk0Lg9EjkNN2fgY5NXdnMyc2x6+xWlrNjW5czGLELwUeB+OYPkySKcAPW3p+/Jb+gQqgmAlH7pddVgrj+vaH8ygSBCrBn8zkQ7Di9v9dE/5DX4JrjvuNF78aGN3mdKhv/yPrMy007+nIOl15QuFLKTSeMgOrrm/pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgvm1vmn; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgvm1vmn"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1275750cf9cso3302710c88.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:13:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771838007; cv=none;
        d=google.com; s=arc-20240605;
        b=WjQik5wa7EsbDdEE+0fkqiBIqedaiA5i0AhBE3oUMw3sDCv+RnF6YWzIOrOaQrO84L
         Rf2EI0TnFSGzyUS/w7mSEBnGfUWRWilB0Q6rtwNg16E67UoufGHOZfasafBM4fgV3l/b
         Alp9cwb8yJhlw9SOxtXemng7QYWfah3iwDiGi1YRbZTn56xyvm+nECiSvWuUK8kOxKwU
         nqiaP+0NEvpvszrvOhEOM28TN2s7W2W2JW7B2hiGK9+s2fUDR+2DuD51/WepdYXRCxJf
         ux4xB0XQcMuMGe2Vpoz6G69bBNfl3rWYrDJNarVeJT1Mco1ecnrJkXa3NHs5QaTkldf5
         J2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NI4IfDDin/v1W7Xn9okdNcg5clUT2mtvt5q8Ie7m4NM=;
        fh=I4NWZxxpTxBMD9KYmCkAd/66dH+Eiv5NcJzRAC59BMg=;
        b=PXCb/O8bzzBKoyUIqnhnVvDjEp2+LwIRPdmvJvmFocmAyHNjXC1LZfIACfSM8let7l
         eORuUWTKo1joRwdfPLUm7OC/1dDgNcbwX518+VPYzYdVAMkIgHbMaRoVgBU1svrzGory
         L6LtR34XeVhYe/sM6w+6RSFcmWbsysdSZ697YLxPxdltOwIFHce2OhzeIGTXEwh2py0i
         kPdrQR9P5LQa5qGoUWmeUKyiXsm81t0qK9vO76y8IcwT31XnF7Ai48tNfZ3eEtkCerme
         JM3EWY5wTgDfRIWa8aoKrTnSjVcj4TJ6HY5LAMw2KnmDDhhupQuXv58nHNi7ysYfCVvx
         teQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771838007; x=1772442807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI4IfDDin/v1W7Xn9okdNcg5clUT2mtvt5q8Ie7m4NM=;
        b=Kgvm1vmnnG4JMUw91Y+mlgRH7ApQcfuAAyPNqYy3xo9tiRZSNpS5qKmnL2YLcNx2OC
         VS//NrvX/iU7ByyOoh5lnsbumX5ZOiuMiEHY07Tild7xXT3gNfsSA9BX/9BxAbPpCOOO
         WX0LbL8SjFdm8Hfgm58FNiIIdaembCB6OUeqS+mGXQHBFLd+yDM6sazG9147fmJyzML2
         t4LUbeXt/8YKwO3yNUM5H3H4blnnIF8DAh9J0HxFA8R++4Wt3O1nh3DPnEDdFzVuUsJY
         HZVI81xuE9eDxNYOGUtNB4TZr3KJDtv7i62B0cBllis+rnlvongaAeEz3K0UYJzrvsbN
         CkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838007; x=1772442807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NI4IfDDin/v1W7Xn9okdNcg5clUT2mtvt5q8Ie7m4NM=;
        b=hpADBTrUSnXJzjHnQ97A6yCm8Qak5sBwf35OTHSQATzode/KJJKl+0A5Z6G90FUPV0
         wMCWXDWlTIImL6d62TLky0RoB6PMtBpqpJNRIxGOykM2FVcBQR1EDyOyMKW9MOmzK9ed
         hhH//znZuLfE3uDIIpU5uU4U6G41NIhYwpRM1RULHFI1F5n4RJLnd2MDYPty77x/UKkD
         5WPSqlLeqrpOnTQs+1j+HDsAoUZiN/wqCctTK+KBnDotzMR3BDUDxViyXwO3d37mqiNy
         jNxHOOXfwJFJM849LUWWZsJpudOx7TqGkRLHjmlezVESwopmZCb7lylGm6r0bXXfJI2J
         r/BA==
X-Forwarded-Encrypted: i=1; AJvYcCX3L44OVp8PVm4/xoYGTme3qRlqm654Bfo/kjtOYEe4ShwvsoU6lF6fcab/SErwIqBcEN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNx23CrE+bKiW9WJGGKYwJy6sX+EFV42It4S5bXfYPH2CyzMJ
	GSUL85ndn+SjboiA0sx7fx9v6v0uvOvJQSdgutONEiDDN4ggcjaMhdO2M2DWRFqDHuJvbUgO7MH
	McDzZXdP1xvfvn4RjkZCj6lvuPUfgi/A=
X-Gm-Gg: AZuq6aJojjRmFKPiyjRsNComKGZBhHDYpU4Sg8aLJ+0T6YE//r/7PscdEJjeI09qwhr
	/6dSl3UToNdf0fSBBV4njQoBkR6KihlOTtPdJatHeuhOL35BDmwPVYjl4Mku36r5uTvgum4Cnb0
	IuxRKfDwq0eYF2PkLG9NghIy0qaINmTHFnsUNlMGG734OBXMRXR3gGanqEoSGnGXl9WZwSO0Fpx
	EK1mME5A2NtzYJvW04wrk5p7oDixO/sxkw9DmQEncx1aXh8ns3xqZ7qwIdFRQl5CsXFkhRgIVDU
	TQwWkOgln4nCpKez1F4cRU4wp3H9FejdTb41O7Mz3DhYDBXFmdH4FcjaVpdqrFWc4ZN7
X-Received: by 2002:a05:7022:b84:b0:11b:d211:3a64 with SMTP id
 a92af1059eb24-1276ac5d55emr3983762c88.0.1771838007255; Mon, 23 Feb 2026
 01:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com> <20260218234215.89326-3-siddharthasthana31@gmail.com>
 <87tsvbe2sm.fsf@iotcl.com>
In-Reply-To: <87tsvbe2sm.fsf@iotcl.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Feb 2026 10:13:15 +0100
X-Gm-Features: AaiRm52uUtrFUuX2E4cGOFpRwGFsuwW9XZ-ubE4pqoZZoTLyXw_ohfA13OO-IK0
Message-ID: <CAP8UFD1CAYZwK4x4-AZWjx3cubzu5WcndR8WJzhcegET+i22nA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] replay: add --revert mode to reverse commit changes
To: Toon Claes <toon@iotcl.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, 
	karthik.188@gmail.com, johannes.schindelin@gmx.de, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 6:35=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> > diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.a=
doc
> > index 8d696ce3ab..ffdf790278 100644
> > --- a/Documentation/git-replay.adoc
> > +++ b/Documentation/git-replay.adoc
> > @@ -9,7 +9,7 @@ git-replay - EXPERIMENTAL: Replay commits on a new base=
, works with bare repos t
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advan=
ce <branch>) [--ref-action[=3D<mode>]] <revision-range>
> > +(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advan=
ce <branch> | --revert <branch>) [--ref-action[=3D<mode>]] <revision-range>=
...
>
> The modes `--onto`, `--advance` and `--revert` seem to be extremely
> different from each other. So I'm starting to wonder whether it won't
> make more sense to instead create subcommands instead of options for
> these. Maybe something like:
>
>     git replay revert --base=3D<branch> <revision-range>
>     git replay pick --base=3D<branch> <revision-range>
>     git replay replay --base=3D<branch> <revision-range>

(I think you mean `git replay rebase` in the above line, no?)

I agree that we should consider this. But I think we should do it
separately in another series, after this one about --revert is merged.
We might even consider waiting until we have more experience using
`git replay --revert` to make a more informed decision. We shouldn't
wait for too long either though...

Also if we nearly always need a base, then why not:

  git replay rebase <base> <revision-range>
  git replay pick <base> <revision-range>
  git replay revert <base> <revision-range>

?

Or what was the reason for introducing --base=3D<branch>?
