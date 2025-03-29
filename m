Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BC8F49
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743272335; cv=none; b=UBGkRpskCCfofGUMGpUdLzvfy3jwQJsZGDczLBy2PR0mdgkzRZxTlsfucW9P0rrXDuSOpbpU2lQzVwMvJ2aDfEHbWc6maREWI5k3viHCCjqrtnw/6b62P7RuIl3JRfYr5Wh2dhNbneUvUiJApkqrkxoGHn9zKmoAjsjYlNPBetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743272335; c=relaxed/simple;
	bh=U/0kh6ykNX/TDwrMry/QrDZQqluZENWvioh5Ir6L0U4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKMZ6NUsLXL8vRgnQgmIl2ldVhd1isNmY3waTnVsGKYcvA1SKhEI/5Zuh5VsFx4dCCmXmq8prYeM8dKCuff7zsSRomrevFxoQ1C724/Hp5I5iH00l0n9q9UR1Ytxgap8nBQ2PYpMMUIqHM6t5IMJMCUna9SRNpwY0bFc6e7x5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxU+Y452; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxU+Y452"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d69774081so1463065241.0
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743272333; x=1743877133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYVOf1t+eIPc+Ia/YxqJ4bFGn71bkWxN3Aqvftvk0fA=;
        b=NxU+Y452i4ZB5L5RSGU6nRWedwVe6MsJCXHA4b1ULubHhhW1ii0EGhuoVk3abLa3rw
         EaHmP+fnA4XVEPvP1EQCNIfeeufeCyimiA6lA8uiR8fAJf0X1e+F540rTF3wdJoEjiWu
         g8YTcc0udUSeSKJkjDYqpEPiFIIYPtvgWyI+XSgCf6XdhhevjYWh7biq9tUFJ239AJqp
         5CcTJ2QXei2Cjuaf0wSIrMLr6JAOtqeIY6ogopL1rjg9hQMinjDtIX9BvvdJPeT+4xCI
         COydCbpPVE+kwIqqLgjwC4Jzj0HaZI1Jwh5mgCpUtSNwl+8hF3Tqvj9uNw61C5Q2vWKx
         8rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743272333; x=1743877133;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYVOf1t+eIPc+Ia/YxqJ4bFGn71bkWxN3Aqvftvk0fA=;
        b=cjVfwCg6ih5cXMvCLWzyhWM7P8WTDGrT+dCbQR+H4iDOHPEci0HMWeg/+lHXXLMsI1
         LF9J3U37UmhuJtKZ8Wo1mvcnpB4qrSi/6tiA0Jvs65BMSwHTCGIu75YlHprAhrpwzOHU
         Bgu6X8UtH+EvwiKBy4XB1uxI404sZOeeshQFV4qB55Sq5maoHxD+59QKgi2GXIuEikT/
         GtdwVmkCGjZu9JcqFiCr105Mdvmfn+IXK6sDL7kKn6vDbuOj0ZFAqCen4ndtFX4IU8Dl
         fl2taogOUPOeHpw9Jl5WhEAV1Vhvy362nrlsDaxi6ffCX7ZEIuYXmRU86lGh+Dum3Dxi
         WpWw==
X-Gm-Message-State: AOJu0Yw5IksF3g/VpeAZ9ENSL8fEhJxjwAupaj/DBh4JpwLqAmqllwtu
	Wb0tZfXuuxoRGzaoubkuUrJsWqEi9YeIha8jld+Bkkot+QZZKzZd7M+5Xp7bEw1Rgnpxv0eYUUR
	PwsvL7u6S+t9NT8O+Wg1k8JFHFAQ=
X-Gm-Gg: ASbGncuIwhQI+LRE2jEzWdTdvGPzJbUjU8k0F1eUw4tSPNmkPl3N8NRI4A2uRcKJIsn
	tNDPlHFfBJH9fPPgA7XBmduzVJpVzo0bRzQwIEpibz86HswV8dTuHqR1ypQBBrK10yHPdz5wXej
	Ip4EZN0x0ENnG+3IkvDzry/H1RaeNMakSj+GQ6tnAMwFpUhs+a7KbcgFXa7Ws=
X-Google-Smtp-Source: AGHT+IGBuRPJHBqVHHD6xy2TIfOWG5PBqEcYn1aHiXtGWOkpYHq2xA8hDmLu43fclrWbRE259y1KO+kmCP/4fBM8p+E=
X-Received: by 2002:a05:6102:1481:b0:4c4:fdb9:2ea with SMTP id
 ada2fe7eead31-4c6d3820f32mr2910241137.7.1743272332869; Sat, 29 Mar 2025
 11:18:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 29 Mar 2025 11:18:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34evequa.fsf@gitster.g>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
 <20250327-245-partially-atomic-ref-updates-v5-8-4db2a3e34404@gmail.com>
 <6141866.lOV4Wx5bFT@cayenne> <xmqq34evequa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 29 Mar 2025 11:18:52 -0700
X-Gm-Features: AQ5f1Jo8DkaqoYpqbDNPaKNK7NDidgi_tsnXGIXyPwS_deGKOkeuBKqt_4PO5fM
Message-ID: <CAOLa=ZQDiCx_VJRbQB1K6EeuA2mDj4twEB98ByddUNLtB8rEKQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] update-ref: add --batch-updates flag for stdin mode
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000025f00306317f3800"

--00000000000025f00306317f3800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
>
>>>  SYNOPSIS
>>>  --------
>>> -[verse]
>>> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] |
>>> [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z]) +[synopsi=
s]
>>> +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
>>> +	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid>
>>> [<old-oid>] +               [-m <reason>] [--no-deref] --stdin [-z]
>>> [--batch-updates]
>>
>> In the case of expressing alternative command line invocations, you need=
 to
>> repeat the "git update-ref" command on each line. Otherwise, it means th=
at
>> this is the continuation of possible options of one command
>
>
> Like this?
>
> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update=
-ref.adoc
> index 5be2c16776..9310ce9768 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -9,8 +9,8 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
> -	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<o=
ld-oid>]
> -               [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
> +git update-ref [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-o=
id> [<old-oid>]
> +git update-ref [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
>
>  DESCRIPTION
>  -----------

I think you also caught a whitespace issue here! I'll add this locally
nevertheless, but will hold on re-rolling! Thanks both

--00000000000025f00306317f3800
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f3350ac22f4c4400_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mb09Za1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMCsyREFDY3lkcVRVMFBDOU13RVBicnArNWN4QmE1TgpsQWNGbENsL1Zp
SStQWkxqM3NkcHZQK2xHVVE4T0VLMEN3d1ZlUXprR3dMVUhjOGhiRWFCWEpIQVhkSm82N2lVCmVy
MXhYNHZ3ZVQrV1d4MStnQitlbW9BeFJUcHJ3aXdsQnJiNURFU09HemZlRXZPRStvQnZydmdwaXp2
TEQ5U00KTDJiMjBaUFdWVFUwMjJoMXVVcWtVdE8xeTF6VmQzMkRieXhUaHpOcU9RNVJkUHd3NVVp
K0Q5Uyttd0gwYWM2Ywo2anMvbVZ0L1ZLT0Z4QjlhUkVrYkx6Z2Evdi9qY3FFMG9icFkzQmpScmph
ZG1DTllOSTRvd3p6clRuRlg5UGw1CjQ0Z3VGemMwWjNrQ3BnWnlrQ2lmai9RaXd1b1pIQW05bkcy
Tmd3ZlNsdGtkSjUwQWx6cFZiWm5PMDRaZUE5UkoKOVYvejFKU1Q4QUk5ZlZjaTBHVy9PN0pkT1kz
SUFBc25DWFpmT215ZUYwOHVmSkxxand5NDhjL2xYcDNuYU9IMApGeE1lRi9QejVqWGx1UEgzTmlW
aklMQU11ZTZsT2s2bXUwa0lvVUNEanFPd0hYbFdxTDVIeUFXVEROeE40MC95CnRCSU43Q0RWcDJZ
RnJPY3dvaVhWR252azl3VHAzd05VRzFXUHRNOD0KPTZKbDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000025f00306317f3800--
