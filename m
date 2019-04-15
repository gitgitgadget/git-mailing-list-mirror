Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0B320248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfDOMkX (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:40:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:60745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfDOMkX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555332019;
        bh=3IylJwS330zpEXDcPfNYd1CKzVB/+axGCUBgRyPV+s4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ms8Uck9wNy2KSbAEFAw0p/6342hwi8xfUaRImjGmmksEU6VkXRJMPtfrmhCyGWN68
         hhujMcmJGNbcrk3dnrULaYjvfpQisNH3xQbzQpVKrMxm+iTSYQcjQlf/jdk4mWLKHK
         imi+zU/rrTRLdroiIiRbsD59lhAuZo6Z3Spz9U/M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1jy-1gib2D1zm2-00dGcY; Mon, 15
 Apr 2019 14:40:19 +0200
Date:   Mon, 15 Apr 2019 14:40:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: incorrect range-diff output?
In-Reply-To: <xmqqo95bxo4p.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904151439370.44@tvgsbejvaqbjf.bet>
References: <20190411111729.GB5620@ash> <20190411220532.GG32487@hank.intra.tgummerer.com> <xmqqo95bxo4p.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rLdkyCY6fe+SHhK6PVZoUCmdpm8W6Q6SqxiDyFRRe/UpSwF1Hyz
 YX66r3kSydu/T8Lv8NMexvXYcphu68pu8YQ/b7xXRc3w8P4+FVChzi6fgqtOnw6gu1RXM17
 fCJrO4QpGr/EAlbGoxWexTtBjQZbMPK5WZeZKleZgbn8pTd0wJu7s7coV/L0vmuu+aMmgSt
 c0Mt48u0+rhpgzCQo5nNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BunSf7yywtI=:NytdGM2r7QtOTh5Ym3MXEV
 hyU0EeQbho9aWIKBQPHDxg9XZwZNuX71sfy0U2fBgsrwiV5rT2R/bInEQQmj0bX1sc3AuOZhq
 OP4R/fX/KDKWMT30Drq0rDT8skyFnf71OSa7omDFfhZgdSwry0sKy8XFBcAkRy7WBe2n4SVr/
 Y6nrY9HeOfy1KpXxcNxUswt1Hxh12LBWcUZKJWhrCWNp1pK5iLqQYfNNVwumSPK7kopnQflwm
 HJU7KhfKy4S1i/KDQGeCjcx8NhcjRYwMYwEctj4MH2dptLweRzjjYyLpPXMYdg7mxSQRgpA28
 QmfyOU7BEKWLoJ1sXB1Z/IQ4fOZjkqpaj66Ft+L5dvjjoTi9h9v8BtfMTKESUe1gtLk3l/2vs
 C3QePGJb8V4ic9acfzovft3m6cep4danizp8/LxphAh5Mu6fyJW6HQXP31//vCBEcoVWAOdbe
 6XCGe+56JognvSTRF/D3dU1P9orOAkwBwLP+36qC36De2OG1UK7h6L9QSFi4Ci3BxQK/Nu+db
 VpIyVY1FU/LODjmo5oYIx2VWcowFowCl28ncl7287s/Ao7ZnQpw2aJjfxiASdpPWPcaX0Dpxp
 ft2nS6uL6BbPaL9BBavtizpC1wFAoutuf8BML+uK03QP3bpN4dbfNaedONx8kPXm9SI6aFuBq
 0oahffR4MyzllLgiQSNmCdzj33aIwAdWvSpueTI2jzkqD3ehNxvcJHiDImUOd7P32SmF41liQ
 ouXzp6fnB0btFOobuR1yD6P46CdVio4YtI3SpWSnD/pKFUsWx9OMNHeYL7is7L2pIdFFZ4kiv
 RHxkwR9jazPiVqXZP2EalcZbfYKoDEKgKgbA6fsigHnuaKyg13RuhePZLrLb7FYUuExoBVVAH
 QyntllayLbQmvx1/LKkXccLGVSQnO/bVb6KIeMArTlwLr6JmrFsrsGSNl1FfQAWJLSuulnRdI
 CU6IBQDoiSQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 13 Apr 2019, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > I'm not sure what the right solution for this is.  I think one thing
> > I'd like range-diff to do is to add the filename, or some context
> > (e.g. is this part of the commit message etc.) to the @@ line (not
> > sure what that is called?).
>
> Perhaps the inner diff can be done with the usual funcname/xfuncname
> logic so that the real function name of the payload is on the @@
> lines (they are internally called "hunk header" lines, I think).
>
> And then the outer diff (i.e. the one that compares two inner diff
> output) can use a special funcname pattern that says "treat the
> lines that begin with '@@ ' as the function name line", instead of
> (or in addition to??) the logic that says "lines that begin with
> 'diff --git' have interesting information" which led to a misleading
> piece of information in the range-diff output under discussion,
> perhaps?

Note that the inner hunk headers are often not even in the outer hunks.

So I still think that it would make most sense to populate the outer hunk
headers with useful information.

Ciao,
Dscho
