Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69E520248
	for <e@80x24.org>; Sun,  3 Mar 2019 15:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCCPAp (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 10:00:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39315 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCCPAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 10:00:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so2730987wrw.6
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 07:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pm4IrfMNrP5cQux3IUJxKj9wi+h9Emxpqo2cL1UJiZA=;
        b=EPedyJ/10u1dlJSL9xdJ2eqCOa6qo76zIwmGwpWh7T1puRqTlZrgfLJRw4hLb9VnQG
         ph7+apJCxLyszWml2xiGeocdbOMWkg9Gs1nAXl0OFsU9MiBAdq0mcqz9vgTho8CIThq/
         u3+oA5jyvaLDlVxRRq5ASDunYr/AhcCodhf1Iwre6VileWznFploY8B76h5x/KytBS8R
         lOJcBubD9Q+tjXKJC1YU3W0oESpoefSC5/CAq6naRZxKPvkiEJ40Yb3UQxaoorylsAU6
         TZPrq/2LTcdEbWkSmt+9cYVZTCa+5qyC0cPg8Jfuezb9XTMCFNWme/2y0flWdMLF8sp7
         TX5Q==
X-Gm-Message-State: APjAAAWgX132Igw7k1hYMfBLpeTdjZyJlPtaY2X4iG4hshGeBWFc/NWT
        xvl0Ee1gChiU5hVIO7HC0HV18Mv4t9KDDWV7JrY=
X-Google-Smtp-Source: APXvYqx0a6m9To5NCPCxOETz+KSOxts4Sb+vspM7/ZeHvpR0JK4+22JtcFFNNABRaAVpqlWqVDLansJ+iaqVXKsLbNI=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr10033135wrg.88.1551625243472;
 Sun, 03 Mar 2019 07:00:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.155.git.gitgitgadget@gmail.com> <pull.155.v2.git.gitgitgadget@gmail.com>
 <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
In-Reply-To: <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Mar 2019 10:00:32 -0500
Message-ID: <CAPig+cS1URdnRb0RM0HYQhtmXWn5knx6Ee1Y96Gc9dt_9LmRKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests: introduce --stress-jobs=<N>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 9:45 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Let's introduce a separate option for that, whose name makes it more
> obvious what it is about, and let --stress=<N> error out with a helpful
> suggestion about the two options tha could possibly have been meant.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/README b/t/README
> @@ -187,11 +187,10 @@ appropriately before running "make".
>         variable to "1" or "0", respectively.
>
>  --stress::
> ---stress=<N>::

Shouldn't the "--stress=<N>" line be removed?

>         Run the test script repeatedly in multiple parallel jobs until
>         one of them fails.  Useful for reproducing rare failures in
>         flaky tests.  The number of parallel jobs is, in order of
> -       precedence: <N>, or the value of the GIT_TEST_STRESS_LOAD
> +       precedence: the value of the GIT_TEST_STRESS_LOAD
>         environment variable, or twice the number of available
>         processors (as shown by the 'getconf' utility), or 8.
