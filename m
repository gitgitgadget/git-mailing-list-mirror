Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B1375F9C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073758; cv=none; b=j6Ym2y11Im21bLBLvn/iF1xZCoboh4MWKFmMUYObLcOZpEb9RdN6x9LmxR74fo/7lOBouKofbhUXn6r/8S+oKFG/drkj5hb1aOW/LsXj8AsFlDJQwGqHtrqpX8/MySvqe4Yb6AcEM5CoGoDuF55xWpeCK/quDXDyeDDQVnNHML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073758; c=relaxed/simple;
	bh=hLrUZZYJkORMTo4H6nAEL7Jd3eM8Rt/HQMMIqjJkJAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpg1LrmD6gPPns1LpQAV0P1M9KocHzhyRe4Y9Akj9k/nSuh9F5vuKCtOdqfFs6TTD4qU9DQqGWWzK213SpZA+ZVujMK96P0dpxxX73v30mz1QXTztN+9YDIcxG+dPvpS/aNQH8N+NqxZaA/WUEafjFuWkQfi0M3Zk4U0y9qPZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ozpef+RT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWZ7XXcf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ozpef+RT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWZ7XXcf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FF507A0062;
	Wed, 10 Jun 2026 02:42:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 02:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781073755; x=1781160155; bh=hLrUZZYJkO
	RMTo4H6nAEL7Jd3eM8Rt/HQMMIqjJkJAA=; b=ozpef+RTjZCc30navQbdNQODlb
	YG0GViHlSW2+Uy1u55srtELEvYmhzrLARs4sN5CwXzc8WSnc8YSGliCUBYT6cvSR
	rU+xnXqao+c66XGNnZNCWbE/2xXwkrc+/sAxi0BbJSe0QB2Mb3N4Ob0N8MHqw4LD
	Q2qdvSheEodedQ2R9DDT9h2YxhsIzphtttjEsr9BccAj0Yx40VgJpKN57BiHHNGs
	k7fMd4222LHaP2/GQmjxt0d9kmnBxQxqdWnvgN1XcbrMnu0ISG0zCog3WiRF6SSn
	15SYdANHik+OcHeQ6vGH9wE0SLjzoYL2HOCCMLMhskUc4NBDtYnXdjL0HzOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781073755; x=1781160155; bh=hLrUZZYJkORMTo4H6nAEL7Jd3eM8Rt/HQMM
	IqjJkJAA=; b=BWZ7XXcfF8sAnAJ7W63yxTtNNCJyPHUG3izOhLyymqHrweqD52H
	c03w4LjDY9YiX5kfV4TPr26t+lAu9iW+I40BxDvHiajnP79hTb8DELjK3v+Jlz43
	PFFLIXXheIfFqOcOR7f8+ep26bmsGqK+pzPda7qkZx1ptS6TdIo5YBqVp3Zr0oln
	r5Us5seTxG8mxrElY4hl8lvT3QxmrBXDuspy6FyF/PwdFf72yReonJyrLm3t69Kp
	SV1xsScDH8vGpZw9HT7aOi7InNNZYU1LH3JBOet2XG4Xr8X2LafePjVUoH2zXCgz
	+Hnbt761VE+DHI/m0nFW+tLXKUTRKBXv42g==
X-ME-Sender: <xms:WgcpalRLEJyfV-yjactAcEjwlGodNF6gWRNLhCRVNxVNafCzA7DVhQ>
    <xme:Wgcpaoyo9tSumXBoFwPWGbX1iPySmMZrlOCqbNOZWoSj7XTEXAJb5GENmr9fYRMpR
    aFG-6ZveURUccPfQnqdViIFGbVBOHy0jRckixRpv4_K4TgIZs2pxA>
X-ME-Received: <xmr:Wgcpahcawjm7AbRR9cEa2lS0FYEJEAASDMlCEjZCSNoz98vMZVKLc1N64YEOZ_mW_lFAf5Je52QsWljlpyKP-U4b-bY0maBpxje-fdWFmA>
X-ME-Proxy-Cause: dmFkZTGBzm/nHaicOh6T0xtWNuPYTairh3YicM7cZZ4bKP9nzn/WNjrL1OEpcMlHvdGrjJ
    R2VKYgYX7AJSBAMMSnu8JqX8A6k6EQ6eL1KjtiW70VCmB24ZctrEEIBmuYDADeAtALUVD/
    7X/15tdSKwmq2dfBEA8SsNVnfIP3iyKl+8msbcEEUVqGFilcYvmFTu2m8o7jBojbSYoba8
    7BvfHAUA4+36F80R3ZBrBoTdrxhfmJy0QTTaslVbRzzYLgCwPbK4vnrzG/L6Auvo3Hd+n0
    m9RNWdo1H6eZdinmLCcwTFhz7ZICNAa+ofk0NzzpzzfBTWzrQ1NzVcMbfaxTPzgh9fpGD1
    TQ7v4rZSDOnbfnSrudQy+m8y8UI2P4L+RhREVvbHaU9iC9SNRqGSN+iHu51gWprZCDX2BL
    5mkrOngUT2bPDYmB8c26aRgIS4r9FER7dI/GQuJMp0VFweaXaF877qq0lcASUwhZppprOY
    8ql6WzFMG1LWGkJZNO96T3ueqRy30Xg3NpMk+Gv3KfYaYioSB8NEom4RXYjWQGBOlKIN5W
    M6qcVw1XQsZrCZcSngRB7NTTnKUG7Gyk3cNu9eWFUF2+rKbQ09lOzyXPTvG06IbY26UilM
    4o/mFvRh0O7IviPAFNQyl0tG43lEHX/SOs7V3ZfVgjmIKcJh30Rp9SFX6guQ
X-ME-Proxy: <xmx:WgcparPDAdvhN9Ab7moLbP6OFAJDK1ah_N_WgCcOBSpDcyOrVEzjqg>
    <xmx:Wgcpast1WvuX1b39CWJg_ZwUAp3H9Wx2sNBuo6rdqZRhAm3Ed_JaQw>
    <xmx:WgcpasBpMB-ONcd8JygVoVa0bBXE7EyHrHdusQGsoVC0dZt6lHm8vw>
    <xmx:WgcparZbvUo2k2NygfyBgMpiAr529om79M35Bo8jrjKxZ9Q3x6josA>
    <xmx:WwcpapPqXh5DZC2YgnkcB41NhnYwd62Av8fIXBmsxMaC5DFgxaeMpxmy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 02:42:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf12f685 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 06:42:32 +0000 (UTC)
Date: Wed, 10 Jun 2026 08:42:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/3] Documentation: recommend the use of b4
Message-ID: <aikHVTYVGw23E_Se@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
 <87a4t32a4g.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4t32a4g.fsf@emacs.iotcl.com>

On Tue, Jun 09, 2026 at 02:04:15PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> Now on the other hand, looking at a few examples I see GitGitGadget does
> deep nesting. Wouldn't it make sense to be consistent?

I've chatted with Dscho about this, and he mentioned that Stolee has
already opened [1]. So yes, if we agree to change the recommendation we
should also adapt GGG.

Patrick

[1]: https://github.com/gitgitgadget/gitgitgadget/issues/2254
