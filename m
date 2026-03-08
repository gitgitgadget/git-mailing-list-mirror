Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FF35AC09
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773013248; cv=none; b=ro/mYWuwjm3BegNO7TlGRIh+M7yBopqX7rsP/LzxfjCGgXH3ZIK4N22brR9aA5rNTjio4FinNzWxaC83Cf0JubKlFAjeS7B7wUY4fAiaJ6hL/zbmA1FDU/MQsHu1T9ZJ6yeHE2lfC2l4DnKX+nmSySoEgEeXRmTxpzVXOQ4VZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773013248; c=relaxed/simple;
	bh=Ka6KxbXTSQXo+S1UOa6J8fKq4/7GttqsXbB3texjSjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BNS5UIPlEbV/z3+p3p/8jXO7IVAkpqDHj7XLUGPHA6FQDlyptPQeqxlIZh6j8ab/hcymYkqeIxEqhpA8dSqchXf2IIKzfX2++qKjoDq3XPwOZSh2Sqm+MLSYWin8JTwrij60fXaVjpGUbD6TLJIdaVCQnxvLUXxEa6gXxg6kkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OoJYM3Pb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AUfT593c; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OoJYM3Pb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AUfT593c"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAB3614001CB;
	Sun,  8 Mar 2026 19:40:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 08 Mar 2026 19:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773013245; x=1773099645; bh=ibztBGacFB
	LHDUaZngWDUs8EZNrcM2vHBJ2zDnUquy0=; b=OoJYM3PbvdvfL34jBYem7K3jMB
	WbWJy9zlNAmNSt5f6d7bZvO8Iyd+BBLfpwhLy6wLIVhFbuojBaTZGmQ92RNXrGhk
	K+gXz/PGpEak10LuBunjMo8Pw6Q30T2yu6P2Hr3aD4nHCAJP/rlJLAeAyYGYNSAh
	aBJz1cX6MhkU2larbzr9NP8PDM+fQrtG1bA5YnH8jRzoQxCJV9CXJLFzDmsskwU0
	wcahz8eueVmTv8u5PCnq8ye2HRmNuidjc4ajLQvN+StJsv/EnsV8uPknqU8ZKh6Q
	yt6k5VycWRzhsXYZSbYmSSnOzJ6JwGMFUMMjGAzH7nj9xH8FnYdKnzvKskdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773013245; x=1773099645; bh=ibztBGacFBLHDUaZngWDUs8EZNrcM2vHBJ2
	zDnUquy0=; b=AUfT593cLBLpangM5UOYNFvRhAGnex2/OWlXKr+X0YXjmb3IS50
	Rebpsx1cBIm07OXd/b6NwzaU3h2c+Vfudlv/Qot7bXcCk7+zmbOXz5z9epFcxcIL
	g0hrfH0rvagqfjLYD4dKl09rWkRzqZgwHVGHNqUD2oDHPS4R6L86PhZ4MrneoFgx
	BSGyn9IkjaL7I8sbNGL7xR/kOqNbOG4a0qe3C6cpb4m4z1Irnq8gAkIrBXTXmaTk
	Ohl5K6CQaarSvY5pkT3NuV8lTKkK9kxVb0oxuN9La3vHkuRvZbtj76GHlFc5QiiT
	t9lU4vsrTNj1P/qiwGuC/Xi6kJnUpNacC+Q==
X-ME-Sender: <xms:_QiuaUBtgd2pHjQfEpWhq2lcOAXOYiw29jt690xqOymTu577zdYxOQ>
    <xme:_Qiuad_7FIETyusjDDGDDKShY_AfgD_aan_jxKU32qJOUpT4FreWPlXosi041HDsV
    hHTXDFH2OVlIltXhRpTu0AIn17A-BeYeydrcJBALBLM87otEsOevw>
X-ME-Received: <xmr:_QiuaU-gS5i9SLElkwPZESSWiRoAHf2KEd2dIEhFmxvuLD7BifEingLRGgYNpuPfaVpVEyfo5DeHh6emMSlDpIXZ09T1aL6p7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeiheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeefleessggr
    rhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_QiuaUe_2P3CiCqdA-CPwHmZiEK1NNuWcbXCTP7X5NU6JXdK3uicbg>
    <xmx:_QiuadG2-CKqZWrv3oJRqNrwp2e2YOECrndclLnTRnqrHUafnfqPGA>
    <xmx:_QiuaSceYykd3_0WFr6gtK1D3o4WTMOJbqzvCAY9sp5uOKc0ssQlGg>
    <xmx:_QiuaXHqEbiM949nENusYnDLm_efyQs7BOlgmDkXtLufObtMsQG4gw>
    <xmx:_Qiuae4YyBIethfx2ssScTyRuxq_kNrHwFjtt33nUMsdT5xGWW_ImX35>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 19:40:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] parseopt: extract subcommand handling from
 parse_options_step()
In-Reply-To: <SY0P300MB0801422323C4C4185B9617A1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Sun, 8 Mar 2026 21:17:21 +0900")
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801422323C4C4185B9617A1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Sun, 08 Mar 2026 16:40:44 -0700
Message-ID: <xmqq1phtao03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> -static enum parse_opt_result parse_subcommand(const char *arg,
> -					      const struct option *options)

So, this function used to return either PARSE_OPT_SUBCOMMAND or
PARSE_OPT_UNKNOWN, and the caller (in an "switch ()" statement in
the parse_options_step() we see below) expected only these two.  We
now instead ...

> +static int parse_subcommand(const char *arg, const struct option *options)

... make it return either 0 (success - we found a subcommand) or -1
(failure - we did not).  The updated caller does use the return
value in "if ()" condition to return early when we found a
subcommand successfully, which is a lot more straight-forward than
the original "switch()".  The original is even worse in that it
enumerates other PARSE_OPT_* values that are possible at the time of
writing it, instead of catching everything else with "default:",
which makes the switch() statement a maintenance burden.  Getting
rid of that switch and clarifying that there are only two possible
outcome from this function alone is a good enough justification to
have this clean-up patch.  Very well done.


Editing the hunk to show only the postimage reveals that the new
implementation has CodingGuidelines violation ...

>  {
> +	for (; options->type != OPTION_END; options++) {
> +		if (options->type != OPTION_SUBCOMMAND ||
> +		    strcmp(options->long_name, arg))
> +			continue;
>  
> +		parse_opt_subcommand_fn **opt_val = options->value;

... here.  Move the variable definition up in the block introduced
by the for(;;) statement, perhaps?

> +		*opt_val = options->subcommand_fn;
> +
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +


And the part of the caller of parse_subcommand() that used to be the
switch() statement in the parse_options_step() is now extracted into
yet another helper function here.

> +static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
> +					       const char *arg,
> +					       const struct option *options,
> +					       const char * const usagestr[])
> +{
> +	int err = parse_subcommand(arg, options);
> +
> +	if (!err)
> +		return PARSE_OPT_SUBCOMMAND;
> +
> +	/*
> +	 * arg is neither a short or long option nor a subcommand.  Since this
> +	 * command has a default operation mode, we have to treat this arg and
> +	 * all remaining args as args meant to that default operation mode.
> +	 * So we are done parsing.
> +	 */

Thanks to being a small helper function, we lost two levels of
indentation which made this comment a lot more readable with
reflowing the lines ;-)

> +	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
> +		return PARSE_OPT_DONE;
> +
> +	error(_("unknown subcommand: `%s'"), arg);
> +	usage_with_options(usagestr, options);
>  }

It is clear that there is no unintended behaviour change around this
helper function and parse_subcommand().  Very nice.

> @@ -990,37 +1016,16 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
>  		if (*arg != '-' || !arg[1]) {
>  			if (parse_nodash_opt(ctx, arg, options) == 0)
>  				continue;
> +
>  			if (!ctx->has_subcommands) {
>  				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
>  					return PARSE_OPT_NON_OPTION;
>  				ctx->out[ctx->cpidx++] = ctx->argv[0];
>  				continue;
> +
> +			} else {
> +				return handle_subcommand(ctx, arg,
> +							 options, usagestr);
>  			}
>  		}

Editing the hunk to only show the postimage shows us that the blank
line at the end of the "if ()" block is funny.  Drop it.  Or even
better, as the block either returns or continues anyway, lose the
"else" block, perhaps?  Which will make the above read like so:

			if (!ctx->has_subcommands) {
				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
                                	return PARSE_OPT_NON_OPTION;
				ctx->out[ctx->cpidx++] = ctx->argv[0];
				continue;
			}

                        return has_subcommands(ctx, arg, options, usagestr);

or swapping the logic the other way around, i.e.,

			if (ctx->has_subcommands)
				return has_subcommands(ctx, arg,
						       options, usagestr);

                        if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
                                return PARSE_OPT_NON_OPTION;

                        ctx->out[ctx->cpidx++] = ctx->argv[0];
                        continue;

may make the result even easier to read, perhaps?
