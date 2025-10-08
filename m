Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3D29DB6E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907092; cv=pass; b=UU8uuY3SJic92lS1vKPU1F5gAUXXhkWhguDBwoNY4Zo6bw7d6WXQac8tNrcf4rHhAY9nzGaPJCl951H+mtIa2gCHleAh3A3i88MTb3ODh7XzgaNW76bxgQQaZv5GbCOFaXnPqc/1quOmgCJoDRvSEDHo1w8kI+5jo4LVRDqPQfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907092; c=relaxed/simple;
	bh=8LEueoGFP1x1ZdVjEObOiirjfT9AhwBsd/3A/qoLqQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkxyXHZtRtgT95yfB5OZKpjLDYZnkksf0e8sdJEY5X8TRj29HNc/dTfPQsyiDs91QnRACM3WnaYoUD8xd7wdMEzyDKvKEmliHTL4nRiOHuuQ9ffqWdHwr9KNdwYWJv7Yjrh4fYVemOiRWn3RzjvVpuHIYIVGrwUWH/URA5a2TXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WFawblQL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WFawblQL"
ARC-Seal: i=1; a=rsa-sha256; t=1759907069; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HHv5YiWkqIDQbSujEl7LSP2oIFfWzwKmEXi3UQoK+b9spiFyc6VGbAscn4Xi2mqzz+W61HRv2jWeIMdeTEE5L0txnLFjcbOggpqFJhyyzNcrBgjhMOsfImgQDwlJEyQ5iio1EYYRimgC47LflpDVq7XQ4AykAjZfCP7dBbcmcE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759907069; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cboupzNUt4Le/A/VxouiOXXCz2Y3rt7ViJ7z0mOSAqw=; 
	b=FQGikGGJYAVh4nFd2d5ygSK0wGvIeKXr0wpbOAFTcDFb1eABAosxSd5NrpiE6xIL63/GqkGUWVVTCqS4elY7cyv/mcB4AjhLyzZI5vm12Hh55vAa5YzlgRNOFXJ3+03P1DSldokqqgQs7fVZbndMHMWiIxpTvVc/8jCOVlyAT4w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759907069;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=cboupzNUt4Le/A/VxouiOXXCz2Y3rt7ViJ7z0mOSAqw=;
	b=WFawblQLCqAua6tI9RnF5Gs5H99Zq0hKgLzwQaycQlE0/OwYblWOFMrR0QfaIvpQ
	1bMQhgSp/ELEhxBrJpTfVVufdD67PzmDS12MsFyRqjXrVQQUOC1oK3fuey7blljWiso
	0Xksl9zp2sBJ6W144P55kcWSYKUW3JWGWlEzupEE=
Received: by mx.zohomail.com with SMTPS id 1759907062562757.7911832257449;
	Wed, 8 Oct 2025 00:04:22 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
In-Reply-To: <aN4c9sqHTgn2wot7@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
 <aN4c9sqHTgn2wot7@pks.im>
Date: Wed, 08 Oct 2025 10:04:18 +0300
Message-ID: <87y0pl3mdp.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi Patrick!

On Thu, 02 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Sep 25, 2025 at 03:53:46PM +0300, Adrian Ratiu wrote: 
>> diff --git a/sequencer.c b/sequencer.c index 
>> 9ae40a91b2..93cd6ab1f2 100644 --- a/sequencer.c +++ 
>> b/sequencer.c @@ -1298,32 +1298,46 @@ int 
>> update_head_with_reflog(const struct commit *old_head, 
>>  	return ret; }  
>> +static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, 
>> void *pp_task_cb UNUSED) +{ +	struct hook_cb_data 
>> *hook_cb = pp_cb; +	struct strbuf *to_pipe = 
>> hook_cb->options->feed_pipe_ctx; +	int ret; + +	if 
>> (!to_pipe || !to_pipe->len) +		return 1; /* 
>> nothing to feed */ + +	ret = write_in_full(hook_stdin_fd, 
>> to_pipe->buf, to_pipe->len); 
> 
> One thing I wondered in previous patches was whether we now have 
> the potential for deadlocks. If we feed data to a child that 
> exceeds the buffered I/O size, and that child writes data that 
> is consumed by Git larger than the buffered I/O size, as 
> well. Wouldn't that mean that we may now not make any progress 
> at all? 
> 
> I guess that's no different compared to before though, as we 
> also used `write_in_full()` there.

That is correct, yes, it's the same as before.

Deadlocks can happen, however they are the result of bugs, for 
example a hook child waits for stdin, the parent doesn't feed 
anything and decides to wait for the child to finish. :)

I hit quite a few of these during development, however they should 
all be fixed (deadlocks are usually easily fixed once detected).

Related, but also important, is thoroughtput when feeding the 
pipes: sending input too granularly (e.g. by calling the callback 
on each line when we send many lines) can add unnecessary 
latencies / delays due to the run-command ppoll mechanism.

It's a balance we must find: for most hooks it doesn't matter 
because the input is small (in this case it's a single write), 
however hooks like post-receive get large amount of data, so there 
I had to batch 300-500 lines to get simliar performance as before 
the callback.

So yes, it's improtant to have no deadlocks and it's also 
important to have roughly the same throughtput through the pipes.
 
>> +	if (ret < 0) { +		if (errno == EPIPE) { + 
>> return 1; /* child closed pipe, nothing more to feed */ + 
>> } 
> 
> Style: let's drop the curly braces around single-line 
> statements. 

Ack, will do, others pointed it out as well.
 
>> +		return ret; +	} + +	/* Reset the input buffer 
>> to avoid sending it again */ +	strbuf_reset(to_pipe); 
> 
> Is this really necessary? I would've expected that we return a 
> positive value from this callback, and as a consequence the 
> run-command subsystem should notice that we're done with writing 
> stdin and close the file descriptor for us. Afterwards, it 
> shouldn't invoke this callback ever again, shouldn't it?

That is correct: it is not necessary. Phillip already made me 
aware that I can significantly simplify this function, which I 
will do in v2 shortly. :)
 
> 
>> @@ -5140,16 +5154,16 @@ static int pick_commits(struct 
>> repository *r, 
>>  		flush_rewritten_pending(); if 
>>  (!stat(rebase_path_rewritten_list(), &st) && st.st_size > 0) { 
>> -			struct child_process child = 
>> CHILD_PROCESS_INIT; +			struct 
>> child_process notes_cp = CHILD_PROCESS_INIT; 
>>  			struct run_hooks_opt hook_opt = 
>>  RUN_HOOKS_OPT_INIT;  
>> -			child.in = 
>> open(rebase_path_rewritten_list(), O_RDONLY); - 
>> child.git_cmd = 1; -			strvec_push(&child.args, 
>> "notes"); -			strvec_push(&child.args, "copy"); 
>> -			strvec_push(&child.args, 
>> "--for-rewrite=rebase"); +			notes_cp.in = 
>> open(rebase_path_rewritten_list(), O_RDONLY); + 
>> notes_cp.git_cmd = 1; + 
>> strvec_push(&notes_cp.args, "notes"); + 
>> strvec_push(&notes_cp.args, "copy"); + 
>> strvec_push(&notes_cp.args, "--for-rewrite=rebase"); 
>>  			/* we don't care if this copying failed */ 
>> -			run_command(&child); + 
>> run_command(&notes_cp); 
>>   hook_opt.path_to_stdin = rebase_path_rewritten_list(); 
>>  strvec_push(&hook_opt.args, "rebase"); 
> 
> This change looks completely unrelated to me? 

Yes, Phillip pointed this out as well, I will drop it in v2.

Thanks!
