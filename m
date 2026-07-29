Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99813BBFD6
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364751; cv=pass; b=hsosHxLVRuWLJwNMuvwF3GNOE9AmuHHyOZl52bCiBqbQNO8dYa47PLR84+BaxqVU0kTH3H7yssAAlkPLJRskkJsb7ffJCHoPnhGIQiBsO4OPzbg+U3XCSv/ODsYJea5ORCcQtPW8rMc7bYHpdycTVZE9qE5j9E1pjWmO6nULN+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364751; c=relaxed/simple;
	bh=r3dlhEJfELVO1K9bsPAN/GS5+b9H20tmGwsxin4nfbQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttrele+6QLRH3vQm41I7rAYgF3n3SaGMdwmUAvl1bVW/2Zr+/iIb3xkMhO9JTgokYnzNoUx5j7nN59p0EW78LggFsCBOkUWbYLp7bUjhviQuBBMc236yFknXpC0x5S++xnfh4dd1a6T+0n3zIsFz//jorLStCtmLceDtTVcJNHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG6IDQlT; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG6IDQlT"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-96723c7151eso392414241.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785364748; cv=none;
        d=google.com; s=arc-20260327;
        b=c5JtRfZnwCw+qQsi4P/EAfEPBcgS829RQbM2U93fw+lgMpX71fZcLOM8yJgw3Ayfm4
         iiK8sV/ylQeXxUDk01HueBfd2BfaPxX1UfEHJtDOh+pMHjidqZApHOjH9OWx873SX4lO
         ptvK7H/AHFG5MYlXWA84rZgDf3Bv3IyImk6maYcdfQRPWnlxcFGhXdX5HxqUIp/WF3OZ
         k3KdJUd2OHPWlGy9zMRNTCxOA635dV18wWCC+NNXCEPRJCq79DjGhFtkhgz/0IpL9Wi4
         h3GCSJF7Nks+7R0KBNK/1mlQMzawQSqMCwHjAcOEolREabkscZ30raM2IANOJufXPkMO
         UgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=T/WvE47Vbe8PEtllY/rkz3MjqqXP1eRscyVOOfUxoFo=;
        fh=a4cP6noKAj2VsfEJdL/krMVcYCP1focHmXBUogQelio=;
        b=bfNLtuJNiHMWiuhyQCZXkgQG0PLbHnRdmMjJuu898akcEorVT67Q1rekE0cMqkqQ+X
         ZnC4vueDHL3Is5NGyLOgvxHm2OOO+6AYfDjcWMPe670o55tyWz0aiJYk3wjdiqcEvp2c
         IBJc1qFL5lx2pfHW52MQ8PS4IBNvIk36IEHraKlc05tdzKRnEg7YiYaLWVZZWwKFxrqP
         A7rSFH/PlSsYYfFN8IkqiytjDN2X2Bs0hDMMgB4Am5nXOwjhe46wz4eBdMxN07+yNH1v
         2l0C2KYnTSPJBR1R5DYrvcqzNhXVDu/+xBi8803HiyzRDcrjPB0edMeltjCqLUf4Mapw
         MSFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785364748; x=1785969548; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/WvE47Vbe8PEtllY/rkz3MjqqXP1eRscyVOOfUxoFo=;
        b=UG6IDQlTQyh6r3zaNj8aggPHoOwJnKXpI5cvxch/hvCpMakxsjOMbFraaMAYDxHLvp
         pRg7e8S2oPQjkmFYGjIz7Bgn4Dzk6W4EdzwlR5MNN4vUGF32Ylxy4tb3PL39DPOgmX+Y
         F/R99Jcr17oq3+E7ZH/eoBF0qaWA7xVUMDCgzHeFpMCSi2kQcD+8802ivxkRFysXA7ka
         +BZNqovUtrsWkIZl2K67Ec+RS1cWx3Eh/p8+/RMHVOzhIqpmyHvlkpBSuei6cdILLmMC
         a9n8vg+FNqKaM/Lbnf08W8lUIBiuoNnkUaqmo2Gp5Wo90j5zT4bEn7t37gqhYYAbfwkS
         v65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364748; x=1785969548;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/WvE47Vbe8PEtllY/rkz3MjqqXP1eRscyVOOfUxoFo=;
        b=UHJFof4CkCotC7W/Zgw5I5jX9rAPhQcIM5knCINoXzeBCf3PmC0OAL9C1o4vQ1Lg+I
         NrnNxkD/dqlcwvk4lclDw4Fh1fXqpUuNR38fsOGbbvdBEcLmTgH6LbfwUUobL4A3ovF/
         /FlycrNRkO6TZzNn2C5hxgDc8A7AxqRrQMf5YYDTd4NsImS2DXfE160/dHPg2OlqXV/v
         guimxOfcndfpFyEIOfoi4qDu/yFEniyApjHGrvoNPh1h8KL+23vu+W4UTbfdcEeEbHPb
         KFalcxsHRzkwS6MuOVqfSfsmDydkx7+OnQp38wDYH+5XpsopxwbrcJKNiS7vubaVIGCs
         volQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJefp4W/UtpqIydhmyJfxJLehl6PknIcnXh+c9fetm9ULwyoTCCHSk2nOy4Cxve1qY6T0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0YDG+fM+wV1uXYdUi6QfBEYXoemURZNMBHfrlxdMOGLyz8TD
	TixO2lejMnYKd18Zpi00dfKWRwLxZsFtNlmpZRNdsuG4O9XyAziWbdIM9pvZXtWGtGd007D1LDB
	vopJbn1KL1CQtYttvfD42t/8/OilDXUVm34Aw
X-Gm-Gg: AR+sD12TVbvwevXyZQhfzuHdC4pGdQznoeT4wW5evIx1FTjeu2rDV0SMJy5zPw8DmRt
	JUZtZRz2BrkxLKg7qyVJGyJo0nCG+KftEwxnZIHMwBobqCGaezB4wAJ5JfX6EFCUwdmKdICv8DZ
	bvGyi+uGkiQ1mZRkbHI4f1HWWG6TRycqa6xm3Owtkp8l1Fmfat4p2SK8x9buMQIQzkD5iaz6WED
	M/k1kSawPZ77bFSAX1luxNb4GAHFcXLgzxGQnK3tJG5KJNPyWe6o1nIBZv8f0pNHD/g0VUQTvLU
	qm71B1zBoFwZEcfGenT8qcET5/XHCBzMPsYT4mmmTIJxTXwNH+AJpz0MB4FztQzTF8sPC7OiNP8
	7Jz+TqujGIHPiFPDpv2PNF4QLWUbdvXzwZw==
X-Received: by 2002:a05:6102:3047:b0:738:20f:10de with SMTP id
 ada2fe7eead31-7574fb497e2mr68182137.17.1785364748529; Wed, 29 Jul 2026
 15:39:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 22:39:06 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 22:39:06 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com> <20260725-objecttype-support-v1-1-2d4ca3bbabf1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 22:39:06 +0000
X-Gm-Features: AUfX_myRvrxRniSSg26GR55jtb4xb70Hb-MQxqCzSiUphrqM2G7qJlkVACNe0tI
Message-ID: <CAOLa=ZSJvOrTXypnh1Bk_Z3kkXtJVwueSH1U-vHALwS=XQTouQ@mail.gmail.com>
Subject: Re: [PATCH GSoC 1/5] protocol-caps: add type support to object-info
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000a199cf0657c79fad"

--000000000000a199cf0657c79fad
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Teach the server-side object-info handler to accept type as a requested
> field. When the client includes type in its object-info request, the
> server returns the requested object type.
>
> While at it, fix requested_info->size bit field style.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  protocol-caps.c      | 21 ++++++++++++++++++---
>  t/t5701-git-serve.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/protocol-caps.c b/protocol-caps.c
> index 02261be14d..5531d388f0 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -11,7 +11,8 @@
>  #include "strbuf.h"
>
>  struct requested_info {
> -	unsigned size : 1;
> +	unsigned size:1;
> +	unsigned type:1;
>  };
>
>  /*
> @@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  	if (info->size)
>  		packet_writer_write(writer, "size");
>
> +	if (info->type)
> +		packet_writer_write(writer, "type");
> +
>  	for_each_string_list_item (item, oid_str_list) {
>  		const char *oid_str = item->string;
>  		struct object_id oid;
>  		size_t object_size;
> +		enum object_type object_type;
>

This is fine, but If you do reiterate, maybe we can follow the reverse
christmas tree [1] format and move this field up? Or maybe its just
me...

>  		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
>  			packet_writer_error(
>  				writer,
> -				"object-info: protocol error, expected to get oid, not '%s'",
> +				"object-info: protocol error, expected to get "
> +				"oid, not '%s'",

I know this is to fix styling, but we generally don't do such changes
unless we're touching the code or around it. It just tends to be a
distraction :)


[snip]

[1]: https://lwn.net/Articles/758613/

--000000000000a199cf0657c79fad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cd62a1c2e252375f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wcWdRY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmVtQy80M0RJOEh2Q3BPaUdtOHphMkx6ZHYwM1lJYQpGeTRZZUhaRFRS
Skx1TXo5eTRBRXQwTWN5czVRNi9SZnEyOWV1M3lpK0x4SXJuV09mbnlTU1gyc0p4eC9wMVB1ClBW
MFd6aUkzMGg5SjV1YlhlNXRyWlFzTDN2QW5Xd1NqWkdvZ2dWVkhKUGtabGhVaEpzSXVmQmh6aGlP
TUJzdlcKU0VsUXcwMUIvOGZqMlhoT09qVUd5cmpta0ZPcnZ5amFJVmg1NjRKQjZWNE9Id2NBUXlY
WklwdCt5YUhGUGFSdgpjTjdYdlVWUWJsMnU1Wlp5SVJaRFQrcldkTVFCNUZJUzRkZXM1T1ExMzRr
MkxYNVNmU3l4cHVIeU1wOWcrTWhKCjk1QnRFV3YrOHdBS0hnK0hZMlgxZFc5MzVGUkN5Nnd5aXFM
bnFGZkVtKzhZam9LT1VrZEhJd1dYN1A0c0wxOUQKRnRYY1d4MXYyaXJPZjM4bGhXTm51azJDMmcz
Q0RWYW4zZHFsZi9TQmNtR2h1amxacXA5d0FvUzRlQW1XQU9FbwppSmdISVNyRDl1dHRHdTVqYlhl
RFF6MXR1NzhQcDlmaGNOVndNdnBWMmVUSFR1c2k0WngvN1dsVjl3NTFnSm5UCklNT1ZZUGJxTXE0
OEVqeVZlcTJzWXVqeTNOd0VJZ1JuSVBoK3VSST0KPStROFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a199cf0657c79fad--
