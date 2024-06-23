Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A91C14
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719136008; cv=none; b=dXoi21qG2K7fISk6VseghBKvor7P7I743/lIdVJmRCrl3dshmime1rgcqPA8oRli5R20SXjsBz+1Ah1PNUuB6Jnf+cAz3KlJKB4s8GH8biL/t1OaKo6gmPR84hNwjOOop0m63Q99L91no+IuyLKNz/MwYRA0poxEpc+/kL8mZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719136008; c=relaxed/simple;
	bh=TWlMqK5zsSFXkf0q77AnSAcGzRKEMvErM2GQETJ30tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwnkRC6uYcFKFTR1qs2gpmwvendWx2tf/Qb0T7W8VQ8lf+HOdn5l+1cTvBS1bOjpKC2ExxqH9KVG49s+Ns0fcanYJlxqULezTrIxDOZ/a99AYfpEV8TV0+rpQEkVY0wAmyM1CaHwMdYBFeAxEVW7Clnwq33xuYQThF3t20BESs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DL4Wf+Zz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DL4Wf+Zz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719136004; x=1719740804; i=l.s.r@web.de;
	bh=w6JwO7Rdp6VEdnz1HE4MVr3ELtNxaIdso05hQmXNy0M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DL4Wf+Zz58zet6qUUlh7tj5JNKspqDo4WcMu0K0lQ8U5R2BpA8O6eucIUWofc4E+
	 36t9df2IbFuikXrzZuOxBeE693WWEbSgb4ay+4CrvEuP2V+FyHLgO8jK0pNbV5hpr
	 cIFZeXN39WIIpsknJV0jbE2ZgvIPSbEJ0PNGD7ZhyM5HpO8AqfOQSgsS66qv/mu81
	 fOVJULboMLn28vOUNj1J7o4H8v5I4NPKVwIFluqI9nYM+7kVL8h3J+zcpNJZG9Po0
	 zsch6w5TwZIOrvDoTRz92eu1D3f1sa0rAA93olihqPbBCXinnBSS8F8ixSaYbqLqC
	 M1YbnpW0RIafsGwYXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1sdnb60G2G-01154g; Sun, 23
 Jun 2024 11:46:44 +0200
Message-ID: <e23dc86c-e32d-40f9-8305-86d4a25e79b6@web.de>
Date: Sun, 23 Jun 2024 11:46:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: allow --color-moved with --no-ext-diff
To: lolligerhans@gmx.de
Cc: git@vger.kernel.org
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
 <8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de>
 <trinity-5166e20d-147e-4205-99b7-f13a007ed5f9-1719134235233@3c-app-gmx-bap30>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <trinity-5166e20d-147e-4205-99b7-f13a007ed5f9-1719134235233@3c-app-gmx-bap30>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YMnP8RdSZ3WLEPW6a076NVczUOeD98muvdOuj6R+eWUX3aikDJ0
 PwRh0cPa6/EqaKreTc4QGMIMx3ld00SrplojVJq64ltkaIStUKn5LyEn3oMZBApokNENRk5
 cPB3otH+xbJ2UP8vRyh0bUhXbGP8nkusZQS9c/kHf8/B6lQRBm5LN4OG96bxXpKjr+iGLx5
 ZKsARe2lZ6HZ/jewR+hLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yFIG21dGwrI=;BsWk9x/7JSdaFafQ1D3czErIYbr
 +kc4A4U6Gbedi6Y55ztEoux/c7NesRvdxiIqrj9dPq03sMKRgVI6neRKQdnYrgVZVDaOnPoN5
 7+JClV1VcR3MEN9wZh4Uo84xiDJtLmrPqGD2VB3Kv4EGaOwj66Gxo46riyMU1HVjzarnrOQpI
 fLN8rSyj3GgsTb8MrYIe3SBeu0q1PoVMnPr1kK06vz8XjV7/xaLsk85JG6Hk+kTMGRP0qWhcv
 LNPT5wWr9toF3TJ1uevy1JqWp8DK8PcvFsgA4VodrMxbrIv8zmIOu6pPb+6+7fRHSfmydLrpl
 k3n0/NwCGmDcWyt20Af+u2G9vOfR8ZKyJiU7G9eYVVChcYSww2/ox0AV7ehafc/YHpBZCXhwG
 2lVmA300vjgkmPJtilFowY5x4cGwIisKHLUVtK6SLMf/jUqMNiHHg22jCIXDzDMLjgMvV2whK
 c7K6iG5tztyPwZoHLQ2myBih9cJ5VdWC/xOhLZt/YW5/w9J4pcSA33AjGrheHSghvFyJmqtk1
 r0THqTSEu8SSomAJ9pmY4hin6c1Su3YFkjjwTCTZX5qkCJi0DopQGHhbuUrkRp9GpBbtLbA28
 EkA4yH7SBHcSfZ8dJ1SIgOQe7Z1PJ9nJ7Nb7HonMLhSgyt92kX64VSzxCpL64yuvnxsJlsXHm
 6L5Fqmt5iOBMzpCYcspPClVINXIuQIVKzJvaJ55QFMluTEqhf8qNpkiu8eN9AvJT+Unef6G1F
 77X1BQkWUQeKd05vneEtszTURgRrNJ4FhUygyWhsAd0+qQFMbMuAQCUwBhzHjRC5DzY6ZDJ0O
 pF/+TyKsZLcqPkl9P/hVgc1jwa/MmUcYhnZb39eLnvaNM=

Am 23.06.24 um 11:17 schrieb lolligerhans@gmx.de:
> using red/green coloration is the current buggy behavior. When
> setting oldMOved and newMoved I would expect the correct behaviour to
> the the same as the buggy one.
>
> Could this test pass despite the bug?
Good question, but it doesn't.  The test uses the colors "normal red"
and "normal green" for moved lines, i.e. unchanged text color on red and
green background, while regular changed lines use red and green text on
unchanged background.

Ren=C3=A9
