Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10831F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfGAMPX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:15:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:35071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfGAMPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561983311;
        bh=PyQYtJelbP1+L559J4yccl83xM0DmI/7HOu1Nc7fAtk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AJ0fHe1FZ8ALrR6d2ABS0MlhVMqpADR1CutvjegWn5NhL6c1ZVIgXXyT8ylQ/NUMs
         m+HVd/KzPEg/WBWFioQOPAapfnK7HgeH0YtmvKZzoLndHcCFTcvndeenI2x/58OUq1
         KPfSwTPj7nfcDzOJcMZwy55t/LmDjPA7BmJN8DbE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1hyciG0aFT-00LoqY; Mon, 01
 Jul 2019 14:15:11 +0200
Date:   Mon, 1 Jul 2019 14:15:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to
 dir_iterator_begin
In-Reply-To: <CAHd-oW45RAov-5paURQ7j5dg0nZktF2J0bME7Wo1pF8YCd2cww@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907011413530.44@tvgsbejvaqbjf.bet>
References: <cover.1560898723.git.matheus.bernardino@usp.br> <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
 <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com> <nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet> <CAHd-oW6c7EoY+t-ymkcBmZM20YcGb1SWhM7XMO35Fofj-UNmYQ@mail.gmail.com> <nycvar.QRO.7.76.6.1906281449250.44@tvgsbejvaqbjf.bet>
 <CAHd-oW45RAov-5paURQ7j5dg0nZktF2J0bME7Wo1pF8YCd2cww@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MaRmFMcWqlPUki3mbrBbcohAQTy6AaiPGZNE7nc7059CmijxgbS
 EI52HfdHLjI1wMCfZ6C8Q+s3wxzBYvUXrFyLiSf7y7jg1D8OTeSheGWG10boJSqRX7RkC/F
 9BygHvFd4kDgJZXDMTcMQlq7rwxsX2HcdyvNOpgFUPMVPXPaP7JnayJB0bi048vVmSctdl5
 badSSUGl9HetCZp5OhrqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ATHM7pINgG0=:wsmFS/h+fjCEy7nFeE9blN
 g0lVZI1wiw1vLX1J/56mzYpmwrxOhv4/Uojb2XVkFf2haLUfdJtRNttYcf34KPZOqyZN3L3hw
 stLvb4B6+lJ25z+pJt1tbCB6WwwAjeiCmSmzRhcxa3QSRwShWrzp6NnBjHrgUwInSFIEKuHE3
 jYg12RswP5L3dWyJx8YbMUnuGsn2Vb3hCt/UrbiGNRP67IBp2FYdbxS0ssN/GGQDxZVmFsKnD
 1RQeQQcdpf8xpzF6Rl2Co3E1E2YK6eypK4/xXvESfb1QjAVEGtw/ghzzPbGfool07aI1PQzvI
 8A3p2QK052UIwzZsNy93ztrojb3OMrZULw/sby7VGn6G7DMj0uUaXRVl+4cdmsE+KADIyO6j4
 /BAt00aiWORk/BXAQNad9fttJAxsHzGbYpUl6nq8DfVop065CwOnmHeA7eiInCfC72xbubGA9
 NGe/JIUUAGKPcIoUiQS744YR1oL5wHU11b5jFFqVfcjDzOiv06wCKWFGOd9qbqnyutT8MqQJa
 jlDSfetbBwevhphic48P+pO/OwVerGCGWT/SXSqouDX2u+VXLoeBxt9NLecb5vepBlKRGOL6f
 2zYzcNRmCg9uy8MjhGAP0lgDIqHd3d4Sx7aVEh6E7aGCe2U78fNSF/PQpxd3TurN34uKrSmvZ
 ZltXN0r2DSpaIeLW9WmMjj1VwcvAqXrVgCzJZK7Y4lkQfiIKsqOQMyyjfjqVi9nHkLwlcJEnJ
 oCecLI9Rvl42H8L8PjvjKeE1aIbknrwM4dpii1/1M5fh0sBG+1KZSlu8RyI5Ia2LNedKXRC4U
 8ZCOZsLiKz5q+AwNGqtf/LZoKDeVIn5yOxjRZEZ+skKcepHdRcLox89Dray5eJZHAI3QlJFEJ
 j4EdF+CAELs+sEriGYHU7R9N6e7xCdyX0VaWus/rpLKwo6/Qm03x7SAybL4OC30UKKOlsJuYW
 nmybrjGuB/puvwD4Rb6HNuW9G6+e1pdvtPYU6j9jSIXr11Ddol+Xy1BeD1AcR48Wx9oV+sXlv
 B9nrah7x0nrGWU/faRdTfqz45YkLlY/lyceBUFLylB8egYDx0h8VB28pAwUG2oVYy76J9yN22
 Cej9TpNPmeLBLMSQKh9PEtUCe3cu83AvSkD
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Fri, 28 Jun 2019, Matheus Tavares Bernardino wrote:

> On Fri, Jun 28, 2019 at 9:50 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Matheus,
> >
> > On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:
> >
> > > On Thu, Jun 27, 2019 at 3:47 PM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:
> > > >
> > > > > On Wed, Jun 26, 2019 at 3:04 PM Junio C Hamano <gitster@pobox.co=
m> wrote:
> > > > > >
> > > > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > > > >
> > > > > > > On Tue, 18 Jun 2019, Matheus Tavares wrote:
> > > > > > >
> > > > > > >>[...]
> > > > > > >> +/*
> > > > > > >> + * Look for a recursive symlink at iter->base.path pointin=
g to any directory on
> > > > > > >> + * the previous stack levels. If it is found, return 1. If=
 not, return 0.
> > > > > > >> + */
> > > > > > >> +static int find_recursive_symlinks(struct dir_iterator_int=
 *iter)
> > > > > > >> +{
> > > > > > >> +    int i;
> > > > > > >> +
> > > > > > >> +    if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> > > > > > >> +        !S_ISDIR(iter->base.st.st_mode))
> > > > > > >> +            return 0;
> > > > > > >>
> > > > > > >> +    for (i =3D 0; i < iter->levels_nr; ++i)
> > > > > > >> +            if (iter->base.st.st_ino =3D=3D iter->levels[i=
].ino)
> > > > > > >
> > > > > > > This does not work on Windows. [[ Windows port does not have
> > > > > > > usable st_ino field ]]]
> > > > > >
> > > > > > And if you cross mountpoint, st_ino alone does not guarantee
> > > > > > uniqueness; you'd need to combine it with st_dev, I would thin=
k,
> > > > > > even on POSIX systems.
> > > > >
> > > > > Ok, thanks for letting me know. I'm trying to think of another
> > > > > approach to test for recursive symlinks that does not rely on in=
ode:
> > > > > Given any symlink, we could get its real_path() and compare it w=
ith
> > > > > the path of the directory current being iterated. If the first i=
s a
> > > > > prefix of the second, than we mark it as a recursive symlink.
> > > > >
> > > > > What do you think of this idea?
> > > >
> > > > I think this would be pretty expensive. Too expensive.
> > >
> > > Hmm, yes unfortunately :(
> > >
> > > > A better method might be to rely on st_ino/st_dev when we can, and=
 just
> > > > not bother looking for recursive symlinks when we cannot,
> > >
> > > What if we fallback on the path prefix strategy when st_ino is not
> > > available? I mean, if we don't look for recursive symlinks, they wou=
ld
> > > be iterated over and over until we get an ELOOP error. So I think
> > > using real_path() should be less expensive in this case. (But just a=
s
> > > a fallback to st_ino, off course)
> > >
> > > > like I did in
> > > > https://github.com/git-for-windows/git/commit/979b00ccf44ec31cff46=
86e24adf27474923c33a
> > >
> > > Nice! At dir-iterator.h the documentation says that recursive symlin=
ks
> > > will be ignored. If we don't implement any fallback, should we add
> > > that this is not available on Windows, perhaps?
> >
> > I do not really care, unless it breaks things on Windows that were not
> > broken before.
> >
> > You might also want to guard this behind `USE_STDEV` as Duy suggested =
(and
> > maybe use the opportunity to correct that constant to `USE_ST_DEV`; I
> > looked for it and did not find it because of that naming mistake).
>
> Ok, just to confirm, what I should do is send your fixup patch with
> the USE_STDEV guard addition, right? Also, USE_STDEV docs says it is
> used "from the update-index perspective", should I make it more
> generic as we're using it for other purposes or is it OK like this?

I thought Duy had verified that `USE_STDEV` would make sense in this
instance, but I agree with you that the idea of that compile time flag was
not to guard against a missing `st_dev` field, but about trusting it in
the presence of network filesystems.

So no, I revert my vote for using `USE_STDEV`.

Thanks for the sanity check.

Ciao,
Dscho
