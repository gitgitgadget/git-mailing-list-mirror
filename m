Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BA2E7BAA
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244839; cv=pass; b=mEpK8NWArUbO/FiUm22e7cg0vdhfOEFIttvLe2H6rCyAoJb1waJyLuEo5omEwxPH/m9Vk/xGVFIhilW3JEJnLFqOy+itMNC9tRAomMGPxGj55Y9hME1q1n9YkIAIZuNBa7lysYbrlPMPm3C4nPur7imKAynZWiw7ge68RELMyyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244839; c=relaxed/simple;
	bh=3RH/7GeLwB2GTffSUkijVsXYhWoEaIoFJu1f4GE7VJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sF6hJh1kWFqvTqflwFKWWtQ+mgdMWAQUPk/Zlq3Anry13HDDXX2SkGalML8PuXgA0BSJ+o/QH7yxJfYtGPA559K+49YLrlFWBH/rjWZzqf0XTIQ9JgWH95ZiJ0ynZ8RyrvQiDJHk13PyTHx89rix80NzbJ99lnR1OAA3OXWB5Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bV/DNMNJ; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bV/DNMNJ"
ARC-Seal: i=1; a=rsa-sha256; t=1764244825; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fUJxyYR7ewk3CTydO96tRBATDtwjaz8Ua4sZhZ0hTbD8MPtWh2YFbdE8kZsK4mlqT2JspJz6pMUgg3XZikAzeHpaM9nwGTkfcErD61KvHdu3v/8i8duKWdzKHRRlvMWeDwLgJozga176FOLYznb2gtIqN1Et0XpsTYqWsKMuJYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764244825; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pBGekbVMGNEmE3xiWQ6vdNeRk5jsI/uKP4EzFiUIf4c=; 
	b=Mqnk1VCY0RNy5Gf+lVO4aA5aC48tr+XEH9X5u4Ojt0NPaDcBoTXfYxNNG737mhmcjajJNXd/43FXPdeArf1C9XMS0gA5yWQsKrz7B4GRl0GyI8Pl0p0ZEQv+v2tJ0a03CBY3VjPy0lRyKsT3tFIBXMznsZ8Aawt+2xVGEQ8ZHY0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764244825;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=pBGekbVMGNEmE3xiWQ6vdNeRk5jsI/uKP4EzFiUIf4c=;
	b=bV/DNMNJd43ZfGcuBKlSb3B4MU8fS1lqzAog3K8488Ist+Aw2whmn+gbxl6/FcwV
	/k/mJgkIFLrHn+GJ3g8BWgrOFz7eHsllflMWfLxKALyYZtYi9l8yHUbhFLu4jYwM5vh
	ZKtBx85vcWTxLdyZ+wWfJljSADfqpqWQsGRFv8IE=
Received: by mx.zohomail.com with SMTPS id 1764244823336713.6708967315485;
	Thu, 27 Nov 2025 04:00:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 01/10] run-command: add stdin callback for
 parallelization
In-Reply-To: <xmqqsee1puup.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-2-adrian.ratiu@collabora.com>
 <xmqqsee1puup.fsf@gitster.g>
Date: Thu, 27 Nov 2025 14:00:18 +0200
Message-ID: <87tsyfit2l.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 25 Nov 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> +static void pp_buffer_stdin(struct parallel_processes *pp, + 
>> const struct run_process_parallel_opts *opts) +{ +	/* Buffer 
>> stdin for each pipe. */ +	for (size_t i = 0; i < 
>> opts->processes; i++) { +		struct child_process *proc 
>> = &pp->children[i].process; +		int ret; + + 
>> if (pp->children[i].state != GIT_CP_WORKING || proc->in <= 0) + 
>> continue; 
> 
> This combination of two conditions is a recurring theme in this 
> series (e.g., something close to the reverse of this is called 
> child-ready-for-cleanup later). 
> 
> I wonder if it makes the code easier to follow if we add a set 
> of helpers that take a pointer to &pp->children[i] (and we 
> probably should give the struct that describes each child 
> managed in the "struct parallel_processes" some name) and asks 
> "is this thing done?" etc.

I think this is a good idea and worth exploring.

Will see what I can come up and if this makes code patterns 
clearer. Thanks!
 
>> diff --git a/run-command.h b/run-command.h index 
>> 0df25e445f..e536ed7544 100644 --- a/run-command.h +++ 
>> b/run-command.h @@ -420,6 +420,22 @@ typedef int 
>> (*start_failure_fn)(struct strbuf *out, 
>>  				void *pp_cb, void *pp_task_cb);  
>> +/** + * This callback is repeatedly called on every child 
>> process who requests + * start_command() to create a pipe by 
>> setting child_process.in < 0.  + * + * pp_cb is the callback 
>> cookie as passed into run_processes_parallel, and + * 
>> pp_task_cb is the callback cookie as passed into 
>> get_next_task_fn.  + * The contents of 'send' will be read into 
>> the pipe and passed to the pipe. 
> 
> There is no 'send' seen around here.  Does this refer to 
> something a later step adds? 

Good catch. This is a leftover comment from one of the previous patch
iterations. Will remove.
