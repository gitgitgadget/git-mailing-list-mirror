Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC419C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6393964E09
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 10:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCQKXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCQKXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 06:23:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69E3C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 03:23:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ci14so1680793ejc.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=duel.me; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=3J/Yo98J/EVhgvjyvMcCvFkCFjDggNsFYUCanVfNaco=;
        b=MX6FFe5I/Pw46ZFipzHigCVtRHLE8kitWhMidt4WErlMIhEE7pnZQ+0kHEvOSGzsy3
         pE8SaU+pIKLTCTMiSqMJBmjz8Ok0iURV+qQ+vQ9LpmABZyGiUVgtLm6U6f4QaPPVdxIP
         1N8JPRr6n95ZnZySRCwc6fDweA0ags5IyeE6rJRiZnnhaD64g0byxJxNnTx0PWqN21bq
         0GDxujgULkeLKH+gsCsR9NKv9AQ1oN6ts8pkSjiSQzXXjQzOIJhi/R/o6Hek+b84TQQt
         zyU2fB53F0olTgYkcy6W5Abs0QMYQe/r3kJNMR9pUAkleVqtT/3nsRzLywxaSm2IcrIP
         8cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3J/Yo98J/EVhgvjyvMcCvFkCFjDggNsFYUCanVfNaco=;
        b=CVqsLlSt9Ky0HzcJ+YC86iez++iYjHAG2W0kgRAf+oIH3WhU0Pa/7DCNBP+SHKbVOE
         C4a4TvEhhqXacOEUOcc/tn6Zt4HOef3ruZ2kyjiLSNkQgpeFj7Qq1QWjsXpA0m0imBBc
         Uh9+xT0zRERLlGaUfX5cp40F4n9n+/w9Z6sutsjXjeFip+f5Jg2Y0T1fbnGquDs7Ny65
         18u+608zydoJ4dh9GXQtlW5p4aB2Z1uieICWynKnOV/W9Ri4itbhOyLZFUEAyIzm4S7a
         godNJtfiXuNAw7WAByqt+Ia0FSxm98FN0/njBYlYsd93XerX+DZPK9iI1ZoyTIAj+kqj
         A0Dw==
X-Gm-Message-State: AOAM531E4rM7nqrPbXC0ZFoa3DY1szPoQ9CWboK2gSARTxVGFI+jHKoZ
        gIocS/dPSf7AyV+SUlr16kNXqF0W92tdlIdYJN1tUxqygdqksg==
X-Google-Smtp-Source: ABdhPJxHv6HUozI0t9mn0dZkupljDyhPBhBiN6ZPuK6y3Li11BHVYw81WTuqopzDtCNfH1EBwDKmzjqs0ANgomLPJm0=
X-Received: by 2002:a17:906:4150:: with SMTP id l16mr34874872ejk.90.1615976580522;
 Wed, 17 Mar 2021 03:23:00 -0700 (PDT)
MIME-Version: 1.0
From:   Pete Boere <pete@duel.me>
Date:   Wed, 17 Mar 2021 10:22:50 +0000
Message-ID: <CAF8W_bFzE8strSWc0_eABdyfCxA+0CA6ph_uXgSyT7YRU-jO6A@mail.gmail.com>
Subject: Re: Extra blank lines in "git status" output have been reduced
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the release of v2.23 I have noticed from the commit:
7b098429355bb3271f9ffdf73b97f2ef82794fea

With message:
"Extra blank lines in "git status" output have been reduced."

https://git.furworks.de/opensourcemirror/git/commit/7b098429355bb3271f9ffdf73b97f2ef82794fea

Is there any chance of adding them back? The changed layout has been
throwing me off ever since upgrading.

Thanks
Pete Boere
