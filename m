Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5B3271F0
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395191; cv=none; b=ZRev6pJjM4DKx8EXgmjfrbioiXp7/Vq1Io3cies0mDYyIMWSeEafbhBDP0wqdULMItBWCjokvfZDZqvMv+EmtLQdOPMgfUTRSXyGrEePIlmk8Qj+pKIUf34ZTNSDMoHVRu4HJUcOQ4vlNsQgEPTSZ33flaRbbmI9oB0atjaOtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395191; c=relaxed/simple;
	bh=uRCoFXbKTrNlrZRNPypc+ZkXK+BlWe9zicMLYsM3h1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1Raepadhti8Paf/UomV9UIq0E6EUk98JHb2qcJdCQOc2hNTveWuvPJsDBV5ow3KM3IqD6HnAdkoYQHmBCbaqGStdgBC6k3JB1dBpjCQ5kp8OysI/EvqCpoietN/4THWwg9Qb83i+b5UAs0kztmWxfDBAu2iYatdVLfkqPa3PN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FG3fqYA3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeGLDdgV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FG3fqYA3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeGLDdgV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C382614000C9;
	Fri,  6 Feb 2026 11:26:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 11:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770395190; x=1770481590; bh=cpcsTx0LZU
	Znz1oA2TfZOejkJYAn/ssWd5EYd4fc6YA=; b=FG3fqYA35arELkuKH0VbYtYnJo
	RoLJyR6ZJvPm8G+4NceiG/EKRFtsgcz739KYClKZLT8vCFRHXoFd/xRV0D4lkdfr
	yctM907jxGmkhuAUoEfu3t9Z4A1uD03tRIS/T4AlH8l6l+prYGkiBT1rBVAKe1PD
	koNTgEssqZbGEr097xbxkFjMhqtYgpp5T4XQZjmuB+xYLd1mVGEB+6kSsbXevdEd
	EBgnAy/2pi7vgTmjBVFoNDav287amZfAklIrFLsuUGK58m5+oL+XAUb+bLIWjd4a
	/J/T6MfR21fOarITBMWbE2iDlgBkfa2K++i5FYlPyBSWzEIVF5dJPNiCtZdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770395190; x=1770481590; bh=cpcsTx0LZUZnz1oA2TfZOejkJYAn/ssWd5E
	Yd4fc6YA=; b=jeGLDdgVGIr6rE1zh6jy1pT08szKPNOwNhhRmZQPJ0xRUuN5R1m
	7KokvrqXMQ5oY2AtR/+0mN0+Qk7DTTbFX8/pEAYH2cJsEPRkktX3aHNeQ7dC3ZVM
	YOtRfwF6S9lablH/EHwGnitFyCpxnMY05H9loxhX/BvzyB1AhKPeS0BdCxbkVI/n
	pyEFIgySUHqyPzMBYtEhReJbLprn3Z4FgVH6RRj/b9n77AOVEY2e4UmPbBQaXco8
	BrUvLR6RsdDci4RbvV/o3gvEZC2PU15/QsRx6yi1bqGvGQU4Jx0Q/VxXnixHlX0A
	Uqd53tfG4rLUgWjdEA7l2QzJjCO9CzNhTUg==
X-ME-Sender: <xms:NhaGaYf7Llww29aMV_YP0kzEjybKmLNl058HOquS3rgwoLSR86ETsQ>
    <xme:NhaGaZRd2fZ1mn4zVWYOwwVFdjUFOrbJdj7BNDA3JhlZaRnr5gef-rPKoMaBL7qik
    boCl0qHJXWSSWjouxS4JJV1NIWmbcVQk2MppwnuEjXias3LhN49wyA>
X-ME-Received: <xmr:NhaGafuNnJRlcHHT1FnuoV5WtpwRwbt-8-kwBbA1Jv-IDSIee7NV3FnQ5u5pvwl6bUIXpsnYUc5750twTehG0mmgxLiXQWJmWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NhaGaacThfCdCMigBMg8nI11t7Gp4gF9MIDUt1rgdKJMthf3FlBTsg>
    <xmx:NhaGaZb2gxCv0J33SmQNrvEJwoP2J9kbNTHY2oaU99TN_7YNXwoQOA>
    <xmx:NhaGaca_ut7xNw1F5jyEBm7qlL1vcb3fxf1mdbAz4MiWh7S-A0fA1Q>
    <xmx:NhaGaeLbGp-huB352ggGjvwIVXbY1ZVCoAwwa9QzRRja50WgCmCEnQ>
    <xmx:NhaGaQAmosEtL5O-5hgmoi3ga254yC4hsvgnWTaihOc0Yt4XjKsx-R93>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:26:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/4] Specify hooks via configs
In-Reply-To: <20260204165126.1548805-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 4 Feb 2026 18:51:22 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
Date: Fri, 06 Feb 2026 08:26:29 -0800
Message-ID: <xmqqjywphm8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> This series adds a new feature: the ability to specify commands to run
> for hook events via config entries (including shell commands).
>
> The config schema is identical to the one developed by Emily and AEvar
> a few years ago [1] though the implementation is significantly different
> because it's based on the new / cleaned-up hook.[ch] APIs. [2].
>
> For simplicity, hooks are still executed sequentially (.jobs == 1) in
> this series, just like before. Parallel execution will be enabled in
> a separate series based on this one.
>
> The hook execution order is this:
> 1. Hooks read from the config. If multiple hook commands are specified
>    for a single event, they are executed in config discovery order.
> 2. The default hooks from the hookdir.
>
> The above order can be changed if necessary.
>
> Again, this is based on the latest v8 hooks-conversion series [2] which
> has not yet landed in next or master.

One thing missing to help those who haven't seen earlier iterations
of this topic is why we would want to do this.  Instead of dropping
a shell script or a custom program "foo" in .git/hooks/ directory,
you can tell the system to run program X when you want to run "foo"
hook.  The reason why somebody may want to do so is ...?
