Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEA1F4191
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333589; cv=none; b=SJm8sHo1+K0C8HgalGyHKPEOyE+3XICFXsnLelknUgMHJolSPdmOy0v/UpTNaTV2wHTaJE+dRjtIXwmWrVw+2oK3OiDViNDkNcAXWQv9rpdFGaZC3MVOZfP+kjNZmh1MKFJxbxGbI1L2c3cc6EGqJPXvZZIc4gHGwH1bk2pNVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333589; c=relaxed/simple;
	bh=ZiGN2I/Gz8K/pAY+ofQiiATBAbip6JNEmvTL9la3mNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WKDFrpz8IHsLvOikVDXPHPeqllsQtaEmrM0MmxMe9omIAuX+QkECDhhq96etkOPStGsrmSagJefkxg5zRTVpIXJiK9LLbviZsJXRZ/MDVYkGdf0kIRxqcvLQKUARBDb5gjaPv2ZlTLcuXONk5jAL+nCbpyP0AOAQXrUPfEd9Njg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xUnl1laI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuVitUg/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xUnl1laI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuVitUg/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 317561D00096;
	Wed, 27 Aug 2025 18:26:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 27 Aug 2025 18:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756333586; x=1756419986; bh=WFuSCkbMw2
	G87E4pCbAhB9h2m8EteQaSlILIIGd7UGw=; b=xUnl1laIAjQgqmCUJOeedtqMS4
	IqA4rY8ywuB1vVo7CnBDQEdHBsfEM41M+X8M2JHL385W0YBxdjtUDJfPVe5ECK2p
	+HmPpU93tgHVMPLX3oiXjXF4ikH7XdcpxF35CRrdJc6O5HZM98eEVyTl9mhcFfYO
	bq4Frie7c4HZpuDcmiulb4iSAHYnkis+gv1fQfLqWrZcpBfFWLaHCr69it8MskEU
	0z/ik3SPKuVgvn0pZQdnco9Sde4+Y3w7V7rAw9Sjb5AZnTKGsBIcV4ViyAnuK5zc
	zbpI7zXJURLOKszcTQmtRWsS4SsoG2bySmxOWbmYOmFwadCld693PpK9ip/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756333586; x=1756419986; bh=WFuSCkbMw2G87E4pCbAhB9h2m8EteQaSlIL
	IIGd7UGw=; b=QuVitUg/pwErc4BjIyN3OFWwzF38lNxQvbpVbwq2yBRTymoX0Q7
	MuFmH7OnxI69nV3/hAJyKGhvwrZCtge9bDr1anZeu/vnExnmJmLwRWw9NuVOQwy2
	O2QHp2VGtVzthDek/8rHiGDEp4vdCk/DYMo9HEsW+OWK68tgH79q4uCIit31kUVP
	5I/6rukhMDLNIW9t4Ylxh0jFx8SxZOQ6e/WYhUB4XdiZoNqqpxEVsgMLQskU2lE3
	woCJgdqTiccSZFbyjXBgUS9E5fur1DlLsFSMF4CFSY8WOTPJDgSAP7QBFhgZDh9G
	6WhPPOPROu9NEZPmxn8Yhn+fXK1NV6adpFw==
X-ME-Sender: <xms:EYavaBo-lNqb_odhMCMa1Y2hyoyqmd_bExChPRl0wpx6D1NZEjk5UQ>
    <xme:EYavaPJf9K9LmqAVRsHG9vSrS16eYqIvjr_OfXN8xTpOWqGJGRuwcqGluhTZr4FRK
    56__eIh1LjJhpIBuQ>
X-ME-Received: <xmr:EYavaEpw-U0LAX2QylNYwJgFwC-LJeCykCJhRHFcqp6GxTK2flcD0pNpQp2yIwaN6ydJblFDbhWk6t28yfs2Vi2jcXqbH5ticJOBZfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EYavaHwIZTMlH4pk5bPZrNCIGhDT_59bgnRSw4uKoyvBHFtMpCBAyA>
    <xmx:EYavaINe8AV1Qhdx0eKNKshV-EjDJLzfdqxJItIuf6wQ7AK8PV5e4g>
    <xmx:EYavaM43P42aLz0AuAwcTZoHvMLhylO3hF71PhLpGYzkM313GRPM4A>
    <xmx:EYavaBkYZ_12u5IFOS-PBDx2AzuL32cycQMv-JAh1Ruvu8lI3pp9Ow>
    <xmx:EoavaHgKixgxBbdQT06W92ow-sotuRQiqaOWiFJTiqm4fD6mRlhJmpLm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 18:26:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] usage: help the user help themselves
In-Reply-To: <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 27 Aug 2025 17:27:15 -0400")
References: <cover.1756311355.git.code@khaugsbakk.name>
	<e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
	<9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
	<CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
	<xmqq349czcl8.fsf@gitster.g>
	<CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
Date: Wed, 27 Aug 2025 15:26:24 -0700
Message-ID: <xmqqy0r4xuy7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> command being retired -- was to reference the provided hints. So,
> something like this:
>
>   - send an email to <...> to let us know
>     that you still use this command and were unable
>     to determine a suitable replacement using the hints
>     provided here

Ah, of course, yes, with Kristoffer's update to tell what the
alternative is, your phrasing is perfect.

Thanks.
