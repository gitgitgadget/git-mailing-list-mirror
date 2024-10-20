Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACFD515
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423082; cv=none; b=EmiS0vNE1JDYSAdH9MBEJ4rJ06rLvoBGLGhc/iSFKpMgLawy7qLxvJwsRmI7yL+n1IRQsvt7Obe3nL547RHAEilSL99nYc1uvlJSHks8rV14jS/8QX4GcMNbaONRu+GXzps5ad21mZiL17AdGXDIXYqDWCfVD+JaPZG4yriKGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423082; c=relaxed/simple;
	bh=COHoe6fVgHmeXDSOM7Ots1y3VNnMNZPgE/t/gCzFZ/c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfTG1uT2y1xwCLVwVSyDYshzuONmnQaiaqHRrZtyqwuy/kb6JQwZ1VMUDtj4fLT31YmQOT4NWLFidB/B27dL8cVfbeP1GFtnHNyWLdNhn2U3v5/k2yaWVXDUlpG+I/CaIzxVo5hqE7D+3LjQkXF4AiT++/X5GvDS6CQ4f0iwuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoJHy4Zz; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoJHy4Zz"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fc5aaccf8so1077276241.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729423079; x=1730027879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvSvc9leJJ57IBh5ug0pQyBzyiryBajDijyZs1DBLVQ=;
        b=IoJHy4Zzbr8/zNuZgvgcZW7oQDWuWJiFmNEk/GaQuhywTGfHzNq83/B0rje69bGqic
         6MztxOy81A4WBAseuhaX4hOyEegBrewTBxuxe5tAU3qoKdIWdYFMy540Q7ml6BTWFF6B
         j0bu8EuFQMs+x+0HLMFlIMXoYWGmbSn0dIH39vChRWqUIQxNplalJ2XH8c5wDyUnT5ve
         tWiVCAwt4xC4EWBZTHJ1F0C0BEncwe0RgeTx2ZtMN4ZgvY/g0IWhe2u0s330y8erpWk/
         ddIXxQTQleQaM/RUAyTM1anEOX0yHH9ZPgSZ16gM/Ay4iegmLTVkWECfC2vZJ9nam7vn
         qMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729423079; x=1730027879;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvSvc9leJJ57IBh5ug0pQyBzyiryBajDijyZs1DBLVQ=;
        b=riBBiMHtkhSYT4dlsUVtUG5r8eOJmfmARvEMzh5PONpSTgII1l8NRC46aoQ1RiKN8z
         BAFKZBJ9r4OhZPVgkIYG6/B042ZQab16hTYo/octTIujnyl015T/bYzQJ3mYlfbPt+Oy
         bVhM8jhj1X5OtvLjQak1vt+yvDqMltn3/EdlHq6i9X8P+wykbak7D5Vp+8Ml3otK9WzH
         qNxFnj/8c9WYbEHoV5MUbyKANariCenO8HaKrX37v7g1tdbKy/hsCaWDXc67777oYqB8
         d9L9+05XFNwFpRBa5v97PGLE5xmJQLS2YDR994YwJ96DH4E8qaXaaQ/erxPas5j2pwsQ
         0Q3w==
X-Gm-Message-State: AOJu0YyZ1ZfLsxlGZrwpTSyrAzkiTVEnk6vW810YF3ktTxOxqzgaPfdK
	lJyqEoKiPChv6qITQrTeR6nl71HDBnhx5IQ1cV4peGNHBo68HCWFMlJCaPyeZBCNE21q/4KMETV
	zx/8nxQD2HYi43848v4AvtFGq880=
X-Google-Smtp-Source: AGHT+IFBYFQrGx0Mry0VVG7QtLXaYUb4aLv5ptAYeeVF8z9XTd2SB+nnAzoNaltnwIx1VN3pqvzVqaBwU+slHD4TCbo=
X-Received: by 2002:a05:6102:5486:b0:4a3:c8ab:d350 with SMTP id
 ada2fe7eead31-4a5d6ba417amr6628233137.27.1729423079305; Sun, 20 Oct 2024
 04:17:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Oct 2024 06:17:58 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxLVLiiEEj2A5Iws@nand.local>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <cover.1729241030.git.karthik.188@gmail.com> <ZxLVLiiEEj2A5Iws@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 06:17:58 -0500
Message-ID: <CAOLa=ZSCenJLOg1jF==_uNGJ7GZdLiNd6GB_JO4XyXMdLNT65g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Subject: clang-format: fix rules to make the CI
 job cleaner
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	spectral@google.com
Content-Type: multipart/mixed; boundary="0000000000004f0f9e0624e6b031"

--0000000000004f0f9e0624e6b031
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Oct 18, 2024 at 10:46:44AM +0200, Karthik Nayak wrote:
>> Karthik Nayak (2):
>>   clang-format: re-adjust line break penalties
>>   clang-format: align consecutive macro definitions
>>
>>  .clang-format | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> Thanks, will queue. Are we ready to start merging this one down?
>

I'd wait for some reviews :)

> Thanks,
> Taylor

--0000000000004f0f9e0624e6b031
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5e5e286cfbad79_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jVTV1VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTNTQy85OU9rVXltak54Zk5mblA4VnM1ZWRSL2NhUwpKZ2FkWGF6Ynl2
bHdHS2tNb3l5OEFlaG1icGoxSVlnRXJ6UUlmRjlZTW9CTGp3ZmxYL3RNdDVFR0VQbmYzVmM4CmVi
OVlrd1Myb0pYcFIrbWtsdmhpNEFmOU0yMXF2ME5KMGczRVhxaEFZTkQ2dytEZUZDTy91MXFNb1hC
SFIzZEkKNWI2TFdnUW9qSUtmUER1VXlBeDhEYnJvZUVGV2JxalpNWVYvTlF1QkIvcXRKeXJ5ZDBY
SVhOUEx2NXM5U2FvUQp3ckZUNWpNZXZEbkQzdUZoWlgzWWlETFJRVVhPWVZ5UXhRaG85OWh3WXlx
SEQzMVFmNDRkYjIraDlUYjNmemNzCjd0TkEzZkJQU1V1S3MxMllKdDhYUCtDZmVDNjNqajlvNzhi
UnllZzQ3cWNnYldmZGNuQ1N3cWNvWFpaQ2lzYXMKdGdGRzN4eWZSdld0V29zSEIySWNWQTlsa0lC
TmszOEdVY3NFSDFQeE5MY1g1YjQ1S0UrR3ZtSFpRSWRHZm9XSAp5aTRPNG10ZlYrcVBkQjZPUDcv
VHlMYmVINzh5UnowbGlTVU81a0Vka3QxVkFPWGVNWkpMcXFhY1A1d0kyZUNECkdjcnUrTnRpbXRY
Mm5MOWNUQitXNmNKTitQQU1tbzEvdnBXUGV1UT0KPUdFU0wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004f0f9e0624e6b031--
