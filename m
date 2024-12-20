Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F0218EB8
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708443; cv=none; b=fpIwRb9VrY+RW280ZYYgTVowWtMJh6sCbjMWpSQDzP1SnFxSv4LneXjT8qHbxh3KLJzrvIfDT8xxwQSYBCZegJJ7C6SlRU+f8tENwhj0g4O6DUPxs8FI5m+ijKNKHE9hhVLc+GxpdqGlzv0hM9RGNoHxakON0gm6IhIjPzAXwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708443; c=relaxed/simple;
	bh=9m3xGGJSYTDKFrP9LtODAr4VraxBCyVY6TUdSHvqxEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mhlYHm+etRdKUpTa2xOko4liIOU6zmkQNQ8pJN8MKJtx/Q0wVHXHTKLqRZo135TKRah0W0HVIqZSL/S4dyy+u3OQjBB84Sjg4hxzYLddGlCvL7dxDADb8KlmmM884ed26t8qBpj8UAwQ7Ab2QzOwdbET62IkcTFtkZn0XQ7SbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r0EnGxit; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jc7RGjKd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r0EnGxit";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jc7RGjKd"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F2821140157;
	Fri, 20 Dec 2024 10:27:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 20 Dec 2024 10:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734708440; x=1734794840; bh=2LxtUVN7t5
	Em8QHTLKiqfehS6MSJY5uHmGkSV90xm5w=; b=r0EnGxitl7Ha5lmXUFKL21ZLvC
	kiSvzAjcmbkEWjkqX2INx5X3/9t2x/Nislsff5T0gtISf5BtGy4RSQG0dU7hhd05
	33t+8C+cFPK7QsMhf5Or2RvH3sjFr6xGwt1FNg8HgsqvoAhaO0ofsyQXnsgie41m
	Us8MAPTie0zj7sGo+iiShHhxSKvOOsy1UtIyRQT0uJ3yeNXBfmE9PQB4txlIyl7t
	UYW7/c0gHTqLwoI6FyjHsWKqcq/o+6YF+nSHGRMko9GVJ98omTFjCWwO2ZdmmbrO
	dKXT1Gn89fcvfMYN+mUzTmccF6jA9HfS9Vvmlz6fmB04J2My8Dg2RYZZ1xGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734708440; x=1734794840; bh=2LxtUVN7t5Em8QHTLKiqfehS6MSJY5uHmGk
	SV90xm5w=; b=jc7RGjKdSmtl1Bam7rhQU6lqjS2GGQqfgYjP01DbfkejL8XbeSp
	+Vv+1A89QJL7B5PH2rG9S6YZmodBQXW6mu6HBh7D8a69D0u6jOKB+HRMrfR5tG/4
	uH8MF0lAlaFzTx8KuIEZJe0i23EaX/S81cB4TEd0gVZIn/8C6TN0ugwtxOGRuGyI
	DCGLXCCU0sEoY50VomiITMEgMF2Zh4w4GBcYVhCJbl0cbNFjNFu9dOmBUoKtWEf2
	M3kpI0f6Eyb7aywK9It1ALl83Nm94vGv2vJQu3hVooblNzwHtcJYOolyMqmQlENM
	nN7lP3OIrJb3mOoxdSWpaFwBttlKl+w2QdQ==
X-ME-Sender: <xms:14xlZ5h5sgqPT90rrT1TlkJ4OFSmYU6Jn87hUhPrcJ2VudQpnErixg>
    <xme:14xlZ-BxUhfftlF3vCMRE_vefjrJAJ7or6MrCAh-0K3B4rsndHU7vOud_IGVPBJ7e
    Dnwh-kcvYXZWzuGfQ>
X-ME-Received: <xmr:14xlZ5EUSjJURmylHCo7N6J9qUEwr4_fPGWoKy2KjdX8bAYaKmHF9DEJv-bydZmtBZHTPnZA-XPymCR4cxMy7oHdyzXTsb2jQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:14xlZ-RzlPA9jECNWLLzOvJvRZmH79YCUC6h3mslHnQOSn5sDC1zIQ>
    <xmx:14xlZ2z0x5nJE6lztLdSmE7xm8z83wmifOco5s0WUVQOjvNoMTwDWg>
    <xmx:14xlZ062MpyiBEeQOU83zoJmiwUDakuolSR158G4lgnLOfm6lJLTFg>
    <xmx:14xlZ7xE5zeKY8S94mIJnmv-yLS6IN7HMc0kuqfe7kqaxZSDOZfFUw>
    <xmx:2IxlZ69XslKZQGniro_TuIF2A7gHv3JXSxrvQEa1P3EYuteanCeKLGZR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:27:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] prio-queue: use size_t rather than int for size
In-Reply-To: <20241220085337.GA133148@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Dec 2024 03:53:37 -0500")
References: <20241220084949.GA132704@coredump.intra.peff.net>
	<20241220085337.GA133148@coredump.intra.peff.net>
Date: Fri, 20 Dec 2024 07:27:18 -0800
Message-ID: <xmqqh66yfk89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Dec 20, 2024 at 03:49:49AM -0500, Jeff King wrote:
>
>> -static inline int compare(struct prio_queue *queue, int i, int j)
>> +static inline int compare(struct prio_queue *queue, size_t i, size_t j)
>>  {
>>  	int cmp = queue->compare(queue->array[i].data, queue->array[j].data,
>>  				 queue->cb_data);
>>  	if (!cmp)
>> -		cmp = queue->array[i].ctr - queue->array[j].ctr;
>> +		cmp = (queue->array[i].ctr > queue->array[j].ctr) -
>> +	              (queue->array[i].ctr < queue->array[j].ctr);
>>  	return cmp;
>>  }
>
> Sorry, just realized that "diff --check" (and apply) complains about the
> indentation here. It's a TAB followed by 14 spaces, instead of two TABs
> followed by 6 spaces. I guess caused by me lining things up manually.

"git am --whitespace=fix" with or without "-3" corrects such
glitches just fine, and "git am --whitespace=error" correctly stops
me from applying such a patch.

What is worrysome is "git am -3 --whitespace=warn" does not seem to
catch it (without "-3" it works just fine).  I do not know offhand
if this is a recent regression or not.


