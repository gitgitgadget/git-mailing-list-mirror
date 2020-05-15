Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87702C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605F2206D4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jLdQxMW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEOWmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 18:42:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:55211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgEOWmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 18:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589582526;
        bh=wEqe4JjsNwCJRxPWp2KOvqTJn9icOysx+0UVBF+fMBo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jLdQxMW4mVN+Fc9mhTK4WdbYdEx3NkaycBQzPV007oZk66Qdw1lbEzuXT0nIRl97I
         fpqNOLDB0fRqTSJPitJQ8/VQg4y+le4stF0DHdP5o1UJ0NF9kZiPNRtzU/vLJLC6/L
         Nu850j2rLVPKPQ13GCT+joCX7VNY4gWYz9fJAArI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([89.1.215.229]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1ijLtZ0OQJ-00qjB2; Sat, 16
 May 2020 00:42:06 +0200
Date:   Sat, 16 May 2020 00:42:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        congdanhqx@gmail.com
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
In-Reply-To: <xmqq3681m7s4.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005160041380.55@tvgsbejvaqbjf.bet>
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com> <20200515150041.22873-1-carenas@gmail.com> <880ded78-21c6-9310-6c5e-422f6a63ad47@gmail.com> <20200515154539.GB61200@Carlos-MBP> <xmqqlfltm9b5.fsf@gitster.c.googlers.com> <20200515171428.GC61200@Carlos-MBP>
 <xmqq3681m7s4.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1268036570-1589582526=:55"
X-Provags-ID: V03:K1:4XcLQIkztySbZY428K4Rnv3Svo2k3mWmyLUn/kIHNmlwx2EQey3
 tVCZMLt2PNK9cI8VhcV7Z9ci4AfVNTlj5bHov86nkfRV75T20q00EqS1r6cxYJo384atMnU
 gK2riRXSVVE+QBc2vmxsYXOjhBt0fd6aOq1AIabzzlTljHJ9OQEswlHIgCQQQICOGPacanZ
 M/gCs2I8a4tO8fNPseM7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XrAqcJwjpPo=:roh+aV2Q6+PIuUoP2is5rQ
 UMfR7qpmRnqiFJkxiE2QsYCTWbrAX0RJOWTiBbNi2qL3MmFg9ecqfHy3o1grakWrvqhzF8p1V
 OGV7dEOPOxA06GePicfUjkyWdrP66deCVWrufhvLlPi/afnVsrRMLcREK28owBmwp5qS3i/d3
 /icaxO0P/Mox2si/xUKQbmVMYlKyEuKBpWYFD69VFyHhJUPAPv7qyh2E302Hh3qIeB3urYfRM
 y+8o1YX7TgH0uOwcyl5MseDlQMp4KctbtsTyQlG5gq7sdbIFhNUT1VcbyLi9hyoVsddrxhIkT
 xAmiYf8hYEE7TOU6eo0Od5OYCV11bTR2hWCGNKQpTI9i9HTuZY2cUmx6XSE4lvOFZfpDyyfWf
 7ycV38S+c9tYXLQaveLK7kjjsfn6wyFEj97jxQ+LyFWdjhxz/3CWbXGX29R+V/5ll90tWWrrj
 kD+VRlzAPv12fkIUSFl/NhScWRMSsNBS4RkCoI+yLakXwyHNyWXOQfXg2xC7ZkKDA1rP161J+
 zqBQSL8qC+3a5S8XtGISOKlYeU2JTMFlo0kyKLSBhV427cFColcxuGjrgHPd9oSz3ez7ix9WL
 mRkOqBGOkPXOYwSryMZrkZhWKVCFbrg8vhBqeSI24H+A7xSP/mGZa3XLjUaM+o1j6oT2Zj3EN
 bf9IYKLa9Y3BTBUW/nXbmRVQfbeZY4BB+jeg2R52baUfy0gKQkREUZ327o+CYAdU5Zw7N4NJJ
 BZQ0vcToWMMHBjrLIJWnqKolwcQ7vQHgmNfK9F4WBD23fSiJEZO/pAcpUWBZGmjdQJq/pk7S1
 aWZB64RL8AA7rQnM3pQydoGGpZeo6fRf6sHvsJI/YJXVuheagbVct4rUDHqJCOL8+Nu9JSsB+
 HvE/nAWi1IZpzgqk35ncO0ysJ8B2jBsF5P5dCSGBFeUqz3Qn2++Z+I57WJJTjheiFCRx9/B58
 C74ag7MmOL1927CD+vd8bD7dlU7s/z8JQDfiRCNPGFIpgxvKHL82rKtRhfHWlnSpYy0TpVAgI
 O8EXxbfyysrpFMpbmVTRX8xeDpDKqlNNiqKfx26JsZFr6u5N0C+l6n4aa4SL+VnanA8JqZ7HU
 meGFmmQZiRitMTz76X889YdDyvn3PvweL+ymr2rKhJRZR/69ZMT9Ym2y/VCh/qJZ/7xf/gnw+
 Q2liIzASiw2v0SGLRbQzjlOcNfAh6IuWhne9IwYLfOwOCTlJ42zL1ETngcISOmeFZwtTlTX22
 WnLCiF6EffE9kMGBe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1268036570-1589582526=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 15 May 2020, Junio C Hamano wrote:

> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> > On Fri, May 15, 2020 at 09:50:38AM -0700, Junio C Hamano wrote:
> >>
> >> At this late stage in the cycle, would it be a safer change to
> >> revert the whole thing, I wonder, rather than piling fixes on top of
> >> fixes to the initial breakage?
> >>
> >> 303775a2 (t/test_lib: avoid naked bash arrays in file_lineno, 2020-05=
-07)
> >> 662f9cf1 (tests: when run in Bash, annotate test failures with file n=
ame/line number, 2020-04-11)
> >
> > will also need:
> >
> >   676eb0c1ce (ci: add a problem matcher for GitHub Actions, 2020-04-11=
)
>
> Yeah, I think that is a good idea.  I suspect that leaving it there
> won't cause problems, though---it would be just nothing is found to
> be clicked and that's the end of it, no?
>
> Will add a revert to the series anyway.

Yes, I'm fine with reverting this, as breaking TAP is a rather bad side
effect.

Ciao,
Dscho

--8323328-1268036570-1589582526=:55--
