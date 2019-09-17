Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB95D1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfIQRT5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 13:19:57 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52530 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfIQRT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 13:19:57 -0400
Received: by mail-wm1-f45.google.com with SMTP id x2so4456294wmj.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fxmI87b7qyju0n1K38H1/KmQAjGrQB95TaP3QdVRXoU=;
        b=G3EN/ovAb/iWYwKL+Au0Tl4ShxWIpTFME4LvUcLrZSSNPV3FV1mG8tVnzCqterxBbe
         KsaCJ+ALOTTTc+FPoJ91aj2+xcaq6lel75YyKMK+2WNm9cdqXxW8tCsmoDGEQtODoDWw
         WYdnQFUPywKvNq28kdODfICLDOaEKjTMj3sZoo9Az6yXpiZ6PCYSvEPdLsEAACl9txV+
         toHWqBTV23BMlW1cObKfAkJh8QyQgmjLUmv25tos4v5vR+xG8QZHc2w1ohhL9mqQHfur
         ocyXWXE97Wrz4b9lNs5fNnzdNn6iCA2q+cDacK1nFeHIIXbcB3DurjwFoUzRUyjgwWNs
         xvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=fxmI87b7qyju0n1K38H1/KmQAjGrQB95TaP3QdVRXoU=;
        b=QcVUSdGxNOoBLXwO/KR3qzI/cltR9eUenf0HvBVSLOT5W8Wi6mXDV6GPv1t/lpZfi5
         j86glipN60Z1gP8Z07MjzOBz0ByoE3/3atkM6hWmtWvsaLqndSWiPBF+InNQSR0s2Yjo
         ucgweawnoWagxj1UKDIW0PBt5dNfqnfr1NAiJUUptjburxuGk0kZMFIDBpgurs3Xd/IA
         lUhKKdpfRDTDaWIwzM0u+JlBx7ZfSslJ2H49sSB1Qf2BHWOXPBxmUgknKRG+Ug++m4vH
         UqrbRsRUPU06ytIEK53AVnvSu/TCqUy05chk0sYoOlFYWanxcIZzoYq9xGYhyKkcfUCY
         Rq9A==
X-Gm-Message-State: APjAAAXAmuO+3USywjaXLjo3hye/o6gAYWLZi6iWTUqSDTLxm8sg733p
        L6+zqYfTudNUkDEHVMeDDHax9HrK1kreECDCPVKB5zlh
X-Google-Smtp-Source: APXvYqyyv3wEVQfPF94ePq2XEj5kPFkPAeWE9yRSfSy6gHkvOb8C4A5Cy70Eje7q5LJgpvC0ELXUHWj/a1p8iDw6d4E=
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr4656518wmm.98.1568740793697;
 Tue, 17 Sep 2019 10:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
 <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
 <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
 <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com> <CADMnYXBayBP8wnyYegZkqRGrh0+PpSxmNck9D+zpadOqJxsXig@mail.gmail.com>
In-Reply-To: <CADMnYXBayBP8wnyYegZkqRGrh0+PpSxmNck9D+zpadOqJxsXig@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Tue, 17 Sep 2019 19:19:42 +0200
Message-ID: <CADMnYXCC8vWNjHAWH32qD37cmQwfY1_0tgb2w5iW2pd=BKE9qg@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Discussions following our last email showed that Sippenhaft (the
spatial component of law, multiplied with integrated guilt as the
temporal component, for nonzero volume or "splash-damage" in the worst
case) is necessary to justify the Alzheimer's-treatment.

Mind that Vogelfreiheit (think "sniper" or "shutgun for birds", "hat
einen Vogel oder eine Meise") is also necessary, in addition to
"splash-damage =3D Sippenhaft * (temporally integrated guilt)", in
general.

Cheers,
England

On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Hello all,
>
> Please excuse that this propaganda-war is (in parts) real-time due to
> privacy-deprivation.
> We are right now forced to deal with the revival of Alzheimer-rulers
> (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler was one.
> They atrophy in the presence of information-overflow, and thereby
> change their personality. It is unlikely a medication will ever be
> developed, due to the latest revelations:
>
> - Alzheimer (AD)-guys are double-solved as reflexive egoists,
> stressing themselves like others.
> - Relaxation as the only cure is therefore just.
>
> Cheers,
> England
>
>
> On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@gmail.com> wro=
te:
> >
> > Hello all,
> >
> > As we just manufactured two poles (good=3DRuhrpott, bad=3DBavaria), we
> > must now warn you of bipolar people.
> > Bipolar people arrange each and every decision upon two poles, gaining
> > a 1D-manifold with every decision, producing a 1D-score for it on the
> > 1D-manifold.
> > They even accept and get derailed by poles inconsistent within themselv=
es.
> > They thereby always fall off left, right, top and bottom along the
> > ultra-dimensional residual hyperplane our (world & society) is, they
> > have no plan a, b, c, and have to learn it all the hard way, always
> > defaming the old goal they chased blindly, falling over and ruining
> > all of our lifes thereby always.
> >
> > Cheers,
> > The GCHQ
> >
> > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@gmail.com> w=
rote:
> > >
> > > Hello all,
> > >
> > > We just figured you can not settle in Bavaria, "Ruhrpott" with "Gl=C3=
=BCck
> > > auf, joy on top" is still the only safe bet for unsafe sex in Germany=
,
> > > due to the ages-old Reinheitsgebot.
> > >
> > > Reinheitsgebot: Don't touch this. We always ruined it in the past,
> > > dying or getting ill.
> > >
> > > Don't produce imbreds, i.e. crossing English and Scotts, producing
> > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Katz in
> > > borderline-regions.
> > >
> > > Cheers,
> > > The GCHQ
> > >
> > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Sep. 2019, 2=
2:21:
> > > >
> > > > Hello all,
> > > >
> > > > Many of you must be disappointed by the recent revelations.
> > > > However, we just figured "Gl=C3=BCck auf" ("Joy on top") makes "Ruh=
rpott" a
> > > > safe bet for unsafe sex.
> > > >
> > > > Cheers,
> > > > The GCHQ
> > > >
> > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gmail.com=
> wrote:
> > > > >
> > > > > Hello all,
> > > > >
> > > > > We know that this is for a technical-savvy audience, but as we ar=
e all
> > > > > people with a soul, here comes a combination of both, the logical=
 and
> > > > > the emotional first waves of the GCHQ-propaganda-war.
> > > > >
> > > > > First waves of the GCHQ-propaganda-war:
> > > > >
> > > > > - Logic: This is the first wave of a propaganda-war, false from
> > > > > injust-people gets us extinct in the long run.
> > > > > - Emotions: We are precious, no pretentiousness, abuse, scare and
> > > > > disgust. Everything where it belongs.
> > > > >
> > > > > Cheers,
> > > > > The GCHQ
> > > > >
> > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail.c=
om> wrote:
> > > > > >
> > > > > > Dear all,
> > > > > >
> > > > > > We texted a README.md on a new project hosted on GitHub, promot=
ing but
> > > > > > not yet implementing a "friends-based search-engine", hosting t=
he
> > > > > > complete WWW in the future, thereby reshaping GIT and HG also. =
Now we
> > > > > > figured we'd like to advertise the project to you directly.
> > > > > >
> > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-e=
ngine
> > > > > >
> > > > > > Please note that appropriateness is triple-solved to be necessi=
ty,
> > > > > > constrained to knowledge and feasibility, making this a perfect=
ly-fine
> > > > > > email.
> > > > > >
> > > > > > This is the first wave of a propaganda-war, false from injust-p=
eople
> > > > > > gets us extinct in the long run.
> > > > > >
> > > > > > Cheers,
> > > > > > The GCHQ
