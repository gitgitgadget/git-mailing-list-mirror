Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E49C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2B920BED
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BsrSq6Ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgJOLqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 07:46:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:60767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbgJOLqB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 07:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602762311;
        bh=F7WjGUJh9+QXLpGI++hlNRurEto1oRjjj7te1IbEQOQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BsrSq6UlSVJYRzhZrOv70esIKhrN339CU+cRaN61LZ8E/7/CaAPPAYlLA/kJffUS+
         x6Z8UHUPtHQTGjWjozKaraAgUjlygv56CbxdFG7yJUJdt8geYtjhU0e23WvGepmAW7
         sfqDwUmgB+tPerTvQitX3Vbyq7FnCy3xvdfkR5aM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.213.107]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1kpckn00Q6-00MZjy; Thu, 15
 Oct 2020 13:45:11 +0200
Date:   Thu, 15 Oct 2020 13:45:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add -I<regex> tests
In-Reply-To: <20201013190113.GB9341@larwa.hq.kempniu.pl>
Message-ID: <nycvar.QRO.7.76.6.2010151343570.56@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-4-michal@isc.org> <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet> <20201013063846.GF3278@larwa.hq.kempniu.pl>
 <nycvar.QRO.7.76.6.2010131337320.50@tvgsbejvaqbjf.bet> <20201013190113.GB9341@larwa.hq.kempniu.pl>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1137850036-1602762311=:56"
X-Provags-ID: V03:K1:bC7AfFtUH0iizqXdn5nyg4xQiGqg1NuI1I0TPNltwpQF95ItSET
 jgpz5Bsi7/gjbstD0uRvddWB7DRMqzOpYjA5sBVwZuC3J8ZMnJdUwUpX+AVsmdsAzuLAoJ/
 3+9EEnTlBqsCtekV87aryu0kcxkgZSmi2NfdBTxQvvLk5WP5rYWDwUA2Qnce04HvX0FcAAm
 Zm/6uORXpiW8z/2pVBNJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NjrMygIDFjo=:FSFqxlpf52QPfhfSggzAQT
 gFJeJYiQxR5H4I1nyvWpK5HDX2pEaEvyijZWcGG/OWytn27zeHW8vGkLr2hVSkCsn5B2zOit8
 sGDDSYPFIppYiywl3f4P52P1mNAuKQ9Fr5i7nHwGz8Ag9cn3/9Ri4dhlMZC2j/1E3PeeNL9PN
 RrW05tlA3q6mI9qjyGLG3IFuXXqk8ik16glkVhYXxx9ssIevIL80/Cv3ibu+kfqXoR+j/OA2t
 DDRWdmuTzpYYMHfsTZllSQ1Mz1gAD6ylQKMKcC9cpectHBET08EV4JzOCESa7pEkGqEP78l+R
 BpmgqdMYJP0Q50O41q/roqEBU2kov1rCenkuAecsY67qaQgHjfg0ILOEARdZVgVCJvZLyQ9cm
 44RUfqBgx51oCEMnzXMYQOF16ZXkqd5vQPhGvisrb3MKSY+8AW3MBc/Uvj3yYCzyVEVy0A8YY
 p328E5Fvl0tJDMzSOrhjhaG2+yIjBoL1EvVIt/Vpn6/M6HAvxWmQdawueDudMFsWnJS2wLOZh
 zyOlW6CVhY+QOuBvEhBBjtzIIfEZVvbGagZYAfUA/5tTy27hg5PY1dlN7t+IYxuN1m6DXy68V
 CMi3dX/6FjU79pFnZqOcKlm/6knGRRCpd//gFcWK3QY0/OYBkQv8CLp6rR4awcmiMjXUh8bV5
 VbYTxl7a89S2denzRx+vfrjTw0zgZR4RxcuP124CdXMKNRBRjTKDDNW8J/Q5OY5hyA5PrOZLx
 tna4df1M0IigyFjrMcly4RMEUrxAPe4nXUo1N5n8xgNogPZAfCmD1nx7n7oFPXXdWt4Y1dld8
 dqTVCC28USnPbxc8LYsu7FwDygyURAZL0+tnHY26J9bpe9+PL35858iw2F5Rdd3KBMHSrTYFl
 xgamV3EGLqhzcHP0ifcc395tdRbQqqW6j7cqno1ts=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1137850036-1602762311=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Tue, 13 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:

> > > First, let me say that the goal of minimizing the run time of a test
> > > suite is close to my heart (it is an issue at my day job).  Yet, I
> > > assumed that this new test would not be detrimental to test suite ru=
n
> > > times as it takes about half a second to run t4069-diff-ignore-regex=
.sh
> > > on my machine - and (I hope) its contents are in line with the "test=
s
> > > are the best documentation" proverb.
> >
> > Sadly, the test is not quite as fast on Windows. I just ran this (on a=
 not
> > quite idle machine, admittedly) and it ended in this:
> >
> > 	# passed all 11 test(s)
> > 	1..11
> >
> > 	real    0m51.470s
> > 	user    0m0.046s
> > 	sys     0m0.015s
> >
> > Yes, that's almost a minute.
>
> Out of curiosity: is that under Cygwin?  I have seen shell-based tests
> finishing in 15 *seconds* on Unix-like systems and in 15 *minutes* under
> Cygwin, which would be in line with your measurements provided above.

Close enough: it's an MSYS2 Bash (and MSYS2 is a close fork of Cygwin). It
is what Git for Windows uses.

Ciao,
Dscho

--8323328-1137850036-1602762311=:56--
