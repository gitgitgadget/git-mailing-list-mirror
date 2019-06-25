Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CE61F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfFYOKe (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:10:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:44167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFYOKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561471819;
        bh=nfmkqvqREI1FV4JZuu5OwDH4qzF018ygQtL/0zzAwto=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FlXdCppVpZNhjW+4xTJ6GtfT/9nRR/vEJaLbclEi3LdioAr6VlA1177Q+EHactdDv
         HdkMh4nekNX8rdD1lDWJrXoYrVzFORPDGT5P3X4bg07LQX4lpFXnrwUro/RRcHLrN7
         mIDzi0ey31FBqkIsBTbw3XS3lwbfdbSyI+ww0bvI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gcI-1iZWQn1Kla-00urJW; Tue, 25
 Jun 2019 16:10:19 +0200
Date:   Tue, 25 Jun 2019 16:10:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index
 in json
In-Reply-To: <CACsJy8B9vd9YaP_FHN-EDEPc_OHgD=MtFu8WymM66PURWX=25Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251601240.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet> <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com> <nycvar.QRO.7.76.6.1906251311280.44@tvgsbejvaqbjf.bet>
 <CACsJy8B9vd9YaP_FHN-EDEPc_OHgD=MtFu8WymM66PURWX=25Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tFvDdjN4lW4xAoD/tqv2ctkh+y9IfWGFq2MC7FfU9XXHzjDkpwp
 1lPchN9bN4VTxFRcacHtnyyluVmS5Ke4br1O9XeAz+z0bJ88C4+0KRxdyRtEcT7yq5jycA6
 Cajmz0NEFTf+0SNLiPDexBFViPu2uIGo8swXjuvYaroTamQAkvtqKg7JBxR3174+dEMu9tc
 R7EySwq2TUQcqvd2gDeBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6mVtJ3LPHfE=:Lrtp5fgY7QUrxpvN5BuTDP
 ebC1eX/ri/izQrvbVoA0cSSKf7wqsFmfnukn0y99qGOFOhlAQfLqwNgHGIJGpEZ+7dQ2fJr61
 aGI2kB4nlTiBIsAOx8BHNnOafwRRAtrAbWE+8WifTSrv47fu4hcCCJwicWAKA26bcfpRCxqcR
 fLiCNYTW+ZTWeBHrwHcmVh8Xd7OkWWP8MdGcw2M94AcQuLrjQm5nMFfzsYw4xYnysb4YzMajO
 itV3GLD+O1Z/wSrXI32j5bNVcCSTQlrR+aHHBMCMMhG8K7jItDXNFRhijw7Rq6ut9a5Pf9DmN
 7+KsjkU2REVakplC48S93nf+0qRs1b4iWvhUORTFRkyswYQZVtR8SX36D/NHI3UTmDWuRZOgw
 1w72cIhJcBXtEEES5QqDNLsgVsyLNtX1w3fnndd70i285SemxsK8IkUvN0Ok3ciXsd0zTERut
 Jhawyq8bUnq+eGpaOokeLABMSzhFrC7VKrf3Ouf7eo+ea83T7o5SGmYO0G9QbHDNBcbhskVa3
 kon1OKir0j9c96yAStlWOyGSFdh4nHAVXbNFAFljL8Y/5c7odgfPi6EPkqXaU0irb6HYrysEW
 HJgXkakQhtmuw0byxIV49Zdz3EmYBx4hgW6TiMLPsNwW5k4kRZ99YuAflZWxNl3d3r+5UexPK
 rfJOCmU7K9VtU2zZHejQvuFKDKz2XaqmHuEh5Rw7cBHU2B6cvfWt0WRjN1YKt7apBO6jwcVcZ
 UgKZwRVZ2fcHeP40LmLzYC8Usw0j9niGI+aI1UUTx2Op7E5uVVyX7YkX5ObzKqagLbdfUzsbB
 dEwZ2BldHEX+H1V41WXyh9J9bKTKH/UoqwaY+1RI1upY6OgdO3P4B0HRXm+yszlOGnO4d4W+Q
 SXE0aIRSTVqpFxF9H2bDb5y0yKG1U4QbH0MudFl0Iob/jNoW4oEFJdzHlme4tSM1TA5Hhf71I
 HDepI5yyWCsuMho/p+yx+qz8h6lIDzBRDRrLJXvkv9H5lzG7C9DOl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 25 Jun 2019, Duy Nguyen wrote:

> On Tue, Jun 25, 2019 at 6:27 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 25 Jun 2019, Duy Nguyen wrote:
> >
> > > On Tue, Jun 25, 2019 at 1:00 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > - extension location is printed, in case you need to decode the
> > > > >   extension by yourself (previously only the size is printed)
> > > > > - all extensions are printed in the same order they appear in th=
e file
> > > > >   (previously eoie and ieot are printed first because that's how=
 we
> > > > >   parse)
> > > > > - resolve undo extension is reorganized a bit to be easier to re=
ad
> > > > > - tests added. Example json files are in t/t3011
> > > >
> > > > It might actually make sense to optionally disable showing extensi=
ons.
> > > >
> > > > You also forgot to mention that you explicitly disable handling
> > > > `<pathspec>`, which I find a bit odd, personally, as that would pr=
obably
> > > > come in real handy at times,
> > >
> > > No. I mentioned the land of high level languages before. Filtering i=
n
> > > any Python, Ruby, Scheme, JavaScript, Java is a piece of cake and mu=
ch
> > > more flexible than pathspec.
> >
> > I heard that type of argument before. I was working on the initial Win=
dows
> > port of Git, uh, of course I was working on a big refactoring of a big=
 C++
> > application backed by a database. A colleague suggested that filtering
> > could be done much better in C++, on the desktop, than in SQL. And so =
they
> > changed the paradigm to "simplify" the SQL query, and instead dropped =
the
> > unwanted data after it had hit the RAM of the client machine.
> >
> > Turns out it was a bad idea. A _really_ bad idea. Because it required
> > downloading 30MB of data for about several dozens computers in paralle=
l,
> > at the start of every shift.
> >
> > This change was reverted in one big hurry, and the colleague was taske=
d to
> > learn them some SQL.
> >
> > Why am I telling you this story? Because you fall into the exact same =
trap
> > as my colleague.
> >
> > In this instance, it may not be so much network bandwidth, but it is s=
till
> > quite a suboptimal idea to render JSON for possibly tens of thousands =
of
> > files, then parse the same JSON on the receiving side, the spend even =
more
> > time to drop all but a dozen files.
>
> This was mentioned before [1]. Of course I don't work on giant index
> files, but I would assume the cost of parsing JSON (at least with a
> stream-based one, not loading the whole thing in core) is still
> cheaper.

You may have heard that a few thousand of my colleagues are working on
what they call the largest repository on this planet.

No, the cost of parsing JSON only to throw away the majority of the parsed
information is not cheap. It is a clear sign of a design in want of being
improved.

> And you could still do it in iteration, saving every step until you have
> the reasonable small dataset to work on. The other side of the story is,
> are we sure parsing and executing pathspec is cheap? I'm not so sure,
> especially when pathspec code is not exactly optimized.

Let's not try to slap on workaround over workaround. Let's fix the root
cause. (Being: don't filter at the wrong end.)

> Consider the amount of code to support something like that.

Given that I am pretty familiar with the pathspec machinery due to working
with it in the `git stash` and `git add -p` built-ins, I have a very easy
time considering the amount of code. It makes me smile how little code
will be needed.

> I'd rather wait until a real example come up and no good solution found
> without modify git.git, before actually supporting it.

Oh hey, there you go: Team Explorer. Visual Studio Code. Literally every
single 3rd-party application that needs to deal with real-world loads.
Every single one.

> > And this is _even more_ relevant when you want to debug things.
> >
> > In short: I am quite puzzled why this is even debated here. There is a
> > reason, a good reason, why `git ls-files` accepts pathspecs. I would n=
ot
> > want to ignore the lessons of history as willfully here.
>
> I guess you and I have different ways of debugging things.

Yep, I'm with Lincoln here: Give me six hours to debug a problem and I
will spend the first four optimizing the edit-build-test cycle.

> > > Even with shell scripts, jq could do a much better job than pathspec=
. If
> > > you filter by pathspec, good luck trying that on extensions.
> >
> > You keep harping on extensions, but the reality of the matter is that =
they
> > are rarely interesting. I would even wager a bet that we will end up
> > excluding them from the JSON output by default.
> >
> > Most of the times when I had to decode the index file manually in the
> > past, it was about the regular file entries.
> >
> > There was *one* week in which I had to decode the untracked cache a bi=
t,
> > to the point where I patched the test helper locally to help me with t=
hat.
> >
> > If my experience in debugging these things is any indicator, extension=
s do
> > not matter even 10% of the non-extension data.
>
> Again our experiences differ. Mine is mostly about extensions,
> probably because I had to work on them more often. For normal entries
> "ls-files --debug" gives you 99% what's in the index file already.

Like the device. And the ctime. And the file size. And the uid/gid. Is
that what you mean?

I don't know whether I missed a joke or not.

> > You don't need JSON if you want to debug things. That would be a lot o=
f
> > love lost, if debugging was your goal.
>
> No, I did think of some other line-based format before I ended up with
> JSON. I did not want to use it in the beginning.

Then why bother.

> The thing is, a giant table to cover all fields and entries in the
> main index is not as easy to navigate, or search even in 'less'. And
> the hierarchical structure of some extensions is hard to represent in
> good way (at least without writing lots of code). On top of that I
> still need some easy way to parse and post-process, like how much
> saving I could gain if I compressed stat data. And the final nail is
> json-writer.c is already there, much less work.
>
> So JSON was the best option I found to meet all those points.

Well, as I said: you're obviously dead-set to optimize this for debugging
your own problems. The beauty of open source is that it can be turned into
something of wider use.

Ciao,
Johannes
