Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE184D98EF
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364873; cv=none; b=ZJLY9O7lSBp7dslTKQUfuC1nkwDkOfxoJ4F/eUzSWkjy1/bMmlds1SeHeDZoVkt8lp3ZSEGuH5kCfxlIGfuKbKoherkuZEjbvBaO9QNsQtROqikWAc3/N/H+qEXMWu8d/lX8ppvUFt/XVBwW2mWcqRHRMQZ2eLPkols49Ti2e48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364873; c=relaxed/simple;
	bh=r28xSaTfJcD+bfDUo+sYy0+d+W0eXDeoKOrz5G8EUMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sD9WbGrYU/0Kt496HFOeMFNQxBAqBJgj4f6efXFL2PDv0H+327hmMVRnZlC3axBMKkGmKa0T+8PhX3gdD/eOlqqPI1Z8vtR73tnKNGEqWpfQOjQK2bJ4XY8Thn/KnOZoypq9tkWk1bG/JtJXgw8CiAOiW37SKOMTnKZ7U1gxjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fpNGWL4g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lV+DKmOy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fpNGWL4g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lV+DKmOy"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id E5BD2EC0064;
	Fri, 25 Sep 2026 15:34:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 25 Sep 2026 15:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790364869; x=1790451269; bh=VIlVRZwPWk
	HEOYVOuULpfDyhz/toeibunfn9r5sCrJg=; b=fpNGWL4gHpccpZAUmoDAZmNIaP
	R21u7izOvy8rutea78fmGsLTwH9PFKbYNdEriDscwvkESw5e1Xfc8ErenB9H5SlI
	xoa5+H+3fJk1T92Q8MYJTefF6G4wEEp33EibUb+z7QoWlVfTOa3sKenlbnjURlaE
	XJPMW2hHP34NL9P1aklzj636p4lV4U5n09iDL58m9o24tcF8x8NhSEeF6ZveooVc
	pl2hhp5BYpMkmmyMO/7Q1NdUV2pRsRBkAQRX4rbMWyz31eIxFR26rnIEOkZzyfjY
	yU0Qm0R4Kc4shG2CmUp1DBoPXWDF+Ymgb+iLwOiK1emFs0Y47gOQ0M9dKgFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790364869; x=1790451269; bh=VIlVRZwPWkHEOYVOuULpfDyhz/toeibunfn
	9r5sCrJg=; b=lV+DKmOyjfwCCC4lIZ+rkmpeVXWAB5zJBWkF+d3CpIHqEjaSg/p
	EnK0YgZtpdl5RUSd99XjcvUUX9/q1PSgWo7oAQxHZafYRcPKTXGzLUNYUq+gbpw3
	Qh2yN3pdBFkXVKZk8fuMioNF5lAU5OPz7tAr/ysBzcCdYQQRbXIfWAZGXZXRJUS9
	pG5BXNWdR7ZJwa76TugS5nE0AUV43lWtw532unRq3VW/JMt+y+LfnhC5qj4JXvyB
	aHFsJ0HnV2YKBzYWEPw1huDFT01vPks/5uYH/SKWca3atVg8w/kewgygFqXbzLo8
	2SIIUFn+P+PnDDmKkbrigp3zzK5cOX78v7Q==
X-ME-Sender: <xms:xcy2algTPP3dC7nNFA10K7zCoiwfJM_ApQJWgKE4I3gH9rqqmhYPJQ>
    <xme:xcy2ahdE56K7962hFFl7xNq5whMxCssRypaXRBHsNBiY7Ft0uj0RicPUnx3gJmh18
    byk9JFBT8xaMDjYxzWhURpepM60wg7wWsCkXx9C8CQgn9HRUyJ9JQ>
X-ME-Received: <xmr:xcy2aiewVg8h8hU-LWukthIWrI_4sHE4C6uDIeCVh6Zc5me-zMe3pSCSxyqMjrKQTmai8SF2XePgiW6OLanlqA_kp5JeMyV1oaDk>
X-ME-Proxy-Cause: dmFkZTGS6bvlCRL61ULTTx8rFBcaNRJsA4deHbzQss2fzFW6oQAduPBxy/IisSdYmKdSK1
    hBoYnwA8yE5kOVgD/Pv5Xh27/ECdK4eOz/x05kp92UOKpr2OmCUi+JKEq0rSwtM2QTVkcL
    eF3zHvA6LeLYda+xJEG6yrGqh5cEhBTIfB0t65cs6BDtJK1eF4n0Nm+1+y3WozIdu50QzX
    z620rIURgaaE4mzkf+uIDdXS2a2FDbvOTrJISFd4kClYKYcNiSpcby38UfacztgmiY8KZA
    ycP1EFZzFGrkFAdkmnO5u4Eg0sY/D+sqgjCwl+Cow+POFBWFcjiW28zrmaxUK88l5edoch
    s+hn5NLPn0bcrFK8KC9253O+z07UxIArS73S90O8oC9GF9hlZNCBn96ml594rhuWnQyCUg
    aZTevJkPAmpjJL3zmiYiLEvjNXyDzuuQwytTVzlQoGwG0/akXjlRTplUE2PAQjaDu/wFKz
    wirMCSLyfMxLkUhSrt808mWb5SlDCiK2kB1SETL18jB6vHYOh958Pzhi9ju1BH8ETL0R2p
    7DMGDtS8zrvsrNoY3fbmyWU4eq8D3PGuASF9z1Ih58DI9tOyhlUT4RMgt214kQTtbNJtBN
    7Q8ypxJiQjmeVobh/z1yUTgBwgfSs47DUzY07Ssnh4h+/YxPBI50dNhxknkg
X-ME-Proxy: <xmx:xcy2aj-O6ohXfiKgaHa2Ynjxu53jKDoIDxGEaP6-pXLFy236PqKVUw>
    <xmx:xcy2ammmIDZcw1g0X48qWTsnE6sHio3f0GfppHqLQLZ4AQPh6EdKNQ>
    <xmx:xcy2at-xxuIPM-n5uVhIqPo1FWO9ql_1HqYLMX1b7FjKv4N8G6dL_w>
    <xmx:xcy2askfz9tJCh-bn_1Xn4EM6tcixSoFY5kPOs21SLdGQtU2ImSdvg>
    <xmx:xcy2apmJYfuLQE_vXQQUDySPqjXf4uZxGaApO2_gYeU3o_ZKlsmz3-fv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 15:34:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: git@vger.kernel.org
Subject: Re: Rewriting the Git tutorial to cover less content
In-Reply-To: <17c46e4e-a4f6-433e-8eea-c1e4eb28fdfd@app.fastmail.com> (Julia
	Evans's message of "Fri, 25 Sep 2026 15:22:29 -0400")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
	<pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
	<20260925082723.GB1493716@coredump.intra.peff.net>
	<bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
	<xmqq7bk9wa4y.fsf@gitster.g>
	<4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com>
	<xmqqh5jdur4c.fsf@gitster.g>
	<17c46e4e-a4f6-433e-8eea-c1e4eb28fdfd@app.fastmail.com>
Date: Fri, 25 Sep 2026 12:34:27 -0700
Message-ID: <xmqqv77tt9a4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I don't understand what you mean by "replace the current one". 

If giteveryday for example is so stale and unusable, we should drop
the entire file.  If there were some topics in there that can be
salvagd, we should freshly explain these topics elsewhere in our
documentation, and starting a new document is one way to do so.
Then we "replaced" the current "giteveryday" with something else.

> Some interpretations I can imagine:
>
> 1. The documentation remains internally consistent, like if it says
>    "see <page> for <information>", then the information is in fact on that page
> 2. Any information explained in a guide must always be explained a
>     in some guide in the future
> 3. We should aim to make guides more _useful_ over time: on average,
>     a user reading the new version of the guide should come away having
>     learned more relevant-to-them information about Git than with the
>     old guide.
> 4. The original intent of a guide needs to be maintained.

>> I do not know if we have bandwidth to keep external links fresh, and
>> having a set of links to stale pages ourselves may hurt more than
>> help.
>
> We've had a list of links like this since 2013, at https://git-scm.com/doc/ext. 
> It definitely has broken links and it would be pretty easy to update
> some of them once, which would help in the short term.

Dealing with broken links is easier as we can just remove them.
Noticing a link that points at an unmaintained stale document that
describes what used to be relevant but no longer in today's
environment and replacing it with something more relevant was what I
am worried about.
