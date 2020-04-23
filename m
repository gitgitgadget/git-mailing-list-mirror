Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA61CC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C709420728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c8rakYwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDWWME (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:12:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:38553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgDWWME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 18:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587679914;
        bh=pSX+hy/S2HHIRtkVdvTIRyPxaMXAGiEAybIHnOol9O0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c8rakYwf5havUn8QwiNlhDpPO5vm02C2YCUeMBy33UG0ge0wAYYX5sQiVY7P/aNFg
         2ZwOHLrLnd5/9LHjaWFSu4vC+kUSmhJ/nE/QeZ1wfdxvyBX6sNQVtyMpPp+UnwyEtv
         OEbRJyJeD1nEKLW08WiGJnlYksH3aIknxQk+1hiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MA7GM-1jKdJw1nMQ-00BbXJ; Fri, 24 Apr 2020 00:11:54 +0200
Date:   Fri, 24 Apr 2020 00:11:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 0/3] credential: handle partial URLs in config settings
 again
In-Reply-To: <20200422224711.GC140314@google.com>
Message-ID: <nycvar.QRO.7.76.6.2004240006510.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <20200422221334.GA571740@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2004230019170.18039@tvgsbejvaqbjf.bet> <20200422224711.GC140314@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s2Aq1eNUsdZ7A137yOxDGnY75oOeRlNmsP4Lm4lgFq98TZJJjZN
 fJeQ/jAKGA6nEXZb7M/wKukcfqiDYAdU6fC0cZpF0A0oRG6UEAN8Xs3wrri5V4nQfKWDZj/
 pir2V8gekkX7WSS0skt/utJgzNU4xsDpGzBkT92ozNYeFzni5Q2RGlHtSh9SpD+BwURsHrD
 +NAmS5fYIcIrS4xRaf2QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A4Yu3gHScGE=:pTFlk5RssMuThWySxf403H
 xJ2zbc09RwbM5FnbW4RhuVxVtxM3o8STlP9qR0b/HoEDhbTmLCyzedfoBrXA95puta6REcou7
 r4JKEz83Z1EHAhdL5PLQRviMyV3UPwBU+tPBIZXRWJVEz6FDHSeiNho9xnSklcxh6rlZSE6sn
 DYUdBFzQF3JTL7k1jNiFmY/0V4lcbfO+tNpI0tUwy5HqSpKRjmjbLK1WIadu5Zz2FAQ3Bmc+g
 Ufz48GEcKOldBEzpBWGYf14bIRwZNQgl/rw9s4q8EqbJnMmdPpbP2RyJcE7nfbYa7iUQuuw9a
 oida66n/qcqUNzfJIl4JZjsflVWDWiR902ntGdssNFWnuFHeM7o/hkhapbO1gnWeST/BdQYYj
 JyXQ7Bw+8Lxq80J3htYqfVZ2aqI1AJkEt0uiwSIFLwXm06nr/IclMmoe+vtI1lCsV0jUOPsba
 bzyMEPvkFa5cq8tpt9pMtww90L76QvZqe1AIe7U+NFwP/tVBZK0WyBOJo5ToHHOL/eJNOrtDf
 oNPVWHt7yQPgpZo2Q1sR2yLMM3aNkx+sGP/9q/ECYjvxSV44U0F6+P8pbxY8+70YgwRCpko/V
 5HnxO4lWdExIb4yAbvefSs03chLgB/XUoA/BeiUX9holwfQ4hSLP+62n+UZYYTFatEN0RSoTF
 gkv9GdFT6sDZZs2uxVx28Nd1gQQgEvM7ldiU8e8U3KgJl1c3DIQghrd9jLjxbzpKXMil989N8
 s6XDN0L1hB5Ad52loodimLdlTxESEJJldM6Eqs6vFrDPBN3Q52mlYlWKlIqLCgBP/5I8T4zEw
 qzx/ClmQmhMAETMYQCZs9b4lSOJR/ucsP6INt2lLVMWfUdg+uny/ksrv7ezz0qgFaZ9opyEAr
 BtXkgg1lBbpPcGiOPgWaZYQOGa/FGIwnbDMwWq5zIcHkwnn0OPVgwqMk/meMbaydEhFgqf2lG
 7JxQyjDrXWeuIDvWYFKSqDG3Z4S+UKXi8MlIpcuZQVhltEONoD+t9sk/7c43G21q/P8tnZnVy
 l/9qyd6PSd00Jb5xEViM7VnoRfwHKO84FTyYWuHvpiXALMCjK6CxgkLdycPRCh7174YoK6zWw
 hrIaCc0tUGnM1G5VAMsSZoHFykxU8zf6eYkyigUr/6uYDKBt7CFMWXMLffzTWjfoODSZmbmH5
 2TcgIn7vSfvknrOXUeEqWs/VoAB1juR1JlXtHh3IkscrmYKMMXrtOxXLWvpTQ9wvxiXNk1tmZ
 HBoUFGAGqhG2AVZ5z
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 22 Apr 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Wed, 22 Apr 2020, Jeff King wrote:
> >> On Wed, Apr 22, 2020 at 08:51:02PM +0000, Johannes Schindelin via Git=
GitGadget wrote:
>
> >>> Please note that Git v2.17.4 will not do what we would expect here: =
if any
> >>> host name (without protocol) is specified, e.g. -c
> >>> credential.golli.wog.username =3D boo, it will actually ignore the h=
ost name.
> >>> That is, this will populate the username:
> >>>
> >>>   $ echo url=3Dhttps://example.com |
> >>>     git -c credential.totally.bog.us.username=3Dfoo credential fill
> >>
> >> That seems scary. What if it is not .username, but:
> >>
> >>   [credential "example.com"]
> >>   username =3D foo
> >>   helper =3D "!echo password=3Dbar"
> >>
> >> ? (Or you can imagine a helper that is pulling from a read-only store=
,
> >> like "pass"). That would send the credential to the wrong host.
> >
> > It would. But I am not aware of any implications regarding `.gitmodule=
s`
> > (for some reason I now expect every bug to open an attack vector via
> > submodules, I wonder why that is), so that's at least good.
>
> Submodules are only one of many ways that people end up cloning from
> an attacker-controlled URL.

Yet the vast majority of the vulnerabilities in Git that we fixed over the
last years has involved submodules in their attack vector.

> In submodules we're careful not to use --recurse-submodules by default
> at clone time.  So I'll mentally subsitute "attacker-controlled URLs"
> where you say "submodules". ;-)

Say what you will about this, but the practical reality seems to be that
most of the security bugs in Git affected submodule users.

Somebody even muttered the suggestion to me that submodules should be
deprecated already.

> I agree with Peff's concern about the unpatched state: since there are
> people who use `[credential "host.example.com"] helper` and there are
> credential helpers that ignore the host passed in, the combination can
> hurt people.  (Fortunately, there aren't many credential helpers in
> that category that are commonly used.)

Yes. That's why I want to make sure that the URL parser we use here is
strict by default, and lenient _only_ when parsing the config (because
then, it is more like a URL *pattern* used for matching, the parsed URL is
never used directly).

> [...]
> > Yes. For the record, I tried to be very careful here. The _only_ code =
path
> > that is affected by this change is the config reading.
> [...]
> > But again, I would love another pair of eyes on this, to confirm my
> > analysis.
>
> As mentioned above, the config reading is sensitive, too.  That said,
> I suspect you got it to do basically the right thing.
>
> Reading through the patches.  Thank you.

Thank you very much!
Dscho
