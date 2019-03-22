Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A6320248
	for <e@80x24.org>; Fri, 22 Mar 2019 10:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfCVKNg (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 06:13:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:55349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfCVKNf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 06:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553249609;
        bh=a7E601z+ayPONySsHAUxtsK9OsUSF8AK/SpHz9bk5E8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KQuEZHiXl2eKYVTm8k7T+fRg36Rp4gU+djR5bV6mEnPgY8peD1KNYsVWBJghMZX4m
         NMAU2pQ6FNWto5kwM4/2j757J9AbDmtEvKOWrAl6Co1MFeCuBi2ezPtxqAsQTmgZRj
         kDIu4HMzXR0m4UJKgt6dQPFSgM6zBc5MUZVJx6MY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMCSP-1h4EmC1lpF-0086p8; Fri, 22
 Mar 2019 11:13:29 +0100
Date:   Fri, 22 Mar 2019 11:13:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
In-Reply-To: <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903221106001.41@tvgsbejvaqbjf.bet>
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com> <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> <871s31vjo7.fsf@javad.com> <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s6PRGrvGI5fh9BOGdYQjeqzkl3N0wqkEmHpkoBWti0ek8btn1TQ
 1AnAfry1vSBHzKn8Tzu1CZETUuSnPEhNhSxWgwrpkOEH7wjWdHyYy3h6novgBxwXRlTRUCq
 +KbcdAcas60YgjNQtbuwbbr+jMh7mgxtcO/DtgZ4Zo5JIlho3f79alKduxk1lOtj3Fr06jB
 vQPu6r7R4arUhVXt8E7JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IfNvcABLFO8=:r3L/B1/JVuVsDa9+/2wtG5
 Fn8klWk07VhiMzwuSCF4aDfUj100SXnw6+e6UpmqiqD5KEHP0bjBny4i4EK7wDB6wquK0k1d/
 DMZiY0kD7WjBsoB4xwVtg7QCcsJ45UbGr/IXmKmsWGJnttF8lxQA22f+cykrH0wvVdTPAtoiU
 ninSfPp7tS3mjl1iYulXK8vK3eo/T//+bxe3D5x5DNOStQ0p/iLPDGxGLpoVK71ODFk34Oh4N
 PKBKltuUAB79MuiAE4vrQ46cPJ0DRBBzqptNjXBBqVJxrGZ800dErzsQ0C4JplR4LtYy7e4yQ
 4Ls4GY4iNmgRbnrTPTZiYLB7wILlWyUBNboOWFTvHoVUI66GmmBvEZIUi/yYMVCX/BrHhYpaW
 JAOA2XWi7s248wE0bcIlJiwiEfTac7ijEnyfGzqVsSf8JLRbWMOU5C2WkHQQGS8ccLhAxV19w
 Lx7oK8Tj08ri8mEd1kj7qpgOfOR6YTQa8f8DkH5rfQbPx08iONbqfqdCEdEb8ATXptlhF5wBz
 5SlfDIC6l4ULO29UHOD3Bm2+ERIM43gaJ4UZ4cR1K7CTwHlkGXdnKEyzNVPCdyR4o4WG1r8uU
 HY3Pz9GBbq22rvhXeHBOoTVYWFhLRiz65t/+N6fLYmoQyzVNbfdbaRrbZIHGqvBPdqpmzjQ9P
 pWuvFyJsTg2/2Q2BuVC8QkwnqsH3heRKPDKMWWgSAanSG5zyMujIIiXx+zPFmZr7lq/T9ANDZ
 e7tnBMc5HvNjDhLRI3e5Xz0MVfrVkj0FcYrHez0xJZ3Xr8LcRj+qEJEUgP2fqr4UK57EILwHx
 71jlew2AMpY5xLgu1ngb+CZN40LIyAJEvckMeiSsSfrmuFw4I4Qba7zd1ZVqNRRy0kfCHz5At
 DWLxQTZMkFqaw58KiGzFSgd8fBfLqqDxOg81QHlAfp6D/mujcN/s0YnWbfq0MsrswsJF0fwgl
 E5b4qsVqUNQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 20 Mar 2019, Elijah Newren wrote:

> On Wed, Mar 20, 2019 at 8:09 AM Sergey Organov <sorganov@gmail.com> wrot=
e:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > [...]
> >
> > > But I do have a very strong opinion against adding yet another
> > > option that takes an optional argument.  If we want to allow
> > > cherry-picking a merge commit just as easy as cherrry-picking a
> > > single-parent commit, "git cherry-pick -m merge" (assuming 'merge'
> > > is the tip of a branch that is a merge commit) that still requires
> > > the user to say "-m" is not a good improvement.  We should just
> > > accept "git cherry-pick merge" without any "-m" if we want to move
> > > in this direction, I would think.
> >
> > Let's just make '-m 1' the default option indeed. No need for further
> > complexities.
> >
> > Exactly according to what Junio has already said before. Here:
> >
> > https://public-inbox.org/git/xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.co=
m
> >
> > Junio wrote:
> >
> > > Now, it appears, at least to me, that the world pretty much accepted
> > > that the first-parent worldview is often very convenient and worth
> > > supporting by the tool, so the next logical step might be to set
> > > opts->mainline to 1 by default (and allow an explicit "-m $n" from
> > > the command line to override it).  But that should happen after this
> > > patch lands---it is logically a separate step, I would think.
> >
> > ... and as that patch already landed...
>
> This worries me that it'll lead to bad surprises.

Indeed. Merge commits simply do not have the same semantics as regular
commits. They not only have more than one parent, they also have the
further complication that they, unlike regular commits, do not introduce
regular code changes, but need to reconcile diverging code changes
instead.

As such, cherry-picking a merge commit typically leads to *many, many*
more merge conflicts than cherry-picking regular commits.

It would appear to be a wise idea to keep that safety line in place, where
users cherry-picking the wrong commit would have to tell Git that they
really are sure that they want to cherry-pick a merge commit.

And I know that I've been there myself, so it is not just some users you
might dismiss as less than smart (which is actually not a smart thing to
do, users are the essential audience of our software, and if we make it
hard for users, it is not the users who failed).

We cannot just "ignore away" that merge commits are different from regular
commits: Neither in the data shape nor in their purpose are they the same.

Ciao,
Dscho
