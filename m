Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005F18FC86
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731743904; cv=none; b=bvRVFjjAk+MG/itSDV2UG8XyjURDK4MtF3m5IijLM4OEpUiXTCJiK06n1y0QD1r9EWSdBTVwS8DqTc2h1uKRvgUyMhRLZEa5MnBYSfNucm+C7/Y2McitXQUTgqFjqpAG7Yogsd/gz3/iVc/BUqpH7ZaVc61tl6GWGQxOU/3PAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731743904; c=relaxed/simple;
	bh=ef/xJayJU2vxAO5TDdbpt0M7Fw7Kr+Ext0OfPf6dMNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5gt7+Hg2Q4yeI8rEb3ckKMpYTNabp4uKat5atYIhdMHkwBPu+3hYBMONHTMxe9g6AEI5924DmsrjbP3pdFTpTPuYyjgTSgEXeY6q+R4gQNgPVy/ljnWnS55k/lKnyrvWiS23P7GKTxKReeZm/0ADaTU7qD51rK0uJXmFEesWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3kKxLO9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3kKxLO9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B77802540152;
	Sat, 16 Nov 2024 02:58:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 16 Nov 2024 02:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731743900; x=1731830300; bh=poFNNTsU2i8dgotEUGjtkyKdP4EeuJzhw63
	MqwzDriE=; b=i3kKxLO9Gfy993Ed26u0rSYvad+55PxabqQei7+pqdupVlo7JfP
	nlH3RqYfpuewtBgpFkRu+RKEkfiFjh8TdG3Bbt4UezQ6z2l9DTEiTaWlhGALj7Jy
	UeNlA/JbUOTjWbmHQLW4wpJat/+7B+652ujbU/vywq3d2zPfgz2hFhScWrueEZ8w
	FPvIlDigI90My1qT1KtM8eBVEFHUXajiITLzNX2GYsltB3GDyVEg3B6tGWM8bU+G
	/lsh0YVTGsQ8/cMbPgWI2ZdMYC956Cbol4j64EfMwUzKbyzMuEMhKgdhyc76WtGI
	KXe0pgLdijgY4B87yXQCHsD+vScZWoy75pA==
X-ME-Sender: <xms:mlA4Zz1Htl_TsoZvFxfFP7T7n2EoeujxTj-aAANKwpxJOz5zrf6RLA>
    <xme:mlA4ZyE_z16gSl31B6TcDSWN7FjmnmBA6_zm0wYZflLdxsrapw452r1FdC1t7PLpi
    H4tR-vAr7ebRNavNg>
X-ME-Received: <xmr:mlA4Zz7fwVieP0AhUTBo-dV1jpR3ezfa1DR24E0lpCbpi60oQZzSpLE8N7qoSG_SjBrjDfhkGd0bICrzpbMzDjnuFNjkVwdcprAv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehfvghrughinhgrnhguhidrsggvnhgtvgesthhtkhdrvghlth
    gvrdhhuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mlA4Z40tKc9teeaOW8t_M32slPDlm4PIlMdWd02Ikluns9_EeqfgFg>
    <xmx:mlA4Z2HXtLO6gzHu5zC0L0pNQS6TYRUsCBPO4RLgTTijjyWJTGqc5A>
    <xmx:mlA4Z5920ynIvt01F1W0RbMixIDPo2XMRXu_Z1lxyupjZtAz8dsOjw>
    <xmx:mlA4ZzntzXoTD4asVHfqguq_SK1OsT9qSjLGVhbsW4RDNuAqVZWoFw>
    <xmx:nFA4Z5DLyIyyqxb6ApPiMr4hwq3KJH9hJivx8sHxn7FXS623BpsCjOZZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 02:58:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 	karthik.188@gmail.com,  Taylor Blau <me@ttaylorr.com>,
 	ferdinandy.bence@ttk.elte.hu
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
In-Reply-To: <54677502-a08c-4920-9b08-13517c8f027a@ferdinandy.com> (Bence
	Ferdinandy's message of "Sat, 16 Nov 2024 00:27:44 +0100 (GMT+01:00)")
References: <20241022194710.3743691-1-bence@ferdinandy.com>
	<20241023153736.257733-1-bence@ferdinandy.com>
	<20241023153736.257733-3-bence@ferdinandy.com>
	<xmqqr07d11wt.fsf@gitster.g>
	<D5N3N1RMMR9Q.28GSGYYBWZSOS@ferdinandy.com>
	<54677502-a08c-4920-9b08-13517c8f027a@ferdinandy.com>
Date: Sat, 16 Nov 2024 16:58:17 +0900
Message-ID: <xmqqbjyfzk2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Sorry, it's late. The above is slightly bollocks since fetch ignores
> any set_head errors later :)
> But the idea stands that if we can set the head, let's do it.
> The previous head is not important enough to die on.

Yes, I didn't mean to suggest aborting the fetch.  I just wanted to
make sure we _react_ correctly to a failing call to read a symref,
possibly because the refs/remotes/$there/HEAD (1) does not exist, or
(2) is not a symbolic ref but signals that the other side has its
HEAD detached.  Treating any failure to read a symref as if the
symref does not exist would miss the latter case.

Thanks.

