Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF5A48
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151991; cv=none; b=GqkSg5gptZC6LFtwwWds04DPS13/y2UfRF6So0S6UYFuZ296mD/p2MCF/7tp3ADWxtKm33QxD8c05Ui27Ipxq6/OgNjxg/yQJQrt2a61tBNp3Grdl8jhvY0Km0CKFpt7/Do9k4+6OsSuy5yDEn6GfCzDqNmi0iZ0JY7FnxWcP6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151991; c=relaxed/simple;
	bh=uBCBa4azbyzZXtuFgx0BawKe6ohc47SrrL1RaMz/CGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXOBGrNN2J83n/VwMU1nClCHeIBtXcWszzbBDERnGNBO6LgxPO8WMRd/obQGYzH6UxMQ2X2tnvAieg/XPpqUtKpQNjKNy4bdegr/VHzmnJz/kq7UbZ/qVusxUtwABNaEePKrVxFERnSF6InzXjc3raglhFBOtWLOKKFc6qnWp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELdQgOa3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArQJ/nNB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELdQgOa3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArQJ/nNB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A4D9140026A;
	Sat,  2 Aug 2025 12:26:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 02 Aug 2025 12:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754151988; x=1754238388; bh=YpP95ncLPo
	gojV0Lrt4N5LYJobocrnj4TYY6z0YctxU=; b=ELdQgOa3uEsIZKRVDyGJiGpD+n
	2eoYll9w27sNDb3dK98exVMaJb5KPXgDZUpn0UuCZxUG0J1rnHQnXTtZzCtG/BEP
	u1jTWWCnJcQeVwbIc5GG/A0xRUFGOEcm/YjGRSKCvux3wdVb0mW4ixCDR2g7u57n
	yprxTw+ybEpESI30EjaH340V6UQV3bwOcJu7HqOwVr61TIx21BIkQiM41KcaFhVD
	CHmR0ffg9KpfiPZfVSNIxoohf5JC4coETY643CRre+BD0MtDQbsp+Ut5/nGT6aq/
	vGxuWQnmrnJkaZ9HMD+fyFZn9U7AfjZ3KihPkQWMGOy7slIVmVDTlD/ZfeNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754151988; x=1754238388; bh=YpP95ncLPogojV0Lrt4N5LYJobocrnj4TYY
	6z0YctxU=; b=ArQJ/nNBE+atX3VlkZcHvwMoh4XhZEuDaETz/knNDduCiUVBzh4
	UM8mPCg3C617yRH7b7/M+8joGoOTzfvi8XKpljp5RgGrIYy9qnKfXFXWdvMTsgV4
	R+z+50O7notj4bOqN4n6UzF3q9HKNAG+jsa5KFC5+llNVY4FBjvvD2IWgNwsALKM
	HvFIBnkUwdMtdYPMzwfFrAfLfbNRmtUbd735jNekHHfvLm9N8QXHiFaySyqNNgjE
	jiF8161UI0/iyQTmpd0de4cHMZK0WMgdmkCSe5BsGi9KJyrW/gwk3p4tkILQkYPf
	XuBH0iWe+E0pkxEp6w60fDdkOTE3YiSRoFA==
X-ME-Sender: <xms:MzyOaFtMsVUaB0FUPXk88vgwlclCNM86tovkPw-q_eP-nzDsFFzmOw>
    <xme:MzyOaKJ9oYguCEHHBBZcBiSpQ6Klol85gUTTulZe6Ivcmno-hLKjJq-B0_xUKHIHq
    7_mF7zGLN3UAacIRA>
X-ME-Received: <xmr:MzyOaFMLb8Fyc-xEVXDComUoU47mNUbcdGA4tqkS-O8l7gx7WNSdHEbJKKVgjVx3j2L29QEcBDVGlXfVoVneei1rqWceZEjLzdXH4Mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MzyOaFU8Fue5g0jOU1r3RBBwQG6iT6VRDgd3dSNaQ-BkXHs8SYmTIA>
    <xmx:MzyOaLmFCoxV0OmGENgknez26-QsxTYtSEi1I8lYocxkZGmYf_3-2g>
    <xmx:MzyOaMOO61w_0xSxKNU4hP-kU9a2HZYYM7BQ3IQ3pRlc6EBlx1Styw>
    <xmx:MzyOaLILxaqWB1efa6V-BgWPJiczQ4N68Eon_XgIt9iOmSJiY-ohIQ>
    <xmx:NDyOaKFJzHvUQUiJyFiwb2nfWM9DfiVUUJpCZzcG9quuPvCEUL6x2mMM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 12:26:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Toon Claes <toon@iotcl.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <CAP8UFD0Hrb-=TRNkueBw06Mgu6Hp1zO8qZVOFVLi8Qp4xkas+w@mail.gmail.com>
	(Christian Couder's message of "Sat, 2 Aug 2025 15:38:37 +0200")
References: <20250716133206.1787549-1-toon@iotcl.com>
	<20250730175510.987383-2-toon@iotcl.com>
	<CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
	<aIyVft9PdlorttzZ@pks.im> <xmqq7bznm0nk.fsf@gitster.g>
	<CAP8UFD3rV5CmHbbmg9vQodJ3U=WxfmWHnaio+7RcBAKz=2Ar-A@mail.gmail.com>
	<CAP8UFD1hdykpEaFrs1VoHbU1f-vT7xL2R6uvFWzjPQKRp0eoEw@mail.gmail.com>
	<CAP8UFD0Hrb-=TRNkueBw06Mgu6Hp1zO8qZVOFVLi8Qp4xkas+w@mail.gmail.com>
Date: Sat, 02 Aug 2025 09:26:24 -0700
Message-ID: <xmqq8qk1k7v3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Sorry for the noise.

When 6d0618a8 (Add Documentation/CodingGuidelines, 2007-11-08)
started a written guideline, the project already had two-year's
worth of accumulated code.  It was more like "we have been operating
without any written guideline, and so far it has been OK because
most of our contributors and reviewers were competent and
interaction among them amicable.  But now we are having more new
faces.  It is a good time to codify the rules that we have been
trying to adhere to.  It is possible we may have missed some
violations during our reviews and have already took bad apples in
the code base, but they are tolerated-but-undesirable exceptions.
These are the rules we have been trying to follow."  It is expected
that there are some corner cases that violate the writings without
meaning to.

Anybody reading the document should take it as an aspirational
guide, where existing violations (1) are not excuses to introduce
more deviations, (2) are "once written, it is often not worth the
code churn to go and fix them only for the sake of fixing them", and
(3) are very welcome to be rewritten if you are rewriting the code
that covers (not merely overlaps) the area.

And we writing or updating the document should try to make sure that
the aspirational nature is clear to readers.

So your intention to improve the wording of one single item was
surely appreciated, but I think the effort is better spent to make
sure that readers are aware that not just that single item, but
everything in the guideline, may have existing violations in the
code base, and they understand how they should treat these existing
violations, perhaps by polishing the preamble to the whole guideline
document somehow.

Thanks.

