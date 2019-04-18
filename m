Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C7820248
	for <e@80x24.org>; Thu, 18 Apr 2019 11:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbfDRLqe (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 07:46:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:55059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRLqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 07:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555587987;
        bh=RwTphXOW5sNLBZOaA54ipyu73WgTHMXuYN3QPUdHw1A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R5IWID325GButcaI9GqS5fHFtw/Zw1AjSeoMJpIL9Mf+SISopUEIa3zYu8WQ8mApP
         JVqtzZPiM6m0hdNUpZEF1EclUlATg7K5jyAbqJfBWn7tVmWLT31LNUTKjIe0v6CKtK
         ZcQS85TjPRxf7Ovt+TCkqcI9U5Evg7O8rBn1HDR0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFgxF-1h5FX40A8T-00EdoD; Thu, 18
 Apr 2019 13:46:27 +0200
Date:   Thu, 18 Apr 2019 13:46:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/7] remote-testgit: move it into the support directory
 for t5801
In-Reply-To: <xmqqv9zfsq31.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904181346050.46@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <81c08b178be6329d51586fa9d615063d3c6f9625.1555070430.git.gitgitgadget@gmail.com> <xmqqv9zfsq31.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wy/YIwtYYX5wT5mOZ6kK2Ejk1N1bigdzUqS46rgsrJdDpQF8VVV
 0/mjj6wpruYdO5kagvjzy1b5cmVZWua1GiOcfTYQe4S/5Rd+3ra4l2jpDKGCxMddmZ7z63K
 2P1WDBvXq4Xtqlu2Ww/IU+750Y8Cpvv8ylMv9aD+whXCBZOR2uIJpqVCmq3VbflScwYhI8N
 N5ZdopKnqq7z6CxHwKu8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oE1Ef8+HKLI=:5uey4JVz6UkVmQ+0Y89U8h
 Dj+57HWlfE3e8oshfwUyA2FUmOWeU2CuhMKcMhQkzKCYxhaAq/RoSC4xNrYR1LXxILEULlt1u
 3H2oaMdVN5FAFXedSHu43q7cX/BtyU1nIa2ZfFcpsk2prouzy2v4VBn0zpxiOetQkjr4Is26s
 ZqrRSy/yApJfF8ZRyfnJ+MAs1PvAPBjivjyM5Wdq1oqFotwyoY9U5vwo00i2l4wMVOeNOqYGa
 DyOLhV4EieVxnD2h3nbqvCWgQP5Hej5WJO4OZX3NOYq+bwJb1HCHRJvJ53BgBET6FaRi/Iq0/
 gZepcb6E2TEGzPdJOK+QiJiEPKA6BRHgNGPonQeuzpNZ2I0WMudoM3BkfxRds+ecfN+xWr/dQ
 NMjL72INV+mdPbsrsdQPDCu8h0gEuw2fA5/eynDfb+C21UOJL4FgRIk5ZPOcC//q+Dt+aVlSF
 HAeiX5NAnyXSWJuYekvV7hFdfWx9nu+OcH9M/dYOH2eYT5Q1UZm8QhFx+KeiJqlicUnhxpzwH
 CmYHjvVOz/DLR9rYTsIBoK3/0rE6ny07UepWOF+sySvLYmHJtjh4d5eDlomsxA799VD039p4X
 Jysnv0Wj0+TGn3gMw7qBcy+N42YxWMhedFTJMAQTtHX5B5eHVIUCsr0jeNawvhDL5QXt5ZaTq
 1ORJbi7Uz3vFxcRQpN/snmAdrZV1wPNmGACU5EJ71vELAguOOvV+2uTPs5e8M3bX+RNU+xOWR
 /o+Fu/GMzOsvf5BcSJM0kOHngAw8qNmnMDolWs9WHWp+gAqjJy3bHpelYtyi9/+CBprTIJICD
 ggWhJ/MNtRZnJzqTKkBMmoWW+JZLHNcAZVVMGBgx3jiTYh5rhQzuAPSGMMGToml/T6Pt5RrQX
 WPlLq7Yt1o/rhnq0NkhyNYu+kNC+eBxpNGZ4Xzr8VQnibVR6GBu+KNw3+0No9KuImI0Fg7Q42
 AvJzewnk6Hg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Apr 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > @@ -657,8 +656,6 @@ SCRIPT_PERL +=3D git-svn.perl
> >
> >  SCRIPT_PYTHON +=3D git-p4.py
> >
> > -NO_INSTALL +=3D git-remote-testgit
> > -
>
> The line lost here was the last one that updated the value of
> NO_INSTALL, so we should be able to lose all the mentions of the
> make variable now.

Sure, I added a separate commit to make it so.

Thanks,
Dscho
