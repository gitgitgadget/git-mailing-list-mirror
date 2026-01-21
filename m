Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552C32FA21
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985512; cv=none; b=hi63LYajMphninlRI6kJQJN9VTXCE8wGXC6vdZcSRspFh5kVxy734Vnn+D31kvd13wtBSpUKaYPCtQrevFh4nBpoehZAVYSS4BRBlZtG3Xvo3jXYnge981Uq5wHcp9N2HLNrWrjNTbnBA+GDIslXVj8Ovi07Dx3hxnYwagGFtI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985512; c=relaxed/simple;
	bh=01wX+LP2w30v5a947x6gCzZEc3ZyEPVhbFUxx322k/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4XKpDgVNK3xTzZhJWH307ywcTc5QS0o23DJGFgPTlS72lyLF9BMMVppZ26HT79F7M09incUjaWHr0IBTWN4KkE6AUBbPl9/d9+bur3HXMJ47lwDbaa/lvH8Gd71giKrCSegu5vZOEFRsZvGRs3E4N+TqZyxDvcrh5Wh6fBWJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FOYtVhsK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=txu/q8Ei; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FOYtVhsK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="txu/q8Ei"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE7707A013F;
	Wed, 21 Jan 2026 03:51:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 21 Jan 2026 03:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768985508; x=1769071908; bh=Ur/ReM4+T1
	a1snAncdJkbpHSgXMw6PVnNzUrcN4NNhA=; b=FOYtVhsKAIYZzZE9Hx9ac7SnfS
	s7FzucoB2o6YlPWa1I+ORX9cvp6GfGDzda33BmjWCHUjerSQa+UR2PK3YxVPy90m
	ma18wVnYaEcxtWCi50V84oZCbY7PmAy3XDEOBP1RZWnbg6fooZ+qoiUcZLSgfwZh
	cMqcuEdtCyFNUQZgLEAIQNRj9uVDFsMG9csJqdFGR7te6Kg4Haa3rHr/mHYn9T2k
	AlUWTppnvVpO86c6SSNja9kQJAIGF25T1k6fwgEc4RYYh17ykqH+4iUtj7Au6Wom
	jkS/F0xJzKFeTYQOdxXW3PSQSJE1JrJkjL+MUBN6HukuvZqcaM4OWQdO4U8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768985508; x=1769071908; bh=Ur/ReM4+T1a1snAncdJkbpHSgXMw6PVnNzU
	rcN4NNhA=; b=txu/q8EirYEV3HqnSpzWLtUuXU0552ZUuseRn2dR7R9m47Lwn0I
	awL6h3dkH6GHhCucKHRUbYUhpiWVuCGAEW0EA4DxlRncvRHAWeL8yEu2SfEEsy0i
	Ps9wslDxAcHhpC/2m5Y2bBjBXwY1K6U5ajYJeuCz5teUn7TtOxCZHffA5e+oeTEh
	yoKs/LQvRNOD6ICZn9mxKZneo/NioCQC5kJl/LL+hAIGTSVbPo+d1/Czi3CpEyr8
	mmB7AH0mY9zp/w5E1WbgXJKewDoiR9yOKh5mHtAasUsoxNqFc9duMsUxd0Jk/jqX
	qeGYrGW1d/km7lT8uP3YRvMrtZbrEu1VcrA==
X-ME-Sender: <xms:pJNwaQRFXxESagRZYb4zaD_o8r5GsQcVmxhoEMkU4zl0Kst-bZAj4w>
    <xme:pJNwaUrhbjB7IK51aavJXiwTqkt3d5CBoYpfTRPi7cTxma4CXuH9wEjyZMfon0_6E
    eXzCct3DdWfxWeVDNwvesN1YO_-2agkqm0eb87jhxZr9kJxVNXRb5k>
X-ME-Received: <xmr:pJNwaWL76LwJme1sh2-nIdpLite9LbHL4mGp88uXpU4whJawVXmwvnpiQHAgrwmMXTH3Re8jLj7BliLL9JObSd0t71V5-Vl5-ct6Ol1RdXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:pJNwafo-BgEb87KUPd3MSe-NELPwcrR629J9lj2SJQoM-2FWKYaUzQ>
    <xmx:pJNwaWwpyxvzRFOB8kCJf6kmKDivSp8JmMm2kvgaUAdhAEesybfEbw>
    <xmx:pJNwabMERDilT4lVGJ6TeoXiT7tt-IXtvYEf7rf5jBYm36ki2i9JJQ>
    <xmx:pJNwaT4abPZOdaR3F0P_mnpDBkeRWseP4VG6TcZRp62htzFNeWKFOA>
    <xmx:pJNwaZ-Dr0myytonID-Cjb3rCYk6P9c-OFqci8dlH8gD1xbyg-HF5_Sk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 03:51:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 245a5f58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 08:51:45 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:51:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <aXCTkVpjJkTabx_0@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
 <xmqqpl7beugj.fsf@gitster.g>
 <aWgSzI30k0BZfZ4Q@nand.local>
 <aWgwn2rk/qw+fRoA@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWgwn2rk/qw+fRoA@nand.local>

On Wed, Jan 14, 2026 at 07:11:11PM -0500, Taylor Blau wrote:
> On Wed, Jan 14, 2026 at 05:03:56PM -0500, Taylor Blau wrote:
> > As for removing u64_add(), that should be straightforward as well since
> > there is also a single caller. Let me know if you think that makes sense
> > to take up as part of this series, or if you would prefer it done
> > separately. I tend to prefer the latter, since the state after applying
> > the above is that we avoid adding any new callers.
> 
> This appears to be easy enough. The following applies on top of 'master'
> if you want to pick it up separately:
> 
> --- 8< ---
> 
> Subject: [PATCH] git-compat-util.h: drop u64_add(), u64_mult() helpers
> 
> The u64_add() and u64_mult() helper functions were introduced in
> b103881d4f4 (midx repack: avoid integer overflow on 32 bit systems,
> 2025-05-22) to implement overflow checks during a fixed-point
> calculation when estimating pack sizes in the MIDX writing code.
> 
> However, those functions call die() when either the addition or
> multiplication of their operands (depending on which function is being
> called) would cause an overflow. This does not allow the caller to
> provide a more detailed message, presenting the user with an opaque
> message like:
> 
>     fatal: uint64_t overflow: M * N
> 
> Let's discourage these opaque error messages by dropping these functions
> entirely and instead having the caller use unsigned_mult_overflows() or
> unsigned_add_overflows() themselves, providing the caller the
> opportunity to come up with their own die() message.
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  git-compat-util.h | 16 ----------------
>  midx-write.c      | 15 +++++++++++++--
>  2 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b0673d1a450..24edd68c671 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -641,22 +641,6 @@ static inline int cast_size_t_to_int(size_t a)
>  	return (int)a;
>  }
> 
> -static inline uint64_t u64_mult(uint64_t a, uint64_t b)
> -{
> -	if (unsigned_mult_overflows(a, b))
> -		die("uint64_t overflow: %"PRIuMAX" * %"PRIuMAX,
> -		    (uintmax_t)a, (uintmax_t)b);
> -	return a * b;
> -}
> -
> -static inline uint64_t u64_add(uint64_t a, uint64_t b)
> -{
> -	if (unsigned_add_overflows(a, b))
> -		die("uint64_t overflow: %"PRIuMAX" + %"PRIuMAX,
> -		    (uintmax_t)a, (uintmax_t)b);
> -	return a + b;
> -}
> -
>  /*
>   * Limit size of IO chunks, because huge chunks only cause pain.  OS X
>   * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
> diff --git a/midx-write.c b/midx-write.c
> index 87b97c70872..6006b6569c8 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1738,8 +1738,19 @@ static void fill_included_packs_batch(struct repository *r,
>  		 */
>  		expected_size = (uint64_t)pack_info[i].referenced_objects << 14;
>  		expected_size /= p->num_objects;
> -		expected_size = u64_mult(expected_size, p->pack_size);
> -		expected_size = u64_add(expected_size, 1u << 13) >> 14;
> +
> +		if (unsigned_mult_overflows(expected_size,
> +					    (uint64_t)p->pack_size))
> +			die(_("overflow during fixed-point multiply (%"PRIu64" "
> +			      "* %"PRIu64")"),
> +			    expected_size, (uint64_t)p->pack_size);
> +		expected_size = expected_size * p->pack_size;
> +
> +		if (unsigned_add_overflows(expected_size, 1u << 13))
> +			die(_("overflow during fixed-point rounding (%"PRIu64" "
> +			      " + %"PRIu64")"),
> +			    expected_size, (uint64_t)(1ul << 13));
> +		expected_size = (expected_size + (1u << 13)) >> 14;

One downside this pattern has is that we repeat the computation, which
makes it easy to get it wrong or forget updating either the check or the
computation.

I think ideally, we would have interfaces that combine the two
approaches in `u64_mult()` and `unsigned_mult_overflows()`. Something
like this for example:

    static intline bool u64_mult(uint64_t a, uint64_t b, uint64_t *out)
    {
        if (unsigned_mult_overflows(a, b))
            return false;
        *out = a * b;
        return true;
    }

This would let the caller handle the failure and is thus quite flexible,
which results in the following code:

	if (!u64_mult(expected_size, (uint64_t)p->pack_size, &expected_size))
		die(_("overflow during fixed-point multiply (%"PRIu64" "
		      "* %"PRIu64")"), expected_size, (uint64_t)p->pack_size);

Patrick
