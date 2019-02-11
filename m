Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186501F453
	for <e@80x24.org>; Mon, 11 Feb 2019 08:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBKIjR (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 03:39:17 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38754 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBKIjR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 03:39:17 -0500
Received: by mail-wm1-f53.google.com with SMTP id v26so15370794wmh.3
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 00:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+WOl2MMc6eoFS8P5WrYOyWm4Nuc0odJKNJ3jRjUqS4w=;
        b=rF3iC09tY1AoDW/aFTrejRJgmfPKd8Y6xUFx/D89LsuQPYIepRN2bnsR6VTsaeFdG7
         m+sFcXZqVTeERN7/1bNWaT4W9OYPD65ULOQp67UNAB3miKpz+T5gunKI7uyEChcFhV0J
         Z8A0nhU0yBUJkz6XaIsYV+B75rUiMMiC/ftbZYcOEdzp2mwz5ima93YbktG3/LfyxD1g
         hpNs7bfnIwsp/FU/67Yjli0hiUY/E+wHoD3C+kcdZ7kQf7BIGLRZfwk8OK4ecFFMh+7T
         c/JBo49Cgm69wJ1VqYwDc9SyoO0EJW5q4v4WgEFneTUkoB9DrLnv6UiYhv1OHana9slo
         m8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+WOl2MMc6eoFS8P5WrYOyWm4Nuc0odJKNJ3jRjUqS4w=;
        b=inKfZ4BsMaA/3Hyk+CT8bCOTusbahRexXJSeNfRXWuSHH1/uefXhR+1HZBqEoRZ2X/
         0vvjcyaIDmb4DnzblNGb4oGY5cGSrWlWGn+daDc3xKIPL+oAklaSY2yMOlS8Wb8rMkV3
         mwtk0/7IcnZl0DNw7slt5SdYCgkjxl/NpzvI/qp/PfsCEPK9zFliF1dt1dOGRA7VRkkR
         TPG6rJZeGQUvpwcqOvxRf3241TgSPbAbWa0v9SXmw6P4EmLHkIz3vv8nLp4PlH35F3pi
         lXxGtMvgBOnjZPmCp7LQ9IkCKtChR674xWWjYCGQG097MO3eQy+HXpRChQxHRK4nRpX5
         kHSQ==
X-Gm-Message-State: AHQUAuanlYDotcUtYtMikt4xi53+HVMPgmNPkOACCz8+hdo8npEp3rqr
        qEk3l3Pl3NccTjJ2hJnqf+TYD7bclIeTn8qxchNMBzOipm4=
X-Google-Smtp-Source: AHgI3Iat4ct5bGyZOATKwCT4BuADBkb6SsdoX1jz65lbyp6aGwI8O5YeUzDmrsPaHQgpmmTWkIplzOjrKyE2rp2R4Us=
X-Received: by 2002:adf:8919:: with SMTP id s25mr25693132wrs.38.1549874354349;
 Mon, 11 Feb 2019 00:39:14 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
 <CAP8UFD24Jgetmb9_ANm07Emwr90obVpiRPyX+HtmaHcL1fYq5g@mail.gmail.com>
In-Reply-To: <CAP8UFD24Jgetmb9_ANm07Emwr90obVpiRPyX+HtmaHcL1fYq5g@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 11 Feb 2019 11:31:35 +0300
Message-ID: <CAL21Bm=n0pe5M0G5eB9svQcmM9dC023J46HFo-jYuDQeyKcwFw@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D0=BD, 11 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3. =D0=B2 10:46, Chris=
tian Couder <christian.couder@gmail.com>:
>
> On Mon, Feb 11, 2019 at 6:48 AM =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> >
> > > It would be nice to have a few more project ideas.
> >
> > I am not sure I have additional ideas for 3-month project for the inter=
n, but
> >
> > > https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> > > projects:
> > >
> > > - Unify ref-filter formats with other --pretty formats (which is new)
> >
> > I am ready to act as a mentor in this task, I know that part of
> > project good enough.
>
> Great! I thought that it would be a good project for you to mentor and
> that's why I added it.
>
> By the way if you would prefer not to mentor the other project I can
> remove you from its possible mentor list.

I am ready to try mentoring on both projects, but it would be much
easier for me to work only for this one. I removed my name from the
other one and made pull request:
https://github.com/git/git.github.io/pull/355

If project about pretty will not be selected by any of the students, I
am happy to help other mentors with other projects.

>
> > I have additional related task: We have a function called
> > oid_object_info, it allows to download meta-info of the file. It was
> > used in cat-file, and inspired by that example, I improved ref-filter,
> > so now ref-filter works faster with it. Moreover, I have found that
> > oid_object_info allows to get the contents of the file. It was useful
> > in ref-filter, and actually it could be also useful in cat-file, but
> > we still download the file differently in cat-file, and it looks
> > awkward. I need to make just one last move to finish my patch: it will
> > close the task about migrating cat-file formatting logic to
> > ref-filter. But cat-file still will not use general way to download
> > the file. So, the task is to get rid of additional file-reading logic.
> > I guess this task is much smaller than original one, but at least the
> > student will have chance to finish it in 3 months.
> > My patch is here: https://github.com/git/git/pull/568
> > But I hope you will also see it this week in the mailing list.
> > Proposed task is in TODO in the end of ref-filter file.
>
> Do you mean the following comment from
> https://github.com/git/git/blob/c17ed82b8983ea7e172181d869966db546c6a528/=
ref-filter.c#L2393-L2399:
>
> /*
> * TODO: add support of %(*raw). Need to switch between oi and oi_deref fo=
r that.
> * TODO: split logic and printing (as it is done in format_ref_array_item =
and
> * show_ref_array_item). After that we could use %(raw) in all
> ref-filter commands.
> * TODO: rewrite print_object_or_die so that it will reuse result of gener=
al
> * oid_object_info_extended call.
> */
>
> ?
>
> It doesn't look like that's it. Could you just copy the task into an
> email? Or if you think it could be an idea for a GSoC project, could
> you send a pull request to add it to:
>
> https://github.com/git/git.github.io/blob/master/SoC-2019-Ideas.md
>
> ?

Yes, that's it. Particularly, the last TODO. But other TODOs will be
also solved as a result. I can add it to the list of the projects if
you find this task suitable.

>
> > By the way, we had a letter from Google, it is said that our tasks are
> > sparsed. I am not sure I understand it correctly. Should I help the
> > project somehow to solve our issues?
>
> Yeah, we got en email from Stephanie Taylor saying that our idea list
> is quite sparse this year with a link to:
>
> https://google.github.io/gsocguides/mentor/defining-a-project-ideas-list
>
> which contains:
>
> "Even if you are a new organization and only want one or two students
> showing that you have multiple ideas (a bare minimum of 4 solid ideas)
> is vital."
>
> They also want "more detailed description of [each] project (2-5
> sentences)", so I think we should work on that too.

I added description for one of projects, it is also in my pull request.

>
> So yeah, any help to fix the idea list is very welcome!
>
> Thanks,
> Christian.
