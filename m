Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129DEC32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIZSIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiIZSHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:07:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C30B1CF
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:52:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d24so6931542pls.4
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=28GCnnjyw850KOtUv31wDTiVWaI35umn0qsidU/Cla4=;
        b=e4m/hPrhvof3hEtaqBIbW0LV9ik0oAsozqwxfFY2b33kvK0MHM5LwKQLtfHuwW2xJz
         JiHO+fOchz+bYxX0FFYlR5dfvc+enSonsk4t9TVIhgj8kFtSfyVajSPX2i3O89p3d/iJ
         7C0Y67njkPeRJv4ByADV4q+vNyk7PeI2KW8QI7zrZWhMBwd+Mqep3FlFyWf2VYxR6Fcn
         cTIUkU9jgqIRP4UxH8jFVDbKEMvUPz+h3euo61ijn729aFGgaOuTyyReRPrsIoVmQUuo
         yYJsXLpyjRp4PXLgvGM7k8MZ+Iwiuo8KN8SCyYQay7HjqnZ2zCvr4dSRR9Bm+TgsapbE
         BaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=28GCnnjyw850KOtUv31wDTiVWaI35umn0qsidU/Cla4=;
        b=C27onmVGPBOz26F8f8kEHKyUJBvwaHIJ8OBlZdIWb+6DpPMgmTxlVLHh5hXBruoPaR
         865xloSW/WPchh9aiUm4auQ7KUpIBlqQQfelUItOOS7vVy+oq3SNAcPtz0ZCaK4BfxG7
         1DSsH9WrfS2A9Lbt7L8i/gmWUW7ISuQPzcBArLb1RdvaYwZ1HUt4CRjES7U6tMVvdJOm
         ahiq0Bl5fmSZlVlQ6/znOGiZ6/GXAh3OIYYZU8bWLHJ3Rekxa23QaERxl0+qVyNeuhG7
         35f4qCHp3Mo/Th6SS3OVS7qZOMveR5iW4xbw4GD/weev/NU+GZHDVOiDoShVNn8NijYW
         uXxA==
X-Gm-Message-State: ACrzQf26VpGsNuk6T27MbJeRA7BrZwsjCO//tAXII+CdrQsPDkbdvAiO
        W6Y2pHqvl3O6UeuX4Nws/iRlsZvUfZDeLVb5ktM=
X-Google-Smtp-Source: AMsMyM7W6tEZrmX/0fKHV3zPyuINFX4RvmVPZII3HUvcymvxRdWUvTTIwMTJXBQ0l+tnTq7EhbLSagq2JulJ4J8l+K4=
X-Received: by 2002:a17:902:7c11:b0:178:a6ca:4850 with SMTP id
 x17-20020a1709027c1100b00178a6ca4850mr24093185pll.111.1664214753569; Mon, 26
 Sep 2022 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <Ywzv7Dl6n+LcY//n@nand.local> <CAP8UFD2gUTuae0nRp2jHHoD3yLsVSGTBzEuHkv8QLDGJVAZ-MQ@mail.gmail.com>
 <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0+qW9aRVbXeKkvZKKi-6rge851FdT3FxPW98_JH_KLRQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 26 Sep 2022 23:22:22 +0530
Message-ID: <CA+CkUQ9xOF3UfSO_Zim-JT0020U_3eS7GeEVrH8UDDqQbhN9Rg@mail.gmail.com>
Subject: Re: Git in Outreachy? (December 2022)
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HI,

On Mon, Sep 26, 2022 at 3:21 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Tue, Aug 30, 2022 at 8:53 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Mon, Aug 29, 2022 at 6:57 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> > > Christian and I both got emails from the Outreachy organizers asking if
> > > we are interested in participating again this year. Last year we
> > > submitted projects, but ultimately did not select anybody from the
> > > program.
> >
> > Yeah, let's hope we get more people applying this year.
> >
> > > I think it would be good to participate in this year's December cohort.
> >
> > Yeah, thanks for your email about this.
>
> So we decided to participate and I just submitted one project:
>
> https://www.outreachy.org/outreachy-december-2022-internship-round/communities/git/#unify-ref-filter-formats-with-other-pretty-formats
>
> which is about continuing previous work by GSoC contributors and
> Outreachy interns.
>
> The deadline to submit projects is September 29, so next Thursday.
>
> I think Taylor agreed in private discussions with submitting another
> project related to improving our https://git-scm.com/ website (which
> was discussed previously on the mailing list).
>
> It could help a lot if we could be co-mentoring the project I
> submitted and the project about improving our website that Taylor
> might also submit. So if you would be interested, don't hesitate to
> contact us.
>
> > > September 9th is the initial community application deadline.
> > >
> > > If we're interested, the project submission deadline is September 23rd
> > > By then, we'd need:
> > >
> > >   - Volunteers to act as mentors
> > >   - Updates to our applicant materials on git.github.io (project ideas,
> > >     as well as potential microprojects).
> > >
> > > If folks are interested, I'd be more than happy to answer any questions
> > > about participating, and overall logistics of the program.
>
> > Yeah, we need to update our microproject ideas on git.github.io.
>
> We still need to update microproject ideas on git.github.io for
> Outreachy applicants.
>
> > About
> > project ideas, we need some, but I think we need to add them into
> > Outreachy's website.
>
> If there are many possible co-mentors we can still submit more project
> ideas into Outreachy's website before the deadline next Thursday.
>

Sorry I missed the discussion on the mailing list. But count me it.

I would be happy to co-mentor.

Thanks
Hariom
