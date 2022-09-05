Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1EDECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 10:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiIEKZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiIEKZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 06:25:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318A1D30F
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662373532;
        bh=hrTrRA4M8wHeUnHS5jnhgEE2zOGRACvVjQVA/yEN+Hk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PuSTN4MFH55vHQGQR9AFSPWYOOGkbBADG0Wuz/zxLRIZ8G+iKmcWGtSIF7BLqGm90
         Os1yOPTbTkHuYj4S1w13Ievp/1whQuA8jkUMxTnT0YvtoDFt2R6rwrGm9/nvLb/75G
         uK1L9Hz6eElfqIL6YI8AARJCs73c1PBoGOA4QG2A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1pSvgc2Xxy-016w2t; Mon, 05
 Sep 2022 12:25:32 +0200
Date:   Mon, 5 Sep 2022 12:25:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Lana Deere <lana.deere@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
In-Reply-To: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
Message-ID: <9676rprp-s6p4-o2r5-6s86-5939os5qn855@tzk.qr>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OLXF4vOEZcYC24vCz7LmSsfNB3Sd8AACRPBv9iGhCpdCgrbDX3S
 gbd7yzffAb8p3Y/bvREHVPFzREm1mM5+Ur9YftTGolgOy+8fSLQEcxkgACfBlWnGAw0VI3G
 iNqSBaQJs+WsSkwJCKnirAQY+rs9hI0y64gpUDvxC6PvCOCBObIvYKvF8ouZWalUwswh2XW
 3eRnIp+P9TBPtDFiD2iVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W25J2iPQCtI=:Dc8urBCn+Bflsr1V5j/95e
 xjFDgDHoHbRyJK17FWk6+E7l0U8+neaJxix+eNchFgV5jw7lHsBNXADgCzdJeYf3ZLAP5qUvg
 atEOsJm/YwORrfHc7juGGz/Zzvo64bxZLzMkzxEmnkBp3+CSP7GFhBBIh2Pm13azHf23bdi04
 spEeUlJ7pT8ir2rONp5TeNGnHilDuWm1Te00rWZVBnD+RZ31uNqS1huIv7v6loT5ktO4lKoqs
 PNET4dXP0wDcCWLYjIatZ7OZcFCfsGCVwBN9BQR6ytBpPkW09qIbJkDYxQoikY7nxGtiVskgW
 5SN0y7ekBqRkVv5WcQr1xRHW5DcUhOe4rqF9PO9Qj86/CUb0/iJaiEtqJlnwVRAkxCIxHTp2k
 KRzNdm8P73BR8teAYNzcHuSCgOmAPoS62sz1ggoEvjp490r61U0nCWL7BqNTOHv+hRJMTm+te
 DuonN3qVQ63qijylAB2HCu4V0K03xt/ntcCZZ+t5mR1xKJEUPcJxZXObTAe0RMNo37yjsaHJb
 kov2E2f40GwGAdSsl81xVWkC6cqIjMkGxK8AWNwLtq7zt6w1IlKsHXjhGdxcMQKUGpvaQ+xTf
 J00ugxgW+tyt57wFmJ1fMVCyF9fykDbAZzboswZWAeOr6Lr5tuNUuiJzNNHS179bwociBUOwN
 NEknDwbgNSWDAu2VcHc5p7710h2r4Cxu2VsIJnPFkcYxOBiGc/oHEtyXnBSjzdEBVxCJvgVvR
 WscwdEQ15ARczlYyDKuU6A2vmtEzzT2HEjSx7bdeihGWyLmkXhIfD5Y4MFonvRttY5YuzVRUy
 ObBefQDiT4zKJmYJt58LBqlCMPiO2KZkip7m5OBeZsYsUTloZhQpzrtjMBfszzdyfq6eQyHax
 0f9WKHTCp0etbm8eRXXiLtWJVMnpR+jOaGuUwX8cBcAU4MRc94kcDI4Qq6LQmafm1qmjpL3yN
 mIEtIOukK0lPDmnp4KYPOU0nhrbar9TULlvtPx6K6D4NrtmLkGmcs8QkwRYBbv9S4EWvPjs+1
 NwBmP+oVIaOEIZNK5EI4RkmAhXHxwUCd+JIHW4W9lDa6rzSSM/aGQ4z1mO4ZWT5MswJ0AzulF
 Nb8PBMZmgNCCn9qrvMA6JANhILu9I91qnTAJvLim2wMK+GwojD/43df9AmCpkh5gmWcCC4FIP
 Es5qkJ6k3X7zRIP+Ub83veGPuN
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lana,

On Fri, 2 Sep 2022, Lana Deere wrote:

> I'm testing an upgrade to git 2.37.2 from the current version we're
> using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> gives me an error but 2.18.0 things all is fine:
>
> $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> Your configuration specifies to merge with the ref
> 'refs/heads/feature/switch-to-qt5'
> from the remote, but no such ref was fetched.

I bet this means that that `switch-to-qt5` branch was deleted on the
remote side, in which case...

> $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> From http://githost:7990/scm/dp/sw
>  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> Already up to date.

... Git would lie here and simply use the locally-cached version of the
last successfully-fetched `switch-to-qt5` branch.

To test this, you could pass the `--prune` option to `pull` (see
https://git-scm.com/docs/git-pull#Documentation/git-pull.txt---prune for
details), then try both pulls, and I bet _both_ will now fail.

Ciao,
Johannes

> Anyone have any ideas about this?  All I could find on google was a
> suggestion that the "no such ref" message indicates the remote branch
> was deleted, but that's not the case here.
>
>
> .. Lana (lana.deere@gmail.com)
>
