Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030032F37
	for <git@vger.kernel.org>; Tue, 20 May 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747992; cv=none; b=Zt2YPu8XvoTK55xNfkdotFmX+P7sQ0i+L1y20NnmLOo7R+TPPV7zzcAmR5q+4/UmyROPxAMdovhUhcxAXxsM1KNnCYm/9ZpTtDfwk+F5+Htmk/Ye42QdHqO/mXWu6AVU5ZvsZuVGsbASBxD+yq8lVvK7+vuiAxwZ/tLI5eTW96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747992; c=relaxed/simple;
	bh=WLsJzOMUTt5zGzn/PX0KRV4rkCRvbev4vkA6oyoVJdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSfwBPPy/131qsCXY/Ff+w6dCssbL3a6hIIbBOB+j504+A/PHYXhwYFeOedz6izZHMVY8h33lPwe+sRMKeKrajtzY3NxYytrokL7yxKNoBrYAuyt4aUFaVY2mjYhOf6anvNZmAIkTh2W5aFe+SwNRrZatoIHQfgvvTh1OlGVHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWHsEaBL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWHsEaBL"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad54e5389cdso462196266b.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747747989; x=1748352789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdcU+xJjiKjHnjPVirL+fwhBKMlyg7Ej5beiOFhCchY=;
        b=jWHsEaBLWtPnxJG4Gi+d9hW+E1ulsVZIugbxGxldI4//68CDKh89apgvSpk+kvkNOo
         4NvZFdPOQz4dtdKa4LpK8Vra7RxDezosi7ltNaqF1NdvamykJioQLh2cMmYwIXl5R0LC
         1Hg4CsNO61e43//9YgTxyPigA2/Hcf8hpLLnIej9tADUK+ELxkxvlxIq6cLyUEqy6bmB
         oeZg/qrdrILzz92QkiqTQrckkLhHhUJ3QobSF4yDvy74R8/cujdZSPkx4IEdQcSBGmUO
         7JJkaYxXy2BHXi24IosAAAUfezDt/LXMd/ktpH6a7Ox9p+3e8rn59hqGWnQvxv31hSLj
         4Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747747989; x=1748352789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdcU+xJjiKjHnjPVirL+fwhBKMlyg7Ej5beiOFhCchY=;
        b=bWbrtNJ9TPRdnSzcLqQVxFTlf8f4qhIVWU27CinICsM83U9SMlkkUL1GkUF2mBXj7l
         oPnZ0/BoLRFruOdyBnA+rfn1JL8twGdawHGw0jZwOZzDPniG82Kg2wdRtw0qvgiQDL/X
         WGGJN1/WI7H/spfQK777u+nG1tk+Pw3js1YH27IzJrf1lazEe/JECS0uQTmB3v/4C0Hm
         t+z57eBdFtNODECsje9K1u2FMNr1e7WpTb70/upda3BVrI0TZ1atNDFJ1f6GU3shosuT
         QmbAT/nrvAaEJPpD5nDGk62gB54aBlTMKuBIoFGwU20K3Q5fGWtnI+/H2J8UXh3plvhc
         8l0w==
X-Gm-Message-State: AOJu0YzHOwEPZPVuuWLpejcL1X/oUlB129LmkgVqgi2pY11dbl01qqPu
	osw+JbN9Hu5B8Kfhhu/OcPxPR3KiXr9+I+y5JTkDUG3QbR8MGlKf1MqS6e3jHc75+QGz7WwUq18
	NPVfK6mvWdivHgUr9wLAXwMu6cCWpJD1HcV0i
X-Gm-Gg: ASbGnctVLwIDKb2rRZJbqg4r0+aoPJTNynJILawhaWBxhQ1io7wl9In65AWmSEnkUtP
	f6oza2Bw/eZl5bp121NExqtoX35g3XyiySIKygH4RO6dtUcB7lxiJKfEBuW+UJ5FM/60dxXEccY
	PEOu6Fx4ZpJuDUCgw1jL602K7LbWCnKlqqfMI=
X-Google-Smtp-Source: AGHT+IF+OoeEvRrdDr00SK/We9HCpF/EJXmQO37svvp12M3/8AkVf5oshvR2X7D3/x7zO/+MhCCNN7y8J0Vikg5471M=
X-Received: by 2002:a17:907:3d12:b0:ad2:52fd:4ca7 with SMTP id
 a640c23a62f3a-ad52d45ae68mr1400900966b.9.1747747988963; Tue, 20 May 2025
 06:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com> <20250519141259.3061550-2-christian.couder@gmail.com>
 <CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
In-Reply-To: <CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 May 2025 15:32:56 +0200
X-Gm-Features: AX0GCFsS7sCa41b32M5dvaZzqErEIB3UYkSttpik2MVO0jBfLi-4rpgpuqcUECQ
Message-ID: <CAP8UFD2XtyPD7b=sE+t9d-kyXDt4hYMqVotwz7hJZEO+5TfXGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:37=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> [snip]
>
> >
> >  /*
> > - * Find first index of 'nicks' where there is 'nick'. 'nick' is
> > - * compared case sensitively to the strings in 'nicks'. If not found
> > - * 'nicks->nr' is returned.
> > + * Find first element of 'p' where the 'name' member is 'nick'. 'nick'
> > + * is compared case sensitively to the strings in 'p'. If not found
> > + * NULL is returned.
> >   */
> > -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
> > +static struct promisor_info *remote_nick_find(struct promisor_info *p,=
 const char *nick)
>
> Nit: while we're here wouldn't be nicer to rename this to
> `promiser_info_list_find_name` or similar?

Junio suggested this name in a discussion of a previous patch series:

https://lore.kernel.org/git/xmqqa5bbq0nb.fsf@gitster.g/

I am not sure that changing its first argument from a `struct strvec
*` to a `struct promisor_info *` makes it worth renaming. If that's
the case, then I would be fine with renaming it like you suggest
though.
