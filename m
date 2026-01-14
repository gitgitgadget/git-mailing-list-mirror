Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC12DF130
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412133; cv=none; b=G3ri+T6bMGDxDvMmKbQRRRB8ThxWrslLez7gtHe1Lewv/6lULYoQU0JLmcxPmhMiIW6l4uBc5xSEtxH89v3mQr8VZaCBw2zDirRZ/RGpZ5lMqmZr14CYSLhUnb7seBnMsZY7nXWTME5UISZ1ttrGDQ2Re4G7E50+yMZlOx2Trvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412133; c=relaxed/simple;
	bh=2/S+RIwmvMELsQOVYOdUExKpEMgnj+Ua88e15lf6qBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToYaKDBonarhsREShifYMecg47T71XoL4cDxLQtJIciL+Zc/S7OxHyq2tfrJP9uG8PUHHwHbZCDawtF7T+Wxe9AwHBEwPC0f5L6plqnN2QGp0jzm1STgGji8gW533iTfnwkwuTRnb3IDMWSsyilSI74hXb+TsFGXIMdY/gKbrks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dJet6huO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iB1NS3IJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dJet6huO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iB1NS3IJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D243B7A0076;
	Wed, 14 Jan 2026 12:35:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Jan 2026 12:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768412131; x=1768498531; bh=H5qhZuw6FR
	FHqIxArxXU2H9fz0lfHn7b+Z36Y6GuWc8=; b=dJet6huO2tmxfgeIKv7bOIRPya
	YYr5ld6w/rpkq/HrSXQjmuasnAjitr0kIn7DWZRgVP7VbR5psvCOrua2DvcNXZ5T
	u4LOFbJE6HuNHWJQHqyViEWQaMBVIcSAOO0cQHOFlNVN0OihLoXofjgAzHSudlFq
	tLe1G+fTsE+ShQizzCSwD9yTETxIOk9UhqcNRdZTa9Th1CTh6EM6ZJtcZptOZeFS
	lBeEH1ROzJVL0K1TzJjL/Kwk67GhHo9mzT4E5AUnfCH5Yhdy3UFuiss9gpX62JQU
	CpnzG0cfR8bxwC4zqB3wqyf0t7qAD8ASN2KZrEfSM6W81KDj65u/8pwenhLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768412131; x=1768498531; bh=H5qhZuw6FRFHqIxArxXU2H9fz0lfHn7b+Z3
	6Y6GuWc8=; b=iB1NS3IJ6kitZpqinzk+/eQFvPaMB2IDicFvZu/EBATG4FEj+lM
	2V4l0BvBoejL/8WSJGTkSlIsX/Cb63uwdH3t3vc2qWXQK+QjV5F0g0lKyXZfCxpt
	PjqzZQixEcpTZHXWEkl3UbOVGdTepJzLM4yrA3A0wptoZ5MGykNdv4ErfpuUHR0m
	bPOM+wwlpGXwDGV1ykrj0/pWSY2KwFLt/pKbB4c0/j5Bj5KmnodgFjYPHO6JahrV
	S5mvHf1NlIvMcWrrJM/cSqbw9cX6KxyTBhDzBGzekre3JfrI+oxFwM4ezkhvxlDF
	Fcx1MYG9mex+TmFPEMQyGnJCAkNorKtqhcw==
X-ME-Sender: <xms:49NnabZRiEbgHUznPD9mIocAUyh9bLaZLIrpLwF9yGQSKqmR-8r0mg>
    <xme:49NnaQbuz4FRS3aZjyNaZ-teHflzjqiHEdbd8_k6KHhNb5-ewzC2Wl9kZHEs_52Mf
    4fjnKA1LdAAO64E-v0f4UNcDSZgcnhRA14wh19sYqy9yx4R6dC0EQ>
X-ME-Received: <xmr:49NnabmyMuvnFnNYxnTdZqj8_mHRcho0IhXtwByJt73i8bqr4rP6-z8TIBoPtgEjl8BAadpg-JICYA231DDJMRPOT8lluMA3csVpAgNf-c4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefhe
    evvdegieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:49NnacyXjgkCoiN7tMZ0CHf_987Jpr1exfXw_dT8N2SJSvk3cvT8dw>
    <xmx:49NnaZNn7u-88_Gqy1SWDBQ3vTnpupMbDPY5C6PcocT-HBQsaPhXoQ>
    <xmx:49NnaQQXrOykF6GmEP1D34SAUEHPTJX-T3e9fjaqPDNqog6OY7b1xA>
    <xmx:49NnaXYXOO0lyT_rXGQuksZKJaHEsPHE7xT-KzctJw5_QLdARSzJJg>
    <xmx:49Nnaexy5hjxwQAoCOpM4DwoSCyCBW9ERRwythOUQYD3U2YcjunBjQxV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 12:35:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e23f69ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Jan 2026 17:35:29 +0000 (UTC)
Date: Wed, 14 Jan 2026 18:35:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #04)
Message-ID: <aWfT4AX4RSieyAml@pks.im>
References: <xmqqjyxli89m.fsf@gitster.g>
 <aWcnsvVdtHYPWOAB@pks.im>
 <xmqq8qe0gthp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qe0gthp.fsf@gitster.g>

On Wed, Jan 14, 2026 at 06:26:58AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Tue, Jan 13, 2026 at 12:10:13PM -0800, Junio C Hamano wrote:
> >> * ps/read-object-info-improvements (2026-01-12) 8 commits
> >>  - packfile: drop repository parameter from `packed_object_info()`
> >>  - packfile: skip unpacking object header for disk size requests
> >>  - packfile: disentangle return value of `packed_object_info()`
> >>  - packfile: always populate pack-specific info when reading object info
> >>  - packfile: extend `is_delta` field to allow for "unknown" state
> >>  - packfile: always declare object info to be OI_PACKED
> >>  - object-file: always set OI_LOOSE when reading object info
> >>  - Merge branch 'jc/object-read-stream-fix' into ps/read-object-info-improvements
> >> 
> >>  The object-info API has been cleaned up.
> >> 
> >>  Comments?
> >>  source: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
> >
> > I think this topic should be ready by now. The last iteration only added
> > another test that catches a bug we recently started to hit in production
> > systems, and the previous iterations all received reviews.
> >
> > I can try to loop in another set of reviewers though if you prefer.
> 
> For a topic like this with multiple iterations, I always revisit the
> thread overview
> 
> https://lore.kernel.org/git/20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im/
> 
> at lore, but it is hard to judge quickly if we have reached the
> point of diminishing returns when the last few rounds got almost no
> responses.

Fair. I mostly want to ensure that this topic will be part of the
upcoming Git 2.53 release given that it fixes a regression.

Patrick
