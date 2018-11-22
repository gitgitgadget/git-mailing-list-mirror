Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B861F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438077AbeKWCp0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:45:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39158 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbeKWCpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:45:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so6863794lfh.6
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 08:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZT+iyyCbYUbNGBlMW0HJBfNIlOroIZWGh1HFO2mvgM=;
        b=K61ulZE/NKBNMeMIfEL0CZaLSYnlmjXBLKbaq+yrvGAc1i5yGANOfiFkJ7aaTLRQzb
         bsByhGeefk86z9ofXa9qthIFStd8rjzR7VSNX024D/g9CzdODETrvvl6BWhObGRe1xYR
         93E+wwtQa7j6REdcUfdpMPKHZoXhU7Xs55St8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZT+iyyCbYUbNGBlMW0HJBfNIlOroIZWGh1HFO2mvgM=;
        b=fxmHi24QsooaNg9yGf42n40/uZlSmLF6qnm6XU6qBfGkUDA3nYRTwBgaHNfaqhRv2J
         TeUvpXne2//ctAr/vifzbS8O6qDKU7VfRCph5s4zmgcfT6Bewksp0qu3wNUTKZsGZ6ya
         OCaL7+QxOVtazyxeqxMb+UH6J1b55G9DS0v+VxiDGpDhvRnqh8/Nrv4Wsf3MDo7NZfHU
         yJ8A1zcbkYmsA+AzEl8Iexb07vGb/xvl6NElIIgp9o0lF/EgEoWkHpisew7ChUs1EaX4
         NzHqohP4gVaocrfcD8FcCCAX5DXbgzM5A9NClEbZqRZvUgif6l1JtWjuk1gi3XR2WTNI
         +KRw==
X-Gm-Message-State: AGRZ1gLCkjlTTi+pQg01Aj3rhmfKbeIZro8vAov3OKO1xLeXiJlm7wXu
        USlevLApGnSZkgVHzP/cdgLvizclk1U=
X-Google-Smtp-Source: AJdET5evq+CTzz9xWEh6Uya0g+16H6g/yvZ5blYGp+Q7LNFmJanWg/zFutOFuUZSgcHHAmq1bkg9HA==
X-Received: by 2002:a19:2106:: with SMTP id h6mr6717327lfh.29.1542902724984;
        Thu, 22 Nov 2018 08:05:24 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id b69sm7359289lfl.28.2018.11.22.08.05.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:05:24 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id l10so6860120lfh.9
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 08:05:23 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr6460263lff.16.1542902723359;
 Thu, 22 Nov 2018 08:05:23 -0800 (PST)
MIME-Version: 1.0
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com> <1965413.u7ZHvrJggb@thunderbird>
 <xmqq8t1l6hve.fsf@gitster-ct.c.googlers.com> <2775489.rJSdpldxyu@thunderbird>
In-Reply-To: <2775489.rJSdpldxyu@thunderbird>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 08:05:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whO9=J-+4BuzV1WWVE1DRTceTRSeXTpXQjJtSz=NRmqrw@mail.gmail.com>
Message-ID: <CAHk-=whO9=J-+4BuzV1WWVE1DRTceTRSeXTpXQjJtSz=NRmqrw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
To:     ischis2@cox.net
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 6:08 PM Stephen P. Smith <ischis2@cox.net> wrote:
>
> Picking up someones stalled patch is one thing, picking up Linus' patch is in
> a different league.

No, I think it works the other way - my random patches are likely the
_least_ important ones, simply because I can carry them around in my
own tree anyway, and my workflows may be odd by most git standards.

If I'm the only user of the "human" date format, then Junio is
absolutely right to not move it to the main branch.

I have some other private patches in my tree that have been mentioned
on the list but that nobody else got excited about:

 - Add 'human' date mode

 - Make 'git gc --prune=now' mean 'prune after start of command'

 - ls-remote: add "--diff" option to show only refs that differ

none of which are in the least important, but that I find personally useful.

              Linus
