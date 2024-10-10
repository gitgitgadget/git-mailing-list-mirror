Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80B3D66
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 04:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534935; cv=none; b=eOgZefKvTg21fTTKAoTqO4Fhbg9dVEBGpUG3tJxxYc3A2l2Drgph00Cm9bUFX78hp+db5HU+yY/3Znnbn4epE0CJ2K5xtpUbzpUZCyY+QLRPthfQq3BLj+//dsoYx0uibNIBx/ZGYQSs9n94/5Y9HS5OoJVymIqE972mA90Uv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534935; c=relaxed/simple;
	bh=gvumD628NuTXEwqub+YKXSnG2nUjpvx8XnttcKOSXbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2dGpi8dlOVwj5WG6V9fsFotZj9/9Cee551i8EgBZ9aJ8AkmYwX8mL4rhWdt64WFnxzdjxn4IwY1HZHcnri8155+BgfyVBGEj1tudwPEGqNlkOkCmkfQ8IkftiiD1WvuEEIbdUzrOAGc+EnEgd/0zuY+w2xgxritMhjac7bYRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KWRdb8xP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fV6HBj2A; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KWRdb8xP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fV6HBj2A"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53587138026E;
	Thu, 10 Oct 2024 00:35:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 10 Oct 2024 00:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728534931; x=1728621331; bh=gvumD628Nu
	TXEwqub+YKXSnG2nUjpvx8XnttcKOSXbI=; b=KWRdb8xPQKmNKpbpyxyDlVzx/B
	biyhaAhzlZidFhMsUbS3EU1Pdq6gw9T5WEkYQeB91ZPN1Ix3FWzij5sqjJJSJtoO
	poaq0nDu/To3o0QxkLiQfBAXZrRT2gZbEn54HqGWWJKxIWtIwQP9gNo6w8cBlRxa
	KBHhKZWHyhoTQCGnYLh6fzRMWMwTphSo/jwG2beIljpDwlBSfqI7J6uXDF5CxlJ0
	e5Z/l9Gm80blyML0La8wftipO3rGQS8VPBSHptb7Zrb/IiijgnPE8QSjZBtHj/TC
	pA53lYwKByibheQ0WEu80DZEWFlfK93mVMyufkCSnbQlqpPnB1X+/ZutFP1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728534931; x=1728621331; bh=gvumD628NuTXEwqub+YKXSnG2nUj
	pvx8XnttcKOSXbI=; b=fV6HBj2Acm+21s+6PWQCmg0ZfHzP6OvAVeVIsLsuWFHL
	IgyCZNTeFK2seGY2aUoTHigkXxEEHQIK1bQTwbT9mli+MqvXDyls3pgJeUZkCFyP
	Ctl+uMHGyYjcAD4mpi+3fl99ux7o8PjRAGiqnZON+8LVySYGChT3YeSDZnm0YYDN
	x9Fb/wHi5ufZctow9NP0mDFCqc5o3mUlK599pukGWTpDBcBaGARNJCuLMZwCj4l5
	rgh7bItEwWJt3XtcHO2Vdl4G2oiQOby2Invs4mmMGRo4K/+VxvCPKNuA3YXcxNVY
	mBwllKZYFgj4r2PA8k5b3E1604zSVkGi8/JfOiHQpw==
X-ME-Sender: <xms:k1kHZ0Z2cg74bffvMhNO_wztoQmwO1kZGMPV7DfqmoesXp7flqEk1w>
    <xme:k1kHZ_ZbfQFs0rRHQUj8zCf0aiOvkIcrt0jndel8W-WqtCx2HNAJqf3OMt7QIiLk1
    ec9K8KfVMcxtTp6Ew>
X-ME-Received: <xmr:k1kHZ--DJ1U7KOKs0FvTXTTPtNSWrXL1Wg57Rv-HkGhMpPBx0ZzyxFEeBqrTRxjuWhlgidFWT1iQtA3vx4-Gb6Gs_nBVHeTmiwAEfNSvhoJL_RHi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepkeeljeelledvhfekvdduieevledttddvvdekgeetieet
    ieegudejkeekkeeugfeknecuffhomhgrihhnpehgihhthhhusgdrtghomhdplhhisgdqrh
    gvrgguqdhtrhgvvgdrshhhpdhtleduuddvqdhgihhtqdhsvhhnqdhmugehlhgvshhsqdhf
    ihhlvgdrshhhpdhtleduudefqdhgihhtqdhsvhhnqdgutghomhhmihhtqdhnvgifqdhfih
    hlvgdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnrghomhhirdhisggvhheileesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:k1kHZ-pSk-nKNNumDQhRJIYBlUd-4f6Xjb_Ml1djeQiX6Ryw7GLCFg>
    <xmx:k1kHZ_pNNGiD_pkxwFtNpgDLHYqcPhJR-6XbIYKhNg53Arze82eWag>
    <xmx:k1kHZ8RrsosxZO--Zwafh8beysNnTrj9gSbNoAvZwyyPwLv4TOq3nA>
    <xmx:k1kHZ_qLF4sSsz2yt_nOiPk42nan4684o4Kgg5teeBdQ4gfNJUFtdw>
    <xmx:k1kHZ-UF6wdf3CsVMD8tjbCGdZicfR2d7y3I69kMavPYGpnbqEdGoJnS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 00:35:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff0bce14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 04:34:23 +0000 (UTC)
Date: Thu, 10 Oct 2024 06:35:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Naomi Ibe <naomi.ibeh69@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy] Indication Of Interest To Intern At Git
Message-ID: <ZwdZhRAyT3fhyIRJ@pks.im>
References: <CACS=G2yH+k801G0z4BO6T2Gc2c6vVDieSr=2B6kT_1P-j0smZw@mail.gmail.com>
 <CAF+8dM9k=z+KR6xd_1jhsM86e=BOwOKkxdJDbX2VUYeu8yMkdA@mail.gmail.com>
 <CACS=G2w_rUUntaCU2NXYODUNfh+kDRPiftCRg04TPapTM_KPSg@mail.gmail.com>
 <ZwY3ZtHPBWWHU3wP@pks.im>
 <CACS=G2yNRA0FxTMgRS8a0VYE2PtuHmgR6mo8vDVZdcEAgBqEvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACS=G2yNRA0FxTMgRS8a0VYE2PtuHmgR6mo8vDVZdcEAgBqEvQ@mail.gmail.com>

On Wed, Oct 09, 2024 at 05:33:13PM -0700, Naomi Ibe wrote:
> Thank you very much. I have decided to work on "Modernize a test
> script" and I would like to work on modernizing some section of any of
> the 3 files below if this is accepted as a valid microproject.

One note up front: we do not top-post on this mailing list. Replies to
emails are supposed to go below the quoted text, or should be mixed
below specific quotes you want to reply to.

Also, you don't need approval to pick on a microproject. It is totally
fine to just pick something you think can be converted, double check
whether some other applicant is working on it already by searching
through recent mails on the mailing list, and then start working on it.

> 1) https://github.com/git/git/blob/master/t/lib-read-tree.sh
> 2) https://github.com/git/git/blob/master/t/t9112-git-svn-md5less-file.sh
> 3) https://github.com/git/git/blob/master/t/t9113-git-svn-dcommit-new-file.sh

I couldn't really see anything that would need to be done for (1) and
(3), both of them look mostly fine to me. But (2) certainly looks like a
good candidate to me for modernization.

Thanks!

Patrick
