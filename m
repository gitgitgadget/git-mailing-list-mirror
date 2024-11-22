Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82723098F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250093; cv=none; b=OMilWvtOENd2dmFoMnIamXQAEcNO5bQjGIn6gqC+p/uKBHWZUCBd8hN8YnH5HOnGmywe4mQYfS1tTs5/nJwr7uLtF6P+97GYVf5SrhCN7qfIbygm5MgG+pRoIUTGbBF4O1FkF4lYEQ8jOo0CBqtF+XyRrkZ8HSazS8YaSh9vkas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250093; c=relaxed/simple;
	bh=TKCRJmQBYo8BhbAl3opklU4KLEatf9xb6LbyX+n6rDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XZWdEdFZ/o90yg28g8VQNvlear3dfsNHaHDoJYS+snffH7w48R4Gwh/NY9/MyUh65sPZBXNLQ8f2l6RJrM07lC83odHP0hKrxmOEWvESWCmo90cfVgnOCOXHihZHxBZAucXsHQ+ASod0e9fo6Io3JtcFP3lMaSJ1Z8OyftZSiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gng2C8KE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gng2C8KE"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A17011400E3;
	Thu, 21 Nov 2024 23:34:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 21 Nov 2024 23:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732250090; x=1732336490; bh=TKCRJmQBYo8BhbAl3opklU4KLEatf9xb6Lb
	yX+n6rDI=; b=gng2C8KEIlN7rZpV7Le6PnS5BUv/wqyHtP58Vl6xXr4BZIsAzEu
	st2rSZd/k7p7h6a4z+UPmP82A0ThZ6QmR+vLX1xD2gkQeC+c+rNXEiiK/5DXvA1T
	ZQ4JluotH7FHNI5d0qNm+qE7IGjXdI7qCBzkqHMc91UVPRteSVY1tGNP84YrZOCc
	cIuaeDxrlOFlnN9BZRp4BGqpuV8/wj8UL3684CcnMu3ZS/My2CXFiJd0NuqkGyhV
	G+Q9EaON2JN50pNnLitL/7W+QHagmNl/6Ubs17z5Vkz13YFftDISsDhIYxMkX20t
	4JIxgQk8A0LkIXY3DG6Q+sGLr2BWupV2b7w==
X-ME-Sender: <xms:6glAZ8E1yGgs7i31r4ZM9QePbD7BuCCtRb99eA5T1EgnYxOhJezeTA>
    <xme:6glAZ1VlbLFIXmQ4qAzFEG0ed9xfqeUCceDuF3gnQ053ch4VCOw8_OzdhKfQbgdz4
    EkQcKOFRpE3Xqet7Q>
X-ME-Received: <xmr:6glAZ2Lb7QUOk5yPwEYixFlNW6Ib2NSrSKIsqcSoOFYI4np7vCeHyru_uaUfVMxEDK7SL38jQofIRZj0Ctig5xcDZunHsX6G2Ik2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:6glAZ-Hgm7h-DZzcrQY4LrEuKQVa2BjMWHEayxsu00O-CT2OEMNXSA>
    <xmx:6glAZyWqGFC2Z3ykorOLpZH2JdvUthi2Wtt4zTV5PgLSmd4jzS1MXQ>
    <xmx:6glAZxNMYLQJOJveLpkHwHWYCepKaJ4i3eT6lk00hQTRGTaWnd7zdg>
    <xmx:6glAZ50He18oCPdrkxh2GG-DFY_majcRaQCNC0UyP3YG6nqyUxt9ng>
    <xmx:6glAZxQBEcGD-srBmueNuuH4rwiBRMuvVWhUGI5PeWSbq091VGsHcTRm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 23:34:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
In-Reply-To: <Zz4Q+2X3wXhLO6FE@nand.local> (Taylor Blau's message of "Wed, 20
	Nov 2024 11:40:27 -0500")
References: <xmqqo72ai929.fsf@gitster.g> <Zz4Q+2X3wXhLO6FE@nand.local>
Date: Fri, 22 Nov 2024 13:34:48 +0900
Message-ID: <xmqqr073antj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> One topic I did not see is [1], which appeared not to be picked up in
> this or the last cycle. That topic has been reviewed and should be in
> good shape. I think the thread died down after agreeing on some
> potentially interesting future improvements we could make, but I don't
> think there were any outstanding issues with the current patches.

I didn't get the impression that there was a general concensus that
it was a good implementation, but perhaps I am misremembering things.

These two patches touch only the test helpers, but I am wondering if
it becomes easier to implement on top of your later changes that
allows the production side to also access the unsafe variant of the
algorithm?

Thanks.
