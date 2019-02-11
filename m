Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE6F1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 10:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfBKKwV (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 05:52:21 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35267 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 05:52:21 -0500
Received: by mail-ed1-f44.google.com with SMTP id b17so8471503eds.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tGB/pz57qKUm8fAJ27sk7g2izbENAfGSu/pSFbG1vk8=;
        b=DFjHv0pEWs7zzp/5KdrM8BrS+pifceJ1bJKJma00hMzJuwAM9qvaDESZBwVtkFNR2c
         H0VZPhQqkOuKMwA1nn0ImdXqJofOZ3sS/rR1lAsXnn32NviVuZZI091X4wluuGIS8k2v
         h65esQT1mZlvbSj6OzDKHX69X/oiuMYurf9Pz04C+pxs+n6Mna9TCUuCzzYl+MgKDR4O
         epKvQIXgkGjh6d5JQYqqMiHe0qtcCFDXnq0Wg2uEU+nFxOYoKpioSqFh1vWgdILkGWFP
         tyUv+/Ol5nhIslVpudepVnrJ8LkVF8Daf8Cxj3s5X7ogwUCegFHSy7j++A9FW4VnW+qB
         3f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tGB/pz57qKUm8fAJ27sk7g2izbENAfGSu/pSFbG1vk8=;
        b=czOqgteht3g0WVHX7lGeUSETCZTVsw0jcfQCZIz57xg0OMAMveCmO4xKg9p2YV8V1r
         zyXcLJJYEsJlVNe0gGhh4tAtFAftA1y3y0pcWftWLqJwJIMRks6EeJxB8S/vbV6NDOuo
         pK3xGxYUNv4y6C+0RI2AEmtch9EJFPGpgfiOmH7q0S5r8I0QpCalXtN+kpdnBq7z1cy4
         cOfrbM25eOfJiue5ZejejXW339tPpdAJ34JoR2DEYcozWY2Ejt2xQdk4injLkYextOgr
         FIujFfMkM4WHOVow5xPDRVWLaZnoc8nw7iKCfgQe9pFhAPIgdIM4hToku93ahDCw4rpF
         oK9A==
X-Gm-Message-State: AHQUAuY6v8ekx1ozKXj4zRcM1OmHBMHNxHBuIItRps5Vlw916OCRNe40
        AyG+GrlQrupNo5N69tBefAqWZM5XnPIOTzeiCSE=
X-Google-Smtp-Source: AHgI3IZw07r6Fj8bQawzrgOrxHgxPWFNG+f0RZ2rvo2jhUfgY+hvcOKsPLj7YvOtsJ59WqLO5snO8KF42BmfdayRbyw=
X-Received: by 2002:a17:906:528b:: with SMTP id c11mr26307299ejm.75.1549882339444;
 Mon, 11 Feb 2019 02:52:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
 <CAP8UFD24Jgetmb9_ANm07Emwr90obVpiRPyX+HtmaHcL1fYq5g@mail.gmail.com> <CAL21Bm=n0pe5M0G5eB9svQcmM9dC023J46HFo-jYuDQeyKcwFw@mail.gmail.com>
In-Reply-To: <CAL21Bm=n0pe5M0G5eB9svQcmM9dC023J46HFo-jYuDQeyKcwFw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Feb 2019 11:52:07 +0100
Message-ID: <CAP8UFD11+rrJ4e4L=D4FX3mjdJ=sdZ8FVOUXQofTbFMxmXEAmw@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
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

On Mon, Feb 11, 2019 at 9:39 AM =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=
=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>
> =D0=BF=D0=BD, 11 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3. =D0=B2 10:46, Chr=
istian Couder <christian.couder@gmail.com>:
> >
> > On Mon, Feb 11, 2019 at 6:48 AM =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:

> > > > - Unify ref-filter formats with other --pretty formats (which is ne=
w)
> > >
> > > I am ready to act as a mentor in this task, I know that part of
> > > project good enough.
> >
> > Great! I thought that it would be a good project for you to mentor and
> > that's why I added it.
> >
> > By the way if you would prefer not to mentor the other project I can
> > remove you from its possible mentor list.
>
> I am ready to try mentoring on both projects, but it would be much
> easier for me to work only for this one. I removed my name from the
> other one and made pull request:
> https://github.com/git/git.github.io/pull/355

Great, merged!

> If project about pretty will not be selected by any of the students, I
> am happy to help other mentors with other projects.

Ok, we will see.

> > Do you mean the following comment from
> > https://github.com/git/git/blob/c17ed82b8983ea7e172181d869966db546c6a52=
8/ref-filter.c#L2393-L2399:
> >
> > /*
> > * TODO: add support of %(*raw). Need to switch between oi and oi_deref =
for that.
> > * TODO: split logic and printing (as it is done in format_ref_array_ite=
m and
> > * show_ref_array_item). After that we could use %(raw) in all
> > ref-filter commands.
> > * TODO: rewrite print_object_or_die so that it will reuse result of gen=
eral
> > * oid_object_info_extended call.
> > */
> >
> > ?
> >
> > It doesn't look like that's it. Could you just copy the task into an
> > email? Or if you think it could be an idea for a GSoC project, could
> > you send a pull request to add it to:
> >
> > https://github.com/git/git.github.io/blob/master/SoC-2019-Ideas.md
> >
> > ?
>
> Yes, that's it. Particularly, the last TODO. But other TODOs will be
> also solved as a result. I can add it to the list of the projects if
> you find this task suitable.

I think it is ok if we propose that task first and then the "Unify
ref-filter formats with other --pretty formats" project in case the
student finishes the first task soon. Or do you see other tasks for a
student after this?

Anyway I don't think we should have both one student working on the
"Unify ref-filter formats with other --pretty formats" project and
another one on this task.

But yeah, if you want, feel free to send a pull request to add it with
the above caveats.

> > They also want "more detailed description of [each] project (2-5
> > sentences)", so I think we should work on that too.
>
> I added description for one of projects, it is also in my pull request.

Thanks,
Christian.
