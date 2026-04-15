Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA0296BD2
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235703; cv=none; b=QVm2mKNDaPZKYgSb3sFRrMqN5Z0FbRt5kIGRYnof622Rwn+RLSv34ICJhJ+WPTKGq64Ne2kXma7SeMMHLpWr2fkVEMyyz10IGq8QjpFhWOFsbfTcpjD7UQ61Qgdx1FrMUQVSTUE22cBMepwJe7xVo/I7vzDlP+k/n+ESr9kUJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235703; c=relaxed/simple;
	bh=fhXN6Li2OFib7q2n4jIve5GzW2qViSA9yg1aWewPwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFLMH+V8gxOWmU9WRjDCYIIknisOKA3kMH64O+VP0sRorl69Sq2Fa7c49yzicstNnflgL9u5JHmhBx7xrnPQRFgzix253rPWqQxRpFCvqapuAMwLuxhreE5Kpfwd8sbMWUYqsDHcVAliN0u2JNrSiwfEs4euyrnQ1i3WcTrSLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IGiJJZmW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XT+nuiRq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IGiJJZmW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XT+nuiRq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E4D914000EA;
	Wed, 15 Apr 2026 02:48:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Apr 2026 02:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776235701; x=1776322101; bh=P35aG54pQa
	DnNKBwK7xm6QmXXLHBxp3uruk/qkDvAO8=; b=IGiJJZmWWUrp97tbGmfNU+xrgS
	Jzdih3RxWuEY1KkIFk/oxZ3JIGDC25Bi5iir6qly0APk2RIu1ZQq38BBQXh7vC0O
	H96Opm9gwqsJHD6NCl7vCPdGm3mAIQ2J1WdxxyxStZcM69DXgE0LJKH0I520YfEI
	cWmU2DDzZIsgy3i9gYBNLQHH1kIzaN2k/ikhjzPEay20J17hQr0SDLxP79T1I5bv
	ielHON9jKyXqfL7P9JlwVORmi+SA9VZipALj6sS9l6pIaeP/BUsnEOQWHFkaviJ9
	sX+RV1Fj1/zDa8iZGyf26RXrEzzMpmHbinQP3l3oRLnz6gMrxz/oCilp0IGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776235701; x=1776322101; bh=P35aG54pQaDnNKBwK7xm6QmXXLHBxp3uruk
	/qkDvAO8=; b=XT+nuiRqFMBg7WEtdfp7ZPj0n8rMk4hX8pc1zxf7Nmxg7RCIOFr
	Ocy4awxo8OKjXyi9MrDcTz05X350aUB9nmfTpCE9k13k/+bK3Y0ZycNT/3w4NVT4
	soALCfjGZjNjdB0lFirARas/qrAGu/yhrY0CaFz95+CaFpeGd7fdkMO0ufVMIlXS
	DjTaaZ7s8EtUnWQZh/kgFYcthw68NgcmaoF8rdXS+Ila7oKJqOaVaa8KRhzKZ4zl
	RsZmBVyimAVybZfHyLoAkzonNspNmJx5sqYUaPKTq8wWi1IFzNtvW9RNb3VC8EMq
	OKgKRSh+qgj439DDjguT4Rh6/E2KzlYgXWg==
X-ME-Sender: <xms:tTTfaaMzupcYU4SickKpYQ4nGhvnmV71VAwKqmlisVAyNifvTuK9Zw>
    <xme:tTTfaQZmwoq3OIJzeo7IYT7677IVow16vBuuJ7rW7UQxD88hA3Azk6QV86UPHoeZQ
    urtpYhFmwUnx0IKI7IsUYMY56bGvZ8_rU1sezX8LnpY53SiLNpCLg>
X-ME-Received: <xmr:tTTfaercdDL2kyCWwNtcshW1V49Hg-V6F9Fn316Ktrj-Sgt84qhSpHJ-y2Uoz9QbJ58t5o3-7PBigB5_nOB5k55sKYL4s7_JcnXt_e3PEkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:tTTfaUbPvvZGUR9dEwq3j_mzlwp2QL_8azDGjKrqVbtMedz6DHU42w>
    <xmx:tTTfaWSgYLAi9WoVA0VGo0H5J1D98zXpfiX7nWKeJhh-5mxwG9cxsQ>
    <xmx:tTTfab6j_4eq4BAz1bTFUHLSOaTZb3dpJKVxUBMVFe2meIWwD4rYxA>
    <xmx:tTTfabx18LmYUanAzIqL0WsnbGavIwplA0P1Pbw9zQ_rpiRQncWYmg>
    <xmx:tTTfaRJ8j0v3ogx9iYkM7rJjB9HKoEBP3VJ-m-01TLsR4mecgbQPsW2w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 02:48:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d6f40b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 06:48:18 +0000 (UTC)
Date: Wed, 15 Apr 2026 08:48:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <ad80r_oY-uAV2zVt@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
 <20260414220347.GA3475127@coredump.intra.peff.net>
 <20260414225206.GA3486072@coredump.intra.peff.net>
 <20260414230810.GA3528448@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414230810.GA3528448@coredump.intra.peff.net>

On Tue, Apr 14, 2026 at 07:08:10PM -0400, Jeff King wrote:
> On Tue, Apr 14, 2026 at 06:52:07PM -0400, Jeff King wrote:
> 
> > Short of requiring a third-party shell, the only workaround I can think
> > of is to manually "set +e" before using "command", and then restore it
> > with "set -e". Gross.
> 
> I guess one other option is to avoid turning on "set -e" at all for
> known-buggy shells. We are not relying on it working everywhere, but
> rather hoping that if at least one platform uses it, it will find
> programming errors in the test script.
> 
> Personally, I am still skeptical that all of this is worth it versus
> just checking stderr.

Yeah, the more I dive into this topic the more sceptical I get, as well,
as shells behave wildly different around `set -e`. So I'm starting to
feel somewhat uncomfortable with the idea of blanket-enabling it for all
shells, as that will for sure lead to lots of fallout on platforms that
we're not testing.

Maybe we should really only do this for an allow-listed set of shells.
Starting with Bash 5 and newer might be good enough, and given that we
use Bash for some of our CI jobs we can assume that this would weed out
failures anyway.

Patrick
