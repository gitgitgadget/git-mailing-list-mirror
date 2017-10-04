Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE242036C
	for <e@80x24.org>; Wed,  4 Oct 2017 15:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbdJDPUM (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 11:20:12 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46320 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdJDPUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 11:20:11 -0400
Received: by mail-qt0-f177.google.com with SMTP id 6so10762187qtw.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DU2O+XI44f+MbSz6nJS32QcvVwzpMs1TgLSWLk50fmo=;
        b=b8c68bkv+JgpbsaSSDEk1SpkfCbngXnnzChjA4AYfnPUsgIRuC2xss5RZ6odqo3Bjw
         noe8zHOqmipHEgk+NkqYTGOcwcd6vsTXCmVd7mekbWwHWqEwR3twmSZnS6Q6lW7rKcPC
         a02J/kb06dTjb+kPgTcAS1s+n0WmK9OF5UVTfkJRlI+5ts/77GR0QVGvOHMsa2gEhK6o
         ZcUM6+gCgw1UUBI5OQhEMuM9+TlY7RyWdfSxe3n7CbegCKbXcShWyH/Ik0YKq+oDEg6y
         srW/Jr/zxsZ7/r4/iTV8FtKWr5zyjYj2uP6CAYEgFMxjQ9khHlbZUbv8WHs/kdKVZxPO
         CQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DU2O+XI44f+MbSz6nJS32QcvVwzpMs1TgLSWLk50fmo=;
        b=G/zIklM9AoDmzpr40anqSXggbSO+wFzgguvwcs1FJ5NaCu/Vt0RmDxBr/KA9btHPzK
         +gbysHpxKArgWmD7iVtDtsbu0wBy5iHnT6idBYtKkXGv/T/AGUyi7d4wxe/+gYI1M3IG
         R/RIrhrh2F/EsSiXLOa6tTUBtNS6b63zmeqdviKGR8mU1mY7UMwymgFNvPXU28XxuIXV
         L7xM3XWZacmlgcMV/spV4fTkCoaOAOeoagGqjavl/wd8vdBE86B87o1qmNODCLOjirOy
         HKnQbgKH98NU/jJ5Wp8B7bVHAqzMbTZe97aqy/YPjPV+arzEZg9aeOEoq4sVFAplmxbI
         lSow==
X-Gm-Message-State: AMCzsaWXCagTZREoncRSSUrB3tsG0rFPigSS3LRalDUa4jnY2B2KPDQ6
        p5DFatUn/LDYxwWwrgyd3Zy9tL4/fd8deEDt1vI=
X-Google-Smtp-Source: AOwi7QBJWjcW1ngN7eNqv81vu/vpVKvnFjqQyMz3WPwvtmjAqOBVHYqml9wqHPZpEGKCMR+9bLCKE9s6xJn0aYHkdvI=
X-Received: by 10.237.60.114 with SMTP id u47mr5643139qte.110.1507130410640;
 Wed, 04 Oct 2017 08:20:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.101.178 with HTTP; Wed, 4 Oct 2017 08:20:10 -0700 (PDT)
In-Reply-To: <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
 <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
From:   Marius Paliga <marius.paliga@gmail.com>
Date:   Wed, 4 Oct 2017 17:20:10 +0200
Message-ID: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

I will look at it.

Thanks,
Marius


2017-10-03 18:53 GMT+02:00 Stefan Beller <sbeller@google.com>:
> On Tue, Oct 3, 2017 at 3:15 AM, Marius Paliga <marius.paliga@gmail.com> wrote:
>> There is a need to pass predefined push-option during "git push"
>> without need to specify it explicitly.
>>
>> In another words we need to have a new "git config" variable to
>> specify string that will be automatically passed as "--push-option"
>> when pushing to remote.
>>
>> Something like the following:
>>
>> git config push.optionDefault AllowMultipleCommits
>>
>> and then command
>>   git push
>> would silently run
>>   git push --push-option "AllowMultipleCommits"
>
> We would need to
> * design this feature (seems like you already have a good idea what you need)
> * implement it (see builtin/push.c):
>  - move "struct string_list push_options = STRING_LIST_INIT_DUP;"
>   to be a file-static variable, such that we have access to it outside
> of cmd_push.
>  - In git_push_config in builtin/push.c that parses the config, we'd
> need to check
>   for "push.optionDefault" and add these to the push_options (I assume multiple
>   are allowed)
> * document it (Documentation/git-push.txt)
> * add a test for it ? (t/t5545-push-options.sh)
>
> Care to write a patch? Otherwise I'd mark it up as part of
> #leftoverbits for now,
> as it seems like a good starter project.
>
> Thanks,
> Stefan
