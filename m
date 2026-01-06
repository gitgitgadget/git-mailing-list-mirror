Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B930B50A
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693523; cv=none; b=k7LRPtUQZxCX26vNRjenRgMq+6fjpdfdjOzFjXBadhkOxBgdyLyFkdDQpi+0YdGv3uCcIF/jdctPW0BRdg85M33xLNJZbB5AczQfAWNJsyj8QVdgyNG5wbKMxS8yMLXTvE9O7YuKXloACvhZt9ras9pe/nvWn0ZZ+8Lvt1lxLmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693523; c=relaxed/simple;
	bh=oKS0k2RRq4FZoevLbpnW0hPJVqwofgado9pl3SZ+T8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfeJkfJhZOaypwbvifF5TEZKV6icHHVh8viwYG7EvYS/vrwOQ9JPRjW3hgLiHywGsRVQpaSAF5vpaFgctwJ2puuJy9DXMSw96gkvfqiIqHGcQceMxsNIGszIp4QRGtoB+ab5hXyvIyc7tn8V/wFi5RYCsb9U7gaL1CKNO6CK17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jiMamJt1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ME0aVQJQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jiMamJt1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ME0aVQJQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E7A601D00064;
	Tue,  6 Jan 2026 04:58:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 04:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767693519; x=1767779919; bh=EqmRjNPVVy
	GgNIE/tRCyLY5kDZIqtkb0cPvOyiLXMbs=; b=jiMamJt1N9pn6KsfeLamxZOG5q
	1n5z3Dko9vHLdYu+of3sPK+VCzkXxBweEnlbidGoukXA4fi+7rDW8QsJtidNXpEa
	hogIC7Q+sS9h8eWkngi+Jyh127U+NrIAGU1NqRTt9qfGhouoTJ23VSK0mvixEsAM
	/wdtPUNKVavqrPg1HS8dT0QHryRLUVmxPYvqyDAEkXDuPZrQMNbnFcrOXxJOxuT3
	xNAlfvASyOtx/2yzg2sBtGQ7biiuTdWM600TB1Kkjnz2kZB1Rb2/pgqah4P3S2Xw
	G163d50igDVDguFcCALyYowootjlCgzvUnnaLM9DFqv641UmnmGROxqizxVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767693519; x=1767779919; bh=EqmRjNPVVyGgNIE/tRCyLY5kDZIqtkb0cPv
	OyiLXMbs=; b=ME0aVQJQID1b8MR3uVuMUd9D5dK6+Nwzm67LukaSMygT/4BIoqP
	o6N06Ti1BvuBUK00sgSe54KIbMXJTqcicOkNXqJ2lbcosYrYyoIiFnsx+4DC8eZu
	w202piZqc6wd/aDvGV9e6OFpanR7QrtYlaQve5/ShUwBGI3BNYRNLqDQm8WlWlOD
	lvBkacvpmfGY7O/r6UAj1f0iYHEHI+lj+EI9kRsn/s1wNmsSWBimbqawhKec4KUw
	klGGXfDComZqDoo6JwLkPbBLqqttbvqAmmXRiR3CegoFEOy/S532X5BFw5vsYiGH
	odgNWkBDwDIs0pV5dgyUa1b01feAXi3tjEw==
X-ME-Sender: <xms:z9xcaeZSnmR5LFFBRCmC9H2J5zbnWJIqCxKbsDD5wnPToxYCyNAOGw>
    <xme:z9xcaYawGlk7VMcjXpY9mSPnEKjTDhHMeuP-h6eCith5IsBpUVvDF8mnLMm-Jqp_0
    NUg7qeAJ0ExUb-t-rj2iaI4dreSLwgh8ePAg6LZwILLg2srMgZzkFs>
X-ME-Received: <xmr:z9xcad-aZ0iEzqkcf72Re7ZVdWM8MZhCBUAzCz6iZtJ1JwgzdI8v-oK2Z5kPdPub8RMbxI2N2JPuAC3-gPhKOEFacUITkuZTyU6EOC9b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeeludekgeegieekjeehlefglefgvdevieevjedvtdegkefhjefhieetfeduudenucff
    ohhmrghinheptghouggvsggvrhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhushhtvggusegtohguvggsvg
    hrghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomh
X-ME-Proxy: <xmx:z9xcafhY9emYdV8mIYcCY6Mex-opCKwpUGwP-btUaZqJWQ2jR_ulyw>
    <xmx:z9xcaVfnRs3-60ogsqyDeLvAyP2n1L9pyS3waG12xZ-s8q920s58sQ>
    <xmx:z9xcaer30h_YqbbbHJdLNIWmBEnV5okVtU3EltibBs0yDw34PqMKUg>
    <xmx:z9xcaSDeMhd0Kzxvl-XlD_nY5hEFtConDaJ9RWlBa05a-0Paqy4PlA>
    <xmx:z9xcaVsE8m4-mAHv8DIIHFqXQPTZ_E8yz2q85Nxyu1cZZT6zZdCYRDoG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 04:58:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be8fc92f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 09:58:36 +0000 (UTC)
Date: Tue, 6 Jan 2026 10:58:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: git-last-modified on bare repository
Message-ID: <aVzcyYjR8l-xXD4L@pks.im>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im>
 <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
 <aVvWDDtBeJMIF3F0@pks.im>
 <eecb1c9a-4dc9-4666-b2af-1e3478109db3@codeberg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eecb1c9a-4dc9-4666-b2af-1e3478109db3@codeberg.org>

On Tue, Jan 06, 2026 at 10:42:55AM +0100, Gusted wrote:
> On 1/5/26 4:17 PM, Patrick Steinhardt wrote:
> > On Mon, Jan 05, 2026 at 04:06:39PM +0100, Gusted wrote:
> > > On 1/5/26 4:03 PM, Patrick Steinhardt wrote:
> > > > On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
> > > > > Hi,
> > > > > 
> > > > > Now trying to actually make Forgejo use git last-modified after being
> > > > > pointed to the non-yet-documented options but I quickly noticed that it
> > > > > looks like it does not work as intended on bare repositories when looking
> > > > > specifying files.
> > > > > 
> > > > > $ git clone https://codeberg.org/Gusted/math-accuracy
> > > > > $ cd math-accuracy
> > > > > $ git last-modified -- LICENSES
> > > > > 768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES
> > > > > 
> > > > > And on a bare repository:
> > > > > 
> > > > > $ git clone --bare https://codeberg.org/Gusted/math-accuracy
> > > > > $ cd math-accuracy.git
> > > > > $ git last-modified -- LICENSE
> > > > > fatal: ambiguous argument 'LICENSE': unknown revision or path not in the
> > > > > working tree.
> > > > > Use '--' to separate paths from revisions, like this:
> > > > > 'git <command> [<revision>...] -- [<file>...]'
> > > > > 
> > > > > Is a worktree required for this to work?
> > > > 
> > > > A worktree is not required for this to work. The problem is that you've
> > > > got a typo in there: you say "LICENSE", but the actual file is called
> > > > "LICENSES". If you spell it correctly it should work alright.
> > > > 
> > > 
> > > Ah, sorry the typo is on me from copying the wrong command from the shell
> > > history. It produces the same output with using LICENSES as path.
> > > 
> > > $ git last-modified -- LICENSES
> > > fatal: ambiguous argument 'LICENSES': unknown revision or path not in the
> > > working tree.
> > > Use '--' to separate paths from revisions, like this:
> > > 'git <command> [<revision>...] -- [<file>...]'
> > 
> > Hm, interesting, this works for me in a bare repository. Has this
> > already been fixed...? Indeed, bisecting this points to 05491b90ce
> > (last-modified: support sparse checkouts, 2025-11-29). So you should
> > probably try with Git's "master" branch.
> > 
> > Patrick
> 
> Yup, git from source works! Do you by any chance know if 05491b90ce is going
> to be in v2.52.1?

No idea, point releases are typically done rather ad-hoc. Let me Cc
Junio though so that he's aware that we might want to pick this if we
ever release v2.52.1.

Patrick
