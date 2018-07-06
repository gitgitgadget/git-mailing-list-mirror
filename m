Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521101F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 16:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933519AbeGFQjl (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 12:39:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45762 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933305AbeGFQjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 12:39:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id u7-v6so4778762wrn.12
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XroXhYSitPkZh2AZyxvA2+gzbL3PwRk2xEkc/fEp7g8=;
        b=fOMLLNKRHmobG/5tHmjH8L5XYOI1/fIdc7DgagV2nxXPlqITgfAarSnFsxldljhXH1
         gbHzzJxsofsAYLjHyMWehfyWKM7nVfw4z800laFTzerh/D7ysGrFmG/Yahf/Rl0PN3Kn
         78kIDKZwI4NST9kzOyT4ZfokWvOBEMd3hKmIJvsdDfMxgpei8bgInyo2KqKtJ/qvRlfA
         M2LTLHKp4IpZZCVsUdBGGN3sls3gsvlfWlYi0CvplKo7XNY1R/rxsrODZErxXiLB5cA2
         BzSE6jFSdRCl1x7Xu9d7gOmQ+1Y9Jq+OPGcyKO8RZfT+NYbukF8cLRfhaSdqY+g+5VxR
         1vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XroXhYSitPkZh2AZyxvA2+gzbL3PwRk2xEkc/fEp7g8=;
        b=KtywSjw7CiZkIM+4/BTfhPavauz8DL3zQ17GPw1cMPE3rNN2vWAvTMUHwLO8uKK1/j
         fhg3knq3I08MPmef6oFudQmICUqI4VmwqInFsF12WoYuIuEg65UA+7BNrynuqMNpU4uE
         zDDhMd/6H5AQ5L81QMk97Cjndgl15iQslPKcD7n07uevgNHjflC6Mo+2q+MU7Fk4HjAA
         q5FEMbjTygPUEhBgrEHRYPQd8qVC6yZNayTGkataep5O5UkkskerrJI5vDG9Q1CMD7FJ
         5TJhbywlZyi5ekTUeSddm5OjbKkYyPFV+5WxdkSBYSIqHtheOFdq2Y7UDKIcTEDcMt1h
         3ZGA==
X-Gm-Message-State: APt69E3IyZJCWEFa5vzTvcB4TcusvqgJjFrq8skNb1OYzVorVOZV+AME
        A81C2U5ssB8vyg76suB/D00=
X-Google-Smtp-Source: AAOMgpePnIgMpcZPe19MyixX6B/VEm0O8vqEeUuf/+hYw5t+Q2uhSRGvnNlZFq0+vIEbJe0OR95a2A==
X-Received: by 2002:adf:b8ad:: with SMTP id i42-v6mr7669611wrf.163.1530895178496;
        Fri, 06 Jul 2018 09:39:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7724532wrn.75.2018.07.06.09.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 09:39:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kim Gybels <kgybels@infogroep.be>, git@vger.kernel.org,
        Adam Borowski <kilobyte@angband.pl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
        <tboegi@web.de>
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
References: <20180630133822.4580-1-kgybels@infogroep.be>
        <20180630145849.GA9416@duynguyen.home>
Date:   Fri, 06 Jul 2018 09:39:37 -0700
In-Reply-To: <20180630145849.GA9416@duynguyen.home> (Duy Nguyen's message of
        "Sat, 30 Jun 2018 16:58:50 +0200")
Message-ID: <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jun 30, 2018 at 03:38:21PM +0200, Kim Gybels wrote:
>> Teach gc --auto to release pack files before auto packing the repository
>> to prevent failures when removing them.
>> 
>> Also teach the test 'fetching with auto-gc does not lock up' to complain
>> when it is no longer triggering an auto packing of the repository.
>> 
>> Fixes https://github.com/git-for-windows/git/issues/500
>> 
>> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
>> ---
>> 
>> Patch based on master, since problem doesn't reproduce on maint,
>> however, the improvement to the test might be valuable on maint.
>> 
>>  builtin/gc.c     | 1 +
>>  t/t5510-fetch.sh | 2 ++
>>  2 files changed, 3 insertions(+)
>> 
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index ccfb1ceaeb..63b62ab57c 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -612,6 +612,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>  		return -1;
>>  
>>  	if (!repository_format_precious_objects) {
>> +		close_all_packs(the_repository->objects);
>
> We have repo_clear() which does this and potentially closing file
> descriptors on other things as well. I suggest we use it, and before
> any external command is run. Something like
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ccfb1ceaeb..a852c71da6 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -473,6 +473,13 @@ static int report_last_gc_error(void)
>  
>  static int gc_before_repack(void)
>  {
> +	/*
> +	 * Shut down everything, we should have all the info we need
> +	 * at this point. Leaving some file descriptors open may
> +	 * prevent them from being removed on Windows.
> +	 */
> +	repo_clear(the_repository);
> +
>  	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
>  		return error(FAILED_RUN, pack_refs_cmd.argv[0]);

With 

  https://public-inbox.org/git/20180509170409.13666-1-pclouds@gmail.com/

the call to repo_clear() on the_repository itself may be safe [*1*],
but if command line parsing code etc. has pointers to in-core object
etc. obtained before this function was called, the codeflow after
this function returns will be quite disturbed.  Has anybody in this
review thread audited the codeflow _after_ this function is run to
make sure that invalidating in-core repository here does not cause
us problems?  Just checking, because I won't queue this change until
I hear that somebody familiar with the codepath actually did so (I
may get around to do so myself later).

Thanks.


[Footnote]

*1* ... and of course changing the_index to &the_repo->index would
    make it even safer ;-)

