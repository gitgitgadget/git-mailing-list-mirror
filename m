Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BAC1AA782
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813693; cv=none; b=Drdl+DuiAO7M7AxHSN6NcNJy3RdTp4KLIlNpiKCP1rdOxgbtAmp3JOMFFpSi4LgMLZoZc3I8PkPs5JQj5P2VoLdSPEpN/gNqX07r9eQjk/mZsGMmHhSpe1n4UfoAO1LHX+QJX+FQA77uuQ/NCY4ufuzK92uJPFQkFjOcm9zeZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813693; c=relaxed/simple;
	bh=fb7ipgl21+APAuWiKsTgf06xnLwrCSFjzYCM7VaLG+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cx8Ml/MwFluCuW9ZMjQ3Q+sJ+utnWsTOA35vn0SJzAcx/CBI1WQlZw8jvRJUOLj8fnUVtV+6PBj1k0UUFdd32A6d9hBnCJaVeAAHVb/cy/9FLxLVG4gcrTT0m+UzqryDHS0F8AgBtxrgsD0EU1ANmljm73Zti6h6/gPQl5fZSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a5cVbmZ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ga8b+HuM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a5cVbmZ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ga8b+HuM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDE63114022C;
	Wed, 16 Apr 2025 10:28:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 16 Apr 2025 10:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744813690; x=1744900090; bh=UREN2TciQ8
	setV4fM7KNG22Jg9uw50ypRBckidK5/8s=; b=a5cVbmZ073D67xP849fkclLBY5
	9nDmqD1VK6WkwtMzLVjOgG6PC1e2FBWxp8tB+eoFI/NW0GDYGKQmGkSEdNJA9mvq
	gVA5sAtjq3oB5H3cMm/JLsrf+xMpQBdiiXn7MuRVAjQ0T20Mql0jEzXp9DhSW52q
	ZanLPF/h3r8wECmpwAq7/Cfwomp/opDocNxSclRHzZxF+ZubhiYDQbXUVCXmxy1o
	LxN2fuvuShiTP/D2P2PpeYwmF3k3Ivetgweo8Hlt0s7kRd48VQbQKRUudmkQ5x4c
	aIYiIPWfnI8lk6G4TEijlunvj3qlrJRs4B8sjSMDF3hXMEA6jPG3xulpJQoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744813690; x=1744900090; bh=UREN2TciQ8setV4fM7KNG22Jg9uw50ypRBc
	kidK5/8s=; b=Ga8b+HuMfRmtnGPbpaLBhaRkU9WVT286/3neaVq16xcJOh1ATwA
	hJJs4Ob+IHWOBmvyFFicrNGk8bUjekvzlzjVR5aiDaf/FMQlaYPhRmx6KWXcH7Jp
	XG3Ebs5J82JCyUw2n+mY85zQOqI/N5roSj7UkAuygs168dR3UkW7A4uTk5wRV0gZ
	fYW9Yw2Pr8ZfqU0YN1PMNBw0Hgbr9k0OhemxqlbuUGxgGryye9euWZGRfybXsufD
	FLMF1YH8q39ubXp/yrIC2wLqSdvqkzOZH2WEEbtesBCcxEykv1ZiGMlcdc4/IIpR
	6nvcN8wNDBlgPKw0d3n7WMzxtQVscVrX2uA==
X-ME-Sender: <xms:er7_Z2hrhJe6lLYllZSgScaJzJOyfbt88pw7FiLp6ZVJQvV6rT7r7w>
    <xme:er7_Z3BHt_dFNBA69Uj8lclnQZWa_EFH7tQHpBHeYt-OnDz3tMeOUFKwub6SLWBYZ
    z7F-LjIWSaF5wauWA>
X-ME-Received: <xmr:er7_Z-Fi2BWuKQTG6xAFPCEiIv_8lmSwNd-7v2QUxB_91_x9OBn2VE-4vVdLTocbbRZvCJlYOU-6klu_5W3LPx6npirx2UWWv05t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:er7_Z_SrR0B9CkG8lX1648PSBthcKgCO-OM7jNxrWJsEgxjQB0ENZA>
    <xmx:er7_ZzwzNRzJctR4IpV_rDifrslYd78DyFCjv-d_zDLqTGS-hgGSfg>
    <xmx:er7_Z95U5ZJZwajyLt8PX5BsbFy_6FhMrCv4_NtBf8pX7ULyPljSAw>
    <xmx:er7_ZwwoKsmTyPE85II1hikvRoG_nbG9E86K5uKLSBSLgOr1yp0W1A>
    <xmx:er7_Z0E5cwdqEZROQ56ElHe4lFC-dtaGCX-5L7tq8QHqfoYg0osKyt75>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 10:28:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  phillip.wood@dunelm.org.uk,  Derrick
 Stolee via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  james@jamesliu.io,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] git: add --no-hooks global option
In-Reply-To: <a5632198-9e04-4302-a3c9-1cbf0f0cad65@gmail.com> (Phillip Wood's
	message of "Wed, 16 Apr 2025 11:29:13 +0100")
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
	<2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
	<cb3d080b-51a3-4096-9650-34ec4ed68f1d@gmail.com>
	<a5632198-9e04-4302-a3c9-1cbf0f0cad65@gmail.com>
Date: Wed, 16 Apr 2025 07:28:08 -0700
Message-ID: <xmqqh62oi3k7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I don't read a strong reason in your message that this is a _bad_
>> idea either. As in, there's nothing that hints that this will cause
>> significant harm to users other than providing a new footgun (and we
>> have plenty of those for folks willing to look, including the
>> _existence_ of hooks).
>
> It is certainly not a terrible idea given that it is possible to
> disable hooks already but I'm not clear what the motivation is. I
> don't find the example of a skipping a pre-commit hook persuasive as
> we already provide a convenient way for users to skip that
> hook. Elsewhere in this thread you mention the "pre-command" and
> "post-command" hooks but they are not part of git - if a fork is
> running its own hooks and that is causing problems for users I'm not
> sure we want to change the upstream project to address that. If there
> was a clearer motivation it would be easier to understand the benefits
> of this change.

Thanks for pushing back.  The default for any new changes is not to
apply unless there is a compelling reason why it is a good idea,
saying that this is not a bad thing does not serve as an effective
justification.

If we want to give scripters a more stable foundation to build on,
the answer should not be to pile more and more "no hooks, no
configurations, just a vanilla mode of operation" options to
end-user facing porcelain commands, but to clean up the internal
implementation of such porcelain commands to refactor into stable
plumbing commands that scripters can rely on.
