Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D752BCF7F
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201715; cv=pass; b=RTzrARzmw9C9zLLJZFlKFWcusvtG6QKIe9lZ8jCKrEN1JhW5EE5PVPW7u2g0kKDjUV0kGdwlJq4r3yYpE+ljrYo2jilLMtdRZu35hvEJkOD7rAB0mGnl2IB1NXUajzKGLICKg03dsQJVQ0XyHfUIWPYYM1hbxUtYIckbckxLWuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201715; c=relaxed/simple;
	bh=1PjD28vvm30/KbplNXCiZyOV7AbJGll9Zsk1PN6b2qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/BJaf5Llx0P/wHN2onPfa8/O39IgM2X9ajj0GfmXNqUcFUQU6cdyfWdjOuTpSBFNcWpWiqEQjpzjY6b2S1ZLzzlHgWbEVPH/O+QxX6Lykj3omo6eXQXH7WZa5oJGb8pXl56fSfhl42nwKxr+O9DGrlWFqb64fdeI4AWzA2o+Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB4gN/Xo; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB4gN/Xo"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so513182e87.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 18:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785201712; cv=none;
        d=google.com; s=arc-20260327;
        b=JgNvvkhLoO0MQoJb/dv+dB6Iq7EI20E1pC94MfXiorBNK7pUFy1iZjModcVQVdWCXF
         AJ1DgSpPRH61+S9cLUBv/PnRhgDFE9YU1mPVnBZFfV84onhayhAbqaPp2gnpduffhR2f
         37ooJ8XpHCvjH1wFANwHEBBNa4AwnadL3BZ2eTOP22j8X6IOQw1Ae65T32hCAlopmCZH
         gQDmZzH46TdvHDEtjN1Esut8Zdf3oEXuGc3o9G+lNaxwMtXTHTAnlNkVOOjviHnYT8RG
         kV7VNz55IoSWaQwAw3gEV1x6dvMVaZjTBoPcMkBtkvP6+JUOltVgysjJBSYnZ5XFnaUX
         tGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6S5XCtMZPn7dIuqNlzYBWP7C9/U0gj7eP4Flg9xzI4=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=rbKgVUzmD0ZTePU5HuSgWfbd0fVMWlxT6Ku+0jl9nEtvyx4niiOHj4EfZaKL0sCoSP
         FnrxP8m2GetBbklVqhqJM+nXX4tJbCa9UY2BzNzNe1HCN1UQixlYs81ufTsXzIF0SKAm
         17yMr5Q/JtTFBqnk7fnuuhKgmsujBB/57YGkBaxDnRGUHVc9dknYcpY4YPMvBI7/D7zq
         BYEsnzFRWobYY5i/CT4YcCe1izDNwUQ2kGItuBKtqWYEke1Qo6PIBT48WSz48dv/amNh
         7D95v7LftKXBLr51k9pxnmr+q8IuXHtd/qXKvvJT0rM1cLE9xvMTACrX0yZc4OMVxAY8
         95qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785201712; x=1785806512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V6S5XCtMZPn7dIuqNlzYBWP7C9/U0gj7eP4Flg9xzI4=;
        b=GB4gN/XoRcvDx/YXLrtaWdm+b9VAz2Q3dB842LZSJuCH/YaEtXT65P16cCtxeo2A2t
         zLlyGUcoqrZ6nqKG0+zxwk+pR4bYRZ2AGLef6Vw1EISjyw00mtruxQwsb6pGVIjJ8YDa
         xP5xZz5Zfre0Fp3GAF/urlYohPb8WDuHxBGxPhu2R8VthnhJaPI2ThSHH+vlGy8pUV/n
         Rz4Vo6CdhGARLmJQIsa4mpolQzhAyWdlhjeLiM3IgIghJLl5n1nK1jW2y4AwQuy26L1y
         Y25UyDkXXmGPx1jYzHDrN6JMREaU8EXptlYF9AcegLxPCdxuhbjXr5HHLxKTGBO73hC4
         YbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785201712; x=1785806512;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6S5XCtMZPn7dIuqNlzYBWP7C9/U0gj7eP4Flg9xzI4=;
        b=STxWNSBB83N8+9cV71zghS1h4xkCkOgRPgPXxcpJIg1UiJb8F2OVVIYJYVFn0fuFEn
         P4NRNDRj5lpPYxyINaK41m2rGAy8A+bDKQj8hdmu+/zqHV1/CEM8PFC0pQgdykK/FLPw
         Mtl5a42t66ZYUKxLXUvfU8rxxekCjqpswMobjqI0u/nlTtmg6/jD4BNunqq6hBiFeYow
         +ZrqfBu6kxY3d6O1+7bKaoaRkNGKfUSGQG6zT+WZblmL1VLHGwaAiVybzAukGyAQQtPj
         h/ppoABl3QYQrhGfAYJPGk2hk9mH/Sqz9UU2TKLx0bRhIdlHuqz38iqxcMF9CD4GqUZu
         FbAQ==
X-Gm-Message-State: AOJu0Yz16nrKMcu6k/9Syir1cdC8jZkJwTZff8IENg47fQ3cgAUTiDmw
	JO0r4xfMta10+O7QGwJfg1ySZtp3+UA1BTGXKIgZ/kzXAzxtifuNRECSjK1fv9g9LBF6QHIvgsT
	tXiK62WJZ2zl9VbNlfKwGhKERfIvpbaD1c5EZ
X-Gm-Gg: AR+sD13DigBjwxTmWxokz57gEg7JCWxc4tFIV3J078n1qXmDGSlfB6Sobgd4CvwOw09
	WLDxiMZNBUycaQuyMpmBRuCcdWGe3g3e7sGDxVPlHn0S4Fx0OJdfy/6N4atW8GFkzTOCmzEaB2x
	7QIlcSLer0F4jJNkBjyQLmtV7GevrbkCC3KR+SqN1Dp8XuCYClcPQkx+lKWGPWaUuy2i0FG0zgs
	6fN3MF5QDXJUHy1VoVeQn95xU52j3pTGox23cq20sopcLfWBY2raZ2xmvO41hmye3Q0chPFhmbi
	BU/e9nE6/HTPHtZifEXSgS0bvNtxfVo0fes0qVRGXezQGi1AFCf5lpaU1YoWoWe/y0jxzavw151
	GXbDq
X-Received: by 2002:a05:6512:3d03:b0:5ae:acbd:439c with SMTP id
 2adb3069b0e04-5b2d0259e36mr38368e87.23.1785201711919; Mon, 27 Jul 2026
 18:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com> <xmqqh5lkq0qy.fsf@gitster.g>
In-Reply-To: <xmqqh5lkq0qy.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 28 Jul 2026 06:51:40 +0530
X-Gm-Features: AUfX_mzrB6Zq0jgnbuTwdawHftnIKuosYXttp91unxnq7ieEaTtPYak_nr_w9uI
Message-ID: <CA+rGoLes7q3rGgWL++46M5n+5FSecadAN0+4GKEK2bFPTVx3+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] repo: add path.toplevel with absolute and relative
 suffix formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 2:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> > +     format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CAN=
ONICAL);
> > +     return 0;
> > +}
>
> I can manage to wiggle it in, of course, but I thought we lost the
> '.prefix' member from 'startup_info' in the recent tip of 'master'.

Indeed.

> As the topic is not targeting 'maint' as a bugfix, perhaps we want
> to use a more up-to-date 'master' as the base of the topic?
>
> Thanks.

I see Patrick has changed the prefix member to the repo struct.
Didn't notice that before!

I will use the latest master branch for v4

Regards,
- K Jayatheerth
