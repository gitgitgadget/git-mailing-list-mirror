Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EBD1F4B9
	for <e@80x24.org>; Mon,  2 Sep 2019 19:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfIBTtP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:49:15 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:37418 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfIBTtP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:49:15 -0400
Received: by mail-lj1-f180.google.com with SMTP id t14so13845580lji.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPt5lsEaf6zu8o1LduV5T6cVk7sc2GF6ZNQqvIgvKaU=;
        b=klUul5VIUO62vnicd1zbFa54/PS4begG/QMXk19z1xsHGWYyPydeMx3WmdoYJf8lLv
         MXpf6H+ie+2hhsGq1Imdd7xAhtfojJkC6ZVxN3kusRu6p5flIe6NG7c3ROGGGj/usNZN
         V2kuvjq5xTLernGijb12+Tnhkr112Z95ZZnMCGGR++4ILdlXHoviuH9CKEEOQxLe728q
         KdlweOF+jq5DxrrfSX6D76OrkMgFfS5vv9FpMuD/WNtCH61qI+cE1iilgzwcOoLgmE2S
         7lmUziJGYE1T0GnYWZHFkc/3juZox89Ncz7WrJ4Au0SpuxDY1OfsKv7+cOQ49uEEFFsP
         ASWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPt5lsEaf6zu8o1LduV5T6cVk7sc2GF6ZNQqvIgvKaU=;
        b=kwpGJXx/qV0fCfZ39SPbhoHVo/ZUoZ7eWZ+ryxJYxhlAioJbTLZaUAi9k1KSIsk+WC
         i2mXKRgNdNY+R3K+RsxHrLn7QxvD711QDB8HvazdPbpL8QtxpWFjdeAZ0TUYFzGAqijL
         2am1R8qaGlz1vcAFMH7deskhOdVZ6AVKDsKHWnBsYLVB6vvJ4vyK3gbZ6uTlQA7P3Gvx
         G0tMDHPQYV5zwjR2FW2ThJnlb1VIr/XfYMoHDmo8OKrC+GsJcoH4sa0etOdZl4T1hD6o
         sI3YErprC1r24EaAzlyfH+YWnJXwV2I2GGBxRL6crwhTPnvc7VhSfaVS4QJTXw3hjyiD
         TlOw==
X-Gm-Message-State: APjAAAXX61ytOCnaXBxA16AE4cgFUduHXMz1KYoh1RxjgmVFXDBvzKE9
        dtINzdzYC8Nxs2Jr3580bjteTFGR71+XwLWaCzQ=
X-Google-Smtp-Source: APXvYqyJ7y6ehjO7pR6r7RUzCxxSDoWjafHTtVZXcJpxUSBukNDk5mwPKrnllumLg08A9+RllCUu/WC1KgJiZghOp6U=
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr16414042ljm.94.1567453753611;
 Mon, 02 Sep 2019 12:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com> <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
In-Reply-To: <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 2 Sep 2019 21:49:02 +0200
Message-ID: <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,


On Mon, Sep 2, 2019 at 8:08 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> I think with your "focus" patch, this is not needed anymore:
>
> After focusing the commit message widget, you can focus the radio
> buttons with Tab/Shift+Tab and press Space.
>
> I think this is short enough, so that wasting a Letter is not justified here.

Pressing the Tab key while the commit message widget is focused
inserts a tab in the commit message.
(Again, I'm on Windows so you might get different behaviour on Linux)

If the Tab key acted like you suggested, I agree it would not be
necessary with this a hotkey like this.


Best regards,
Birger
