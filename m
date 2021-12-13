Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B066C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 13:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbhLMNqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhLMNqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 08:46:23 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649CC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:46:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id j9so14346973qvm.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 05:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Q1P5qBzLwe8daljXrJxYgrn3rB9XQdCF6veLpu/BiWM=;
        b=JcH56RRIMcDzf7s6tpoF8b1/6HFwhzqv+YdJd2gZMrZW/6gRP/KxpoQESoq6lLeqIw
         dzaq5+ftVo6BPsl5LRTXm4orWHC7L5WTwoyLMfCRRYRXDu1dnfx/jWDMnvi6nSdkaG1v
         oy6NBylkoiLJltloV9Zmagz0udySUD6kGzK6CtwiA75lgcCrngKK2/5aacMAf3fB7vjq
         xH4XYgQkWrHFQyXTwpbQNarPtpXGIDEXGssKi7vsS/CihJIx6BgPzh5GKqu927UsSEx8
         EeuuRXuzcaGLBqBqNSOutid5fNxp8dzdNWPTGYqDErk3QB+GbZzw/YYPm4i1JDP+VtsI
         1D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1P5qBzLwe8daljXrJxYgrn3rB9XQdCF6veLpu/BiWM=;
        b=65yvUSvdd5kVLrs8O4jjpHBKv2tzGOzRYcHMo9zfdNK9nHdzxvBAQur/INMMOxbc4A
         eOHHPd7xnD3KvdvRpcTb7xryLHZSx6TIQsdh6rZ1dJYkvWR74FJswY+/SiwkmCVovkiJ
         oJhXnsUPVz/mQ6LWisl6drvnESU6XDy2GKU1LWr1Vh5mR5yU92lhmhJaEnA40JjND/X5
         JaTi5D80cPvQ8iE1UDj2ThEY46qAAlueJ5GIERJoh9zoutTCyOaGvg04+q6rEruKtTnq
         fNIMANOIoxfd5itb84kLbrsGFVcg5RLV4MK61NWJd/FTHM82EuobGMSp3RaiTEEMMyVf
         bMDg==
X-Gm-Message-State: AOAM532hjXoOKX5X99/JxrJMTWIJYMAoqEK/7tWYJTUrZ5z04kQCE7dt
        rW8qhpYYCQnw5+Ta+AItk1sVPrWOyfk=
X-Google-Smtp-Source: ABdhPJyl3Vp4xviQ+RLsUHRe4t6yhH2NHWO5IB9AMzKp/7yKB35vlaPGPAvxl2citmokxr+3IsPuOg==
X-Received: by 2002:a0c:f34d:: with SMTP id e13mr43330456qvm.119.1639403181967;
        Mon, 13 Dec 2021 05:46:21 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bj30sm5790880qkb.58.2021.12.13.05.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 05:46:21 -0800 (PST)
Subject: Re: A bug or issue with "git rebase --autostash" not popping the
 stash automatically
To:     Henk Smit <hhwsmit@xs4all.nl>,
        Git mailing list <git@vger.kernel.org>
References: <763856358.299504.1636971571656@ox-webmail.xs4all.nl>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <9ee85cd2-3783-d077-11c1-5a779a325a0a@gmail.com>
Date:   Mon, 13 Dec 2021 08:46:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <763856358.299504.1636971571656@ox-webmail.xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Henk,

Le 2021-11-15 à 05:19, Henk Smit a écrit :
> Hello Philip,
> 
> May I ask you a question?

You may, but I might not answer, or even receive your email. It is always
a better idea to write to the mailing list, and CC people that you want to
be made aware of your message :)

> 
> Today I saw your post on the git mailing-list:
> https://public-inbox.org/git/a0071549-73f6-9636-9279-3f01143a05de@gmail.com/
> Regression in 'git pull --rebase --autostash' since v2.32.0
> 
> I am far from a git expert.
> But I have seen the following behaviour (git version 2.26.2.dirty and git version 2.33.0)
> 1) I have a few changed files in my workspace
> 2) I want to "update" my workspace
> 3) the remote repository has one or more changes in files that I have altered too
> 4) I do a "git pull --rebase --autostash" or "git fetch && git rebase --autostash", etc
> 5) The fetch works. Autostash creates a stash. Remote changes are applied with the rebase.
> 6) PROBLEM: the stash is not automatically popped.
> 
> "git rebase" complains that there are conflicts (can't remember the exact wording).
> This happens when there are real conflicts (local and remote changes in the same line(s)).
> But also when the changes are at different locations inside the files. Not real conflicts, imho.
> "git rebase" says "Your changes are safe in the stash". It doesn't pop and apply them.

Yes, that's the correct behaviour. If there are conflicts in the rebase, we do not apply the stash,
since it could make the situation even worse if the modifications in the stash also conflict with
the same lines as the rebase conflict. That fact, I realize, is missing from the documentation [1].

> When I then type "git stash pop" manually, the stash pops, changes are edited in, with the
> usual ">>>" and "<<<" markers. Everything is fine. Except that the stash is still there
> and I have to delete it manually.

So, the stash does not apply automatically, there are conflicts. As noted in [2], this is
the correct behaviour for 'git stash drop' [2].

> 
> My question: is this how it should work?
> Imho, there is no reason to not always just pop the stash. Why do I have to pop (and delete
> later) the stash manually? Is this a bug? Is there a way to make it happen automatically?

What you describe is working as it should,  I think.

> 
> Is this related to the issue you point out on the git mailing-list?

No, I was describing a case where the stash should have been applied automatically,
but it was not. This bug was fixed in Git 2.33.0 [3].

> Would the current behaviour change in the latest version of git?

I don't think so, as from what I understand of the behaviour you are describing
and my reading of the docs, everything is working as it should.

> 
> Thanks,
> henk.
> 
> 
> Some background.
> In a previous job, I worked 3 years with git. At that company, we used the "git up" plugin.
> Programmers did 3 only 3 things: 1) clone a tree, 1a) edit, compile, test, repeat, 2) some
> times update your workspace, 3) push your changes to the remote repository.
> Step 2 was simple. Type "git up" and everything worked automatically.
> A very very simple work-flow. But it was all we (the regular programmers) needed.
> 
> I now work for another company. A larger company. They've started using git earier this year.
> Most people still use ACME (the previous source-code control system). They just clone a new
> workspace right before pushing (creating a pull-request). So most programmers never update
> their git workspaces. I am new, I skipped ACME, and use git only.
> 
> I used "git pull" to update my workspace. That failed sometimes, when/because I had changed
> files that were also changed in the updates I tried to pull in. So I asked "how do I update
> my workspace" to our git experts. Answer: "commit first". I don't want to commit. I don't want
> my local changes split over multiple commits, etc. Basically they want everyone to become a
> git-expert, before they can even use git. I think that is wrong. I think we should have a simple
> work-flow for the average regular programmer.
> 
> So I've been looking to make updating just as easy as at my previous company. The "git up"
> plugin is discontinued. Because "git pull --rebase --autostash" is supposed to do the same thing.
> It almost does. But the autostash doesn't pop. You might forget and lose your stash, you might
> forget deleting the stash after applying it once. It just makes updating your workspace a little
> trickier than it should.

As I wrote above, the behaviour you are seeing is not a bug. When applying the stash would fail
due to conflicts, Git tells you about it:

         Applying autostash resulted in conflicts.
         Your changes are safe in the stash.
         You can run "git stash pop" or "git stash drop" at any time.

So it's up to you to remember to do it :)
If you want to have an "always-on" reminder that you have something stashed, you could use
'git-prompt.sh' [4], and set GIT_PS1_SHOWSTASHSTATE in your shell environment [5].

> 
> I asked our IT support, I asked our local git-expert, I asked our local GitHub support team.
> I asked on stack-overflow. Nobody seems to know what proper behaviour should be. Most git-experts
> don't seem to care. "Do what I do, which is do these 6 git commands, and then do these 3 other
> git commands if you want to look at your diffs, and do these 7 git commands before you want
> to push". I just want a simple way to update my workspace. One command, no surprises, nothing
> extra needed. Am I crazy for wanting that?
> 
> 
> So my question again: "is git rebase --autostash" supposed to always pop the stash or not?
> If it is, is the current git behaviour a bug?

It's not, not when the rebase has conflicts, or when applying the stash results in conflicts.

> 
> Thanks again, thanks for your time,
> henk.
> 

Hope this helps,

Philippe.


[1] https://git-scm.com/docs/git-pull/2.34.0#Documentation/git-pull.txt---autostash
[2] https://git-scm.com/docs/git-stash/2.34.0#Documentation/git-stash.txt-pop--index-q--quietltstashgt
[3] https://github.com/git/git/commit/5fef3b15dbf609bdb13352d0eb716cd79c8ff017
[4] https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
[5] https://github.com/git/git/blob/e773545c7fe7eca21b134847f4fc2cbc9547fa14/contrib/completion/git-prompt.sh#L44-L46
