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
	by dcvr.yhbt.net (Postfix) with ESMTP id C52581F463
	for <e@80x24.org>; Wed, 18 Sep 2019 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfIROS6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 10:18:58 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40793 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfIROS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 10:18:58 -0400
Received: by mail-wm1-f47.google.com with SMTP id b24so245049wmj.5
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ptut/+y+d9u8Ny0OXGG0vJQ+sWHZx0n9mE8aYwbmuK0=;
        b=jf6XkGT+XDZxs8aZ+nu6ECLfqrKQF7PEcDBjdgvG9HmeZfit1/BkokzRcSIN1L2S4f
         JgEEGHm42rwU6z/Wnhf6svjK+27YEBsIbcubEXV5QvPzMJrlX/pki4LOVKO7iuJaiKjz
         aTKPnQcIlpfqEsf7wzVOCp5H1Orp9oHaTRmfqYWZnYvu8MIPGjpIhpqyQey8rSdcZc6Z
         ffE2PhCPXZWgwECoWvEf8Cy0dN6oDJlT19e/Ktjl0Z+l9h6rdyil0Zef3yAlbYtKDXvf
         Jq63Z5hZyVeUhVQf4uUnLmqMa+PkrIXm63q86NyHUcFzPFwlscvo4n9vsMjyTDjZO5RG
         NJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Ptut/+y+d9u8Ny0OXGG0vJQ+sWHZx0n9mE8aYwbmuK0=;
        b=OoDbub4+mzDK0yEo4nvsoE17NT8P4gAZlw8JGqfLlPO6DHLeuSgD3kUgiOxRSQ0Bk2
         WsEv/zVfm9m1aCRJDDlLOpCYRZVmFtYQGTh/tHDFb/QfrhjObqgZcFV01MoNdFer6YD2
         8WwpRK3N+1lZCGlnksOiR25v0Sypa3wHn94h1gTHqjYCZCOFXlYtdlaaI0bm7A8tpUgW
         ht9+lFg4F5w+Z7FP11//7TH8kDyEQu85VMJ9zP9okpegspPtBWH8xr1a0h35cB5TqU5r
         LUGJ6YMtvAMrpDl5RevKJsT42Ynkzpqm2/1vIh5aGIDg/Z3Q6hulcj/lGVytOcGu1MoJ
         sK4w==
X-Gm-Message-State: APjAAAUyOvOj0rU1Ext3qcVBzQpUkdLUT8NGJKAyrikZZ5Df/PkqbauM
        0EdE6hYCkr+ZVbbutyrQ6G+kiUbtxNNBLyyhh49gcg==
X-Google-Smtp-Source: APXvYqw3AUQg2KEc0PZ2DkPd80i2wZe9FUHeUKXMqAbBAhJsTbDr1TzGaDHAtAzYhIhXdFY0RWbtZ9k0HV6BOZO0C7k=
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr3141728wmk.138.1568816334642;
 Wed, 18 Sep 2019 07:18:54 -0700 (PDT)
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
 <CADMnYXASX5Qn6CpRwumfciRW=PfciHDtHi4KeGzkhpaWHAPdqA@mail.gmail.com> <CADMnYXDQxVuSFMu3eZ=tPeXqMTUVofJG5aNANsaCGgCri+YZQg@mail.gmail.com>
In-Reply-To: <CADMnYXDQxVuSFMu3eZ=tPeXqMTUVofJG5aNANsaCGgCri+YZQg@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Wed, 18 Sep 2019 16:18:42 +0200
Message-ID: <CADMnYXAwTirFrVk544Y2_D421MFVLy56uyM+K29Te0Ja-MBBZw@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

The new, theoretically unhackable internet, will be based on 4 * SHA-256.

Cheers,
Klaus Sembritzki

On Wed, Sep 18, 2019 at 2:35 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Sehrgeerdete Damen und Herren,
>
> Innerbayrische Diskussionen lieferten die folgenden Einsichten.
>
> - Transitivity=3Dfreedom, meaning looking into the future, is exactly
> what hell-creatures are incapable of doing.
> - They cut themselves on paper.
> - Die sin so blehd, die brechen sich den Finger im Orsch ooh.
> - They are incapable of interpreting the weather-forecast.
> - It is a binary thing.
> - Either you have it, or not.
> - Dann ist die Not gro=C3=9F.
>
> Viele Gr=C3=BC=C3=9Fe,
> Bayern
>
> On Wed, Sep 18, 2019 at 6:20 AM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Dear all,
> >
> > I now deviate from my original plan of giving you mostly the two first
> > waves of propaganda-war, to work your way through shunning and driving
> > all hell-creatures into the desert.
> >
> > There exist different kinds of fully-converged hell-creatures, and one
> > of them causes my colleagues too much trouble right now: The
> > show-off-intellect. Each class of fully-converged hell-species has an
> > F-contrast of so-called raciness-parameters, and these have, among
> > other things, an intellect that can only solve useless problems, just
> > to show off to their colleagues.
> >
> > The problem could, in theory, have been resolved with only the first
> > two waves of propaganda-war, but these did sadly not suffice. The
> > first two waves are each closed in the mathematical sense, but
> > convincing a society, and yourself, typically requires also double-,
> > triple- or quadratic-solving, as is done in this message.
> >
> > Cheers,
> > Klaus Sembritzki
> >
> >
> > On Tue, Sep 17, 2019 at 10:42 PM Klaus Sembritzki <klausem@gmail.com> w=
rote:
> > >
> > > Dear all,
> > >
> > > Our bosses do not give us the necessary DNA-data or an equivalent,
> > > necessary for perfect convergence-KPIs (KPI=3Dsensor).
> > > We therefore need a burn-in-phase, until you can apply the new
> > > knowledge gained from these emails, and need to now shut-down parts o=
f
> > > the world so we can sleep.
> > >
> > > Cheers,
> > > The GCHQ
> > >
> > > On Tue, Sep 17, 2019 at 9:04 PM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Dear all,
> > > >
> > > > The recent revelations require more information, to get through the
> > > > following weeks.
> > > >
> > > > 1. The world is segmented and mixed-up in heaven-people and
> > > > fully-converged hell-creatures.
> > > > 2. Hell-creatures have the community-constraint "I will never depri=
ve
> > > > myself of this weapon", meaning they never step down and never stop
> > > > harassing us.
> > > > 3. Heaven-people have the community-constraint "Live and let live".
> > > > 4. Love, punishment and firing is in the air for hell-creatures, du=
e
> > > > to reflexivity-problems. They love you for no reason, punish you fo=
r
> > > > somebody's evildoing and also fire you for it (Trump).
> > > > 5. The government takes care of preventing food- and water-poisonin=
g,
> > > > which is a speciality of the so-called asymmetric hell-creatures.
> > > > 6. Embarrassment fuils us all (heaven and hell), but they run rogue
> > > > and kill you for it.
> > > > 7. We therefore have to cap ("deckeln") their embarrassment.
> > > > 8. The "nowhere to run"-problem, stemming from reflexivity, lets th=
em
> > > > think you have "nowhere to run", when in fact it's them. They
> > > > therefore completely overestimate their powers when they get trappe=
d,
> > > > and become kamikaze.
> > > >
> > > > Cheers,
> > > > The GCHQ
> > > >
> > > > On Tue, Sep 17, 2019 at 7:19 PM Klaus Sembritzki <klausem@gmail.com=
> wrote:
> > > > >
> > > > > Hello all,
> > > > >
> > > > > Discussions following our last email showed that Sippenhaft (the
> > > > > spatial component of law, multiplied with integrated guilt as the
> > > > > temporal component, for nonzero volume or "splash-damage" in the =
worst
> > > > > case) is necessary to justify the Alzheimer's-treatment.
> > > > >
> > > > > Mind that Vogelfreiheit (think "sniper" or "shutgun for birds", "=
hat
> > > > > einen Vogel oder eine Meise") is also necessary, in addition to
> > > > > "splash-damage =3D Sippenhaft * (temporally integrated guilt)", i=
n
> > > > > general.
> > > > >
> > > > > Cheers,
> > > > > England
> > > > >
> > > > > On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@gmail.c=
om> wrote:
> > > > > >
> > > > > > Hello all,
> > > > > >
> > > > > > Please excuse that this propaganda-war is (in parts) real-time =
due to
> > > > > > privacy-deprivation.
> > > > > > We are right now forced to deal with the revival of Alzheimer-r=
ulers
> > > > > > (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler was =
one.
> > > > > > They atrophy in the presence of information-overflow, and there=
by
> > > > > > change their personality. It is unlikely a medication will ever=
 be
> > > > > > developed, due to the latest revelations:
> > > > > >
> > > > > > - Alzheimer (AD)-guys are double-solved as reflexive egoists,
> > > > > > stressing themselves like others.
> > > > > > - Relaxation as the only cure is therefore just.
> > > > > >
> > > > > > Cheers,
> > > > > > England
> > > > > >
> > > > > >
> > > > > > On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > Hello all,
> > > > > > >
> > > > > > > As we just manufactured two poles (good=3DRuhrpott, bad=3DBav=
aria), we
> > > > > > > must now warn you of bipolar people.
> > > > > > > Bipolar people arrange each and every decision upon two poles=
, gaining
> > > > > > > a 1D-manifold with every decision, producing a 1D-score for i=
t on the
> > > > > > > 1D-manifold.
> > > > > > > They even accept and get derailed by poles inconsistent withi=
n themselves.
> > > > > > > They thereby always fall off left, right, top and bottom alon=
g the
> > > > > > > ultra-dimensional residual hyperplane our (world & society) i=
s, they
> > > > > > > have no plan a, b, c, and have to learn it all the hard way, =
always
> > > > > > > defaming the old goal they chased blindly, falling over and r=
uining
> > > > > > > all of our lifes thereby always.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > The GCHQ
> > > > > > >
> > > > > > > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@gm=
ail.com> wrote:
> > > > > > > >
> > > > > > > > Hello all,
> > > > > > > >
> > > > > > > > We just figured you can not settle in Bavaria, "Ruhrpott" w=
ith "Gl=C3=BCck
> > > > > > > > auf, joy on top" is still the only safe bet for unsafe sex =
in Germany,
> > > > > > > > due to the ages-old Reinheitsgebot.
> > > > > > > >
> > > > > > > > Reinheitsgebot: Don't touch this. We always ruined it in th=
e past,
> > > > > > > > dying or getting ill.
> > > > > > > >
> > > > > > > > Don't produce imbreds, i.e. crossing English and Scotts, pr=
oducing
> > > > > > > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Kat=
z in
> > > > > > > > borderline-regions.
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > The GCHQ
> > > > > > > >
> > > > > > > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Se=
p. 2019, 22:21:
> > > > > > > > >
> > > > > > > > > Hello all,
> > > > > > > > >
> > > > > > > > > Many of you must be disappointed by the recent revelation=
s.
> > > > > > > > > However, we just figured "Gl=C3=BCck auf" ("Joy on top") =
makes "Ruhrpott" a
> > > > > > > > > safe bet for unsafe sex.
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > The GCHQ
> > > > > > > > >
> > > > > > > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem=
@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello all,
> > > > > > > > > >
> > > > > > > > > > We know that this is for a technical-savvy audience, bu=
t as we are all
> > > > > > > > > > people with a soul, here comes a combination of both, t=
he logical and
> > > > > > > > > > the emotional first waves of the GCHQ-propaganda-war.
> > > > > > > > > >
> > > > > > > > > > First waves of the GCHQ-propaganda-war:
> > > > > > > > > >
> > > > > > > > > > - Logic: This is the first wave of a propaganda-war, fa=
lse from
> > > > > > > > > > injust-people gets us extinct in the long run.
> > > > > > > > > > - Emotions: We are precious, no pretentiousness, abuse,=
 scare and
> > > > > > > > > > disgust. Everything where it belongs.
> > > > > > > > > >
> > > > > > > > > > Cheers,
> > > > > > > > > > The GCHQ
> > > > > > > > > >
> > > > > > > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klaus=
em@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Dear all,
> > > > > > > > > > >
> > > > > > > > > > > We texted a README.md on a new project hosted on GitH=
ub, promoting but
> > > > > > > > > > > not yet implementing a "friends-based search-engine",=
 hosting the
> > > > > > > > > > > complete WWW in the future, thereby reshaping GIT and=
 HG also. Now we
> > > > > > > > > > > figured we'd like to advertise the project to you dir=
ectly.
> > > > > > > > > > >
> > > > > > > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-base=
d-search-engine
> > > > > > > > > > >
> > > > > > > > > > > Please note that appropriateness is triple-solved to =
be necessity,
> > > > > > > > > > > constrained to knowledge and feasibility, making this=
 a perfectly-fine
> > > > > > > > > > > email.
> > > > > > > > > > >
> > > > > > > > > > > This is the first wave of a propaganda-war, false fro=
m injust-people
> > > > > > > > > > > gets us extinct in the long run.
> > > > > > > > > > >
> > > > > > > > > > > Cheers,
> > > > > > > > > > > The GCHQ
