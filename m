Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6A1DFE1A
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219014; cv=none; b=rR8tA0mjnIByjQ+MYwDQTNiYrlyFMkNbjnXAVZk+b6wCMJTNuYH/tFkKjj1tnr712f6tcDURUSwLCN4Eh6gZxh7EU72/jNhUGVCbPJj6/YFOspFBtavR6T204MHBxBavGcpv8kDTuJ5wXyXk5W6OffB9NSr2l/aqeWtmzcGh9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219014; c=relaxed/simple;
	bh=MGMNE4SXr/PPOSDj5vuShy4eMOMX1nvgE0tH7QXIh1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElU5o+ouUVzFVpCvV6Ei/58AIHox1pYtqyCuu9Q5TWIfNYeYeTyhxbcaI+T4g5hY2/o+J5QQCixIxpNgjOvZQvBZ9EksNWL+U4KE1dF8AC6i4AANaKsB8XpjMxwkh7/Fi0aOUx4sy2DkDDx8indewMgjhiupznDpZke5K2A9+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkImrE1r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mgy7TOoh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkImrE1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mgy7TOoh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4838F114017E;
	Tue,  3 Dec 2024 04:43:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 04:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733219011; x=1733305411; bh=h/4CJRyKO8
	gQJhZO3fBZbEjkB3Vt+0Mxz7UIhauyn3g=; b=GkImrE1rx2rS9NxKsSEFvRdkbn
	p/m3TZc2kV7dZwHIrGFqILlqzgpZT7UR2tSsl0msteYrGzL0NGEVLIC9shshWY1N
	h0PwApsd274OrkJhHyCseLmaq95EjaONx+njkrxDnbgrkyTj8HoXaoqnWKH7UVNG
	1Os/vYLC5JZ/1BHORtFRTF609VZleA8fSnqk/GvgftwSSA089wG9hJyhm/JKlHSf
	k8vqyTdngVx2nKAzVqK/ntUoQJO3FhiUI74fDVWQxqckjRWxjfkZk8bAlpWITQwo
	S0twDLcG3kDTtYgeEahHQ/CUIqW2Aa/0zOeltPHrSK+D0HMElSmpCCIUNqDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733219011; x=1733305411; bh=h/4CJRyKO8gQJhZO3fBZbEjkB3Vt+0Mxz7U
	Ihauyn3g=; b=Mgy7TOohTS17q9Wn63uTUCkQNw5gFO+IzDyFHEdPKpT914XIFDe
	ZCScibxdMbp+ipPwf4GlLfctnj/D0SLnXnn2DkAhGBSppQa2xEC5gFoSgqgfnyfP
	y/hrgSAQx91FqCA88brPSjvCG0Rn7TTVD9Ut+4JIsc+N2kwLk5nBrT7AEViF1o96
	TwHURJe/WtqrQAxyq14kEUI8qClhvXi0sxzcE8p2gqCAtDgAgMUJCZ9d9240OsRA
	1B34lQ0N8xlY2QoOLLjJYHkkuR1zOiTkgELRwg6B15wbsjjDv6o65OYzqVRjkkQE
	Z6176EFeNcHbovYaZ6iMiwiiPF7tzMj1kTA==
X-ME-Sender: <xms:wtJOZ_0aD1n8v5mXbh3LfRy9dPQMqN47Zm0BcM8gyJdyoE8jEJd1vw>
    <xme:wtJOZ-Hn3wy8WQptiBLcdCw2xTjB0G0iP49ksTIfneCUGZfubDI5H33NCQDJG6jru
    yXwRltKi-NBFm9__Q>
X-ME-Received: <xmr:wtJOZ_44dn6ncETrBjiaBu1Hqaln7XjHROYDUXStuhLTDC0IOHM6QXDM-7NlDPmVw8faEs4XRKMzNAEcmsZHEyJLSuP7cWqXGpqaxzgrWDwh7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdegieet
    geeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wtJOZ03klSIkm1mgMQdS77zIS7lfz7ZXX3WPgPxLQSZKl0HScM7P3A>
    <xmx:wtJOZyEnL940230if6trGUefoknVmdOkKCKRcausZBAVNF8Oajf3cA>
    <xmx:wtJOZ1_rjShnkorC8CuhLzkbmzY9-Tsduk1YD34KOFJ28V2JEibOlA>
    <xmx:wtJOZ_kiFpZYQdaDNTjko_8aKBWUONXKb8OfxMoFVyBguy9I5fNm9A>
    <xmx:w9JOZ345HYF179um8BKCo-W__auACuvASEzueIhSq0uL7Ddklr0KCT1l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:43:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d50060e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Dec 2024 09:42:10 +0000 (UTC)
Date: Tue, 3 Dec 2024 10:43:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	me@ttaylorr.com, shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/8] Change midx.c and midx-write.c to not use global
 variables
Message-ID: <Z07SsWL6sExkYUdi@pks.im>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
 <xmqq5xo8qh9h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xo8qh9h.fsf@gitster.g>

On Thu, Nov 28, 2024 at 10:27:54AM +0900, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Changes in v3:
> > - Split out the first commit into a separate series [1].
> > - Improved some of the commit messages to be more descriptive.
> > - Merged the 8th and 9th commits together, since they were similar.
> > - v2: https://lore.kernel.org/r/20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com
> 
> Merging either v2 or v3 to 'master', together with their
> prerequisite topics/patches, seems to result in identical trees,
> which is fine if reviews on previous rounds did not find any bugs.
> 
> Will queue.  Thanks.

I've had another read through the series and couldn't find any issues
with it. I also scanned through v2 to see whether there was any feedback
on code, but it seems like the only complaints there were about commit
messages. So I guess it is expected that the trees are identical.

So this looks good to me overall, thanks!

Patrick
