Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818E12CD96
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304272; cv=none; b=COarkPTpaauUCZOFwZj+ztIHiPemq6dMd5Bdjv26A8xX9DAQ9NrdNzZbI2JvOdpH783YeU+2VF+5ex/mei+A27L286zJhKGeaT7O366axXMPWN7kkZkiiAjVKw5hxkO5QDY/fuEBpWppeDpQf7XslDPAoIgGsWGhvQ7C700lGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304272; c=relaxed/simple;
	bh=Rn6rERr3fFj4351hTEeCjzGjawhj/r6tjVvNBiEwAPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWKzJ++9yTP1qhCRwTTf50/9xztGD7OvgXdNKJFRUPbPz1qN2OgUVb1OQnSI6OU+kghW2AFH2ho1OJpyljNTP3LQNwGgNIwCLrp9MP/Z2HbP8f6dZlxxqSOKo9nkRSOKHZGyZN0Cy4VUgg88y0Cv7s4IAeQS8A4En2n+tnriFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oC1JZhSF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMzyUa/n; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oC1JZhSF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMzyUa/n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13FCB7A0110;
	Mon,  8 Sep 2025 00:04:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 00:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757304268; x=1757390668; bh=3CgcRvUWpp
	GE2EZP6a+f/nTCMPmfgqOnBCfBGe4VgLk=; b=oC1JZhSFSrDXarDjh67GG11QyA
	SBIE60CSj7KRuaBHr9KDsdUR6UwQpGFgVy0AtUJHNJblme0UTP7lMje62+/OHn1E
	pYP1VUkWxIyreWb6qaS9SyWzvtznFhXO0e+0a79HhwHEhWi0j7CAafzW/wLuucFT
	X+KG0ouudZvBW6M9g1bry4jWFi7DOTABIx8ELqrJWNhc2CKcejyzyV1TrLYFSL1k
	q5gGdcrYhXQMynTpLdDSvENNBS9hM/zcSo8WWUpIwm9DNjsNFIzQu3/BBMDM718W
	Pb+nOWjH4ONPATISJEFqsaGa5pMqsRZdZmHOa6shirUNrLThY4uzZzho2hUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757304268; x=1757390668; bh=3CgcRvUWppGE2EZP6a+f/nTCMPmfgqOnBCf
	BGe4VgLk=; b=RMzyUa/n+0wS/BSxqtm8+TmTzHrvQnSmmNS9bsm0Og/WnlJptVu
	3Mg2HGCvMjNj/N7lo7HOxf70RBEUTjVGD6WCTMd+u6C/8DNE5FUOrodjI7FWrABj
	pT8HChp7wBrfjnmarCJeZV0nXVMTXRb5KemdPx0o0GMDYwZhXXZ7qZRkAGTL2yHJ
	T4ZROeLhDokduoLO37VftizKLtsJ2XpKTBvgx844bh+6QUMYwjySUs/mghWJ3Z84
	EwDpdu21VkVGxUIdqyE0VJWehAIolk5xwSqitsJpTo9ZdCCfBLW6YXC4Zz0F3ZiG
	BlNp6PGgUVJ5TxxpajDSfFPET2tqdKyGXJg==
X-ME-Sender: <xms:zFW-aKnH6IycsRRXaccTp2Jp7c2TovaSVBhL3er2HsiuT2gTaNlAgg>
    <xme:zFW-aCDPk_TJjLJgYWsUQvtS-hVuFvDRwz7lzaubDaAJ4YL0hzbHajkchfrdhd6OG
    HOnhHtTBZ5vfe468w>
X-ME-Received: <xmr:zFW-aKc5YMhI6SZQ8GlVurePkO5U56JL1cGnzbqSwu5w3QxEndRZklULEIt1B6U0O4j7w7CHT0HWds9V6UwvVKWAJb9fWadVdip1TbjhNuFh0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zFW-aNITf6ZNyMGP6wmmst7-032vsyjowlowVRGhItYYU6N9o7TobA>
    <xmx:zFW-aNcHGg8pcC74PF2fqsdsbg-GuVJ6lg1qsN6HKmeh7xvmuMsuMg>
    <xmx:zFW-aE0z6VhFXqYuNN6fucXA1NJTdy8wDPCso9fBE42bQReNRcH7xw>
    <xmx:zFW-aGj9LyJBR8BJOXNaNN2vDo0uBGth-WbXDotZ_hVEL0eWZzpTbA>
    <xmx:zFW-aA3n__zP5sGeVsDwJp_nbBqQLx7n1MxLMNC2HMFguDfQARI5uCNH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 00:04:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58ea83a5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 04:04:26 +0000 (UTC)
Date: Mon, 8 Sep 2025 06:04:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: aLaz7yCXWGG2_oP_@pks.im
Cc: Seonghyeon Cho =?utf-8?B?KOyhsOyEse2YhCk=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] add-interactive: reject malformed numerical input
Message-ID: <aL5VxjPSqfXbnY7W@pks.im>
References: <pull.2044.git.git.1756553495661.gitgitgadget@gmail.com>
 <aLaz7yCXWGG2_oP_@pks.im>
 <aL15aTmKQOsNrF0D@Seonghyeons-Mac-Studio.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL15aTmKQOsNrF0D@Seonghyeons-Mac-Studio.local>

On Sun, Sep 07, 2025 at 09:24:09PM +0900, Seonghyeon Cho wrote:
> On Tue, Sep 02, 2025 at 11:07:59AM +0200, Patrick Steinhardt wrote:
> > In general though we're not doing a good job here of error checking. We
> > don't at all verify whether `strtoul()` returned an error, for example
> > ERANGE. So if a user passes an integer that exceeds whatever we can
> > store in an `unsigned long` we'll silently proceed with a bogus result,
> > won't we?
> > 
> > Ideally, we'd use a saner interface to parse these integers, like for
> > example our own `git_parse_ulong()`. But unfortunately, that interface
> > does not handle the case where we only want to parse a substring in a
> > longer string. Too bad.
> 
> Good point. Would you prefer I introduce new parse method here, or
> should this be handled in separate patch?

I don't think that would need to be part of your patch series. But we
should have proper error checking for `strtoul()` if we're already
improving this code.

Patrick
