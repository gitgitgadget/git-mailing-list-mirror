Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F81EC636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 16:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjBTQrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 11:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjBTQrl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 11:47:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA01206AF
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:47:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id bh1so2136110plb.11
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Uf3W9qq+yHqyAGFuA6Ntx0PHExt4RDiwjg3boXF6Ak=;
        b=LXwy6uPhgCitmJ7H4mvza/4OatkDj0baWC4khBXvWel7KFsyCVOk73xmuGkzVXfzNf
         M+aeQzBEuLG/j55YbBs48JHRRmruFr3xIEL0jbHAXrS048X3CugWZXQy2Wz01VJFYgm0
         gni4T8bevRmtz3fGNLkmUg2utt1BaEQEFnY2Kk5p4pzEIpoy7SKNUViPBdxIv4DesAt7
         PQ7h0h/0Vaw0BVZc92XBNrZ/d8rj9yiW5RiZ4V/2HOXS93tEtaoL0783pJ54CQ0/SVh+
         3FFEcRgPRrGo7j4JB2TzYYdZJ0kPi1yjHb0iQlUM1Pb/5Z+o/qZnL1UvlsemRdrzpbrD
         eJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Uf3W9qq+yHqyAGFuA6Ntx0PHExt4RDiwjg3boXF6Ak=;
        b=aBMwSs0lAhUBC6RDG1xexzcHAsuNYmn7UIf1a7q6P0zlaWYRwv7ESTPuMG8LeVKu/m
         qLBM1Ce7OtxMgPhGcrH0tteNao1lES553vex2DyelF3MZpdJ4SmZr8jql+VwXRnRDNpt
         /Ui8v37jpyQHv3BbddY7tUSlCGYaymdnZotcfNNncrK5OmJN6I3r/4mgYURVjr3HSRJ4
         flaIMZrmJxIk4dIWiDY0eaP4egiynG9FTx1YM/ZWSfRJLZlSTK/Yy3HWBMMcUhaxKENY
         MAF9mwWegGhRa6mdLp/UVybIfTZ36A8QVtH0m5ZrqG/Hk0e1XrYp0pK4zzfwx1h/w46+
         D2+w==
X-Gm-Message-State: AO0yUKXfAZC/hgP8KTmUeMNseOEKisAaSOvLndrEUYdyCQz/yZo5nfuG
        W26c6flaMWI36u/Hin1j20ELlEML+inro3WuZeo=
X-Google-Smtp-Source: AK7set/CRJONnDWkl4P2/sDRF1/1VTPYDCyi1Xcie2eBm5ucEA18sn2oUX1RdWURvgyrvqPd9CoZBzUflWL/lRkk2qw=
X-Received: by 2002:a17:90b:3ecd:b0:231:2896:597b with SMTP id
 rm13-20020a17090b3ecd00b002312896597bmr705971pjb.89.1676911607163; Mon, 20
 Feb 2023 08:46:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com> <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
In-Reply-To: <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Feb 2023 08:46:32 -0800
Message-ID: <CABPp-BEAqP7maTVw82Qr8mn-sxPzXmHnE_mTKf2pg6hVYAJSUw@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sat, Feb 18, 2023 at 8:39 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 18/02/2023 03:17, Elijah Newren wrote:
> >
> > One concern I have is that "--rebase-merges" itself has negative user
> > surprises in store.  In particular, "--rebase-merges", despite its
> > name, does not rebase merges.  It uses the existing author & commit
> > message info, but otherwise just discards the existing merge and
> > creates a new one.  Any information it contained about fixing
> > conflicts, or making adjustments to make the two branches work
> > together, is summarily and silently discarded.
>
> That's a good point. Another potentially surprising behavior is that
> when I'm rebasing an integration branch with -rno-rebase-cousins then if
> one of the topic branches merged into the integration branch happens to
> share the same base as the integration branch itself the topic branch
> gets rebased as well. -rno-rebase-cousins is also slower that it needs
> to be because it creates a todo list that contains all the commits on
> the topic branches merged into the integration branch rather than just
> the merges. The commits on the topic branches are fast-forwarded rather
> than rewritten so long as they don't share the same base as the
> integration branch but it noticeably slower than using a todo list with
> just the merge commands.

Yeah, modifying rebase to accept a general range expression (instead
of assuming upstream..HEAD) would really help.  Then, to get just the
parts you are interested in, you could use a range with extra commit
exclusions and additional qualifiers like --ancestry-path=<commit> and
--first-parent.  In fact, you could also list multiple branches (none
of which necessarily fully contains any of the others) to replay
multiple branches at a time.  (See [2] for where I discuss this
more, though focusing on the --ancestry-path=<commit> part of it.).

But, it'd also fundamentally break existing workflows, so it might
have to be a new command, perhaps `git replay`.  However, there's
multiple other improvements needed in rebase (such as not wasting time
updating the working tree or index or reflog for every commit, or
wasting time writing N control files when we could move to 1 control
file, and allowing working on branches that aren't checked out) that I
think would likely also break compatibility, so maybe another command
is a good idea anyway[3].

[2] https://lore.kernel.org/git/CABPp-BHmj+QCBFDrH77iNfEU41V=UDu7nhBYkAbCsbXhshJzzw@mail.gmail.com/
[3] https://github.com/newren/git/blob/e84f5f3585fd770ed21f398d2ae5f96e90a51b1e/replay-design-notes.txt

> > My personal opinion would be adding such a capability should be step
> > 2.5 in your list, though I suspect that would make Tao unhappy (it's a
> > non-trivial amount of work, unlike the other steps in your list).
>
> I've got a couple of patches[1] that cherry-pick the merge if only one
> of the parents has changed. I've never tried upstreaming them as it is
> only a partial solution to the problem of rebasing merges but that
> approach should work well with "git pull --rebase=merges" as only the
> upstream side will have changed (when rebasing my git integration branch
> with that patch the merges are cherry-picked). They might make a useful
> starting point if anyone wants to try and improve the rebasing of merges.

I've actually put quite a bit of time into this problem.  I have
outlined what I think is a full solution to the rebasing of merges
problem space at [4], which expands on my earlier discussion with
Johannes on-list over at [5] (which in turn was a follow-up to
previous discussions that you, Johannes, and several others had years
ago).  If you're interested and have any thoughts on my plans for this
problem space, I'd love to hear it.  You tend to have very strong
insights on everything xdiff, sequencer, and rebasing related.  My
"replay" branch contains a partial implementation, but it's not really
usable for anything rebase-merges-related yet, so you'd mostly have to
go with my writeups.

A warning, though, that I won't be able to respond to feedback on this
topic very soon.  I will definitely get back to working on it, but
it's been much more challenging with more limited git time these days.
Unfortunately, the current economic environment reduces the number of
ways possible to extend the amount of time available for working on
Git, but one way or another I'll eventually get back to this problem
and implement my ideas, unless someone beats me to it.

[4] https://github.com/newren/git/blob/e84f5f3585fd770ed21f398d2ae5f96e90a51b1e/replay-design-notes.txt#L264-L341
[5] https://lore.kernel.org/git/CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com/
