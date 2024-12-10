Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74413BAE7
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788876; cv=none; b=bbZyeessMTEm+k3mzihavC/BreN2RWYu7NOy6lrlDtp3Q64JT9kMuVKk3lHJeTCWRLGLCQo7SYzg7S3O92EKfKwcTMn9iyF56WNAgs0PzqtXoKDMTYvMtGa/R2ncvnlWHLLpFhnrNv/lMkyIsSN5REhM5tdq6Fo39wQ5VVfQ47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788876; c=relaxed/simple;
	bh=NAaZ5z2bEuZpi9GUBHZiKaD0Wh8HHmpes9D44y9eTNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2kQfqwbHIxMVzc6KUbo2gxgkkoJ9rpKhznB6zDQ09j9o/6VOLlQ7ya1NPkfB3oxIGuuue+GhRXH0qDaRgwlgBvrmwP4ZtJi+cXEZczolTIhWnYk1FMhxGQVK5fwfiAbCJs3QT24k/2s7rJoLyt9bkZXR1lUTd7DNhrbR0u6CnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uCE86CIw; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uCE86CIw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84F4C11401D2;
	Mon,  9 Dec 2024 19:01:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 09 Dec 2024 19:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733788873; x=1733875273; bh=iFwR4rTCC3O31RPIUEBUL1T87VVTh6K13te
	e00mDjG0=; b=uCE86CIwI3+pDpoxDd40ZV9tEedrL3Wy2P3pEKwa0rui352dZLU
	QFXCSYd6ovPnPLJy5xYoZMyRqs+ZZOqGhD4n5f0Bz+VChOf/2mCchJtPw+wGoO95
	eLpfj8I2tgSEe2YlMtSTTyXQ3vRed1hIfGIAVhO04s0+kjC+IQacCO9ZeCQbJ6yS
	kLeVxEqy/ASzdil703ODrhMIPzF1MBz1dUCsx+8ps3mTxncijQl6XUOp8yfCcshX
	/EJlmkK6c3Bd4vWxXizLysMimZeFWeb/EBA4iOYhe8Q5TF7G1Em5wZOyqplw3xTz
	6pm0twqXxlvu8vPWgYNh/TT/e87MNvSAtTw==
X-ME-Sender: <xms:yYRXZ_oTW6WgLVzlXyc2VIOvvpz5UHxVIThzmXNUpVBb44LrYNfD6w>
    <xme:yYRXZ5o5KLrhWq52-Q7m3tphBR71dFcSZ2Li-92JsoNEKQmQ54oqA2FhD2hUu4fAA
    DnqJi9y2yz3ga3FVg>
X-ME-Received: <xmr:yYRXZ8M6OQT9o2Zg6-1h2Dqzy1LyABfRV3UiBfiPrf3tr6mfo32kyLfj8-sAdp-NtXUCh0J41AdhXCvSaHp7w1FK3ewiIQ2BsG8dcgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:yYRXZy6j0MF4ZmbOwWGsSsJWvNgiGz3gDRd0f1PrfeW3P1am-WI_IQ>
    <xmx:yYRXZ-6SHIcxih-AElfNAsLD5ah6tGfaMgeczPX-uX7rKXZPBQ0xoQ>
    <xmx:yYRXZ6j_eosyg4gZ1BqvInJncPLFBBMkgtD5Zp6bO7qokx_60qDbqg>
    <xmx:yYRXZw5cjbaW4ChWiqZYwG0CMFMZhF1Ay5R7SIvRLx2PnvhtsjST5Q>
    <xmx:yYRXZ2hM8HYyKnF8lXSysRRodu6Dmgsc6JkUBdIpqE2ebCTrUQQht20p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 19:01:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Jonathan Tan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/8] pack-objects: create new name-hash function version
In-Reply-To: <20241209231522.841908-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 9 Dec 2024 15:15:22 -0800")
References: <20241209231522.841908-1-jonathantanmy@google.com>
Date: Tue, 10 Dec 2024 09:01:11 +0900
Message-ID: <xmqqjzc8mmns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> "Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> diff --git a/pack-objects.h b/pack-objects.h
>> index b9898a4e64b..15be8368d21 100644
>> --- a/pack-objects.h
>> +++ b/pack-objects.h
>> @@ -207,6 +207,34 @@ static inline uint32_t pack_name_hash(const char *name)
>>  	return hash;
>>  }
>>  
>> +static inline uint32_t pack_name_hash_v2(const char *name)
>> +{
>> +	uint32_t hash = 0, base = 0, c;
>> + ...
>> +	while ((c = *name++)) {
>> + ...
>> +			/*
>> +			 * 'c' is only a single byte. Reverse it and move
>> +			 * it to the top of the hash, moving the rest to
>> +			 * less-significant bits.
>> +			 */
>> +			c = (c & 0xF0) >> 4 | (c & 0x0F) << 4;
>> + ...
> This works because `c` is masked before any arithmetic is performed on
> it, but the cast from potentially signed char to uint32_t still makes
> me nervous - if char is signed, it behaves as if it was first cast to
> int32_t and only then to uint32_t, ...
> I would declare `c` as uint8_t or unsigned char.

I think you meant the type of "name", and your worry is that *name
may pick up a negative integer from there when the platform char is
signed?  Here we are dealing with a pathname that has often UTF-8
encoded non-ASCII letters with 8th bit set, and I agree with you
that being explicitly unsigned would certainly help reduce the
cognitive load.

Thanks.


