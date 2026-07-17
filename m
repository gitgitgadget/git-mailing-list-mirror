Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76021ABBD
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784321228; cv=none; b=aRfdUyw49MqyHxaVikGKG/LNiOghCWH/ZEzwI1HGAFR04gHNVXN8C3sOZfdCmBFwNNXS/PBjVa7TboI9HqSlyy4e0DSCsZtODFYFRSsGKESsC9ci1BlxxRcD2SaV2k1Hesb0fC7eKk5UEckHCtbQAhqJAgG2lJ2/Bl45dMDfc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784321228; c=relaxed/simple;
	bh=2CjQ37saBellEEmxxvnGq45n2oSUuWbqNBaeU2UbTAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BvElKCB1QLG/1Px9pv50YjcgBfWIg9NfR5WoPonP5isRN2PDLp/LLh68c3UFNg+YdQeCR2B0nFrV+Jn/WE44FJK4enksT8fvyy42ET/5NM+i8fW+qoOnSsZcxQdhkFi45p3MSy1VlnL4PImSYMskg59/kCBhJ0n8vFTbF93El9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lga6X47F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsE7AAjq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lga6X47F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsE7AAjq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F288614000B5;
	Fri, 17 Jul 2026 16:47:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 16:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784321225; x=1784407625; bh=5+Ag/7MGTH
	F4Z9vDy+xUQHfkWTDxfolP2737BqzjK84=; b=lga6X47FhOCdXO51xp5p1/GwzU
	azDn5R7JV84S8SPtd3lKkPy+eaj5WhpYo+unOB6vwGHhh/SrS2xAFabSbeI7ffpb
	4fozawnwGJ9AMzgDEh5dP3UrwSF8ptv29xKLQnSb/zixMTlwD5oSX4vWg0IGDBM7
	D4wfz/E+rZ4jQA6nWA+UXN3ppKN3RrlsLv0u7KykKQYKny7GZQSzi61v+eciemaD
	7gGp87cu+TZG+Yd7CEa+GSi36wr0r1wqXSCOaYqWTVOxnLfCq5VsqHYSGc3tcR4f
	fxEl6brxviFUn90QztGJEQb+JFrsMvmitScJtK2XrnFIhVMVsOH6Q/Qf7CaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784321225; x=1784407625; bh=5+Ag/7MGTHF4Z9vDy+xUQHfkWTDxfolP273
	7BqzjK84=; b=AsE7AAjq9gqsRlnlnLzJLkJ6WeuuG+nT4LHhwIWgBN5p13LM/xq
	cmLbcT33OlG+m2ySbqWYD1oaJPyBMTdkd1MXV8ciBt+v/fCBgTxmkf3dnQpgBPHK
	ppi/7IJO/jmoTg5lO3SnXkVVStNwgf+R70Qy1P1vdukM35aMTDT1meCyK3e0Q8eA
	z3eWRduA0Ot15sUXfl6nmJLu0ZfP85Fh1q8UpKJsZkRxaeeDsCGTxbrbycJe6RtY
	f15KOptNZbnr+JqgrJEXVF7en/jckIRtwaPEyBlkDKzFwNnr5mYU+lJo3tD3zurx
	hwBbH14odTiZu6wsO/GbyMwPi8EOCsypWCA==
X-ME-Sender: <xms:yZRaaotnzrU1Rt5mmqLdS8ieZ_UxLw3A3SMkv8FnTxq7-PovLva5eQ>
    <xme:yZRaasXeOfPdZwvO4RiLKCYJHtk3m0i9vnBiqiwTgC3c2bdHBkIgqHMXyPeRtyH8F
    ZBLiF0F503T5Q2gzONPE_58f-KVHXZHzcnozT_rAZWf9DSiQ8U1>
X-ME-Received: <xmr:yZRaasFqd2QkSRxetkQyUTm-lHsQ_MNUWUtVtFqqk6wjtg4knFyjQUhQcLFA-k9y17QkbbyBbDliBq-q1h1-Ij-XBobWxe2cKhgrqtw>
X-ME-Proxy-Cause: dmFkZTFeo9ZWDAzMv7drt2rLDuhAhwo80H4cCLw8CDmPx0TQJEvFnapKJVpNDg+/AS72Qs
    gWqELcZ+zx/85mRpwTR0H+5+ZwBYr0Zekme4wZeWltLL3sZA0zbqkJd38h/f96PMoC3o0Q
    A2PID8LW9n6qShh0yS0VcuVW8ljqs3RByQi6AwjT5hioXG8ChKWbuceoAwPoNhVNF1s6to
    XE3KkK9EHOaWB7+duCkr8grN4KqALWSYQkwbfs8GNc442lRxFRg6xeFNppQmejaMh2P3uT
    qu6QTjy1FBl+LSo3+igUuem7AdHQ4yUNsWBH6n09RmjfjrGDyaZS/X8o7MtxwfWzNY/BKj
    x8DPbpgl5Ib2USL1xpOam7jCGKuygAYNe3qtklDUUoDd2AuKJxJAYEF/o7/g6LTdYfV5yS
    azI+ilEMTb0ymLSsgUBZwBcXr3mnJqXMcUCkJhXcDzmHL1K16Kjine0t0J9jXtcLGV7INm
    mRVP81Z7ULHh/cRR5SxS51MX2hD3cmxoLioSjbfo5/vBMfB2shcoeE5DTiCZBbkK9zgxUl
    Hcr0tr5VyyRGlWKfplhOe44UzlYMc4PAdEWCY7VO5+7tCV3vlOJ0I/ketSmk3ZA4g91+46
    tRw8dJkKNEo6rcSTx1hMj4gJc3vHpJsxwgnqsRa1Z51leKnq+iz4Cws4Xwlg
X-ME-Proxy: <xmx:yZRaam0ET17dcV2q3Y8Z3IfsD5eHR9bQL2R2GHXXq3CjEAvpXRbtYA>
    <xmx:yZRaamONMPVNI7xw9CNUD86HCKzVGtqh7JMkGNjo7qZIUWjQwFJPVw>
    <xmx:yZRaat5-8zl1vfemx8RDKmhOiFJrvptzax_hswaqqweShdU2fOysEQ>
    <xmx:yZRaao3AiT_5d3YW5DptAD8ODCNHnlKMSSum0qi9glBk8L1DwRHVbw>
    <xmx:yZRaarIEhW7e0YXnj50jMwKUOyeycOSo-lkSD0NwttFfg-aKeRQ75vMY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 16:47:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Gusted <gusted@codeberg.org>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 2/4] revision: expose check for paths maybe changed in
 Bloom filter
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-2-410418f18614@iotcl.com>
	(Toon Claes's message of "Fri, 17 Jul 2026 17:47:00 +0200")
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
	<20260717-toon-speed-up-last-modified-v1-2-410418f18614@iotcl.com>
Date: Fri, 17 Jul 2026 13:47:03 -0700
Message-ID: <xmqqwlut1gzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> @@ -748,26 +748,20 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
>  						 struct commit *commit)
>  {
>  	struct bloom_filter *filter;
> -	int result = 0;
> -
> -	if (!revs->bloom_keyvecs_nr)
> -		return -1;
> +	int result;
>  
>  	if (commit_graph_generation(commit) == GENERATION_NUMBER_INFINITY)
>  		return -1;
>  
>  	filter = get_bloom_filter(revs->repo, commit);
> -
>  	if (!filter) {
>  		count_bloom_filter_not_present++;
>  		return -1;
>  	}
>  
> -	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
> -		result = bloom_filter_contains_vec(filter,
> -						   revs->bloom_keyvecs[nr],
> -						   revs->bloom_filter_settings);
> -	}
> +	result = revs_maybe_changed_in_bloom(revs, filter);
> +	if (result < 0)
> +		return result;
>  
>  	if (result)
>  		count_bloom_filter_maybe++;

Doesn't this change skew the stats?

In today's code, revs->bloom_keyvecs_nr == 0 results in an early
return, without touching count_bloom_filter_not_present.  In the
updated code, we would not notice revs->bloom_keyvecs_nr being zero
and call get_bloom_filter() first.  If that yields NULL, we increment
_not_present variable.

Also an error return -1 from bloom_filter_contains_vec() breaks the
loop in today's code, increments count_bloom_filter_maybe (even
though the result is -1, not positive) and returns.  In updated
code, an error return would return from this function but neither
_maybe nor _definitely_not is incremented.

It could be that these two are intended "while at it we fix it too"
improvements, but then they deserve to be mentioned in the proposed
log message.  Personally, I think the first one that increments the
_not_present statistics when keyvecs is empty a bug, though.

> @@ -777,6 +771,23 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
>  	return result;
>  }
>  
> +int revs_maybe_changed_in_bloom(struct rev_info *revs,
> +				struct bloom_filter *filter)
> +{
> +	int result = 0;
> +
> +	if (!revs->bloom_keyvecs_nr)
> +		return -1;
> +
> +	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
> +		result = bloom_filter_contains_vec(filter,
> +						   revs->bloom_keyvecs[nr],
> +						   revs->bloom_filter_settings);
> +	}
> +
> +	return result;
> +}

This is inherited from the original, but I think it would be easier
to follow if it were written like this:

	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++) {
		if ((result = bloom_filter_contains_vec(filter,
					revs->bloom_keyvecs[nr],
					revs->bloom_filter_settings)))
			return result;
	}
	return 0;
