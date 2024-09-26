Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15256136349
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358640; cv=none; b=qwW81FLwLiExFKf86GN98rddzFsFj2m/ZeE0sx2I9Z1Fj3h0a+g9PrgYsE5BQ8MNzXUidQyP5blfARrqO4KG8y86Rt9TGcLjxPHq2GxB86froHJROl2UVcYUzj2HHzcQHpGhhal+2WTGBi+p0BekQQyLFxsTJ4xYObrtMyqjPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358640; c=relaxed/simple;
	bh=reQE2TB2L7AgpOZpAmTUO8nKfSKAPN0B2Mir47TwYCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgbB4EGeeWMZAAKSez/Z8j5/Zi7ZmWDxvR8U7/2YTrOLBHXFeb4ARZgX9zKFbrcHUsnsjsRcIwRZp740Eklw7EWYpdVskZF23EHY6ofmg7vxJmJtSTJYhpY18A3DZnL1dLi31vU5a4oh2S77re0EwsGbhA7Y+REoyIz0zA19KwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TeExRhNf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gqct5IsN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TeExRhNf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gqct5IsN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D1F51140203;
	Thu, 26 Sep 2024 09:50:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 09:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358638; x=1727445038; bh=reQE2TB2L7
	AgpOZpAmTUO8nKfSKAPN0B2Mir47TwYCo=; b=TeExRhNfaRAYqn6l0p4jOCQy+7
	PWEXS22jRpBaNHw+0A/MU+5Y2YPTorqSPV0IzIx4BJTHpgHe9u2pX1dXRYtrYw8j
	yPFnQ9sYzCDYavikqrNHfN8hbo2GKl5F+iRiY2MItdwjBU1HrSqVeE6f7o2EjaZa
	YNHbiq2Sm3uVgGKub2mAwzed08megHjBSsdgPsbvtpj3HUOBzaaD1OmlpahWwbE2
	63BnqceMg2ZRZMpwQ2O4CADc8FFQXr6Cspwzp7X0lOBfZCjYj3hnb3fdSArdiV+r
	07PX4KUw9oDoMM+i5PDlJpYYzcBCqrETRxxJ/t+8Ip/nUEL8qjRzLq10Av+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358638; x=1727445038; bh=reQE2TB2L7AgpOZpAmTUO8nKfSKA
	PN0B2Mir47TwYCo=; b=Gqct5IsNgpOnnN5TgFHlbUPqFWQvPKvgwKCIT28DZbVP
	nAHRqd4pjSs+HtOQt2vz/B70C6Y12aviL2PdlQl3dyuxU/XgCukB10TPbcbOVK5P
	UwNKBe0wrPaZQM3OnxGf9fnnz9DYrwYs/VESli6hdwzT1R2CjXy6bCCfkVQq27CV
	XY1GXcuv72wka4UwWVrrX2NTTxKag+U3qJgTH5H8TSrgK9v3NlsLifT0Fy6r9aSc
	v5KwhpDCZNiJi3ScmIgRXk7epTe6sLnT0oQc8c8tpbfRw2GRGDHqhlZ2zU4ON53n
	tH+5S139Z0bdmA+u2P86cGcg5Pw0PbgDKnAjKHGA0w==
X-ME-Sender: <xms:rWb1ZjoIsaI8mQegP7e8fMpWwy_8rXpqbw7IscxtncG4k00pbw7fMg>
    <xme:rWb1Ztq4Mnwu9EfwDpK_pA10smfUiLlRLgfhNsyhwCcXvs42Mb_3_lCzN6mUCggcj
    s-3M--DIyFdSsgLRA>
X-ME-Received: <xmr:rWb1ZgPpBOAe50jAZK2IUdGdul35p4HiyGJb7NHd1DsNOpinkT_kXKciB0y9_wAFZrpRbYes0CwaTWGv01cgLBv46o4rq0_IbIIuoTZeV8uTNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffffdufffghe
    eugedvveduhfehfeelhfefueevteejvdegteelvdefgeegvddvtdenucffohhmrghinhep
    hhhtthhpphhushhhfhgvthgthhgtohguvggvshhpvggtihgrlhhlhihthhgvughumhgsvh
    grrhhirghnthhsrdhsohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rmb1Zm5UF3kogtXOGkxiueHZz3CcVaMN7kxRDRUPwqi514IgKqgOoQ>
    <xmx:rmb1Zi6LdfqN4GWEfT4JyCW7wuRl9AwyKDv__RhCmBfxWpYgGx7fDg>
    <xmx:rmb1ZugyZvKaHk7poIIlCoi3obusN-8lS7undJyY_ZInCBZPXov6og>
    <xmx:rmb1Zk6uvZetDWy4QqsD-fDYxgXIlZqa2G0Xjh_bKBmU7dQLFGXJCg>
    <xmx:rmb1ZiGQCbeRzVem2YWbeJMsgklmg1kdrgQQgDrucZ_Uwo_fSdYLkixZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bbe3895 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:59 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/28] leak fixes for http fetch/push
Message-ID: <ZvVmqpGZkM_m7nXl@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:49:30PM -0400, Jeff King wrote:
> Patrick asked me to take a look at the remaining leaks in the http
> push/fetch code, especially the dumb variants. So here are enough
> patches to all of these scripts running leak-free:

Thank you for taking a look at this, highly appreciated! The series
looks good to me, I've only got a couple of nits regarding typos that
you may or may not want to address. Either way is fine with me.

Patrick
