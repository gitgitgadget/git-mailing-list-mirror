Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53018FC9B
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017943; cv=none; b=lL2TZYLq6+U+7AW3+/9gixBHVTAhVF0LDKMHPuRnGpZkEaQskN7VvrH7+ZgsbFXXFFM9oU0sDcIE3bOG3U/gWVKOCCp9wQL6xBU5K4+HIDUnTjjkWHIxotyjLWAiMaU5M53xFhMDQ7EHf/aKEce3zR+O/urSHGBpja3AeEwENQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017943; c=relaxed/simple;
	bh=M0YdClZ+zOhv5W33YFXPdNWPAKRFKRllVvQScXVowAg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDWsnoGkVvYqxQZoPr7dMAkjyYDQRf88wxBEIHSr7ryrxabTIBGIL0FIGXUB6ZQubxogECQOef+AzTadXZO7sff1FmIJ2h06V3bAqxozyLiTBb1DfyEVCpG5zw9vHYIiYAi2e3QPMj9PXatORKGqY5GTF+HkZsTrghVjh7VW5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfocEOc4; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfocEOc4"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5b22f97b7so992393eaf.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723017940; x=1723622740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0YdClZ+zOhv5W33YFXPdNWPAKRFKRllVvQScXVowAg=;
        b=WfocEOc4ma+70EzOlYpK0MiJcsqCJcPI6/5LuS+EsadoedRIUuHTY8A4oaxsT4Ex8l
         ug+OecE1frz6oKJIQpTN0NODcCsDECqPdYAkRAxWik1SKc/ue9A6h9K8EmumoadY36ux
         O24xc89KF3e6HTghGmgaBvg8JkQjtpVcTyxrEDThUCP85hk59xvGQAvKnhYRt2Rs26/c
         3FP1Jq0HPhuLKIYCorQEhK1rnKdtYRWsyq62/L5APPvMTBHRHfuGzqTur1aConFxCFeP
         LeRCaEEj8E3c1/zZV3uCA8qWxgazgi/OzsvTlbBUikeFzEpZ4AuuLTobWaqvfXM514sT
         DqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017940; x=1723622740;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0YdClZ+zOhv5W33YFXPdNWPAKRFKRllVvQScXVowAg=;
        b=Ay0lvz4sU9i5fEyPbL5kqgMrSb9PdK+MH+IcVvZfrcHuWeVoxCKvILIr6XIO1ekZW3
         kkjadxhNCr/uMryIZbRwYPcm14PzcawJ2hGnAFMwxw+rxYGVFFdIYTaZgwlLiw0fjYf4
         Hy9C67VO3fLn4kItHFe+LyU1qYH46g7o6PVHZtxJJHZSVCZ/3d7GjxYqN0W7v3E9vwHD
         gwcO5LVdY5stzBzcWolAqmyhR0BU43oJvdKlVCiLXFlK26UTprel4z8qk18/1BwdB2zS
         NQo0iF9VpAHZ0N3nRN+baWUtZ3VtMaBYlzYuBYcb++bfTssG77LA9lVigaN605BMphvr
         yLNg==
X-Forwarded-Encrypted: i=1; AJvYcCWcpm1eQr+o84laBeSQCWzSJ1V36BNrY7fD33AAJcUgGw4DT9zvTVEIF2JkoMPWR0LEKE8BsZUo04nr1gQ8z2NK8kQZ
X-Gm-Message-State: AOJu0YypZmqFEs6HigQkFIr4jStZz4nVKBtOZ4Zevk7SMl2pXY1hVDBj
	9ZG6hFoHja96oHks3lo8vZDjd81jabaq+gCR+qlYZ4yRH/mPLLddMjdZcXRVpqSt7D7d51D16Ab
	knFOfMOFlbbrzZ/DtXjyFL7g7CiZyAw==
X-Google-Smtp-Source: AGHT+IH6tC7c+XTRjQJTYiqxnJK6lvzBZe/xwT6aeIxaY++d5k0A67AKrWnHDMFUCW2hUMd5gBX15c1ZXVVEi3+uaoU=
X-Received: by 2002:a05:6870:d29c:b0:259:88b4:976 with SMTP id
 586e51a60fabf-26891f0a9e1mr20089605fac.43.1723017940614; Wed, 07 Aug 2024
 01:05:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Aug 2024 03:05:39 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZrEBvB9Urj8mG4i-@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux> <ZrEBvB9Urj8mG4i-@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Aug 2024 03:05:39 -0500
Message-ID: <CAOLa=ZQdmC+EQvxpqSjkXUo_PB2apkU2NteC49v6mvyxsByk8Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH v15 4/9] fsck: add a unified interface for reporting
 fsck messages
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000004ae363061f1360d8"

--0000000000004ae363061f1360d8
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> The static function "report" provided by "fsck.c" aims at checking error
> type and calling the callback "error_func" to report the message. Both
> refs and objects need to check the error type of the current fsck
> message. In order to extract this common behavior, create a new function
> "fsck_vreport". Instead of using "...", provide "va_list" to allow more
> flexibility.
>
> Instead of changing "report" prototype to be algin with the

Nit: s/be algin/align/

Rest of the patch looks great!

[snip]

--0000000000004ae363061f1360d8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f0a11116efec3fbd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hekt0RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUJFQy80aDVCZkM2eWpvRVE5dDZUM3YwNGtCM2lLVApONWJoTXRLSHps
aVhRTzdnajBJYkNnUUhTT1dzNVIvRndqMnRucitYVkw1d2lBS1FyTzZ2bWxUK1k3dzlOSmdoCkVH
aVJsTGp1dHlVVFRCam9aN29ndlM1cmk0S2MxQWJUcjJGaUw5SElmVDZGd28rd0o4cWNiWkNzMUpZ
ZjdyZGsKQ2hMcjhBQzZmVHJiS3FLSUtlRUdjdGpMNTVjNUMyL0swdWV1Z25QdG4wWitKbGxpMDg0
OHBXUmZoT2d4T2RxeQpXZStQRkg3cDd1dW9ZOEl5eEdoTDNEKzVKdlhXUmFpQWsyMlR2R1p1RHU5
T3VtcExUL0I2SG5oeFFyN3U2WmRHCnFJd0c3azdrMldSb3hZYWE3TEZMT1NTaDVaSXVCV1U2MGNs
TDc4T1piYXlKRm1Nam8xcU12di83N2p1dGsvNHgKbWE3VWFOL1lHRTlLaXl0UlNWK2pjUkpMK1cw
WjRTbVFQbG5Lb0NCeGQyeEVvSE8yUFplTFZBRE42V2V1d3JHTQpZamxya1Y4SDFJYWZUaXcyU0k3
ekhOTTlRaXFKSDNVMjBiVG85MkhUUG0zZXlhOWc3OGNYQUZraFhMNzRmektFCnY1R3hjbnBJS0lI
MXlGUFhoSWVuQkgweWJUS2NnRkxLWnlpS2FBcz0KPUtmalUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004ae363061f1360d8--
