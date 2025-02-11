Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1724C671
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284568; cv=none; b=BGxhqG/7xm18PyRCbbSmhEL62MWCA7y0O3HFNqXLG7eYuSraNLbuyJ+z+Q8GE3nCJ3VeaTaZKAyPpZBdCmmxJdbaA3dsD5tdk2qb1dTycUzAHjk+6gYC6LRkl5ER5TpPwXkbmGJLF6yjLAXvXXDbCjMP/ZszixGzn5NGMMBMMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284568; c=relaxed/simple;
	bh=keDZMQ7ycI4f0B1RC4ZiAzwcYXp/ApWamJ6QU+I9gvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1tGd+xVmtGkP3H/7leLDjKM4kOsiniwzlbxWunMjlPq63MESPlmyYNDYb0syqpxLx5SgxxsCj9NuxL17wre7NP3SaXpvU1xPbhLuTIZEDcntc4L0Nk7YETzxI7ANXU2bE4bIfRCBpwZVyz8vtFqSnaNvyZKrj9nz4bkGwNFQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juRl26hn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juRl26hn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so56183705e9.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 06:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739284565; x=1739889365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V77CDSGyGCu4t982bRrTU6myJkTmYKI2srRnmpsIo/s=;
        b=juRl26hnfaEAoNhM1b5nH3GAGtpolzH/EBuUQCLOWC2qT8s9OZOzNmIP/ba7HX7DF/
         TeQSC0QyWQIfYn2RXxqlmygLC5FRl5lelm9mO3zBnNUAsxDO+IDBKC48EsVpS/IkT6UN
         NrtwYc5aQJpOVi5VgCpB6Si3L+1/8HPQUfXPlggluM95D8aFy82O+IsQFAYyLFy4RlUi
         gbaX7emjqTBk+zppA6GVScymQseMLscbtvemCS6Yanp+3eMhbBvyEHhANU+4Pd5j3PFx
         mcJN3neIhCgj1N28I0Cb/MLy/mfCz4gpj4dbXPMZoxAs0BVYa5wyQY74Advq+Q3hNzOM
         U1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284565; x=1739889365;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V77CDSGyGCu4t982bRrTU6myJkTmYKI2srRnmpsIo/s=;
        b=RWjAK/4qfKONnREvNq6TpGdwTSSKhfgBIa2RIEgfNMhHA5+iEdOUgCDw+y3ZMMdSfg
         7IVRk6I/H9mT1Q/obn4eTyY20tlPPJaPW+Tq/rDtS0PYuU/xzqZSjjp4MhZFYsdjwO7l
         WZvl8vfH6sj3N/4EgjfXLUOGHmkq9lSGNtTGV2sdJRVZ2bAGbaA1u61LffcDPiEvKDHb
         gSWlsjUm1GMJHi0Dq5GmGfEyhHHGb7cWoq53P0FGMv5Fki6Szt9XFcX0c4+MTWHIBzXa
         1YECmzgWsAVleplQ7T0jpS0JoKJJTQlaPuHRTWfxkzY1PxINwebkHeNqmjvaRP3TK5IT
         hEPg==
X-Forwarded-Encrypted: i=1; AJvYcCXgebHTpEra8/S3D2PHCiBu7KUVI0P4rAOkj7IjNeN1rx0tISNXQ1OepYl1N1ny8LaFeRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5W70ai5LAsda82R6ErcanArnQOGCQtZzwGGZc5Lkr0PN6KDUT
	q4OeezLwDBiH9Eb32YR4/9qji9jbzEP3eHdmmOnL1r7FGubeosMq
X-Gm-Gg: ASbGncuKJM32LjSGJl96RXAyU825448ECySLErXj5VrXhYqfaTAgVSWIT1bxpBsnvWu
	n4vCA3sob8E7UhV35BBPh5Dv6JZhIcZcyZOr2yaRCrnpZ1aZoS79CfU3SfIfVtC5P1e+53FzYUf
	t3q2YwbaxXLQUvs+56clIdsDumvzbNL9y+5QKRagktd+osnuiV+mzQWAr3HFhbNoc5AatlksfFM
	mmYZwqBPgLX6uJPFnzFl8Ddd2aSLqKAxHC3LXW+/mLP88raQceJxhHtivGA4gz6811bjWta6Q6T
	fBgmMntx8il0+qvwQIaA504N/pu/uoIUvvBBMqFTqhwlbBTEt5/Z2rWU8k7stgSwqNExyg==
X-Google-Smtp-Source: AGHT+IGd9s0RhlwNCBJSVaNRfQaYWv2BOX6uhOmNcDBwZRdPPwDdVI4O4aDAfs46mVELeK4uBMHcHQ==
X-Received: by 2002:a05:600c:1d0d:b0:431:5632:448b with SMTP id 5b1f17b1804b1-439249c658cmr123278085e9.25.1739284565069;
        Tue, 11 Feb 2025 06:36:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da964e2sm181127445e9.4.2025.02.11.06.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 06:36:04 -0800 (PST)
Message-ID: <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
Date: Tue, 11 Feb 2025 14:36:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250210191650.316329-1-intelfx@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivan

On 10/02/2025 19:16, Ivan Shapovalov wrote:
> In rebase-heavy workflows involving multiple interdependent feature
> branches, typing out `--update-refs` quickly becomes tiring, which
> can be mitigated with setting the `rebase.updateRefs` git-config option
> to perform update-refs by default.
> 
> However, the utility of `rebase.updateRefs` is somewhat limited because
> you rarely want it in a non-interactive rebase (as it does not give you
> the chance to review the update-refs candidates, likely leading to
> updating refs that you didn't want updated -- I made quite an amount
> of mess by setting this option and subsequently forgetting about it).

I'm a bit surprised by this - I'd have thought there is more scope for 
messing things up by making a mistake when editing the todo list that 
for the non-interactive case. Are you able to explain a in a bit more 
detail the problem you have been experiencing please?

> Try to find a middle ground by introducing a third value,
> `--update-refs=interactive` (and `rebase.updateRefs=interactive`)
> which means `--update-refs` when starting an interactive rebase and
> `--no-update-refs` otherwise. This option is primarily intended to be
> used in the gitconfig, but is also accepted on the command line
> for completeness.

I'm not convinced allowing "--update-refs=interactive" on the 
commandline improves the usability - why wouldn't I just say 
"--update-refs" if I want to update all the branches or 
"--no-update-refs" if I don't? I also think supporting 
--update-refs=(true|false) is verbose and unnecessary as the user can 
already specify their intent with the existing option.

>   rebase.updateRefs::
> -	If set to true enable `--update-refs` option by default.
> +	If set to true, enable the `--update-refs` option of
> +	linkgit:git-rebase[1] by default. When set to 'interactive',

Our existing documentation is inconsistent in how it formats config 
values. rebase.backend uses "apply", rebase.rebaseMerges uses 
`rebase-cousins` which I think matches other commands and is therefore 
what we should use here and rebase.missingCommitCheck uses a mixture 
with "warn" and `drop`.

> +	only enable `--update-refs` by default for interactive mode
> +	(equivalent to `--update-refs=interactive`).
> +	This option can be overridden by specifying any form of
> +	`--update-refs` on the command line.

> @@ -129,10 +129,17 @@ struct rebase_options {
>   	int reschedule_failed_exec;
>   	int reapply_cherry_picks;
>   	int fork_point;
> -	int update_refs;
> +	// UPDATE_REFS_{UNKNOWN,NO,ALWAYS} numeric values must never
> +	// change as post-option-parsing code works with {,config_}update_refs
> +	// as if they were ints

This feels a bit fragile - why can't we update the code to use the enum? 
Also note that comments should be formatted as

/* single line comment */

or

/*
  * multi-line
  * comment
  */

> +	enum {
> +		UPDATE_REFS_UNKNOWN = -1,
> +		UPDATE_REFS_NO = 0,
> +		UPDATE_REFS_ALWAYS = 1,
> +		UPDATE_REFS_INTERACTIVE,
> +	} update_refs, config_update_refs;

I don't think we want to change the type of `update_refs` as I'm not 
convinced we want to change the commandline option.

> +static int coerce_update_refs(const struct rebase_options *opts, int update_refs)

I'd be tempted to call this "should_update_refs(...)"

> +{
> +	/* coerce "=interactive" into "no" rather than "not set" when not interactive
> +	 * this way, `git -c rebase.updateRefs=yes rebase --update-refs=interactive [without -i]`
> +	 * will not inherit the "yes" from the config */

Style - see above

> +	if (update_refs == UPDATE_REFS_INTERACTIVE)
> +		return (opts->flags & REBASE_INTERACTIVE_EXPLICIT)
> +		       ? UPDATE_REFS_ALWAYS
> +		       : UPDATE_REFS_NO;
> +	return update_refs;
> +}
> [...]   
> +static int parse_update_refs_value(const char *value, const char *desc)
> +{
> +	int v = git_parse_maybe_bool(value);

Style: there should be a blank line after the variable declarations at 
the start of a function.

> +	if (v >= 0)
> +		return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
> +	else if (!strcmp("interactive", value))
> +		return UPDATE_REFS_INTERACTIVE;
> +
> +	die(_("bad %s value '%s'; valid values are boolean or \"interactive\""), desc, value);

I think we normally say "invalid" or "unknown" rather than "bad" in our 
error messages. It'd be clearer just to list the possible values as 
there are only three of them.

> +	/* coerce --update-refs=interactive into yes or no.
> +	 * we do it here because there's just too much code below that handles
> +	 * {,config_}update_refs in one way or another and modifying it to
> +	 * account for the new state would be too invasive.
> +	 * all further code uses {,config_}update_refs as a tristate. */

I think we need to find a cleaner way of handling this. There are only 
two mentions of options.config_update_refs below this point - is it 
really so difficult for those to use the enum?

Given a bit more detail I could be convinced that the config option is 
useful but I don't think we should be changing the commandline option.

Best Wishes

Phillip

