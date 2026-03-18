Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844903624CF
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856981; cv=pass; b=u5REQO1HuDpax4FCtgEw4Weat9wQ0CTGUwdV3fvvYMydVeIIqA77KFzX8ebmRmyJdv8f1I6Uj5VvlKvilTURPvBDvObpq0QSdDBMGPcm3A5NQ6tr8hWBdPfWhqgMq9kMT9zKi9sGc8ujhf9yqRHQuXN40J66JaRCh3C6ucOmekc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856981; c=relaxed/simple;
	bh=H3U1YFjcTYWyxBcA+u13F/jb7k4A9VMzQz1Qt6xwK8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NA6HXPSlNA35yP96EmGUSxp2jXAHbr+m1Bs/9ahVQ+TLTwnyXrJvusrI2hMqDuPtk1Em7KnRgDBNfxtMpMHVtSEfZk+TSNnOCx87o0N33bbX9SlMaiBlzpvOKzEaNARUvQDogjTtnYZLlmxPdJqFDnhhrdYqywFHiQCYUXxQwhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ir6OUabg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ir6OUabg"
ARC-Seal: i=1; a=rsa-sha256; t=1773856953; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hX0MCnnJzCVaZi+Iv2owjLG50yidRgRPBWBtcwShybJsyWiMacE0JTEoWqZE4g53IfUlfPaQ0lPKNTlxBPS0etD8uaPgEi1fR2QjZwWq0H83u1IuIL3vEz6oyo5PUVDjB+Js1LYWnMySb4h/pYedy4C3gRPcnI+zpyrfYZhecP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773856953; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WXdtwTC8O8Od91vtxt3YljYfOXBaPbBGb2PpUy2lheY=; 
	b=BzO4nLcZDoZWD+b+c7PyXildr08drbpWGa6ejAq/ug+HXksp6XavpX7MQC6sgQCoeAj/R/sMcH6DSwOwQenvFoH/Wc9/6aDw6xKqWSgYZBnTXOg3XgPA55iQw31VDiwE1VIJJPZGXDbe2bbsIWFcroVYArcYq1jlJzZHoAZpdrA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773856953;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=WXdtwTC8O8Od91vtxt3YljYfOXBaPbBGb2PpUy2lheY=;
	b=ir6OUabgrj14MgfU/Dfv5JrKZNef0oJIxVmYvJtSqfK6W4JgiIBLFJYfQ3pj5pub
	wGONFhi72x9dN7fvdr2JQdVbr0UIphMT7lXDaNbruCBMZ3+GzemujsoebJF5ahklnm5
	aYTOYoiK49TwTfGzHoVYgXJP/fOZakrrYZODyXjU=
Received: by mx.zohomail.com with SMTPS id 1773856949178675.2599645611344;
	Wed, 18 Mar 2026 11:02:29 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>, Emily Shaffer <nasamuffin@google.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/9] hook: allow parallel hook execution
In-Reply-To: <xmqqjyvcstvi.fsf@gitster.g>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-5-adrian.ratiu@collabora.com>
 <xmqqjyvcstvi.fsf@gitster.g>
Date: Wed, 18 Mar 2026 20:02:23 +0200
Message-ID: <871phh2ez4.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sun, 15 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> +hook.<name>.parallel::
>> +	Whether the hook `hook.<name>` may run in parallel with other hooks
>> +	for the same event. Defaults to `false`. Set to `true` only when the
>> +	hook script is safe to run concurrently with other hooks for the same
>> +	event. If any hook for an event does not have this set to `true`,
>> +	all hooks for that event run sequentially regardless of `hook.jobs`.
>
> This is very conservative and safe default.
>
>> @@ -307,6 +316,7 @@ static void build_hook_config_map(struct repository *r,
>>  			entry->command = command ? xstrdup(command) : NULL;
>>  			entry->scope = scope;
>>  			entry->disabled = is_disabled;
>> +			entry->parallel = (int)(uintptr_t)par;
>
> Hmm.  The source "par" is (void *) and the destination .parallel
> member is a single bit, so would this
>
> 			entry->parallel = !!par;
>
> be the same?  A cast first to uintptr_t, presumably not to lose
> bits, and then casting it down to potentially narrower int made me
> wonder what else is going on here that is tricky.

Yes, I will use the double negation here on the re-roll, it's the same
and much cleaner (thank you), since it's a simple on/off toggle.

it'sAs you saw on other series, double negation just doesn't occur to me. :)

>> +/* Determine how many jobs to use for hook execution. */
>> +static unsigned int get_hook_jobs(struct repository *r,
>> +				  struct run_hooks_opt *options,
>> +				  struct string_list *hook_list)
>> +{
>> +	unsigned int jobs;
>> +
>> +	/*
>> +	 * Hooks needing separate output streams must run sequentially. Next
>> +	 * commits will add an extension to allow parallelizing these as well.
>> +	 */
>> +	if (!options->stdout_to_stderr)
>> +		return 1;
>> +
>> +	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
>> +	if (options->jobs)
>> +		return options->jobs;
>
> This could be risky for hooks that claim they do not want to run
> with others at the same time, but the CLI user ought to know what
> they are using, so this override is very much appreciated.  After
> all, the override may be serializing an overly optimisitic set of
> hooks that want to run in parallel to avoid interaction between
> them.

Yes, that was my reasoning as well.

I'll expand the comment to explain a bit better why we're doing it.

>> +	/*
>> +	 * Use hook.jobs from the already-parsed config cache (in-repo), or
>> +	 * fall back to a direct config lookup (out-of-repo).  Default to 1.
>> +	 */
>> +	if (r && r->gitdir && r->hook_config_cache)
>> +		/* Use the already-parsed cache (in-repo) */
>> +		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
>> +	else
>> +		/* No cache present (out-of-repo call), use direct cfg lookup */
>> +		jobs = repo_config_get_uint(r, "hook.jobs", &jobs) ? 1 : jobs;
>> +
>> +	/*
>> +	 * Cap to serial any configured hook not marked as parallel = true.
>> +	 * This enforces the parallel = false default, even for "traditional"
>> +	 * hooks from the hookdir which cannot be marked parallel = true.
>> +	 */
>> +	for (size_t i = 0; jobs > 1 && i < hook_list->nr; i++) {
>> +		struct hook *h = hook_list->items[i].util;
>> +		if (h->kind == HOOK_CONFIGURED && !h->parallel)
>> +			jobs = 1;
>> +	}
>
> Losing "jobs > 1 &&" from the termination condition and instead
> explicitly "break;" out when we demote jobs to 1 would be easier to
> read, even though it would spend two more lines, i.e.,
>
> 	for (size_t i = 0; i < hook_list->nr; i++) {
>         	struct hook *h = ...;
> 		if (...) {
> 			jobs = 1;
> 			break;
> 		}
> 	}

Indeed, that is much easier to read, will do it in the next re-roll,
thanks again.

I was thiking in pseudo-code something like this when I wrote it:

if (jobs > 1); then
   for each hook in list do
       if hook is configured and not parallel then
          jobs = 1;

Then just integrated the (jobs > 1) condition into the for loop below
it, the break short-circuit didn't occur to me. :)

>
>
> Other than that, very cleanly written.

Many thanks again, this function I think is the "hairiest" part of the
series, at least it's what gave me the most trouble and also the part
where I spent most time until I could convince myself it's correct.
