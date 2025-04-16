Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808A20C492
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781776; cv=none; b=cTWStC684QoBvsEwYqbfqOSloLQH8fZBWrC2PyRJUyq3flbrmBKKfevdhislVh1+afpTt1neZipRfngxeIbDGlG102d1lUN46w6OgY8gPe8JT+K+C5yrzARTaI0+pFndU7e2VY74XBKTyhkaBMqb5oDlKGHTHuvtDqQrm7T1KTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781776; c=relaxed/simple;
	bh=+cHxprn32tKA0YMavNJWN1eGM5HuaUE+JYFhXU8Z9oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAbJFEg0MxbceUn36GQKLZ76G06XGTLfL8hNrzFaEkEkOd+DovkvMjtSe2dcZtIIQ5tj7ARB139KoRx+e6m+PeNiKsugSrF3WwTsRstxp4MC0RfyXgpYZLUnhS2qLMihm+RGccSch9mPYCQ2wNESfAmf2aX3Mq37LMPbrHBcm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsDqIziA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsDqIziA"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso53815445ab.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744781774; x=1745386574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/059RvTZKRbeW5Ea55p1E2glej/nU6pgWSpaO5Em1Y=;
        b=KsDqIziAIiZ2dEV1CM+qfWxiDaguc1/U2962IX4KafQWyqS6jU3MUHmQu0RATRysJt
         eqbtSuUJJVJCYZCY2uQNUMADgHXeJ28FtLYyCaxkxPjHXqpn7vNGfXKwcehex2Mwz3fF
         nQABifXcdCgDCIEkDKmrfsgJwdX7ewE1Vr/DWgfHUUyXLCTk82hoFFJJYUUB45aa45Vs
         yD55uR1DPN1Pv4f5BlrCTUi31AuySOjZ8s4FWv5P63Dk+j73DCJqpYMngwXHoWrG2vhc
         xV9L5QhrPjz6z/4EJ4WYbXZ8oHqwi8hQagtCDK/+VWzoxAxFwp16svAsqCOSNL5GpR2T
         Y1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744781774; x=1745386574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/059RvTZKRbeW5Ea55p1E2glej/nU6pgWSpaO5Em1Y=;
        b=ONbHfp3ukd53XIdVsUzqCMgpLazC0b1KCqGY1+6LMelPxdAqvJ5y6y3knpNHy5rLtf
         WZJIRX80iDief4KtVxBCVGcgYdvP4aapScJXiE94ZQfWY4BMmccQmJMpjbErbPjfxOIa
         od65r0vDaW4JLZ7vFKYHuY9rIGNTEgjP/SVXbEjjqIhwecSFnHEIA/Te5Go0gjC3ttZL
         UlgyPWCKMuxGmAiPf4tbneC2JgO8NFWH1CgUXoOS77mlj9JCVStFxfU+uCPjZoKs61a1
         /V16wtSY4vglDiaXNBrYgVQ/nIdyqPy+QVfDirBA+a7Iq6c+ap72Dvg7+6rgjXO/lJiZ
         gTrQ==
X-Gm-Message-State: AOJu0Yx5yF0/ZsMtugkxkDEfm/t86PQE4q4nqZxMkbEyJ9fF8OH7jAWE
	2wW+ZX59ovEflxIl8FoSMMz4Arn+fImSv/npGyf0i51OSEUC/i8pskJ6Ejm/h2l4go3De+2PeA6
	H8yzrKyCYt+JJ827bUIbfG7iXKkiBNZFH
X-Gm-Gg: ASbGncsxQct1M6Jvtf0T4QQn5j6sBuhoE2VtlGojbQU7HLn2BIm/yQZEfIiBS4WYr+L
	GtzjWmrLxq9U3jqRZNF6DWaq0N3o8T7ReRooQUYacYMyjCuuzs1DBOR7ax8NrzzoeA8BS6gi0f0
	7Sngxz4+xMIyj7dCevARhdEqNia7KeWg435uMqQFAR82qWIY69ofTKbPi2uAjAYbjGFQ==
X-Google-Smtp-Source: AGHT+IHkYaLyIbc5EgpBS/a6n6Ve/cCDz8UTB8QxfnBNuyqR5ThrfU+6Z2h8mTzsQs3BHxGQiGSYBwVbHFBzfvma/8Q=
X-Received: by 2002:a05:6e02:1487:b0:3d4:2306:6d6 with SMTP id
 e9e14a558f8ab-3d815b67120mr5166705ab.21.1744781774164; Tue, 15 Apr 2025
 22:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744757204.git.me@ttaylorr.com>
 <9a18fa2e52bfe1bd98ea2d50b8e91509dcf67102.1744757204.git.me@ttaylorr.com>
In-Reply-To: <9a18fa2e52bfe1bd98ea2d50b8e91509dcf67102.1744757204.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Apr 2025 22:36:02 -0700
X-Gm-Features: ATxdqUENEDn6dVH1T0x6Y6cLEDnXmWwCWh6JArPjhLNmY0JhS8Kf8bDeV3r27pU
Message-ID: <CABPp-BF0hLbMtsiqmQTO9nWvjkk9W513d4TSzj7BQoBC9Baw7A@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] pack-objects: fix typo in 'show_object_pack_hint()'
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:47=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Noticed-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index eb2a4099cc..f06b359150 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3532,7 +3532,7 @@ static void show_object_pack_hint(struct object *ob=
ject, const char *name,
>          * would typically pick up during a reachability traversal.
>          *
>          * Make a best-effort attempt to fill in the ->hash and ->no_try_=
delta
> -        * here using a now in order to perhaps improve the delta selecti=
on
> +        * fields here in order to perhaps improve the delta selection
>          * process.

Thanks; much improved.

>          */
>         oe->hash =3D pack_name_hash_fn(name);
> --
> 2.49.0.230.ga662d77f78
>
