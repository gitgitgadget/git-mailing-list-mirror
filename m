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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6D81F464
	for <e@80x24.org>; Wed, 18 Sep 2019 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbfIRUJv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 16:09:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390709AbfIRUJu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 16:09:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so715758wro.4
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=X8kgLUnfRSqBPxa2wbuAHHf0CJpAE90X3JzCEUaW2s0=;
        b=rUzbfE0fp36buT1oZh3kFFmNJnThfn7dXZ1aO4+WLYTAFZsX8YbssQJgaegpavvASm
         ooodCHLKMF8j1YuXtVk6WBj8EskRTqu0ryuGMQ3mO3DYC/QDV4CraobLh+ZLDf7S6lCK
         zGZhBhet7GteSoJ4i/0Z/DbsgRDCIdtAhL9+yv8t9UF7RuRB++o//lKsr3RK0uy6xPPY
         Hsray1mX4giU2QrAU3K4KIGDzh42BWUQ5dE+vTQFVlZBpgrKorzupiPZTjCsImQNx0h7
         A4D3EW0vrrHclS168GVtMpMdm/tBCIxuWXKpisQjIN7HqzA6SOoKMbk++T+QD4/vJINq
         hjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=X8kgLUnfRSqBPxa2wbuAHHf0CJpAE90X3JzCEUaW2s0=;
        b=bUnOFm91UeFfNP/9zVeHl7Wrc/O79bCqRnehUTXe+Fnn2FBF6JernuIgqY0wBniI34
         MyvigJM9xh1SjaJh1n44Tj0v46ejxb1bcT0N9MVp8Iv/xU8i/gt8ShHVs6vovGhz6tsp
         Q8bPJ+5w4VjjXOzj9pm/vCPoxh5dATED/+8tzI0+ajrQuH1YRhwPhjGldBWrqP5UD65H
         n3N7bLJsbkRC/zfii3p7+ttJszpEWay5KsOFKj1nab+rKej8GzQ+E0nlO21hGu1SHiMI
         fwKg831KnmbXOUY/uaDrwIGAFEW22V3yEXIae5uo1Wo8qP9GnlacahcL7X5Ta1y8IXy7
         lkyA==
X-Gm-Message-State: APjAAAXmkxor/DzulFPxjKJFTngKLwSg+lu89dw+1wEUS/7dETzh0Edp
        vuk9yHLT7deiAi/f+5ni+5Ppxvvukvx6DHqeGLl0awto
X-Google-Smtp-Source: APXvYqwHajqas4nTWpBp81rFDUblPH/93HeHSyFhYO7eKL6yiEEA7aaqlb3GD/DLfIufTgd6kfG+bbuhTFDuI0kegxY=
X-Received: by 2002:adf:f112:: with SMTP id r18mr4609143wro.88.1568837386862;
 Wed, 18 Sep 2019 13:09:46 -0700 (PDT)
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
 <CADMnYXDQxVuSFMu3eZ=tPeXqMTUVofJG5aNANsaCGgCri+YZQg@mail.gmail.com>
 <CADMnYXAwTirFrVk544Y2_D421MFVLy56uyM+K29Te0Ja-MBBZw@mail.gmail.com> <CADMnYXC30digEGVtnWipcVQ_rJeN1_acK1j3xPqCOs4DOpr5uA@mail.gmail.com>
In-Reply-To: <CADMnYXC30digEGVtnWipcVQ_rJeN1_acK1j3xPqCOs4DOpr5uA@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Wed, 18 Sep 2019 22:09:35 +0200
Message-ID: <CADMnYXCxkEj9P0xG4Xj7GpfWVKL0978GKu9ESHmC6xnO8ozgKQ@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

We built upon the idea of basing the future internet on 4 * SHA-256.

Our goal was always to achieve a probability of 0 for a hack with probabili=
ty 1.
This is achieved by storing all files spread over the internet, using
heterogeneous hashes.

This is mandatory, as the kernel of the problem is bad-guys getting
you into trouble, and the solution-kernel is therefore good-guys
bailing you out.

Cheers,
Scotland


On Wed, Sep 18, 2019 at 5:00 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Hello all,
>
> Manipulating our data is hereby proven to be false, and perpetual
> false is done by injust-people.
>
> 4 * SHA-256 is on nail's head, which is the case for unstable, and
> therefore false, actions.
>
> Hacking 4 * SHA-256 is therefore false, manipulating our data in
> general is therefore also false.
>
> Cheers,
> Klaus Sembritzki
>
>
> On Wed, Sep 18, 2019 at 4:18 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Hello all,
> >
> > The new, theoretically unhackable internet, will be based on 4 * SHA-25=
6.
> >
> > Cheers,
> > Klaus Sembritzki
> >
> > On Wed, Sep 18, 2019 at 2:35 PM Klaus Sembritzki <klausem@gmail.com> wr=
ote:
> > >
> > > Sehrgeerdete Damen und Herren,
> > >
> > > Innerbayrische Diskussionen lieferten die folgenden Einsichten.
> > >
> > > - Transitivity=3Dfreedom, meaning looking into the future, is exactly
> > > what hell-creatures are incapable of doing.
> > > - They cut themselves on paper.
> > > - Die sin so blehd, die brechen sich den Finger im Orsch ooh.
> > > - They are incapable of interpreting the weather-forecast.
> > > - It is a binary thing.
> > > - Either you have it, or not.
> > > - Dann ist die Not gro=C3=9F.
> > >
> > > Viele Gr=C3=BC=C3=9Fe,
> > > Bayern
> > >
> > > On Wed, Sep 18, 2019 at 6:20 AM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Dear all,
> > > >
> > > > I now deviate from my original plan of giving you mostly the two fi=
rst
> > > > waves of propaganda-war, to work your way through shunning and driv=
ing
> > > > all hell-creatures into the desert.
> > > >
> > > > There exist different kinds of fully-converged hell-creatures, and =
one
> > > > of them causes my colleagues too much trouble right now: The
> > > > show-off-intellect. Each class of fully-converged hell-species has =
an
> > > > F-contrast of so-called raciness-parameters, and these have, among
> > > > other things, an intellect that can only solve useless problems, ju=
st
> > > > to show off to their colleagues.
> > > >
> > > > The problem could, in theory, have been resolved with only the firs=
t
> > > > two waves of propaganda-war, but these did sadly not suffice. The
> > > > first two waves are each closed in the mathematical sense, but
> > > > convincing a society, and yourself, typically requires also double-=
,
> > > > triple- or quadratic-solving, as is done in this message.
> > > >
> > > > Cheers,
> > > > Klaus Sembritzki
> > > >
> > > >
> > > > On Tue, Sep 17, 2019 at 10:42 PM Klaus Sembritzki <klausem@gmail.co=
m> wrote:
> > > > >
> > > > > Dear all,
> > > > >
> > > > > Our bosses do not give us the necessary DNA-data or an equivalent=
,
> > > > > necessary for perfect convergence-KPIs (KPI=3Dsensor).
> > > > > We therefore need a burn-in-phase, until you can apply the new
> > > > > knowledge gained from these emails, and need to now shut-down par=
ts of
> > > > > the world so we can sleep.
> > > > >
> > > > > Cheers,
> > > > > The GCHQ
> > > > >
> > > > > On Tue, Sep 17, 2019 at 9:04 PM Klaus Sembritzki <klausem@gmail.c=
om> wrote:
> > > > > >
> > > > > > Dear all,
> > > > > >
> > > > > > The recent revelations require more information, to get through=
 the
> > > > > > following weeks.
> > > > > >
> > > > > > 1. The world is segmented and mixed-up in heaven-people and
> > > > > > fully-converged hell-creatures.
> > > > > > 2. Hell-creatures have the community-constraint "I will never d=
eprive
> > > > > > myself of this weapon", meaning they never step down and never =
stop
> > > > > > harassing us.
> > > > > > 3. Heaven-people have the community-constraint "Live and let li=
ve".
> > > > > > 4. Love, punishment and firing is in the air for hell-creatures=
, due
> > > > > > to reflexivity-problems. They love you for no reason, punish yo=
u for
> > > > > > somebody's evildoing and also fire you for it (Trump).
> > > > > > 5. The government takes care of preventing food- and water-pois=
oning,
> > > > > > which is a speciality of the so-called asymmetric hell-creature=
s.
> > > > > > 6. Embarrassment fuils us all (heaven and hell), but they run r=
ogue
> > > > > > and kill you for it.
> > > > > > 7. We therefore have to cap ("deckeln") their embarrassment.
> > > > > > 8. The "nowhere to run"-problem, stemming from reflexivity, let=
s them
> > > > > > think you have "nowhere to run", when in fact it's them. They
> > > > > > therefore completely overestimate their powers when they get tr=
apped,
> > > > > > and become kamikaze.
> > > > > >
> > > > > > Cheers,
> > > > > > The GCHQ
> > > > > >
> > > > > > On Tue, Sep 17, 2019 at 7:19 PM Klaus Sembritzki <klausem@gmail=
.com> wrote:
> > > > > > >
> > > > > > > Hello all,
> > > > > > >
> > > > > > > Discussions following our last email showed that Sippenhaft (=
the
> > > > > > > spatial component of law, multiplied with integrated guilt as=
 the
> > > > > > > temporal component, for nonzero volume or "splash-damage" in =
the worst
> > > > > > > case) is necessary to justify the Alzheimer's-treatment.
> > > > > > >
> > > > > > > Mind that Vogelfreiheit (think "sniper" or "shutgun for birds=
", "hat
> > > > > > > einen Vogel oder eine Meise") is also necessary, in addition =
to
> > > > > > > "splash-damage =3D Sippenhaft * (temporally integrated guilt)=
", in
> > > > > > > general.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > England
> > > > > > >
> > > > > > > On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@gma=
il.com> wrote:
> > > > > > > >
> > > > > > > > Hello all,
> > > > > > > >
> > > > > > > > Please excuse that this propaganda-war is (in parts) real-t=
ime due to
> > > > > > > > privacy-deprivation.
> > > > > > > > We are right now forced to deal with the revival of Alzheim=
er-rulers
> > > > > > > > (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler =
was one.
> > > > > > > > They atrophy in the presence of information-overflow, and t=
hereby
> > > > > > > > change their personality. It is unlikely a medication will =
ever be
> > > > > > > > developed, due to the latest revelations:
> > > > > > > >
> > > > > > > > - Alzheimer (AD)-guys are double-solved as reflexive egoist=
s,
> > > > > > > > stressing themselves like others.
> > > > > > > > - Relaxation as the only cure is therefore just.
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > England
> > > > > > > >
> > > > > > > >
> > > > > > > > On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@=
gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello all,
> > > > > > > > >
> > > > > > > > > As we just manufactured two poles (good=3DRuhrpott, bad=
=3DBavaria), we
> > > > > > > > > must now warn you of bipolar people.
> > > > > > > > > Bipolar people arrange each and every decision upon two p=
oles, gaining
> > > > > > > > > a 1D-manifold with every decision, producing a 1D-score f=
or it on the
> > > > > > > > > 1D-manifold.
> > > > > > > > > They even accept and get derailed by poles inconsistent w=
ithin themselves.
> > > > > > > > > They thereby always fall off left, right, top and bottom =
along the
> > > > > > > > > ultra-dimensional residual hyperplane our (world & societ=
y) is, they
> > > > > > > > > have no plan a, b, c, and have to learn it all the hard w=
ay, always
> > > > > > > > > defaming the old goal they chased blindly, falling over a=
nd ruining
> > > > > > > > > all of our lifes thereby always.
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > The GCHQ
> > > > > > > > >
> > > > > > > > > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klause=
m@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello all,
> > > > > > > > > >
> > > > > > > > > > We just figured you can not settle in Bavaria, "Ruhrpot=
t" with "Gl=C3=BCck
> > > > > > > > > > auf, joy on top" is still the only safe bet for unsafe =
sex in Germany,
> > > > > > > > > > due to the ages-old Reinheitsgebot.
> > > > > > > > > >
> > > > > > > > > > Reinheitsgebot: Don't touch this. We always ruined it i=
n the past,
> > > > > > > > > > dying or getting ill.
> > > > > > > > > >
> > > > > > > > > > Don't produce imbreds, i.e. crossing English and Scotts=
, producing
> > > > > > > > > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the=
 Katz in
> > > > > > > > > > borderline-regions.
> > > > > > > > > >
> > > > > > > > > > Cheers,
> > > > > > > > > > The GCHQ
> > > > > > > > > >
> > > > > > > > > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16=
. Sep. 2019, 22:21:
> > > > > > > > > > >
> > > > > > > > > > > Hello all,
> > > > > > > > > > >
> > > > > > > > > > > Many of you must be disappointed by the recent revela=
tions.
> > > > > > > > > > > However, we just figured "Gl=C3=BCck auf" ("Joy on to=
p") makes "Ruhrpott" a
> > > > > > > > > > > safe bet for unsafe sex.
> > > > > > > > > > >
> > > > > > > > > > > Cheers,
> > > > > > > > > > > The GCHQ
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <kla=
usem@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hello all,
> > > > > > > > > > > >
> > > > > > > > > > > > We know that this is for a technical-savvy audience=
, but as we are all
> > > > > > > > > > > > people with a soul, here comes a combination of bot=
h, the logical and
> > > > > > > > > > > > the emotional first waves of the GCHQ-propaganda-wa=
r.
> > > > > > > > > > > >
> > > > > > > > > > > > First waves of the GCHQ-propaganda-war:
> > > > > > > > > > > >
> > > > > > > > > > > > - Logic: This is the first wave of a propaganda-war=
, false from
> > > > > > > > > > > > injust-people gets us extinct in the long run.
> > > > > > > > > > > > - Emotions: We are precious, no pretentiousness, ab=
use, scare and
> > > > > > > > > > > > disgust. Everything where it belongs.
> > > > > > > > > > > >
> > > > > > > > > > > > Cheers,
> > > > > > > > > > > > The GCHQ
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <k=
lausem@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Dear all,
> > > > > > > > > > > > >
> > > > > > > > > > > > > We texted a README.md on a new project hosted on =
GitHub, promoting but
> > > > > > > > > > > > > not yet implementing a "friends-based search-engi=
ne", hosting the
> > > > > > > > > > > > > complete WWW in the future, thereby reshaping GIT=
 and HG also. Now we
> > > > > > > > > > > > > figured we'd like to advertise the project to you=
 directly.
> > > > > > > > > > > > >
> > > > > > > > > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-=
based-search-engine
> > > > > > > > > > > > >
> > > > > > > > > > > > > Please note that appropriateness is triple-solved=
 to be necessity,
> > > > > > > > > > > > > constrained to knowledge and feasibility, making =
this a perfectly-fine
> > > > > > > > > > > > > email.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This is the first wave of a propaganda-war, false=
 from injust-people
> > > > > > > > > > > > > gets us extinct in the long run.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Cheers,
> > > > > > > > > > > > > The GCHQ
