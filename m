Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793484127;
	b=Y8oajUUa1oN3OoQCm7gFT+DaAPOdjfVjD7V5CZiUTj758nHMyHRKoTtb++X+JZWi/8oS
	 qXoqNHl5FyEVJ5lTaD4tJdl3yx7/YMBPHyO3uWqWRyC92hNfzaJSCsjAsw9+enlMXYo5j
	 QVJcpKGF8iqNU3evNZX/R/g++xPH06Gira3N1m5qbtr5nj3ilGGyokfkM/CSVK1CP4K4H
	 RP/mngo7KLthIQT1sUAN6J2+fMVnhHPOnfwt9ahlaoW3odueyBR1BqVImVpZ7tTciyQYr
	 axTOYupG11on841zErlXm3WD/QySQVyd9EY2DyZpME5zPK9EWrgSjPRwmhdnx9O7e0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nrq9WUZYc3roIL0ut4vu7BVSZVFPLEYhLtmPBFJ6BBk=;
	b=BBBvfDFVg/+OtqRzkzj0SJhEKvYT8iBzQ5cWdjy+DpoPax2Ps96fAAfnZ7lX+7FKmLL0
	 JPLCKi3uerlY0k0rGRxugb6F394Stp1ios1T3j+vbf1GJnzr0VL/JtgZesk9AS0eARbrr
	 NbI9VPTj1XJNqhOc4Ga+4zisThUWVc2Ak8aQ0Fg1o9rG/2Nasqd5nnnsYcxIr8k4rLj3j
	 /UoM83ap4bypw0E4ClBNekK7B3ruABCR5ETUD9dtmcV0Dvxz7PNiI6/k0ta+lXrAt9Len
	 mPN4wrLPz66tHpEQzAhBawTyq6FAVNwwWDIFpta5XGbFPFHSpp6gde4GlPhGe23Rw+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1xkriQ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF3606A338
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 22:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03AF3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a1xkriQ2
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dd4f3f696aso858912eaf.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 15:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793484126; cv=none;
        d=google.com; s=arc-20260327;
        b=LCqtwPTT6giPxzV7UWyAtbf6T7m39jr52woHyqGlhIXt4oY7m7imA7/EkHN8FqCC3b
         JyQmSDXanjPkas/MBKOZmM14Kmby+PzwfHR8/TwGhVwK36FAW7huFKWa+3wLJV6zNE+f
         X/xcxW+IErPqm+mBBJG7v4a2lJoFs02NmbATqRRAPpF+ZDoGZFhOi6toq9DudbHSFy5Y
         fdB3eJNGAJaWR6mM7YA3dnyJYQV0baLJ9PavOyuctXe5Q2BWuAmd+erBTwsjZHZfqf43
         d1sqiUMQicsT8HpXPprSsZdmqa2q3YRVXskzwD4c1azvMfIQurovHRGFZYVse7sz94v7
         5B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrq9WUZYc3roIL0ut4vu7BVSZVFPLEYhLtmPBFJ6BBk=;
        fh=hz+/nn3ggLKvx7MVMCnEfhHO7zZTcWxbS8wudRGL11s=;
        b=TDqCxl3sEwuRY0MEllN42g6fu4IKDt0yKnpozGhgWIIbjzNn7dY4+0M5N3xwf7TXuG
         8D/kvGwyBGIRGWzCFo0S92mURVVWfpaBA2UBdUB+/n4qu+clpj4yK0p0GHheXhbFWl1D
         OjFRvcvshmWZ7UFLgUmsPSK5Jpo6craA8tji7tcikOzBz3jqVhCT389g76VfVF3vkHpi
         nQwo3qUsDJc4HoIfC9ZRIpHf0qXefEDQzzOyZ1+ZD5gZ1gUShC0Hs76PeihEHFxMv2dK
         Ys1r4vggg1/cLCFpuxVIFxO/x0IVpRHQNSsedSXr52hUG1Iuw3O8I52TetSiY0CRkSVR
         WPKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484126; x=1794088926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nrq9WUZYc3roIL0ut4vu7BVSZVFPLEYhLtmPBFJ6BBk=;
        b=a1xkriQ2Q6KWNLdzOQN1VaQdBILg47Pk8w8aInRQujG4Yfxo/qgMsM6xr0FbI+d4Mp
         w9GKYwTVKDaKm4nsp48aThRG6350D2gC9SvLKA639Qu6EqqYqi2KaWxcFfDiQHZ+fF0A
         KrQJzPm0XNgHn/vOJGpMcR3Xi3uqLYbsLfsHPskZ6QYHXTD6nUs4Eerj7FvnoXxBOaiW
         Tdi8tqZk+MlY/+pFWnT7XZTVD/lDixd0EFlwyIQjb5QyMXHBlcYU+FXde8zh7e988Gy7
         pcHtXC2JJGw+hIBTk4Z/hpJ+41L/wJ1tLGGt6OYEd8shLd+6VQMG45F+VkkeBhW3qqvL
         gVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484126; x=1794088926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrq9WUZYc3roIL0ut4vu7BVSZVFPLEYhLtmPBFJ6BBk=;
        b=Nmd+i1K5VFbQKh9xY/Nn9UMLv2RcLhYa1kQvhQeD5mjMkVfb3HMx/CqXpWwgQmjkUr
         EckfXrh0v/sxqInsZu0TFDqYmfCEqK8zaRfBlR1wmHILnMDY4baeu6Z22jELDFz5glpb
         PXKyBCg5hmYwGe/X7/bfFq1+s+QfZeWVD/jCwQX3oAgZE0Uq2ipiL0/RAR3xcViornJJ
         wNJcBfh73lvNtqmfBoV5o/6wP0GAjONpb3diNatR2tdDIwAfXPxAMnuV+GF25z4tK7lZ
         s3P9JVEpep31grPJr+6xNB4bnRuZgXQc+wR3lbskDyHV3F/diVGropxj1zVV3WggFex7
         yFJA==
X-Gm-Message-State: AFq9FYIs3vDy4dt/rmTl7SdZJyoAcqdUIgQk0gZhfGLnBSJ0/wIqBeqx
	VnYyreA3iwpMgJzUwIXUl3l2R0Xb+4Nj8NdPThh+IjEuPab8EfejmvkjO9ntx2kc5g5vqKzVla9
	iJ/wqGTSmyJvr9ju96w7PulwZ+LwV0kU=
X-Gm-Gg: AYBFou2zhYqZue2sHHNvK2ohhmiP55RH7v19NRf2MCjd4+flv5rOHvW9uTUwGU9d2AF
	Htm/nTibSmEP763Npk42sSdNnSGkHbxc3qYZN/3c/HR9S5WZgypEctE8ku105t+H45eexpJaKPr
	OwzOFO7orHRjavvcjldJi8/gmPbMGNbaxsN0TJ1d43c6W/V/nRFKZjUtLhDn/AFJaf6Dv3E8Ano
	eBKCc8Bgaoj0iKiT/0ZThKQXVsZ/tjGrnLt4Z5U/MnzGIUUsA16nTizy3BWY0w9qapao8brTN9D
	XNEoppBUoP3Xfbb/mCBLTeBAhKlquYlSPdUtAtAK+MT3JJTN55MScQWTmRCkgAA0beEgktJrjyz
	sygnmlZ9tmNArOiloUC/cKhb5EHJt46hDHsDbfRmrZffKyi2/kM2URbB+Jr/7PE7Crp9IvrbpBp
	WyWbn32/ez8Lk5dDXju+IMJXMBOfmpKHyrsap59y7DLMnJKnM0KzRx
X-Received: by 2002:a05:6820:a659:10b0:6ff:fcf5:40ed with SMTP id
 006d021491bc7-714f2a97a1emr2246108eaf.90.1793484125863; Sat, 31 Oct 2026
 15:02:05 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029012616.139783-1-tangajoris@gmail.com> <20261029231621.48958-1-tangajoris@gmail.com>
 <123de4e4-3387-4eef-8a05-9ed1ad1fce30@gmail.com>
In-Reply-To: <123de4e4-3387-4eef-8a05-9ed1ad1fce30@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sun, 1 Nov 2026 01:01:27 +0300
X-Gm-Features: AclHuK_NYAf_WrTmCCjB16uX3nnIzHf-ZXzTCul7nUqLHnt-HnCAv60de_i6ZRw
Message-ID: <CAKrRMNoAALZ0V5fdKjZPQnCXuMP8y49vfUmxYnRt7UEeUTE7kA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] parse-options: answer
 --git-completion-helper before command runs
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, l.s.r@web.de, gitster@pobox.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kaartic,

Thank you so much for taking the time to review this.

On Fri, 30 Oct 2026 at 12:44, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Just a gentle reminder about this portion of the MyFirstContribution[1]:
>
>    It=E2=80=99s good manners to reply to each comment in the mailing list
>    discussion instead of letting the next version of your patch be your
>    only response. Tell the reviewer whether you plan to make the
>    suggested change, keep the original, or pursue a different approach.

Thanks for the reminder about replying to comments. I'll do that from
now on.

> May be give a hint that you plan to do this in the following commit?
> That might give someone without context (for example someone reading the
> commit after a while) a hint about why you are worrying about marking
> fast-import with the NO_PARSEOPT flag.

Alright, I'll add a sentence to the commit message saying that the
next commit removes the NO_PARSEOPT flag from fast-import, which would
make "git fast-import --<TAB>" freeze without this patch.

> The change seems to be fine but I wonder if it is worth a note in
> parse-options.h about why show_usage_with_options_if_asked() is also
> handling the '--git-completion-helper' and '--git-completion-helper-all'
> arguments?

Yes, I think that would help, so I will add a short comment above its
declaration in parse-options.h explaining that it answers these before
the command does any work.

Thanks,
Tanga
