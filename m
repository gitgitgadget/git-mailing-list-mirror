Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E38C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF46720734
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 14:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a/9IFM2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgFJOeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:34:14 -0400
Received: from mout.web.de ([212.227.15.4]:43559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgFJOeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 10:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591799645;
        bh=WF82/30ghDbOmF/TRuM/jrqpNzD/UdVlGUai3Rbsncg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a/9IFM2pKpQOd+7UJIksefY+ssHlvullkZ6DpvpiwMuNYKOjsBSE/frHFybSt0y14
         m1iBAp/ESXIF3pwqCtbRCnSFgEjRMXJZ83vqN1GIaZHhyf01zDnxpI0pvnwEgfrArx
         32rqAwwqx9vkyJErP0atxCstdnsuyYi0Cwy/jO3s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC1ho-1jaC7A3ViK-008qOz; Wed, 10
 Jun 2020 16:34:04 +0200
Date:   Wed, 10 Jun 2020 16:34:04 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: osx autocrlf sanity?
Message-ID: <20200610143404.5sgww2fmsouubloj@tb-raspi4>
References: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
 <20200609231336.GQ6569@camp.crustytoothpaste.net>
 <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPiFCK0h0LfdyE6Q=UJkuX+Qdb=rULcgDJwgxQ0w-1O0zpMew@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:hEGFeT4hAxI3kLUugcg7/16AFw2uHgccOyja4Sg1wtCRCeA8peW
 1A+zsvb/n4VEVwmVPouBrOgD7qZRtburAnaHtawJkapQxmYxzUrNjbGs77LW0TYMkgBiBbG
 lC94/075SQ1I6IijVUmMssq4USfMHzpOExmrQ+K7QrWqb8+pWDDYRyHwWyo7r1qdDt+6/FO
 RYQLn5scCxLg7cYNbr+sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QA4X8CyDbK4=:EGpLL+4pj6Ij/PgkkLJAoY
 /mZOCSgskVBugV9OrRpF8BqalIHJeUbbldHpXUuXoYWdPuqRDFR0iufKZw67Li4/IftPRaBuc
 +boL7evLlQUZi8YMIl2mzfZERlV/gq1wYmdBz92xJNOidpu6YjN4aEgB5W7JkmY5RHQPm7QJn
 xejt1fUTKbN6yM3TjOQwfIH/DyWHo+hBvBFHzFsG9gHjwy6UfqVER88/KKm3X+3rS9K41qzlT
 BtSr9tZT3OpLnajwpsOrFAEYVrGL/Wcf+74UPfMQgyKAZACoQcPR/WcfEwscDwce5XshjWggl
 dMpRYIYjRYcpu64y3optIi/GvJYqFIoFtQlL1Jh1b3DghUyll2/+abKslT5sb2cU38CapDQyK
 TZNQx/6y7XFlQwd0FDrQm0F+Ww/0E5qsV5KUOmzaxLzBuTc03GENcJqBZ6BRZoBFF/hwNVSvW
 RxYh/9XB/rbyqyJQymb3OheGliodPJh3uPY/LDMyDbHuTEvnma16kEeRxCEu9o5MwuEPlNvnA
 jVIXD+LWIw4eoyRqyXLAbMrMKnV+OE/ALTt/CwyAswIezVJ+dKF5WaUglNDjWJySZyCZFIQ5k
 fcs8D8f6AU3TqhNRaYz0z3Ay35rjwP0B+EEuy82Hsv46nuCxXfvvViIkZ/WYkF1WKNG8m1RY7
 4UshFtiZy8JWZHL40G9gtk/SGuoTKQK5pnx3HrTNVOPxkCxuNl4ZwXj9iBjM8mJByRWwGmSLu
 NsKyGJ+szXiS8W4IACLrd3w3B8S6TBovZ1+ncMigtevg7BPyrNzWHORpPR6E65RG1PSoUO0Js
 o6nbSCoUkroKMFyxiRwN0ft32TyOPGMF5G9bPwjOCkkClRcZmW0fXz99WwlWtdGL19apFGW2l
 eGU08o2glW01MEnkGfWVYDDZRQOAVXxmMuf3rsCfaZakOZAx0IoWCyPbyd8a4y3k2zZCtNPKO
 tS1gAtWMDoiu/c6GGg2NcLTwP0xe3yLyoEDUj8Jq6kF02qagTzc3Ryyw4nu65g24hAwb3QfWE
 PVKq+SrtC1ymG7KHJCXQ5PqmHcjt4RxAc0DX3Kd2PnBIa5JmZc2Y7QTKLFEfu3H0pmQgo1r5N
 2OHWBXbRE4XQgxRvAQ8Okdn7Jf2dndcWKscUX6dVuCiOGdJQWfcHMZwWfFg6zsXlEehVeFUY9
 L1RHQi3wWPIq9THYXNUqXG9P0poxOPpbKJDcwn4kQ6ySwaItOnHeQg8dBibFhGdpZf9WOCu2Q
 Rpdu3bEOQl0WAI24a
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 09, 2020 at 07:31:23PM -0400, Martin Langhoff wrote:
> Hi Brian,
>
> good question! There is a .gitattributes file, all the files affected
> have these attributes
>
> *.py     text diff=3Dpython

That is the important information, that we need.
Since there is a .gitattributes file, (wich is good),
you can forget about core.autocrlf (at least for all python files).
(That should be clear from the documentation of Git,
 but it could be, that we can make things more clear).

There is only one way out of this dilemma:
renormalize the line endings in the repo (and live a happier life ;-)

https://git-scm.com/docs/git-add

Sorry to say it this short, this has nothing to do with OSX,
it is the repo itself, which needs the renormalization.

>
> regards,
>
>
> martin
>
> On Tue, Jun 9, 2020 at 7:14 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2020-06-09 at 19:52:42, Martin Langhoff wrote:
> > > Hi git list,
> > >
> > > long time no see! I am here to ask for a sanity check. I'm on OSX.
> > > Checking out a repository that has an un-controlled mix of line
> > > endings. Mostly linux-style, but some Windows CRLF endings.
> > >
> > > A few tests.
> > >  - I set core.autocrlf=3Dinput globally --> a fresh clone doesn't ha=
ve a
> > > clean status files look modified right after a clone)
> > >  - set core.autocrlf=3Dfalse globally --> a fresh clone doesn't have=
 a
> > > clean status
> > >  - set core.autocrlf=3Dtrue globally --> a fresh clone doesn't have =
a clean status
> > >
> > > This is git v2.23.0 from Homebrew.
> > >
> > > Am I doing something wrong? Can git work sanely on a mixed endings
> > > repo without having to fix the world first?
> > >
> > > ... I do strive to fix the world (and this small repository), as we
> > > all do, but it should not be a preconditions before git behaves
> > > sanely.
> >
> > Does this repository have a .gitattributes file and if so, is there an=
y
> > correlation between the patterns in that file and the modified files?
> > --
> > brian m. carlson: Houston, Texas, US
> > OpenPGP: https://keybase.io/bk2204
>
>
>
> --
>  martin.langhoff@gmail.com
>  - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
>  - don't be distracted        ~  http://github.com/martin-langhoff
>    by shiny stuff
