Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982FAC2D0EC
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:42:32 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648A9206C3
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 21:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Pw/CR0d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648A9206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgDLVma (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 17:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgDLVma (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 17:42:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F72C0A3BF5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586727743;
        bh=vwAz5i87oyBl3WnS7kJUvrUbG4tox17Awin/7bxC6tY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Pw/CR0d4s5WtUwtinm/5iXXTmnfAGZoI7QbPFysnTpBpfSKV+JZysKrUyctIoHFup
         TVwBumu0hHhNgI9f6aYykGYxkxI52cK9s2KeyCgmD0Yj5I69bQD5WLNqWmLDDdJrj0
         gFD4fZmNfXwOUr6MPbqJpMtaFmobxwLrNm+B51Cg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.12]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYNNy-1jjJVt1QGo-00VSxJ; Sun, 12 Apr 2020 23:42:23 +0200
Date:   Sun, 12 Apr 2020 23:42:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
In-Reply-To: <xmqq7dynjgx7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004122339290.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com> <20200403084654.GK2224@szeder.dev> <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet> <20200410153131.GM2224@szeder.dev>
 <xmqq7dynjgx7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-452306205-1586727743=:46"
X-Provags-ID: V03:K1:j71xrpE9QR9Encclx0ESoUe1k57dFGSIdgGaN5K/x2voHqO8r9e
 K2EhI+YncfV1JOmLaODHnFYmChEiCXkK2Vaupd3W+738+iDIh4R6CHTsiAcrcy67+fkQfxZ
 poKdhpKJlKzJWYos/PK9RBhuPI6wyIWeljv9LaecoKOXSbNjQwkMIviFJFKUYhjCR1vrAF3
 KPp+Cc6ID5EsOEbmJ7aGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ei+2Z8YzMSY=:iDxr5hIyJZHr8xGRPV7xS1
 pFdU5JmdYz9JBbPVj5ZEGjNvXJDYW3IUB+pYypfVD/mAseiGhhY0nbuDUzq0Zv0ThSli3vtIS
 TWXkK6+e/dPeWWuZ1UoeWOJRvQXZ7yWQIlrWgrqvlXNSOgewP2Mw5+akKf2hpYX0Qgeb6qvKg
 eTsnQXxfOPkpy0RDfxhlBWdVPa3YTvDbGaEj28Lb5mkXHONNJVxXYhnYE5xeiZG4BYNMA4Zvh
 h8VpNvRHUFDeDqR6hKTVzB+wCjehAaLEXtOYT6opDDMNkpTY8bzVH0SsnL1ibUvDWzlthkPlj
 JOxCTkJrZsT3Et0wKJIcYgdGTSkcNyTWm9l5NXgA0TXtIeWBCXwUW6nx9RoRCmt8vM+EXSwNf
 gbPixgMqCkBhjoY9PoUWvEePkqpDN6paVyqOr4fuh8Ci4Q6CzNsD1fFUgoeF0d9WbFhUdtPrX
 sg8krTQSrDeOX8bkhMZ3Zuti4Ty679xbi0X77pX3n2HcL0IvRxsEPcPyXJZlBzP6/iBrM7qhp
 YBbmW1bhiiC7KZXS1jiOpJ1sFrFw5MmbeUgd05ZXQbu5EVTBblTSBfKA+ycsUEyMPWpERYp4I
 Z4zrOzrfD6JiKzhAt2mYN52doI8Dku59HnjDoxl6gb2CBTs1EkMCJZ/Z162IBBBovAEIs058P
 AJi27TSkLJ0yk05bMInopf23k0lTO0lMJHHWXb7rCCmMRb2Q6anlc5P+EtWL/k3PTyj97RKRS
 0t+SsnVocFV8kuGnAcmeE6u5GeA9tzcIeW6FP7NRh9pQLWW1OPYtoCRASJuO1RmQXu9vBPDze
 pAg00lZTET8xuPar8Qwl/Z1P/Y1a4qzj+mGn44BJ1ESRKVk2xLEkFxk/CzjPqKRgroXb5kMzt
 5XzNWvm2ty0aJpiZyrS0cXqWuEnxe9JqdZSAy2cy4/eRge31qtVkmLh9FXfmt6xl0cL6K1VRi
 jgFShtgXO88N2xtVMrHe++PEKOMnxo6tRQMpH67Fm62jiGKIoU0QZauReUIYheXM66ec34wyA
 eHnlWB3bL8fr96jmzVhrlZ/JRDu0kzkzA+2KHABpojFAX9ggRR4wfUAmZDfTQHYqH9OLMOLww
 JLlkxZh3cziyaYDd7We2AVHt4iXadghygJAOQR6ZAAs3GMlayYsdICGI+NjBmfYXIn/OeX5hL
 bDxBeNt0VPfcA5eMqZLLEOLuBTsbg/u3u8Nze2EjmP+tGf8zNT+XZRgo+G6jv0eqWww+6+9xt
 4ZWmKzR2L69HL9fAO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-452306205-1586727743=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 10 Apr 2020, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> >> > CI_OS_NAME=3Dosx.  This is head-scratchingly backwards, and I think
> >> >
> >> >   test "$CI_OS_NAME" =3D macos && CI_OS_NAME=3Dosx
> >> >
> >> > would read better.
> >>
> >> I can understand where you come from, but your code is not `set -e` s=
afe,
> >
> > It works as expected in at least in dash, Bash, BusyBox sh, ksh,
> > ksh93, mksh/lksh, yash, posh, FreeBSD /bin/sh, NetBSD /bin/sh.
>
> Thanks for a clarification.  I do not use "set -e" myself (it is not
> a good idea to rely on it in general), and was wondering if what was
> said up there was true, as it did not sound like a useful behaviour
> at all.  Not complaining about a non-zero exit before && or || makes
> it usable ;-)

While it is not in general useful to rely on `set -e`, there are
situations when it comes in handy for debugging. Or in copy-edited code.

As to the "It works as expected", this is in a Bash:

	$ test "$CI_OS_NAME" =3D macos && CI_OS_NAME=3Dosx

	$ echo $?
	1

Yes, it works, but in the common case, it exits with an error (that we
ignore, unless run with `sh -e ...`).

Just making sure that we're talking about the same expectation here.

Ciao,
Dscho

--8323328-452306205-1586727743=:46--
