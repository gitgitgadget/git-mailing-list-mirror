Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765034EF0E
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590680; cv=none; b=nfzyi35Es9FAw7tNGuwM7XY1s/YCqewQbbzhwP24D+BTetWf90+JrEVmliU1JyihAv8AopPqfzGrfDN/p3ureai9sX3FaGok/JZjuTZ2eRxsP5wpefzOWH7bw2/P9pj98AylEyS5S8nEc7wEEAP5Icu7/jHoCukoL4R9I15B+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590680; c=relaxed/simple;
	bh=JvaHNEuZ/wOg3MPPaqNHsl86pL75QLy8Xq8zATFHb20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=in6h6IFohja6TdXEGw7hzWnzA4a08YX5h9MwZfzgYaDaI+12unTcPrMMeYlDeI/8Ub/Yxj9acU6+5l7B61Q1APQEadF+C5ozZRlexUrk6TNw3s+YST/fB1SERrFr7zko2YlxAfmt3VNHQ9aATneiL8+ZKH1l4rnXgxPvlR2XUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bg/PcOOL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzBYgQXT; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bg/PcOOL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzBYgQXT"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 118241400032;
	Fri, 16 Jan 2026 14:11:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 16 Jan 2026 14:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768590678; x=1768677078; bh=BNH5ZpAxos
	GBK63pVpH9Ht2CImKSpx58mI29ceE6954=; b=Bg/PcOOLPiC9NM4Df8gLJpDu5U
	0oclyDJPb2Gf6121l4kX55/yEfjXzBYbUr0fDB8W9wmCbc3bz2E22qn9Vc0f0W8b
	OqFDArdQCRs4KUtbhcjm5VY3upv0p90f7wWOPlmzHVDU4ZxitJM2c4DAStvizcag
	mTA8TcwtT/sWckMB4xjcTWp/9uK6HSpu0awnSTvYdx3c2e194jwah/lX49xwtKXx
	wp7zA4glHgFcv9yyxbI9MHLAHVmtHZEFF6V9Ce5JxVZkHcB20/yBxzs3dZJrtEbr
	xeTa+u85V3ag0Wdq6JPq8KR6Ox6wDkdylgSzvoqIzG6MTKdiFZhHCXeIORhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768590678; x=1768677078; bh=BNH5ZpAxosGBK63pVpH9Ht2CImKSpx58mI2
	9ceE6954=; b=DzBYgQXTc9Ix/8Ry7IIWhxbIib+nLt1juFIDvK4hsmHerTt2Jfb
	+XtRhCQzC450u+H7KG8GCdwVLmLRaEAOWe5HkpjVtvEvfZ3jWkmALp+wdOZ5ciYl
	gRj7LbCpgH9J/+0UTp7+de+o9vpilmliYrWOZnEmNIct5H7SagdrkRC8YHm4FMDC
	BBP5PsEdDkl9pfFJox/pipQfCUnlwp3c63Lzhyx9OpDuP7onapR5qH7ISCTQVhN0
	rX6QlRctuokJ3/lqVGeA2m0LuARK06GS8rTsi5FkU2DWRFrVHcPd0Ik6IqUKMHbo
	2pO0IYUfk4lYmnHi/0sO4Fg23ZIg19+rS9w==
X-ME-Sender: <xms:VY1qaSbOOCLi2tlcpOfJMrn9a8EZs82wy4OM_B159j5d80aayyz1DQ>
    <xme:VY1qaZEr35HRXAiyCX7wr752O8fO_4eHwyeWa8zhy1SHeOvwuaJVfpLqPHgpZK5RS
    AEswtclMNfslz3v1OD1B7uwhWJjeGEgEnAX-jQPYS68jAlvEuOcew>
X-ME-Received: <xmr:VY1qaWwtmc1_vjwR-UK4Ky_mXuo3qJJMZMczf3FYNY_CsEkx1Fdzw4sQUL7ESUqXhk6Kj8AivPDipMDoB0-JP_G3gTqsIDDxZFuvbqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VY1qabnOhJRgP-gGx-9r8URmbMv4B8yKWQpGs5tYy-4dEO5kfR__OQ>
    <xmx:VY1qafkJSPUy4hgKT_vT_5wz7WNf493cGV3Q6Aj179TQhSIQbd17vw>
    <xmx:VY1qadwTXtcrrrjewWhSVyLyI-9eJhOEftpEad2-eaeftB6MPSAp7A>
    <xmx:VY1qaUqTvl1Ict3RjjCOsJoRsAtnVRmSHDl_MpOC5gxUwnW--A3cgw>
    <xmx:Vo1qacK9ab38wB9HNpcuVkASxD2d-ARRCuLwdXD-JNETwe_rD6BoucVZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 14:11:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: amisha <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  newren@gmail.com,  peff@peff.net
Subject: Re: [PATCH] sparse-checkout: optimize string_list construction
In-Reply-To: <20260116165003.95314-1-amishhhaaaa@gmail.com> (amisha's message
	of "Fri, 16 Jan 2026 22:20:03 +0530")
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
	<20260116165003.95314-1-amishhhaaaa@gmail.com>
Date: Fri, 16 Jan 2026 11:11:16 -0800
Message-ID: <xmqqqzrp74q3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

amisha <amishhhaaaa@gmail.com> writes:

> Subject: Re: [PATCH] sparse-checkout: optimize string_list construction

It would have been nice to see [PATCH v2] or whatever that signals
that there is an earlier iteration.

> From: Amisha Chhajed <amishhhaaaa@gmail.com>
>
> Improve O(n^2) complexity to O(n log n) while building a sorted
> 'string_list' by constructing it unsorted then sorting it
> followed by removing duplicates.

By the way, do we have t/perf/ that substanticates the performance
claim here (in other words, how much improvement are we expecting in
practice)?

Also, have you found out why the previous round that did not remove
duplicates saw no failed tests?  Perhaps it is a good idea to add
some test that would notice if we failed to add calls to
remove_duplicates in this patch?

This is an unrelated tangent, a possible #leftoverbits material, but
should not be part of this patch (or even in the same series as this
patch).  I notice that string_list_remove_duplicates() almost always
immediately follow a call to string_list_sort() of the same
instance, which makes me wonder if we would be better off if we had
a variant of string_list_sort(), and call it string_list_sort_u().

Thanks.

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 15d51e60a8..7dfb276bf0 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>  
>  		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
>  			/* pe->pattern starts with "/", skip it */
> -			string_list_insert(&sl, pe->pattern + 1);
> +			string_list_append(&sl, pe->pattern + 1);
>  		}
>  
>  		string_list_sort(&sl);
> +		string_list_remove_duplicates(&sl, 0);
>  
>  		for (i = 0; i < sl.nr; i++) {
>  			quote_c_style(sl.items[i].string, NULL, stdout, 0);
> @@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>  		if (!hashmap_contains_parent(&pl->recursive_hashmap,
>  					     pe->pattern,
>  					     &parent_pattern))
> -			string_list_insert(&sl, pe->pattern);
> +			string_list_append(&sl, pe->pattern);
>  	}
>  
>  	string_list_sort(&sl);
> @@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>  		if (!hashmap_contains_parent(&pl->recursive_hashmap,
>  					     pe->pattern,
>  					     &parent_pattern))
> -			string_list_insert(&sl, pe->pattern);
> +			string_list_append(&sl, pe->pattern);
>  	}
>  
>  	strbuf_release(&parent_pattern);
