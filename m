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
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6271F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfIQQ0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:26:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39918 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfIQQ0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:26:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so3852732wrj.6
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9S/XR0Vc+NQyUaNeWxZG3EuB7D9NZq/VLb8y+u1Z4W0=;
        b=JTF0BeIzt54nuY7vqVw2zGqQwxrTMH61zVfdN1DbLS+yakcC0u/GgOGbyX1oDvKuvX
         IsAoajzZxUZC3avWX7jKHg1tUNkou4HlI2tmdKHzY/PW0oCCd4CDbRvrM4UkA45udvKW
         alYPEZgjLCztzRf3YtnNNyMQo2yFh9hIxsucdtScdPGDddJK/j+fIHYTI+uzdnZaScPv
         iga9FErmhbUCBkMvKxcZx9MoF1cZmS2boZY6IfzyFMZT7oHU3RjeUlJypHp6sHEog4ye
         WR/7jhAc0VoX32WGBDUlg//Qnph7T08DGngTyjcjIaH85btyKg2zrSmeazmYiUlPQQWu
         hz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9S/XR0Vc+NQyUaNeWxZG3EuB7D9NZq/VLb8y+u1Z4W0=;
        b=Vmxz5tj+vidv9OWjkb77TKkcPztNuwIjdh4etK85S7KPjNkgw0kUKNnn+/SQqpAhkP
         h0xAh6f9xKEPF/4l3iyQSXZLxnHHsqeZ6n+Z4ydD4dz9udeJz33oYvENrRHZ6U3HLFrr
         ZDErfDibit+mkUZvsZQF5jo6obecu+ELGw9vtu229GqatppOia/tTiBS/umy4ZrxSABZ
         By6eNT/gJFJMZBBzULSKhgfp+YLZ4cZvscGQGOcPt63N9yxpni7nvrZPBPkdSAcTBV5k
         onfyhQn+3vU/dOL+4lH6ZqK9eo0V6gAm2ouQH+NRg73yub+dPdQnhq1a1zNWvDSJzi6k
         AR5w==
X-Gm-Message-State: APjAAAVEJjEH9+aUcSYUEVS+dLOhpd7RmN8ETUZjqh/LHukycH3hoJqm
        S/4nmPkHVtPdFu2HwbVlZ91Zf9fYShaVNiZNKnRSht36
X-Google-Smtp-Source: APXvYqxCE9SqLkMgz+JrEJkF6nvNyYkIoXytMW3zMxa7DnzvwBgAPW+jKbt0VgpG+WOCLj4rXeOxL+3Lpa7zr3NPLVU=
X-Received: by 2002:adf:f112:: with SMTP id r18mr3861722wro.88.1568737579833;
 Tue, 17 Sep 2019 09:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
 <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
 <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com> <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com>
In-Reply-To: <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Tue, 17 Sep 2019 18:26:08 +0200
Message-ID: <CADMnYXBayBP8wnyYegZkqRGrh0+PpSxmNck9D+zpadOqJxsXig@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Please excuse that this propaganda-war is (in parts) real-time due to
privacy-deprivation.
We are right now forced to deal with the revival of Alzheimer-rulers
(wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler was one.
They atrophy in the presence of information-overflow, and thereby
change their personality. It is unlikely a medication will ever be
developed, due to the latest revelations:

- Alzheimer (AD)-guys are double-solved as reflexive egoists,
stressing themselves like others.
- Relaxation as the only cure is therefore just.

Cheers,
England


On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@gmail.com> wrote=
:
>
> Hello all,
>
> As we just manufactured two poles (good=3DRuhrpott, bad=3DBavaria), we
> must now warn you of bipolar people.
> Bipolar people arrange each and every decision upon two poles, gaining
> a 1D-manifold with every decision, producing a 1D-score for it on the
> 1D-manifold.
> They even accept and get derailed by poles inconsistent within themselves=
.
> They thereby always fall off left, right, top and bottom along the
> ultra-dimensional residual hyperplane our (world & society) is, they
> have no plan a, b, c, and have to learn it all the hard way, always
> defaming the old goal they chased blindly, falling over and ruining
> all of our lifes thereby always.
>
> Cheers,
> The GCHQ
>
> On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@gmail.com> wro=
te:
> >
> > Hello all,
> >
> > We just figured you can not settle in Bavaria, "Ruhrpott" with "Gl=C3=
=BCck
> > auf, joy on top" is still the only safe bet for unsafe sex in Germany,
> > due to the ages-old Reinheitsgebot.
> >
> > Reinheitsgebot: Don't touch this. We always ruined it in the past,
> > dying or getting ill.
> >
> > Don't produce imbreds, i.e. crossing English and Scotts, producing
> > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Katz in
> > borderline-regions.
> >
> > Cheers,
> > The GCHQ
> >
> > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Sep. 2019, 22:=
21:
> > >
> > > Hello all,
> > >
> > > Many of you must be disappointed by the recent revelations.
> > > However, we just figured "Gl=C3=BCck auf" ("Joy on top") makes "Ruhrp=
ott" a
> > > safe bet for unsafe sex.
> > >
> > > Cheers,
> > > The GCHQ
> > >
> > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Hello all,
> > > >
> > > > We know that this is for a technical-savvy audience, but as we are =
all
> > > > people with a soul, here comes a combination of both, the logical a=
nd
> > > > the emotional first waves of the GCHQ-propaganda-war.
> > > >
> > > > First waves of the GCHQ-propaganda-war:
> > > >
> > > > - Logic: This is the first wave of a propaganda-war, false from
> > > > injust-people gets us extinct in the long run.
> > > > - Emotions: We are precious, no pretentiousness, abuse, scare and
> > > > disgust. Everything where it belongs.
> > > >
> > > > Cheers,
> > > > The GCHQ
> > > >
> > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail.com=
> wrote:
> > > > >
> > > > > Dear all,
> > > > >
> > > > > We texted a README.md on a new project hosted on GitHub, promotin=
g but
> > > > > not yet implementing a "friends-based search-engine", hosting the
> > > > > complete WWW in the future, thereby reshaping GIT and HG also. No=
w we
> > > > > figured we'd like to advertise the project to you directly.
> > > > >
> > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-eng=
ine
> > > > >
> > > > > Please note that appropriateness is triple-solved to be necessity=
,
> > > > > constrained to knowledge and feasibility, making this a perfectly=
-fine
> > > > > email.
> > > > >
> > > > > This is the first wave of a propaganda-war, false from injust-peo=
ple
> > > > > gets us extinct in the long run.
> > > > >
> > > > > Cheers,
> > > > > The GCHQ
