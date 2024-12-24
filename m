Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D4190072
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033172; cv=none; b=H7ovedu5QKxJtVvvDnOAwYZuWyUaxSUP4tXqaY078J2r0U+g3ud0V/EDWWAVilin9/P1vnv/GZMJWv2qwKSvgGdyY8E8MHGynUdTkG+IeON2SdQcsD4qjuAGFNjI5jkAMrtyGPzI44D70NoxcwpsB2TxGuVv+5CtLbOSsXqNojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033172; c=relaxed/simple;
	bh=zFdHoYSNyOpHrLgk6z+uKWbhdVx1lyxw7vpm40XguTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKEmdKKshzizvMCU1eZDH67otrrMzh4EbKnooF/ertk1mFbN9lr9ISp7xnoGEjfwM+XPvaEYoxbBxCXCEvYzz+Tw+GZTDv+pNEHR8eH/f9huqMJL/5eUmlSj2hnbWFTq+zkcJCpW6rz4luiDYSP6e9D3t/kXDoC5I40sc9a+HyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=Qsq0e1cV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="Qsq0e1cV"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-300392cc4caso55350301fa.3
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735033168; x=1735637968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7ITtPIaq7j75+lCZ9nualmsCjd+cTdruCySte5NhiI=;
        b=Qsq0e1cVRaERSVvX0/2X9TG3xKgpK0FwoeHnqEv0qR8n7n2TdPja6s8hUO2lb7kztI
         y7cvOYorBNZU1ccYfpUz+5aXcDy2lsX6zql2AuBbbh/3Btp4AMOElf/9GceEusR6yY7d
         do0s3OvqlXjTO2iwU03U9os/1vz+ITS6yXUMIMGrRFeQTXPewIbh9iR70tSz6LgA0kuy
         bfjBSqJWh1iJ3OfQl8cmJlqYEKDDPwWpUSEweSiXl1sRrdyrLGtf9Ot1zcFI54xHG+V/
         Lw8AIYVxPOUNqKN24/Qd+xwm+ly+BU0XTW3JSf6CAFSmGUgCU9asdcPtiL1IwgAApyU0
         cZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735033168; x=1735637968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7ITtPIaq7j75+lCZ9nualmsCjd+cTdruCySte5NhiI=;
        b=C+MCWmG3w3GdKfFlCOOTgHicZOcMbmtG/lVxZVZWPoqGIl5deges+738BgMKDS6Gzr
         a9r6lN2jqMEDeRLejRVuEFsdwWnyy+cYqFypi/EUC7IwIil3mfwl0gsP7hWtm0B0Z44t
         4vCWMIDs1kRYwndQ5k2aZhVF9OUKH5bjSuf7D2LeBuZKyuDF6mB/N5PrMQ5X1pKUp3Ri
         gIafQvDArxWwWhFfIH76QZBIRIGltEXYCOHMBfjt+WXrWZd2Rec5bmyfyz2aClTdTASu
         65EwZEZC234SPxGOnACgzwqWfjsKUWfnb6HRVYqj1KaxW0OnUTosbEyX1t2kDHUlgJb1
         pw/Q==
X-Gm-Message-State: AOJu0YwFmdAnAhtLJaT/xb19TV4UuoAxW/tuT9C+w2f5fmipykc8OEWl
	ZybrquK/h0aJkpTesuhpvYZ5JyVfXW6AusNtZIdLf8JxxpVz7WbIVESxyifmyxD+AHy3imWf9zO
	domVYXavJt8K57lr7sSd/mX1M5M6IiJcVQUOROQ==
X-Gm-Gg: ASbGncsQICXRJrb7AeZcjkzKuJILBhnxJD+Uemx/bH20l5oQqrnPrQcfYXwgsSadf0E
	rKBBrmQzBYQxZCgs4/q4BFz8j9iqQT5S4DVDVZH2x
X-Google-Smtp-Source: AGHT+IE7L3VPTG/R915AeMJQkjQ4os/JD7/3IHsNJmqmlGYpcPpVjqIqOTu5Ff4oJwxZQegptbom04My8+1QYMbwM4M=
X-Received: by 2002:a05:651c:1506:b0:2fb:5035:a03 with SMTP id
 38308e7fff4ca-304685344a4mr47705601fa.14.1735033168372; Tue, 24 Dec 2024
 01:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223133918.25133-3-ash@kambanaria.org> <20241223133918.25133-4-ash@kambanaria.org>
 <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
In-Reply-To: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
From: Alexander Shopov <ash@kambanaria.org>
Date: Tue, 24 Dec 2024 10:39:17 +0100
Message-ID: <CAP6f5MmUW0=QYzHfLR2ObKFg7kLuTJO=7C8o1Kr+=cb-RLcnFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] gitk: Update Bulgarian translation (323t)
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com, 
	paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Johannes Sixt
> What am I expected to do so that you can make translations of the current=
 state?
I mostly need the proper origin and branch to sync with. In my case I
synced with
master of git://ozlabs.org/~paulus/gitk

I now see that you have published https://github.com/j6t/gitk so I
will sync with its master
and resubmit the patch.

@Junio C Hamano
As gitk/git-gui have new homes - can the README point to them?
Kind regards:
al_shopov


=D0=9D=D0=B0 =D0=BF=D0=BD, 23.12.2024=E2=80=AF=D0=B3. =D0=B2 18:31 Johannes=
 Sixt <j6t@kdbg.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
>
> Am 23.12.24 um 14:39 schrieb Alexander Shopov:
> > Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> > ---
> >  po/bg.po | 696 ++++++++++++++++++++++++++++---------------------------
> >  1 file changed, 360 insertions(+), 336 deletions(-)
>
> > -#: gitk:2203 gitk:8681
> > +#: gitk:2206 gitk:8739
> >  msgid "SHA1 ID:"
> >  msgstr "SHA1:"
>
> > -#: gitk:8700
> > +#: gitk:8758
> >  #, tcl-format
> >  msgid "Short SHA1 id %s is ambiguous"
> >  msgstr "=D0=A1=D1=8A=D0=BA=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=B0=D1=82=
=D0=B0 =D1=81=D1=83=D0=BC=D0=B0 =D0=BF=D0=BE SHA1 %s =D0=BD=D0=B5 =D0=B5 =
=D0=B5=D0=B4=D0=BD=D0=BE=D0=B7=D0=BD=D0=B0=D1=87=D0=BD=D0=B0"
>
> > -#: gitk:8717
> > +#: gitk:8775
> >  #, tcl-format
> >  msgid "SHA1 id %s is not known"
> >  msgstr "=D0=9D=D0=B5=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D0=B0 =D1=81=
=D1=83=D0=BC=D0=B0 =D0=BF=D0=BE SHA1 %s"
>
> > -#: gitk:11508
> > +#: gitk:11571
> >  msgid "Auto-select SHA1 (length)"
> >  msgstr "=D0=90=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=BD=
=D0=BE =D0=B8=D0=B7=D0=B1=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 SHA1 (=
=D0=B4=D1=8A=D0=BB=D0=B6=D0=B8=D0=BD=D0=B0)"
>
> These strings are no longer in the code: "SHA1" has been replaced by
> "commit ID".
>
> I am unfamiliar with the translation workflow. What am I expected to do
> so that you can make translations of the current state?
>
> -- Hannes
>
