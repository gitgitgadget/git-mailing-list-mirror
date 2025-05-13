Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447A8BE8
	for <git@vger.kernel.org>; Tue, 13 May 2025 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112891; cv=none; b=WkWzqD9j88wMchtAkeCg2wyjJhwSXjamR7QU/rNg93Bdo9fkAiNak3vClTBVTsgdY+sAG2dQJIwxtz7ciNKwnWMyFWGkwCKKLi7RaN/v8pyTaOG607VWQWCCKdWIiLw7Fc4D9nvo+Z4y+QdLe8gj5TKddACLdfHXfTlLpvZfpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112891; c=relaxed/simple;
	bh=zI2uNmurVbSTerCA+ybWtArHpbTLVwiKznK0qeOM7HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixF3MzqsBMidVkYHM276x7NHnMgYo5JPyieLcGKXC1jkCd9MTWHIzFnDN427CRzlRAeWTEuDwFXVWSGpeOvfB9EWaSUttohe94ImC8tGliogzoou79vUILirc1w+qGYKvPGrCLcKVpZYzutSmmrihVc0V3o6znWgd5NdnbNN5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ATNBmbOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a83fuZE/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ATNBmbOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a83fuZE/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C26013801BB;
	Tue, 13 May 2025 01:08:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 13 May 2025 01:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747112886; x=1747199286; bh=Q4TPw6HCLO
	9+Xo6b/YN8zvNGYm+GPGmcndROt8VMciI=; b=ATNBmbOVR8mV9ADrgsGkrb4uJG
	qasSiEP4Cj8Vomf1++gJEr+6Q4eRGQozinfDJZgqKmWaBq/bN7QKjWhSzMSUw99m
	UULYbMCC7lenbEhRnJ9DOBl524VmD1SLWwKcRx3cIrN7e6pllBDGu8hDS1wOH+DU
	DeasSbKHM+QxpJcbQiFYfKvEWHhfl/o32PyGzOBlBUnzl4/D9ODiSV/7jv55GbEk
	8kWkBrhdqhMtDzryPCC7RzektSN9zy3YCUyY9Fl4wuCcF6H0wVCWkBx9q8vdzRj3
	K4kmvT/LSK2UdgmlMif2JZ2XGzthyxl1PGERnUSYzSIsA5vWJVy+vP4xEjIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747112886; x=1747199286; bh=Q4TPw6HCLO9+Xo6b/YN8zvNGYm+GPGmcndR
	Ot8VMciI=; b=a83fuZE/8E79CRvgpUdHipJe2Nyl20/FG3zR86mmtAb7oqKhiS2
	pXFfuWDQd/YFYpxHkLUD3aqrMJLpRsyp/3wZXhHy/qcb+iAMwYIb+h5/SS3M3cqg
	zIQ3ZJy7JEVPxu+BnkZzvmqOqSvUHdLLRf6s2QzSCH7GgmLiKZwW+SZ93Rx9owcy
	e3CMe5e3B5WN6we2Crg4IOyHzx3fEksl54wpYcD+sam7Tj2HkISG88rHGtlgxkxu
	Nw/I7GZWy9mLjvIdNVkoOr2h4eNuBKkg3GxAz6x5PJwlpoKBdkYGBSsVmCLWEQwT
	9J/MUPx8cS7mxyghg09HghIs2LeQ8WmsrlA==
X-ME-Sender: <xms:ttMiaEheYQP9KgscdOXER66gEBZ-J1Zvnz8_6s9rr7fKfaI7yR29cA>
    <xme:ttMiaNDwf422CzP29wkEIr7i2rNsvq2AWx3OlOVpbVGWzXHdTKvubV1LkrXO7xJ5n
    HZ_R9HupLfg30PwaA>
X-ME-Received: <xmr:ttMiaMHA9IjiEq1xIXMMGPFqR-krnDkvCf7lEj7tP6v7CV9LdLM3Pm6EgV3DP8p833azJHGDenG7AWQVwFNbwDFl0cm77HUJBHL22E3HsoERdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ttMiaFTkMoo7E57nPfHsBJG1F4frz8gxpT7z1ORZFMZeeenxllGVBg>
    <xmx:ttMiaBx0giIVkzp9hC244OLjumuPattoOVt0c5Z1M7jjsPKu_NWIUA>
    <xmx:ttMiaD40k7goE1HFNSLcAJCZsAeIB0FNxAU_fRoy9jX_JmV60PkG2Q>
    <xmx:ttMiaOyDYjdT4moiMrQgWcU_UYQc-_OQSflZbqS0TuwK5iyfNEwvxg>
    <xmx:ttMiaCpdjwqAZ5P7fp6a13gAn0SpOhFbeWV1K1cET0e-_w_Rnmpb8rbS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 01:08:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac364a79 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 13 May 2025 05:08:03 +0000 (UTC)
Date: Tue, 13 May 2025 07:08:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aCLTsqZSWklaEOq6@pks.im>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtx2mqihlc0M7H@ArchLinux>
 <aCGzIlLH_ESNg6-v@pks.im>
 <aCHoovrKiSUemBCL@ArchLinux>
 <aCIIL6IWiiWiGbFd@pks.im>
 <20250512155654.GA1219668@coredump.intra.peff.net>
 <xmqqh61pu4r9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh61pu4r9.fsf@gitster.g>

On Mon, May 12, 2025 at 10:18:34AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > It may be useful for fsck to detect this, though, even if the default
> > message severity is set to "info" or even "ignore. That would allow
> > people who know they are using modern Git to increase it themselves (I
> > don't expect normal users to do this, but it would probably be useful
> > for forges which run automated "fsck" across a lot of repos).
> >
> > And then the backwards-incompatible Git 3.0 thing would just be tweaking
> > the severity of the config (and in the meantime, it would help flush out
> > any unexpected instances people run into).
> 
> I came to make a same comment but the above has everything I wanted
> to say (and more).

Yup, agreed, that sounds like a reasonable approach indeed.

Patrick
