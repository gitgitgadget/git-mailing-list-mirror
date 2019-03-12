Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532F520248
	for <e@80x24.org>; Tue, 12 Mar 2019 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfCLKLw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 06:11:52 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34308 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLKLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 06:11:52 -0400
Received: by mail-io1-f43.google.com with SMTP id n11so1605290ioh.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gViPfLlwQLcS8oOyXIMuMc97cGmWGgWTizO11pUJY2M=;
        b=PPd0ihRf0lJqgfTMgaA1eQyy2IoN+AA+5YQvgIRjR88sTtgPhrcIF7ZcZNKksiTXFD
         xug3uSV+wmr8nELPJSvmPf74PBEntVqEzUboQ/NY+1H+ZHLp0835n0aSsWZt5mIcffSs
         vH6dlgKaksXN4sEhtr5jG8VusmVooeG4GXOGFh75xkA8bq6a8P5zoKvHTI4p0pBP5Icn
         p8I/0PfPgeCrVRdAvncVgdHSHC+moXAvbWc0kqD3w4P7MSNguf0d9MVN7slqnnnzpLwm
         2YxMmBvyQv9J4Bjvrh1oWV+hE+/WbNY4HR96rmCSyAeSmyZpGZUSYAoYzyf40qX/mdbR
         Xf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gViPfLlwQLcS8oOyXIMuMc97cGmWGgWTizO11pUJY2M=;
        b=e1uhwvlQB2iNlE8HxG0ph6PMFLP4fjHWQHqNWZrXseKhuRgWbf16sF0WavFcLLTJHN
         FzP/HV+8yXMu6WyYfF0ODdBB3P+uGAZHkjYo6gdneW0QK2rRpbNhFnZO+ACKcYGKnFbp
         lF5vSmvKOBKeukFZG8NG710/AGtYTnhWGkmO4XjOK7dQJEiQAO9B/or9F2daWMrDR6wI
         N/gwbbuw0vvvM4i+DP3Nkt12ZyTWoXQ4Ykf1HM+ywdTVAm1vd8CkD5ZKEHRVkLjIXL9g
         SdYHaWn/De0SOtcd6EewteIuigdzP8vDynFShZwskrEC89RGhXHCHa5eqcZIgol+CGqa
         wI5Q==
X-Gm-Message-State: APjAAAXw1nyeJRnPKN+kfmylV1V7Y7vqYyq4GuDkdci9degSnzq06wuq
        YqUhyRBQl7KRCBIJEBK7UbdYKVgoobU7+t35ttxCGw==
X-Google-Smtp-Source: APXvYqyhPuqvaf9WWZoZ2y3XeTCVy96HweUf1Q9/uttkDsdVcM2ZTY7Wyh/HjhKUKqpMCHwIKG1PObxNW77zLju/NAM=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr16502082ioo.236.1552385511230;
 Tue, 12 Mar 2019 03:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CACsJy8ATKdcDdbTzCdZFhChKEAWhjuYQJBpGXZ9HAVXK1r2pFw@mail.gmail.com>
 <20190305045140.GH19800@sigill.intra.peff.net> <CACsJy8D-eQUGFsu4_cB9FE6gAo2d68EF_x2ze3YLXKAxYJfhSQ@mail.gmail.com>
 <CAHd-oW4LsyZOgHYgKaACX8AtzbA8pBpFUPWSF3GF6XxA_HKfjA@mail.gmail.com>
 <CACsJy8Bit46VatYZNB-ZsMBL043_GYDLqZ3fAZ8HzXZ9Kv1Z0g@mail.gmail.com>
 <CAHd-oW4e6CtcaKXbowqZM-pDAEGJxupHwBvFk2veaaYswt0hmQ@mail.gmail.com> <20190312100237.GA20471@ash>
In-Reply-To: <20190312100237.GA20471@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Mar 2019 17:11:24 +0700
Message-ID: <CACsJy8C=1dj-1T=5dt92LK5_Ario_YL2hkQWpi2dkhXyYY=_Hw@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 5:02 PM Duy Nguyen <pclouds@gmail.com> wrote:
> We have to analyze case by case. It may turn out that there are many

s/are/aren't/

> opportunity to utilize multi threads. I think checkout is definitely a
> good candidate. For "git diff" and "git log" maybe you can try "perf"
> to see how much workload is locked in pack access (mostly inflation,
> because it's easier to spot from the profile report)
-- 
Duy
