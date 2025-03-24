Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0147125E469
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817763; cv=none; b=ScTVWoezyy3dAvZcIvFpG2oAKYfUv4ucbDEDQz9FVwGKNVt7AuVlfQri0AYt1lg50rzXGPl5/dmohA3DDyODO1duTrp+pEMfXdlzcDdd2eG66922Rde37w311FlHIEH09rJB8RmTyxK7/tZofe/09TzSbBFw6m2Gt3OYBl3HmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817763; c=relaxed/simple;
	bh=MMdvvxSHKnp1BjlAmYxiIzlPVZhIVOxJifdvxFOhA/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Neq7T/OgIrhwjjJavaHr24ruLbwhKVJiRGTXRR6YDrZMJVFFMsxQNkyJnofR3IVJVGwnJPMFjH2/1Tk3vCdGsE/S8upoJoAC+HQg2Sv3LnhNNTqnT6ywO14al/FWDVDabZIK+JTVWtXlLOU3EtRuwzx7e38FMYoKv6HPpKMGqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mixnl4pH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jjjom/sW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mixnl4pH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jjjom/sW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 025B625401CB;
	Mon, 24 Mar 2025 08:02:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 08:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742817759;
	 x=1742904159; bh=72gCNSu38nP5w59pdLj8OQ2ZGIT1+B/+MPqRd+C8Ke0=; b=
	mixnl4pHGJiCBSnlQCpc8HFHlDdwM3OgtfuW8D0MduDA18yAvXws0apJiYivfLIN
	2kBq6wrTfJobG0J3YgBzbo9XjvbPM9FB3ZatlzsYs0SMi2iFHaX2QajC6cJ/RTXH
	Xop6n1H2ZU9QSWVLb9IgihEcaa6xcFi18BYELAhDNdQPwr6W+4XVuBZglUzG13aL
	Ito3ViiN8aDPjno8SaQTk4SeARwvT5oXNZGLM2hmistW6uYO/ugLFx3+6Kuu+pSO
	G/W5gzZIZUUx5NPBZxrqRDEb2AILTSsM/jWeM/6EQQgBJn6T4rM4ccnexIgXKnUS
	DhJGcajSXnG4h372xVeLGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742817759; x=
	1742904159; bh=72gCNSu38nP5w59pdLj8OQ2ZGIT1+B/+MPqRd+C8Ke0=; b=J
	jjom/sW7vabtoopRiAtNzntXCaoVEFZKyMZ2n0G21J41bi026qjPPnsPShX0woyI
	HTdOl5vG5vFvnLoKOSWN34XXUGI+U/tMT1bqKUc21qBQXdbkOQnkios3bWtYf6ZP
	x/FoetOZuD/gUvwQ1PLXnZhFdzhK+Z/ymnYxkR+GUwr5wzeJqrot/+ASp9F/Ji5l
	BdTnI1rm8uUZivEMHMXl38BhBWvJ0glM41bUBSf4SR59swnebBuv6QsWG2KdI1/J
	G9xP0p5GEBVJMEnHKsbbmkiOUCFHJgduCXw+fW2mcKDcIV0rUCUMqyIPD4vlPnAa
	M6RuOvsdHkijgW9J8UoaQ==
X-ME-Sender: <xms:30nhZ2cGwoBRceDb-CZkWP422vASJMsolsfrT2xP_flrNVg9T5glMw>
    <xme:30nhZwNgR6Xi9Frv4cQuNBRe-uhHp7CjjO91FJZrv8fjF0pXVVR3QjWqjft9h0LMX
    hFB6dkq_cGLGy6zFQ>
X-ME-Received: <xmr:30nhZ3jrypN5r4uuGvpFx2osyBEXvKol1dWyVvTc_-MSExubS4moQHRVknJvXHXPwy0EPI3z-Z2SCzLhXrduh57N9dwA01F-q43dL1GPTER-Mtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudette
    fghfeggeefjefgiefgleeiveefvdefuefhudfhuedtleeukefgtedtuddunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopedtheiihihtfedtsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:30nhZz9-d6RiWpMloB_eInAU_KAISa18sGg9CSlpxdZVUuWdJriulw>
    <xmx:30nhZysfpaLjnB_-bsrNN-8X-Of8aWrPZjGQY9MbItEwnFlO6OFyUg>
    <xmx:30nhZ6GD2SCFDt4r-lUTJRL9FCRy-lOawJANyau15nTBVu9IHOFEtg>
    <xmx:30nhZxND6dGvWB5ZtXcSakKAdUNPq63eV3mcc9r3yu3cqMrQONTmJQ>
    <xmx:30nhZ77Gpng3xE6HTqXWhFDgzU-2wgVuW0MTMldK7PfpzD4tMgwvU_xr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 08:02:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cb0dcec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 12:02:37 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:02:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Yuting Zheng <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] Proposal Discussion: git-refs Project
Message-ID: <Z-FJ3EQdFIkQgtkR@pks.im>
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>

Hi Yuting,

On Sun, Mar 23, 2025 at 09:36:51PM +0800, Yuting Zheng wrote:
> Dear Git Community,
> 
> I am very interested in applying for the GSoC 2025 project "Consolidate
> ref-related functionality into git-refs". I have reviewed the relevant
> code, documentation, and mailing lists, and as part of the application
> prerequisites, I have submitted a microproject patch
> (https://lore.kernel.org/git/20250323022111.20226-1-05ZYT30@gmail.com/).
> 
> My current idea is to extend the `git-refs` command—by calling into the
> existing code—to add subcommands. This approach would replace the
> functionalities of the mentioned commands while ensuring that I do not
> modify the code underlying them. This guarantees that the new `git-refs`
> subcommand meets the new requirements without affecting the usage of the
> existing commands.
> 
> However, when searching the mailing lists with keywords
> “nq:consolidate ref” and “s: refs”, I did not find any discussion about
> merging these commands. If anyone has come across any previous discussions
> or could kindly provide additional insights on this matter, I would greatly
> appreciate your help.
> 
> Thank you for your guidance.

I have been chatting with Peff about this topic quite a while ago, but
that was mostly an in-person chat that hasn't made it onto the mailing
list. I may also have mentioned on the mailing list on several occasions
that it would make sense to consolidate, but there wasn't ever a bigger
discussion around all of this. There's also [1] as a non-authoritative
source for this project that documents my intent to consolidate the
commands.

So ultimately there hasn't been a lot of discussion yet around this
whole thing. Driving consensus and designing the new interface would
thus be one of the biggest challenges in this project from my point of
view.

I'm happy to provide more feedback once an initial draft has been
created for how the project could look like!

Thanks.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/issues/330
