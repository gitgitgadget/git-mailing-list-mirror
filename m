Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A11EDA3C
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000763; cv=none; b=eIejTMsFVx7kwzNFmJYTfk4MzubE/NhA2zcZYsIadzBZHADNwpezzgJv5WDzSBydCT65TH3AhVFB+2VRqSoWpUFJRJCzP2Gujq02hGk30qiJnPY2DkyZ5O/NRwrO+EdrZv4eDKBACrnaXZKN8sHG0kdsEg/vLeHiNcMPM7wNv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000763; c=relaxed/simple;
	bh=7bU1ds7QdMe7fyPjRAX4C7xRsdKQ/nVgTj5EjhV4Ucw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fiJdUtEjqdmeX5j0KdoJbWg8PVeSM8WYj74wLjYmJUWit3Zu1YyBRD1L2QOSbwTp+/zw7xjMVwfJV+XCJ6Cl7ho5fIivGWD8MTYFFJHgfrlNK1cd4a3PslEB1TuDqhBH6G2CrH/i6S3gA6SWyVzKxecVtNnMzlJaVj1Ngj4ROJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=thtT/Yg9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+CwcE7i; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="thtT/Yg9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+CwcE7i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D42C51400240;
	Thu,  4 Sep 2025 11:45:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 04 Sep 2025 11:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757000759; x=1757087159; bh=A6s7ZujHH2
	Pfy3aRAq4TNBvVqFtwgbJp6tAwquOvkSA=; b=thtT/Yg9vQTf7qhubtcEacXS6o
	5KbQEPRhiStfSLQ2fbrsbaAjxm8r+RH+ZPOPx+xI/W8u9M8wOiGiUAPIekFxpjui
	Xj2bB9lCY35teUcG8W8ZHkWi167OFKHVetvOmA3hcEmIqIUWT6oGpk6OnYjDwjh7
	LU0k7B8lpGCca6JKvAoHYKVivJ7r1V01D86V9yEk1f95qZOrSgI+iXDL4o477o/3
	AWmgOYLpJjd2PWiLq7YccJzedYzsoKRVgk79EDXx8LdmiQO3OJRMj0l3svC+bYok
	4autlP5713QfCLGAbkEpgVEB6vBrpW6Vp7AGmrecEOnjsLHsnKMd8eqW4pUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757000759; x=1757087159; bh=A6s7ZujHH2Pfy3aRAq4TNBvVqFtwgbJp6tA
	wquOvkSA=; b=R+CwcE7idb4y6xkqI1EYLfCcFE+xxLcPTSIM1Ar7EoIUJBnOr62
	g+MCoERNRZLNholXpwaT8I2UvCdYJUZHaifVIG8rxOvWU5FkJy698fKlj9z5+s0o
	rmbvzG8s4YF1mnWOfzHgMiRYPEGrWxWZ0si3fVD2Gkks795CKDCR8ZASrabTaFcT
	/IN3OrXbyJzNglHypqym2quLHgGdbyT7cATg3+juKFmQzpFYXQNYGF3ikmZgsk+g
	ALMvKKkk52IdoY45ocHERukDfaBFcXOjxQbgoBwOv7xy4UvxjtMJsBwKUCmihOZo
	/Gc6egeMmX9l2O0DJq4+9BW5CFe+mhPLe3Q==
X-ME-Sender: <xms:NrS5aKVO-PtGEi6EtzTCqiJHMWJEq2IFBC3K9_yBnvhnaZwJbtPkxA>
    <xme:NrS5aBXLqU3__2-mR66ebY-guJE1ifQQ1UBU7NgWL3AJ75lTRG5ReCCnXQPB6h9cx
    XhD1vDDdj7Ghk0_Fg>
X-ME-Received: <xmr:NrS5aNQlvxdUlfKO_293UbRs50FCAMqyGlFYbhjqXmrw96yJQPdDykSwJcBJZ8OVW78BKbSJomrQCZ61YT5q3tNUz9Xd7IfjVLcwkic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiug
    hgvgdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggssedvhe
    eisghithdrohhrgh
X-ME-Proxy: <xmx:NrS5aIHsFywV7cI7fQhXgHILwVmIA1_LR-RBM3IFmJ33-wJkyEfifg>
    <xmx:NrS5aFTgwffnh-CLbTC1zdfFN76k15JF4hHTXd6nP0-lttmxAjLoag>
    <xmx:NrS5aKo7RZt_9kpBBdC5THnC91cEGGYm5ZYDI0moY0N00h-KJTElqA>
    <xmx:NrS5aDo0qS4pUDp4-HJ685_iWq44XzymQ-AGTsZ-pZA6-Afg2qtedA>
    <xmx:N7S5aOkg7_BAnmzLFBiz5QSRJOM9RRs5humt_SG_7ak48GpdwjPJeF3q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 11:45:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Taylor Blau
 <me@ttaylorr.com>,  rsbecker@nexbridge.com,  'Elijah Newren'
 <newren@gmail.com>,  'Kristoffer Haugsbakk'
 <kristofferhaugsbakk@fastmail.com>,  'Josh Soref'
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  'Christian Brabandt'
 <cb@256bit.org>,  'Phillip Wood' <phillip.wood123@gmail.com>,  'Eli
 Schwartz' <eschwartz@gentoo.org>,  "'Haelwenn (lanodan) Monnier'"
 <contact@hacktivis.me>,  'Johannes Schindelin'
 <Johannes.Schindelin@gmx.de>,  'Matthias =?utf-8?Q?A=C3=9Fhauer'?=
 <mha1993@live.de>,  'Sam
 James' <sam@gentoo.org>,  'Collin Funk' <collin.funk1@gmail.com>,  'Mike
 Hommey' <mh@glandium.org>,  'Pierre-Emmanuel Patry'
 <pierre-emmanuel.patry@embecosm.com>,  "'D. Ben Knoble'"
 <ben.knoble@gmail.com>,  'Ramsay Jones' <ramsay@ramsayjones.plus.com>,
  'Ezekiel Newren' <ezekielnewren@gmail.com>,  'Josh Steadmon'
 <steadmon@google.com>,  'Calvin Wan' <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
In-Reply-To: <aLlzj-FxXCmBXTQz@pks.im> (Patrick Steinhardt's message of "Thu,
	4 Sep 2025 13:10:07 +0200")
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
	<aK5mJI1NfVQDmDXN@nand.local>
	<01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
	<xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
	<xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im>
	<aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
	<aLfU5sEa-RE3X4G2@pks.im> <xmqqms7bchln.fsf@gitster.g>
	<aLlzj-FxXCmBXTQz@pks.im>
Date: Thu, 04 Sep 2025 08:45:56 -0700
Message-ID: <xmqqbjnqb4qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> If we cannot find anything, an alternative could also be to take a very
> simple subsystem that doesn't see a lot of changes and convert that to
> Rust. We'd retain both implementations in that case, which I mentioned
> is painful because we now have to keep both in sync. But if we say that
> this is a testballoon, only, and that we don't continue to convert other
> code until Git 3.0, then that might be fine.
>
> "varint.c" could be a good match. It's trivial, only 30 lines of code,
> and completely standalone.

I am afraid that it is a bit too trivial.  I didn't mention this
possibility of maintaining parallel implementations, but the
quiescent area I had in mind was patch-delta.c (no, I am not that
ambitious to suggest diff-delta.c as the first example).

> We could still build new and optional functionality via Rust, but I
> guess it also doesn't hurt to have a test balloon that is part of
> libgit.a to test interoperability.

OK.
