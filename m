Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64175367B92
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405656; cv=none; b=c2oLLsKSi9WYl4aTFAryNSdOxO3RtrdHzRiUfpWFQ7O+mh7Sig4Wvw2mQXaPqNhvs71ZcfelPFgtXrMdwmFn+2r6ptou/KOyOyniOXa8MoezGkhoRFn6UoCktVc8mVKez4aFe1xszAo2fC80haoDamc3KO0eMgSfrH0hbLHaTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405656; c=relaxed/simple;
	bh=alDdLIxHJzrzmdulJjmGg3L+0ij0PnIraVHeoL8Ufd8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J/T8MlmQO8gV4hL/Rtj/+b18SIOq2LdFeQC458qi3hpfcBGGGCYiXASCZfZkhVMScIU5t7DUNjGDF2MRhuSeR9eW3GjOzGVItV3hfSvRGVSIxTkxRKoF/0BFIRSnjXEaQp3zwP/JslqBEgjCh0uyOnwZK9KiGKJG9fuY64nvCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bct7EZiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N580qlLn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bct7EZiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N580qlLn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92F2C7A01C7;
	Thu, 30 Jul 2026 06:00:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 06:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405654;
	 x=1785492054; bh=uVeV/vmhrbJYh7rWPMEzBbaxFhL1YFR4qF1juZjx2qc=; b=
	bct7EZiC0agsJZPBwp5nszfriXtPuknYW8YUv7xx/UUBf3AHS2KmCVoLzXMHiTvK
	hmj5m9n3DjXzzfUKGhrpBEfRAY5hhvXvkgmzuFgzVFe/Fn5G6F+9STpgH3tBqc8Y
	WqqCYmm9YUPppyT46ti9U9VhKv3MKALI9wmTTnoV+HMk5i1qbQo4YEjpCGI53e4k
	UJGZ/JmLAhDyfWPRlpBjfbhXrUpJwH/B8bqWO8DxNLLfegvbrvYFPKoG6gvT8h39
	Ns/b2G3UlDK46gD0Qgm2wk9yc9PZIWxv4GOnp/T393MvKTHIBRsE603hVVGdcgPz
	nAe4Dbuf3N59EG+xSZtZkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785405654; x=1785492054; bh=u
	VeV/vmhrbJYh7rWPMEzBbaxFhL1YFR4qF1juZjx2qc=; b=N580qlLnesUivsjxs
	X+0LKtKYw+GJtneAbF5Cl26SsYgpmA8pezg/jlpNSaKL1WU5SlMWIJN4nqgm0o5w
	zf39GLd9ya96y5Fsi9IEEHmAxsj9wqNlhfZcN7H3dccjD1/8Alpuq2CCk7wrolS9
	2CR1DOgOtCPIEMZ5r/CVKjBnsRh8QQlbtrdVL62OtQ+aeJ0wqFR6+pFkhB5R2UMV
	JN39b+GGpdBlp7UU55C1qlkzsYJ/EPBYDpSgSr7O+DNPuV8wK/eu/2wBA85qDrM7
	mNI6E+j8TONeiipI+9S/RXkwR75kPFQmjMeQHUopp4qjojBqu+1/xghwhb6Ik1Lu
	yGYNg==
X-ME-Sender: <xms:1iBraoPGcI36L0OUsnXalJVHsFDmBcjYddLk5FHcBEKXO4oiX3vktfY>
    <xme:1iBrapwLsQF8vO35HI6APRCZz0_2yUA1nde0DJbuLqm2p88wbjYq8lI3qy5acTB04
    G5w712Xgj9T4Hjq4S2-fEAx1Rnc7L0xZ4LJzAtUUe0W2UPWvsgT3w>
X-ME-Proxy-Cause: dmFkZTEWxvFPhzPXL2UyhSceJk7eGpXrtsOaaq+NuGIMahzR1kskyfEMr/T0qsyxk9/Sou
    uRv0qjre1N5Pqvi2FtYAePvOpLPzvGKA8j9VSfbORlUtay0dJC/hIkSWl2ix3UM7oI45n1
    jt33y5prIlvHs5z7ri5TDkjJtTpkMeM4Mupbsu7HTBedDfjo//FIIUy4Xe3h35QT5eDhVM
    epdHgpsoRBN8YqLStWMGmcSw8fCzrA1kVo2guQprGkRJr+ckV6Ge1Y9RR4VmfS4UEpgmvw
    XD6ehkfwnwyRMn6186xTbplNelVOhzW/y0H6bHeMWvcSVg3nIZOkR/a9eqlDpt5/fduDFY
    fUAhqo2Oxb5ivKcAlzcqW8/HJ5b/7r0/nDQmzzy0sO3kLKbYRjcag2RojSAj5SxaTDVYaj
    A/A5ROwB2H4IfXV4byIw8Y+gRg0wLX+JYvhOKAfbO/mRkULAoSj0jpbWPcbUHRJFqaOmWN
    sL2MVPwCKQjPhz5Pga14kTfW6KO+6anGDiaVZSL6GCH8xrA2468C7zoEo3itxx4EGb4Q9l
    ix80f1wJAyXYM8Yf4qdGIWM5IdKVR+hl7xhF20S2JHsatUnelraKkt/aHHeHDeb9lnfnOp
    nseXqgMEZ1DKusWYn0M5hfUbLiRdCqkx7e2FPBAfIS/6tEkOhcj36N5qwUgQ
X-ME-Proxy: <xmx:1iBram7U1dnwG6xiojhZcbwIuKOByWJfeEBSrzJ93ewtzmnqZM5I0w>
    <xmx:1iBrat2PKD4fk_EUicoj_wa0ynWJx0fPlm12dLzbwpTvdYetaECkVQ>
    <xmx:1iBratBMCBgjajLrD5jxGQJnIR8378oPkh2lGydUSPozmq-_ChHcmA>
    <xmx:1iBrav1_430xPtdj6nS-r5yNkcdG237n-qhJA-yBn-gC2wtWlvGRRQ>
    <xmx:1iBrajiZDRR_DOWR5j5AUMifFr3I1Aq8R3QXDusS9dBKKM_PJJpNnAJP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 515233020073; Thu, 30 Jul 2026 06:00:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 12:00:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <6659f0ee-386a-4aee-a888-b16d22559aec@app.fastmail.com>
In-Reply-To: <xmqqzez9obr0.fsf@gitster.g>
References: <xmqqzez9obr0.fsf@gitster.g>
Subject: kh/doc-replay-config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026, at 21:07, Junio C Hamano wrote:
> * kh/doc-replay-config (2026-06-05) 4 commits
>  - doc: replay: move =E2=80=9Cdefault=E2=80=9D to the right-hand side
>  - doc: replay: use a nested description list
>  - doc: replay: improve config description
>  - doc: link to config for git-replay(1)
>
>  Documentation for 'git replay' has been updated to refer to its
>  configuration variables.
>
>  Will discard.
>  cf. <xmqqv7a5b6n7.fsf@gitster.g>
>  source: <V3_CV_doc_replay_config.780@msgid.xyz>

I have posted a new version now.

<CV_doc_replay_config.709@msgid.xyz>
