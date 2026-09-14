Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390533AFD1D
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414470; cv=none; b=YEhtX8RtEUCm29p4Z0XU1QAEMQ9MT85LNf0lLQ5FbjdP2BpVp36rNV+cQjcQlVB+MZ4MSdNDqIXrQzLb9hFSSElC2eHTa4ThTjEIA4iLlN5rLg4p9n8iKT49gmh5UflMZ+YoCsN6HFMeeaKo6nQFXnPgwXu9G6utUdEuq2YtWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414470; c=relaxed/simple;
	bh=L4o3cFi5xKOSo9sZOEFHhAgW/iHXJ3ftjp7LXRtqSrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mw8Y8fH5YAhHT/BI2aZXsqI09W81VfW1AKodCMT01Fpn4o64tClb87nRmI+fxfuFaDFJuhYvKqqWXJyHEAp+6Avc/mW1lGZ0nQdOMCaAV0jS8Ot5dKmjO7f+y9juu5wEvLJ/qloadWQCOR53hl5F8RNWIwjAVJfjzpH9CbHNQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sars48SM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sIg7NDtN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sars48SM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sIg7NDtN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A46897A0101;
	Mon, 14 Sep 2026 15:34:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 14 Sep 2026 15:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789414455; x=1789500855; bh=GnyJ1lWCzY
	979R+ykc3ciyF8DNYKkMTWfo40Y9HtZSg=; b=Sars48SMonClHvVSBEIdyxOOGY
	PnTYXfrW3ppn92GjHjRCIfM6jr2QDA62L5lXfvv+6sboYoZAGTk2PNr0M/D9uuPF
	NfvMj+uvx+lI7iglU3kKoPeTKCGSwn/gtSYeR4xHeVPBzgld40/MI7M/ghNJ7qhB
	hgO9KmB3beLZPySfSM9zCkz/mzjr0D3aXAhA3tgdjrSlFoMkFpKxf4lV6E1/qWOK
	PeQAmviy0V0Rts8ceZe2C/cia89F3ikeBvPwUwbxIo5wpA6jkOWkhVGlYXQy1Y9E
	l06z4mn4mMScaLvCdZEXYLMj7A6tGSTb8IOyYBWY3BAv69TLZmmcPc72yjsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789414455; x=1789500855; bh=GnyJ1lWCzY979R+ykc3ciyF8DNYKkMTWfo4
	0Y9HtZSg=; b=sIg7NDtNh6hZrb2bekF3HHfjQsK1NoI22ibZ5Y3qGX6FOQSAYG2
	+FX+uZYiZ6Z+RiKocD3b0Kw2P4W1gltx46XCjLlF0v4z9G6fGEB8q0riy99eRSoS
	z1JaB9Iyu+rurVrHGsnlqjEWtPp+h94LFW6tjpzOAG7O/174Zj653nEae39/9lC5
	MgSty0AT4mAPq0SGZjPDL8SG8NO3FaPlmqB5jtqnKLrChq3+00yCPEANOdl6NqyT
	h+DPMOAI1UhoCg/ekAhFSP/f+WT+LtlnmXssJaYnObVl6fQ3rDfb4da6fSR5refq
	NDfq3jhYlLKCJba3XiaDS96qP76KVXNJIfA==
X-ME-Sender: <xms:N0yoakR1jH-8hiaYC4FdGWzl2igFVGW2zQ0jBU_K4mkuznUslCbYbg>
    <xme:N0yoag0BQiGfG6lxUka9U_Zwr3AhE8Ulq3aRFmIOP7ZXStB_Ea-o_y3JX_n3L6Hmy
    d9QiTqYuf9DqViNBMDQhTkgruY3a37Lk39ga7koVnow6U2G_mLu8-E>
X-ME-Received: <xmr:N0yoaoDelEer1Yfj-8el2V56cR8rpwBEzdM9UAFqU7N7SaYq7RKFckLmMtVoCaRplDdIus4OKW2qgePkGodLQ7UcCqFBkHUl1Q7e>
X-ME-Proxy-Cause: dmFkZTGPwawsQvA2Yo6FXMbEQNvbbOt3Kpy+dHSOeK+3EeAA5//p4+oRq39IX7UU9b2xKO
    PXxV0ctkUZ8Fc38+qaJTBLc6p81QAetoOF2l90a3ibCnsowWeqhMPfIkGSwWcz2ir6KDFo
    XCBEWg/ITa7on5GaHY2xKOTLVBXrhGHjenf1JyzuB6uOavuGjF3GHW/aZTdtHZc8lNGpNx
    L2EzHA1jC7lwXmIT43abIVvI+5+eB8LNs6fhBoWufapRw3o6PV/ORHVRE3c1sA04VIqNWK
    O9KAgHLNmQM0T42cokT5rHajCwNXfD67GjrbWEHdtNrqPf8kGkzYXpsb0YXYsHxHFScCEF
    acxgZEBMttR2RYQISpWDxWcCmpdvUHA8P5JrbDHqGR0t27NRiJv7icH0OU69IFIOYrA3NX
    hqLRNXy8p0Jg3/bUOeCKqWfdZzDFqNxMk++fLmkC0GaabyLeZfMzJRwZnIIcotDd9TMHc5
    svFCnjqAmqrOLsKXTMFKjfAg49LzAxCIh4sG+7Z48wIhWXuWG8RyNldlcNj70s5XvKRcFO
    gwP4j5rJG3DUTym65ZegWwZmEPNxQ/oOHDrIlOUSVcTkvwM2TVRXiTOEIDBgbUd4MyGQUS
    VQEXWGpOpZtLKeCX1fdroPLTKnWH8urWjC2/2B9Pgb+JKo//tIdPURdDtT0A
X-ME-Proxy: <xmx:N0yoakjaMs0s3dFsYvkcPs_9zeDOwVlcqMyKTeiPZ1Fz2ME9TQfBEA>
    <xmx:N0yoaiMvYuHuySvC-kuVdJmhWrUrFG2sftrU261_zUcQIWCfQcHhQA>
    <xmx:N0yoas-BI9x8tc7P7JST5fs3Kk9S4djxUmzUUUvGDMP6ZiqOTEcBaw>
    <xmx:N0yoarePVVERA22QH5y3HPol6iJvJhoh_zLjgtjL8IzwVxq8C-vpGA>
    <xmx:N0yoasQLbXfckR666Y3E20UoMJToM5jdufLWTJEcLlvvON9q5JsfywYG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 15:34:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Andrew Pleeter
 <andrewpleeter@gmail.com>
Subject: Re: [PATCH v7] var: support broken-down idents, signing key,
 multiple args, and -z
In-Reply-To: <pull.2388.v7.git.git.1789009798902.gitgitgadget@gmail.com>
	(Andrew Pleeter via GitGitGadget's message of "Thu, 10 Sep 2026
	03:09:58 +0000")
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
	<pull.2388.v7.git.git.1789009798902.gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 12:34:13 -0700
Message-ID: <xmqq5x07630q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  DESCRIPTION
>  -----------
> +Prints Git logical variables. Exits with code 1 if any requested
> +variable has no value. When multiple variables are requested, an empty
> +record (a blank line, or an empty NUL-terminated record when `-z` is given)
> +is printed for any variable that has no value, and the command continues
> +processing the remaining variables.

Very clearly described.  Although it makes it sound as if the
command always notices a variable without any value and reports
failure with its exit value, no matter in what mode, but I do not
think that matches what the code does (below).

>  int cmd_var(int argc,
> ...
> +	term = nul_term ? '\0' : '\n';
> +
> +	for (i = 0; i < argc; i++) {
> +		const struct git_var *git_var = get_git_var(argv[i]);
>  
> +		if (!git_var)
> +			usage_with_options(var_usage, options);
>  
> +		if (git_var->read) {
> +			char *val = git_var->read(IDENT_STRICT);
> +
> +			if (!val) {
> +				if (argc == 1)
> +					return 1;
> +				putc(term, stdout);
> +				continue;
> +			}
> +			printf("%s%c", val, term);
> +			free(val);
> +		} else {
> +			struct string_list list = STRING_LIST_INIT_DUP;
> +			size_t j;
> +
> +			git_var->multiread(&list);
> +			if (argc == 1 && !list.nr) {
> +				string_list_clear(&list, 0);
> +				return 1;
> +			}
> +			for (j = 0; j < list.nr; j++)
> +				printf("%s%c", list.items[j].string, term);
> +			if (argc > 1)
> +				putc(term, stdout);
> +			string_list_clear(&list, 0);
> +		}
> +	}
>  
>  	return 0;
>  }

When we ask for a single variable, 'argc' is 1 (and we never update
'argc' in the loop, which is good), and we return 1 upon seeing a
missing value.  We also do the same when we receive a 0-element list
back for a multi-valued variable.  Otherwise, nobody in the loop
remembers that we had any such failure; the loop continues, and we
return 0 unconditionally.  A "missing value" anomaly noticed during
the loop gets forgotten.

Either the documentation or the code needs to be updated, I
think.

I am still not convinced this output format is easy for scripts to
handle when multi-valued variables are involved.  It is also a bit
unclear what exactly "variable has no value" means.  A variable
whose value is an empty string is not such a variable, right?  If a
multi-valued variable has an empty string and the string "hello" as
its value, would the output from the command confuse the reading
script into thinking that the first blank line signals that the
variable has no value, for example?  Having to know which variables
are multi-valued and which are not before parsing the output format
does not help, either.

We could, of course, disambiguate by prefixing these lines with
variable names followed by '=' (or NUL), which would likely
eliminate the ambiguity.  But I understand that you are trying to
allow the parsers to proceed without having to strip prefixes from
each input, which is why the format tries to rely solely on the
correspondence between command-line arguments and output lines.  I,
however, doubt you succeeded in doing so without making the output
ambiguous.

Thanks.
