Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439D10E8
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEpBunj9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so5518943e87.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704939701; x=1705544501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a24TbCFKSEXOjZ96uBlLSvtPm/U4fikg3dmlOx1jtPk=;
        b=AEpBunj9WQ5AKHvKhTufJXoZLf6XLtzmPCdqNV+eJwT0S4ybRdCE/aqxxtDaf5KYzu
         it9Hcy7iFcsOMvPH9dVMzntN/wziZ/IkCyV/HnFLJwxNf169C+x6aYXEb2hN+vdXa9E6
         0eC5lI7XkZon2ih4wJsyfbbkTnTVVTvxECG2PYlojcT/ml+mU16zNPwooi/FHWQG6nud
         5VltNTNLtE4n95CcVPZN9ZC5uu7KN/j+8o2TluG7JRUrRiEKNnCwa0KjAxZZqyuLniww
         Y041/E27RDqI4bvVzGCUEs0fKe3wBhUOwFyUfWxnfd6XT1MpXv8kKkQXZxED+AiioaOJ
         aDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704939701; x=1705544501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a24TbCFKSEXOjZ96uBlLSvtPm/U4fikg3dmlOx1jtPk=;
        b=EoXVx/runyZN1MlbGn4O5Eo1bhrTlD1iMDNhrQHBjYjysCd0OOXC2lEQ1N6dugR6rC
         kzWTIe3wEmT6utdWlN4eMul1ulyaIYIo1wJ42qKHxtUFiysFqhMhWVjTIYi/V4nfhygN
         atBpvdoFJC/RG8DR8TNu+2bFLzcQQpiYab8fz1b7v6rP9r8LhiZosAkY9WjoqzPyRhNL
         t1ie3IcjD8N4QGolqYhLQD1auafE9M76PDE/aZRg44h0r59Ogaqu2C0LQ6MoxVQSXHmE
         C0fy9MscLqXmw1s7bxTOuh0mgB9JpJp24n579nXXAll9Y0B3BreK+NdUq41nSH1g/VoV
         9fSg==
X-Gm-Message-State: AOJu0YyWa7HrhFJMX7Byst+w3pWD8glYjoqVPo/GfvI1HWkI10jy/PXK
	qGVe30MmbcjnUEjf7jKsaeOab9bg+gePcLRSjZQ=
X-Google-Smtp-Source: AGHT+IEk5QIt8FRdTFPDIojsd2JZl/MUQcCpviPahPprCfLnv8bhnMb7Q8SArYBMZrDRw74BetGYsdUvKF71ldKqtWo=
X-Received: by 2002:a19:6454:0:b0:50e:d1f9:ebe0 with SMTP id
 b20-20020a196454000000b0050ed1f9ebe0mr75915lfj.2.1704939700741; Wed, 10 Jan
 2024 18:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com>
 <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com> <008701da442f$b2dfe420$189fac60$@nexbridge.com>
In-Reply-To: <008701da442f$b2dfe420$189fac60$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Jan 2024 18:21:28 -0800
Message-ID: <CABPp-BHx=4HPSN4enkHTL7PPnNBsJ1vGWe4Em5imH7HcOcH2PA@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: rsbecker@nexbridge.com
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 5:44=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Wednesday, January 10, 2024 7:59 PM, Elijah Newren wrote:
[...]
> >Would you be okay with the following alternative: requiring that all Rus=
t code be
> >optional for now?
> >
> >(In other words, allow you to build with USE_RUST=3D0, or something like=
 that.  And
> >then we have both a Rust and a C implementation of anything that is requ=
ired for
> >backward compatibility, while any new Rust-only stuff would not be inclu=
ded in
> >your build.)
>
> To address the immediate above, I assume this means that platform maintai=
ners will be responsible for developing non-portable implementations that d=
uplicate Rust functionality

This doesn't at all sound like what I thought I said.  The whole
proposal was so that folks like NonStop could continue using Git with
no more work than setting USE_RUST=3D0 at build time.

Why do you feel you'd need to duplicate any functionality?
