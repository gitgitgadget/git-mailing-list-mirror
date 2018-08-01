Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDF11F597
	for <e@80x24.org>; Wed,  1 Aug 2018 00:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbeHACAZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 22:00:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51318 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732840AbeHACAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 22:00:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so4953078wma.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIdaZ41wcgb0wauMi/vDJRzzpUoENLeS7pAFnXQwfGs=;
        b=nTetVKa6cASfFqGPlIgD4XQnM7CyyYr2aSqI5+EIQY/bMC2GrOXFrWw/AZfcznREKT
         h1kI5f3jI3XNPvI7Xca/0aiEQ/7sQ+H1BwH7Sn15aRprlgNTipQ1tBaO0QR7lQZkHaEj
         Xerg0Ug0lVdK4KvbrJO/nrThkko+0MPkwl5LpwnAVZSeKi0aSgEJJ4DCZZzzu/jcwrny
         2dq+yfbMpURZnQWblQUxFEuZ78cRCq5x3ZoR+IOsCV0OeUX0ys2UvKIzJzTJ0lAxCQVq
         RJcSVPLCoMny/AvJlRQLwYTmqy19O6QUNbmcoIN02L1gM3WDHcTNL077qN6khkP4m26a
         i4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIdaZ41wcgb0wauMi/vDJRzzpUoENLeS7pAFnXQwfGs=;
        b=p+wpzFZFKcCBZlyIt4m6uj+HaBCgbR5Qg0Gzx7KvnpH8lFe2a4nPStCgiKaxkD6etA
         U84lDtATiuT0Hb4KGU13Xmi3npy4M6nca3TIlL2Fs4EH+n3hIhZOZyyGodfCRGT8kUbA
         WjuPJqOnaEo4sJHd1N3jOeXdnIkq4V6+s2Th31MHYw9sL/yXC+IH5pAZHt2uzEc9sx1W
         xYSqbtI5mhP3M5az1k6j37PpXrhwSrC9BrgDcPB56Fc24a6USrLg+69lbhBI6G5N5hr9
         Ou4BbZWySnDSuheggk3LftQ+6Fw4HvVyH+Q9lx0oebnuYW+bjCNN8mWAA7XRYxqc/Ojo
         YKVQ==
X-Gm-Message-State: AOUpUlG+xMo18yS96dHEy4mZfAsHfkonH0MfTv/HX266Eu+ehtt/kjPs
        /KwmHQ+jAISRsXuwRMHJOxln/AbnrovbybDpIgQ=
X-Google-Smtp-Source: AAOMgpdF3NyMGMOBmK0jDOCZE74I/rnH8s94hIKw3R6eOwejRoK+OYLK/TACx2bHzm+L9W6sMRyckR+8xTmqSd2HqFA=
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr1074772wmc.107.1533082655965;
 Tue, 31 Jul 2018 17:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180708180104.17921-1-predatoramigo@gmail.com> <20180730162920.20318-1-predatoramigo@gmail.com>
In-Reply-To: <20180730162920.20318-1-predatoramigo@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Wed, 1 Aug 2018 06:02:25 +0545
Message-ID: <CAOZc8M_FJmMCEB1MkJrBRpLiFjy8OTEg_MxoNQTh5-brHxR-=A@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v5 0/3] rebase: rewrite rebase in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, dev+git@drbeat.li,
        pclouds@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

During recent development, I found out that `v5` has some issues and shouldn't
be merged into `next`. I implemented more options and ran a couple of regression
tests from which I figured out that certain choices I made in those commits
need to be reconsidered.

During recent development, my working branch `wip-rebase` has passing `t3400`
and for which I have made some changes to the code already in v5.

Cheers,
Pratik
