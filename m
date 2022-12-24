Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D8C4167B
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 21:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiLXVLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 16:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXVLb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 16:11:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69EC2185
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 13:11:30 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 83so7669922yba.11
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 13:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9EJgxhkasDhJjAvr9oQUwVEDkJuRBetCl7TksUNTaw=;
        b=njwN2PRIwqCb8+HTX6f88AcsZhQQA1R+zEo/Jt8ULRoFHjAwb/GbPhNTp8c4bm9OJ9
         oFnZnBVyVhXfPlIwv0sy1tSNCTm8RnYaFycvQPEQMd1ytLxTPtAxPaA0LAK5UOMX1wzU
         pXwS5CCeMW9JoAaaO7ulRPWZRagVqFcorncPhB9C82RAPvOtIbKrpRUHg8vaXyDl/K9N
         /+4A5JJskQdq1ReA9dr86Deo3jttFMuSRJE/aFHlo7/LQwcTskGHnVxIvWk+hONsGvpQ
         vsp/gp29XiEPL3SOonKwDivsYViM6YprqkIIjGJ0maFiY4zdEEEiSK/03zm6utskjslM
         gb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9EJgxhkasDhJjAvr9oQUwVEDkJuRBetCl7TksUNTaw=;
        b=cuSr3dhXmQ4kphwIeemieUqN8eloYI8bPNpU0rUgd9LwJQrIlOaplCHOId1ibBs1Rm
         fKpsSmGw4tQwKgzAtLNp7KkhAfpCKHRdm0Rk9ybCfaOOCY2eRDJe4EWQ770uW00x6UXe
         2VvNNTX4tNG5OmasWdyX5leA9CoOkUpgawHE0RJjXbDheYPysS6LcF6mNag7tOJpjS0T
         GnDpvW/n+JXKv4T5jhcJDloUgNc81Grb0aYGWM0HzvGGyW01y7PHQYIqGr8IVxeeVFYN
         QQOB+/lFqA+IwaA2AU/3WjLgk9/o7bv2T6RBmqY6+nLj/92YFbeMzf3roExxuS3PgNkq
         6i1A==
X-Gm-Message-State: AFqh2koaZkb23uVCNvHB1MYp5hix64IR3bys+W6pIS2h37aU4ByQrB2V
        q2ymNB6FLWZ+Qa05Lw9swiY+azo2arBXsJuMZ97Bgb5/VDJKkw==
X-Google-Smtp-Source: AMrXdXvAvcXcI1rA73Da6e1N7JtpTIgs27GUYUIjElpVDrQV6VbYqOWo/dC3SaJMhtA/xrf1YFHXf6ORctIhPGmEDXM=
X-Received: by 2002:a25:c010:0:b0:6f1:8895:e769 with SMTP id
 c16-20020a25c010000000b006f18895e769mr1473630ybf.390.1671916289950; Sat, 24
 Dec 2022 13:11:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+PPyiHtPsRwqMmr6annuuqzeUEf+7pFUSbnXdThjNNVtxFCGw@mail.gmail.com>
 <20221222192646.GF3411@szeder.dev>
In-Reply-To: <20221222192646.GF3411@szeder.dev>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sat, 24 Dec 2022 16:11:18 -0500
Message-ID: <CA+PPyiHtSrLwandGcjWxzZzfuwaxX_Cpa0h40HCLBekH1vSK7g@mail.gmail.com>
Subject: Re: GitHub actions are failing
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This should be fixed in 0178420b9c (github-actions: run gcc-8 on
> ubuntu-20.04 image, 2022-11-25), which is in v2.39.0-rc1, but your
> branch is based on v2.39.0-rc0.  I would suggest to rebase your branch
> on top of v2.39.0, because it contains a few other CI fixes that are
> not yet present in any of its prereleases.

Thanks for the advice, how can I do this?


On Thu, Dec 22, 2022 at 2:26 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Dec 22, 2022 at 08:55:43PM +0300, NSENGIYUMVA WILBERFORCE wrote:
> > Hi
> > So I have been working in the signature atom patches. I have been
> > testing my commits on my fork. However, the actions are failing.
> > One of the errors is
> >
> > -------------
> > E: Package 'gcc-8' has no installation candidate
> > + end_group
> > + test -n ''
> > + return 0
> > Error: Process completed with exit code 100.
> > -------------
> >
> > I would like to have any help, my branch is
> > https://github.com/nsengiyumva-wilberforce/git/commits/signature5
>
> This should be fixed in 0178420b9c (github-actions: run gcc-8 on
> ubuntu-20.04 image, 2022-11-25), which is in v2.39.0-rc1, but your
> branch is based on v2.39.0-rc0.  I would suggest to rebase your branch
> on top of v2.39.0, because it contains a few other CI fixes that are
> not yet present in any of its prereleases.
>
