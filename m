Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B39AC433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D8660EDF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhJXRaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhJXRaT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:30:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41545C061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:27:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gn3so6540910pjb.0
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lBQqhCB8OphxQ/NtgsmL3/Ej3IUJRs0XVHGVfQ3EEd4=;
        b=dTFxlApOOC1GL2oA8fHTi4UfY0vYP8Ve5F4jHfy5o0vc/3aCMBLD3Nq8RRQ7rU/9zQ
         snlNFS0jEMlrXRUA3Z3aDlowCHTr+Omhrs0rgMI7Nvd+Xx1YwY5pgTE0QRHojk/GCgek
         S+b5IwLHmaSI0iMCm9WbTCwZUrfFXEUajUwq2IUibxvPOkoeNS0rRg70Q2xbht43+DUY
         /i0Oy1ZnYsk8gB8YpxL3lHH6uqjopw1Fxy79RCIyg4ede2ZMt5siGKDtEaPyteIrgtIS
         +S1ocR0uB6APryflaKWsjoTJl5cJf/aDX+XrzX/8LWj1MvBOOA5wrmEwxIOYhO8HqpFx
         SkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBQqhCB8OphxQ/NtgsmL3/Ej3IUJRs0XVHGVfQ3EEd4=;
        b=52Q+Vdd9ImelzdAgCKYOfEZaNpHZdqlrOxxkN5s+8AD8Vsy1o/KJoZRr8NhUs+pD1h
         yLbIjb/oDBzRdYfbODdiNmpwHE2PX4PTW4EvXMVU4mm0wDmIHoPa8kX45wpszJnut3nf
         vSBMXdN62GODHLBxWs1jkbk7e6+hW2xvUxTRDPkFrbzbpF/8YxcJPlEtziH3bXEgOHta
         rA98zQnE+NIwVbXbJ6o8TGvUHjijaDJ76Z1/j0VtReCBgfjW3E97YqSunDX8mh9MbHmD
         ZuPmMdpc3UN112ZngrGPYPG6WK4qLVdMZ1+hvfI6aglS4OO2//2OXyW2bFWMMJ0Q1B1R
         OEIQ==
X-Gm-Message-State: AOAM530eeQn7jz1I4FEBDwZSypt83l/wWI7vzQYbPbbddeiJQJZgYije
        ZLJWV5AOOR1X4m6k0Xn8rnl66MLSlCebhye8+Mr3oxgSy/pJyQ==
X-Google-Smtp-Source: ABdhPJzVTQbZmZqyUk2wrLS8jLoUI+rXT/Lhg9zip8NcUOg/4V4k/VeLdV8aol5VkWSacClzTjvoSb5cX1quWHAOybw=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr6574819pjb.90.1635096477721;
 Sun, 24 Oct 2021 10:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211024170730.3428123-1-szeder.dev@gmail.com>
In-Reply-To: <20211024170730.3428123-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 24 Oct 2021 19:27:43 +0200
Message-ID: <CAN0heSr9atBArKnXyoJ8H0fHFaU3-+Zw9ueNsS0S2wwT+Fe7DA@mail.gmail.com>
Subject: Re: [PATCH] command-list.txt: remove 'sparse-index' from main help
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Oct 2021 at 19:08, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>
> Ever since 'git sparse-checkout' was introduced [1] it is included in
> 'git --help' in the section "work on the current change" along with
> the commands 'add', 'mv', 'restore', and 'rm'.  It clearly doesn't
> belong to that group, moreover it can't be considered such a common
> command to belong to 'git --help' in the first place, so remove it
> from there.

I actually spotted this in `git --help` just the other day and reacted
along the same line. So for what it's worth, this patch makes sense to
me.

Incidentally, this drops quite some indentation in `git --help` (because
"sparse-checkout" is by far the longest subcommand listed there). After
this patch, we're back within 80 columns again.

Martin
