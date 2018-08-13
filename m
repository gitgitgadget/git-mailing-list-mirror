Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CAB1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeHMVIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:08:25 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:45161 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeHMVIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:08:25 -0400
Received: by mail-yw1-f43.google.com with SMTP id 139-v6so14266603ywg.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrDWmJwka36RVBNEtf/J8XjoAKgGJbdISZk1vjCOCf8=;
        b=IBbytelh0U7Rg8EMQVfCW5ZSk8Sw2vS56MunxbSV7t+5+3Iyxav9bj/NHipt+i5CNJ
         s6hmUhROn2CYtencVvVJudhIIRHpRFFIwtMVUpdP+lTTFbrwdJF5XLCS/ZWwJEmW0r0C
         ZrVYi/ZJQiuP+g1ZcEswE4gNVjPruqkC+oxi38rLPW9QcANtWF2q37kNZbAkrRxK5BHc
         gTtWn+mNSQbgyvjTGpuuYXPWwXbqycEknMYWsIo5M3lLEYfHGtf/OyJDHp97941pTSr4
         Iu3dZJIucKbdcKbJoiWaeiFJhNInavjLC/oHA9KCIwJ92qBJIQYzUDkybmZX949QfWzP
         2+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrDWmJwka36RVBNEtf/J8XjoAKgGJbdISZk1vjCOCf8=;
        b=FPErdKc5N+X96gFm+lPsl8CKPz/7kuW7gC2YDnoRYp9szLbQg8zoVGJVyjS+rfHvpG
         1kf6OPvFuSfDIeXWYyK1H2YC3WaS7hma2ccrkZwrO2Q/JAcphz8yhBNEiBCFk/P1hRhu
         G6dtdfV5SKEj1zCItmFCrgwlFjv0ogI+IBciJoh0H0sz6W26YHHyKBTEWZdE2R4t37PY
         QCMpqoaWLWXEf4vHTRDY65B/dLEWEXcrMQh08zW0gMBWCxvg1O3OgemOt+ZfIi8rB22a
         Mg1CIGkY21qXfnb9Xhtk7ieuOO6iW2FYTWFwuY1Nj4Dl4K84ibF8pS+i3nyCBi5LX2mF
         jp1g==
X-Gm-Message-State: AOUpUlFytKT+99S7i/9e9iMJnRZFzR1KWTSrRMfYFbiFsZ83X7og/ojq
        vOVrN6C3ZXFx5I/9ga+A3BYxA/qr5ot9GtdYwfi7Jg==
X-Google-Smtp-Source: AA+uWPxRZ5OToMzuY5TgKKcs0OOAC5JuvfUSlYQhBwKybguwM79gxYJ9t7SMfQFmjNRRPkJ3EuJCt822Mf6NJ2Z/vRM=
X-Received: by 2002:a25:874d:: with SMTP id e13-v6mr6936237ybn.515.1534184703191;
 Mon, 13 Aug 2018 11:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-4-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131348120.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131348120.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 11:24:52 -0700
Message-ID: <CAGZ79kainPmtHWT+11+34f4F2pGD3+too5SrG547z6HRFYjK-A@mail.gmail.com>
Subject: Re: [PATCH 3/4] range-diff: make use of different output indicators
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >                       strbuf_addbuf(&buf, &line);
> > +             }
>
> My preliminary reading (I sadly lack the time to pull your branch and play
> with it) suggests that this works, although I have to admit that X/Y/Z
> would confuse me in 6 months from now, as they do not really read like
> diff markers but like plain text. I could imagine that '>', '<' and '#'
> would not impart that confusion on me.

Thanks for that suggestion! (I'll change it and add a comment)
