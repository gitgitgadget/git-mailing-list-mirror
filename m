Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFE63CF
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284726; cv=none; b=smSHWmKPkJu59kN5GiI2lOYMyRKwi2xOwW2L0N+tNS+cz/eS3xyCGJZaLVN2HNWZskzM9Z9Sq//93KkneiwUrQN2GaiZXLfwmLaFdG8h4NB518wlNwBAMlrU3YG09KyreHynYyUaT2WLHgI5XULTBE9Rkxa9BtM0cYeRp9VoInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284726; c=relaxed/simple;
	bh=9wC6UkazV4Z+rrUJJ/Nn16clcPUytdb8Zn8wRry/GFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crtGB51qm51f+dsn5rmgyMg8WMkgD8jKxvR014g0O3i6YfRQU1RTLx2jjL3wBD5030OYxp9u5CfgTwC0a3r5DxOfmzqizkZuQr2T1BuZODdWgELPlA8t09+Z/hA1OruuedzO0KqgPFx/u6M05MJSMIFCy1m4EHUpnTvIOxQeQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aGs/fSZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1ke2VjF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aGs/fSZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1ke2VjF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 994997A0062;
	Fri, 24 Oct 2025 01:45:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 01:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761284723; x=1761371123; bh=VRkqABvPI1
	UQQn+43UOZD9deRJ5E1U3BhLeue62Rza4=; b=aGs/fSZ157yllPFPmQL+js6Kcu
	Y9ESY1OzAArJyHMtZZfiuFI/Ld6qv0rRPZ2iOG4L8lo42lhe30wsB2/CJunSsRGQ
	/R+8y7VqoK0/y/+lqTW5FoZFY517bT5gD5VgMmAUoqVlpUXEZGeKnyoJiSjy8UZp
	JdXJRb5e3x44cSixSbSori/W0dia54T0nZSpZo90xjdofghThFZ/cMk1hb5pXYbR
	m6b66w8KJ5FmLvbtOa4bCkgoRQzKyQP6W6ddvo8C0egCTEW+n6ZvewaiK/B9ivbX
	EX0Es8cGf2vV4YazhrnRsS6A8vK4v31JUaBbV7lp9uAou6+236Jow/QC02Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761284723; x=1761371123; bh=VRkqABvPI1UQQn+43UOZD9deRJ5E1U3BhLe
	ue62Rza4=; b=E1ke2VjFHjPZ68Sp3BIadRBoUrWfoJcY2S9yTdi/6dWFznh9r3F
	4z/Xy/BMRVJ9rPXBIc8sU6MICNj7pTqp+/YZG7Xplj9N1oqXRdii5LgK1DBglJF8
	rxK7LokcIq7mzLY57Ps3wCKCRHVrWCzHxr/Zjj1bMGQV0FIwHP6jl2SR6CumEvNa
	LVM0p9yP1f9SENeoxL+qem6h7alxh7/ahxTlNAxEWat/aqodrq7lAzHk12wXvZAC
	hBmI8rEYBv0u+0Uc94VnjOycWGbh8uS/CIq/nZLRQZdhwfP8vtjkpeWXmAMzLSV+
	96JlcMCfdZDKQjINMsaeBFVkjoRwrKIjtLA==
X-ME-Sender: <xms:cxL7aC9HQAelE9eQ5CVDg1YkWYceVKHK7w-oGcg0VpmW3XmgOM0nrA>
    <xme:cxL7aKKAeOlCo0DLlimi1GZ2vVic99_BQaG6t5_4yRftJRY5Y6-Z8MNwmSEc3cd1i
    F85UjSlSQfDCRhsY6mdLMHrsrISbUXGZBlYPg8jORhCJtMeA7wTNg>
X-ME-Received: <xmr:cxL7aFZZtvHavzyFeUDfx1rTezs-ps15wqixhjlaKrdNwc3_OQHH3TSBFMmujjwL8w3eNlepA1S_8d2ZCR5HBAvwj5llHDohLxwWZLRubg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:cxL7aELR-ZZwOkomW_Ub0j28-T3XR_Vs8hVj08H6rkZx59e2NRYgtA>
    <xmx:cxL7aLDgmElfCkafD0i8ofmFvgxTmZdPd2FYs_sPuv2erKLfb7q3nA>
    <xmx:cxL7aBpMx3wlaLew-WutVsVWK_fHINCKcXd2t1PG1P1sDPOKI6T7qw>
    <xmx:cxL7aOjMBVEZf7m5C3Bc8DdcHnryw1M-W5E8yzHxWHrwQMRccEaxjA>
    <xmx:cxL7aEkqvnRy4khhYlPwYpVgFL7w2e2OhSzCTRZaEV-LDI5SareNz6qD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 01:45:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df7586c6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 05:45:21 +0000 (UTC)
Date: Fri, 24 Oct 2025 07:45:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/9] builtin/maintenance: make the geometric factor
 configurable
Message-ID: <aPsSbt0pK4sbmVQj@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-4-f0d727832b80@pks.im>
 <aPqDG+f9ZL4Oc1Ar@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPqDG+f9ZL4Oc1Ar@nand.local>

On Thu, Oct 23, 2025 at 03:33:47PM -0400, Taylor Blau wrote:
> On Tue, Oct 21, 2025 at 04:13:26PM +0200, Patrick Steinhardt wrote:
> > The geometric repacking task uses a factor of two for its geometric
> > sequence, meaning that each next pack must contain at least twice as
> > many objects as the next-smaller one. In some cases it may be helpful to
> > configure this factor though to reduce the number of packfile merges
> > even further, e.g. in very big repositories. But while git-repack(1)
> > itself supports doing this, the maintenance task does not give us a way
> > to tune it.
> >
> > Introduce a new "maintenance.geometric-repack.splitFactor" configuration
> > to plug this gap.
> 
> Interesting, this wasn't exactly what I had in my mind when reading the
> last round, but I think this is worth doing on its own. My apologies for
> being ambiguous in my earlier message :-s.
> 
> I was suggesting that we have a repack.geometricFactor configuration
> variable that defaulted to two, could be overridden by --geometric=<n>,
> such that we could start doing "git repack --geometric" without having
> to write "=2" every time.
> 
> I think that that is probably still a useful thing to do in and of
> itself, but this change doesn't preclude our ability to do that, since
> it just overwrites what we pass in to 'git repack' when calling it from
> within the maintenance context.

Yeah, I understood that suggestion, but I still think that in the
context of this series here it makes more sense to piggy back onto
git-maintenance(1) itself so that we're in line with the other tasks
that we have. All of them are configurable via "maintenance.*.foobar"
knobs, so I wanted to have the same architecture for the geometric task,
as well.

But as you say, this doesn't mean that we cannot introduce a config for
git-repack(1) at a later point in time, and I also believe that this may
be a useful addition indeed. I guess the order of precedence would be
that "repack.geometricFactor" is overridden by
"maintenance.geometric-repack.splitFactor", as the latter is more
specific.

Thanks!

Patrick
