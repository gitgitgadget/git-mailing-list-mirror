Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CAEC19F2D
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiHNCF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 22:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiHNCF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 22:05:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3518347
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 19:05:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qn6so8052009ejc.11
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 19:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1JCG5TtOsvZHzfgJNC4H4l4Y7xuvs+vhuqpMrvcUUWM=;
        b=fP8f8wWa9ffp2j9aY6/Reg7OT6csuiLuncztdLzYL10MpiZDm3jCDzok7J4usOBb/m
         Xo9BisXPETdf14e0PnK9mWW4e0vfTK3Z0hJuQeffc9goUs8FOoY4bK2aP05MKJ8kMpRw
         YKEN9DtG3SpGnFRCh/QMrBfdZ8eL8E+U70LEuXwXP+05l+oi7m9Zl39uK8kFAokCRptb
         HO03N4z8P5KVUoO7CPyctbP58+1+AEtvhUPgEJqb2DGxcCzMj9xUwmWPfox1RrZaPIfP
         wzBx6x9DFZkoHIe0ltypt125/7ot2zGkvGvY0bq003HNKGkSc9TjQKDUR4niLwZ33CFz
         8WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1JCG5TtOsvZHzfgJNC4H4l4Y7xuvs+vhuqpMrvcUUWM=;
        b=FlMiwREElPyhPP5H7hxubFGcFHe5qVipS1/9UgOz7pQPA/d4BizR35XekqVk4O8eGf
         2yxXt5ObxNrVSPWt3IMIv2OmtGmlJn9QoMurjvM7ppxh2vapRsCBJK+KOsit0DTDCN1m
         01g+ZtVZDuqLv6idrseVZMlvTaMdmRKUat6oJHBD6om+YNOOKwpk/5C7Wk/9R63Vqns+
         783mNYmJpFPcGAeL1f6i3zYVLvCXGeTFPMkYJF4Qd9QYILlguJgyjQWfsNSLNDWHO3sl
         SVRSJVTIABpYeoi+d+GAN+KaiWYMZARxgIPDebkbjDzkJCuvv9xhooGfJBR9WWyaihzd
         gaZA==
X-Gm-Message-State: ACgBeo0n/2UEmYfAtGdOBAgOf5e/hw2b5rcAAuqjoyZX0Ovum9eSigcP
        xVGshT2/Wn5WeOxg9CkUHpGTSy1Hw40i+HKJDD8=
X-Google-Smtp-Source: AA6agR6wL4A303gPD39GOfRb7B2oYC9o/0TVbTMnABlt3r7Lq7b26afg8FHFPk9L9xzua/iPw0nG7e/ebFfreQHKkk8=
X-Received: by 2002:a17:906:93e8:b0:730:9e5c:b45a with SMTP id
 yl8-20020a17090693e800b007309e5cb45amr6396914ejb.530.1660442753567; Sat, 13
 Aug 2022 19:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com> <CAMP44s2A7nJDVRPbixPPPtTedg_Q53CEdw+sBpGZwOfQG4EZSg@mail.gmail.com>
 <0dddb367-ebf9-930f-1b9c-000a532774d3@iee.email>
In-Reply-To: <0dddb367-ebf9-930f-1b9c-000a532774d3@iee.email>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 13 Aug 2022 21:05:42 -0500
Message-ID: <CAMP44s1XOyMgX+4hHzNXpUmJ0DURn93=B9dH0pBm5Fk5YRfdvg@mail.gmail.com>
Subject: Re: "master" term - no one cares
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Ryan <rmrmail@gmx.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2022 at 11:55 AM Philip Oakley <philipoakley@iee.email> wrote:
> On 13/08/2022 04:15, Felipe Contreras wrote:

> > This is not a Git issue, this is a Git for Windows[1] issue: they are
> > the ones exposing that message to their users at installation time.
> >
> Thanks for the comment. The wider point is to ensure that everyone can
> choose their own name for their primary line of development (plod), no
> matter how fast or slow they plod along.

Everyone can choose their own name without being asked. All software
has dozens if not hundreds of default configurations that the user is
not forced to choose at installation time. When I type "bash" I'm not
asked what kind of prompt I would like, that would be annoying. I can
choose to change my bash prompt any time I want, or I could choose to
keep using the default.

We don't ask users what name they would like for the remote every time
they clone a repository, we use "origin", and that's fine. The user
can choose a different origin with --origin, or just use the default.

Being forced to make an *unnecessary* choice is just annoying, but we
all know why the Git for Windows project is annoying their users and
it has nothing to do with technical aspects and everything to do with
*personal* politics.

> There is a confusion between the use of the term that refers to the
> *personal* mastery of a _craft_ or _artisan_ technique and, at least one
> of, the historical choices for the usage of the term 'master', which was
> a direct reference to slave servitude. That was for the use of
> electrical circuits which would detect the 'tick' of a primary timing
> pendulum and then have all the actual clock faces that indicated the
> time be _driven_ from that 'master'.

This may be the reason why some people used that name in the past, but
it's not the reason I use it.

For me if I was cloned there wouldn't be two equally valid versions of
me, *I* am the original one, I am the "master" copy. This doesn't
change if my clone is cloned in turn.

This is exactly how master branches in git are used. I have a master
branch of git.git, but it's not *the* master branch. *The* master
branch is the branch from which all the other branches came from,
including "maint" and "next", and all the dozens of branches in
thousands of other repositories. If the word "master" makes it sound
more important than all the other branches in all the other
repositories, it's because it is.

Regardless of what name people use and for what reason, the reality is
that "master" is still very widely used, despite of the campaign
against it which was clearly driven by ideological reasons. And it's
also a reality that the world is not going to end if users are not
being forced to pick that one controversial configuration at
installation time.

Cheers.

-- 
Felipe Contreras
