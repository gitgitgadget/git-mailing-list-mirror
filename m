Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5F3C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6763B61205
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhJVOaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:30:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:53419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232972AbhJVOaA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634912850;
        bh=UyO5Ufo7wzVd3+MY8MUuOUUnmOl2caNzZQX0nVI5zxg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YuWdSTcO+JeZDmPgM13T3uDRsCmn4PRgNwYeK0TKwzxulP48D49j2+8eM+aljw0Hz
         LVyNehKF2lzJZclDFwolCgMYWl6Gb5s7lcCvjzvGh5gKx736lYwnV5icqBwoI6YwI2
         v6hLYljviranc2uqfJfq4FY9ETNxcBz2l3Js96UQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1mTFLX1Bnt-00FjVJ; Fri, 22
 Oct 2021 16:27:30 +0200
Date:   Fri, 22 Oct 2021 16:27:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] git-sh-setup: remove "sane_grep", it's not needed
 anymore
In-Reply-To: <xmqqwnm6ge7w.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110221625570.62@tvgsbejvaqbjf.bet>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>        <patch-6.6-556fa96dde7-20211021T195538Z-avarab@gmail.com> <xmqqwnm6ge7w.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2060435684-1634912850=:62"
X-Provags-ID: V03:K1:5OWcBe8BsBAjedq4ifPfv2Qn49zE7mhBR+ouh7ldOUWtqcqGQnD
 DVEVdQlShevkaMp0IgZqOAIaIx3OjZeHFBskacVtHAodZLXvyYCgpu+fmG1hnfEUNy+BVel
 PQEzbKai9NlyfBazxusIQxRMle0w3T6upjrYZC98RN9+HNH3geTEXcKBycDPObS5cMITfZV
 C7Mf8yIDQMOqAvLYwO51Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Ka0/I2dm+M=:zihpDRhTNVOXiZgZZztgK7
 lsdq0ajnAEah0n39RSNPS25x3nQvZh+ZfRXigFRpXw0c6PVMbiS/X2YCSgbWyGWM7DP3Anwx9
 pwxDuPAzfPwCmIODKyzOkCwQudfash6QGjEYScKDKaPY60qfVIx1cb6dqCGPU3ncr155SJo5W
 goH034iSy1eIkU1t92XZEzzhHs9eOlypF12r1s8GbWxAsBwg/kVsYtwpNELqaoWwqjhG0MzqJ
 RgdVM1DhWCKF8ZZ9m25a8lhz7VgE8mpkl+zcXOzpbW36OnTsex/l1ytHovlc6Vjc2gUIh13Or
 +WOIoGwUkWtzPfvvyQ+Uqm5jTv0Sp+5PmqBeB5WAASmVZRtIXrtP/5RJ94RyInleBTuYesf8s
 1wEH4VpNfFNFSTNmMZKlWtJ6eo6Juk8dOVc0bfV66i9FYIMae4ovOVm5aqpTl/PgfTugCLRz+
 zDqb4oDI8ZlWFviGrBv7r6wTNrkqd3KXJ7OFVfympQYgTWQRp6HkHoWSOH7emAj3LsP28a7go
 oXmO2pCjAFe6xRsK9d8JpDDepZFhQhuv1jZWcdx9hbE5YVFEuY1hoStXrpcQoRhs5m6qZExYp
 tnI+WYASnmxXpcqO8wlVEsGSip5qvIZ0j/V5HOKWatJzYddfSGk2A/y7Q2PGXqugrvkQuPaxM
 MEra3+Hh7nGmwEIEs00rKw1+v05wjfpPLzxuqrF5GPZ47BgZkTbWu5HzDmvclEbuhn/pdiY1H
 C73cJVydT7O6AwdWAvfts/5ay7iRpEFFr6HKafim69IGV9mpA+tGf3wYEDQ14SCFiPH/Pt8eX
 iA/tgK6aeBdt+nCiqERZVrV2ZDAH0rnVYsaGhjU4z7QQwtCH0nC2wBfpZ/unVa320LYoG3peA
 3yYWpcUGZL5Yn+8NOb+OAScyxDg9VAxbnVkAsff25d/z488TV0/ThrCPywWy1q6gyLa38SLA9
 OeygCp1wlXikY5LJuGm9sQx4xIqU6TGbyL/6gzFfTco3gBFbnJjVoo/UzPqp+1Y627pTwFLbB
 kEXP4ea6sKkTH/7oHPpR2eq7klliGCPTccO6mkCZ3fCTqaCuYnh5Z8XCbaGuzW+bPwxy91pjF
 nfhXe5HovXtAqg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2060435684-1634912850=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 21 Oct 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > 2. The SANE_TEXT_GREP added in 71b401032b9 (sane_grep: pass "-a" if
> >    grep accepts it, 2016-03-08) isn't needed either, none of these gre=
p
> >    uses deal with binary data.
>
> For all other users, I think the above applies well, but the one in
> filter-branch deals with end-user contents, so we cannot say
> "contents of the tag cannot be binary".
>
> Not that I care about filter-branch too deeply ;-)

You probably meant that you do not care about filter-branch too deeply?
;-)

FWIW neither do I. Recently, I had the need for some large-scale
rewriting, and I used this as an excuse to learn me some
`git-repo-filter`. I was pleasantly surprised how easy it is to use, and
how fast it works.

So yeah, I don't care about `git filter-branch` too deeply, either ;-)

Ciao,
Dscho

--8323328-2060435684-1634912850=:62--
