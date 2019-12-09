Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA3C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F264A2068E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="L61CQvyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLIP07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:26:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:46307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLIP06 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575905208;
        bh=ceTkCAs9LmMw4D4gn1rSwOlcyqk5kVjPWbRd0/VZQT0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L61CQvyJXKfm6Fhq6VG293P3eGI8EBfooyXri2LwpdwEq+r3G7MqOb+mc8/awIOao
         tLfkdlumo0R7oIoBga7JmaM3xgpDD+zdSfYU1No/M/n/eRqF7HL+AlzwNNX8fYt92h
         Kk047od3zKqmW+LMKbgLGoXLh/qzfEROweUA1dUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1iZv4a384m-00DHzj; Mon, 09
 Dec 2019 16:26:48 +0100
Date:   Mon, 9 Dec 2019 16:26:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Marc Balmer <marc@msys.ch>
cc:     "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
In-Reply-To: <1676A670-C8B7-482B-B330-B03B35CB6B5E@msys.ch>
Message-ID: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
References: <CANxxO2MGJ2Wo6Y-33KzzPXz6vktRACk0Oi2Y6o_s-cDFRhG7+Q@mail.gmail.com> <3b9408a9bd87ea488c4a6b9bc2583aba56ce3949.camel@swri.org> <E8FC0E5F-DD83-4470-B068-21865ECA84D2@msys.ch> <e19d7992acf0efc990aea356716a3afa34e13cb7.camel@swri.org>
 <1676A670-C8B7-482B-B330-B03B35CB6B5E@msys.ch>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5fqRvEjcWilwh/d1FnoC/Nw54WKgbZgKwZh52UcqbibnuHAFqha
 Ekx4uWhrzlmfRf9dY/rjCor8+1JO87ikBk44UHTEq7Gs+pl+QzXfv0EH5+gWzfAxLbGBuZ+
 uyD793emQSwk6ngnM7PknsO2FlAyMhEX1n2bheLacBiRXmQVHJnMSAHstJ5cdUxzMF+blgZ
 ifU5I7MKFTiEmIoZkdbxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7NEfW78lRyc=:oyqJ4Ehk4Oq07YUHkffPuP
 FPZsvNOVC/FhlsGB6KYoGsbHC71Bpv423ly2Set/ao5gqhwots6MzI72oT9r044G+yiK4dtSd
 wPkbcu5t4q8PLA25ew2GXbjd+Yp4mWSHn1E2XdlBTP2ujiV1sFipnHeikUbds6hqBxpR9s+0Q
 ynHw7OyRWHMcjgQdZJzK+pvyduuwhEjtcIJ5wGWbokH0uSRvW7TnmPfvgqb4DMnzX5RrlBBIn
 5PvVhxdfqzLwgNYJ0ipBGH0YyWlX+o33Huo+PtWNqp3UuTI9M2HHwiqVMz3sWAfjOsG0h+EWG
 vW3jrlu9bAJDhuoOjyo3SYU7pXamDdqVJLfNmuUvSyYh/Y1k5/7kgDp8aSXMHQTHUZTaoNoUD
 5tPH/m13ptqWT2M0K2+0PFB8LCqcQow9ywAT6aRHrQQQuKQlUryYc22R7jG8S1lG6XYEVmPNk
 732RHpvlNceDGcobblPvmSRPy5FI470HYYc/CGHfaIPReIskZXyOrqYHYbgItqjLKM/euNxaA
 1crq2S3geJB8W0SoTsOuwsazWdEoAKvxMgyK4g8bG2Uz9ftx/zNeRlORpg81j6LIfhev4YRVF
 zZaxTEFiLkQjEWKineVqQ92gUswTXcXwaBrCzRAcNGKDBmDiXbgNNEo+KQ7UcDpC3dRyRuOUD
 xLIAgeg8D72Hm23gikwUlI3GSncRtex8PPtmpPJGSRvxe1Qd0jw35MgRx24eRyMRZca8psOQU
 zi55TPLrCeYQLdVhpHjvcttE7o3TIEom0CsBq8EpluDXYQvwovflSd+Nvlwmi02Xe3L3dpI5Z
 71h4Wp7VbMJ9r6LxZBrUIOHagrcSfhnwDdBAXE8z8qI9tW5wjKMgZMo2bJBNABKIik/SOOAPK
 nOEAABEjU98eD9MHxACPNZdfw1FGFs8rFd130jp9Ab0IALHh9z5dFMn35a0W1cvko18HckKCV
 pOeyToJbEa8IeBeT5Cl01offZs+zEXPNYbpw7gZAqleg4d7Ub0G05OtsPXk9N1M+LCFA5BPF8
 DZ/Ffqe1c5ifNP9Jk+NSwm7yj1Z99XX7IxAD4tHfNkNnpRMem6GNiwaX7m6zOWUNwySV03nxI
 9K+y5ovgL+b3kDqKnnWUjOBL866w7sQFlYF/n95x/m2C+el1yz/O3mceTsUDvSvluZZP49aKX
 Y2kIhQlvgNy0AqGMOsrrhppuBHyqWnkpfnwM1l0G2cw40VjyQOAJgP0mINVUDB+6lIhKs24y4
 2p0AvMtx24sIm+Hac1l+sivB0wc/6IE15Y3nFa5CJQWsGon6rKV3DKFF3x8U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 9 Dec 2019, Marc Balmer wrote:

> I am not familiar with the source code, so I can not send in that
> revert.  I can, however, say that I am grateful to whomever does it ;)

I am against reverting the change without knowing the root cause.

The recent reporter only compared Git for Windows v2.19.0 vs v2.20.1,
which is _quite_ a big difference.

For what I know, the problem might be a change in the MSYS2 runtime that
is mistaken by some malware for malicious code (we did introduce some code
to emulate Ctrl+C in MinTTY which injects a remote thread and executes
ExitProcess() there, which might very well be construed as an attack, even
if it is actually very much desired behavior).

These segmentation faults in `git subtree` on Windows have traditionally
been _all_ because of overzealous anti-malware.

So first, a much more fine-grained analysis would be required, e.g.
comparing v2.20.1 against v2.20.0, then copying _just_ the `git-subtree`
file from a working into a non-working version (or vice versa; I would
highly recommend using the portable versions for such side-by side
comparison).

Ciao,
Johannes

>
> - Marc
>
>
> > Am 09.12.2019 um 15:18 schrieb Strain, Roger L. <roger.strain@swri.org=
>:
> >
> > As I said, I'm using a custom script here. I don't know if anybody els=
e
> > benefited from the change and hasn't said anything, but I won't object
> > to someone submitting that revert.
> >
> > --
> > Roger
> >
> > -----Original Message-----
> > From: Marc Balmer <marc@msys.ch>
> > To: "Strain, Roger L." <roger.strain@swri.org>
> > Cc: ns@nadavsinai.com <ns@nadavsinai.com>, git@vger.kernel.org <
> > git@vger.kernel.org>, Johannes.Schindelin@gmx.de <
> > Johannes.Schindelin@gmx.de>, gitster@pobox.com <gitster@pobox.com>,
> > pclouds@gmail.com <pclouds@gmail.com>
> > Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
> > 315a84f9aa0e2e629b0680068646b0032518ebed
> > Date: Mon, 09 Dec 2019 15:13:47 +0100
> >
> > Roger,
> >
> > I am all for reverting it. if that does not cause any other regression=
s
> > or headaches (or both...)
> >
> > - Marc
> >
> >
> >
> > Am 09.12.2019 um 15:11 schrieb Strain, Roger L. <roger.strain@swri.org=
>
> > :
> >
> > I haven't been able to find anything relating to the issue, but I also
> > haven't had a repo that exposes the problem to test more thoroughly
> > against. If this happens to be a public repo somewhere, I'd be more
> > than happy to take a second look.
> >
> > That being said, if the community feels it would be better to revert
> > the changes that were introduced, I won't object. I've had to further
> > customize the script for our internal use, and those changes aren't
> > something that would be useful for the public at large. (A few changes
> > relate to the presence/absence of a specific file, which I certainly
> > wouldn't expect anyone else to have.) Short story is we're going to
> > have to use a custom script going forward, so keeping or reverting the
> > changes here make no difference to us. I still feel that the changes
> > which were made make the script more correct, but clearly there's some
> > undiagnosed logic error somewhere.
> >
> > Honestly, I'm surprised we didn't see this particular issue show up on
> > our own repo; it's ridiculously large and complex. At least if it had,
> > I'd be able to troubleshoot it more reliably.
> >
> > --
> > Roger Strain
> >
> > -----Original Message-----
> > From: Nadav SInai <ns@nadavsinai.com>
> > To: roger.strain@swri.org
> > Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com=
,
> > marc@msys.ch, pclouds@gmail.com
> > Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, after
> > 315a84f9aa0e2e629b0680068646b0032518ebed
> > Date: Sun, 08 Dec 2019 12:30:48 +0200
> >
> > [EXTERNAL EMAIL]
> >
> > Hi, I'm curious if any of you had any luck in preventing that
> > seg-fault in git-subtree script
> > I'm encountering it myself using git 2.24.0.windows.2., seg-fault is
> > in the same while loop (currently on line 757)
> > When I tried your suggestion of adding the ($parents) ($rev) to the
> > progress print I see that the last commit have only one revision
> > printed
> > like this:
> >
> > 259/290 (523) [271] (843dd34090d36dfabd6a2e3e8459a4887427313b)
> > (a69ee056f66acf66c63f89f55d26c0cc17036623)
> > 259/290 (525) [273] (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
> > (843dd34090d36dfabd6a2e3e8459a4887427313b)
> > 259/290 (527) [275] (82303752a428cf1d789ac9f156008adb2798b7b5)
> > (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
> > 259/290 (528) [276]
> > (7187897883c9fb4d33d4c87a02b876f8603728ff05f0945ae2ce9f98a35135)
> > 259/290 (529) [277]
> > (a00a3665343439a426671958dd90ed0407a22cad9ac9f156008adb2798b7b5)
> > 259/290 (530) [278]
> > (90beb94ebd331c457d79d05341453f5829a50bfcd4c87a02b876f8603728ff)
> > 259/290 (531) [279]
> > (9582e0acbed1910173564e250f350b5cc4291a7f671958dd90ed0407a22cad)
> > 259/290 (532) [280]
> > (f183930d6fabd3dccdddc5ec35d754ad28caf3b879d05341453f5829a50bfc)
> > 259/290 (533) [281]
> > (c9309f3a38c41f7991d9e78ddb47f7e85b8521eb564e250f350b5cc4291a7f)
> > 259/290 (534) [282]
> > (3bcf08f63a0e2b93ecc376bd679a16c80e99e7b1ddc5ec35d754ad28caf3b8)
> > 259/290 (535) [283]
> > (134621bb55a0470cdf6519ce08d6909af43ce0e5d9e78ddb47f7e85b8521eb)
> > 259/290 (536) [284]
> > (edb3471fbba29748f9784d29b3cee1dee2df4b37c376bd679a16c80e99e7b1)
> > 259/290 (537) [285]
> > (dd947a095df07a32dfd56666a395a7c42b25ca116519ce08d6909af43ce0e5)
> > 259/290 (538) [286]
> > (a639e09d2cbe1ea1149c080c1c95b8b018340ae2784d29b3cee1dee2df4b37)
> > C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 757:
> > 8853 Done                    eval "$grl"
> >     8854 Segmentation fault      (core dumped) | while read rev
> > parents; do
> >   process_split_commit "$rev" "$parents" 0;
> > done
> >
> > I downgraded git to 2.19.0-windows.1 and it works now.
> >
> >
> > I'm thankful for your insights
> > Nadav Sinai
> > Web Tech lead
> > Philips-Algotec
> >
> >
> >
> >
> >
>
>
