Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C932172773
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375173; cv=none; b=NpH5zJhAAUzqe4HEW7HTSimbeEoQWRCLvu9Iy4zeI0bCgr/hbLcS5h5d9/8cMWKUs8JqcRS3zBXugYT/kppXQ1uojlrpL+NCXkz5xRTUYNYRe4Kyf8VaNGZmnnZnw0JWRS1qv3ScxWdxHCCKHcXSX7ukRlqGAkmaCfeudFf+ZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375173; c=relaxed/simple;
	bh=jdyhq7c7UFoAGQsN0vxz3a0pPo5HJsZHJeM64NYm39Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ATtG1DNvFmfRGG1JQlGAfJnPmllhmfXevXFrU7BPTAqhQVSWg+/QEfaRm+574lsZKrlB5E+Yivh/Co50/5xbjKkpcGDoR3EKH/mMjMWYOxVcngvOu8dL7BUy55AjoUjpEdIrKVq6SuvjP/9L7dCWrC7IpjmlnfQxHDPwYUJcu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHp46quB; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHp46quB"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22ed075a629so9487fac.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713375171; x=1713979971; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOsBVg/+6uehlCYX1Nsk0Z2LfENiMgU0ulEOGiIPtaA=;
        b=SHp46quBBAJpkuSi4brTgnB80Zvs9+F+8Fe1UGytd+4DCQbTohIqxTlkN2elbn9lfQ
         Fczc/fgeiTLPZQQyZVIDnMNhX9PaqbLxNUH4lhiEDFhWrRWPELA0CzVslxKEpQIXaimc
         1zkBEeX0I0xcsf8ftNE8vcXtjcqJFDNFFdUbaPG1avIvg66Dy9loFTvwNuZcdWyPALvA
         eNZv17JmCOG1ivlrA36ueyOjtbfC+QfyCKdQFvr9gjcjNsm9kcJaYmPqWTLBVXUm4uWn
         +kiis6kVxP1MXAW5b2vxvhQFJtFZaYRhhu1LfnzMJLkl1rDNVom5qyNSUV7oNvBEMwTg
         CA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375171; x=1713979971;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOsBVg/+6uehlCYX1Nsk0Z2LfENiMgU0ulEOGiIPtaA=;
        b=aYcQyxvIYJjCQA4RoAoJ89BpOijHP5Z7kddRbJlWxhjn3OCihSX6U4kcxNAPn8QiIh
         e+9igyXHECX1w4V7Xqf2Zo6hAwbU8TyXByAYzA31jK0XPQJDrEkn3jnpFBJlHwai5hm6
         NyLsda3mcjy/qrNBOvmmNWXxsAmd6JW4DMDMw8weBquDIBJUkQWK9drneJ20v1yDKdPG
         GFnYGhHyVYs0lJVYjxtDYO8fXzY3Au/mXUziD4D5on1oUhaG4vDwRBJ7prqZiUBV1Goi
         FgqhswIPWHBiAVkHKbb6U35xdz3ItEVkiud9gL7xo/q501MzbBhRA6CR4QsPKn5+7CM7
         SglA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Gt6793gSWnyEjxA2lLIApyVJISJ8BYRWwEHR3hgId8hhjpvB3IyGjn0IAa27iH46lBSK81fYLzFmZDcSM+M+0B27
X-Gm-Message-State: AOJu0YwiUZ9LzesFmeZdrmyrGbVF1g0yqf7+Hvvt+nc0JouBrQnkRYlT
	ti2MJuU2DZSbiGlm6Ko0sJkbeCSNeXnlDJBDDbv7SjjyC3ooNEMOuJTBAXJnb8rTQEvxeUVdCyd
	EE51bJ51hWLt2gSRow7KbceL7IGo=
X-Google-Smtp-Source: AGHT+IFmaSkIr6NP/8ey0UB4Xvk6DOAixLjfEVnQs5MmaOB691EAZZ+0iIBhd2QzV8NyJBGwAhzsojKxYnEEMCyTfX8=
X-Received: by 2002:a05:6870:34f:b0:233:1901:7523 with SMTP id
 n15-20020a056870034f00b0023319017523mr235158oaf.55.1713375171616; Wed, 17 Apr
 2024 10:32:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Apr 2024 17:32:50 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <9d5f2eff8ab2a9d7a994a2031a31d4fa6f4791d2.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im> <9d5f2eff8ab2a9d7a994a2031a31d4fa6f4791d2.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Apr 2024 17:32:50 +0000
Message-ID: <CAOLa=ZS2S4=bC=s=vFnSfgvB0jZoKmH2Pi00V1Asyxo_yKSHPA@mail.gmail.com>
Subject: Re: [PATCH 2/5] builtin: stop using `the_index`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000078b79006164e3e23"

--00000000000078b79006164e3e23
Content-Type: text/plain; charset="UTF-8"

[snip]

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 0c948f40fb..fe873807ed 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -3,7 +3,6 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> -#define USE_THE_INDEX_VARIABLE

Nit: The other changes have a newline after the header.

--00000000000078b79006164e3e23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 294c36d46b8fbfb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZZ0I4RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHRZQy80bU5vdFBqYUhKNnUvakNoZ3FmVUIvcUN2cQpGK1hlZGZTdG5n
V25nT2pES1ZsYWtQWWpwN3lXbmcxR3hGRTVNaVRUMVVtV3Q3NjFQZCtwTUZCOVhxK1hUaW10ClVm
K1dpWTNWdWlXZHE4ckRYYk9zc0ljMmcyc2RCeVhzL3E3bXpYM1gzUkxrRUh6M1RSbVdIcjgrTE1N
K2w1aFMKY1FqUXRhWVdmaE95N0FNOHIxMk5RUFhTcmJHVjRKQUhqRzR1eG82T3orN2hueE5NQVlS
aW9hVHEvMjBXM1ZBeApZbmJHaXQxM1NVaUc1ZXhYQVlvejNBdnZGQnZ0R2pZbDZLcjdtalhab3Z6
WUFlT3NGU0lLSk9aNTdkQVVJMytwClM4c1RlZTgwclVoUEhZYmZvb1M2ajkzQzF4NnBBbzBDMEQx
Z3ZhT2pzV0YrajNzMmhETXYzcXVaRTN6eThRTTEKL1VxcGd0NkVKaUFjV2JHNEplbTRpUVAzVzJ3
ZldFNkZmMUNJWnpwejhHSmZXajB5a2VQWEdJVjhJNThBeE9MaApLTGFuTm1EbXIzZytZS05PMWo3
bkwyV3dQQkwrb2h0cC9VakZ2SWxBT1lMaGJJZEJoL3VrQzdFWnNxQ1d3c3RaCk5rY21ucXpFTU55
dnAySVRJTm1zNFQxTFdtREtmbUIxTTRhc3RlRT0KPTZXTkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000078b79006164e3e23--
