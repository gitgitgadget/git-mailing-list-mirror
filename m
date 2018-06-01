Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F361F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 09:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeFAJrg (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 05:47:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFAJrf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 05:47:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so1848463wmt.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HBXqkXtP/6A4Qr2jgj9CrF3z37Fcy8e6dDZmobsskEo=;
        b=krKLzblvohhUbnBw8gnRwjeqqMrPgQSKNTF1DnJJH720XJMZ/wx3las+BV7UsikNyF
         wNV3PDa3YDaMXADx9U7n+AgfPkJ5L77gVFy9HVm/SY6NrYAsQzC7RrYrwSH+Is3m9Uaf
         kw/gVETBgfmFo5yw3bFJZcYIURMY1/68SUqBuVs2b1VqBVFJzXeHdhYmfs2WJBDebhMR
         tpPwtR8Tos9MyAz/7m/V/RuS6FEnrGFgMbT6foOFiWO8U6ScceshkGCupHBkxJxSNM8D
         LEj5xYrWKGAAFVb7+8GKK0IOaQhoJJd3BCZghJwYmwt5zkk2ZDAyQ8h44yo9kqbSdHiD
         K14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HBXqkXtP/6A4Qr2jgj9CrF3z37Fcy8e6dDZmobsskEo=;
        b=mtc4zdlES48Aa2NBnADAJXKN8rqeaek2bHxhwgt6knwZEwjWhN0PlrDf4COtHKNzdC
         VIU8OzP/frzsAKvb1/zqqd7o7FjkGYTKG7L9vi0CDbNiV4kaDH6+/06C1x2ZoXr50tcS
         9q1k/a7NH1cUPcGE0hn+1TAmyOEieTZkClw6jbkoZ3Fr7dbJOuABKYGsFTNMy9vzxHoO
         wXBP1U0vZznG1YAJG9JmMYC/JT/KXp7ahLkewmUMhlnM9MJ0fAJmdOpFyLqwOhZ9vbPv
         JaNTI24Hz86mmXoJL6Rkod8ktwJX4luu2XQkP3W1An/7w9J+oAW+3amcGGMm7hniYTNb
         ccxQ==
X-Gm-Message-State: ALKqPwe7fiKpYrr6LQTJ8C0boxWo7GRM8tAMSuu+90AMTqQvMyuyuZWG
        8kwMGLmpMAmb+8/dLWf50iI=
X-Google-Smtp-Source: ADUXVKKbATTAvQuErRaZuVawPIusuN4l6eep8zLvckjKB9QQkyknE6BJ3lThiTKf+nEhOa7KbeMmZA==
X-Received: by 2002:a50:a4c5:: with SMTP id x5-v6mr6372908edb.247.1527846453768;
        Fri, 01 Jun 2018 02:47:33 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c46-v6sm9931332edc.34.2018.06.01.02.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 02:47:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 9/9] checkout & worktree: introduce checkout.defaultRemote
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-1-avarab@gmail.com>
        <20180531195252.29173-10-avarab@gmail.com>
        <CAGZ79kZKaZq+bqFTwe+Y3FU-1DHPjzNrvMNU=DM10EyOXxZJVw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79kZKaZq+bqFTwe+Y3FU-1DHPjzNrvMNU=DM10EyOXxZJVw@mail.gmail.com>
Date:   Fri, 01 Jun 2018 11:47:32 +0200
Message-ID: <874limale3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 31 2018, Stefan Beller wrote:

> Hi Ævar,
>
> Sorry for chiming in late. I have a couple of thoughts:
>
>>     (
>>         cd /tmp &&
>>         rm -rf tbdiff &&
>>         git clone git@github.com:trast/tbdiff.git &&
>>         cd tbdiff &&
>>         git branch -m topic &&
>>         git checkout master
>>     )
>>
>> That will output:
>>
>>     Branch 'master' set up to track remote branch 'master' from 'origin'.
>>     Switched to a new branch 'master'
>
> I thought master is already there after the clone operation and
> you'd merely switch back to the local branch that was created at
> clone time?
>
>     $ git clone git@github.com:trast/tbdiff.git && cd tbdiff
>     $ git branch
>     * master
>     $ cat .git/config
> ...
> [branch "master"]
>     remote = origin
>     merge = refs/heads/master
>
> But the observation is right, we get that message. When do we
> do the setup for the master branch specifically?

What you're missing is this part:

    git branch -m topic

I.e. we clone the repo, and have a "master" branch, we then rename
"master" to "topic", now there's no local master branch. Then we
checkout master either with only one remote or two.

>>
>> But as soon as a new remote is added (e.g. just to inspect something
>> from someone else) the DWIMery goes away:
>>
>>     (
>>         cd /tmp &&
>>         rm -rf tbdiff &&
>>         git clone git@github.com:trast/tbdiff.git &&
>>         cd tbdiff &&
>>         git branch -m topic &&
>>         git remote add avar git@github.com:avar/tbdiff.git &&
>>         git fetch avar &&
>>         git checkout master
>>     )
>>
>> Will output (without the advice output added earlier in this series):
>>
>>     error: pathspec 'master' did not match any file(s) known to git.
>>
>> The new checkout.defaultRemote config allows me to say that whenever
>> that ambiguity comes up I'd like to prefer "origin", and it'll still
>> work as though the only remote I had was "origin".
>>
>> Also adjust the advice.checkoutAmbiguousRemoteBranchName message to
>> mention this new config setting to the user, the full output on my
>> git.git is now (the last paragraph is new):
>>
>>     $ ./git --exec-path=$PWD checkout master
>>     error: pathspec 'master' did not match any file(s) known to git.
>>     hint: The argument 'master' matched more than one remote tracking branch.
>>     hint: We found 26 remotes with a reference that matched. So we fell back
>>     hint: on trying to resolve the argument as a path, but failed there too!
>>     hint:
>>     hint: Perhaps you meant fully qualify the branch name? E.g. origin/<name>
>
> s/meant fully/meant to fully/
> s/? E.g./?\nFor example/

Thanks, will fix.

>>     hint: instead of <name>?
>
> In builtin/submodule--helper.c there is get_default_remote() which also
> hardcodes "origin". I think that is a safe thing to do.
>
>>     hint:
>>     hint: If you'd like to always have checkouts of 'master' prefer one remote,
>>     hint: e.g. the 'origin' remote, consider setting checkout.defaultRemote=origin
>>     hint: in your config. See the 'git-config' manual page for details.
>
> his new setting elevates one remote over all others, which may
> be enough for most setups and not confusing, too.
> Consider the following:
>
>     git clone https://kernel.googlesource.com/pub/scm/git/git && cd git
>     git remote add gitster https://github.com/gitster/git
>     git remote add interesting-patches https://github.com/avar/git
>     git remote add my-github https://github.com/stefanbeller/git
>
>     git checkout master
>
> This probably means I want to have origin/master (from kernel.org)
>
>     git checkout ab/checkout-implicit-remote
>
> This probably wants to have it from gitster/ (as it is not found on kernel.org);
> I am not sure if it would want to look at interesting-patches/ that mirrors
> github, but probably if it were not to be found at gitster.
>
> So maybe we rather want a setup to give a defined priority for
> the search order:
>
>   git config dwim.remoteSearchOrder origin gitster avar
>
> Stepping back a bit, there is already an order in the config file
> for the remotes, and that order is used for example for 'fetch --all'.
>
> I wonder if we want to take that order? (Or are the days of hand
> editing the config over and this is too arcane? We would need a
> config command to re order remotes). Then we could just have a
> boolean switch to use the config order on ambiguity.
> Although you might want to have a different order for fetching
> and looking for the right checkout.

I thought about this use-case, and if we want this in the future I think
the most straightforward way is not to invent some new search order
variable, but just make use of git config allowing multi-values, i.e.:

    [checkout]
        defaultRemote = origin
        defaultRemote = gitster

Although I'm not interested in implementing that now, and unlike just
having one special remote I don't think it's of interest to the vast
majority of git users.

>> I considered splitting this into checkout.defaultRemote and
>> worktree.defaultRemote, but it's probably less confusing to break our
>> own rules that anything shared between config should live in core.*
>> than have two config settings, and I couldn't come up with a short
>> name under core.* that made sense (core.defaultRemoteForCheckout?).
>
>   core.dwimRemote ? It's a bit cryptic, though.

Covered by Eric's reply in
<CAPig+cSk9Dt3ZLQRjWwpxqMyP3npu3KbEQxkNfjV5RxRtro82Q@mail.gmail.com>

>> See also 70c9ac2f19 ("DWIM "git checkout frotz" to "git checkout -b
>> frotz origin/frotz"", 2009-10-18) which introduced this DWIM feature
>> to begin with, and 4e85333197 ("worktree: make add <path> <branch>
>> dwim", 2017-11-26) which added it to git-worktree.
