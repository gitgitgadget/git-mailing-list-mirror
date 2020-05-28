Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87FC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 14:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E021208B8
	for <git@archiver.kernel.org>; Fri, 29 May 2020 14:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YgNPnP+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2OJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 10:09:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:59081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgE2OJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 10:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590761346;
        bh=L/cAzKrJuN+H+KY9ULlkUVxxSNz8i8E168Jgq9oUyI4=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=YgNPnP+HtojM93vLiSHMJfu9BcpWEgbWJuGDop0p5K+JcmvY7It2/UKI6ZbQq4YTA
         7i50vtqOJ25Jws1dk4mS4RL73GTln0jZw+/s6BEWqBbd3Ip+u8sjnwIF/D3nBhMiia
         +dQyZS4xfXCzwu6GiQ25pUmqMMWpNP1s8WQFszAg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1jnmFN0Azr-009f1V; Fri, 29
 May 2020 16:09:06 +0200
Date:   Thu, 28 May 2020 23:35:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE] Git
 for Windows 2.27.0-rc2
In-Reply-To: <20200526204539.6181-1-johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n/xHygcdrjSaifeAfLqWaPDPBJdoQD54YvJbbvW7R887pK2ZXJ0
 ymLuvOJzO8C8S3aNMuoE8yQ/Pz8iJmDzlzmV+qdqA2MsgJe7IT+eAohya4DEmzfFliTaV+8
 bIMaaey++7gwzKfCiC+8kRWHC6Sviy23WNph0T/+68MygapwlNuYvDn+PS0SQ3lenM9CrFJ
 V9stVwkuS+O+WEgdCrShA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ITO9YMDQRyw=:UiFvRhI8tP6ghUF0qG6rPR
 ElKAfMS1QbdgcPB4OMaRAa5JhUiTCmbE2gq0CakzKGJOuErAQdzSKcXn8i/abC1xLafB5k3Th
 8Dl78sl5zwtJd76AoEy3h+ZY5gIreZnLjcYA21oEItfZuHpBV9yINQ0DYJ8upUP7A8X/WkQNk
 KPmB9ololYs+2xSPNF1kodKmhDE4r7K0eQbCfB/qRiFDbvyhdcaaG7pS7MF3tNhbSN8x8TGRi
 AVJgcId8KsK9MDZi+QcaMfQ6ByVjVZN+u/ga7LYIetLzNp2XcXzN95PYnFS9EQ1JPuhIt6gJ6
 y9dPMZUDqOvD6FKdCwPZg1FXm17BiwKovRlwhhNDc8huMVrDgBZkU8rFG2NtLLelq8VlDRHbN
 3euRghCiU+I01NIEwnVLKzRQVLtDBY1S2FP8ENfKgVE3kt+je7z4RPCY8zrW3hXvZxVg6lLvz
 zN+UNEGmyYRhNvUZ0VezQkSZ5qGHSExKqFlwftBepVJ0tIihsxUvpXLqiPSoA9/BxNwgXBXum
 0ubnTUacnZ9NqjSmkH1BS/ZNMByV04kshl8V/yAVB4SngnGhPeb77LBimy5Sz1rf9B/u4Z13o
 9S6EXwMfkn+ooOGA79QAkN1gXZ64c91G/+rwMx4kp+Yerl8uK25qGEojDbzi4etiFtjjCwest
 OVz6EyuhoZJZ7sTPbgLIxmFWoKZxmbyNiiGzmT+WF+qJ57Qg3RBuMTu3EKtToNqrVgX17nsa8
 WaWCzyDDtzNNUmmDmCQf2JkQCx0ttb3qV4/PaI5PhHyTgDkyKI3fblh/ZqWBzeBMUqYLM1LMc
 Kgy+0u5oCZ7xghVmhV1Lr4acyMW+XFsKAsSLPt7F2EH1NcSf82Bg5/gC1K+y0UZ71TUivVs+l
 Ya7wiODTAcf2F0MeMjGYBLs4OfYZMfoVEIteDTDFzlkOTgqdlJbNn31SAxEyQhmn2x/OilXkI
 GOYwzuVlFUJwpdL+QYfkqeQi6OMpj4UN1sX27u8inwLydxzmoWJKxlBka2Ke0ojje1L7UzPXT
 lod7D+XwsaHzboIR5QCbbVJ/9MSVSv6ZQ50V9DUbn9jKAwJeh7+jx8AujDf8HmECXEem+r6FR
 r4bVNDUX52RkjX5rB90Vbhtm2u/kx2cW4Mi0y2PJey6jCfVsdDGuVyPCljMFgHYRrf+xqL5KA
 mra2wzRxJ/Wq+HDm/a8XapISW2lXO0c0DANkUpT+QUvpiL8mZvH3dSN/CDcfYGuOsm00gdgDN
 pbDEy1z55H38ofUdo
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

On Tue, 26 May 2020, Johannes Schindelin wrote:

> I hereby announce that Git for Windows 2.27.0-rc2 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc2.wind=
ows.1

Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if Git
v2.27.0 is released early enough). It has a (last-minute) bug fix where
the length of symbolic links that is recorded in the Git index is the
_actual_ length of the link target, so that `git status` agrees between
Git for Windows and WSL Git.

Unfortunately, that means that every existing checkout that contains
symbolic links tracked by Git will report them as changed until `git add
<path-to-symlink>` (or `git add -u`) is called.

In cases where users use both Git Bash and another version of Git, this
might cause the problem where one of them will always report the symbolic
links as modified in `git status`, but not in `git diff`.

Sorry about the late heads-up, I only just realized that this might pose a
problem. Granted, symbolic links are not all _that_ common on Windows.

Ciao,
Johannes

