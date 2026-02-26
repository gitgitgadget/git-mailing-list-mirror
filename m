Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40069309EF7
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111033; cv=pass; b=bDISLb0X6fj/sc1ehqnYZsSkTIRpCu6wkZQkuB5H8mqGQMxRCKrTrf+Ny6PkY0EeB+hWqQzCOIlq9Kmop6fCZEcBzeTwI/p+nJohZUpFb4xBDgICskVG6CLR+sXMrwj5aQMSYQBjxpOE0prOCc9F2N2LSjnuJXWckdl2s3BBtkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111033; c=relaxed/simple;
	bh=bKzKn2Q+gW4rCQVhnV/Hw+DDz4DLP3058hkyEZ8Px7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axCls+Hz5y9sVllHiOhiJTDVykL9dZCKbPFXhjODt3V3yseC4l0dzBveVWf6toGu5whtaX3c0s+bUVvSsTk032FADO1hmKRBopgfFmrRU8hfbuVST596fj4LBk1M+X4yd2/O42Q0HYQGMhEanXDKnAVXV6Bo06ifZklHlHAd1IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA0++fWS; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA0++fWS"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c68f0e47so415223a34.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 05:03:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772111030; cv=none;
        d=google.com; s=arc-20240605;
        b=gcEq8mFdO5pWf2/Tk/YvjPm54DhAUBPQzp4woXI6Z6TsuUOjm6sPuzVytoG2OwLzHx
         7Y76HgDCBtTmGme5G3YljzRDaO/tTFAQLFw9B6y36DgI5qNuxsv6ckRLjDctvx0Uh86u
         44j2jHFAOXGxAeL0XFFfcGidwpe9YsqsDiQ/U8MnGiY/+cW867rU9htezgYjDDyBn0YK
         cwu7++qcEbip3sEvB3prrTRXlLNbYawm7g0mJDykEiW4N6I6C4T5orq7fmfkD2dgzKG7
         ADf0HM/TRzAuEIaH5KKRQHd6ropbCyaWQmCgWFkThQ2f4nUyG3kkAuL+Rb6a/OIqiobO
         r7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F16BQZumfylciGCCXVIshxRo6MvNk8PVUjpk+r4mLng=;
        fh=XQoDUKkBmjYtKWjHw7Q8XcylU49m4d+1nXbJBS9YIpg=;
        b=T+T0A0dN1KEBGM9lMZBFj0luu5CTTZ7ewMhf+iZsiNrkWK4ClM08dMaoN6M3yZrnT4
         Ge9KUYsenoPTaKYw3u6ipy5I9RJ1HBd+Xf+CE1xmoWQZaSZz4d0WtNW45JO6m5fjLZVg
         gdTIZXPbtxf7CfGSONYwpCnL72ThcftFM4UMFC8LvBmgf9A8rr6T+vfzMkcngNvvCR5s
         /EeeG6pXJ5x023Z2l7YTssddWMu6OWFJTLbFYOZw6gwl8f4hLJ7hrEynz8a/pECmwwii
         QUxeBwKBDHCVVCyxQ7hBKSFPtiaNpPuxiMWfyVTMzse1IHaJBJM9J+wKve0HjX0Pi1Tv
         rrDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772111030; x=1772715830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F16BQZumfylciGCCXVIshxRo6MvNk8PVUjpk+r4mLng=;
        b=WA0++fWSYikguK4/vY1anm7QuKe5//cmbVoB9+n/wZ9yGpsuc0qxFQdxWJMxtMJ1rN
         DQwLjzVfTgKayqSsGunCeo8onJi1T5lb831v+PI32jPQ5pU+cjPnph877DqXhdn33CCi
         nsi+vvXIraFRGsg3EejKs+RAQfU6BVEQcD9fGUzZJP7acPfdBE0wbmHxrUEks0cidEHE
         GB6JamC/P6UFvU+/QFcLHDyXhuBC+Psm4QKhAPn2JbFq255hLe4jzmGMaWQlDgZmKqgw
         aBmlQ+f6Zt9zJeYSejsTv9W9C6DJh3AQatfjchlJb6yzcCRGGhHoA+OXB3slPhUWMEWv
         G5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111030; x=1772715830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F16BQZumfylciGCCXVIshxRo6MvNk8PVUjpk+r4mLng=;
        b=JkU23LBoMQMBYBfkGQZ3nbmk5lWW3bNiKtz2buEAMwK/T6J+pUNjOYzL0LiiY18K6M
         v5haZA2anH78LEEB03lF7KAv/OCldFMR7+ikF3vLOCWKA94lomIhFIkZa+2/eSDirWEt
         b4vCrxLuWcAAQ56W8Lwm5SDqicTDVXDYP0RVBKRJYSLhqzSSq/GEElcKuNL7MLKfE1aA
         +rzM0zqe4Sg1M2Hiup5wCyYIwm7KtgdyNqZ+1EYPKb1wmFS5iV3qkzzNSOD3s+UEfkez
         KfaYVu54Ef4h6VaRfeDssYBtpDpGAX5Tikoa+IFRSnWMwBgXRYseqda335Q3wAfEDLeI
         4X+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDKjVPNpTGP4jjzLculhCCs6PQvusVyAa0YEJtTSJdNk5qxOXwRQyiN3pWx5SUAhEq7K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQW3+BpdAbZqJxeJvrNSVkBwf++NH/7CLwNZPiEdE+a3U56Fd
	jVGLFueRTv0F8AFsF865rILSN+LaZjOtBmflp+KquPYLpOLOKgNW/1SYa5SNPOjBGLN7cOw/IuZ
	8TDd+RgWQNihXHVe3SCzHUn+WVfVc9oM=
X-Gm-Gg: ATEYQzyJRrJywdHzZap0W13zwPVdJBv1kTncAob73KzgQyf0VdydP69FYSygXMvGEXw
	jlTU3iGginZMZB87MKV60OjjMRDD71MyYZOcVGZBnfqHL7ifuBjgmLi6BnQpqS9X2gYmvB5iajk
	hyxjQ/YO1ftcsl6lbueL69keOkIJ3/pU3hBjvsh1iqLl2wUesA40jFEWI2piO5InXPbuOOVV+rw
	0J+Y+fFrE0RrIuONJdd/QvnverCRznmk66S80q4pJ4RqVOxkAG2QpaUsXyrJQbLgUQu0mryV2XX
	R59RH42V5jgXCMjw8esE7QVAi8xN7R+oHGwccWaJovRZuq6joX59+Ssm1Jm0Xh8XN/qagJPEgOV
	a3HY09Fd5UrJDd8sSjNAs/Six
X-Received: by 2002:a05:6830:7103:b0:7c7:5907:b1a8 with SMTP id
 46e09a7af769-7d5829fcdb6mr2482155a34.13.1772111030009; Thu, 26 Feb 2026
 05:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769256839.git.belkid98@gmail.com> <cover.1771258573.git.belkid98@gmail.com>
 <xmqqa4x7b0ba.fsf@gitster.g>
In-Reply-To: <xmqqa4x7b0ba.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 26 Feb 2026 14:03:36 +0100
X-Gm-Features: AaiRm52HbNXz-UTC51zfvZWDs-VLE70mWAqSYty9L-rTlAm5ie4e1Y2L1RtLXOo
Message-ID: <CAP8UFD2Rz3NMrTayi9yjRk4-51tStaLWKeBVB9RaJMWmiBLqrQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v7 0/3] store repo specific config values in new
 `struct repo_config_values`
To: Junio C Hamano <gitster@pobox.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org, toon@iotcl.com, 
	phillip.wood123@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 9:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > Changes in v7:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Added the code to reset the initialization of the_repository
> >   in the fuzz-commit-graph test in Patch 1.
> > - Changed the call to rep_config_values_init() in
> >   initialze_repository() by passing it the repo config_values_private_
> >   struct instead of the accessor function in Patch 1.
> > - Modified the commit message in Patch 1
> > - Added extra lines between variable declarations and code
>
> >      +struct repo_config_values *repo_config_values(struct repository *=
repo)
> >      +{
> >     ++        if (repo !=3D the_repository)
> >     ++                BUG("trying to read config from wrong repository =
instance");
> >      +        if(!repo->initialized)
>
> $ git clang-format --diff $(git merge-base master HEAD)
>
> would have pointed out the style issue here.
>
> Will amend while queuing but it would be a bit before I can get to
> this patch set for real reviews.

I took another look at the series and found only another nit (a
missing blank line). Otherwise the series looks good to me.

Thanks.
