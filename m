Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1D388368
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172678; cv=none; b=ZeufCZRNG+WzXuM1ryZlIF+VDqxdl9dfgNTW31bwxVjH8fYElqfPZ8LOC8lNChO0rEvlIy8Yxpw2YNCO+2BSRdAxCG/ZK8XIZajdaLrjTmPKSxF7Mi+BYN75pcfLVPJK1nxgxDVEdY/KS+7nMNgrvl2hi2i7Mdg/X5utmFL0Pzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172678; c=relaxed/simple;
	bh=SACvpvCzKuyKMBTy0OhDouUjxarfQwWGcIGj09e/88k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pj6gkH7hXfmhIxnuVkItBgGpT+CDRiDJIUksCSK/JDykeX0ICQMsH1GASXi1K+a54iXvNP5jw6m2iV0WJrw/8XUAp5nsCIzbAltdwIbjxGN6Dy/a/AOe7K+uN0XXBvgpSiPi0uAHwTIacQ6G7btHh5PCDl9o29Xr7jYFdVwZEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BlZW1gtv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N15a4e7V; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlZW1gtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N15a4e7V"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 790387A0128;
	Tue, 19 May 2026 02:37:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 02:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779172676; x=1779259076; bh=PkZ1mcXxxh
	CZ7X50tc4yA4WrKT/0aWuB+grGKQRzoDc=; b=BlZW1gtvw2hV64SH8UUPbdrUCy
	p7uzhahM25E8pxxENJJ7PrCXN3F8XHssAo3m4df6yeGIAML2eERvt7eP1GmGMs1N
	sKYHwWcIF+9RuO/ZSrx0kACWa4D4p6N2s8GULVVcCUGgcqgFrDWf1s3TEYwxrsVe
	lzjh1u6Q59ItoHWAGQeiZwBKrXSnxxeqkTl5EqrzRv3qRQDOhZINIAUkH29f+vjQ
	WbRQa2swSC4GVh4fCa+8j3IXJYO9ZrtMy2AIXFpx3ziLG617buSpJf/A59fy1i3+
	VLD+NmMJkR5tuU1QiDQjYJel+WWoV/b1c4TsAhDmwYKc5XTjjq8fHuQg2D2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779172676; x=1779259076; bh=PkZ1mcXxxhCZ7X50tc4yA4WrKT/0aWuB+gr
	GKQRzoDc=; b=N15a4e7Vro7p7nvJsXygLXRU5sd/cGxznmTwyr3lOmx/N0aDICG
	ZTnovsRZQkT9BRjGMi9E7tnjeRrI6NuKH6evTGGmpkjs6gX1D1RT/nS6GikL7vjV
	fi1bICVPh08UmE1G2f20U+1DksYCAUsQJ3sFOLchquBgkFDJYlN0XojPkVvzlxZP
	gBu2J4JhJSP2t0ZiP0jtgzHbdIUEmVph8gGKBZVt44Bc0Va0YAHY4qBsToM0/UfF
	MEZO0s6E/M/hRykhb9eDJI/KHLxkHcmfbamOfTk6tZ1BXh0I92Ern3jR2lRe+icY
	mMxYWaP3rqZWrZYyNZyBEq0oaoDAkjuIGeA==
X-ME-Sender: <xms:QwUMagGYQL6-sbox1tcHxe6IgqsCARfsxceodYrkQVngiZ_easnTFg>
    <xme:QwUMagOFKiTom9wDw-2G0d5S8oimyu1XZIBRKogSM38fa7r68RUlpXY3szzCnA7IL
    YHOKC4mt0EWKpayVoiLOu_KjjaLkwEMRSKckOq2Zsn_Sh7d--0e>
X-ME-Received: <xmr:QwUMaifncXWCYwNY-9IiCzEBI123wGJsq7YturaK_8auH56nCpDwZkTQZ6zzyBN9XpeEvwXtJlwXKXSBE9rwa7chXoEos-LQmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvmh
    hikhhlohhssegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QwUMatufwcadhF50d7q7Soqs6tmkJ-spUEauslDoeBR5Q-YdFw9IyQ>
    <xmx:QwUMajmPCRP0BpSLNMGObC-nkoKUvIlxjzyIRBinRa8piHTVtl6ZUw>
    <xmx:QwUMavyKRyzWvdhvEgOBexwE0Foi7VExNGOrbd1DPNW4HEqM1a71ww>
    <xmx:QwUMalPd3R8pHo9jCxkTYRYsnPrIC1qb4Jd7S0el8Nf_ad8ESlkTaQ>
    <xmx:RAUMaj3BFtQk3gJqzcyqDEKae9BLl2ULtEOablraTjBzlMYrcdpvd9ni>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 02:37:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] log: let --follow follow renames in merge commits
In-Reply-To: <agwAkHzjrJQPVtCS@collabora.com> (Miklos Vajna's message of "Tue,
	19 May 2026 08:17:52 +0200")
References: <agLU58gbG1y7KLz-@collabora.com> <agwAkHzjrJQPVtCS@collabora.com>
Date: Tue, 19 May 2026 15:37:54 +0900
Message-ID: <xmqqo6ib7vlp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> Hi Junio,
>
> On Tue, May 12, 2026 at 09:21:17AM +0200, Miklos Vajna <vmiklos@collabora.com> wrote:
>> I sent this out a week ago at
>> <https://lore.kernel.org/git/afmfSa-p-9vuDL3E@collabora.com/T/#u>, I
>> didn't get any reply to it -- so I'm somewhat optimistic that the patch
>> itself is a good idea, seeing no negative comments.

The patch collecting no comments is just that--nobody so far is
interested enough to drop other things they were doing to give
supporting code reviews---and "no news" does not mean a good news.

>> So this is a resend, this time to you, CC'ing the list, rather than the
>> other way around.
>> 
>> Could you please review this?
>
> I'm a bit confused regarding what can be a next step here. I
> understanding you were away for 3 weeks, so there is a lot to process.
> :-) Should I just wait more or should I resend this?

Rather, ask other reviewers; when I do not comment on a patch, I
often am not interested, or too busy and the change does not look
interesting enough to me to make me drop what I am doing.

