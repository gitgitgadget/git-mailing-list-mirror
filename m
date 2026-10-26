Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983631;
	b=nS3YEXZ+KAZ9FoVviWrr2qBz008b27MU1WWtWnAez5gH0lCqUmXf1np10dCeoFcNH2fM
	 zOnUubMFd0uAfhm+AmCNo2610iiFoB3Hhv6oxqOoXrL/3Q3ipj8kV+xV03+7fhuWaghEO
	 VjpLtjm0jZPyvTWbB9kniZtNbkMxsBrkiaI5LxeXBRj3nXcQs7n676o276TkfVwEADX/7
	 biIBVim7b5Mz3KoeOhlO9074En85HyOMnJDfe/ooGxdET2x6KY8jdeg4kC9JqoMR72dtS
	 mA+IWz4+oEUXr6V658y4ZOhvyd0nRn8jjAEzERROpS4C4M4/dwq1/vOdK6GhDEaMu9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aGyjmZ+2JhZq7h9GHgHiZDCOWu1XryS6FLFkzZ6Jc08=;
	b=5LSqBCPkkDMk5mbBsSFq6n2zriciepXNzWfKc8fsZHDA1C0HqlJZOQyjuYLyi7DEba9e
	 AZcs35S/KDBgbNBJ6ppTcofAwVm8Gyro5xyt8AycTzG6ANgU6QOzbbLlIf5EcVdAw25TM
	 YPyDIfpudpnZixPTbkqtaC22vz26Rcz7CdKHhkuaN6+r/tlPdcfl9DVZqLOqX9KhH+rU9
	 YZCzItPXycJfyyzLDfBFLJSHWWsCcK1/DwLyWDX7lS3Us4c0Erz35Hks0F4u3iIhWSZrI
	 Fx1aTNmxKSCYPvkM9CrH61A03m1UNv3t2ktgBII502/ubacKZOHNwQrzFGy/AqlvNdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bZmag4WN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8370606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8370606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bZmag4WN
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-53ec9237600so1486555b6e.3
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792983630; cv=none;
        d=google.com; s=arc-20260327;
        b=pc4+oO/n3zHgXIwm888T7dVZzYcLhmp8Vuu7JB2nJbFogaVh1Z0HXZoOXjxaVqA9jY
         UbOn7t1Uq47QKOlGsCrKRRZV1NbPZBTGBFS/G7WyM/cG+tmfgfDkVRpTf/MIP4kPqqJA
         l/PyjE3NtaR66tqi27owAffjIHBGG/wWYD+4mPY9+VGXVt78dd1ZqNdlUjeGgdg5hoDH
         rJBovPo9H9kBmOjf4dlz5fdT7YflZy4DTTQAtaq+Haj1b4AFDcWveqOxMemZxmY3MZRw
         /kQJ8zAIpZ/xB811YX5SxTkRi8+aRK72fo8NHZOWmSY856Iy30HuNZhanbl+OXvSf+qN
         qiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aGyjmZ+2JhZq7h9GHgHiZDCOWu1XryS6FLFkzZ6Jc08=;
        fh=omdYVhLuSZr9UgpBAd/pGu8p8kbQ/Nccja0zvlYQk1Y=;
        b=kXDJEyz/XO7IThXmUnPbaKWCJ+Uzd7yS/C79g8y4ipTPU2GG7cVz/4TwVECptyjpAG
         JibYbY70SD2ZBq1tC3OwLvuZRZFVQ2LqYliBo2jyVygSHT/6oorB3Pq8dr6GNobmo9dT
         gfWBGOuMz4AHygu3Qi9z4z0zeNlgRwFAidMIEvAp6nzUMVyaurtvJ0vExKXfsoeAdas/
         wmZeLhJzBykqwWHWldxm6WmR18qYxsLYURoA8mDZwQlG4TRrbckqw11P7tyfKzlu7rNe
         3CLGJvD6SqUNzyt8CRjQLpcNsX5YJpbdlmV9JY9yCuCx5vfDzaEWt22k1WO0ssgRxd0x
         1Z4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983630; x=1793588430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aGyjmZ+2JhZq7h9GHgHiZDCOWu1XryS6FLFkzZ6Jc08=;
        b=bZmag4WNc0BqX8s8BIRKSrxl5e0W6Z72sfR1WIqmZZdrG2By3nQFBvoHeT+3mq04Lj
         19/4PUMckVtFVwmLUN4zoPyl6ZsYKL5vLSS6BI7FwTHYnWMO6wIBb6YCJb70p5YGRSgb
         FlDTTv/B2cHnKDYYjsA/xbKemRfINomhMAb18iKlWttNxtB4hEddtd8hPQ1Hpai824Jn
         CCO7KcqCvow8y2iN0SKXNFI1WTaWfX+2sfjnyY77LvyYZdJJYPxyJPthsGtxOw0m2Mf2
         ELm/E5yjkZqHsa8Rt5V7DzoegzS5dBnLhZiiSWFvjXDfykfgxczNZYRnkJVDfIc4EuXs
         wmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983630; x=1793588430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aGyjmZ+2JhZq7h9GHgHiZDCOWu1XryS6FLFkzZ6Jc08=;
        b=P1h/I256UlRNeyBIrW0JQuOOZNhE/IerV1lSCYkN+XEE+FPjkz4xBMwKLEc0f9QUui
         K9vb/zaOCG0O3DV/GnHcdtmExJZvHPeZf5bSIeYsP8UtCd8nSdP9+MAUQcsFbu5lbDWA
         7yKfIq4tFSK/9KQ2QiKOtPj8Iiy6mYKuGZNrJbDa4UeQS3qNpopE3wJXmrez0+dj/Ru4
         +CvexRDoehrMVksd7AcorfMGUMQwoaIfkaChrNLewgQL/bHfNI4HsphNl34QT0UQOJHo
         c+4ueeaDZeKPX8FKL8ttkDf5MOf6hdSleaNXs5k6d5omJbFTrkzXL0AbAJS36hkEJM+b
         n2Zg==
X-Gm-Message-State: AFq9FYJILJGSidvihbsMz8H/49YT/ZQzX+9E57c4Z/sxDW6+4fDsDawt
	JsCyZCPVDwWX/07J4jrPIvy1woaEQpJkEQj26T6CpTo4na+cAVEOJBh1zhLWvBvZZs+q+lRLGX2
	m42FIHNo8IL/kmnBrdXeTk0bjwAqn4f0=
X-Gm-Gg: AYBFou32SQuMl0Ii1oZ3yGMexFmfc97pji1r70jZupO07T/JiTA00eQaS9masB+J0Nw
	oArVgEhwX9EbpWS7E6UDHV0SX/v1yZoQR3mMD9ctyVAeRN8Tmm2FYrNv9HdVqR8BGfOFIccy42B
	/p1nSuvWu4ri3nSKVUyx9F/Z4fxoodjB+5aa7KlJBE/P6VD18AZBy70KLzFSZqyPUesTXVxPADW
	qOGF3GJDCW78NJekm8As5Qy41fb1DNV1NuI86bHpAsKXsZ5W6ILzhlQktSxZJJ7YhyV4u/1d8WT
	0ibP+wiPxMLGg10BhPJhIbYjYnN5xRvFoPnm9iBkjy82v59qfezAzR2zESqPKPasU16JX4ecBn3
	Ep8vn+gXku2moHSXs1IWBLLwmLnRPp2OSExR9yD5SuXgR0nRdumFMP0I5d8CgqGoWhy07sthL9b
	S9b6hxmHM1GgRERy8FkVt0k0YTWHyJpUU8p4R0J/cTrVAW1gkElz+pl1dn
X-Received: by 2002:a05:6808:c2c6:b0:4fa:8d48:3a5a with SMTP id
 5614622812f47-55c002bce7bmr3750366b6e.38.1792983629816; Sun, 25 Oct 2026
 20:00:29 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024052449.95869-1-tangajoris@gmail.com> <8b60c7f6-4a1c-495a-a594-aaf322279539@web.de>
In-Reply-To: <8b60c7f6-4a1c-495a-a594-aaf322279539@web.de>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 26 Oct 2026 05:59:53 +0300
X-Gm-Features: AclHuK-ddz99f0vxs981HvtIm5SyXFM-zc78Sfyn08Imr2BOa4n5FJDDv3IM04E
Message-ID: <CAKrRMNqtqYiE2YKVky+mHyrkqtW2c_L_DcCen1hyaQa8D0+fWw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] git.c: drop NO_PARSEOPT from builtins that use parse-options
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Oct 2026 at 10:59, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> "git fast-import --git-completion-helper" prints its command line
> options only after it gets fed a line of input.  That's odd.  Do the
> completion scripts still work seamlessly, i.e. without requiring the
> user to press <return>?

Thanks for catching this. They don't. __git() in the completion
script does not redirect stdin, so the helper reads from the
terminal and "git fast-import --<TAB>" waits until the user presses
<return> or ^D.

This seems to happen because fast-import only calls parse_options()
once it sees the first command in the stream (or EOF), as it reads
the "feature" lines first.

Since patch-id, diff-pairs and var return immediately, I'll send a v2
that still removes the NO_PARSEOPT flag from them, but keeps it
on fast-import, for now, as I make a separate patch fixing the wait
behaviour, and ultimately removing the flag.

The separate patch would teach fast-import to answer
--git-completion-helper before reading its input, like it does for "-h".

Christian, I plan to base it on top of your early-scan series, since
it touches the same code. Would you be fine with that?

Thanks,
Tanga
