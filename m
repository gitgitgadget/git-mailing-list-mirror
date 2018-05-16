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
	by dcvr.yhbt.net (Postfix) with ESMTP id 940391F51A
	for <e@80x24.org>; Wed, 16 May 2018 10:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeEPKdZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 06:33:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36981 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeEPKdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 06:33:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id l1-v6so421280wmb.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 03:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=peFwd/5dQM+cOb387YNDdU5ANQ6eJ4gRtqpgfoRElTs=;
        b=FaCAafA57dM3NM0ws5JXShC/vOm2e/6ZxUXKvP94jVzPDJuW94diXQxOrYAeXoVLuv
         AmFN9laKIFKY0TO94i5fFT/YFk1qPwfwuKsm5LWuWFFYURrR+X6bXLfCOYwbroZ1vAqy
         H416nz2+8FtPGmqpjNLFXIp1UeqxN68Wa1CVHM+Jm/rwPAjWh8c1hN9OJa+Nq8iyEVKL
         4GcaHn3UzEWEcuTnpv92tgsPmJc5r5iPSE6lS7y8/CJeQlJVF8tCCvgr9mmyASXRaAdd
         3mdT7Pz0JkwRYPB9dykwK+0yaTiHuP9nMClaDjGoZRIfZXApruRQdR9GC/ehY6I1ziCx
         OqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=peFwd/5dQM+cOb387YNDdU5ANQ6eJ4gRtqpgfoRElTs=;
        b=rFjOurK2VVNAXd2TXVCW/ryX/BWlyXHu7tZHFJ5DmxvrFcLo5RBZEqx7UiekkNbkO4
         B+IaJfo4M+PH26HyKgV0b7twDHulw+Ch5kmCKj5e7fE9pYGc54MeX1+m/sifUxTygOTb
         WT15zC+2/ZnfLhmfkC9uv3rY2zskyAaFzdm+VxSASUWNVI/G2dAKaK1FzRjaTspdRA1q
         i+qGCkJajoQj/TO8uiNTjbBM7ZRnbQxpbbVsNhmejdHGrRw8bxtE5vP0fpmPdLnTIwwX
         VikvXbzyfMGWMGCFORIejTFikSqRlsSrhiOAc6pvS4XAYgY3SJYHh3cnvolgxGBnOrJf
         Yhxg==
X-Gm-Message-State: ALKqPwfewgpNR1EErCX5Bhkd0sXt44BDiHgAZPRPaUJLFt5uFnI8FtZ9
        iDp/dIDKF3N4wi+6GDesa9F9sIys
X-Google-Smtp-Source: AB8JxZrjjVdF/ESyZog5ipNgwvPHnY+q5UkHYCx057qfbrN3RASzdMgiQgXD7HuYc4OzzuG6aWwHVw==
X-Received: by 2002:a50:ad69:: with SMTP id z38-v6mr391939edc.306.1526466801891;
        Wed, 16 May 2018 03:33:21 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e1-v6sm1164244edq.12.2018.05.16.03.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 03:33:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com> <87po1waqyc.fsf@evledraar.gmail.com> <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
Date:   Wed, 16 May 2018 12:33:20 +0200
Message-ID: <87muwzc2kv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 16 2018, Lars Schneider wrote:

>> On 16 May 2018, at 11:29, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>>
>>
>> On Wed, May 16 2018, Lars Schneider wrote:
>>
>>> I am looking into different options to cache Git repositories on build
>>> machines. The two most promising ways seem to be git-worktree [1] and
>>> git-alternates [2].
>>>
>>> I wonder if you see an advantage of one over the other?
>>>
>>> My impression is that git-worktree supersedes git-alternates. Would
>>> that be a fair statement? If yes, would it makes sense to deprecate
>>> alternates for simplification?
>>>
>>> [1] https://git-scm.com/docs/git-worktree
>>> [2] https://git-scm.com/docs/gitrepository-layout#gitrepository-layout-objectsinfoalternates
>>
>> It's not correct that worktrees supersede alternates, or the other way
>> around, they're orthagonal features.
>>
>> git-worktree allows you to create a new working directory connected to
>> the same local object store.
>>
>> Alternates allow you to declare in any given local object store, that
>> your set of objects isn't complete, and you can find the rest at some
>> other location, those object stores may or may not have more than one
>> worktree connected to them.
>
> OK. I just wonder in what situation I would work with an incomplete
> object store. The only use case I could imagine is that two repos share
> a common set of objects (most likely blobs). However, in that situation
> I would keep the two independent lines of development in a single repo
> with two root commits.
>
> Would it be fair to say that "git alternates" are a good mechanism to
> cache objects across different repos? However, I would consider a cache
> hit  between different repos unlikely. In that line of thinking
> "git worktree" would be a good (maybe better?) mechanism to cache objects
> for a single repo?

The use case is cloning with e.g. --shared or --reference.

Consider the following scenario:

 * You have 100 developers with *nix accounts on a single machine.

 * These 100 all need access to the same repo, but .git/objects is 1G

 * This would then naïvely require 100G of space + working tree. If the
   machine has 92G of RAM you'll be swapping the fscache in & out and
   performance will be horrible.

Instead, you have a single repository maintained on the system designed
to have all the alternates point to it, cloned as:

    git clone --reference /usr/share/git_tree/bigrepo ssh://....bigrepo.git ~/bigrepo

Now you're using just a bit over 1GB of space in total, but any new
objects the devs create will be written to their local .git dir, since
you're spending 1GB for those 100 repos instead of 100GB the data is
always in the FS cache.

And here's where this isn't at all like "worktree", each of those 100
will have their own "master" branch, and they can all create 100
different branches called "topic" that can be different.

With worktree the references are all shared across the same worktrees,
so it's designed for one dev working on different topic branches in
different checkouts.

The --reference feature is also commonly used in CI-like
environments. Imagine the above example, but except with 100 devs you
have CI jobs on the same machine being spun up all the time, although
here you get some overlap, if you're OK with the main branch name being
different you can also do this with worktrees instead of alternates.
