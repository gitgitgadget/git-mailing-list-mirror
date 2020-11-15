Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664DC844F8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E374822265
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aloI+Hqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgKPMOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:14:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:40959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgKPMOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605528859;
        bh=FUM687dyMpXJd577zLrmrUDTouCNgzu9Y6DIFPcYksk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aloI+HqndeuqYd/Wiu9phYiYBEWq9zvCetTS4OhUjnN2ujAogYN/eOoD42h9QJkvm
         GqFmaL9sGQMv+KELMLpQ7Kw2G9bn3MgikGAu66+XiuOB6P+BWl6Wu9msz5aAXEfA/i
         8RX4bLsmZ85j/UQ+j3nSz3l1qOIumb+TMSpwis+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1kohVX3YGL-00RpTi; Mon, 16
 Nov 2020 13:14:18 +0100
Date:   Mon, 16 Nov 2020 00:57:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/11] add -p: prefer color.diff.context over
 color.diff.plain
In-Reply-To: <4A02D618-34EB-4B20-A102-99B3CDAFD0BB@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011160056450.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <48d8e0badfec5f0e576868f7a406ed7ede6c7200.1605097704.git.gitgitgadget@gmail.com> <4A02D618-34EB-4B20-A102-99B3CDAFD0BB@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2069398629-1605484665=:18437"
X-Provags-ID: V03:K1:qk7y7u3aUxV8NCq+cfRhA24SUeUa/DQDUhHLvb+qzw/IJKZKo2m
 lI++FwtUk9iWKdLfcAPA2QXwRZ0CaZqgKjjtKv6p6k2LhV2H4k05SQzzWYkIYKfr7Rsd5EU
 QOndpuVx9ut5Zq3KaxgZim6tPgMB0xDzoXy5jE++5Zxm/cmdmICtBry64dcRaKOZSCfu+v5
 6Q+tOudBo6QFHLCObBdFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HBJ4wZ+zhSU=:dqLeQ+ecC1O0lgD7fWV/3q
 Jxg5ffMGL9JsQ3tIAcICxfJMu6ZSX8+BzO6NSPlsInAsTThwuLd3xAFvoRoeXQ/pROTIAB4Jl
 Tv/2bbS62gV29r4db4wju0fqH9WL11SoyXqmtVXAUIrHSlbgzcEcF1adR6yEu2SczlAQA2p3s
 nds/ESPxWs06qWq+nFVhDKSLQXsMZdFzKYsE9cRCz7TgUIff9OuLN6gD501lCWNE83G1Um5Tw
 upqhlXwzvAnKeKRSbkQIg7bo+GiKrWO4dHrRhRrPwZk+YrNFKYR6RqveqYdHa9m3h4EF6VfXY
 15qIeaJWY5CFLgDGFb3puEyhI8eKQGjdbFwWx3WWY0VHAG0MJ7eFmdLhtUXXXp5ZqNIpT2CCG
 WebOpmF24yIH5W7EyIkpXiSJhO9PmiEqREYsQZBqIfbxBjrHJfOQJvvuY7fgCqbM2RJ39yAHQ
 JyLz2h9pR424sK64nuxyYYeIqgrVIJ+9avanfNSbbw8znaAmB7pjTwNWWCEr7I8BjJ2jrirr2
 SYZquJGQ8wy6EKyM8hUnVXDleVtifIbxFnANX9KnAObJvf0FdmHoWAzoQvyK6CBqUEFjl5B+I
 kf6NCDL6CJX14pRcs33e6SVczxiVJ/+MITX6TsYPsjCw5ffkMaRPDBNLKjEsMNv2A6P66VU1w
 5pK0zUYRxohnxWZo7oaCSx563VjWw12vk2gVSFYN4u6A9rjvRUaC4+OBhAobm2eqh8TXZGMkx
 UvPMl2HjZZJiwovH4FBIYsBROI4F9ADytqFoCCgpnZvrsU6eDhboqHFUh2GOlJpDQ4s/UUlZq
 /e5z2KEKLXrpdSnLDsQeL44gjW2GFua4OLJtNR6CPrNquQ5GYr6/63vwCemRd/XcgLwsK8GRx
 zHxBWRN9WS3mqVJsGB+qiUN3isx9GPnO3stHUF4vo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2069398629-1605484665=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

[to make me completely confused about which spelling for
"Phillip"/"Philippe" to use, Philip Oakley needs to chime in.]

On Fri, 13 Nov 2020, Philippe Blain wrote:

> > Le 11 nov. 2020 =C3=A0 07:28, Johannes Schindelin via GitGitGadget <gi=
tgitgadget@gmail.com> a =C3=A9crit :
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This still needs
>
> s/needs/leads/

Of course!

Thanks,
Dscho

> > to inconsistencies when both config names are used: the
> > initial diff will be colored by the diff machinery. Once edited by a
> > user, a hunk has to be re-colored by `git add -p`, though, which would
> > then use the other setting to color the context lines.

--8323328-2069398629-1605484665=:18437--
