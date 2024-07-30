Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EE1552FE
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349148; cv=none; b=cVJ8QNMCdr/fE3wrxlWOh4Kwke4KcDmhxD4uounO0F3PNwfp41Izow/rlDBdNY8zEzknLoaO6hkNnV/Z5mH4oRsEH+deq/M+UXxwwBQaOkBabnlKs7erMRPafP16Ip4I7m9uezaocjCUScgx661Jd7xdnjLoKOpAxRB9AniWUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349148; c=relaxed/simple;
	bh=FRWEbTzVjSJR50iAR5eC2XFWdDjjEVdYGW2JQV+XOrA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvpY3oUB0yWd7fM3f1D9WZmKFtF2DIP7rLqGkLklL1tVEZ3yP/7B6O3EIeULD2JAknHlfhJC7ReeI1/tGfElGM1T/+eHV8z2tSCAQk2umhWI79wo/SG31/B4/P9zhiNMKacyvEeBkvcHp/NEjowiE3fn/sFZCQivlSntYRGCxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2VN/hi8; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2VN/hi8"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-260f863108fso2766407fac.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722349146; x=1722953946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FRWEbTzVjSJR50iAR5eC2XFWdDjjEVdYGW2JQV+XOrA=;
        b=G2VN/hi8J2/gB83HwdYSqcUYiQVL4nur+Xt7pRYVTfENRKRMX7Tmzo6lW3OPCdlwts
         baJSOPiaH88RpUnkcK4R3OUdgPAUop5j4N+DizzOFv62Mze3CgpE69r9qaGWF32lUyfP
         lMnLXNrmz3e7X1Yn7fCzUvcBTmNvg4x+qEtgyhjifmqpvsSEFX3X0I0HXDAbfqsTkt+K
         HlTIFi003/skAVVv5XIb3b8gJpp3Y5FRw/RSNnjb/81lWyg+2drplZHpFsJtYPvbKdYI
         xtkTb9XzrkUbYe/DlHpcYAhnOw0Lx+86/UiL6R7J6dxcLCF7u9tvJVzxF7uuk/4yXb1g
         Mdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722349146; x=1722953946;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRWEbTzVjSJR50iAR5eC2XFWdDjjEVdYGW2JQV+XOrA=;
        b=v9g+afem54Q/lgiCyr1Dl8VhtUA5CbeGsBKJD126zQ0p8ecCwpGKIyMO/UV6z14BnG
         I9SdqrQdz4yQwuqtrLEdYkftdwUt7WUFREncuJKeqDbbulPYTVPTjcQloAnYrP/z7g0f
         l9Ynq8rrbdgThkzgXFdvBg5aeAbalRKVfE1rK0sEvbjc9BjBb6D+HsRO+1kdgj6himfz
         FtXxzc5HC5GrIVCqO8cYO9mj05b91ik07dGhvtYGvcgXZVDaZy0at5KZD6is1bh2LbP5
         Mh4kDE/TysYjizowYSw83mGsAiui/1jaNJdkozW3KPpD7OTH7txWeDF6XotW1OPN0xB2
         fV1w==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZWcEt+N7MmdmqkHHWoC9Faa11lM8NNl+qwhYXeSlMz2SnZh03Ux+LczyiJGNY7aOcNjJkr6ZaNs8FgoeIWA7k/Vh
X-Gm-Message-State: AOJu0Yzg5kB/ewnlGFFNo2e3TOTGfDFdcF1P96dhnhSAsIL9CDO/1X/j
	woVA7DIDUe2VClOP3plQg5OnHaYXlZtLZGeeulC6Aruy19ou3KZVCGL0y11nBdi3czHy0F2qR+Z
	54bCXwjgZkNk0KPLr2u4nuNFBXS4Jyw==
X-Google-Smtp-Source: AGHT+IFbZ2ykRMha8IxCdmQBPZ0qhMvNVan8yM1UkVUTp1fFQOino2+84EAc34AApSBWOTG84e9f0nnoQMDwvjf15tA=
X-Received: by 2002:a05:6870:c14c:b0:25e:24d5:4d6b with SMTP id
 586e51a60fabf-267d4f3d53dmr12604785fac.50.1722349146337; Tue, 30 Jul 2024
 07:19:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 10:19:05 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <c33ad700d68b5d8b5940dd803d116ec19bb75c7e.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im> <cover.1722323818.git.ps@pks.im> <c33ad700d68b5d8b5940dd803d116ec19bb75c7e.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 10:19:05 -0400
Message-ID: <CAOLa=ZRrUMawq_K=_4OUQrV7V67LhCUrBGtk2G4Z5Zq7+h=hAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] clang-format: fix indentation width for
 preprocessor directives
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000000c1234061e77a96b"

--0000000000000c1234061e77a96b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In [1], we have improved our clang-format configuration to also specify
> the style for how to indent preprocessor directives. But while we have
> settled the question of where to put the indentation, either before or
> after the hash sign, we didn't specify exactly how to indent.
>
> With the current configuration, clang-format uses tabs to indent each
> level of nested preprocessor directives, which is in fact unintentional
> and never done in our codebase. Instead, we use a mixture of indenting
> by either one or two spaces, where using a single space is somewhat more
> common.
>
> Adapt our clang-format configuration accordingly by specifying an
> indentation width of one space.
>
> [1]: <20240708092317.267915-1-karthik.188@gmail.com>
>

I totally missed this, thanks for fixing it up. The patch looks good.

--0000000000000c1234061e77a96b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e1372994ffebda51_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hbzlsY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1kzREFDa2ZVY2oxbzF0enR5WGlsaWFjVUFZSzlnNQptWU9POWY1azkr
S3ZkOVpXNDkxamM1bGZDcHZ2d0lsVFduK042SXFoZXhQeEx1MkxFTUtxdVRiRFNrdFZsYzBvCndB
ejV1aHNLMEFMTUxHUFk5U0k1NzRGdElwVno3NTFjeUtaUzBjMW1Cc3g4NGR5VTZkdHJ2dUFkQk5l
MDdLY28KNnZHbkhwb3VxenFCaXV3aFNHV1NHYTN6Y01PM3JzdytJWDZCQ2xPeFdSTEc0MFYvQXhn
Smo4M0VRdWtrWUFDOApNRWtPK3dzNFdkMmx4SzVsN3AwT054YlYzSU9zaGZOQTNBd2VzWjlPZkxn
OGp2M0RUck1hZHR0MDBGUEJGNmVNCjE5WkZ5YVQ1ZE1BR0twU3JYSy9ZeVp6QzVPSFlIZGFXbHQx
YWVHMGhyUHkya0dPL1ZMY29sZ3Rzek10d3VvK0MKYWlQVVVoVGlCckdCNTdMTXRabTVpaXNROWZx
enNOVk9rWDNpY3ZLY0FId1VsUE8yYU5qM2dxdjJpcjI3YkhHNgo1S21KZkZwVytDN0V2S3VLaWNO
dWZuZzlGSTNWRHdKdzBVMzJuTGFLdEpXQU5nTXB1UmYxV2VsekdwcjR3SXZICjA3ekhaVkt6S3Mx
N2ZEdXNqRFBwaWdNK2lxZGN0bTd4eklmYlM5Zz0KPTNFSEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000c1234061e77a96b--
