Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335930E82B
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722246; cv=none; b=LDzfyuJZYcD5xIriZclvkbdzqpl2QEYl4saoSEhG0YUFS051mGMpPrXiH8Ho2FOIUZPgs40oBbAvAzH3+qlgGuJWB+knIoHZpuSvTdhVtA8+4QnbFlvVCLsdguS2rlqBzz1xfHfj6ssIUGJKGIILIoW7FugLcQUwV8LfXU16WIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722246; c=relaxed/simple;
	bh=8B5ZdXnvSrzbZKZYnjSXVoENYiN+Q3mDqrl3Xr3o+1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubx+66DEnlEh0eBBFxc5yFu8oNmSZ+ybkavM3st0lDuYhDddaMa0dtpfJ9/fbq8uEwaGJ85mwdKlcdJg8M1sotpIr1u75IoXVLjteccO4+sxGhzC2Q4KiBrUOtcVwRyE5ELU3Mu78Dve1Glqq9iJ5WUBZUp9GiH0glizfftQFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i+pnN6SF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YY++zOLe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i+pnN6SF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YY++zOLe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B46271400318;
	Wed, 29 Oct 2025 03:17:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 29 Oct 2025 03:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761722243; x=1761808643; bh=Ou5vMWnORd
	ZEvOxuEAxUffbgWjrrVtnJlRIwOsN7s2A=; b=i+pnN6SFYnke/eS9UsnQdCDRYH
	H/jQ1fOMQ9EiqmPPgu99RBr+sqzHICgb6CpoXdt72DZyA6QKMtzVPzYFZzMd5XcA
	6RcOdhgMTFabQcbhdK/CDVWuqqKuxV2sE4/B2SaOuUdow3yGaO5PFU8eLRLX1eg2
	K/v5/HeZtnxMoPfHC8MYm70bhxyJG8Ef/hG8kt/gSJGJ6L6kPliKwIiifvJBasIg
	AE+XrjCTrkfi99wyGY+PktIYNJ+jZE8Z+0KAk1DD+IhAS3XHo6+aOsa6yyUNyzEo
	wVfdoZzwkfBzaDV2IU5iho1rrBMp4zSqrGFCdP7ZDg0lDjyv8ke+WmIbLW3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761722243; x=1761808643; bh=Ou5vMWnORdZEvOxuEAxUffbgWjrrVtnJlRI
	wOsN7s2A=; b=YY++zOLeeANzjVGasoxGRQGhwlWxSQZ3HB0AmwkxsDJNUHwUhCd
	gEwWPuZJFpWG75m3wb1/cvqFg55Kovl6V5Jz1wptaU50YLB6KHx5TT737vKM4jFB
	UlKlIuG3i6eNdnjmsfJ7EkCCst03iEhIi+7x9g9Lzq2/JgIccjFLg+4z3Ezrfjpj
	4yiVvT8PLaYlMwND79mX3nCXFo0JV3UTt0pzMbfaivNRfQSv5x7RkHq/COpaj1q4
	ObtIhf7UjfWb57RNomagACiUcSxGwq+7vR1amm+VIqy/DYrAGpo7YkEZP4bkNhlx
	zjaNi7zwfMkKwvDe55NmpfhaPuw6IumPKQQ==
X-ME-Sender: <xms:g78Baen1IrjT1kMRByUCFvy2H9XV2Y5rO5K23NQyhNYfIONaX_iJKA>
    <xme:g78Bab2pMWkDzMkW45CoZ_h-spUH8Qrzo5fbWWK7xcBmCLPoru4-PQKgeM3aRWsF6
    KdPoEs-dwaOr6Pf0AJZx6xQGTmvLn1SNw4fFWV5fJxcg5gARVNl8Q>
X-ME-Received: <xmr:g78BaaQJKv2ONPcJmC-C6aljrQG4qcnlrwqEfnl5AqV1RVpCIay8vB9wT7q_BrFWJtUKbQSeIPGJpoTogR1XjR_YT0HyJQi75cJcvemM3sI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g78Badu7mdLRHkQcQdikPPprS1HWj855XPAdTbVFNm1WRgb385FMQA>
    <xmx:g78BafY75sskVud_O2i09wb83PxnBVUee-FrEd2uK5O7JOHvFBYmXQ>
    <xmx:g78BaSt3RuPXBcAHniJ4ESLy73ZDKuMdJR_qIX9w3hc_VAt3JjhaDw>
    <xmx:g78BaRESShVmSs2CJDUE9VXnJEWEqX3mYaGf7MiNdTEfGY96BGXgig>
    <xmx:g78BaZ8s3q1d4_cleaE8GvzFDVxy4c-X718jgHDX3EaflRKcW0CJkIVH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 03:17:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4eb56aee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 29 Oct 2025 07:17:21 +0000 (UTC)
Date: Wed, 29 Oct 2025 08:17:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] whitespace: correct bit assignment comments
Message-ID: <aQG_eRPmsxKqJ0H9@pks.im>
References: <xmqqfrb4hyjl.fsf@gitster.g>
 <aQBlCCDWMhLX_aBa@pks.im>
 <xmqq4irjf8mc.fsf@gitster.g>
 <xmqq8qgvdm0y.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qgvdm0y.fsf_-_@gitster.g>

On Tue, Oct 28, 2025 at 09:33:01AM -0700, Junio C Hamano wrote:
> A comment in diff.c claimed that bits up to 12th (counting from 0th)
> are whitespace rules, and 13th thru 15th are for new/old/context,
> but it turns out it was miscounting.  Correct them, and clarify
> where the whitespace rule bits come from in the comment.  Extend bit
> assignment comments to cover bits used for color-moved, which
> weren't described.
> 
> Also update the way these bit constants are defined to use (1 << N)
> notation, instead of octal constants, as it tends to make it easier
> to notice a breakage like this.
> 
> Sprinkle a few blank lines between logically distinct groups of CPP
> macro definitions to make them easier to read.

Thanks, this version looks good to me!

Patrick
