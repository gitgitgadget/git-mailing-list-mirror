Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C04C2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9262073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Er8fMaBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfLYMDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 07:03:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:50787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLYMDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 07:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577275389;
        bh=hceiF2/gpqcG/jo2mUNnkvjyJonl20Curil0uJQTJnU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Er8fMaBh29RX6YCugAW1LRfgXf6CLCL25zN4Ww4MUZAcBPtgc1PsPKG7lHXZh1ucP
         S7rHvrtbo9IQizcXIMbbHDWvi+iIUTVihsvyFDTmv9Ksee5x3Mi/q1yGAJG1mtR+Uw
         7X7xqhvb9ASiPFCCuvxinbWbHoctp62PmJlyn7nQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1itjse1wY9-00AFix; Wed, 25
 Dec 2019 13:03:09 +0100
Date:   Wed, 25 Dec 2019 13:02:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] built-in add -p: add support for the same config
 settings as the Perl version
In-Reply-To: <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912251259540.46@tvgsbejvaqbjf.bet>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com> <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y00x+BZl3stUs9KBInLmMfQE6olQZb3IbuFN/1qkFssYV7/bOPz
 wDVCCdyIqctpTE31GWs1GsmsDk4FRM1DROGE6eTbBuKGpGbZq+XdMaX2zvSP3comlTevK4t
 SyQqL4RDcbisORQFVaXk+GwUB8Te2SmkxBYCmeTLcaDy09vV7IkU2fyuMN2gMXG5aSnNA2O
 yOtGMrpO8HR2WQwPtiChQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/l8Sggn6NSQ=:3K1ZiQW/x37jKHjUxWOfnV
 ChtfmsKnty8ECbDVi1wT9oebPmdi9D3S74wd6vYGe5N5g3FnZChWr5kfjYlWawOvhXhZ1MU+O
 jeUu0kEQu8pl6ZMYDFPvjhJoxwVdo/L3Hl9//8Bubx7bFsAh/5V5qHP/gegz4PY+c49IYKSMz
 gca6TeuXvsoQcrIzCtsTLjLNuzXf/SPFTjquOFTbvrS77pYTXRzT64G1Py6zgXn9WgP7EJB9g
 uVL5is6U6ODLboR7bK/MkXLAHgiy4MkChsNL4rqgaD3iD+aj0v+tmG0GdkJsxDxFwXuta9AoD
 g2XGwjgrWxA0R02BdLlc4oqYXeyx7Wacl66TYJLFj0LS0REDfLRrQ5cRt6s38HGs9KbV55J7O
 AE4+qIOhwdywctxP9JW756euf6bha52uoC1fl/eY9/hH+pyYuyn0OSzc0+FN2SDiq4poKIK8U
 RpbPu25rKL6SjVcVKiQsHIAeeToeMcfzr0lNxHW15HoC8WXay07VR/w5XpyGMsCrPeO4OqQfU
 3CyKn3/6HH+txkCJFcLisszSv/JSEuUpmSIqQ+OGh5OWjfxpkZ7ZqYZlxUK8k7XEVK3Gyf1jT
 jvlGDZU2xtGBTxc7ir2mmMezHnzNuu9oRFrcFo6v9GXdVIXA5JvuCLO0xqgwVvat0oq2CdFJs
 WKeUcgXL85sCra9g1iAeHsus9ziKPau1yMN751KmoE11tzhzqys+55CFtjDolURc4Tfw9nGeZ
 VlRPrnEnuUuK39JHfGgf30zpdPGMIlFB+emw6WS0+PIaDeuuwEcQxd5u6UlRtAoteE3eczOyr
 hW8e6IxNq+zcYaQfg4ECphQx8ujHge7EigGOBsDHHuH2WMEpGiy3vFVozM2qMX8AyDSxoUqUc
 boObvydEmAHo3KCekDefBjybBtPqokYnFcvDx/aqppZNZo6+UEKDdXNeK9S23NQFuMWD04DEk
 yCsPuLk8hZ50SWIRszZZTAayDejr9GU3Pr0AGMB8cPeGvy9pT7r/mwOG/TucNDIZ98WuSFtUS
 IhHEm/junF8mptBUst2+oXyvLh0FzQ8RzgNI8jbHnGVnJm7p0iSYyR6O1mc+yBYx+Sjtj+1iT
 3erU/DL92MYa+R3jHWkiYrzAEs3M51cxL6cOCPnh2WNWKX/CRT0Vq0shr3zMrYkqAEV+wy0L2
 HelGN+bktRPk8TdZdYx4Jdr4nJPLyMjvetrLHuNYcpMl30maI9b11yjuamFJCAnl1THpLl/Fi
 tl5SaFcCA5/kgxEk1vfYKcygEoZnUmb4+zXIKws5zwq4eAk8enj1+npoFrRM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b
>
> It is not generally helpful to those who reads this list to use a
> commit that is not part of history leading to my 'pu' or 'next' as
> the base.

Right, but it _was_ part of `pu`. I based it directly on an earlier
version of `js/patch-mode-in-others-in-c`.

> I am guessing that it will build on top of the "use add -i/p from
> more commands" series, so I'll try to apply these on top there, but
> I wonder if it would help readers if we had some extra comments for
> human consumption next to "base-commit:" line (similar to the other
> stuff like Published-As added by GGG), perhaps in a format similar
> to the one we use to refer to random commits, e.g.
>
>     base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b
>     # commit --interactive: make it work with the built-in `add -i`, 201=
9-12-17
>
> perhaps?

This is actually the output of `git format-patch --base=3D...`. I agree th=
at
your suggestion makes sense, and just like you suggested in another recent
mail, it would probably make sense for `git format-patch` to learn that
trick and for GitGitGadget to simply be just one of the users.

Ciao,
Dscho
