Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9231E376B
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061137; cv=none; b=gFPRyU9kKS3nMGtzDkvEGzA7lY4kl56waO66Rso5vefA7NuPrZ4ZrwnIl6Bk+C5oU5OtD6sVdb85pL9VyNX9vGSbJs1lwIX2TYdZ4pk0x6AD8uJEedVEn3Rfw0lvl12sMJT74N25hiCWxnxDjXC8waVysrEE7g+wvzHvS2elh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061137; c=relaxed/simple;
	bh=nnYPH1qBR2BemX5pDGTdQxS4PHV39Ua5ki90LbW0qLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=isBOcjT3qjmsjE3/v8q7isxw9yQ+69gUtYGgIdkcIzSiPDFQzuguP4QemcTc5BMM03YWedyIOYU6VZzKb04vjmhACq1I5jZsOH+vpjdM2AD1zHPgNwhfqbnZ+ZjKf4yBXUKnpdwI383VeqQZG+L+wiJVRJlrTiDBWP1MBWc/l8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sd0NkuzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAXeIkJX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sd0NkuzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAXeIkJX"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6CC1B1140149;
	Fri,  4 Oct 2024 12:58:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 04 Oct 2024 12:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728061134; x=1728147534; bh=zrJ4fm+dLU
	fNVFcnCibWFqU3Va5B1eNV3RvIbDUSYXI=; b=sd0NkuzZ8ymTLW7KZzYTp95KGq
	7eyqjwJVDZcflX2nFfchGCBgCcTlrSlpeK+SZBqiome2wJXVJaFTJw5UxvTNJJYO
	KVGiObYV8YGkxL+VR7wKh9+1Sp8kxKNoZIpULkjuTRRYrj12xP00n8mZuIDa+iCs
	cIMqDy2STWR9m/Ig+2a3zhuhPbl8lBpK5cZS1nmmIynV9wUflSSKXfOl5ecsDwWA
	5rpsf27WF+hTu2EVU0ICbWqIgKlYcAuTSyL6rCPzRdOGBuriLLpBBIkO6ft/JEuQ
	izK+jDMAbGxjIOhHVnNU4/PsukWdZaX+3TVoHwNleLoV18ftt5AaGqIaPfRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728061134; x=1728147534; bh=zrJ4fm+dLUfNVFcnCibWFqU3Va5B
	1eNV3RvIbDUSYXI=; b=eAXeIkJXZm2xw24pLQkuDqchslXtM04MAtlhfU/+LDQ+
	b5joXbS5ZGKK+xg+rCzw7bTvWpsNWz+TR+6ByY0whueUCHYonfw5uEEHXKfnO7bY
	txi0mC0AW1ac73/LZgS+zo1HUVFJpQjPYaGZ8M8GFr/pTbPp8SwxMMKv+69/joD4
	0CDHN1iWSZnaWop8ENVTO+HZCGNkdJR/LVB4xLz/5FfcC95rkpb2y7CGoIbAsf1Z
	RbZxihZ23UVpvAx9MrjTfEeHFQh1qZ1mRWMpFDganllDldgGa18VKO5AL8+IMXLD
	/iYq04FJ/QWNt50DF+TbvE00ZRyNOqDxqqh6on4tSA==
X-ME-Sender: <xms:zh4AZ5492WM7qjSQ_RZYjA92ZpzPq2vwalyO79gQn7YHBxXGvod1-Q>
    <xme:zh4AZ25MecrPDLPCgzJwDAtb_TMPiX3TZpIV-EdQc5esu5mFTPwCBTTJGwxYuD3AV
    rV8eVoTacD9TaUABw>
X-ME-Received: <xmr:zh4AZwe3GAH-oakR_RpOC0WoR0xVhUZ9HEDhrfQ26LV8R1wOaEu8emlBXWnLXHvXnQLXsxdTGuP0Yg9DhBhZ47TwXjkbj2vXSUX9BnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zh4AZyKkTb0vgQiJweXNtVnOlAcxABEnmNuEnre0YSmW3-RPOpzRUQ>
    <xmx:zh4AZ9IyIWMueitu5tVf9gzOC0FhM-wK3ktHxla1lfAq6WhO2ewshA>
    <xmx:zh4AZ7zrSX8gNsMKFJRrO0L_8pIbw3wA_lmMcdCFpm7wnsagJ5ozog>
    <xmx:zh4AZ5LYMWidNATUJQ4NVRkbWExakKe0n_SnejFFrgQifOixPfGPRA>
    <xmx:zh4AZ7h7P6LHj46a2jarlJaxf62JhOAg4-Wa-8gks0r4vjb-QC-XVWQH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 12:58:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
In-Reply-To: <ZwAYccsboGIhGVIx@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 5 Oct 2024 00:31:45 +0800")
References: <xmqqh69thzd0.fsf@gitster.g> <Zv7aLRXwt9cfqW58@nand.local>
	<ZwAIM6GO3VtoG3ZM@pks.im> <ZwAYccsboGIhGVIx@ArchLinux>
Date: Fri, 04 Oct 2024 09:58:52 -0700
Message-ID: <xmqqmsjjereb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Fri, Oct 04, 2024 at 05:22:27PM +0200, Patrick Steinhardt wrote:
>
> [snip]
>
>> There are two maintainership models I can think of: either a single
>> individual or a group of people would take over.
>> 
>>   - A single individual needs funding. The ideal situation would be if
>>     that funding came independent of any of the large forges. Or
>>     alternatively, the big players in this context come together to all
>>     pay into the same pot to fund that person. In theory, the role could
>>     be elected and serve for a limited amount of time so that overall,
>>     the community is in control.
>
> Well, I think we cannot easily fund a single individual. It it is a
> full-time job, we have to also pay for the insurances. I don't know
> how to hire an individual in an open source project. But intuitively I
> think there would be a lot of trouble here due to the laws.

I think the model Patrick has in mind for the above is like how
Linux Foundation hires Linus Torvalds to work full time on Linux,
while the Foundation is funded by large industry players.

Git has become important enough that such a model may be workable,
and that may make it easier to maintain appearance of impartiality
by whoever is being funded.


