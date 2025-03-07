Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CF1E1DE3
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341739; cv=none; b=qOxrHYCLpjTUOiC7Z6FudSObBiKKy1Ghsu0IeqZIgyR/avMmV+SQq3ffz1qCciVjg8/h1hmDQqqD5s3xn6mIyezu6oiVjvPvGeZyrtY8GQheG5KP/T7x3U0ySmQJw+EowZKb3FEndoD+3libsm9NafOz5OY43t5EuTV8PufVHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341739; c=relaxed/simple;
	bh=DKo50ljcL9eXr8trcL3mvc6bNe/izooKfQRuqubRp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNCIQ8mVWIKET/Ut4jzeKfPqbY4sJMKgFJxAfECE8hyenSolefSHZQAB8kiRSAn5jXs8Z+lyPZFxqn6afuXrmpWqkISNc1PUo3av66TdbZ58SEnQS36AG/lY7lP44gH9+LI39OMjpknHSo38fOoomsUEiJubg5OdhLUXusyRAiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PauXl2Kz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKEB7EPB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PauXl2Kz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKEB7EPB"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9375C1140106;
	Fri,  7 Mar 2025 05:02:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Fri, 07 Mar 2025 05:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741341736; x=1741428136; bh=5ghBpH0iJh
	R13kLKTLEf5hnZP/Pa+mcFDNhe8tj9tUo=; b=PauXl2KzEyATJZEfTzDASJWUu9
	sWStDhw3GMVvxgFxfDrEqEAkHYgCnuCe8PE6N+7nlE1+nnBf6dh+9Vilq8gVqQ6E
	GZ2LVhJ6aR2Tw7N+Lss+YJM9TzRZz0Epzlq3+mT9fl7NEfMZyrggV+hCJwC/gINp
	UQ8uOzxNT1Tb9sC2j5TnuyIVZlbHw837U6PfMfY8qpFlSLqLe3FTXk21ijLwRJD9
	Monn6/jpsC1ddikgZ2GRDGC2lhoO5041nDEQBYLOufee/H0iK4RZqzCQR6lzbJRO
	JvZlYZ8yaY57DV8SzAFrsoJa/b8er4uMY8hyGkMb/IUARCI2H6ywAK9zoqiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741341736; x=1741428136; bh=5ghBpH0iJhR13kLKTLEf5hnZP/Pa+mcFDNh
	e8tj9tUo=; b=OKEB7EPBiNiww89yw6HDc658b72iuimD8cdAWLOStDpiwtoYQtk
	s/SG70IWnHenzrOyD4rAbyExtFtvuWYNn1/uj4TkLHFqEUfjeeaSueYh5Nws+dI3
	Lq7DQOjlTvrGLd5a25bZqgnQs379JdP7WNuTPLy6GVyL02wbCPfoEheqre6BBqr7
	a44RZ2Ras7v4TnYLWfcwFL6XmhfLouQht5BDXDKVHBbhkMX32JelxrWzjdFHTYbG
	OSNY6MOVXMn4w/sQhx0N8k8+sZUW770UNXaHbf9fkfZ0NdXS7hFpQvCadk6hNyrS
	LDSqsJEiZBbPMtXNwRSK/YwTMJ/gooGaTKg==
X-ME-Sender: <xms:KMTKZ5bTtsv2xlXNctJc8EjKG4iFaXdhN_UTr3lCxH3kGdN0YvrExw>
    <xme:KMTKZwb3LmkTj9en6r_L8j0-XW-kH9NmqRUPtXw4WLFfF_-YuS097vfr-wwx1VhoS
    o4Dvm3upu5r6Zg4_Q>
X-ME-Received: <xmr:KMTKZ7_p1t_7Ycn_lrCNIPVIr5dWqvdF4ta2s0DdFTwEK6C4x-PI6ObfjCGZwex1fv0VV0OIZQr8W4bT1iQyTYdiLL9snmp86n2NP5Q1lg4t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:KMTKZ3qMeseGm4ncT3dCtDQt2YwfftTvnNwdEqBBjfIhdGE68m8oBw>
    <xmx:KMTKZ0owH5IRZFELH8OQp8jCRyFclDgXMpJRSVVq6eUx0d-F0gDHow>
    <xmx:KMTKZ9SnyG213xj5AAyXzaeRTFGWxmFYacWOdH58VooeVWFAsztBGA>
    <xmx:KMTKZ8p-RQe4gMi0o3ZHxaYQgyFPJYB_MehtZaenDjyko3SC2vVRSw>
    <xmx:KMTKZ9lc2Dc0qAJM894Jf_AWOUh9B1w5njF5b8e4Hx4vpSRSE78WZ5o0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 05:02:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c31b8420 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 10:02:13 +0000 (UTC)
Date: Fri, 7 Mar 2025 11:02:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] ident: stop assuming that `gw_gecos` is writable
Message-ID: <Z8rEIffQeVCjd_U8@pks.im>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
 <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
 <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
 <xmqq8qpijezc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qpijezc.fsf@gitster.g>

On Thu, Mar 06, 2025 at 08:33:43AM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > In other words, contrary to my expectations, the `win+Meson` job is
> > ill-equipped to replace the `win build` job because it exercises a
> > completely different tool version/compiler flags vector than what Git
> > for Windows needs.
> 
> It is apparent that meson support is a new procedure to build our
> codebase that is untested and unproven on Windows at all, given that
> among all people who may have stake in Windows you are discovering
> problems in it this late in the cycle.  Nobody knows what other
> breakages, other than something obvious and easy to catch like "ah,
> compiler refuses to go further", are lurking under the radar.
> 
> I would be reluctant to trust the build artifact out of meson-based
> build on Windows after seeing your report, especially the above
> part.
> 
> A reasonable alternative may be to declare that meson-based build is
> not ready yet at this point, and possibly disable win+Meson jobs to
> punt and divert our engineering resources elsewhere in the meantime.
> For a new thing, having an uneven support depending on the platform
> early in the evolution is not unusual or to be ashamed of.

I think it would be a bit sad to disable those jobs. They build and pass
the test suite alright in Git itself, even though they fail downstream
in Git for Windows. They help me quite a bit to ensure that I don't
regress anything that already is working while I'm iterating on the
current set of features. So in the end, I view them more as testing more
variants of Windows than replacing what we currently have, similar to
how we test Git on different Linux distributions.

I have said before that I'm very willing to help to figure out any
issues, regardless of which platform, and I stand by that statement --
if you see anything that is broken in this context and report the issue
to me I'll jump on it immediately.

> > Nevertheless, there is currently this huge push, including breaking
> > changes after -rc1 and all, for switching to Meson. Therefore, we need
> > to make it work, somehow, even in Git for Windows' SDK, hence this
> > patch, at this point in time.
> 
> As I said earlier already, I do not mind turning the type of this
> pointer, which is only used to read from a struct member, like this
> patch does.  It is the right thing to do, so I'll apply.
> 
> But I personally would not be comfortable with the product built
> with "completely different tool version/compiler flags vector than
> what G4W needs", even the compilation passes with just this small
> change.  If I were using Windows, that is.

That's completely fair. The CI job we have isn't meant to verify that we
have a G4W-compatible distribution falling out of it, it merely verifies
that we can build and pass tests in such a "standalone" (that is,
without the SDK) configuration. We might eventually want to introduce
another job that _does_ use the SDK with Meson, as well, but I didn't
yet see a need for that until now.

Patrick
