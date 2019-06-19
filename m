Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3151F462
	for <e@80x24.org>; Wed, 19 Jun 2019 11:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFSLTf (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 07:19:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:60643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfFSLTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 07:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560943165;
        bh=PLFExe045zY5IS9NghucBiq5VZ5I1DjMRAJ6ITUYAIM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jr6fRJof7JYDtDY9uj0y+fsF8kq0SAT1SBHvn7fY4+xSKsH9S72vfFlWE3bmnOBm0
         P70PekxEPzzx4ok3W3vypCYSJGmrKrzChBHV4osnrOYJx7iwPna3ZifLb4rVnH8ChT
         A+Mz44qfCJuI6P1Lc9EfzL15lE0aUxgjkFtfS6NY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1hxfvw32ID-00ObNh; Wed, 19
 Jun 2019 13:19:25 +0200
Date:   Wed, 19 Jun 2019 13:19:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
In-Reply-To: <CAPig+cTXdz6s_cftPydKjtESz986s1xLQvwV8xPzYSR_xLK6Cg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906191318570.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com> <CAPig+cTXdz6s_cftPydKjtESz986s1xLQvwV8xPzYSR_xLK6Cg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NHYOYs761amXInku32uq1d2AIdPxjex1BbbP0r4ZKBSl1Ev6cQg
 k8e8i/3GITxzG0bZ6EjCCLoHL+zSSJ0hppLXpECXU3USxwNCBNvd9FydxFotZNZgf6bPOIm
 tLN2E7SGyTsTBjb7WLaE9PIR5yNlUdVVxzin110GW4Vgs52BvTY3k1ciHCPAPXNsFUUi4aD
 1WQON1vJXKhlw+4fJeC6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d5iysVdPV4E=:17MfreGouJ3PDw0E52qQ3v
 8pfd51+8nhLwUqbyxvKgrWUzQe61yrut7WjDlBk7GyEuluJKmBo0oCtCe/i/378fJO3fRGeRH
 mRGDup4SZ5s2Xq/3VbiqgvvJb5hE0htnppGLr4a52cqMugAGCjCL37hQDNFqeBX464yrWON64
 +hEGJrXz36CxJBy93qNI1N+bIcV0lRPJmU8h1g24t6E5tFk82dBy1iCaaGQFr34/K4n4I9f9k
 r9JvfD5WhEVlgEMFCnTuMyKngNle+xffs8OEgWk2S00NFcppiENNB9wkg+Lhj4r2pNdsE6pyy
 BhcKRqfCVGPCfrATFxuo8LftyxUlBWFNyKEhl0PYSg3f+cEPcPFSES2BF9TBkG2Z+t62WvDmq
 9Z5NxJIuiaX54mkRJPsjFOMSxpzqduQjJOKe3DZ1dc3uS7exD4Vcwo969K/9ebugtIq9Jr2Yq
 MC88g1/5ARdI0TXftaZWVUiF4MoIyW7tzaY5HvdeQ1rje2w6jJgUQl+OTRfSlje/0QSwnJGM2
 f01VUKsu9rIQy70Bj7WAVgHAY0bGIau8oO6kQj66GZVLpgbmZEgBn2K0RrKp1NavOkoM0jjRN
 XC5/eULFZvbo5/QGIiKHInM0wRoKx7ECu6LNbYoSe0mLCSskdrCfKxC+8drhYFCv4x8iJrtKt
 6YNw1zJ9ndX0MY3leDTCSFkBvZm3UIU0McUUcouH6oPPxlos1v+m9vpadFfEpaDTM2YUNHU3M
 Xp2XnaJG7tuKr59Ub7A8NCoWTCqGLsziVr6whMVZQB529TSeugD8xPVvNc411BLyaU9+7VVJH
 CyhU0WB68qqoZyyYCSCxUZATrmc6pPPiHNrcTNs45GmyFTmQ5dCNT0WPAIn8RICXmJBjO2gJO
 HpH73QrtgXN8E6URGlLlQQQjruVrffYqbpdcN9ahIkbaQheQdIDH4WEzWfSizypO57CrMibh1
 5CEi6SgEJWYHfg+di9xlwUTOMEzBQ30HY2oB3Ibw8UNktKJUc/lTM
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 18 Jun 2019, Eric Sunshine wrote:

> On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > In MSVC, the DEBUG constant is set automatically whenever compiling wi=
th
> > debug information.
> >
> > This is clearly not what was intended in cache-tree.c, so let's use a =
less
> > ambiguous constant there.
>
> s/constant/macro name/ would be clearer.

To me, "macro" always sounds as if it referred to executable code, or at
least to something that expands to code.

I went with s/constant/name/ instead.

Thanks,
Dscho

>
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
