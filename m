Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793184801;
	b=AbwQNdA9VzeCvcphvuv2VGF357e1kISc8dIG0KHVh4c8Cz55IjIdo5roNt78l3Quhrk/
	 /JHrE8hDxaiwxb822iNpgFmxCgYL/ILEqo61/hgJTZuf5AYdhcSqaF88LHN2GaRfbPOVe
	 MR7JHNdEJphpk+6UKpFgIMs+yMGHhW8UnrbuAbemjwYj/Z0nO68IiRTxqvjiPxcelOhnj
	 VeZQv1q0f0EbRGUnwbCEclDLtfup7o9UF1uqE7J5BX+dIGjzY2FxS2QBqv14DUai2VzeT
	 PX3Oss4Aipd5zOP5DfUePgF6KGsxROvhRmuZDsYmk/4zt54FuX3QRSsSXTcel34TYiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tS/VO5/AsluA2q55cvFf2XY2mLXBMxWWBXCifmLkEGg=;
	b=fkvrU7H5uy62AP76gxDmxRm9L9XDWya1cpGRPSBIyB7vy2czjf81wwUoJs2H+2YLgkZ7
	 NOzBOZqu+MuYz+F/GleBYN7I+E7Di25qvj/Rjxy4c+nT1eLextP4KNK9vZXNrzDb8L4DS
	 zXjhBrNwaJhJ884820Zg8Syx7Zyk5qqBCKuRRjTgwglgabTBPwjfEiO/6FUrd0OB4Aww6
	 pTEzYs5/xNAKImF4bY1ntUoAdy/CIU0tUr31ntnQTlScRvr7tA/WgAJuVhekmEYRKyS3n
	 dGi4VqZoKjeVQyVkW01QgD0EWMZUM38NwBhOWWE8bH9XD0OZT1lvtC8pSUWJhyThlcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYLmMsOT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A2606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 10:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA7A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYLmMsOT
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso558878241.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793184800; cv=none;
        d=google.com; s=arc-20260327;
        b=AFywCdWnjGA89/YJ0Ra59JL35jKgwjxcvgeXIDYojUL/UnYvCg8c+WYP2Tiayb/IRH
         wRD8N3N9VJVQJab9BAttmavtjbsZIHjYSyxjOn+08mJBPzije8cUwmmDf6JRgTP0AfcM
         IuSHHhzJjJMGKJUDB+J9QfiZhPQfOhHxAxNKtpm/9coXqthFyTcHzWuIMMvCG0hzrGUw
         Xq2u25XgQ/vaIqEPFDUADhxy1k0heAd9g2SEv715oM+5pYJj/7LFBo+DfOByELn3mcmG
         7wHE0qWRDduFGFK/otj7AOyFksNZhSaBp2+uMuh6Pj5zNfVIbn21zUHhLiBZDjrEyuKc
         fQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tS/VO5/AsluA2q55cvFf2XY2mLXBMxWWBXCifmLkEGg=;
        fh=B5PST1wmSYzvTI8RmmAXC5pnNcsCFFcymOLBiVA79Pc=;
        b=Z0/wF+T7KW728sFHGk6SofVkbQh3Bz7nuBLQ+16MCqKe47tVE9lMw0s61VMWDw+kr2
         GkDr1YLjnDX3wMhgPIy3BK5O7gVM/lG9rfhJ6aFnO3eeyaVjEHIhDeGDPUsE84KLORGQ
         vTMcoPEUYNh/g0O3PA84fVv+pAn4DSmoqKJ6zDvO9r7xngBeqJFztdYhOQH/0LoAkFuQ
         q9IVeRUhmPl7SyYorLbmBtrNys+Ls/f3F2HeFmRbeGSDNLOwrb8VRGvFewqbMovbCPAB
         lPhPSnOpYIV8V/S8y74zNfBhm8byeg+GYYmbuZqwy33E6WJFgmQ85A7mT1pIDWpMPsjx
         wSQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793184800; x=1793789600; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tS/VO5/AsluA2q55cvFf2XY2mLXBMxWWBXCifmLkEGg=;
        b=eYLmMsOTyU+yDcLAMtEuP8PlgaLy5E1Sbc0qjMbQdk34Y+x6sIwn5/+eiV1V+wICR5
         TjRn0k66BXlJ3L9A56rsHYkH0bP9mdSl4ZGRO+h4T9MBNiPvNu0myb/ySRg+Z/7frRSm
         9Ytme1N8Csn/L1iU3XMidCLgO+Zm4GAhIOUSnqvpgoBHhjp9Qp0j6U5CFzrkTI3sGSg6
         kXxMuE2wOo2GZogMIa+OuOhXVjGq7nf+d72x7VMlPgY1IXeadIec6tTR3W4MBjPApkJl
         ddDSJO/V55fvFJDLpRCfzCTSsVm3MbGIrSxTqMvAVMhSz9Lr16k0oTLTLc/conuYAokI
         swZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793184800; x=1793789600;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tS/VO5/AsluA2q55cvFf2XY2mLXBMxWWBXCifmLkEGg=;
        b=tSoTh9Ijzl4X5EXFU4RHvCgc74qPFbAkEjCQQo0Cb8vYwAOVyUAIvj450Zfe4QMsCB
         oG6RgMLZCJvwKU5fXqWx74nlhLq20FjMIWsTXkNTBdpoAQ+2wJLhcMmK727MpMwV5u1s
         xk+z9PcV3qsjitXv6E3ALfL4eDHRVjrOrWMixfntdlemKU/79Yskha4YhfVTvCDaeKaw
         Ds4ob8C72ckoGkwpqWk9eY25AQPCt45hIDPAZUk6H3i8S7xNwuK+KvLNMYur7kPVBVC1
         uYCtPsEl9OkR4xJVYHQiSgJz1av8oef9RLlF+s7fhV4WXsCkUHMK12akJtT8RAFogMhz
         a7Kw==
X-Forwarded-Encrypted: i=1; AKwUvBwImi+spu6+Qz0nVKCGV8/GenSxZzmp8IgdcKKNvi5gwcY+P7bvIF+Ko6aUPd5m6eABZX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR5FUfNHou/BVVh8rae9DpEVMznzAwsYsFz1/8C6RnEXc7iP+j
	jpLPVWklEu5zWR/57p4PS1swiw+75M3xBA3mvr5V3p81NhB9buAvR5eQTK0DUNBLUYlwyX147Dd
	nQKJ9ymGUID7xczw2rYTyBCEAtoL8ayU=
X-Gm-Gg: AYBFou2n4WHH+FrLrMO/cZhUxBHqRAi3tkWkkkBCP8DRNzwJw/+MsifxVVYZYZ90otH
	WFUUk8Xekf4UByuPSln5VrzIkceivtoaLDRSBkxMY5Q//LaL3pYbK3lV0U6VkBZoySE3QcPIEvJ
	UzXW0WUeonDfNwOarXhkVY7yaNsv15kaeYBcxRcyR4jNuL1Sq+kZ1sEnmFARSJz0MOLc+VgOP/c
	BlR8WgqlOZYJsi/6WQJIQvl+wHg2U1kdXN11v1kF/xpqUDAQ4SQwPec/wR+n1PRZvA2ZS2UxKdA
	G+6iZtqr8Hjgido766iGm1bPUqRcSrq1JWh1SvzRrPHpqgKF7tiWZUXHZh+54FYXP4fy/mCZxNq
	kILSdFlhJKQKUAsXKvXYzvG5bWECAOWuwozoMNYFXrMWemohQQOkrrrJ7cNOlz3EBV7KysXCn8/
	WhBfoftCULmTZeZ7k4H4C9tVzO
X-Received: by 2002:a05:6102:508d:b0:7b4:879c:bb76 with SMTP id
 ada2fe7eead31-7d03a4c76camr772855137.21.1793184799705; Wed, 28 Oct 2026
 03:53:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 06:53:18 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 06:53:18 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 06:53:18 -0400
X-Gm-Features: AclHuK-7lVJYa7_S7ANgMbYLrRTOhf9fP9ah5Il9-gtmMRAvstq-AcHCrYtdK9c
Message-ID: <CAOLa=ZRWktyBmeeiMbPqnX_OkizqPA2mmGrnTABW7Pkk7DcKpA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] odb: introduce object storage extension
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000000eb5b065ee45f91"

--00000000000000eb5b065ee45f91
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> Range-diff versus v3:
>
> 1:  906c3d3e3c3 = 1:  f09fc3200f9 loose: drop unused `repo_write_loose_object_map()`
> 2:  3d3bcf0f825 ! 2:  655e1de3b9d setup: introduce object storage extension
>     @@ Commit message
>              allows you to configure a different location for the ".git/objects"
>              directory.
>
>     +    Making the location of the "files" backend configurable is not he most

s/he/the

>     +    thrilling feature of this new extension. But it gives us a couple of
>     +    advantages:
>     +
>     +      - It allows us to start exercising the payload logic in our tests so
>     +        that we know it's working properly for backends that will need it.
>     +
>     +      - It allows us to easily detect tests that are broken with the new
>     +        extension because they for example assume that an object is a file
>     +        in ".git/objects/". Testing is not part of this series yet, but will
>     +        be done in subsequent patch series.
>     +
>     +      - It aligns with how we handle the ref storage extension, where we can
>     +        also change its location to an arbitrary path.
>     +
>     +      - It allows for some very esoteric and edge-case-y gimmicks. For
>     +        example, you can initialize a single repository "skeleton" and then
>     +        multiplex therein by setting both GIT_REF_STORAGE_FORMAT and
>     +        GIT_OBJECT_STORAGE_FORMAT to point to different databases. These
>     +        edge cases won't matter to many people out there, but we will use
>     +        this for example as a building block for migrations.
>     +
>          Eventually, this mechanism will be used to support alternative backends.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>     @@ setup.c: static enum extension_result handle_extension(const char *var,
>       		return EXTENSION_OK;
>       	} else if (!strcmp(ext, "relativeworktrees")) {
>       		data->relative_worktrees = git_config_bool(var, value);
>     -@@ setup.c: static enum extension_result handle_extension(const char *var,
>     - 		data->submodule_path_cfg = git_config_bool(var, value);
>     - 		return EXTENSION_OK;
>     - 	}
>     -+
>     - 	return EXTENSION_UNKNOWN;
>     - }
>     -
>      @@ setup.c: void clear_repository_format(struct repository_format *format)
>       	free(format->work_tree);
>       	free(format->partial_clone);

[snip]

The rest looks good. Overall I'm happy with this version!

--00000000000000eb5b065ee45f91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e7009293e20a269a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yaDFCd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK205Qy8wZDFvOFdvL1FZZ2FoSWNNdXVIU3R0YjM4VAowZGxuYUdrWjZQ
cEVvVU5CK2ZidXRhcE15SkpUOEk1bGhnMTdjOTlRZG0rSG9XSGZJbEZ4TVBLcFBLUE5JcURBCkx6
dUUyUHBqNWpXODBndEJ4M3djVXpmOE5LcWY3a2RSWHM1QUZZUzhXNGZDUDlpOGhBdnk5OTVyMlF0
VHVsNFQKZnUrZmwrc29RL2lQZDRLZkJaUEZWNUcrc2ZxcU9hZU1uQnlIVjBPNzUxdHZDY3R5SVU2
WDdrZStKQ0xtenZqMQpTUUNJclRBRlV6dnR2NWlpa0NCM0hQbDVjMkNHYXBsVTBnQnZWU05Pbjlk
OXpUUVdsZzU5N0wxWk9CSXhlUHd6CnlYY1paS2hIN0FKRDVhSmVmRll0U3ExU0pTMi9sWXc5Tk5j
bElZTyt6dDU2K01ubmkzbGNkYTB2TFczN1VvdWwKYWRBS1BBSjBZYnVQcFhJelhUcGRNTlAvZmJM
bTRsYS8wejBJSU5rRlc4TWxsTXV2ZXRzOG41WkVyZFhXaTNUUwpDVkx4a1ZUa1YvQzdBRTI5ZFBY
RmdaK1NqVDJaQzhMYkdvM3A4N3Z1b0NyQXRGaXhHSnRDVlZzUFlseHVzeEZ1ClJjYzNLenFicmg2
Q3lIcVNUQVQ4dkYxT1p0N3c0NG9xQlBsR3N6az0KPXM4NjEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000000eb5b065ee45f91--
