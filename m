Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1DBA45
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952658; cv=none; b=gJnD2EO1vnrPBhtpKFrvqTrlCm9YmiJ/ZGXTxPQDPd4Hu7jhntlrPpbK7ntGDeK6sxlSVNzB8O689RAJx67FYrN7lonXCEZlVKcfeI19OkByH3KK12TLPClWIHsbd1kt4kk6/vx5eISoTIF5Z5XAJ8PL1xo/R1R6fdsnMSqMlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952658; c=relaxed/simple;
	bh=AiLVxy8uiMpndVpANcAZCYzu2GpMamUNdytCFZP+hBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/kr2B5Ks6PRBNZU13/aTgbge/Dt3yGkXRZy+YDTnOafSQFzLrRG/j6lYHMFvzB23FNuKTaC2LgPh2481WDoAZZNHzIpcX2EO/BiyJu0IK8VBX4dE6Kr48iPuibEirjx3Pjh7j0u/0cMBLOWG2JYj2wZI1G34EKzkdXzOKpj4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7e05b1ef7caso18663241.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952655; x=1711557455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eG+Zoaik6v6bPf9roCzBtYOvh2Znx3irN1iq788BugA=;
        b=PqOqk+6vRXo4mQJkUrH4QbRjGtGrQ8sb1CTwbDUsrsK8n/I14/uQkvGepGhnDql0UD
         tinjfQsLCHR7gtCuaHsJTpqY02CLIchocQkF7/PGhvKg7ZzCdvlw+B8GeZ7taN9IDOqX
         f6FrxlCRgVdMFweve45uEPrmurvWoWzr1VUpfX+M8J2KgepKHocnYFu5HY9P+q/sFcL5
         oB9jzr3CnXxckEr4PhUMxsw99EIpc3edLqZ6YR0uBH0tlrC3jPZJ4gN+LCv62wOc4B3t
         /gEokh9UbmWimwftn0iyUtwpbw2nZIRpmwNvrA9BcUoNyPwRt4cL+DVb1QJZQzOYnRbO
         24LA==
X-Forwarded-Encrypted: i=1; AJvYcCW4XTjsqcBOwMPZ2uAS9jIoKAuz3TGSFjR395l0TQ/bs0CyetCMOjUn4kbMc9xSqxh70dpaKcQaRfsEmltrbnl6NNz8
X-Gm-Message-State: AOJu0Yzv+auLOSinayOqxxsYKrhbZQNrXT80HbodoOYbgFF6nk0VbmsP
	KNRXgqR010iaKl6tzDNxXW5uRl/WTSolXM+EH3uRWi7B7+ZkEKnHKObYkLsj7Wu2+nv4Ks/0Gk2
	W3gx1lVqymu3FLAOZPk0df6Q5tTw=
X-Google-Smtp-Source: AGHT+IHJHORk9YsdDAb19m8TZmwkbHSVztgrOB8y4Lng4Kcjfw8cR0Ajfnc6ohwaSKsinXQWpUkhDWNRt9ocqBMUiXE=
X-Received: by 2002:ac5:cdf3:0:b0:4d3:3f2b:dc63 with SMTP id
 v19-20020ac5cdf3000000b004d33f2bdc63mr12348838vkn.5.1710952654707; Wed, 20
 Mar 2024 09:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
 <xmqqa5mulycz.fsf@gitster.g> <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
 <20240320001934.GA903718@coredump.intra.peff.net> <CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
 <CAPig+cS_hCOnAuwRd_dY5h37-wgHCk2tjS7asm2Dm_p=s41X3Q@mail.gmail.com> <CAPx1GvcVZgsU+WHecLd8PWo_MN+wJj6wQ-G5nxYvWnOUOhfQng@mail.gmail.com>
In-Reply-To: <CAPx1GvcVZgsU+WHecLd8PWo_MN+wJj6wQ-G5nxYvWnOUOhfQng@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 20 Mar 2024 12:37:22 -0400
Message-ID: <CAPig+cQOAfRNrzyr8ABMxkNzbazD95AN4u=T=xgTUnMF0zHZpQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
To: Chris Torek <chris.torek@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	rsbecker@nexbridge.com, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:35=E2=80=AFAM Chris Torek <chris.torek@gmail.com=
> wrote:
> The suggestion for having `git var` list GIT_HOSTNAME gave me
> an idea: perhaps instead of, or in addition to, a `hostname`
> condition in the `includeif` code, we could:
>
>  * have an `includeif:env:...` condition that tests an env
>    variable against a pattern; and/or
>  * use $GIT_HOSTNAME as the variable.
>
> We'd then set `GIT_HOSTNAME` to the gethostname() result *unless*
> it's already set.
>
> This gives users much more flexibility, because:
>
>  * they can use the hostname and/or arbitrary-env-var condition;
>  * they can then *set* GIT_HOSTNAME to the short or full
>    hostname at their discretion if the default is not suitable
>    for some reason; and of course
>  * they can, as noted, use `git var` to find the default setting.

This certainly is a much more generic approach, and simplifies the
implementation considerably since it obviates the need for
GIT_HOSTNAME (or --show-hostname) since the choice of variable name
and value is fully under the user's control.

I have some vague feeling that this idea of using an environment
variable as a condition may have been discussed before and possibly
rejected due to potential security concerns, but I don't use
`includeif` myself and haven't really followed past discussions, so I
could be wrong about that. Peff would probably have better
recollection.
