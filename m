Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED071FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 16:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbdBHQlI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 11:41:08 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37021 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752823AbdBHQlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 11:41:01 -0500
Received: by mail-it0-f49.google.com with SMTP id r185so107207511ita.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GmSrarvQiyaevpodRQ9utR+cETnB+6LauaNvrcg4cuY=;
        b=JqFaShpSwS5Xd8fU9g2/zWm1g0bf4hX6WEV0NeSCA/6V2tSuVHfcAAUvveR2U617c5
         DsXIRaambJwxX2dMr1GvQDwtSUIADwzDul8nBx/AMZRmGVqhrtz/eXcXWD9eYODIKceh
         lt2x/WRSaCctIXWIKr69ILvQuO7hLn1RKUitLAmt1l3ejoVzTusTO0Qxva76zcR14CZP
         NZROaXC4SSW7qX73/0tKlycu1SsOOI37JyVzTptLCcZ4RpL1LRGqOnEVjPGdwDNyrNeW
         vxK+UYB29hRYNT/DXV6NHM6GieDW9l1XUT5MrKbrh1aT+FxMl3Ni5Ifdxrrufn8C8Xh9
         M+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GmSrarvQiyaevpodRQ9utR+cETnB+6LauaNvrcg4cuY=;
        b=iZ3Xrus9uCQzuHB+zcSGy1zCWNOdMezCOKgBs8Z7bFJ+CxTe2slpmA2bzUs7Xg9b9k
         ExtmTNBk4MBnzPr8579X1y3WJHKT7VB0DRe1RPpFd+SWw8JYKQtIWl12B4r35ACpt8RR
         viAFIIgk/vIwjS98lx/O3aFFz5X4q8/O2MSo6J5fgozTBaE0OuuagBhRRpqzWQ+Z/6Eg
         ZUEaTdIvephn7GYAxoD8wKPKYEYXpZ83of0/mwx1OztVTfdOkOTxail6TTKYZQ0tDqNW
         ReZPPDuIscj1eYUeyLUczdkDD1MCExgh7JRGFihxISNfk0+HYFnmfQXi5e/oFN8hq79g
         0ayA==
X-Gm-Message-State: AIkVDXKH3Jvsaz9Zr8U93rfChU+YhZWpi3pD82HqSqjgwZ+wxr/fQEM7YkT762OCn0+EqE81WIhrYX1hFydecULQ
X-Received: by 10.36.4.2 with SMTP id 2mr16419874itb.116.1486570392425; Wed,
 08 Feb 2017 08:13:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 08:13:11 -0800 (PST)
In-Reply-To: <CACsJy8C=owNPpND4Ab7bFE24kpWBr5fQdob21DEDCckCXu0Mng@mail.gmail.com>
References: <87h94d8cwi.fsf@kyleam.com> <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com>
 <87efzg7oq3.fsf@kyleam.com> <CACsJy8C=owNPpND4Ab7bFE24kpWBr5fQdob21DEDCckCXu0Mng@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 08:13:11 -0800
Message-ID: <CAGZ79kZiEdHbWxo6OEu050EOGSvqX0ardZxxV4dpJYveKt4cGQ@mail.gmail.com>
Subject: Re: init --separate-git-dir does not set core.worktree
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 5:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 2, 2017 at 7:37 PM, Kyle Meyer <kyle@kyleam.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Thu, Feb 2, 2017 at 10:55 AM, Kyle Meyer <kyle@kyleam.com> wrote:
>>>>
>>>> As of 6311cfaf9 (init: do not set unnecessary core.worktree,
>>>> 2016-09-25), "git init --separate-git-dir" no longer sets core.worktree
>>>> (test below).  Based on the commit message and the corresponding thread
>>>> [1], I don't think this change in behavior was intentional, but I wasn't
>>>> able to understand things well enough to attempt a patch.
>>>
>>> I'm missing some context. Why does --separate-git-dir have to set
>>> core.worktree? What fails for you exactly?
>>
>> Sorry for not providing enough information.  I haven't run into a
>> failure.
>>
>> In Magit, we need to determine the top-level of the working tree from
>> COMMIT_EDITMSG.  Right now that logic [*1*] looks something like this:
>
> This is much better :)
>
>>  * COMMIT_EDITMSG in .git/modules/<module>/: set working tree to the
>>    output of "git rev-parse --show-toplevel"

.git/modules/<module>/ itself is a fully fledged git directory, making use of
the core.worktree variable to have the working tree at an "unusual" place.

"git rev-parse --show-toplevel" is the correct place of the working tree

>>
>>  * COMMIT_EDITMSG in .git/worktrees/<wtree>/: set working tree to the
>>    path in .git/worktrees/<wtree>/gitdir, minus the trailing "/.git"

(in worktree/<wtree>:) "git rev-parse --show-toplevel"s output is empty,
but the gitdir file exists unlike in the other cases.

>>
>>  * COMMIT_EDITMSG in .git: set working tree to the parent directory

(in .git:) "git rev-parse --show-toplevel"s output is empty.

>>
>> This fails for a repo set up with --separate-git-dir [*2*], where the
>> last step will go out into an unrelated repo.  If core.worktree was set
>> and "git rev-parse --show-toplevel" returned the working tree like it
>> did for submodules, things would work.

When using --separate-git-dir you cannot tell where the working tree is from
within the git dir, despite knowing it has to be *somewhere*:

    [core]
        bare = false

So I would hope we'll set core.worktree again in this case. Otherwise how
would we discover the working tree?

>
> OK. If I read this right, given a path of any text file somewhere
> within ".git" directory. you are tasked to find out where the
> associated worktree is? I.e. this is not an emacsclient executed as
> part of "git commit", correct?

I always assumed core.worktree is precisely that analogy, i.e.
core.worktree is the backwards pointer to the .git file (which
is true coming from a submodule background).

>
> So you need some sort of back-link to ".git" location. And
> unfortunately there's no such thing for .git file (unless it points to
> .git/worktrees/...). I'm hesitant to set core.worktree unless it's
> absolutely needed since it may have unexpected interaction with
> $GIT_WORK_TREE and others (not sure if it has any interaction with
> submodules too). I think adding a new file "gitdir" would be a safer
> option.

How would "gitdir" (should it be called worktree/workingtree instead?)
work together with core.worktree set?
Would it point at the .git file or the root level of the working tree?

>
> I'm not entirely sure if enforcing "one worktree - one repository" is
> safe though. The first two bullet points are very specific and we can
> assume that, but ".git" files alone can be used for anything. In
> theory you can always create a secondary worktree (that's not managed
> by "git worktree") by setting GIT_WORK_TREE and "git checkout -f"
> somewhere. But I guess those would be temporary and nobody would want
> magic to point back to them.
>
> As a fall-back mechanism, I think after magit has found the worktree,
> it should verify the found location is the correct worktree, with "git
> rev-parse --git-dir" or something, and alert the user otherwise. I
> think "git rev-parse --git-path COMMIT_MSG" should give back the same
> COMMIT_MSG path (and it applies for any files in .git dir, covering
> all three cases). The user could add some magit-specific files to tell
> magit where the actual worktree is when they hit corner cases.
>
> If the use case is limited to editing COMMIT_EDITMSG only (after it's
> generated by git), it may be best to add `pwd` as a comment to that
> file. You won't have to go through all the magic rules to find it out
> (*). And it helps non-magic users too.
>
> (*) well, you do, because you probably can't expect everybody to have
> latest git version.
>
>> Of course, the issue above isn't a reason that --separate-git-dir should
>> set core.worktree, but the submodule behavior is why we were wondering
>> if it should.
>
> I'm not a submodule person, so I'll pass that "why" question to Stefan.

Good question. As said above I always assumed it is the backlink to know where
the working tree of the submodule is.

Digging through history I found d75219b4a, which explains why that is:

    Since recently a submodule with name <name> has its git directory in the
    .git/modules/<name> directory of the superproject while the work tree
    contains a gitfile pointing there. To make that work the git directory has
    the core.worktree configuration set in its config file to point back to
    the work tree.

I remember reading this some time ago and wondered what the
"to make that work" implies though and IIRC there was nothing I found by
experimentation.
