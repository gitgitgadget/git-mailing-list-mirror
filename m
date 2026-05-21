Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AE383999
	for <git@vger.kernel.org>; Thu, 21 May 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385769; cv=none; b=nCfpWFiLL9Do3o5/xwTadVWqSvKDBAkZQ+/6a0otEdygYZhKTQFycSDlQpN1Hw68uT1FN0xiXri/1F9ZVAP5Tb4ZyxDD+gGmvcdsocKYF4TgDgsuzyK+GawiFNR9JD8O5DplCXtvS+vcHpsr9iK6vZV7vDtNQqU7pNaS6NFLOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385769; c=relaxed/simple;
	bh=ejwGbTQq4FQrf4T74jSWX5KicW80oi0XvoN/e99hjTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2MSYAHDidbyHrpxd7nf1zk/sla1jNSA3o+UE9COHLc4LY305pmZghmUMXgj3C08AY5E1iPjoAv59VONWofC5cGktAefY9qY52YaebiyGdUdO6h9Y60DdFiqb1j2BtrbRIrdSCDwKgcfsOCYEd0ic7U8hNG3EbOSWFJp5JlZJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZTmOgzA7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKk5238+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZTmOgzA7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKk5238+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F3B321D000FF;
	Thu, 21 May 2026 13:49:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 21 May 2026 13:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779385766; x=1779472166; bh=ejwGbTQq4F
	Qrf4T74jSWX5KicW80oi0XvoN/e99hjTc=; b=ZTmOgzA7rzJHSkpvqRElbgtH/D
	RoV9U9oYgxBb4mpxx0dIakprSZI5+JgXetQmhVQUK3D/YdtJjoI2P/mpltFBOipN
	qXtLdjQbqW/iYSmmTP/w6plWCHexGDfQV80xkx9lWRIqbTGHZupQjnOe677cbE+W
	5FFwMnOug5PMI16b7wyoPUbM+tti6kDwK5Egj/moX9Lk9o9HjZS247VuaKa28AoR
	Y+Oz5Kgkpq09N3PmafoVohbJbpqp3anRDlW3x3Oh/ZnAx/vilvX+59rYPQGlsqaS
	QSUdslGXhVBj0IwX7xeHb/M8As+c+YzsAhMfRg2tXmwz4P5638Do3HAtIJHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779385766; x=1779472166; bh=ejwGbTQq4FQrf4T74jSWX5KicW80oi0XvoN
	/e99hjTc=; b=KKk5238+NFh8K1IIYWth6Eg7pm1yAwGL4TP5XPP/fvhSTNaYgQb
	ECwsIBS58f2I8p91rqwaLSF7cKMefbUCoOATDR92yPvDlnf8gMHB+oANbufOY/m9
	CupFNZG+e5BFBjts96dcPdkjnLfoLjRikN4g2hic1ff94gzH/IR+QZmteKhKLCtE
	NG4LL21zMwh15oK8WLiRinccz1jr5iHUZoib8zGNfvOsfBSTz1SbwD17Tk7h7yID
	FWJUO7wt+/UIKcvwE4PRVu+fs7Nu/dcu0v10LB7oD3YeA7w103TXJJ2uqyx6zlcd
	vk4GOiKMrfcsKeJPxsg6OunRpWEYWStpccQ==
X-ME-Sender: <xms:pkUPahp-iHvVZD1bWQRIbdkbjWdQd7HIEcsrHn0KDvEx24Dl3wOTvw>
    <xme:pkUParEEM7hQCxXovVbWnqC8jrBbGzjuhGNYoA-wxIliIU5c1CiqhZF7BtDAAJ-aO
    Js5q3Gl786i5X9v_EiuLBws-bk2XAqwVFOuaUG_ngAIu2zyjIwF>
X-ME-Received: <xmr:pkUParkNmklscAaTqcklcK6YhbSV_N99j5anTXFGQfYdm3wxcQvxMhFm9a00PmWY6yQtzW6PcV1MY1EysO71jGEKDiWxdOtyzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:pkUPammRQryBKN0ASjqWObs6gywOzaaFaXeZkcto8BcwH_KUiWzoRA>
    <xmx:pkUPaku7KXyt7kfBTPu4gJmLDqvl5wy94M7ef7ufaHNMQc3wbLUxdQ>
    <xmx:pkUPahmivxmnF8SIWiBVkzxh-Ymy75O0wpJBdrrpGqMOXt_Nvl19aw>
    <xmx:pkUPanuEGa2Q16ccOd1248hnLs5VfvrYC7R05iFKa5CJYEGr5eS1Ng>
    <xmx:pkUPajOfK3Tavv78AjdLYLbqxoVuobI2SUDcfQSyVT-6H54RQO9GOIaE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 13:49:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/18] odb/source-loose: wire up `write_object_stream()`
 callback
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-16-6553b399be2d@pks.im>
	(Patrick Steinhardt's message of "Thu, 21 May 2026 10:22:36 +0200")
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
	<20260521-b4-pks-odb-source-loose-v1-16-6553b399be2d@pks.im>
Date: Fri, 22 May 2026 02:49:24 +0900
Message-ID: <xmqq8q9czm8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> -int odb_source_loose_write_stream(struct odb_source_loose *loose,
> +/*
> + * Write the given stream into the loose object source. The only difference to
> + * the generic implementation of this function is that we don't perform an

"difference to" -> "difference from"???
