Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969432E3FD
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147113; cv=none; b=SVQ/hUqbubDA0sJyvQYdkigIfTIsULhbpjn/dACtEpl/LNaT9jeosORBkFfjTD/WFZoxien/NiIsSdq/bkU6uABnBGlk38dvvH0fyldgr/EUMdbyp8mft08VKrDabTVLLGb9Fi5a0Gir+imHkSI05aTp/aBkRHeFvTEt5YOhiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147113; c=relaxed/simple;
	bh=xDFbjrRU9DwXdD2edsA3pkWhBHVZGQGxWrIwouDK1Ko=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dSk0dDSmKSwb+UiiajvZjtPf/CVoFfyL+9WgB/jszjPL3nYPr2xaHqdYZBf+mNO9hcLCjrPYwpj8ba1ap5yxyYLHtPWLOEgNi/k9KACNhE4RMbA4kFjG4gauBnuZM+5mlqmsxeMMZvx377svcCLAxr6fJLPQ98qIwUvn54V/EF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=AWYuwRQS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WwKTGpZH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="AWYuwRQS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwKTGpZH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A2781140074;
	Fri, 22 Mar 2024 18:38:30 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711147110; x=1711233510; bh=yLr/YpeHktztviVnCb7haMGvJUXPrRSY
	jzPTMyRUU2E=; b=AWYuwRQS99jX48obYUD2ILwqi3YWyti9IsLPzW3khgXtXypQ
	1aYsm2yegwgn+K9U2eRZ8O7HJ4q5LOtOx6TQd5hi1IgN0LL9s50a7uCe4QINz0ym
	Q8tXHWRkx6++D4l9nBD+f2hanB8deoU+EWXy6rdJJd5QqeFJrOZkViZCjfmGSrv5
	8Vlvs7n2XTqc6NEmshksOjINDYAGBVzqild1TfAnYEUc/tfPj7B4mlC9KXjvB+Zg
	FfHI7/RmJSUDM8wFoXlh7GtW3wneCsmjBNNTQOnixtQSCF4KF6LXdYyeDLQenu/X
	fAtoXizZBLitVvOP2OvSkfWhw90IDC1wg+Vi3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711147110; x=
	1711233510; bh=yLr/YpeHktztviVnCb7haMGvJUXPrRSYjzPTMyRUU2E=; b=W
	wKTGpZH4CIXvNBlqzWtzs4arnmWwSz0tulSPzuUT77Y71/w1FU5qGv1DKPlQiLQc
	nEdWmUgQ+GBmreUFo4w6pvaZI8ooIdYxrA2tY47B4zt8V/f06cGufxVe3OHYPjxw
	gHllUpZeNGHwBFAZPsmQK40TpA4gGGHa4jvuwhDlXP5lXWsS/fBbAXHalOrFq8v1
	B5js45v7HDkYjpueL+RyyZtrTcAH57yJaypO+yEE08e/7E6zTqsN9dUJVoj2B8MQ
	NjofymOyzz60an0FCR6c061RVR2cn/4cSyOVrEBtgDrhINJIVMbZkq4ZV3j+qQeQ
	kczPUOme71lq8+qxuDJEg==
X-ME-Sender: <xms:ZQj-ZZDC7zv1T30OoRjk-jrKJOXeF7_sHAHB7EhpdDzmaRbh848uKQc>
    <xme:ZQj-ZXhTmXLHGkXYdTwW3wa-yAGgNDzD4Woo8D5SWCHKvnqhar03tx_p0G9mryynB
    QQuBt0jj49xtSGi7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtfedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ZQj-ZUmyRoa1Gr0L4jGtYjGv4-J_ALzIXtReh5hIdtxGTStmw85FAg>
    <xmx:ZQj-ZTzrdp5bYEC4SVFcwIdr-eiZVDA10cyv02IPIC2B3VVUi5lo_Q>
    <xmx:ZQj-ZeTUjW-sRC1JOLflA-_VvCUv3v7kksrZuYNk0XBzVoUg3VMYxQ>
    <xmx:ZQj-ZWYZv2fXZVTL2q9K4nFh5YXTqtlAxJTn8bwTUIjw-PZkyHMyjg>
    <xmx:Zgj-ZbSrXhAV6vYC3BYUix2QkrBVBhQhoHJ-wZVRBV925OsbL62gmw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8241115A0092; Fri, 22 Mar 2024 18:38:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b9dc977-e8f9-472f-8476-1b13fa6e6d93@app.fastmail.com>
In-Reply-To: <20240322221327.12204-5-mg@max.gautier.name>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-5-mg@max.gautier.name>
Date: Fri, 22 Mar 2024 23:38:09 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Max Gautier" <mg@max.gautier.name>
Cc: =?UTF-8?Q?L=C3=A9na=C3=AFc_Huard?= <lenaic@lhuard.fr>,
 "Derrick Stolee" <stolee@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, at 23:11, Max Gautier wrote:
> Notes:
>     How should I refer to a commit which is part of the same patch ser=
ies ?
>     The commit id will change so the message won't be correct anymore,=
 right
>     ?

It looks like a fair few say =E2=80=9Cin the previous commit=E2=80=9D fo=
r the one just
before this one and =E2=80=9Cin a previous commit=E2=80=9D for some comm=
it that was
before this in the series but not the immediate previous one. I guess
that=E2=80=99s okay, no?

--=20
Kristoffer Haugsbakk


