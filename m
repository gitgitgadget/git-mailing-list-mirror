Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549426B2AD
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191042; cv=none; b=KX1Esbp8uyl7ksbpdJZjcWDXIRh9C/inNrb0Lj/drO2liQo/ZwOD4x/gopAp0aVKPH8xiMyFd9id1o8gp9DcZKzD+AYfb76YZHSC5GPWIZlJVGO4dU+J/dk5xEIzQuLJmjIoGxCnSyyNgW/AnbDNtXXFPcqFDffkRQY0i71BbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191042; c=relaxed/simple;
	bh=hsnN0sxEjmJQBTQBb+9HlVLrrXCxfuqc2ZZ7vy+ZGE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cT/EyvGWx0D5xbVlCKqhcrRkmCaYTPB25c8MbjMULw3/xZtZc1PPcUGNB6zft4BkIH/Q/4+ymjn04ATZkQXqDs5q6fepbS/dIZbFX3m0RB4UC+SDz6m5f8i3MIoD7as//z0SC3rBjhMEqFbVc9LIDUwK/+GsiUJrkSehCjxzB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YJqC3jXa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2CpZwgz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YJqC3jXa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2CpZwgz"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C82AA7A0095;
	Fri, 23 Jan 2026 12:57:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 23 Jan 2026 12:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769191040; x=1769277440; bh=Xf9m2Ws/Qc
	xQEpyjI+CewdDndHTHPBVXOxuZrSTG2EA=; b=YJqC3jXaqP/FPKnTxwMNWMR4hU
	OQin++SwZ4xU14yZ8orvq7kSwBkR5bHxQGs9+gp2k1/lYR2ijaaRw0L6p4ckVadG
	BtqUW5amvGFAx+1rmg4cFZ2Xf+F5Ii80rhore7SxJ/NPNsb3iqhnr40pHsKkjajS
	7J8mD924mVaSvlKV+ADdCFqAgwJJcHZ9Vj9BmpO6gKtddXRiYnhpxqdhgD4OXmN4
	zSZlz1BD1kpYrjsvFYl0LzqRPTauMZZyQqbH7N0NOCZr7tey7d2Sm7SbUsDNzkfw
	W7PdYTcsPL+EkcAL2dm1bh8T3m6mwr9v3Gwr3XDnd46huR7ESy25mkqebw/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769191040; x=1769277440; bh=Xf9m2Ws/QcxQEpyjI+CewdDndHTHPBVXOxu
	ZrSTG2EA=; b=V2CpZwgzSJtSSBkt8OhOzWPrPHGFVUPt2kHS+28vRHlCkNZiGIf
	DwnPx3CIfAQeh0JYLyk/faSU5hZ4LMSpAX4akBKkHsuTuSyZ4jGzt43u8+Lyg9ko
	vQJWwr1KjdqZc8zssGlW2RwiobU5/OPOoL03M8iHImefV4Kry7rt/tD4rOWppbRi
	DiG/eJjYnQBEXF5Fk4lNbpe2kvnHgoJAtFScqFPbhmmulcmYATrRMjXUNKfsrc2a
	OuEWWpZxRFni54zW++z0ivvaHIw3VqZZaRdpnEC55eUJAzQyCNHMJVjlENF063yK
	paqr+BnmoSoxIm1HyJ2P+HsJ4GIXgpTm8Dw==
X-ME-Sender: <xms:gLZzac5drJmaCHihJOwyiswCMw2zNwXniiHk97L1BHitPHza_QtU2w>
    <xme:gLZzaRlGBGD3J1kxyX5TN9KIXZKvAv0S2eGUiBig07AoTXJeEjdOpm2BcC56ckowO
    ibZMQ5W8GBmgReuSrM_xeVbC6Jdf790Cjup9MpAk4-QW1a4TtvY1g>
X-ME-Received: <xmr:gLZzaVSpm05rCcgG9euie5OpE8hnf3dgFs0YkUzSsTlBP5eNFvcgx5QvX47LH6oyjAkXz6Zrv4OXcees6qCxG_ogS3aEQIm_LS9ujJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gLZzaYEAxicGbQqSSAy5Za0hcofKLK3TtTmZw_L9by4_rcDwejmR6w>
    <xmx:gLZzaSHsI4-DLO3WYY26FY2_y5LboQ7hw9kE01sxRREJl-uD50AahA>
    <xmx:gLZzaeRODRQymvDMeYL7nlC4fxw8vWC1INcZMFmgezCeJM5nih6hOQ>
    <xmx:gLZzabLlw_49quwTRDvQDWI8yN8mMyh3MUWI-Ny9M3dJnLOt-tN5UA>
    <xmx:gLZzabDvK4WmXugYi2GQgAWZ44RGWyFGE9nBvftVP1KlDz0gxcxhn9ZK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:57:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 6/6] fetch: delay user information post committing of
 transaction
In-Reply-To: <CAOLa=ZSLPasvFrCgKzVOq7mDXiqX9SxoOf0MZdzBXOLn73okMQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 23 Jan 2026 09:49:46 -0500")
References: <20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-0-2ddba0832440@gmail.com>
	<20260122-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v4-6-2ddba0832440@gmail.com>
	<xmqqldhpmmrw.fsf@gitster.g>
	<CAOLa=ZSLPasvFrCgKzVOq7mDXiqX9SxoOf0MZdzBXOLn73okMQ@mail.gmail.com>
Date: Fri, 23 Jan 2026 09:57:19 -0800
Message-ID: <xmqqjyx8gqkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +static void ref_update_display_info_free(struct ref_update_display_info *info)
>>> +{
>>> +	free((char *)info->summary);
>>> +	free((char *)info->success_detail);
>>> +	free((char *)info->fail_detail);
>>> +	free((char *)info->remote);
>>> +	free((char *)info->ref);
>>> +}
>>
>> This answers "no" to my previous question.  These are not borrowed,
>> but are owned by this structure.
>>
>
> Yup, cannot be borrowed, since those go out of scope much earlier.

And the reason why they are marked "const char *" which typically
signals that they are borrowed is?  After all, that is where these
casts inside free() comes from.

There are two schools of thought.  One (which I originally was in)
marks resources we own with "const", if these members will not
change once we initialize them and we want to avoid accidentally
muck with the contents of these pieces of memory during the course
of the program.  Those of us in the school often have to cast away
constness in their calls to free() like the above.

But I saw many of our developers squarely fall into the other camp,
where they always use a non-const pointer to point at the resource
the structure owns.

The latter school of thought opens us up to bugs caused by mistaken
code that modifies these memory regions that those of us in the
former school would use "const" to avoid, but it makes it easier to
reason about memory ownership models by signalling if the enclosing
structure owns or borrows the resources.

I'd say the latter school are majority of our developer base, and a
lot of existing structures follow that rule.  I was hinting that we
may want to follow suit in this new structure.

Thanks.

