Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95D1F30C3
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026576; cv=none; b=NEgbc2S1zKDpuig36T+dBPwnjWgBhZKDaLzLWFVmAFYcKpv8yD7KjUv0PXADC1uJ2i/910/DNeCejyXsiHgh/YX7kfckUS28ZuBCo4d/zAlQVNWp1kQxAaM7rXfEGFBl5D21wiVPx3Jb3R70zAEWd+MSpP/ewrwgI1L5HmhHyaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026576; c=relaxed/simple;
	bh=JHxbIEB9LamVuVyneKz9rqUZNfIrl0d6uMUpDJ7nVM0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=qFiEkcPPLkE7ZiS4K4CTTuQ5AEGaTTOHe+cOiFwMBwOxbPbNerZgx7ZiP6W/YRbgluik/NoRsPio8sPJp8zYXSfaHzQ+3t6LulxPtffXGsHhY3ATHV71vmgM7KyoaoktYJDBnT2w/xmtYiu+OJKZrfytvQCuOuvABnp0MGcc5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti3c4gCU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti3c4gCU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787eb2d8663so2099877b3.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 18:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766026573; x=1766631373; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWI1fRdzuTdP22WfHUcwZP6BjvdNRW9yuGJxEe+n9u8=;
        b=Ti3c4gCUP24AVAeJ1hNg/Jtu1bCeXgt1Mfu/1vgQwGV1MHh9prwgHBDP1JmjgSm9At
         tyrTN6Iev3ycP3jqbL9/mZlhLz28bRs7mkgThkotFJ6jd4jqDMNlu6Zf2+WeogYywIlo
         cfbacIS34recPKi47RkZ5V8OCePCqDNTH2GRJbY7tWFUiF2T30T6Jp/IhfMCwSLFAthu
         hVLKaup1RWPPy3wULnQ4R2LlyW75M9mkDqlov77t2j9HDorsgYreRM3CE5zYX5ahVMAU
         DDBL9GNJNYcRHuZRSMViSmsHdQQXappRRfdDCCo6G6F2ucm61NUfiv+2zbd4V59m2Tzw
         d1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766026573; x=1766631373;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cWI1fRdzuTdP22WfHUcwZP6BjvdNRW9yuGJxEe+n9u8=;
        b=EpdhK9aikHNstgmFwIG5kH1exrjLfSEuG/3X2z2ZlubVE4CYVSi199OWE9lYCnufFf
         09CINyH0Q0euIH8G9OZO0CX9MFQ/WMCi6P7NNgke/OmyAgFfZWxvqdbgdr4tfDgas7Ny
         tzPm/8lcZTxNMaAyJ7d79EveQn8O48miBgrebNeV3+bgKwItB+zpDMWjXrNlQWriTeWK
         pISWIfbcdUHZj4kFoaPoUNVbFUyNrsX7ORuXVU4izrh8A7a0iK7S9TgWsv5D4ZMeayB1
         PjNcnFmyGqsCBJ5o/mgb4bMCzhFi8s6l+Im5qPW6tM1VzThUP31lUOV8KJxd/8gEFiJ7
         ZJgg==
X-Forwarded-Encrypted: i=1; AJvYcCWYAjm/xrCiohS81FRkrZGnWeTtujwyYfuBNIssbNu+10VuYg5H5srLBN4Q5n6a8O7BVXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsW5QaeWa5O6c9Xhc86tyAWyTM13vEErFXkSyPB7yDV2zPpeq
	5rGbgxaPWvsIKBcJFtx1QfWaoA3vqIeX1+xvEuUyrEnHQBhKG576nxZf
X-Gm-Gg: AY/fxX4p2aSfrkQ7G4gQcwfYtp2bd6orjMYbNIINsJi+XoyAc21HoaW/GbdhCDxVPEV
	42D9Hh5dmPrZ0ZH2K7paiuMQ5g/PZYOgQNtSmzliiadMys8sDRQ9hKLCs5jH1XiMyuf1NGQi+BT
	/+ThVwmtJG/Cf2PNd9lu+JrgeK/amdquIPU4brdAvSWSsCSUAFXManbn+bEWsi0+ii8pXjVZc/I
	ZYWmVQLgOm0bY1RDn7ochXdU3dz1rhgCsuEHkCzu1SGrEvy4z9b4UKlA3TJz3TkLhJzg8tclgvX
	zxPXRC+Ym8Cwo96ieA0QI86E2GHtVot7jV0QOohEj3XSjle/sqBsT50b2ra4bXI3F1oAPDJu8+4
	VgYOzr2+JKUhss1lFIcfhkStEYDCy0wDMtquqmGB0JoEEYEqpU/4zoR0eZkd/zhW2wlbQg0bZWc
	YEnoHzC9HukHtYVwUdsBgMwyW28MunpdYp1rhZyK0=
X-Google-Smtp-Source: AGHT+IEbQF+7mcyFm7x9ZZAmOaaEI2aNtXV7SExmKjyRllkLo3Vh3T1qZHPsRc/xejFrfqArQ+NDEA==
X-Received: by 2002:a05:690c:4b06:b0:787:c948:2040 with SMTP id 00721157ae682-78fa5abf3f2mr15050757b3.16.1766026573532;
        Wed, 17 Dec 2025 18:56:13 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5982:24ab:62e1:eea6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa7266a1fsm3639837b3.32.2025.12.17.18.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 18:56:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: meson -Drust=enabled fails on macOS without GNU sed
Date: Wed, 17 Dec 2025 21:56:02 -0500
Message-Id: <69EAE286-A7E8-43CE-A503-FAC707541244@gmail.com>
References: <aUApKxjYHMPHNIac@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 "D. Ben Knoble" <ben.knoble+github@gmail.com>, Git <git@vger.kernel.org>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <aUApKxjYHMPHNIac@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 15 d=C3=A9c. 2025 =C3=A0 10:28, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Fri, Dec 12, 2025 at 03:32:30PM -0500, Eric Sunshine wrote:
>>> On Fri, Dec 12, 2025 at 3:01=E2=80=AFPM D. Ben Knoble
>>> <ben.knoble+github@gmail.com> wrote:
>>> I think it's due to e509b5b8be (rust: support for Windows, 2025-10-15)
>>> [relevant folks CC'd], where we assume sed can take "-s" (which AFAICT
>>> is a GNU extension). But perhaps "-n" was intended with a "p" flag on
>>> the substitution?
>>>=20
>>> I've been building with Rust enabled on Gentoo now for a minute and
>>> haven't hit any issues, but that's perhaps because the command is
>>> running with "-s" and not working as intended (yet still producing the
>>> expected results).
>>>=20
>>> The relevant snippet is this (reformatted slightly by GMail, apologies):=

>>>=20
>>> case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
>>>  *-windows-*) LIBNAME=3Dgitcore.lib;;
>>>  *) LIBNAME=3Dlibgitcore.a;;
>>> esac
>>>=20
>>> but "cargo -vV" produces something like
>>>=20
>>> cargo 1.89.0 (c24e10642 2025-06-23)
>>> [...]
>>> host: x86_64-apple-darwin
>>>=20
>>> (on my older system, on which I haven't tried the build; the failure
>>> is on my newer system with close-enough-to-the-same output). I'm sure
>>> you can see why I don't understand why we need GNU's "-s" ("consider
>>> files as separate rather than as a single, continuous long stream")
>>> here?
>>=20
>> Yup, that's a strange one. Indeed:
>>=20
>>    sed -n 's/^host: \(.*\)$/\1/p'
>>=20
>> would be the correct way to do it, while also being compatible with
>> BSD-lineage `sed` (such as `sed` on macOS).
>=20
> Ah, indeed. Would one of you want to turn this into a patch?
>=20
> Thanks for the report!
>=20
> Patrick

Work is ugly this week. I hope to send a patch this weekend.=20=
