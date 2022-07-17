Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17372C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiGQQ6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiGQQ6U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 12:58:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2DD13FA9
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:58:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 125so7652029iou.6
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xt8lSG6u5UlSS/gFm9B2chXAGH89HeiiYNHnV/cOpKI=;
        b=OPqT/WU7mvfZKKMoAXf2VEEO9jm4h9L/XKNFTrwH3xIpYBb3twqnssXVx/CEO4NklM
         B5c0jHBnsBytlEH76h+7F0xPhb6VfugQ2SHBmxY4yuiQJgsuQ8jsmtLr9JtLow0XJkf5
         FqlGiMFocJAsh8UqK+yljK5iEq8gWtTk1AvccTA+K/AVVRa5nL+TuIenpmvGfzuDH+Sy
         HWGNjCH+8PwSxaSYUWZzI/jDHeYZjwdI5uKN03bQHSAMAt5S4TN0xzZYS7nlYE3tqJgD
         NsxXSmlwnIfXpLxMB38Tkczd4IlQsGeb1Dd+LMvOlh/+XBZylvDq4jrG0vCa7iRFyAt4
         ZSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xt8lSG6u5UlSS/gFm9B2chXAGH89HeiiYNHnV/cOpKI=;
        b=UjQiz0kV9eHSDb/Lsc6iSB01A7NUAj3pid1AVNX2FhPCfWu2CXI/YraUtZtLqYut8f
         drLR6mlTf7GDz/0VIVZhwuU5ut6tHGZHwsfFwL5alweZ3RmW45Od2MtxrYZyti6vbQEP
         74J/1aO+mh3pbHxB5v7s5h4//AHzVUuf/hqfbK/w0jb8ghE23zdZ4NRN8o2CYIT580dM
         PKtQ2VTZdPUfrmjumU0lpg6wgU2w5zj1LO7ZrRgZnsg3B6xu91EZ7/nz+vWvnUqb41Ls
         GWI0at8OGjvtn54ElMfwsawgKbuUoIAC8+sAlmuuKVbdrY+4Qj1T2SXHNctj+m7LeEib
         JjPQ==
X-Gm-Message-State: AJIora/ra1B+a727ATsD8Z++3xWVZhkt6NYL7t8snfAwyxX1Wd1EFDq8
        q8lwSxm3NN75CtoVhqjjH1+HmGNA1sSvf4Ve5Ds=
X-Google-Smtp-Source: AGRyM1sUObODtWLdLJyhxD71aP1HFCSgppjfbL5fnygjDKm+aEh5e8e9PHXTQEjaPqlH1U5ENU3pqGXQW8PReZjyqz0=
X-Received: by 2002:a6b:f302:0:b0:67b:e1c3:7cb5 with SMTP id
 m2-20020a6bf302000000b0067be1c37cb5mr5602702ioh.206.1658077099390; Sun, 17
 Jul 2022 09:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7d4g8onl.fsf@gitster.g> <CABPp-BFzehrH19zRSbLBB42nEs50_UCcfV2B22ZJFYtPCX=Zsw@mail.gmail.com>
In-Reply-To: <CABPp-BFzehrH19zRSbLBB42nEs50_UCcfV2B22ZJFYtPCX=Zsw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 18 Jul 2022 00:58:08 +0800
Message-ID: <CAOLTT8R3y4m_ZSuT198_7X16mCu+BtbuMi5756PKs+fAzxpd8A@mail.gmail.com>
Subject: Re: en/merge-restore-to-pristine (Was: Re: What's cooking in git.git
 (Jul 2022, #04; Wed, 13))
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8817=E6=97=
=A5=E5=91=A8=E6=97=A5 11:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> On Wed, Jul 13, 2022 at 7:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > * en/merge-restore-to-pristine (2022-06-21) 6 commits
> >  - merge: do not exit restore_state() prematurely
> >  - merge: ensure we can actually restore pre-merge state
> >  - merge: make restore_state() restore staged state too
> >  - merge: fix save_state() to work when there are racy-dirty files
> >  - merge: remove unused variable
> >  - t6424: make sure a failed merge preserves local changes
> >
> >  When "git merge" finds that it cannot perform a merge, it should
> >  restore the working tree to the state before the command was
> >  initiated, but in some corner cases it didn't.
> >
> >  Needs review.
> >  source: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
>
> Looks like other reviewers aren't stepping forward (this has been in
> "Needs review" for the last 6 "What's cooking" reports), which may
> suggest others aren't as interested in this fix.  Since this was for
> an issue you reported, and which you even volunteered to help
> shepherd[1], perhaps you could step forward as a reviewer even if
> you're not that familiar with the code?  Some things to look at and
> report on:
>

Sorry that I missed patch update before. And this is my first time
as a reviewer. I may leak some experience :)

>   * Does it fix the issue?  (You reported that v1 did, again at [1],
> but perhaps you could retest for v2?)

Yes, I have checked the test, it is good enough to solve my problem.

>   * Does it appear I've addressed the issues Junio brought up about v1?

Yes, Junio said restore_state() will not be called correctly because
we are using
only one merge strategy, which has been solved by the patch: "merge:
ensure we can
actually restore pre-merge state".

>   * Even if you can't analyze the changes deeply, you can respond to
> my patches with a "walk through" where you try to explain what the
> different hunks of the patches are doing in your own words.  Even
> folks unfamiliar with code areas can sometimes catch simple mistakes
> that way, and even if you catch nothing, it means there's another
> person more familiar with that code area.
>

I have checked(walk through) them carefully. Look at them :)

> I've had a little more time lately, so if you or someone does catch
> something in the review, I can try to update the series.
>
> [1] https://lore.kernel.org/git/CAOLTT8RpGGioOyaMw5tkeWXmHpOaBW9UH8JghUvB=
RQ50ZcDdYQ@mail.gmail.com/

Thanks

ZheNing Hu
