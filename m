Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2B3370EA
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782582793; cv=pass; b=S/Xahl/tNYGMJD5E+BP8D0H66qu8BtuTH03fU1IyLern04XxiE36/L6i0DKUYzYJQ7zOi7zbuZu07BzHrcA1kn1YMYmID20FKunThvLjoWUtKqOIEkyNSagNnJDr5KmJhxb3lnnLofor07HKA/Eyu+h8gFLc/Up6QZpVy+yNXVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782582793; c=relaxed/simple;
	bh=4QSLYNEHkjHgGfUhBYVZ0XFScQZeJfg2uAiByL3aM4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7iLb1mU7/09ndaEvaOT+Rm8M/oM/oMY2KlTvqmYicRLjKKYm1tf83tX8gKMBDNXOQUpbNcrvdy8cUWziQGeESHxzyK/i/wvogrEgxLdKwnGpqODEJNGzxV+kGByR24j2xMFovvtbh0j9kjWiskoE3OCVzLQtlecor8qGxCIt6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYSWrBU3; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYSWrBU3"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6647c26a4a3so1777933d50.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782582791; cv=none;
        d=google.com; s=arc-20260327;
        b=lWvYaFQwDjrkkcJKm+hDlhCAjNKVLMpjb+lYeJRhJsRX/uDQ7zrMDbvidJnlwhmwMc
         90O3Ul45WOvg95ZACiZeLIYXz56mwPowBSXe3y0tofEoZUGa4nPKq8VMMhiLqVlu+Ezr
         Z6TneJIWbqxsvYM7GDd0FV9Myp7a+qIp03h43go+kyPEChP5vgRWUCjIgZzL9HxnBM4y
         58rb33gRD2EU/c1WBRUBn/mI3YPwfzY1FTBcMpZcnbHGVvUTUFMVRUWnF5r16Ks26i2k
         xQ0ZhH0p4kgsKGnxOJ9ywBU2wUL1u3yJWRZoZKRXFHKZMHTwIinWlA03KtUMB0kas+eR
         eY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l6NON4y0wgfkQgZ5my4Y178WaeDDBLlsLVVhosSEn00=;
        fh=clL7yXZIPo9AtB9rYW7pjk/7NgUZhNJoLLacyUAJNc8=;
        b=iZT+HcQNW4BPC7czxSiFT6euDIuwvD7/oKBxcDehz3AKVouotjf8UkdHu9i7vgwGmL
         ADLx6/zmp/rpvAV49NGMOg+6DkmhzNL3FTJRXSqtLya8uU5Ru40Ho/yNt8YT02n+aDUP
         M+mX4wrpSt49WTwGyDAMKhA9uTjryW10SeoScSH2TZaHPJ/qHeGv/Vq3d10GxM4YUglu
         cq87laXuAmmRwC9Q12gqYU1ouuecNUxnM2UCWGFm22EV0cD8U+C+5uJccaVP1jj3goAB
         sl0XcEflrkr5RAu2PKMLTjhupCUi/ZPIrxg6mOMbdtXnUBajBizDSfkf47X2Hk6Qkd61
         7SNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782582791; x=1783187591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6NON4y0wgfkQgZ5my4Y178WaeDDBLlsLVVhosSEn00=;
        b=qYSWrBU3v8gp0zmtlFN9gWd//TZ88R7rX5tDVYO0NOwI2+umg6QTwqB48fPy//CA2F
         33fYbfkDZ27cNypzPOX0z5xGsgEjtPtY6plCmbC4F6VuoHR+w5fHfmKeFpmR4h5BjyYw
         +R3daHrSinRcqJpLXeXkahBBpMpnNFle8VDl7zZkJizpXu2N1O8G5DrROysE7WCfhNIx
         Er4bUlunVsvai3MgcB50kpGODWTM/m/+uhrWlircGTgRSzhL3tfF2KnsgLixBV/Cze5W
         bIhQQvuQxOzoi3W8w5kUKxkMkoKzmLtm26UaOYlw8XJ8tSkReZ/G6sm50GDoVnOtme3l
         tKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782582791; x=1783187591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6NON4y0wgfkQgZ5my4Y178WaeDDBLlsLVVhosSEn00=;
        b=i72QwRvvcqox34qvf8R/avResZe90/V3hfmdBzPmeA+DscqYPs2acYsmEP1czm+bp7
         A6tB3G5dEU2YlaDq56Fs6AaLFZlBw8+52fbUDPxTo0mCT7mrbSntt1ZfXOJSJed0+ZJI
         fHveGLlRJQhAgz5w70Z2gJ6qyw+iHbWs8Le4qqpabKe1vQvknb0OXFTt4L7JQ1SsL0Zq
         urzgdLCTNEwCd+5bGeKO/HPRZ3MrgffvtaYBXoZHfGod6k7VX//HEC/5A0GubWJ4PuVy
         ib/EpoYtjrIruCypqQ7KmowTbJGfgfelKcvIDbv1hkWwIC7QYxqp0br0l9sDo2pnGyEc
         2Hvg==
X-Gm-Message-State: AOJu0Yw2Boior9selO/ZIqQ1utNN/DYms5QnpPje1vgDZU6veTT2qzYA
	D3wjwlauQe11GnRH8il+JD5DXr2pDojX5ZElJPmOh1++AX7+ffcFM68xADK/LlAQp4ONey5O49o
	RYFCaBSXXPEm3aSHnHAj4yT16dL8ut04=
X-Gm-Gg: AfdE7cl02PlU9ulya3NlYQWQheTdr39jH3twGkatw69evts+u0YgA5QDKlKn/VoQOD6
	KXQgkHU9TpvHxKqeRSFV5uBN4bTbqDUWn5a7HdxOD11mWNwJilH20XxKJr+g4ZfNx6EEuz+tGPg
	6kxW5XJKG6cpuTEnZMnGLOz3q57IFH5dqydzv60eZh+w7/DeFbO7DfXk0eZdyX/kG7yEQsdMXX9
	vZA7xjbPnSjF0oIAle1hODqoitY0YlciM2blyn3UaL4I7AJF3ZRvRZjBFt7Iz4lOomKhZRGjCwf
	BcDOOTJYP86Rbl2gMTRL4tVDi4cyEODvzpa2W3qpi/Ba+9CcPQQMmomnx1r9Po4lKexTR3o4X1v
	+Eh97e249WW86uLp1/zj+dBfgPvUGy+J3C0muiH/DJy7zle6wd8k85zlP5cuIZzvZanuyoA==
X-Received: by 2002:a05:690c:4c12:b0:80c:85c6:8982 with SMTP id
 00721157ae682-80c85c68ecbmr55172267b3.65.1782582790708; Sat, 27 Jun 2026
 10:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-9-09f7ffe21a53@gmail.com> <CAOLa=ZShTcHOekT+NuxMwZz-7P5i9aSWXSL6MW9_9aKkNwqsig@mail.gmail.com>
In-Reply-To: <CAOLa=ZShTcHOekT+NuxMwZz-7P5i9aSWXSL6MW9_9aKkNwqsig@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 19:52:59 +0200
X-Gm-Features: AVVi8CfNZP_gr_L7IA6oWavIFH7GnAZPhHvjN5wuGbPGUiIzIvWxNmv3u92sEKQ
Message-ID: <CAN5EUNTrdNArd5SX9df6x9bOhRfzE4c7dLOuNu7ONUdn4TLsUA@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 09/13] serve: advertise object-info feature
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 27 jun 2026 a las 0:23, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > From: Calvin Wan <calvinwan@google.com>
> >
> > In order for a client to know what object-info components a server can
> > provide, advertise supported object-info features. This will allow a
> > client to decide whether to query the server for object-info or fetch
> > as a fallback.
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  serve.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/serve.c b/serve.c
> > index 49a6e39b1d..2b07d922b3 100644
> > --- a/serve.c
> > +++ b/serve.c
> > @@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r U=
NUSED,
> >       trace2_data_string("transfer", NULL, "client-sid", client_sid);
> >  }
> >
> > -static int object_info_advertise(struct repository *r, struct strbuf *=
value UNUSED)
> > +static int object_info_advertise(struct repository *r, struct strbuf *=
value)
> >  {
> >       if (advertise_object_info =3D=3D -1 &&
> >           repo_config_get_bool(r, "transfer.advertiseobjectinfo",
> > @@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r=
, struct strbuf *value UNUS
> >               /* disabled by default */
> >               advertise_object_info =3D 0;
> >       }
> > +     /* Currently only size is supported */
> > +     if (value && advertise_object_info)
> > +             strbuf_addstr(value, "size");
>
> So is the plan that further options will be added here to value? If so,
> whats the format we will follow?

Hi!
The current documented format is at `gitprotocol-v2.adoc`, however I
think it could be improved. I have a more complete version in the
not-yet-sent %(objecttype) support series, but since the question
comes up here, I will update the format documentation in this series
for size only:

oid <oid>
  Indicates to the server an object which the client wants to obtain
- information for.
+ information for. They must be full object IDs.

- info =3D PKT-LINE(attrs) LF)
+ info =3D PKT-LINE(attrs LF)
       *PKT-LINE(obj-info LF)

  attrs =3D attr | attrs SP attrs

+ obj-size =3D 1*DIGIT
+
  attr =3D "size"

- obj-info =3D obj-id SP obj-size
+ obj-info =3D obj-id SP [obj-size]
+
+If the server does not recognize the object id, the response will be
+`obj-id SP` regardless of the number of attributes requested.

About the names `size` and future ones `type` they are arbitrarily
chosen, so for example: `delta:base` could be `delta`. They are
appended to the buffer so in case of adding `type`, it would look
like:

strbuf_addstr(value, "size type");

What do you think?

Thanks for the review,
Pablo.

>
> >       return advertise_object_info;
> >  }
> >
> >
> > --
> > 2.54.0
