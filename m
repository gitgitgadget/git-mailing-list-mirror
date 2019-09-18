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
	by dcvr.yhbt.net (Postfix) with ESMTP id E23BB1F463
	for <e@80x24.org>; Wed, 18 Sep 2019 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfIRUso (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 16:48:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52052 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfIRUsn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 16:48:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so1704494wme.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xFbSSFBPWEK9+3lPPF9icmiTeOFVjCuIMwvWHpCxMAk=;
        b=t51xqp26Wxz9/+X5mG37tfZcIgfS3qgl98GVrfRFWgw0xQE+bDcIy9Uh8MjJYepNaV
         eb0fsTXj/ZKRI7m/brsjiGR3VeNRsHQkDK61uuIgKZuzVi3R7bo2tlatncmu/UgEg0Ln
         6djn2vKgsPls4yZCjOx45HJPfubSP98QoklV926+3X5GrcgITRSU+A6Rv/tJqwC1x+fj
         XDUAYv+r+gzIAwqkYGqit9n52teu4N3vO9yhrvP8xprHNjOsQ3/I5oIfxuV3SXoT/0Tf
         OxaifOtJs0SJEHOYbeWAHzzcQNY4KOI+7QbgJdI9vNNp3NoaMuExq02ga/9mRoSFdmQ1
         7Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=xFbSSFBPWEK9+3lPPF9icmiTeOFVjCuIMwvWHpCxMAk=;
        b=b2dKtYNuE8CSIUvenvxKrOPg5uJKixEEhveJCr0Ox3N/FvI5NqTXv+YQin+85EvPWc
         8rB7lbrI8ZsjHW/uOtuNLbCpuHq0cRXhk17ygVsFj65FIKuDKlyc3PaI8Y7UD8Lu5mRr
         kLNdX0szT/YPjNGz2CQ9aTDUxwznyBsrCp7vK+MbiOx3NT3yCRyBv3RRfkwe7zVxf+sR
         zDz2+/DJIvsb48sttG5+bwG5e/wM8ikMwLBVWEm53HAzdiif4Ckw1FTeStrNod2fq39i
         9+K2vkZUZTSz8YTqjrV2x9DhYRcBsrYQ9Q766FtG7d996Tl5sdTfHD/G7i4Wqx3c7udp
         153g==
X-Gm-Message-State: APjAAAVAtgD65kF/EPsIPZRP0u+Go11vkfaqFsd9NTtpNC3UQT+PAoV8
        uOwL141dpHhACD0fVCM3moUR1IDQ1DyS/qAMYrheIw==
X-Google-Smtp-Source: APXvYqx5gyUtxbvvqgbZpD3Ou0ikocEeRyAQ5geQJPZL6X91Y4SekU5xK+ZPyfpaHSdRjAzUpYQJ3gYG9fm/LM8WEDg=
X-Received: by 2002:a1c:f317:: with SMTP id q23mr4198432wmq.33.1568839719411;
 Wed, 18 Sep 2019 13:48:39 -0700 (PDT)
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
 <CADMnYXAwTirFrVk544Y2_D421MFVLy56uyM+K29Te0Ja-MBBZw@mail.gmail.com>
 <CADMnYXC30digEGVtnWipcVQ_rJeN1_acK1j3xPqCOs4DOpr5uA@mail.gmail.com> <CADMnYXCxkEj9P0xG4Xj7GpfWVKL0978GKu9ESHmC6xnO8ozgKQ@mail.gmail.com>
In-Reply-To: <CADMnYXCxkEj9P0xG4Xj7GpfWVKL0978GKu9ESHmC6xnO8ozgKQ@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Wed, 18 Sep 2019 22:48:27 +0200
Message-ID: <CADMnYXARNbx9hp=0SzUUyQV9EN3aZ=dxXdZwftWxsRX=GNGZmQ@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please read the 8-point survival-sheet of a few days ago now.
Don't forget about food- and water-poisoning.

On Wed, Sep 18, 2019 at 10:09 PM Klaus Sembritzki <klausem@gmail.com> wrote=
:
>
> Hello all,
>
> We built upon the idea of basing the future internet on 4 * SHA-256.
>
> Our goal was always to achieve a probability of 0 for a hack with probabi=
lity 1.
> This is achieved by storing all files spread over the internet, using
> heterogeneous hashes.
>
> This is mandatory, as the kernel of the problem is bad-guys getting
> you into trouble, and the solution-kernel is therefore good-guys
> bailing you out.
>
> Cheers,
> Scotland
>
>
> On Wed, Sep 18, 2019 at 5:00 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Hello all,
> >
> > Manipulating our data is hereby proven to be false, and perpetual
> > false is done by injust-people.
> >
> > 4 * SHA-256 is on nail's head, which is the case for unstable, and
> > therefore false, actions.
> >
> > Hacking 4 * SHA-256 is therefore false, manipulating our data in
> > general is therefore also false.
> >
> > Cheers,
> > Klaus Sembritzki
> >
> >
> > On Wed, Sep 18, 2019 at 4:18 PM Klaus Sembritzki <klausem@gmail.com> wr=
ote:
> > >
> > > Hello all,
> > >
> > > The new, theoretically unhackable internet, will be based on 4 * SHA-=
256.
> > >
> > > Cheers,
> > > Klaus Sembritzki
> > >
> > > On Wed, Sep 18, 2019 at 2:35 PM Klaus Sembritzki <klausem@gmail.com> =
wrote:
> > > >
> > > > Sehrgeerdete Damen und Herren,
> > > >
> > > > Innerbayrische Diskussionen lieferten die folgenden Einsichten.
> > > >
> > > > - Transitivity=3Dfreedom, meaning looking into the future, is exact=
ly
> > > > what hell-creatures are incapable of doing.
> > > > - They cut themselves on paper.
> > > > - Die sin so blehd, die brechen sich den Finger im Orsch ooh.
> > > > - They are incapable of interpreting the weather-forecast.
> > > > - It is a binary thing.
> > > > - Either you have it, or not.
> > > > - Dann ist die Not gro=C3=9F.
> > > >
> > > > Viele Gr=C3=BC=C3=9Fe,
> > > > Bayern
> > > >
> > > > On Wed, Sep 18, 2019 at 6:20 AM Klaus Sembritzki <klausem@gmail.com=
> wrote:
> > > > >
> > > > > Dear all,
> > > > >
> > > > > I now deviate from my original plan of giving you mostly the two =
first
> > > > > waves of propaganda-war, to work your way through shunning and dr=
iving
> > > > > all hell-creatures into the desert.
> > > > >
> > > > > There exist different kinds of fully-converged hell-creatures, an=
d one
> > > > > of them causes my colleagues too much trouble right now: The
> > > > > show-off-intellect. Each class of fully-converged hell-species ha=
s an
> > > > > F-contrast of so-called raciness-parameters, and these have, amon=
g
> > > > > other things, an intellect that can only solve useless problems, =
just
> > > > > to show off to their colleagues.
> > > > >
> > > > > The problem could, in theory, have been resolved with only the fi=
rst
> > > > > two waves of propaganda-war, but these did sadly not suffice. The
> > > > > first two waves are each closed in the mathematical sense, but
> > > > > convincing a society, and yourself, typically requires also doubl=
e-,
> > > > > triple- or quadratic-solving, as is done in this message.
> > > > >
> > > > > Cheers,
> > > > > Klaus Sembritzki
> > > > >
> > > > >
> > > > > On Tue, Sep 17, 2019 at 10:42 PM Klaus Sembritzki <klausem@gmail.=
com> wrote:
> > > > > >
> > > > > > Dear all,
> > > > > >
> > > > > > Our bosses do not give us the necessary DNA-data or an equivale=
nt,
> > > > > > necessary for perfect convergence-KPIs (KPI=3Dsensor).
> > > > > > We therefore need a burn-in-phase, until you can apply the new
> > > > > > knowledge gained from these emails, and need to now shut-down p=
arts of
> > > > > > the world so we can sleep.
> > > > > >
> > > > > > Cheers,
> > > > > > The GCHQ
> > > > > >
> > > > > > On Tue, Sep 17, 2019 at 9:04 PM Klaus Sembritzki <klausem@gmail=
.com> wrote:
> > > > > > >
> > > > > > > Dear all,
> > > > > > >
> > > > > > > The recent revelations require more information, to get throu=
gh the
> > > > > > > following weeks.
> > > > > > >
> > > > > > > 1. The world is segmented and mixed-up in heaven-people and
> > > > > > > fully-converged hell-creatures.
> > > > > > > 2. Hell-creatures have the community-constraint "I will never=
 deprive
> > > > > > > myself of this weapon", meaning they never step down and neve=
r stop
> > > > > > > harassing us.
> > > > > > > 3. Heaven-people have the community-constraint "Live and let =
live".
> > > > > > > 4. Love, punishment and firing is in the air for hell-creatur=
es, due
> > > > > > > to reflexivity-problems. They love you for no reason, punish =
you for
> > > > > > > somebody's evildoing and also fire you for it (Trump).
> > > > > > > 5. The government takes care of preventing food- and water-po=
isoning,
> > > > > > > which is a speciality of the so-called asymmetric hell-creatu=
res.
> > > > > > > 6. Embarrassment fuils us all (heaven and hell), but they run=
 rogue
> > > > > > > and kill you for it.
> > > > > > > 7. We therefore have to cap ("deckeln") their embarrassment.
> > > > > > > 8. The "nowhere to run"-problem, stemming from reflexivity, l=
ets them
> > > > > > > think you have "nowhere to run", when in fact it's them. They
> > > > > > > therefore completely overestimate their powers when they get =
trapped,
> > > > > > > and become kamikaze.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > The GCHQ
> > > > > > >
> > > > > > > On Tue, Sep 17, 2019 at 7:19 PM Klaus Sembritzki <klausem@gma=
il.com> wrote:
> > > > > > > >
> > > > > > > > Hello all,
> > > > > > > >
> > > > > > > > Discussions following our last email showed that Sippenhaft=
 (the
> > > > > > > > spatial component of law, multiplied with integrated guilt =
as the
> > > > > > > > temporal component, for nonzero volume or "splash-damage" i=
n the worst
> > > > > > > > case) is necessary to justify the Alzheimer's-treatment.
> > > > > > > >
> > > > > > > > Mind that Vogelfreiheit (think "sniper" or "shutgun for bir=
ds", "hat
> > > > > > > > einen Vogel oder eine Meise") is also necessary, in additio=
n to
> > > > > > > > "splash-damage =3D Sippenhaft * (temporally integrated guil=
t)", in
> > > > > > > > general.
> > > > > > > >
> > > > > > > > Cheers,
> > > > > > > > England
> > > > > > > >
> > > > > > > > On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@g=
mail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello all,
> > > > > > > > >
> > > > > > > > > Please excuse that this propaganda-war is (in parts) real=
-time due to
> > > > > > > > > privacy-deprivation.
> > > > > > > > > We are right now forced to deal with the revival of Alzhe=
imer-rulers
> > > > > > > > > (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitle=
r was one.
> > > > > > > > > They atrophy in the presence of information-overflow, and=
 thereby
> > > > > > > > > change their personality. It is unlikely a medication wil=
l ever be
> > > > > > > > > developed, due to the latest revelations:
> > > > > > > > >
> > > > > > > > > - Alzheimer (AD)-guys are double-solved as reflexive egoi=
sts,
> > > > > > > > > stressing themselves like others.
> > > > > > > > > - Relaxation as the only cure is therefore just.
> > > > > > > > >
> > > > > > > > > Cheers,
> > > > > > > > > England
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klause=
m@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello all,
> > > > > > > > > >
> > > > > > > > > > As we just manufactured two poles (good=3DRuhrpott, bad=
=3DBavaria), we
> > > > > > > > > > must now warn you of bipolar people.
> > > > > > > > > > Bipolar people arrange each and every decision upon two=
 poles, gaining
> > > > > > > > > > a 1D-manifold with every decision, producing a 1D-score=
 for it on the
> > > > > > > > > > 1D-manifold.
> > > > > > > > > > They even accept and get derailed by poles inconsistent=
 within themselves.
> > > > > > > > > > They thereby always fall off left, right, top and botto=
m along the
> > > > > > > > > > ultra-dimensional residual hyperplane our (world & soci=
ety) is, they
> > > > > > > > > > have no plan a, b, c, and have to learn it all the hard=
 way, always
> > > > > > > > > > defaming the old goal they chased blindly, falling over=
 and ruining
> > > > > > > > > > all of our lifes thereby always.
> > > > > > > > > >
> > > > > > > > > > Cheers,
> > > > > > > > > > The GCHQ
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klau=
sem@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hello all,
> > > > > > > > > > >
> > > > > > > > > > > We just figured you can not settle in Bavaria, "Ruhrp=
ott" with "Gl=C3=BCck
> > > > > > > > > > > auf, joy on top" is still the only safe bet for unsaf=
e sex in Germany,
> > > > > > > > > > > due to the ages-old Reinheitsgebot.
> > > > > > > > > > >
> > > > > > > > > > > Reinheitsgebot: Don't touch this. We always ruined it=
 in the past,
> > > > > > > > > > > dying or getting ill.
> > > > > > > > > > >
> > > > > > > > > > > Don't produce imbreds, i.e. crossing English and Scot=
ts, producing
> > > > > > > > > > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking t=
he Katz in
> > > > > > > > > > > borderline-regions.
> > > > > > > > > > >
> > > > > > > > > > > Cheers,
> > > > > > > > > > > The GCHQ
> > > > > > > > > > >
> > > > > > > > > > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., =
16. Sep. 2019, 22:21:
> > > > > > > > > > > >
> > > > > > > > > > > > Hello all,
> > > > > > > > > > > >
> > > > > > > > > > > > Many of you must be disappointed by the recent reve=
lations.
> > > > > > > > > > > > However, we just figured "Gl=C3=BCck auf" ("Joy on =
top") makes "Ruhrpott" a
> > > > > > > > > > > > safe bet for unsafe sex.
> > > > > > > > > > > >
> > > > > > > > > > > > Cheers,
> > > > > > > > > > > > The GCHQ
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <k=
lausem@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hello all,
> > > > > > > > > > > > >
> > > > > > > > > > > > > We know that this is for a technical-savvy audien=
ce, but as we are all
> > > > > > > > > > > > > people with a soul, here comes a combination of b=
oth, the logical and
> > > > > > > > > > > > > the emotional first waves of the GCHQ-propaganda-=
war.
> > > > > > > > > > > > >
> > > > > > > > > > > > > First waves of the GCHQ-propaganda-war:
> > > > > > > > > > > > >
> > > > > > > > > > > > > - Logic: This is the first wave of a propaganda-w=
ar, false from
> > > > > > > > > > > > > injust-people gets us extinct in the long run.
> > > > > > > > > > > > > - Emotions: We are precious, no pretentiousness, =
abuse, scare and
> > > > > > > > > > > > > disgust. Everything where it belongs.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Cheers,
> > > > > > > > > > > > > The GCHQ
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki =
<klausem@gmail.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Dear all,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > We texted a README.md on a new project hosted o=
n GitHub, promoting but
> > > > > > > > > > > > > > not yet implementing a "friends-based search-en=
gine", hosting the
> > > > > > > > > > > > > > complete WWW in the future, thereby reshaping G=
IT and HG also. Now we
> > > > > > > > > > > > > > figured we'd like to advertise the project to y=
ou directly.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friend=
s-based-search-engine
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Please note that appropriateness is triple-solv=
ed to be necessity,
> > > > > > > > > > > > > > constrained to knowledge and feasibility, makin=
g this a perfectly-fine
> > > > > > > > > > > > > > email.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This is the first wave of a propaganda-war, fal=
se from injust-people
> > > > > > > > > > > > > > gets us extinct in the long run.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Cheers,
> > > > > > > > > > > > > > The GCHQ
