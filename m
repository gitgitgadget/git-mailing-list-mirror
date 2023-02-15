Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F70FC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 00:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBOAEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBOAEl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 19:04:41 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E8A5CA
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:04:40 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso399035pjf.4
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFUbHZtkbpM0QSZ1C/aSOnwKgsqwsJFzTohFH6DAvMU=;
        b=DE6VW4MDQ2wech9JX+BN7rXw8t1pV7PCkmJHYna6NUCzZ9hzQatNyzGrD+LUfLi8Qk
         v/+GvplK3KtcydSHozubSZncTb+zTtOnVZHEaJoh7iqZdf3H5v3L0ub+34hq+75yC/C8
         soSWWR+yzWUzmJAsEJrFL9IsoNH0zwpYqAcET5NTIUj62cTEDmRl0eFVoLvFRKdSZIt8
         8nHgFMEbdliHSL0BrvbBc3noFv/LkWckCF2gKtnGelNdYUhHnpkaP7/DrVcaPrpvlSvL
         vyZ2yZSgn99YzaPzdzmkBn5cwJSwR3jx2hqEXd2kB31HQJY54gZnGsLyLltCR7FTV0cN
         6hNw==
X-Gm-Message-State: AO0yUKVEfNNUiOP+q9/vJKdDHTjyheOy7GLrru39hvnYci22nsgei01z
        IxyI5w9EGzWUYdmUBPQ7zoyzT8JZ8qEq9RxRGgI=
X-Google-Smtp-Source: AK7set8ApW3rlJsWuXiXxQJl5z+ZE2ABUSF5Chhe3cAQOitAEYbNwRUH4ieo7mcbTCbOBowKKTmHfPIex6K9lHXz6Eg=
X-Received: by 2002:a17:90a:4107:b0:234:190f:87e6 with SMTP id
 u7-20020a17090a410700b00234190f87e6mr291056pjf.8.1676419480180; Tue, 14 Feb
 2023 16:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20230210171338.81906-1-vinayakdev.sci@gmail.com>
 <xmqq8rh5gox7.fsf@gitster.g> <CADE8NaqvP1JbLL89prOCu2Qo-ZVJTTN_CZjk7bJwzMctV9Z2Bw@mail.gmail.com>
In-Reply-To: <CADE8NaqvP1JbLL89prOCu2Qo-ZVJTTN_CZjk7bJwzMctV9Z2Bw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 19:04:28 -0500
Message-ID: <CAPig+cT98gscoD=Fh-QzJxruxdZmjGKW3gy95cA3xAokV7J4rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] {apply,alias}: convert pre-processor macros to enums
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 11:00 PM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> On Sat, 11 Feb 2023 at 03:31, Junio C Hamano <gitster@pobox.com> wrote:
> > Vinayak Dev <vinayakdev.sci@gmail.com> writes:
> > > Revert changes to alias.c, and change variable types in apply.c
> >
> > When you send out a rerolled series, you do not have to show your
> > past mistakes.  This [v2] is structured as a three patch series
> > whose first one makes a similar mess as what [v1] did, the second
> > one and the third one then revert some parts of that earlier mess.
> >
> > That is not what you want to show your reviewers, and more
> > importantly, that is not what we want to record in our history.
> > Rerolling a series is your chance to pretend that you are much
> > better programmer than you who wrote the [v1] patch.  The review
> > exchange is to help you do that.  Please take advantage of that.
> >
> > You may find "git rebase -i" is a useful tool to help you pretend
> > that you got to the ideal end result without these "I tried this
> > first, which was wrong in these points, which I correct in a
> > subsequent step" steps.
>
> OK, I will keep that in mind before sending subsequent patches.
> Should I re-send [v2] after making corrections for this mistake?
> That would make the corrections more obvious and the mistakes less.

You should send a v3 which completely replaces v1 and v2.

To prepare v3, use the "squash" (or "fixup") command of `git rebase
-i` to squash all three patches from v2 into a single patch, so that
v3 consists of just one patch. The squashed patch should contain only
changes to "apply.c"; specifically, changing #define to `enum`, and
changing the variable declarations from `int` to `enum`.

You can also update the commit message of the squashed patch so that
it explains the reason for the patch: specifically, the debugger will
display the values symbolically rather than as mere numbers.

Finally, proofread the commit message and the patch itself, and resubmit as v3.
