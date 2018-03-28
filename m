Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71931F404
	for <e@80x24.org>; Wed, 28 Mar 2018 21:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeC1VT5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 17:19:57 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:35344 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeC1VT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 17:19:56 -0400
Received: by mail-yb0-f174.google.com with SMTP id v66-v6so1309840ybv.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=csbQyXZIOAWhuxm8Gwgi3RAeDmnyl70Im/zfDmimo2I=;
        b=igF4tVpyn/DipVLFmbahS2hYXE5n/yrSxjhfkF5zf7kA5ZKBM7m+4RT29JJFRwAaCG
         Hnd16a3jYk8p12ZyAU7kTwfpv6OCom/e6ajLV1jH+nFAG7fMKrExiZ2wp1T5iKiSvBzY
         53qpthorYyHUt3Hqy3qiRQk7SzOBjmODNrKdYqDRyBRUVBoIrr96aR2OirwMEMLDJanv
         7LwZROdYOfvtODuXHicUEkCgwNJgglJLUUKsjN4G8GwLEe61Fgg9kzOL4xPj+HlCi5T2
         kdEKIxSUQQ8APLTPljQWdk4vo3jvtmVPVgp3MsQp4DBmi0IABW36UzxI7hbCFplvW2+M
         HHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=csbQyXZIOAWhuxm8Gwgi3RAeDmnyl70Im/zfDmimo2I=;
        b=ipdBCCXQ2TTARNmjVnK1Ppu8DnbESw8ThBoQ+chKplqrYO8w3idJgkQ9zyoSHvWa4Q
         OpiWM4HrHEmDfy5qsw1IRWMePVMms0tQPzZZAZq+blPrO8aHhmKoUZ2kTYl45zadLy/p
         uj5nROWId0C+uHW2kSa0lhGGiVfLrTrbJCHqJNxl7MvHHl5Ov01U5EnvUrX5vFr5Q4Y0
         AbCdWGzr6JhKPnlK585VPXQB97+snYte4pob+Bb++F6utL4GUjYoqRxZ9TYbrtuGm20o
         kRU9a56Eaj15HMN+J2VJ2wufB6urFnWN81KhVUI16VjZshep/5MnnGGXtc+fzYUTU8Jm
         vc5Q==
X-Gm-Message-State: AElRT7Hy2uzDapfz5f2jgI/C7NKS2w8GCA16IBfY8nOOOKzAdXxYzRbl
        AgPEMRgxxPzfT/Lq5E7siIjUkfJwVDjh7Im13uqtBKW5
X-Google-Smtp-Source: AIpwx49iSA4U56nZaF0tjabQ5+uLwJFZMh6EMa3eBV4Tc+jO0dIdCB6UdqdJDx8gTxsEG9RihVXwl65lb3vjE3gyQxI=
X-Received: by 2002:a25:e80d:: with SMTP id k13-v6mr3285410ybd.334.1522271995360;
 Wed, 28 Mar 2018 14:19:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 14:19:54
 -0700 (PDT)
In-Reply-To: <9ead5ee1-9d4a-38f6-0fa3-ca4c982b33f5@arcor.de>
References: <9e22b49e-6732-17c7-76fe-0ce241787db9@arcor.de>
 <CAGZ79kYGY5bjh0WPQh7xkXQxLkB9EQ-OcJhVuGE8YUnwmvk2Fg@mail.gmail.com> <9ead5ee1-9d4a-38f6-0fa3-ca4c982b33f5@arcor.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 14:19:54 -0700
Message-ID: <CAGZ79kZ326BGMuNNDTepN=_9j35Tu+zUACHKK67m+dhz7MFpMQ@mail.gmail.com>
Subject: Re: git submodule deinit resulting in BUG: builtin/submodule--helper.c:1045:
 module_list_compute should not choke on empty pathspec
To:     Peter Oberndorfer <kumbayo84@arcor.de>
Cc:     git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 12:37 PM, Peter Oberndorfer <kumbayo84@arcor.de> wrote:

>>> 2) Should "git submodule deinit" work on submodules that were removed by
>> upstream already?
>>
>> To answer the question "Is this a submodule that upstream removed
>> (recently)?"
>> we'd have to put in some effort, essentially checking if that was ever a
>> submodule
>> (and not a directory or file).
>>
>
> Hmm, yeah looks a bit more complicated than I initially imagined
> since submodules can have a name that's different from their path.
> And after the rebase, the name <-> path mapping via .gitmodules is not available anymore.
>
> Naively I think it could work the following way:
> * Either iterate over all submodules in .git/modules/ and check their config
>   has a worktree = "../../path" that resolves to the submodule path we want to remove.

This would work but scales linearly with the number of submodules.


> * Or check the "gitlink:" path in submodule/.git if it points to our .git/modules/
> Then if .git/config contains a [submodule "name"] entry
> we should have a pretty good idea if this folder contains a stale submodule.

If you move a submodule a directory up or down, the relative path is not exact
any more, we'd need to check for the last part to loosely match.


>> When using "git pull --recurse-submodules" the submodule ought to be removed
>> automatically.
>>
>> When doing a fetch && merge manually, we may want to teach merge to remove
>> a submodule that we have locally upon merge, too.
>>
>
> Yeah that would be nice :-)
> In my case I updated the repository via a rebase, so that would also have to be covered.

Oh rebase itself has not yet learned about recursion into submodules.
("git pull --rebase --recurse-submodules" is a thing though)

>> I view the git-submodule command as a bare bones plumbing helper, that we'd
>> want
>> to deprecate eventually as all other higher level commands will know how to
>> deal
>> with submodules.
>>
>> So I think we do not want to teach "git submodule deinit" to remove dormant
>> repositories, that were submodules removed by upstream already.
>>
>
> My gut feeling makes me expect the following:
> * It would be nice if such stale submodules showed up in "git submodule status" or "git status"
>   Now "git submodule" shows nothing related to this stale submodule

That has currently only two ways "+" or "-" for there/not there.
Maybe we'd need to add some characters similar to "git status --porcelain"
such as "?"

>   Now "git status" shows  Untracked files: src/rt which is a bit confusing as the actual submodule is in src/rt/hoedown
>   Now "Git gui" shows src/rt/hoedown as untracked git repository

hm. The current state of affairs doesn't sound intriguing.
Though, I think we'd want to step back one more step and rather want
to ask how a dormant submodule comes into existence, instead of
just improving the reporting. Reportingthem is of course also important,
but in the long run I'd rather want to have situations like these happen
less often. When upstream deletes a file, they are also not required to be
deleted manually, but merge/checkout would take care of them.

> * There should be an easy(and safe) way for the user to deinit such a submodule
>   if if the automatic submodule updating during a merge/rebase was not enabled or somehow failed.
> (Minus the problem of somebody having to actually do the work...)
>
>>> ~/src/rust/rust$ git submodule status
>> ...
>>>   b87873eaceb75cf9342d5273f01ba2c020f61ca8 src/tools/lld ((null))
>>
>>> -> strangely I get (null) for the current branch/commit in some
>> submodules?
>>
>> This sounds like (3). Looking into that.
>
> Sorry, what do you mean by (3)?

I meant the ((null)) issue is another third thought that we can
discuss separately,
slightly unrelated to the others (that you marked as (1) and (2))

Thanks,
Stefan
