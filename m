Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9CAC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479BB611AD
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhIIKgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:36:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:48429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234168AbhIIKgg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631183722;
        bh=NpIw3K+W2YpYffA6pLrqmoOq6UX+eKzTZtHG6XecR6E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GR4yOJXw0QNpAeNXEHeP//EB1vJKdAas+PvQjPF+SuDaeqMkWp9NcYB+5rPBa2ap4
         7Lm6RwR9qpT5/s5PQ6W4rnSMLxpNbnyq+HSyxWmMgs2ALKtT6PxRBior4BUTIQt78o
         xJquYiUAbKqR1ZJA+a80Anblob0kDXlYlL6OkHj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1mThIT3jSG-00Vvzn; Thu, 09
 Sep 2021 12:35:22 +0200
Date:   Thu, 9 Sep 2021 12:35:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 08/11] rebase: remove redundant strbuf
In-Reply-To: <35b6c26c8f934e3bac984014a59c095c15416c79.1631094563.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091233330.59@tvgsbejvaqbjf.bet>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com> <35b6c26c8f934e3bac984014a59c095c15416c79.1631094563.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fdn6r5+geW9WSovhZNSKmsVED19VU2yN4qYq2uFe8mfu1AZzvxN
 Z1UNVR6C0gLsIHrP+5Qgx6dDqcNNfVGfQtkcn5drylL4zffvS2BdPu38vwD+k0+BJ1inTSi
 GSl4GaGpK2rQyLLA+EXtIPlmUKhiCHjQJryBfw7FSvGAfhd01vr/Pn0G4BVmqLOyxOazev7
 VDQwL0sq7getpafpB6DUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2fMknwqHrD4=:aO4anBP4QWTyW4TlDIy8tj
 +0KE6YVpUdWXW/2H3+8NRd/zMxdmgGbkdH7qYVERe021s2IlJl6kEDhojSFYNXHJ1Pszrnolt
 PNwU+y5NVUq4HQj35YtYHW1r3+aHfLwv5H1VcC6j2ZrVurL5pyKmfD+Gt98+ZAIBa5zD1xKa2
 dTZsbHIe3wTBBewZ418+4bmbMyJuC7O6f1Y9ihL6RhbIomYHpiyAHk+ZofH8LLgfGv4PwQw5v
 V3fd2DBVvc67qHwVEbbJU/XF7kkpaID9g/2DNOVkWgC2H/MiIEl5fi0FKcYQuKZsB47AmMrVh
 Vk4MYYzW0EYDRU8NTvM5xBp5KWhRgu8RbisUykhYUiRSXKJGyAT82gP0XJ6cEOUPYV6P9i+xH
 jRy3bLgNKl/dTdQ0yP7adiqZ6uQcy9OngjgKiTweowMjr/0EZQJWKF1DSX7OZ4z/Y7A4VFH0S
 HvWaaOM1OiHPq12fSf//UkPqzujHOzVuoRgw2a/7r/CUthtkzU1Nvknv8gNTt8dqrWKQL6yEB
 X4ZU1MgQBOSioLbARSS7cFUziPq4wGTh72bjH/OSYfMCV39YVGbIvfvOT4uM5PVrnkgV79jCm
 DO2sCdN5eMkSpb8rwh0lP2blZ83gmeloqA23754n2jPQmkc8HMczZAomDmMN+gI841/jN7KR2
 Lj8/Yp9I/OFAwUDF4V9dXCy5EkwzIWYSKsNrDP4lef4Wt4L2FPlyw0OZNk71BvBq9qbqoKxdV
 ytQLSqkprno+HRK34xNrhi+tL/5eDa8WwIx5hRRk8skaHdHk1M8ynlDSWHUNF66x3a18962Vj
 tjryig9A+jUaqq3N9NqCzJClvg1ng6O8z6Zyy87GVCTj1o10dbE6kmE0aKsreb5NB3g8b0IYE
 KG9m/Wjs85Xl34rsd815R2pQ7xjYG+8DyvFkHdK/bX5LBGeC03LsEKSvnvf42lk2FFHX9GTGN
 qFMHi7Lgxpe/p+3YZhKvKTH2lQR8rRunAQyQmjGAA+naqdAHtREYYwpH3di94ZUO8VktO70TE
 LlszodS+mGcBS3Be9lYmcK7gOO7fV1MwE36dMdGqN02yqgOlU3YphMnrrlj31FPxKzlhWm/JI
 7z4/yebs4v0HGw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 8 Sep 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> There is already an strbuf that can be reused for creating messages.
> msg is not freed if there is an error and there is a logic error where
> we call strbuf_release(&msg) followed by strbuf_reset(&msg) and
> strbuf_addf(&msg).

In some instances, we use a `buf` variable to construct a string that is
then assigned to a `const char *` and is used elsewhere throughout the
function. If this was the case in the code you modified, that would be a
problem.

I did verify manually that this is not the case, though, so this patch is
good to go.

Thanks,
Dscho
