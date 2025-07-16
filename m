Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3E265621
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630008; cv=none; b=A2+XlIJjBJzPe3bv7TaRjdE+pAEohilamBxn9d/e1MbwQbD2Ypu4uT8jn5nQW5bWsYxE/ppo+BI2VwHThohzMRKqRXV5WM3zmVSJjDp4k5xqPSPKhCt0SzT/Y4AcNwKYC63o6cWkO+D1xnSslf/bGLwpCpxKKuSXOcKZhltxC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630008; c=relaxed/simple;
	bh=Mxbkgf/ELOKNFHCsKo3ai4Awzl8JmiCgJvwM7U32QJE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i/hbp1AdnWMlvTpXZ+esFpYbZVazWXs00QHAVDt6svq++qCee6FhSeEo+9cowlf7ZA1VyFz2Rvn0Li7D31RGn0U5sX6SPhqqRO2fUkkfUrY0RmSPL6k0aodxxcrd7d1w/s1EWHICavQ5HhBuh+PYh71d84SG5jPvwlLoI95Cte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAgu8oNL; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAgu8oNL"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-234b9dfb842so54692225ad.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752630006; x=1753234806; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyTNq7CYrpcx1SiLuwcdq/JqdKx4jzLaOvGRDFimI7A=;
        b=SAgu8oNLWc21WONw/RKEopcEGVpMdWPmV/dmzal7Csr2eQHDLGCm/lGomSsXNhK965
         rUUw6LeczB5otawGHdbD4qTBwwtmBX0nig+f+gZKJ0aCj6PDE8Ij3U40+UfX8v9Ury+h
         aHKFmsOrD76D4T+2Ke7xygNvkg+1uxsucy2PPYhreB6YWFbVJ6EEdCnRtxgY/zkTQSI4
         P4AKS6Xk9GDbad2BE4JTWbEu9qlsIQWy9E59ZGRhVvtkW2Oi+QVYNFqdzikXGrF2BRhl
         +xMt3nWVnF8s0EWZDdnSDyceYcaQlBXFH2EBHWQXrnlYQjebcBpEo/7OgySfKswkzEOl
         nMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752630006; x=1753234806;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyTNq7CYrpcx1SiLuwcdq/JqdKx4jzLaOvGRDFimI7A=;
        b=WiD+laCGOt4SqYCuAXFQZ7KX1DpS6HuDOWyv+X5ELFON/LDos5KIUJg+gVDELglqow
         tYlEgbAglGwtLkmHxCMYo2JFFRWUopRYqPyfUHGAt0mcBMgx1drqUcsZYFMWMruBruwn
         YsaStspG6FexqL+D/PebdOK84nJst++GDxEOghEnWoZySnZ9bNRt56jeTkaf0K+WrTrd
         X6xgywjN8k/aHIh+sKsExcpfbdbCtOr/KTD3+/6qrCh7QVZ3CdELSgvMjihrZ+PGfHrw
         4Ow6gm20lAAhrkzCkgMg1y/Z0pRp0dP5zHUwvPONLmirntCUEgwVKt59B9xefTQIco9H
         V4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXA0LryNiPEuoCZ9is7fF/A9SuIC2qsRrkqG6R+nfD5YxNiq2E7dqqAe+TUQwB/K0zeWQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQ6dd6D+EkWvlKZ+4Gg+AbLWSCo7E+OoCbzk5b4qNeQQh81wC
	pOhLpA4q7COOxCcca3lIqfNDJveagO/gSOW666KjiP5EO4jWFPvALQ1Fx1rdgf9XHRM=
X-Gm-Gg: ASbGncsDvIgXnaLBFoOCR/EBDkLv6uGXWKJS0J+POez/odnPeJOk5x6h1dn6XfMvm48
	oWEBn/Zn28oMx0uQo8COQrHMUDLhgfl4fhvZmok85dx7YByA0pCaktAjhdrE7Vclv9EC0dcLvif
	IwMbZwRyYyk2Vu7zR8nwuY4gi0ujJlIvrGn74Jn/QnYttEJMM1nejBsm7LMo2jHyKySW7L1JcOU
	6jiA4V2XaW09dywPeX1OL7aapqHprLuMqMFjfs8G9g4q1xvDXIIAeDL561/HLBqpgYw8iBk6g5C
	KfNlzgChB0Wp39s8gc5UvggkzDjEy7XzzsH9XsPbJVvEdH4NAnEaROHyqt5oltc/TSf82wOlEZE
	tAbkFK8aV0pwCIOTV8Q4WSra8yu2U1PPT
X-Google-Smtp-Source: AGHT+IHk5VZLHPHCTG6pj2vFETIEhOcc8gpHEPMklDz62QpTuRXRFGgtLFI/ekAwo+gxonJbnvKU1g==
X-Received: by 2002:a17:902:e54a:b0:234:dd3f:80fd with SMTP id d9443c01a7336-23e2566af24mr15461655ad.2.1752630005833;
        Tue, 15 Jul 2025 18:40:05 -0700 (PDT)
Received: from smtpclient.apple ([188.253.126.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322da7sm114995955ad.96.2025.07.15.18.40.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jul 2025 18:40:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [BUG] git pull ignores pull.autostash=true configuration when
 used with --git-dir and --work-tree flags on a bare repository
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqa555gp1i.fsf@gitster.g>
Date: Wed, 16 Jul 2025 09:39:53 +0800
Cc: Bryan Lee <hi@looping.me>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AEC3113-D687-42E0-B6D0-DF62FA1A9A8B@gmail.com>
References: <010001980c90be66-2401a0b0-5c86-4135-90e2-c325852ef168-000000@email.amazonses.com>
 <1AD9A170-8E17-411D-A13B-EA7780CF4D39@gmail.com> <xmqqa555gp1i.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> Bryan Lee <hi@looping.me> wrote:
>>>=20
>>> Would it be worthwhile to:
>>> 1. Add a warning when users set non-existent configuration keys?
>>> 2. Or at least document common misconceptions like `pull.autostash` =
in
>>> the git-config man page?
>>=20
>> I think adding a subcommand like =E2=80=98git config verify=E2=80=99 =
might be a way to
>> solve this problem.
>=20
> Yes, but I do not know if it is feasible.
>=20
> There always are end-user or third-party defined keys that are not
> known to us, and we cannot tell if an unknown variable is such a
> end-user defined one or a typo of a known one.

For every git_xxx_config(), we could add a register function like
git_xxx_config_register(), which looks like:

  int git_xxx_config_register()
  {
    struct key_ent ent;

    register_bool_key("key1");
    register_int_key("key2=E2=80=9D);
    register_date_key("key3=E2=80=9D);

    ent.key =3D =E2=80=9Ckey4=E2=80=9D;
    ent.desp =3D =E2=80=9Ckey4_desp";
    ent.verify_fn =3D &verify_key4_value;
    register_key(ent);
  }


And then end-user could define their own register function as well
so that they could also use `git config verify` to verify their own =
config
<key, value>.

Or end-user could provide a .gitconfigspec and `git config verify` will
load .gitconfigspec to verify whether there exists some invalid config
<k, v> pair.

- Lidong=
