Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780CF1F4C96
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765068222; cv=none; b=FdX9ED+5dtjwOOcCd6hrq/ipUyuLkF4Sgy/fgA1gGT/5LJxbYadmqDsMfcxRV3tNf1IhgLSaenIkjLMEfPBKrIMB6IHgkaWKBoE7XjyyCCW2B5zZtLybuEGu0btc8R7UFwVDUvETzxRlsf65IY6hBXvgOGhN7JtXXGBDS34QF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765068222; c=relaxed/simple;
	bh=g+t0UYc/2WJL/dXzS3CMO2sG47k4nB928jCNKKuGRqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhuPYdKaWmZjY6PBE7a2C6JUqQ8Rj0YRmq3+/LQNAh6u70HFNmTQkPJ0TxDA8EK0mtJugRmY4bo6RA5GK189p4GBl4EixSgYnxomF13ULRU6y65C57B8iR5xCYSlmJjLMJTRiwPkPcBqC77rJAqQ83x18sVZSOwrADjngH/+K50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CJKsdB9i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ul/wEQ75; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CJKsdB9i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ul/wEQ75"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A2B314000D4;
	Sat,  6 Dec 2025 19:43:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 19:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765068219; x=1765154619; bh=QuYrb9eoqL
	B5kNl82Vetne3Ouw6cffkGyfoOi7a2mcQ=; b=CJKsdB9iLEdVyEYurS44uyAUCH
	nHrC3rGEKAhgIFRcvY06fj5Fa2yQ0IZFqOOQBkXtr9pnYGUIT8HnIdr+I3618j1W
	XFBALhXx03zzz/nx0Z5aYHYhkJLz32wQ1VfonObKbVFe/0mI9YZfz+8UggsaKyVj
	i1hdCBMB1OeUlgTDMCAk8Y09sWerWs/BMZwWPRxVBoEPwqNC/TR4n64MVLIWkr0Y
	Nyn7jklgSuhYITE4/xwddD5lJIIj+aOhuSqbw8C6vUob4CafKie0mS4XQQHIDt3M
	Kqk+U7rRYVJuRHy+OEWnLYgVoiRzoJOfwI27W9Ws+56Rtqr7+T0QDj8BUNng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765068219; x=1765154619; bh=QuYrb9eoqLB5kNl82Vetne3Ouw6cffkGyfo
	Oi7a2mcQ=; b=Ul/wEQ75kVY7f5l+5BqGp4S3mAZ6JPMhGSqDatDXNmNFwOAFetb
	37N3ehmoEKYqsi66/1xx31vA4o8OJu0DSbje/ge6jITS0Q9LBtKexj9bpnAn3USQ
	pRVmqi0kzeCDrgJ+YCH8jr3nYgnZa8qKd1Dy2fkmKvlKTOeugsVNwj/KrEPof4sE
	zI1VxJfZMVo2m9SQR1ubwoZuP2FCvoRc0lW5Y9O6ltldPWGv9E4w2BhL/KSd2k1Y
	sty58BQncBuV/ddaeKJN1WU26DwrCCaCatBmmgeyt9qQJhMNfgKqnNmyamGrDFV/
	Ho30ifEyG6lFgXim6jz95aavxK8rmyhQf6w==
X-ME-Sender: <xms:u800aRelbLZ8Mv8qloAi_ct3ovpUdssuSTkd9ITQawkW2NpsFnXXAQ>
    <xme:u800aWrsmh3-5QTZNV0cSVU1U2gMv4hdOw6mIaQUA2CNdrjlk61qTBphjMehThQz7
    p9GDDeadtan_wTqxkVvjN3KuD9AY7rFgOBN84m8H1QJ9oO3pEQkQQ>
X-ME-Received: <xmr:u800aX7tk92QS3f1y2oPc9dKvtG0Fv8AFti2ofRdHJtOAdPz8zzt3OjulRZSyb3fxI28dtZgmcDtSsFZiUbfVbzT9kfvpWiwog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u800aUrWTVx3zd6X07LjGNrcL4BhEGyCo4zq2VxMTJYFTHfUG14i7w>
    <xmx:u800aRg1RF6jfVUrbR45V_4KiOXNFcnxnIHxqF_jNC-b8QVQHpaITQ>
    <xmx:u800aWKsbzfBqBiPVNIYSJdGc8_SiRRT4u56R3OFPcM3xNe4IbTeWw>
    <xmx:u800aZB7l0PDPszo-IhAprMpVZlnMi9llvz2JT_SS21x1aflbDNZrQ>
    <xmx:u800aSp_WqM4k2HGCGYGGgQL0bZjIqe89C6StxQG3H-494hwK3WoQJzk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 19:43:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #10; Sun, 30)
In-Reply-To: <CAOLa=ZTC3gWcFVENTCa2WQsxaq4X2a_D+0qQUBdg31uf0zjoTg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 1 Dec 2025 04:53:42 -0600")
References: <xmqq5xaqbxmk.fsf@gitster.g>
	<CAOLa=ZTC3gWcFVENTCa2WQsxaq4X2a_D+0qQUBdg31uf0zjoTg@mail.gmail.com>
Date: Sun, 07 Dec 2025 09:43:38 +0900
Message-ID: <xmqqcy4rnmth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> * kn/fix-fetch-backfill-tag-with-batched-ref-updates (2025-11-21) 3 commits
>>  - fetch: fix failed batched updates skipping operations
>>  - fetch: fix non-conflicting tags not being committed
>>  - fetch: extract out reference committing logic
>>
>>  "git fetch" that involves fetching tags, when a tag being fetched
>>  needs to overwrite existing one, failed to fetch other tags, which
>>  has been corrected.
>>
>>  Will merge to 'next'?
>>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
>>
>>
>
> This should be ready for merge, it has been reviewed over multiple
> versions.

Other than the "eventhough" typo mentioned in

https://lore.kernel.org/git/CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com/

this topic should be ready, I tend to agree.

