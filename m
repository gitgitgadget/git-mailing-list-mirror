Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B3B2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 22:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdJ1Wra (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 18:47:30 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:47753 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdJ1Wra (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 18:47:30 -0400
Received: by mail-wm0-f49.google.com with SMTP id r196so9146259wmf.2
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=inLrWCdEcITX4QpMKJMo8JzIq67FCVNbU4u/t9+NE/I=;
        b=ib6+jphnaNDyT1JoVVc9YXWrRGVe1t1KOMyMtBGEjVkFpomR2VBe+JE9RsosOIzplq
         TD+UyIZ2pfnx1r5L1syjhUQYTlyfNpO6y8U3Ay5z1jJkWB6J4MdbiADAzaClylmrLLiy
         Iz8FILunfkJwZc9cQYtIYsZG5M3WZ6QjV3oCYzomjMvvJDzJEJ5Z0GHrtGvQ55LUKfG2
         5jF085tMiCMAP5jPYMPk6Vv0AWxSMBzX7/Jgl/gbRXX27jmR8gZYHFBbcesb3G234TAU
         Lumd7qZWEYyTeROfdtCwbJVW/DsDWKC8IAhzhl5MDkJ+uW7f1M9G0lR2ytnKv77/qRBd
         v6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=inLrWCdEcITX4QpMKJMo8JzIq67FCVNbU4u/t9+NE/I=;
        b=AE5R82QlREcClxQkYPgeF5ywqPPlz3wS4ANmIRpiAihGhFZ9ZiOKSc3n8MTjax3/2d
         wzzHd9bVD0NpMW5jc6CA6wJvzOU2fsZSga2de3OjnG8CfVjeSXi01XrEB2SBMO3n+TEQ
         GDYP9Y9qmFie35ZL/6oQ6/H2CgVJsbhODqmzlVbQ67pM4HhVr3+MviL04ERZB6HiyJuC
         HL4bUR6axoQJX9miiWXN+lLLri+ukcRBGHYMOYEWqXh1PgpXMArERanRI5RdBk348OAy
         PR0fGeGvdvT+PIXh6wgMoyo+tItu07nmU2l8f02/2Tjsn8Gy0cZPoCg2hsYed5bIawXR
         i0uQ==
X-Gm-Message-State: AMCzsaXVMapnE5VeuSc9YtsdwLXzBXRDjyUbVonbMqxzjP1jQr3GY8Dk
        tzk6xBa6McircT8PgfvCb5qUJZjBEMT+WEIqnqA=
X-Google-Smtp-Source: ABhQp+QMJHq5aQbtiiaXigAl3ZFiNosXI/j1VOf7tYi/akq9VvMofYJbieQL7HEWaGouBhXCTdYZY/9c5m3M6liNFv4=
X-Received: by 10.80.182.210 with SMTP id f18mr6069862ede.104.1509230848765;
 Sat, 28 Oct 2017 15:47:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Sat, 28 Oct 2017 15:47:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com>
 <20171028004506.10253-3-sbeller@google.com> <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 28 Oct 2017 15:47:08 -0700
Message-ID: <CA+P7+xrtJrN8t=TWMuKCq3OC_YJJkkO66QkerAja=hCp6Vh8sA@mail.gmail.com>
Subject: Re: [PATCH 3/3] builtin/describe: describe blobs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 10:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
>
> Nicely done, sir!
>
> I wonder whether it would make sense to extend this to tree objects while
> we are at it, but maybe that's an easy up-for-grabs.
>
> Thank you very much!
> Dscho

I'd very much like the same ability for trees and gitlinks as well!
But it does seem it might be fairly easy.

Thanks,
Jake
