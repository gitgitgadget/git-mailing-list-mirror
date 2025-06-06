Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB97FD
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 04:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749184537; cv=none; b=bl2meUOM4tz8+RIOuPcO8I88Tc7DLGKeAZtkDwwe0LNaiFNwvIK0crImH+ap+CUx6AhTouJZiFgcc2cDTSLZsGuQLZ6fYXC+D6tmnmGU9Lu8lXIV3XIdD7tQCbBH7YX/lmrkBm8q+W6Q1mfp+0Y1A+LNJmNZAgDmUGHDf/lQfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749184537; c=relaxed/simple;
	bh=hIXSzy4tAUHKJHDYSXdPrUl2gMOufzCKAzkV3E0X2wc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TCEFkiJKxXidO49YDPJcORZOjwxJYVeD0n/FDs7L/Y5u9JppHsCetD8N8wkLRvUCd1obGehNOtcSLc8NWsh7kKl9CYW4uyhCg5DfGTlVrlUl1vYIn2+0uo9kBFbl5nXQr9GapUFkUDFrhBuussYJZXNNeH/vFqLgBXnGk5+miZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FkG5GM4Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SaZGalGs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FkG5GM4Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SaZGalGs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5241A25400DE;
	Fri,  6 Jun 2025 00:35:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 06 Jun 2025 00:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749184531; x=1749270931; bh=+1TFGvlnVA
	yEPGby3t/LagDoPTupMO6OhlxPu0VJkVw=; b=FkG5GM4YVoUms9n1AFHnb8zk+4
	rrm1AwfC7t7j+iQTk9tOy1Mso47VLJbNXc9HU5MLlEqdNoy8NzoX0gNriXJPPaBc
	meYmBmEET8Qg5/8j+C+ae2T4nBuxG+5POMxLOcbLHDtxc8Lb6PUqUjktXYH93N98
	T4/EOzDDdY8bXLMibVpDjJuHa+IANqTmtkGeQDmKMbu8wr30PQXyTx/6eJ8Uyjdz
	4PDPdggpp5iNOUjeI4jAeQalaHYg5UTWiJGCD69GLKtM2XhUiwnrFVteObksAVX2
	yn1rm1wOPjVu8F2VmVSRw/KE1Uw9z+VCuFhMWW4z7b3v9jD7Mp3IF+x+zUYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749184531; x=1749270931; bh=+1TFGvlnVAyEPGby3t/LagDoPTupMO6Ohlx
	Pu0VJkVw=; b=SaZGalGsNluRX59xre1lCD1o/1W5hMYCJ0mDBkVr1ovv5j8H6hp
	7e/CdD+Je8Jgw9ojCzD0iUaXTubmzNT3rXhCop23dXn0h87g2hBDCXGEb6BvqnYk
	1KFjYU4swten9zamRKkEUZ1lkkNY9UfjsjdKsrF0rFT87PaY6GNWYlTFwo+YzTrv
	aIURpsoCIFEdftCav67yLatpi64nm3HrTrc7E84T8YNQHkOTvvTLz9Zg01DQ5tWC
	7Rrd3M7JSl1JFu0RhJjPpRQcWE5/K5ATfi4G7ynXoHXOUhJfxBn4CGaMGocEr8dD
	Gje6XFdYxi4TVH9iKIxoAml+19EVrLWFZIw==
X-ME-Sender: <xms:EnBCaAFPM9s3UMDUunczBT4bgRWx3_ELO3WQEeDlNLv7QIaa1-yw0A>
    <xme:EnBCaJWltWiV-003vAiyIvTEGjuUKBs5ipk4CRazJ9FjbO-bj1HBcS_Ya-d3vh3Sq
    aAKqRq4ifAhWH6AiA>
X-ME-Received: <xmr:EnBCaKK215o-qXJoyHEIQjkK2Blt1XOHf45TNxKdEzisSK3iASwxCHyAjEaUG1k_6AHPBlLd1-j7uhM32NvyvXn6v_NUMKuxRdAF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EnBCaCG7KdpFFtaFYQgvNp641KgsnTYxX6WWjqYHUtvRmUHRg6pbHg>
    <xmx:EnBCaGUXlL5YZ6bCzyc8C4U0Or64GHJ5dmJaimBzzhE_p0cNelqILw>
    <xmx:EnBCaFNQFdpY5g7HysaCJYD37Ezjkmt14cFW2BIjVcy86uf7-XUa-Q>
    <xmx:EnBCaN1WX3o5I_a49uAo1WKN4qRd1iTmYNJYvbKCMZOLbHSkC3XK-w>
    <xmx:E3BCaHQn8tEOhO61SElPXZXlJ2PZBDBDGp_eOIWF--NcdhNM-xcr3R2o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 00:35:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <PN3PR01MB9597D25829C2D0A4342DA311B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 06 Jun 2025 08:58:11 +0530")
References: <cover.1749112640.git.gargaditya08@live.com>
	<0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
	<xmqqy0u687ww.fsf@gitster.g>
	<PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqy0u66n46.fsf@gitster.g>
	<PN3PR01MB9597D25829C2D0A4342DA311B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 05 Jun 2025 21:35:28 -0700
Message-ID: <xmqqldq55vxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

>>Which makes it sound like if (!srvc->auth_method) is enough?
>>
>
> No. If the user specifies PLAIN or LOGIN then it's not enough.

That invites another question.  Why aren't we checking for PLAIN or
LOGIN and when one of them is given use the password?  What is
written in the patch looks backwards, in that we seem to assume that
a method that is not XOAUTH2 and OAUTHBEARER must be PLAIN or LOGIN
(or anything that wants us to pass CURLOPT_PASSWORD).  IOW, why
isn't the code more like

	if (/* not using the more advanced method interface? */
	    !srvc->auth_method ||
	    /* method interface that takes password? */
	    !strcmp(srvc->auth_method, "PLAIN")	||
	    !strcmp(srvc->auth_method, "LOGIN"))
		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);

if, after all, PLAIN/LOGIN are what triggers password
authentication?

> So, considering the fact that the original code for imap-send
> was setting CURLOPT_LOGIN_OPTIONS
> unconditionally and
> was running the AUTH command even if auth was set to CRAM-MD5
> or whatever, I just preferred to not change that behaviour since I
> may cause some regression. There is a tiny possibility that CRAM-MD5
> may work, but I don't really have any free SMTP server which uses
> that method itself.
>
> In short, just to be very safe here, I decided to not mingle with the
> logic much and simple decided to use a seperate tested logic
> for OAuth2.0 and let the same logic be used for rest cases.

Don't be short ;-) Be long in your log message to help future
developers.  In short, you want to make your proposed log message so
clear that future developers who found this commit in "git log -p"
to come asking you these questions---that is why reviewers are
supposed to ask questions and ask for clarifications.

> "Set CURLOPT_LOGIN_OPTIONS irrespective of whether there is
> an auth method specified or not, unless it's OAuth2.0, where we
> use a different curl API"

That is a very good thing to write down either in-code comment
and/or the log message to avoid future developers come bugging you
with the same questions as I did.

Thanks.
