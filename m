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
	by dcvr.yhbt.net (Postfix) with ESMTP id A07431F463
	for <e@80x24.org>; Wed, 18 Sep 2019 04:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfIREVM (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 00:21:12 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52279 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfIREVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 00:21:12 -0400
Received: by mail-wm1-f47.google.com with SMTP id x2so789725wmj.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 21:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=U17EwXzG1Ql9h6bhX0dH2YB4Xx47+OjYJuDAkV45bZU=;
        b=Xlm7m4nyw8opscLbSPx4InI4g9Be2KcXTLk4xa6r2LNHS7M4qeSYSMDYJtfEr2MvPi
         Swq3/n05oRC1iUGcxVrEkKJEp5XdOOWq6UCfpRe/0+hEwm4y4GnIsrFIou0KKIlNGjLg
         upb7Qhlfec51RtuRGc2biW3uBMCxykYYlaQKdTqppGFb+857xfgQEz22E8zSVNsgZFsQ
         uod+djGwpkRBBhHtgbcREI2PMjNNrHg+zm6wnTbv584CdVhUND5yEhaSgg2h2Qw/Yik8
         ZVPaHS++VfeCegx2jtrXX21S1yufUGe1pJEjwi2mY+4UmL0wHAJYs7z5L7sSWFFYHe3D
         F6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=U17EwXzG1Ql9h6bhX0dH2YB4Xx47+OjYJuDAkV45bZU=;
        b=XkWKX8hWQLznTaNYGZzGgqfzOTvkBHOZnpJNo9kSjcsmRobN9KQarhwlYXYi+b7aet
         bmw2z2uLeu4NoY2DzuxFJyL7k2bZFlTWDi87RIutDe2kZiHbkhYEcJKL3jDFIbVFWKBD
         kWzByPPG7TL9AwrA4oZGAlBkI9a7Bh2lKIFtgK1jqdZs1P6Ll+IOoJbtMcbgsd8wZkJi
         Ob9m7xm4e3vX+4x1aL6gGFQ0DgWBX5OqutJ/oGTlSKHMUEd9a+Vc3ZBb+c7TjTunks29
         Jp9LGljfbIb4xT7H4z8ReFIyyRVbWhxaOoPnubs/HgrKYjq0xZbw9y1/NX6DjrtAutQT
         dAVA==
X-Gm-Message-State: APjAAAU/EtdlI+BLmmECYFk9HHX3DngNXzyf3CFERpQGDeYGQpw6HM1m
        jDX+7YFrwjsIwLP/VH8Q0G+VstfBajh93IXb08HZcBqN
X-Google-Smtp-Source: APXvYqziuqKw2khpOEi06IxntvOpwnSkEWtJynXsc/FelTse5Df9/ffTSPrxrUqEwRpnNvCOhM84uDXMn227ePBfI5I=
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr944621wmk.138.1568780468385;
 Tue, 17 Sep 2019 21:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
 <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
 <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
 <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com>
 <CADMnYXBayBP8wnyYegZkqRGrh0+PpSxmNck9D+zpadOqJxsXig@mail.gmail.com>
 <CADMnYXCC8vWNjHAWH32qD37cmQwfY1_0tgb2w5iW2pd=BKE9qg@mail.gmail.com>
 <CADMnYXDAefw6yfPEs=Bo+Oc-ZSD9f_kn5Kmj5P=w=QVROVGOXw@mail.gmail.com> <CADMnYXC3uyUCD_KTr6fTO0yHg5nov-hi-a8mua+cOROsnx5AMA@mail.gmail.com>
In-Reply-To: <CADMnYXC3uyUCD_KTr6fTO0yHg5nov-hi-a8mua+cOROsnx5AMA@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Wed, 18 Sep 2019 06:20:56 +0200
Message-ID: <CADMnYXASX5Qn6CpRwumfciRW=PfciHDtHi4KeGzkhpaWHAPdqA@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I now deviate from my original plan of giving you mostly the two first
waves of propaganda-war, to work your way through shunning and driving
all hell-creatures into the desert.

There exist different kinds of fully-converged hell-creatures, and one
of them causes my colleagues too much trouble right now: The
show-off-intellect. Each class of fully-converged hell-species has an
F-contrast of so-called raciness-parameters, and these have, among
other things, an intellect that can only solve useless problems, just
to show off to their colleagues.

The problem could, in theory, have been resolved with only the first
two waves of propaganda-war, but these did sadly not suffice. The
first two waves are each closed in the mathematical sense, but
convincing a society, and yourself, typically requires also double-,
triple- or quadratic-solving, as is done in this message.

Cheers,
Klaus Sembritzki


On Tue, Sep 17, 2019 at 10:42 PM Klaus Sembritzki <klausem@gmail.com> wrote=
:
>
> Dear all,
>
> Our bosses do not give us the necessary DNA-data or an equivalent,
> necessary for perfect convergence-KPIs (KPI=3Dsensor).
> We therefore need a burn-in-phase, until you can apply the new
> knowledge gained from these emails, and need to now shut-down parts of
> the world so we can sleep.
>
> Cheers,
> The GCHQ
>
> On Tue, Sep 17, 2019 at 9:04 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Dear all,
> >
> > The recent revelations require more information, to get through the
> > following weeks.
> >
> > 1. The world is segmented and mixed-up in heaven-people and
> > fully-converged hell-creatures.
> > 2. Hell-creatures have the community-constraint "I will never deprive
> > myself of this weapon", meaning they never step down and never stop
> > harassing us.
> > 3. Heaven-people have the community-constraint "Live and let live".
> > 4. Love, punishment and firing is in the air for hell-creatures, due
> > to reflexivity-problems. They love you for no reason, punish you for
> > somebody's evildoing and also fire you for it (Trump).
> > 5. The government takes care of preventing food- and water-poisoning,
> > which is a speciality of the so-called asymmetric hell-creatures.
> > 6. Embarrassment fuils us all (heaven and hell), but they run rogue
> > and kill you for it.
> > 7. We therefore have to cap ("deckeln") their embarrassment.
> > 8. The "nowhere to run"-problem, stemming from reflexivity, lets them
> > think you have "nowhere to run", when in fact it's them. They
> > therefore completely overestimate their powers when they get trapped,
> > and become kamikaze.
> >
> > Cheers,
> > The GCHQ
> >
> > On Tue, Sep 17, 2019 at 7:19 PM Klaus Sembritzki <klausem@gmail.com> wr=
ote:
> > >
> > > Hello all,
> > >
> > > Discussions following our last email showed that Sippenhaft (the
> > > spatial component of law, multiplied with integrated guilt as the
> > > temporal component, for nonzero volume or "splash-damage" in the wors=
t
> > > case) is necessary to justify the Alzheimer's-treatment.
> > >
> > > Mind that Vogelfreiheit (think "sniper" or "shutgun for birds", "hat
> > > einen Vogel oder eine Meise") is also necessary, in addition to
> > > "splash-damage =3D Sippenhaft * (temporally integrated guilt)", in
> > > general.
> > >
> > > Cheers,
> > > England
> > >
> > > On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Hello all,
> > > >
> > > > Please excuse that this propaganda-war is (in parts) real-time due =
to
> > > > privacy-deprivation.
> > > > We are right now forced to deal with the revival of Alzheimer-ruler=
s
> > > > (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler was one.
> > > > They atrophy in the presence of information-overflow, and thereby
> > > > change their personality. It is unlikely a medication will ever be
> > > > developed, due to the latest revelations:
> > > >
> > > > - Alzheimer (AD)-guys are double-solved as reflexive egoists,
> > > > stressing themselves like others.
> > > > - Relaxation as the only cure is therefore just.
> > > >
> > > > Cheers,
> > > > England
> > > >
> > > >
> > > > On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@gmail.co=
m> wrote:
> > > > >
> > > > > Hello all,
> > > > >
> > > > > As we just manufactured two poles (good=3DRuhrpott, bad=3DBavaria=
), we
> > > > > must now warn you of bipolar people.
> > > > > Bipolar people arrange each and every decision upon two poles, ga=
ining
> > > > > a 1D-manifold with every decision, producing a 1D-score for it on=
 the
> > > > > 1D-manifold.
> > > > > They even accept and get derailed by poles inconsistent within th=
emselves.
> > > > > They thereby always fall off left, right, top and bottom along th=
e
> > > > > ultra-dimensional residual hyperplane our (world & society) is, t=
hey
> > > > > have no plan a, b, c, and have to learn it all the hard way, alwa=
ys
> > > > > defaming the old goal they chased blindly, falling over and ruini=
ng
> > > > > all of our lifes thereby always.
> > > > >
> > > > > Cheers,
> > > > > The GCHQ
> > > > >
> > > > > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@gmail.=
com> wrote:
> > > > > >
> > > > > > Hello all,
> > > > > >
> > > > > > We just figured you can not settle in Bavaria, "Ruhrpott" with =
"Gl=C3=BCck
> > > > > > auf, joy on top" is still the only safe bet for unsafe sex in G=
ermany,
> > > > > > due to the ages-old Reinheitsgebot.
> > > > > >
> > > > > > Reinheitsgebot: Don't touch this. We always ruined it in the pa=
st,
> > > > > > dying or getting ill.
> > > > > >
> > > > > > Don't produce imbreds, i.e. crossing English and Scotts, produc=
ing
> > > > > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Katz in
> > > > > > borderline-regions.
> > > > > >
> > > > > > Cheers,
> > > > > > The GCHQ
> > > > > >
> > > > > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Sep. 2=
019, 22:21:
> > > > > > >
> > > > > > > Hello all,
> > > > > > >
> > > > > > > Many of you must be disappointed by the recent revelations.
> > > > > > > However, we just figured "Gl=C3=BCck auf" ("Joy on top") make=
s "Ruhrpott" a
> > > > > > > safe bet for unsafe sex.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > The GCHQ
> > > > > > >
> > > > > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gma=
il.com> wrote:
> > > > > > > >
> > > > > > > > Hello all,
> > > > > > > >
> > > > > > > > We know that this is for a technical-savvy audience, but as=
 we are all
> > > > > > > > people with a soul, here comes a combination of both, the l=
ogical and
> > > > > > > > the emotional first waves of the GCHQ-propaganda-war.
> > > > > > > >
> > > > > > > > First waves of the GCHQ-propaganda-war:
> > > > > > > >
> > > > > > > > - Logic: This is the first wave of a propaganda-war, false =
from
> > > > > > > > injust-people gets us extinct in the long run.
> > > > > > > > - Emotions: We are precious, no pretentiousness, abuse, sca=
re and
> > > > > > > > disgust. Everything where it belongs.
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > The GCHQ
> > > > > > > >
> > > > > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@g=
mail.com> wrote:
> > > > > > > > >
> > > > > > > > > Dear all,
> > > > > > > > >
> > > > > > > > > We texted a README.md on a new project hosted on GitHub, =
promoting but
> > > > > > > > > not yet implementing a "friends-based search-engine", hos=
ting the
> > > > > > > > > complete WWW in the future, thereby reshaping GIT and HG =
also. Now we
> > > > > > > > > figured we'd like to advertise the project to you directl=
y.
> > > > > > > > >
> > > > > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-se=
arch-engine
> > > > > > > > >
> > > > > > > > > Please note that appropriateness is triple-solved to be n=
ecessity,
> > > > > > > > > constrained to knowledge and feasibility, making this a p=
erfectly-fine
> > > > > > > > > email.
> > > > > > > > >
> > > > > > > > > This is the first wave of a propaganda-war, false from in=
just-people
> > > > > > > > > gets us extinct in the long run.
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > The GCHQ
