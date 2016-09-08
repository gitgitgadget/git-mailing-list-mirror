Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DBA2070F
	for <e@80x24.org>; Thu,  8 Sep 2016 06:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933792AbcIHG7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:59:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:55152 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932529AbcIHG7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 02:59:31 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MMT1y-1bhLbl3vgc-008FnV; Thu, 08 Sep 2016 08:59:28
 +0200
Date:   Thu, 8 Sep 2016 08:59:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] compat: move strdup(3) replacement to its own file
In-Reply-To: <xmqqfupbob9c.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609080859160.129229@virtualbox>
References: <89725a44-8afa-1eb1-732a-23b1e264616c@web.de> <alpine.DEB.2.20.1609040941210.129229@virtualbox> <6926b39c-4448-c463-33f7-d9eae841c635@web.de> <xmqqfupbob9c.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-303377715-1473317968=:129229"
X-Provags-ID: V03:K0:wVs3v/pgDaexAsbVaJQVg9ct2pwfA7udkVc8X0OX2ftZZb3is1V
 R/75PBnjfW355Eoet0mAEoeJa87dDCkWwpRTK9s7E5JM0r/FEQNm+M85//krKQNIJdoo5A9
 Nvf7raaji6OCLiiGyZTt6XuXRCI2K9ZXd8j1juCTYqktll/FOi09XOx18RMI1JpNtRMK+Lx
 ZUnT8sGDua6ISgBSfuA3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l6eSpn1gRbU=:u8cFeb6sfhrfdu5y9AaNtW
 g0b1BGuOADNjg2RNgbxUlwjsDYzg9Mu84Wc4lP9Om3WbQ/A464id/bff9xFngyXs5zYywpSys
 Ucq2QlK6dJuYl5F5e0fGXF/FxcFHaXtX8SNYfPkbzGEgDEB5SVdB2M9+Wg92OpQqC9OMCAYaJ
 gv36HbP6+9s3oLmHks6eQppUIWkdjW22PZM2MAUlrc618JiqKir5a9xbUNZClzFOocdJicTja
 BBcAdoHq+Mpfieo8fVglDj6h/r1XgkGdnL8HRyrW1nut5C5HR6ucVZZbFZz3ppdL+aLM3BfoH
 dqiSANrAgPPFGbpWaFUamUGT1iKi3ZVARdB3kqehT4ibjuQfNLNj6kf4WllIxPMXdZ0Dx+XXR
 /zc0No8+8khEKMtGccoZyurWPrYSfLpzab1VL9ThKNdiWX2TqEqTp3FND+J72lP121FCM15po
 XgnCDmTSsQ2s4bFdX9RMlCN7NYywR6XLawvUrUVBGQUg20vlH6Er933a1y7c8n74VJ7kTtKYv
 x3mHlG4hC2lAcr0J9VryXV6e5RnemT/yZpbBT39HnA7u2QSVK0jzAMHZV/k/tYeX9bO0Qv7Yh
 jT5LgiA3u9uChFVwdUKLhIHWhrsSxpF5VlPVsJ5f/nAcsUoAIUJHMxBqB6AeowJfJKb3rtzrE
 oTMcAjlgHbNZRKF/h6o9Y3ES9PUsxUgqOXElw5e0ainzAFADLH+NXW6Hssbkd+oOWvtW9e1sC
 VyscgCDoYkiH9R42vIAc5MB5C2nCmQbCD03ySCAdpYCBPE/oBp/yZsgAQ3anfP8kLQhxL9RA6
 /yEaenv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-303377715-1473317968=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 7 Sep 2016, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > Well, OK.  I think the missing point is that the original nedmalloc
> > doesn't come with strdup() and doesn't need it.  Only _users_ of
> > nedmalloc need it.  Marius added it in nedmalloc.c, but strdup.c is a
> > better place for it.
>=20
> Thanks.  I'll add these lines like so:
>=20
>     Move our implementation of strdup(3) out of compat/nedmalloc/ and
>     allow it to be used independently from USE_NED_ALLOCATOR.  The
>     original nedmalloc doesn't come with strdup() and doesn't need it.
>     Only _users_ of nedmalloc need it, which was added when we imported
>     it to our compat/ hierarchy.
>=20
>     This reduces the difference of our copy of nedmalloc from the
>     original, making it easier to update, and allows for easier testing
>     and reusing of our version of strdup().

Excellent!

Thanks,
Dscho
--8323329-303377715-1473317968=:129229--
