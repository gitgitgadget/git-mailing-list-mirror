Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FC2DC346
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013210; cv=none; b=Ii++iHid/b8LEIlJWeQcF9N6EKvkBcBncst3vDKRp5Q8pZIZdsYI56sqCgibJuVTR5AgrbOy+rf2dHdThJaaZeT0WRjmxD3t94Rk5ioqi7TL0IyEZyW4809YqM7EZVDRScTc4yCGBQHbEUFsUbNqk7t0yQAE+SbbT5z/9kYsybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013210; c=relaxed/simple;
	bh=fCAyShlZ53TMCbu+Xu47UyWDDSfv8CFdvgCr+A8Yv+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf3L+1f3bIcIi8ipVTtjANWO4StTBTyOJv73+j5xjqLSLAshRdkWfuqfhcKaUZBwpxL2dfiZdgTJwfrvZiQjzjYngwafZPPZ3c0i4OSFk+cKgXWg0ArqwcAnQtteSZPvPpYpK5qhkxrs3xq7jBjSQGdpRXlZa05/qP4JSdwAyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fck/eJ0L; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fck/eJ0L"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2e0513433bso147334166b.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760013207; x=1760618007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUCFgwF8gRgABUxCOb0ih+DrrtMS0xDA03PR0rtJhc8=;
        b=Fck/eJ0L6wUqfCj7XInU04nOyyitlzrglrqQltpLbT9B3SNDWOpkqNCrEFy0vdgudk
         J5LZBrHxCRB73sSg1tiGRHvGRVWrv68jtLvcuj3XxaRWt41FPt2PGha3QYfnJ8qR3e1V
         xFdyFe7wwmWp8kkhntpeV/gbsByYTj/CN4YVRCWtnZVMW2IFuW0r8go65rIufdUSueS9
         bROKAmEEJzsRy3iSbd2+EYXL6Z3/PIUmx7wzh37lJa0oaIQ9E3RLHENNIz+Nx/47AoMy
         8hmzet0fUG/2UhYok0EcVLqrGZrjdCkLS/6a8HSgOgIN7VpaCfRF72QLtydlhJl6fse2
         Yknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013207; x=1760618007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUCFgwF8gRgABUxCOb0ih+DrrtMS0xDA03PR0rtJhc8=;
        b=Tdr2YQM0tmWzg1cCbZeeSY5e8OD7kd7NOP4MkZKD7kI1Xm0H4FIiXLFy5B7vbCxexS
         S5Ina4JNYQxxwyWUnyoE8VeZAB5swcDorBGGlnSz3zTtJEfuN3Ig5eNZ6yNum/7W7jA8
         8t8q4W4+4VDFrjey+IsCb29j2EeRZ1on57DeKRahEWGeHfzImYMUtsLNfMkCN0ObzI3E
         ggzvhTrq4YWcl8Ll6SqlUDIRbUGZYpewaNtJp38/9eVLneikHVdi4oN1BpkFhGqGjMEj
         rboiuysq0pvPwSmJvE3FA0KCPsqTPR64w+MrXI7RuPr4ifurc5IiGQFaSY8EY78Xdw62
         UHHA==
X-Gm-Message-State: AOJu0Yxtrxn1YwDXXpEtWVFKcH7M/9EVPfMM/PpzAeEEIeO65lSbWrCp
	Aus6Y8yyC9N3ry8Rp/KPra7KHIgn7L/JaZiV5kmvrDMEesRX9jeDzQ2N4SlkQtsjMh8O3/FzHt7
	nfreLpRG27AaZhwmh4p3oymd72kWIaLg=
X-Gm-Gg: ASbGnct+49ebxk/MQRASVSsfVpEtZpDxSgzLT7H1ljUHYtpm/HfDahmScbGDho/quIb
	vFSNj7f5I/Te0vcu8FdLdYpk1nuxhjcplRXncoKXdWaSbzokCVt5WKhQtynPm1DOtFFa/NW3J4q
	r7Kyskeip19y+T8E5GV4TSAbV/ZXvg1rdn8QgCfS2ddl4+R9P783Oxt0NHsdNfIkwx0eSmzW/9G
	zvmU/c1FM+rzrs0ess3E5PKH0ds28v7HM4Q8LDR+A==
X-Google-Smtp-Source: AGHT+IFxwQRORFl//WRrN7vknAAXDiy7U7tc+F+moppS5FsYchDacUbmX5LL8psLuaVP+kF/1fo/BcnSad0yXo5vwjg=
X-Received: by 2002:a17:907:c12:b0:b44:f9fe:913a with SMTP id
 a640c23a62f3a-b50acb0e584mr708970366b.65.1760013207181; Thu, 09 Oct 2025
 05:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-5-christian.couder@gmail.com> <aOYPWvdE4VnL8T7z@pks.im>
In-Reply-To: <aOYPWvdE4VnL8T7z@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 9 Oct 2025 14:33:15 +0200
X-Gm-Features: AS18NWBA1eqpojOjxl645niuVCTPd2qIAog_eEhVN9nmmA4b37o_MkkXf1kLP40
Message-ID: <CAP8UFD2g1usFU3fhV-8bdr8CCiipSOw=XuYGHrx3N8MUkVXjDQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] fast-export: handle all kinds of tag signatures
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 11:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> > diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> > index 21ff26939c..5a46608f65 100755
> > --- a/t/t9350-fast-export.sh
> > +++ b/t/t9350-fast-export.sh
> > @@ -279,6 +279,54 @@ test_expect_success 'signed-tags=3Dwarn-strip' '
> >       test -s err
> >  '
> >
> > +test_expect_success GPGSM 'setup X.509 signed tag' '
> > +
> > +     test_config gpg.format x509 &&
> > +     test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> > +
> > +     git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD=
) &&
> > +     ANNOTATED_TAG_COUNT=3D$((ANNOTATED_TAG_COUNT + 1))
> > +
> > +'
>
> Nit for this test and all of the below ones: our modern style does not
> have empty lines at the beginning and end of a test case.

Thanks. I think I have addressed all your comments like this one in
the v2 I just sent.
