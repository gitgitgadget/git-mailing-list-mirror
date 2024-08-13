Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428B19AD86
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553785; cv=none; b=FZ7/tS1CKjWXHX5C+wVALgkqJCeuAhM90tnDhr++fmCmCuSq/3JI7CxU4DIj0prJXczQFSB0GY1UG7yFmXP2dT+z0GmboZf8qncYvttah9DbSksZ/EnAaLSWMXz1gqvFsE+dZY3Z8uUSJ4EUzptPdqV39wazcbxXqjDqGoHNhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553785; c=relaxed/simple;
	bh=oSLIotrkB/8mrv18DVkxbxn1JibIfyWjQVAI0fCGGg0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlDkk0qga6PPLfj/VmITehFyZQsaPzIMv1dtxb12+0DndhKi9tI+o7Uu7LFwPsujTmBGzrrsGI1BQ0/cDCbkDHN9PjJ006yLoH9QVO7Vxn8RucU3T1C7yh0H4JwdNoWi79ykWyPSFxwfjczSYYFff9+6yLWy7gGlR5lUYRgFDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUJoldNf; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUJoldNf"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d59e491fefso2640874eaf.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723553783; x=1724158583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSLIotrkB/8mrv18DVkxbxn1JibIfyWjQVAI0fCGGg0=;
        b=AUJoldNfcNhLll6FGiakLrICxdBR02WKK1T+QiHebEFXkFeQJFliibzz1piCN+W5ny
         IHY9V182rs3kKKgwbv6VrPDnuDtN9H7WsPpm5hxdPk5lb2fbgJAHFBouc+c0QyTrN5m6
         QWGRnTeSB9z0q5bn16M1fX8ypLLqnlIC+SPVJu28R4ZWxybzZ+ly2EdZn2IWznF1dW8W
         vZJ1oKWiR2XcHB4Tto9hMkMzkoSWf7LnK0Zz0Ke+2QygmVNzj6w8sQw68YsMjRMmBbuc
         VU3YRVfjGpPNpOklzdKOJ/v2FJTsjprCEQBVZVwYWpX0OawSPNs1xCh8+EXQCzU0sQCM
         MIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553783; x=1724158583;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSLIotrkB/8mrv18DVkxbxn1JibIfyWjQVAI0fCGGg0=;
        b=uid5dS49hzikw7oMCUp9yKiGRIzNfxf7ekvJxNR/MWZ6MgZ6xuihHd0lNn7VPIMUC0
         max/VvrWVRoTGT7S4VFkenDCjmb/nFYmB3ayka4i9qziupEef40YrTmSFf0a4FvtXWHP
         HE/MIbZCQvBTkOAeTW0uIsBWtQmjmdxzhPZhvN2ewnp70qznNpIt22mmKzfprO1ukKba
         +YUBy/ddSIZCiMujMnOrwJsVT2QwVBa6VDqIgfqqgguJQVXT8w7eW8rQItwuG56Dghqd
         4dq7zbKy59t5CgU14bO5u6QPPVX7876Q9ej5mHu6v3QsxmUZAaWTh9JX9OvDd7bOB0iQ
         YWmw==
X-Forwarded-Encrypted: i=1; AJvYcCUJTOJcMyzbH6EDUiGZf9LUsMDgW7/a0e0poPrxhOBuJC3uqdzklrHji/Ui2+pQb63KrdrDC1n5+PprWEesrQ+AXhd2
X-Gm-Message-State: AOJu0YyxJgCSjEMVAHw7pDpQ7/IYk6JKSyMrFHAX1+4Gv206VwDpRQhq
	38AWFJTZ5Zl4CQNOz7H1yjASzYW1O3YD2TqXucK1MEeJoeR8Y//5i4wMg6mF1XgMs3iAqPiITDG
	ptXNaeoYF+P/TsJi/ZgctlivZm/Xa8g==
X-Google-Smtp-Source: AGHT+IGcLCG1PCp1H0x9NvyMTUZ8sHDTBkHFfZDa1Nt9g/tHa7/d2RyXosce8WlCBbaGN7t+2/+dAtvAu58Zy8ZBhS4=
X-Received: by 2002:a05:6820:221e:b0:5c4:57d:691e with SMTP id
 006d021491bc7-5da687f25edmr3748419eaf.2.1723553781824; Tue, 13 Aug 2024
 05:56:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Aug 2024 07:56:20 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>
References: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 07:56:20 -0500
Message-ID: <CAOLa=ZTCpetjY=kU9eQxq-LXkxe==Yr=rsNQRmPLHLPsnO5KEg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BNewcomer=5D_Introducing_myself_and_expressing_int?=
	=?UTF-8?Q?erest_in_=60Implement_support_for_reftables_in_=E2=80=9Cdumb=E2=80=9D_HTTP?=
	=?UTF-8?Q?_transport=60_project?=
To: AbdAlRahman Gad <abdobngad@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000eaf997061f902259"

--000000000000eaf997061f902259
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AbdAlRahman Gad <abdobngad@gmail.com> writes:

Hello,

> Hi,
>
> My name is AbdAlRahman, I'm a senior computer science student.
> I'm interested in working on the `Implement support for reftables in
> =E2=80=9Cdumb=E2=80=9D HTTP transport` project with the help of a mentor,=
 I'm aware that
> the project is not being worked on in GSOC but I was wondering if the
> project is still not taken in general, and whether I can work on it
> outside of GSOC?
>

I think Patrick already responded. Just adding my response too. This was
my first time mentoring and as such, I'll probably stick to the GSoC
schedule as that helps me plan out my time better.

If you do pickup the project sooner, I'd be happy to review the patches
as I can but cannot promise the dedication that having a mentor would
provide.

Wishing you the best :)

--000000000000eaf997061f902259
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1fe9b6940ded7a48_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hN1YvTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXVBQy85TDA2amxSUTBtbVV4VkE2VXNkZlZ4bnpYcQpiei9wRG9FL2xW
RXJJZVJjQnluZ1Blamg4bitIWFQrSE9HUGRIM3o0blgzaDdQQWpoT0p6ZllMSmxiYTJrR0F6ClZy
VFFjMHhTd0FMT1pNSjAzUU1vdGVaMHVTSWpUZExqcTQ1Y09mc3hNZi9lNDFQYlRpdTc0eGt5cFNL
d2FHWUgKbGRKVXI4VTRaOE04NzhVaVVHY1lHNGVKazR3cEduK3VTTFN6ak5LTGt2cFY0UFJ4QXc1
VFVRUzd5RkNzS1ZhZAprZk5xMzBpdFBqVXp5NEw1a0dUbEJFQk9EZXkxSFFNcm54L3JLaGN2S2Jz
cXMvZXA1L1AxQUtiamhVVTRhK3ExClM2cE5kK1Ywa3YzYmRUY1FVZStFWXFlcnFadDZpSGdlUCtD
RDlnWVREcnV4T0RZem1JYkpham5XL0krOW96OE8KWjd3aFgzVzNzdGtRQ2h2ZUowVWpodXUxcGZm
V1NaSm1BQnNITWY1YnpEYldXKzVHLzArOTY2cUdnTklOMEZZTwo0Z2l4c2E5MHBuRnZ1ZFo5bFZh
VkRKNW1MS25NaEJnNi9vKzBQRVpTeEptK0ZOcUg4L1pMb0ptMFZGbFlhQnR6Ci9oY0lCQlppMVEr
cER6R0JJMGtpWUYxbkQwc1dtWkNJdGI3T3lqND0KPTFUUGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eaf997061f902259--
