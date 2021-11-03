Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EEC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733EB611C4
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKCXrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:47:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:42187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhKCXra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 19:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635983087;
        bh=pLZaTBMnSq72gUiQLUnegR04SzcswaFr9Y6M6PJjLLA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M4B4KbOcX9ukL/ZglcGkcvyKWZDS8JGAUsQwsZajMDjOvSfLK3FjpEFCjzCBGXo47
         vHCVHsVHOpKEMqd9BagPvvPMW7irIdN5o++SCPB/5oI1U2rWLYfsLggclk4htmyCeh
         uI7Fr+TwC0sXeWUPYPXdJ3iPMvETvV8aLIeKKqK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1mBojg312d-00dYPf; Thu, 04
 Nov 2021 00:44:47 +0100
Date:   Thu, 4 Nov 2021 00:44:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin: add git-default-branch command
In-Reply-To: <xmqqy2656tni.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111040040340.56@tvgsbejvaqbjf.bet>
References: <20211030140112.834650-1-thomas@t-8ch.de> <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet> <xmqqy2656tni.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3vUcCLCZ2+Ce+1Crn8JPjIJGFSrNhrAB4FMeYRmJteS1Nf8FhHD
 gz7TkGqBXaM7WY1z5ue8KoM7ez8XBnhQ+3uktPajoSSuqeOsdXarbid4UtiVE/du8kAtb/h
 Vwf2bbDHiyrWkOVACs+T4bwQymyDcePzY9GxML2Ea45XjMq3MVTydmViAp3utQ+QQXAsm4H
 SQJr7LLeo7vVh9vmD1zwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fO6fzFxRQs4=:Tx+doCYCShWK+Ve/hSLjqM
 bXX3d7bfcScJ/CYNRQSFN6WJZn6w5lrAQLUc03X6YaOjtoisDLqEMMTmim3v7g155Z+GehlMo
 No5N7j1CU26/kTocAC1WNrmH3mLkAmJTW2g5jPBVx0sZgqwvYqcffBLQv0T/XvJ6icybdIdm+
 qG6jMOXfAoefYxyEWwtTI9NX8HxUHQtOrkfhs4sg/veNWU7fS3wVja08zHcdAxMfxcSKXUoqX
 x/gvgEA04OJbK3k8J8Fn51M6qRSiEf9cHFD8ciHd1+v+2UUWgPdUu8hdEM7BHqfZA3ELGklJ6
 m+jsN5lLyMNSqM2umpMAC6HHQVkp28z1TCtMQKpTSrJLCB2kxl9qbrItMJ6ODD1EU58+80L+n
 RKTinGej8VtpGkIi9zgPRQVabzuzsgx0R47VC3u2HQZnL7Lmh+VwvRDW4xWD0A9h+ZkwxtIDc
 TJFB6WlljwIoMiHu6h/UiyY4UtaaUzjnvT8Ke786s9bqcchvfw2hkQCx6ZHInwiY4/iBqISI0
 uw5TWPhxH+6DAtiJZZH0iQEgWzg1G4hgemIKrTRciMFrYdj4IXiqR87nCKMTNb01o78NqTA+Y
 1olTxERJMYzmRyDhU02Brjj9bgyhEklSgtJMh/8IgxrdnCdP+9icZaBBiWF33t4201Y+mKgkm
 bzzK8hA6nowPfrU1aVyGEgMYrI5VhnQUB7m8SJFu6VSFOB+8FH3XE72p/bxzYLkCgffk5aKvY
 dXXlCTNfEW0sLTMysm0/7fzynHT9Nm53eB0CRL9TCFOXTxjE44gI7PVYuf62gyf1Ae/noW+Y+
 a0j40C2PfFATAy68XnDXSLJontuPt9nThMKYEbDqWj43SbvUaIa1jqtTWpubJkH6g5d3xEyAL
 md0l0koQ2ocwrFOjJMfK0I2V8JOqU2yGWy9oqZAimS0L8gmCNN472QvKanUl2GsOHGDB+dGrh
 eUgvVUbcsk8WNdyqTpr1nBmCzF++n0DnY3z9SJN6fg3PZEu8Wb2+xs/4nK8ASbJWMCaHF8MqJ
 /IJdV6JGKQIvAQ8YKJlrlouH1uqHrJSsuJd2XnNkBLRtBV9hLp1a/Cysd4P/S4DyXcGNn/j2V
 GyCgluzzGIlo5I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > But we do have prior art in Git how to display similar information: `g=
it
> > var -l` will list e.g. `GIT_PAGER`, even if it is not configured
> > explicitly.
>
> Nice.  I was hoping that somebody would remember this one.

I am glad that at least you remembered what I said ;-)

> GIT_AUTHOR_IDENT and such that do not even exist as a variable is
> part of "git var -l"; the name for the default initial branch falls
> into the same category.

Yep. Likewise, `GIT_PAGER` does not have to exist as an environment
variable, and still would be listed in `git var -l`. And `GIT_EDITOR`. I
know there are scripts out there looking at `git var` for such (possibly
default) values. That's why `git var -l` is a pretty good place for this
information. Maybe the commit message could grow a paragraph with this
line of reasoning. Thomas, what do you think?

Ciao,
Dscho
