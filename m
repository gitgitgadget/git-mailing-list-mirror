Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A21DF980
	for <git@vger.kernel.org>; Tue, 12 May 2026 04:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560992; cv=none; b=o+Ac0Ym6HgJmQqQr8IcJg8uA523vp4niFuelVGS9BKxvZdJt2pLiku7e2f0Im6w3bUfEVFcmvZByyO0lGe0+UszVAwlIbGEy4eEK3a9yBsvMvRYBbI+wQsbYW04mqD25AUHhFaB00hPbiF+6qxrocOCp1ThpKoR23dXqxNw38Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560992; c=relaxed/simple;
	bh=MPkIspOlVNfVg74iq/60JjXHSv0KnfPCaWoXBMKytOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixg33D3cJ+rgRBss4Z1ArlzJ/t6VFtyjsIc2nRaXDeelW+SFplYMicMf6l/xDYgR+3BhLzsJ1HNig2eVA5YfucdNGQw6Y05+MXffVKx9SAAlHhINsqIp6Ftirgj5GOtQyFLF07dIEa599T0XG8CO0S9ltlUXL1CfOWs3ISkTtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eswKCMEZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZT5WW5I; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eswKCMEZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZT5WW5I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E40737A006B;
	Tue, 12 May 2026 00:43:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 00:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778560989; x=1778647389; bh=qwf4ijmxfz
	pRm5SO1tNI/Cd36p5qzwjGI0FrFEnayTM=; b=eswKCMEZ05PvVgZ01SJ6dz6x8g
	FeZJewJQgANVyHVRcYlcWYxlQRXVpVcvJfE1/wj7739ApGaUasmijxIyfaAtB7aU
	a91pJXgsudhCGUZXsDZjItwyKhl/30FckjtmmHN4fpKv1OnSOSpzQmC2cVlyJq1x
	5Si93oPnG/ydI+buY8g1bfv+cyH8/uhPGjlepT7zLImUeZaq58LGrd48QHwUjJI3
	tEcYFPS+U3cPV44tkVumXm8Aez3Ku7fic5dj9ahHmxiDOdCpACEBWx35jp4PNGS4
	Sc0M4TLKPrZDVzkKgQgLArhtpTXaeMHVSlhU6AZUOmTspOYcox1s+BDm9ZmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778560989; x=1778647389; bh=qwf4ijmxfzpRm5SO1tNI/Cd36p5qzwjGI0F
	rFEnayTM=; b=SZT5WW5IP8YqwxdlH0y3rgCBdf0ENzB1UJZf8j2v0MiVWuyMdIc
	AZ8QuvV+pYms90OLRuNB9nuuuUea200qNZXr7F60pFERCk2cbeVk1tfoLd4tfbkT
	ygrauy1LfKtbIERT8hFZKcnALqxYT6JarktYZN+H0qOx25wqAZPkhnvULrv/uBZi
	NALSmmfNdaAOdJ/vq41e8BS1io5t5G/mSvAy7S2CUV+XhIAfiW98XfuxIWyKovoO
	PMieUD418mi+1W1tpi4Opjwvl8iiVP7HMre/HMbuYSTDypD17EvWvBFe0LK8Zkno
	ibf7KNUKRk6oiOq6sn6jr7qMqunoyggn6wA==
X-ME-Sender: <xms:3a8CasjwOFDQXh_tKUvKyhLFCOxmq43zfS0iUELPcD4xi-i8BJ11dw>
    <xme:3a8Caot2Y7Brx4KU0QmcBmI2YWHSRcToLbQZgQcQ5F38yQ6mFWElVamaw1dHkogg8
    rAUxfXBy-JBtji9EqH8PS-iN5WxSDDSi9pf_7G5RHc6a3510WFrZQ>
X-ME-Received: <xmr:3a8Cat61wZHO9LdmwJLqcCCxyuFZrFEGlm6bVR4VrfkqSgDEgL4t36rpGC8L4r1eTcqjDbFUuABBM-fJw-KI66GTvgj5xkqoug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrshgthhesfigvsgdruggvpdhrtghpth
    htohepmhhitghhrggvlhdrghhrohhsshhfvghlugesrghmugdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3a8CakNTdSnG2VYjH9KEMDhOVUHRcxQ9xwUu8e7VzgzyZj4fcpJcdQ>
    <xmx:3a8Cart0_FGd3UwVPWTNHr6WcII7WJXf0eeQsCDgxvG_CMu-x6owZw>
    <xmx:3a8CanbU8Q58g5BNJSoOt2UIfmR4EK88_6jbdX-8dWmkU9aHkaJK1w>
    <xmx:3a8CatzwqeDintszNuH_F1p1B-5rUY6QWWa2iJoFPHi8-L-5IniaJw>
    <xmx:3a8CantA4jj9L_8fOF6JfMZ7yYMUS_yesoRPa96nt0sTNMoDcopiUEMa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 00:43:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  rsch@web.de,
  michael.grossfeld@amd.com
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
In-Reply-To: <d1170f92-3690-4fa4-8070-75ac9f119174@jontes.page> (Jonatan
	Holmgren's message of "Mon, 27 Apr 2026 10:36:55 +0200")
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
	<20260424151053.917066-1-jonatan@jontes.page>
	<xmqqpl3ovuvq.fsf@gitster.g>
	<40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
	<20260425232916.GA29816@coredump.intra.peff.net>
	<4a130a23-fa32-460b-a338-409d85d18166@jontes.page>
	<20260426230125.GA218434@coredump.intra.peff.net>
	<d1170f92-3690-4fa4-8070-75ac9f119174@jontes.page>
Date: Tue, 12 May 2026 13:43:08 +0900
Message-ID: <xmqqbjelp7ab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> Sorry, that wasn't a "hey we should deprecate this" code-wise, I was 
> asking from a documentation point of view, i.e. was curious how you felt 
> about what is "advisable". Shouldn't've included that in my email

After this, the discussion went dark, but I think everything that
needs saying has been said and we are in agreement that the current
patch is a good way forward without closing doors for the future too
tightly ;-)  Let me mark the topic for 'next'.

Thanks, all.
