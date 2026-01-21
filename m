Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C633B6D0
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029233; cv=pass; b=PU3Zt0PHQFqeET8cvc34zh8mEhp3hDkWuQS5P+0CktDhw+SioWTGE2U4+MqmZ2HMLnlnyPkDV1p+3mYRor0/YYHNY+P6Fuuy5dHeNd9K6yMWQAeMAkjUo9a5JgZemu1Bn45aikmxusUCFX+Xqnd9MfosckM3KlcqS0hRmI7oMbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029233; c=relaxed/simple;
	bh=7VugLP0SeeLTUDNr77+l9oESkMqG7cbtjM2TDV3O1EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGW0AgTringLcLzILCPOEp/ktseQ4NsOneDPaRbnszK/JelEPaEQKoZ6KDaMGN+xbR7YgGnaCwAcgRdmhW8qfHAgHbSuD3U4dCyZyQOxqqmx3hK1egKcylsTxSzM8s4k3B/LW0dHBEczU5Mjdv3oXbh1A30Y/IqnS0fDCxIxonc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW9Jk6UI; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW9Jk6UI"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-382f9930e54so11611371fa.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:00:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029228; cv=none;
        d=google.com; s=arc-20240605;
        b=MKxQj64GAgMTur2ODqQBJzkglVliVKfY6VI/lOMA6KBGqpYZ5D8uBjo/jhkz3MLtpS
         RrV1KZLyTw1qKDj6LYcpIsBWnk3zaoGc3m5/ZyAmN2F9AzoV5otkLbCjr7rwDT+KuUvW
         OAzQ2zzK+C49bvb+f1k6gaOs6wXb128ovynBDnLHK03L6YzEt2L1CoOKmRcNhVUnVf3g
         ziSKiYrrsDZNH6RscgweMM7p8bV599PJLDNbENNeCXqHdCAfwustLKMUMvy9iL+hlnqm
         /E3qSvCqI/ivOmA6Of8GX/+PiHWwRwypiK+UkbsMHLvHMduGPdHCSYbQfSsdHgrO4Bco
         JxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQCEfBOSuI8UZDmTl+3c4ktGlmtGqsGQNYOrRc9j3pQ=;
        fh=OQzRLeDdMNCiQDQq29JRzQS+eMeKOX92CeT9F991rZQ=;
        b=hiV/UjxS7PmFgD/ElgbgfY5vh1rYvVkDiLLWjEWrz3aB5n1up8Bbt8hPrPFhgQ8Y2n
         M96sOSU3QV1EXccxAYDTdiZQLp32PbfZcTrauNyfsYpvZ/sZ4XAp1ichuPlzHJIqUTVh
         G44+tSKiZxCij4JTLOKCl158ObTIZbiNZOL+Uh2wAIdPAyUZCMSvvyl5ZkNBXNojlcIS
         0ziOJIq9Y12s26PpjRq+4ZSX1kEFv8KB2N72qwtwjfpDMmxYNlsAJUNYg2vR6isphHYK
         mIis/3t4XzvkrfBSvXVJLUP7tcpYyDkwXsCSwGgTJT4wgZEQNQTcuMYmYLsqYWTDAJWJ
         BOQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769029228; x=1769634028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQCEfBOSuI8UZDmTl+3c4ktGlmtGqsGQNYOrRc9j3pQ=;
        b=JW9Jk6UIfWvCNY0Guj4ORYNTU431NhLlQUIdH8lAOLep4W9O8PegA9sY3XY2xvc2gW
         f3TLnv59g2canzg7RqkqD/6bgzxrkVmG8QDFI4RLaBFYNQ6xVIdRyZhR7Mh7z2TSBbWr
         xRt7WuIxbTG4YI2pi5zZCDfBnqSUUaGiB2xJB8bPeFB2ISE2Bp/OOQEbCLRPSV72rgnh
         DrKvXNfR6XuvQSBZV41wOgCzs3KttQ1oQfYqYCldLxiEybT3GsgtuTWXX2qXAXHOVISO
         jGPMSaxL2WIk/6WpQjVCK/qd89hQ8X6beTHEIYYPL78RDZ0pjuUcyrrRHrOnn1K3kP+7
         Q8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029228; x=1769634028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQCEfBOSuI8UZDmTl+3c4ktGlmtGqsGQNYOrRc9j3pQ=;
        b=WllhWp86wEAyiDzUzxjHmasYDdm0niLniVVZuPSuVSeg0GQtc9IO1dPiSDMw5bAx3i
         4VhhN90SY2Tn7cyL4mnCPVxeJjerPUU8NbIni6FOS0J09T6PMGR2DluWkTIXyJbWeElW
         cbo/TtC4u4ILSP9PeF/iT5DYCWfGsPyV/NtK2NpNDdYhrwI8VI23HBy9+rE11Etngaw0
         vjDg02HXELmT52lDYgwgtGHnw2Yqf9P54svPjJ7fWjL7M9F6FTz4DuUwHSL6hACUx521
         xGJs/4Wn3H2FuYyJJFQoNvJMO0lUG7QMcjbzFjmtDReG0O/RuXj6VOzBOT9Xuu3sqpF3
         ijIA==
X-Forwarded-Encrypted: i=1; AJvYcCXiv0zXw2iW2yCWbwtulaATJi6kgqaxUpFhi71VE1Ajfi4Q7hFHZ7CzQuJW5b4ORCpMiKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2yCk6LPComtKb2psZOt8vfDtsRkMf8eC4HH9CDMJgdomOPq8
	llNKoEENmzwO2NKEetE2t/Z7LBwzd5j7kJ5b4cs8NaR4pdWDYUiIAQKD8u3KYmDuBx4IXiqFAlw
	DA7mB/2R1l/TmYHtSoy8K1qJzFtNE6Ds=
X-Gm-Gg: AZuq6aIiZrEAEqDWoArKheSu4Kdgw1gEC9azChmjGikvzHsLVP6XY6nhlDpVkNkyCjw
	N61IjeFhNlaZunibDvSFHXqwlzY3/C8dUknWMnOXQklbO0nEbPjPSowAgU4rZ5gKMKpUNG2oCdm
	zWF1X2fX0RP6u4wu0uXm5P7q9sZ/+hQK2dSshtUdq82bMrfj164MHLQ2rZeTL/nIAzemaIemt3m
	/W0CpYJa+2adAmdT/BuOzsxOpjEAIcwQT5Hu1HRlcj+GDGix9za9nhQT2JVZ9GE6Ume26g=
X-Received: by 2002:a2e:97c9:0:b0:385:c236:33a2 with SMTP id
 38308e7fff4ca-385c2ba9723mr1562651fa.16.1769029227595; Wed, 21 Jan 2026
 13:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com> <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com> <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com> <20260119055947.GA3100271@coredump.intra.peff.net>
 <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com> <20260119204010.GA3148606@coredump.intra.peff.net>
In-Reply-To: <20260119204010.GA3148606@coredump.intra.peff.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 21 Jan 2026 14:00:15 -0700
X-Gm-Features: AZwV_QjkLeATsQYjEThxabDpcMmECUR-uRPxnw77YGzA7ttYMOdyokO7uWFsXlc
Message-ID: <CAH=ZcbCNeYATxqAeXcGd9kkHzJq2y5BpMrChSzb215EHAjHsbg@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 1:40=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 19, 2026 at 01:21:04PM -0700, Ezekiel Newren wrote:
>
> > Ok..., is there a way to pad a field to the largest size needed so
> > that this also works on the harvard architecture? If C isn't even self
> > consistent then how are these structs going to be passed between C and
> > Rust (which is THE point of ivec)?
>
> If you make a union of the pointers, it will require the largest size
> and the strictest alignment requirement. So:
>
>   struct foo {
>         union {
>                 void *v;
>                 uint8_t *u8;
>         } ptr;
>         size_t len;
>   };
>
> would be a single struct you could use to store a void pointer _or_ a u8
> pointer. The one thing you shouldn't do there, though, is assign via one
> union member and read from the other. So I don't know if that helps you
> or not (I confess I have not followed this rust discussion at all, and
> know nothing about rust/c ABI compatibility, and just got roped in on C
> esoterica).
>
> > Or do we just tell the arcane Harvard architecture "too bad" Git won't
> > run on it anymore?
>
> Minor nit: the Harvard architecture is one where function pointers are
> not the same as data pointers. An int/char distinction can happen even
> on more common (von Neumann) machines.
>
> But I think we can rephrase your question as: are there real-world
> machines we care about that will have different pointer sizes, or can we
> ignore this issue for practical purposes?
>
> I don't know the answer. I suspect it probably is OK for Git not to run
> on the machines mentioned in that C faq. But:
>
>   1. Sometimes there are subtle implications of undefined behavior that
>      may cause a compiler (even for a sensible machine) to do unexpected
>      things. I don't know offhand if that is the case here.
>
>   2. There are some modern platforms in which pointers are a bit more
>      opaque than just numeric addresses. For example, we've had a few
>      patches dealing with questionable pointer usage to make things work
>      on CHERI Arm systems. I'm not sure if any of that would matter
>      here, though (IIRC, it was mostly that pointers were unexpectedly
>      large and had matching alignment requirements, but all of them
>      equally so).
>
> -Peff

What about adding clar unit tests to make sure that different ivec
types have the same size and layout? e.g. sizeof(IVec_c_void) =3D=3D
sizeof(IVec_u8);
sizeof(IVec_c_void) =3D=3D sizeof(IVec_u16);
sizeof(IVec_c_void) =3D=3D sizeof(IVec_u32);
sizeof(IVec_c_void) =3D=3D sizeof(IVec_u64);
...

As well as other tests for ivec.
