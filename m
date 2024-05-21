Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE92BB15
	for <git@vger.kernel.org>; Tue, 21 May 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288331; cv=none; b=tzfC5bfQ97mLOIlTvuNeZEVDvgDMNL7owmXdYOU898QQHxw0xTdTljG7rZr8992dtqGzGdxJX5X/JQqDjZ3rKTDWmhCmOkwLqbwE9oFJ0Z9LhjBxKFGewv1gISzW6vNYjdOqHorZs0VsWs1KVku+ophdVMwplR45fr/NVIgkuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288331; c=relaxed/simple;
	bh=g/CwISVNh+vjOVjY8V+z9Ysuhzq5FYxsAcSaNp4RDDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgyMpEGprgHoLxyXrp2i3DjMQGmOJ6rzeNDyYdmu+dxtd2kT6jgTTPlCuBDLAvytxFzDA2WnZ2bLWBZbAd1D6/knyTxnKKGKUWcWFnGkhhKzJGjkij/X0p/2txEgLJWKUC4QmzWDjHEE20LvwK9xrjoGGDLV9z/nCB9eHY+o2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQDcQ606; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQDcQ606"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b277e17e15so3057595eaf.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716288329; x=1716893129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g/CwISVNh+vjOVjY8V+z9Ysuhzq5FYxsAcSaNp4RDDI=;
        b=YQDcQ606LWT9cX4irh4JJy2oofI8hdbjdPFNaRlJ1Xxy1jpKym+6NIDFxPtu/+0gxe
         7UZgWr8ZTHMakASIlFqkBmzMkeYHIm6xC9YwBO7H0EKA6/l6DLZmkOmPpdkfwDvOpO5b
         SR0bbmzxYTghQEbA/HKfIMxD+TqWUDx+ceej5CnjIT3Paa8AiBf9veWJQR4U7tN5rOtd
         X+tP7wuELmj80cX7NAkNOn03VeaqQD4JYlieHxmAGXsUaHNlCjllHAS/iR4NyJU5l1kZ
         eAuOyZwCGcxxzFgQy9f8Tt+ky5FBdFSSvyhJwFYj1t99+fvSD6o30EzdTJK8pj9zPExn
         0j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716288329; x=1716893129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/CwISVNh+vjOVjY8V+z9Ysuhzq5FYxsAcSaNp4RDDI=;
        b=lGjIih9KIDfdw/dZcrdJI9e/L8VoOzDtMYpfE9kJl3oq3347d6+Ro9mWDepAzxE/aE
         CLW5+0di/OEdfNu52z5yO8GEj7psz/mD0g5YKkownzpSltgJ9z0046OmxIoPDShfcsOf
         EdWatMtu0ZRdZTFRWTTwreN2U2DV5dajVEMOx/KfbuG4VwSyFIKvYqoi3AWdYmWUtRbh
         G8nUYx4aCsl5T0/WhP+Fa4y6u0xCbGlOanbYyj3Ia62Pdiuh4qtbuaX23b6CTx/LYWXR
         otW465lmKBZ+OW0lQqLoE/ZjHkBL3A5mSOft2ioYMX25fQttYDcvvHLTWpawzj0zdNk8
         AHzg==
X-Gm-Message-State: AOJu0YyTSzgIxsKbPXEH8NAAgFRPF86gcQ8t53Qob6b6U5GJwH31XPMx
	95x1dPBflJ6A5NgaSJ6pDPXyEo90RaH278aYoTw+4vO3ebqJi3WR5kJarjlxDlshIG6mHH+PWlU
	GKLLgrcu3xG74pW9cp/6lBsPOKPfG0w==
X-Google-Smtp-Source: AGHT+IFHD3ecg8iRqVWbyg2W0KyqkkAqa7TVBdLJ12gXdrPVzThpgF5ZidwjJRUQQBq14zbG+hhkw0Gmd6UoufQM714=
X-Received: by 2002:a4a:e783:0:b0:5b2:f2a3:5e with SMTP id 006d021491bc7-5b2f2a301f2mr19276683eaf.4.1716288329120;
 Tue, 21 May 2024 03:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
 <3e4a7071-60b0-4f7a-b347-d584d5eb076e@aixigo.com>
In-Reply-To: <3e4a7071-60b0-4f7a-b347-d584d5eb076e@aixigo.com>
Reply-To: noloader@gmail.com
From: Jeffrey Walton <noloader@gmail.com>
Date: Tue, 21 May 2024 06:45:18 -0400
Message-ID: <CAH8yC8mNns_XiQHp3=q_tYr03Q+kR1r=2WOYha1XMp+cYs9WDQ@mail.gmail.com>
Subject: Re: How to disable safe directories?
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 6:42=E2=80=AFAM Harald Dunkel <harald.dunkel@aixigo=
.com> wrote:
>
> On 2024-05-21 10:39:32, Jeffrey Walton wrote:
> > Hi Everyone,
> >
> > I've got a big DoS on my hands since safe directories landed on
> > Fedora. I think this commit is the one responsible, but I may be
> > mistaken: <https://github.com/git/git/commit/8959555cee7e>.
> >
> > At this point I've wasted enough time on them. Now I would like to
> > disable them completely.
> >
> > How do I disable the safe directory changes?
> >
>
> That is actually pretty easy: Kick out the commit. I would suggest
> to turn the die() into a warning(), though, giving people time to
> adopt this restriction.

Thanks Harri.

Would that be something like safe_directories.enabled =3D false? If not,
can you point to a setting?

Jeff
