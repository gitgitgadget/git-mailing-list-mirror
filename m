Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794875351;
	b=IpLctyxxsNtbYFZgjZQFuq+LyJCor7X6kTmps7Bu6ZFQiOhYRh89lmNlkTQmVGDqG23y
	 MmL7fJwM4VC4CS+LtARRiev92+gaOf2vRZpxwgPqpwaE6czq4IQ9Kg4LSDmvNLyAU2yCh
	 kAcSu+zt1hknzk87AUhR24KzDEKxDj8qNGNeBncuDejY84kZ9pZQTzimblI+i5eD0nt08
	 IdMANuhE+uKrZlDY+pMT+wdU6TovzYLuQKd/FL43rsX+QjBF9t3e4xEm1ZwsSg6qfgrc6
	 dWV9kr7axKKgPY99nFDZeWCCJyxYNqUmkcD9Zxaokc6hty/zHV/LUz6O8z7SRLmOK5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794875351;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7rkBY+2Jq03n6O1kdOOrsr4WCYHaYGMOoxdVvN4/8YE=;
	b=KjoxwpCfqAvWtUmc0UmN/VlGbjXqgIety9q51jSlzlIYaY1+oQXbj/orLgh9vHP0wPr6
	 WcoT6eW9fAZaJll3w2HEfaHFnk5NJzT2vsdtdnmKxWHjRXo7gy5eitvecD/PDFx8KEfd6
	 48qJ3o1rBL7m8dtNa5aSwE3jc9xkk+CPXhrl6Ef+GjPRwF9vCpLDYIWMFLhR+9WyDZiJt
	 nLUxC4AEJNQt3lO65xl/YgZXSKyNBZN5QoddJ6zAiBsrX9d4Xj206kuQ89rZP+oGfMz3F
	 eQtzM5Hyh+x6dnAl8pH7dQxeEnIaZD2X0pvI52BvAwULzHNr9u4LdXk129ZQxjMZZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jb4znbeU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gKLtE9Cz;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBC606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=jb4znbeU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gKLtE9Cz
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E7D81D001AA
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 19:29:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 19:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794875350; x=1794961750; bh=7rkBY+2Jq0
	3n6O1kdOOrsr4WCYHaYGMOoxdVvN4/8YE=; b=jb4znbeUdaJEGLE2UeDOQkvK6Z
	6Hr4IDbQ+urV8LpMyNCzbpqA2ssTVZFnm5egxFMTvBoJCQ7BYRSBzx+OfRdEoY6h
	m2kAvztxA3w5SPLwDhZ6PYYERw+YUpxK6g6kYDkrbMZt2YWtLlbFeawF6mg0Iz+N
	nuc+WilG6WX1QZ0pA8UEE9IUWjQmCYp73ZIMHzlAktbDoPWsO05Q14XqRot0MtDu
	0Ewznn6FxvT96s3LxZcy45sunKDVl448NrRuHvfqQL1RuvndHdv6FfTCTJCXi3vO
	vxpsPbe7Gh0sjnmu3Eo8vKk2/tSFu7zLapXNP++V8QjPyDV/ZGpdwV7EFSKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794875350; x=1794961750; bh=7rkBY+2Jq03n6O1kdOOrsr4WCYHaYGMOoxd
	VvN4/8YE=; b=gKLtE9Czf9xlQ7/A9Euf+khkD/RuI0HlMNR35Z8O2fQEYmGP2K/
	2g2+wq2EvFNwOv8XTmpaJVzDzMUer0Vs1Ig/0zeBzNOYX8OC//YxaE3KEVrtUfa8
	rCf8uQnH8hXMEbsOydIDJn9qxJAXCJVrJTlN+w/4YGc9VZHc4QqmTn3EOM2vHgbd
	dxGxK6b6DwknvwCsSUxtmHbjjPUGjNwqGzzdEd/cN4Snvtvox6JMiYCJLK0rShRl
	6ATHO8xACcyQBEc+RZ5FgMxs83SIXuKmi1VY5fARuF0yFb73HlAYIfyW4peX7sch
	DtgzIx0VrBU0VOgJrSB5ogN60JfXrMmh7sg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794875350; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PQjAjR3GTfzFqKIeDyDA3p7aOCWYXwDXVlDGGgXsd9APHIV
	Z1XCc/2+H3myCfC/YO0A2gpw7zjUfLgRB1sZOwZle320irXBgk5DjuPxrBcHFltU
	Ujj1m23vyOg63fHXCeJlQjYuMNEiB2ato8N0JqFHJ+Nd9SNHKfr78gsTlDl3PP/J
	ZmV9C4dknqHNKPHXoLlXkDuHUnYbffudS6WvOBb8o3rXeL7HJ/Met+Q7/gbV8BCI
	RGhlGNUneTxDY4JyzlhUyvktounITqN+hyjdjvILgG/vPhaNwm/5vgqpOhrNypSI
	iGWhG61uX407DQNOVlSVwviX6HLGyA6XkQOVcxg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:TqTP2p2axxFqAEE97HqlIPLrI7MdxWi8lz4w2ElyeAg=:9ykYPY0ExN2RbtVx0g7QELAlronbN9UGbRs8x74ozYM=;
X-ME-Sender: <xms:1Z_7apBn0SNdleQ-YlF4e6pSzZBuvQuVTfz316uibI6kkhURP7UAxg>
    <xme:1Z_7arO5ZbOB2Aw3P0NDEQXZ_Zm1TtIQiyvOT2B4BUUiNQrsXlWIgfjkXLpdLjQnT
    VTICyloxC9_bFSMOrCzWv6CKiKW9x7FW-N2MCNM24iF_czD8eRObQ>
X-ME-Received: <xmr:1Z_7auY97nqnO6vw9RfMlLDcyB5uTonOPZrZZaYKSPnvouvjYHUOuqmj0lpeOarjg_AC0tU3VDBp6iUDjKihPtSCNnGUtJL6JLTu>
X-ME-Proxy-Cause: dmFkZTF8LnkUGFqt5uqifZ+Pg58UfQtPCX4pdk+XbxpM85j6CaF5GHD5jHeiOCb89LhNLn
    Ji6yijlwJJbNBXl7lFwaWXET5pQ02q0XsLvbtZYEhWdrpr1PXvscTVhWxzYeS1mCZ/7eON
    EZkhrC453O6ALEFB4u04xTQR5RsJuFMhU5Qp+1MVUN7tuurMk9LZr46YjK4Nl9DLcjMFX5
    xz0p0koIyCJGsm4mdFoT6RmgeGUOoGHdkWJ2VKSRNARv80RYhGzXBlF5SV8cSQUzHwXV71
    RERp1gIiHizFzXlpWfSTgtw//Olw10StCkyBx3PuLK7L4f/1rebL0ycPflub0YSFPzWyqd
    w49/bidDbssqG4hsefoEOT84N007nkS1HoH34cTcqr5C/sQJM+Zcr8ZjXnhFVn0MrvROIO
    5PXGG0s6r696s2jdbg4hYZUXFY+UxzwvRVXvF85Mqm66n/eyQx9FM/4+U/GHNZl+wjlvo3
    b1WhE8Rv6gLBhSeYo9vrv6b5mehpH2tr/SS2JJemNycY6rNQ0Uzhf5Wm8ZTTXVg6TynhPe
    RJia/aHNToOQBmjE2ByPxFAfDLslu+Qp5+tsARu8c9zXk4EBdOd3T0eGPtb3SlhwmUS6XV
    KvINldCgPeKQxngHnOrO0JY4NeEaf7QTwPa3F42t1gStvDvCiMJBt5lbq28w
X-ME-Proxy: <xmx:1Z_7aqtuAsvqxOmRO9g_xKr6gNETGJquQHBcLAnOEyhfsyA4RYd8KA>
    <xmx:1Z_7agOQkFWYR7XalcKRRc29y3LmgeCREgKnfjXOXtlizbAWz9pPpQ>
    <xmx:1Z_7ah4i5DvubM0jyuoA7UuugdsEx3XJS7cZ1mXeaTc4zMsCUOy50w>
    <xmx:1Z_7amTxefxbg0m2fBWR8Eb59Qi570KmhqiWIHcYpx0SByey-A53Qg>
    <xmx:1p_7aiGTU__RGISzvxN_EPSj0HvqF3ybBFeaQYisLbTUrjNKpdwwuif1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 19:29:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ravi Mistry <rmistry@google.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: What's cooking in git.git (Nov 2026, #06)
In-Reply-To: <CAF+mdicGt4+aydaTqjP1DJRzxpRBbKSQQNai7BvXepC5Kt1vVg@mail.gmail.com>
	(Ravi Mistry's message of "Mon, 16 Nov 2026 13:09:29 -0800")
References: <xmqq5wxwolja.fsf@gitster.g>
	<CAF+mdicGt4+aydaTqjP1DJRzxpRBbKSQQNai7BvXepC5Kt1vVg@mail.gmail.com>
Date: Mon, 16 Nov 2026 16:29:08 -0800
Message-ID: <xmqqh5hgi9m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ravi Mistry <rmistry@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * rm/http-retry-improvements (2026-11-06) 5 commits
>>  - http: default http.retryAfter to 10 seconds
>>  - remote-curl: retry transient HTTP errors in post_rpc()
>>  - http: add http.retryStatusCodes config option
>>  - http: add exponential backoff without Retry-After
>>  - http: fix retry count and Retry-After timing
>> ...
>>  Needs review.
>
> Since there have been no further comments on v3, does this look ready
> for 'next' as is, or would you like me to send a v4 folding 5/5 into
> Patch 2?

I am reasonably happy with the series as-is.  My eyes were staring
these patches for too long and I would prefer to see somebody else
give a second opinion review, even a cursory one, though.
