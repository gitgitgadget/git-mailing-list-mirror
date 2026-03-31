Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D823321AA
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997445; cv=none; b=uNUg6T8GjpVy5oKPiDFiGCn6YmccF7PN+rsV+T7oATQggS0xAL145TbMWOPFBcqb5Y/JYmriMTLxsklzHMnbdNuCsJt4yuMWfe4vmX7EO8FQl6MjrVwBKYKtlDacqEouPSQXTt+fTQVIpWBW1s7gMaOcfn5jWa8VflRFKXG4Azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997445; c=relaxed/simple;
	bh=94HoNPKp2YZW1BW1axnVz2h6ErEblTZ089g7OyM9M3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh5cLCBYpeKAUWMBeLPudLF4d7lSqbG312392iS0b47A0DnT+I91Fb+29nwdg8N5zOHNvELoqmLQ790QcrNZKKyO+cAP06vz8A+tfXWFN/7+x1+dNamg69iIl0ZilQ0kFTJymaD1G5QfZNGNqSpdw5+2JTxIYhD/KHg0Sy1r0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zU511OEA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXQbYcZz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zU511OEA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXQbYcZz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 10EF2EC021A;
	Tue, 31 Mar 2026 18:50:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 18:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774997443; x=1775083843; bh=xx8SwDf6Hh
	TJ7gvApFluaj65ZeDfB316OAn+IKDQvzU=; b=zU511OEA8VLj1dVjHc6YHKvs79
	+UYTpl1L5maCzkrX/4E/AdDE7IfbitWKYCdmyDPO//eYwk5qkTwHKS3PjNBMgxtQ
	F1bU7w1dq6CQQoVorJmk60Gi5Vc7mK0/GGT8dgP+SktI685nhTHVt9SmmAgxdxFk
	Dy2WAjloCiZ3o+jfbtnIKYPxIn8m8HOhjGXaHwds7Trr9fkSfQlndyUXtrqzrmE3
	Uxy34jnNwD82F/HlpIX9csivJhjDwMXaWbq//mjamG3AOhNeFYbkezZHw7tYYozY
	rN6hgbEFzVsrjTcURQWyun54SsPLXnq2TYmrhhZDj2IfZQpdp4gM+/pFuJIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774997443; x=1775083843; bh=xx8SwDf6HhTJ7gvApFluaj65ZeDfB316OAn
	+IKDQvzU=; b=mXQbYcZzM4Sb2PLqZVicj9w6geyEIWHOx0yXe53sjuc0BSsxN8+
	Vncci1YGczNfNCkfvw2FyQkPneJOFZwDpyDU3iGvMlMw79rIvg6VQhxtgk0Y5h7/
	Mzq8seRC6W/BCqSoX0UZ5Pq4ZY+ZAmD4F5dVivbawjHcAn5IceWlUVeiCpgyPuwX
	ieLBXdxso7VQXFHIm1p5cOtC08+W7aiMDz/7IxpqRvEzSUfkYLunKeWTteR+bhsV
	BoH1d+GWLykjchFUSX0pKxHK+hB1zbCAZjr/UYiEkbiE9EZEIw5o17cc+v7apa9e
	qrKrN0vvAce7wfATio1PXffTDbNRavCPrMg==
X-ME-Sender: <xms:wk_MabSK0z5LcCH8QFeXlhuBWOYkQGD7lLWXuD-dp6nWIR6gI2ySCw>
    <xme:wk_MaSxmM503b_WI5diaZU-WgTS_n_lldE9Dg2Qb2cbHisaKlARqFlovT0OdEwEeH
    FOC1mb0IRcueZUK1BWMobStroWLhOxO_ULFwDcKv_USQyu8O0plKw>
X-ME-Received: <xmr:wk_Maef-hqm4VjaEP59yDBTF5f6hgPSEnkoLiIH0KDjexnL5oA3fjbntGP0zTPjlZbAQ-8kE9L6BdTVKzbV9JByoaAuTQCHfYOppoGo4k0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvd
    egieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wk_MaWJbTO4O-QggZnR6l6jKbqqc8wOlnmafXToUquGEDuVMgu4Kew>
    <xmx:wk_MaXFyuzQI-sP32B5MM8EojF-vu97lONrwmnZxRhGnqexpurBCtw>
    <xmx:wk_MaYorZfigWa91rqgtC-XI8ybGBST6Yyl1DWZbs6CHpoLJiiu09A>
    <xmx:wk_MaYQ4_lIcUvgt97xAxlWCEIJdrSLVfzEw3ErC5JHpmjRmOzrRWg>
    <xmx:w0_MaeoCaEZa8zfu2WOhv3wL16urWSBuzJ37jjX-KT-S7sUGV1Zwwb1r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:50:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f2e9337 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 22:50:40 +0000 (UTC)
Date: Wed, 1 Apr 2026 00:50:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 00/12] fsck: drop use of `the_repository`
Message-ID: <acxPvS984rAPJxdl@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
 <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
 <xmqqy0j7wt7z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0j7wt7z.fsf@gitster.g>

On Tue, Mar 31, 2026 at 03:05:04PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this patch series refactors "{builtin/,}fsck.c" to not depend on
> > `the_repository` anymore. These refactorings are mostly done to prepare
> > for upcoming changes where we'll make backend-specific fsck checks
> > pluggable.
> >
> > Changes in v2:
> >   - Propagate the repository via `struct fsck_options`.
> >   - Link to v1: https://lore.kernel.org/r/20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im
> 
> Looking good.  Shall we mark the topic for 'next' now?

No more changes are planned on my side, so I'm fine with that. Thanks!

Patrick
