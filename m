Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786737;
	b=x3DZx7QQqzy5zbLoCxDbUR3i6rdA66KA0jrOf0pPY8vnj9b2znNz/MDbYKyzbjLH4lvZ
	 nTGSry9WiyDNIpvCdFgvvqJzEXiSHR/FMWfG9j11DeGfsDE8/pFNiKqDUmm+H6aMIr8lF
	 fF8BE0vkyPsJQ9jMssqcgmloJPfDnqVa9Vuv4UMjPLGPiIN/GJX3SGFh7eNCBCwwfB/6w
	 Csu84gE71hEyAmNRhLEGDMVpPqaVO/h1CRZxGsofzHbbKANmVhf8dDAmV9IlHnpOxKz+K
	 1j+O8rheLMtfKLm9R5j5sHsGPCyq311VDE7eR1DpTNVGqNs5RAuunDHnbc+j/3pQnWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n9cL6tJQr2U8K1AlisarPnDBboHF0BEOhDBs7FJhko0=;
	b=EYOtw56fficqJDwnzAKdx5wPLXVNXpyc0AfqJw6FDkIdB5hNpctuj80DmcU79vem4Tes
	 wf1OvJcuyi5j3+CH2pjNfNO91/wdSXgOaO/ir0+GCGKjKUPPxGKonVxGdBv8R+6LHQIt4
	 QL1pM4/WZ2fJgDGXGHzJKKOCqTBcgLTjOlCWYTj6wzByC4IhtWM7SUFSk5p0W9esGAxrP
	 bTQyD2Bku6cu0iN5SiOmbnaLRGEPWzM4jx+Xdljkj0hhQVila6K59VVb/WrWBt/bOtaqS
	 apHr6mPw3p8pB3fkeYTjcDVrEIDeTZIAwuxh1WCygA4IhwoiVB8Ez++9VCUUdwU8dZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V70noMHx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC8606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACCC8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V70noMHx
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab53a99771so4317061fa.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 02:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786735; cv=none;
        d=google.com; s=arc-20260327;
        b=bizuEy60acHH1vM7bZT7gLiGydXhn8Y5YUX2g6x17zbRQy0B3lNskSxpE/WrzGHfcg
         47h5Kp7fA2xSod70Xa0+/UzIPc1IVnehTLvaLH/2PAyAV14OPvIa2fHFKad4nKdYsq9l
         OhkBLi/FmxC8xqGyacu7+ce3R2pPKgy9zJcsjv65VuG+5m9YNoJacR4974XJSzD4FWEL
         pJld6kYIte3uYWhgKnwC0dEqO80FFY44EnycOBGpjQJxbw7qSq9tVXOruZ21ESCX4G+i
         MLDOe3Fym/zdGqQfktJqJf3ZOsRNZQi2ffFaRdcG8K8BQrj/55dlthRu9sUCD2VGb4Ik
         QMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n9cL6tJQr2U8K1AlisarPnDBboHF0BEOhDBs7FJhko0=;
        fh=DNa5Z5Ecl41IFdgSjt5z6SXHaDRIsrxbGohFO5QnuAk=;
        b=V6bnDrX1784Pwqigw0im03C9BE5UOUEmqQ8oRCRlzbPXv1ljtbBQyVDmIaE404bIZx
         7RwmDGoIqc9/xPIz8LkpniYwE/QPC34EFhGOskywAQo/cbSqE3GBzI0ylYwB4EgVYcq9
         vFPcsW8rpswPZ6DXK0FdmijJL3XTG0ZY+wWTwsrdD8r14/lPaiQrqdPFKr+7f3wsxXrT
         1MHI3A9drNXfcdWK4r7fyqOGMkdJxjhrpmgreSisqA7YU7hjFBi41ZHQIDTOfXcMDS0J
         SgK97AX+O/Q5zZiBXTQEd9EApRHXfHklc41VVnwPfwhBwue5Glkss1K/moByTSdM3Czp
         09gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793786735; x=1794391535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n9cL6tJQr2U8K1AlisarPnDBboHF0BEOhDBs7FJhko0=;
        b=V70noMHx0aBrg6a7p4QUBvpygzbuBfqml5fqXafvV5J36dzoEC3Ol64JFoAVNS05y6
         rphP88dC7bv6xP6dh2CTzoAqgxEcBG52mZVKPU7T84N8A73PWhdVnqncvI7iIh4y74Uf
         +rNEtQbgWc84SoTUt9s9G0iWXH6pLfBNP/EayNFbcOtXlb3VfDFqvpW2ZoPOf23jLtzv
         A1VYiHEiL4rOSDn3DivnmDqm5xyshUayrhCt0e/jJ/ECFnohNx+BGOAhIMDKF4U5BWjU
         +ZqT3GfpXoti5xJWl9jbGrQ89kOn6THYavOCT6Uerag5MkK4Hf2Z85Z3Z6OUcP3YeFc3
         K4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786735; x=1794391535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9cL6tJQr2U8K1AlisarPnDBboHF0BEOhDBs7FJhko0=;
        b=1v0gR+PfbRC0qmA5TQADVSCbdCO7z029uiznXpkRXg07VV/mN3xpP+5QsIP9po5jnU
         6kNu57Ujz5+4ERGkHbjB7E5mn0vV/NPjYdXiK6+qYVo3LBsi5CWhm73iXoFWxXvtbb6V
         SNLRmS8FUDO28Aj0/5w2wiLBWZoowLy6QtCtcHtAKxlHkeGq58RcHWEcaRmJfpWFSM01
         P5m9Oc3pvHj0w+JhdDS++jnQ5Di4rv44FCuiJdqF+bX1CCNfYhGls4Wq6rfWl7nor06J
         R4H19TyW+vmT+yy3oJXkZp8THuAmoTn5lOdoAyE6Cfnwi7aCMsJlQdlS+Sb0JJ0Mwyzt
         OkAw==
X-Forwarded-Encrypted: i=1; AKwUvByrzZTOa7qujXYPbJFOM5P57NE/0en5r7FdFUQlQlAHWsYVMd3YICriE+Of+CkDlXL3VQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j3GHIQKoY9DXXAkKDPv9AMVrAlRbc/etg35zcpbuLCoCeDb/D
	8nctLsom/80r0KTBEwOQAaLVbsq3Al9bZofzaPR4Qy2cwmNPme43d/Nbt0TywEiNfujxXWPyMJC
	SHB7ngp/ULk8u7ezZKeG+G/BW0CSLMi0=
X-Gm-Gg: AYBFou2Pez37Yx2gua4utQhEF+mtBMCrhcWAeQN556rbJ8K4dMtOb0wy8nVZX7L3AkJ
	ZYZUxt4g3KrNh6SJNgRHFzC8yR1TzOyyabo9I2F6Myf44UACbt6v9NnIIjJgU2K+1kdKZiQDFeO
	nlMiqeB3y9BO8bV2efzxgI1cI1QFCYjgMTkBHFMejcXInaVSzqYW4MWH5PxkmTIXLhffkwctScr
	n0Xa+d9oLvk2j7LeuCokUVV1Mxy+AF7UjRP/twMTVVBtyG3q7v3Xjsdn9C9A5O/b80dED5rtDBK
	wnsBc7la+9oL7FUPZMBM0VwYrPNYkncQaX9pdBl6kHjK39ASoVXDUBUjySJt0cuHPgJfnh++0Wx
	VycAQUT7QAML6vzjhsW/TATVGUP37kk6H8coTXUUdDnw+tSjQwUV2p4MdHVyrTTAdEmI=
X-Received: by 2002:a2e:a552:0:b0:3ac:df0e:5059 with SMTP id
 38308e7fff4ca-3acdf0e50c5mr2639231fa.12.1793786734655; Wed, 04 Nov 2026
 02:05:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKUOgLzP0CSwOwLeoSpM94A+XCT2X_cVojHsLugDfw+tBZk9LQ@mail.gmail.com>
 <CAOcE0wLn5tU6Ok90EhPfyQ0f_atkaFPQyWFLh7JovRGjZ9aZAQ@mail.gmail.com>
In-Reply-To: <CAOcE0wLn5tU6Ok90EhPfyQ0f_atkaFPQyWFLh7JovRGjZ9aZAQ@mail.gmail.com>
From: Immaculate Mecha <immaculatemecha87@gmail.com>
Date: Wed, 4 Nov 2026 13:05:23 +0300
X-Gm-Features: AclHuK_Bkxq2wGY9ZlrxKFJNNv96391DJnzlz5ZVnO3Z0M1byBnQplmLAHtio9Y
Message-ID: <CAKUOgLzN-7-ywvdPnpNF+KPbPovHko5iqZ2X6VaJvZjAaaZGkA@mail.gmail.com>
Subject: Re: [Outreachy] GIT_DIR inherited by shell aliases in linked worktrees
To: Priestess <herroyalpriestess@gmail.com>
Cc: christian.couder@gmail.com, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	kaartic.sivaraam@gmail.com, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for reproducing the issue and for explaining the design implicati=
ons.

Given the contribution deadline, I would like to use the reproduction
and investigation as my Outreachy contribution.

The investigation has helped me understand how Git handles repository
environment variables in external shell aliases, particularly when
linked worktrees and `git -C` are involved.

I understand that changing the current behaviour may require a broader
design discussion. I would appreciate the mentors' guidance on whether
this investigation is suitable as a contribution for the Git Outreachy
project, or whether they would prefer a small follow-up task.

Thank you for your time and guidance.

Immaculate Mecha


On Mon, Nov 2, 2026 at 6:44=E2=80=AFPM Priestess <herroyalpriestess@gmail.c=
om> wrote:
>
> On Fri, Oct 30, 2026 at 2:40=E2=80=AFPM Immaculate Mecha
> <immaculatemecha87@gmail.com> wrote:
> >
> > I'm considering a small Outreachy contribution around repository
> > environment handling in external shell aliases.
> >
> > I reproduced the following behaviour:
> >
> > Create a repository with a linked worktree.
> >
> > Run an external shell alias from inside that worktree.
> >
> > Have the alias execute git -C ../TestBaseRepo rev-parse.
> >
> > The nested command reports the calling worktree's Git directory and
> > common directory, even though --show-toplevel correctly identifies
> > TestBaseRepo.
> >
> > I traced this to the inherited GIT_DIR variable. Unsetting GIT_DIR
> > before running the nested command makes all three results point to the
> > target repository.
> >
> > I found the earlier 2020 discussion about GIT_DIR inheritance in
> > aliases, but I'm interested in whether there is still room for a
> > focused contribution, particularly around regression tests for linked
> > worktrees.
> >
> > Would this be a suitable microproject for Outreachy?
> >
> > Thank you,
> >
> > Immaculate Mecha
> >
>
>
> Hi Immaculate,
>
> I reproduced this on git 2.56.GIT. From inside a linked worktree, an
> alias running `git -C <unrelated-repo> rev-parse --git-dir
> --git-common-dir --show-toplevel` printed the worktree's git dir and
> common dir, but a toplevel of the target. Running the same command
> with `env -u GIT_DIR` gave the target repo for all three, so the
> inherited GIT_DIR is the cause.
>
> Note that with the main repo as the target, --git-common-dir looks
> correct either way, so an unrelated repo is the better test. The
> correct --show-toplevel seems to be just the cwd after -C, since
> GIT_DIR is set without GIT_WORK_TREE.
>
> handle_alias() in git.c has a comment, "Aliases expect GIT_PREFIX,
> GIT_DIR etc to be set", so the export looks intentional. That makes
> this more a design question than a microproject, and a test locking
> in current behavior could age badly. I'm not a mentor, so I've added
> them to Cc to say whether it fits.
>
> With the contribution period ending soon, a smaller microproject may
> be the safer route, and you could still raise this one afterwards.
>
> Thanks,
> Cynthia
