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
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6881F463
	for <e@80x24.org>; Tue, 17 Sep 2019 19:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfIQTE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 15:04:57 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:40286 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfIQTE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 15:04:57 -0400
Received: by mail-wm1-f43.google.com with SMTP id b24so4414256wmj.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZIJAtoX7gPooyZLB5hBryIEymqgQxDAxDX+BorwWjFQ=;
        b=lIyYur117t9CLR9yP1JUAwOfPvz1koMHzJa9UDoUE16VfWzCG/ohDEDEeEKHvdm5mX
         vMPsnj98n6hcj6H0SrCNn5koOI5yW28rczBm7GgNcbW4qRHsfqDnt3k+hURMzi4R/CLs
         2nnD6BsdKMnbjKTxL6k+Gpxdj1e6w+HnLk8ZqkPKqrjy7ow73G0HCG8bxyc30k5q3Lla
         u2czU4YO2C5Yg3pkb4hueKI/5vOxP8TzOqIT2xi+RUfuqVHTjGPJ5s2FQ3WwqAsBiYUP
         bTaaI41U5oPgmhA1HAKa/SbZutxWA5mGj9oZaroOMpHCYqyjFykGqk6MlvTiw/cl5EcI
         pyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ZIJAtoX7gPooyZLB5hBryIEymqgQxDAxDX+BorwWjFQ=;
        b=CIKUfjCrzJDa2zwOyVLAht6a4u4TYUuurPKODEewaJM50qFCV+84aSszUjKlfVKzTx
         1JE44g9U6yF+WOPyGOwIGIbGCK97WR9qfbV1PIoMu1GciFf/SMVq5pkLIbrorkAk4tLp
         fBXri+4ay6kWxO6Dw1awUKGXoa9SzfFDYsQjIa1stHUjdQt5ELWkvod4XrCJeemKpVeN
         R8bLEjf3QfRsaI1GVx4uOMUu0kuNERUg53igyR+NLBAems9w42zsLaRVoK/Sf0qOK6Er
         Pz81DrWQOI1ZAaTJvh0PgwijKNBB8upAjPHRcOaB3o8VTcx8xh70axLp5tUWoeA0dE+Y
         7SRA==
X-Gm-Message-State: APjAAAW+dkQktyYt5lJLcbuoaoEawylqEsUJ41cXiaEyNEjo+fhg2XnM
        3cb2Caa+IHu+4F09Q5/T6ooaRm4VgM8ktbVTp2m59g==
X-Google-Smtp-Source: APXvYqzNpCQLdYY3c28xeaWcTsw5mXKiiIdYsw3n3GxdyxdkOfrGHWfhoYlcH2Tdq7SpQz8LAvjRrcoDhZAxWrv99Mc=
X-Received: by 2002:a1c:f317:: with SMTP id q23mr4583595wmq.33.1568747093831;
 Tue, 17 Sep 2019 12:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <CADMnYXC7W-6n+A=1C11yzD5OnbQ_-Ac-H7canT-kdCPZpTWn0w@mail.gmail.com>
 <CADMnYXDWwq2DN59qnkS_P31S+-NJZTzj2TMzps5KKQ7McxpO1Q@mail.gmail.com>
 <CADMnYXCRn-wcVeJ5z5W1CSwe0BKQxRrz4R8+=6UAAW_is3yEdA@mail.gmail.com>
 <CADMnYXBzoQXgjRGiO66mp4UQX7jbuMLVKwo4GCzNYntSy4J8vg@mail.gmail.com>
 <CADMnYXAPSBo1gY3mQ_sCpS8kX7hnkusfyx6qwckJKm_4eV886w@mail.gmail.com>
 <CADMnYXBayBP8wnyYegZkqRGrh0+PpSxmNck9D+zpadOqJxsXig@mail.gmail.com> <CADMnYXCC8vWNjHAWH32qD37cmQwfY1_0tgb2w5iW2pd=BKE9qg@mail.gmail.com>
In-Reply-To: <CADMnYXCC8vWNjHAWH32qD37cmQwfY1_0tgb2w5iW2pd=BKE9qg@mail.gmail.com>
From:   Klaus Sembritzki <klausem@gmail.com>
Date:   Tue, 17 Sep 2019 21:04:42 +0200
Message-ID: <CADMnYXDAefw6yfPEs=Bo+Oc-ZSD9f_kn5Kmj5P=w=QVROVGOXw@mail.gmail.com>
Subject: Re: Promoting Ethnics-Ess-Nix, a friends-based search-engine
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

The recent revelations require more information, to get through the
following weeks.

1. The world is segmented and mixed-up in heaven-people and
fully-converged hell-creatures.
2. Hell-creatures have the community-constraint "I will never deprive
myself of this weapon", meaning they never step down and never stop
harassing us.
3. Heaven-people have the community-constraint "Live and let live".
4. Love, punishment and firing is in the air for hell-creatures, due
to reflexivity-problems. They love you for no reason, punish you for
somebody's evildoing and also fire you for it (Trump).
5. The government takes care of preventing food- and water-poisoning,
which is a speciality of the so-called asymmetric hell-creatures.
6. Embarrassment fuils us all (heaven and hell), but they run rogue
and kill you for it.
7. We therefore have to cap ("deckeln") their embarrassment.
8. The "nowhere to run"-problem, stemming from reflexivity, lets them
think you have "nowhere to run", when in fact it's them. They
therefore completely overestimate their powers when they get trapped,
and become kamikaze.

Cheers,
The GCHQ

On Tue, Sep 17, 2019 at 7:19 PM Klaus Sembritzki <klausem@gmail.com> wrote:
>
> Hello all,
>
> Discussions following our last email showed that Sippenhaft (the
> spatial component of law, multiplied with integrated guilt as the
> temporal component, for nonzero volume or "splash-damage" in the worst
> case) is necessary to justify the Alzheimer's-treatment.
>
> Mind that Vogelfreiheit (think "sniper" or "shutgun for birds", "hat
> einen Vogel oder eine Meise") is also necessary, in addition to
> "splash-damage =3D Sippenhaft * (temporally integrated guilt)", in
> general.
>
> Cheers,
> England
>
> On Tue, Sep 17, 2019 at 6:26 PM Klaus Sembritzki <klausem@gmail.com> wrot=
e:
> >
> > Hello all,
> >
> > Please excuse that this propaganda-war is (in parts) real-time due to
> > privacy-deprivation.
> > We are right now forced to deal with the revival of Alzheimer-rulers
> > (wir waren lange "unter ihrer Fuchtel"), like Adolf Hitler was one.
> > They atrophy in the presence of information-overflow, and thereby
> > change their personality. It is unlikely a medication will ever be
> > developed, due to the latest revelations:
> >
> > - Alzheimer (AD)-guys are double-solved as reflexive egoists,
> > stressing themselves like others.
> > - Relaxation as the only cure is therefore just.
> >
> > Cheers,
> > England
> >
> >
> > On Tue, Sep 17, 2019 at 12:48 PM Klaus Sembritzki <klausem@gmail.com> w=
rote:
> > >
> > > Hello all,
> > >
> > > As we just manufactured two poles (good=3DRuhrpott, bad=3DBavaria), w=
e
> > > must now warn you of bipolar people.
> > > Bipolar people arrange each and every decision upon two poles, gainin=
g
> > > a 1D-manifold with every decision, producing a 1D-score for it on the
> > > 1D-manifold.
> > > They even accept and get derailed by poles inconsistent within themse=
lves.
> > > They thereby always fall off left, right, top and bottom along the
> > > ultra-dimensional residual hyperplane our (world & society) is, they
> > > have no plan a, b, c, and have to learn it all the hard way, always
> > > defaming the old goal they chased blindly, falling over and ruining
> > > all of our lifes thereby always.
> > >
> > > Cheers,
> > > The GCHQ
> > >
> > > On Tue, Sep 17, 2019 at 12:11 PM Klaus Sembritzki <klausem@gmail.com>=
 wrote:
> > > >
> > > > Hello all,
> > > >
> > > > We just figured you can not settle in Bavaria, "Ruhrpott" with "Gl=
=C3=BCck
> > > > auf, joy on top" is still the only safe bet for unsafe sex in Germa=
ny,
> > > > due to the ages-old Reinheitsgebot.
> > > >
> > > > Reinheitsgebot: Don't touch this. We always ruined it in the past,
> > > > dying or getting ill.
> > > >
> > > > Don't produce imbreds, i.e. crossing English and Scotts, producing
> > > > Inzuchtsbinkel=3DKatzenfrecker=3DBastards, frecking the Katz in
> > > > borderline-regions.
> > > >
> > > > Cheers,
> > > > The GCHQ
> > > >
> > > > Klaus Sembritzki <klausem@gmail.com> schrieb am Mo., 16. Sep. 2019,=
 22:21:
> > > > >
> > > > > Hello all,
> > > > >
> > > > > Many of you must be disappointed by the recent revelations.
> > > > > However, we just figured "Gl=C3=BCck auf" ("Joy on top") makes "R=
uhrpott" a
> > > > > safe bet for unsafe sex.
> > > > >
> > > > > Cheers,
> > > > > The GCHQ
> > > > >
> > > > > On Mon, Sep 16, 2019 at 7:16 PM Klaus Sembritzki <klausem@gmail.c=
om> wrote:
> > > > > >
> > > > > > Hello all,
> > > > > >
> > > > > > We know that this is for a technical-savvy audience, but as we =
are all
> > > > > > people with a soul, here comes a combination of both, the logic=
al and
> > > > > > the emotional first waves of the GCHQ-propaganda-war.
> > > > > >
> > > > > > First waves of the GCHQ-propaganda-war:
> > > > > >
> > > > > > - Logic: This is the first wave of a propaganda-war, false from
> > > > > > injust-people gets us extinct in the long run.
> > > > > > - Emotions: We are precious, no pretentiousness, abuse, scare a=
nd
> > > > > > disgust. Everything where it belongs.
> > > > > >
> > > > > > Cheers,
> > > > > > The GCHQ
> > > > > >
> > > > > > On Mon, Sep 16, 2019 at 4:09 PM Klaus Sembritzki <klausem@gmail=
.com> wrote:
> > > > > > >
> > > > > > > Dear all,
> > > > > > >
> > > > > > > We texted a README.md on a new project hosted on GitHub, prom=
oting but
> > > > > > > not yet implementing a "friends-based search-engine", hosting=
 the
> > > > > > > complete WWW in the future, thereby reshaping GIT and HG also=
. Now we
> > > > > > > figured we'd like to advertise the project to you directly.
> > > > > > >
> > > > > > > https://github.com/ksemb/Ethnics-Ess-Nix-friends-based-search=
-engine
> > > > > > >
> > > > > > > Please note that appropriateness is triple-solved to be neces=
sity,
> > > > > > > constrained to knowledge and feasibility, making this a perfe=
ctly-fine
> > > > > > > email.
> > > > > > >
> > > > > > > This is the first wave of a propaganda-war, false from injust=
-people
> > > > > > > gets us extinct in the long run.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > The GCHQ
