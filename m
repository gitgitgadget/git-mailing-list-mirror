Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C9C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 01:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhKVBSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 20:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhKVBSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 20:18:05 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403E0C061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 17:14:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id q64so16543194qkd.5
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 17:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4v5QKNd3ZCoDHN+ZjF/ERSKsBey+JLB1az1HJtR1sqc=;
        b=pK372831F9koNEClXJo+2vPH+xUkvoynqoNepGv2Uhov208VLBLNleMIx09f35w8AP
         wxQmzWGj9nudkImUxkRTmHCfq2N3m2bM1tX0JgveX3b7tYy5ZDEO7vb8eD9Xg9mpD/IU
         tpZljFiQEjSTw11KtChFvi6Hv2ro9HsstZmSc8Kyd4YTKL77+dKzxJp+s3CixzswvX+j
         tCjWDVHWmP0kMiF2dpKXpGRTXHr3y7Trq2XB7+8jK7Y08ugjLCVkrfO4Tmgv2RX+vWj1
         U/KzwROsPsIffGELa1eBYTB2B1KtwynVSO1HPq0xWz6QcPgu9Elk2RMvsvU03bPlPNx8
         Z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4v5QKNd3ZCoDHN+ZjF/ERSKsBey+JLB1az1HJtR1sqc=;
        b=EPQFox++e8vidp6vLIXtgb5Anzf99xKbhLZzWbN1ccVlw7smVvLZKqTzBtpSXbcLVw
         h19oBJMAzrG8dWZJ4g+BbT17gwafHx/OR9KFujdEickffMuISImyjKNNM30ev38YUMUm
         U3/tNw5hwpocGcTreFH2Q6IesR7f1Luf0GT2hLpQ9l+KfLUEU/M3BOqF4o3mVcb01gy5
         Y5mun618uV7gwrLJV/yWiMd43gy0ZpzeV0Cgxh420X78jXDD5jb2oCM6RyaVQcxdNoYZ
         nNz7qLu8FyLGjqo5A1F5ZIWUiyXmZsx+WuKMB5/7+nTg7ZmBMulFxbDgfN8CQxkMyeZ0
         Dbqw==
X-Gm-Message-State: AOAM533ojH3xn7WDcbsd2/eaIL48uTvRqycfKQCBD77+t3Bhtpj0pe89
        O2+cgHLDwi1tgzeHpprYhW07+w4I3lYGzZ3i65A=
X-Google-Smtp-Source: ABdhPJwGUmWDN92dyEiR7qHVTGMqH9hENxTjKsmR95iWbPYKKD3jNIw3bNDbJWhe5V4u41TnO3ALqUzz7h4KWzEnIqQ=
X-Received: by 2002:a05:620a:710:: with SMTP id 16mr44260647qkc.379.1637543698200;
 Sun, 21 Nov 2021 17:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20211113033358.2179376-1-andersk@mit.edu> <20211113033358.2179376-2-andersk@mit.edu>
In-Reply-To: <20211113033358.2179376-2-andersk@mit.edu>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 22 Nov 2021 09:14:46 +0800
Message-ID: <CANYiYbFJiTfrErw9etMHsHLBkj3jQ2jPCqJ7H1gBGZmT6QF9kA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] fetch: lowercase error messages
To:     Anders Kaseorg <andersk@mit.edu>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 13, 2021 at 11:34 AM Anders Kaseorg <andersk@mit.edu> wrote:
>  static const char warn_show_forced_updates[] =
> -N_("Fetch normally indicates which branches had a forced update,\n"
> -   "but that check has been disabled. To re-enable, use '--show-forced-updates'\n"
> -   "flag or run 'git config fetch.showForcedUpdates true'.");
> +N_("fetch normally indicates which branches had a forced update,\n"
> +   "but that check has been disabled; to re-enable, use '--show-forced-updates'\n"
> +   "flag or run 'git config fetch.showForcedUpdates true'");
>  static const char warn_time_show_forced_updates[] =
> -N_("It took %.2f seconds to check forced updates. You can use\n"
> +N_("it took %.2f seconds to check forced updates; you can use\n"
>     "'--no-show-forced-updates' or run 'git config fetch.showForcedUpdates false'\n"
> -   " to avoid this check.\n");
> +   " to avoid this check\n");

The leading space character before "to avoid ..." is not necessary.
This will change "po/git.pot" like this:

    https://github.com/git-l10n/git-po/blob/pot/seen/2021-11-19.diff#L374-L377

It was introduced in commit 182f59daf0 (l10n: reformat some localized
strings for v2.23.0, 2019-08-06).

--
Jiang Xin
