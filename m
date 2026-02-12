Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951941760
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880254; cv=none; b=WAsgQi/pSvpq6bGp6c3lfkg/fAMVDyX0jrXhc/sqXgoT0cXBTBXJLdmRDNJ2MIg4fqq87EzhOl+OuZUH7R06Ca3PHlFpcUd3QP1j14T3I9SHSICv+te0miBsEd7xZX2x+FE5K9dajbOBW7CUp45cbGzDQ4Y34to5V5IRFSjTUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880254; c=relaxed/simple;
	bh=ilGala0iQpkH/QN6avG88cBZAL/p79HQGs3HXYqgdh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIBiA5jNBsgDbHqYJVoA5ekPhqun4X7XJsc8E1cuTGU6ZyiZYtFvZvfp+j4br49no0TR/R1Hv1su51kIux//dTHMQeF2mMdtKX4tVcHCVfuct6yGgbQGQCJbVyjUvguDzj/6G1VnNw4Y32rVmA5y30mZqxy2+DC3asgbq1+fZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RSxO5DML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNcvtP83; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RSxO5DML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNcvtP83"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 751CA140001A;
	Thu, 12 Feb 2026 02:10:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 02:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770880252; x=1770966652; bh=vD3piml0r+
	uBnKf2sBHsrzA+uECJH3XNHU5Sthd2rE0=; b=RSxO5DMLuOoYmR7FQU7vwbbHBc
	9pEzpC7kt+A/QSvFMzrPUiLAk9vClon+SgKBGMAKAlk7gg4aWKIpG/Dn3gTRWeb7
	99sfQTsAArTdFZA5AGELdfojkizm+oxItz2/0t8TqT1Aq14Li7Q7Hz9HmtFJCAQu
	BDDVsq79JZ4fRdM7hkBXWqtJ9GVnTVOc1dOLP32T9R2pXX0rHR0M9Bhgz4ddKDAH
	MS4NYey5KytiKagLOFpzu9ZNUVGMXNPsiZ2hWK0vCrHaTNmR/oPaYskwCGYs+lgX
	Cdtemgk0mRSsnKZwhMbtpyXfWtw6wTI0/W7XFe32zfiUDeOdnTVLhuaAZ49w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770880252; x=1770966652; bh=vD3piml0r+uBnKf2sBHsrzA+uECJH3XNHU5
	Sthd2rE0=; b=PNcvtP83S67lWu+WPjcibCrSEMTZUr9OmH1YUPnMcvRzMdmRbKU
	YuBMsNsu/Q+zKFP7UtGrCvT8yhATYCYl04XLgjsqIYZxZHi2tKJjB1W0lmEKbBKg
	TfHsHiVpwTyTvr184FbklCwEYhGnltvlYrUtQq5zQPBiT+kRqZN+ohDg+QTVcaEe
	b6lyMIGbPKt2LdmZneHWfVl0lrit4aGr/5CJpubNxWu4+iPpdXyzNoNOjX4etTjD
	nvTNXQfIzhiDQzVKQXX+HMJxMgU8RWb3UXO+e6ga4KnN5wUdxU3cEy2w7zMpWnuk
	Gldq234Jl/IX4mxAqTYyzmS3nKVnsEqnG+g==
X-ME-Sender: <xms:_HyNaX-BB0rh8-VEXjqpnSlGDx1vmRBhKMxC8qPspxw9fZ2cVmBnpg>
    <xme:_HyNaZvcMZ9qv162ytMhy8HxaRESXwShoGgYvXXKMkXbT4iPw5n3nZqGhDhrH5K1p
    axC0aOgXrofAZm6IrKoPBad_k0RYaPwhJwLlfRPhZYrTzUKCtlpKw>
X-ME-Received: <xmr:_HyNaSomm5FaZKaI2KJimulF8ZEoh6GXNT_URfYj7P0P-OL5pePQt3fiKF09gDuso9S7-xMTr7cVg1TNzdU3fy8tC4cCTBoa6DolURAg_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_HyNaelE6yX8d4GAn5NHuA1k83HKSkxBcL4NtFeWNr2R8sUum08x7g>
    <xmx:_HyNaewqqANbcJmnijZVBkQWxDKvuL1sd53gelyTTKV1qHdBqgHMPA>
    <xmx:_HyNaek5Unyaz0ya6yf_c_PSP70NOolnwzQ4U9umqZEAlCiUkgEi6A>
    <xmx:_HyNafewahvj5T-KmOBIuGbJddCJf1l_6Ttsa8ldIs8GrpxzTJrOEA>
    <xmx:_HyNaTU7zqLBYLybnlO0VhaphJ6nsvsNDontvei16wF15N9hz9Kdatp2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 02:10:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72bdff7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 07:10:50 +0000 (UTC)
Date: Thu, 12 Feb 2026 08:10:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: document NEEDSWORK comments
Message-ID: <aY1892Rzp1bQsLoW@pks.im>
References: <xmqqms1ft7il.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms1ft7il.fsf@gitster.g>

On Wed, Feb 11, 2026 at 11:17:06AM -0800, Junio C Hamano wrote:
> We often say things like /* NEEDSWORK: further _do_ _this_ */ in
> comments, but it is a short-hand to say "We might later want to do
> this.  We might not.  We do not have to decide it right now at this
> moment in the commit this comment was added.  If somebody is
> inclined to work in this area further, the first thing they need to
> do is to figure out if it truly makes sense to do so, before blindly
> doing it.
> 
> This seems to have never been documented.  Do so now.

I noticed recently that there have been multiple patch series that
blindly turn such NEEDSWORK comments into code. But I agree with you,
the first and most important thing that such an author would need to
worry about is whether the comment still applies, and what the
ramifications of it are.

I almost feel as if NEEDSWORK is a bit of a misnomer, and that something
like NEEDSTHOUGHTS would be a much better fit. But I don't have any
intent to change that throughout our code base right now.

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index df72fe0177..b358d6bfb8 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -33,6 +33,15 @@ Git in general, a few rough rules are:
>     achieve and why the changes were necessary (more on this in the
>     accompanying SubmittingPatches document).
>  
> + - A label "NEEDSWORK:" followed by description of the things to be
> +   done is a way to leave in-code comments to document design
> +   decisions yet to be made. 80% of the work to resolve a NEEDSWORK
> +   comment is to decide if it makes sense to do so.  It can be a very
> +   valid change to remove an existing NEEDSWORK comment without doing
> +   anything else, with the commit log message describing a good
> +   argument why it does not make sense to do the thing the NEEDSWORK
> +   comment mentioned.

Documenting is a good first step, but I have to wonder whether such
authors would even discover this. But even if not, it means that we have
an easy place to point to going forward.

Thanks!

Patrick
