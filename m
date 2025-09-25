Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D018C02E
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816505; cv=none; b=VholAz21XUdIsQZKAYWPJBYy8mpxsne/+sHXkSdC1JYkGNlg9phf0ws6vFGFDhO0kU2fLQdpAYxvVo8sHp4H4ibRZrpqtofJ3ffJydKBfFXSNjVk3GqJNE+P0nBqdXCtwWxmtgRbPTX6L4Hr+i9wwf9iUCE5bMYknUmhSsXyQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816505; c=relaxed/simple;
	bh=M2UXh/d80pgIoDLxeoBpelb372CwhQwAlt3sF5jlPkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CuJgjygyL+dLPkRIf6UjYpz4S9pT9mFybBJ1X1jNsshAw2EFAPQTUbOBFv3Y7tlG0wYIKKWNTgAgBOASD5nqjDhwWD/MaMXsIkpPZbLCkydVgRne1vaS73Fu37NUrU4JK+I1dXncN/1E63GGK+qGDCLxLW9NUGklb8Tdo5bBdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mQ7+ncx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IzStpCLX; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mQ7+ncx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IzStpCLX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B83387A0103;
	Thu, 25 Sep 2025 12:08:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 12:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758816501; x=1758902901; bh=Yjja/pXgjh
	8B9WjG/hDbpO/axGzTR+9knkU/OZ+Dht8=; b=mQ7+ncx+Plz2lkZ94+Uhzwd7Cw
	+liDyfLKQCQ/FCRqdPDbI5GkLTfHoPxkdXf/DwcYbrN47v+KZ0aBlPtSXaFvSqRD
	i9u3ZdPSGRjChMxp4qZ2vFAUg0CVkUE9I0ClSNNLtlXTTgUTJPxnHRduXm1TcEgy
	ySabTCpt68mRYkZy+u/Xxw5a88R0L/mdRbp2J0asQXN6ECMVOjKTPPsqlpeQtvbS
	HHxLzkp7TDVrfgESS4boOrkArYFc6D52jz2GAL1IKSsrIqqz0FuZXrng+XCo2XBs
	UHTQqhlJA3vIrXy/mn2zANzJjVWXr+sw0dUeAYXzK8SRgIu19GvEQdDhSSxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758816501; x=1758902901; bh=Yjja/pXgjh8B9WjG/hDbpO/axGzTR+9knkU
	/OZ+Dht8=; b=IzStpCLX0WPOTiZtp1OM/agzrW6hQzhJU5NTtBd8MP7xc9bQiKG
	vTl+ePPh7qR9wyh3F1hBokCtW/OQgETBfRhRLEN2vXOqM33UJ5JUXsa4y3ZpZAAu
	jNIkOe/swS8yA+oiRWpGc9L7cCzzs+d7cIRIcx7tpsEXhAax9TNhnkoyTfcvRugG
	woFkvak8nwJmrp/6PQGZc7IPMNicvxUScTQs/kbBUhYhYEqy+Cz7968BwYYk387Y
	wNgjraOQYqdlhOHYrgbyOrxDaHiScEVtwLuYTovjsjGQDfQH20DdpdEQ140kddza
	zP39ctNmpuyTL42B8I6NQKh+rU7wEQRY2lw==
X-ME-Sender: <xms:9WjVaGt0EiNxQNBM5gXlC83N_kPk57QDgLCwWgvNeBZoR46MVSvNxg>
    <xme:9WjVaNu35Z4VXt_F7OyNkeJyzF7bV6R2yuhvbnT4BaSROIRjRysJeqKw8-0uMlSOQ
    cDnJz11Ry_OSpCuCh63g7F53UbUHKWCwIhAv4pPD-v2xr3IuXIRcg>
X-ME-Received: <xmr:9WjVaEDmJV5t5s6aAq6fxCHfdl_wsloi-3JWzjoWLKHEGftwYcHPrlbJpKXOVgnHJ7mHPQB0hP0-PCQJpZDKPErb3PuQ08Bv_6tu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9WjVaHP3r3TQikMiz22esPkywJiodCkCEUOm_nRWWLZD3NRknLkTYg>
    <xmx:9WjVaFyC9uaZ6_Q9LTefTl7mAnptB7gAa2KR6P0PZBa6aKA131l8_w>
    <xmx:9WjVaPWIMRcRAhm_1OJvjXYRHidW3OZ-4Q22stSulfAjFL8Mq3v0rA>
    <xmx:9WjVaPPJ2YxqtV_CcCYKTE-TfK6Jz-Lj73dAyLoVsFm66wVr8Xsa3A>
    <xmx:9WjVaNvRn7tdAzGU2GA1ZK5Md8IHnrUARs_5Wd11-O3VK3rW5jdWrcJx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 12:08:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v6 00/15] packfile: carve out a new packfile store
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
	(Patrick Steinhardt's message of "Tue, 23 Sep 2025 12:16:59 +0200")
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
	<20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
Date: Thu, 25 Sep 2025 09:08:19 -0700
Message-ID: <xmqqwm5mh5vw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> information about a object database's packfiles is currently distributed
> across two different structures:
>
>   - `struct packed_git` contains the `next` pointer as well as the
>     `mru_head`, both of which serve to store the list of packfiles.
>
>   - `struct object_database` contains several fields that relate to the
>     packfiles.
> ...
> Changes in v6:
>   - Fix a grammar issue in a commit message.
>   - Update a comment to reflect that we access `struct packfile_store`
>     in "midx.c" directly, as well.
>   - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im

It seems that we are basically done with the topic and strayed into
nitpicking territory?   Shall we declare victory and mark the topic
for 'next'?

Thanks.
