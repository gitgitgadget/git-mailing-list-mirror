Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7BE1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 20:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3Uk5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:40:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:60623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfH3Uk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 16:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567197641;
        bh=bVngd7wIXt/LHbXU5FvR2uIypBqtgPeFCwDB20rBRkI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A5QEa1lPyREsdZFXGP/uVps2a3Rs8J3y5WbczJSWgYYOCzwRZl1CgIcYYAcnjRkX2
         IB+hIv5Vobo/2VZbooy7UQcLlYhobZdoPSD643tDqlZ//HSv8XPoPYwolJqqxL1iAe
         Czxkq5gx3GJSs5SKJQE/XD6+wQqS0IFtiwBDdU8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwF9u-1iGQi70g9e-0180jc; Fri, 30
 Aug 2019 22:40:41 +0200
Date:   Fri, 30 Aug 2019 22:40:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it
 elsewhere
In-Reply-To: <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908302221210.46@tvgsbejvaqbjf.bet>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com> <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru> <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com> <87blw93c5n.fsf@osv.gnss.ru>
 <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yBgeHbedx4WX+iZbVMe6AAcRBV6JTFk3ftwuSgORf1KVD2qGG00
 qomHaYQxeR6kLHykzxVkS3Hl/EmFBEyq1ZluVd1D1/dvUAy0reBjKYAtBImV8sTEugQA3MW
 4i5K6wtOPH+8ZmpJJkMQ4mGcIL/st++aPWKhfk9r5F0jDAbGZhSwoLmCvD5rlzPMM2KzoMh
 xaMPaH4EG2n8LcYq9IjjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlxP6/J1F98=:74dM5fClJOsUsOEbdicQno
 xrjIgxrD+G2dd2xDWDUZhA7KPhsXD8EUYuWzIOIED4dMuBUxu5zg6DCAcNbZLc4l7n5ubXafS
 B0eKHkEIL2xd+4XPxyAafZy7wrMXka9Boo3Q4kobhTUQ1ZcDeQ6tZYKVNF123GmYs7StcR9Yj
 TC6kBneOAxIEToMEnzj3btKD/+CqOc02IyDi6IrAbJ6cQ4XiJJ8KC+D+M3JrXOYGlagrudVMz
 Txyop33a9nKUtu2O5xGjHzBaXSunDBeDFLQVG2KeSEJ3n0tGCjIyK/30KlFbv6T+kFZPwyewy
 cS8k/x/8uI1Dtl3tAfuE3TQYuoBzzoZQdVMgDM4lU9r9BKk+u4ebTTg0MCypS7YanTJx8CFr1
 yEWz3S1Vg2GhLjm2wBWEqPFl8xSIET+Rv8jM8BVQ6n7rmNraZiupP6M0tRPdbKY0j2c23leSu
 H4f2I6Rd1nG3JhR4a1T+weo79j9rdlg7coLHjneYyl5Y3FyNS0Bg2HXF4CpgffEFQs7FtLgb2
 zvCN6p2tvGG9g4ZqSAO3J4BZ3MKHKZgclGdb/eq6D674WkCXU97QXVrCdpGgzlxEk2DwvMlBK
 tmNKuezyes/khhTq1izWsWtCuLfAJm8S0MgyjBnMkIle52dD+UhTmu8LfA35j2LZAnx7Lb+JO
 BaVk30JeznvWZnwghBgU8Ls/y9Oer+rE3g7X/IO2WaGNRwbT1rPDBIztWrNHEQ4iDIPzCYKkp
 3vIANDOSIKA6GZOqijXO/8AbOspzRL/TFUpdKqrZUEmNsaaqvZtQDx6Q/Y5lLRGaqZYXV+4EQ
 O9ipRnBres+NzFL5YF9ok09ihRUxH+d2fY0tJiMVi8zcyaTPO77G3LLfroX5Y8nZu8LSCefUU
 2LxbR9KwNxe7XhGQSuU1KFb22zHaa7XjfniKw5GvCD4P7/Dk6Uvxu64hN/+AsmO+pZk3RyROG
 4YVLMlBy0PbfVgpwNpDK4SfLigI4pu7QyyN381Exz6DZXGk9QTKtBZrRqV9YZJ4AEakwlb79U
 9dCm3VsX8v7p/OhEmxHeWHUUoY+HjtlhfTGaWjuKhf6Lnnzix7nHkJnHIh7UmpqUUwZRPUnie
 WCmVQTyMMdvkmzx3g7kEUsnXGovlzA6YEHTYIrnIw6BfQrIJApKps+hM0V6F+yMW8amhBNQPC
 kqED7ILI3G6PqbOksKqItAYyR+oeccqGtciYIP6o+8UEB8KvfWZZp2dWFVEXjP/xeT8uE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,


On Wed, 28 Aug 2019, Elijah Newren wrote:

> Hi Sergey,
>
> On Wed, Aug 28, 2019 at 1:52 AM Sergey Organov <sorganov@gmail.com> wrot=
e:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > On Tue, Aug 27, 2019 at 1:43 AM Sergey Organov <sorganov@gmail.com> =
wrote:
> > >>
> > >> Eric Wong <e@80x24.org> writes:
> > >>
> > >>
> > >> [...]
> > >>
> > >> > AFAIK, filter-branch is not causing support headaches for any
> > >> > git developers today.  With so many commands in git, it's
> > >> > unlikely newbies will ever get around to discover it :)
> > >> > So I think think we should be in any rush to remove it.
> > >>
> > >> Nah, discovering it is simple. Just Google for "git change author".=
 That
> > >> eventually leads to a script that uses "git filter-branch --env-fil=
ter"
> > >> to get the job done, and I'm afraid it is spread all over the world=
.
> > >>
> > >> See, e.g.:
> > >>
> > >> https://help.github.com/en/articles/changing-author-info
> > >
> > > Side note: Is the goal to "fix names and email addresses in this
> > > repository"?  If so, this guide fails: it doesn't update tagger name=
s
> > > or email addresses.  Indeed, filter-branch doesn't provide a way to =
do
> > > that.  (Not to mention other problems like not updating references t=
o
> > > commit hashes in commit messages when it busy rewriting everything.)
> >
> > No. Maybe the original goal was like that, by I, personally, use
> > modified version of this to change my "Author" credentials from
> > "internal" to "public" in branches that I'm going to send upstream, so
> > the actual aim is to change e-mail of particular Author from a@b to c@=
d
> > in all the commits in a (feature) branch.
>
> There's an interesting usecase I hadn't heard of or thought of before.

I'll throw in another use case that's kinda related: extracting the
history of one file (or subdirectory).

In my most recent instance of this, I wanted to publish the script I
used to use for submitting patch series to the Git mailing list,
maintaining tags for iterations and generating cover letters from branch
descriptions and interdiffs (this script eventually became GitGitGadget,
https://github.com/gitgitgadget/gitgitgadget/commits?after=3D6fb0ede48f86e=
729292ee1542729bc0f5a30cfa6+0
demonstrates this).

To do that, I ran a `git filter-branch` in the repository where I track
all the scripts I deem unsuitable for public consumption, to remove all
files but `mail-patch-series.sh`, then pushed it to
https://github.com/dscho/mail-patch-series

Please note that most crucially, I wanted to rewrite a newly-created
branch, and only that branch.

Could I have done the same using `git fast-export`, filtering the output
with a Perl script, then passing it to `git fast-import`? Sure, I was
really tempted to do that. In the end, it took less of _my_ time to just
let `git filter-branch` do its work with a not-too-complicated index
filter.

In another instance, a long, long time ago, I needed to restart a
repository which had included way too many files for its own good, then
rename the old repository and start with a fresh `master` that contained
but a single commit whose tree was identical to the previous `master`'s
tip commit. I simply grafted that commit, ran `git filter-branch` and
had precisely what I needed.

I would be _delighted_ if these kinds of use case (rewriting a branch,
or even just a commit range) became more of a first-class citizen with
`git filter-repo`.

Thanks,
Dscho
