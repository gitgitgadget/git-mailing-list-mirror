Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2B7203F3
	for <e@80x24.org>; Tue, 25 Jul 2017 03:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbdGYDjz (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 23:39:55 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36947 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdGYDjx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 23:39:53 -0400
Received: by mail-wm0-f47.google.com with SMTP id c184so45850320wmd.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+XCED3xOIcT2YOkXcmLWdlzrx78aOS9QTMD7c2Ccj8Q=;
        b=lH3gxVDcSEQsdFe/JLUHvkH4+D99w2NOvI2em1MZ1DDgBmxGuTfn1suqu+xVQP9M1S
         +crALNW8YCksx5HYFZTbcn0OA4A3DFuST/r6I2VLV4z+MAGNoPtU8LaOAY+WybB/oIpP
         /Ao8S8nSr5xi3Tmug46S6RRs6wPnMnlEkS5PYtFqK+xYa8HMIfPiDcIHTTbF/coORkjk
         9A3ZAykk/sbLBvfXvtcAJTRfub5dNklTfNCgt93gzbfs5W38Fn4fICKe6n3bFWW+dLn3
         ttdkZDoTcjoJl/ECDKR/d5jgqnN4/1tjpTLQi66/lqbYk5X8cQRKQG+qsai2S8mE73wJ
         MLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+XCED3xOIcT2YOkXcmLWdlzrx78aOS9QTMD7c2Ccj8Q=;
        b=kfVmxWhyNOqSnyOz9jB2HzJQcr+r8iquksakwZWC27rI2MD4EGxq8GRCHN4RsRxu8X
         7bxRbJc8NKjOj1g0lHOLAd/CSAXP+2CyxjOkGhFnLzdJrD2ZMgwFlkAyndwT52fQ1IPG
         A3BjnQOdlr8gvjds91mkswdxszOWdq+nk6kggG5O6+SXx83NE8G5sKeiFYqI1XkMYLZ4
         vffXuWv+OQW9QO30lGDlTLOf5XSsHJuQRp0w15JoP4BBct8u3JNqmdUufydEQA8Sri8P
         leLKAeTpcNbWK7Qxzv+3yZCQJp3G8+FW6/JY/Br8PWkBrUx8lQ66Ycgo28FyR2UvdloQ
         Rsow==
X-Gm-Message-State: AIVw112owar++48p6Ud3WIWmFgNJyy3CEw2RphNgZh2Viqs135atqDjM
        RGt1TRY+UfR4N0g/1UUbH7rqybdO2TNJsfA=
X-Received: by 10.28.54.202 with SMTP id y71mr6659115wmh.106.1500953992383;
 Mon, 24 Jul 2017 20:39:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.148.75 with HTTP; Mon, 24 Jul 2017 20:39:51 -0700 (PDT)
In-Reply-To: <CAGHpTB+ADy+TgCtr37m6QniOQ0p96=2LMzesaGQkAwycnoawHw@mail.gmail.com>
References: <CAGHpTBLzN2g_ZXP4G6Eo5yZrvK_bB8KjBiSZ-Nc5JHNTRzv8qA@mail.gmail.com>
 <20170724091319.6818819d@twelve2.svl.corp.google.com> <CAGHpTB+ADy+TgCtr37m6QniOQ0p96=2LMzesaGQkAwycnoawHw@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 24 Jul 2017 20:39:51 -0700
Message-ID: <CAGf8dgLqgdyf3wTLC+odZsK4gZyENb68YvLk_4og_co1nox3wA@mail.gmail.com>
Subject: Re: fetch-any-blob / ref-in-want proposal
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 12:38 PM, Orgad Shaneh <orgads@gmail.com> wrote:
> Sorry, I thought it's the same thing. I mean ref-in-want[1]. This
> issue in gerrit[2] was closed, claiming that ref-in-want will solve
> it. I just want to know if this is likely to be merged soon enough (I
> consider several months "soon enough"), or should I look for other
> solutions.
>
> - Orgad
>
> [1] https://public-inbox.org/git/cover.1485381677.git.jonathantanmy@google.com/
> [2] https://bugs.chromium.org/p/gerrit/issues/detail?id=175#c24

Right now, we have been working on other things - so it is unlikely
that it will be merged soon enough.
