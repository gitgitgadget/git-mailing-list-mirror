Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EFC209AD
	for <e@80x24.org>; Sat,  1 Oct 2016 20:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbcJAUto (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 16:49:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35642 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbcJAUtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 16:49:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so3862673wmg.2
        for <git@vger.kernel.org>; Sat, 01 Oct 2016 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TPqRMmao/HQTNzuoF978j+S3K4Tn4mEZk/1cYFb0rrE=;
        b=s9m7u7DMWtIaCj3IyTrE/5eKayr0j2mA6aqNOTVe+CsF5TTmZ5cBNIFHpRbkjigldl
         KYFLe6PAV9gPeXAuNIDIzLihmsi36DEPu8fEb2Cu96uisjMg1BWTuGMU2HaUoPVhzpF3
         6vuhGv1dElaOwuTp3RvvwLI16b81JYenIOaKqvK3BLsE6hNFmBN1TEjxbyuJMdziJxX9
         Te7EDhtGgsf21wSXqYqRuYwXb5eiW0iCxZ9cuXJNtXNoGbEEBIES93ykelhjUtoIgenQ
         NDC4zPUSwstuOz3CF9Se28F5BzmQVeCJIGxJcqU3OUT2dptRWUjdy3RNMCrSnylvzgeE
         bGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TPqRMmao/HQTNzuoF978j+S3K4Tn4mEZk/1cYFb0rrE=;
        b=KJQGWyrsVihmXx7rEFkHsCaKIlXORNXxnAZ9X8WS+wIR+aiUml0gc5jbhmVkuAWXXg
         DB3BqSAYGyALouFqzC6wN/3SlgJP5jkgxvfNGMTFMr9fz227oJ1zNVX76ppY57KBdPko
         Kyey8B9S64yYyx84J/jp4eSAY2ulzpmlC6jQy45ROTUc0unS/2a9uCr3fbmRiKbchNP9
         GSA9FRaOBUNpyhnACmrX4wtrAYIm2bUxBqTdLZMuhnXzKAKSzMf3SA9X3dPczgkuFDfo
         xVZNOdzu4NvxlM9zAZoy5doBewSIbseDfVY3LQP0cSDhGz2jkKl2vKbnV/J5hoiKl4Oz
         XAvw==
X-Gm-Message-State: AA6/9Rl/almBfNoSJcDREq0XDf/rObkcaRhms80P5CwN4W9h2E6PdDgC4YEGOuPrJEBV6w==
X-Received: by 10.194.52.3 with SMTP id p3mr13196840wjo.55.1475354926572;
        Sat, 01 Oct 2016 13:48:46 -0700 (PDT)
Received: from [192.168.1.26] (abrc125.neoplus.adsl.tpnet.pl. [83.8.96.125])
        by smtp.googlemail.com with ESMTPSA id p144sm10892679wme.0.2016.10.01.13.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Oct 2016 13:48:45 -0700 (PDT)
Subject: Re: [PATCH v8 00/11] Git filter protocol
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
 <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
 <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
 <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com>
Date:   Sat, 1 Oct 2016 22:48:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.10.2016 o 20:59, Lars Schneider pisze: 
> On 29 Sep 2016, at 23:27, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> We discussed that issue in v4 and v6:
>>> http://public-inbox.org/git/20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net/
>>> http://public-inbox.org/git/xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com/
>>>
>>> My impression was that you don't want Git to wait for the filter process.
>>> If Git waits for the filter process - how long should Git wait?
>>
>> I am not sure where you got that impression.  I did say that I do
>> not want Git to _KILL_ my filter process.  That does not mean I want
>> Git to go away without waiting for me.
>>
>> If the filter process refuses to die forever when Git told it to
>> shutdown (by closing the pipe to it, for example), that filter
>> process is simply buggy.  I think we want users to become aware of
>> that, instead of Git leaving it behind, which essentially is to
>> sweep the problem under the rug.

Well, it would be good to tell users _why_ Git is hanging, see below.

>>
>> I agree with what Peff said elsewhere in the thread; if a filter
>> process wants to take time to clean things up while letting Git
>> proceed, it can do its own process management, but I think it is
>> sensible for Git to wait the filter process it directly spawned.
> 
> To realize the approach above I prototyped the run-command patch below:
> 
> I added an "exit_timeout" variable to the "child_process" struct.
> On exit, Git will close the pipe to the process and wait "exit_timeout" 
> seconds until it kills the child process. If "exit_timeout" is negative
> then Git will wait until the process is done.

That might be good approach.  Probably the default would be to wait.

> 
> If we use that in the long running filter process, then we could make
> the timeout even configurable. E.g. with "filter.<driver>.process-timeout".

Sidenote: we prefer camelCase rather than kebab-case for config
variables, that is, "filter.<driver>.processTimeout".

Also, how would one set default value of timeout for all process
based filters?

> 
> What do you think about this solution?

I think this addition be done after, assuming that we come up
with good default behavior (e.g. wait for filter processes
to finish).

Also, we would probably want to add some progress information
in a similar way to progress info for checkout, that is display
it after a few seconds waiting.

This could be, for example:

  Waiting for filter '<driver>' to finish... done

With timeout it could look like this (where underlined part
is interactive, that is changes every second):

  Waiting 10s for '<driver>' filter process to finish.
          ^^^

And then either

  Filter '<driver>' killed

or

  Filter '<driver>' finished


> diff --git a/run-command.c b/run-command.c
> index 3269362..a933066 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -21,6 +21,8 @@ void child_process_clear(struct child_process *child)
>  
>  struct child_to_clean {
>  	pid_t pid;
> +	int stdin;
> +	int timeout;
>  	struct child_to_clean *next;
>  };
>  static struct child_to_clean *children_to_clean;
> @@ -28,9 +30,30 @@ static int installed_child_cleanup_handler;
>  
>  static void cleanup_children(int sig, int in_signal)
>  {
> +	int status;
> +	struct timeval tv;
> +	time_t secs;
> +
>  	while (children_to_clean) {
>  		struct child_to_clean *p = children_to_clean;
>  		children_to_clean = p->next;
> +
> +		if (p->timeout != 0 && p->stdin > 0)
> +			close(p->stdin);

Why are you not closing stdin of filter driver process if timeout
is zero?  Is it maybe some kind of special value?  If it is, this
is not documented.

> +
> +		if (p->timeout < 0) {
> +			// Wait until the process finishes
> +			while ((waitpid(p->pid, &status, 0)) < 0 && errno == EINTR)
> +				;	/* nothing */

Ah, this loop is here because waiting on waitpid() can be interrupted
by the delivery of a signal to the calling process; though the result
is -1, not just any < 0.

Looks good (but we would want some progress information, probably).

> +		} else if (p->timeout != 0) {
> +			// Wait until the process finishes or timeout
> +			gettimeofday(&tv, NULL);
> +			secs = tv.tv_sec;
> +			while (getpgid(p->pid) >= 0 && tv.tv_sec - secs < p->timeout) {
> +				gettimeofday(&tv, NULL);
> +			}

WTF?  Busy wait loop???

Also, if we want to wait for child without blocking, then instead
of cryptic getpgid(p->pid) maybe use waitpid(p->pid, &status, WNOHANG);
it is more explicit.

There is also another complication: there can be more than one
long-running filter driver used.  With this implementation we
wait for each of one in sequence, e.g. 10s + 10s + 10s.

> +		}
> +
>  		kill(p->pid, sig);
>  		if (!in_signal)
>  			free(p);
> @@ -49,10 +72,12 @@ static void cleanup_children_on_exit(void)
>  	cleanup_children(SIGTERM, 0);
>  }
>  
> -static void mark_child_for_cleanup(pid_t pid)
> +static void mark_child_for_cleanup(pid_t pid, int timeout, int stdin)

Hmmmm... three parameters is not too much, but we might want to
pass "struct child_process *" directly if this number grows.

>  {
>  	struct child_to_clean *p = xmalloc(sizeof(*p));
>  	p->pid = pid;
> +	p->stdin = stdin;
> +	p->timeout = timeout;
>  	p->next = children_to_clean;
>  	children_to_clean = p;
>  
> @@ -422,7 +447,7 @@ int start_command(struct child_process *cmd)
>  	if (cmd->pid < 0)
>  		error_errno("cannot fork() for %s", cmd->argv[0]);
>  	else if (cmd->clean_on_exit)
> -		mark_child_for_cleanup(cmd->pid);
> +		mark_child_for_cleanup(cmd->pid, cmd->exit_timeout, cmd->in);
>  
>  	/*
>  	 * Wait for child's execvp. If the execvp succeeds (or if fork()
> @@ -483,7 +508,7 @@ int start_command(struct child_process *cmd)
>  	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
>  		error_errno("cannot spawn %s", cmd->argv[0]);
>  	if (cmd->clean_on_exit && cmd->pid >= 0)
> -		mark_child_for_cleanup(cmd->pid);
> +		mark_child_for_cleanup(cmd->pid, cmd->exit_timeout, cmd->in);
>  
>  	argv_array_clear(&nargv);
>  	cmd->argv = sargv;
> @@ -765,7 +790,7 @@ int start_async(struct async *async)
>  		exit(!!async->proc(proc_in, proc_out, async->data));
>  	}
>  
> -	mark_child_for_cleanup(async->pid);
> +	mark_child_for_cleanup(async->pid, 0, -1);

Eh?  A bit magic.

>  
>  	if (need_in)
>  		close(fdin[0]);
> diff --git a/run-command.h b/run-command.h
> index cf29a31..f2eca33 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -33,6 +33,7 @@ struct child_process {
>  	int in;
>  	int out;
>  	int err;
> +	int exit_timeout;

I guess it is no problem adding new field to child_process struct;
it is not constrained for memory...

>  	const char *dir;
>  	const char *const *env;
>  	unsigned no_stdin:1;
> 

Where we read the value of the configuration variable?

