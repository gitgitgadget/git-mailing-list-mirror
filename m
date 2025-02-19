Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156A215042
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989496; cv=none; b=rGpOcBrHppG9YaNk5OfvzY93e2DP1pFMMmFaQjA+RdXAwhRAOnBbnSWjiXwyPSwQJYp1XZfazvuYhD0beVzuZ959U1KXFIJbgCDfBj0TP9ewMt93OCG/lZjPptjcCVJeWO9VhkloLWRFcSf4E8YKFR5sECTnpRm+7jKHeXwmFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989496; c=relaxed/simple;
	bh=zz5cYP9vOj3AUjQfWgXcvMs458WGjQaVEgz9GY6dPZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFkrY3Kbn7FoHOJ9y9C0eIdSbt7wT9Ot/BifVuH86IBnvwguc2+CdYWGwrtsodUSlbMPXPTjMWeuRIIN8R4PGExuiY18E99/OcdUDbQ1lVBD/Rx+jlk+7FeL7yALQGzVFFRj7xn8DiBIKtNVsBHnHWeERZsPR6qYBOv0vYj4yNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHTbfkXb; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHTbfkXb"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2bc56e74e75so8280fac.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989493; x=1740594293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UM2BxHnaXK2yDAsxwU9o4/1f9ibpbtraIMjmYSWJaq0=;
        b=WHTbfkXbIOGFSGkWYpIiNq4oOC9jdEyhhFyk/8kNRxSa+7qwYMhtI/Zvykyfd18tiG
         ACo2s3+QS3Jz4ZPSvK1175bjNHsM9Vi6/G38UINK5CzqpksxoxPeWvxYnOGAUpLtn/Fj
         fAuWwOLb7SuLOdH629b3ImQDMjiP92aef3+dJucrUilMsIM8IwbdcCmcIQE64jc9+AkO
         xGTAS8n/2zeHiAU47LwFhtMoKfZ7ULOqDYEcvyGuH38gF8J4ZZ+HW/pK5we04LpSDarA
         X0eFd1pQ5mzf8It4u24pkpYRQdZVF2azCit4GqRRHF/e5XaEZA6rYQ7vHO5LjUtXmORQ
         Gncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989493; x=1740594293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UM2BxHnaXK2yDAsxwU9o4/1f9ibpbtraIMjmYSWJaq0=;
        b=DHym9QGmuuDaGaO8WWcFbnSvwYOcf7W8rco9VdyeiO7JKkqGNWKkHMpQzTTtf/l7ox
         3M8yBHpTq6ung1o+3rQKR8H0ePN1pth0qplxKqEm32FyscxSREjmsY6jMI8tOobNZSC+
         5Fhl9x5f48elrncsaCFXvFRQKl2ysA134Vj8x7/PBFvJ6kEIZRwGZCwU5ZoCKsHliS3j
         Tl9icXSQizlciQKJ3cfxO9H1FzElvjKNzlAZjnC9GvmQXgmkrbjw0M0SJx5YSBMcWNQ4
         YW5Zf5wS2Wv3Ny82Q/P1LomdBJBaGfGhtbvhtdWnvABhmnF76EmDxYEWo5UzBkpF3P0B
         rB8Q==
X-Gm-Message-State: AOJu0YyyYCHiPmulbSmEWgxYWcw+Xk1uCLowU1kkd6q9TgjWTHGj019w
	ZUQ8FcNWd3u+dSj7Enp+VoAmaEPu1ffkUj533RHNRH1eg5J+j5fT
X-Gm-Gg: ASbGnct9tkddlUjQaAsy8CCYUbKa8D4hEbX11e0lOrs9tC87OlB97ujUNDiG8FQdGjt
	05BjaQ42mJLzBltb+zItRmvOEgncjlASHXPnyMSRcDzQyVaddXBU6GNmz3jxAeVG1W5/pPfeiz4
	kQ+IIciTlJK6i0CZsXiZQw7VEd0Oq9wwhzmFePxFDR+BqEfce5H9HZOA7NR3DY3VunGncdymlFA
	cmEk/nJw7j70pQGLJc1yQWiFskC97cVHNGZcVGJBhAHQAYBOfKeHS/c9NeqaM4j0FHK03gWC3UX
	j2eA7CSk
X-Google-Smtp-Source: AGHT+IGIt7wf+8SXzRiD8CATrknbLFVZVoHT+YrJ0N3DNCXvV0PsFQhlrsUZZ3ZydQfcae+hRD5HWw==
X-Received: by 2002:a05:6870:204f:b0:297:2201:84d1 with SMTP id 586e51a60fabf-2bc99a34610mr12701102fac.4.1739989493487;
        Wed, 19 Feb 2025 10:24:53 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2b954875ce0sm5896631fac.15.2025.02.19.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:24:53 -0800 (PST)
Date: Wed, 19 Feb 2025 12:21:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 03/16] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Message-ID: <7q2ldwq2mc7vhpqfpj4lg5jc2badt5sgcv6x3eeqjcboraiqxn@5bzhi5n6alxm>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-3-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219-pks-update-ref-optimization-v2-3-e696e7220b22@pks.im>

On 25/02/19 02:23PM, Patrick Steinhardt wrote:
> Most of the commands in git-update-ref(1) accept an old and/or new
> object ID to update a specific reference to. These object IDs get parsed
> via `repo_get_oid()`, which not only handles plain object IDs, but also
> those that have a suffix like "~" or "^2". More surprisingly though, it
> even knows to resolve references, despite the fact that its manpage does
> not mention this fact even once.
> 
> One consequence of this is that we also check for ambiguous references:
> when parsing a full object ID where the DWIM mechanism would also cause
> us to resolve it as a branch, we'd end up printing a warning. While this
> check makes sense to have in general, it is arguably less useful in the
> context of git-update-ref(1). This is out of two reasons:
> 
>   - The manpage is explicitly structured around object IDs. So if we see
>     a fully blown object ID, the intent should be quite clear in
>     general.

Makes sense.

>   - The command is part of our plumbing layer and not a tool that users
>     would generally use in interactive workflows. As such, the warning
>     will likely not be visible to anybody in the first place.

Ok, so in many cases already the warning is not propagated which makes
its computation wasteful to begin with.

> Furthermore, this check can be quite expensive when updating lots of
> references via `--stdin`, because we try to read multiple references per
> object ID that we parse according to the DWIM rules. This effect can be
> seen both with the "files" and "reftable" backend.
> 
> The issue is not unique to git-update-ref(1), but was also an issue in
> git-cat-file(1), where it was addressed by disabling the ambiguity check
> in 25fba78d36b (cat-file: disable object/refname ambiguity check for
> batch mode, 2013-07-12).
> 
> Disable the warning in git-update-ref(1), which provides a significant
> speedup with both backends. The following benchmark creates 10000 new
> references with a 100000 preexisting refs with the "files" backend:
> 
>     Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
>       Time (mean ± σ):     467.3 ms ±   5.1 ms    [User: 100.0 ms, System: 365.1 ms]
>       Range (min … max):   461.9 ms … 479.3 ms    10 runs
> 
>     Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
>       Time (mean ± σ):     394.1 ms ±   5.8 ms    [User: 63.3 ms, System: 327.6 ms]
>       Range (min … max):   384.9 ms … 405.7 ms    10 runs
> 
>     Summary
>       update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
>         1.19 ± 0.02 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
> 
> And with the "reftable" backend:
> 
>     Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
>       Time (mean ± σ):     146.9 ms ±   2.2 ms    [User: 90.4 ms, System: 56.0 ms]
>       Range (min … max):   142.7 ms … 150.8 ms    19 runs
> 
>     Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
>       Time (mean ± σ):      63.2 ms ±   1.1 ms    [User: 41.0 ms, System: 21.8 ms]
>       Range (min … max):    61.1 ms …  66.6 ms    41 runs
> 
>     Summary
>       update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
>         2.32 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
> 
> Note that the absolute improvement with both backends is roughly in the
> same ballpark, but the relative improvement for the "reftable" backend
> is more significant because writing the new table to disk is faster in
> the first place.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/update-ref.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 4d35bdc4b4b..d603f54b770 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -179,7 +179,8 @@ static int parse_next_oid(const char **next, const char *end,
>  		(*next)++;
>  		*next = parse_arg(*next, &arg);
>  		if (arg.len) {
> -			if (repo_get_oid(the_repository, arg.buf, oid))
> +			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
> +						    GET_OID_SKIP_AMBIGUITY_CHECK))
>  				goto invalid;
>  		} else {
>  			/* Without -z, an empty value means all zeros: */
> @@ -197,7 +198,8 @@ static int parse_next_oid(const char **next, const char *end,
>  		*next += arg.len;
>  
>  		if (arg.len) {
> -			if (repo_get_oid(the_repository, arg.buf, oid))
> +			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
> +						    GET_OID_SKIP_AMBIGUITY_CHECK))
>  				goto invalid;
>  		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
>  			/* With -z, treat an empty value as all zeros: */
> @@ -772,7 +774,8 @@ int cmd_update_ref(int argc,
>  		refname = argv[0];
>  		value = argv[1];
>  		oldval = argv[2];
> -		if (repo_get_oid(the_repository, value, &oid))
> +		if (repo_get_oid_with_flags(the_repository, value, &oid,
> +					    GET_OID_SKIP_AMBIGUITY_CHECK))
>  			die("%s: not a valid SHA1", value);
>  	}
>  
> @@ -783,7 +786,8 @@ int cmd_update_ref(int argc,
>  			 * must not already exist:
>  			 */
>  			oidclr(&oldoid, the_repository->hash_algo);
> -		else if (repo_get_oid(the_repository, oldval, &oldoid))
> +		else if (repo_get_oid_with_flags(the_repository, oldval, &oldoid,
> +						 GET_OID_SKIP_AMBIGUITY_CHECK))
>  			die("%s: not a valid old SHA1", oldval);
>  	}

In builtin/update-ref.c all uses of repo_get_oid() have been converted
to repo_get_oid_with_flags() with the GET_OID_SKIP_AMBIGUITY_CHECK flag
except for one in parse_cmd_symref_update(). Is there reason to leave
that one untouched?

-Justin
