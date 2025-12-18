Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8AA1F09A8
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766029430; cv=none; b=gepWbRa/MVLP1XruvIRb5k0P+dCnhOUeE73zfYgSAjSJnU4R9ZCS05lE5asKjc0hjAzvU56/D74h//LUcX3pdylg58fnPo1McIYV2TspA7b+GplsUxc2GM9zO+6fbe+kLhrmIVjnSBzDxv4yL86ryOA8gRnlUsr4D6O9Q+BLxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766029430; c=relaxed/simple;
	bh=9Gk8XcOc2B7lyw7zUSjJCEYyspZk+j8ZO9rTMz1FGNY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QlW2D8SrOc+MCpbDdEGWAHpqw+uriMLoliz2qjBJcpiRs6XvcyKAZFtUeGcNnoc1S+v7Ed6anDX6M2HTV8fP/QQfbXu/WV6RpCVPQzFBi8pwB65Bq0LP9x7A3pWYs5hVS2bKQDKh9t+rvG0RknGn25XwDhZjG2kox+jRxYd5x9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtrW/qr7; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtrW/qr7"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-644795bf5feso186541d50.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 19:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766029427; x=1766634227; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lek4t3gXzPVk+KIdfZq1qSHgbD9dOXit/2yuojU4a4s=;
        b=VtrW/qr7wIYD/lF6XfTbnDEIhDZ4qnDG6Jhs17gHV8+oTIHWpTf81jDfAA06QOLcHj
         wfSCFmg1e7fTtMWSnd2rDEmOcUuTf7Z1X21a40v8oSgIM7qnjjAf+g3XyMe5yWvsEj6F
         W5J8ksqadAUsHQyYXOUld2UExD/F8jbPdvT7Yyh21C49LWfCYntrePk2ZrkOTeU7rjmf
         IcywUN5I3JFBqIMNaYqtTFWWoaznNdzddwHY+nDHhHh5LZWAM/tmlgs1M3hWdWuUen6F
         oGXUSlOIJXyO23N6IzQpAPQxkpX8Tf/RH4HqRjYynQPi6Tt/By1aJ6T1dJxPg8Ay8ZDl
         Q2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766029427; x=1766634227;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lek4t3gXzPVk+KIdfZq1qSHgbD9dOXit/2yuojU4a4s=;
        b=EanFwijxbEwbEDLniBlf3TS4m88dwbqAFsFeEqaLMsKOMFpR9aG0sOJ2IqKZbl0ET4
         W6/mFEr6Gsii1vafN7AyikZEknFNyfhxxLRijSMs+LbCR1zx43SQlZB6gctR8pQZMk9W
         UiuEkPbeQoL+FkBJ2YnpYXyu+zAG0hmEgrE9dxV/2fym9TetTyttrmTS2wO8xSNEM9rI
         pznpfoHLvVuU4Oj0AYMgP7gp2VayfMEVHApO0V1Gh+u6ojPZ+FhkZiBFeDPuvffzd9Wf
         datplLW/iWfghi/aAZDsxfZxw0b+3xzAj+bRzY7pXrpy0S8w1fH2z2GLd4/+1J5O4Qxy
         emWQ==
X-Gm-Message-State: AOJu0YzcR8Wue7nrLdFi7CD55nyqZPnxvfDEfl3uCHq3BVcAdjFMbO2s
	k94jE22Qa8duSk9iQMVUS+BslTIpplskRcgveDGU7oPWbouqoCi23pMT
X-Gm-Gg: AY/fxX5CUxIsMp7UOC9FytZYz6e3OmxieKe2616WAjhWSMvYFekWRvWd0cI2zQQEtJh
	qUNWGyRbY2ZQ+/hVhZrYI1Q/4+TKSRWVwEgcNmRGd6g9Skq5sP8HIY+y/2ySFw88TV0N8EyoyG+
	0HkDIDnm+q0pwHOU7YbGdWnXpguNAjXerNctzW9gJ/0g8VU32lJ5cNSz5064YUHXDoMSXW7WiXI
	6QVU9BKGcOuxGuk5xU662nUKDCzLl4NBJuAc/Jo4DtksIqjCgrjd5ky7adgLX6oMAUtGDxbJNqR
	5cphBj+gv/t9RONvhEIdMG5MbLcYtcM9FHc/KiJCL/aINeDRpBe6dwZMIm24M5QFAah3EPuR7qz
	FXjzbXPJX+Mvic4IBhlgmJ09HvwYczZ/X3ZEZnIe9Zqe3JyYFvLDLJIdXYrRIWdANE1QbZ2xKGH
	mMGBGsDXjKfgrV8a5ZAnSg4dMxGXIog0IvdEkkMQIBNR4Jcb54bw==
X-Google-Smtp-Source: AGHT+IHei6GtOBp/R/Um8T//B8bB4HzN3ZsihoJnlEv8sUwhCpJbz+G3rYHe4bhWTcRwAkHn8B2BVw==
X-Received: by 2002:a05:690e:11c6:b0:641:ffaa:4eda with SMTP id 956f58d0204a3-645556634f3mr16523070d50.74.1766029427244;
        Wed, 17 Dec 2025 19:43:47 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5982:24ab:62e1:eea6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-646636e86ccsm566713d50.5.2025.12.17.19.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:43:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 00/10] Add submodulePathConfig extension and gitdir encoding
Date: Wed, 17 Dec 2025 22:43:36 -0500
Message-Id: <351D4D02-AF90-4209-85D6-6C3C80C99C8A@gmail.com>
References: <87pl8flnef.fsf@gentoo.mail-host-address-is-not-set>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>,
 Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87pl8flnef.fsf@gentoo.mail-host-address-is-not-set>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
X-Mailer: iPhone Mail (21F90)


> Le 15 d=C3=A9c. 2025 =C3=A0 11:29, Adrian Ratiu <adrian.ratiu@collabora.co=
m> a =C3=A9crit :
>=20
> =EF=BB=BFOn Sat, 13 Dec 2025, Ben Knoble <ben.knoble@gmail.com> wrote:
>>>> Le 13 d=C3=A9c. 2025 =C3=A0 03:09, Adrian Ratiu <adrian.ratiu@collabora=
.com> a =C3=A9crit :
>>>=20
>>> =EF=BB=BFHello everyone,
>>>=20
>>> For those new to the series, we're implementing a submodule gitdir
>>> extension which allows us to have a unified way to determine gitdirs
>>> and do things like encode submodule paths to avoid FS conflicts.
>>=20
>> Hi there, I admit I haven=E2=80=99t followed this series closely. I use s=
ubmodules quite a bit but haven=E2=80=99t yet peered into the depths of the i=
mplementation.
>>=20
>> I read over the documentation changes in this series, and it=E2=80=99s no=
t clear to me how or why I would use this new feature (I don=E2=80=99t mean t=
here=E2=80=99s no benefit! Just that I=E2=80=99m having a hard time parsing i=
t out.). By =E2=80=9Chow=E2=80=9D I mean: I can see how to set config and ru=
n the migrator; what does that unlock for me to now go and do?
>>=20
>> Does one of the previous cover letters explain how this is useful to subm=
odule users? If so which, and perhaps the docs could also contain a =E2=80=9C=
here=E2=80=99s when/why you might want this extension enabled and what it al=
lows you to do=E2=80=9D?
>>=20
>> Or maybe this is meant to be not too user-facing, in which case I=E2=80=99=
m curious who would turn this on and why still :)
>>=20
>> Again, I am mostly curious, so please don=E2=80=99t read this as an attem=
pt to hold the series hostage! :)
>=20
> It's perfectly ok to ask, no problem. :)
>=20
> This series is for the minority of users who either:
>=20
> 1. Encounter errors like the following in submodule.c:
>   die(_("refusing to create/use '%s' in another submodule's "...)
>=20
>   These errors can happen due to a number of factors, like
>   case-insensitive filesystems or submodule layouts.
>=20
> 2. Need to specify non-standard gitdir repository paths, different from
>   the currently hardcoded .git/modules/<plain-name> location.
>=20
>   With this series, the gitdir config becomes the unified way to
>   set/get the gitdir paths, so you can move them around as needed.
>   It also helps other git implementations who don't need to exactly
>   match git's behaviour: the config becomes the standard interface.
>=20
> If you are not in one of the two above cases, then there is no reason to
> enable this and it won't affect you.
>=20
> Hope this is clear, maybe we could spell it out better in the
> documentation (suggestions welcome btw) or even tell users in the error
> messages to enable this extension.

Thanks! That helped, and I am not in either case ;) I agree with Junio=E2=80=
=99s downthread points about docs.=
