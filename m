Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526AFC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3366720780
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Xet37/Hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgF3N42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:56:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:37811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgF3N40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 09:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593525375;
        bh=stPkpaNQxFNwZre/lAxHyWBgrCHZiCCwCkmpJPdiA/8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xet37/HqvqJ2rSmHBBv4w81ETFvkJi0ZXGNr9icfm9o69I65h3+OdESm4kVWxbmxP
         l/0dqbrNmIc5VBA6zxjCEaHU1svhfVJx3+PQ6qKr396aYAnvkvcLrQwX8MUp/igqVO
         0JG6a+59W5KSuN7D7/jV23X0HDFBiuzQyitr/28Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.212.146]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1jbTgP1LjC-00HATf; Tue, 30
 Jun 2020 15:56:15 +0200
Date:   Mon, 29 Jun 2020 16:07:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 0/3] Accommodate for pu having been renamed to seen
In-Reply-To: <xmqq366j5d57.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006291606060.56@tvgsbejvaqbjf.bet>
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>        <pull.668.v3.git.1593087539.gitgitgadget@gmail.com> <xmqq366j5d57.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1172079787-1593439636=:56"
X-Provags-ID: V03:K1:qeuTT8IEOQ292NbCLDi7el+pMtdz7TCcItCP1BZAYi8pKcEaKDm
 6q9SRDr9E+esmq8Ym6HkSHSBwHD6l+dHkmSi1cP0lKyRnEU5WM2mXKnNoJf9s9Q7VPmhm1y
 8l5HOGrjnEEvMAZB6PeA3vbc5W8en1RgfyiEdkAPZPE8xsLkNQy2+qtwyjdcjSS57+UbTRx
 CVaMfg4HGzfuehmiK6szQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U61bgliFRgY=:3aYqWtskg9soqaHCwiEC3b
 8Fmn6wohB/ij8adWQUsqeJnES2u2v3ipFWTScMuqM0BNIuJZ/NaPRdo5oBxn4c8B6N4VtJWwM
 Ngp0If4la6iBia9QDSk1+6vJXciWcRISUekTLeaKvLATu7D2EsUhAXBj6qDbBAEehvTFrDS1r
 ZZJxTqJv42/uduN9yzUkV7tnLrRps7N+FduffMk0zxVl1rJ+iQoQElM9Ru4GcQZdjzqMqYnTm
 MQilKTSvCtB+2esWY9wN53Xbsu3z9To8/bzn1LpZMXkTO3wUvIPod8ok87fwAr0oqjHJ6Q2bi
 pZlPOcRj4yBqtA2CvuLl5kERPGcVN5QK31/PwpIDxXcTB4xQCkDEoGbs1wWGJeufg1liyxwzE
 9chNl0NPJLV9InxBLxYfSoPAJrZDetk7wm7KgbvNOtQ1oGPwwfEdOlA8UL38KefHhAs7b5EXV
 6wJsdtsFqfLTYdJncowVqfGZQ+4V21PoWKYtzgMLDrIfRW6VtOkJUAvQ/Bf4uLBmYI0P1Hjs7
 6Pq9xppSePuqlhYDemVmurNt+Fu6SRs+5eRoMI2FYN70P5eRnZ4X4NioOEpGrnd0I+laRgRg8
 VjSSE0aIu9DEasnwD/F1kL0Z6hU2WDeXT1teZuzvvUIB6Xu/lkSoNh+h4wIv7sXVm7chRTJe1
 Ctei4L7yAkqcmMLUyII3LVnl3bVW/sHK7w7bmA0NYj33xpOnsFAemo4O8+9W9eiHK454zM1BH
 p3onEbJ9ctD4LQC3eNEqJkkdjkV6dsF/PAA9PGLs30HJh1P39Xg2q2Dcg2CPuIMrJFTccDdN4
 TgnLWWLFRnbqQbJSmzt6Mfy1ncCA4cae7+lHShDA+MD+DkoKwakf+lGAPzkWk1kZg79neOz/6
 MqLtIlMBpNp354b0Lh25ynts4WcQY9CfOJbv4VLy+w5cXBdSisRWP7GpXJG32xkFvyx2Mv36Z
 n7uyehu2bCbGM3pe/IvEUc67RJRK4y12/qHjD0DQql0YP1GZVENzUL2AI782wz7EhN4ZFNLvk
 FOh2oVYcjQNiO7tbK6GEsE3O/Yo/HtHXLM6pQoSubk7+GBM4SAz5sgAS/tpEmPXrj4qlubP8S
 CSRSfP9L6kGY3ugIYMuEVFgSV6iKXpqWo207PFSCUWFi9g7DKigoINOwLdcMqdbFznaucBA2i
 PWlbcMfZ4PqUaBxGX+ASKMbt8yICXyUe16S5xEv3O5PJ/JQ+jfA3fHe2AVp62/uZDXHl/BC0L
 19FsVsTjL4VGkpnEv+EJK9Ocl/OcMRp9OZmC2rA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1172079787-1593439636=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 25 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > This patch series adjusts Git's own source code to reflect that change=
.
> >
> > Please note that even with these patches, there are still a couple pla=
ces
> > where pu is used:
> >
> >  * In the translations. These are legitimate words in languages that a=
re not
> >    English (as in "gpg n'a pas pu signer les donn=C3=A9es" where "pu" =
is French
> >    for the English "could").
> >  * In upload-pack.c, where a variable named pu is short form for
> >    "pack-objects updates".
> >
> > Changes since v2:
> >
> >  * One accidental quoting change in v1 was reverted.
>
> Thanks for being thorough.
>
> You could have just told me that the fixup queued on 'seen' looks
> good to you and squash it in the first step instead to save one
> roundtrip, but replacing with a new set of three patches is not so
> bad, either ;-)

To be honest, the GitGitGadget-based workflow makes it quicker for me to
just submit a new iteration. In fact, I did not even see your fixup until
I read your mail.

Ciao,
Dscho

>
> Will replace.
>
>

--8323328-1172079787-1593439636=:56--
