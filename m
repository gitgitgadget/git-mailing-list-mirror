Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F495C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E44F60724
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKDAOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:14:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:46455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhKDAO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635984706;
        bh=ZlaMcK2WIIXAi/5PCIcVpyZOZvTiQ3//tOD8y8+CwJw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W7HOTJiPxW8yVxKO2F7IrY/II9HMk3TUJY4a8KI9F2EUabaOpy5bHVlKtJndB7VZW
         XKGq4ScBn5KJuye/DOCO/8chthvyOcHbG4kvLQAwah5abQacLFAlC9LSlTRm9qrKDH
         qQ2ZxtJt+8BQG+tNn+TmBt0YlextPwG5vv9mqcbM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1mFzQn3T56-00g2Le; Thu, 04
 Nov 2021 01:11:45 +0100
Date:   Thu, 4 Nov 2021 01:11:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v4 8/8] clean/smudge: allow clean filters to process
 extremely large files
In-Reply-To: <20211102204737.3wzphfcd6ne3sj2n@tb-raspi4>
Message-ID: <nycvar.QRO.7.76.6.2111040109440.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com> <41fda423982d99847d3879f5ea1eb3570ae9eab6.1635867971.git.gitgitgadget@gmail.com> <20211102204737.3wzphfcd6ne3sj2n@tb-raspi4>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-681909134-1635984705=:56"
X-Provags-ID: V03:K1:5OmzRvxQuaJDoJ+hEiYbkfVl1e9r5hPE+c9LgtcdB5KHZ5IgGCe
 4HkidBTTkwpvHvVZ2Rvw74Q5o77JxexKlQsAJql1+tXNc0i7rtX3T2kgv+zvl+u1BNEzc/B
 wMnjuwKjcpkXmJySOhBEemdbPFdA0EnMKS6QMEX66KYbenyLzpZ13yaWLGmHCm5S/3XL/p/
 vSRMYCCUk0x/FtCvoze+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uQa0+0fZqZg=:rLXoluiSISvcBvwKTh3R52
 Gxv+4A1vszgbQHwjlytW2Lk4VOn1KZH+CJQwmuYD7tiY6R5axfYjhr6vhjHAii6wBcJZIitvx
 fHwmocnaqqGLgWe79F5UpdL9gmKY6a0glpJzze6tY2W07Q+U1Qa6DDZNTrbpJIx+xGPnEdJy2
 Cwi7rAlMNsYOBmgf6hLQwVb2dklVjQFLtZzNYYwdvB7970gtkkZERG0g15NeIZUwGYRBdig48
 mirmeujxLHDsfgUUNsuWKVpQrXF+V10lZ4oU/awfoYBKObokUYpWu2P4aoRK71e2pyqVQz3/1
 ttX2gtVe6PBIJwwzc4GpJ/vf+g+xslqGc2ZFOKltW6saJ+BwASVBvV4qQfsyZVuJTxP1vVvvx
 t6iYnb0xtI9OHHNuDI5wf9vbeqfoJeegRMiNzuzwzPDznSDUMhrZ9w3/tM+IlMCtvBU6ld4Eb
 Tcx6VYA+KmQypcHLwDG33oDFT8E7C74Ya8hS3XABXiejJO2sHX319IQkatPvcLD07HNFRZ5nr
 o7mJRuASH+T4LunxForj8zJnijqhaH8yXhFzcaL6yGEiBw3s1Il7o6RM/hLE7uf7uVKttPy1S
 +v1ccsvBQZIOPQyOieLaQhdBPR9a8k44AIkHWAZBDkIvODHjrrkdUv9Sq6VBz4980ckC1c5Xh
 VV5/YDh/dccmUVEPDL4+sfI8qHQIXaybPk9JHmxhNwN0ZM2mK6jydlygIY9c2HGC3VW/yLhqZ
 WaqeK50ldo67x6ECOaDRLpyWEIfscBw1NfWfMvWgTAY3entfYG0MYb/Ga51l6tS+KJ4+1zupF
 RiDfmlKsxuKI4P3Fe4AEUDppSY+MUo6GAT2w4SoI9PQ1+k2idnMd7Nu8SzYQftv3rtIwyxKLP
 NWQ+dYFjrnBbM7g8Yo3MrnVolTodamN1E3Mnim5mvoSi4r9/t70C9+Veywp+c5aIEcXNUaH+i
 f8hpM3f9uTIdotgvPzXZzJxGsHV7rC41PCUzwl9LqVm9TKVpwwayiIObnB9DeH9jjQtud1CzG
 zDUwQ6gGsAKyu14D9wIlyoqPvUXXtspAAjq8A5s7y6UFLBK2cPvvWH/CTcKn0jZcG7RtopY2o
 dHB7rJD19+eww4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-681909134-1635984705=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On Tue, 2 Nov 2021, Torsten B=C3=B6gershausen wrote:

> On Tue, Nov 02, 2021 at 03:46:11PM +0000, Matt Cooper via GitGitGadget w=
rote:
> > From: Matt Cooper <vtbassmatt@gmail.com>
> >
> > The filter system allows for alterations to file contents when they're
>
> Some nit-picking:
> looking at
> https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes
> we can read
> "...substitutions in files on commit/checkout."
>
> Should we use this wording here as well ?

Again, I believe that Matt's command of the English language is pretty
good (but then, I have the advantage of knowing him and I very much enjoy
learning new English words while chatting with him). I would therefore
chalk it up to artistic license when he uses the word "alterations".

Since you did not comment on the patch, may I assume that you find it
flawless?

Ciao,
Dscho

--8323328-681909134-1635984705=:56--
