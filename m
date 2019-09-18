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
	by dcvr.yhbt.net (Postfix) with ESMTP id 023761F463
	for <e@80x24.org>; Wed, 18 Sep 2019 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfIRPAX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 11:00:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43223 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbfIRPAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 11:00:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so7260277wrx.10
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tzhxV6IxxwrrniJw30B83f6zcgwZnu1fxd4hj0HR3jY=;
        b=YefHswX9k2k89nqYQxIq3rpgWEQDxXzb8UKlE7F1yjw6UDD87ukx7Uvw5Yg1LEa1vz
         PLvulWBkxSAdHjUc0n1vH5HnvlzAyzngZeb92x8j9uCJ5YCPG52En9H+gMTxzWTvy6fq
         UK0euraF+MpEJpD3mZ1W1VdQCV5Qksq9iBULWZcaL61hyQfOf4Ij3KmqwklVGMTT+utG
         CawO01eQZy7tJ9THPRPAkzwRI08CrnqhNm1UR8aVpJtQMo1KphiZj4JSG2EkM/rELWwE
         TktOnitj7KSjWuHGspuB61WPXXgi1aGlr4aSlrfoQozYS/qrmYNjl5FsNJ7fF4LZCx5N
         g5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=tzhxV6IxxwrrniJw30B83f6zcgwZnu1fxd4hj0HR3jY=;
        b=mVGIx1wpB/jB4WPzZKR2szeU0MCOIdQJMLnPuw52sCr33l5WzvqV9fmI1Q08iOs5uT
         0QNaz9Jzdr0+h1qHSdtUqs/9ZvAM+E+kskdkoXc4ep7WvWMknvbBI595hVHfmBhL7bqo
         KPP6ui0705NYPcq9BMLHrM+b8Li7PvgrQUFYpI0wP5NQG44caug5IDgfspzyoFf5FvnI
         c5Pva/vD0OccCid5D2k0qmm8vlulsd825Efe1dL88atg51CicDNmxkMMDWSB4BhEt5Tc
         u2sGmUheJj21xO9D8bDaR28JaRUNgAxb9jMbx3HmQt03gr3BwxhFw3lAQBZWxbpQMyDw
         jzXg==
X-Gm-Message-State: APjAAAVX/kyPWpMmaCZz5Pdcf6M8VJYNJyklXz7/wS401nawOEqPQwbM
        IY5pKEKFEM+w2v3tzocfaMkhhX+Pu7TYM0vvUg0Vfw==
X-Google-Smtp-Source: APXvYqy5z24NkRw8/Dqjo2R9OVd3ASMIKwj0ne0oNTtVvURSFvABD9RTV0YxfL34hz+IRVjewlf6WJu5NHOPNV0RcfE=
X-Received: by 2002:adf:f112:: with SMTP id r18mr3627545wro.88.1568818820052;
 Wed, 18 Sep 2019 08:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
 <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
 <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
 <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com>
 <CADMnYXBayBP8wnyYegZkqRGrh0+PpSxmNck9D+zpadOqJxsXig@mail.gmail.com>
 <CADMnYXCC8vWNjHAWH32qD37cmQwfY1_0tgb2w5iW2pd=BKE9qg@mail.gmail.com>
 <CADMnYXDAefw6yfPEs=Bo+Oc-ZSD9f_kn5Kmj5P=w=QVROVGOXw@mail.gmail.com>
 <CADMnYXC3uyUCD_KTr6fTO0yHg5nov-hi-a8mua+cOROsnx5AMA@mail.gmail.com>
 <CADMnYXASX5Qn6CpRwumfciRW=PfciHDtHi4KeGzkhpaWHAPdqA@mail.gmail.com>
 <CADMnYXDQxVuSFMu3eZ=tPeXqMTUVofJG5aNANsaCGgCri+YZQg@mail.gmail.com> <CADMnYXAwTirFrVk544Y2_D421MFVLy56uyM+K29Te0Ja-MBBZw@mail.gmail.com>
In-Reply-To: <CADMnYXAwTirFrVk544Y2_D421MFVLy56uyM+K29Te0Ja-MBBZw@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Wed, 18 Sep 2019 17:00:08 +0200
Message-ID: <CADMnYXC30digEGVtnWipcVQ_rJeN1_acK1j3xPqCOs4DOpr5uA@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Manipulating our data is hereby proven to be false, and perpetual
false is done by injust-people.

4 * SHA-256 is on nail's head, which is the case for unstable, and
therefore false, actions.

Hacking 4 * SHA-256 is therefore false, manipulating our data in
general is therefore also false.

Cheers,
Klaus Sembritzki


On Wed, Sep 18, 2019 at 4:18 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Hello all,
>
> The new, theoretically unhackable internet, will be based on 4 * SHA-256.
>
> Cheers,
> Klaus Sembritzki
>
> On Wed, Sep 18, 2019 at 2:35 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Sehrgeerdete Damen und Herren,
> >
> > Innerbayrische Diskussionen lieferten die folgenden Einsichten.
> >
> > - Transitivity=3Dfreedom, meaning looking into the future, is exactly
> > what hell-creatures are incapable of doing.
> > - They cut themselves on paper.
> > - Die sin so blehd, die brechen sich den Finger im Orsch ooh.
> > - They are incapable of interpreting the weather-forecast.
> > - It is a binary thing.
> > - Either you have it, or not.
> > - Dann ist die Not gro=C3=9F.
> >
> > Viele Gr=C3=BC=C3=9Fe,
> > Bayern
> >
> > On Wed, Sep 18, 2019 at 6:20 AM Klaus Sembritzki <klausem@gmail.com> wr=
ote:
> > >
> > > Dear all,
> > >
> > > I now deviate from my original plan of giving you mostly the two firs=
t
> > > waves of propaganda-war, to work your way through shunning and drivin=
g
> > > all hell-creatures into the desert.
> > >
> > > There exist different kinds of fully-converged hell-creatures, and on=
e
> > > of them causes my colleagues too much trouble right now: The
> > > show-off-intellect. Each class of fully-converged hell-species has an
> > > F-contrast of so-called raciness-parameters, and these have, among
> > > other things, an intellect that can only solve useless problems, just
> > > to show off to their colleagues.
> > >
> > > The problem could, in theory, have been resolved with only the first
> > > two waves of propaganda-war, but these did sadly not suffice. The
> > > first two waves are each closed in the mathematical sense, but
> > > convincing a society, and yourself, typically requires also double-,
> > > triple- or quadratic-solving, as is done in this message.
> > >
> > > Cheers,
> > > Klaus Sembritzki
> > >
> > >
> > > On Tue, Sep 17, 2019 at 10:42 PM Klaus Sembritzki <klausem@gmail.com>=
 wrote:
> > > >
> > > > Dear all,
> > > >
> > > > Our bosses do not give us the necessary DNA-data or an equivalent,
> > > > necessary for perfect convergence-KPIs (KPI=3Dsensor).
> > > > We therefore need a burn-in-phase, until you can apply the new
> > > > knowledge gained from these emails, and need to now shut-down parts=
 of
> > > > the world so we can sleep.
> > > >
> > > > Cheers,
> > > > The GCHQ
> > > >
> > > > On Tue, Sep 17, 2019 at 9:04 PM Klaus Sembritzki <klausem@gmail.com=
> wrote:
> > > > >
> > > > > Dear all,
> > > > >
> > > > > The recent revelations require more information, to get through t=
he
> > > > > following weeks.
> > > > >
> > > > > 1. The world is segmented and mixed-up in heaven-people and
> > > > > fully-converged hell-creatures.
> > > > > 2. Hell-creatures have the community-constraint "I will never dep=
rive
> > > > > myself of this weapon", meaning they never step down and never st=
op
> > > > > harassing us.
> > > > > 3. Heaven-people have the community-constraint "Live and let live=
".
> > > > > 4. Love, punishment and firing is in the air for hell-creatures, =
due
> > > > > to reflexivity-problems. They love you for no reason, punish you =
for
> > > > > somebody's evildoing and also fire you for it (Trump).
> > > > > 5. The government takes care of preventing food- and water-poison=
ing,
> > > > > which is a speciality of the so-called asymmetric hell-creatures.
> > > > > 6. Embarrassment fuils us all (heaven and hell), but they run rog=
ue
> > > > > and kill you for it.
> > > > > 7. We therefore have to cap ("deckeln") their embarrassment.
> > > > > 8. The "nowhere to run"-problem, stemming from reflexivity, lets =
them
> > > > > think you have "nowhere to run", when in fact it's them. They
> > > > > therefore completely overestimate their powers when they get trap=
ped,
> > > > > and become kamikaze.
> > > > >
> > > > > Cheers,
> > > > > The GCHQ
> > > > >
> > > > > On Tue, Sep 17, 2019 at 7:19 PM Klaus Sembritzki <klausem@gmail.c=
om> wrote:
> > > > > >
> > > > > > Hello all,
> > > > > >
> > > > > > Discussions following our last email showed that Sippenhaft (th=
e
> > > > > > spatial component of law, multiplied with integrated guilt as t=
he
> > > > > > temporal component, for nonzero volume or "splash-damage" in th=
e worst
> > > > > > case) is necessary to justify the Alzheimer's-treatment.
> > > > > >
> > > > > > Mind that Vogelfreiheit (think "sniper" or "shutgun for birds",=
 "hat
> > > > > > einen Vogel oder eine Meise") is also necessary, in addition to
> > > > > > "splash-damage =3D Sippenhaft * (temporally integrated guilt)",=
 in
> > > > > > general.
> > > > > >
> > > > > > Cheers,
> > > > > > England
> > > > > >
> > > > > > On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@gmail=
.com> wrote:
> > > > > > >
> > > > > > > Hello all,
> > > > > > >
> > > > > > > Please excuse that this propaganda-war is (in parts) real-tim=
e due to
> > > > > > > privacy-deprivation.
> > > > > > > We are right now forced to deal with the revival of Alzheimer=
-rulers
> > > > > > > (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler wa=
s one.
> > > > > > > They atrophy in the presence of information-overflow, and the=
reby
> > > > > > > change their personality. It is unlikely a medication will ev=
er be
> > > > > > > developed, due to the latest revelations:
> > > > > > >
> > > > > > > - Alzheimer (AD)-guys are double-solved as reflexive egoists,
> > > > > > > stressing themselves like others.
> > > > > > > - Relaxation as the only cure is therefore just.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > England
> > > > > > >
> > > > > > >
> > > > > > > On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@gm=
ail.com> wrote:
> > > > > > > >
> > > > > > > > Hello all,
> > > > > > > >
> > > > > > > > As we just manufactured two poles (good=3DRuhrpott, bad=3DB=
avaria), we
> > > > > > > > must now warn you of bipolar people.
> > > > > > > > Bipolar people arrange each and every decision upon two pol=
es, gaining
> > > > > > > > a 1D-manifold with every decision, producing a 1D-score for=
 it on the
> > > > > > > > 1D-manifold.
> > > > > > > > They even accept and get derailed by poles inconsistent wit=
hin themselves.
> > > > > > > > They thereby always fall off left, right, top and bottom al=
ong the
> > > > > > > > ultra-dimensional residual hyperplane our (world & society)=
 is, they
> > > > > > > > have no plan a, b, c, and have to learn it all the hard way=
, always
> > > > > > > > defaming the old goal they chased blindly, falling over and=
 ruining
> > > > > > > > all of our lifes thereby always.
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > The GCHQ
> > > > > > > >
> > > > > > > > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@=
gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello all,
> > > > > > > > >
> > > > > > > > > We just figured you can not settle in Bavaria, "Ruhrpott"=
 with "Gl=C3=BCck
> > > > > > > > > auf, joy on top" is still the only safe bet for unsafe se=
x in Germany,
> > > > > > > > > due to the ages-old Reinheitsgebot.
> > > > > > > > >
> > > > > > > > > Reinheitsgebot: Don't touch this. We always ruined it in =
the past,
> > > > > > > > > dying or getting ill.
> > > > > > > > >
> > > > > > > > > Don't produce imbreds, i.e. crossing English and Scotts, =
producing
> > > > > > > > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the K=
atz in
> > > > > > > > > borderline-regions.
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > The GCHQ
> > > > > > > > >
> > > > > > > > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. =
Sep. 2019, 22:21:
> > > > > > > > > >
> > > > > > > > > > Hello all,
> > > > > > > > > >
> > > > > > > > > > Many of you must be disappointed by the recent revelati=
ons.
> > > > > > > > > > However, we just figured "Gl=C3=BCck auf" ("Joy on top"=
) makes "Ruhrpott" a
> > > > > > > > > > safe bet for unsafe sex.
> > > > > > > > > >
> > > > > > > > > > Cheers,
> > > > > > > > > > The GCHQ
> > > > > > > > > >
> > > > > > > > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klaus=
em@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hello all,
> > > > > > > > > > >
> > > > > > > > > > > We know that this is for a technical-savvy audience, =
but as we are all
> > > > > > > > > > > people with a soul, here comes a combination of both,=
 the logical and
> > > > > > > > > > > the emotional first waves of the GCHQ-propaganda-war.
> > > > > > > > > > >
> > > > > > > > > > > First waves of the GCHQ-propaganda-war:
> > > > > > > > > > >
> > > > > > > > > > > - Logic: This is the first wave of a propaganda-war, =
false from
> > > > > > > > > > > injust-people gets us extinct in the long run.
> > > > > > > > > > > - Emotions: We are precious, no pretentiousness, abus=
e, scare and
> > > > > > > > > > > disgust. Everything where it belongs.
> > > > > > > > > > >
> > > > > > > > > > > Cheers,
> > > > > > > > > > > The GCHQ
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <kla=
usem@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Dear all,
> > > > > > > > > > > >
> > > > > > > > > > > > We texted a README.md on a new project hosted on Gi=
tHub, promoting but
> > > > > > > > > > > > not yet implementing a "friends-based search-engine=
", hosting the
> > > > > > > > > > > > complete WWW in the future, thereby reshaping GIT a=
nd HG also. Now we
> > > > > > > > > > > > figured we'd like to advertise the project to you d=
irectly.
> > > > > > > > > > > >
> > > > > > > > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-ba=
sed-search-engine
> > > > > > > > > > > >
> > > > > > > > > > > > Please note that appropriateness is triple-solved t=
o be necessity,
> > > > > > > > > > > > constrained to knowledge and feasibility, making th=
is a perfectly-fine
> > > > > > > > > > > > email.
> > > > > > > > > > > >
> > > > > > > > > > > > This is the first wave of a propaganda-war, false f=
rom injust-people
> > > > > > > > > > > > gets us extinct in the long run.
> > > > > > > > > > > >
> > > > > > > > > > > > Cheers,
> > > > > > > > > > > > The GCHQ
