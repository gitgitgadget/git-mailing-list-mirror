Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB32F5A02
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888256; cv=pass; b=VrLUlvbH5x/YkkQ19sK5/4LGOgx3/j0ICEI/d9p0pxF9mUgfe+s/hIIDWvW0DHU2VymZWO58xd4ftL4emKfja6Q6a9Zj3AO1x7Er3LjM+CjpOlMRcyWVVb3udO+nJJZ/TXIhFIp9B9cb7ZbpHVr3dRKT3hwlnZwsdphdHJnk1hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888256; c=relaxed/simple;
	bh=5ow5KHh5iEi86RzxZ7bN+uSQEz60ElhecPKBntRCZS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXwkLCs4FdEpZqjxDK+aUhcBbIVKKdOXhDmtvV6Rw/CQT4k50qVcRArIw/qvuY4rcT/VjqCDSR8XCV22NvmlJgSJa9e3SnJbYhFU90hEzZ2x5Xm9YlLTrWf4Q3xr8e0ss5dhMg/1pRdB/n4folWVVA6fw2OBztWn+lhA2420E+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=h6HiGSoK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="h6HiGSoK"
ARC-Seal: i=1; a=rsa-sha256; t=1758888232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WmKKj9Bd5TDGeORiOm0pqt1hOLMsgQ6G7sF9YuqM5utfWmWm/XmmfZ1d2ymf28g1Ka1BQfFRBspQiSncaqJd1aQlLKI0bB9qatPIsk2B8iqUY282IeC8NnPM7SnrVB/nwGQqKM8kz6f/cbujTzAEBZmdJLH0EIxq+UFhXMkrfMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758888232; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7tShwlTqcTS/a6uR0m8WhoQXci25WlDG8db67ebK6QI=; 
	b=f4N7ThcTUUr8+hdSsLQddAQ/N6R+7pe335/Qe/mKQxquO9Sk2HxF0Am1mnhh6wYY4pv3KT8ltbt5kdIZog4EMG2+CfU8zBNOtPkZfPy/zYwCLjI/jXYMmwcFlA6O/SW0TfnzMaszVY9n/2S4hLP+kYX30hk4NqLB5OkFNuiyUZo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758888232;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=7tShwlTqcTS/a6uR0m8WhoQXci25WlDG8db67ebK6QI=;
	b=h6HiGSoKoh9WvJLjxEx6shsGu2oYELerDdxM+19ILEwtWBd/J2QFRyU5GVemhrvB
	VyGKx36YubWHh6H4MindhnDFpOBY5ESM2LT7yRNV+siDNqBTBxIciDX4YE0nPu7mU/k
	hTh2UG5cWWVi4v0vE/z6oV6L7Wx/eqB943kA5Nb4=
Received: by mx.zohomail.com with SMTPS id 1758888231107434.3726880658677;
	Fri, 26 Sep 2025 05:03:51 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 02/10] hook: provide stdin via callback
In-Reply-To: <xmqqh5wqfgbs.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-3-adrian.ratiu@collabora.com>
 <xmqqh5wqfgbs.fsf@gitster.g>
Date: Fri, 26 Sep 2025 15:03:45 +0300
Message-ID: <87ecrto1y6.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Thu, 25 Sep 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> @@ -69,6 +69,10 @@ static int pick_next_hook(struct 
>> child_process *cp, 
>>  	if (hook_cb->options->path_to_stdin) { cp->no_stdin = 0; 
>>  cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY); 
>> +	} else if (hook_cb->options->feed_pipe) { + 
>> cp->no_stdin = 0; +		/* start_command() will allocate a 
>> pipe / stdin fd for us */ +		cp->in = -1; 
>>  	} cp->stdout_to_stderr = 1; cp->trace2_hook_name = 
>>  hook_cb->hook_name; 
> 
> OK, so when feed_pipe is defined, just like when path_to_stdin 
> is specified, we stop saying there is nothing coming from the 
> standard input, and intead set cp->in so that the child process 
> would read from there.  Unlike path_to_stdin case it is not 
> pointing at a file descriptor that is opened for a filesystem 
> entity.  ".in = -1" is a standard signal to run-command.[ch] 
> machinery that a pipe to that child is to be prepared. 

Yes, that is all correct.

 
>> @@ -37,6 +38,24 @@ struct run_hooks_opt 
>>  	 * Path to file which should be piped to stdin for each 
>>  hook.  */ const char *path_to_stdin; 
>> + +	/** +	 * Callback to ask for more content to pipe to 
>> each hook stdin.  +	 * +	 * If a hook needs to consume 
>> large quantities of data (e.g. a list of all refs received in a 
>> +	 * client push), feeding data via in-memory strings or 
>> slurping to/from files via path_to_stdin +	 * will not be 
>> efficient, so this callback allows for piecemeal reading and 
>> writing.  +	 * +	 * Add initalization context to 
>> hook.feed_pipe_ctx.  +	 */ +	feed_pipe_fn feed_pipe; + 
>> void *feed_pipe_ctx; 
> 
> The comment for the member is a bit too wide.  More importantly, 
> this does not seem to capture the fact that this is completely 
> ignored when path_to_stdin is already in effect.  We should at 
> least document it if we wanted to leave the behaviour as is, but 
> I wonder if we want to detect and flag it as BUG() if both 
> feed_pipe and path_to_stdin are not NULL.  There is no inherent 
> reason why the data prepared in a file must take precedence over 
> data coming over a pipe. 

Very good points. I agree we should flag a BUG() when both are 
provided, because the stdin feed methods are mutually exclusive.
 
This is actually something I thought about while coding/testing v1 
and just forgot to add in.

Will do in v2 and also make the comment less wide.

Many thanks for spotting this!
