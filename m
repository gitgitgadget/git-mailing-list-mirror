Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687E1EE7C6
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663419; cv=none; b=clcMNN8HY9UIXf9NDEEjQb04nGr/0w8H9K658dteNDD2V43bOzRtCB1GYuSExcU+P00xYIqV23gxUOSH32xrQYKjot7EHDsLJvXJJwSNoBWKyj+QJc3AsGH12PUobRl1tdboAG3RwGtxDdcxZQuWoP0u9A6Ma8sCcInaMwSo9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663419; c=relaxed/simple;
	bh=sPLbKA4fKYzJm4Uk5l5QuQIS+QYXUbiQ+EevBo/yVG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpoNTSK759KctBdoZP27aXdxaM1f/Y7sRAzAg4xHz9R1Yve+9hsfbNPfYrk7QOYNRuloBQ7DoaDX7q2ZVVz0t3XE72Do6Bgh1puAgVKXMC6Xd7hQ55e35R0k5IIkTtbhVpRP9z3n6x/k305uW+5ygjfuMdJojESPvsCP4TOlVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YeucRZRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdVA/hl5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YeucRZRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdVA/hl5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E8480EC01D1;
	Wed,  8 Apr 2026 11:50:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 08 Apr 2026 11:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775663416; x=1775749816; bh=MJO+IUF7Ub
	P0wo0ZjpD/xFZJMIdzYXAuX9WnET7Diwk=; b=YeucRZRwmC4g4ZHMlC7x6DlkLS
	ADsU8HLsQT5LBYIqbniKnWHXtN21g0JsAeM90wKYhm2vjrZrfTG+XnwpH5+n9wiC
	6TDlsFWfqyd6fJsSwFh/ciIw4F8CwQqezsO8I9LFCPFMQpkCxzPK4C9uKVHv/VV7
	nEGXsdBrJvGyehI3WCz7dvXHLhA3tK65gSCRIeW76E4yIColAlJb+vTcMK/kzQBJ
	QnrT58OAqw9/OSp7a3Ykyzm5jfraISZYxtYBUZzp/0nZUg7T8lSStXStj+NxAHXF
	rTxcZQcpjBMDVri4619ONHSAIP3/nUok5gz0UwAeCG0qh/aTsvZBQeUBTPdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775663416; x=1775749816; bh=MJO+IUF7UbP0wo0ZjpD/xFZJMIdzYXAuX9W
	nET7Diwk=; b=LdVA/hl5BV5Q3faCD5jHsiD6spY4Sg/iVnwC/3QHXDbeO2fg/wK
	ngKbnzhE9tcbLs7Q9/BExnKWYUM9/eUKT1XHw9SUUqs7nYnmBbBQ4eVG2vgzFlXY
	uB1PA1029sdlUpCBcPzXPk/w4+4tIvi4WSEk0hNt41PBVLPdoxToe7vOz/zrjMrn
	ab5FUc6w9Nhfg8C7vFay3hn3gGhwoLgy4qCm41CaaJpKVBB0oHo5uEVBN1bnOgrU
	7abygIkyJtNG0tT+cM/veJ2uznyDiyJZKQ8PKhm/4AuPwqA3wowuzirq6dKuQu2f
	QmL3ww+jp3Pna+hewcfHMlUsAEhsj2Cwr3w==
X-ME-Sender: <xms:OHnWacGupt9ansgXlcdYRAvV9OtQI-mDLz6UQ6Ef-R1iS-1SAIiBdg>
    <xme:OHnWacO0Eo48L0bUNWdHQ_G-qAkEQizPTF8FevVvfSqoCS2LGyfelUIw9-SFbWcCv
    Rka3H0UmmRoKu5jvEbG9w5eBfhLvLECh15Gdo1wyxBAdy_M0evW1g>
X-ME-Received: <xmr:OHnWaee7NK2J2tYwrRAOd-Cd7VGSouQYvToDIjWu39MUaIc4x-kKE_V8Ak8PFgUAUgLqL34WjeovaxN49L7MKG6QIurxlbXacQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprh
    hssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoheprggurhhirghn
    rdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:OHnWaZu12jD_9jzygsmyHvmoOt3wtwFXO8bQLQ3AhQFzDKGQb1R7Lw>
    <xmx:OHnWaflRQlY9eRAXojvUNzlpqTHLMcLxiXYf59GsX_SYvsNkZ77OTg>
    <xmx:OHnWabz2atOOU3qFP8nJdJOuDYDWfrzYRh5b3EZpSilsnEPfsKm_7w>
    <xmx:OHnWaRM-wfFGad5H_grfdHOI_HHRqE0omcCva_IZzW6YuPeZjWOs0w>
    <xmx:OHnWaZrYBjDnQpPLurrWDO-AyOFwQOkxQVnLXj1Q2vLTmfAEyvnRnlUH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 11:50:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  Adrian Ratiu <adrian.ratiu@collabora.com>,
  git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
In-Reply-To: <20260408052031.GB1324339@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 8 Apr 2026 01:20:31 -0400")
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
	<20260408052031.GB1324339@coredump.intra.peff.net>
Date: Wed, 08 Apr 2026 08:50:14 -0700
Message-ID: <xmqqpl491mfd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think the root of the issue is that we should not be trying to
> propagate SIGPIPE to the child in this case at all. Our handler is
> pushed there only because it's part of sigchain_push_common(), which is
> sensible: in general if we are dying to SIGPIPE we want to do our
> cleanup. It's just funny in this case with the ordering of our SIG_IGN,
> because now that SIG_IGN isn't on top of the stack anymore.
>
> I.e., I think we want to reorder like this:
>
> diff --git a/run-command.c b/run-command.c
> index 32c290ee6a..8a95f7ff1e 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1895,14 +1895,19 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
>  					   "max:%"PRIuMAX,
>  					   (uintmax_t)opts->processes);
>  
> +	pp_init(&pp, opts, &pp_sig);
> +
>  	/*
>  	 * Child tasks might receive input via stdin, terminating early (or not), so
>  	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
>  	 * actually writes the data to children stdin fds.
> +	 *
> +	 * This _must_ come after pp_init(), because it installs its own
> +	 * SIGPIPE handler (to cleanup children), and we want to supersede
> +	 * that.
>  	 */
>  	sigchain_push(SIGPIPE, SIG_IGN);
>  
> -	pp_init(&pp, opts, &pp_sig);
>  	while (1) {
>  		for (i = 0;
>  		    i < spawn_cap && !pp.shutdown &&
>
> Does that make your problem go away?
>
> I suspect we could construct a related case that does fail on Linux
> without the patch above. Imagine we actually have two hooks running in
> parallel. The first one is fast and does not read its input, and the
> second one is slow. We'll get SIGPIPE writing to the first one, and then
> kill _both_ children. But that's wrong! There is no reason to kill the
> second hook, as our intent was to ignore SIGPIPE.

Oh, I am very much impressed by this analysis.

As -rc1 has already been tagged (but not pushed out yet), we would
probably want to apply a fix before -rc2, I suppose.

Thanks.
