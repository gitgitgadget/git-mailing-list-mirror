Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D522C6E3
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558395; cv=none; b=BFE/OEgR+6DQwlUnOzk89jyfmV8FO+i2XofpApCbenFuOhSqpZ6k7rDIkZMLT3PHxevggVJmQlwbMkq4DiMaZ4YYzHnZy0qThojmKwBJCLCC8ISrVc5BTXcJTm+8lD9k6LA6AGO1cZeQ7mh1VByF5Tv2sT7G2FbB6nU1S3qfgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558395; c=relaxed/simple;
	bh=YbHmWlEAeJMYz/rHRWayoKrQqvvnCsWxsVpTPv+nwAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E7iqWs3EyeUhtgltJ7DTTrK0HpDFemx1QHkcWod2nQd5ZNc/EF83WSixGildjq1mWmn9N6Ok+4W2Bfqts/5N09N8zCvs+EmOuIgH3/GViDGDnag4+GAwtFScl2p4ydrZo1sy0vMC7dQsgqLqKfLc+5bSc0w6E29YZ1jkS7VJwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMOaogd3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMOaogd3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DAF811401B4;
	Sat,  7 Dec 2024 02:59:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 07 Dec 2024 02:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733558392; x=1733644792; bh=YTZauyOvgHqx1S1+y8s8z9SIVcPwxVqh69v
	slE9wWx0=; b=vMOaogd3ZQUROexL3XqgitFZSFTnNWo8XWSaiCttvLf+NI506jQ
	kLmKFvcsx1d3lv2nxLwSya6YdrI3pDrch8lZRO0glxS7UG0EhPmA33WKwjogEFYW
	SopBIl6ZMwih5FqZ0EB2NQj/8oG9AyYhjLwedixOwc5ZYIgWoRoQEZfO2D2gIGjI
	i4AKV9UK++1MrYS8nNxBeYmj7o7wM+lDqUgr/56KB5CRAmvIgFW8mbqfl2NU75tT
	zSjyx1SbPpNpyFutn0hnX+c0qyBCx5ktD8ZabTTKrRx7NYmyskraRFvQbXa1bQpM
	4nvO/D9nCGWn3KcHwS2f1BjjtPWCxJWl1yA==
X-ME-Sender: <xms:dwBUZ_L8h3qfeE57UcukOi8nM0JtGpsptdoYhhFYvFqqqRQCvzh38A>
    <xme:dwBUZzI7NqxKsLOUyMXNLMLl0vU3Q9FfIfbfRj2cz7yLOaTmA-_aV71c8uaQwWweL
    6zTHsm9oARnPID6hw>
X-ME-Received: <xmr:dwBUZ3t4vvECN1uv9yY4KT6In8LVIPG08wnbOmuXOGH57TkNKETcXmhXpsPTGnFa1DmwjlUMnyqN_sXXRrsmzr2IPXr68Oz8ph7ouYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dwBUZ4Y6nw7rLKiCfRfjFcybHjE1vg__otz4n5fEh9Wgamd4Tis9mw>
    <xmx:dwBUZ2YTLKw20cBWDEv1t0jeil3wgG13x3cIEL2VL0giwWbYsquAgA>
    <xmx:dwBUZ8CCIL8lMSs6tOaiErp_EdYQRvggRZvzY20P5iPeVVhgq2sWmw>
    <xmx:dwBUZ0a97RHOe76sBhz1LVQ-eqEZ_PgK5XB-Jgw7hALcOCHQj2lOFg>
    <xmx:eABUZ8N1uM3PeDUjFJRjiFWHbIZ93KIJ9Ykw3V7FYJ9q__Bu0JUKNXbS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 02:59:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/5] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <20241206124248.160494-4-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 6 Dec 2024 13:42:46 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<20241206124248.160494-4-christian.couder@gmail.com>
Date: Sat, 07 Dec 2024 16:59:50 +0900
Message-ID: <xmqqh67fudmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Then C might or might not, want to get the objects from X, and should
> let S know about this.

I only left this instance quoted in this reply, but I found that
there are too many "should" in the description (both in the proposed
log message and in the documentation patch), which do not help the
readers with accompanying explanation on the reason why it is a good
idea to follow these "should".  For example, S may suggest X to C,
and C (imagine a third-party reimplementation of Git, which is not
bound by your "should") may take advantage of that suggestion and
use X as a better connected alternative, and C might want to do so
without even telling S.  What entices C to tell S?  IOW, how are
these two parties expected to collaborate with that information at
hand?  Without answering that question ...

> To allow S and C to agree and let each other know about C using X or
> not, let's introduce a new "promisor-remote" capability in the
> protocol v2, as well as a few new configuration variables:
>
>   - "promisor.advertise" on the server side, and:
>   - "promisor.acceptFromServer" on the client side.

... the need for a mechanism to share that information between S and
C is hard to sell.  "By telling S, C allows S to omit objects that
can be obtained from X when answering C's request?" or something,
perhaps?

> +Note that in the future it would be nice if the "promisor-remote"
> +protocol capability could be used by the server, when responding to
> +`git fetch` or `git clone`, to advertise better-connected remotes that
> +the client can use as promisor remotes, instead of this repository, so
> +that the client can lazily fetch objects from these other
> +better-connected remotes. This would require the server to omit in its
> +response the objects available on the better-connected remotes that
> +the client has accepted. This hasn't been implemented yet though. So
> +for now this "promisor-remote" capability is useful only when the
> +server advertises some promisor remotes it already uses to borrow
> +objects from.

We need to figure out before etching the protocol specification in
stone what to do when the network situations observable by C and S
are different.  For example, C may need to go over a proxy to reach
S, S may directly have connection to X, but C cannot reach X
directly, and C needs another proxy, different from the one it uses
to go to S, to reach X.  How is S expected to know about C's network
situation, and use the knowledge to tell C how to reach X?  Or is X
so well known a name that it is C's responsibility to arrange how it
can reach X?  I suspect that this was designed primarily to allow a
server to better help clients owned by the same enterprise entity,
so it might be tempting to distribute pieces of information we
usually do not consider Git's concern, like proxy configuration,
over the same protocol.  I personally would strongly prefer *not* to
go in that direction, and if we agree that we won't go there from
the beginning, I'd be a lot happier ;-)
