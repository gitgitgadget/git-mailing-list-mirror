Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB6222568
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892755; cv=none; b=LaeBlv2nyD3VCyvG8GnB0lEkTiQo+y7W0Lt3X5vZ+IqdyXUb74+VHhpaWoQH5alYgn6AMBT8jQlYBhjZAk9Hc2Zsl1uWTC/S5X7v1lX6AkukzE2ugMOBZPAAfDNFgeg1JHk9y7EugU4u/bWD9MDbgHckeaX8c0vl1hxnuC/vol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892755; c=relaxed/simple;
	bh=Bddpu1/etI/o+8O5Hh/4bQF/J/ofirlSl3W9nGL3t8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnU15LToIpMUWaGSpnvyn5rrLfc/zU/ibdwR/DosHImlTFvkI+KlTlbrxRBd9xpsL5KG9eV8lqUXTjALVf9QyWd6lqKSZ5RiGd1msmcEb/ZUsELeN6Jj7K5/CKE7bKuwR4MS1txEpPdlspcX83juByY+12Hwp/ho814WVE3aGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lAZPGaZn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiF0BVJj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lAZPGaZn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiF0BVJj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6DF01400183;
	Fri, 31 Oct 2025 02:39:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 02:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761892752; x=1761979152; bh=Tb63FEL5Gx
	bU6YL20XT5XlsdOrgGOMcrGrOKsxMzPmU=; b=lAZPGaZnA4CjU18FELode/KKCi
	4qywzfJNYc8F/5IMXtiXlyiJQPR9O+YLR4R7tHCL+qSuol1ryqzWoA0bbwqgssoA
	uXwVzRReMonJjxdA35Ru5865vFQBz2q3VQhQvc4YWJuJvrPn4W7FiwP3Rxlmkr3h
	GCsGg7S/iGR9uOjLrcoPB5Kby7kOdpD4nc4u/GOolLxG1tHzeohddftFVKOkdyzg
	JNzqyxHyOvMmnlkOWPVtB0WfW/19E/hbKufOS3q3FWatEvGerYF40lmzfV00LSsT
	bVJQn1jkZsaWuGEujgs5fiaJ04l4+caEehbx0+E8c99ZcK241Q4L/+NniU2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761892752; x=1761979152; bh=Tb63FEL5GxbU6YL20XT5XlsdOrgGOMcrGrO
	KsxMzPmU=; b=DiF0BVJj5gVug5DlGwJ7tBS08WZsF2ifmh/VtDbi8uMrGA7RdY4
	vDVCR+tKFb8/37fAJBOvhIO4rwRToJaygvdJQ3uYxlt89fJDdebInXXTAXOCbhfX
	x7lQ7Q0txc/FdDZ+IOey0CKavC9eR1f+tgM/Fa5iVk2jw2fjBwFi6BAM3Q3c2tBa
	qOQWsa5Ndx75vmuut8qvlIMk41HZr2NSKLjFxRKqZ54bi43MUOh8/MRFayRqoEA8
	wUUX3OlD5S+WT/O4ElvFsGSoetUPERbbgs1cjE3eJ02AOxrQBCZYrds58XzSZ/U6
	amLv2lezWATESd6auCUvA8PXKzZZ5zK8KoQ==
X-ME-Sender: <xms:kFkEad0ObviVttlEga-7slMyxi9h8-r7kzixoZdJMMUbakR2HWd9hg>
    <xme:kFkEabjZxLOo5BMmLNXq7j5LwaNDJF5Pf6SHK0ymwcYZ2XCngFwcehVFHqhAkmB_K
    QXSYnhPP5XvnCRv6UJsefT8hVerOSARfOUWW3FfrpcRkQBK6BH3MfU>
X-ME-Received: <xmr:kFkEabQLiuAolY6NVZleqpcWb5yub_ukeOE_xy_00S5WtOwTD07UEaLwsi4MB22erlitGLPNuLgJ6XOOkAhffIFCYkRri4YSs3jd9iqAtuyDYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehrvddttdelkeduuddufees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:kFkEaUg3BWwfasSjyg8n_8vS5Ci-PD8cGpPfL4RPgRln_Io7vGxSIA>
    <xmx:kFkEaT61pH48Qn1VQ7x10UIA0ZTVWtXyBYEHJGFrl3NQxpV1UVUu1A>
    <xmx:kFkEaZBgsMpAwupTKHE3rIBTRJZTywCsp_lNZJaHlgRDj2ed5wep9A>
    <xmx:kFkEaSaHbRYcFk8iRxeZlfTcZkRJCdbCvsJ3m_vqoow9SBdH8vozMg>
    <xmx:kFkEaX-NuaurPUjVpDZI1eGTuotcjCFGqTiuP9JCuc4_q5elF-YyQRHL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:39:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d48d4a56 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:39:10 +0000 (UTC)
Date: Fri, 31 Oct 2025 07:39:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Xinyu Ruan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Xinyu Ruan <r200981113@gmail.com>
Subject: Re: [PATCH] refs: add missing optimize implementation for debug ref
 backend
Message-ID: <aQRZizsobXECzvJI@pks.im>
References: <pull.2090.git.git.1761881859881.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2090.git.git.1761881859881.gitgitgadget@gmail.com>

On Fri, Oct 31, 2025 at 03:37:39AM +0000, Xinyu Ruan via GitGitGadget wrote:
> From: Xinyu Ruan <r200981113@gmail.com>
> 
> The debug ref backend (refs_be_debug) was missing the optimize
> function pointer, which caused a segmentation fault when running
> 'GIT_TRACE_REFS=1 git pack-refs --all' command.

Thanks for sending the patch! As far as I can see though it's redundant
with Karthik's patch series that is currently cooking in 'seen' [1]. So
once that's merged down we should be good.

Patrick

[1]: <20251020-refs-code-cleanup-v2-1-f5349ed0f6a5@gmail.com>
