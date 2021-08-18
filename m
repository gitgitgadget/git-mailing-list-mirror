Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C3C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE17460F38
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 10:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhHRKbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 06:31:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:38401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230424AbhHRKbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 06:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629282635;
        bh=UtiByxmhd2xsv26QgV7D5CgQkd7BIgfiyX4OPqqf5U8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bhz/dW/fjq+u00c11wkSqqR7+8CrjwmwjxZe/hZprLh+ZnQZFj/lACJxgRDIDxH+E
         Ii0CbSoAMDL2yQPOaPuIEGxNwGDDUK3e/S6p5JTeVhCBoL7cgP2czqekGbX4OcUpCv
         IZQ66MRAfmk3fRB2IXfrttX3lYMWPjYSuFkliQLc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1m8dL50zoC-007pGS; Wed, 18
 Aug 2021 12:30:35 +0200
Date:   Wed, 18 Aug 2021 12:30:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
In-Reply-To: <xmqq8s0z7m9m.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108181229320.55@tvgsbejvaqbjf.bet>
References: <20210817110728.55842-1-bagasdotme@gmail.com> <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet> <xmqq8s0z7m9m.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FUyFswaHlzcaqokuGelRFvign2/xROf/5UNL6ZBP3nIbTWoWRA0
 Nv0yOLFDEJycMHKbOkrYGFV9t0orUq6ur06g1QAnHrS+L55DUs6q6XeG1oDNdrQa5JPhoYS
 1e/MeGILRWjtBzD7e+z0jfQ5jik7KBQTjY2FGu9Ip99y0SOPDWVHYNWrmQCenKxbUWhOGkb
 LTjVBeqgRLn+/lijlimbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gB+BkfSdjYc=:ud+wDTTTjShzXu91CUBYCR
 wbM+Qm1VKppHk+FDAkay/5DDuPehEKXJicukjmqJfizQU0zuvEo4zreNikR4gEm+OsrlhvUC4
 C4lY9UBl7sNmC6N5RbexVV1LqnAGOfJiFgnsinysipgwypVIxHTrTFzzVF7R2TvemLosfdkS4
 fYNV9b31/wAYQY1ESI5p74ehzTb41JkAxtswhw0mjvEd6Z/KGeeUvu2VmrVOcGjNzsKon5GDq
 AHCZ6UOOTUoMpQpOaUKVh/210158Yzt7qnwInq9UqxDOssySOT6V7zzCSUn9Vmww45u2T3oMI
 VbvnNK+lqfQ74hdWIIs8JCO9GjV1kkTWgQ08RKw+Aogj/YptvM7mrsOzp3kiqEqhBru3iSKms
 zIyt8rSlPQzfPYGatPjUF7u/jUtv6EFJwPuuAy679aixVc0o/nLHZCOt1Ckrd8J4y8WdxR+pL
 uwuJ9Ts4hwyxOALRHklV+w+B+Nbhy9rhnSiQ8e9x+rWFr5KzXzQJ2VZo81I5KNREb9PzGC+17
 DGCbn1u0LeIHXHmELCVS8TFjqOPZAQmZuysH0W52PZ9kXrBzhB1cLE8pCGeXUqZqgcoGeG5ih
 Z6pmf3DPqU2QS6eOg5pdkt4zIDr9NjJeiRS7BtRrvdUpAmmXh2wt/2rSQZp/dzAIFI9DSfiTd
 UAXb4n/VhkWJBGZ3lohlDx8mpwlDJ4NVI6mvv6a11u4N9wmjqFmMh+Wln76loQRN648+RnIGg
 MJkYMAKhUrX6GlbkZav5C7yyEuLScSDfzO22XTMCYbV+amD4JDWNexooskGOYqDlRLvAc4jz7
 hZ4EBEf+/wsQPWiEt+iGsGB2t4kTUyssHxz0bKMxULKObI8jXfAqQPx18elQ2ZYNEWtspWzSy
 XscjW/Th/fF23L7WLm/2KyQrxq9PXpnRsV1xZ9Etv9vFoF5QAKI/xaNF8y6/B8w0sVsjHVRcQ
 K/hW6cOG7E4CqaRwjHztQhMKY8SF0rWmvETFngnrxJR9UFPq4IlajFWQuP+x3bhfPgx7y1UII
 MuiIdtpjkGwq/3rBk4eO6hwV2Dvp3SWj7RIE00cGI/HeaBMrEGDSvT9/EVEd3Q12yiBDnMO00
 QBDto26/wGvMWqZGmtEGsvFGLbcrB0MwYmdGRFPV1oTZGAeAnhozGIOfg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Aug 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Would those `all` and `strip` targets interfere with one another if `m=
ake
> > -j2` was called? If not, wouldn't it be sufficient to let `install-str=
ip`
> > depend on `strip` alone?
>
> Good question.
>
> I would have expected that this will *not* be a new target, but some
> sort of make variable (e.g. "make INSTALL_STRIP=3Dyes install").

That would work, too. At the same time: wouldn't it be nicer to let `make
-j15 strip install` Do The Right Thing?

Ciao,
Dscho
