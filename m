Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A2D126C00
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205973; cv=none; b=SOn4p4TNYSdlkiYjN5x2nZ9S7wM3a5fYM0OmnehKvwmyH5FL6CxS1zRUu7tow8LxMoU3IkefEkuaay/Yq9DhMuxpIKmhzwXUgOEX0yIiquqhZLo0SpvUoSqGvyuO9wyBLSOAuBVUEmwlDQ4kP6un48KIOK0b8jsJCnjIQlVjUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205973; c=relaxed/simple;
	bh=8/jHJjX7Ta9OvcX/MRoTVueHQMOSXCyu11yE60jbsto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPzgVO3pQTicK+JAsI6hYKh8tlR/ZGvIPsVUorfY6hP0bc40QpI/AfypN2Ef91nhR2hhY3dM5lY5iKtLCESIGo4v+4uCz/kbGzud4vIFSPw7f+aOvtMf6e3snQLVs4uLQsSsTl4ICAcLM99ySWgEsUqiRBbkX9z0Y1GQjEbaQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HnmD/HX1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrTpcgKI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HnmD/HX1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrTpcgKI"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A32F138061A;
	Fri, 13 Sep 2024 01:39:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Sep 2024 01:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726205970; x=1726292370; bh=Jyw3efnDFx
	+288+BtF0fnt8W+ScB9G5pSSTsjpk0OE4=; b=HnmD/HX1xqWNrtIsc9qr8j8uRN
	6L9O2OFXYsD4BCjGfcbpQDw4f3bDmMlXyxQGRkuzjopNAuCqDMQbmwzKKkSq2ihv
	IXONWcqbokbrktiBp+pvPO+f5w6pSkeWfVPTOgX35ufLrEaFvfULrxSZ53c8Uun7
	p4m1c9aqg8GIKCCzb4YwbvYjs8RA/uk1MGUgatTUT8nrgupcX8LNjvfgBh9vtDux
	WR+wfl32Lt/fWyrQ5Av7hRLFd1u6y98RMVXRTZ18A5/GDgO8Z1DGoPAdwtxjY2Rv
	gXlnF+0yCPxtARBTWQClD1zA3adpeg9E43Cl/CyviC+dGze9mFyMCOk+P7oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726205970; x=1726292370; bh=Jyw3efnDFx+288+BtF0fnt8W+ScB
	9G5pSSTsjpk0OE4=; b=rrTpcgKIk5Et6ym4zy5q/noYQQFUa8cqnjrU23olGG3c
	MzhqzZDbB8XYyeXTp/Ea1S+pmoXBwdRR9YM00JYZ1gd+IV/bvUJr21aaRhv92cPf
	IZeu4GRZRr6cTVrjkBj2n0R0NEAPKDbBTl141cdVl+6izreHh8FgQ2SoeTNGDAXF
	Xj2D2HW7P51zFlGhNWeHZN5Ntr9Tph9Lgd0+kDRDAena8C5feq7NrFZrG2nRcE5V
	knQ1CUZ9VsPRet7JUVqZej0x971ibhF1/lnATwLe/bVPoW4gSPnfG8lfMx6AeG65
	OG18Wuxj834eaBkpyT6gb/DTrrFB+Q6mir+ZH6Ejdw==
X-ME-Sender: <xms:EtDjZm26SXV4DRdZXJ065TM6erozctcZJMnIwJSTKtO1xeYB8P0jQw>
    <xme:EtDjZpFqVNgvDKK65H7nwLsmRO1w5lZmau5NdlGeiukmM-GhHYrpLD-mFcWg-BO67
    szZ1Q6LlV83s7f_7A>
X-ME-Received: <xmr:EtDjZu79u-bckb6sZrFQZtvKhyC9C9rSZAcK0dDS0VO3bHmYPGwStcgE4XoWPRr2B7rtU0G6c1HJ83zM7pG4VkOomrlnZfr70Xp-N-1wpdzLBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffgeehgfegue
    etieeuudevtdejueekuefffeekudevvdelffeiveeiveejffetffenucffohhmrghinhep
    ghhithhlrggsrdgtohhmpdhhthhtphdvrdhsohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EtDjZn1eeuRUTNbhWYJQXcnkHtkYA0j6jT3YJesc4OFNaa08Vxo8cw>
    <xmx:EtDjZpFNfvYwZuRLCMXVKWbS7PTLZLCESaprZxYVeMaCt2xWIj8Ghw>
    <xmx:EtDjZg_pCS41Tw74Stgmry_VtFlobgLINBkKERyOFbjp83Ualwik1Q>
    <xmx:EtDjZulGDdBLBjR5sQF60lNvZnGNHv_J1hDYYAP7FZogTlHpxqInzA>
    <xmx:EtDjZpDB2vwG9xYRU_64BmRL0p-p4_la1Sc3MgHowDYZJqPMkVKPsfIs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 01:39:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b4b2bc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 05:39:17 +0000 (UTC)
Date: Fri, 13 Sep 2024 07:39:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <ZuPQBhgl0CRgxQ0g@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094730.GC589828@coredump.intra.peff.net>
 <ZuLFPxsDiMB9UBhF@pks.im>
 <20240912112242.GA622312@coredump.intra.peff.net>
 <ZuLWHBvrT31KVd9W@pks.im>
 <ZuLi4x664v8dbm2i@pks.im>
 <20240913045510.GA1194807@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913045510.GA1194807@coredump.intra.peff.net>

On Fri, Sep 13, 2024 at 12:55:10AM -0400, Jeff King wrote:
> On Thu, Sep 12, 2024 at 02:47:38PM +0200, Patrick Steinhardt wrote:
> 
> > On Thu, Sep 12, 2024 at 01:53:00PM +0200, Patrick Steinhardt wrote:
> > > On Thu, Sep 12, 2024 at 07:22:42AM -0400, Jeff King wrote:
> > > > On Thu, Sep 12, 2024 at 12:41:03PM +0200, Patrick Steinhardt wrote:
> > > And with that the [fixed] pipeline builds and executes our tests just
> > > fine. I didn't wait for tests to finish though.
> > > 
> > > Patrick
> > > 
> > > [here]: https://gitlab.com/gitlab-org/git/-/merge_requests/210
> > > [first]: https://gitlab.com/gitlab-org/git/-/jobs/7808775485
> > > [fixed]: https://gitlab.com/gitlab-org/git/-/jobs/7808836999
> > 
> > Most of the tests pass, except for t5559. Seems like it doesn't have
> > mod_http2. Maybe its Apache version is too old, or it needs to be
> > installed separately.
> 
> Yeah, according to "apt-file", there's no package which contains
> mod_http2.so. t5559 is supposed to notice that during webserver setup
> and just skip the script. Poking at it myself in a xenial container, I
> think it does do so correctly. So that's good.
> 
> But the CI environment switches GIT_TEST_HTTPD from "auto" to "true",
> turning a setup failure into an error. This is overall a good thing
> (since we'd notice if our apache setup breaks), but obviously is wrong
> here. Unfortunately we don't have a knob just for http2. So the best we
> can do is something like (might be whitespace-damaged, I just pasted it
> out of a container session):
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 51f8f59..0514f6a 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -336,7 +336,15 @@ ubuntu-*)
> 	fi
> 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
> 
> -	export GIT_TEST_HTTPD=true
> +	case "$distro" in
> +	ubuntu-16.04)
> +		# too old for http/2
> +		export GIT_TEST_HTTPD=auto
> +		;;
> +	*)
> +		export GIT_TEST_HTTPD=yes
> +		;;
> +	esac
> 
> 	# The Linux build installs the defined dependency versions below.
> 	# The OS X build installs much more recent versions, whichever
> 
> 
> That would still run the regular tests, and just turn the http2 failure
> into a "skip". But it does make me nervous that we'd break something for
> the non-http2 tests on that old platform and never realize it. So maybe
> we need a GIT_TEST_HTTP2 knob that defaults to the value of
> GIT_TEST_HTTPD. And then we can turn it off for 16.04, leave the regular
> one as "yes".
> 
> I assume you're collecting a few patches to make your new xenial job
> work. I think what I suggested above should be pretty easy to implement,
> but let me know if you'd like me to come up with something concrete.

Yeah, that does the job, thanks. Let me tie all of this into a neat
package and post it as 5/4 on top of this patch series.

Patrick
