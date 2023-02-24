Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E8C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjBXX7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBXX7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:59:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653571ADE5
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:59:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f18so1273127lfa.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WpWKUIx2bAQKuDPbdZKOInIMpU4UcdfauJ/wI4BGSoM=;
        b=jKvBafQFOJTnXQcLkFoJwXM09pq5kCoHzlHMIA7V2BqeuXqZHXS0pVyk3NEwouVheN
         ypca5lKxwGpVPeaZSJCF3TfvO8CVkbcmLi4TMPyncIzNh6vGiaBW079RHFlBxVOGYd6T
         xHa9GQu4XnLK1vjWD3UgLmxTAfZPtetSI01wctCOX0NHNEWgJSa6LvxiwEVJzMDKkAM/
         0PMRtnwaR10O8dXa+coHU6g2jAUbLvvwIWLzK2tT/pVNNLkqv1LdfYI3OrJAVz7bhoas
         MWmc8rTi9CqbkN5Z+jz4WLqS1vIpCvsFGnaSKqT2oDp7IGdf/6x+jpjqB6+WOJOOLgOr
         jlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpWKUIx2bAQKuDPbdZKOInIMpU4UcdfauJ/wI4BGSoM=;
        b=1Hj5wEEP7LlzK+JUGLAwPHMxkHQ/C7zL2OviYHuJZNW2iqw4zfadOoT5BqaC1e0VGb
         m35t4YdHRh/1dok/Lz1W1jRziZ3E4YfRPbTyg5A8JOjixHvwUJpksFAG7TVzzeLJY+8a
         nGSbSUDxIyeqWrLrmR6cXm7PNQ8YNtLk19duTE4yADbSQjsp9ymhzlczraWyaTTP9786
         stFMyVD6/iUN5K55n5fdcTUSZ5vvH7+FPlDUTwD5wHM6RdYa+Zzyky4ssaQch+zp9PtY
         z1lvmxIqrWGORUBpruwrVjcd/T/YX+cqsTqNRHq+m6hznrOjwwEd6cK11tB4lch5FlKu
         HCUw==
X-Gm-Message-State: AO0yUKVzWf1gp19lf1ck4tSQyXO4UruTMPlOZEBY8U9eayYvXDtFXqLz
        Sly+gLXMjfOkIkVn4vui7a56wYKzqfOZjHtwD7OltJQQmtsY8Q==
X-Google-Smtp-Source: AK7set/U+tmS+gWDkosC+ZZXe12dYWIHBWyvaSrbW5GFHtPRLl7cTbyKmM3IvlDtI1vAq3kVcD+Ievyt02M+q2dCu8g=
X-Received: by 2002:a19:ee14:0:b0:4d8:50e1:8ba7 with SMTP id
 g20-20020a19ee14000000b004d850e18ba7mr5213528lfb.2.1677283188443; Fri, 24 Feb
 2023 15:59:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
 <87a615vkqk.fsf@osv.gnss.ru> <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
 <87bklilnvp.fsf@osv.gnss.ru>
In-Reply-To: <87bklilnvp.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 24 Feb 2023 15:59:36 -0800
Message-ID: <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Feb 22, 2023 at 6:27 AM Sergey Organov <sorganov@gmail.com> wrote:

> >> I also agree (in particular with Buga) that from the POV of user
> >> experience the method suggested by Phillip should be superior.
> >> [...]
> >> Even this would be a huge step forward compared to silent
> >> drop of merge commits and blindly re-merging of updated parents.
> >
> > I'm not so sure it's a huge step forward.  Or even a step forward.
>
> Git currently throws away my precious merges! Silently! How it's not a
> step forward to stop doing this?! Sorry for getting that heated :)

I totally agree with you that we have a big problem.  No need to
convince me on that.  :-)

But having a big problem does not imply we have to implement and ship
the first proposal that comes along to change things.  Or second, or
third.  Such proposals might actually make things even worse.  You
correctly point out that we do not need to require perfection, but we
can and should require that the proposed solutions not only make some
things better but that they make things better overall.

And in order to convincingly persuade others to adopt various
proposals, we should be aware of what the advantages and shortcomings
are...at least the ones that have already been discovered and
publicized, and be able to talk about those shortcomings candidly.

> As for Dscho results specifically, I've got an impression that he never
> needed rebasing of merges in the first place, and re-merging always
> suited him just fine, so it'd be rather a surprise if rebasing of merges
> suddenly started to work better for his needs and workflows once he has
> implemented it.

Are you serious?

You're claiming the author of --preserve-merges; and the author of
--rebase-merges; and someone who actually implemented the ideas you,
Buga, and Phillip were all discussing to improve rebasing of
merges[1]; and who maintains a project (Git for Windows) that has
countless branches with hundreds of commits and myriad merge points
and needs to rebase the whole lot as Git is updated...is someone who
doesn't actually care about rebasing of merges?

I thought you had tried to read up on this subject and were commenting
in good faith, but I'm starting to have my doubts.

Please, go read at least [1] to see Johannes comments about how the
prior proposals don't work beyond simple cases.  He didn't discard
those ideas because he didn't care about the useful information in
merge commits, he discarded them because in practice those ideas
resulted in behavior that was *even worse* than the current big
problems.

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1804130002090.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/

[...]
> for now I do believe we need something
> reliable that has been checked to actually work for common cases, as
> blind re-merging simply does not.

I agree with you.  The word "reliable" is particularly key, and IMO
rules out any suggestion that involves applying the diff between a
merge commit and either of its parents.  Not only do I think it's the
wrong solution theoretically, I also think they have empirically been
shown to provide problems that many will consider to be as bad or
worse than our current poison.  I obviously don't have veto power or
anything close to it, but in my opinion any solution based on those
ideas do not meet the threshold bar for inclusion in Git and I'll
raise my voice against them.

Solutions based on other ideas are fair game.  Heck, I've proposed one
and I know of simpler variants to my proposal.  Other solutions may
exist too.  But can we stop pushing already discredited proposals and
instead reach for something that has a more solid foundation?
