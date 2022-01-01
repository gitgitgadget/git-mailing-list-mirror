Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43FC433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 22:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiAAW7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 17:59:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:59835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbiAAW7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 17:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641077948;
        bh=TmO5zCyP3yBiUoJZXGVQglAen1V8GXJsH/p8jb0xHK0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Rpr2xOEpgRwstq/HekpLh6C/a11g5TKDSW6ZeGGSoS/vvgAuHoB5/rrk14Clwvdfh
         cEvggHC8dVklAap6c3xEJiDO+KHyj3f4ArMGa2ZpkQkjxpkhytnlHgcjGkPL0sW97v
         lDhtYM62b6td3RcuPSzDjcy/KbJ7HA3UZ1DZCJvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1n4LZW1PNK-000acB; Sat, 01
 Jan 2022 23:59:08 +0100
Date:   Sat, 1 Jan 2022 23:59:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] name-rev: deprecate --stdin in favor of
 --annotate-text
In-Reply-To: <xmqqpmphx1yh.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201012357040.7076@tvgsbejvaqbjf.bet>
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com> <xmqqpmphx1yh.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s5I6Kv2D+P0c6cBGQMavuSLuD/DsDCXOgRcBuQtWonKarVC0PI6
 v0x49q05lssWlqq45GUKk/f1SUQDuH7u3f3WuMY72PNtzvw0zWe/erlxtDJEKSakGIl8AW3
 9FWOo9d5W37P7vuvcIMRLe6/1GNhsvB5FGKNhZh6xFe6T2cKehC+9yZnjSNstKb+aJ4RmC6
 WG/QIVw7EQXIl9Ec+BEbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6rcvadUOpFM=:BXNTj+Z6n/g2WstNA6xr9e
 83g8oOvhsSZFIO+JYjoGEnaBWIBlg6CutjzxurYlt+vLnP+HGrqYhsWWPYEcEGPVDbQaXBwCM
 IFMD7uc06o89Ay0cO44t0Da5gxP6RDsx28ykoyrkVMQNqkxFzHvK9eotAfGr+IszOvldrJURv
 NAU/z0gFsODI2K/mO844/CCBvXvAORSAHKz6ZQRW0qVak8vmESqKgu/LqylT/IcPud6QzvS5W
 nORKoa1YeqFfQWAXODOeE15JRZI7Mg/B+w5MxF0VYXi8K3jpq6qP1G+GU7MWjuEiBCbBc+WOo
 zCwRX7YOVnWvUFv0Ykl8anD/oFur4VqO3rpvQbYlEPyKjjVzvDW9lWZgUuYbdWwhbrW25OPai
 zouJYeZ2TbPkaJzs2EsYrcifmToTK86i7SMK5QW+Lr9KTSdj2Ple/6p3WtFMKtQ1+8FZkUk8e
 mUcbzngKRc0GYe/jyeJrAizcIRfPPD7wWaetsIQP17JKXXwWD5jtdxfqYIX0f3YLEJOgpbXOM
 O2C4Ox5x76yeYyfxJ+T0ONRSbaR4BcXGZv6hE8+e/dqolsPdFmrIjLTl8b73x+ZcZ/tQmEzQZ
 dFVo345mYYiRHScDPXd/jUFrnztYzyFTmGUDZEG+tn0LGlJjfcVPFYdPqxe6quZjl+VZvKOTq
 xr8HPkKhyQK69x4GoRrjX6maUiY6bMRGY8+T+qCOXG7u/sfVu0vi5yqjFsIuQUeOvwgK44b5r
 kKA5w9FH1CxNNPJ2Ji7cT/KkH3bML4HsfYluz79QU1ZlClEX+VhQ5xOmKAe1Br5C+nV+gcSGP
 MAEQN0MYimT3TFWtarozKngLYXtbLVoZK5WYLMZvRl6p+CfMoGV6x2XlNAkdM3uTVoVObWrfb
 ssJIJd4hlySor/HvtgQbBiA2mltJ0wcizBwll8CJmAwBlMuaLFe8UwnYZIyoE9qID5Tknwd6u
 VTEuskgC8bGC/xoBa6PfR90NTHSnOyi6qPeLB7oHs0eUtIEK+R7ETP4e4cZHzMnX6Lv03HXAr
 EnEFFYLMcSbczd2lzjM6LBehv1oPWIWeKBYdgcRSps+eo9/ZJhrvkmbajEGYb/98oKNeJaptL
 0JNalhExrh4Dh8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Dec 2021, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> As name-rev is Dscho's brainchild, I think it is benefitial to ask input
> from him, so I added an address to the CC: list.

Thank you!

> > From: John Cai <johncai86@gmail.com>
> >
> > Introduce a --annotate-text that is functionally equivalent of --stdin=
.
> > --stdin does not behave as --stdin in other subcommands, such as
> > pack-objects whereby it takes one argument per line. Since --stdin can
> > be a confusing and misleading name, rename it to --annotate-text.
> >
> > This change adds a warning to --stdin warning that it will be removed =
in
> > the future.
>
> I know I've suggested the name, but 'text' in --annotate-text is a
> low value word in an option name where every byte is precious.
> "Annotate" is very good to convey what is done to the object of the
> verb, but "text" stresses the wrong thing (we do not annotate
> binary,o we annotate text) without saying where the text comes from
> (i.e.  standard input).  Perhaps "--annotate-stdin" would be a much
> better name.

I agree that `--annotate-stdin` is better, especially since people who
might look for a replacement for `--stdin` in the documentation are much
more likely to find what they're looking for.

In addition to this, I also agree with Junio on the deprecation needing to
be done carefully.

Ciao,
Dscho
