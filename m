Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C92D1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 09:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfDXJzl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 05:55:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDXJzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 05:55:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so24194595wrw.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQS6JA0/lyXJDz/kpMRsfVveqd2Wo5mbMRpfC3DDHsU=;
        b=t/p8PDblD0x0Tg2NwfrygiDamBBgPw6P2G4EtxYxD/cUM2Mmb7m0aeSbicYWOwie6R
         AyzLlB6HFA5ijXjho1VPGJ6ZaKrMf5lCJufSjcWITiw5GDDmRSsxUHRE/sDaas+x/cC1
         3Spbck/+jPFEMnNuNA1HWdAnFKcO+b5yvHMKiq0DulbxbaE4JjOn0IpzAx2l5SNznU+m
         O1cFjusXoLB0HUFA7LIHNWiY9WJ9DVdjjyq4tcLNCx7dQYVASSoDcf3oz65FvF6m8KaG
         UtY/ZmIVfHMT4T8EgOnpbingRIk1dnjM270E2InKa+JXYTBM22aP8jS3IE/2kJBVDVWm
         Gfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQS6JA0/lyXJDz/kpMRsfVveqd2Wo5mbMRpfC3DDHsU=;
        b=Xp6Y2/MxZyMUQnV0xRuONm34OGEdf0aiz8Qheyzs6owT9qlVAtR2j2YL9xfQHzJiVD
         WkNrgljKmrH15Mb5pB0kOTRdXsrFsSD0uUXb14vK699BJoROdHhKeJCVhZ+TXIqNf8O6
         AZGmIHgtdBvPQZh2geChSgXJlmzaItAcby29nmm/cWAmTEiShqfnF481EahcoLUqT7gS
         YXykRZ+xszgdgOTxQbi4ttyNWi4irarlR6MI8jD4xzYwhqfC2q4Xugj76Z4HvLyjuKys
         um/6GWPaJGqZ2SkGVDwGv2QlwLPe58QbTXeSA9sFRjemECzNqE3kEygiqRy0EdG1hQjc
         Ys0g==
X-Gm-Message-State: APjAAAVOBLE8ZksJ+YrZmf03V4CqThcHKfviS3Qdu0wjbwzPXRf7FcMG
        jiLfz6f/K6Taah8AaN7ad6A=
X-Google-Smtp-Source: APXvYqxzo9o5In4fdnGM1LitGbzBU8x5eo4SMEhIYOmbSezdZ1rtODZo4FxW0/5pbB/Zj0tmmlx0cA==
X-Received: by 2002:a05:6000:11cf:: with SMTP id i15mr20066065wrx.287.1556099738174;
        Wed, 24 Apr 2019 02:55:38 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-7-19.as13285.net. [92.22.7.19])
        by smtp.googlemail.com with ESMTPSA id f10sm18478544wrs.17.2019.04.24.02.55.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:55:37 -0700 (PDT)
Subject: Re: [PATCH 0/5] Multiple hook support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <87tvensu1a.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <551bcdfa-d098-48a8-8712-05b7e1516bd8@gmail.com>
Date:   Wed, 24 Apr 2019 10:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tvensu1a.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/2019 09:10, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 24 2019, brian m. carlson wrote:
> 
>> Oftentimes, people want to use multiple of the same kind of hook. This
>> may be because software or a project they use requires a given hook, but
>> they would also like to have a custom hook, or because they're using
>> multiple pieces of software that both require involvement with the same
>> hook.
>>
>> This series introduces support for multiple hooks by using a ".d"
>> directory. For example, instead of using a single
>> ".git/hooks/post-checkout" file, you'd use multiple files within
>> ".git/hooks/post-checkout.d". This is the standard Unix paradigm for
>> multiple files and should be familiar to most people. Hooks are executed
>> in sorted order.
> 
> I think it's interesting if people can chime in with current in-the-wild
> implementations of this.
> 
> I know GitLab's the best, not because I was in any way involved in it,
> I've just dealt with writing hooks for it:
> https://docs.gitlab.com/ee/administration/custom_hooks.html#chained-hooks-support
> 
> There:
> 
>  1. The instance has a 'hooks' dir in the .git repo that's a symlink to
>     /my/global/hooks. They could also use a /etc/gitconfig
>     core.hooksPath for this part, but whatever.
> 
>  2. That /my/global/hooks has e.g. a /my/global/hooks/pre-receive that
>     git itself runs, which is a trampoline script that runs all over the
>     place and executes global/per-project hooks (which live in
>     .git/custom_hooks/).

Having global and local hooks could be useful. I've got some tooling
that rewrites multiple branches and has hooks to prevent committing and
rebasing in worktrees where the branch is being rewritten by a rewrite
in another worktree. I'm using core.hooksPath at the moment, but if I
ever work with a project that uses its own hooks I'll have to add some
sort of trampoline like gitlab.

Best Wishes

Phillip

> 
>  3. "The hooks of the same type are executed in order and execution
>      stops on the first script exiting with a non-zero value."
> 
> I wonder if the eventual goal of this facility would be to get such
> users on board with using git's native feature for this. This series is
> most of the way there for GitLab's case, but not quite.
> 
>> To preserve backwards compatibility, we don't run the hooks in the ".d"
>> directory if the single file is a valid hook (i.e. it exists and is
>> executable). This is because some people already have multiple hook
>> scripts configured, and if we ran them both, we'd run the hooks twice.
>> This would be bad for e.g. the prepare-commit-msg hook. This is also the
>> least surprising behavior.
>>
>> We check each hook for its exit status, even if the hook normally
>> ignores exit status, and if it fails, we abort executing further hooks.
>> This provides an easy way to reason about what the exit status is when a
>> hook fails; we need not consider how to handle multiple failing hooks.
>> It's also consistent among all hooks, whether they care about exit
>> status or not.
> 
> Others have replied to this already. I linked to the 2016 discussion of
> my RFC for this in
> https://public-inbox.org/git/87wojjsv9p.fsf@evledraar.gmail.com where I
> made the same choice. Some points on that:
> 
>  * There was the mention of "but what if someone wants to run them all",
>    e.g. for logging to N logging systems where one fails, that's been
>    brought up again this time around by others.
> 
>  * The case I find more interesting is the ability to run the hooks in
>    parallel. Saying "glob order and exit on first fail" categorically
>    closes the door to that.
> 
>> I've talked with some people about this approach, and they've indicated
>> they would prefer a configuration-based approach. I've tried to make the
>> series such that it can be replaced with such an approach if that's the
>> decision we make. It should be easy enough to simply replace find_hooks
>> with an appropriate implementation and update the test framework.
> 
> I think whatever opinions we all have on the current implementation it's
> OK to get this in in *some* form and just made it configurable or
> whatever later.
> 
> Most of the work is the ability to run N hooks, how exactly that happens
> can be tweaked later, and if this series lands and someone isn't 100%
> happy with the semantics they're no worse off than they are now.
> 
> I.e. we could get something like this in its current form, and later have:
> 
>     core.hooksOrder = glob | random
>     core.hooksHaltOnError = true | never
> 
> Where we'd say that what this series does is core.hooksOrder=glob and
> core.hooksHaltOnError=true, but that e.g. parallel "run them all" could
> be done in the future with core.hooksOrder=random &
> core.hooksHaltOnError=never
> 

