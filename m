Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAF1A0BE0
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350071; cv=none; b=SRkjq0Hx4B2aA11aBWg8lUCZ2rvzWpjMqOndemE8nLrbq8C8RzdFajUoOWetkUJ4dyrBBRhNBb3sWVfAD8YPE2TEjb4kzBRM1wOD9q7IoRHp4KmKZrPPSelUUPuEUw6SC+MtKXp3mONbMyjgpGaZMbgnWmV84jseM8ouy7onmpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350071; c=relaxed/simple;
	bh=QH7dGlDAmUb9BdhUJAherTzdOEzB5BqydcUOrhbfxSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHGdtOFuf82JO0RViaPFajW4FgimJM8ODqE8LlSdOthkQglfgCXLa25rLdDyoJ8FpAAyi5xCsnThNf/PcsKhFbhHi6dxYT4iLVM5E+5JBPpS4G24V1xbWOwfWyb2nkk/MwNlMwKXtb+u5rFZ8YGDGb2DlclQ9lac2pNWjCbUZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GBjXCnRk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jyQSB8IE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GBjXCnRk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jyQSB8IE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E65C21D002AF;
	Thu, 16 Apr 2026 10:34:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 16 Apr 2026 10:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776350068; x=1776436468; bh=9zkoFGP6n2
	vl6q6jfXI8IR6RDkUWT/Yeb8NJNn8K1M0=; b=GBjXCnRkBKHwPKyANK8DX0BpCy
	l6fSsKctVc0FQpzl0wbj+cEMG51SzL1qphLjtcrW4gbN3XnrDRsswJfed6dOxrt2
	RBggbFZVgDC5vJuvrbELl/Apmmtzr/iGhjU26aK7F3zAdap4UjGEAIm0ocySBH9o
	Ot+7YG1yPkfawXilBpjmXgwuIkD8aImQPjhmbGsFOJiBLvXAiALd2Zke0+fxspQP
	AQtOEqws3n+adPNEHucSifMEUMBkRDVC+Wuq1FzHduYbJ0WVpsKVvBMdpVeWoNu0
	Ds/TEdPjxs8cRUca+mpu+8mxVym/o1jMj435/69sQRTcCZWBHVOi5aF3nOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776350068; x=1776436468; bh=9zkoFGP6n2vl6q6jfXI8IR6RDkUWT/Yeb8N
	JNn8K1M0=; b=jyQSB8IEa9wJ3JGhnLjRNkT20ECpZD2tp9gqeuioZlF1Vv+TTCK
	lc9bG7+0XWBQzOTMp5nYhY3dks9kzmFwOROSlSMZW1Q93kCMRtOSdefyeZGUttjB
	OExEEu8kHIF8mTWLYkkhZLKA0HN16fLv4cJlpR+98IGIFCEPTzmYaZhftFtGiDU/
	UsC9CwZdNe4wDvTn5o/JaFGYERoumfh0iNAv1NIJtblokHsSUJGTfxoj26iECaHw
	2wxjMswCiSBXJb246atSI2GoL7WWfFaVKnm3xEWUFU7InxQoNFZv6BwPTyQuuaxU
	jeIKbdvzJNT7GaabE4L+QtPZ4dhPvoJYv6Q==
X-ME-Sender: <xms:dPPgaZXguR4hYflW2xqYN_NhUQdslNePyPnoOFElfoNiKDNXWRRlNA>
    <xme:dPPgaQk-dbfZZXD7jGA32AkVUWX29IBUtzS1JjUsj7bFY_kuDPc1nw_zwS9b6KLuu
    iObCUXEf5D92ZF2idwp15wPcCadCbEIbhAe14fxT-PH1MEnY4__>
X-ME-Received: <xmr:dPPgaaaN3d76dPrr8Ds94dfCb4_qyTb2fFOV6NIF1gAvZXWfFdb0rUKvFkQ_lbovjRUvstLvE4y9KEolqKBRkz_1Mj1uoMmBEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dPPgabOBwFO4SSF0pEOScY6YJ6kj6oQnLdKWuDc5ySrrxkqPWQYimg>
    <xmx:dPPgafZAwxW7kKr5UZYjV09Nv3M7tLBzOVOb9n-X_hxHa7erjqThsg>
    <xmx:dPPgaZ363TXi7LQH7PWAnDUwxJdSFdyjC39gYVjwkHhplUuI4_ZNFg>
    <xmx:dPPgaVfWUxXwJJrMKWLZW6ceupdhZ7leaFHcf4W44hGWlTLhdmAkDg>
    <xmx:dPPgabVptvZ78EZW7aMpoGw9GeAKHvqMrAU86hB8BAyhdZMQcQLarC8O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 10:34:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <20260416054924.GB646814@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2026 01:49:24 -0400")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	<xmqqeckifq59.fsf@gitster.g> <xmqq340yfivf.fsf@gitster.g>
	<ad3rgbgadjIZRgaz@pks.im>
	<20260414220347.GA3475127@coredump.intra.peff.net>
	<20260414225206.GA3486072@coredump.intra.peff.net>
	<20260414230810.GA3528448@coredump.intra.peff.net>
	<ad80r_oY-uAV2zVt@pks.im>
	<20260416054924.GB646814@coredump.intra.peff.net>
Date: Thu, 16 Apr 2026 07:34:26 -0700
Message-ID: <xmqqtstb3rf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I'm still concerned that this approach is going to create extra friction
> for test writers down the road. This series needed to clean up several
> spots to avoid false positives, and some of the spots were non-trivial.
>
> Now that was the accumulated cruft of 20 years of test-writing, so it's
> not clear to me how often new test-writers will run into this. But when
> they do, I worry that it may be hard to even figure out what is going
> on.
>
> But I've said as much in earlier rounds, and I'm not sure Junio agrees.
> So we can note my dissent in the captain's log, and I can reserve the
> right to told-you-so later if need be. ;)

The alternatigve to allow us to be sloppy is alluring from the point
of view of a test writer in me.  But do we have an easy/canned way
to run tests and see the unexpected failures outside test_expect_foo
while ignoring all the noises from passing tests?  Perhaps running
tests (with and without prove) while redirecting the standard output
stream to /dev/null or something?

