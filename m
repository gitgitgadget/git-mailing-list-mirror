Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E562628C
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159043; cv=none; b=XtznHT6TX1xvqTR3PmAn9ZCpiwTljhUvsG++IwEDPoZ8yGnzqEnDWx1NilYvghBwCwQ/e/TnQe3AnwGTkwHHfDGpQe3awgTW+TbmIJYiiCvAUPd6gQ4zX8ftoSImY5kWJYQA+wUpxN3s20uInXxz85D8qlmEz/2/RMJqbdw/uPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159043; c=relaxed/simple;
	bh=m9/+IIIuxLavT9JHO4SxepLSTugNNUkib53jKmnbYWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+f7GHVBTo1aOF6hR2hFAB/GJbqSBxtCe/VYMqtZ987TrHAy9wjtsKu0i13GULpnoRPYK56Fb1ZHHYERr0egF6p4QgWtvpnq99wAi64J8tTe49Tj9htyKEBdYAyu4TtFguVjOAzeVmIhN4qsx5OCGTm3MqNo+YjJ4b+a3Fx1MWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=THHskYV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHh9qlNb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="THHskYV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHh9qlNb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB16B14001C0;
	Mon, 25 Aug 2025 17:57:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 25 Aug 2025 17:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756159039; x=1756245439; bh=YHZgR9jn+j
	mGuQ30AlOfK4YJ6EvUPKohxmEWUE4WRVo=; b=THHskYV4S/1X9OEjO7MTVsEFen
	H/gYc/39m3te+gBe4rwOgKV+4hcnRompzaK8yZ6FPm049bfaJoLHPHyRYgd0CL4X
	O1MKlSEsBDMbY/8X/0n8FrhUcHzvohWdLV6jdvEFGNWPBhmvUL4OMpqSej2/WpP3
	MLFQ35jHL+Zip6pdc/DDO8NQ91DExXnKOHjiFwSjn/sUwHjEMrQiHipoZ8wzv3Z+
	ZgeB0mL5MPmXKrfWn1zG8NeXmKXHtxMSkLHFYw8Z1d+wBPmMxsNCN75TG8SJ4mP6
	OxW4TBL804L2j2vA1DJD3g6+q/YAP1kj9BY6znEQe2oXZCXP2gjMI90E/U8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756159039; x=1756245439; bh=YHZgR9jn+jmGuQ30AlOfK4YJ6EvUPKohxmE
	WUE4WRVo=; b=AHh9qlNbMoco9LtmYJuxKoiWR6Wxz067rFGYVMDoxQi9trydw9g
	lewoVb5wRDHi05iW8MDWPnUzph8npxoRYGDZ4UjFWo08gP3ywvRjSlP+OjnMdipu
	U9cSmh3Fn+myv4wmJFcginWF3DHWjdpblLR/2zwgn8YdcZIS2eco3wjvEZ6GeCrw
	G+NebNa6D+foxHZnUhsNeHT028nB8stLNuYx1m/eCHIc8LFxFSMV/6JKBZDQsllh
	wHtudVa7HfpoJjLDJMdib/lYEWhRkLX6JP31EIH+0A2wEjX0ru/a2xxOfzJaIon7
	c6BZCgPLwgze2VNCUPDXo0C5b9TvWhVL8Tw==
X-ME-Sender: <xms:P9ysaHqS9wfA23J3V3heNTcAxRJTZkvdagpq0VoARd7uerjGDz8ERg>
    <xme:P9ysaMMHZRTcuBh-khxdIH5aWVliSc4Iev04ddiaebmhmD9USADzEcUV1nykwtIcw
    1rymHnrFDLOZQQZ8w>
X-ME-Received: <xmr:P9ysaAyO4Y6NSmSIEOk0k_ayjKJETc9QWvnYyxvrrNMEaVYR9-w1GB-TJp4kd2y7Rkdfumxa-xxuPQJst0CRLxHeGXjoUyPSVddcBtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:P9ysaNt4-YNVysiaGYhmGGlzcpcTc5xkZVtW5Fj5g2V3iQ311vJ7Ag>
    <xmx:P9ysaB6FR_ZTYRWIxsHM2T9rYkZrALyz3sI9-XvoMWO0_ILi4FSAuw>
    <xmx:P9ysaES1n2F6uR-1DmefUUmp1pYC3bDw0vC16JeSToI3J8r1rLBSRg>
    <xmx:P9ysaIosuDuUsDqkPB3rCU1reTvszP1Kv0X44e0DLostV4TLiVlXeQ>
    <xmx:P9ysaNZC3uc-FXuq7LxKrXh4-yqbqpUPL17lvVHtsL8BFIFroKc2zpg2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 17:57:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 4/4] line-log: simplify condition checking for merge
 commits
In-Reply-To: <f98f3db4-cd36-4a24-903f-7aebf6af3d51@gmail.com> (Derrick
	Stolee's message of "Mon, 25 Aug 2025 17:43:10 -0400")
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
	<20250824190644.2573279-5-szeder.dev@gmail.com>
	<xmqq4itvp19r.fsf@gitster.g>
	<f98f3db4-cd36-4a24-903f-7aebf6af3d51@gmail.com>
Date: Mon, 25 Aug 2025 14:57:17 -0700
Message-ID: <xmqqqzwznjya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> ... but the negation and OR condition made me need to pause and
> think about it, while the positive of "does it have a parent and
> a second parent?" was something that flowed naturally when I read
> it.

Yeah, that I 100% agree with.  If it were

	if (!(c->parent && c->parent->next))
		handle_ordinary_commit();
	else
		handle_merge_commit();

that would have been very easy to grok.  I do not have a strong
preference between that and

	if (c->parent && c->parent->next)
		handle_merge_commit();
	else
		handle_ordinary_commit();

myself, but I always felt that handling ordinary commits was the
primary thing in this code path, which made me react to the swapping
of orders of these two calls.

> Definitely a taste thing, so I could see you wanting to skip this
> one on a pure "don't touch what's not broken" policy.

True, too, but the code that fails to be in a readable shape too
falls into the "broken" category, so in that sense I do not mind
queuing the patch, either (and indeed tonight's 'seen' will include
this step in the topic).

Thanks.
