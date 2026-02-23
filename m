Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1332ED58
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866945; cv=none; b=e4g1LnlQ/r2gyCRhiFQF7Lv+rkZEBUO0p4BT/QZ6z9rHPrkuYF9OzgCfa4doDOzUmGOxEv1pzkFvD+QSWuN7uYkk03WWI2VU8XMoLCL2IEvUvTOKOiKrvTvLoSN8+QxRtoWteJndpXpXOkQGGYVrCEECfWTsG8h0oEbCqooGxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866945; c=relaxed/simple;
	bh=sgX8b6auet/c6pJtMdAEkO0T5SHXycdUsenaNevbMr4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E1eaFC9tm7btbWwyFKCn6m1PiF+SNSx9dUywF3VxWvLPVZMkCFe6pvcRasXbe2MwJE0eYr4WNc4h8LlOPkqvSDqN8NcBtaZynsq8bvQganaS+gbLGP3/YonMUF2LFZQhQha7nIq+PwG7ixCPkvBSrw3oj8fiApPuQ5H3AGhyXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U5kPfrHV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IwBBMG5S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U5kPfrHV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwBBMG5S"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFBD914001AB;
	Mon, 23 Feb 2026 12:15:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 12:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771866943;
	 x=1771953343; bh=sgX8b6auet/c6pJtMdAEkO0T5SHXycdUsenaNevbMr4=; b=
	U5kPfrHV9p8dBq5IefUnSMbN0e90cyQbK8zFfNH6zlYpqTG7YPWbPKgQaL+WIeqo
	yx2CTinbz7gIHJf6s4xEwWOdrj8z6mEd7sUtnI5Cf3gR/qtJpBlwaDuzhlWKmYlf
	84b5ORmXehQNjJ6zdvK6MU+ho2SwL35+l1Yf5YNa5I1E6pHDnYDguVi4+YFOSoGF
	FdmNbW7YtqPoNopF0wq4v+0iO47QYSsSk5hoedtclHYYln4ENzyR2sb/i2aENiXD
	EKhCOxGD9P9gmrNiMwviq4jRxmGdz0/JoKUsgUFv4QrbVNmk3HbDRfK7EMUDH/9b
	wNVSJuN0qrzz6qhEhMDcCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771866943; x=1771953343; bh=s
	gX8b6auet/c6pJtMdAEkO0T5SHXycdUsenaNevbMr4=; b=IwBBMG5SBTqta3JYs
	ESdzyNGNBFtZrhU5D3CELJhwdrsS+sTM0BokSARRTATrSVfuRc29scit7TLZsZSd
	dggvqqLYeEAPcQLjtt3/EDd1TJfYZxMDjuBrR5ZLoF4IjcEqeTQVkGD+HtpIjvUE
	Zjg5BXTYaJof/phD3oyCjxyF0mfm5jrIDjm7Oj4IFwpSPYdEHhcx5SsUR1jev6dp
	xHPaQqLLzsAOGbdr4AnsP6i7dopse1RDOvLg9C6LQ7i7lUX2cKkBakqEJ6Bgohgs
	dyn+4yuwk1RoRnX8YZ/K6CKTgTW3H6vaRaYOvWfOcSCDX0Be805FhRExDHvXVJpU
	7k5RQ==
X-ME-Sender: <xms:P4ucab75SdQCZjkfSU4zSdUk0t5NJ_njQ9sAfSOO6hmJhMm99Xe9-mw>
    <xme:P4ucabvdlrR1FAUie6Gxw8mcH0r9v8FZvjWpfJIc8dZERnO8GeHISrl5p6iYv3Gnv
    MylsUQ--2x0bcCDwU3dGew96wsl-63tcYCIsb4iqqnAUExVxj_S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtsh
    hhuhhnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:P4ucaWlMHuB5JbSwJr7hHizy5qyPNBO--A1SkGkPhtFH4zH5ZFqrTQ>
    <xmx:P4ucabwnM0yqmjQpo6G8hRLcts66Hk9nimlYPoDU9emS-JKTrg6jfg>
    <xmx:P4ucacNQkfptoBdM6pFoozcLlazdWVzJ909R57JWcCiggzsaogaz_w>
    <xmx:P4ucaXSAymlBgc5VQCrm0hehWGDtqDHbIO0OOCW93FxKNIBOBcdHtw>
    <xmx:P4ucacf16cjZTO4XTvJuoZTQJnmnMowlnm75FMhBZh-pie9khS_aYA_e>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B99881EA006B; Mon, 23 Feb 2026 12:15:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApPrxj3Ujcv-
Date: Mon, 23 Feb 2026 18:14:58 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Au" <cshung@gmail.com>, git@vger.kernel.org
Message-Id: <92e33f7c-f45f-4f5c-9d51-83ef6232364b@app.fastmail.com>
In-Reply-To: <20260223165147.3294516-2-cshung@gmail.com>
References: <20260223165147.3294516-1-cshung@gmail.com>
 <20260223165147.3294516-2-cshung@gmail.com>
Subject: Re: [PATCH 1/1] transport-helper, connect: add atexit handler to reap children
 on abnormal exit
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026, at 17:51, Andrew Au wrote:
> From: Andrew Au <3410332+cshung@users.noreply.github.com>

This email here,

>[snip]
>
> Signed-off-by: Andrew Au <cshung@gmail.com>

has to match with the email here. Or probably vice versa since a real
email address is better than a GitHub noreply email in this context.

Maybe this was just an automatic don=E2=80=99t-use-my-real-email-address=
 thing
that GitHub did?

> ---
>[snip]
