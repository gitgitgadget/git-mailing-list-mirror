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
	by dcvr.yhbt.net (Postfix) with ESMTP id E87731F463
	for <e@80x24.org>; Tue, 17 Sep 2019 10:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfIQKLp (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 06:11:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41548 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfIQKLo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 06:11:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so2469485wrw.8
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Mw8ZK7hv9RYMujNq3BbDGp2fc+nXU07Fq3JcSgljTyQ=;
        b=VA9anUjJkGjwJq99aULc+bZbOhsZ96WIMyAHeeb4OWDW6WwN3wPAqE489D7e7bkX0Y
         FxJuFlCo/rX561tN4zKddciV62Yoa3k4YfnmMKbODhXSr4nNAZvEM8PojcO30gLbE4rS
         QBGiFfLsAObhXXq7ohyq5qVywXaJG0G4PIrhr+te1sSRJpWcSFN3CC5qesqvAdITtIYq
         0VcW9yz36nrOVjdbw142i/qNpdcbA0P3FAq7KIFGs1Io1LR4PA5V/bQZj8QVwbov2ZoI
         bTBLdHqmHzqW0C5tLU0V86YizDOCaSdv3MuwcAweD8vzgjUNi/hqsfOPW4hDLYCUFcIH
         l5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Mw8ZK7hv9RYMujNq3BbDGp2fc+nXU07Fq3JcSgljTyQ=;
        b=JgaCXGZqryMaVxzYfYY0Utk0ByJuNC/0qxtx6VJLNP/91rkZZkwH5Ju/QusH/M3LOT
         Db1N9vj2NBwZKwRx3t0vTGRT1dmQ1CaVmKYTQ1CmOQ/BE1Fg4Cu7JGEIRUhNPE7hw8YY
         zjanc/zUiT1pX0+vqwaCvBAz36nLRwDeggokMHXXxhehMktAG11ULd0P1awqF8U1p9Ks
         NFnRzMUOelitAEPurI9tB8Tv2PpW7UeJfaiAN7bE0Tqfm9Z3vwurMtiIwcM8VXuxf2bo
         77XAKc4+RH5ILXiKLrK1tcwaIrsVaGwhQzYi4ddijyldWSrJ2J7EgoS/urCRd7awkcue
         uJlA==
X-Gm-Message-State: APjAAAXPuxcRpoGkFxXILaL/Jc+F2e3uE8vXUlwV45S1OxTBfO28GzpO
        N7C88E9bR+Dd5jIv8aae3ivYhUZndStEHuptuu2dgg==
X-Google-Smtp-Source: APXvYqxjvSfCFZXweWtsRCmH8u3pW4FpYZgBYBYE1HS6vkRjniAdXqtd/8msZKqWJ1lHVoIlhS4sZdEnISlj5JZOb2c=
X-Received: by 2002:a5d:434f:: with SMTP id u15mr2390390wrr.16.1568715101936;
 Tue, 17 Sep 2019 03:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com> <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
In-Reply-To: <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Tue, 17 Sep 2019 12:11:30 +0200
Message-ID: <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

We just figured you can not settle in Bavaria, "Ruhrpott" with "Gl=C3=BCck
auf, joy on top" is still the only safe bet for unsafe sex in Germany,
due to the ages-old Reinheitsgebot.

Reinheitsgebot: Don't touch this. We always ruined it in the past,
dying or getting ill.

Don't produce imbreds, i.e. crossing English and Scotts, producing
Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Katz in
borderline-regions.

Cheers,
The GCHQ

Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Sep. 2019, 22:21:
>
> Hello all,
>
> Many of you must be disappointed by the recent revelations.
> However, we just figured "Gl=C3=BCck auf" ("Joy on top") makes "Ruhrpott"=
 a
> safe bet for unsafe sex.
>
> Cheers,
> The GCHQ
>
> On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Hello all,
> >
> > We know that this is for a technical-savvy audience, but as we are all
> > people with a soul, here comes a combination of both, the logical and
> > the emotional first waves of the GCHQ-propaganda-war.
> >
> > First waves of the GCHQ-propaganda-war:
> >
> > - Logic: This is the first wave of a propaganda-war, false from
> > injust-people gets us extinct in the long run.
> > - Emotions: We are precious, no pretentiousness, abuse, scare and
> > disgust. Everything where it belongs.
> >
> > Cheers,
> > The GCHQ
> >
> > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail.com> wr=
ote:
> > >
> > > Dear all,
> > >
> > > We texted a README.md on a new project hosted on GitHub, promoting bu=
t
> > > not yet implementing a "friends-based search-engine", hosting the
> > > complete WWW in the future, thereby reshaping GIT and HG also. Now we
> > > figured we'd like to advertise the project to you directly.
> > >
> > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search-engine
> > >
> > > Please note that appropriateness is triple-solved to be necessity,
> > > constrained to knowledge and feasibility, making this a perfectly-fin=
e
> > > email.
> > >
> > > This is the first wave of a propaganda-war, false from injust-people
> > > gets us extinct in the long run.
> > >
> > > Cheers,
> > > The GCHQ
