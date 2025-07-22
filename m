Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DC7F9
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194262; cv=none; b=sZfmjv8XVgI5kvu0Mfd9NJndTn6xZ128+RG3zwggSPdoz5e9/A9VDHbtiF+ZYcxK/JJSdDAYchfQTH2qoNn2T0MYxPdtiNoJzAhDOq993qgELxCYjz4h9du3VSc6iSTcETS2ZPZoArZw5w84l0MC2o7baI/2Cs3zqa677GtuZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194262; c=relaxed/simple;
	bh=v84XbCX0Ft6f8+WIPuWL+wj7yAYPjyy0EcE7W6fANQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6+cRtTeE9DiL+T+H87yEMEnn9ldUdqfr8TwptnHlzu7M1pclDJjCq89/pcEloj6NOsAhNFXhNSuEHFocrcF9Zy8n+yI+WV6WQCaTnhmuc7FxRocdn/0/S3HdYOyPmVWMwFx3970BbQVQv/rOvTHx9xRA7sFalI5zoNRvA7uSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vBtLM7WV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=goeAU6mE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vBtLM7WV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="goeAU6mE"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C8281400157;
	Tue, 22 Jul 2025 10:24:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Jul 2025 10:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753194258; x=1753280658; bh=L39e54GVcl
	D/Tk2piMaNM0uAzjUFIugNUlLrb5wG3DY=; b=vBtLM7WVHY/FYOS5+0i17kkM9V
	DUxMKX1OmcfLfsexOf2amcyLiHhSFN4qOjSbU+HCJMxCBomrFMkRcP3E0Q7wzL1+
	XOHpScg611Z5n3xAhznOwvDvILKRmeIZfJb1S4zcaB5MStRMFK4w0PNLrjkLh8zC
	jb3hmDf5Mbxyo+WSflO+zTpaVhAjlyZ+FM50sZEQTLgqocvdkDYS23a5Eiqik8F7
	CIFZSuBtNCu/1J5tr+1WczjIKrWECbpxNbDvkX8aHNz4u2ZTSE7tOo6Vx9n1WigX
	uM36WjP2O/RhPiWRSNzWJMPvp0WWvhvgIqprTaU+fBCM6DRxCZ7op+9m8NSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753194258; x=1753280658; bh=L39e54GVclD/Tk2piMaNM0uAzjUFIugNUlL
	rb5wG3DY=; b=goeAU6mELf2lDC8dIdnqvxhococRm2aboGk2Je+dIWuGdUt5k37
	Uz+JxDCfcKJldt8rrjtwh25eWCNLiOOgPqz1kV9054dz+Q8K/K4/FVVf/d7k6Ddy
	aCZqP24eAoFfbHUVLrPxCXqZpGRvPSgPnSn0PisM5pIDXVQo5VGyORZuo8O9Juar
	RASE1/8X1QlWpXOl7pZgU+Vfbhy2viaJ2qtmYP/KuEQE9OqrH6MqM8yDAFoeDCaj
	vu1oIfsCOPpFDozVfS/CJIy+8paddM/yxtHW/581dvT33k2RRl6oom5RO3f0IFdP
	moG4tW7mbL0HTMvLSIA70U0zLI1sOvWvt/g==
X-ME-Sender: <xms:Ep9_aH5RRg0X8VdH3oZwvZt9pY-I5uSZsjNV06A_MEEgwsvaAgqmGw>
    <xme:Ep9_aJy7bb-NtTEIOcbC-ZJBl5MCmAPJF_UFpeLXPmChvmh8I-C5WGKVGFOLMQhav
    twRYD9IlX65Sl6g4Q>
X-ME-Received: <xmr:Ep9_aOO-o2G-CeELSqUbYWCKEeN0cl10mot49v1Bj9aUMiK4Wwe56AbQAvBZ311Sgrsj2yxNb5IcI2xGj0HFwYKOjvPLmA1vDyBJsCez9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Ep9_aHlo_ATLDeO7-HY_hSvfyH1UsqMjNe_mm1U0o6oOhMaNDcmWIQ>
    <xmx:Ep9_aLTngjSpH21mjPsuJjxNdkMNz6gfy_4gP181GNG9yhPNhf9DXg>
    <xmx:Ep9_aOVb33JZwVDgSXQoo4m-DCCxaw_ShcoGVHoidZ2c7Np3SANbhQ>
    <xmx:Ep9_aHLFkVpKzKqGteUs0qrFgkdjDrspOtbbkvC4oHUuvl7hTm7P8w>
    <xmx:Ep9_aP_vLnbIN8VZ_uWXI0PdCE-wMXKnn1XVRda6bxkxZyZRz71nCb9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 10:24:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c999ac77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Jul 2025 14:24:15 +0000 (UTC)
Date: Tue, 22 Jul 2025 16:24:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Edward Thomson <ethomson@edwardthomson.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aH-fDEX7gdpALJ6w@pks.im>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
 <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>

On Fri, Jul 18, 2025 at 05:25:01PM -0400, Eli Schwartz wrote:
> On 7/18/25 9:34 AM, Phillip Wood wrote:
> > Hi Ezekiel
> > 
> > Thanks for working on this
> > 
> > On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> >
> >> So...
> >>
> >> This obviously raises the question of whether we are ready to accept a
> >> hard
> >> dependency on Rust. Previous discussions on the mailing list and at Git
> >> Merge 2024 have not answered that question. If not now, will we be
> >> willing
> >> to accept such a hard dependency later? And what route do we want to
> >> take to
> >> get there?
> > 
> > As far as git goes I think introducing a hard dependency on rust is
> > fine. It is widely supported, the only issue I'm aware of is the lack of
> > support on NonStop and I don't think it is reasonable for such a
> > minority platform to hold the rest of the project to ransom. There is a
> > question about the other users of the xdiff code though. libgit2 carries
> > a copy as do other projects like neovim. I've cc'd the libgit2
> > maintainer and posted a link to this thread in neovim github [1]
> 
> 
> A hard dependency on rust for Gentoo amd64 would potentially require
> building https://github.com/thepowersgang/mrustc followed by building 13
> and counting versions of rustc in order to get to the latest version.
> What is the minimum supported version in this series, by the way?
> 
> bin packages for rust do exist but not everyone wants to use non-distro
> provided binaries, sometimes for auditability reasons.
> 
> 
> For Gentoo HPPA, Alpha, m68k it will simply mean the removal (or end of
> life and staying forever on 2.50, perhaps) of Git. There is no rust
> compiler there.
> 
> Even s390 support for rust is limited to a precompiled version not
> everyone is willing to use.
> 
> GCC-rs will probably fix this general issue.

Hm. It would be nice to assemble a list of common or semi-common
distributions that do not have proper support for Rust for all or at
least some platforms. Should we maybe consider reaching out to other
distros (e.g. Debian, Fedora, BSDs) before we commit to any change that
has an outsized impact on the larger ecosystem?

I would really love to start adopting Rust, and if it's only going to be
architectures that are extremely niche I'm probably fine with that. But
if there are many small systems that are impacted by such a change we
might have to reconsider.

Meh :/

Patrick
