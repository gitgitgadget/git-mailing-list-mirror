Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3B31987D
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770363608; cv=none; b=sA1+4LxHeQwwhTodiGHxuGT1jHXPtfK1cKaYbKOzqLAE7EJXYnEXMBD7HcfIxQLnoeQn6H94n7J1cdWGl6khsMpVsfMs5kv5Le3FMxQpPczChlDG0mzH8ohV5EXocDIkpYlnRRlTblhYjYsbSqj+wfC+A37EsgwOcaJZIgKVSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770363608; c=relaxed/simple;
	bh=b0DMdLy55Ii7b7MPt2LL9+tTG0Ju4tzxSZptd0vnSCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF3tGTU3r9Q0vOyLyVOU4mbXSwfGSpZccQSwI8WzrOSQU1e/I2WVnkQgFjTd4AI8l5+ppqrghsB7HcUW4OIZtHJy/HXyN6S/QF9/pJHQc+At0CK68Y33gjGeOaKVaDUGaF9s7d71VprNB3cXVD5gQp2VVJjrpMn88PEvTQbszpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W8x211R/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5N2C27l; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W8x211R/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5N2C27l"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 719A91D00172;
	Fri,  6 Feb 2026 02:40:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Feb 2026 02:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770363606; x=1770450006; bh=OuxymK+W0/
	ckJLYyinaG9lmfY5GEZPvIbi5Me8aqiZU=; b=W8x211R/9fBrwEvGpsEcuv//g1
	3F+2qrs9CjBGRa6quxZhKLKRRJyDnegFhhFNM5eOWsDXhkt2xBQDHL5DdpHN4iR3
	udT5IeRmFIRqXgDMtHkJ2Y410cqQg05rV++ipxFRDQpoGesZ2xWE+2wuJ6Ayo1Br
	mai5dMhwAeOYKVdOMHbNJfvLKQU4KCFu0w4IEcWPSPyPt1x2tapWFb2VsHv3EFXn
	LyDP4nD9U3SReYd1AXqogznQriGyFJX4vCn+CN66IA0gq5sbf761OMd/g2f6oRzJ
	LedxO4996pqsVydyErVqHFP0yKJtnEBIQiyuBB3+7gC9AKHqD4pgrdsvXWBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770363606; x=1770450006; bh=OuxymK+W0/ckJLYyinaG9lmfY5GEZPvIbi5
	Me8aqiZU=; b=q5N2C27lLDFa+pYe42BLEOJC36Yf+aJc+LCLAuH+YF+iU4VjJj/
	bqkJL91EmdTOXtDQ7xetP8BX/SpzwVyE2JqzIYUrmCT6fBzeaSXqz6KBN566YpyH
	+4mNS6fv0Z613GRuwTwn6rerJ1GaEtXF/+XXtGvqqozwl6IU9tztFP03VGaWJiGR
	NweUdcrU0Pq9gi4r6iT02C6kZlc0tpfdL/4oC5UIdiXjoXIq7yQUz1g1xc7WLWHX
	pVa2i+SX71NPTwNtu9PsDhGonsbNv611z8OQFOBay5i7Ffm3HphayadMHF4EmLUu
	uUWoibYSsRiC6lHUSbM1E1uqCNXDboPW1lg==
X-ME-Sender: <xms:1ZqFaRAXFGhVxHwezbSfmkUtB_WCic2FJg5kDokEOafomHtfRq_pjg>
    <xme:1ZqFaW8p2DHkGiCWq2pfdfduB43AtGeqS6IbSQL59daZjjt1qj_5-VVk9EHOfYkc1
    BUzQF0AJS5pIuL9u-ld1yxE25WqHei7BceTNTT_bne-vny-rUFiV4A>
X-ME-Received: <xmr:1ZqFaZ9mFRfuCYNgVFHAuiFH2kqwGX-Mxyzn9v_4gj8j2JyeBUvDYkDm63GKAKQQAqauGFkFxyX9QuIpnownHrvaVUlXqnMMC7IwvC-Hnf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefhe
    evvdegieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghskhdoghhitheshhhofiguohhirdhlrghnugdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:1pqFaVcPrnOUxdvg8AfQUr52KAQf0hxMLFlnBtsm45N9whD3aRuPGg>
    <xmx:1pqFaaEteqMxGsTO3XDhaY2RGqmhTskTRa_tIi5n0JNw_3c3zcfh2Q>
    <xmx:1pqFabeUARn1NhopjmtfV2osR8krc_gGVTHIjucyoAXufOMdpzV4jQ>
    <xmx:1pqFacHFz0mpemoKPXVV6eabbygRk50qOWxzR3WVOrXzPHFS4ipejg>
    <xmx:1pqFaTJN4KAnMgVA66zvzBNE_62x2EQ-yzQDlfiTF_vL6WCv4VB3AEto>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:40:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccc418c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:40:03 +0000 (UTC)
Date: Fri, 6 Feb 2026 08:39:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH] ci: avoid ubuntu:rolling in most jobs for now
Message-ID: <aYWaytvnR8wOdc1s@pks.im>
References: <xmqqy0l6khkd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0l6khkd.fsf@gitster.g>

On Thu, Feb 05, 2026 at 01:26:42PM -0800, Junio C Hamano wrote:
> We just was hit by buggy uutils dirname in ubuntu:rolling.
> Avoid breakage caused by being on the bleeding edge.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * So here is what I have near the merge of "let's test contrib/
>    stuff as well" in 'seen' for today's integration to avoid getting
>    hit by broken dirname in ubuntu:rolling reported earlier in
> 
>     https://lore.kernel.org/git/ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land/
> 
>    Until uutils used by ubuntu:rolling stabilizes a bit more, we may
>    want to keep a patch like this in our CI jobs.  Or we may offer
>    ourselves as a guinea-pig?  I do not have strong preference
>    either way.

I think being a guinea-pig and reporting any issues we find to upstream
would be the best outcome. It's feasible that eventually, Ubuntu may
fully switch over to uutils, and if that's the case it would be great if
we had already ironed out all the bugs that we happen to hit ourselves.

So I think demoting to "latest" is a fine intermediate step to fix our
CI, but ideally we'd do a similar workaround to the sudo.ws workaround
we have in "ci/install-dependencies.sh" so that we only disable the
pieces that _don't_ work. That'd make it easy to contiue using the parts
that _do_ work, and once the bug has been fixed upstreamed and has
become part of Ubuntu we can then disable the workaround.

I plan to have a deeper look at our CI next week anyway to fix some
small warts and a test failure that we hit on GitLab with the MSVC job.
So maybe we commit your fix as an intermediate step, and I'll then
revert it and come up with a more localized fix?

Thanks!

Patrick
