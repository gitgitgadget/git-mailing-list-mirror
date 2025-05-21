Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378329C34E
	for <git@vger.kernel.org>; Wed, 21 May 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859566; cv=none; b=nJ3Da1yMMlbRPIwJob4AI4mir5BdB95dcHCcUHSfdnSq+9d+xSJcLUt2FNdfefHneO+RS3kLa2pcnVnIa4/PWrI1X41wGw6TWVYqyM0PUggHUCR0AhK1iSuzbNnL6oOz6JL+pVlCn8C52A7n/Po3rmMGqMfqRe5TSYBC8qDCUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859566; c=relaxed/simple;
	bh=rOX4g/he9psYd16edKqG3PByWBltE97uMW0aMC3Kxhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q3YjlqRm/Afi4sot66UKzcubWNmBb7K5j+W/LCSJ5lhlaCW8V1GZQAShMbZA+oSI68h/d9vOui1YdgVZ7uY/lBuE2pOOZSszSmOsHZlO3/HmC2d0e3PCWMpw3k/UqLOQauYNOL56/h0tTJvHEpCNLrXGR6wwt7g2R1j9lnWQF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NSJNnc6w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YqrSDxZJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NSJNnc6w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YqrSDxZJ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 595871140095;
	Wed, 21 May 2025 16:32:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 21 May 2025 16:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747859563; x=1747945963; bh=M/c1lPh6Ty
	cBPkU3GWlFz/nViVLHi83noIPeniNkkfE=; b=NSJNnc6wDnVJNGSZzpWt9TTbr7
	gGPAVpBsuT2sK/EdbEUmD4ZERaJw0Zjv9S+pAiI8AKOrqXTJenf+TS4rB9OO3Uub
	Fjr7SBrt2FKO8bUhRbQQVYPV9gPOjghGEd1ONLJJ9H+I17shIrOV5444xoWJs7zf
	9t6UWySWgF0JxJcEXbZ6mk7nNBypn5Aw3zynU1vlSjq/bqOu8mJJoeWm5QeYefYj
	m+D8y+thIDvfFF/PMjv0F+sLyow3YXmpCdS6ex9dYsaP2lx1TBtxvf9wEsGH8UKJ
	LQGvrbHo3Xpnmih/t8CNJl6VaycE12vFh2kpD04VrAhlLaLKzyL22XoZqJjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747859563; x=1747945963; bh=M/c1lPh6TycBPkU3GWlFz/nViVLHi83noIP
	eniNkkfE=; b=YqrSDxZJJa00bJFxZpMeINSUFsB7jTTFgk0YUhiLiRKsGGXQEXv
	j+rzGjwUUI82zkfuKcN/fgs1wwTUVmrraRUVYGujaov7V65VJSs4YLX0+QfNvBhN
	JT204IbGOt3PWDh/4TnAWRCmJ/RkY9VRlZsfvSld/YNJ5+gkq/reqV5L9/wC3oUI
	PELickTQJXxW8Z5BFlUyshwlALWGDl8Q+GA+L0dZbfFYXoxskyNR+2CvGv1T3SSc
	XTc2mSqcepr/vuqrO9FaKitZGWndpfloAKykjSrGx3TXbC4xuxmai0ZJFn1FR4UF
	0F4QjRPePq7clWfxTTBpf7os4EBoDii0VVw==
X-ME-Sender: <xms:azguaB5Iqjwrh9E-Vqe3fEYValSXsAXEBu1XgSsbHimf9r0QoHpqyw>
    <xme:azguaO7E6Zh1ZmDnC9xg5Egn6iu6ZmDElIUfbMwKPMaggpMYqHzRUG4o9TN67-Fba
    HUNx2obDkMLTfthbQ>
X-ME-Received: <xmr:azguaIcFPwn7S_c5XF6TlNVY_eZYriGRp9GhA5cIbS5OKY6h4iUpP6vHFqbt3IT6ubN7U0rXmV72UGDmTI1cBcmpYtqnxJvwhU_MAZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegtdegucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfet
    vdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhhfohigsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:azguaKIQJP6PEuI2I8IYp5K3KwAM2Gt1QIBlgTDdUesOLR9GFabgFg>
    <xmx:azguaFJl6KlwV1HZ74GkOb5G-cKK12TySOUt_X2uRsLrGd_RvJNwzw>
    <xmx:azguaDxseSfNNea-UZCQzlG0pjnmAKEXyNCfkT7XZB5fcS3Kb-wBLQ>
    <xmx:azguaBKP3icbWiPM0TqgqyDzKgHc6p3SVE4XbO9UanyfsE_Frmf17g>
    <xmx:azguaOrb1sW5OUi4PIY8YRZcrPB-IBc5h1Z1zXzXM1PIc8LKC9yd74G1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 16:32:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Alex Mironov
 <alexandrfox@gmail.com>
Subject: Re: [PATCH v2] name-hash: don't add sparse directories in threaded
 lazy init
In-Reply-To: <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com> (Alex
	Mironov via GitGitGadget's message of "Wed, 21 May 2025 20:16:25
	+0000")
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
	<pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 13:32:41 -0700
Message-ID: <xmqqecwhaemu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alex Mironov <alexandrfox@gmail.com>
>
> Ensure that logic added in 5f11669586 (name-hash: don't add directories
> to name_hash, 2021-04-12) also applies in multithreaded hashtable init
> path.
>
> Sparse directory entries represent a directory that is outside the
> sparse-checkout definition. These are not paths to blobs, so should not
> be added to the name_hash table as they must never be queried.

The second paragraph sounds as if this is a correctness fix,
i.e. "should not be added" hints that we would see a wrong result
returned from the hashmap if you added these entries to the
name_hash.  If this is a performance-only fix, that should be more
clearly stated.  Also, can we have performance numbers in the
proposed log message as well, or is the improvement too small to
measure?

Thanks.
