Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01211DED40
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456862; cv=none; b=SxldBdaixKOLzne6r98eqtNu0m5Wuje8Cbjc1/CgT4289+Hohrf/frh9nAvklwy8sXVBFrrlkbkMvJe0QBcNrfX9mDAuClE2cK331uCjB2bB05U9Nim8jV0wLZ/gDEJfVVJoMCO2FvRYRZL/nfOsk3kb0ycKkpisnXuKOH18sIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456862; c=relaxed/simple;
	bh=P+jMESMvN1H2rRZj2TqQsIB2jFO/ecC+EDyvBy2K+yU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XqYfcbgo8Y/d8zEPi4vL97eZYYlUu5RPJm6hhqVSzkETBjfB4xBoqIIlaAoQpqHfWLqvxpXdYlKIYPkTX0qDVdVpCyhu/3KpgUOpOMhNGFa+V4YbvBjr+9evncvAf4Y77a1SoGNkoVhF6aV5RTFEESEvHrj1uA/O2cTj1NKLtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC/YtVzs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC/YtVzs"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so4006785ad.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456860; x=1786061660; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nb0PY7gkexKptHqgWd9vaMJWuWXivl68du3MLdzhg7c=;
        b=ZC/YtVzs9wgVRzxbWYJ4CIHyc4BLpjnKG3ohP++CJjb/bZqbYVxWKGPAFVJAT9Qxx7
         1Ci4ydi2ljzcdkl8y7tdvjEakAh2AL3jKbOk5MpIA8C8E6+pkv4hnZ+xrzQP3t6PekKo
         tASlZSeiuM+8oJTXgVbV2O1p31H3t8Hj+ezCmkIaiAU4EGgNfT18dz52THoI+CQAmdPf
         XhaajY0mam5s2O7f6PiriRUiZqHFtcadYloZwBbEgJG0BDRuzBitQbAj6UhUEPjEAVUy
         DpLvg9cICLLlJJcs1JgYSoGoZgqDWymjHRUK6USOxL4KRTg5FGgUTz4HCJtlYsDsRsdi
         oRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456860; x=1786061660;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nb0PY7gkexKptHqgWd9vaMJWuWXivl68du3MLdzhg7c=;
        b=g0Doj3qcLRnMkHO3UqRXAQrFLOsDUBlgUTfRqOPnhyDGGQXkED5fYl/OoyqGG48BKH
         bZFo9hNJffD/HeMKQuFC9HhKK1ToqaLUntQATk4sNvpIJYVLE1yVl99TLu6hXs9Vd+M+
         yhEZV0oN94UEyJDz6xZfk73vXOUZDSTvzw89GH+dG4ye6O44ZAzJSFk9r0k+ZdCLjx3q
         tumEBA8dajhusmVDiBRyXx88enKEIknebQnsf+ICNSlB/O0deQbaa5iVHCvb2qczfIET
         gbKL4U2qsINpZjbj51x928i1rhUZb5kr4m8HEqpsVd71AEB42pPNKEr4auJKUIUXoM/1
         fciQ==
X-Forwarded-Encrypted: i=1; AHgh+Row0J+ycyqn/kfy8gQJyCBlqhaTANlw92wRibi3A7ZTGzPjqLFQR5uoUfpiv8vsoFT82Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIQ/HncTVbXME8oNPPqruFztmf/uCN09izdDKASB0U0GvlQER
	tYOtTnamsf+35Gg6xMYJOKc6triy10uCq6QZ5xWhY/lNOlDPz04dch/DQfqS19rb
X-Gm-Gg: AR+sD11gFh+gM+NOmYiLxdAWylQqIgEQ8CvXphYgQwYxMzy7xUnz3gwGBAPvzpapuSj
	YzT8del34BGXXgUDTw4cNkgPM1Qpy+u1/eJH+5k3Y+DVNDJEWuaic9YaKs8IL7Y3bexEq5y2IKM
	oJnAA59iG4NAYrwCH7jEBGK9AVy1m9GNj6ssIR7MUcH4/s0LC6TsuE/tiI8ycpUF3S9KQO7ozK4
	JQHJ1d/TeyH7I5fCboy9uXEt3eEaPqxwqhFgGEm3Zits/DC2qNsbGYyh/X8aFZexYBRImTWKydT
	YXx8o9Rswd25pEcsOsG5VRzVafgsNhYitWV9iT9+qcNdcGT22qpxB4mf4Ci4IcedZaKeU0vxLou
	FN5QyzVzTa4ROpo7oyGbcaavS0abiaFXhzPmKjA41N8Rr5UzwrPUjJj04OARx7lxwuGh8R0IuLV
	ExacJCv+ycLrD6vI3vvlEYB6+RUgPXwEbtxJwl6UEN/rdio1guwOQTGZuzpGGAcjGCUXOSGz4bG
	n2xwMut9BC9YrGglMZ64LEjFlmjr5lboGt0uXpna1aFGH5MXe7/jbus24sgn5HOpFJMO7OtKqId
	VwQ+KDT6x8jTXbrcUhUVKru0oCSKRSqMGsYmCorRMA==
X-Received: by 2002:a17:903:3c44:b0:2c9:f44e:9942 with SMTP id d9443c01a7336-2d046d90ed7mr693605ad.13.1785456860046;
        Thu, 30 Jul 2026 17:14:20 -0700 (PDT)
Received: from smtpclient.apple ([114.202.151.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c2e5b2sm32901665ad.74.2026.07.30.17.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 17:14:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] git config --global: doc and behaviour disagree when ~/.gitconfig and XDG config file coexist
Date: Fri, 31 Jul 2026 09:14:07 +0900
Message-Id: <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>
References: <xmqqo6fojkds.fsf@gitster.g>
Cc: Nils Fahldieck <nils@fahldieck.de>, git@vger.kernel.org
In-Reply-To: <xmqqo6fojkds.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 31 juil. 2026 =C3=A0 05:35, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFNils Fahldieck <nils@fahldieck.de> writes:
>=20
>> 1. The writing claim is inaccurate.
>>=20
>>   The docs say XDG is used when ~/.gitconfig "doesn't exist".  The
>>   code tests READABILITY (R_OK), not existence.  A zero-byte file
>>   created by "touch ~/.gitconfig" is readable, so access_or_warn
>>   returns 0 (success), the condition is false, and XDG is silently
>>   ignored even though ~/.gitconfig is empty.
>>=20
>>   The condition should be described as "when ~/.gitconfig is not
>>   readable", not "when it doesn't exist".
>=20
> I do not understand this part.  If you have a file that is not even
> readable by you, it is not very useful and no better than the case
> the file did not exist.  Also, if the file exists and readable,
> between a 0-byte and one liner ~/.gitconfig there shouldn't be any
> difference in behaviour, no?
>=20
> So, "when the file does not exist or even if the file exists is not
> readble, then it is not used and the other file is used instead"
> would probably be technically more correct, but I am not sure if
> such a change has much value (unless you are trying to be very
> pedantic).

My thoughts as well. A readable 0-byte file is not a counterexample to the d=
ocs; if such a file is readable then it exists, and is used as documented, n=
o?

>> 2. The reading claim is outright wrong.
>>=20
>>   The docs say --global reads from BOTH files.  The code reads from
>>   ONE.  git_global_config() selects a winner and frees the other
>>   path.  There is no code path under --global that reads both files.
>=20
> The documentation needs to be corrected, I think.

Agreed based on recent thread <20260720113402.0dc16abe@frustcomp.hnjs.home.a=
rpa> (subject =C2=AB git config: unintuitive behavior with - -global and - -=
no-includes =C2=BB in case I have mis-transcribed the message ID, a necessit=
y to maintain plain-text mail from my mobile phone, ahem).

Best,
Ben

