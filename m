Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BEBC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A620523406
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgLIOzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:55:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:36233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733142AbgLIOzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607525622;
        bh=7uRB1ILDCNH77CKQx3zX8wVegQnkZlfTV5wMtonNakU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k2XjIi5ma3/ALgzWW3rlvpFTFwJ7+7B5hvP6Bu7lEuSvKgiAYkdqv0LmVvWprOkye
         8DYFDZZII4WvuD8n4VmxbQ6fNnTKwzsPUzRa90puMmplYzTJYsRARJ6mdy5hnCt2Cb
         8fZybp9zXeOClzV6aZ681PfV51jJGl1UXASM9tXY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1kYNiA3CoN-00KgDY; Wed, 09
 Dec 2020 15:53:41 +0100
Date:   Wed, 9 Dec 2020 15:53:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5310: stop expecting the default branch name `master`
In-Reply-To: <X8/x5LaeZgbvXT0l@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2012091553210.25979@tvgsbejvaqbjf.bet>
References: <pull.809.git.1607260623935.gitgitgadget@gmail.com> <xmqqim9dbh17.fsf@gitster.c.googlers.com> <X8/bYzjP569wEL5x@nand.local> <xmqq360g6lxc.fsf@gitster.c.googlers.com> <X8/x5LaeZgbvXT0l@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w0p6rFaMQ4wG1AEoH0w0vUdW5bTu4CLB5NcQzYQShRGsTtDhUSm
 GxQZGAUQ17+9MFfO9Ve4v4zglQoJG9dNpw3xOaH/Ks1bEJzStg6cqSKBE26gwHnh1f2W0O5
 cl2XedUVmU9fMBpoJBQaSoi1+/+JYXo4hB6hlBw/OBgpBMl+DviwxbyLzb2ltbffiGore96
 gS6LSnOYx74p9GHheUCiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdhD0R+oLMk=:In/IACXohXyPde9uCfmadr
 D+joXUJ7WsWfnjw90Hc/DbM9DG/kM5qIfcM2bOSiNNyRl9yTlTbetoyyAEoLF34KBq/Qs3TXY
 l6jyDLFv7DII5BQAnlAveZy+6YS4VbbDL39AlrlwEfJMagDCmXfoK5JaUoJZ331XEnM7wr669
 yd5xMKtE7LE+FgsbJWcmwDE5o/2M6XBF88AvTOF61awofHK4sTLf/OybocfjIorIkDwxIbOsU
 iFCSQuB+o5PQPKg5OyR9Ucqsi/VVIqb17p3DPuRostBe3E9p7q/Xedtfp5hk20EhUIanp0I9A
 wofNf8UOyZdeeucZXOZdFJlyHUCtJbuTVWNHCigx07+ubLodQRqLcAksnnc6h6H7/IQjL7GqC
 iAFKerUUDxXwskzbPlztngmr2TXEvB7lJYs4ydsK7LzIS6X/oDrvGE8U/w7sNqVKd6UGEfZ9n
 5PbgF80mjVUGa/P2/zFiliAvtKhq9PZ6Rr8wi3AkjF/LUBedMNqw0SG8sXrEwOVU3WldOiTmP
 g5CYcdo00mGCHD9H+a+FlDjQ9OyrdFffTMPXlkCuJ7XaUA73x7rf+JaLFhQUX/eAwOfHhErJx
 L5n7CiY1MXhVrUhaI5rk/ETciMX46M1hDuBabTcBQWqG4BnG/RD9rOSa/86jfy5MqIWNpTai4
 yFyBFakFNcepMNV6rQ4aWwTnDB58xDG3xUFu7pEv7YK4u7Sfxj5oP3f3qtf+tBuKDYoDYqtVa
 6RxW37KQtIa5OSuxnyB2PIe8l3DZmTG7Ml5w0BZpT5IShnpRBqAwAzPyKXeSTmSU5G5Nlu555
 9fruYq48Y0ryZaKk7iBZWbHiGyFC1b8Ep5pFpVpbUuHKiBUO+aX+DtWHUfcPvxKNkDK2JA/jF
 i/EX+DG8q348rFtGnAd/CRZAu3BH3U5paw/+dqXLk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Tue, 8 Dec 2020, Taylor Blau wrote:

> On Tue, Dec 08, 2020 at 01:13:35PM -0800, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > On Mon, Dec 07, 2020 at 10:35:48AM -0800, Junio C Hamano wrote:
> > >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > >> writes:
> > >>
> > >> >     This one goes on top of tb/pack-bitmap, and requires an updat=
e of
> > >> >     js/default-branch-name-tests-final-stretch (it no longer need=
s to
> > >> >     hard-code GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in t5310).
> > >>
> > >> As the targetted topic is not in 'next' and marked with "Needs a bi=
t
> > >> of reshuffling?", I'd appreciate this patch to be also forwarded so
> > >> that I do not have to worry about it myself.
> > >
> > > Ah, sorry that I missed this before sending out v3. I was hoping tha=
t
> > > the fixup would be limited to one patch, but this needs to be either
> > > spread across multiple patches, or applied at the end.
> > >
> > > Since I already sent v3, how do you want to handle this?
> >
> > As I have many other topics on the table to attend to, I can skip v3
> > and take v4 if it is not too much trouble to fix the issue at the
> > source.  Thanks.
>
> No problem at all. Your instructions were spot on (4/24 and 15/24 needed
> adjusting, as well as the later patches which could no longer be
> applied after modifying those two).
>
> Checking my work against upstream, I can see that the only diff lines
> which mention "master" are removals:
>
> $ git diff @{u}.. | grep master
> -	git checkout master &&
> -	bitmaptip=3D$(git rev-parse master) &&
> -		git rev-list --count other...master >expect &&
> -		git rev-list --use-bitmap-index --count other...master >actual &&
> -	git --git-dir=3Dclone.git fetch origin master:master &&
> -	git --git-dir=3Dclone.git fetch origin master:master &&
>
> and spot checking the inter-diff between what I have and what Johannes
> posted I can see that they are the same. I've added some Helped-by lines
> in the relevant patches to indicate where the suggestions came from.
>
> v4 coming shortly...

Thank you so much for picking this up!

Ciao,
Dscho
