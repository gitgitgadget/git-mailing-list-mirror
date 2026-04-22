Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2D1A3164
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870639; cv=pass; b=OzNNGYy8N7QELQLs0ujMfq53EnTe64Vg+QUi2H9pV/YBxsYq0lkDjRLPK507GOw3rZLz1rxKIMPFKBgaO2ySQJtH/f2Tq3kdPai7T0CNH1oU3g8O5q7yDiBON/ebrIgNqVKPTTLv104jGLzwUrOptHb7WEtduIywyMmDM/sKuBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870639; c=relaxed/simple;
	bh=ZzBuZwKCMNfJzqEOBkDOzLfvHv/DSc0y+aEMBYN1cnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De5zh7TnNiM6YYOb5UzksPGowx/y881Mj5F5zu1bT4g0RL36lbzXGKF8z4ZfJK0LzSiXnMH7FzkvLi8CwQU7GMP583XOPUYqdiTqxyjxKoGv1Z22GnqZE7RwKdEdRoP3sFiDrekMJakpvXkZfPz8ZOTWIPlg5LjBWMjLiFnnL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaM/Xm9O; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaM/Xm9O"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76c60c7502so2442312a12.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870637; cv=none;
        d=google.com; s=arc-20240605;
        b=BcIj+30b+gQioYSQl94epesu/y5VFBhE0w4Kuk90hF2lJu1FlFH/69HtgP9bwREvsE
         GPztpL6/7fVrhnAuonrwZJxEMB8KscnhhZD2fLibm/fphLjaTvx/soqQDF/FQYHicUtf
         NQ/syTHE2E/OL3V8eyWhgHNwPbCAs2DFrf6NgLaUj2cZZ1Vk/iKatYn4yjiZgZjxZ9xQ
         kLoaikSsw+niE/e4Roo061WRdrMvZWMyQe8m8p8JxAc9OoJgZvSkWt4EOq+kdZIYbRoK
         N3WFNum0gqOi6eWyV3ytfT6Ktp6bMU686N9MdTmyPzvFIHcLSDyCa23FFjUaCEQ3sMtT
         8tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7KBFSlpU3Lyzz0IG/yzidWxS3LrTvj3T5eqEkxV0KIc=;
        fh=DhOplH8Wm0HJxlPTZpb3tKfCO/1+B0ZPOux/REQhY2Y=;
        b=FY91IkOVP3+cZh8EjezZi/BmkMb1ah7yRX0tQBoxA94grr948z7fz9rwOedi6qw2Sw
         s0SJ0I0Ph3T+hLKImaR0U2jO0UJzAIUOrHf73c++YaBNvnkLFudZVukq01EAGI1tWLst
         r25F6cMKp1YM68V7RDqo3XsHX1jmyXldpuTooBu1gme07nR6A6ADrXOz/DjwIZ3u+EjF
         2UwteX6QA3cvbNMfZ1ks6EIKQmwlI9SSend2ONmFHlKycwcswVonVp+51/VV6oCCgpAT
         OysRPX6HXqWXUmEyanj7Fdebx4fG0ftWrW/LzvVv6WQXHfCkSRrjHCkFv4LJU1m6zep1
         kiTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870637; x=1777475437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KBFSlpU3Lyzz0IG/yzidWxS3LrTvj3T5eqEkxV0KIc=;
        b=EaM/Xm9ObcoqamA8+iZ9ob2OtbcM8ZhvZUzhig/yo39L3If6ToG7EtbE1c1SdMMUCe
         ynRaT+gTWRfDZ/6KPw6ehOqTUaGyGJilYCnr9h1yfKMwJ3ZheDeGb33cVTnX4WbDzwy/
         i5HU4qPS1w+9HSgWMcJQfqLXkBPT/4NAguVasoXeLnL1YP1dzfOTlklzFHu6OUJhZOdV
         O6JHQ/sevlUn6k14WZCyBw1qQXExeC2YUWnw/g90mrmCWLlw6VQYnjOexR6YFh/qIcZF
         9QdF9MtyUzbDDdZrqQnq2QwBrvWAjW7HdoIIlsKuvVkqQaDcJV1sNRHxpq00FQIdxaar
         YVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870637; x=1777475437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KBFSlpU3Lyzz0IG/yzidWxS3LrTvj3T5eqEkxV0KIc=;
        b=VoO2YAdYnw7y+JgDREUaPtPPuGSCiP5PE4EJHbu/HzgNUmF6OdG8isLfVZyq8oVmrj
         k+V1dbyYDA1ohc5Wo/4UfiDSAoRLT68T69i+vn3RRpY9e+o16zliP141XDFC560jZXTB
         T78h860qkmVwShCUhKZTC1NgyyiicxN+nu6s9jqFO7RV9bcw90f1prHOCBAOjy8rAqx7
         /knA0rxxAFAd7pCT2l6xWuvZ4BfVVfqnFX2Jfe1VBOcmCdIOSX4C44OIUbTpHNf5juF7
         OeLd2S2H6CY5Q8oe0gDabewh73IjLNLqEIpmkWLmhF7gB8Gr+ZcDCP04wN4sW4OeMjVu
         kUkQ==
X-Gm-Message-State: AOJu0Yy0AQIpFJ2gFnsHLdV17XOd9xsE5M0fyQN0OpjIW/8mCig0SC6U
	AIPQgJFTL4ss+B/1MbsY0y3gV/v2ykckgCoxD7VPsDgonOEWKJRatY9cpXZUAUERzdT6Fwh6Jda
	MH0HY1TpcLaEYs44OxgH1wkzpsejrKhA=
X-Gm-Gg: AeBDieud8N0sTKVEsgMhOf/qsAZsn5Z3J9fCFr4zWUhW8jOVA8oFyqFyK38UlMJ4H1Y
	n7WOmJXqaamGVEd6VUXi+Rf5nUcwdUjRvEAS58j0mwHXhCuisYDXSISKhfY0Nwat90pko+HqVri
	GgAT0AQPnv19cejarXvBguFfzKshEFOEBUXpL5F2I8aDnRlJaOv6f722ELpWfpDGv2zCfV4aiTT
	TeJzI7aw56ZjT2NZojjMEpQCF+BD7dMFyhQBKcPWgH3qyNiQqJ0WEnWBdwS+DG4L8XaUR7Z+feh
	anr0YkuCxfZRZTZrobtHO0EW2Oi2Rt0MXmgxOLrpRzdrDh5J/IfzLaC/ybD4vi4D/LLiZkMVxZM
	ULR7+
X-Received: by 2002:a17:90b:1e10:b0:35f:c156:a82e with SMTP id
 98e67ed59e1d1-36140290696mr19180038a91.9.1776870636828; Wed, 22 Apr 2026
 08:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net> <20260420221425.2763661-1-sandals@crustytoothpaste.net>
In-Reply-To: <20260420221425.2763661-1-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 22 Apr 2026 08:10:25 -0700
X-Gm-Features: AQROBzDjOrk8N5Z3yiZFzWHfxw3u2RFoVrO27YkoOYE4_x6CWhrfTfrnG29bFnE
Message-ID: <CABPp-BEy0dENdPG3XyLvqkKgWsP2kN=EF+-e8OHXOGkPrGXQog@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit: name UTF-8 function appropriately
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kushal Das <kushal@sunet.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 3:14=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We have a function named verify_utf8, but it does more than verify, it
> modifies the buffer if it is not UTF-8.  This is different from what
> most people would expect, so call the function ensure_utf8, since it
> mutates the buffer in some cases.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  commit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 80d8d07875..790dd2faed 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1637,12 +1637,12 @@ static int find_invalid_utf8(const char *buf, int=
 len)
>  }
>
>  /*
> - * This verifies that the buffer is in proper utf8 format.
> + * This ensures that the buffer is in proper utf8 format.
>   *
>   * If it isn't, it assumes any non-utf8 characters are Latin1,
>   * and does the conversion.
>   */
> -static int verify_utf8(struct strbuf *buf)
> +static int ensure_utf8(struct strbuf *buf)
>  {
>         int ok =3D 1;
>         long pos =3D 0;
> @@ -1819,7 +1819,7 @@ int commit_tree_extended(const char *msg, size_t ms=
g_len,
>         }
>
>         /* And check the encoding. */
> -       if (encoding_is_utf8 && (!verify_utf8(&buffer) || !verify_utf8(&c=
ompat_buffer)))
> +       if (encoding_is_utf8 && (!ensure_utf8(&buffer) || !ensure_utf8(&c=
ompat_buffer)))
>                 fprintf(stderr, _(commit_utf8_warn));
>
>         if (r->compat_hash_algo) {

Makes sense.
