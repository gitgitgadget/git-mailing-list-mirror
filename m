Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D522DFAD
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615618; cv=none; b=NnwMvzUtZ+p0yQxVXajDFYoctxQW+yrv/dytdLmQgbU//mDOCOjEh+oJ0EhXFCakHG919teT7zGV/25DTD4SweEKMa9K1ZQDtzmuSJg64TDWSU3H5Vti2sJrJ9SdaxScKwpww80B4X3xEBy5hybMTYMXmBq5Id9duYO+FBzjkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615618; c=relaxed/simple;
	bh=/3/KvU0dseavmmyU3LeMymrYjvi9NqeXhNocMR1hewY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exyjgfnaRwOD2Swrf+7SzYUc/99T0pvG0gs6HnG/y0Nn1vYDqdW+eWNqSY9LKKFVbl8j/G84xJ1A4MflKaATWxh6BLIPeSKn6YwlrfcbZX9GTQXfPSNoL7F32EEfAuB2bqH5o1xIW6UZjJoOeQ20I7lNuNcGLQf7Y491cwL8HeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io; spf=pass smtp.mailfrom=pspdfkit.com; dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b=kjqtvvtF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nutrient.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pspdfkit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutrient.io header.i=@nutrient.io header.b="kjqtvvtF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89f9bb725so420270266b.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nutrient.io; s=google; t=1748615615; x=1749220415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg6dPPWLWVKAJq3JFUC4zseE1omqjmPEMMcoTdghgDQ=;
        b=kjqtvvtFT34HAyPFr7xJ03dkpGYklnrqiHflvWy3huHBcVqAl/YtEg3DpdK67rM9pD
         VVOCet/1l07xGKAyarfgY9uIWvVFlcfRa8II7RKVqUJIsu78E2UNjnfaNTGRdnOfWAv8
         k7kJwFlozXXoxtgGMWZibKuc5136tJKPhJxzgRWBTxK5YWnuUb7oLAxHWYohFdfT2Jqz
         zrWCFNqsDdm0ThyXRE2Xavqc+pX28lPK15czc/zF5yC1Mo2AhKo6u5v4UwRB9JRnEtxE
         OJedJ9ESp3ml/sRa2McOU+2Y0Ypd+QHXxOhcm4F2lbFUHnOcwKnfiBSNwMJSPx17Od+7
         80iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748615615; x=1749220415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xg6dPPWLWVKAJq3JFUC4zseE1omqjmPEMMcoTdghgDQ=;
        b=HfjkVdbDY7XCD7Gv1mTf3EFZIe/A3E4BXEvxWsChKK6EWLPQSK4BHd2QhmGJDvCNbS
         g0oeO6R26GxufJJPTpALOZW9rztnua474EzP81hwO48txSy2F+miWaC7H4c5E6csLbU3
         1Zh3OUoPm2sk3wUOAuWdjRPudymwVl3J2k5E1ZH05rSa/5wEg8jc6qNi4FNU0Rv1VkV8
         j8hSb1uHdsCSlDsYjUI9P0gSExOaY/HWIql8+nBqd5rzF0/m67Q2RG3hDZUAo9oXCZUV
         /0mKll+9UoR2Ey2HxyHrF3KMto3gJOEWZR0LiIncfZIIBuM1D9UlI6iDFwDIa4J1Ovaa
         hCMQ==
X-Gm-Message-State: AOJu0Yz8zTKT2wti89De3zM05PqX6be+l1UzZSkwwfEXWkJmcd0vx4El
	w3XB5qMGCYySyZZDML06O+HTva46HwoEG0GLNJ8bjJdbaEaQC4U2RuaWO2bobCOrsN28xd9M5nP
	Q1xaWJwdjIIWJiwjkleUQF16zfjQp23v2XPMPGBhtUQ==
X-Gm-Gg: ASbGncuvLbtawOLVTalZ3T8gULMYL7zWvpBgdZnd3CLM2mH5T+pjKHf7E2jX7C/LJG+
	4WQdKb6IHsPOw25WOV7t/A7zNyWVdSktscwf0hGELdEN6dHhoksiBVnE7pKbgbivTWnHwZ1n0A1
	mNvQUHkU25q3j8vNd/yAVF533/CbXngG3TYg==
X-Google-Smtp-Source: AGHT+IFi+OkkT3k+ztxdDgZg4apXnGrxcPP2MCsB0qhHKLIYtYEji4V+hxmIIh+3n2piUVoiVjVvkDqe1ve4F7xNRyQ=
X-Received: by 2002:a17:907:9450:b0:ad8:9c97:c2da with SMTP id
 a640c23a62f3a-adb36bfb187mr229270066b.40.1748615614663; Fri, 30 May 2025
 07:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528130116.21534-1-patrik@pspdfkit.com> <xmqqfrgnhuuw.fsf@gitster.g>
In-Reply-To: <xmqqfrgnhuuw.fsf@gitster.g>
From: Patrik Weiskircher <patrik.weiskircher@nutrient.io>
Date: Fri, 30 May 2025 10:33:23 -0400
X-Gm-Features: AX0GCFu4Sx99fX4YUBwL6IVrDzj5h4KvPUVEDQbw461Ks3dsBokUQ9cs65Rh_yk
Message-ID: <CANMzfzhhHX1J_vPH-DMD2kPmQ6G_6YUV=7aZ5JojGy-LU6guAQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] contrib/subtree: Add -S/--gpg-sign option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, apenwarr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 7:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrik Weiskircher <patrik@pspdfkit.com> writes:
>
> > Hi!
> >
> > We use git subtree a lot to manage our dependencies, but recently start=
ed
> > requiring signed commits. This patch adds support for signing commits t=
o
> > git subtree.
> >
> > This is my first submission to the Git project - you don't have to be g=
entle,
> > but please let me know if I can improve anything.

Apologies, Junio. I replied only to you and with HTML emails. I'm very
new here and I'm very much used to different workflows. I'll be
better. Please disregard my previous emails.

>
> A few things ;-) starting from the log message where you didn't
> quite add why we would want to do these changes.
>
> Also, I think these two should be combined into a single patch.  We
> add a feature and make sure the feature works correctly and we also
> make sure that the feature does not misfire when the user does not
> ask it to trigger, all in the same commit.

I looked at your review, and I agree with everything you said. My
patch wasn't very well thought out.

I'm also at a crossroads here. I'm not sure if the optional argument
parsing will work out nicely in bash. Let me explain:

git-subtree uses `git rev-parse --parseopt`. This *does* have support
for optional arguments, but highly recommends using `--stuck-long`,
otherwise unambiguously parsing arguments becomes impossible.

This is true. There's no way to differentiate between the optional
argument or the next positional parameter. Therefore, I would have to
use `--stuck-long`.

This in itself isn't overly difficult. There's only a couple of
parameters in the script that that would affect. The problem I have
with it is that I don't see a single user of `--stuck-long` in the
whole repo. I don't necessarily want to become the first one. Seems
like something destined to be cleaned up at some point.

This means my options become:
1. use --stuck-long or
2. make -S not take any parameter or
3. make -S require a parameter

I'm not happy with any of these options, but considering I really
would like to make this work, I would probably go with 1.

Any opinions on this?

Thanks!
Patrik
