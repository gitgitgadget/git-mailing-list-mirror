Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825FD1876
	for <git@vger.kernel.org>; Mon, 26 May 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241249; cv=none; b=EymPzSH0xnQ8jyiai0wfmpL+MD1Z1YdhABPynLdGGZz+6vMLp0qvUIbpYAkYHm+d9jUkdmHPU82QMX9q39IG3dQGFwyHSWh8g3iwr6Qp0xdAINa6ao5mb8uF+FEGlfGCY+RU6jWya+2lOlQi10mSG8F7yqAaqGMJRcPMuptiea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241249; c=relaxed/simple;
	bh=QHtyvWo5nGHvzKPRBLg+jte5SsoO02MFHER3IIulNow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC/008YSboqxUCvWKgvrYXJ+K4HXZxbMg/MlT+/DRYd8bbtjQE/wpohTvxo2KXGhmTv67En+XpYBKccBb0vbcwHlEcSQ2HgKzeMlNQpw0fw82XSdbutXdBCQW5YyVMs9ip8s5qcxFM2978+7vGtYgIb0hg3vYRC2K5rwaib43Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JoYtGhXL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrnTHpR/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JoYtGhXL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrnTHpR/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9204D138043D;
	Mon, 26 May 2025 02:34:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 May 2025 02:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748241246; x=1748327646; bh=k9Q4hfNhF8
	bpnLla2nhF/74O+zPovK3FAxpVyCq6/6U=; b=JoYtGhXLRxSWICsXxoH4O4TJXr
	gJWAMEs98tjDrocnlDBjJ1u5p3NpEKN8FTHmzPWVMWnmbakWC9S9yherlcNfO4Fa
	FwDxQpV4WY/rnCgufxWRS6VHimDA39PkmvJPYIHLrKh4b8AWWLdxy/ZncbBRD3Sy
	W5EQCiBBswWvDQYUVRuYhCzB+uDT3Zo7LfzmMjwJ8QyNd4/tzsUtFNcWUmf3Zoh/
	2QJ6sFGfiFNcLNh8AcsXvfrDoQRYmZpz7fu00TV0xg+LLlpNR7xRv8CZ+aL9gvtM
	m5XvTRfYtDPb9BiLeRW3Iv+2FSgLasOBFP+Um7XJgO0BEKj9fbneRffuRHFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748241246; x=1748327646; bh=k9Q4hfNhF8bpnLla2nhF/74O+zPovK3FAxp
	VyCq6/6U=; b=TrnTHpR/tMeUplCCzA4cfzHklHtFvakBtVp/IKHuYl63Ngm1EQ4
	Ngz/e7bgobTBoaxWXdbFogHtd58/UYzmJWpq7i2+yE0SJA87jpkDL141B+mgY/ld
	peypyEh6kHYWVyc+wJhn7iJ/fJ+QrirX5j4gLDUs3ww+JLPKDKfkubohEQO3072t
	4b674yE10idk+n3lq02XTez39RB7ejs5Ll2JLNkRSeYXxRzDocbzCKEp1Vg6x+hP
	/0lFy20E3lO5/Qkf8idA/b8yFynQXYOAfv65PhQSFd8G0Apcu2vHSOd+FJFJcIFb
	5BwaXEGpFq8JFlaexcS9CD/tt/sfVp6eC7Q==
X-ME-Sender: <xms:Xgs0aDqhDuiEy5q7iDbMcG2L9j-XBSRoAzdqzFJ30f6GaYaPQ2KlBA>
    <xme:Xgs0aNrdgij27gblhusV_gpnVjrnDfzKMFTF6sF9wInqMTKlQ8f04MbTUaa0kSH9w
    Mi6ip0j4hlm778Lqw>
X-ME-Received: <xmr:Xgs0aAOqYluoI2MGBW0CE7WR8zbYn0Fm6W8YitVoucTZIGaOAJPdHTGJwXsarsLUhIzvqmHR_kjvw7vXITats71dMWcFsGj49OylXgX7jXIpBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieekvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhhedtvdfhveelvdel
    fefhveefgeeugeehffeiueffgeeigeetheehudeffeeigfenucffohhmrghinhepnhhoth
    drlhhotggrlhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Xgs0aG6BaCd4xo5t7qCvhxiRsh0rqp4JfXYNjMPM37p0F9ChaXikGQ>
    <xmx:Xgs0aC60c53TLaakw8tcnHFAb3QrxDMnl1RrCs9ucWl6HbNIbhYo1g>
    <xmx:Xgs0aOinc30p5kwNy_fA2B7Rm-tajzWaO109E1NPLbmrrtx9QjTm2A>
    <xmx:Xgs0aE5_lr_ZBFHwFDIXHR_WAnxfnATks16clgIfK1ZePjKGLC_FZA>
    <xmx:Xgs0aG7oDgNCTY_PI2nzumbCXFl4L0cOSZvGHz07Qq7pyVDZ5tzPG0QS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 02:34:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92fcab09 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 06:34:04 +0000 (UTC)
Date: Mon, 26 May 2025 08:34:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
Message-ID: <aDQLWkSKKO5gWbUr@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-5-ben.knoble+github@gmail.com>
 <aC2OaeLYJQAOE_S1@pks.im>
 <01301fa6-eea7-427d-a61f-5cb8dac99afd@gmail.com>
 <aC3SZtwQSt0mSVuo@pks.im>
 <2a8221bf-5edb-449b-a4c9-3754350466d4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8221bf-5edb-449b-a4c9-3754350466d4@gmail.com>

On Wed, May 21, 2025 at 04:27:48PM +0100, Phillip Wood wrote:
> On 21/05/2025 14:17, Patrick Steinhardt wrote:
> > On Wed, May 21, 2025 at 02:07:25PM +0100, Phillip Wood wrote:
> > > 
> > > But don't we still need to change PATH so that hooks, shell aliases, git
> > > rebase --exec, git bisect run, etc. still run the same git executable that
> > > started them? For example "/usr/bin/git -c alias.g=!git g --version" should
> > > report the version of /usr/bin/git, not ~/.local/bin/git which comes first
> > > in my PATH if git doesn't change it.
> > 
> > There's two parts to this: PATH and GIT_EXEC_PATH. We do have to adjust
> > PATH indeed to contain the location of the 'git' executable. But we also
> > add GIT_EXEC_PATH to it, which I'm less sure whether it's actually
> > needed.
> 
> If we were to add /usr/bin to beginning of PATH when the user runs
> /usr/bin/git I think that would be more surprising than adding GIT_EXEC_PATH
> which is what we do now. When we add GIT_EXEC_PATH to the beginning of PATH
> we only affect the lookup of git's programs. If instead we added /usr/bin to
> the beginning that would affect the lookup of many unrelated programs.

That's a valid point indeed.

Patrick
