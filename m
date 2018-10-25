Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24341F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeJYOH0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:07:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeJYOH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:07:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so145458wma.4
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 22:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RfK7xc4KKmr7DBCd69AE3YbuhjmMdNHmrvL+az4a0/8=;
        b=vKzqfRvJhFK9C1/ay0aewdnTYPFBsPq/XrH4DMyaUo31JF9hJDuGJKpLhKQsC9ZXr1
         S1nB4Tsf3uvIElZI2CINY/nY8mnBQkA1sLx/zcYe5PYaEZCO5sPMhQA3eBNEkFFLns7L
         AgaiFpbjL1/VEzt+VeV3zd5o9jNLgGAZwMAXMomUlGl/tXdQhDCEmGWq7zH9ovoljHv4
         uKYr1LEi6EPnwREc4K3uCzD2QOFnw0mNu68sWJO8LJOSqO1NAtJtCS5vaqKmHtiucL+B
         qXHtlO1IOMl9q2j2NE+gHOx6B6Mzp6hk9PsMLjrftV/F5SNx4o9rJz6evj60DM+QDW53
         2riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RfK7xc4KKmr7DBCd69AE3YbuhjmMdNHmrvL+az4a0/8=;
        b=pBPuQAX+E8kqxCrSwDXBX4PN35cIEiMYz+aX4OeroexjSamrxkPWJ5YKCmAheBv4Lp
         GMCh+FHI4q9ACbYYuQhFt/I5Yzbuu4UuQMoZPbfl8ddRNyzJRf8WxsENxHVapNGc7cF1
         vaXhm9a7YyTM2ab3nRHS0KKGcDmcVJ9ts3qBfNEy5nFJnRWJ0826VsGrAH/8+cvOL2cs
         oIFxsT96DF9t18KPNfAChY3tKPLfYQMYW926S0oJkvu24zc4YA8M23jaLd5tpKu7i565
         gCBy/R0IttYywIDepiNH0MRAOSxQxNkDq8/zk/rH7Rxh1HmvfdMSA2ej4jQW7DE4n/ai
         rw4A==
X-Gm-Message-State: AGRZ1gJLCLRISNkIf843dBvSKrviD/BeTQlDxhgKrJdX4z2ffN+L4K8Q
        QrFW9eVvlN9FYm4DMCxrPqg=
X-Google-Smtp-Source: AJdET5e0FJNB48odSoRSgnS1cA6P9lBJcvVHzxhHxdN+pZLPSSd+jLp/lEi0LX/fO7T5OB75R1G/HA==
X-Received: by 2002:a1c:760b:: with SMTP id r11-v6mr237548wmc.39.1540445776409;
        Wed, 24 Oct 2018 22:36:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s7-v6sm1678734wmd.0.2018.10.24.22.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:36:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com
Subject: Re: [PATCH] sequencer: cleanup for gcc 8.2.1 warning
References: <20181025001406.6729-1-carenas@gmail.com>
Date:   Thu, 25 Oct 2018 14:36:14 +0900
In-Reply-To: <20181025001406.6729-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 24 Oct 2018 17:14:06 -0700")
Message-ID: <xmqqlg6mk2pd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> sequencer.c: In function ‘write_basic_state’:
> sequencer.c:2392:37: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>    write_file(rebase_path_verbose(), "");

The change may squelch the above warning, but doesn't it change the
behaviour?  You need to explain what the changed behaviour is and
why it is OK to change that behaviour in this space, in addition to
show what warning you are working around.

I _think_ the intent of this code is to create an empty file,
because that is what the original version of "git rebase" did.
write_file() does use strbuf_complete_line() to avoid creating
a file with incomplete last line, but it does allow us to create
an empty file.  By adding a LF, the created file is no longer an
empty one.

Does it matter?  IOW, does it cause a regression if we start adding
an LF to the file?

By reading master:git-rebase.sh::read_basic_state(), I _think_ it is
safe to do so, as the side that consumes this $state_dir/verbose
only checks file's existence, and does not care what it contains,
even if somehow the scripted version of "git rebase" ends up reading
the state file created by this newer version of "git rebase" in C.
Also next:sequencer.c::read_populate_opts() only checks for file's
existence, so the newer version of "git rebase" is also safe.

So as an immediate workaround for 'next', this patch happens to be
OK, but that is only true because the consumer happens to ignore the
distinction between an empty file and a file with a single LF in it.

I'd have to say that the ability to create an empty file is more
important in the longer term.  Can't the workaround be done to
write_file() instead?  I actually do not mind if the solution were
to introduce a newhelper "write_empty_file()", but the way it is
written in the code before this patch, i.e.

	write_file(FILENAME, "")

is so obvious a way to create an empty file, so if we do not have to
resort to such a hackery to special case an empty file, that would
be preferrable.

Thanks.

>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 8dd6db5a01..358e83bf6b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2335,7 +2335,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  		write_file(rebase_path_quiet(), "\n");
>  
>  	if (opts->verbose)
> -		write_file(rebase_path_verbose(), "");
> +		write_file(rebase_path_verbose(), "\n");
>  	if (opts->strategy)
>  		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
>  	if (opts->xopts_nr > 0)
