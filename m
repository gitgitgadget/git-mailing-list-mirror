Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945D41F453
	for <e@80x24.org>; Thu,  1 Nov 2018 01:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeKAKUo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 06:20:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAKUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 06:20:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so759600wmg.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hH7sr939c2BIHJM8Up7S05LoKA/qNo5hek9qm101++Q=;
        b=TpF+6ZR2UayD3if0drRjADS7Z8kBA+B14UlX0056GXHVuiOSTU0gVShBFiZp/1IM6p
         b2cxCHVlNCdmMyo2dLcwYdELizrOtivD+3s1FuIPmFv7qN11m21MdUhWDUhP1tPLUSc+
         AG5tDocFb4nQ6UZLl93n6qs6R/Clge/ohdTUN/t8rHiXPC8hvynVOuFzXD59e7NNkJ7y
         4YLq3dLelS4gLGQ9VUSoFDOBTGC1NZdrVRmqE0ks50bw64al8KGsCbou669D6oP2XVGL
         8Dd4zJn9E1Ub9AFxQq8jMp9BPZ/IYou8z5UO++ufCmp9C63Hi50W+/By6Fn2H13iSaV2
         IaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hH7sr939c2BIHJM8Up7S05LoKA/qNo5hek9qm101++Q=;
        b=YLB8jYeYo/lXzhUxsokX7byEJl7A8rHanzOZiv6udjV4eFHaLfKJOwYiRM5vRPJdWo
         0a7tezRW8JDO4HfBSJgxEem9hPUlq0y5Hlx+7zov30i8hegofsNYd9afJjjKQaP/huY5
         6wFQwIysejSR7AWl+l31NXHNW8QsL5c+zk2TE1A+wfd5P9iDVfY78t/RS61kQ87UCcgu
         zQZUbSoPKzkN4ub/j7Iw1rMiwd4bI/7hHUmrte03Sf6720B1mpiqc5Dk1OkNsichqth1
         yjJQNjymnw+u9YBBl5q21g+oVBYGu1Fst/5X2Z4k90pGJS5LQ3EVPyhyRiYbAO6A1TiO
         JnOA==
X-Gm-Message-State: AGRZ1gLB+pR4YurtDCqGy9SPTj0oqHRAk0k80bE3a/MWnfqq3IvCMA3n
        EaSC27l7Hry9OwiyPZTQyE0=
X-Google-Smtp-Source: AJdET5exaDlWxcji7znZGq+LBXskGpoGJ5i87gOSGRZYvEywqkRYr2Jiz6yGaiyJSToFz/ozQ1P7+g==
X-Received: by 2002:a1c:7e57:: with SMTP id z84-v6mr4313083wmc.43.1541035198850;
        Wed, 31 Oct 2018 18:19:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x18-v6sm480389wrs.50.2018.10.31.18.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 18:19:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: using --force-with-lease after git rebase
References: <CA+KyZp5Zv77idtpu9jtxDUyE9zPP8UN3LsQBG=M5yM2cnMFgVQ@mail.gmail.com>
Date:   Thu, 01 Nov 2018 10:19:55 +0900
In-Reply-To: <CA+KyZp5Zv77idtpu9jtxDUyE9zPP8UN3LsQBG=M5yM2cnMFgVQ@mail.gmail.com>
        (Alexander Mills's message of "Wed, 31 Oct 2018 12:13:06 -0700")
Message-ID: <xmqqr2g5vbk4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Mills <alexander.d.mills@gmail.com> writes:

> I have been confused about the need for --force-with-lease after rebasing
>
> Imagine I have a feature branch:
>
> git checkout --no-track -b 'feature' 'origin/dev'
> git push -u origin feature
>
> I do some work, and then I rebase against origin/dev to keep up to
> date with the integration branch.
>
> git fetch origin/dev
> git rebase origin/dev
>
> then I try to push to the remote
>
> git push origin feature
>
> but that is rejected, I have to do:

This all depends on how the "dev" branch at the "origin" remote
relate to the branch at "origin" you are updating with the commit at
the tip of the "feature" branch.  Are you pushing to "feature" branch?

If so, then the rejection is very much expected.  At this point, the
histories of the "feature" branch at the "origin" remote is seeing
would look like this:

    ---X---o---o---o---o---A
        \
         x---x---x---x---B

where (X) is where you started the old iteration of the "feature"
branch forking off of the "dev" branch, (A) is the tip of that old
iteration of the "feature" branch, and (B) is the tip of the new
itertion of the "feature" branch you are trying to update with.

The "origin" repository does not know WHY B is not a fast-forward of
A.  The only thing it knows is that you are discarding the work done
in commits (o) while attempting to publish commits (x).  If it is
intentional, then that's fine, but it does not know (x) are
replacements for (o) due to rebasing, so it errs on the side of the
caution.

With the "--force-with-lease=feature:A" option, you can tell the
other side: "it is OK if this push does not fast-forward, as long as
I am updating from A" [*1*].

"--fore-with-lease" without saying what the commit you are expecting
to discard makes Git on the sending side _guess_.  Depending on what
you do locally, it can make a wrong guess, so I would not recommend
such a use, but if you saw it succeed and if you did not lose
commits at the "origin", then it may have guessed correctly ;-)


[Footnote]

*1* Telling what the value of 'A' is to the other side is important,
 as you are essentially saying that 'B' has everything you want to
 resurrect from 'A'.  Imagine that somebody else pushed to update
 "feature" at the "origin" remote from 'A' to 'C' (or if you did so
 and forgot about it) and then you tried to push 'B' after rebasing.

                             C
                            /
    ---X---o---o---o---o---A
        \
         x---x---x---x---B

 As far as you (who rebased) were concerned, 'B' is equivalent to
 (or "an improved version of") 'A' and you want the push that does
 not fast-forward to go through to replace 'A' with 'B'.  By telling
 "I am replacing A with B" (instead of saying "I am replacing
 whatever with B", which is what "--force" is), the receiving side
 at the "origin" repository can notice that there was another update
 by somebody else's push to the branch while you are preparing 'B'
 and the tip of "feature" is no longer at 'A', and reject the push
 in order to prevent you from losing the work between 'A' and 'C'.
