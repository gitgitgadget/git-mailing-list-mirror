Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C151FCCF5
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111780; cv=none; b=XGpM8DiMvZlJJ320oR6B5/niEhtcoDNfHKlhlCrupERw1ErdAwtt2CIaNw7/EujPhxvjyXHEvOssVbCQS0WD3T4VKypG2E9xNpkig1zcWw8seHUt604TJT6wZ3sFAPPknPqBV4dztPttF7RACF4kiPeaZJ60DHF74r0Iw0aYl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111780; c=relaxed/simple;
	bh=q7vZ6S4pls/T1HLMUox4MFlRb2Rx1gnk2TOt40cMc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPTpTOVrEwyNuxNV10AR7tI63FB9xNdubw93J/whAbaOky+nZ/JNHM0x7k4CkrRxhWIs9DqihJup2Rw24woMyCp3fEmjWBQ+NErxVCXxw9PyoWgu9ES/SPz/WVJ09llH+ZFYVMlOdZn5e8/DUvMioMkFgBFxIodJwQ0M6HxxJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n8akdKTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3qoauJI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n8akdKTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3qoauJI"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8629114015D;
	Fri, 17 Jan 2025 06:02:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 06:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737111777; x=1737198177; bh=fK9JtrH5a8
	Y/RP/WcI5Rhn2ravdPhVGEC2U0ZJtGN1Q=; b=n8akdKTPbA11NCx9bbHv5fYBYt
	zQCh6SZAzDFMTkoV7yfvVK9hFh3RTHmqki+vP2sv9zYx5EIbpeyQfzWGbJH2Z+cc
	KWezLIgg+uFuuAFfQ4oLNmIsjJ9cyTIDx2QnXs9rhKALaViR0gugyB9H1zgU2gAF
	esJB7+zUft6KcweHJpE6GMmrXCtHtvlzG47JESCdZfgY2cOAQtbLBInEZbhFFwtr
	LmkYtiwwD5//LdhNHWX8W42gTqbC6eJ4Us4V9EhQfhxmfTzlohNKWidc2+TbSuQp
	zqXDM2sTe91E6EgHN85mpajILBlVlwVfY0dbP/D6fY59nt0kUTgZRNFA9Oqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737111777; x=1737198177; bh=fK9JtrH5a8Y/RP/WcI5Rhn2ravdPhVGEC2U
	0ZJtGN1Q=; b=J3qoauJIqcf6j8Owt3M4fKYnQd17VdSzAfp6m1i4hR5ukCXvAZ/
	ojoB5qV7S6+WVB7GamHy1r/nPHc08CZzbqnRc3RKAZSF3Uzd5K9Rc+Ny0QOkDQXp
	BF4e5A7w9vy/KgtVGdP5S3h9zK6Zslme0cJ37ciwJNWh8D17a9nwOxPwkA+4Qqyx
	S2WLosxdGwWDJ58aK7q/DWoO2T6c1L9FzEogdiCJJwm6vINk0Qxdefg+qpLAzNLm
	WcP+Vq9Sf9RVHsyIKBIm4WIBmFPpx4gLt0YnF5HJA3r25sIS4Dh6/lUSx85WeJ2+
	K/w9n4cObLhlSMJdPuzZK5+YWh1wr8+4qtw==
X-ME-Sender: <xms:4TiKZyF2QSp4kgi9EB2ytAc7FY7du74BOqz8Tk2VIY13H60x0as4ew>
    <xme:4TiKZzUOY5q89GLjvTNhTCT44U9N6i1w2QICwLpIysMomKxh_K9SrZM7DRlMiOzj6
    tHOTukqlMy4IvbCAg>
X-ME-Received: <xmr:4TiKZ8ICLcGUkYwdP6b4kiU1DaaGY3P6kyqOkJvB4O02SEga-uTl6Oxaejc0qwOoXIh5qziGIypxdgzGgT-WM9bZpO8bGTo6BOCPA0d9aFRV7ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4TiKZ8HkX7xfRtNq4t1iMo2Fb2ycRxmSQUg5qQo-DCLYEt0hy530aQ>
    <xmx:4TiKZ4WQidh14kbOHFR84KP9hfGs2hUNUlyfpTMWLDlGLzl1ie0nzQ>
    <xmx:4TiKZ_Oi7NtgiQDUvMc2NFZiif8JJzzxYxjSeXTqaRoqMW_CheSYlA>
    <xmx:4TiKZ_1EyaKaokwYeMv0foWNxxBFxjQPMwZrDb4UaG_JiZZ5FxXm8A>
    <xmx:4TiKZ_RTfbL2fvnBPRY4wC64meAwbC18n_mosSZz02CaLiSbhUSdcoMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 06:02:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91dac6c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 11:02:53 +0000 (UTC)
Date: Fri, 17 Jan 2025 12:02:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 00/10] compat/zlib: allow use of zlib-ng as backend
Message-ID: <Z4o43deLB0-Kcxid@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
 <CAOLa=ZSfhDHd65D3d6pxbG0HqMPobfdj8fRhLogANyJ_karz0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSfhDHd65D3d6pxbG0HqMPobfdj8fRhLogANyJ_karz0w@mail.gmail.com>

On Fri, Jan 17, 2025 at 10:06:48AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >  9:  45fde7a7dd !  9:  6fefd3ab44 ci: switch linux-musl to use Meson
> >     @@ Commit message
> >          is the `GIT_TEST_UTF8_LOCALE` variable used in tests. Wire up a build
> >          option for it, which we set via a new "MESONFLAGS" environment variable.
> >
> >     +    Note that we also drop the CC variable, which is set to "gcc". We
> >     +    already default to GCC when CC is unset in "ci/lib.sh", so this is not
> >     +    needed.
> >     +
> >          Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >
> >       ## .github/workflows/main.yml ##
> >     @@ ci/lib.sh: linux32)
> >
> >       ## ci/run-build-and-tests.sh ##
> >      @@ ci/run-build-and-tests.sh: case "$jobname" in
> >     - 	group "Configure" meson setup build . \
> >     + 		--fatal-meson-warnings \
> >       		--warnlevel 2 --werror \
> >       		--wrap-mode nofallback \
> >      -		-Dfuzzers=true
> >
> 
> why remove the group here? The rest of the range-diff looks good.

I don't, it just fell out of the diff context and thus isn't seen
anymore :) The line still exists.

Patrick
