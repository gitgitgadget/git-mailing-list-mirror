Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A446441
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884968; cv=none; b=WZIYsAzolWbKXjVdupSXiIO9nZ5LyLZ2xux8tUUa5G0vABiJJhtfngUfCeQrFA+Q3rpC3zvcygx/+iJ4d4I6aAZFwT2u2EcAN6eb4zOKmh2z1mEdjEZksQ1puW6JhipS3OxeavFlNo+mPUvMWluvpMc3hJ9SxO1U5RXcNDP52fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884968; c=relaxed/simple;
	bh=mKnbUKNLO3iFaZBizU3VyolmHTU6xg5J7TeNufV8gU4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Hfq/80RlmNdtgbFawFqJOgvKzhfvlqtcAtDdth9PUy0Eo9qZfQs1wb9E6zUgQuMhqG2ODiy3EIaQc/1houWyPwt1usZQ5Dij/YES1YtdWDSirQh8RqJmuspIEBpwRN4Fq+/G3ThKU4iUxseN8Tx67l2W1QBu9/xoJ/DPFWWvt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Xo4f9m48; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V6KLbqLa; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Xo4f9m48";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V6KLbqLa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id DB8903200A51;
	Fri,  2 Feb 2024 09:42:44 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 02 Feb 2024 09:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706884964; x=
	1706971364; bh=ayB8JhjZ5iDk7i4Zp/4b6RLRkeuCtnDGWjvM8hKyYkE=; b=X
	o4f9m48bF7IFMzgHyMMuRQAIiG+dHm45NkHiqhnt94Rnagh3eZ+L+bg7YPT3lfdV
	MmILk94DC5kIOf4QnBpmKd1u7TcDnlOLFf/YdG9VUiPbLw8XrCxOOatRB0EejZJo
	tShD0Y39TeOBD30pLCPoA9wAsExhsxG2hMbxbHLhHXKBew4gukOX+Bwjip06fXTY
	WNMqAAOWj5xJBHLNODGc1AoA01ahDbsDoHPQDfx38R9X1pzzZUueNEwLYx7+yLFo
	OuxYcYT5JqdMJLBEY5NXSWuZHtQ6CN99rxpd89egwtHJpJLjeg3WW0dfOSqaT7DR
	pBwzr0Faa2pXR4qWfodrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706884964; x=1706971364; bh=ayB8JhjZ5iDk7i4Zp/4b6RLRkeuC
	tnDGWjvM8hKyYkE=; b=V6KLbqLaey8/2tBO7peswlORtdTcPGv3MyOmaPjuAOHB
	1wt40u2dDHhAA4xt4d2w7zQD18J4Ur4OMRF9y8QbUARL0cxdoGlGQmomddspy9RS
	1fZCWDDwPUPf2+gzJn+NKfWg+8+DAh3M1z2r1UTc2uyTawAHxRyZt8l0/DCDFl8G
	/5SrmLuumh3pDPHD5LCAE/lfYt4aSmtUlD0Vw7C3rh0HhrqZjsD27ELRzUXPrnsi
	+lQxF5swLgCriw38HqBiFy3fNGBrFjzvKiEwFXDIWF7F7PrriI9SYWIETIBGapUL
	aMS/1ex+pCgDg1006HxN2tM5wgQbq4owIaYfloeJnA==
X-ME-Sender: <xms:ZP-8ZQXbf1RfgWxNAniSezc4nsd1Nbb66A8tlMGwcBu-qlsl395qIXg>
    <xme:ZP-8ZUnbyF-tPSJofAapKtRtDYMBm0iOuAi1fOS86aP1g-YwFmd9Hg7EOIZnTCaA3
    pZM0Tm74IPH1cSx4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ZP-8ZUZMNaq5uIromU0W8QsYecTvAvHLXUKhqkdNolC88_obeY4y9w>
    <xmx:ZP-8ZfXJo6T5-U9AT_dZygBxiW40eTQNtlbUqJ_sfBFjJWW5oc0-nA>
    <xmx:ZP-8ZanfTiHi5oXG0LYJ3UMF3vHLTcP597N1uqujc4klq3zh79kaZA>
    <xmx:ZP-8ZRtsqbN4dk2K0hjlgFf2iZyUVQYxVM6gOFjsicVupDRaI9wpHg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 06A8915A0092; Fri,  2 Feb 2024 09:42:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <418c0333-50fa-41c7-92bd-0797f06041de@app.fastmail.com>
In-Reply-To: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
References: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
Date: Fri, 02 Feb 2024 15:42:23 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Martin Guy" <martinwguy@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: single-char options
Content-Type: text/plain

On Fri, Feb 2, 2024, at 14:45, Martin Guy wrote:
> I'm sure this must have been thought of before and rejected, but us RSI
> sufferers would like to be able to say "git rebase -c" for "--continue"
> not only for speed and ease, but for all the other RSI sufferers out
> there.
>
> I mean, yes, I can implement them for myself (at least for the most
> common long ones) but wondere what the zeitgeist was on this issue - at
> least that way they would be the same letters for everybody.
>
> Thanks
>
>     M

Magit is nice if you use Emacs. All interactions are a combination of
one-letter commands and one-letter options.

The CLI is too tedious to do everything in for me.

-- 
Kristoffer Haugsbakk

