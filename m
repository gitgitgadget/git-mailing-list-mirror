Received: from pfout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CA15573A
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351141; cv=none; b=dTsEK9kNtgYLmCrY08DhXjOMU4yUm+kksOTgwqWR1Qk6R8GGHMRl0qdLaAjRRumUOLVUlSgZEGst+O03Q/dccrdytFaMnP+AZ3VCP1LJie66KoFKHiKZkmfZETI81d9AuD7E5bjcPwTGf5zcrQ3bJQC5Nfs3YX5hJsGzhJSS6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351141; c=relaxed/simple;
	bh=pbOVk2cPLGQLwwY5MqxhlmcVC0lprBluFHqh3ZEJkBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku5Jy0eOPDqPUvdlYeS3jCD+4nJSnHHbE7I96YRnrsvKQworQdpo7+UO+EBDK9HxqA6SFvrTO7vjS/oDlt/AjhQfwgUeyRqyFwUJPoNHPUv4FayekgA+L+1V2y0HmuSFjclnibil3Yi+CyzMXG+u103TvKnhE0KiZVD+CgamUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GdJSQ8S4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpCOkAD0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GdJSQ8S4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpCOkAD0"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A579913803BA;
	Tue,  3 Sep 2024 04:12:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 04:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725351138; x=1725437538; bh=rK++GwryXT
	CGqOPa1fnE/Q0lkn80m80+CS/mX4iYiJw=; b=GdJSQ8S4mN+cfbmDAXhNtqmPsc
	XT/kNS6Ho/H8TAEbnb+PakkIBQ0+8E0peQfaJhfpjaVCrzVfrAUQo2I6+0WzVMbk
	Psc4zF8fjNrjJJsUjG6lZJkgIE1gTC+XmP0eAcTR7X1g6aVezEAJV6j4DzuzmaOk
	AL5Hx+WnEpk27wo82h2Cg9YFiU1NTzSLz9BvawsivtmYmO4Mc35BarDf/udqwiw9
	pzHX10H+vDDRUFzvr++lLFqq8aZaahhjIm4/Wv/9qu0WBX+DG/CNST9yarLMrmZh
	tjTNCR2UvAmoOd5YF3Oqy2a89pGVQJRPnjPpov+Cz2b+Cf0coxKlw6WlcDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725351138; x=1725437538; bh=rK++GwryXTCGqOPa1fnE/Q0lkn80
	m80+CS/mX4iYiJw=; b=QpCOkAD04cJt3DQyBpd7HianrEtSZcPqmdMBj8YkISzU
	QK3VdpFPmNcp72nkP7pmRIhKm1IMG6nUnEvpbPFBiDoqexfK8i5wVGy/4dJK8G13
	aDZcey0CjCU+8ERV7XeNaPj4ytGIh9Ma+SvMTC0Cy8KOsGaKS1mMvk8Fe1oLJUoi
	142/hM2imaB+JoQimgsCvW8elofINr+CkuNTq9Juttd4ovCgs8lMDZR/LSGFeyjd
	mY1vSlb8lhjut74p9KUcCx+e7jljVqGYnQkgzEWxsVx6mxvWvf9a9qh27vfogs9o
	+nawLFyjw27jFPnccQM2Zby0G/nacmQDnfstgrxg2Q==
X-ME-Sender: <xms:4sTWZoYSOEnhx6ycvqfvGtIUaaKvryFq6RrDVZ47ZHL6252X6j6tWQ>
    <xme:4sTWZjZjAh2OblJiWj05LUd8BDc7qTxt7PGlJxI0MS3lqUccR3-wusTF7YGPQWCRD
    EdqonAGauwXtIN8Cw>
X-ME-Received: <xmr:4sTWZi8aT8AG4Ugw2lNKZxUiA93lTSiiYUTKdX3syP3IiSA8FIT-yYMhO6qDyh6pukEOQhP11Mgdayk1MVjYv9QFvluPlsQlQJFGa2uyQY5fpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegvthhhohhmshhonh
    esvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrshgsvggtkh
    gvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:4sTWZirMax0cftXzd6NDwzL_4q4KATKZZt8ClpgQGUgVO17sh9em_Q>
    <xmx:4sTWZjpuTz-40yzC8TC9NOis84oG_9lm8hNlCh9pUozok32STpD-0w>
    <xmx:4sTWZgSnOLyD3eGrBu8US7dDGkKzhMHQvzLaut4fxpaP02YMSV8jbA>
    <xmx:4sTWZjpGeuxkIWcK_9BOp0s0dg_FParaWYdyDVczyckKX7EBoozK5w>
    <xmx:4sTWZm1LFLDRLShT_SswYHNIxFtx-6boLdne32cMhdsuIf4e8RiNmgZt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 04:12:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76ab0b84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 07:45:28 +0000 (UTC)
Date: Tue, 3 Sep 2024 09:45:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 11/13] t/unit-tests: convert strvec tests to use clar
Message-ID: <Zta-nU4UMyrWgABW@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
 <b3b8df048725c25b14860513b7950b158a6990ea.1724159966.git.ps@pks.im>
 <c6f13f6b-7899-4bbd-986a-9bb1649b214f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f13f6b-7899-4bbd-986a-9bb1649b214f@gmail.com>

On Wed, Aug 28, 2024 at 02:17:05PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 20/08/2024 15:02, Patrick Steinhardt wrote:
> > Convert the strvec tests to use the new clar unit testing framework.
> > This is a first test balloon that demonstrates how the testing infra for
> > clar-based tests looks like.
> > 
> > The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
> > running that binary, it generates TAP output:
> 
> It would be interesting to see a comparison between the current framework
> and clar of the output from a failing test - the TAP output for passing
> tests is pretty much the same regardless of the framework used.

Will do.

> >      # ./t/unit-tests/bin/unit-tests
> >      TAP version 13
> >      # start of suite 1: strvec
> >      ok 1 - strvec::init
> > [...] The binary also supports some parameters that allow us to run only
> > a
> > subset of unit tests or alter the output:
> > 
> >      $ ./t/unit-tests/bin/unit-tests -h
> >      Usage: ./t/unit-tests/bin/unit-tests [options]
> > 
> >      Options:
> >        -sname        Run only the suite with `name` (can go to individual test name)
> >        -iname        Include the suite with `name`
> >        -xname        Exclude the suite with `name`
> >        -v            Increase verbosity (show suite names)
> 
> The output above seems to include the suite name - are we running the tests
> with '-v' from our Makefile?

The `-v` switch is actually doing nothing when generating TAP output.

> >        -q            Only report tests that had an error
> 
> This option is incompatible with TAP output. As we force TAP output we
> should find a way to stop displaying this help.
> 
> >        -Q            Quit as soon as a test fails
> >        -t            Display results in tap format
> 
> We force TAP output by adding '-t' to argv in main() so this line is not
> very helpful

True indeed. This is the default argument parsing and output from clar,
so it's nothing that we can change. That being said, I guess the best
way to address this is to use our own option parsing here instead of
using whatever clar provides, and then we can also print our own usage.

Will amend accordingly.

> >        -l            Print suite names
> >        -r[filename]  Write summary file (to the optional filename)
> 
> > diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
> > [..]
> > +#define check_strvec(vec, ...) \
> > +	do { \
> > +		const char *expect[] = { __VA_ARGS__ }; \
> > +		cl_assert(ARRAY_SIZE(expect) > 0); \
> 
> As there are a lot occurrences of ARRAY_SIZE(expect) it is probably worth
> adding
> 
> 	size_t expect_len = ARRAY_SIZE(expect);
> 
> above.

Can do.

> > +		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
> > +		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
> > +		cl_assert((vec)->nr <= (vec)->alloc); \
> 
> The conversion here loses the values of nr and alloc which is a shame as
> they would be useful when debugging a test failure.

This is something I'd address in the future, once we have macros that
can do relative comparisons.

> > +		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
> > +			cl_assert_equal_s((vec)->v[i], expect[i]); \
> 
> The original test also printed the array index of the failing check. As the
> elements of the test vectors all seem to be unique that is less of a worry
> than if we had tests with repeating elements.
> 
> > +	} while (0)
> > +
> > +void test_strvec__init(void)
> > +{
> > +	struct strvec vec = STRVEC_INIT;
> 
> If we're rewriting the tests perhaps we can take the opportunity to add a
> blank line to each one after the variable declarations in accordance with
> our coding guidelines.

Can do.

> It might be a good opportunity to show the set-up and tear-down facilities
> in clar as well instead of repeating the initialization in each test.

I don't think it's a good fit here, as setup and teardown would hit the
system under test. I rather think they should be used in cases where you
e.g. always have to setup a repository for your tests.

Patrick
