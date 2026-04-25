Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF9314A9E
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154260; cv=none; b=LIW9TIf2WB1oNmGUusPTUvhetswpJjppifZFFoK5j/1s/Pm7VM7AoV/OYKHjEQX+QeIA3729fK99ftj47eOEvFmf14PMANLASl2t5q2LwaohQqXyRia9HjHgIiscUY57xjsHwQcn+RAeq8eChL8N/pQnz1/rMxAsn7LRrO3oJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154260; c=relaxed/simple;
	bh=76ch6+32iBJZmBuyua3B7jzoBLdk1cQSCN8fTH3GzU8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=M5pmZeWkawm+vSmV8M6HS5Nk4ZR6u41mnOGIEcqUGmkds64HPvzzAmp5+sqLgC9ipygd0c5lDTrWIcfKMv4JKA/7uvPJaXUUllpcAE8PTQyoRdogM1Zp/VKjWo7EOU75Hp0xwAUhO52a+r43PTtmZZbR0Ti/rqGO0f8ln4ZHUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsFHCx8u; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsFHCx8u"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65890a6ca20so213577d50.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777154257; x=1777759057; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ELWnSwPn/XcX3F6jXZgXPWjmAvWDjPguPnc7u9uUMI=;
        b=lsFHCx8uR/FnJ1hQn90JVE1ljZrE2BFnwPyR3FIa4u6NQUsk4VxqXbd3KuaReAd8fT
         cpKgVGJPNbASb8/ugjI11rAif37WJz6BJ70TVq2j6FWJe7VH5N9QcKmDZXOPAofjDGLF
         y/6uf3wGHZIggBRhfonKt9RQsopOQIlmfje/Le8X5ukkNeL05pw/W7XVZynBb3/Nu4jr
         vPCBUa/w9hLlZy69otydgWS9/D/s3v/Rnme/ntVY2RHjfTh3GMt9D42sHHX1V5rwDLyw
         iumw8zd7YVgB8pjL2yj9TZxkY4JOdywVmrHfBqwWxKkgj3GApxNIo9wqftw+WZEippJt
         1Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777154257; x=1777759057;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ELWnSwPn/XcX3F6jXZgXPWjmAvWDjPguPnc7u9uUMI=;
        b=ISw4WhG6x+Pm5TenSy7zvAj7NemMGFoq2sM1Hkg3xrI4beA15gmMburX1TtPJK3prS
         RyDrWOtwBgqbEH2i2g2WnKk92BRmrey/WnNcPoKQv8GhphNfjeBYjcLIP5ZhHCVwg7mw
         lFi2D14M8Wcd7L/kV5nH3Ek83i1Wmi4dpbN6/O8bEr0Gd3/TGr4LF6gg/SXiygnL9/dV
         UqIi/AcP3kB5cLoseUvZ8otFiZA5gnbnbIULywkLURoB2yOvSW9xhsZZMTqGKO+dKtM0
         RlbRBHP/JfSuphbTaMRez1n3Q3jlCDueRk/r2nBcTlKTHXnzWgrDvVIvdnv0poAFMKfz
         wagQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vCN5mJLd817J9oPXho5/CrNfgv9O5uXhbrqzFGvcdQIc3h9f3Jvc81jXLXbrDkhMsDhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw710KM7Cegncz4/7DTOrZAbr0S29ZWPPLOz/Pd07UYK01600iw
	tKjJKNRae83v1GW1wHTtoNa7ikF9/kBQF5evuYzLP4+Nvswjo6EQE5qW4is70Q==
X-Gm-Gg: AeBDieuOyFnPPOtrzhs08zFDAeYsAUQSLej7qT54abLVK/iEJcpky+mzJ0PDkT0UwCu
	hnPxGuyb/hxkjn7z+gzQKUwn2aGiPJ72VxNC5FBI4Jp2ckNI16/ALws4MDTGwTzjjalvFCApPVX
	5j4vzqs8QZM4AT4IQV8aC+ROxfKBDcdXvVmlD4NgN/9y8UGJjve5mb5NwZtQv1os4Es0Z2u+9NP
	eTpqmx4xAeYMv8gnVJYqjE0bC0mtloql8hcAA8jTkQnSbNYmJoh13DOGPlNaAgncsBSgKhNDT1s
	+4xvVGyhazZvt/ZPrnuDLAeLEHfJs2ez55AXd+SMVG1vHf70iI+CkWsdz/Bgrn7xjNT6NbFZ6vX
	+l7Hm/cD+z97OxccDa3NRCgWYqlHLxCoR5oBkNcSz8Jnlj2HVL1He+20j2uxoNKzoyLNvWmUqmq
	5mfbD0uVMvkHtKx7Z8may5SGjwrk9eGcXzExbAdpEM+fSHTtL/FfcQ3uvpE2Ty+qG8uTuUtP1lS
	dYdh8EwUG2PxQvdloWi0V3prSMqq6FgV1IXH9vU4h6tauLXET2WhJU=
X-Received: by 2002:a05:690e:400d:b0:651:c234:8204 with SMTP id 956f58d0204a3-65310844302mr35904679d50.24.1777154257678;
        Sat, 25 Apr 2026 14:57:37 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:89bf:c6d2:553:2cb4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e3353bsm12382061d50.12.2026.04.25.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 14:57:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Multiple remotes
Date: Sat, 25 Apr 2026 17:57:25 -0400
Message-Id: <E5737766-2A41-46A6-A3FD-530CAC5076F4@gmail.com>
References: <20260425175824.48380-1-haraldnordgren@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 haraldnordgren@gmail.com
In-Reply-To: <20260425175824.48380-1-haraldnordgren@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 25 avr. 2026 =C3=A0 13:58, Harald Nordgren <haraldnordgren@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> The last one was a rhetorical question.  I do not want to see such a
>> configuration variable to implicitly trigger fetching at all.
>=20
> =F0=9F=A4=A3
>=20
> Good to clarify that when working with me so that I don't go ahead and
> implement that!
>=20
>> If you are merely starting at a single arbitrary
>> commit, instead of anticipating to having to repeatedly sync with
>> the remote-tracking branch that will subsequently move, there is no
>> point jumping to a "freshest" commit that you haven't even seen let
>> alone inspected (i.e., you do not even know if it is a good base to
>> build on).
>=20
> Not sure I understand this sentiment. For better or worse, the latest
> commit will decide what you have to work with -- unless we expect it to be=

> reverted or forced pushed over.
>=20
> What better starting point is there?
>=20
>> For a starter, if you interact
>> with a repository with two or more branches, should
>>=20
>>   $ git checkout --track=3Dfetch -b topic origin/main
>>=20
>> update an unrelated remote-tracking branch origin/maint from the
>> same remote?  As I already said, most Git tools _depend_ on the
>> stability of remote-tracking branches
>=20
> This is an interesting question, and it's very likely that I am missing
> some nuance here. However, with that said what option does the developer
> have, you have to accept that the upstream changes constantly when others
> are working on it. What good does it do to keep the "head in the sand" any=

> longer than necessary?
>=20
> I'm not sure there is a way to fetch only 'origin/main' and avoid
> 'origin/maint'? Maybe, maybe, if that exists it could be useful here.

Isn=E2=80=99t that exactly what

    git fetch origin main

does? (Might need to expand the refspec.)

>=20
>> still on a leave
>=20
> Enjoy your vacation! I don't expect any response from you until you're bac=
k!
>=20
>=20
> Harald
>=20
