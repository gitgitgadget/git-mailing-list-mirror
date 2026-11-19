Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121018;
	b=jmT1lhiQGlYQ3ww3WrM0ZyHSjD76PdQc1p4oPtJ3GTkcXRbImwrVamQlN0GdKdZGCV9C
	 s9qoC8oWWCokWzzdve+xlKWnv7dqWnESViuynCUGd/BfM83uEFL87nb+kWDAZ+4VCgHyw
	 9zEHsVbsoo4fAMFWl3iKcj6irU+J6En1uN5KaenbOelwBsujS0NJSRUNKCHzCANCiiHq0
	 UwtoC8hFwJUKschX3nIe4sT7093rSkHb1DI/FZp3ChXtQHu8UuIRu0xKTVNDou+khlSQr
	 H4lNbUp2HGD4dwKJmI7iBL8hGQHaE1tXGZ9ayJd7gfpdTvq2z8OtPb819MLB0Xi06KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121018;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=gfVQEhJgzSMJPltxOo9ePckAGC2Zn/i8iEOKBJuUz2o=;
	b=xIqlKOl2WYvFsZEmifHg2Dzd0vNuja1kHQg50L/s4GhwZMb0HikmUpNn1tK2iszuR4lP
	 UURqpYmsj9X/2viRZAGuqywiMq7GvlCNMnpH98u3ukW3v8hCdxxIUf2iccnNlMBDLNwy3
	 ODww4YFrzu7LXNwRtiKTiCh9/DG8ieQOp3iICv8RPaU7JeiimRMO6n2i9X0gzM1Yl0mPH
	 oJOBJwjdgow5Rc9jVy7JfurQaH8LYJyXM8OgssqQCyDG5seaztjxtpx42WBtiZ5yvMUF9
	 QOF74Ql4hDCs7F2ku9KCykWphEkUWeg9X5Y/WwPkt/nfEsxdcsLQfkCATY7iSZWHmUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aKpLG06J;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0iGgihfG;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B44606BB80
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 20:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B44606BB80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aKpLG06J;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0iGgihfG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B51197A0335
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:43:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 15:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795121017; x=1795207417; bh=gfVQEhJgzS
	MJPltxOo9ePckAGC2Zn/i8iEOKBJuUz2o=; b=aKpLG06JKLPhkwrl2FBGzcc6KF
	WUU2dcAoTLXvbQbGugZPdUZEuQfx0ic0X0Yb4Jm+fEfrvc//4F7BOAQvPzjF9DEN
	UfHVCp4W9t2xxNqaOQMe3c9EOgCO3BxKIKm14SW2o73+FtJAD6kGJdU9ZCx330aD
	E5wrU9vvkVocH8CNP7tyl+C/hZskr5NxmJ0lGtq2oR8k+P4Tcew07zAu+8ffOaiC
	V9B7EH4Jsz9jLAr3bWTWIfGyeqdav/WkfPplZozBCP7gkP2zshVsLphRUo+hV/Gy
	TheL+nyZwqJ1GlP7yU9VBXI3dVC5xHNBF9jStlSZJSAkQLm5fEbLKPFLdO1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795121017; x=1795207417; bh=gfVQEhJgzSMJPltxOo9ePckAGC2Zn/i8iEO
	KBJuUz2o=; b=0iGgihfGL0+QBZ6ldoJJh7pVHVvGzHrz6VeWGvJ4kRQUF1AsKdC
	b5l/xVslexeHZ28woQvWQDBU0zihK4gnjt1/1VhhQeXQjApWpvJfvskerZ9eyThw
	insMljIrCIG9CTxGdlRLJVo4VuI7ohrUbAnrb4LPzCm4b2jzOyC9jnfJAgxHreHD
	KjAT5E6sH7R/BGsIOYY9ghiGxj8jZYjIRWGFFxSCxiXqSPn5foAbY2lkjO1kSka6
	3CD7b3DKaebxn71qKqwvgGXTc4ZINqvIam7g+drLHjY4ZwpsGlLv7LHsTTC9JFwe
	go1OJJNsLxBII9VweetsG7aDBjGEEiKs6kA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795121017; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ndh6Cvi/lCdWvEOpAUfRfhs9MIH3JQxmKNJrj1/lbkVMX5o
	W1fZtJtlvr640aWnRnr+VyaYHWHpE+B3lNzyi7hRMgUy4iDkZs0pmxOCZ99VgVpt
	25tKWoPTuAYREga2pJF/1M0YIUfqVacYUGhdQ4QuLNiKdeZ0pYRrDlJM1xwaZwq9
	DawZ0kHn4aGGLbENhnH/+Aby1ZoCBSc+MeYjcncXSWPthQTKixi09Zqvn6tobVfW
	gDsc/37fpL8BbOfLDah+NCEZUMOk1u3hnHtoC9ILljMhFLO3Sj8cPffb7HilfH8c
	zvbinGui8oSRMzFUExCXy5Z9obwujNNV7Bfitew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oaGq82KkyTtg19DkjMKiLz+PAiS0rz6RAzAzfhiniqc=:mn6cLtgh0XYB7jkXP5sWavrHN5A6Rarzairl3xxkc+s=;
X-ME-Sender: <xms:eV__ai_Nvw5TBYZg0tU0ofGCzP0C4Fajtz9P4Adwc-wE0d78A1ybOg>
    <xme:eV__ak-bJILb54sRB0lr7KoM52DJUYkkhuvjgXSgTxTCCPU_Yo60KBMlJtQU_4GhO
    QPAj7I6k_WXI21sYzHs66eVEPrD2Obg1zNw4KY3KVb5_570FHM7Xhs>
X-ME-Received: <xmr:eV__aqT2NucLy00lrR9PXcrzkOVvTqC4O-P_UtKsa3uUyTDE_ApheucJ_-pQjxnRCQ1mIrkhBZDXzSZic3t82zvsoMBqCBM0uly2>
X-ME-Proxy-Cause: dmFkZTEKiSMjTBSxy2/I4611tqSaS+z9a8u9sMM96GTj8/Zob5NGWtmKn0uL3einF7ww2x
    12C1EET+92n8cBj+z0cDtIedNi8p7eufqYdvUd6oel1RNAoVMpuSJ/jv+D7bBpfoZsFeci
    QIxeIWML3DTaEOqF7lnNaoZHB0lqQrPkJjCEqS7QEjcMJKIgeBllpE9EQ3Vcy/GJHQ/4nS
    1UAa/w6xPJ7Ujgp1XjDWGvlOzGxhSDA1ZU0Q4FxwvrQb6JLvhrhBP/L7Ax1U2J8JwCT6vY
    0RoFm5wpShAIfk+soulUFH1lm+WVm1xhB/hgKLw0ALrS0HpNT96kjmTWikCzBOt/TizQmR
    PJpXBzVeYeF6tEeC8Ri0YD/J+YiBdqOEzzDGDOWB9LQTekG5o/oZ+bXJR0+I3N4/he66+I
    p1dJQSggod2FmxSXXFqcTLh1vSaZXNBPi6GwLfY+m23JjKE/zQr1T6rLqE4nnrJMOn0ubk
    nko9m3OUwDBBnqsVZvnqpkLWjsBg6Z/SS5kZNmqbye/Pz3A7aUgIuzOYaueadRkMJF97pj
    5HE4b9xQre1kPkD22jd6jY3l5zvYCbLKIwal3eXrOJVRWuTvwQppoBsptlTTvm75He28An
    rUTTLamXCAoP/jLSs8vSLPIjj/ADNcXS761HClPHHQdHidzn0FS2JsPC/LYQ
X-ME-Proxy: <xmx:eV__agfK3fnB1LtLT_o-hcY4z26iMHP49lC9YuxaGpDRtN-sDuipiA>
    <xmx:eV__amAjGj_EQDg7cb8h0C_gyZlAyldM2xdCCuhUWZWGBd9fSedvNQ>
    <xmx:eV__aqmvtoh9O4pMeHmV8V2MNT-VxuVVpznLHSNY65S27od1s4BbGQ>
    <xmx:eV__apf8QEn42pwlE2oBxaMURJSzqJhz2zl1SWkn2A31ebkUx069VQ>
    <xmx:eV__amLiAqeL8igdDSwJNwxGFt-gM2YSJ4gP_dCcBouag41NCK0so_Mv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 15:43:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Matt
 Hunter <m@lfurio.us>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 1/5] fetch: add remote.<name>.fetchRefmap
In-Reply-To: <2111d174-9571-4eb5-82cb-92f5330ae24c@gmail.com> (Phillip Wood's
	message of "Thu, 19 Nov 2026 10:53:36 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
	<c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
	<5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com>
	<xmqq7bibh3f5.fsf@gitster.g>
	<c40477c7-e1d8-4af1-859b-b739dac4bc86@gmail.com>
	<xmqqfqwzcgmu.fsf@gitster.g>
	<2111d174-9571-4eb5-82cb-92f5330ae24c@gmail.com>
Date: Thu, 19 Nov 2026 12:43:35 -0800
Message-ID: <xmqq1p8gwo08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Great. So I think we'd want a preliminary patch to ignore --refmap when 
> there is a destination on the commandline and this patch to be tweaked 
> so that
>
>      git config remote.cabal.fetch master
>      git fetch --refmap=refs/heads/*:refs/test/* cabal
>
> and
>
>      git config remote.cabal.fetch master
>      git config remote.cabal.fetchRefmap refs/heads/*:refs/test/*
>      git fetch
>
> both fetch "master" and store it under "refs/test/master"

I thought "master" as a fetch refspec element is a short-hand of
"master:" that tells the machinery not to store the fetched result
anywhere (other than FETCH_HEAD that is).  So the first one of the
above should be how the current code (without any of Harald's code
for configuration) behave, and the second one should be how the code
we have been reviewing should already behave, no?

With the first line in each sample replaced with (with or without
the leading '+')

    git config remote.cabal.fetch +refs/heads/master:refs/heads/main

the first one should store what it grabbed in two places with the
current code, and the proposed update will stop touching refs/heads/main
because refmap will take precedence.

Do I understand what we agreed correctly?

Thanks.

