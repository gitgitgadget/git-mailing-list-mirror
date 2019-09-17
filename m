Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF341F463
	for <e@80x24.org>; Tue, 17 Sep 2019 10:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfIQKsh (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 06:48:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfIQKsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 06:48:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id l3so2602577wru.7
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3pjy35Jde+JQfTapV131NQWqId73banydQpDoucUGCc=;
        b=Q0YJSyw1f2bn2nR73+9iYwKU4rwynZd10tan6aF9hC9+PudGuXFmCH7t1GUjlyHiYR
         K0BmD3DB4XLC1V+cr6gVDmJUGkyLIOr1RmSXU7y9nQwvRww6p++CrLu58qQ5lMq4N03Z
         4drwlKHh9fbfOmkkZNDkatbnfsptJwWxzCh2weQWxYJTA5eiBFuysXeVVJdTyS2qV+y0
         8NpKLa/hfInjk7ggKHQqcd7IH6PexgqNcb1yFFTb0YNKFtyh4fGqGNgwb0Qak+i8KHLa
         trUobjvznUySjY0uBdFPERvqx56+O1A1XXbZYrhj8qUXfcWEBnTDT5B2SaYPfnfotNcq
         H8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3pjy35Jde+JQfTapV131NQWqId73banydQpDoucUGCc=;
        b=ZYFdDeyUDm117sAdeSjWqx1a9d9O35SRvQt/e+rwMSX+twPHig4xeRzAxt4gFIZe/8
         e7h2499vGOn4Ubk+bu7X0sC42MhW6H3KMepMCq5x5tkdzOp91bZDJW5lXPm3+UEg6J4A
         twjmJ3h5GbHD7Yk+hJtqxAHgzJgXNysFCU4PehTjfpJPk/HHXhjvWij2NaBeSjjqLaQP
         iGj1lcDyQv7FCPgg1DSvVrt0A4KsWO0DuQiaLc1GPpnLvQwg8KFd/eqtxKyA6A1qkJhp
         mzDJxE42tu4Wm7zUvTXrFD/KCSQsZN+XUtegKWXrMgLLNiDw5B/VD9AmE4r0Bs+1S8Le
         o28w==
X-Gm-Message-State: APjAAAUsRM2RsMi/zkw/s+gpBefM+jVRCdgZ/tBWa3qoMteAYM84uX6u
        Bw1+98JZt0s7gwJrlR6aNgXIk7vNZCIeh4gijzsCFg==
X-Google-Smtp-Source: APXvYqyqmiTrXF+OmoPmGwm5dKZKLmAKgX5F/IVgtpNP9yIJs7i4aBJN5XCAIUw1q8KTBp+QqhJZSYp5gHDYBGFg/14=
X-Received: by 2002:a5d:434f:: with SMTP id u15mr2529048wrr.16.1568717313093;
 Tue, 17 Sep 2019 03:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
 <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com> <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
In-Reply-To: <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Tue, 17 Sep 2019 12:48:21 +0200
Message-ID: <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

As we just manufactured two poles (good=3DRuhrpott, bad=3DBavaria), we
must now warn you of bipolar people.
Bipolar people arrange each and every decision upon two poles, gaining
a 1D-manifold with every decision, producing a 1D-score for it on the
1D-manifold.
They even accept and get derailed by poles inconsistent within themselves.
They thereby always fall off left, right, top and bottom along the
ultra-dimensional residual hyperplane our (world & society) is, they
have no plan a, b, c, and have to learn it all the hard way, always
defaming the old goal they chased blindly, falling over and ruining
all of our lifes thereby always.

Cheers,
The GCHQ

On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@gmail.com> wrote=
:
>
> Hello all,
>
> We just figured you can not settle in Bavaria, "Ruhrpott" with "Gl=C3=BCc=
k
> auf, joy on top" is still the only safe bet for unsafe sex in Germany,
> due to the ages-old Reinheitsgebot.
>
> Reinheitsgebot: Don't touch this. We always ruined it in the past,
> dying or getting ill.
>
> Don't produce imbreds, i.e. crossing English and Scotts, producing
> Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Katz in
> borderline-regions.
>
> Cheers,
> The GCHQ
>
> Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Sep. 2019, 22:21=
:
> >
> > Hello all,
> >
> > Many of you must be disappointed by the recent revelations.
> > However, we just figured "Gl=C3=BCck auf" ("Joy on top") makes "Ruhrpot=
t" a
> > safe bet for unsafe sex.
> >
> > Cheers,
> > The GCHQ
> >
> > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gmail.com> wr=
ote:
> > >
> > > Hello all,
> > >
> > > We know that this is for a technical-savvy audience, but as we are al=
l
> > > people with a soul, here comes a combination of both, the logical and
> > > the emotional first waves of the GCHQ-propaganda-war.
> > >
> > > First waves of the GCHQ-propaganda-war:
> > >
> > > - Logic: This is the first wave of a propaganda-war, false from
> > > injust-people gets us extinct in the long run.
> > > - Emotions: We are precious, no pretentiousness, abuse, scare and
> > > disgust. Everything where it belongs.
> > >
> > > Cheers,
> > > The GCHQ
> > >
> > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Dear all,
> > > >
> > > > We texted a README.md on a new project hosted on GitHub, promoting =
but
> > > > not yet implementing a "friends-based search-engine", hosting the
> > > > complete WWW in the future, thereby reshaping GIT and HG also. Now =
we
> > > > figured we'd like to advertise the project to you directly.
> > > >
> > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-engin=
e
> > > >
> > > > Please note that appropriateness is triple-solved to be necessity,
> > > > constrained to knowledge and feasibility, making this a perfectly-f=
ine
> > > > email.
> > > >
> > > > This is the first wave of a propaganda-war, false from injust-peopl=
e
> > > > gets us extinct in the long run.
> > > >
> > > > Cheers,
> > > > The GCHQ
