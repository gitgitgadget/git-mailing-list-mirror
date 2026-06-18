Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A92D0C7B
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757540; cv=pass; b=OPss6shSJjCaNb+pOIoKt/SyllXUefHF8InzwQpYlhrWRFq5p24lKAlP/+FWzmvfN6/4W8AA/eXncuXvQN3WI2eH0OphI2coIGTt2VsRGH4w+5wfYKmCe1Tqaiu6yLb61mJz154+0YdStj0UalSBmOhmwEMoTUOgUPEK/NNh+ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757540; c=relaxed/simple;
	bh=CMHgKlfsFaI2ZcSTbQ0Xntc/ewjw/RGBMKO2JUGCcSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFfIm2S/DiGpy9v2Fif9xkR8ib9Rx9dpg60UHyhJeUEd0urn5zIEhW4tNUVdKoKQdjdyanG269+2kzHoaWVC/M0o1XWEzSOc0Iy6lVjSIyixeNt9gR0nSLNK4LtK5SlyxT2OhZGdSUV2BCW74ZbBu97KVy/0oM1pVVJR1mY5CGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI4kB+fa; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI4kB+fa"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6e9408e30so466016a34.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 21:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781757538; cv=none;
        d=google.com; s=arc-20240605;
        b=BXUvbhBmo/QiBXeVFw4YA0SkrHHoYbXrBRPK6uoCncEnoJyE1/1//Zm8sJK275hju/
         D5xrvx7xoNvJUWLfwAG/G41p7eg/jWgiI29bgQIXJ+FHh5XZKI0CRBTQOIcJbm84RrNH
         c5WWIkSA/5bN5Sr3hpi3wIsZYLummThtVPEes3viGcNrbZy5ArLFuJmpW7fxkX8v9a2j
         KwZwfd3f2lUFbZ+BfMqKi6fOu9RRl3fbtoDTi5JZtwQKxjL4nkmFIbFt5C23yR9FY3DN
         NlZvSBQVbUuFUXi7I1q7SaFnqh8H79CcNRuwpCoZ9Yf90FW4hfW6qb+uVqSOryD1sJYL
         X+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QF3AvAe3anVCqnIzeZVpXUuoEA2lx16Q59AA9IWrFwA=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=gTlkzhCJiNKjPKJDHQxqr3YyQ/5KbfVEqhAzHvz4ty8WwNENs8FBVa7sZvbWroM8EL
         bv0Jgo0Wu21Me1o74/9JiRaQ9dD6HYQy0q6l5Bx8wxVcQgde2ythbOiIDBeaErNh7GOn
         7rCUZl0F9ZVy5yAiSkmCizk1eNtow+ZTjPSM2RJFfY8y5OJ86/9rZA/zneNSqwikZSry
         qlKo8QWx73aFlLRa/EIwTtM07YXl9eQIc9cXmhINwR+HvDd9WRgSUo5GL1ZO7fkIzaOI
         BVKKT1oPvIOGp7u4U+q9ysusDeSYzyNP4ltiVlIAwNKtIU0PSPUv9fMRSlobqJOvK5eQ
         1lfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781757538; x=1782362338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF3AvAe3anVCqnIzeZVpXUuoEA2lx16Q59AA9IWrFwA=;
        b=hI4kB+faRC26kdVBuT01p59mgFoKdO8vWpUJzbpBtBhdLmRzo5dV09/4RcCpR4VcgR
         1dSqYqLF7zxhnX7zw7VWcfn/EhztKTKwrwX7i0yVipeiz2ci9y5zmi3L6wuRYT+zaq7a
         hwkySVwY6PqttVP2PlP43ZVN1hC2sQkfxX69Ijz6A3h7Wk76CLH7TKMVcuNBaYvLflBb
         QVwkNzozOcLFstJ/Bf1nWWbqK2pMxnQt48CCr3h98gF/L7lSBFB5MaEm8PnyQ93/IpMG
         EWvVhQezfWhpCvhT/60TExkJsdXmD82oOl+PdHD13rNIu962DUAR2UT6HjmM5MAY7hhw
         7Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781757538; x=1782362338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QF3AvAe3anVCqnIzeZVpXUuoEA2lx16Q59AA9IWrFwA=;
        b=f3hlVjrXPj8gicHW5R9TYl4FXgpRUQHSybqw7M3VKF+1zqdjYD80WGH0z3+21L/sN4
         X10uaQqfgV5bNtSX4r/zbk9jfM6cYb+IEy18vTBitspSTJDmZDh4LRKfBnPmzbg7fsoj
         tLuL87KOTOHCtKuVoQgwl/Gfiq1mh46dq1C8v2IwCrwp4y3qoBVq2P0QVJHxWSFofLBJ
         qrM8FwgpbY0CuNUY/qSVQpcI5Cmteue2PFeNChm/TW4IAjeQGFCOAWLVnHv4iQCk2Q8L
         jzLAhKA5mzrgUuLIoGBGB+5tHG60DSn/U44NQifxDb8DKUaG+pgEwLtoZeFajGAyZIXZ
         j7VA==
X-Gm-Message-State: AOJu0YyhWVpJnbEyT58ubnmABOuj/MRb54W/psUGTuj5r6K7fF0oMPRD
	r8JVz9jpEbk34qZ30f+UrWBa1Cr552bLgmxQPfPjY0UT6xZI3wmlY6/VWFdojlV8Z80hsB+ZBI7
	+taynxlGufpMIBPFVR4w+5lb8AqLhDvF5xaFf
X-Gm-Gg: Acq92OHsSggc7wVSwM7Mh0lEHoTs3nU0itbc6XFBisV5AwE79NuAEALqge50cn54NYA
	ZRp6TtJNYDCgn6A64OhkRa21J5FLEosee698W2vsN3hNU0w5FAylMNB83IpAI4By7Y206i+gUBf
	cHrs2Ce5CnhYalw+8wzzQCLWRG/ua8UZm3ReeG2bQwBrfhGt+05AYmFp136zE/vPXOOs5QRwxlz
	AKW5/+htY6Mu7bQxINeb9i2xC2Sa418UX+iPAyLtJY5wjcrfTeTKsayhjf7/Rp8XEwwyfszSrrl
	WWFe+Kgut3itWn88xLBB8QEfqA53jA==
X-Received: by 2002:a05:6830:6a9a:b0:7e9:94b:af7d with SMTP id
 46e09a7af769-7e91c3219f0mr2103538a34.20.1781757538604; Wed, 17 Jun 2026
 21:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
In-Reply-To: <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 17 Jun 2026 21:38:45 -0700
X-Gm-Features: AVVi8CeLu8TEpITwGwaPk4n0feJu7D4AqmYH4sxb-Ogt38tJGxz3IV6oh1KVMZQ
Message-ID: <CAC2QwmKXqaM5_AeEpNt04YRJa9K6G0vkFtfXvnq_QRShpmSoPQ@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: address design critiques
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 8:53=E2=80=AFPM Michael Montalbo <mmontalbo@gmail.c=
om> wrote:
>
> Junio C Hamano wrote:
> > +You would want to be particularly mindful of critiques regarding the
> > +high-level design or viability of your proposal (e.g., questioning
> > +whether the feature is worth implementing, or if the chosen approach
> > +is appropriate).  You want to defend your design decisions on the list
> > +first, because you do not want to spend too much effort in the
> > +implementation if the design is not yet solid.
>
> Two small suggestions: open with a direct imperative and replace
> "effort in the implementation" with "effort on the implementation".
>
>     [B]e particularly mindful of...
>     ... too much effort [on] the implementation...

Also, maybe we can even more directly say:

Do not spend too much effort on the implementation if the design is not
yet solid. Be able to defend your design decisions on the list first.
