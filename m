Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C33F20248
	for <e@80x24.org>; Tue, 12 Mar 2019 11:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCLL6s (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 07:58:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46619 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfCLL6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 07:58:48 -0400
Received: by mail-io1-f65.google.com with SMTP id k21so1769573ior.13
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 04:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GcQD3XZfkerAPlWPW1UvBR7YRUFWBPyIOpISPFXmdms=;
        b=UuWro+ptoAAMg0DR0e+EL7IZKPZTDZYQkN7kij+0A8BV2Wp4sY7O7EATyfSU7pYqF6
         1PYc9omfa28ITOhqtwhX7QKyzwTkl4S4VSbSS1neh9qsVmWE3IytowEAcwA9e/z2qzeC
         TpiJZqSTjXjEQGdZnv4EnCqO/eJh1Zq+PCDZtI+3ZfYKT6wOf+8TZ4mpOF6vClzkqNsx
         t7E60mCY7fc28mn68HpfKiP5QJkMUnC9OoSgglw5LOjdtIQm2WfE2P3DFrHE9xpEKSd5
         EJxE1CpLQq2bt5tTcwiARZFcqqgm01BiiTEGdZoZzlV5O9pPqZ4dF8S861lLrqudGT63
         V2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GcQD3XZfkerAPlWPW1UvBR7YRUFWBPyIOpISPFXmdms=;
        b=e5cSRNc40/EQ8eZCskX0FvkOuSyS0e1oMBPVn/34Ny1aonRd/Omzsr2yjM1x/iO1iG
         /BOLa3BVaSH2xarK8HmAs5CvR32Rdf20R+tSSIPsKYNm1jHO9XpDFFNbYiwg8/GyU/t2
         aqga1xPOqT8ryLyeB3WyfgKsfHbyF+o7ePv1tG6NuK/YRQwON4r4LlJyFiiPn8mfYISs
         6Tl0YwUexzsxd2LAraFqJX1CdR6dAPDr1L56jqAvYo6pq1Xiy5IKHp4ij0k4OXf4afIw
         vTOrrCsWb4NbM0CTGtbx6sirUYqPcw2usdhKLi+p0sJ/3YKEAk8Em7Ez1LEJhwf/FpiG
         zD+A==
X-Gm-Message-State: APjAAAX4kHiso8JlPNSCc3qlQ17K8cg8C2dbzBOm3Ew1NopJto39boiS
        LgRLGK9v0IyTWWockaeK/mcFngJiGoYRc5m/yFo=
X-Google-Smtp-Source: APXvYqy7sfO1gN75Ax4AmjdIOdPu5J/sBeemei6px2IVfkTwboaaziGhPrClSppLFcT8j437NNv853FMDGAobPymrjg=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr4850762iom.118.1552391927497;
 Tue, 12 Mar 2019 04:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com> <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
In-Reply-To: <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Mar 2019 18:58:21 +0700
Message-ID: <CACsJy8Ax0nt1zt9eqNs6QM4gCS-PFfXH9woxd81X-_zywQRnVw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 12:25 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com=
> wrote:
> > >
> > > Hi Duy
> > >
> > > On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > > > "git checkout" doing too many things is a source of confusion for m=
any
> > > > users (and it even bites old timers sometimes). To remedy that, the
> > > > command will be split into two new ones: switch and
> > > > something-to-checkout-paths.
> > >
> > > I think this is a good idea, thanks for working on it. I wonder if it
> > > would be a good idea to have the new command refuse to checkout a new
> > > branch if there is a cherry-pick/revert/merge/rebase in progress (wit=
h
> > > an option to override the check) as switching branches in the middle =
of
> > > one of those is likely to be confusing to users (if I do it it is
> > > normally because I've forgotten that I've not run 'git whatever
> > > --continue').
> >
> > Interesting. I think this would be a good default if we have an escape
> > hatch (which could even come later). I often wander off to some other
> > branch and go back. But then half the time I end up forgetting I'm in
> > a middle of something and just "git rebase --quit" :P
> >
> > Of course with git-stash (*) and git-worktree, I guess there's little
> > reason to just switch away from a something-in-progress worktree. I'll
> > try to implement this in the next round, unless someone objects.
>
> No objection here; I like this idea.

One last thing. What about --detach? Should it have the same
protection or should we let the user doing --detach (experiments) take
the responsibity to not screw themselves up?
--=20
Duy
