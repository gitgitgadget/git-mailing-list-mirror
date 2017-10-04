Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B5E2036C
	for <e@80x24.org>; Wed,  4 Oct 2017 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdJDTaS (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 15:30:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36219 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdJDTaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 15:30:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id l10so194265wre.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dO7N0CwP8ro0dyQGW1dkdeivI3q/60JmtXPCh02a/+0=;
        b=sTCHioHr7jg97xf0QrRQgMmyJjWzAcMzEtyXVLz43ewF4v34pBahuZ4U4kE7fe51Us
         WeIjy7R8VoEK9LD2Ls7DU6FO/F3PNKHrZzSAcRr3O5zJVu9b0XzJ23a5UcVoI++ZFYTW
         Gm7ZWjNM0ehCrM5gsc8T3mowg9jX/0WjeV7ESZCx+so1lyRbbeQNpFaS45JsAH3pKnIU
         XzGgKL49FYQHIMVY5+GlzpXsnmXmP2y64UpdxIE/0m5mzHhcN/8WKXDS5QzKf8Q30sIj
         sEsBlcfTFnq1PKezOxe3mUdF0ipDuusGc0O7eA6WBJWW6MGyKB5ccOD0u0uuDhVOjJkT
         Y6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dO7N0CwP8ro0dyQGW1dkdeivI3q/60JmtXPCh02a/+0=;
        b=AlHeA7iMvMJIjBfsZZajyB4W4RfChyCEx7PdUHMMyPBfO0B6YIJofDgntDL7trXJzw
         B17qi2jsqAtXCpKH6CWgGNpHnSdw04IVVcAoiFzA5a4tR5hxFAMNnNIyCihwB5QGGo6H
         1WCxbZhIuqDZV43I/Cw06d3H6JfF3JEcFdax5Msl4sRjcSrvsCgqc8qNSQFOuBKkkYzv
         avEkJ38DZ15yc0Wwpw04G5HXCQASamnLPRQV8lKCZJbNzCi/NTzibvajPxgaZCaj934+
         x/MMtpaz9lfgvwpqQq/zpSfy1X/P4bEraavVatna0BI25SqjyWTXzOuL3gAA3/fl5rpM
         jxqg==
X-Gm-Message-State: AHPjjUhEoBbyedCSkyLB8z1jZHSVrPLdfnZOjD0VM76ZZkiRpxxOa5SP
        X1BDjJDv60nFkpofB+UD8ks=
X-Google-Smtp-Source: AOwi7QCIGFnAL29w9OuZCsL6oqQkavCsc8y5ECUD8nRZS39AyxjaQocOqiIffgbMZnNzVhxPuA6Z0g==
X-Received: by 10.223.134.157 with SMTP id 29mr20825897wrx.72.1507145416610;
        Wed, 04 Oct 2017 12:30:16 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 92sm5101855wrd.15.2017.10.04.12.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Oct 2017 12:30:15 -0700 (PDT)
Date:   Wed, 4 Oct 2017 20:31:07 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] sub-process: allocate argv on the heap
Message-ID: <20171004193107.GE30301@hank>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-4-t.gummerer@gmail.com>
 <85456f81-9e9f-d0e4-86f7-9f546691dee3@kdbg.org>
 <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 03.10.2017 um 21:57 schrieb Thomas Gummerer:
> >> diff --git a/sub-process.c b/sub-process.c
> >> index 6dde5062be..4680af8193 100644
> >> --- a/sub-process.c
> >> +++ b/sub-process.c
> >> @@ -77,7 +77,9 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
> >>   {
> >>   	int err;
> >>   	struct child_process *process;
> >> -	const char *argv[] = { cmd, NULL };
> >> +	const char **argv = xmalloc(2 * sizeof(char *));
> >> +	argv[0] = cmd;
> >> +	argv[1] = NULL;
> >>     	entry->cmd = cmd;
> >>   	process = &entry->process;
> >>
> >
> > Perhaps this should become
> >
> > 	argv_array_push(&process->args, cmd);
> >
> > so that there is no new memory leak?
> 
> Sounds like a good idea (if I am not grossly mistaken as to what is
> being suggested).
> 
> Here is what I am planning to queue.
> 
> -- >8 --
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 3 Oct 2017 22:24:57 +0200
> Subject: [PATCH] sub-process: use child_process.args instead of child_process.argv
> 
> Currently the argv is only allocated on the stack, and then assigned to
> process->argv.  When the start_subprocess function goes out of scope,
> the local argv variable is eliminated from the stack, but the pointer is
> still kept around in process->argv.
> 
> Much later when we try to access the same process->argv in
> finish_command, this leads us to access a memory location that no longer
> contains what we want.  As argv0 is only used for printing errors, this
> is not easily noticed in normal git operations.  However when running
> t0021-conversion.sh through valgrind, valgrind rightfully complains:
> 
> ==21024== Invalid read of size 8
> ==21024==    at 0x2ACF64: finish_command (run-command.c:869)
> ==21024==    by 0x2D6B18: subprocess_exit_handler (sub-process.c:72)
> ==21024==    by 0x2AB41E: cleanup_children (run-command.c:45)
> ==21024==    by 0x2AB526: cleanup_children_on_exit (run-command.c:81)
> ==21024==    by 0x54AD487: __run_exit_handlers (in /usr/lib/libc-2.26.so)
> ==21024==    by 0x54AD4D9: exit (in /usr/lib/libc-2.26.so)
> ==21024==    by 0x11A9EF: handle_builtin (git.c:550)
> ==21024==    by 0x11ABCC: run_argv (git.c:602)
> ==21024==    by 0x11AD8E: cmd_main (git.c:679)
> ==21024==    by 0x1BF125: main (common-main.c:43)
> ==21024==  Address 0x1ffeffec00 is on thread 1's stack
> ==21024==  1504 bytes below stack pointer
> ==21024==
> 
> These days, the child_process structure has its own args array, and
> the standard way to set up its argv[] is to use that one, instead of
> assigning to process->argv to point at an array that is outside.
> Use that facility automatically fixes this issue.
> 
> Reported-by: Thomas Gummerer <t.gummerer@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sub-process.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sub-process.c b/sub-process.c
> index fcc4832c14..648b3a3943 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -74,13 +74,12 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
>  {
>  	int err;
>  	struct child_process *process;
> -	const char *argv[] = { cmd, NULL };
>  
>  	entry->cmd = cmd;
>  	process = &entry->process;
>  
>  	child_process_init(process);
> -	process->argv = argv;
> +	argv_array_push(&process->args, cmd);

Thanks!  *Much* nicer than what I had :)

>  	process->use_shell = 1;
>  	process->in = -1;
>  	process->out = -1;
> -- 
> 2.14.2-889-gd2948f6aa6
> 
