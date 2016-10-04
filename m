Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968F320986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbcJDTFN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:05:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34568 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbcJDTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:05:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so15940151wmb.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CncZtRgs1LdJYak/HXxS9WPlWKG0h3hs+LIc/pkX2wM=;
        b=FKYfODTSjjyoB3euUSu4x/dwao8uy80wbxLjsvyLO93FDQVPKg5HqmcIZt3Y5TrjmM
         RkIx+3SBMitdmRjaU2Ys0rfPpftXaN2jTypBchH2dlAuDorxuXs8L/dSP31jdkVHzzrj
         D55ryLFJnmI/QrBdwwP1XfPeTcN16QkNHM6WT4M2dBmAKcZRqjzyWfjhDqwaFJ9zSuKx
         qBXWT/WdNiTGs5Jz0VEh5TOVrMUjNfttiZoSh8ZwWKCUAdcX9VWLRmw7cvTlq6bZxh73
         UaPvLAAmZ1OLByr3k3WhAJWwHseXCuzoH+U3uWIwBh/hySvleIeJE/6Fw+vxb6uUFGf1
         GgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CncZtRgs1LdJYak/HXxS9WPlWKG0h3hs+LIc/pkX2wM=;
        b=LsiPLL2JOpO85O24nQnd4/nFX6a+IFczvpzszbARjMubVAJ6hx4C6H8SsH55o0Fbuc
         OMxAf9il1SZi5czUjDoqYxME48Nh8XEgj1Qdb/wkGUctX0MdiQ2qTZQO1aM9h1OElHu/
         3y1EjpyMU8Tc6NRh1FHsPg2M/aXIwLi8goqJ2wwdt4+j5YcOliPphv6MpE9bMEqpNLHj
         cC0Kq8qPwC4xmS/cBypK2O4HRKLeDtyWVGoMTZ5lX80Q8Y1pi21jndS48Fj9lseRR+uC
         KxuQU7H1Tx6Bqp3Y/MGWp3eHuqRGFrsAKUuHAJgupNjDsBTXqyjncQ+NCaUyTpd5OIlw
         vweg==
X-Gm-Message-State: AA6/9RmR3IAuHd2qbJYS9oeUDI5CSn3WMYq6rVUj/sGpiqbwCQzdXqrHSS5XjEK34917gw==
X-Received: by 10.194.94.168 with SMTP id dd8mr4217112wjb.96.1475607910300;
        Tue, 04 Oct 2016 12:05:10 -0700 (PDT)
Received: from [192.168.1.26] (dbs112.neoplus.adsl.tpnet.pl. [83.23.44.112])
        by smtp.googlemail.com with ESMTPSA id jt8sm538173wjc.33.2016.10.04.12.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 12:05:09 -0700 (PDT)
Subject: Re: [PATCH v8 00/11] Git filter protocol
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
 <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
 <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
 <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
 <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com>
 <E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f7f9ca4c-229c-390a-beb0-a58e0d3d66b3@gmail.com>
Date:   Tue, 4 Oct 2016 21:04:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.10.2016 o 19:13, Lars Schneider pisze: 
>> On 01 Oct 2016, at 22:48, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 01.10.2016 o 20:59, Lars Schneider pisze: 
>>> On 29 Sep 2016, at 23:27, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>>
>>>> If the filter process refuses to die forever when Git told it to
>>>> shutdown (by closing the pipe to it, for example), that filter
>>>> process is simply buggy.  I think we want users to become aware of
>>>> that, instead of Git leaving it behind, which essentially is to
>>>> sweep the problem under the rug.
>>
>> Well, it would be good to tell users _why_ Git is hanging, see below.
> 
> Agreed. Do you think it is OK to write the message to stderr?

On the other hand, this is why GIT_TRACE (and GIT_TRACE_PERFORMANCE)
was invented for.  We do not signal troubles with single-shot filters,
so I guess doing it for multi-file filters is not needed.
 
>>>> I agree with what Peff said elsewhere in the thread; if a filter
>>>> process wants to take time to clean things up while letting Git
>>>> proceed, it can do its own process management, but I think it is
>>>> sensible for Git to wait the filter process it directly spawned.
>>>
>>> To realize the approach above I prototyped the run-command patch below:
>>>
>>> I added an "exit_timeout" variable to the "child_process" struct.
>>> On exit, Git will close the pipe to the process and wait "exit_timeout" 
>>> seconds until it kills the child process. If "exit_timeout" is negative
>>> then Git will wait until the process is done.
>>
>> That might be good approach.  Probably the default would be to wait.
> 
> I think I would prefer a 2sec timeout or something as default. This way
> we can ensure Git would not wait indefinitely for a buggy filter by default.

Actually this waiting for multi-file filter is only about waiting for
the shutdown process of the filter.  The filter could still hang during
processing a file, and git would hang too, if I understand it correctly.

[...]
>> Also, how would one set default value of timeout for all process
>> based filters?
> 
> I think we don't need that because a timeout is always specific
> to a filter (if the 2sec default is not sufficient).

All right (assuming that timeouts are good idea). 

>>>
>>> +			while ((waitpid(p->pid, &status, 0)) < 0 && errno == EINTR)
>>> +				;	/* nothing */
>>
>> Ah, this loop is here because waiting on waitpid() can be interrupted
>> by the delivery of a signal to the calling process; though the result
>> is -1, not just any < 0.
> 
> "< 0" is also used in wait_or_whine()

O.K. (though it doesn't necessary mean that it is correct, there
is another point for using "< 0").
 
[...]
>> There is also another complication: there can be more than one
>> long-running filter driver used.  With this implementation we
>> wait for each of one in sequence, e.g. 10s + 10s + 10s.
> 
> Good idea, I fixed that in the version below!
> 
[...]
> [...] this function is also used with the async struct... 

Hmmm... now I wonder if it is a good idea (similar treatment for
single-file async-invoked filter, and multi-file pkt-line filters).

For single-file one-shot filter (correct me if I am wrong):

 - git sends contents to filter, signals end with EOF
   (after process is started)
 - in an async process:
   - process is started
   - git reads contents from filter, until EOF
   - if process did not end, it is killed


For multi-process pkt-line based filter (simplified):

 - process is started
 - handshake
 - for each file
   - file is send to filter process over pkt-line,
     end signalled with flush packet
   - git reads from filter from pkt-line, until flush
 - ...


See how single-shot filter is sent EOF, though in different part
of code.  We need to signal multi-file filter that no more files
will be coming.  Simplest solution is to send EOF (we could send
"command=shutdown" for example...) to filter, and wait for EOF
from filter (or for "status=finished" and EOF).

We could kill multi-file filter after sending last file and
receiving full response... but I think single-shot filter gets
killed only because it allows for very simple filters, and reusing
existing commands as filters.

[...]
> diff --git a/run-command.c b/run-command.c
> index 3269362..ca0feef 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -21,6 +21,9 @@ void child_process_clear(struct child_process *child)
>  
>  struct child_to_clean {
>  	pid_t pid;
> +	char *name;

I guess it is here for output purposes?

Should we store full command here, or just name of <driver>?

> +	int stdin;

I guess the name `stdin` for file _descriptor_ is something
used in other parts of convert.c code, isn't it?

> +	int timeout;

Hmmm... we assume that timeout is in seconds, not millis or other
value, isn't it.  timeout_sec would perhaps be unnecessarily long.

>  	struct child_to_clean *next;
>  };
>  static struct child_to_clean *children_to_clean;
> @@ -28,12 +31,53 @@ static int installed_child_cleanup_handler;
>  
>  static void cleanup_children(int sig, int in_signal)
>  {
> +	int status;
> +	struct timeval tv;
> +	time_t secs;
> +	struct child_to_clean *p = children_to_clean;
> +
> +	// Send EOF to children as indicator that Git will exit soon
> +	while (p) {
> +		if (p->timeout != 0) {

Here we use timeout == 0 as a special case, a special indicator
(IIUC for the single-shot filter case, where it is closed already).
This is not documented.  Somebody setting timeout to "0" would
be surprised, isn't it?

> +			if (p->stdin > 0)
> +				close(p->stdin);
> +		}
> +		p = p->next;
> +	}
> +
>  	while (children_to_clean) {
> -		struct child_to_clean *p = children_to_clean;
> +		p = children_to_clean;
>  		children_to_clean = p->next;
> +
> +		if (p->timeout != 0) {
> +			fprintf(stderr, _("Waiting for '%s' to finish..."), p->name);
> +			if (p->timeout < 0) {
> +				// No timeout given - wait indefinitely
> +				while ((waitpid(p->pid, &status, 0)) < 0 && errno == EINTR)
> +					;	/* nothing */
> +			} else {
> +				// Wait until timeout
> +				gettimeofday(&tv, NULL);
> +				secs = tv.tv_sec;
> +				while (!waitpid(p->pid, &status, WNOHANG) &&
> +					   tv.tv_sec - secs < p->timeout) {
> +					fprintf(stderr, _(" \rWaiting %lds for '%s' to finish..."),
> +						p->timeout - tv.tv_sec + secs - 1, p->name);
> +					gettimeofday(&tv, NULL);
> +					sleep_millisec(10);
> +				}
> +			}

I wonder if we have some progress-printing code we can borrow
from, or just plain use (like progress report for long checkout).

> +			if (waitpid(p->pid, &status, WNOHANG))
> +				fprintf(stderr, _("done!\n"));
> +			else
> +				fprintf(stderr, _("timeout. Killing...\n"));
> +		}
> +
>  		kill(p->pid, sig);
> -		if (!in_signal)
> +		if (!in_signal) {
> +			free(p->name);
>  			free(p);
> +		}
>  	}
>  }
>  
> @@ -49,10 +93,18 @@ static void cleanup_children_on_exit(void)
>  	cleanup_children(SIGTERM, 0);
>  }
>  
> -static void mark_child_for_cleanup(pid_t pid)
> +static void mark_child_for_cleanup_with_timeout(pid_t pid, const char *name, int stdin, int timeout)
>  {
>  	struct child_to_clean *p = xmalloc(sizeof(*p));
>  	p->pid = pid;
> +	p->timeout = timeout;
> +	p->stdin = stdin;
> +	if (name) {
> +		p->name = xmalloc(strlen(name) + 1);
> +		strcpy(p->name, name);

Don't we have xstrdup() for that, or am I mistaken?

> +	} else {
> +		p->name = "process";

Hmmmm...

> +	}
>  	p->next = children_to_clean;
>  	children_to_clean = p;
>  
> @@ -63,6 +115,13 @@ static void mark_child_for_cleanup(pid_t pid)
>  	}
>  }
>  
> +#ifdef NO_PTHREADS
> +static void mark_child_for_cleanup(pid_t pid, const char *name, int timeout, int stdin)
> +{
> +	mark_child_for_cleanup_with_timeout(pid, NULL, 0, 0);
> +}
> +#endif

Uh?

> +
>  static void clear_child_for_cleanup(pid_t pid)
>  {
>  	struct child_to_clean **pp;
> @@ -422,7 +481,8 @@ int start_command(struct child_process *cmd)
>  	if (cmd->pid < 0)
>  		error_errno("cannot fork() for %s", cmd->argv[0]);
>  	else if (cmd->clean_on_exit)
> -		mark_child_for_cleanup(cmd->pid);
> +		mark_child_for_cleanup_with_timeout(
> +			cmd->pid, cmd->argv[0], cmd->in, cmd->clean_on_exit_timeout);

All right, nice abstraction.

>  
>  	/*
>  	 * Wait for child's execvp. If the execvp succeeds (or if fork()
> @@ -483,7 +543,8 @@ int start_command(struct child_process *cmd)
>  	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
>  		error_errno("cannot spawn %s", cmd->argv[0]);
>  	if (cmd->clean_on_exit && cmd->pid >= 0)
> -		mark_child_for_cleanup(cmd->pid);
> +		mark_child_for_cleanup_with_timeout(
> +			cmd->pid, cmd->argv[0], cmd->in, cmd->clean_on_exit_timeout);
>  
>  	argv_array_clear(&nargv);
>  	cmd->argv = sargv;
> diff --git a/run-command.h b/run-command.h
> index cf29a31..4c1c1f4 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -43,6 +43,16 @@ struct child_process {
>  	unsigned stdout_to_stderr:1;
>  	unsigned use_shell:1;
>  	unsigned clean_on_exit:1;
> +	/*
> +	 * clean_on_exit_timeout is only considered if clean_on_exit is set.
> +	 * - Specify 0 to kill the child on Git exit (default)
> +	 * - Specify a negative value to close the child's stdin on Git exit
> +	 *   and wait indefinitely for the child's termination.
> +	 * - Specify a positive value to close the child's stdin on Git exit
> +	 *   and wait clean_on_exit_timeout seconds for the child's
> +	 *   termination.

All right, so here is this documentation...

> +	 */
> +	int clean_on_exit_timeout;
>  };
>  
>  #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
> 
> 

For full patch, you would need also to add to Documentation/config.txt

Best,
-- 
Jakub Narębski

