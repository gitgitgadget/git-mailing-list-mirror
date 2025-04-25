Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614F218EA7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619361; cv=none; b=Wq/AoC4QZabV4gdeL+v6AvlK3Ga7jJNT0rPE3tShvCDfrcqcC1W2GEPR6vGdCHgw3T/Y4dH6LaIGS7pf8O5NXnK/CIItwAHC88kRGhs4QeJrWNfK/6tA/jtNihrwkv8aUF0Ywvq4HvOe92zZi1O5E63PuaHXNc0aE2NMDXBTumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619361; c=relaxed/simple;
	bh=I0nIm78lYnY45U63d6ckoE/pCPoe8w36Dl495t308K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pepFP6s+UFJubLWQlt7snPrb5vm2QjGNF6IGeSgkaDIqjezv5hISgZSGcLKmR1WcE7qIVKsrWeN6HPDog9znmM5I4jPc2tZvThe5jlwc9jeMtcfYaeRyim1rmqm1dKFUS01KROCEjpfTs+EabOoX2AsRMv1A6eaFT32BMZQuuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpCCsQoH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpCCsQoH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f0ad744811so20499056d6.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745619359; x=1746224159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0nIm78lYnY45U63d6ckoE/pCPoe8w36Dl495t308K8=;
        b=VpCCsQoH1g3bqBsnEckTp2jNIyYj21bFraS2b/vclxyhkOzJJSrdXowR0wHDWlbpSs
         e7ONfEKteyhzQQAjDRiTpz6O9J+JoZXl+nCAzUabGuG7plRbY/N0M++YJwWvZmUQOHcx
         ftRFPAxbaLFUiLoQlGBXnAORtSajmpnrjHwCEDBUTT+qUOh0erq97u02RHTD8sCtvqjE
         ORH6yrOOerQ1LnhLo2fgHf+W+Qmu+hqibnI/eH8zYbcuPP1BM0xZzUSRGJqSZZQHaSCb
         18eVbnapHz1C5gc17oVheXH4J6E7lbr5sFaQt3I0Jj651jCZjKK8o3t8YXmySYkGz27r
         DNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745619359; x=1746224159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0nIm78lYnY45U63d6ckoE/pCPoe8w36Dl495t308K8=;
        b=NPJkRy4O6F4evjjZ6D7w+VHFqKzpybG8Pw80h1SB+1C95iX/6vFRrGDU7C6+YJF/2e
         0wlJALpx94r2jlre1O8sNVuOLIqeRpvpGHlucO5abjfkqUdBDllymOlxa0clIwlX2+G5
         kh/0V9kUdJqhhBObSe286/oEX9SOCxJv03dpBHAw42TxD+wruFOrreAhziQR5u9T0ypX
         0Kxl9HDzzYNlk+5OM24duLpfS6WmHyeVkKAJy08tIqfKgABWaK0JeAHJ/ubQBa4GT4fe
         AhycPpSH84ORPnXBHA+UX6ue/K/dGpgHdy8LYV07+9iOJDvkuSD/BuqogACE80E16SaT
         04vg==
X-Gm-Message-State: AOJu0YyMZCSQ6XwCjmy3MZCJuNmxfE0WJm9RUA5NuaMLFM5taqxB7TeG
	Y2cqw7NR16YHqrWI//w/s1DZBhOXz2OJ/oGsap78H7ZF5NBinToBQxoiq1BXoZZnCRkG1YKCvM5
	sWr9esKNzi0KO/A2Nj0KtqvpBb7VXGQ==
X-Gm-Gg: ASbGncuXBhQcSpV5aGh/nKXl46fMuOYroRSppQtXdOHfAInzfX9bVV/xedKZNeFEPym
	3paRXTTBJJKh3/6n7namNsZMzqVesOIr/X79m+hbGxpX15uXtV4ivqCzimvaVxRuPFF7A4mWPOH
	lKqXUwbPSrLc7YRpbIol5H8Q==
X-Google-Smtp-Source: AGHT+IFGitQRTV7N31CTbQH0RsUIaSDIiu0HkJz6HR/+Mp54psrGZcdNaQX7kHQSxYgTLbyzNeRbKcLnsdU2BA86jJ4=
X-Received: by 2002:a05:6214:629:b0:6ed:1637:442d with SMTP id
 6a1803df08f44-6f4cb9be09dmr67888736d6.10.1745619358923; Fri, 25 Apr 2025
 15:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+7SsOdTiAocj7ZTV=OVw0tyKJxZ-H+m5S8soPfFy6zW=1ddzg@mail.gmail.com>
 <ceb84ea7-6359-63c4-e02b-418d9d313b06@gmx.de>
In-Reply-To: <ceb84ea7-6359-63c4-e02b-418d9d313b06@gmx.de>
From: Junio Luan Pereira <junioluanutfrma@gmail.com>
Date: Fri, 25 Apr 2025 19:15:47 -0300
X-Gm-Features: ATxdqUHehPlfWeFDQM9PEhlvy_42oXSIReTo4jS-s6axW2OJgE_s9d5AlcQs3bY
Message-ID: <CA+7SsOd9jtjQT+zg8XttA-bfONG2Jpkg4uBTTdys87e_jEX1pw@mail.gmail.com>
Subject: Re: Error on using git update-git-for-windows
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I discovered that the problem lies in the schannel feature of the curl
binary. More specifically, the problem is not in the curl itself, but
in the feature "Safe Web" from Norton Antivirus in my PC that, in some
way, blocks any attempt of curl to access sites with a public key
validated by "Let's Encrypt". Turning off the Safe Web makes
everything work properly.

I am no expert, but an AI I used suggested that replacing the curl
executable by one without the schannel feature would solve the
problem, but I was unable to do this.

Based on this, I believe this issue can be considered solved.

Sincerely

Em qui., 24 de abr. de 2025 =C3=A0s 10:05, Johannes Schindelin
<Johannes.Schindelin@gmx.de> escreveu:
>
> Hi Junio,
>
> On Wed, 9 Apr 2025, Junio Luan Pereira wrote:
>
> > I am using git-for-windows on a windows 11 laptop with the Brazilian
> > Portuguese language.
> >
> > Recently, an error occur every time I execute the git
> > update-git-for-windows in the following way:
> >
> > $ git update-git-for-windows
> > curl: (35) schannel: next InitializeSecurityContext failed:
> > CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - A fun=EF=BF=BD=EF=BF=BDo de =
revoga=EF=BF=BD=EF=BF=BDo n=EF=BF=BDo
> > p=EF=BF=BDde verificar a revoga=EF=BF=BD=EF=BF=BDo do certificado.
>
> This command is implemented as a Unix shell script:
>
> https://github.com/git-for-windows/build-extra/blob/HEAD/git-extra/git-up=
date-git-for-windows
>
> Could you edit (in elevated mode!) the file at
> `C:\Program Files\Git\mingw64\bin\git-update-git-for-windows` and add the
> `--ssl-revoke-best-effort` option (for a full explanation, see
> https://curl.se/docs/manpage.html#--ssl-revoke-best-effort) to the two
> `curl` invocations in that script, and then try it again?
>
> Thank you,
> Johannes
>
> >
> > Reinstalling completely the program apparently does not work.
> >
> > Is this some kind of bug on git-for-windows? Was it reported? Should
> > it be reported?
> >
> > PS: I have no knowledge of programming, developing or debugging git.
> > Ask me in case more information is needed.
> >
> > Sincerely
> >
> >
