Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B44C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 21:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517E92082E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 21:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RI33lINf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfK3VXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:23:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:36549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfK3VXA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 16:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575148972;
        bh=HN0rRnzR4qlR4x8uIzn3mw2EJuSuGv3lgTvLI8s0aBI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RI33lINfATfcLPXYfLrMSrOexm6Cs8cCDRs7uRaCOTIOzzvpBxwUle5Cxb01jhjKk
         YnuWaU1jjh+1NS3V57Wg6XBKZl4hXF/HCM3hKEoOF19IfFUxTR56lrSW9d1rg/uAh8
         qS55BiLBV4uiwUF+jSULVbU2bTaXZdgd+DyPWNSk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH9Y-1i57AW2yya-00ciUV; Sat, 30
 Nov 2019 22:22:52 +0100
Date:   Sat, 30 Nov 2019 22:22:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andreas Schwab <schwab@linux-m68k.org>
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
In-Reply-To: <87y2vxrt6t.fsf@igel.home>
Message-ID: <nycvar.QRO.7.76.6.1911302219350.31080@tvgsbejvaqbjf.bet>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com> <pull.480.v2.git.1575110200.gitgitgadget@gmail.com> <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com> <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org> <8736e5t98b.fsf@igel.home> <xmqqwobh15c7.fsf@gitster-ct.c.googlers.com>
 <87y2vxrt6t.fsf@igel.home>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iNYigm/qnc6H1rLDjM4J4eUOVEJipWKUx966qwm7l3Wf5+W1F1N
 JCWELxcxQTeOF9P5+vDFs4/EskJAeZiARNEJLTh8zqHoXNfjX9617IC5IixpHVv/UofqIYW
 VGNhSvAUSg2Y+ib6lkZef4NFBusMzJALk/T69oSWD05HZUC0QvLXiokXZ12u8w7b0WFISMn
 ajYe8uBxB1jq+g9BuFJ3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRz1Yg5TSzo=:w9hwx6KZQHmZdWMItw13Q/
 Lqn69D1e/Gy/8EBV0AkKuydC7gvBCPOPGuQzjEzCy/0G6ByXbLUX+Agyeg8AzLvWVU9QWbTj5
 9jtjmCR32PILjeHuLBoGOnUxAYS2N9hl35LXySUNZbLc31DVAm7Y5iWEHzIIOd16l6XaqI4Gd
 AcmNarBhBhXLupoYszWQY4hEfhBb7HqFRsZwk0rBgFoG4+cSGQG8VlCNDrmGng2dmEk6jIc+r
 +UtRNWhPez0uJ5fb3Pf072j4RZhtTTQHXKNFJyalfXR1QxPExy9EdMkaC2R6vcy75TqgJU5s1
 wk7rYHuZRM+OHUA1OnZpb0dMzPnx4vVcG0FbA4Cx72oqASyd4b/LtkX3mb9rj8pD+c7bnIBGt
 6STCkaS/qfTpOtIbv1eZyjtkYDsq+KXTwfKc9BucJ/8meGp1IU3/1133WIZDf61Xx0C2mnmKi
 LqnsJCRexxL2qbRBmpOt61Tks1ktiSZtZ08WHJu5MFFyP+xostgPpD6sErrAdQOMkzzvyI5jB
 fG4LMKx3AoDxF/Hid/2NWovMa/8Gq7nYOut8x0a/oi2BG2NrEkMNcJObRdbrzp0d6SKS2y0UD
 7SNP5xhj9bdUD87/zQsQsAI+bwF4cXUjTTUGTIVZBtPMoTzxTLPpr8idEw/bTsd3bB2NTn9NP
 D0uiCR+oErI4A2015ZS2rU5AmDtFRHo1FsjGT1WFDqvzWsxdcyyF8EQCRHY9P5v2NcoMO0a/m
 mwTYg30h56oxd/9fkvFIhjsh5tvzTqgQX+N3DtG3B1U9fnY2WXvnP9r+bFlkA9e9aSEy5hG8d
 /8W5l320H5Y2veAQFMDuhr5aR3VKm2WmnuVyVUCRVMiNM6wK16jPNgDta6HJWElc+WKSLUyxz
 RsUiHRk4QnHDRaT9/gG1K5p/yt1ACPnUu0w3y4eEXGwfAqLlY/v7Ll/K7h9KBjob0pHqtjRlE
 4+T+sz9TnMib348Y2wDB3JbtJ8yh7fCb8fnvbi48RziUhec5Dw++XCk/qegWRGcDIgzFq7MBw
 HMnSgvXibHKOqDD5QdH+kkrsFyTD1VnWm9bG6mnop9OyVULnezI3ORKhp56w6XHrlvMUdAyeb
 zaehKBscEOnpyYm4r91VNL9dxSDLrRYjU/c2u/X9dc3tw3MhN9xlM0wM7/23mdVM+BsMY+s79
 ypY+6/dw7LFJX4+GNUI7m558Lx6k0Jl08gf4TVnWwrgPUi/iw0knvWPYRl+5LoDou4hBe3743
 af8xrlUo71/37gsCozrrOOfxbDt7UFylTBhhIghjbeKFzkogZ65XOMWC02yQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On Sat, 30 Nov 2019, Andreas Schwab wrote:

> On Nov 30 2019, Junio C Hamano wrote:
>
> > IOW, we cannot take advantage of that POSIX guarantee in the
> > codepaths that use our internal API.  So...
>
> But it's still a good practice to follow.

An even better practice is to focus on what's important.

You could, for example, review the original patches again that needed this
fixup, to make sure that nothing similar lurks in them. That would seem to
me certainly more meaningful than harping on POSIX semantics in a context
where they do not actually matter.

Ciao,
Johannes
