Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9811B25C804
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805878; cv=none; b=ddPbpX8hKnYUh55k/DFVTENkriNQ66ur2jVZxIxDym2pGEJet1zc5rgAR1/N9NKdEUHA+0GS5wSRHoAZ8X3CiEy1YPHwX5qRIf4IP9lh0Qok7rSc5HApyNV4Xg6PdnLhuxN2D7rUoYj9iy/KSrLqWAyjGyJVek0maSwef2zmXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805878; c=relaxed/simple;
	bh=kcEHcFK5UoAe/Q0Ql74mZc/CEBSbvyQ3cJLc3GvU1eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIJnrkIhRb6sJmzEhCWzM8DXt/0Ph2gg4vM4V4qBTsDG+eM65xsGAacWBTlb+dOCADP3R8zvhcG1dJw4STRse41/Etec2heuhJP9jmxmhJeFD+sBK/Up46jNeRDnOAb2yU4Z9dymu9PFGvacRD3K1bflSjb3/VjDojRUe5rs8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fUEdd/Ov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbMddYoV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fUEdd/Ov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbMddYoV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D6425EC0972;
	Mon, 19 Jan 2026 01:57:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 01:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768805876;
	 x=1768892276; bh=oK7c+AQvId9rg/MQ4ELCje/v/F+6EcBCk3Sof7lqlAY=; b=
	fUEdd/Ovcoy3OYyR7Bl7Kt/y/vRcQoyXxJVl9NYrcYyluq764U6HWT/vlOe0NPBX
	5amlfe0E9aWKHz5aRDKXIp22EYyQmV1gbZ3Yol0hdezvwg9wDxFMrngfXUOFkoo0
	kuNhP1HFTkpwMFCWsTmrVkGPSf7324zLxncvBxPFCin/3WIAT9pCe5SJhUdnYT5k
	+WTg4EYSIFaAKwCGhvgLAog4BoxzgyVaO81rlhMmPwmWXx86XIrGHDwavoAggPYU
	+1AeGwEjuW5mmPYNxAUPhA5l04wDPEdVuxmRWAxqBaFIgM6FYOtCirbCmZIhLpD7
	FStZovkLi7y5cGpEHwG76Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768805876; x=
	1768892276; bh=oK7c+AQvId9rg/MQ4ELCje/v/F+6EcBCk3Sof7lqlAY=; b=v
	bMddYoV0bqWqPFqgefmUeicECmQwvYSFRnf8qZViMVdlnRMURRMwYJC2AtniycIZ
	QYnM/ZCiowb+1iOCM3ZW3q2z7ApWvsH3ZC9/zhzG9V2IQkOt1KccpawynAySVPcY
	KYX/UWIGmn727VNMlBxlP92DrLG5HhC6uw9l/EcKedmMGWEIrtLlVsKWlqyIUG/w
	uahd4XYogw2FCz9p4u4AZYEBVMpqOG8eIRuQ9XyVEK4k4eNnMjvM2CUMMj+xCwXZ
	Pm0cyB/fqRyhpDy2fEx43stmbCZwAXUEgV13RzX8O3I0lDkDB0D2b5ylkKRTTKaZ
	A8eAGbZQL5/umJc8pEnag==
X-ME-Sender: <xms:9NVtaZrP5xxcYLyJpnjN2c0myNn-Kq_vfE51ByhEWQ3DV1_RmNoJ_g>
    <xme:9NVtaSqBXuRZ-aOqHRjKi80Zu8_JDTZPnKhCsdcjkpXq1BnIrCUI83JDxcZ_AxJQV
    ZH6voFjIqIKSBxfLKFv5O0AimjRyFE0AwMEP7IHcoxao-KXUUxRtEk>
X-ME-Received: <xmr:9NVtabPI6hDRn6xL8MLHEcOPd5i-rozbhwRB9PYT6SE8BYT_OM0uUmrmu-d9CJ8MnVrdf-vWcNn38EKgedSeubFXpH7koODo_LhuXCZ9kXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomh
X-ME-Proxy: <xmx:9NVtaTxUbDyS9fYdAogDaT6wU0CjsF7_AZ-HSC-CwlHFawnYLIFnFA>
    <xmx:9NVtaUv7Xmo-iQJvnLtHd56CfNauh7c8Tj68i0sPga6KKL52Gwn1ug>
    <xmx:9NVtac6u8KGyU1zHu7Xqpm0ZDiAcW1xpkShMDVGWyw67jtxC0CkaJw>
    <xmx:9NVtaTSVWoIG9GqZLly1u8i-43KtFJOzbMN9en8Nl7fiLm1l4S5G0g>
    <xmx:9NVtaRJih2Nb4JuU3LlYEhvNJwGZvKG_MEM_6wPrQ9Xqv1dtEGUC1Z6f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 01:57:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a659050f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 06:57:54 +0000 (UTC)
Date: Mon, 19 Jan 2026 07:57:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
Message-ID: <aW3V7-RV9wCEw1vY@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im>
 <87jyxjjejz.fsf@iotcl.com>
 <aWjVWC71rFeTsHLP@pks.im>
 <ca6cfd7a-3392-46ce-99ab-3d93c9ce90dd@app.fastmail.com>
 <aWnkJ_GpgbXBPwFp@pks.im>
 <xmqq3445a370.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq3445a370.fsf@gitster.g>

On Fri, Jan 16, 2026 at 09:16:03AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Surprised that “revision” is a synonym for commit? Why is that?
> >
> > Because in my mind a revision can resolve to any object type.
> 
> Yup, in the early days of this mailing list (like in 2005 ;-), the
> word "revision" was used more or less interchangeably with "object
> name", but "a revision" was much more likely to refer to a commit
> than "an object name". 

It's probably still much more likely that a revision refers to a commit
rather than anything else.

> The name of the file that implements one of the more core-ish part of
> the system is "revision.c" and talks about "revision traversal", which
> is mostly about following parent pointers in commit DAG, but also
> follows into trees starting from commits.

This discussion makes me wonder whether we should maybe update how we
define a "revision" in our glossary. One could take gitrevisions(1) as a
starting point:

    A revision typically, but not necessarily, names a commit object. It
    uses what is called an extended SHA-1 syntax.

We should probably get rid of "SHA-1" though. So maybe:

    A revision is used to refer to a specific object, typically a
    commit, using extended object name syntax. Refer to
    gitlink:gitrevisions[7] for more information.

> > Also, it's confusing to conflate the way to name a commit with a commit
> > itself. "HEAD~10" is a revision, but taken by itself it's not a commit.
> 
> I do not know about this.  If HEAD~10 does not resolve to anything,
> it would not be a commit and it would not be a revision, either.

I guess things are getting philosophical here :) I rather see it like a
pointer: a pointer is still a pointer even if it doesn't point to
anything.

Patrick
