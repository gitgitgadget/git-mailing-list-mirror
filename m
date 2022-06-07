Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C4C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 01:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbiFHBbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386248AbiFHB03 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 21:26:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A049AFB408
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 12:39:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h72so10064415iof.11
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3WmGWpzpNqjgdWcQ2xPP8AfYlKmOHpo+lLuY3SVdZZQ=;
        b=PVx5qMutgy7y3iRKoJJVPHXQZR8imEI9fi+42Rt7eppJo7C61mGQpbTrQZ55E3fvK7
         eJEIQBCzXEkJNBRXkBXv316Lztb8IRuUgq1DM64zJS9MtJxxPiev4FWZPvC2bMfBrMp3
         2oiDNphYPtArvhx2U4IIxcaVHFqHXLf0EwI1T9eQwFRLBwsP+mZU5kKxH+OqLL6rPo5f
         278RKq3QzBNahvyfDfWvFxXCQDIqllfGadNqbhprmQinYlQyLg9/vPMc3tKmatQssHiA
         6D/IVd9Ce6f9i20Hs+9HM+xJ5RsmwrpVqd+P2yblem5HEiN4uBxcmkoP3ROjziBPgAjm
         adbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3WmGWpzpNqjgdWcQ2xPP8AfYlKmOHpo+lLuY3SVdZZQ=;
        b=zwV+do/BGf/BIj5e74HPnfPvYbU3ylCbyqKiK7USCaX8VZx897d70BLBhJKFhnkE2w
         MrkskhgfhugjSn9Gb4PsNjrESFz7xUb654fp7+9SIOogsPOg6rpyEv+Ma6U/MJtk8xrm
         fIag4TIJ+rUmI1OvCpKGdSfOknj7HaUY32GAXzU/Hn19eqSUoeiOVpFeHSDau3DWPr0g
         Ebu/tTRl+rs0nOghimVGX6Wy/cpo8/wIRoqVBWM2eDkpYAii+BH8PpCvFcXCL1LT+tmC
         uxJoHzP+Gb1m2ll9SfhLWh4ZENCXolVtyc7WfSDGuvPIZQidjvV7Xy6rH9EMBJvLBmic
         DKRg==
X-Gm-Message-State: AOAM531EZP8XFhVMaSq5sHjuVGA7PgClpUz14LOSyLHk8ctG50k4Y4nN
        NDpDq+cELCyqXG6TBgf5cUFe
X-Google-Smtp-Source: ABdhPJxq/5+SoQLqdKYGDj5BBd2kY4X7eqbB2dLYgorato+LVNj1JJH0TVL9RYpNkzezYEIxR2viqA==
X-Received: by 2002:a02:3448:0:b0:331:84bb:d66b with SMTP id z8-20020a023448000000b0033184bbd66bmr11379278jaz.292.1654630779966;
        Tue, 07 Jun 2022 12:39:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:84ee:28a2:f31c:8892? ([2600:1700:e72:80a0:84ee:28a2:f31c:8892])
        by smtp.gmail.com with ESMTPSA id o10-20020a92d38a000000b002d16d5165a5sm7621513ilo.45.2022.06.07.12.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:39:39 -0700 (PDT)
Message-ID: <9354d1d3-c1b7-3baf-215f-30659ad48b22@github.com>
Date:   Tue, 7 Jun 2022 15:39:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <YppSl4rOvVciLuXE@nand.local>
 <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
 <3bb8baa2-e3e0-5cf1-aace-b0ba3ec6eb77@github.com>
 <90ccd923-3552-fe88-5d6d-869def7f1aeb@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <90ccd923-3552-fe88-5d6d-869def7f1aeb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2022 6:11 AM, Phillip Wood wrote:
> On 06/06/2022 16:12, Derrick Stolee wrote:
>> On 6/4/2022 11:28 AM, Phillip Wood wrote:
>>> On 03/06/2022 19:27, Taylor Blau wrote:
>>>> On Fri, Jun 03, 2022 at 01:37:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>>> This is a feature I've wanted for quite a while. When working on the sparse
>>>>> index topic, I created a long RFC that actually broke into three topics for
>>>>> full review upstream. These topics were sequential, so any feedback on an
>>>>> earlier one required updates to the later ones. I would work on the full
>>>>> feature and use interactive rebase to update the full list of commits.
>>>>> However, I would need to update the branches pointing to those sub-topics.
>>>>
>>>> This is really exciting. I'm glad that you're working on it, because I
>>>> have also wanted this feature a handful of times over the years.
>>>
>>> Yes, thank you Stolee. I agree this will be useful, but I wonder if users
>>> will be confused that --update-refs only updates the branch heads that happen
>>> to be in the todo list, rather than updating all the branches that contain a
>>> rewritten commit. I think the latter is something we should try to add in the
>>> future and so we should take care to design this topic so that is possible.
>>
>> At the moment, the design adds a comment to the TODO list, showing which
>> branches are not possible to move because they are checked out at another
>> worktree (or is currently checked out and will be updated by the rebase
>> itself). That seems like a good place to insert alternative logic in the
>> future if we see a need for better behavior here.
> 
> I think the question of whether to update branches that are checked out in
> another worktree is a question of whether it is less inconvenient to the user
> to skip the ref update and leave the user to manually update the branch or to> update the ref and leave the worktree in a potentially awkward state if the
> user was half way through building a commit. The answer probably depends on
> the preferences of the user.

I think that their 'git status' will look strange no matter what: their
working directory and index could look significantly different from what
the branch at HEAD is reporting. For this situation, I would rather continue
preventing these ref updates from underneath worktrees.
 
> I've been using a script that updates the refs for all the branches being
> rewritten for a while and have found it preferable to always update the ref
> rather than have to do it manually. My script also updates the worktree
> checkout to the new HEAD if there are no uncommitted changes which I have
> found very convenient. My preference is probably because I tend not to have
> uncommitted changes lying around in the worktrees whose branches get updated.

Actually updating the worktree to match seems like an interesting twist, which
we would want to consider if we go this route in the future.
 
>> Unless: am I misunderstanding something about your concern here? Are you
>> worried about refs outside of refs/heads/*? Are you concerned about it
>> being _all_ refs/heads/* that we find?
> 
> My concerns are primarily about being able to extend the --update-ref
> option in a backwards compatible way.
> 
> I'd like to be able to add functionality to rebase all refs/heads/* that
> are descended from the commits that a simple rebase would rewrite. Say I want
> to edit $commit then I want the rebase to rewrite all the commits and update
> all the branches in in
> 
>     git rev-list $(git for-each-ref --contains $commit refs/heads/) ^$commit^@
> 
> Ideally we'd avoid adding a new commandline option when adding that. I think
> we could use an optional argument as you suggest below (though it would not be
> a refspec).

This is sort of the opposite of what my series is doing: you want to find all
refs that contain the current commits and make sure that they are _also_
rebased as we rebase the current set of commits. That seems like an interesting
direction, with a very different set of complexities (ignoring other worktrees
seems like much more of a blocker here).

I would consider this to be _yet another mode_ that is separate from
--update-refs, though it could share some underlying logic. It gets more
complicated if there are merge commits involved (do we have a --rebase-merges
option?).

This makes me think of earlier discussions around a "git evolve" command
(based on Mercurial's evolve command). The idea is to have a different
workflow than I am presenting: instead of creating `fixup!` commits at the
top of a multi-part topic, you could check out a branch on a middle part
and work forward from there. Then, you could "rebase every branch with a
rewritten commit" to get things back into a nice line.

In conclusion: I don't think we should go down this rabbit hole right now.
I think that --update-refs would be something we want to enable by default
if we have such a mode, though.
 
>> One potential way to extend this (in the future) is to make --update-refs
>> take an optional string argument containing a refspec. This would replace
>> the default refspec of refs/heads/*.
>> [...] 
>>> Instead of using 'label' and 'exec' I'd prefer a new todo list command
>>> ('update-ref' or 'update-branch'?) used in place of 'label' that takes a
>>> branch name and updates the branch ref at the end of the rebase. That
>>> would make it easy to do all the updates in a single transaction as you
>>> suggested. Adding exec lines to do this makes the todo list messy and we
>>> have been trying to stop rebase forking all the time.
>>
>> Thanks. Yes, a new 'update-refs' step at the end would be good to make
>> it clear we want to rewrite the refs in one go without a possible
>> interruption from the user.
> 
> That's great, it is a bit more work for you but I think it gives a much
> nicer UI.

Thanks. After some hurdles on my end (and some additional complexities
discovered in the process) I will have v2 ready soon.

Thanks,
-Stolee
