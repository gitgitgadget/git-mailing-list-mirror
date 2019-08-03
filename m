Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FDE1F731
	for <e@80x24.org>; Sat,  3 Aug 2019 20:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfHCUfQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 16:35:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:35983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfHCUfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 16:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564864498;
        bh=3+NhQw7sfWNYBtwi9RjLFjY4v8cIXTDIN7uGef2BBPY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=liaSAe7n8gSt/ToDvgJz+95GoXwxvkEUcFOmqT7ry4elILuBrynl69aS4HRPsaube
         yqJC1/ZVznbtDg3MSXxf2VN1mTyM55Sd5MnESUMU2ambLKV8p56homyEeH1MTvPOsi
         /T47EWTV0Qxpi2lnsU7FdjgIhhs6RESqyGuMCE/0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLj5z-1huHac3Xlr-000vfH; Sat, 03
 Aug 2019 22:34:58 +0200
Date:   Sat, 3 Aug 2019 22:34:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
In-Reply-To: <a68f09be-949f-b16b-a585-9ca2a1991a4f@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1908032225510.46@tvgsbejvaqbjf.bet>
References: <20190728151726.9188-1-me@yadavpratyush.com> <20190728213634.GB162590@genre.crustytoothpaste.net> <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com> <20190728224943.GC162590@genre.crustytoothpaste.net> <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com> <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet> <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com> <nycvar.QRO.7.76.6.1908021414530.46@tvgsbejvaqbjf.bet>
 <a68f09be-949f-b16b-a585-9ca2a1991a4f@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jHrGuosYLXxkqpGQhmMQqjgMM08O2H2knRTzp7ZJ00GmGfgYVbp
 q5uIS/VrEoyRdwOzFvj8yvKg/H87U4ZCnuoOf+EyMn4yI2D/sVRuGNxnWrbgsbT714sPdTL
 W28+d3gC7vaARZMMjHMaOUaMIjaRamTvWKnL7PYvPweoanvQtmdkwEiPZ4GkB61OOMSQUhu
 iHjcZmeBveyNvjMzy+6hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v6KW/SBKwbQ=:hSbIjNHocyabfwOimRR8Yx
 jMwAJG+EXOmWJT01vRZxzzyPdM0TzoNKLtM/cWMIFmfFLS9UlRrAKkd2g2Gs4EF3BOJWnMWW5
 OGuM2fYIeDdmUB5dCisG1cP4GplYODrkwZ+hvpZTO0ARGq6+TcIu8twCaAfsUB3ZMlT/yX2px
 Mu+Lcbya5iZ6v3LjqLYclXWkIhKv4gJijolw1Jtn6aBPoR2Q0eStqh6cSxKERRsxhfRFxK9xN
 VA3TzY00fuiOAcXie0DJOae5bmDqhXpNojmwY8GLNaS4/vd+2lE0du4tRIA/h4IPtsSsA2K6H
 LmBR47xTtEXWHiNzmQpWCMiEk0HpyqIzryIWd73Kixa+ikESWVCuqsj0dGMcHGtmYeZVk7DV/
 fOhOkBe2wYeU0GbelJTjx5ksVAcIXjB2UysohkY9+gIpNQSz0qsBuhC1mfbdldV0hK5btEGay
 oCdEjKxqYj29kIHPd/4ricnCH0DaDN4JDMiLk4ciHQiBCnTNSlpHwfeFO68r6hiTk2ksTWfiH
 l04JQ7Zj/HFB/Ap/4qn5rfMvRLO3/+NB0p+DGlfHLHPXTPsaJXUBBkNXwcrl7dtmgzHMqyKWw
 KcpPsoTijbhCj7ZrUUApKGePPFnVz6fma4egzNP7wBMjv52sXJCFX+ffEefT2Cm4SYXpgmILZ
 i8orHUsVWBuMLTtL9MdcWkBMEYr19ykD7UGWXsAvURJQz7sQRcQVHrPUsl0XFXYvQ0mCsVZmQ
 fXVsInGXjlvc/C3Rk9YjsnE2LEyMqQkyKiYgOH4AVihJQ0IsMAtqqetsWNr4QpFIICbOa1cCE
 yD6rMktcHs4Zp4SJu9eW+ExGpdpef+J4F1Mpvdc/d8P8eaacLZlQ+iGfCUHsYSXLeDOWPfP7Z
 nz/+7JqxJwQiPm2MBXhnP9N4iF0W4ZCiUaO4KOoRiPHp1Max3e76r3PSpXijE+poBteI4fIzM
 kCI5OAAMPAghHK/6E/JwNypr3ZWOarIGFqBbIFqCpERr7TxyJRk/CJPK5KtTDlh+sZIolVtqf
 qjqTE1i+q9QwOlUGcdBuIupgJFTtxpkdjb9j1Tw/JphRnI1wkrAzjCWN4Ag+xStgbk6HbKx5Z
 Zaq6FJHKdf/BbwSJ/0XksFGxPu84bgo6i6fRsMkw3mizrv/mTawaJ8YOCb4cWyM7llp78ZBqQ
 lqIMI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 3 Aug 2019, Pratyush Yadav wrote:

> On 8/2/19 6:09 PM, Johannes Schindelin wrote:
> >
> > On Fri, 2 Aug 2019, Pratyush Yadav wrote:
> >
> > > On 8/1/19 1:12 AM, Johannes Schindelin wrote:
> > > >
> > > > I would be _extremely_ cautious to base an argument on one
> > > > particular setup, using on particular hardware with one
> > > > particular OS and one particular repository.
> > > >
> > >
> > > Agreed. That's why I asked for benchmarks from other people.
> > > Unfortunately, no one replied.
> >
> > What stops _you_ from performing more tests yourself? There are tons
> > of real-world repositories out there, we even talk about options for
> > large repositories to test with in Git for Windows' Contributing
> > Guidelines:
> > https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#per=
formance-tests
>
> I thought the point was to not base all data off a single setup?

You misunderstood what I was saying: a single setup is bad, and you can
make it moderately better by testing _at least_ with a moderately-sized
repository [*1*] in addition to git.git.

So yes, it would still not be enough to test with, say, the git.git
_and_ the Chromium repository _only_ on your setup, but if not even you
can be bothered to test with more than one small repository, how can you
possibly expect anybody else to add more testing?

> [...]
> > I wonder, however, whether you can think of a better method to
> > figure out when to auto-refresh. Focus seems to be a low-hanging
> > fruit, but as you noticed it is not very accurate. Maybe if you
> > combine it with a timeout? Or maybe you can detect idle time in
> > Tcl/Tk?
>
> Hm, I don't see a better alternative than file system watches.
> Timeouts are a heuristic that can potentially be problematic.

Let me stress the fact that I suggested a timeout _in addition_ to the
focus event?

Yes, using a timeout on its own is stupidly problematic. That's why I
did not suggest that.

> If you do a refresh too frequently, you hog up the user's resources
> for little benefit.

Indeed. You want to find a heuristic that catches most of the cases
where files were changed, while at the same time not even _trying_ to
refresh automatically when probably nothing changed.

> You don't refresh frequently enough, then sometimes the user sees an
> updated view, sometimes a not-updated view. This inconsistency, if not
> fine tuned properly, can prove detrimental to UX.

Right, exactly. And of course, since you are not changing your own Git
fork only, but the Git that is the one that most users will use, you
will have to consider carefully in which direction to strike the balance
by default.

I would contend that you should err on the side of _not_ refreshing, as
that would probably affect more users negatively than the opposite.

Ciao,
Johannes

Footnote *1*: I don't expect you to test with the largest repositories,
as you are unlikely to have access to anything approaching the size of
the largest Git repository on the planet:
https://devblogs.microsoft.com/bharry/the-largest-git-repo-on-the-planet/
