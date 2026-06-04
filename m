Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B13C062D
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555956; cv=none; b=OurJ8ZJCZpbEIpcp8a7CcxO10R3ZJwqJD8x6n9XqjvXtTcEJ1ONSLZcJatNlxe57ZtG3PjQw9ZihQDrtUFeSOdQnvMBF8dgdGBpcyXLD48+4aD2fnMOaTC39bOXeLTjqhBrY1mYlvm3SdcNNN1M6wgg9xFoVo0eReOhXlSC5Hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555956; c=relaxed/simple;
	bh=9CGcD7wp0fwKg+3KQcGVz710gn/f27KOUABJ993ojK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZZns6TTQNSfz/ZKqdGJSOXsL3GKnJBO3RbLIXaP60CrglavQVa57dXckblWIe1Pqzpzd/fjdsLByDTafHsGsr27fjzkUozz5Z2zrasvTtEb+VbAHy1xkPrmLXd9jS4OdWd/Gfg9pO3VDIJUYGa0JAOtUrVOeDLBQC5PUvZYpto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uNkaXPYK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lP+1Miua; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uNkaXPYK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lP+1Miua"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F6A8EC00C7;
	Thu,  4 Jun 2026 02:52:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 02:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780555954; x=1780642354; bh=egZ7QhynlQ
	RzVNkk0aED+/IfdQBDiNwlltniD3Mtv/E=; b=uNkaXPYKTny/Cx/zDMEqcUVbkN
	D0PADSjQqHrXMMLa4AblSGbrK9SRGSfB6uwajHgzDpdBzvZUHp7LcG4w2lAqzAX1
	RoWW8OeAzJrn11GRFncewePnieCqKxW3iUcG4vK7vvLb4A/gBLaophcvvieptbXS
	2xVgWxXLGTD4JtoYjOyFEAjRZGVnLc53RbAMt+P/oOgHxwmjL40JvqJK0teftXh1
	EvLhJXjNtBDoKI/eTPTTL1IyRE+Y2eaZXdLiW9xYVkanAua4Cg22cpJbGQWtoyiz
	mz/NbR1/mpncX2tf9+u51V/h8jpWGM1KRlqo3M22dcLjWApDntzxPIxwUOgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780555954; x=1780642354; bh=egZ7QhynlQRzVNkk0aED+/IfdQBDiNwlltn
	iD3Mtv/E=; b=lP+1MiuaUJaeyDv5fTd2ZJ9Cuyb1r2eO7MsQhCnuju2AT71qHE4
	ZAhD5BQrnOz0JpSOxfX+8HNqBD1Ps/dVkZhohNYiPNai6IjXrIJhJR+gY5whFnXG
	3RN1lM+vPWlMJC+EXp+7E3kWR4ZMF6BHw7/X4TWUuNxvGAzu55wJAx8LocfBCpoM
	9YHku7puLvutZoaHXCDJ1KAaJPt6WOu7RlMxtjV3tz909EHIeuqSDnYWWR8Jn1wk
	ixMfy8G3gWosNhH05NNL0GGSTJK0BzwE9cjtM1XLcqDsRk1Cwg2VF6H7Fqmg2JuJ
	Unh+CEszA7oYO/t+qdpLFcxquSCUj6abgSQ==
X-ME-Sender: <xms:siAhaikn1oh5pn3N861JFqoTSEYmwOAp-Xk9ybc5Qn461p15bZDduw>
    <xme:siAhahR6-wMUzFrSdl8LlUkdWP4a-vjIUZ_zuXL1mdMhsbdIiA1kX8Icmn7keVEi8
    uqPE0nXhy-Pw59nCfEpr2XRacY67mGwHKe5pTmPC3qnfD0mpEQCz5M>
X-ME-Received: <xmr:siAhauD6rrhK9_fE7iZ15d3XnKGrhRGGh7aUgcB5Ws7bUaQCrf1xJKiGqow7NZs5NSCWwgAeZvKZahrBgLkTSlftfQV3U1lHmVJ2ltMKN6I>
X-ME-Proxy-Cause: dmFkZTFxCIIZlZpiQhNmc/4fWIZKjW4jTlhKr8kV5ngxAqRdHzNl8nfXzemhZmZKogTh/+
    UJK69NfpXSN4yCFovMIaHVTn8K5wMVcCFJPPu3NjQGg0msEIJOMBpLkkfbmcdNNNoVvXPj
    swaR6QYyJBUgqpSz6nAkGmR2Bf48jS308A9dSqRLggDF98yZcOGonDcRC0fPpBjrcP9Vr9
    NGIICg7516ARTOw5sWAP4oBFprG3ijQP5gqk9JQaTRDqy2E7+0MIsvhyDim3aTa3NwYWrl
    t1Pba7kfjmFMlbVsGMK9jbbn7IR9lP2Es2/6cvSbNY/aShWCOPNxqjZxi6LCu1rt38vlP9
    UYV+daGGiKjAP/TnTzjz9YXduDhNj6rz1LkbKDs4OQpNz4ArOsbIbMF03ZGwP4XacmICBN
    ZD1Y+I05/WncN0OnkwuzL442AMLZRYQCvk9/ht5Yiv80SedU7pSA774b0eLoLfUe3beYAh
    o+oXpVS6TKQeJNElKsm2eqrK+JUdlnrpp8VeyRBY1hIaqGpMZljAoO39/Q00vV1nBzFGrU
    +3QgoDC1973ldN3yohXzlOwY1gYZIb67L7KRxrfjvsNTSSV+HfBen/n8wnxafHVThAaJZU
    L9N9mjVw0oIhZdCLE5qtTAC89m8CofWRHgZDXsLxlSTON3uQzOfyDhdNaucg
X-ME-Proxy: <xmx:siAhagSVMEcZNsJxc0WfYEZXiUk6BIR380Afe8_j8m2Nd1nxqLUmZA>
    <xmx:siAhakqGoje98t1bT3Pm-WJkZN6iTz6I2mAgmKP3shtC6rSffTJs0A>
    <xmx:siAhaqwqo7dGtOpOy21njHjGvEey9b2PPzQtowunVf2-U09Fzmur7A>
    <xmx:siAhahK9MrUUIWTkEJFjETqiTW6AzlpEMoLrkBjDVetw-cG6LWpkHQ>
    <xmx:siAhauDC26V1R-jsrMb9R5-et6yUR3vallTdFhpYphwf47HsEdzwCk1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:52:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4109672e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:52:32 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:52:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #02)
Message-ID: <aiEgrfVanSZzbmkI@pks.im>
References: <xmqq8q8vowvt.fsf@gitster.g>
 <20260604062122.GB3194609@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604062122.GB3194609@coredump.intra.peff.net>

On Thu, Jun 04, 2026 at 02:21:22AM -0400, Jeff King wrote:
> On Thu, Jun 04, 2026 at 11:35:50AM +0900, Junio C Hamano wrote:
> 
> > * ps/t7527-fix-tap-output (2026-06-02) 4 commits
> >  - t: let prove fail when parsing invalid TAP output
> >  - t/lib-git-p4: silence output when killing p4d and its watchdog
> >  - t/test-lib: silence EBUSY errors on Windows during test cleanup
> >  - t7527: fix broken TAP output
> > 
> >  A recent regression in t7527 that broke TAP output has been fixed,
> >  some other test noise that also broke TAP output has been silenced,
> >  and 'prove' is now configured to fail on invalid TAP output to
> >  prevent future regressions.
> > 
> >  Expecting a (small and hopefully final) reroll.
> >  cf. <xmqqtsrlw09t.fsf@gitster.g>
> >  source: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
> 
> I guess this is the source of several CI failures on jch/seen that look
> like:
> 
>     Test Summary Report
>     -------------------
>     t7810-grep.sh                                    (Wstat: 0 Tests: 264 Failed: 0)
>     Parse errors: Unknown TAP token: "/bin/sh: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8)"
> 
> This happens in the dockerized jobs whose images presumably have a very
> minimal locale setup. I don't know if this is a sign that the tests have
> never been doing quite what we expect on those platforms, or if it's
> simply noise that is now being caught.

Ah, thanks for flagging. I'll investigate.

Patrick
