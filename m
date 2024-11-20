Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6718A6A7
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089030; cv=none; b=RnqBBggmI+aRSJnVXp2bRFwhkpcToHmMOZCGSpkc9yoFoCsLWlvsFH143bBfJYJQ1vXKpEZiO3L4MJMavyEUeaShfOVFV8dp3Ucdj3fbRIcBeRIwTZHVN9kqZCO2HnHV93+vskDdeD0cno5rTyNpq84kubsY4GM1HXVABEfCS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089030; c=relaxed/simple;
	bh=+JkTJohxGHlUBR/QbV+YHOWoTvfQCJbpH/nYD3O3u7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NY2krNTnLMLw4QzHBXUWnAOZ2g1K/8kdbJ/OGEHZrc4nEJqMbuKdGzU6ztfWNBZM35xaPaqh/YhI2JAisJnYcVxg8aDQ7uiPgP/0QNc6wMQgpEZnhQPRa9iPtR0NjVshxfsNJZ+UdAcJErSBiyFwqaFrQb/5+z9QwLJ5ad97G+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n7znE49y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DYx51RKJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n7znE49y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DYx51RKJ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A26B11401EA;
	Wed, 20 Nov 2024 02:50:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 02:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732089026; x=1732175426; bh=AJLOJcAmrX
	x2n5vroyuEDsUMifZuPZdLo/nfzpDp1XY=; b=n7znE49yRBEjXoT2JbICby8AeH
	tmkBLJkToSq/7O5xD6ekrKpajnw2Qnyj9FDvZgFZBLCVn+Zycm9xDtvybFLDFDdK
	s/3NorZXBsZbqmtlTr9vFcWgjuNHQ2XSbuGeQvNI+Ybyo3Q9bnnqNlFV4xxNcLtm
	HTJcnqrMLrxgsTINSC3tsEvc3I8npO4cER9YZ8YHhe5czNfYgPw8shYv8CW265HK
	6xlHar2C4SPDPJWe7/1ruho/i1pR4h/QHTaw6tPhpCupLQxkQ70LXY5dV2skvUGa
	VDIMR0xYIldq06uwTx9SyhTNZLOmDJGI2won4awkAXAEnQsGJdg4tHaP26mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732089026; x=1732175426; bh=AJLOJcAmrXx2n5vroyuEDsUMifZuPZdLo/n
	fzpDp1XY=; b=DYx51RKJ5uzRT9BERppPX7fv7tuXpqQDip9lqsHzSYonLUx/JUj
	HrABhBJ0eTo65FDrDbCdavADR7/tzYEQJIIZ5s+k/kvCtLuCuRTdoqVXpetARw9q
	8mkXaafrgofMCOIXyKU5+nOFZVylhfPwjKKuwamOinp0ERmS1Npcrlu+Gmn84kA4
	jEy8pZbGPUSopmzA+d3IsYRURkehbd1MjpAdbZD0UCw3lAKgakwyXnpqH/mQoJJO
	qowHOqTULS9rEclgr/y1cXZ0zmohsQdkK/Za/e+LN/JNmTGOtSfTGUhZc6GQouMc
	MCSbV9D206tjSC8a2OKguyZQPYB+bYox6+g==
X-ME-Sender: <xms:wZQ9Z6hV3ztaJ7cw5OiL_ncUh3YNzuuVcF5wIZtSJInKXV0LZHNfYg>
    <xme:wZQ9Z7CE4hMQPSRH5qE1wriOPrZKVaW7KUN_e74kaOzfY6VU5Cz5kWUklpfvuNYfe
    h7o12fYBRL_MAT3Uw>
X-ME-Received: <xmr:wZQ9ZyH3SOQIO_jOFSUtlypC5ALfTtVoUrxtJK-ukT10YnoaMzi9MtKzkzuxpQ3lBYfLxvrKiXVGaVITz81yc2bG4GdeR-X_kudoO_oW3KMTyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wZQ9ZzRLaHaqfjY-jy5TOw8wgHRQeqZkcQ3v_rURZKEAewKf7en8NQ>
    <xmx:wZQ9Z3yBLMZLMIgmpf3X6qHZ_Ay8XGQMmXDG16k2q_zpX8PO25zk6w>
    <xmx:wZQ9Zx4mf8QVgcTtCBfzeRFMeNgZcGDM8NLudHV18Q-jZP710T2BHg>
    <xmx:wZQ9Z0zAp4A44YcGzN3VujCTVjsn3OfDwKT60F0_96Rvd7gFqqmIYg>
    <xmx:wpQ9Z3_xDlepPO322daBvDYeVYYw9tIg3gFPyQkaJH85bLsTnEUa3tlG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:50:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3f6a313 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:49:30 +0000 (UTC)
Date: Wed, 20 Nov 2024 08:50:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] refs: optimize ref format migrations
Message-ID: <Zz2UtKNnREAJgtaI@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>
 <ZzH-OaXmFcZkGE43@pks.im>
 <xmqqzfluidwo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfluidwo.fsf@gitster.g>

On Wed, Nov 20, 2024 at 04:04:55PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Mon, Nov 11, 2024 at 05:57:43AM -0500, karthik nayak wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> I read through the series, apart from a few small nits, the patches
> >> look good and straightforward.
> >
> > I've queued the single change to the first commit message locally, but
> > don't think that this is sufficient reason yet to reroll the patch
> > series, so I'll wait for additional feedback.
> 
> It's been a week and a half, and since Karthik's reviews nothing has
> happened.  So, let's start looking at merging it with that minimum
> update, perhaps?

Sure, let's do it that way. Will send the updated patch series in a
second, thanks!

Patrick
