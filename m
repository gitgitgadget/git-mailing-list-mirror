Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20FB1A073F
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751321909; cv=none; b=tGeflJ43Mx7opnPuB95OaHQgpsWBJbBep5zn7qge+jfR+x1vND5wRdckrOnJ6n5i3oavV9SuFn6JA+nc/HDXHtRYb5GUlC8PIkmFa0cr8wNlIp6W66hS77QCWP3DociA3iVK2NdGjOwjI7vL8rfgHJh7P1zJao9buMWt3n9F6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751321909; c=relaxed/simple;
	bh=t0txpIOQUrIH2Bg92vB6B63u7yZHvyCdR/zFziWY5z4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fLN3ZkztHqNidVYaMImgKN1neGpdCRd2EsAmFAhG4Bx3EwCt4NY3Mt0AyiIQkHq6rWhZSV189VSs380vvEnRXdGhQ1WWMBDUvrmGE4S4MlxinTFhui9jGffC87nE4GlXj78EjzoJ6ne7jDk1jDHfxvjijujYlseMJg8tnpMMk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzndHtTn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzndHtTn"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so8466236a12.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751321905; x=1751926705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rXD3H0UUPsY98Yow018WcHlC17U68bNZFStlXaXL+3g=;
        b=DzndHtTnReqbCq0UDgFds8dquJkDGJonGbIDIMiZktwYfIbN/FhUKyNSo4TEKIVSQz
         yv6zORHbTRlLx5IwQqqirVokjo2wS6577VMk1Jb8angHhvEsBBQagvqbgwiDNJFu4RHp
         CU9RQHjJpXxCZdn57RgM2bWkCr5+A3Fjenowi3j6EtNIkWbU0GfUobLMaG2HaqnBzZEC
         uLioouIKHBPWTXFaPsIqg+/sTZcrZ5B0w+KIuuWq0g/SAS97wFwXUESH5Ch4NWbWcosb
         VudvTH8AxByu6Afm7pFa0kNw9zda66Is9bfTwJXSZwA7KcP1OxzDvwhLq3IRaLcLA+ND
         ZVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751321905; x=1751926705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXD3H0UUPsY98Yow018WcHlC17U68bNZFStlXaXL+3g=;
        b=UNUBbE3vEzpIfOvOxPRb47ThuyC3g4FZC5GkwXOZ6cPTWsJzMOoZCc4D6ymnelKck5
         O3ogO4uB7w55yle/ClVBcWwju0hXW2bu9RW2yGRN3FuxpLvDE2Z6huigVdMwFkkUd4s2
         pwtandDWJo9MLWSdZwTBiKwcInvmiaLzPvK8J/P5I3LUTBRbtEao4sBdlb+3nI3ls62H
         83JwDeUlEk9OkirHegR3m/zfzx99n3MX9843r9Q5eXq26GEqcnPKkHsEZuC34rZk//BK
         NtHUDxwXrnjlc9wyyU+AdikR8YxUQny7oM1Ijwvp2nXC6P32eOaetDSubz6igE7WDKtc
         iyOw==
X-Gm-Message-State: AOJu0YwZRMMFIZwJIURmDsCib5O3Ax55U0JbTlVh7VbnS5eLQTWH0mke
	elC4dZa5WGlnzgp4ucsTGsj5/N+K5XssDUnbLHBEfmNVfDA0rcnURmQilYmJhhxmn6g8WqPEMyh
	eVs2RfCvL0cw+3fEnUuBm18X57skmXEonsDNw
X-Gm-Gg: ASbGncv9e44kijmIjvWp3CAps9asawS1NqMNxyezSY2mzZrTKf0kmjS21OCeFFr2hyC
	d+2+hB3hBLtvLs2xFHs0NWmSmDXxFT9eWCDSZL3c0uQEANokYFWe8En5fXqIdeFRoY0WtRlobOD
	KruaZhRHBmvuUqHzKad4uqhN+7lz9R13h2Bp46KPIZwDJj1Q==
X-Google-Smtp-Source: AGHT+IF0mn0sr7QCSGyY/uzIurtBCLPRWBCrrF0y//YrATmCKDG1vnLNXJtWeKzsYNiCP8UJTDxHZkuFfLVo53ljGEM=
X-Received: by 2002:a17:907:8691:b0:ad8:9b5d:2c1c with SMTP id
 a640c23a62f3a-ae34fd8cb6cmr1497128166b.19.1751321904925; Mon, 30 Jun 2025
 15:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 1 Jul 2025 00:18:13 +0200
X-Gm-Features: Ac12FXymVdZrTFigyOwVErwTNFAL1ssRuFJZwQFeKHUSTZze5eA0vVLNKokgtPU
Message-ID: <CAP8UFD2hTgJu-byOE-R-nt6OYqVoBTH1JiLbHoqB_pq=H_K9yA@mail.gmail.com>
Subject: Draft of Git Rev News edition 124
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, 
	Stuart MacDonald <SMacDonald@kaimaging.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-124.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/780

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Wednesday
July 2nd, 2025.

Thanks,
Christian.
