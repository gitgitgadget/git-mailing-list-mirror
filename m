Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9AC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5CB2080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ej0jrq04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHLMm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:42:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:41283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHLMm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 08:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597236163;
        bh=ME+umR2SIPMTnmmNh54Dp+QDOorYyPITQGBwK90bgr8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ej0jrq04YlcJBUyhwhzSZGGhJx+Z7eCUw6GM5nKGXRfjewrnAvG15NTIdEKtOueF3
         42m5TSdIWj7IMN7hh2OHsQONAwALSXFt7sgA2FIq2k65kH4KoyRwDMKRhyRz/G0Kf7
         q2fBxCCIPLNhZlnUO0x+B4xNcFfP9lEEPzYcASsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.213.182]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1kthcm3wT4-00y6re; Wed, 12
 Aug 2020 14:42:43 +0200
Date:   Wed, 12 Aug 2020 14:42:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
In-Reply-To: <xmqqk0y59fdg.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008121441570.50@tvgsbejvaqbjf.bet>
References: <20200728202124.GA1021264@coredump.intra.peff.net>        <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de> <xmqqk0y59fdg.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-78178296-1597236163=:50"
X-Provags-ID: V03:K1:cNQqB8O5IAv9Vh4xDHi46JkCl9J1iuuOgvQttDePJJUfkESf1Vl
 YjIqCFca546aXh/BVkFG+78pAT50uZZCPP0+SINx8qA/kURaeVVt/YhwpCfXZQVBUWnk/Ux
 sMUUHeJLXfErolqvHgNTZfgIraeQPsJjiusPUWUPE54EeyGh7k2mbXLOezyQsGnAiG1lbql
 xC6Lal7VFS7+YrLgouT0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Q+Gj/5UUuo=:g5AVprbMw26ikvcc2rp1i7
 y+I2C2EEBd20hjy4vO2gc9eYCXO1l4+M7pzrja0diO7W+KnKqYcJ00HK3WbCtMNIEl7oN3aB0
 q3+bCngnddX1/enwiOlg8ll1D3kTLhcmpMKz0ZVxh8+Yfn4eHd905bRJnt+wY20pmqQS3A1r3
 UsaiLyec2WA1JQ9a+ovy8dZXqoRHCLGvnBcc14VOzaQp+ooPhq3LuWYNaEHjBKwt3VZuTyq+n
 aJ9j8Lspi6kkkvoafyp1CW/iXbF+jTF8DeMkrGhNdQ9jcRARaCPv6noe+ApM2cnRnVVS9KIU7
 5xjCefB2QyypKenBfNMdEY4eKRGqkQiF9eZoX/lA3IyJ75cdrW7NVtHBvxI8jVwgFdfUmxP3n
 /UKL1BrxaOp8XrC7JfCfOsiZBb/ewsSM7b65w4tG8PD3sMutEhp6fOcOwo95Y1C1ndfWpBpBr
 KUBT2uEb29FfBZW0APE5UH5XHq5wI0vjfTfpjep6C+wK1MLGo631sBcANHGu6qtnK8iITKF+L
 fHEY7Ui3XXTiC6igwrhcUGpqeCrL3ScbpApW+0RM4OxaRyDOvzeuRBEzWpfmVVhrAXshd5EPQ
 HLWhpvXK9DpNMe83UKaZbwL5ggQ+thxVp/dTtatcJ9SWPVQ+dGyAuhlFxi/AMgvCeihD9/Gop
 syddjju9HIKWVWcN1QxUnZ/4KiyIx65trwTn+XTFbHmx1MjATnnp1pz0r4dDpWzH/0RDBFpn/
 ZJN/iOyB92pELitQlHMmJ7KpMn9EcXylFxOtier6NJJW1hCHMZq99PAm4g1EtBEdS7MMEGGMH
 v4viutvG8YwM5JXAnH9+qvpsILt+qwz7tEZVr2Pd9fJAchxQtQZ6XPrYipI8CK+XtEjBh4MGx
 n2L25jlG7he7vAq+qusiNt1UUjkvBqUwsQwQImjmlUrqauwvSa+kFcuGX0FcKm6H6S7sG/wvS
 ct2xZ+QJwNUFf9n1YgoiMks2DvYRkttmHAeobHJC8inAJvwbmQ10MRYzHSnIBzrrwlBuUSAGG
 yXa3sEkrwB96kInLyyslCaS3xfvWpHNVLcsglHw7JCZJ0d8W5qJUpCOfHrrpjWnwnQ8DwW0GM
 EU3G96CZt1CAjrYaaG1fdTy58YY6zYMxnXVwI+O17IbInXjYRbt4AD2NecH8izc9tBqeWvNqP
 vGGG/7InSdBjCcdZYNNQ/IW7WYJxnQ3HiQrkb+BfeZTHbsWX+gi7Rf+u3Q1wix0FzOOIH92rq
 O4JTbXxQAOvSevq569Cm+/s++F1Jx9y6uCrOaOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-78178296-1597236163=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 11 Aug 2020, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > 7.31.13 goes on: "Function names that begin with str, mem, or wcs and =
a
> > lowercase letter may be added to the declarations in the <string.h>
> > header."  So the names of the strvec functions are reserved.
>
> Ugh, strbuf functions are reserved, too?

We could try to implement the very patient approach proposed by Ren=C3=A9 =
and
rename `strbuf` to `git_buf` :-)

Ciao,
Dscho

--8323328-78178296-1597236163=:50--
