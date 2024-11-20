Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447818035
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086301; cv=none; b=JGx85C0t25orBxner9occu0bzuYhNhQ6kWsxg+GerK77sMgpNeAlwPkeKfqMOS6PyKmMVudKBX5QMAxO/Oa4fur+bKUs8tZ8BbtAcDOWWxT6Ea5Tq1lL0VGPmgNDyV83FugOWgivCd9HuP4yhsEw+iOLVYR5g55R3+3kDJcduBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086301; c=relaxed/simple;
	bh=RhCBbxc1F53PVRLQY6we8SEi3hzHDj0aUWXQvbKRRhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mcoNNkc6zbVcYzS95z7hCRQW99S6qrUXNyzugY6M0Z/roZRk40BA9uKrtZvVt70aa3TtvevxucQ92a2LkJNuNQZ7pEQdd4Uryqb+VQ/TiTIFQIFx1ZBwFslJiuPtajY08MysERz6DH3h7emd+9sNVXNm+TKzfhCLd+Su5Aw9qv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaRoMMED; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaRoMMED"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49F03254008C;
	Wed, 20 Nov 2024 02:04:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 02:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732086297; x=1732172697; bh=sgOtsF3IdqZs7JaOE7J/auuwA+fJrpmuwDP
	nYSQkA4g=; b=TaRoMMEDCybACqHLmXWGtyMbYP19BIMz9gF/1KsO9xUjnO25Nxh
	2BmObQ0fG7pgpCEI8bDCl0SiV5SMvFrZ5dR3maiOYkZhADqXIbi+KR06LcrYgpkp
	4mrAOHWbMb7FjSztanGaQ2c3hU/Ln6Ws+pL8mHWgJU8lo/0/THLfS/y0C0SO8lik
	Wcmz5faQxMOD57I42C4MfW4Kp18ewgTfbyyFXu1H7PYhL5M55xYBmIo4iUSe5Xis
	JL0JlHhWJ9topYJpkHerngAfXHJ3dlUGxwjdXYAgsLhXEyXoUzN63h7WOuiicj6U
	IVSmVk7fDEiKa1+Dka+WxPXM4JB9KlN+bWA==
X-ME-Sender: <xms:GIo9Z7fkxTlYE9--b8q1Uru0ljinGTSSY4hxPJi4mBaADkig3fjdXA>
    <xme:GIo9ZxPoaDe_OWdxITUum71imWzb6cI5yVxTICU_78VXiUwHZ6JGPkBdqHNCKnKTz
    IninOdq6N1HYLR2sA>
X-ME-Received: <xmr:GIo9Z0g6EDvQsKy19gCViedipzrKDIpKD8mTYrngiCl5Hfp3phbxTqXRefRGWMnB4uDFvql07m5_7I3TTx2sv4lmjxtsJtp3Q7X->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GIo9Z8_siCm4bmvbo8_WdPlPtj_nzGEwEh8VUK8CaUT69H5mjQdQhQ>
    <xmx:GIo9Z3uSJsFXj4PsYp99eHAQDExrFPOZTGdPsQj3xQgripsKD8iVKQ>
    <xmx:GIo9Z7F8URnHpShz4PasyXas3m1TT2xEF9_xM5ehcD16rwIW79gr6g>
    <xmx:GIo9Z-OuguHZ9fF5IeCDP4pLsB85oBgmtTMgAJdpWzVsMI__Tlcg3g>
    <xmx:GYo9ZxIXONV6VPm60ws_oCKvBLbdZ7DEEUMNp7Izhn4cEid0AxC-Jvzh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:04:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: karthik nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 00/10] refs: optimize ref format migrations
In-Reply-To: <ZzH-OaXmFcZkGE43@pks.im> (Patrick Steinhardt's message of "Mon,
	11 Nov 2024 13:53:13 +0100")
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
	<CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>
	<ZzH-OaXmFcZkGE43@pks.im>
Date: Wed, 20 Nov 2024 16:04:55 +0900
Message-ID: <xmqqzfluidwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 11, 2024 at 05:57:43AM -0500, karthik nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> I read through the series, apart from a few small nits, the patches
>> look good and straightforward.
>
> I've queued the single change to the first commit message locally, but
> don't think that this is sufficient reason yet to reroll the patch
> series, so I'll wait for additional feedback.

It's been a week and a half, and since Karthik's reviews nothing has
happened.  So, let's start looking at merging it with that minimum
update, perhaps?

Thanks.
