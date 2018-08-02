Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7A01F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbeHBT3z (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:29:55 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:41523 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbeHBT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:29:55 -0400
Received: by mail-yb0-f180.google.com with SMTP id s8-v6so1492301ybe.8
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=US31a/0T/+CDRGDg7vRG/He+RRcx5nyVNYZz5v7CuX8=;
        b=NqMq2d68XyulyUUbwXdmCz9TXmazu9WPDuJLpdcI2fNDrrR5/+KgxD8y7HSjO9UGTm
         /FMqOuQcw4jRxrCm2UnA3vX7iqV5ldLipKdvlYVfhjcNHnYtpO7CUZG2cok9RM1kNY4o
         VmDJN1GKNIo70KysUJdFV4js/fbRrRFnGW3J7vp6dSnxfrlARLGxMV58sKsoFGFulw+m
         yfXyXj4NRpKImHw7of53GCL67CRuHsuv55+LAIMlWdytpkodxLVC5KzguH4vIZqMzDbS
         Ny8aKg/LSdR/XxxkjsH83Y/CoYwWHxwf+pIi7JD0ht3Bhxg9qd0FxyarbPQ+OY/2rM7U
         TsRg==
X-Gm-Message-State: AOUpUlETS0OG7q10Xh85/PrnAS0OCrjdWz0RmegdXai/JsDpwoti6JIj
        6vFa8xhAi7lHc7/Kf1WRaZKbOUlb/jy5hRC+Ylg=
X-Google-Smtp-Source: AAOMgpdPcxTtPHL08jnZFBMd/1j6fUewOb1PbaWFHMKlwSVmUdhUi9RD3QluxAnrZEjz5trQveIWrwgWuWmIaqWbRd8=
X-Received: by 2002:a25:9d81:: with SMTP id v1-v6mr315690ybp.76.1533231467348;
 Thu, 02 Aug 2018 10:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-3-hanwen@google.com>
 <CAPig+cSbibJ7i8LwJqPe06xJObnq6dJdMUnJoC1uAg4zUQq3KA@mail.gmail.com>
 <xmqqeffi856n.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PXfp60C-aiizUURjcqr-A+VJQDjMJ+fU_5DOo10x+rcQ@mail.gmail.com>
 <xmqqsh3y6jfp.fsf@gitster-ct.c.googlers.com> <CAPig+cR3WdYpZftK72MKMs4BBF2ZiuO-Bm_-edJ4tr1bRQvoGQ@mail.gmail.com>
 <CAFQ2z_NOxB4E13hoUPwoP+kZ0rVofCf3mb+bdopyTLnzWu1kPA@mail.gmail.com>
In-Reply-To: <CAFQ2z_NOxB4E13hoUPwoP+kZ0rVofCf3mb+bdopyTLnzWu1kPA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Aug 2018 13:37:36 -0400
Message-ID: <CAPig+cS5Nwnau36t_G-PBgY_8aoQQT6b_TfQPeyLt0tFXSppeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Highlight keywords in remote sideband output.
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 7:46 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> Sure. My doubt is that it's hard to tell what the state of my patch is
> at any given time.

Understandable. Junio sends out a periodic "What's cooking" email
summarizing the state of patches sent to the list. The most recent one
is here [1].

A patch series may be annotated with "will merge to next" (meaning he
thinks it's stable and probably ready to expose to a wider audience),
"waiting for review" (meaning not enough people have shown interest to
look it over), "waiting for a re-roll" (meaning he expects a new
version). Other annotations are possible. If a patch series isn't
annotated, it means he hasn't made any decision about it yet.

Also, if your patch series is not in "What's cooking", it may mean
that Junio just hasn't gotten around to your submission yet, and there
is a good chance it will be in the following "What's cooking". If,
however, a couple weeks or more elapse and your submission doesn't
show up, then it may have gotten lost in the noise, in which case it's
a good idea to send a "ping" as a reminder.

[1]: https://public-inbox.org/git/xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com/
