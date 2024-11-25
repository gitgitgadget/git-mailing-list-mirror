Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1411E480
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732577973; cv=none; b=I9JyhnUluk0sQ2EL6EwjIH0jVaaIPwDgbKKdZQhrJkXyHKWi9HU/g+wodcmaBfv4Xl5JGxWIDADbmwXNmbltjefUrldYTdmQzaMWwK01l/a3PA+AwoAgJ8/HXKwjx8a78gUbjT4a3oWS9ViGV/YWs3hVzMaydjA/2t02b2hhyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732577973; c=relaxed/simple;
	bh=KBWcu3C+/AJRmgKfbPZXbZm+mkmCmFX/WLmcxDgCNn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipFaB0dhc7VHED5c5Qxu8m80peG9+1SsLw5UmsbXywJhC++HJbjSnVxvP+rbUGCTz/fOkVzIKmMteIuP7OQDY480ciiH6q4/dAecWoS7uBYAUQK3VESbkDvHzY+4+LdCbWFUWocKcvcEVvNBBbfZnzx6uFWu8VYyUVWRTilWUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TR9//VVl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TR9//VVl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FDAA11401E7;
	Mon, 25 Nov 2024 18:39:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 25 Nov 2024 18:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732577970; x=
	1732664370; bh=wECd14zsGEgsj9OJOAzpd69EZ6WKEQoG6OiMfxAFNYI=; b=T
	R9//VVlGHYnwv2cu1blxfTF0H85+b7oZ01fRKUb8KnpqwefQYxQgL0RrKEP4opQh
	HHsANaOcmsNWwsKhG5L9XCw+wOXYR2+5AZBrUPV4xPtzoXSi4xko49G0D9ZIo/uD
	IoN7oL5yPtBu7WdUYsFSPaOBdc1kqDDGxjjTKhqUsqvlLvTJA0MtBGqVeeEvEOm6
	kB77nXTQLBUQ7xqMTfKOXsIFzWHVcJbJzGF4N572QVZUTCct0fbsXcKRxx5OSt5v
	opoYZwGHipDmiuRErKFVwW0tIsYdQ7Me+HegiERewa0Cs5hlI8TDxicCG8U6By38
	1xYi93fIIG9QxNVvdhtoQ==
X-ME-Sender: <xms:sApFZ349JKc5LhPOp9aTObjeFqCkL8tXg_9gexoxrIsLW9-rpj7rzQ>
    <xme:sApFZ85-y_UKIniszxif8Rmq_2yJvNXkaD7EsljmzQn5_ksF3h0RwQuS8ZfWZxgqf
    Qdnnr9ki-bMl4lERA>
X-ME-Received: <xmr:sApFZ-dp2vxIcQYRmPP9H6u_h_ubY456LwfBT56mbVGvbY39pFhriU-syERZhEORbgWOlhs_VoTeR0NAp4boztOUBKKffJhDLuTDzg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    hhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sApFZ4IN_BuBOmRJ6BH7uArZGzWBgHP8tKU7lcbAz5Wi9Kr4lZPmcA>
    <xmx:sQpFZ7JQkMpHPhNTqjxu2qjJ_DKz3nhzIKwLhRszf_aWqkb3ZfvcZQ>
    <xmx:sQpFZxzk8CjTf-vPyYV6NMuO2j39jpcd5Lo3-mxzZEaNBh0psIJHFg>
    <xmx:sQpFZ3LZ79_CS5xnw0aOVkkQXnG83-Knku89d-3JaBl6cIJ-CBN30g>
    <xmx:sgpFZxinP4T2KydrILjdfSTS4beO3qJL5yiqwJf-HqsD84qKoSrLl_zd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 18:39:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/2] refs: stylistic improvements to ref migration
 optimization
In-Reply-To: <CAP8UFD3XYZe_10dBVpORKPq0PgMPDEAsbZAsd=xJB14i9Ocf7A@mail.gmail.com>
	(Christian Couder's message of "Mon, 25 Nov 2024 10:35:58 +0100")
References: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
	<CAP8UFD3XYZe_10dBVpORKPq0PgMPDEAsbZAsd=xJB14i9Ocf7A@mail.gmail.com>
Date: Tue, 26 Nov 2024 08:39:27 +0900
Message-ID: <xmqqplmi51e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Nov 25, 2024 at 8:35 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> this small patch series addresses some stylistic nits surfaced in the
>> review of ps/ref-backend-migration-optim. v3 of that series and the
>> merge to `next` have crossed, so I'm resending the changes from v3 on
>> top of what we have in `next`.
>
> I took a look and both patches in this series look good and correct to me. Ack!

Looking good.  Thanks, both of you.
