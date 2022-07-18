Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5D2C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 23:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiGRX0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiGRX0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 19:26:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC831213
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 16:26:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bf13so11963086pgb.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4P2sOjX+hfE8GYM/LOxAi0bFvI5IGNBp83yb/esfkY4=;
        b=A+X4Gx5yPzdZPIH3Nqx6IvnAhcyhxkvVGAlii06w0t2Q9R1eVWOQQ1RCW6AHjRakvF
         WD8pnPHdC1F2hbu6wIOQldGW4uQgiC8ATRWgvgrrZNpaEGkcKoherV/ffAQQEt3/Up8V
         Eve+urk6xphrQg4yutLWyvHQ41V/pfs7ZbudjWaVDpbS3ly4NazCZIVlIJsPguBzKRcG
         zfeB9u3EUDQBwkyuYno71C/AppRKZ1i3YvcNOeISVIdY4ef+4+XheJXMepE2v8R+KHXJ
         E6O/EJ0ebnn0mohZfMdjNU3f9F4C/arkYSj4B7N8kmSPpjFcc8/rYLGPnEP0DBvsQyZ4
         WSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4P2sOjX+hfE8GYM/LOxAi0bFvI5IGNBp83yb/esfkY4=;
        b=F2Ws/iPU50ZniVziFfSKqvPqir++8ATlwnYxFP/zpe5Zz56OT4eZzJ4p38GylNmcH+
         i1HHj3BqXsn53K/8I514mSXhRmgLh/k1M77mL4YPG2TEY3hKQLoQYZ5b13A8VAvD4xoN
         lNwVgVILUitYQtMhurMjPtnvfEKD/ZHznrpKuzF0wNwEAMwZXs7IjQMIfv2WlI1JyqOd
         P7tzDSF8XCPV5fq/xNTyIvigGHSvjC7Qn69Ra6odjESWSCK66NpQBaWaxl4A8fDn9D34
         aRsQrgq5xLrM/UZgICQMq/YSNYTDRbfAszRuP7tJBgIFUSrl0FDFlyTQ6v07WT02H1HK
         INmA==
X-Gm-Message-State: AJIora/NWcgFH8s3G3qWsnWV41UWIqg3qJgflc9RecyCawdkHSOG9gRW
        wK4Abxhbpw6twBUB34dAUG+Rvt+nuZCGwJ+2vjfjZwBtJBw=
X-Google-Smtp-Source: AGRyM1tS6nLgTAhh2k1Iba0bEBV7do0UA0ZSy5vdHaJWQYDG/8jygUMDbJDi+YGcuI1waGbmn7lOP7qIE+ItPRkhmVQ=
X-Received: by 2002:a05:6a00:1496:b0:52a:c3fb:8ec7 with SMTP id
 v22-20020a056a00149600b0052ac3fb8ec7mr30390406pfu.25.1658186774034; Mon, 18
 Jul 2022 16:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
 <YtDVDu7VKgAcvRse@nand.local> <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
 <YtHoJ90N6rmDmn6M@nand.local> <CAN0heSoA=wv4syJ3VOe92QPpjPHyqUPJ8+Pv+mbB0-TiiieVmw@mail.gmail.com>
 <CAPOJW5zEJJwx+1_4MrpwPVnpV=i_82obO-uqAcYJGJDS6y=31w@mail.gmail.com>
In-Reply-To: <CAPOJW5zEJJwx+1_4MrpwPVnpV=i_82obO-uqAcYJGJDS6y=31w@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 19 Jul 2022 01:26:02 +0200
Message-ID: <CAN0heSo-uo10XN-3c0jYpULQW+h2ykS=Pp2Xv4=cOrXnnyzYNA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table extension
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Jul 2022 at 21:26, Abhradeep Chakraborty
<chakrabortyabhradeep79@gmail.com> wrote:
>
> On Mon, Jul 18, 2022 at 2:37 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> >
> > Would it make sense to let the `const void *key` directly carry the
> > 32-bit value and hope that `sizeof(key) >=3D sizeof(uint32_t)`? That's
> > probably too magical, "just" to save on dereferencing.
>
> I do not have any particular opinion here. I will do whatever you think i=
s best.

To be honest, I think it would be better not to do that. I floated it as
a random idea, but it's somewhere in the vicinity of undefined behavior,
and in any case, it might be a bit too tricky. If we're doing a byteswap
anyway (on virtually all platforms) and doing a bunch of comparisons,
trying to save on a dereference doesn't seem worth the increased "huh"
factor.

Martin
