Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11E14A60C
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747039; cv=none; b=LzTJMnG1IqBXXCnX0QWTR70q28eJLV9nqf2CxdAsZIub8u+8mInmaUbkP5UUZrGArppy19WZBl7mHFzZqMqPvi8Glkh3S5Yw7wMMrt/TN1Hc0vn5QZY2WJvEirMJu79F1hvK31W2XNqJ8Jp8J307ISMli+6biUSWAJXYCwN6tZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747039; c=relaxed/simple;
	bh=8ggQz1GnK6yTG6lK7bVEjiArZ2Jmk1FdmNniACOP9e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5VKGLN8DlnXq5kchlDYIRm2FX6RvqeXZq1UepbVdbUxLnoybqBupDkUlHsmovxlJlme3Sk6O0pFGH1LRGNxJUJdIG6iFU09BP9IGrxs0NihkliOLKrNYekj2ch3OCAvNMrG56s0ZHSBDjopAMuvOJ9ajLVmM+6pWH34r6T21XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K/eaCpvV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K/eaCpvV"
Received: (qmail 11730 invoked by uid 109); 13 Jan 2025 05:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8ggQz1GnK6yTG6lK7bVEjiArZ2Jmk1FdmNniACOP9e0=; b=K/eaCpvVgnoZi6ffbi3sUYOEao4PUEAITST7kvdrLCxe6Gx7NxmqGmKSvFN9hRUs2b+cVeoC+LnALEeSxfCJnueMTkX3P9oVYAFutzcKzM39cKuLzAl914dFu6Br0ps4lR9TVbpf/QUj/+yb/YN5i/ZpRb6XkZowDCZC7Bnykhq5yJJ23UxGcmHDJeDmOjRlSSORQDvhxwkjZDgaTMXH9m3A2lPeD2wFCRmIXlhvHjMU3L0SXrfayh9t6ZfObQsg2X8i72lYOUIUZe+j4SDCXyVQnYwW3+B3rv6J/bPXe7nsYReh9RkmOSei0EvIEE0SsbnnTwha6urp+Jbwq64hMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jan 2025 05:43:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17107 invoked by uid 111); 13 Jan 2025 05:44:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2025 00:44:00 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Jan 2025 00:43:55 -0500
From: Jeff King <peff@peff.net>
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yongmin <yewon@revi.email>, Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v3] help: interpret boolean string values for
 help.autocorrect
Message-ID: <20250113054355.GB767856@coredump.intra.peff.net>
References: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
 <pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>

On Sat, Jan 11, 2025 at 11:27:19AM +0000, Scott Chacon via GitGitGadget wrote:

> Interpret the value of help.autocorrect as either one of the accepted list
> of special values ("never", "immediate", ...), a boolean or an integer. If
> the value is 1, it is no longer interpreted as a decisecond value of 0.1s
> but as a true boolean, the equivalent of "immediate". If the value is 2 or
> more, continue treating it as a decisecond wait time.

This mostly looks good to me, though this part gave me a little pause:

> False boolean string values ("off", "false", "no") are now equivalent to
> "never", meaning that guessed values are still shown but nothing is
> executed. True boolean string values are interpreted as "immediate".

I think false boolean values end up as "never", which shows _nothing_.
As opposed to "0", which continues to be "show but do not execute" (and
which we can't change if we want to retain historical compatibility).

That's probably OK, though it is a little unlike other bools in that "0"
is usually a strict synonym for "false". So we could go the other way,
with "0, false, off, no" meaning "show but don't run" and leaving
"never" by itself to mean "do nothing".

> diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
> index 610701f9a37..16b124b1c17 100644
> --- a/Documentation/config/help.txt
> +++ b/Documentation/config/help.txt
> @@ -11,13 +11,14 @@ help.autoCorrect::
>  	If git detects typos and can identify exactly one valid command similar
>  	to the error, git will try to suggest the correct command or even
>  	run the suggestion automatically. Possible config values are:
> -	 - 0 (default): show the suggested command.
> -	 - positive number: run the suggested command after specified
> +	 - 0: show the suggested command (default).
> +	 - 1, "true", "on", "yes": run the suggested command immediately.
> +	 - positive number > 1: run the suggested command after specified
>  deciseconds (0.1 sec).
>  	 - "immediate": run the suggested command immediately.
>  	 - "prompt": show the suggestion and prompt for confirmation to run
>  the command.
> -	 - "never": don't run or show any suggested command.
> +	 - "false", "off", "no", "never": don't run or show any suggested command.

"never" gets folded into the list of other false booleans. But
"immediate" still gets its own bullet point. Should it be folded into
the "true" line?

> diff --git a/help.c b/help.c
> index 5483ea8fd29..7148963e468 100644
> --- a/help.c
> +++ b/help.c
> @@ -556,6 +556,27 @@ struct help_unknown_cmd_config {
>  #define AUTOCORRECT_NEVER (-2)
>  #define AUTOCORRECT_IMMEDIATELY (-1)
>  
> +static int parse_autocorrect(const char *value)
> +{
> +	switch (git_parse_maybe_bool_text(value)) {
> +		case 1:
> +			return AUTOCORRECT_IMMEDIATELY;
> +		case 0:
> +			return AUTOCORRECT_NEVER;
> +		default: /* other random text */
> +			break;
> +	}

One of the reasons I looked so closely at the "0" behavior above is that
I thought the maybe_bool() parser might eat your "0" before you get a
chance to act on it. But because you use maybe_bool_text(), it doesn't
do any integer interpretation at all. Good.

> +	if (!strcmp(value, "prompt"))
> +		return AUTOCORRECT_PROMPT;
> +	if (!strcmp(value, "never"))
> +		return AUTOCORRECT_NEVER;
> +	if (!strcmp(value, "immediate"))
> +		return AUTOCORRECT_IMMEDIATELY;
> +
> +	return 0;
> +}

And these all make sense. I wondered if we might ever mistake this 0
return for AUTOCORRECT_*, but they are all defined with non-zero values
(which makes sense, since we store them in the same variable that might
hold a "0" or positive value).

And in fact it would make my bool alternative suggestion above trickier,
since this function could return a true "0" to mean "show but don't
run".

> @@ -564,20 +585,17 @@ static int git_unknown_cmd_config(const char *var, const char *value,
>  	const char *p;
>  
>  	if (!strcmp(var, "help.autocorrect")) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		if (!strcmp(value, "never")) {
> -			cfg->autocorrect = AUTOCORRECT_NEVER;
> -		} else if (!strcmp(value, "immediate")) {
> -			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
> -		} else if (!strcmp(value, "prompt")) {
> -			cfg->autocorrect = AUTOCORRECT_PROMPT;
> -		} else {
> -			int v = git_config_int(var, value, ctx->kvi);
> -			cfg->autocorrect = (v < 0)
> -				? AUTOCORRECT_IMMEDIATELY : v;
> +		int v = parse_autocorrect(value);
> +
> +		if (!v) {
> +			v = git_config_int(var, value, ctx->kvi);
> +			if (v < 0 || v == 1)
> +				v = AUTOCORRECT_IMMEDIATELY;
>  		}
> +
> +		cfg->autocorrect = v;
>  	}
> +

OK, so parse_autocorrect() handles all of the non-numeric values. And
then we fall back on the integer values. Makes sense.

So assuming we are OK with the "0" vs "false" split, the whole patch
looks good to me, modulo the nit about folding the "immediate" line in
the documentation.

-Peff
