Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8289BC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5178723142
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbhAFWmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:42:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:50445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbhAFWmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609972856;
        bh=YTliJfYa3AsSUsmesimOV5DyGBXoe3v5Mwfwc2AGzik=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aSzMCA9o4OfOtOYQyDKYxtttr/k5McvedVJqstVkRnMlH6UV6bg+AmEDHKBknkIq1
         2Mvgv5oEV8jBgdAcXbeE4yjUE7uzLIcC2OkTHGD5GOnhho+O6ZTJHw0eGZqNNRd8GJ
         GT9A4z4NFJmx86jnQ1frxX04fBawMLjbk+a1PejU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1kF7EJ2p7r-00iztT; Wed, 06
 Jan 2021 23:40:56 +0100
Date:   Wed, 6 Jan 2021 23:40:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
In-Reply-To: <7b5ad849-ca6c-a462-fdef-c06f8511d946@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.2101062336350.2213@tvgsbejvaqbjf.bet>
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com> <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com> <xmqqczz05b4x.fsf@gitster.c.googlers.com> <CAM0jFOfSE3_TQ7WXiR_G6eHOZnr-0ryv=CniXs4sxs1=JnucUg@mail.gmail.com>
 <ab835195-0c69-830b-c7cb-71d50b4ce4db@kdbg.org> <xmqq8s9m3kx4.fsf@gitster.c.googlers.com> <7b5ad849-ca6c-a462-fdef-c06f8511d946@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7320mDybiCqfM5xSDPOk0b+qsPuV8NSdW6yLSxnzQNAVyW2GaUf
 jiNx3bZkXceFY8zj6Q2531wr6Hl38OITn5W8Mf/mMk9fRDGzszIrTgwpb2r72+TtXDJM2yj
 Rhxiq8wZdQ7l0mOSEMLvpxbI4fXxwjaS+gSZ4uKNeXFQW2sv3n3imWalsGCQM7UqYKR9v0g
 9H8bU4TfMh/dvfZ4O9EbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:67eh/1bo1xI=:vYKQI05NsQPdFzmFykuuyx
 pc/NwsoIJPg2A2FNfZiaf4tx4JLxYHPMHjnyXpJSJbI91RtvXoSdRmqsviAXbn9gRsv7vDY9l
 4JWmtrKCMBSn0GdQ/4dMwnsU4wh/uEQmav/8TbTsiBN1zGxfmqVNMnAWVSVz04+IhbMuFcCpp
 9FQys25AiqWbi7C+Au4feEInz6UFCkt/OV50jWzbivvS9+9JYC0OM7gwdNn9vm699knje4Cht
 JF5VeJ6mM5xoPgHjhek4RVKohCTqBiOpkEpnCeSFEkX+jAqeDWoo6nOBcSguMEDayV+n1nt8s
 CTGJ1wvLs6t87vbwg+oIhGm6I48sNPm0Hqh2D0RTzhuEd+x9RMFVniOf5CtosS4wmmaIzeRQs
 djtNpEE4p65PxOIPrBK9waT+RfKanJZE0Xo5DOsozE43/6iqSkHBhF0BQwyuj0C7sX2NlZ51z
 Ggr3QQi0Nd/cMb+hPpjOx9/1rHcVPvBGvTFjg1SLfRRMb+mIedTAFM708P9wGP5uv1bm2Hy/V
 wAC6xt9iNl6ucv9FVhl789t6U5LtYtVJ3OuBryqlpLMh4AVVtvrizl9qBALmFcPSpdvdoPBtt
 PpVcNyiVClwYbBXieRYchmTWVARkSeVOgce3sIdk23TMxOaD2l1IyJB30kbArxndxjfjiATSk
 HA2RpsViQYoJ3BxGWQIhNcTPZXJ04OzuZAkpwd3pFsqalH6ujrT2HxyqbUaMYURidqP5NV1zU
 vo/3WnOvaUSrOUgk2rJjV+TAyQnDNLFsyirAdaHQ8T/Rs3pQoLvV4EZlYM9+Nh+Lp/QtPb9h+
 QW7g5Arqo/vfBubP15NnFtnhYc5o0Xh6PiqL1QRx4s/7YxPGTgnDlDsI4xb/XyadOB/wYQ6n1
 v4vSdWQYL7KGwDt+xWbu8DP6wNMTyAV2OkWo5UqU4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 24 Dec 2020, Johannes Sixt wrote:

> Am 24.12.20 um 23:21 schrieb Junio C Hamano:
> > I wonder if we deliberately designed how each insn you can write in
> > the todo list should come up with the authorship data (i.e. ident
> > and timestamp), or if we are just using the natural consequence of
> > how the implementation happens to work?  I think it makes sense for
> > "fixup", as an instruction used to make a small tweak to the bulk of
> > work you've done some time ago, to use the authorship information of
> > the original commit that gets fixed up. I don't know offhand what
> > other insns like "edit", "reword", etc. do, and if there is a room
> > to improve them.
>
> For 'squash' it was a deliberate decision to keep authorship of the
> first commit, see 81ab1cb43a87. Initially, 'edit' changed authorship
> including the date to the current author and date; that was changed to
> preserve them, but I cannot find the responsible commit.

Note that a new verb is not even necessary, thanks to the `exec` verb:
Something like this:

	pick <moved-here>
	squash <use-this-commits-message>
	exec git commit --amend -C <use-this-commits-message>

As to the implementation of a hypothetical `fixdown`? It would be a bit
hairy, I think: right now, we rely on the fact that we can find the target
of every fixup!/squash! in the already-parsed todo list. If we do not find
it there, the fixup!/squash! simply won't be auto-squashed. The desired
feature, however, would have to look in the opposite direction. I'd rather
avoid that complexity.

Ciao,
Johannes
