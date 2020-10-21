Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CDC388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E3E2224E
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A5F678Xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443456AbgJUOsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:48:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:55135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443437AbgJUOsG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 10:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603291683;
        bh=g/rRzevHVy4H9YgMoHu2VoHBgwxtDakEVTn+9EkLQdY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A5F678XuHtwOzWF4KnJGL9gZMMKgfyUDHGdjhaSDst4GXsJ/+9XzMyisDDGqb6gt1
         RNiQ2Ma3xNwab9UFOxNG2wv8YOcDCg3FTpJ0oQSHxPoioWI1AOfrnPINf+CO7fEvtf
         Zf3t7rra0JCHCEolQHM2ruHj5ZU2lVtaA0DDnUxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.235]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1k5qTI37hr-00j4Gr; Wed, 21
 Oct 2020 16:48:03 +0200
Date:   Wed, 21 Oct 2020 16:48:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: mr/bisect-in-c-3, was Re: What's cooking in git.git (Oct 2020, #03;
 Mon, 19)
In-Reply-To: <xmqqr1put77h.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010211647050.56@tvgsbejvaqbjf.bet>
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:53dLl+vkE3acuGKS6ShntiNHQRAVABs+VCubcBSgjASmfWRJs5x
 0ryR/6RYbfA7GOg6eAcNZD5iigCHLP5EKeTdrEWHgY0lZR6T9lHa8G96mX51NCCnMsBak40
 fioqqDxpdddRzHzTzLCt4R879sbHkQ5IgR3aRfGONfVJn88EzzwxGPob2gxIY6smNj9xc03
 gePtyDywxnTslNmdwPZ6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtqPWudE6hY=:2HPw3uf8EhcE6T6b3fYelW
 OOanSIOur2yAzzN3rCIxLMbOUZaqhyqip9QAhKa9iEtxMQUJbyCGRW/ZNgKcn0XHbKNIcvEDp
 /zgDZ0xAc/JLSYdh25Ix8w03bjP+FOSyeZBRauFv0F/wvgbHB4NcoaH+ZmbpaYlIrgLt/+zaA
 /XF7dXBR2Rg6khPGRPyUyJr3taNk9lGzecKmbfqkoS83Tghodz94e+PNJDPKg5obRGCKykzsq
 l5CDhK7e/Di4BMq6+Cdn6kEM/VQ70XARlt/KypEa/+vPwhfbJp/etxpuQ/kdaOXUVsQdpwWlM
 ImuGZlQOk51oC45fD32i+55cpY1KC7aseF/pcI36vGI/nBrIuCWesr3Cs6ru3krJpLMGLpTEM
 mLvkJ7q8dk6Kx1se+wmRIZVrr2kVnemlQr9NI/CtlWQYck1cwhuKyCadUJlZvPUhlRrcU/mvN
 3UjFTabQEL/mERNONdSQQKvAbJNLCHPJiZ+CRPStHGrCWKi0d2E1wfeZQP5nUyiWesrX1AKrU
 c1b8kkWwzv1BqGTMajxnDghLcCbT8c82y23QyEdJAlVsC3G962F7PQFFAELSpKk+qLjMaJkDU
 hpOvtS75CtZxHpRF0aLblR3mPJKNxTlgQpm1IxE0LJOIvFZ//Q9i4WRrTc4opmkeoyNaPsiyC
 Xe4nNFu+T6PAZWuOuN/1UTgSPTW65BVdlA3yoGm9h0cOXQEWNDFgn0QbpKpcp211YWaPFJnLx
 sk2kbOQhi/X9uahJqIUeEeADpVh5B6dVWMX8lJYPIzRlaqQMIHpQlbWyAOpP7Oalf6psT7iaf
 IyD7Ok7pIC2HWzEYTYd92KkgIup3zndBVshgEh2KzSd6bVjJQaTN6DRN+bnUE+1lMoqPA2qbU
 V4gbNkZGgMD4uHzHmpujwi/zjg0BOD3+sTd8BseXA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 19 Oct 2020, Junio C Hamano wrote:

> * mr/bisect-in-c-3 (2020-10-16) 7 commits
>  - bisect--helper: retire `--bisect-autostart` subcommand
>  - bisect--helper: retire `--write-terms` subcommand
>  - bisect--helper: retire `--check-expected-revs` subcommand
>  - bisect--helper: reimplement `bisect_state` & `bisect_head` shell func=
tions in C
>  - bisect--helper: retire `--next-all` subcommand
>  - bisect--helper: retire `--bisect-clean-state` subcommand
>  - bisect--helper: finish porting `bisect_start()` to C
>
>  Rewriting "git bisect" in C continues.
>
>  How ready is this one?

It has been reviewed _quite_ a couple of times over the course of 9
iterations, and I think it is ready now.

Thanks,
Dscho
