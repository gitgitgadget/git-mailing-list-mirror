Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161C3112C4
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995993; cv=none; b=soR6xoPPZcoKtzTe9/UPZB/1+R51up24He+iJwbXRhx4i3e7P9TrALWczyHSKR75qJMORzqaukel1cSm45d1zRGsItGhD2KrM6wCtBHoxrfCtXHKOAG6VO62n6tAxjwTR/mfu0+klohdzKNgCNSarX661boOD7w35lzKPheL3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995993; c=relaxed/simple;
	bh=S9rtqT24oBxaQIrXw2N1vYrz+hSnaWzCknUYWjWjeJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4+lndgZKfW7VjicqQFvoG7i2AaXXnMZPcNfbabpQgyIX7J8FMZNuohRuIEF75AOThn+q5J1P0+P4IELa3GtaI/VCDYWw5i7tTuIUj7+0kHAXZM5elcIVIXJX6cfWjxrcHF18dIPXDAOk7K6aN6ERGJcAK1pQbQj5dyo9ClF1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SYlMMAhr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/J+14Nj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SYlMMAhr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/J+14Nj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CBA57A0365;
	Thu,  4 Sep 2025 10:26:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 10:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756995989; x=1757082389; bh=/RJCvtfvk0
	Ro2f9ialNhxIOZLheszSswMpQ+E0tIXsY=; b=SYlMMAhreZC8p+1SKjAQ5R/pRC
	wNBpyOAZFRa26GSrpkt5Em0UUkPb18jY9/NJhPjVfiTU6+wxGbL97VW9igmgqud6
	TZ4fXYNqXlfwFDjuKCDAtOu99bPKM+09+2x3wEMEMJz2XABZsO4yBmvU9K7jMQAv
	BkaPe9EfJjpIzj7ZDnlhJbZWCBAaD1r6FcJFdw0FhdbhdaUiFRn7El3lTg0S+BCS
	wOjM5TTsKuHzoPsNkN+dfOQ2+6xKrZfM4zhntvR2PZ++uhGPf/ERBmCwShf43AB+
	Bk17CmTiSsKTUDa59wEptOQY4UEO8yNkz1MlXHfvsv/21GDn7rynO859Shqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756995989; x=1757082389; bh=/RJCvtfvk0Ro2f9ialNhxIOZLheszSswMpQ
	+E0tIXsY=; b=H/J+14NjbtPm+DxNQ0DbRhOT82m4CX7AIeiLszLYrGolqofWZnx
	7tQDBR3W1A5wXsm+WSc8TletV0W+knXIlsq2IC8UmyBQn2fWCucp9zv6LpRy5Dkm
	IiI5kh6o5VCWI5pP7A10AWVQUIwqHoXn6Lw1LytAIKK2lRypLwtfWqPTFe5iTye6
	ApEYf4ezGS37k63LUcfGsv2rR6F6zE5LhS+i8LO4m4TO7oy5i/tb7KnFgAO1G0EZ
	SrS5wvMfLW55PZrnO7XxUvbgbXOIY9RLZr0anVZXKIj6csyXtqWyOlzQIYhb5Cbp
	y4wU1wE7A8h1B4JJ/YtvQFIb/xS+8xck+6Q==
X-ME-Sender: <xms:laG5aNp28_5KHEwh-NXjy9AnL1UE1FZfS2HNBzGovu8DigTL4kRIQQ>
    <xme:laG5aP1ssht12wibn82fIHV5jCdJf6C53ykg_Tcn6dgSobxwQ7Orr42cH2B-ECkoI
    _y7NO1RLiHKrGaluQ>
X-ME-Received: <xmr:laG5aMD--R9gL2UVGtHhEGzu0WBqGQw7YT0uOw8BzwKgKTkNmHtzkpzZwwuu_iXKpjPWsJKguQhxSEMrQ72iHdgMQy3Urs680YN20Pne2h6kBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:laG5aHd1GHtVhVQD6frdpqP-FNMh-QXfuuJjuQP4nv7EBJjqGcI4yA>
    <xmx:laG5aBjZPnxAmye4S-wmYVddBCL3FtL1YLnck0N6ya8L2v_6bKAg5g>
    <xmx:laG5aPqxgivv9dgeQ5WNNSA8DOLM7v3-hqlmIg3PctxorRERO2lyYA>
    <xmx:laG5aBFb1oKgxqQlTNTUU9hD29WyMQER2zk2BN4NYJKO0pw1iI0ttg>
    <xmx:laG5aIPnepfQ-XeL_iKmWPvl2SQfB7iu-Xu7aLwtEiPfjCDOgSCq49WP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:26:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a35b3b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:26:27 +0000 (UTC)
Date: Thu, 4 Sep 2025 16:26:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #02; Wed, 3)
Message-ID: <aLmhjw2xAbUogL1L@pks.im>
References: <xmqqplc6byai.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplc6byai.fsf@gitster.g>

On Wed, Sep 03, 2025 at 10:07:49PM -0700, Junio C Hamano wrote:
> * jt/de-global-bulk-checkin (2025-08-22) 4 commits
>  - bulk-checkin: use repository variable from transaction
>  - bulk-checkin: require transaction for index_blob_bulk_checkin()
>  - bulk-checkin: remove global transaction state
>  - bulk-checkin: introduce object database transaction structure
> 
>  The bulk-checkin code used to depend on a file-scope static
>  singleton variable, which has been updated to pass an instance
>  throughout the callchain.
> 
>  Will merge to 'next'?
>  source: <20250822213500.1488064-1-jltobler@gmail.com>

The series looks good to me, so I think it should be ready for prime
time.

Patrick
