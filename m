Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC99201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 19:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbdKIT5E (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 14:57:04 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:44007 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbdKIT5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 14:57:03 -0500
Received: by mail-qk0-f172.google.com with SMTP id 78so9247971qkz.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mvh3Z+7Sjeu6v8XXsfI0XcOLdJ+ijhjh69Nza6QFlBs=;
        b=P1Zh6bGT4MCeaTbjPTpmj11/KDKrdr7y+RtaqruTfOzzo7AKjn2qx9k0rabAnDmZZe
         RcfPQ1VnmvRdE3wK4Lbm0YfF2/RBvlo/CLF+sZ4z9YtLsThzpbXQrUJ7fzuK+uQwzbHx
         dyJudYydsZpnbOjzykWpaMZpHoGGet9rGrvPdzgSDc2ZXafTES7ikWZ9blKhuT0ugTk7
         GP6Z8FsF1CNANeOhnUrncQoC8gGm1vsfD5mbJr0Oa7VCq1Kjojuj/qZUJG0bmmqroFrh
         5RWKjSEbXs8EIdbG8SWO5J7UkdvqSR9076vYsq1n+BSSqtjRW7ZzvDLrVZaaJQL/oKGS
         vJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mvh3Z+7Sjeu6v8XXsfI0XcOLdJ+ijhjh69Nza6QFlBs=;
        b=NJVeyxMhYxSKmw3jiUTfHX2ig4XbF7WdZ6vqq7evVBUnAnND1NCFV5vIFxWeu000bm
         dulDcTWCVcCXsc3hBTYIBcq1TN1Yp9GhkeuhAK2sMQjuzLN1BNzBB8CfNle33yIyctFb
         roG3dgXvimbwQdjFhQ9BKRCo+iTdkJIRUvBm5Fbd7I4ZOE93Z+0T1N49JJCoA5TcRGfq
         4TkLjKHQf9Lx9jrcmJqNJr6q4DwZfWaYOIQ9ytbl+0R4cBlI0t0Fcw0WzgwP33O2cXp7
         8CetgVYILYEGBwegnv7QPGCkwIUvqu7fE2aDQAD83PdjWfe3X2YS2ie2moASS1eTA8hE
         IixA==
X-Gm-Message-State: AJaThX7uSYp6rLjlM2BkHzFJxBEQZuVp9xMaTk/+Njpq978/MjaCsGNU
        RuSR+HGdka+y/RGXM1CDxUbyR4M/vZcdfH5njSJFWA==
X-Google-Smtp-Source: AGs4zMbf43MMIhaxkxBvMA2Yyr2LGYmoGz5rb3SDcXdALjEKYxyUtKSnDZdqmupYparPILspRaixKi6ImeCV5UMR0cw=
X-Received: by 10.55.129.70 with SMTP id c67mr2821441qkd.230.1510257422542;
 Thu, 09 Nov 2017 11:57:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 9 Nov 2017 11:57:01 -0800 (PST)
In-Reply-To: <xmqqbmkcjaxo.fsf@gitster.mtv.corp.google.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
 <20171109001007.11894-1-sbeller@google.com> <xmqqbmkcjaxo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Nov 2017 11:57:01 -0800
Message-ID: <CAGZ79kZL2_v5S5OJ_FnuZbHrKmPX9gXwoyX36G0br+5i87JQhw@mail.gmail.com>
Subject: Re: [RFD] Long term plan with submodule refs?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 8, 2017 at 9:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> The relationship is indeed currently useful, but if the long term plan
>>> is to strongly discourage detached submodule HEAD, then I would think
>>> that these patches are in the wrong direction. (If the long term plan is
>>> to end up supporting both detached and linked submodule HEAD, then these
>>> patches are fine, of course.) So I think that the plan referenced in
>>> Junio's email (that you linked above) still needs to be discussed.
>>
>> This email presents different approaches.
>>
>> Objective
>> =========
>> This document should summarize the current situation of Git submodules
>> and start a discussion of where it can be headed long term.
>> Show different ways in which submodule refs could evolve.
>>
>> Background
>> ==========
>> Submodules in Git are considered as an independet repository currently.
>> This is okay for current workflows, such as utilizing a library that is
>> rarely updated. Other workflows that require a tighter integration between
>> submodule and superproject are possible, but cumbersome as there is an
>> additional step that has to be performed, which is the update of the gitlink
>> pointer in the superproject.
>
> I do not think "rarely updaed" is an issue.
>
> The problem is that we may want to make it easier to use a
> superproject and its submodules as if the combined whole were a
> single project, which currently is not easy, primarily because
> submodules are separate entities with different set of branches that
> can be checked out independently from what branch the superproject
> is working on.

Well and this fact seems to be not a problem in the current use of submodules,
precisely because the workflow either (a) is not too cumbersome or (b)
is executed
not too often to bother enough.

> These are good starting points for copying such a combined whole to
> your local machine and start working on it.  The more interesting,
> important, and potentially difficult part is how the result of such
> work is shared back to where you started from.  "push --recursive"
> may be a simple phrase, but a sensible definition of how it should
> work won't be that simple.
...
>
> We should make detached HEAD safe against gc if it is not,
> regardless of the use of submodules.  I thought it already was made
> safe long time ago.

The detached HEAD itself is protected via its reflog (which is around
for say 2 weeks?)

If I were to develop using detached HEAD only in todays world of
submodules using different branches in the superproject, I run the risk
of loosing some commits in the submodule, as they are not the detached
HEAD all the time, but might even be loose tips.

This combined with the previous paragraph brings in another important
concern:
Some projects would have a very different history when used as a
submodule compared to when used as a stand alone project.
Other projects may be closely aligned between their branches and
what the superproject records.

So the more we deviate from the traditional branch model, the easier
we make it to have the submodule tips be very different from the
standalone tips, which may overexpose us to the gc issues as well as
the general question how much these projects have in common.

>> Use replicate refs in submodules
>> --------------------------------
>> This approach will replicate the superproject refs into the submodule
>> ref namespace, e.g. git-branch learns about --recurse-submodules, which
>> creates a branch of a given name in all submodules. These (topic) branches
>> should be kept in sync with the superproject
>>
>> Pros:
>>  * This seemed intuitive to Gerrit users
>>  * 'quick' to implement, most of the commands are already there,
>>    just git-branch is needed to have the workflows mentioned above complete.
>> Cons:
>>  * What does "git checkout -b A B" mean? (special case: B == HEAD)
>
> The command ran at which level?  In the superproject, or in a single
> submodule?

In the superproject, with --recurse-submodules, as the A and B would recurse
as strings, and not change meaning depending on the gitlink value.

>
>>    Is the branch name replicated as a string into the submodule operation,
>>    or do we dereference the superprojects gitlink and walk from there?
>
> If they are "kept in sync with the superproject", then there should
> be no difference between the two, so I do not see any room for
> wondering about that.

Except you can still break out by issuing commands in the submodule
to change the submodule refs to be different from the superproject.

This was also more along the lines of thinking about the (Gerrit) remote,
which does and okay, but not stellar job in keeping the remote branches
for superproject and submodule in sync. I'd expect glitches there.

> In other words, if there is need to worry
> about the differences between the above two, then it probably is
> fundamentally impossible to keep these in sync, and a design that
> assumes it is possible would have to expose glitches to the end-user
> experience.

yup. And by exposing you probably mean a patch series as presented?
(git status/log/diff making noise about the glitch?)

> I do not know if glitches resulting from there would be so severe to
> be show-stoppers, though.  It might be possible to paper them over.

I think so, too, as long as the user is pointed at the glitch to correct them.

>
>> No submodule refstore at all
>> ----------------------------
>> Use refs and commits in the superproject to stitch submodule changes
>> together. Disallow branches in the submodule. This is only restricted
>> to the working tree inside the superproject, such that the output of git-branch
>> changes depending whether the working tree is in- or outside the superproject
>> working tree.
>
> This would need enhancement for reachability code, but it feels the
> cleanest from the philosophical standpoint---if you want to treat a
> superproject and its submodules as if it were a single project,
> ability to check out a branch in a submodule that does not match
> that of the superproject would only get in the way of preserving the
> illusion of "single project"-ness.

I wonder if we can combine this with the approach Jonathan gave above.
In the worktree (of the submodule inside the superproject) you are allowed
to use these "mirrored" refs, whereas in any other worktree you have full
access to the normal refs of the project.

>
>> New type of symbolic refs
>> =========================
>> A symbolic ref can currently only point at a ref or another symbolic ref.
>> This proposal showcases different scenarios on how this could change in the
>> future.
>>
>> HEAD pointing at the superprojects index
>> ----------------------------------------
>
> This looks to me a mere implementation detail for a (part of)
> necessary component to realize the above "No submodule refstore".

Ah ok.

If all branches would use this new symref type, the handling would
seem to be very similar to what Jonathan described with a new type
of refstore instead.

>> Superproject operations spanning index and worktree
>>   E.g. git reset --mixed
>> As the submodules HEAD is defined in the index, we would reset it to the
>> version in the last commit. As --mixed promises to not touch the working tree,
>> the submodules worktree would not be touched. git reset --mixed in the
>> superproject is the same as --soft in the submodule.
>
> I am not sure if you want to take these promises low-level "single
> repository" plumbing operations make too literally.  "reset --mixed"
> may promise not to touch the working tree, but it also promises not
> to touch submodules at all.  If you are breaking the latter anyway,
> it would make more sense not to be afraid of breaking the former if
> it makes sense in the context of allowing the command to do more by
> breaking the latter.

ok.

Thanks,
Stefan
