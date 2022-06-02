Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFAEC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiFBN2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiFBN2h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:28:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C6C31523
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654176511;
        bh=+UyErzQTrqWMPmOEbiCImctI/0MT8P3QqwtzL7RNMq8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FYZ9oGzTxhVp2qF9xjnu5dGLrGnCzIVSabqI7fl+6Tnuu/pS5ssYOlWjxq45YilYh
         BodsDMsopI+DY5GRyGZ8Iq15mInZT0Zvcy6/Wy8O17DC0J13ARAHkaGHMFCdE/jVrW
         dSJx19Mf7axGVeJaHmECYdsrdrSj+gcmylCjJg4k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwUw-1ndyy31AJI-00uGbq; Thu, 02
 Jun 2022 15:28:31 +0200
Date:   Thu, 2 Jun 2022 15:28:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Benedek Kozma <cyberbeni@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: Bug: fsmonitor--daemon doesn't pick up submodule changes
In-Reply-To: <CAN8jHOhn+tNn2cR7X_fPyyLF-ADiScD2gymKY9H2ZFb+UdkJSw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206021525430.349@tvgsbejvaqbjf.bet>
References: <CAN8jHOhn+tNn2cR7X_fPyyLF-ADiScD2gymKY9H2ZFb+UdkJSw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7sNFCVEqRzpeOLPU2lHUp6hyvo+5L4W1OxYd+TyBQdaoFtdBp+a
 nVYKqUsvli4b6/Jji1Gy5+ni9Zh3qJcdR1MYM7ZCkozNZCRTFdGzgrv3KLAj5WFdlPDibSY
 IL9GguDmRYHw2AujN5ZUP3P7rmqkZhdjAi2SLMi7fGhhsyoBmIt+Q34PlLyvswDmHYFKZbN
 nTCVoX4BSvKSGX3rqh0qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HNobJUudNtQ=:n3LoIB1otvyxKvi320gHW2
 tbpaKbTEdO8qOb649rYyaLiGdWQ/rAnZFsxfUERAobiPtOK8ouczWx4LQ7PtQiSQMmgeSmBKm
 CmKx6boMsCZsqRE4n1MKIpQuT0lUv92Cpk+DMdXD1NXfM1It0UJpwRgtvYrzQSho+K0Wyj6zf
 1HBbJQqagPFeOlBIbCsDbFiz6NVKRYtkylcLL0QDTvq8FkCfqoqRQMf7dOimzB+DgvRkBzDcn
 XJn9mzqUd6fJVoc9VkR7Qr4mDUXvxb/jcCs9QTQJOor4txjbC/71fCYNEx1ZWz23nkWR7fi9j
 R2QupJuNDy0VsE1yZdjTZkJtHcZKxCaVG0U2rBlsqc+1XapkIoe0/D+Euq/v3TvfIOVzJxYMX
 JoRMDseh6hgoMRki9+kQU/ucInf057xwUYLk75dYVkzuen74dfV2gxd2D0GLJnCgp+8DgcUtR
 4HYl0t1efjdTqivo461kC0T0I2za3oPOnEyv7kZLB7HSv02C8QwI/DxvTXkJg7f+VV9ZY+XwC
 WMHV5AqNo7ihvIoPRefkarF+z80wXV8SXIyywb6FkEQFz1zYBkpNjEhtV/S8rQO6ZnH/DhyGI
 uYpDopycpjkf/W8JShd/mJ90K87rBjWc/UOHB4dLvpgK5aq9HGysrNEEV2aciFzJrKVLIealp
 pJmtPc96Q3iQPKbXdrDrHj3pp2Ei+oUxzvj9LG5xxW1AYu7kW742etHpGtJx6c9gykphfQcbP
 26sQRHTmPUBPqZDrsTKmUCuoeSU7GUiHXPav/nhZznlp4SBVqaqrO/3KujC0/AtBuJR76DsDq
 +vE8OdBqSdKuF2dlokaC8MUHItVu5fWFz/x2yyEQY6SGn7fBlz0stcsgnGpKjOIk3IWqgnU+M
 jZ1hWbbLlfrWD/ok4bjSuspvB5cNn/ZfBb3Y2hylxafJGw3QySnHFHlshKPNs22MrITgUf8zU
 NVPC5GOLDngwb/1QGP9dl/BoWLhWDisvwSNzoJakm4zQUf3ai8ye5m+DPUheO5W6/K2tReXY/
 0y3FZoUXAgJnqkmw960jyLf496b3/KeAMtTkWBJDNyYpVVJ29KChOJDFBAKnnq5IawLvY1EyU
 colhkFxtic1rFT6Vhk7wKJNMlIXFORRAwkpQuh7BikvWz9CigEgstuj+Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Benedek,

On Tue, 31 May 2022, Benedek Kozma wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> git status
> cd submodule
> git checkout origin/HEAD
> cd ..
> git status
>
> What did you expect to happen? (Expected behavior)
> the second git status showing that a submodule changed
>
> What happened instead? (Actual behavior)
> second git status also shows up to date

I believe that this should be fixed by one of the active FSMonitor patches
that are lined up for getting merged into Git:
https://lore.kernel.org/git/d0c8fecd1a0d622b1a6cce0aa79fdcdc2771db1d.16536=
01644.git.gitgitgadget@gmail.com/

Do you have a setup where you could apply this patch and build Git so that
you can verify whether this fixes the bug you reported?

Thanks,
Johannes
