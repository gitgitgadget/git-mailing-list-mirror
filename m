Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816073;
	b=A0OQ1WF7vQ2KfUfsCwWJxzE9nM4ppvHbr2SVaQm3ue3RNmh/XvTjX1W34Ol53FNr4vs8
	 hzVWOl5orvtwB5haUrPNThGsR6JqRXnklwslIDfm/4OQQ5xJktJORWnfE9Otzokfv+iLi
	 E2ZtWdOXCXD/rSZ7hRW3HAeIga4bm1cn5xGvuHkrmnwXOQTK78SvWOvUIDHhE0NkH+vKB
	 t9uBU2YuV6bTKfvhDIvT1NDaSLeqD1THIEFf4oI6xOeNH2L5BBaXO1nQKqRHldHIxvkOw
	 +iG4IuAaRzs9cQRsu+6WsMckco8nHbVs9LhRHAh9aryY7sMB1AAxsfTABqvXdp/62gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816073;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qjr4I9ikNMi09j2PQ/unNMgTwt7xMPRmuhTzr923t9Y=;
	b=q4Nh3pXCc4cfIHq28+1+5cnyqqI+wevkJUSQQtcG7xn6h1k67fopU3P2PJ0p155MdSh3
	 W4gazhNKraIc7l9MRaIthBCntDNiPbuAqyIwVOToFDq5qld3T1DE5SKEEEu2+fE0/prVw
	 ufSSoRM3W2YRkdasmD1biGxisnhaO5yUO40gqbWPsYhKG/pzmxeWH9mygNHfZQkT75dVy
	 aAk42iLS6/nOfL51ZrTebvvMmO07zkSSlK++fy33Kvb8Pb5uYIG+QioxAVx76eWgEOULm
	 L6jbHwtAvF6aX6cXTje2FG6cNzkRXSt6nWH3XMqwJyAJUbru5s6PfYmi3YrsUojUrtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=b4m4jtAw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=27rcjLMI;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E571606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E571606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=b4m4jtAw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=27rcjLMI
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C0777A0185
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:01:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Nov 2026 03:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794816071; x=1794902471; bh=qjr4I9ikNM
	i09j2PQ/unNMgTwt7xMPRmuhTzr923t9Y=; b=b4m4jtAwYklpIBF0oCqaoJA6Os
	cGiRm7aSuf0RbHGsuiIEbsglxOn3c5USF3UquSgAK+IxihzNIAJNXW1u6H+6Pr5W
	ahVsAyUSqz1q3FjP18VGSBLtaawSSqTefPA5ph4wTQIKUV+8oP/0Npm9h2zOUrPB
	XIvR1lYji4W0HuU09lsJcZnG5KQK9GrLGfNrdkGj3ohjew6qLJNFA+n+D3uhzTTq
	yma2SeW/8P59PKhngV4vB+pxSeyE9AcJjHCsugMObwyw+XrXRkNgoEzIt5uqyG4F
	n9XYdudynIr5e+oJpDm4mvaUj2RzPK14HuT6UK1KGoaIeDcSwgBl+SGvFvMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794816071; x=1794902471; bh=qjr4I9ikNMi09j2PQ/unNMgTwt7xMPRmuhT
	zr923t9Y=; b=27rcjLMI0Y1NH7Y1Q/4TpSeoOX1BjHqSfH6FIKhrMs1liE9HyhB
	GRh2U5C+07RkGs9hDZcRGWe3f3epzqtGfEgKm4erqGePWINieSns/qZY8XU2/33+
	SoIZJr43ToiNj6jvR4v3clYKmO7aHGZCze3xH9Fw1I70zu1Fpz+Be1J0vzxxhjBO
	tX8FXqOq0u6vBu18C705JaN3mc5Tt6BV2yAb/iuwNiT5Kg+nAPUCLHnSr92Lu0Gt
	obFLrjCsGiIvauEEMcrPLQSrd8JxXU7xdFAufwpd5/RoTJokLTmu/XzEhm+IzIUN
	BQ6byWJdProogAU+6QoCJU21nMUQ1LoXyIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794816071; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:OoK45bZ6Vn/nUXt8kq/sEH+849nX8tMF5FSGsIGznwo4NY0
	N5H4eshgSu3uV1f1w1KoH8MfQ6snEHcxulRf2B16uwzAzYCR49FuYMdkbFnTssY1
	u6XQGKdggVzr6LTJr/oUhdlWHvpH7lWhpl3uBU4axutLgUll4+yhHBDzjKTrZ/fR
	kZQEtXQjSmH9vvLKdB+WheCeMg/iTFfJ5VqecDDj4RDiFC7R7ZdrNim71yHANiyq
	70MojcUvhz/regvXUGVjLzRbvLhcqy92xMQFqFB1gnxD6KJ4eg/oaI1FVg3kQuVq
	ziJFnn36CbZ3bkjDLbTJGkxcAOzfFRLYCPmhLzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ehGtX7juA3yNjB5D2ICg+SgIPOws5jCjxpjTQcHQT6s=:NWR+nQWOTK03V3iCoN6lW+D1JzQtkamckwr3zlPzdwM=;
X-ME-Sender: <xms:R7j6aoEbpYNBqMd5UjY3Hrj4NxEgTHs2FUsIu9ienu3ROO49bhHePA>
    <xme:R7j6aoOCG7hdWbFJrRqHlCjIhmGyD4YBN91BjwMj8Ax5N476a0dTgWYnRJBWl3f35
    RMdCcAtd---QpZ3z-zkHJIQfWeEunYXxctcVPLVseifesFMvNC64qY>
X-ME-Received: <xmr:R7j6aqfWzqgQ3JSgq8S0wdhBdrxNLD6kogCJvO0_Vmgp-iwPPf2e7zfpofk2n5zlC4EBfpE>
X-ME-Proxy-Cause: dmFkZTFZ9JhNd9GiBhX8PZKSCOqEvR2QYF/dFvxpKvr2l0haYiCYqEvrE/QjqCJTGUuiN0
    MZ7gY6ltp33TKIGTLI6O5r2+rjPVMyY1k2R/Ng/4CVwzh7y05gix56zMnu9YQQJLEINsLJ
    HJ2orev954lJ9XS51O5qsyI/gRLp341XUPGyUB12/q9fI0HJK/biiRf09itw8gd/ceO3O4
    X9glPwoNapQLaV/zsExSD3IV72QVWttz2iItit/JkoAhx2NL4Mq+GQcL7gtu0WbItlqFeT
    Z1Rqq8cjM9lhn8x6+LqFa8VWBYWYo0Ao0FyJ7Y6JFfIm5phH7OGF8s+2Dj08PrCvQXejOi
    NHiGEsu8Ah3K9+uoqAoigNRqyDg3udqEV8vy0rMrTNw1ZZcDFxkPTIjPZZSJK9nF1f3u/V
    2YTguvy0/KPfwmpj/6f7tLRwNvJ6HT/nEUxV7Z6KBzTbvFhG9ItI9MOZ+WXw57KpvuNWfU
    ikRqE8k7rqfhpMnDwk+rYOkLUW9eU3vPP7WT2mx2Xq57MzNzhpXbugtCW5fNBfuASatF22
    FiuUdZgaqp/MB92FMmOcMfnWTVUPccH1PtrFJPrRNPYPF6oLbZBXnhfZBArbYonuB9gGr9
    1VcjbMW0VtYrqvHzzXZYcDjEDdwTR3cKome8Xtg9CnJ7mYFI4DS7xRVlaoMA
X-ME-Proxy: <xmx:R7j6aluZgO75AI2k4QhTas0mnlaY1eprzhvetDGzQ85k01-qeAtaMg>
    <xmx:R7j6arnKgpVOe6om-TRH7q4BAEYSFt5gcjCK39zDfqLrdlDT_A-Mlw>
    <xmx:R7j6anzgWn8VSbE99yEgDg-jM7Hz-DOcwgDs5q63K4io77WFXiVtJw>
    <xmx:R7j6atNE6q-ajcTz64KdwI8PLrXihcjIjJZQ8BxM-AYZi9f4GuEilw>
    <xmx:R7j6aonTCtUSriqSjplvHAggM9KhRf12flXsfDiIrXVigWI3wyVaR1iJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 03:01:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74d423a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 08:01:09 +0000 (UTC)
Date: Mon, 16 Nov 2026 09:01:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, jltobler@gmail.com, szeder.dev@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v2] log: make --follow following renames for non-linear
 history optional
Message-ID: <avq4QewLSGVLkCjv@pks.im>
References: <ava1ax5UFfcvkU_d@pks.im>
 <avqyVuMvKeQshZYS@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avqyVuMvKeQshZYS@collabora.com>

On Mon, Nov 16, 2026 at 08:35:50AM +0100, Miklos Vajna wrote:
[snip]
> > > +	if (opt->diffopt.flags.follow_renames &&
> > > +	    opt->diffopt.flags.follow_merges) {
> ...
> > As far as I've seen we only ever set `follow_merges` when
> > `follow_renames = 1`, so it feels redundant to check for both. But on
> > the other hand that's a bit more defensive, so maybe that's not a bad
> > idea.
> 
> My thinking was that follow_merges is a modifier of follow_renames. If
> some code path clears follow_renames later (like builtin/blame.c does)
> without knowing about follow_merges, checking both flags means that we
> still skip the per-parent rename diffs. So I would keep it as-is.

Makes sense.

One hint: please reply to review feedback on the mail that gave the
feedback instead of posting it as part of v2. That makes it easier for
others to see which review feedback was addressed.

> Range-diff against v1:
> 1:  cdf63f7017 ! 1:  cd19ed03cc log: make --follow following renames for non-linear history optional
>     @@ Documentation/config/log.adoc: This is the same as the `--decorate` option of th
>      -	i.e. it cannot be used to follow multiple files.
>      +	i.e. it cannot be used to follow multiple files and does not work well
>      +	on non-linear history.  If `merges`, `git log` will act as if the
>     -+	`--follow=merges` option was used.
>     ++	`--follow=merges` option was used, which follows the path separately
>     ++	for each parent of a merge, but is more expensive.
>       
>       `log.graphColors`::
>       	A list of colors, separated by commas, that can be used to draw

Good, this gives the user the necessary context to decide why they may
or may not want to enable this config.

>     @@ builtin/log.c: static int git_log_config(const char *var, const char *value,
>       	}
>       	if (!strcmp(var, "log.follow")) {
>      -		cfg->default_follow = git_config_bool(var, value);
>     -+		if (value && !strcmp(value, "merges"))
>     ++		int b = git_parse_maybe_bool(value);
>     ++		if (b >= 0)
>     ++			cfg->default_follow = b;
>     ++		else if (!strcmp(value, "merges"))
>      +			cfg->default_follow = 2;
>      +		else
>     -+			cfg->default_follow = git_config_bool(var, value);
>     ++			return error(_("invalid value for '%s': '%s'"),
>     ++				     var, value);

And this fixes the broken error message when an invalid value was
passed.

Thanks, this version looks good to me.

Patrick
