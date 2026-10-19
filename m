Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E873EBF11
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420012; cv=none; b=sBl/igzSMoBJs2LwHo/sHMkt2vNiDEFHJc5l7Psy9YkelcHjUhyH8rkKgcS9wqsm1Hsdq2meh7r+Edbmbo5g84mI/MCILnDUKaMLKcKle1rvwteJa6QiNL8/PNvBjCo+FO1gC1KPP7XwesbPvbQFKjZuPyZWm8U/bcp+nF5rhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420012; c=relaxed/simple;
	bh=5YacYihicperf33eK89UsCSv9EI0lbZTZTemlf1jFbI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dKRwpdfUfmL4dPoZeOuxV3CcN4KtlyvtedL4nawO4DWOHoCwIFLuW1OCQF4Zpv1WL9/Fd9Yj9Jd3thjrpasGPQ7rdSDyV+6WsqvczOWRWflpOnNv7DQbn3N4HgC/pWUPdDnbIHH5nyvpxIYtJ5IWKqNinLbdFhuKSAhD61vwCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCjNdN/+; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCjNdN/+"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b056d58f2aso16331117b3.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420010; x=1793024810; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH7YB0u3pPgKNC9Ktxeex0/M41n8aAfNfMX6DMv8m7w=;
        b=oCjNdN/+LmV85MaDqCCUUne4oWTmx6AE8tw3SbOF4UPc2Xyol9TtThL7s2sNO3pA76
         8lfXQpewJfYJZ8E5Z0nx4XWs2xCJTL6nKyt4Hvpj3xgKCq1IxBzsJ3aS+IA/pKWbUuv2
         KUkE0mG3q81VaE1L77/zBkuh25GuFKjq3nJ1arye8Q99baZJy4ybTsHIWZIH/H6PWyqn
         DsYEZfXUraS161sn15zQFA5wzbdKpjXWFxYRP88c+XgeGDP44UZpCK3nOgSUQjHcZLfk
         IBQ6JAvEpHxWPCYdkUU2rY9I+shRYMC68afLGvu2ahP+TIS3Cy9wZYaTY0cvyNqT3yhM
         Vq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420010; x=1793024810;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH7YB0u3pPgKNC9Ktxeex0/M41n8aAfNfMX6DMv8m7w=;
        b=E26BdyXe1DojvPT7sB6niOGqGjxnh1mmnbLHBJxIS+igHFMX1j6u92gEyPJXi5uYP3
         jWXeoLDyxsh5hXmFx33hctBXcvk8kbtmiSFLYAS7SondGTGBmkEk04/peS+ZE9omygcK
         8AIr4OuS7GqKbo059xcNnwaYz3jNclkrAFD/hPf3B5sNiJvKeymAQQz/G6D3CrwdYH1b
         XQpbZAM/TlSbrX8oKwAxAmhw/DCsiROMPbjmtQcY/Aax2oBA1J29909yQwbPheHA1V/Z
         6/gdDEaGCNyHAE9RWuZuSXT7TQ8MGPf7AwjO5inGPRIrB4n9b2ClDHDSFw1jQJMuZL7V
         CnwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1JXUppCNJ+gBIDOHTyb1CXRD1STn+6JY5M7sBuoirpr9Z7gvIyPgsS6ouCdkhRZdy7lQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoR5j+HkBDOF6PUIFMWgDaoj0g52NjXO7zqyg7IJ8XDSZ+0/Rz
	AZlR3M2LTE2xZ/PJ9qizvED3VZn7T524gMoz5bsOpD6DGa8aRNrR6rDZ
X-Gm-Gg: AYBFou1Ek/SLQV8y6gmJ3CDXsEkmUFkhFMkVD91/p8X1GgtOUXZ9ktMHgtJHmazdduU
	e5hxaC9NZ/9sBsZcRT7aZK3/j72BBsw9yh0us+dAPLwk2NYklCBISupb0AfdrBSKMLFDmVbjdtI
	7a0sWsP4ottk98XXUezGOVH8KyXK7LWTKyEvY8fGM2gtIDzn7lyoILlbeXPDYZeVTuaFkgEV//m
	dGSgDb7qU3UBvevv7uVyMHNcxtqkTaCjSDu2Q6xE0su3I6E9gKDwoNIsi68ehsVVRG7UdGw90Eu
	tqYS4omvc8RlH3BEdLSgy4wohzuJgvxDSocfPXHgqQzStm1XZCZsFlUj56lr4ERu1ubTyuB9mg4
	rFbtcdyqi6SzxomWW7lS5Aovap/GZGdFcOtclgjzLkK8znaOt0gg1qFukAe/AIfN9VOAwncFzeN
	sQCCzGNILL5xoWJqUQrfmaQJEnkHLrw7daJF3oV4Wuh+OqWhpa6YEFe5cPo71igNZA83FrRGkIf
	bX3k8cFiBdNn8NDXaIUUbtMKv/kGR28jPF63PA7ixY6Nuu7+s2eu4vjKWO0tOwhjWxlb+JwYMoU
	y/c/M9XcLdpOB3VTXFDSPiHisJr33lUJwdAFtlq21XP7g1g=
X-Received: by 2002:a05:690c:a0ce:b0:854:819:64c9 with SMTP id 00721157ae682-8b0f2164ca1mr17340727b3.30.1792420010229;
        Mon, 19 Oct 2026 07:26:50 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1909:b48c:a809:b114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b86df7dsm1022407b3.33.2026.10.19.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:26:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
Date: Mon, 19 Oct 2026 10:26:38 -0400
Message-Id: <65ACF5B8-875F-40CB-A361-14452A38F405@gmail.com>
References: <CAHwyqnV=iiocV2FA32-X8LTgYwWmzQguPtkykFKM-t7B7ttNOw@mail.gmail.com>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
In-Reply-To: <CAHwyqnV=iiocV2FA32-X8LTgYwWmzQguPtkykFKM-t7B7ttNOw@mail.gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 18 oct. 2026 =C3=A0 11:20, Harald Nordgren <haraldnordgren@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> For me it depends on what I'm forking from. If I create a branch on my
>> desktop, push it to my server and then create a local branch from that
>> on my laptop, I normally want the new branch to track something like
>> origin/master rather than the starting point. However, if I create a new
>> branch from origin/master then I do want to track the starting point. So
>> it is not clear to me that the behavior proposed here is better than the
>> current behavior, but equally I don't think it is any worse. Having some
>> way of saying "set up tracking when the starting point matches one of
>> these patterns" might be useful, but I find the tracking options to "git
>> switch -c" so confusing I normally just run "git branch
>> --set-upstream-to" afterwards to set the upstream I want.
>=20
> I don't actually use 'git switch -c', I just used that in the example
> because it's the *modern* way to do things. In reality I always run
> 'git checkout -b'. I agree about `set-upstream-to`, there is probably
> no single terminal command that I run more than
>=20
>    git branch --set-upstream-to=3Dorigin

Curious. I typically do

    git switch -c topic origin

and am happy. (When creating a branch that *doesn=E2=80=99t* start
at origin but still should track it, I use =C2=AB branch -u =C2=BB as shown,=
 too.)=
