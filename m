Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084737268C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933486; cv=none; b=DAFp1orOu1q53dyV9ucgsR9/PKrauQkYsm2D0bqBPg8Dwoz6JZCPO26R3UvJSjnAKdxOTMw/D+3bIQ25Jt25sLDS4tDQSN5ClG+j32SpDtmSoO7/ql1dng/VhBqvsbXDI4/7WMwTIkBsd2olF/GEIcxhkiJ6nWPkcWWO81nE2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933486; c=relaxed/simple;
	bh=aJNCSNSBpKOhqt41xOzrbnRSRmiJVWJ4FO67LX2pt+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caW2T7XHwWsLdPo6yb5uVDTw2y52C5ahJA8NmUtzdbnaX4pimTK4CmR3oEO7mePfaO6CWWMVjeFpPaeBolkQ9djDLO5RHMDylYreYZz+vZuFSQKdXLN07Cu5elKD/0VAxaPn166wQRRcwarjfbsmo+SzUMuvgCWFa1CD8tROvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y5aZhcXl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJQR3dz3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y5aZhcXl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJQR3dz3"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D62D51D000D4;
	Wed,  9 Sep 2026 01:58:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 01:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788933484; x=1789019884; bh=MNIg0KjKki
	EqlkC8uZ4j1ZnDcT5EDbxRGnUWBGAPT0w=; b=y5aZhcXlmHFhSk2hti4Y+uBm1a
	6vfdvLX+RHZYRqOM7X6mKWP08UeUtGE40OHxnls/7N0ipURE2aeT/XUDZvxZM6Q0
	QNlUap+B2rd257Q0X9vnviMxA1EuUhkQGU7v2n8txSQi6+hSS0dfjR7bfx9+7Sjr
	GoC5J/Pz4r/7TezIiAAgWgyb0g8bozcvMipUyfFzXEqKPSuVsZQihpclTT3Dfk6g
	0e7dR/R75vWMA47Gjzyq39CoNK41IcVae1I70FJNtwxXVu2BGyfYIBOXJuH9vmCk
	VtGhdR+vCjUHHCEJ0X24lKa8Duqz+sqFmucl7ys4bBrLdfEmsnyk3Jlmtmyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788933484; x=1789019884; bh=MNIg0KjKkiEqlkC8uZ4j1ZnDcT5EDbxRGnU
	WBGAPT0w=; b=JJQR3dz3EoBYU0eAX3MwUx9t9gvUxX+106FILD5UEqNe2nAtaD6
	LLw5++2hIyrgBPyiz4dp1+T9EyS0fsR1wxxjSbjP5OcpMYgtIRBVnaKd+qj89t7Z
	IdvBhe4l6PFMRJdEpcOUm1/tfSDv0zYsj5Awy7oqZryotzKFqFbkwzJ4Hy8cOWf9
	9kcJhsDT+/d14I1Bv82zl+bJSXlbXRlrAb+czqtVn053gN3kIlaWIOOSt5HTzB3p
	hmmcTL090AWjFHZrAdHXzRnSsXjuetWze9meLGYY1KamDXaweycYDPeKbK6qHl+P
	uGpGppN+ALYY1JhdQ9EGveHUAw2Bd4LYXsQ==
X-ME-Sender: <xms:bPWgakEIYiSsXX0E7nBIVnLl6IHjjtkg6zs6Mmq2MwJDRkQjeQeJEw>
    <xme:bPWgauBXwxkgwaaKFkhjAGWrXQzFKHT7qN4hqplcYWaQkb-_RNU9jhVTDpxLz-nt-
    HpvwHp13md3hDtw8vX6AZ02VZSQ-gglpbhbfaUQOKYvl3_FRokaLoI>
X-ME-Received: <xmr:bPWgasV-VAPEO8e90lvCnVQzvJz6c7CwDeOioB1WaVgolmAd8nTuKaeM1haHMt9BypGVXA>
X-ME-Proxy-Cause: dmFkZTFsTjzmcP91mI+yZHqymkIiMDnXcie6o10o+bFBIZG2mxBwSL7XCpGvBvg2+i0y1M
    B8+JicRvagy4EMGt40FU0ZHKgsGVF4iOp73Dp6Cb0RqDHLxrCWF/q7v72e1O8LCGF7Lr7u
    kc1kcFiiYxqna2qLNVZmBJsMP6Fu7RXx45yaY+ifMcZvMFVC92lUtbAkRYj9rrdHlazj/g
    3oqXrerCXV9De0iOL5KkhDk6BpNTgaaR93gYPySNgRCQROxwDfHMGDu3/rsZ4Qqc9N3Fz/
    bRfY0Im06+ovRZZv8D4XUAAjxtLg5Dm43Vj9gP50pwh/Q/h7ExGG7+deBNvEdMGSzbhiIL
    neJwwaHReMevDU2e1CprdWdAswpxC4qkjKHg4/CPrL02JwuxZCyiOLLWTi4uGWFGJeDFpH
    BSNwNdO4jmyHEP9jX2GXymGq/3A8HzwcvRr6+toaQw0DqWH3VQcV/csKtb5cUS116WU3sB
    8Z37dqO6G5dabj6GatEid/Sk1nsn2trUtAHpaqncq3ouw3Tea2Ime/bFuualL3w1NXCdeO
    /1URMP3VEO0hSE898VAi7e1EWMvKLhoPJ9oQPpMB4kwD1bIFXFftxXjKixBG6QEQrdawqf
    B5cDH1MKYPyjOqmUIMW4HkJbeP8ugJgn9DavcicVFZwdR6XZbdDhsA5365wQ
X-ME-Proxy: <xmx:bPWgaqpXyFprgyB74ztUzRykhaMIn45_CfGO3WlFcA-dhVzq8O90PQ>
    <xmx:bPWgagRrolaieLAFJLFHVgzVmD2LvA0y2s5TOm9xoCx2IwKblNk-7w>
    <xmx:bPWgas0jZn1GN-HidDJX7gaAun3ZKT12JGaUAPcrV7EPYZbpQwzojw>
    <xmx:bPWgakAqMINKaUDrp33mNSYyfw5DxwmWiqBcQFvDTMKcUzZCmIjALg>
    <xmx:bPWgaqztAFqV-nFrxQOeZ3ac3LOXVjR04miH6gQg5kBl6hkPmxxN9fxc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:58:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eaf79747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:58:01 +0000 (UTC)
Date: Wed, 9 Sep 2026 07:57:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v3 0/3] sequencer: leave auto maintenance to the end of a
 sequence
Message-ID: <aqD1ZlaLsJ7K04Bw@pks.im>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
 <xmqqse3jyc2m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse3jyc2m.fsf@gitster.g>

On Tue, Sep 08, 2026 at 08:53:05AM -0700, Junio C Hamano wrote:
> "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Changes since v2:
> >
> >  * Auto maintenance now runs from builtin/rebase.c and builtin/revert.c,
> >    once the command is done, instead of from three places inside the
> >    sequencer. That follows the apply backend, where "git am" leaves it to
> >    rebase.c (Patrick, Phillip).
> >  * gc.auto=0 dropped, maintenance.auto=false is enough (Patrick).
> >  * config_parameters is a char * built once with strbuf_detach() (Junio).
> >  * Patch 3 extends the tests of patch 2 instead of adding its own. They also
> >    assert that nothing runs before a stop, and cover a single pick with
> >    --edit and a sequence ending in --skip (Phillip).
> >  * Commit messages rewritten: what GIT_CONFIG_PARAMETERS is and looks like
> >    (Patrick), what patch 2 changes for the user and why the call moved
> >    (Patrick, Phillip), and the comment on the helper (Phillip).
> >
> > Based on master. Independent of the rerere lock fix in [1].
> 
> Will queue.
> 
> By the way, is it just me or are proposed log messages getting
> longer and longer with more irrelevant detaild these days?
> 
> If it is not just my imagination, this trend must stop.

It's not your imagination, it's gotten quite a bit worse over the last
couple weeks. I also started to push back on this trend, see [1] for
example.

Thanks!

Patrick

[1]: <ap-iEoeY7XKjeZgL@pks.im>
