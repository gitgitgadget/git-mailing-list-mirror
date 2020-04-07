Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F87C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BBF20747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Vn3wcNVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgDGOuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:50:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:42751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbgDGOuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586271017;
        bh=lfbNQkEgSObNuHPzZ1x5bhsWrwdwYMXfIxLcsTHw+CU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vn3wcNVe9PXuWEVWu0zbZbKeqeSCBRHj6z5MN6zMXOoxKVn8gXvA+YXa0ZFK2icsY
         ZcIK+IZAH+WTiWghsi6zs1B44qVfFBwhUce8JiozKZ50UpMjKPB0fpfKNUxNHwHt69
         ASEJv6DX1mt+gULUyrQ7wausjYrfHAxbQucR9ed4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M9Fnj-1jPwII2Gal-006Kmj; Tue, 07 Apr 2020 16:50:17 +0200
Date:   Tue, 7 Apr 2020 16:50:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
In-Reply-To: <09397e37-a22b-5159-b760-bae238ae3ed6@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004071649190.46@tvgsbejvaqbjf.bet>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com> <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com> <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com> <09397e37-a22b-5159-b760-bae238ae3ed6@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:abdsOg24a9xFzNkb+UpNfqGFKsNaI3xi2ZCtHJYDKpzE5whF4+v
 UL4qnB3VitnQCxZfXlguf2MS9zBaY5SaAg9PkcddffuX0nd5bPuCCzptpaw66H1yfAnOizh
 wAd//iDExKHp05bw7dnN+A7FJTia52D978zVUOXaWhBZnx3F8BEHvll5eTi0rkL8lN+BhVv
 n4grFHTteSsD+K4JnpHyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Htvyl4SdW1E=:FTZr207h+yTmH9P+Zgvxk3
 Trj9mphwSmiGjwfyB9N4NMR8GWg7NvokVJ8hGsVxs1wKZGV36q15O+devAvMad33vF3zqk8ri
 nedP1ro146h0CPJc+So/Sjx8LceYfyWA3MofDrS+w6gkmwU7R6gExOjOA2mWJdFkGsJcPTLJI
 w2R+WJixAREZrSigfpr7cclvr7wDv4IaihmRo3msfuyebjhqoye5QJfi39/fTdhpsUbcMcpJr
 z6+3eqmNEG+iQTm1sz1sklcpZVdEowXLEehjHnMC3OZDFfze0SiUJlxjV0bON9pliuym9alDZ
 5dJ1J6vU4LQ7dCNfilHaCM7hLBQdJ/imXSo34Kgcihn6/Mas0iAfonkeI56NY+9B0P+wlIOuQ
 +COrzf24l8rT60l9Dd765WLhOxvTCilebt7PXdl40P6F8j3u6Tdyd9744mrLyEVMkY5PZQNPL
 5R8ltN74UHOe0MCaskI2Pg4NlTGa/w7+3+NmRh2gh/7TFmgn+F+eWpt2+DH0zkk7HfQbbzKyx
 3hbUoeYhio8+ojjwbP3QSouWhMx9BO4du30uth3mJHe+zYe3Bl+/l1OzaaGk0/MWVPAI5ppmR
 r0nuopRLEmeFfbJq8RNq5+XS9h8nIsbC91fgYcL4p30ZTwn3Zf2GY2LcFEvVKry7uNo+XPvgb
 v2FQPXCpEPP10hqCSzmKuQBX3rw31qWGnZWcPWD3IyVhM/PRZQqCKCuZuCZa694jXrzr5F1RJ
 bkOqcIcCDeSfy/NwtHPeSkhSf5IDzYCvYxR1FvEfRsZmKCdt8IJRXsb/0uKyBz3pd/OgH4o+K
 7H+hamxngVrFFiLUv+apxS2dm6vzfXcw3nGjA/HvPd3rYhsY82U588gRMX1bqy+va4NUKmqth
 eoe0nx8zL8Ydj39gw69jFEumdRremY1d/QdZnra6YhVjZg7jgFW5EcHJSGy1wrb/1+bH4lSmk
 KTqmO+C16wL0Zm05E+yhE1K4n64jEgKH9MeodneqC9A+T+/Eav1KAkDwIV8pNcQTRyCpsw45p
 pq7LllXSnktb6Mqi/O+Gj70yPtEc2oYlLjL42sAmFcdp29GmVg3EouKhvhh3NnQ8jRzwnjYm+
 KV+yvoiQWFtbGpRiCjFDnViwm7XhwfvXv+39b+1j8Qy+JDCiA2J7563UNV6OwTOOLNF8QZ/yC
 Z6+FMZ3YgylFpAeAcVMxdWKSVWFa+wgZFpWYTTxQnAHawItuKTUrs9XlInEJVkFyabKitwjQK
 f+7KVha5oIa172q3yVVp5eMn/TwfqOrxfANJfkA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 2 Apr 2020, Phillip Wood wrote:

> On 02/04/2020 18:01, Elijah Newren wrote:
> >
> > On Thu, Apr 2, 2020 at 2:25 AM Phillip Wood <phillip.wood123@gmail.com=
>
> > wrote:
> > >
> > > On 01/04/2020 21:31, Elijah Newren via GitGitGadget wrote:
> > >
> > > >        va_start(ap, fmt);
> > > >        strbuf_reset(&buf);
> > > > -     strbuf_addstr(&buf, action_name(opts));
> > > > +     strbuf_addstr(&buf, reflog_action ? reflog_action :
> > > > action_name(opts));
> > > >        if (sub_action)
> > > >                strbuf_addf(&buf, " (%s)", sub_action);
> > > >        if (fmt) {
> > > > @@ -3799,8 +3800,10 @@ static int pick_commits(struct repository *=
r,
> > > >                        struct replay_opts *opts)
> > > >    {
> > > >        int res =3D 0, reschedule =3D 0;
> > > > +     char *prev_reflog_action;
> > > >
> > > >        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> > > > +     prev_reflog_action =3D xstrdup(getenv(GIT_REFLOG_ACTION));
> > >
> > > I'm confused as to why saving the environment variable immediately a=
fter
> > > setting it works but the test shows it does - why doesn't this clobb=
er
> > > the value of GIT_REFLOG_ACTION set by the user?
> >
> > The third parameter, 0, means only set the environment variable if
> > it's not already set.
>
> Ah thanks, I thought I must be missing something fairly obvious but coul=
dn't
> see what it was

FWIW I was also about to comment on that. Maybe that warrants even a code
comment above the `prev_reflog_action`?

Ciao,
Dscho
