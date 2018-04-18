Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16461F404
	for <e@80x24.org>; Wed, 18 Apr 2018 18:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeDRSo3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 14:44:29 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:37543 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeDRSo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 14:44:28 -0400
Received: by mail-yw0-f172.google.com with SMTP id u83-v6so865470ywc.4
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4zZ5vtrm8EEdO1Smv8XxhEsOzQbxN5ZykOG7JtG8EXs=;
        b=UEv+iYzLiqzdzh72iLGO0pmQDDRV16oUdAe8nggEoYY4lhl/Q4oJUsQGAV05VMpwxL
         ur7rUVjYf3cGQSOM7g3LZEquxOj2EczSOepEbmBs4doEzFgaSXBFdWHOvj7Mw/hIJ+Vf
         Ae79UdE1dapkDBSbKDUCiMCnOZHmh4WRMb0QDggj+weS5fjWe0QZpxM2qXkBwu5xAXZ4
         jLe1OhQaZLGxKd4Tg5Exf0KdYm/N7guI+6iOd79ltLk+tzr7RIZFHV0/H0PDdfBVBZzH
         a4v/PsHtRDBg7ZdiStM1GmiJoNMSYhY3OiCj5eZVkmd5XynQyodYESaHPvX3w29d6R2E
         KZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4zZ5vtrm8EEdO1Smv8XxhEsOzQbxN5ZykOG7JtG8EXs=;
        b=bMGkqq4OJty3/vryrskq/feNf+ovtY3NQmPIraADe5PlCNxv1eRvI4ATEF8ipO/sER
         /nw9J+nDOHct248QDtJudUQIigSFsUOFwLmgl9/afDAhIiT/R/SonBlPuBXlePSjykcD
         OuCPa5Dj5x6xyDHpw1MRzOYAAv3bjivXNq3EvZkpsgII7/J/h3QGCucq8eFZfKV/pMQT
         gTGqr/9tjB3mLv5012MRtEiyRxGM/1IP9tnlwaaOjsgAg7Omd7Xu8QDO5DtmZtYOiKqy
         Pqd5sjonwf4oH1/Gv4YrkgFmi+xm3PrBURMFQ4tWgbnFZns/QO2ECIIOFGgObI8Oj01Q
         /1BA==
X-Gm-Message-State: ALQs6tBUIXE2McpNylwGvasKGVeO19IdEuHGe9w+30wtxvxUyy868RJw
        Fk29tZQxB/ucW+hZr+/kSvvklvef4mPQOJhjCN9zHQ==
X-Google-Smtp-Source: AIpwx4+/gpxUMU1QlPBkysFReNxH0y1SXvExi+XimJRkUyhs7wO5svpLo2SxHINmyi0ZqQkIa8rAgwemHwQQ8h4A4Tw=
X-Received: by 2002:a81:5605:: with SMTP id k5-v6mr1897163ywb.345.1524077066945;
 Wed, 18 Apr 2018 11:44:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 18 Apr 2018 11:44:26
 -0700 (PDT)
In-Reply-To: <20180418134357.1e417fb22201b6a6b67c02c0@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <20180412222047.5716-2-ao2@ao2.it>
 <CAGZ79kZV+MLaVp4AM77bJkT=MeBvDSHTxZCni8dkqq4VLWZ0AA@mail.gmail.com>
 <20180416183742.032530a4d44faccd44189ea6@ao2.it> <CAGZ79kajTdkPKpcjH3NXBE75qWnNCCq_OefAjQsw17hK_VEyCw@mail.gmail.com>
 <20180418134357.1e417fb22201b6a6b67c02c0@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Apr 2018 11:44:26 -0700
Message-ID: <CAGZ79kb6-JaqUhgb_BdegbmyZowbMwR35UDcvSaXLCvWtVkjmA@mail.gmail.com>
Subject: Re: [RFC 01/10] submodule: add 'core.submodulesFile' to override the
 '.gitmodules' path
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

>>
>> Good point! I wonder if the cleaner solution would be to just
>> tell git to use HEAD:.gitmodules and not check out the file?
>> then you would not need to come up with a namespace for names
>> of the .gitmodules files and scatter them into the worktree as well?
>>
>
> Any solution which:
>
>   1. prevents the gitmodules file to be checked out
>   2. but still tracks it in the git repository
>
> OR
>
>   1. allows to set the gitmoudles file under some namespace
>
> would work for vcsh I guess.

I personally would tend to rather go for supporting your first solution
(prevent .gitmodules from checked-out, load from sparse HEAD),
but I do not have strong arguments or feeling about this dimension.
I am fine with a namespaced .gtimodules solution, too.

Both solutions can be implemented by either:

A) adding the code where it is (like your patch, e.g. using

> -               value=$(git config -f .gitmodules submodule."$name"."$option")
> +               gitmodules_file=$(git config core.submodulesfile)
> +               : ${gitmodules_file:=.gitmodules}
> +               value=$(git config -f "$gitmodules_file" submodule."$name"."$option")

B) adding a helper, which is a layer of indirection
to load the relevant configuration.

And when it comes to this dimension, I'd strongly favor B over A.
Having this indirection helper in place enables to add more options
later easily as only one place needs to be touched.
(These other options could include the other solution as presented above,
or the idea with the special ref as mentioned in an earlier email)


>> > Can you give an example from the user point of view of such a
>> > "config-from-gitmodules" command?
>> >
>>
>>     git submodule config <name> <option>
>>
>> as an 'alias' for
>>
>>                gitmodules_file=$(git config core.submodulesfile)
>>                : ${gitmodules_file:=.gitmodules}
>>                value=$(git config -f "$gitmodules_file"
>> submodule."$name"."$option")
>>
>> The helper would figure out which config file to load form
>> (.gitmodules in tree, HEAD:.gitmodules, your new proposed gitmodules file,
>> .git/config... or the special ref) and then return the <option> for <name>
>>
>> So maybe:
>>
>>     $ git clone https://gerrit.googlesource.com/gerrit && cd gerrit
>>     # ^ My goto-repo with submodules
>>
>>     $ git submodule config "plugins/hooks" URL
>>     ../plugins/hooks
>>
>>
>
> I may look into such supporting changes once you decide the approach to
> take for the bigger problem.

I think once we have the helper in place you can implement the solution
to the bigger problem as you like?

There are a few pros and cons for namespaced .gitmodules and
non-checked-out sparse HEAD .gitmodules:

How do you modify the .gitmodules config?
============
In the namespaced solution, you can tell users to edit that
file manually or use "git config -f $new_location" to manipulate
that file.

In the sparse solution editing becomes a little bit trickier, as you
need to edit a file in the index (or HEAD).

If you have the special ref, you could just checkout the
special ref in another worktree and make changes and
commit there


How do you change the setup?
============
In case of a sparse gitmodules file, you can just check it out
(make it non-sparse) or vice versa.

In case of a namespaced gitmodules file, you'd change the
config setting and have to move the file to the new location.
as git config is just about configuring, the user is left alone
with moving the file, or would we have a helper for that?
("git submodule relocate-gitmodules" or such)?

If you have the special ref, you could just checkout the
special ref in another worktree and make changes and
commit there.

I hope this helps instead of confusing more,

Thanks,
Stefan
