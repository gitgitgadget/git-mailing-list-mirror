Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CFB20248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbfDRNHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:07:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:49189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRNHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555592811;
        bh=DjgzJOypiplB8ox6O0ntu0KjSI0bz0MyxadbXLNww/g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YHLABXWzIGZZ+qeRQUs5M6zq8FCbYpbzcVi47C+s3FDuat0JZm0RkfzmR2XAWlKSO
         qUVeWv0Wi3wV2U5Pa6fdgkfpzOe8eioWja/ZA+9YocpdgkUqK8twA4Ka2KWA6A1q/V
         XWu9XkVjv6CFPfruRDxg7vxSW3a9nwBAIX30Fbz0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1hFSr335Gk-002o97; Thu, 18
 Apr 2019 15:06:51 +0200
Date:   Thu, 18 Apr 2019 15:06:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
In-Reply-To: <20190415145042.GA27540@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1904181505520.46@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com> <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com> <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com> <20190415145042.GA27540@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rKT14yf3tYReCIrKFraYDf7zpLvR0GqUp66Bj/uXeZC+wXwyrYM
 mlzbliBFRFchl50Zdm1thvzo17JHZvYYGIakyqTFnBvaWqhL85+9ZUwhSxKQYSSJOCc7Ele
 btlrXVyYWB1M38QYpVdi1Hk7lsosvkbbgDLhJfB9uRjq2/KpMVUTGzoCh6GsESqbGp2UMeU
 TdIl8WKaouJMwiAahYOrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AsYPnTCoMRs=:aSUzrzgmLsVM96TJ0tTdt1
 7VIvdWzw+l+4bwgklH0r4jzL2Su4qS5czSv6qhYx+6JSM8YX44TKnBvbpl1UtHt5OCmXpWZ4W
 OpTMu4+UpiKtYhTa7aAtY+SLtEkSn9QXINr4zD4m/gWCHtIPDnuMSwPHpBZ9qoZclhJ60irq/
 F3ewYCJ7QbDUekuyWzFyn0LzQLr+bqNa3yavOBNjfJXbeU25j808KksPYDtW+PtTV/BwDxN3a
 lJQjUl4Ud/TUaL4zeBz49vXw8YJ2QdhS3T7af93Pjc0VOuK3k3d2GV+OGi5dwcyq5ZAqHBKEC
 QpFysSx4zkjJMYgG6Bwhb+hrFhSrPOat+MfEy/3SwGBJBqpGlTU2O77fgORPst3SY/p1vAGat
 2yWQx25Arlw1So6fRbwORjIIR1MiB16WnkdkQZxPhmewadUMa/HI00TgpTf9koJ4ILeIyjrH4
 67YbeAtKgWWgJRQ0iFBD2uVUncJ/W6ed/U06/2s4oXzNwu1qkqWmkNuMLz6AMddvBrdtiJftv
 oRvbsIAbzyUbiSwWOJZlSpygljEkolMbr8QkCCgr2n8Mq+8b+baY5k6I1ls0+d/6viHfB1fI3
 rd9TblK1zCgd77eEEOEbkEpeSLLdKU4NvWUJOqkmj0iKvfoceYdjX80pQRARZt8fQ0kdFWcIc
 7HmdfhOCKgmmQyzoWZmqKRMZ7soMlv03NC4fsdV8Apd7lt1NoIsbBXGQvvxXEBJPvSBpctxXU
 vkRE4+fupQYwmnTyJDyVYvOCj1D1tKvXZmAsBnVqlXoPLea4Y5kihL5TYVHDsxJAqzU6dqJs6
 sXORseO+tfMLvFgwsR45N1IJmdEgXHnvoCuJqI+rS8ipEiNCZUT3MVbWroqpTMh8RwBuu4i2o
 Triic6ikQoFiJDp16kaeBOpbk1aHmvdSyj1Kxw5OKKprSMMuNX/WWui8xPIKXKZ5a34CaYddr
 jukVZmKXhmw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 15 Apr 2019, Jeff King wrote:

> On Mon, Apr 15, 2019 at 12:16:51AM -0400, Eric Sunshine wrote:
>
> > On Sun, Apr 14, 2019 at 11:10 PM Junio C Hamano <gitster@pobox.com> wr=
ote:
> > > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > >> +Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname
> > > >> +       $(QUIET_GEN)echo "EXCLUDED_PROGRAMS :=3D $(EXCLUDED_PROGR=
AMS)" >$@
> > > >
> > > > Should this rule also have a dependency upon "config.mak.autogen"?
> > >
> > > That is probably a good point.
> > >
> > > > Perhaps like this:
> > > >
> > > > Documentation/GIT-EXCLUDED-PROGRAMS: Makefile $(wildcard config.ma=
k*)
> > >
> > > I'd rather not let changes to "config.mak-", which I keep in my
> > > working tree (untracked and disabled copy of config.mak, that can be
> > > readily activated by renaming), be part of dependency rules.
> > >
> > > If we know 'autogen' is the only dependency that optionally can
> > > exist, then depending explicitly on $(wildcard config.mak.autogen)
> > > would be a better alternative.
> >
> > When composing that email, I originally wrote $(wildcard
> > config.mak.autogen) as the suggestion but changed it to the looser
> > $(wildcard config.mak*) when I realized that the developer's own
> > config.mak probably ought to be a dependency, as well. Taking your
> > objection into consideration, we could mention both explicitly:
> >
> >     Documentation/GIT-EXCLUDED-PROGRAMS: Makefile \
> >         $(wildcard config.mak) $(wildcard config.mak.autogen)
>
> What about command-line options that influence the outcome? It sounds
> like this is the same problem we have in lots of other places (like say,
> compiler flags being updated), that we solve by generating the proposed
> file output unconditionally and comparing it to what's on disk.  E.g.,
> see the way GIT-CFLAGS or GIT-BUILD-OPTIONS is generated.

*Sigh*

I really did not want to do that because I thought it would be tedious and
more complicated and result in a longer patch.

Well, don't you know. The patch is actually *a lot* shorter now. So much
so that range-diff thinks it is a different commit ;-)

Thanks for the reality check/prod,
Dscho
