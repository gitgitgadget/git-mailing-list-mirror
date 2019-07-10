Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892691F461
	for <e@80x24.org>; Wed, 10 Jul 2019 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfGJUfz (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 16:35:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:46801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfGJUfz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 16:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562790950;
        bh=/0whHagEcBB/ChT3SYiF5+TmeUfLTmxoXidl7HUVLPI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hQ/nOAMA1qVCl7B5uQxR2vl5p2bxqWHEA3hMPEfBEwryD1XzkCj7orS0K4aKunRqo
         bu+YOsvPI4aqjRno19qrQapARUnswIZoc4N1WM0PefTwY93goEL9ivgs2A6lKiLxgI
         jZ1/8L575q6HOKRuNN4UtgVYptEFvhtMpEJRC9HQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1hqXiT0UZj-008ZhG; Wed, 10
 Jul 2019 22:35:50 +0200
Date:   Wed, 10 Jul 2019 22:35:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Avoid illegal filenames when building Documentation
 on NTFS
In-Reply-To: <xmqqef2xu4oz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907102137060.46@tvgsbejvaqbjf.bet>
References: <pull.216.git.gitgitgadget@gmail.com> <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com> <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907091524460.5700@tvgsbejvaqbjf.bet> <xmqqef2zw9op.fsf@gitster-ct.c.googlers.com>
 <xmqqef2xu4oz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UUTh1sD9TK4dhvMRjHN1Suy9XdBqLHt/qlts0PZckAF8EYm/MTu
 M1OWk1s0HQlTAhl7kQOVPbZtsfYwQDgmb2GKfco7lZIQw8fncC0HAxoSwKOTAHSfJl3caTX
 QbpsIMDi3xSoBN2kn3+ac7K85GWv0FFk5/KDub2P0LFh7N4DuhJaswky6j+dneWTDTGC2VH
 6I/LptfFaNAdbbnj4nkyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Abc6OK84jk=:GF7HswfPxo8/Bkn5ItbwqV
 MhJ0v8/ucmDP6x8DKWbyu59r96iTNkWb4k5zyaBvcC2OLoiafWi8kuC/WhZckw3WLREd1Qo4M
 aaevsd0Bw0uwUeZciOvanlRgyNED5Rrf5TzqJcbiga4jkhGIMJaOrjn676e0li8+JMtC5ng86
 FrnuC81zY0cuuZOJK+LJDNKcGiU2Fna0BpoxIRAdmRGtqWXkcii5awpb4uVToqgfg64ZwaD5p
 dxsYEjx0ZaNsAOl4qkHG0AHSOJl3J5nvrhPWAq2S3q/3KKzlYXbOGWlkzI416lmbkDLJxB6iu
 HuHOgfZzBLht2qXQfl+p3N4kPCXnI8RbRr9vRk3I3Br0Xw8yTK4bULnbfZj4IisLpD5PMDiw8
 m1aSWtzKXoVo7jZk15jCuHbQaIIazDBLHQWhkObh317hILV2gD78VZSkGz82p/OYd+xLZ3i+M
 UqnLAyIM/DI3jbvdDvjuOen1/T/q8bfzkwsirk5ydC/S7kUgk0M961w3treXZHPmv3/4kuyzt
 3Gmq0XVTjV6xVJjLVK5jL4X1yTCMBXahGn9fJhtRT6sWSBvkJjYXUVL/o88B3zFl/TyEUr7Vs
 NvhVedwhK7IHj+ufPWiu5/HWb39CmGTtupiyqIgWGYwQlXs9/9vPNPQdONlBzbQnSb4rvxqYf
 MfIk8aT2vxnCijH5/vxxdeCtEyIrkhhphe4EF0qkXE9V1vwURaHgjoktT2zzeeXgOqU1EvSg0
 KmzPrgWqNBNhLpLcUr4uTwPKvkztJNNhf2XmYjDpXJmq23tHclFCwcDJaW0lYYNaNSquKcGxv
 PMSNTg8/pNezqY5/Pzcw7ejAKnKl+xCcRrI++VFpYCQbUDuTLjxQcpFUcSREVdiR5rP/34aXI
 MoA2PhITJ8fGjeOBhzkoqJJOVAS4pTP5JWLgYxgTnO0QGOLgJE0Mqm18xduS5zS28YPscOmQA
 DpRGXEcaX5J6BBKb8H0YrqiU4BUQbi/u30Moonpvu9+XeX/kDwaeHeLAzCCb8Y1XhJRBzzB2T
 EngUz/078D2N3zh8ofgbpxinqqikQlwRNV1Gs6NaHTIzfNQw565iev64rbrzxXIvFNRPNzU4r
 O1vsXg9QQfvGSApJfa73KBFqIYOlqSJ9bJ1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Jul 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> In addition, your `+` scheme will break on Windows once it uses `git.=
exe`
> >> or any other non-MSYS2 helper...
> >
> > I am not sure what you mean here.  Is your git.exe disabled not to
> > be able to do this: "git.exe add hello+kitty.txt"?

It's not that. The `+` is not allowed on Windows in general.

Mind you, I just read up on the details (see e.g.
https://en.wikipedia.org/wiki/Filename#Comparison_of_filename_limitations)
and it looks as if NTFS actually _allows_ this. Even VFAT allows it, but
FAT32 does not.

So I guess I retract my objections, as there are probably smarter ideas
than building Git for Windows on a FAT32 drive.

For aesthetical reasons, I still do not like the convention to append a
`+` when appending `.new` would make things clearer, but this is not a
hill I am prepared to die on.

Ciao,
Dscho
