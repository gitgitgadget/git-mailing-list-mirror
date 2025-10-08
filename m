Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BE23F42D
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926417; cv=pass; b=qHwt/8QAVQDwXa07Ra5iZxHNUEyhCoP7+vnA+ugbBCu73rzteeNBUiAwbuMrqj1MG59N+jncBEtQ20vvmV91f2YDAXTFSS+YrTiLDGEwYdYNAYnrOZy4diQ35sOGKHdeRlA/a+IQIwkJbyY5Q1EfL1n0NKM+g4a/RyyKo2I+wkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926417; c=relaxed/simple;
	bh=1HZNzukepkC1A30TofVbehkNNwOfKjHK3eQDbn1QOWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r0hmPM5jUp9AJ1oBPbBhnB3M76VPb7LO0U24c0Hn1VOL43NrvbSb0lhXo63PPYBbBG1u+Sl11IAwyO8gZ1+8pxtqAf78RJfoqY9xP8/amKmmFkjQtnR08g0Oc/IENpVr7aPctp61/f2021JMEdPwARBbppCzeg7gsmMuWhIvVXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Smj+YI04; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Smj+YI04"
ARC-Seal: i=1; a=rsa-sha256; t=1759926403; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fGi8xUTpotRYf/QgWKd3qQDWKYKoibA9YWpSylYDJ3RJF9ZoSEx0J9WFlWmFpcQADgiS5EhnqdDbYeQDJor8R6G4kPIPB9Qf1MMPuKFh1OplbffeXJIKkFefExnT6RE/fGIr4jSowOBs0LpCFS307Ig2We2dU/0nKiIbOF0bzvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759926403; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iL2QPD7ggojnFqxi3jFkshTBrkgovVzFcWSXK00IL5Y=; 
	b=BPJPjplMyP42hj66LUWs4V5WBTv8VIb5yShtHZbZb4NoCAtDBFwASzrUxqkgAX1TT5YYMdE9E/aHwe8kDcLxZJQSSlPamFhlQ0Fbvpn2L5WLp7rzbIJb0coIqq0Mkpi3KAd6cbYq43n7Ul89hIPuTinrK729J0aQilHjdSqCEGM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759926403;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=iL2QPD7ggojnFqxi3jFkshTBrkgovVzFcWSXK00IL5Y=;
	b=Smj+YI04Ax6AiV6T/WCx7FA1rmNL65f52D9X3UE1/5D0k/VxezoTHFNm5bfOwJRM
	HzxnMhAWLmdov1de7lI9/cijgRzdO8NycdGL2IYfHweQa1+GUfKq5RUvlJLV9x0jTlA
	bWCoJ0v3frVG4otXEtMkb8D9tuAVmFNYH6fPDB6w=
Received: by mx.zohomail.com with SMTPS id 1759926400999313.21511931070654;
	Wed, 8 Oct 2025 05:26:40 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 05/10] reference-transaction: use hook.h to run hooks
In-Reply-To: <aN4c_DWtqBBScKEh@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-6-adrian.ratiu@collabora.com>
 <aN4c_DWtqBBScKEh@pks.im>
Date: Wed, 08 Oct 2025 15:26:32 +0300
Message-ID: <87v7kp37gn.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi Patrick and sorry for the delayed reply!

On Thu, 02 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Sep 25, 2025 at 03:53:48PM +0300, Adrian Ratiu wrote: 
>> diff --git a/refs.c b/refs.c index 4ff55cf24f..5a2b6ad1fc 
>> 100644 --- a/refs.c +++ b/refs.c @@ -2377,31 +2377,16 @@ static 
>> int ref_update_reject_duplicates(struct string_list *refnames, 
>>  	return 0; }  
>> -static int run_transaction_hook(struct ref_transaction 
>> *transaction, -				const char *state) 
>> +static int transaction_hook_feed_stdin(int hook_stdin_fd, void 
>> *pp_cb, void *pp_task_cb UNUSED) 
>>  { 
>> -	struct child_process proc = CHILD_PROCESS_INIT; + 
>> struct hook_cb_data *hook_cb = pp_cb; +	struct 
>> run_hooks_opt *opt = hook_cb->options; +	struct 
>> ref_transaction *transaction = opt->feed_pipe_ctx; 
>>  	struct strbuf buf = STRBUF_INIT; 
>> -	const char *hook; -	int ret = 0, i; - -	hook = 
>> find_hook(transaction->ref_store->repo, 
>> "reference-transaction"); -	if (!hook) -		return 
>> ret; - -	strvec_pushl(&proc.args, hook, state, NULL); - 
>> proc.in = -1; -	proc.stdout_to_stderr = 1; - 
>> proc.trace2_hook_name = "reference-transaction"; - -	ret = 
>> start_command(&proc); -	if (ret) -		return 
>> ret; - -	sigchain_push(SIGPIPE, SIG_IGN); 
>>   
>> -	for (i = 0; i < transaction->nr; i++) { +	for (int i 
>> = 0; i < transaction->nr; i++) { 
>>  		struct ref_update *update = 
>>  transaction->updates[i]; 
>> +		int ret; 
>>   if (update->flags & REF_LOG_ONLY) continue; 
> 
> Hm. In the "pre-push" hook you converted the callback to process 
> one ref per invocation. Why don't we do the same over here, with 
> one transaction per invocation? 
> 
> Not saying that either one of these is better, but it left me 
> puzzled why we use two different patterns now. 

Good catch! It's a good idea to make them consistent.

We should do it here like we did for pre-push, to avoid processing 
all data at once and risk blocking on the write side (one 
extreme).

However, writing just once/one-line per callback (the other 
extreme) might add unnecessary delay/waiting on the hook child 
side.

So I'll modify both to batch let's say 50-100 in one call, to 
ensure a good balance.

This ties into my previous message about how much data should we 
write in one batch to ensure good throughtput while also not 
blocking for too long. Hope it makes sense.

Will improve this in v2.

Again, many thanks for your careful review, really appreciate it.
