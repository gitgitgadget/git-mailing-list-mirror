Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685224D8C8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990443; cv=none; b=uUZWu4dSNOm8CzoJd24h6cdxavwv9JpK8sicOPwqbTnPbuMZd1cIhrzDxfliF/f+M/5QIA94wZcs7UTrrZZRQ+CphuaEuUaJ5SewtYkQ0Q/Te2BTUgyNMkmT7+1ctFOmPYN2Bhln1xmFm0jKMY8j74R6NfnPrJezE22/0Zuokqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990443; c=relaxed/simple;
	bh=B3necKBYZ8lKK6R+1FpStO9hYSiCsbnQE40Z/AFWo40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvm/cu5kNjzI/t4tqbe7qrjp7k/eSo3I7FazMayty3kW9KERoTOABjMIWjjMmLasiOujVGl+kGpdHCbAh9IeUswb1uIr5fMd/rTPabCzLRu3VUehr+06784XALrhXeW1PbC5qTRABcue9NAZ9Ih3qzFSKsKy7oHkKrV6drhtk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIZ2tccp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIZ2tccp"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso8262169a12.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990439; x=1738595239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnChESHSvroGRQidAeu2u+qHtIKo6967Nh3Bvor25w0=;
        b=QIZ2tccpRyVk6IwefRUSs3Avjb5SVARzgogivxG/9QZmcheb/0juw3937JM/n0AO2n
         c0vouwd+u3tWj/87sUZt9ZeLMVxm1JD3TDREe0G7KuMtzbb0usl9r1lS9HQUStrbvVTT
         ckSx7Sajy6S6b7+2DNW8M83fi2irVbci1lXOX9YOUrG1eLuEzSSjqjMEv1CqRYpKE+wt
         z5BMjwkdqZx4waidPOwh8uLnpsYOt2pEdjk85O/3+ioExYxuS4ut3hgubIXIz3SwlTJR
         B0F/Z06YIORgiN+vwXF1e30GdBpK5keayfGeNFmp3uW2XopLm+Wl5NghflxsNpuzd3Ae
         b8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990439; x=1738595239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnChESHSvroGRQidAeu2u+qHtIKo6967Nh3Bvor25w0=;
        b=ALlxTuzeOWWH7+EwKenexASjLPRcNFmuelMO3YvZ7E/IDcrNka21VEqTBHhZhFytN3
         SbKsD6zFoKWPRzUSCN9r1fy115g5xG4FOFoAtGwyNVNTvIq11F0gqlCbbZYwJ87V5SZH
         ciJIiX6ZnS0ugBM0oXplvge4vJgA/IZWQaVwThQeD5NhoxkO0gnOZzbzudQPLrMC6It5
         DymYgwKzKw6TYpwB8gCDVsMfMYMotSrNpKKL6ApoAAy2AM/WiuqWQQ9lx6GIzZzQdUf3
         p3+HhPBw69/BhEckICz1OGhypKG3BGaYuxcRMqyNabh0Kg3Xx/4w/zWm3/GY+M07t1yp
         iR2A==
X-Gm-Message-State: AOJu0YwWPbclXCKoWm5aqTUIbW2o0O0j+Kjnp6THVuxvcurcK38yrGTa
	+tkerm32jkcp5hw9QNG5fg/7BPdcITcTzHPkG0ZAWleSS4QnHHbDXMnethwNqlxp9L1A8HDmREd
	bpK1kJpVP28UTik3nEAAmC0aAEfg=
X-Gm-Gg: ASbGncvA43PznX8909jySkGS36s+yLWkLBKu1hrIhLFAv/tKJiABr8YLGq+RYYvWABx
	gKw9l7VvXs33+Zt6jAPIHdKlfRUZG2vYEbLMuOLnmhvoh/SWJLu4lUU8VCWrT06eL
X-Google-Smtp-Source: AGHT+IFgPGQNFQIaS1D2aQaANHI/AX4JX7ZK1OojEpb+U9s0jLlox/aA0IOZu2MOil259Z7eFwXd7Y55zf7jkNXZ+rQ=
X-Received: by 2002:a05:6402:5110:b0:5d8:211a:4d59 with SMTP id
 4fb4d7f45d1cf-5db7d318ee8mr39028066a12.19.1737990439366; Mon, 27 Jan 2025
 07:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-2-christian.couder@gmail.com>
 <xmqqfrn0ui7f.fsf@gitster.g>
In-Reply-To: <xmqqfrn0ui7f.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 16:07:07 +0100
X-Gm-Features: AWEUYZmStKS8GNf9BiIyvxB5c6hum2jSvBwHm35g_oQV34JMpTTI3IvvOxr1qvk
Message-ID: <CAP8UFD2b71dGmqBh5Px4F9E6Jetdo5FdzE9GKP2CsLVWXexHUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] version: refactor strbuf_sanitize()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024 at 7:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +/*
> > + * Trim and replace each character with ascii code below 32 or above
> > + * 127 (included) using a dot '.' character. Useful for sending
> > + * capabilities.
> > + */
> > +void strbuf_sanitize(struct strbuf *sb);
>
> I am not getting "Useful for sending capabilities" here, and feel
> that it is somewhat an unsubstantiated claim.  If some information
> is going to be transferred (which the phrase "sending capabilities"
> hints), I'd expect that we try as hard as possible not to lose
> information, but redact-non-ASCII is the total opposite of "not
> losing information".

Ok, "Useful for sending capabilities" will be removed.

> By the way, as we are trimming, I am very very much tempted to
> squish a run of non-ASCII bytes into one dot, perhaps like
>
>         void redact_non_printables(struct strbuf *sb)
>         {
>                 size_t dst =3D 0;
>                 int skipped =3D 0;
>
>                 strbuf_trim(sb);
>                 for (size_t src =3D 0; src < sb->len; src++) {
>                         int ch =3D sb->buf[src];
>                         if (ch <=3D 32 && 127 <=3D ch) {
>                                 if (skipped)
>                                         continue;
>                                 ch =3D '.';
>                         }
>                         sb->buf[dst++] =3D ch;
>                         skipped =3D (ch =3D=3D '.');
>                 }
>         }
>
> or even without strbuf_trim(), which would turn any leading or
> trailing run of whitespaces into '.'.
>
> But that is an improvement that can be easily done on top after the
> dust settles and better left as #leftoverbits material.

Usman's patch series about introducing a "os-version" capability needs
such a feature too, and Usman already reworked this code according to
your comments here. It looks like you found it good too. So I will
just reuse his patches related to this in the version 4 of this patch
series.
