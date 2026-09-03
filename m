Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F304A8FF9
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445201; cv=none; b=kc19rnO+8+od4mByl6wMijHZ4fx6pf/auQJRbeqAWyDpVRBl2HBEZMBWLXTmuJZwhMG09+3yGJq2Ia+/Wj4f0KgFEWTHlRzz9B7ouRaD5KdOJ2Ug4fRZDMK9dpNDMZ6j/jgBPsLH1eI0HP8sqZ/qm2JTXYUAAP2DKrh211xOyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445201; c=relaxed/simple;
	bh=w0j/JItWRikyAIdcnEdPuSXnR9R7XHOvtMVRio0UsL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4wMaEftctbCHJRLPooI0Eh6WZyNopcUO2glG0S/5cbybx3giP+HUXzJHqtUF5Nyog2ohqMjBWO7L8639FoHFn7dsnOhYlw2sOtJSd6feuFsZ4pFZe5VLXAR1p9IDgZoQV+FzL89V9NOfxPHBz1cUD+d8QjHQNy+bKeviiNI7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Or9rLOYI; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or9rLOYI"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9387752a4d0so222493985a.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445179; x=1789049979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hx32TeZ3bioWfCf1V/mYIf+hE7oMx6Nm19/ccAtGeDQ=;
        b=Or9rLOYIYj2uo/gP+2UySVtX/Mw1hLdJory7eodHTebiQFkEsrLIKPWGsjQ/F0TuD4
         /xrdWaxzoqaRXCtWbXiBSwRUhzik6mePBZLRRqBp3FtppfY7xmEUXE7+DFMiM7gzOhJ3
         44K4qluBfHK8hGg53JJMSiaHi8OOE/nHyTRDe8/gqg5u+ra/6S+IwJMUtyfhIvqQsGs2
         S5vepxcmaPEDv61ZrNNAyfx90uI9k9u0Em8tPz/XEUZukz3lHedwdz27wbWE6WOgnhWY
         QQxcOsD4MixObK/q4E6VRD2uMaaiqy8bZOm4nt+27jxV0yYDtOJE0BDp4l5Ydu/7gcWN
         9M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445179; x=1789049979;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hx32TeZ3bioWfCf1V/mYIf+hE7oMx6Nm19/ccAtGeDQ=;
        b=bo4wTU8N1swTF0wryR7WGox1uTqrGFeISJLg95iKuYiIvzmAW6CCIVxJa6Bbv+8rT5
         /UwT7ATopdskKQYsRDJT14dscWDsA4Bh54yNR1grSb/e5FoyDObYPpG/7vhHLi4xx7oI
         brNxBuRDNsNOnTyjOTLMMpwdqAMvSMs5MtPvn36MEgKxiMI2+N9mWZ9SQLRqztumNjsd
         XhW6ECoJ9C4xPBL0x9FpHbz1pKqDX0Hje+fOlKAMwZKU+YpbjRGPzPjaN6a+Y70PYP9s
         kwYEOyy1RL9QTsSEO2MjOe1ew8ZuaZReO5hFcbeB/ZdgSYOTvgWvNWaivFFNJp0S0cSI
         uoFw==
X-Forwarded-Encrypted: i=1; AKwUvBxgv3yQNwD5DoC2N6+Kwc28/kCDloIuuM8wQRrHZ62fazTI5wH25F5tSQBsnB4owzUQ8s0=@vger.kernel.org
X-Gm-Message-State: AFuF++naq2fvxc/IMGSmV4EP3+CEVjhnvs8Tdy9eShsKoqE1JM3wUAiO
	b1xGIM0PYVFnWcAS+TI8YssySb4QpU3d4+Y7WvdTDGdlA/WTBFo3DRmv
X-Gm-Gg: AYBFou2FxunWJUOMvldUyAYiMaUdVsJd2u0aKAcihwn6I+z9beN5wDXcObT1vbY/vD7
	HzMNu7eL2RgvYfmLxsRLiakLQZfwYS2WbWINtjsccRm8KXcJPqG477WR5b5YxplhplzmAoz6vRl
	KzggtJe3cIzJabIorzmasvkusxJx2UNa9cPwLfNpACvWGx2R1Vw5u5dqJIS9RNwcb1XEN2SHk5D
	Oc/+gE2EgohMV14KHo8mfMSBjKscldfUMKxPmREO2G3B0id22mfEXaca62SA3SzBn2N8tzU2+aB
	upVjsgFhWyljUeQiJOtGFCGxQaA4njbVmd4fLihVR5U8M+xxU0wogf9nlOrZ0+5HnehdLRxsFYj
	4D8ghNfShBx5mZGjXv15FDBOvJTR3dj/mgXobF/wG0Zwke60SkqGsZvet2M0uuXSRG/viQBmHTl
	cxh92vu8XyBbSfjcrP4yYlvACgoYPjbb092Rnrx70QmWwDS99wl4euhorChCxt6U8B3YINue6qc
	nUGIAVsea8rWcpBOKpIUG1lt6AmILoRsogdLbr76aYMiH3SfdheQMR9npukqp8rhh+956MFXlM5
	WKP0gIyziBW+txml9PiP378tcxLw2xZ+/F5zuiN2C3NNoqT4a9oeupINsQKxSZZt+C6gGQqOKEP
	/apZGBaEzkx9kng==
X-Received: by 2002:a05:620a:7112:b0:939:5f4d:67b0 with SMTP id af79cd13be357-93960c6a0femr1467015885a.8.1788445174527;
        Thu, 03 Sep 2026 07:19:34 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f396f2bsm502352685a.33.2026.09.03.07.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:19:33 -0700 (PDT)
Message-ID: <2ca2b4db-1fd9-46e8-9385-260a12af43bb@gmail.com>
Date: Thu, 3 Sep 2026 10:19:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] builtin/maintenance: improve heuristic for "rerere
 gc"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-2-9929c45a9788@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-2-9929c45a9788@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 5:04 AM, Patrick Steinhardt wrote:
> The "rerere-gc" maintenance task is responsible for pruning rerere
> entries older than a certain configurable cutoff point. Whether or not
> the task gets run during auto-maintenance can be configured via
> "maintenance.rerere-gc.auto":
> 
>   - A negative value indicates that maintenance should always run.
> 
>   - A zero value indicates that maintenance should never run.
> 
>   - Otherwise, a positive value indicates that maintenance should always
>     run in case we have at least a single rerere entry.
> 
> While the first two conditions are sensible, the last one is less so as
> it does not account for whether we would even prune old entries in the
> first place. Instead, it effectively implies that we unconditionally
> spawn "git rerere gc" when rerere is enabled. Chances are high though
> that there is nothing to prune, as the default cutoff dates are 60 days
> for resolved rerere entries and 15 days for unresolved ones.

I agree on these points. 
> @@ -121,10 +121,10 @@ maintenance.rerere-gc.auto::
>  	This integer config option controls how often the `rerere-gc` task
>  	should be run as part of `git maintenance run --auto`. If zero, then
>  	the `rerere-gc` task will not run with the `--auto` option. A negative
> -	value will force the task to run every time. Otherwise, any positive
> -	value implies the command will run when the "rr-cache" directory exists
> -	and has at least one entry, regardless of whether it is stale or not.
> -	This heuristic may be refined in the future. The default value is 1.
> +	value will force the task to run every time. Otherwise, a positive
> +	value implies the command should run when the estimated number of stale
> +	entries that would be pruned is greater than or equal to the configured
> +	value. The default value is 512.

Thanks for updating the docs so clearly.
>  maintenance.worktree-prune.auto::
>  	This integer config option controls how often the `worktree-prune` task
> diff --git a/builtin/gc.c b/builtin/gc.c
> index de2f9e7fed..9147418a61 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -396,31 +396,13 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
>  
>  static int rerere_gc_condition(struct gc_config *cfg UNUSED)
>  {
> -	struct strbuf path = STRBUF_INIT;
> -	int should_gc = 0, limit = 1;
> -	DIR *dir = NULL;
> +	int limit = 512;
>  
>  	repo_config_get_int(the_repository, "maintenance.rerere-gc.auto", &limit);
> +	if (limit <= 0)
> +		return limit < 0;

This is cute, but works. It's logically equivalent to

	if (!limit)
		return 0;
	if (limit < 0)
		return 1;

which would map more directly to the two documented cases. It takes
the slightest amount of mental processing to connect the docs to
the format you have.

> +	return rerere_gc_estimate(the_repository, limit) >= (size_t)limit;
>  }

I do like that this method is simpler in the builtin code in favor
of a method that has access to rerere internals.

I do wonder if rerere_gc_estimate() should be
rerere_stale_above_limit() instead, as we are not using any callers
that care about the resulting number other than "is it at least limit?"

> +size_t rerere_gc_estimate(struct repository *r, size_t limit)
> +{
> +	timestamp_t cutoff_resolve, cutoff_noresolve;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct dirent *e;
> +	size_t count = 0;
> +	DIR *dir;
> +
> +	dir = opendir(repo_git_path_replace(r, &buf, "rr-cache"));
> +	if (!dir)
> +		goto out;
> +
> +	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
> +
> +	while ((e = readdir_skip_dot_and_dotdot(dir))) {
> +		struct rerere_id id;
> +
> +		/*
> +		 * We estimate the number of stale entries by only considering
> +		 * those starting with "17". This is the same strategy that we
> +		 * use for estimating the number of loose objects.
> +		 */
> +		if (!starts_with(e->d_name, "17") ||
> +		    !is_rr_cache_dirname(e->d_name))
> +			continue;
> +
> +		id.collection = find_rerere_dir(e->d_name);
> +		for (id.variant = 0;
> +		     id.variant < id.collection->status_nr;
> +		     id.variant++) {
> +			if (rerere_id_is_stale(&id, cutoff_resolve,
> +					       cutoff_noresolve)) {
> +				count += 256;
> +				if (count >= limit)
> +					goto out;

This short-circuit is valuable and helps me understand the method
prototype including a limit. If the method is changed to be a
boolean result, then this would be 'result 1; goto out;'

> +			}
> +		}
> +	}
> +
> +out:
> +	if (dir)
> +		closedir(dir);
> +	free_rerere_dirs();
> +	strbuf_release(&buf);
> +	return count;
> +}
> +

Again, all I can find are taste preferences. This is a good
implementation and leaves some flexibility for future callers to
care about the number of stale entries.

Thank you also, for covering your change with tests.

Both patches LGTM.

Thanks,
-Stolee
