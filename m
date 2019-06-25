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
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2E81F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfFYLiC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:38:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:33999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbfFYLiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561462674;
        bh=cbh20DnjRDtQMNeL/WzenG4rNMCdIn7CB8mzDPXHGTE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SDEVCX9X/VzP3l8eqNI/4aT+oYEwZBFSFTr3IKx4hBzWWLSMTz7V9rRVU1NMZsOo5
         lC6CEW4PBZ29eAwGWLl0wnGoOJVqhdWkywQpECaRUxIoIpBHCS0nqjhuxwhfhxU1rv
         79IdD7rqaQ57xQUNy1ipXZxzCXxIwlQGgjtB954I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MS5xC-1i7tZw1cmw-00TGY4; Tue, 25
 Jun 2019 13:37:54 +0200
Date:   Tue, 25 Jun 2019 13:38:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
In-Reply-To: <efc4a141-071a-6549-f25d-21cc6256832a@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906251336150.44@tvgsbejvaqbjf.bet>
References: <20190430142556.20921-1-szeder.dev@gmail.com> <20190611130320.18499-1-szeder.dev@gmail.com> <20190611130320.18499-4-szeder.dev@gmail.com> <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com> <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva> <20190624183927.GA10853@szeder.dev> <efc4a141-071a-6549-f25d-21cc6256832a@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1302675637-1561462695=:44"
X-Provags-ID: V03:K1:oZb3VMwaJmAcD2cgjnHhcbv8/9xWrVPxh9YbJXbrajYnHD/r4oq
 /0jDop5IOdqd5DXaVksnDsudmqj/Sn5DzfwzV58DGfFcWBUDsCCJxL/qOfMYRa4C/OaaqUK
 Qvpy109b0+kUWCgmU4x4rDyuueeBN0zRBlO5WaHK7OEOe7YpysaB6GHDaOmdBrjhewBrLz9
 NgiPl8+zEItaDfOY90HUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VoLOSjCrd2A=:59KIt4EFdb887vV5UlNPJX
 sSU9Ir39SxlhCA6992LYuCB+0KR5Azc8V0pR9C7u5WLosQGdznpJyCkZ0PLjK6/f1AkCESv75
 0MjXbgWs6A5S85lpX/xUfz+lQlWEBs/sLQawrld+EX9f7pOPMYz7NKChuVPLN6wAc3nYMph7k
 zYOKL6rn8YOCTcBrRgZtpVKUqr5wmwZRTFt5mpxHG35dwFdMcKCoZN75L2te6Iq7V4jbePzjB
 BpW++WyfirpofYhX78IaKwtGuTtQ7rLHg6MmIly5U1VPMb4GlNW+IWdNUdewfIDooMVmuMBGF
 BEkDV7jLxtMPiYEJH7N20/7uXXfCd66cI54IsNdu6eG4LRXQLGfApsMzZNxbXQ6oDFHPlr42C
 b+SIMYFF52wrFPYslHkt4xXnnQUVn0HsiaBmuIVuT87b9WFbRTRMa/Ig9pi7Bvj+3QEQWaJMj
 w8al85QzDObK69jjdn1jeo+hPK/2gIH3WMxc4TaSv0TpQsyuqxArfJzyGwvmpNhj+MYPkasPB
 NOaMHStp/6KmvKkaibsXZSzsmwLOa/ZViKymapBkh2eB79c0XWle578ire3O+8CO17yGtN9uC
 NcK9R8+RBeWL5w5k5IccEldt0RNtGEdeUy0QpWJ+WKQGVtgxfuy6QXCDYf37iFjDXnwL8kNGE
 Ja2VlAJ/F90MC1Cju2DgkbhehNujNzBrjZyCHAWxb7OlkH3a0njm0ukCxmi1YDCpybRo1X8Wh
 OSSp8zWS6G8KR+GxO4nXpkEjAV2uKJ4STE3+t/Frn09t7jJsjVDgV87UB3t8PYs2HJFdqah2z
 cT3b6RG0i6JFGGwTsz8RSeQgxp4HEzQo/eXpawUyF03gcmLR09UPCkJWozDQb7AQy+eg6PTGW
 JVOxxii7rAgHacI5S0QOPODPXi75aRrAlTOowAXiz11imZTGYkGBXS7QpC3AQ7ZxEop5oiI7B
 sVYQidPWnF2w2T0YtS/7gAK+DLaxoN8ZqO+QFp4uN76p1A2miwUveLqDoM0iatR3NVgpNi8MZ
 e6uPxVmKuYzCzwxaA7BLmKUclLgkDAamtDav12QiMYDjHH08JiqT57eko+CzDPqbG6bl5bKvM
 NVeJB03ffNsuEYaTVgN7AaOqZjjxn2wbmKk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1302675637-1561462695=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Tue, 25 Jun 2019, Phillip Wood wrote:

> On 24/06/2019 19:39, SZEDER G=C3=A1bor wrote:
> > On Wed, Jun 12, 2019 at 09:14:40PM +0200, Johannes Schindelin wrote:
>
> > The other yucks affect the following four tests in
> > 't3420-rebase-autostash.sh':
> >
> >   16 - rebase --merge --autostash: check output
> >   23 - rebase --merge: check output with conflicting stash
> >   26 - rebase --interactive --autostash: check output
> >   33 - rebase --interactive: check output with conflicting stash
> >
> > These tests come from commits b76aeae553 (rebase: add regression tests
> > for console output, 2017-06-19) and 7d70e6b902 (rebase: add more
> > regression tests for console output, 2017-06-19), and are specifically
> > about checking the (whole) console output of 'git rebase', so I left
> > the updates to them as they were.
> >
> > In any case, Cc-ing Phillip to discuss whether something could be done
> > about them (now perhaps preferably (for me :) as a follow-up, and not
> > another preparatory patches).
>
> Those tests were added to check that `git stash` was being silenced (see
> 79a6226981 ("rebase -i: silence stash apply", 2017-05-18)). I can have a
> think about a better way to do that, but is it still a problem? I just
> tried to take a look at your CI output and
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11406
> seems to be all green - have I missed something or has G=C3=A1bor fixed =
the
> issue?

AFAIU the test cases were patched to accommodate for the new output.
Ideally, they would be changed to not need any changes in the future,
certainly not to accommodate changes in unrelated areas (such as the
progress).

So yes, the build is green, and the patches are probably good to go, but
there is room for add-on patches to clean up the test cases to test
succinctly what they are supposed to test.

Ciao,
Dscho

--8323328-1302675637-1561462695=:44--
