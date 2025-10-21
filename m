Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020223AB98
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030081; cv=none; b=YFYtEljjCLPwtEt1JgIKb/HUodB+nv5z6XkwDD8Zy0GoG0qI72nPaeX+PjhrwMG95ujJXEazfJ4q81wC+GIVSUSfOa80XVMjhH3z0Tra8vevz7qeq8GSoiBFcaof/TFIwgPOh/X2tezbTCPRE99tyA5Alrfjn+mNsli7j+JuXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030081; c=relaxed/simple;
	bh=E/cQC/g6O9BpErm+Vef1UAqwfGgyGN+sdRo+raKV6hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCnyIeIP7DHfyaq1FqR0whs0/+nfi/B2xFI0+VKQWfyKAJX2ou5azgmwOsniZWfKFl6vF86LamQbNU0QjCX/X3N7eeE0NO6qDmXtocxkAOEOT0D6Od3uWOrraWVasQb61sICVobvXrOBimT7UZXYy8Jrt/RHMSnLoJvrNGy8OYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHAgI5A1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHAgI5A1"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso5881557a12.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761030078; x=1761634878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvT6jSUlXhf/zofj9OhGU695zgV+3HjZNh5OyEuiPXw=;
        b=hHAgI5A1PJqRVl/3RawZEavYUgXN921HlvhAiSvKbciW1FAcjhd9QR7eyJmjTxN66u
         Mgc+UoKjSuYAbMQlOwIQRyWEvk4UVQ7HDM1aB6vlDPZRFp1YcZALKDEn1sL2qIlC/5Qq
         s5HPD5qnC99/Gegf8oQElPEJRPzX4VIv/+gUs8/38p3Li+uha8Vgq3at2b9y01eO91gd
         WQR4X4zR8FPYnEzXJv1Z9G8lruawbmH0ECoUx7wEyKGAdLnqloRluC5QRFPbXwbQ/bcg
         FDh1JumGxi1w5RC4M1lrIGVxg+cJQFoI1F7q7A8/IFB7eKNhmQ6b2vqY06rOoxTHrxeF
         1CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030078; x=1761634878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvT6jSUlXhf/zofj9OhGU695zgV+3HjZNh5OyEuiPXw=;
        b=e8RcM3FU13apF9nqACupJyqz7QCHI7WeDxfLchShZfQugjQghVZJO5xs9Nsuu7TIH/
         YJrHmzQeYP7HN+tLcx9rq6xrJf12CIbSS4hY3vpdTqz+AIxUGveAg5ZMG1D8UFmkWFf4
         5fy/z9lqQned9WTCc2wmVi8NBPnfEwachktqEkpbsUvvIuEPtK+Al6mq+2Krze2cFSS5
         /U4JDFs42rw5YC4rkV8BuAnQz/ZAktXfEtvO6eXhPc9lGy9cJYAivz77qLg3hIPDnrbz
         1723Sv79d3ZYkVtZ4fSXyt04CvijK7SoMsnlp9MKHi6CNgd/Rw1eB+vMZc0ee06Ad8am
         kRsg==
X-Gm-Message-State: AOJu0Yyo4yXEZsaFdJXIYmqp9tVXNqHbDPR+1ko47OBDrH/U8qlqZSHi
	AEkcRV2/klMkA6dh7UO0eMpLklsmhrvfjzdaHXnEdMmT9QZczmHzRPv0YwRN5JXDOBP87f7uZB6
	CANzVr/jCpzzYjJRAwSf3C56t3X5Puyw=
X-Gm-Gg: ASbGnctHxZ+yF5z+iJ+LbY+bsm02N57U8tPZfCRPRU3PyUDn21xO2i4MIaiCLSUTWSB
	VKnytsZ5p639NSRf0nIoqTczI1XAEjubW8FftIZzWnetl5SZQnvyqaS5SdCbSOhOdpmM+OyfEKN
	Pv/++cnecvMWRp06xUp8Zt2Y0MF6eQ7DUIF/O8pNnomn3Q/ycRarcHikAMqLCdjE77Z2FVKE3LR
	6vx5cnbuqzqe2MkO/uB9EJbrrYkuceA0PslVs5kfNyef1zCoTC8L2stOQHp
X-Google-Smtp-Source: AGHT+IGm7LHt6tsYj9K6pLQWSccHdeutEPH082GOLZ71O3I5WlKes4SIiwAHYVNDBB3LdzKSK3C3AjrHkzNGqfzyBTE=
X-Received: by 2002:a05:6402:3492:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-63c1f6458b6mr15231622a12.14.1761030077504; Tue, 21 Oct 2025
 00:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <a830de15ecdb5e5f45625927cb69b2be552bda42.1760997183.git.belkid98@gmail.com>
In-Reply-To: <a830de15ecdb5e5f45625927cb69b2be552bda42.1760997183.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 21 Oct 2025 09:01:05 +0200
X-Gm-Features: AS18NWBT_QwgPhgFm1YH1AW7EE48LZAqE45cFwLQeViakV__dE_4MVYNqoOTa8c
Message-ID: <CAP8UFD1-H5jRyd6b5FhgCMLObnErXVr8p0s+kMd0qO5jWkkt2Q@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 2/2] gpg-interface: do not use misdesigned
 strbuf_split*() [Part 2]
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:57=E2=80=AFAM Olamide Caleb Bello <belkid98@gmai=
l.com> wrote:

[...]

> Reported-by: Junio Hamano <gitster@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Junio Hamano <gitster@pobox.com>
> Helped-by: Krisoffer Haughsbakk

I won't repeat the issues that are the same as in patch 1/2, but
please correct them.

[...]

> @@ -887,19 +887,21 @@ static char *get_default_ssh_signing_key(void)
>                            &key_stderr, 0);
>
>         if (!ret) {
> -               keys =3D strbuf_split_max(&key_stdout, '\n', 2);
> -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_=
key)) {
> +               begin =3D key_stdout.buf;
> +               new_line =3D strchr(begin, '\n');
> +               first_line =3D xmemdupz(begin, new_line - begin);

What if no \n character is found by strchr()?

Thanks.
