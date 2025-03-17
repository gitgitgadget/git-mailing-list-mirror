Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF4204F9B
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253992; cv=none; b=pQHolgSXRCnAF2Kq8m6Eh2jIvxuVuS5+fMVnukzSd85M3I8Syvkk0VRcoRwSZI41g5KCix7nSzFprZQI218PzoV+Oso6Cyb7kbMkhUm9ZJh1VwJXrO0yNDzcXJm99F9AQ9smSri65OqbQ5drDofVe7gTpT61k7IBHYIyGOUfBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253992; c=relaxed/simple;
	bh=OFgPc7OJR4jFB592leLba4/g0emp6tBJk6xFForHrjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RQXsRss8JZyZ7A7Er2VC8kl0nPcSqpWkfZEnGHExPegh6c0fVDQvMZ3+1Koqyxj+QzF4JEcw8RrGc++QMvuG8+7xaaUKCRqqbXeBQAshacx+A0AiVBRwUe2Xrq6412yOtnhDxqFxwxNyXuvXrkLqeQv2o/nPp+MSm9yBtKDKf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1BVAbdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VpweozjI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1BVAbdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VpweozjI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D802114019D;
	Mon, 17 Mar 2025 19:26:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 17 Mar 2025 19:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742253990; x=1742340390; bh=apV9oz49Dk
	9p34We4ctw+GKx6q2mAjNhYoyRPy3PAkQ=; b=e1BVAbdIlPelEKV+BeEBvrBIg9
	G1849P4pqgHkyddAYlnqYwYyLSeCSffdM/I3qxWMV93XaXDChrWvns5JvHVAYgQR
	C3oqAGy2imF10Vab7PwGv5zzf6IJeMA0CQjfrtkX8m8bAwzm+TF7WjA9BqF2vZjF
	qkay/kw9kO6HZ27m+HobWMTs93rd1iUEoTZyIdTjnKMiRqbBnPx78GAzRll4RjYd
	7DwXHEb/WnzBLc1DofwOwhHbDom6/iDY9l6OVMGWRGgdmMDIZUJfWHAfVE3dxQdh
	w6SEdm/0Dl2pXlWbyBEjBaofVQnjA1yOy++mnznydNQzHy+4zhb7pNT7td9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742253990; x=1742340390; bh=apV9oz49Dk9p34We4ctw+GKx6q2mAjNhYoy
	RPy3PAkQ=; b=VpweozjInQQ8g3IbRuH6r0XVs5c8OT3v4po1o1mMDxUnXggKr8Z
	3IB3OyPjCeobvOgy1qEcBGlDqGq7X6qil+PByKdIarXRVHBUXPPtVmxHqrGd16C5
	1zlsm5/Y9ZjxpdngyXJHXppyK4QkJ5nzcTSyBE2+USdvJ8TUvUyOgRUq5LqnNcca
	gSBCecR2iXu/OAfr3ChZdX6/9HVnaf4BOFpIFk/3ZGeiSIyS1hPYyQJ33f4hQqa5
	cUHN3mDjeqhqXYi3nEHirx5rP6xui32K2VqodU8Ed16WhHZmhFYYjYMGjuNPh5Em
	siMexLW2dKJ4SLayPUKvTM8rE++E5VGPwsg==
X-ME-Sender: <xms:pq_YZ7QhSvcduwRJV7gMfpuNXIMBMP4E1RXsiYvgyuWEJdeiwY24yw>
    <xme:pq_YZ8wtvlb2YNQR7tbuUl-ua_zHfc5CzYLdJOgBt8AYZk9CJVWvg1XLmksoiqVkm
    eh1Lzyuow-0214MZQ>
X-ME-Received: <xmr:pq_YZw0gj-NWB926GNzsYwu58BmZRO2PYYWPtrBx2nCwoJN9fUsftuzoEwcad93otlSsacsq3rP0t9-SoZU0b3AJVkNAvoNO75SKenQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pq_YZ7C_m5EJyKbJTmpIZfl2GWej5MTyIX9NwoF2lspCIDk7J6U9Hg>
    <xmx:pq_YZ0iCDIDwCxlC1jpUwJAx8osi058DSWsX7FSh1WnZl2Y1x0PUjA>
    <xmx:pq_YZ_rEps0FTigI2k8R-YB-R1nRKbV_x4ZkbiyFiHQy9ZeOOleUjQ>
    <xmx:pq_YZ_gLEDpvbtMdufds9OsapH7FfcZq5ToloPGoMeCPCIjUWcgIsQ>
    <xmx:pq_YZ_VbE8-PzOdsBvSLMgrStBURpHeO0stKhntLXnMxNm-IkPd0Z_fJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:26:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 0/4] refspec: treat 'fetch' as a Boolean value
In-Reply-To: <cover.1742250259.git.me@ttaylorr.com> (Taylor Blau's message of
	"Mon, 17 Mar 2025 18:24:20 -0400")
References: <xmqq5xkdrrhs.fsf@gitster.g>
	<cover.1742250259.git.me@ttaylorr.com>
Date: Mon, 17 Mar 2025 16:26:28 -0700
Message-ID: <xmqqldt35jdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> This series explores treating the 'fetch' field of 'struct refspec' as a
> Boolean, instead of taking on values called "REFSPEC_FETCH" and
> "REFSPEC_PUSH".
>
> The refactoring takes place in a couple of steps, but IMHO the end
> result is pleasing and an improvement in clarity over the existing API.
>
> For reference, in one of the patches above, I had suggested replacing
> something like:
>
>     if (refspec->fetch == REFSPEC_FETCH) {
>       /* something */
>     } else {
>       /* something else */
>     }
>
> with a switch/case-statement, only to realize that 'refspec->fetch' is
> really a Boolean in disguise.
>
> I am not overly attached to these patches one way or the other. I think
> they do improve the refspec.h API, but they're also ripe for
> bike-shedding. So if we agree that they are good, I'm happy to see them
> move forward. But if not, I'd rather not spend the list's time
> bike-shedding here, so I'd just as soon drop them.
>
> Thanks in advance for your review!
>
> Taylor Blau (4):
>   refspec: treat 'fetch' as a Boolean value
>   refspec: replace `refspec_init()` with fetch/push variants
>   refspec: remove refspec_item_init_or_die()
>   refspec: replace `refspec_item_init()` with fetch/push variants
>
>  builtin/fetch.c    |   2 +-
>  builtin/pull.c     |   3 ++-
>  git-diff-pairs     | Bin 0 -> 12166200 bytes
>  refspec.c          |  38 +++++++++++++++++++++++++++-----------
>  refspec.h          |  18 +++++++-----------
>  remote.c           |   4 ++--
>  transport-helper.c |   2 +-
>  7 files changed, 40 insertions(+), 27 deletions(-)
>  create mode 100755 git-diff-pairs

Somebody does not proofread their cover letter.  Sheesh ;-)
