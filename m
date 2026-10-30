Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394544;
	b=iXeuDm9Nhge10/JPpFfZLFMWAUHZDxFgnprjTSE7M0af6eiy3xpY4DxFytzJ4Sk/bBWN
	 Pk70m2N0eRLq0U6JuISnaEBa2QeNDzcPRhEpokh5PZe0OgmeHTt8euIzeBC1NcGqEcAfW
	 X3jBCmMCp3EWkN5MmE7Ue7wsMZhqMj5u1jFprtngJzdj8LaK50Qp5b7gGHFNoUMyZFZhq
	 8J1/K1M4X7w2ST07zXE40c5+KP6VSlaDxAtXhWwVWkc2poPLOz9c1XZR+1VnSUoRDP5pd
	 3DLCJ+edxA5M60Kt66KP9j39WJQU0pymKldYCoyyqqkslUsY0FNG+CDCYYtFxltnHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LtMxO4Ebdhj3hoZAkNidcfnBKcCfz0ZNifRQZg6E7lY=;
	b=LEvCWvQ6F4NiEqMsV9+bvHmGxsjPrKvjEr+8mz5ARKQl9+yy8tAWTrBrgrWS4WfkZbkB
	 KvGwN2chDIuWbNVWDiUUa8dhZSJ5e8tGE+gF6Dxr4GmUopdoDPEHn/yh0AtiwDDEIeBdp
	 6Ml5CcqmcqMPnEiDRAo02uX1hqEMDOonmsRnJZk7cavmcym12b6oJYMDGe1zx02qC4V1E
	 7d7beQtsD8eOMqZO1DxirlBmjJ/bYsmHdKujZIq+xWdnr+Vjlj13s7MTwxU/f9L47cmyj
	 WB4mxOcxQIJseS+uR0ncr8R0bCx64v7bDpr0XZKZLZXwzSRmFSXlsNf11LN+XpIDZsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrZAhJ9U;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7A606A31D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 21:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD7A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BrZAhJ9U
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3550c917fd3so1595881eec.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394543; x=1793999343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtMxO4Ebdhj3hoZAkNidcfnBKcCfz0ZNifRQZg6E7lY=;
        b=BrZAhJ9UaNkcR9v51+OcssogmEJRL4ggfHeGCwqRhWBCGQppdSB/Vy3kOGa/JQlhbG
         m2C48lGiWRCUKZ+CgQU9UQbP9QpIscTuTfHOPOkjQ29W1zjrJ4SScjBuo1TUj/U0P1aE
         GHl10JlsDs8ND16JyCwhEaPooxfIdO/g3mzJtlOAlI0GXcrdZm9MgtZHnvYmDan3pUIk
         1zVLjsmcXFMl6MbG67Oi628wsmfdCzRP6op7m7moydDTMbEQMgcl07tdy2+PPw6ZtK8w
         d9hi5wFiXiL5n7UkCjnde6leck3GY5DmlSpRI4znC53VFMsuxPT7gXrfx4i4XK12p4P5
         eHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394543; x=1793999343;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LtMxO4Ebdhj3hoZAkNidcfnBKcCfz0ZNifRQZg6E7lY=;
        b=L2ASyGoP3+RBR0JUiWckF0WU1+hAY86ndLVRDpznqCUj4BU+VfpHmUReeEf5Ur2aB4
         kuZdUD2fTVS+pN8V7VI679+HTPg24K0MkU2lCy8Q0RbBieJqsEFzi+0BK5HI+H5WHUxy
         dEmy7XFy7nyP9MOxOBiCuYcETECvV1oBXfEa9dHKVcOBHuuFLyQXuqfF7kLywfrtII5C
         RiekQ1yBadqK0oXI+nOQLr1McCHbQ1a3QUxA3tsnp/LJSek+sN1TXhra6dgSDDQ1iI2x
         t2WI15g2hrdYdExM3XjbVAWtS5muo9/gecn7mkwvK9h8BHwcmoAOjE7YkgPq+JcuL8bg
         mSAQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2hvo+ULuxTtbkmyHc5fU4GcWMGCxnnmYw4Yfu54Np01NsZ0ocjv6ODojr+K/bcb6LC50=@vger.kernel.org
X-Gm-Message-State: AFq9FYLx7vOTVZSYz4ZD7JEhGrdyEMrAk9/OcGVgmatAnZGWbZxbXt6a
	Np/+AXxq0Hdzmx8cqB4rbOqGIe+z5fegLqM+cNjLWge0SfqgGyAD7QIl
X-Gm-Gg: AYBFou3FSI6p8iKSjPKds3iSYXPo1l1FHRwka6PeVXv2tKefO3aH0oL/79xfeGyHGob
	6RIbaKp6ZyzAe9ay0YgUbBveK7/sGxx22KpYPkA6G1jms4RktYpv/ASBbmZtodkxtTH60XDwAyT
	Vj4W29QC8YTydRpjXIeK5Oim+3ETcnszCV1uNtp2zSD1gvrRgj7dlKEK8+F69HV4BxkTGdM46bt
	/QaoFqxE0yIgL0OytUWh0d3eWe653IheMQValgrKuj4OncgyUQhVqkA5+JeV3OiCo85zrrTI1p1
	wBn6kvRd09HtX70yQ6Ogfc/1g3YXZmmLx4BcbPrGwraRXf9bCzEzWXDqLo/Fh495VvMbKkbZjsd
	1LH0oeI78zVO0WKbV4M5b3a9JPtTe55WXBkNMBF/yvdwJ/EEj0SaI34lPhDeU4FHuz/DXcgCe7O
	KBQDWY3SnspakbuaXazSWkvaKQSuWueeuBUkTun+fp+7ou6NM5eZNQuW9BAsix1xl7GvsHC9/1C
	VtjMHkb4ZrCc/tzRjsnxytAdmZPhSKaihwlm/EIvKr9y4G1rkdxWHwC/gj+Y61yirISdK5SiBrG
	D0ORtv+XBSAmBENNDadz4o5zNMdMVerZT5MF98gJ
X-Received: by 2002:a05:7300:fe86:b0:369:ffa5:1f8d with SMTP id 5a478bee46e88-36a42400e2dmr4207990eec.8.1793394543055;
        Fri, 30 Oct 2026 14:09:03 -0700 (PDT)
Received: from [192.168.0.11] ([106.51.26.191])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm8936954eec.12.2026.10.30.14.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:09:02 -0700 (PDT)
Message-ID: <02ba1b9d-b598-454b-897f-cb33ba190b13@gmail.com>
Date: Sat, 31 Oct 2026 02:38:57 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] parse-options: extract lookup_long_opt() from
 parse_long_opt()
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com>
 <20261012074413.337183-3-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261012074413.337183-3-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 13:14, Christian Couder wrote:
> In a following commit, an early scan of the command line will need to
> look up long options the same way parse_options() does, including
> unambiguous abbreviations and negated forms, but without any side
> effect: it must neither set option values nor call die() or error().
> 
> parse_long_opt() can't be used for that, as it does both the look up
> and the actions that follow it: it calls get_value() on the option it
> finds, die()s when abbreviations are disallowed, and error()s on an
> ambiguous abbreviation.
> 
> Let's extract a new lookup_long_opt() helper from parse_long_opt() to
> perform only the look up part, and let parse_long_opt() act on what
> lookup_long_opt() returns.
> 
> There is no behavior change intended. In particular an exact match is
> still preferred to any abbreviation, abbreviations are still rejected
> when disallowed only if there is no exact match, and the ambiguity
> error message is unchanged.
>

Neatly explained!
> diff --git a/parse-options.c b/parse-options.c
> index d7cbb5a343..a98b958423 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -516,16 +516,46 @@ static void register_abbrev(struct parse_opt_ctx_t *p,
>   	abbrev->flags = flags;
>   }
>   
> -static enum parse_opt_result parse_long_opt(
> -	struct parse_opt_ctx_t *p, const char *arg,
> -	const struct option *options)
> +enum long_opt_lookup {
> +	LONG_OPT_EXACT,      /* exact match found */
> +	LONG_OPT_ABBREV,     /* unambiguous abbreviation found */
> +	LONG_OPT_AMBIGUOUS,  /* more than one candidate abbreviation */
> +	LONG_OPT_UNKNOWN,    /* nothing matches */
> +};
> +
> +/*
> + * Look up the long option named by `arg` (without its leading "--")
> + * without acting on it. (Neither prints nor dies.)
> + *
> + * Return value:
> + * - On LONG_OPT_EXACT, `found` is the exact matching option and its flags
> + *   (including OPT_UNSET for a negated form), and `stuck` points after
> + *   the '=' or is NULL.
> + * - On LONG_OPT_ABBREV, `found` is the unambiguous abbreviation, same as
> + *   above for its flags and `stuck`.
> + * - On LONG_OPT_AMBIGUOUS, `found` and `other` are two candidates of an
> + *   ambiguous abbreviation.
> + * - On LONG_OPT_UNKNOWN, nothing matches, no result.
> + *
> + * `other` is only meaningful for LONG_OPT_AMBIGUOUS.
> + */
> +static enum long_opt_lookup lookup_long_opt(struct parse_opt_ctx_t *p,
> +					    const char *arg,
> +					    const struct option *options,
> +					    struct parsed_option *found,
> +					    struct parsed_option *other,
> +					    const char **stuck)
>   {
> +	enum opt_parsed flags = OPT_LONG;
>   	const char *arg_end = strchrnul(arg, '=');
>   	const char *arg_start = arg;
> -	enum opt_parsed flags = OPT_LONG;
>   	int arg_starts_with_no_no = 0;
> -	struct parsed_option abbrev = { .option = NULL, .flags = OPT_LONG };
> -	struct parsed_option ambiguous = { .option = NULL, .flags = OPT_LONG };
> +
> +	found->option = NULL;
> +	found->flags = OPT_LONG;
> +	other->option = NULL;
> +	other->flags = OPT_LONG;
> +	*stuck = NULL;
>   
>   	if (skip_prefix(arg_start, "no-", &arg_start)) {
>   		if (skip_prefix(arg_start, "no-", &arg_start))
> @@ -554,43 +584,70 @@ static enum parse_opt_result parse_long_opt(
>   
>   		if (skip_prefix(arg_start, long_name, &rest)) {
>   			if (*rest == '=')
> -				p->opt = rest + 1;
> +				*stuck = rest + 1;
>   			else if (*rest)
>   				continue;
> -			return get_value(p, options, flags ^ opt_flags);
> +			found->option = options;
> +			found->flags = flags ^ opt_flags;
> +			return LONG_OPT_EXACT;
>   		}
>   
>   		/* abbreviated? */
>   		if (!strncmp(long_name, arg_start, arg_end - arg_start))
>   			register_abbrev(p, options, flags ^ opt_flags,
> -					&abbrev, &ambiguous);
> +					found, other);
>   
>   		/* negated and abbreviated very much? */
>   		if (allow_unset && starts_with("no-", arg))
>   			register_abbrev(p, options, OPT_UNSET ^ opt_flags,
> -					&abbrev, &ambiguous);
> +					found, other);
>   	}
>   
> -	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
> +	if (other->option)
> +		return LONG_OPT_AMBIGUOUS;
> +
> +	if (found->option) {
> +		if (*arg_end)
> +			*stuck = arg_end + 1;
> +		return LONG_OPT_ABBREV;
> +	}
> +
> +	return LONG_OPT_UNKNOWN;
> +}
> +
> +static enum parse_opt_result parse_long_opt(struct parse_opt_ctx_t *p,
> +					    const char *arg,
> +					    const struct option *options)
> +{
> +	struct parsed_option found;
> +	struct parsed_option other;
> +	const char *stuck;
> +	enum long_opt_lookup result = lookup_long_opt(p, arg, options,
> +						      &found, &other, &stuck);
> +

Would it not be better to consume the `enum long_op_lookup` return value 
via a switch rather than having a set of if statements to cover all the 
cases?

> +	if (result == LONG_OPT_UNKNOWN)
> +		return PARSE_OPT_UNKNOWN;
> +
> +	if (disallow_abbreviated_options &&
> +	    (result == LONG_OPT_ABBREV || result == LONG_OPT_AMBIGUOUS)) {
> +		const char *arg_end = strchrnul(arg, '=');
>   		die("disallowed abbreviated or ambiguous option '%.*s'",
>   		    (int)(arg_end - arg), arg);
> +	}
>   
> -	if (ambiguous.option) {
> -		error(_("ambiguous option: %s "
> -			"(could be --%s%s or --%s%s)"),
> -			arg,
> -			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
> -			ambiguous.option->long_name,
> -			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
> -			abbrev.option->long_name);
> +	if (result == LONG_OPT_AMBIGUOUS) {
> +		error(_("ambiguous option: %s (could be --%s%s or --%s%s)"), arg,
> +		      (other.flags & OPT_UNSET) ? "no-" : "", other.option->long_name,
> +		      (found.flags & OPT_UNSET) ? "no-" : "", found.option->long_name);
>   		return PARSE_OPT_HELP_ERROR;
>   	}
> -	if (abbrev.option) {
> -		if (*arg_end)
> -			p->opt = arg_end + 1;
> -		return get_value(p, abbrev.option, abbrev.flags);
> +
> +	if (result == LONG_OPT_ABBREV || result == LONG_OPT_EXACT) {
> +		p->opt = stuck;
> +		return get_value(p, found.option, found.flags);
>   	}
> -	return PARSE_OPT_UNKNOWN;
> +
> +	BUG("unknown enum long_opt_lookup value '%d'", result);
>   }
>   
>   static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,

Rest of the patch looks good to me.

-- 
Sivaraam

