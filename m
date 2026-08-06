Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5340A940
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017353; cv=pass; b=LSPB6ZFdD6wl6+mrqAWvjb6wMS9YksRrfWIOII6/O6hef3EpYC3GrXlv9E8cAJVw9VOWJZaLRNJRJ8HiEelp8vsSGPM2Wqj3H4VHz5um/AD6z19Q+/eenNxeP2kz94AVUUVnuhNn/DjufW5fsWEGHEpiYDPuGhQILdzjggQGXLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017353; c=relaxed/simple;
	bh=7teSZktaqqEBGVfHfGlsGclkAguM2VRHokIKdpmAph8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIUpx9fF6qS0Ja7r2xD0AKLYYin0m90ktQjMnX+Bfv9VVsDdsiD7QUHKMkQM2zbD1IvOGzplKiE/4Jnm8SQFqxMWxmQ301PKeJdi9pg/79Ww8c/E2ee4MAA+t5wCYwOzm4tTg/A4UtytVYRoCBmTI0RAfM5lKYmbieZoywYnto8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuFk6mlu; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuFk6mlu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d004f135b1so25809605ad.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786017351; cv=none;
        d=google.com; s=arc-20260327;
        b=hW8W7SROntiZscF8kcUTmn96nXsVrGPgpJ2Mm1ScaSnjTVTVn2wxd6SJCMbevPZ80w
         1ouxJ1rMQRl+EfC4uOJwY5DCLHU+xAy7OtqfnKlCl98Nc5nZd9NXeI1Kpr8ff0OlWjc+
         XCUf/HI5FXvitCXMumUWU0h7erKOMKNuFmUpITDVJXv6Z6ZbqCjYCdDKo8qmSJs8LQ8W
         KzQOp2thXQSzElheSkmIJIo8VLBHf099zow4vIGGJfuEAm8FjjFum55rR/0xKh3JpOB2
         rSl8Flc+U43Lu+x0/80p2Sd2rQQEVWDJOS2AC7Pw7tqjsV5V5/P89j6OqJulwDf9gGhy
         O2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txkqrnpJm6LBo2C4J758y5IAQu2sO7zL5clzWDYxNwQ=;
        fh=vClq1Rt2WRwSod5dZTXe+aNG9LSP5gGoIDvHSGyfdVo=;
        b=qzbBHn+lnAbeyZTYLLFr139DTb8AOoZiDLEt50xZf/YnFrRx5GHn1IjTRdq1HcwBI2
         F7YG1Mu77dTXXDuSDOJWHgrynDpfq3Km0+1fKwORNAZJQ9UepDuEbCGZtDBwli9ydKA/
         gJFOd/h9L1e3prz2nkODomrZ0ivLIhjqEuoNhELvXefpuVMN66DxIPILasm3gJjA3/4L
         JttuaPxfZ+BcDnqlKj6RAl/68NmdEVTpPz4lTlwT+aAmEqAebYR5F80KlK0Xs8KGTPSG
         v0E5oTb09TS664yQSpeB9YrNkJBb5u63TvFBqXuVymn9nSjrll0FyzqyBDfP07QquYfu
         fbyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786017351; x=1786622151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txkqrnpJm6LBo2C4J758y5IAQu2sO7zL5clzWDYxNwQ=;
        b=JuFk6mluh29t1rHphteVxRHl1jKCbC+VaPAemBireq9LidffmLG/5gs5tVX58EG2Ai
         WJjEIyCeJn5usXkA78zb6tfFWEBSMQoYXl8Vyt/ryQGMRTajivNjWw3fV2NftJWaw+uH
         ow80TWD0q6XQR7GJQ6NFJTiZvuUpkPtB2gC006Ix1T4DLdjc98I7CfFykOkrDBY1wVbX
         /xU61ElozoO3/7btNTtnC9pVsHK6KMRIRkfipBvbQ2gsJP5+zQEcTs5HPERD2xanmrUV
         IDoLf4smhxjahF2XX6kWsDR5EjFVr5uP2kA/rBRikVGI1vG4atrLsfzaR2eURZ/r4O3i
         i5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017351; x=1786622151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txkqrnpJm6LBo2C4J758y5IAQu2sO7zL5clzWDYxNwQ=;
        b=Hm5I2+HXzDK3OId7h2ckVXEYHblbOmU2fh/zlcruCipBIOm3QPhBKArlcEmVZMruJ5
         HjbUtclhkNFPvhjI6srFd+sXZZbpQLS2TjvFUyMfGiHKxht7aPwwJ48lC59nBkbz6GeI
         EaC7hXptcshJVs8JWTS13MvjuR/HqCsrlbJiqKACqZFfreaPrEiZs/sJE8Dcem9y5b8y
         mPYWFc7IGhumLy2TnupBWTBsEU/wk0OvnKb+9CM2klvoTvWkwMl+f+bQ4gtAtO37GJVZ
         SzyAgYu6sYfO0Oamy3GBFl/0nil6UJ/fZaQiOVtj+Fytsr/096Vl3t6HhQYnB6yEeEfB
         Q+Yw==
X-Gm-Message-State: AOJu0YwzHUjXfgt+TsIuc7ihBZNGlxyTYI4ei7PW3IobWN4q9/kJw7B+
	C5hrSA2S1br1cBlZd9e1/Nd5OhH3Aw7SrWhI4s+q8iWTepBGDVzIdJ+oKZaznNKUXHbt0GJ9mHa
	3ELux4IW3kpRrwvRAqQJkSEWCxNi0jM8=
X-Gm-Gg: AR+sD12pHo3+QNdNRPOQkJkH4YrsjfO0raJUP0Y3tlZNKWprzBs8bQ7rJl8WA2lB6+H
	+yN8KJmFlyc6zXyZ0D3+EdPNKEIAE+EiKABINazuLZuPV9E59e5MQwasbQKg7w4zUJ+oxauxmGN
	DjEPS1thvs9kheepMECSKDsCUzhD0UZ5z18x8JJM/Qykxb5o4SjrHJ+uRHt2gG5Ivh79pkgtYAf
	vz/nzotZb4AsQT5K/bu+vw4Vss/pTEhX+2Nlb4LU3GMRt3hqaKg7J5hptmTIFz1M/3W8X1JtDXp
	h1X7CSy3uhVqlORNOac2RdwdwcmM9To3WjI70jcbG1Jham8MmNYkVv6gbibg4arcmDXMduA4NIa
	iNGM+40pjcaLFfhcNWTu5BaMDA24S4R4mmvhyssiFwh+621mIfseArx1Jg+iJTTw2UbMu0k50Di
	uUPxYt43Ab2p0dcYyKOvl3XvoGqZT4xQ==
X-Received: by 2002:a17:90b:1808:b0:38d:e658:5959 with SMTP id
 98e67ed59e1d1-3903c545edamr12322298a91.5.1786017351294; Thu, 06 Aug 2026
 04:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Aug 2026 07:55:38 -0400
X-Gm-Features: AUfX_mx0Sq3XqyaOZNzacXiY7KUEhLMp646O-rgqRj7_OfGJtK7neGLs7Q-0Rhw
Message-ID: <CALnO6CAmM4r2uiuBFJcciR_94KPRSJoCOsuNKeqTQ0Bt=Puvyw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] doc: interpret-trailers: explain key format
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	jackmanb@google.com, Linus Arver <linus@ucla.edu>, Matt Hunter <m@lfurio.us>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

Apologies for not returning to this for a while! I haven't read the
whole v4 in detail, but I reviewed the final diff and output.

On Thu, Jul 30, 2026 at 5:18=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name (applied): kh/doc-trailers
>
> Topic summary: Explain the format of trailer keys (alphanum and
> hyphens). This is important to keep in mind so that metadata is not
> lost to simple syntax errors. Also replace some terms and define the
> important ones upfront.
>
> Here one change lead to another in order to make sure that everything
> stayed coherent. So here=E2=80=99s a linear overview of the changes (as o=
f v4):
>
> =E2=80=A2 Patches 1=E2=80=933: remove RFC 822 mentions, =E2=80=9Cmetadata=
=E2=80=9D term
> =E2=80=A2 Patch 4: This command is not just for commit messages

One small comment on patch 4

> =E2=80=A2 Patches 5=E2=80=937: Explain the format in the simplest case, e=
xplain
>   the =E2=80=9Ckey=E2=80=9D format, and add a new example
> =E2=80=A2 Patch 8: join some existing paragraphs that are about the same =
theme
>   since that makes the text flow better
> =E2=80=A2 Patch 9: Also use the =E2=80=9Ctrailer block=E2=80=9D term intr=
oduced to the doc in
>   patch 5 later in the doc
> =E2=80=A2 Patch 10: Rewrite new-trailer paragraphs (relates to patch 8)
> =E2=80=A2 Patch 11: document line comment behavior

A few places we use an inline list syntax ("=E2=80=A6 (i) stuff =E2=80=A6 (=
ii) more
stuff =E2=80=A6"). In the added example about ASCII trailers it is useful
because we make reference to (ii); in the initial part of the manual,
I don't see any references to the delimited items, so I'm not sure if
it's worth numbering them.

Not a strong statement, though, so I'm happy either way. Everything
else (that I looked at, see above) looks good to me.

Thanks!

--=20
D. Ben Knoble
