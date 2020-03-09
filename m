Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625DEC10F25
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 19:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319D320848
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 19:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HDMIcVN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCITRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:17:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:55553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCITRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 15:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583781426;
        bh=B3Qw4karKByDEc0hQoUKZlJhxFR3oDvqekK1dZs8hQI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HDMIcVN2jBrTKT11etANAXuHOxbJEq63dHhKT83q0/cpzGL7t44WIN+PqTnbCXBW+
         a5sxoF1GHuoFYpnKY6nqnMdS1wY5AFh4G7ULX/SO6jEwlRzQqV4ezJ4nPILmkHG/jn
         oFRffCNB+uwhHt/FAUtqLk3I4iJLanmaDwGHCicQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.209]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MeU4s-1jjLCn3xye-00aTKo; Mon, 09 Mar 2020 20:17:06 +0100
Date:   Mon, 9 Mar 2020 20:17:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003092013090.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com> <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet> <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4scnhEWOe0T9E7z2GhS9FOAkK3q9W0Pu9+xQHKaiFVpZUCdMdHf
 K1jyKma25nfJsWBcqjF/OmMsi8obfuAqNgsmwqlmteDH7ztdNiKFTD9oBo4PyfHOIttg4e8
 pPlGZ3EUovl+3JAglVdZo+ZLm/QH548HkkjvqLt1l8YCI0x77efdCNohm46otsMox5JERRs
 DwwbaTfqDejMuqSDxntyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GT89nN9vVCI=:IGm7x8kV6jwzUXwegET5Lu
 SvT02C65R7AFUbvUILiAjmQ6U5++nwrn/v36J9wl+h6NYgP31L9Sr4e/MDJYPc3Nbuj9lPXVQ
 wmsQ7LJeG8/F54TVvXSKB4F1pCBqAdNQ5JmmNSKBHw+iA2zysU9unWzHuXKZywELsrxtqKQmb
 rDDCZfV2wrk6Lk8T8TGYX2bJCFVw93Hqn6gAtWDtzHe/PRD/v/0jx0ryhZY6WNMjJo/Tuu9g+
 GQ9cFgH/nVurZssu8AWjJ7NFouIbb+VkHojcOtrIqjjOHouDgDTc/ENQxqYKVRaVEy2cDHNOk
 9XPEA4xTYXgX0rXDo2dNhXFSajtpcAEOnuJon7K62EgWxPQSjYL+ROW8szpPFZm/DOwfswNbb
 aZBq8sKZ43IrlSXHp1LyX/iDLnoSjAhU7Gqf+W7U9VxgxafpLbM+L6lAtqtm7aHqoZLLmDIWm
 m4/EruSYanRIQljofMcuSOc/gptoRnknVmhgqQQT9WWDTl7qxBnXlTFO6At3dkzqRVkyOJ3jg
 anCSkF6YTdG0JRgRALKVCJsfwUizPkWPghJHBi2oB35r5bVnEQTs5jcaijnABsCH9GTIH5QcG
 TPFAzQIdlP6sbGrbzFxJKl7uTPPp9+ThOkyGXnqz2MaA0tFl8+8BdcljP+W9bU1M0CnQSLLCZ
 7Uj/KN2eBwVGTHfg5pLsXYmXLfkCIA7yFK5+LgxuQHoW99kAU+bL1bNrGl2ozqpipFNFjbBN7
 obGx75mTUhAXo37Whlqc3BYMgKRwTz/j4BfacrNFXh366VWG1Wy+GY3xUe52m3ewQ/oAPGwEp
 0SJeTjL/5DYL8D4654PpT85WQwQTKg1T1go0cx3RwfINjeNNd88vg1hYbMZ55374H/UK+8IMc
 0vvKlxhVe92ZSq5ZWw1CCO34KtDq9S7K0QGFQwboZe9bZd0T/aKxPJHXaLS3S8g90k24nAu1E
 X1iuWposyU64PCKgZQvypplUvlv6f6N5U/BobGzwHlsJrZhEcawf++MmIFiJTNsnXKgAPaUpf
 0ULxkfunBp9brW17f5wLa4OhmG9GVdi6krVeFMwop+lVKjm71lT9S142NMLEWIFidd0GoLdcG
 phhTzcGb/CFrR5qgCrJ9pCSvCpy6y0ZL+F3Ak37KQaAUeBL/f8FC/VC+9BoD5npe9OzmD113U
 fPM/FPn8sOy99Wsabo3wAVMDeBrrcnZXu4I0Mf/qrxsupuSWHLfOqC2qFcDWZ+8LskbQkzMV4
 AN2IKka02BI3AHeN/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Fri, 6 Mar 2020, Junio C Hamano wrote:
> >
> >> What makes it possible by making "git bugreport" stand-alone is for
> >> it to link with libraries that the remainder of Git, including the
> >> transports that link with libcurl, has no business linking with (a
> >> library to obtain system details for diagnostic purposes, for
> >> example).
> >
> > That would, however, make `git-bugreport` more fragile than `git`, i.e=
.
> > the former might fail to launch under more circumstances than the latt=
er.
>
> That's a bug.  You can go fix it when it happens.

Heh... yeah, that would be a bug, and the user would not be able to report
it via `git bugreport`...

Which is the whole point of my complaint.

Isn't it obvious that we should not have an independent `git-bugreport` by
now? With a stand-alone `git-bugreport`, we might

- fail to load the .so files under more circumstances than `git` would
  (since we link to `libgit.a`, we cannot have a subset of dependencies,
  only a superset, or the same),

- launch a stale `git-bugreport` from a completely different Git,

- make users angry for wasting 3MB of their diskspace for `git-bugreport`
  when only a dozen kilobyte would suffice.

On the other hand, if we make `git-bugreport` a built-in, I cannot see any
downsides.

For me, therefore, having it as a built-in is a clear win. What am I
missing?

Ciao,
Dscho
