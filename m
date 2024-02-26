Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAC1BC27
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941561; cv=none; b=tBknCMj/8OCBHrBSmZpjCR87QI+eEVXck9bayZ1L9aV4y+WFFolLWxUOoqtusy8NvgRaMm4VcSJ8oZCQn3gutRZ1eyqLCRZYTMwl6eUd+gt4XsCBS7LEkixDxlgfPZZHgpUy+5/elSXToMzydphCiMeUbx0gfMDVdnqzFVS5gpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941561; c=relaxed/simple;
	bh=sG2PlmoQD1xJvZaFiF9KoTACp5h0bewcxwbt8NqOsKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOIHVN31RPUXNZYVqnTI8tZ6O/Mdyokm811bLNEsOJ1a3CGYNex7Q7bVYihZKDswEY0xfl2HHAOKv4BWBqMtBvTszsj8b8bN4b/C4XOrxqWwKEHSjkkSOv9cjBsmZqMBgFhi9nU8u1AfK0Y7FfFtyVuT/dQEs5HTBf7yZUUgD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apMOVPrl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apMOVPrl"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso298768266b.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708941558; x=1709546358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZoFZOZMUR6aUFKunR+Kv+CxH7joKxA1fUjC6AkvJQA=;
        b=apMOVPrlj2MKBVgDNTfXle3dc4VvIvdEjZpNeCoOAkQ6brj3ouOCKFJvm8We4XGtqV
         8Ajybi+I0WqIP8m3Samgx4UaIKVAzRwWENaJQ9bfBbwEj2wXKXrTGss1hF44StPJ2XKa
         z1IgCsIHGdmgmPGTk98xo00zsS1PD1AnAoajCovw1LtPVtERDWYMLxjWKZrkrMPUuzQt
         Lcc6JCea0ywChA3DUN9srMFCDahEX3nFiuzrZs8OqSsXpmDNDtkAY0QlyTRHt8CEYEzs
         2W77BahWTVYPVV0iHjThWhBGwU8lT6XnVXS8gdJ8PAPT7TlTpxGv9Ir5SKs4CO46gw3G
         3HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708941558; x=1709546358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZoFZOZMUR6aUFKunR+Kv+CxH7joKxA1fUjC6AkvJQA=;
        b=qAYzMn7IAV6+JTxv+3cvWgrXE5nm0LpA5n+ujv6bGZmpoSeFgu4pULLekOG2cGiw1I
         kZqe4ApQVQs8LMJKdPd28MEFoX73VbmBCGkhNEd6ioSuXclLMtQHTWdaVa9lWDrmCN+g
         vFxs+5DO0EjAMu1ETZ4hJXVHhTumCxytte7lwu2vGHtTDWiwjRlHai8MYUzS0jHgij0M
         2OLw+bMbJwkGaOLD1vYKK4csT7qbrrcsj3p7lO8UEgqmbaW1OXonH5WUXnJU7jFZqx4g
         4FHhgbMTy0mGZ3VKHiXqH1yaimHOGbthxs4R7ryaNtUMkr0H6AXdSf5qBFCG5h8TKDzY
         EM4A==
X-Gm-Message-State: AOJu0Yzb8k8gcG+M9SaMrVx+z6i8dHXmRHPrNDlCdbjGF8CG7aC9LK1V
	4oGs+RpRvUsb5aNBDUwSBS2SUCo5llvV6lGBajosDy10BiK/b7gKYv1fcj0/BH3x9fLRYSCQt3q
	zC/F80Drk6EmQduRBagiakUhuZII=
X-Google-Smtp-Source: AGHT+IHWB9EX2ysJ4S6sSpDaWzkXXmX4+YBXqkpU8vQTkuDCqbggNfxZIZuv2ng15KR/P1K5C2xlnKSwzCvdGUBhHLE=
X-Received: by 2002:a17:906:39c1:b0:a3f:1139:13bc with SMTP id
 i1-20020a17090639c100b00a3f113913bcmr3736836eje.74.1708941557564; Mon, 26 Feb
 2024 01:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224112638.72257-1-giganteeugenio2@gmail.com> <20240224112638.72257-2-giganteeugenio2@gmail.com>
In-Reply-To: <20240224112638.72257-2-giganteeugenio2@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 Feb 2024 10:59:05 +0100
Message-ID: <CAP8UFD3qR8E0gvUQtzzkLPWv4Db45kFS4pEqHKQr5siciVJ-zQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/1] add: use unsigned type for collection of bits
To: Eugenio Gigante <giganteeugenio2@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 12:28=E2=80=AFPM Eugenio Gigante
<giganteeugenio2@gmail.com> wrote:
>
> The function 'refresh' in 'builtin/add.c' declares 'flags' as signed,
> while the function 'refresh_index' defined in 'read-cache-ll.h' expects a=
n unsigned value.

It's not clear from the patch that refresh() passes 'flags' as an
argument to refresh_index(), so it might help reviewers a bit if you
could tell that.

> Since in this case 'flags' represents a bag of bits, whose MSB is not use=
d in special ways,
> this commit changes the type of 'flags' to unsigned.

We prefer to use "let's change this and that" or just "change this and
that" rather than "this commit changes this and that", see
https://git-scm.com/docs/SubmittingPatches/#imperative-mood.

It might help if you could add a bit more explanation about why it's a
good thing to use an unsigned variable instead of a signed one. For
example you could say that it documents that we are not doing anything
funny with the MSB.

> Signed-off-by: Eugenio Gigante <giganteeugenio2@gmail.com>
> ---
>  builtin/add.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The patch looks correct, thanks!
