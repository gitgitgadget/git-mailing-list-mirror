Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B61E9089
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571644; cv=none; b=mI9yAITP+F1wz4SJj6IqB3iUInw/WJNBS6moh/zi6YD1t1Q+fL1KR9R2i/1jFa4XlC+OGAATSVUN7aTLxTz5Uyf4Dif6S5EiBQmUjxDBNMvYzP3Bg+ZDNBcm4OmkNA+pooWzc1gcRnfiNFgLp2zriTjq5FK5kWeDPHU7Efv/A8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571644; c=relaxed/simple;
	bh=ghrlL3OJ0dpSFL5u8t4itqUnq7r9H5Y+BnVFs27wQ7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4d5ytH2G4pnNl2M7uRd3K12uI3lXOZZPQst/6a/zqQSAC4ElcOvKrdtir1JQ18y/7aK4PfBjRTttHwbG2Qjf7PWbTn8J4s7jAhiiOn7u0Dqgo0p7QvmT1Uxh4RDXrCnECDQmdOW2UFV895MJ1OljUAd4hccahrBLmT6sGWotmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kk/4IpsL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kk/4IpsL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B16621380444;
	Thu, 14 Nov 2024 03:07:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 14 Nov 2024 03:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731571640; x=1731658040; bh=dQGtvFxO4bI33Xjtu+TpBA1bQY/sSHVTRuy
	42JX8lOQ=; b=kk/4IpsLYvAlFklBoeprtvYgHLCThsmusdPlLXygMzoXfNfPiCH
	+LT71+k0YwtynblwK9aj+8tEfxhtu2ETGP9Wxlsl10SSyrL+MyXB6JJSJS6ftiYZ
	h0z/y7pvISp3D8vvPUncNm1ecNzHbzDlpl1IDetLuVXSIbBS9AQpH4AmYgsC9jDk
	u2uBy9sv8FD4acYoYmWy3dBa6otdtOMl2EhKS6OC21LRBcvWgaXjpHATVzvTpPuE
	18vVULBUIhVUhvRogEefybHYf6rNS24s+89dEP/wMr9wspFeUOaRm8ZSK6LnnV5X
	0R0TX3bB5UCIM17E8XEJkFAsrrEZVV45rSA==
X-ME-Sender: <xms:uK81Z-kWV_EC7dtWkzZDBEMOeJ21KKZZKUEMe74CWCe_Aa_Fz6JTgg>
    <xme:uK81Z10zbHVJbFWz3Sat-nfHA09Oym8DASsDBJjXqQJewFSPNeHOEUVRcH3mERo4V
    NEFfOjtuga9WlnlFw>
X-ME-Received: <xmr:uK81Z8rEUyyMNCxRmagaqWRMmiekG4aXW3YMjLYl4UydUF97JuCfqTErTsoQmnA6kvIAsM_V3j8l2ZDix1_cbB3gn2eBznx3h1so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhluhhssehoii
    hlrggsshdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopeguvghvodhgihhtsegurhgsvggrthdrlhhipdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohgsihgrshdrph
    hivghtiihstghhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:uK81Zymyk_0R6dGTZXsHir6C-ORy6JmSMXJJtVQ2DXSut1oncuegNA>
    <xmx:uK81Z811A7J9qoIu9EelELcjNXPgtBseRMiuT1yBZPWkERx2sUHckA>
    <xmx:uK81Z5vyMcclYyDGyX0Va1HWe3FEBtxrU8MQPpoijgeXvDOIFdlFrA>
    <xmx:uK81Z4UfvTOjUoCneLx_YntRzL2XWO5LP7oiFjxwCz6q93iOVj7cnw>
    <xmx:uK81Z9lObcGUlO7EefyuAutxa_z-u23z_a7ajFq2CrStOYyHigt_R5Kk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 03:07:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Beat Bolli
 <dev+git@drbeat.li>,  Tobias Pietzsch via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Tobias Pietzsch
 <tobias.pietzsch@gmail.com>
Subject: Re: The health of gitk, was Re: [PATCH] gitk: check main window
 visibility before waiting for it to show
In-Reply-To: <ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org> (Paul Mackerras's
	message of "Thu, 14 Nov 2024 18:19:29 +1100")
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
	<bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li>
	<ddee92a7-3d1e-f869-9cc4-72b70eee0dd5@gmx.de>
	<ZzWkgblaoWehC0kY@thinks.paulus.ozlabs.org>
Date: Thu, 14 Nov 2024 17:07:18 +0900
Message-ID: <xmqqed3e6xxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Mackerras <paulus@ozlabs.org> writes:

> I recently (as in several weeks ago) sent Junio Hamano an email asking
> this question, and asking for his opinion on the best way to proceed
> with gitk patches, but got no reply.

Ah, it was probably (just) before I took a few weeks off, and I
completely forgot about it.  I tried to be careful pushing back
patches that touch both inside and outside gitk but I wouldn't be
surprised if some slipped in by mistake.  We could split them out
and get your tree back in sync, if you prefer to keep gitk as
semi-independent project that is subtree bound to our tree.  The
arrangement had merit in early days, back when git itself and gitk
could have different release cadence, but in practice, I haven't
seen gitk separately issuing freestanding releases to end users (or
end-users installing versions of gitk independent from the version
of git they have, for that matter), so perhaps the separate tree
arrangement has outlived its usefulness?  I dunno.

Thanks.
