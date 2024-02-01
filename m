Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726976FBB7
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809242; cv=none; b=im2Fbv52/58T5X9E1iYm2EXFpEzbcPnAb1BaPGd7yZ7YOMcI/H0fcApdWujKWucvDOwf1BZF978jyn9mRXqTo/tyMpD7ynj0sqyPJWhQ1tLSI/7TMvfIBcxTFv7IpYaBUfoDVGN6A5iIbruFfzGf6WVy3ijbmSfuIGhFs/GXzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809242; c=relaxed/simple;
	bh=GjHhJiyAegDUHLO7C9OhkEwp8PT4X77fK0b3YLOxKX4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=G2kUa7tmC7TxYUOEvFOQlXJAfs1xrEsD5etlncoloa/D+iixNJADfYJikBAQQFrTZK0japOLrkpcd8jFiddyAFdDPGw2PHVSNjY3KFHyNn/aA2/2d8og2YPCbYv9snevqLp0bObuyPjjiEdAlE+3RQauO48dBmSGzEuha0MCc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Ypw2vJTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bPg0mncD; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Ypw2vJTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bPg0mncD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 163031C0008D;
	Thu,  1 Feb 2024 12:40:37 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 01 Feb 2024 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706809237; x=1706895637; bh=OhoJuphoqg1qwTI9b6X0gcLxhRPq1k7f
	6RxSKLvbot8=; b=Ypw2vJTPfJ2hp+MV5liKVTSVoCj/3+MX6SUR1RxMWY6xhVca
	fH2UCDkkJ2UqjRPliMFBMJrmXoFGGWd/yqhiduNsmHbGsqwJHdYfdw+j553anJn/
	+XogvBsTVEz8ogrucNrjl+Fq+Q3skMaPN0REdcvUdwDl9mkEUdC1GLRoJrjtSdl0
	rvafhp28j2ORV2WF8GO5uuceiNaNEJerdUnEj6UYKWk+hFTKo7KwcFZ8AeZe+yv/
	kMmIJECiueYGb5kMxTTirjD1cwgxNR0MujlJN2SOzjC+UTbkqVN7lJQ8hrHxAPRX
	uHshzIe9LC3D833O3vytGrXHMD8BsAtDS4e/+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706809237; x=
	1706895637; bh=OhoJuphoqg1qwTI9b6X0gcLxhRPq1k7f6RxSKLvbot8=; b=b
	Pg0mncD1G3SZcPF51ozfjcoKFwmcrlQRlQKu8VbrFEUMYks1b5jwccin+Gbc6zqW
	GfqTPtUeYvfEwFyR2L3Rink9nwftEk/oSAVsHMxxxIvblI8paefMEzRieh3lCJMv
	gqOMcMy1To3vOc977DpKUzPN4XkU4bfr/fH9vjMBJ9RynxKcJplUe8pAvXHc3uzj
	3HxRFoZ8h28OYXkmP0lO1x+Evnq35E1NUufMkfVLpiaQnGFLAQQ6Dl0FeTN2k5H2
	qtaiVhEdrLm12aVKvd6FxRLlnch4B8Gqjv8Yc0Y6F2jslh19x9gSStqmgefWVjww
	LvEXNDmoPP+Cny1mC2tCg==
X-ME-Sender: <xms:lde7ZdlQiqjPFMLKmKTzjLMRztktHmBWkx7pFnDoQgIoAtHahlvFFvg>
    <xme:lde7ZY1-iQVZMxh3ne3ejDGoCkxUYWAlgYUv5T7DJ6jYC-aFtZlIHrZPSjoIvqI8Z
    j9we5GDyO8dX9UIIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:lde7ZTromcoKrObTQehz3Fuct4q2X4xgQ-YWnali5oQNap5jyi1cdA>
    <xmx:lde7ZdlohzCjfMbU0r4s2UfHKvjcUt4rZDlWjVw5CicyaQKFrV_u6g>
    <xmx:lde7Zb1eKmQGKgKymAxb6MqIKxaNitvS0wl1XYBGvPXqRkOpDgrtoQ>
    <xmx:lde7ZcxUYEO1K2QnNqCuBCZJ1AS3TyKDq0xIsE5D_cxaNIBBOm0RlDHMnQY>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 35E9815A0092; Thu,  1 Feb 2024 12:40:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6174fbd7-5eee-450b-a38b-1d1b695f6d14@app.fastmail.com>
In-Reply-To: 
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
References: 
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Date: Thu, 01 Feb 2024 18:39:30 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Hans Meiser" <brille1@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Dragan Simic" <dsimic@manjaro.org>,
 "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Disclaimer that I=E2=80=99m relatively inexperienced with this project
workflow)

My impression is that the email workflow is very flexible and
tool-agnostic.[1] On the other hand it=E2=80=99s hard to get set up in a=
 way
that makes contributing to a project as easy as contributing to a
project that is hosted on GitHub.[2]

=E2=80=A0 1: Konstantin=E2=80=99s reply here seems to confirm this. And =
thanks by the
    way for all your emails on this workflow subject, which I always
    enjoy reading. And for your work on tooling that of course other
    email-based projects than Linux can use.
=E2=80=A0 2: With the assumption that you already have an account there

What would really =E2=80=9Csell=E2=80=9D the email workflow would be to =
have some sort
of program which can set everything up for you so that you can track
your contributions as easily as a PR on GitHub. Of course people use all
kinds of different platforms, but let=E2=80=99s say that it only was for=
 the
latest Mac OS (this is all hypothetical anyway). All you would need to
do was to give your email credentials and whatever other technical email
things that are required. Just install one program and track all your
patches as well as the replies on them. More concretely: maybe it would
have an email client which would make sure that all your outgoing emails
are done correctly. Including things like not mangling patches in your
reply because of hard-wrapping or something. (I created a support ticket
for that on Fastmail yesterday.) Or: let you immediately inline a
=E2=80=9Cscissor lines=E2=80=9D patch into your current message based on=
 a commit or
just your current working tree.[3]

Also: never having to copy=E2=80=93paste message ids manually. :)

(Again, all hypothetical for the sake of the argument)

This program could be very opinionated and dictate a very rigid
workflow; the point would be that there *is* a way to have a setup which
is as easy as GitHub (modulo email credentials/technical
things). Because then if you want to customize your workflow you are
still totally free to put together your own tools just like what
apparently many people do right now.

If this was even just hypothetically possible=E2=80=94I dunno=E2=80=94th=
en that would be
a strong argument in favor of this kind of project workflow.

I think that would be the best of both worlds.

=E2=80=A0 3: That also sounds more convenient than pushing to a GitHub r=
epo. in
    order to make a PR

--=20
Kristoffer Haugsbakk
