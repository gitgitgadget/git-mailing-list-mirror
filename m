Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBBC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 18:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773BE20809
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 18:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NE/ChPuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgIZSaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 14:30:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:41613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIZSaK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 14:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601145002;
        bh=5c9m79J2jzL3iIgggHkfDAOg+E5zcBTDJKt38sKcWJY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NE/ChPuF47q6lZvzRqvW4ieX5x05fa+xUNEhTGBwS1i4w7EyBh7KHqbVuvTaU1GYv
         qifelCRH47ENnTzI6xTAdVjztumcbj8bp8OJ47ZEfW5+mDdC9tvUX/Dnpjt/NTJjLV
         rvHDspvjCVwBCeeae4ltcOCjuGGVd66Yu5IACM4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1kcwrR2eg7-00rpMo; Sat, 26
 Sep 2020 20:30:02 +0200
Date:   Sat, 26 Sep 2020 06:25:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/5] t9902: avoid using the branch name `master`
In-Reply-To: <xmqqzh5idah8.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009260623130.50@tvgsbejvaqbjf.bet>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com> <pull.734.v2.git.1600725687.gitgitgadget@gmail.com> <c2c1238b5d9dde684d100fa99437a813140cd615.1600725687.git.gitgitgadget@gmail.com> <xmqqzh5idah8.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0gHpHzPRxjGNvt+lMImPtynkUi7OpoBQs0Qh5iSjBtz8jJt31KA
 e4noYvoTfBHlsTihckf7XwYt/rwmRkrbeiz9rHMcQUEgGZ5jt6LRg2QLtml9sHqCqZE6dZq
 p+z2g5fbMmI8JqRu6wexAf/gFttrLLN112LMQADWSxpggyGuGMZrnk9Pu9hh4X5Ycp4m6Gx
 rlsgpbTx+3G4TDPUn3QOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fsmNnTefe8=:YTIWh43kAz8UYNDk5pHoSX
 itBuACTd4NItNEe1y0KU6PXiDnvcD2U2xtDfj8Gwma1gSbWeTxQuPQpSbs8sVPJs5h/6IXY7q
 DgxbFKYbkNzuiKQtJur0n1VytAYxLIAFsDmXCT4KJzBiHpPUxQZEpZ25XMZ13/O0h5pdnMk2b
 5WnNQcHSSuTnZa/jQpZ6eZfLkVbt4u0XEfdw/6TJf5NdtuUJLU0FB1zGshsQrK0ZEAi9LrE9C
 5yxNNmB0zHrkRLyDfihypB7/ANO+ajaNnXwfYMOU+sYsWPbdwFCnFvV5yAIBTKqYTnXRitdhN
 EuAn6oC30LzPy/kuATGmTglAy42rJ/hYN4l/Zf46b7tncye9aAALiLG2NfQyhggJf6Al0ytHo
 aYxgdZZOeJyz1K+lNX3WQZz9CDJ/xXE2XjxQsdIlB3Ut/XueU3jmsGWL/EssOsldmkPqfb6BL
 wfB2vXAKm2BFDmH1C73hnp2tWFMADgigiHYirOKPiNAWg2W9umIwaWw5DWypCGM6OSVvMmsMh
 J8cxEuvXzZSCVtazItzHNMjtSSxTt8Hpicbvi06qRtUuDXC2F9pi/qUyCrw1lpnCy4SjQ9gSs
 loxlv3ZdMfWSgPa1NYbz6Gw5k6/47pAOmZsFNOiPdr9WhQyEd/XVj0RRXLLI5hkjueWcp+Boo
 Z2OevRuU5LoCu5qbJ59BwxxwDIxqLtkGRpT+SZdlfdyQeK6gEGJJrX9MwRuR9Lb/V3PgKMqp+
 xWJlUu1ARttWhI0dk6f9P1YD0xYZMTDpmkrHvENs1z9e+S6WT9m2hrPzBdbl9EvGBtNzHgwRb
 bb/mNeRELz/le6/Mu005Jxj27L6VNrApGF1ouTbnrTn/l6VGqXkG6OXk06SqyqHk8lhJmBjM8
 wBLseuTXuVvQU8yoSAvvZvnkjuuh4mHqZbh+78ANCB266vZXSYcE7b1Q3HydIQCsiYef7LlUW
 yNc+mbMkf7wGHdnqqduESuwhEzqm3i/IczRopCust27FQ4o+uGw1bSvtzK5wMTBVkbrUwFExv
 E7m0QArdOKzHLaA9SmUWCGu2LodOLZklO8gJ+GCbaGgCp1JYuLiCAJpV+nm7sdpC2GbppetRI
 vllG6u4IQ6rdSByt1CupCf0ByCEqtskh2w3u05D806SiUvr1uLWB32IXy2tF/7gJVabR17XZN
 aWfUhKSHxdRAGGEk/ubNeOPGSAk08b6kGp6sbVc/IKGOYW8WMH3VrLcBS2z1/PYYDMt8sjjFC
 CwEXqaCbrX28/Lk4Fo/j3DrMpmmBSLQG9K1D03A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Sep 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The completion tests used that name unnecessarily, and it is a
> > non-inclusive term, so let's avoid using it here.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t9902-completion.sh | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Here, the tests and the tested feature do not work any differently
> on the first-made branch, so the same "just use topic, not the
> first-made branch name" used in 3/5 applies here.
>
> Luckily, unlike 3/5 and 4/5, this step does not involve names
> derived from the name of the first-made branch name, so 'main'
> may be OK as-is, but for consistency across the patches, we may
> want to consider using 'topic' here as well.  I dunno.

I am afraid that three test cases that are touched by this test rely on
the fact that the first two letters (or just the first letter) are
ambiguous when tab-completing branch names: `ma` could complete to either
`master` or `maint`.

To clarify, I added a paragraph to the commit message.

Ciao,
Dscho
