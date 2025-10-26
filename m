Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A24302160
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761523021; cv=none; b=L+uvWWjtDw6i6RWqFRsxoAvk1y7OMTl9RvtQ/aOE5ZUzbnjrKnxz4F0RPV34pPA/pMWL0KjI+MDf2MSX+gWljgI+ueGy2w1bDSL+4+iVOMMOWMQFjDsntN7LbNAQborsEDyFXpTrgQEf1FlHIElxOz0cEY3Uk7+DL5qe2hOq8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761523021; c=relaxed/simple;
	bh=CRCbAS2kPZ9kw32gyai6e4Ds65JPNDoD7GlqHZtjkmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzNEXpmZJ9vIFdJ3FMF9EOburlHDHfczyYJzHunFuBwvFDrXj3OLjHbOTTVTK+IiMJjtaFWJ5hXAcvBzMUgKoXpAVTlznH9p+hGLlG8vOg0ymkOyVGXkNyklo7ZtOFUh6kEoKiDqP5EJy6YvB1VUCZomLlkTX0UqbmuMGsFVdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e8935059cdso2202291cf.2
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 16:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761523019; x=1762127819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrBDajk7o2ygA4aOZmyh++OdvYMEBfmzIN3y8LQrAOQ=;
        b=mlt6vd5eB7Dzx/ibK16/9wDhzoIhlHiAowXUUGLkxk4YQn+gryFgK/46DRTYlTcdgY
         zstIumz3moUi9bgoQxO+//fHGRfRr5AoNE7LgHNLpJNQK+JNaq24jLpos61RAUAMfw0O
         WKVIi4YGzysPOyP8sUIwCr+m4tB+ix7YfRCDwk/Q4Qb4J2MGXKjnwNLjoIbYSvWd+mLr
         36u8EtrzlTd5t+INWkcnEK5Maw1fgiwaK7Pm10bpNg3aZO6UqAuKDKyjWExFBJ5LBw42
         Mf2iCbEanqfUWl5kb/VTFZZzaLwrN6bE730eacVaoRd+7xuE1QGGz9XQ87MwPRjKEeKf
         EuJw==
X-Gm-Message-State: AOJu0YzFaUq6A99WaZAEF54uUa4aiYPIxB+HXp7yOQswCKg+//sXUd1a
	H83xnng85m41UymiZfJZr3EcB/Py8k3YJ/c98Y+HrIWPrvWkVp3s95njf/xJwpoCvHQR8wHgSay
	UL/E14qQfse7rPLotks5b2h/BJEzTAWQTtdsy
X-Gm-Gg: ASbGncsijITT/mS2aO0zKQCgOPsnZaVV8vY1k0T50/7h5R+EyRujic7tiEpio5b2EW+
	pC8Lnn2ligucSOlVyXqHxf+P5xDFqfEkT0qCUq4BzAWI1T3XpiVs17rmnGnQ4oYCeecz5nNscby
	E/Fl8EMPiRxiFgPAbjjW1fpv8FQPNRz2tSudUKVYhru2k5nAI7YdJ8aAhgOAyUmkqhohX4GRVbz
	mGNX80N95fBmSq6nfr8uSYkvHOQjqtgC7U+vtfdO2s7EJtjfH+alLRAouykX7X/s+puScRJx4oe
	kaTd+729MUnZeiMpWg==
X-Google-Smtp-Source: AGHT+IGFAkPKZ13CsCAn0LkVGJW4whSwBlVBZoLcisqQLv+rh4npA/KaWSVcSK1j/4fDagYBH+suJvf5YcmIQg0xo7g=
X-Received: by 2002:a05:622a:8c03:b0:4e8:a54d:cce8 with SMTP id
 d75a77b69052e-4e8a54dcd9fmr257359181cf.4.1761523018733; Sun, 26 Oct 2025
 16:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com> <20251026225409.46647-2-lucasseikioshiro@gmail.com>
 <CAPig+cQO4_T8K-8wFBDQN-n+rasBF7LR+vJ6ez8swfmDz1ossg@mail.gmail.com>
In-Reply-To: <CAPig+cQO4_T8K-8wFBDQN-n+rasBF7LR+vJ6ez8swfmDz1ossg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 26 Oct 2025 19:56:47 -0400
X-Gm-Features: AWmQ_bkx_tSwDAeINJg4gRWWEz8gbqCYey6ZhpoDj5jWvwPICDQn07vqONLfkoc
Message-ID: <CAPig+cRHKySZ+JPs3G0HowdCEJmE9fP=tCFB=DV-KMPknKTZkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] repo: factor out field printing to dedicated function
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 7:53=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Sun, Oct 26, 2025 at 6:54=E2=80=AFPM Lucas Seiki Oshiro
> <lucasseikioshiro@gmail.com> wrote:
> > +       switch (format) {
> > +       case FORMAT_KEYVALUE:
> > +               quote_c_style(valbuf->buf, quotbuf, NULL, 0);
> > +               printf("%s=3D%s\n", key, quotbuf->buf);
> > +               break;
> > +       case FORMAT_NUL_TERMINATED:
> > +               printf("%s\n%s%c", key, valbuf->buf, '\0');
> > +               break;
> > +       default:
> > +               BUG("not a valid output format: %d", format);
> > +       }
> > +}
>
> Moreover, I'd also say that since this is not on a critical path, you
> should avoid the premature optimization of passing in `strfbuf
> *quotebuf` and instead make `quotebuf` local to this function.
>
>     static void print_field(enum output_format format,
>         const char *key, const char *value)
>     {
>         struct strbuf quotbuf =3D STRBUF_INIT;
>         ...stuff...
>         strbuf_release(&quotbuf);
>     }

Or, even better, scope the strbuf just to the `case` branch which needs it:

    case FORMAT_KEYVALUE: {
        struct strbuf buf =3D STRBUF_INIT;
        quote_c_style(value, buf, NULL, 0);
        printf("%s=3D%s\n", key, buf->buf);
        strbuf_release(&buf);
        break;
     }
