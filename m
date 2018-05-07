Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E190D200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeEGXjb (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:39:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45617 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeEGXja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 19:39:30 -0400
Received: by mail-wr0-f194.google.com with SMTP id p5-v6so30363070wre.12
        for <git@vger.kernel.org>; Mon, 07 May 2018 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EU7WUw5orZZQFeVRB2M/n+RptJ84hB6h8nyRCxxCGPM=;
        b=oMKDuUyy3Y9PfXPQc0aGjZr70TSZJUaNJKDayPxMqL99wgo3z71DVq14hmDTKDGgez
         lLE81vtoeDJhS48Uw5oAGEB4YqoZCrSRREcUb63seg9MzKSM+khT7q6ImyyN/6TabHuJ
         Qk8mhzF84jcdUR7tROXhXCnYDrPMSu5bqI9/zQRNRZv3R4oIJaOTXUltLbW9xANgjv1Y
         F567JgMl54Zby7Xkt/gu3hwL2Rzis+3fTWoTaEx4Ep8vXjHwfDIcQlVMcn9zHNQD7qO0
         ojiH9KVThTKTDKR+HMU0utsTumPHppwMFDwL0C8DjuJQa9iMyOhCaDk/KKyir75sQdfr
         xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EU7WUw5orZZQFeVRB2M/n+RptJ84hB6h8nyRCxxCGPM=;
        b=A8nLTKLeFqwLHUp1fTTQgtxnSAYobRqQfXnP4/lNPLNuu8rzvqxPt5262clFq9cNjZ
         axCyXaM4CFt3gn03A3rC1hra9JLUiQ+J7QCKM0ab+skQzUHYQVuc0LEEDITdCO5AIsi5
         2i7GPHcxjzBR5EfKc4U6Es1Tp+Y0iYi4X13owK2PaoGp/56QM4nvY1PLnOEmCJdBuRZA
         k12ON4Pbg0v2e3/s5DohgF5dA2C52qosV3LZKXqrdCyR1/L6Lutynt80wLKvu68egdt+
         Dsvlu2MUiFtqbXMK/1Q0DdotCms/+lTEjhDtYo4RvybunCq9yr9VBHVhSXejBjBv3rV4
         cTMQ==
X-Gm-Message-State: ALQs6tDTUj9eUaavI56GSpAbdyO613g1I2GaWq28c4Sh+DUAGcYjDj5v
        YWIQUIXoRLGmKV7TKM9vIjM=
X-Google-Smtp-Source: AB8JxZq5iAZfcEZDd5QaB5CyUTDy8lQtWxWYu2qT2vhEXOtSeSeSXgdovSJvmJTNlw20bXljyF5ubQ==
X-Received: by 2002:adf:8407:: with SMTP id 7-v6mr16837529wrf.176.1525736368617;
        Mon, 07 May 2018 16:39:28 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.177.115])
        by smtp.gmail.com with ESMTPSA id 76-v6sm17232654wmj.0.2018.05.07.16.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 16:39:27 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
 <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
 <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
 <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
 <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
 <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <bc9fa17b-d133-6679-42cf-2374e4513c35@gmail.com>
Date:   Tue, 8 May 2018 01:39:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZbRCH2OiTW1Ge31R9JN+vWD6tcjNWVGSzkSBcYZvwDjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 08/05/2018 00:24, Stefan Beller wrote:
> 
> > List, rename, delete -- all these seem more as basic CRUD operations,
> > where comparison is a more complex one. And not to get me wrong - I
> > could see "branch diff" being part of "branch", but not really when
> > "diff" already exists as a separate thing, already doing quite some
> > (but still diff related, and configurable) stuff.
> 
> If we go with "branch --diff", because it has the CRUD operations already
> there for branches, I might ask for "remote --diff" to diff two remotes. ;)
> (That command "remote --diff" would not make any sense, would it?)

I`m not sure if this is a reply to me or in general, and whether you 
support what I sad, or argue against it...? Because what you`re 
saying was (or at least should have been) my exact point there :)

> > Basically, what you (conceptually) call "two versions of the same
> > branch", I simply call "two branches" (from usage standpoint).
> 
> If I diff 2 (topic) branches, which are based on a different version
> from upstream, then I see changes from commits that I don't care
> about, but this tool explicitly excludes them. Instead it includes
> the ordering of the commits as well as its commit messages to
> the diff.

Here, I was merely pointing out that you still need to provide two 
branch heads - which might be expected to resemble "two versions of 
the same topic", but they are still (just) "two branches" in Git world.

> > And you may have a branch that got split, or more of them that got
> > unified, so defining "previous branch version" may not be that
> > straightforward - it`s really just "two commit ranges" (as man page
> > defines it in general), with "two versions of a patch series" only
> > being the most common/expected use case of the former.
> >
> > Finally, if user picks two totally unrelated "branches" to compare,
> > he won`t get a really useful diff - but it`s the same as if he would
> > compare two totally unrelated commits (where tree state massively
> > changed in between, or having unrelated histories, even).
> 
> I used just that, but narrowed down the comparison to one file
> instead of the whole tree.

Again, not sure if this should support the argument, or argue against 
it? :) My point was that there might be other use cases (as you seem 
to have supported now), and as "diff" is pretty forgiving, might be 
"diff branch" should be as well.

> > With something like `git diff --branch <commit1>...<commit2>` you
> > would get yet another "diff look", useful for use case in question
> > here.
> 
> Personally I think this patch series should neither extend git-diff
> nor git-branch.
> 
> It should not extend git-diff, because currently git-diff can diff
> tree-ishs (and does that very well) and comparing to
> worktree/index.

Hmm, are you saying that `git diff` actually has a too generic name 
for its (more specific) purpose?

> It should also not extend git-branch, as that command is for
> CRUD operations that you hinted at earlier (Earlier I proposed
> git-remote --diff for diffing two remote, which makes no sense,
> another one might be git-worktree, which also just does CRUD
> for worktrees. It would be a bad idea to have "git worktree --diff")

Agreed here.

> Hence I propose "git range-diff", similar to topic-diff, that
> was proposed earlier.

I find it strange that we already have both "diff" and "diff-something" 
commands, and yet you still propose "something-diff" naming pattern 
instead (but I guess it`s mainly because of auto-complete concerns).

Please forgive my lack of code base familiarity, but from what I`ve 
seen so far, and at least from end-user perspective, I may rather expect 
`git diff-range` as low level implementation, and possibly exposed 
through `git diff --range` (with a nice single letter abbreviation?).

> * it "diffs ranges" of commits.

Thus "diff-range", as your description says itself :) ("range-diff" 
might sound like it "ranges diffs"...?)

> * it can also deal with out-of-git things like patch series,
>   but that is a mere by product and may not be desired.
>   Just like git-diff can also compare two files outside a git
>   repo, that would not be a good use case.

Hmm, so still follows `git diff` in general... `git diff --range`? :D

> * it autocompletes well.

Only here I`m not sure if something like `git diff --range` (with 
accompanying single letter option) would be considered "auto-complete 
friendly", or not?

Regards, Buga
