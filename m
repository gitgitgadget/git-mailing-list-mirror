Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24138654E
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289199; cv=none; b=uE9U8RA+md0AEuOzTFndH0n0fox9KkN8kRRmZoBb9rKQXxMy3tA82GoaCaPMV9HFkW1B80KRMCz1cam8Pyjg18URnyeq7FY4vO4xqoSKksaWfKWabJ1lqnwLg8V3xDRZGzymd1vhfiLYY6V60fq1zrU10XxzGbhpbzWccoI6oN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289199; c=relaxed/simple;
	bh=aDr8oyns23cU0E3D6Ksaxd4C9alcudfw6aN3e0I/ivU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=A/0fXk0QIbrV4BzyKjFr84rJVbU8YUAdfeBmE6g+fvQ3EMKunvkrxBXxy+Ncs2HNxX7Yqcw4uxF3cJ94D2x61O1KuEVOjqR4UKSWKp7k5bsC7fkOpFiaPLrZ1fGtJrFgGUQ3/+TXNxT3XQ0urQ5YV3Mzm9gyrMlaIRjU3P79QXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBBE9LEL; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBBE9LEL"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ab3e26cceso71849957b3.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776289197; x=1776893997; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHpQ/fYwpnrHzEL1KH3xSZtzo4WKTbsSyhHqGmQIKzM=;
        b=fBBE9LELwYLS1/bNIdYDtptadYS0fTPGuTNsSSccaw1xHSipC2CEE1cJPpoe79fGKV
         f8Z8cDlNCbaISVErpXL8D40VlyJCzF+L4qdrdVBqJDpvmLhBt3Ezr9ZDP13v3rtWWYyt
         fe9ImOZE4FNybyKUr4FbyO1C8wQIVqfRD3+y668WaEWcSw5UuYEc9PMgin3Tcx+NuVLa
         +DHyUAuAlEuNvCNt6sbWqT+ewemt29nqV/zyDmoZFCrSmT0uJB27yGpjmVsV5IqAR6NS
         4A6Ahf5Ae8lMHDiKuxtsJJdB1IfYafi8klZ5whha6nnM44B9AJFCn5uxqSharr26HAh1
         joLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289197; x=1776893997;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHpQ/fYwpnrHzEL1KH3xSZtzo4WKTbsSyhHqGmQIKzM=;
        b=X4xd8ZXxRIHF3NRoOnfDwHcow4bAuoMkIPSaw485A88Q2OfQrnTqvSYNL9xc794iOg
         hiSs2mdEWIKjhMAEm4tr/O4oV48AN3H/9vZODGWvyc212yUeIClab/aBhCqPwZkdLFcY
         uUp0aY9GDM47MA/Poxhnbsqznj9WCP7zysJb7vn/Z+GP1Lz6m2bPL1tvQH2B84maBRHS
         Ir5v7yz9nI4IefMUjoUlu6oH0RAytyeE8zcmt+yeSIHQiE3w4YTGPT3/Yrl0FTKfIdNU
         KNk60hjnxyWOVMr6nEflCk3d3xIlIJhBr9WxTpu316o63UJnI9KcKTnpyyXxiPcKBIik
         ASNw==
X-Gm-Message-State: AOJu0Yw3RienVUKiwjOg/0e84ShpCQZV9X7eDe/ulkB17IHCHCgEYm4M
	EUwzxhadDAzyOdOPhFiXcOy+sVQy9YJBeEwRHvGH+hYP+g/B8nTsGUzp/qhKFL6o
X-Gm-Gg: AeBDieteaq/gnQ4vnoD/4eoV34VUVGpz+TpRm/u0n9nM8cG4KzvPEgEysnErM7mKS7n
	rcq+qQzeVs6tGSTl0Ve2URq3J6Fa3OXvVVcaCdJ+hwU5GN3Z4G7hXz+w5xz+rB8nGXDc58THaGo
	2u0/moVXpWHE1SKyKij3cpj5HT6jgUz4g4/e3sZkixUH29qadtglxgxxMCoZBPLXW/MU7aCznm0
	kJOdYQd6FBF9PSA2awDKrZhq2iPluEPuT0+XwajhMZKVo/bOfKk5aSL3qmXie+8yBtfm0lIlvo+
	/OpuGpZj8iRSCjidbT8jM6v9mjKPZdIGiuwZQwSAeuoqeJo1hc2Mz9alAnAN9RmvuL81Y3EenYd
	8JE7WzOLsOZsM0Y14a/LGvRYAoVETFAq2i/97BeP4SD/+Yo48URjc+gLySKnnXpeLDQPnC+4Sot
	tjr66XPkD0wnZnzw2QI62Bcow/6cJUi4eIHUcLPkbKJmY8tWKf8sVWBzsyjFa9ERKInKtak8kR5
	BYbQISmq5gqKl6kdymdFFntDJRBw5LHA8lykiCzn9NuZ1rTZYoE6C6e2xmw/esmgg==
X-Received: by 2002:a05:690c:3482:b0:7b2:c6bb:434a with SMTP id 00721157ae682-7b2c6bb4dadmr155659957b3.44.1776289197019;
        Wed, 15 Apr 2026 14:39:57 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4cb2:f26:96d0:1bb3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76621668asm14126337b3.4.2026.04.15.14.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 14:39:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
Date: Wed, 15 Apr 2026 17:39:45 -0400
Message-Id: <C049267B-F119-4F27-8267-1B9ECFEC454B@gmail.com>
References: <xmqqo6jk6r7k.fsf@gitster.g>
Cc: git@vger.kernel.org, Colin Stagner <ask+git@howdoi.land>,
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub,
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <xmqqo6jk6r7k.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 15 avr. 2026 =C3=A0 13:58, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFJunio C Hamano <gitster@pobox.com> writes:
>=20
>>>> Depending on the history graph, subtree split can recurse deeply
>>>> enough to encounter this limit. Rewrite the rejoin-deepening
>>>> algorithm to reduce recursive calls.
>>>>=20
>>>> ---
>>>> Changes in v2:
>>>> - Rebase on master
>>>=20
>>> We have seen two iterations of this series without anybody
>>> commenting on it.  Is it a sign that the topic, or possibly "git
>>> subtree" itself, is of interest to nobody?  Or is it that it is so
>>> well done that nobody had any comment on it?
>>>=20
>>> I don't use "git subtree" myself, and I do not know of anybody who
>>> will scream at me if I break it by merging an unreviewed patch, so I
>>> can merge it without worrying too much about fallout personally, but
>>> that is a tad irresponsible as the maintainer ;-)
>>>=20
>>> So...?  Any volunteers among those who have a higher stake in the
>>> program than I do (which admittedly is not a high bar to cross)?
>>=20
>> FWIW, I can see that [1/3] is a benign clean-up that should not
>> change any semantics.  [2/3] talks about the variable $sub, which is
>> used elsewhere, is not protected ...
>> ... in "git subtree" to verify), but otherwise the change looks benign
>> to me.  I have no idea if what [3/3] does is sensible or not (and
>> again, I'd rather want to see somebody with stakes to double check).
>=20
> So, yet not any volunteers?

I have shared with some folks who I thought would have a stake in the matter=
, but the dearth of replies is evident :)=
