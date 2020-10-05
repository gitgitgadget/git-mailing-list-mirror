Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E7C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 21:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8E3208C3
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 21:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PjuHUBFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgJEVUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 17:20:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:52569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgJEVUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 17:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601932850;
        bh=GqZkDPmtQ0CaGy4baCZ3NXpK4OLaKtWO69fz0i2DhzA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PjuHUBFBAvBkyZnzHNeIuO2Dd/tylZZon1pI14jR1C7iBPBLpfcodfDfmtad5okSp
         Kc7wshcIos8gA78U6GiyRUk8/NgOhDseto6uoiVqyqUpQmpWDgAFlHYetfAMPi61NM
         aKJ2tFE2gGStbw5PxwhypOSPzXYUilt+/3vjX2vM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.145]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1kw7mF29IP-00bw6z; Mon, 05
 Oct 2020 23:20:50 +0200
Date:   Mon, 5 Oct 2020 23:20:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/7] t0060: test obscured .gitattributes and .gitignore
 matching
In-Reply-To: <20201005084051.GD2862927@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010052306470.50@tvgsbejvaqbjf.bet>
References: <20201005071751.GA2290770@coredump.intra.peff.net> <20201005072102.GE2291074@coredump.intra.peff.net> <20201005080353.GH1166820@google.com> <20201005084051.GD2862927@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:geAN9qULUzVdQV590E5ZeYbDBZXB+EUn4Wox/R0Fi6NhnPZ3N07
 i+oTrXK/q0IoluRFxUSaDi0J5eccGFDioCyCVsas5Id2yhXyiT+GXvjLhviOUSLEXMjKZoP
 WSjVSyGNcWDOwInDsL7nur0jStxlOSjZYUorVNvE9V0P+45rx2E9bNWHL5g3xMsO/mq7bjz
 A/YOMVrYAJzfCvTa2QARA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0W1UeGrvZs=:tx+rag8yehabDeFol/a621
 bKe+Ju6Nz1ydOSKC4iwUpgH6zH0HtxKHihn0W/ii2vxq3owJP/GVqFUwCoHTPszUr4CisAVx1
 iBveJzPtToby5It2WVJpETwstgEOyAC047txArH7ZbtkgGaZKLoWmkne2bEifrI2zXndDP++6
 kEktrc+5hCISavM5flYYAcgpscmfsSYwIi4SS3eZuMItWyFIQaF6wz1IbMH7rLptpFgADcVIX
 6ROI7Uvvj10MzEcWH/m0mJJYqubZ16W7jYfBqMigWIykKDxyqD1VktGuwAGrK76ONkZC3HmVJ
 7kUzgAnwkHyXFQV8RuQyMtV1fTC69kv93Ppq6eHY7Zhiln9S8OUR7SozDXPtsmjadfgMUr34G
 tXkgnry1wtOYl9IIYVWeHZYsn4Emaw0cJTzhgwvI8mPIWKzrwi7QisPy0NYuDN1qo1BORMh9/
 cDkSROgiuSiFeasCopTsodeznHlYIMnVL0n8dxgwdMGdjObX59MX4xi9Q5T2MM5AYr5BalCTs
 ZCki11h6RQyQF0+v3mBqkvp9uaKmWFJwQjCFHiTBVhUfqdD5KboPxgJvktVq5FefYczMustyJ
 X8oMUAmBY30yXNX0n6g6EgPM3I9/1EDkR98YdhiGMBI1Db+9fyeV7rmo6+CypsGfQi3tvTB/E
 y9pbS6rtsUanK+PjRNFGCm8rt1RWkUmrwlOgmxz1II8DTj7G2Uim2fNQPLbfFL1Ajt80zKaVR
 VLmZ8Y/NIhaeHemVPiT6RnTHX+xM9zGqxtSSTqvObrLKS7CAOsCNB16MCEZlcHmMLvbfTxX6f
 XkU/UjYL7kiUkhohYsOxgE2mOQLEblx1QsWNb0dN/EUIu5rlHSCPLtotyeCZIsSqj4e1xTI8/
 e0lew95TGwnm3ftZtmpG6/OYgRfs833soq9/n5jxkwgAakAB/OY6kZ9ZdOU/6NomLyQQDIApa
 HbTrN0CW8uhFNLSuaoUA94D14KyMa+evKnpJsrMGvAj5Fgp6d3iKijyOwl2Li1grkG3a7m+Cu
 XrwfcFFhXNCLNBAumOFgCXgGyZL5DhTHAHgC2XTY5BRz5EtxOq5ySPR/3Ifj75jAcPgqOOOLw
 BfE+Avj1kGXggCoOWQzKMXK+WYZsWxiQfNhlsx97z/bQe0Jq+uXBdphtvQU7DShVzVYnbt7yp
 +Z6TV5NujsHHgYp/V6MRVZRDx4sNsLAnix8t01M8HVtSwMOz1YznXsLom4yHs3PpCg+EGzo8s
 zszgaEngxob+HudmdD+GCODBvBjM2/PK6QOJckQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Jonathan N,

On Mon, 5 Oct 2020, Jeff King wrote:

> On Mon, Oct 05, 2020 at 01:03:53AM -0700, Jonathan Nieder wrote:
>
> > > Note that the ntfs magic prefix names in the tests come from the
> > > algorithm described in e7cb0b4455 (and are different for each file).
> >
> > Doesn't block this patch, but I'm curious: how hard would it be to mak=
e
> > a test with an NTFS prerequisite that makes sure we got the magic pref=
ix
> > right?
>
> I suspect hard since Dscho punted on it in the original series. :) If I
> understand correctly, it would require having an NTFS filesystem, and
> generating 10,000+ files with a clashing prefix.

It's not quite _as_ bad: you only need to generate 4 files with a clashing
prefix and then the real one:

=2D- snip --
me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitattributes1

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitattributes2

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitattributes3

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitattributes4

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitattributes

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitignore1

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitignore2

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitignore3

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitignore4

me@work MINGW64 ~/repros/ntfs-short-names
$ touch .gitignore

me@work MINGW64 ~/repros/ntfs-short-names
$ cmd //c dir //x
 Volume in drive C is OSDisk
 Volume Serial Number is 5E6B-4E77

 Directory of C:\Users\me\repros\ntfs-short-names

10/05/2020  11:11 PM    <DIR>                       .
10/05/2020  11:11 PM    <DIR>                       ..
10/05/2020  11:08 PM                 0 GI7D29~1     .gitattributes
10/05/2020  11:08 PM                 0 GITATT~1     .gitattributes1
10/05/2020  11:08 PM                 0 GITATT~2     .gitattributes2
10/05/2020  11:08 PM                 0 GITATT~3     .gitattributes3
10/05/2020  11:08 PM                 0 GITATT~4     .gitattributes4
10/05/2020  11:11 PM                 0 GI250A~1     .gitignore
10/05/2020  11:11 PM                 0 GITIGN~1     .gitignore1
10/05/2020  11:11 PM                 0 GITIGN~2     .gitignore2
10/05/2020  11:11 PM                 0 GITIGN~3     .gitignore3
10/05/2020  11:11 PM                 0 GITIGN~4     .gitignore4
              10 File(s)              0 bytes
               2 Dir(s)  314,658,705,408 bytes free
=2D- snap --

But I don't necessarily think that it would make sense to add that test:
it adds churn _every_ time the regression test is run, and by deity, it
sure takes way too long on Windows _already_, and the test would be for a
regression _in the NTFS driver_.

At this stage, I also highly doubt that the algorithm will change ever
again (the last time it changed was several Windows versions ago, I want
to say in Windows XP, but it could have been all the way back to NT).

In light of that, I'd say that the bang is rather small and the buck would
be not small at all, and would have to be paid by developers on Windows
who already pay a disproportionately high price when running the test
suite, so...

Ciao,
Dscho
