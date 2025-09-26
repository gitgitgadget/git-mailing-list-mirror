Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A951E86E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896099; cv=pass; b=nhZq15Kw6VSidjHPx8l520WcFbRBiTxGHXJjwITfq6zCgeoBurrHcuCr3cSS069tRTmzzNWrw3fPIKX/To8wSfMA+Vl2EdZWrSj+UImIRte2r2jKWzngzZ1Y/5UwJf8TkMFqcGUlqu1tBEjaYFn9wojm8yXOsKta/rOelP5RKfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896099; c=relaxed/simple;
	bh=+hvNPof/SilC/3lp9p5rgLsZMcuznOp0e59B6d13cfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D24uYUYNIwNoJHRqExRWLL+D2zHVmfGHE47x7LR1ZrUksoAr190bysKqWoYz6h9k+6fdfyy7/Xe0NyW1pa2cmAwrKCvv9HRRhbejqYVhLZiFe0LfA80YHB+8vknMPTE4Tu6p2MMxsdRFjGfGf/cEW2mZ8TKHz/vsFyAORhSb26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=eIk5JrNM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="eIk5JrNM"
ARC-Seal: i=1; a=rsa-sha256; t=1758896085; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NfQDM7iW9pOuSRHijkrGbwRX0+v2Nyfa9mAvPDxFUH/JRenb6l7jewUshyxmXZfSCu3Ej3K642lTu8B/681hvbHAOcAIbiqeCqe2cx3FGM30DkfiCk7I7OJFPw1VoHdnBIyyLlNbykx7UpWBRJV9vIduTRal+7UwYphIqXzLHh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758896085; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NTYuik8R3+HAf7o8Lti5J+d0DANG+fZod5gxgfpFRAY=; 
	b=RP5h1pS6YdJ6v6kRF3a5vKis2Ayc+YYySuDIc17N9qox2QGp4U4eLAjK3au7RQa+P9ZmMSONopC9GHAB2RHjHRnRA3nwxqyzJqxU3TgZ1vMEiTVh/OeoTUoH2WBFwlPPLbheLkQHadwA77pFIeaXANm5EDyv/DIXZCG+rJu/2ak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758896085;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=NTYuik8R3+HAf7o8Lti5J+d0DANG+fZod5gxgfpFRAY=;
	b=eIk5JrNMIJaLgCnkFkL1oskkpUZvEoB2SHljXij6S6b6OwYjI8WQoV6hs1AM3ANI
	XN4+wpc5DGgjcq6m01GLvbBDa9qI5EfW0DqqaLGnvD3cw/RC05m2isLsbaiKatix5gn
	zCKFKw7ZI3n3RFIW/r2IdJBwZCrlEVhKYNuQ3GAc=
Received: by mx.zohomail.com with SMTPS id 1758896083458329.38615303546567;
	Fri, 26 Sep 2025 07:14:43 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 06/10] run-command: allow capturing of collated output
In-Reply-To: <xmqqplbedwtg.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-7-adrian.ratiu@collabora.com>
 <xmqqplbedwtg.fsf@gitster.g>
Date: Fri, 26 Sep 2025 17:14:39 +0300
Message-ID: <873489nvw0.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Thu, 25 Sep 2025, Junio C Hamano <gitster@pobox.com> wrote: 
>> diff --git a/builtin/fetch.c b/builtin/fetch.c index 
>> 24645c4653..53bd5552c4 100644 --- a/builtin/fetch.c +++ 
>> b/builtin/fetch.c @@ -2129,7 +2129,7 @@ static int 
>> fetch_multiple(struct string_list *list, int max_children, 
>>   if (max_children != 1 && list->nr != 1) { struct 
>>  parallel_fetch_state state = { argv.v, list, 0, 0, config }; 
>> -		const struct run_process_parallel_opts opts = { + 
>> struct run_process_parallel_opts opts = { 
>>  			.tr2_category = "fetch", .tr2_label = 
>>  "parallel/fetch", 
> 
> This ... 
> 
>> diff --git a/builtin/submodule--helper.c 
>> b/builtin/submodule--helper.c index 07a1935cbe..76cae9f015 
>> 100644 --- a/builtin/submodule--helper.c +++ 
>> b/builtin/submodule--helper.c @@ -2700,7 +2700,7 @@ static int 
>> update_submodules(struct update_data *update_data) 
>>  { int i, ret = 0; struct submodule_update_clone suc = 
>>  SUBMODULE_UPDATE_CLONE_INIT; 
>> -	const struct run_process_parallel_opts opts = { + 
>> struct run_process_parallel_opts opts = { 
>>  		.tr2_category = "submodule", .tr2_label = 
>>  "parallel/update", 
> 
> ... and this ... 
> 
>>   
>> diff --git a/hook.c b/hook.c index 54568d5bc0..199c210b97 
>> 100644 --- a/hook.c +++ b/hook.c @@ -135,7 +135,7 @@ int 
>> run_hooks_opt(struct repository *r, const char *hook_name, 
>>  	}; const char *const hook_path = find_hook(r, hook_name); 
>>  int ret = 0; 
>> -	const struct run_process_parallel_opts opts = { + 
>> struct run_process_parallel_opts opts = { 
>>  		.tr2_category = "hook", .tr2_label = hook_name, 
> 
> ... and this are curious changes that are not explained in the 
> proposed log message. 

Yes and sorry for not explaining these better. The only reason I 
had to remove the const is to be able to set opts->ungroup = 0 
below.

If I can find a way to do what you propose, then 100% I will drop 
all these hunks. I agree that is the best way forward in v2.

> 
>> @@ -1841,6 +1852,10 @@ void run_processes_parallel(const struct 
>> run_process_parallel_opts *opts) 
>>  					   "max:%"PRIuMAX, 
>>  (uintmax_t)opts->processes);  
>> +	/* ungroup and reading sideband are mutualy exclusive, so 
>> disable ungroup */ +	If (opts->ungroup && 
>> opts->consume_sideband) +		opts->ungroup = 0; 
> 
> Make it a BUG(""), which may help avoid unintended bugs, 
> especially ... 

I did exactly this and got test failures because some tests end up 
setting both ungroup and consume_sideband. Since the original code 
I got from Emily and Aevar just defaulted to setting ungroup = 0 
and removing the const I went with that instead of actually fixing 
the tests, assuming the tests actually need to do that. :)

Now I know better and for v2 I will fix the tests and add a BUG() 
here, with proper reasoning for the test modification.

An example of test which fails because it sets both is:
t1416-ref-transaction-hooks.sh
not ok 7 - interleaving hook calls succeed
 
>> diff --git a/run-command.h b/run-command.h index 
>> 4679987c8e..ad0bab14b0 100644 --- a/run-command.h +++ 
>> b/run-command.h @@ -436,6 +436,20 @@ typedef int 
>> (*feed_pipe_fn)(int child_in, 
>>  				void *pp_cb, void *pp_task_cb);  
>> +/** + * If this callback is provided, instead of collating 
>> process output to stderr, + * they will be collated into a new 
>> pipe. consume_sideband_fn will be called + * repeatedly. When 
>> output is available on that pipe, it will be contained in + * 
>> 'output'. But it will be called with an empty 'output' too, to 
>> allow for + * keepalives or similar operations if necessary.  + 
>> * + * pp_cb is the callback cookie as passed into 
>> run_processes_parallel.  + * + * Since this callback is 
>> provided with the collated output, no task cookie is + * 
>> provided.  + */ +typedef void (*consume_sideband_fn)(struct 
>> strbuf *output, void *pp_cb); + 
>>  /** 
>>   * This callback is called on every child process that 
>>   finished processing.  * 
>> @@ -495,6 +509,12 @@ struct run_process_parallel_opts 
>>  	 */ feed_pipe_fn feed_pipe;  
>> +	/* +	 * consume_sideband: see consume_sideband_fn() 
>> above. This can be NULL +	 * to omit any special handling. 
>> +	 */ +	consume_sideband_fn consume_sideband; 
> 
> ... because which one between this and ungroup gets precedence. 
> Document that they are mutually exclusive, and help the callers 
> with a BUG("") message when both are set.

Agreed, will do in v2.
 
> 
>> @@ -529,7 +549,7 @@ struct run_process_parallel_opts 
>>   * emitting their own output, including dealing with any race 
>>   * conditions due to writing in parallel to stdout and stderr. 
>>   */ 
>> -void run_processes_parallel(const struct 
>> run_process_parallel_opts *opts); +void 
>> run_processes_parallel(struct run_process_parallel_opts *opts); 
> 
> This is the same unexplained curiousity I touched earlier. 

Yes, I promise I'll drop all these in v2.
