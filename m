Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26B1FB1
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793577; cv=pass; b=fmLqnv4bCujlDaKo0mRAgJvtZzf3jwsFOSr9qjvXilXXpWu1YDkEe59QEji2y99GlFQlnT+gDx0ApXZDmaOZQ+j3YYo4QVw+Uc9weehhd8hgqlSaYsfsYc0r8MsIRWmAoxwNDCvFkBPAqaOcTU9ENoZcXwjfU0H0rGqdIOT4sZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793577; c=relaxed/simple;
	bh=D1galKNEBMvCr++hJ4I1qhRtn6tp6K5RWdxdfYt2cGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zib3J8NG/GhhSo+cv9fxrzVWVP4hNWIQXA7FXt7Dr0j/kYfB8zPNJzQ4vHEr6MtBbHvEV5w+sCrqNosyIhiPvHL/kLoYQ5Wq4ggueev/YZuOtHNqR1kFiDiL1Su+8HIgtwInb1DC6d+lrb8i4DpQ0JSHqCn97ZKo/pJDoNytgOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Woka4Oz6; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Woka4Oz6"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44cf70de986so1209071fac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787793575; cv=none;
        d=google.com; s=arc-20260327;
        b=hTuXc+FTf4sxTvUHpOtzGLU5BOYfLGa57W7UVu6QvQhoYDE5iNgJfwI6v/6SiJNEL8
         cvOmAFwOC4OQZ3NIYMm1x/N1V+9YoL0NA3LjWmG/OqsdaYbat6DcDt6Yg+lCrxrms5gJ
         Ax13JhwmSL6UgCpQXiAHto/zgnOK75ugigEqItAPwzVIjIj+SPEKeSFW8hkiv/mnTez7
         5O11djVc8xnFF7IvStopSIyOTvl1tw3V/dvQmBmxSrbZhcVJteY4l0V3XbrI+pwVw0nw
         dffJBWENTvEJFDOPj7YbdXrt7zH+SBu/d4PoZOFVlNx/jDSMW0nkbGjF2PArFq51nhqo
         a8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WinKCkN+9tmBwCiM4gGmFmHHGikU7Ol1VXOdFSOkq60=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=pkigpJllC9pKHzbwdKPLUgqxA9Ew4GUR8kDyUryPo8YqUof3RDMdghrPUZXylw09y4
         DwElSr8YHdwQaB5Efs6QuE8IjW9mKBEpWCBXU/zNcJ2ZQ0N7nbTE7Bl1OP4LEtjq8KOJ
         AV4PfinQTg1qJ59mw0bJxTA4FI/z/8UweiIDkYKKctnEFlg/eSTQurw6JnCb/Io8xuK2
         awT59aMeesN6APolekg9CpQ81t0oXLL7Dsfx0MVnEtAKkCcCJ3nEVGKKs44Gtu5dNpui
         sK2fMce5gU4jrW0NkPkKQP/OQmajKcKC4katpeyRuTZQoEuqjJC/zvZkbn0g4jEN2SJe
         wszw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787793575; x=1788398375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WinKCkN+9tmBwCiM4gGmFmHHGikU7Ol1VXOdFSOkq60=;
        b=Woka4Oz601HB5Z/quEuAZpa5kESWI5Mz2DaB6fAxYQIbeSt9KB+AqesBQiIHWWi45L
         8t1mfrvhpp4OHiqiTz0424rQAxw4TcLz+ncJLgOVcs3sKTgKDgWv0QPs1KHt9/YcZXze
         YyJU3hPap8pIAB72jjrxR8108k9DAYWQvPcf1oGXgyxy6upvF13G7Ioqw5F6KLLAEgnN
         71cpEBgsgBLYMvQLIHFl4RqiDu59NnsIncBgYcLgWeqFA44vx4dn4FEeOoZLe4fZurNS
         XdKkrJrmCS7XbVzTGtPABJTQAP6tDF87E50fb2fFEX47hIljh05pYKbafPiPnMEfe8U5
         U7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793575; x=1788398375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WinKCkN+9tmBwCiM4gGmFmHHGikU7Ol1VXOdFSOkq60=;
        b=RCKfe6JRb+zTUDFu9oJ4NiychoX2RRrAd2M2LvKFuYkepS+UYWdQiRI54KjUwP8/1S
         K7OQ5Osv6ZlkFpd5DPBRDbW0nqm4SeT7u1K9EF0DaAgYiUQGLEcimlHoHLKXco1K8vRV
         bzpMTJKz+rNbwrSfrlOYeV6I3gPJNWFfbkUFCIjag1Dut9XKLl3ZSbWwELLK+Zc4hRLu
         dsge4E9wgN/nh8Bo5OJtqe+Oas7ikGSTtZHJo2cwqRio/LkW6pC8K8VqIev3ph/57SXS
         Jc/UDR08TI7Up4wM4Z16czujZIGzc07hobhaecmfqtEOXXR4e75lghZqS1XBlUb6vybp
         k0lw==
X-Gm-Message-State: AFuF++m722+wko6etDtSQrga+AWTAgMRfyRJ84D5mfb2NSZKm/nCbBn1
	BdUuVg0Lka/ekVxgZk6DKYGr+pHLsZkbMu0JRbMMM1Vp0TUYD3YM2y/OtHpesxC3Cn0FMNYE6VI
	sfV5zI8aAq78KefaMmYmhhHs69TIUbbKTfA==
X-Gm-Gg: AR+sD12gZMFnxrU42EmNJz+e1aTDtcEe8iCqL69OFHgAxej41c3OWP5+7zoZ1K262YS
	9DKKvXE9bHskYTGaPzsCEqlTvGQZJucRGJzCou2oS3ysHsZthiPctlP+5sKQyOVRqpEG8A/P5Yy
	UpPXdQq0J4z30qCtulr1LUwTRJ9GTxDx34S/LcjXbxI+rPZMqSIchah2txp6pTZDQmY1aY9RmE4
	fYOAioYLwNUEkxURamsvA7fIrHky5zKRXDr1DD9jdq6HjRqNCMpk9jWeN9AMLOl1+c4DsaH3io3
	lT6KQjvPOvYNaiLltGbP/IMKg9B1MY4yP10/W0Nd+5k9dHugSDm5Uo84OfBnAkkqYso2dAV4QxP
	6nmeBbITK2E+Zg+vZkjjzESjMFJ526DptOdPihebs24c2X09X4kdviQqRfzMWFQ==
X-Received: by 2002:a05:6820:a28b:20b0:6b1:4e37:41c0 with SMTP id
 006d021491bc7-6b1a048c805mr8680447eaf.19.1787793574682; Wed, 26 Aug 2026
 18:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826233152.1703497-1-gitster@pobox.com> <20260826233152.1703497-3-gitster@pobox.com>
In-Reply-To: <20260826233152.1703497-3-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Aug 2026 18:19:22 -0700
X-Gm-Features: AcwNN1X-x4Mfx_SM9MrYZ76_K_d2B-IzubQVt1m3tWZT_iQTE_rF_-z8Osx6Ijc
Message-ID: <CABPp-BG2PJ7AyC2ctPuX0bmkFd_cGmNz+XtbjdjCbMrH4_d99A@mail.gmail.com>
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
[...]
> +void die_for_incompatible_opts(const char *opt1_name, int opt1, ...)
>  {
> -       int count =3D 0;
> +       unsigned count =3D 0;
>         const char *options[4];
> +       va_list ap;
> +
> +       va_start(ap, opt1);
>
>         if (opt1)
>                 options[count++] =3D opt1_name;
> -       if (opt2)
> -               options[count++] =3D opt2_name;
> -       if (opt3)
> -               options[count++] =3D opt3_name;
> -       if (opt4)
> -               options[count++] =3D opt4_name;
> +       while (count < ARRAY_SIZE(options)) {
> +               const char *name =3D va_arg(ap, const char *);
> +               if (!name)
> +                       break;
> +               if (va_arg(ap, int))
> +                       options[count++] =3D name;
> +       }
> +
>         switch (count) {
>         case 4:
>                 die(_("options '%s', '%s', '%s', and '%s' cannot be used =
together"),
> -                   opt1_name, opt2_name, opt3_name, opt4_name);
> +                   options[0], options[1], options[2], options[3]);
>                 break;
>         case 3:
>                 die(_("options '%s', '%s', and '%s' cannot be used togeth=
er"),
> diff --git a/parse-options.h b/parse-options.h

va_start() without a va_end()?
