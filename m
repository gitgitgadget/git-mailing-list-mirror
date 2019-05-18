Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6583E1F4B6
	for <e@80x24.org>; Sat, 18 May 2019 11:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfERLlX (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 07:41:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53528 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERLlX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 07:41:23 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so15970348ita.3
        for <git@vger.kernel.org>; Sat, 18 May 2019 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+uIDnlELtfmqDLnR6M28Y10FVCQHweXuMlDDyf799I=;
        b=gWWUzucASvrxfDQJj/oVgG7og1qH4VUecK1axXgzD9SlXnk3x1SHWRWH4EZVhSuPNz
         b4e/XHoCUxM2fcqogOY/xdx9v/gwKv/duE2nWppPGKuMldqAaSVX8DQaAENnBxTw9r5o
         fxzV0bxn5Uq6TDadgAV/F4WDyzYye6djMmjgnJ75Xfi7UGzWZIkHyU+Ph5YVGk3WX8KA
         6dX8x2BCC3G1sc10FTShfqS721upBtgDK1zpiIimHOCOG3fVfrbW+9dgtBPC7SeRqLBY
         DDmJuMMgS/AjZoV/PnrTC083YCPYtK6KJ1MGz9I8vPl+ajzvKam1QKERS/Dshqs1TLd0
         QEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+uIDnlELtfmqDLnR6M28Y10FVCQHweXuMlDDyf799I=;
        b=nD5cqXSnM1hiItKZr8KtclKL8XxR62dBG0a8bLwJDyGjuPXGpFfWsUsHHCYWIGjVF0
         i77AUM9qJD7YVS1ejTG4RfK2ScErVfJgATcAQiFyQK+bZbTviv9d4YS4ayzBLuxc4OyJ
         mO54/5dB8plHErjB8QNq7v6On0lpRE0VTdnWPVFJth6sA6ulvlK2O+4Sh4CGbXjEhq9r
         u3HJfPKpAtgZATq29q+I5dN6rt+/kKzhmwP1zNd31s93QVxYwzXjyGADR76GnCIi9FZY
         bzJk/Nfd7Ka8dEKvdhyjfAeIIwkFd6W7xi5dzJpEFtWPfQK/ZBYQSUeX5o8+VIZLuld5
         w9mQ==
X-Gm-Message-State: APjAAAXiL7jBij6MrTWyVBakvUkDkER5riK80yoJzSqQ/CecDCO3s09A
        jtq0y287ZCrUaNg9Bs4CHJPRs/UZklGTYUpZQWfLLw==
X-Google-Smtp-Source: APXvYqwlYAfUDmlETcMShMjRAmcnaHovSxHjCo4KIYap51Y6cVBYUlZn5+4Q4n1SrXetcVRhjTx2UZmkm26qSG1S1Jo=
X-Received: by 2002:a02:ba85:: with SMTP id g5mr39719899jao.92.1558179682459;
 Sat, 18 May 2019 04:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190513175903.126079-1-bavison@riscosopen.org>
 <CACsJy8B589nOPNt6143BNQNojRYn4pyQCMNZKLRn+EGyWD4-mw@mail.gmail.com> <1376dce1-6ca1-88f2-97c9-c8dd2ac683a1@riscosopen.org>
In-Reply-To: <1376dce1-6ca1-88f2-97c9-c8dd2ac683a1@riscosopen.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 May 2019 18:40:55 +0700
Message-ID: <CACsJy8BypLygJGW67mtomL=VLQLVuPSsYTx-3+Dp_Zg-hkSVpA@mail.gmail.com>
Subject: Re: [PATCH] clone: add `--remote-submodules` flag
To:     Ben Avison <bavison@riscosopen.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 12:50 AM Ben Avison <bavison@riscosopen.org> wrote:
>
> On 16/05/2019 12:31, Duy Nguyen wrote:
> > On Tue, May 14, 2019 at 2:46 AM Ben Avison <bavison@riscosopen.org> wrote:
> >>
> >> When using `git clone --recurse-submodules` there was previously no way to
> >> pass a `--remote` switch to the implicit `git submodule update` command for
> >> any use case where you want the submodules to be checked out on their
> >> remote-tracking branch rather than with the SHA-1 recorded in the superproject.
> >
> > Are there any other submodule options that could be useful passing
> > from git-clone as well? What I'm getting at is, if there are multiple
> > of them, perhaps we need a different/generic approach than introducing
> > a bunch of --<something>-submodules. But of course if --remote is the
> > only useful one left, then it's moot.
>
> That's an interesting point. However, for many of the switches, it only
> makes sense to set them one way when you're calling `git submodule
> update` within `git clone --recurse-submodules`.
>
> ...
>
>
> In summary, the most significant omission is --remote IMHO, though there
> may be an argument for adding a small number of others.

Great! Thanks for checking.
-- 
Duy>>
