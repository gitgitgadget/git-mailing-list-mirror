Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB0AC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A5E60FED
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhKJMOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:14:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:57659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJMOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636546273;
        bh=Bl2862j2dmsC2bliR6xWTxblA9//nRZLTFVlTPkzz/I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eu6q5W0vt8lz+gznxPJjSzjurlzj91xUTQe2pcVZdVnjNuTIPlFy1KSj9ewD76IKk
         +4EgD1xa+aVV/4e7tzE1mza9JRXsVpOTB9PU4j3Fxzf2QccDmyHfcG9VSDXxLb2T/b
         WlwoHpH4WSKhk3upD7+7sCtb/mCFpwamFnFkOoO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1nCqsc3hj0-00XYhN; Wed, 10
 Nov 2021 13:11:12 +0100
Date:   Wed, 10 Nov 2021 13:11:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 2/4] receive-pack: Clean dead code from
 update_worktree()
In-Reply-To: <211110.86y25wirtj.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111101303380.21127@tvgsbejvaqbjf.bet>
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu> <20211109230941.2518143-1-andersk@mit.edu> <20211109230941.2518143-2-andersk@mit.edu> <211110.86y25wirtj.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1607751677-1636546273=:21127"
X-Provags-ID: V03:K1:6AWoN9ynKqBHFwKCff7IGrjclZtUis5hZBlnxSzPnUz/n2SedE6
 usy+n09MRpRh9ywFfWKKngTjNKvGK1zYC5w5bBOq94f5E7OhJiod+8GEygQyeN/uoBN2RHV
 QIhfCozytPcKhaWRKDi+XFtv7YupLITRxXjL2YtZetZUGYaaEv5ZyHo78Nr81XhQXTUwUxG
 14HF+yVnSX2HblCbbCPPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mq6tFUCEGuE=:SD1iETR7UPMY6AuFoVWrSb
 bS4slGzJn0y0irO2fjDFwygirFMvooegWdL3WFScqEO1OuqB37/z8PNWqhEKrXmqcu/3lFC9G
 FBSPsBEQt26HcZzItrm549fmdfZUK1JKb46/1zChhkCDtRGTlKEYzzpsqotzbOf8IUhpLlQAL
 CNLU5HG21ks6qqonPSKcQiqCT0m4JEpzjOdngCMEtxbD8U8aQ21o6wnYvTVLwIrJ2k428UKFY
 ixGXWAqJKi90RzcPWtmzdsKrhiKWXmhU6EVa9BMqYi27RtD458hGD3BYFO/lwoXQ1kbSXB4Rf
 TDuL8HmWg/Q91xYwo38/hJDJY/HTIYvG10XNqnl7o6F2CajRULEaFu60WxDhq3hp0H11UIURh
 nqA+3qfkces8LvEfWpyBZKRim0jMHwAAqDEwa+Z7BkoKNAiPHCj2hrM8JcuYSEH6TmDREXAqk
 nl7esU3QlTpcraLIFHnrI51xWAbDzgEnvQdN6fm0nOZuPbyiR8I8XFtPiVrvq6Owcwyxjf2J3
 UcrxTc/ylAM9sWPIBFiARhfNokPYtQzHtvwdk0ahpywJYfv4fmkSH1/X5L/OEYefzbekFDBbH
 j8bNXHk80VNZqk/epVrLQw0MqJGH+U0snIHmjyoo8RjiY0AAdtrsKy8z18LqvDUDjgQAu1+uk
 aWoNfGEWdLaHI/himqbz1X8MIj/xVFAiTJzvhca4izWRR0qRlLzM9ydIlKZidy31JPyc7t/i7
 0w+Ox/CZdaL1zC75MAIgksRCAf1+nYyqRTSwy2E6tZBrnel3YP+9k/6r0ID+QbHGPRku4zk5z
 EUBBm54Hoztja5NU0lVfBAqWx/p/1ep8lMKNkiTuMOYir3tKdrIYhWDkOEznaX5QYTyssmbVx
 zSfbTyqjJkMQjWxM6/LvsU8g3bjYMjrOmGZ/xwq4DvgPtEDvUKfq2ISkCjRyeirHepqqC7rJQ
 Yi1Q2X1na1Yf21HXJRk4ZFbviTdVDm8112JIOpiH1F+g9gSTxqJJJtT3aDYICr9WJVu4EQSak
 INP9ljyza36TDbXnFHkaA64+13HEgk9cwRERAm/oYmAfs2A1sU29hMOUkxCQInU8DNdP+DAik
 lmiI2eOrcFa8E0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1607751677-1636546273=:21127
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 10 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, Nov 09 2021, Anders Kaseorg wrote:
>
> > +	if (!worktree || !worktree->path)
> > +		BUG("worktree->path must be non-NULL");
>
> Perhaps a metter of taste, but I think BUG() should really be used for
> things that need a custom message over and beyond what assert() gives
> us.
>
> In this case using BUG() gives you a worse message, if you do:
>
>     assert(worktree && worktree->path)
>
> You'll get a sensible message from any modern compiler quotign the
> variable etc, all of which says the same thing as that BUG() message,
> just with less verbosity.

Maybe code reviews should stay away from  contentious matters of taste.

This claim that `assert()` would somehow be preferable to `BUG()` is not
backed up by our very own coding guidelines. See for yourself:
https://github.com/git/git/blob/v2.33.1/Documentation/CodingGuidelines
does not mention it.

The question of `assert()` vs `BUG()` has been brought up on this mailing
list before, without a clear preference for `assert()`, in contrast to
what the comment quoted above would want to make believe.

And the fact that BUG() allows for a well-crafted message without having
to rely on the compiler to guess as to what would make for a helpful
message, that alone speaks volumes.

Ciao,
Johannes

--8323328-1607751677-1636546273=:21127--
