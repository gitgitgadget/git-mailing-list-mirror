Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5E220960
	for <e@80x24.org>; Tue, 11 Apr 2017 00:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbdDKA0N (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 20:26:13 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35253 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdDKA0K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 20:26:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id i5so40529557pfc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1Ra+AYDpVatBWesaZnvw6KEhFK/4MXQaSn1dLDdoe0=;
        b=YZAeVMXKCeaT9dLmL2nl2e2SOZBoUcxQnDzj2exxBjBEK129cLdi3wOapJD4x3hDRg
         ASUuLMwDXI52mRyUYDRWTWlGpdo+KKYWmKHouVLfsnkh/BAkSEjxJNEe6SM5b7n5mCL3
         CRIawxTvhVQIJh86Cd1mKunO6kPIxsZw5YR3SE3QLxZSgjV+d1SIyEqrfJBD3UUCHvbQ
         vrkrN/SKuHV0W3ozeS2rHQgrpKuQi64djuCo8sqN2FlOh5OMPkEfzIJFGoSk4CIx4yjR
         eabQsJBlEQQ6NG9hg2kx3nfCAZfUW1X0IX6+7A+8Z0CIYE1zvZgDjh/WXgttLtSGcLju
         qIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1Ra+AYDpVatBWesaZnvw6KEhFK/4MXQaSn1dLDdoe0=;
        b=hGGzMmF6rNZra8Wwdducvd3J/6YtPqL/J6exnW0qrGXYe+3ZZNfl5xhwpGZLREMcT+
         6eWLar2CNsviXzeAhgtsx3J+eQx76nx3Okep3TPH5SdQnjbK7xFEsQMCLzXfj5SHYTGG
         oDGLhMEMeMNIVoimh/JdDXfkgtyYqdTJJSDNj4udYuMfSRm3Rlu3n00h5Z0ixjvRoYvY
         cXGCOKAdXFTqBwPvtUuR5ziVt9hBRwa0WhB1/4KmIhiOpLokknpCpKlcryQXX1BT2oYq
         /wr0aoXsiTnrOhPCnF2NcO0Vdbs6uYMGoKf4HixDXIau4R78ziZySWJny5/tQHbQLXWF
         gbeg==
X-Gm-Message-State: AFeK/H1koNOkvs5YzFIHw2fzqeDBma917hyWOc7/ZZ5tLrq3h90gbDWtFgnYRgJPcCNfsw==
X-Received: by 10.99.127.12 with SMTP id a12mr59037151pgd.5.1491870369260;
        Mon, 10 Apr 2017 17:26:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:dcb:fd1c:cdca:5669])
        by smtp.gmail.com with ESMTPSA id z123sm20733109pfz.56.2017.04.10.17.26.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 17:26:08 -0700 (PDT)
Date:   Mon, 10 Apr 2017 17:26:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] run-command: add note about forking and threading
Message-ID: <20170411002606.GJ8741@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170410234919.34586-6-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410234919.34586-6-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> --- a/run-command.c
> +++ b/run-command.c
> @@ -458,6 +458,14 @@ int start_command(struct child_process *cmd)
>  		argv_array_pushv(&argv, cmd->argv);
>  	}
>  
> +	/*
> +	 * NOTE: In order to prevent deadlocking when using threads special
> +	 * care should be taken with the function calls made in between the
> +	 * fork() and exec() calls.  No calls should be made to functions which
> +	 * require acquiring a lock (e.g. malloc) as the lock could have been
> +	 * held by another thread at the time of forking, causing the lock to
> +	 * never be released in the child process.
> +	 */
>  	cmd->pid = fork();

Why can't git use e.g. posix_spawn to avoid this?

fork()-ing in a threaded context is very painful for maintainability.
Any library function you are using could start taking a lock, and then
you have a deadlock.  So you have to make use of a very small
whitelisted list of library functions for this to work.

The function calls you have to audit are not only between fork() and
exec() in the normal control flow.  You have to worry about signal
handlers, too.

By comparison, posix_spawn() takes care of this all.  I really
strongly do not want to move in the direction of more fork() in a
multi-threaded context.  I'd rather turn off threads in the submodule
case of grep altogether, but that shouldn't be needed:

* it is possible to launch a command without fork+exec
* if that's not suitable, then using fork introduces parallelism that
  interacts much better with fork+exec than threads do

I really don't want to go down this path.  I've said that a few times.
I'm saying it again now.

My two cents,
Jonathan
