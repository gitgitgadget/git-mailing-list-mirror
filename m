Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53CDC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9277520672
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ctUBqr8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbgFYNER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:04:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:54821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404709AbgFYNEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 09:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593090231;
        bh=7SEI+AFNq1MDe3QNHYlKT7JDWbGNMIo6Fc2vdYZiUZg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ctUBqr8N6k3ik5AkRVZB3No+wduDs/YR+F09JtFsIYth8xClZKPcbLR9ihYOSbmEr
         7u7PqRxkHMRoJsOSvAiH7fQVZvxAN5cWUuKFD92CKKdALeHDONlEmmx+b6QZlmWOBE
         v1EDiw6x5hNm/k9QPaPgzPW44jpOeAd4mQqWEJBQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([213.196.213.24]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1jBYLk0hal-00eewK; Thu, 25
 Jun 2020 15:03:51 +0200
Date:   Thu, 25 Jun 2020 15:03:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 0/9] Allow overriding the default name of the default
 branch
In-Reply-To: <xmqqk0zw77li.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006251503350.54@tvgsbejvaqbjf.bet>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> <xmqqk0zw77li.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xmYZ0UuBqxLW5JGNRa+6RaIm6M4dA5BVCY4eM6y9N0XVu9/JtSX
 GGmK+BaaE5TH6ekNaDL2uxttEwYuJpRx3ZxqwAfDZLfsLb5Bw7DWKjVa+iTCmjLf2a7osq/
 UQ3Ufpr3wdWNeAitoqPXySE8XDne1WMp5F85y+dWnmvdM6P/zvtr6O2EumrVps1YKoAsOoD
 f0TtIw6S274I4Y5eOwQIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:csIJ8WRa820=:11Msw5EzJyi4vrRGxr3abR
 99agiPYx65YgjvJr7NHYDdzKEB3lSQv2uDl6Pe244PHVVqYi/iv0Zc+GJ2nwK+NdJ3PGPSTj+
 aaGeoAP/UQknjtABYBCVra0rO3+YCYIoJ9ZY8oeh0Pz5dIRuiSTaI6zOAJbpJwuexFr9ZeUa3
 HvwOQs35I84U3LX5J2VtT5KT7BMAnNZyFM8L/dhJTUyAhHo7wTqTA5rmy5TuFDBkMpg4JXzgQ
 Z6Tq0XB17jTlvowQ50Wk0B2NUpOFZs9NLD01zHfInRNksmBmwo1hf9cVHoX2pkjd8jFcB0802
 JVtrfCeEmNXe/MLRbbQMoiis0akIJ6dHPABfe/4w/FsT1ExrUtoAylroXP2N4e2EV09RX4XDM
 7fMN4tDYKGx7emw+e8h8HkYfUxbp6RSMaD+2DKLR+b7vFVKLLUcZf7CSv9afw3KWanrbrgMF5
 vwRBC0wZTT8YAZflMww4WGPHsT6uiSBVCnkpqtWTJhfEGBvvd7stjSBtvhbfQQVyjHRwsiCcf
 E4e3GhlyxGWb8Suoy6CvScXszxU8JVhZ2X7gc3cTbNGFbvuDD17uD3Xd/U3CaiKreTIIuRKCw
 jQl68KEgu+0BHJUnnV6TI50s0w1JN0OFumD0NYbvegUwp71W77wJYvkvvMsfmLFNqSNu20xXp
 2PHJzb7gg+ttsbjsc3ar2ECnup4CyWcIuEQIzOSuJvXFJPMn1eZDxaBT9aUj4iOIUPGnKszN7
 87bRZCrw6E8MrtF5fzWmpV6VPoz+psI3X8N+fuDJSjQ9JlKTYKc4PmFHF5dW1ghlQ9fBKrPhc
 acLiutQY60x5xEOYDAe1WyPo+OfB8p+wsrYNdXqeV+BgRiP/08yBO+pM5r4qc99W0bA+nmHG3
 tXNq/QSdlQ433d88OrrBfcxLx/VPs7CQ1FCw6rz2Pn5vCBapDU1VzAn+VO3KRMF0iFQNkiS3p
 YlDBeB/IKnCGU9WKSYtmZLeYdTTw3SEeypmpCo+E6heFTWEoui2XdpJ/lNuwyCGDY8ScZaylr
 DrskSOvYCU2tDGnRLYvVgBQVnPAYBgm5SRo6ie5CCTesiu+INOQpOxAXAH+F2/kaRk3Nn8rii
 aEYuUu5fNVD2jUqcG1eu2OUbGWi86s1BFMtIuYW4JXAUw/UrWuIdR1EXWu7IN9R4LDrA9f039
 IpF/0VLPKuQ6xEwSndKOjRIAG/yONdbRvuq70AkfyOCnjKzTH6HNR9oduHX2k670frnU5vAbz
 bdOEKNJO5DbXSN81AQdtlLuj6aKVC8BfUUqPNiw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Changes since v3:
> >
> >  * We now avoid the phrasing "specify a specific" in the messages.
> >
> >
> >  * The git submodule patch has a better commit title now, and it also
> >    adjusts the documentation more completely now (thanks, Philippe!).
> >
> >
> >  * A code comment in builtin/init-db.c was updated to no longer talk a=
bout a
> >    symlink when it comes to HEAD.
> >
> >
> >  * Made it the responsibility of the caller to warn about reinit &&
> >    initial_branch.
>
> It looked all good to me.  Will replace.
>
> Thanks.  Hopefully we can go 'next' with this round---knock wood...

I concur!

Ciao,
Dscho
