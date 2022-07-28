Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48693C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiG1O7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiG1O7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 10:59:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99351169
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659020373;
        bh=AzNsJtnmmmxJ5XvS+4NiYVcoK8gPlDNiKNIpNtjyqgA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DP5A1M/d6TSnVXJ0EyphnhFvENDa3idRG11hHaYXDwyBNM+vM52+KPxQuNcAQMxCg
         mS6UyQe2S73Nj3eLxFoVtJwzlL3IKmscmUvDIIAAVUffU/rl1HuIpQH6R+191Kq3sa
         h3sVX54r0Fnm2eAlvvecrisgg6mrPgLw44u5LYfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.196.158] ([89.1.214.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1nfoQn3lTF-00p1Fy; Thu, 28
 Jul 2022 16:59:32 +0200
Date:   Thu, 28 Jul 2022 16:59:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eugen Konkov <kes-kes@yandex.ru>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: --creation-factor=100 does not show code
In-Reply-To: <1196830250.20220726145447@yandex.ru>
Message-ID: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
References: <1196830250.20220726145447@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XsCNU4tl5BQ4s5xmVlkDCnfAgKfZc1Kqip3IQkheMuU1Nml7bnM
 7SnLyOqSQnWpshQ/qVg6TcYbsVS6w2/N00dur7PYo+NRn7vvJkCt1PEq1cE33BYVtIp0f2+
 6FVm/oA9om2trOyiWaAC7WbuqBeQUkIWLMHeA3HP6p9NC+8DW/vK7bRmY2fy5umNW1B2oG+
 GE9z5DxzHORdErpW0ysWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GOnHna16dD0=:/ZSnpHP5cdE9mSXaf51Lbo
 KL8FmTXNP7d0EWBQwn9T2Krh0TSQvJ5voX3nPAuvcQsXLmCB2sPo5wYi1ka87G/PudNNiWW6O
 DSP75NYNp/jb+efpeF6JFxDX9QB+zQbgJXoIoyzhcwv70o7EWOP8BBmrwu7Q1ZHKjLR9Oerzr
 H+JW1a9G920eJgKgOBWyWAV2ITz6LTsJuDF6jDJXMM9dMqU6OiTSGC3L7N6ctMh65kwOPtNIM
 9224yKOtr1kivkjDirm8spbgcKIxdYiWLlRQAWfci7x6JyVclkOtddrFDrUh65S6nhBeXGC7/
 QTznNn1P0KxL38pRgTRTCRZlu0mYEo9W5xreFeRRpa8T2wMORfndtqUr56WTb6w001yRCR6/v
 D77gzZJM6dXfB4ALhua0+jaQ2VhDBujLrnFTlDCw5SeMYahf5RkPD9bbbFK5yTPowvMxE/QRm
 2rmossfkf872JnhwrcPqfAFluuLXSxXmYL+EtRiNNFgVfzKRsejgldLYnCdVGLCsLeBz67shf
 r4N2cSLLt8uZgosM8V/IbGlGOB1OsMFYQpC6kE8wPCwhoVMKQWaHIxtpT1ghoZ35uQ88ibuuM
 ghexuViPfdVsusBDdN8rG4RS8NjXg8+SxQX7QupX7K82CSW0qPethp3w7Fds70hwyyiWsDzaK
 hiAEUBnBY8+JmI/6tNxYle9yn2Wu9BGq2Y81QzMSyJa9U4cHgtsmAJMBonh3MmCYobbu9bpo6
 xiGisvzPOv38bMU36wB4Q0Mo30+T1paUU42m9EX/LIID2w7PfnoyrArivHPEBzL4LB9CgUXM4
 5nuc83IrQ0rlzVg5X2VCDKm2ameq1MX4yOa+LoWftRTEd2IMPMZAFvpfDARyeKmfPH5IGe63I
 urDqrE8jfmBbPW4HUMYye04PEOcGiDwkW97mCZpkRwYgGnUN95S7j1RYjC2UPIXwaENDHCOVo
 +BqgaTQvkCgflkPALcHcENoSX07kDIb9Kng80dHE9LicdmADUB24H8jWKN/IaFG7/xmCpaI2G
 BUtkOmEfYo7FHmxcgd0YLBSzG3RWqUUexH2WJF7hCc5Tp+Jq6f1Fupwe+lHxj9KUFSE/kPvZO
 RJfF0Bv0isXsCbx8nBB2QZ74+7PPxcr3VfgBAAswCA2FdoZ/grt4APIuA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eugen,

On Tue, 26 Jul 2022, Eugen Konkov wrote:

> $ git range-diff --creation-factor=3D100 branch...origin/branch
> 1:  a87daecd47 < -:  ---------- Add mocked exchanges for ...::AutoRenew:=
:General test
> -:  ---------- > 1:  36eaeb56a9 Add mocked exchanges for ...::AutoRenew:=
:General test
> 2:  9594ccf145 =3D 2:  70681dd13b Remove a call to DB::state
> 3:  740903e01c =3D 3:  5745ae5702 Run cpanm without tests
> 4:  e8e6cac09c < -:  ---------- Do not use 'require'
>
> --creation-factor=3D101 does =3D)
>
> but maximum value for percentage is 100. So expected behaviour is to dis=
play range-diff when value 100 was provided

Please see https://git-scm.com/docs/git-range-diff#_algorithm for an
explanation what the meaning of the factor is, and why 100 is not the
maximal sensible value.

Ciao,
Johannes
