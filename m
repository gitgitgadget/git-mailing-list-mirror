Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D91CD15
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734607027; cv=none; b=EIpZlE2scCN+Kks7rHicwdUIbbJxu8ZcR+qODfDh45nr/DnomfPaXqRl2FE55E/Z4928gCq9eAWbdb5Cb3E9mr6JqFHE3pXkW1PgxrXNs0m2xPbsE1FSmFt9toeLgJlXNZsEyXRao3sL2YiZSnSeBcCRyjPgc0rQgZuf8Hf+9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734607027; c=relaxed/simple;
	bh=Bv6FWf/BOz79quhETW98vvcvP/nIw8WPHQImOZYn3Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t57WVkC0dUVBpvvuerAqWC05D+6s0RMifpBab7Scz8rLjJ+mV9kJH2YPb9t3xJUYxVR0GJtHiR0TOV05XEgqBqXYFSdg9anmwLwCj8sV1UIlydTFqBp6ptGS13cIziLR0CZZCMHTfa6G6iK6/Pm9DI1mr9EEDoYm4ulFgl8wQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5V1shqg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iSqKi8lF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5V1shqg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSqKi8lF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF3FE1140146;
	Thu, 19 Dec 2024 06:17:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 19 Dec 2024 06:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734607023; x=1734693423; bh=VPR2+Std7B
	Xdym8clB25C0zbL2RehVerKERuj6L4YtU=; b=L5V1shqgHCCpfeR4Q9/ETOPExR
	E92dOBaSakRYJQs4ZgiJJnm/AhA5QY1hZcn70ZZ+q9+v44TP5HMvMc8O2nUbs3GM
	eHKsFY1ZCoyk+DYSaBDjlGlF41zzcij0aq+hlm/1j6qRn0N4jfby4ipDrup/+p51
	g1XNRvtMcEULT5XYOimSxJ4wv+AxLbwKcwPecjb+LBfqYhFYeeftbYAx4cYQQ6wU
	YB9K7WJ03rnqElnPR9GsmWcQzv9BsmzER3L/1FclD1FFzSV/EaQq8TeKevnz2HGl
	w6+pELjy3JBwjQNto0vqxMl6tjjFsVV6cAWyJS8retGpnRosLbDRnvfNjbBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734607023; x=1734693423; bh=VPR2+Std7BXdym8clB25C0zbL2RehVerKER
	uj6L4YtU=; b=iSqKi8lFlDwDIScZ3N3ODavUk3DA4nTHwjaVUJBRgMaNH3NzWja
	2ZFBPSPVwUPfrxC7+0oC6YH4UkT1+mAlo5CBEfpdRzdOiX73T8bS1h0z3BWUygTL
	QWQ43YNyzvbAw/RaxmVIZyP3RpuF9aXPndXkN0Apax2Y8JlcXjLsFQC5PMQVngd8
	rX4GuwZ6woiYZ+2Jia8iJ4ty4qK7mCFJiA8FIcggR7FTYysFx1znTVCyWWtGzDKs
	EHxn+Okh8/3Hs2eJe1ML1ghiGnbY7WELv9QoPBRcGxXV9veDQ1XNz83xlzKeqmXg
	d8KzetJzOAVNeUjp7pyMJLKP7lKTARuoE+g==
X-ME-Sender: <xms:rwBkZ0ROQ6ykObAFzMvRAk4-jCLTBAEDoaJSBB5tMeM1V4_ftqgeyw>
    <xme:rwBkZxyHnzdGzzBzBho8RQtW0RrvCQfqANsbMGTgbgxEcv_fttS5dT7KXcLxOkSa0
    kj5vPCrL1B6k2a0iQ>
X-ME-Received: <xmr:rwBkZx0HgM9dVDMxxoZx2dz73uS3sWzh1SQ0he9x5uqglHXP2FKusPgaK-R8YYwSKy8X1AbgIOZ3AOhMehpfUdsDwLbcsKcnGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsohhomhhmrghnfeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rwBkZ4CBhllYnW0tc9fw5u6CkTx-UF2ZH9BxLGDGj9BFCYEWjPSqpg>
    <xmx:rwBkZ9jn4ZSDa20YRnfW-RIxtwOxfsgY_RtTO3V7Dq9KzLT5dVdi2w>
    <xmx:rwBkZ0pjguZogRIdEyxtspaVFayzStIrcrj6s4tpLckpxi8ImC1BGw>
    <xmx:rwBkZwhUjnFvo2M290q08_m9tfvdoZaShDMJOIpSuDWEMGaCwqzEvw>
    <xmx:rwBkZ9dbo3tv01drw_oOGkZ3IEWK-iuHKf2TFGEB1tcguMn-kULzddwi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 06:17:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Boomman <boomman37@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: git gc does not clean tmp_pack* files
In-Reply-To: <CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
	(Boomman's message of "Thu, 19 Dec 2024 00:26:15 -0800")
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
	<20241219054222.GA2310556@coredump.intra.peff.net>
	<CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
Date: Thu, 19 Dec 2024 03:17:01 -0800
Message-ID: <xmqqmsgrncr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boomman <boomman37@gmail.com> writes:

> Yes, if the behavior in case of running out of disk space is to just
> leave the malformed file there, it stands to reason that cleaning up
> those malformed files should be the first operation to do for gc.

It is misleading to call them malformed, isn't it?  When a Git
process creates a packfile (or loose object file for that matter),
they are written under these tmp_* names.  When the processes die
without finalizing these (either removing or renaming into their
final names), they are left behind, and it would be better if we can
remove it _before_ another process wants to consume more disk space.

But the issue is how you tell which one of these "malformed" files
are still being written and will be finalized, and which ones are
leftover ones.  You want to remove the latter without molesting the
former.  And you want to do so in a portable way, possibly even
across the network file systems.

I guess, as Peff alluded to, we could do at the beginning of "gc" to
prune only these "possibly in progress, possibly leftover" files
that are too old, repack the clearly "finalized" ones, and then
prune again, this time including the "finalized" ones that are no
longer in use, which would help the creation of new packfiles from
being blocked by these leftover files that are hoarding disk quota.
