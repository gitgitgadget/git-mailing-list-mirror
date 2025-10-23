Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED1239E97
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198781; cv=none; b=HWo2BZIQ+gUNJ7hAu77Q43oZ9K4E2tangJ9KC9g2ZgT9J9E1qiD1wxGpKm8coSZ/l5H881V5faCd2H93kSyJ9vglj4fqwqaXH1nPQKu8Iv4Z6u5OxIJ2nhJfDjtDJA/yCdxHxQuGFvROicMSi2im8G+PCUvRyCN3KnsqIN7XqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198781; c=relaxed/simple;
	bh=xxJxkeJ1mCREPvcJaGV/5YoVRIkD/bNt6mlqiNKKdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1yOPdKIZ54O9nXGcp3YsWkezi6uif28rkKXbhhuOrfzTE6jgGfotKUguFO1yuqP7s8Oth411BYE4Ek8XEtS9XnmbskuEAdNOkRiP7rRKBsBqhs2xVsWGBxmjfVEwUUlo0IbZIXiPhpkL+LTMYa9GGTKGj4s5p7vz3b0kuyKt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJMcuK0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eW2fbV7n; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJMcuK0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eW2fbV7n"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E2DF9EC0148;
	Thu, 23 Oct 2025 01:52:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 01:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761198777; x=1761285177; bh=ZF5ugxcUsK
	O58MRA8SXM/GIS6Wlf6IvWsg0fqtImwro=; b=cJMcuK0YCcXAvbZbGchXcPucUg
	mzkwKnL5ZXGolc1NmWJl7MUfpYgMjrI84sQiLFXWoY+MjY3pxl+utyl8nEBLoFN7
	HHxJ3ee+iQXxEOqz3L6YE8s3SpoDJGgEuJ7ErRXMOb+f+qQtCsqu6pwJ+FBcx7r0
	7Qd31i2rDFUsc3Ou41AiJP6zizpkDBVx37PFnM7v4j4DJV2VY+Ax9MqwYX7ejv6F
	KXhahjbkL1L0R23C9nB336mkf8b46JgPPjQPuHDLrsC+yf9zlHGX7mMV38RKY122
	9E2COtcZPW5mQd8GLuwNjr7y25wn2/2vzFgTKP7VW31VitgTAnsrkjFWnxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761198777; x=1761285177; bh=ZF5ugxcUsKO58MRA8SXM/GIS6Wlf6IvWsg0
	fqtImwro=; b=eW2fbV7nVERB4mmBEYKxV/jpJx4WpIYyMjWwxDHn+GU3niRMlKZ
	ySWG8yrsaZuHi3f3qUT30m7Cfv0AeAfQU55NF4wz8y4kyBGf1iNiLC3bQ/3pBX59
	7F5ORhdtiEEz0yrFTroLs+cOaUXRcRGW8swlj8ktMJiiTuZVbu/RzD2GmIikTGfo
	QhL8wMNTLKzBpzam+2fEm8GAHoOkS60N3DhTitXd+Y5KEFuXQoBt8w/eg3gyGLvb
	qreF/gDNpmPICczgiQbAdGcAMMMxMdMrcI4rA7CChJ7slj6j67Yfa8TV/pgSrvK+
	b45u+VGLzX5pjWJsMTZ7wHTk6PsYlUMjrow==
X-ME-Sender: <xms:ucL5aJG769WvP_KtIGpiMf1IcrNa4VZiFsvs5pYp_XjlKJvx1Tx8-A>
    <xme:ucL5aCBkAH-rFz1VLlm91I3v17RrqcArdcYXjWV8QO2mLDFw1qFjf4w2NnAepqp1e
    J4v-SqhOfmBoV6z0SQLNMUy5-FM6YwKWxLw-BBdBMs0a5XCmee_Kg>
X-ME-Received: <xmr:ucL5aE-8YsOdpGJFkT3sED7gcwNg8fVuGGQwaClBnrmTcpXnaF4wjlCqsaZ3zLqEgomI2XsZIYhXc-253BzeZyq342lsmI4bosFVjezGeCpAFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ucL5aGCX-uRjQw54U5KKIwfofyRmTCYWEQL5bRuTt6ekvBpXf5POVQ>
    <xmx:ucL5aBSDqNX1Kgn-t-B-tgR1WPoestEK5YfDgHSFRd6W32k0i03viw>
    <xmx:ucL5aFvmIxzmKb67BkmtMJn9Hk5OjrCIwfbLfB_sZM99yMtV-O8INA>
    <xmx:ucL5aF1NK5Do9lqtTIWLJvrkCBgaimohXgE303qpkD74X8RY__jYkA>
    <xmx:ucL5aLCF1VrttOJ8xyE56HoxnfGghzzqeTnR3sBJ08w6oIAME0tG7bju>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 01:52:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef04c0f5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 05:52:55 +0000 (UTC)
Date: Thu, 23 Oct 2025 07:52:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/14] refs: improvements and fixes for peeling tags
Message-ID: <aPnCs-zK1Mzi4wb8@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
 <xmqq4irr0z8k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4irr0z8k.fsf@gitster.g>

On Wed, Oct 22, 2025 at 07:47:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes in v3:
> >   - I've rebuilt the topic on 133d151831 (The twenty-first batch, 2025-10-20) with
> >         - tb/incremental-midx-part-3.1 at 935ab44a0a (builtin/repack.c:
> >           clean up unused `#include`s, 2025-10-15)
> >         - jt/16a93c03c7 at (builtin/repo: add progress meter for
> >           structure stats, 2025-10-21)
> >     merged into it. This is done to fix a couple of merge conflicts with
> >     "seen". Both of the topics are only in "seen" right now, but they
> >     are close to be merged.
> 
> The latter reference is weird, but I think I know which topic you
> meant, as I just finished preparing a merge-fix to account for that
> topic.
> 
> Will re-queue.

Oh, right, that was supposed to be jt/repo-structure. But I see that you
managed to figure that out correctly, thanks!

Patrick
