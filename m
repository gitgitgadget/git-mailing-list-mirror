Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FA31F424
	for <e@80x24.org>; Fri,  6 Apr 2018 07:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDFH3u (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 03:29:50 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43929 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeDFH3t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 03:29:49 -0400
Received: by mail-qk0-f193.google.com with SMTP id v2so211945qkh.10
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WvZ+e/fW168NusYRZ+fUfXA9SGeBXiRzOrCUBAqpWjg=;
        b=g8mXvlJD3f1rOwLwqtKwyNWhhgM2B3njijuTRb3f7gZefI2fAWxDlibMw5fkAWoe2q
         KzFHFo1hFzfwR9ILI3jAdQXdr3XtkgMY3jXZOSsaK9PVgDHi1Ey6MaLHj/nh0UVTXfD4
         YwveA4T6L/Z0x4rDSzip7KVR5XpGKOS6KRFSZCXcm6sUe2z2RfBezBHNDs5v/C2OKMDh
         8wFaEF6HNc7kCjZ/9Ri4GJias93/zOAOis6w49oZVlcwoahZtnxJe7K04MpCAWVFU2A2
         8S56/2KVMSrE5rcmbN/jOxT5gnSZL6TcAvUAsrUcDKtRAUT8E28dP0a3TBlHR+OlJ2tJ
         qBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WvZ+e/fW168NusYRZ+fUfXA9SGeBXiRzOrCUBAqpWjg=;
        b=DeTY5oqXg+F+XKu7ZMHjF63FBz4C6Gd/NkLq6pv9lg/cqFm2LGw63XMhj9w7Q5ubVd
         OjN71mPS91VNWG0EyKkt1AdnRjqQE3Q5Q+6XjmK/TArZS83/ljS0jiJrGHPDmvhcCvy5
         BW32jpwA7KhQvBHkYfXQIfUI4sZZU2F50R14NO0zHmtbd249StqfUrLFFt8so/+zIDuf
         BMtYy83LK9bKOFOT6xwFzIVnQPWhkf371eYFzBzJ9DjFNmrhsJFcBPix9+9JknevKw+s
         kk0X13+1LpoMpR9b8zn1wzXYCcwmVZDY+BAp+/QKJz/7ZjwZeUWqACtm/67js4BV84Zz
         g+bQ==
X-Gm-Message-State: ALQs6tAVqC7rQ37WD7sT0D63xxBbwvKqjVgmP9+hQ4pLDj2kaGmnihsv
        2nRcawgL3cqqixRIYWTS+VOwqoE00TvWeo6aJAs=
X-Google-Smtp-Source: AIpwx4/7eEVtb8lkKjhnLWT51hTuGja0r3nR/5yE7lhDR5WqdKMDmfjBsoGsdhzuAi+EbiEOvWcLCJjgnHYFTCUdrRM=
X-Received: by 10.55.22.28 with SMTP id g28mr34180145qkh.152.1522999788795;
 Fri, 06 Apr 2018 00:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 00:29:48 -0700 (PDT)
In-Reply-To: <20180406063017.GD662@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com> <cover.1522996150.git.me@ttaylorr.com>
 <20180406063017.GD662@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 03:29:48 -0400
X-Google-Sender-Auth: Ha6g4uC5I6jsiRsr6V2990r3GSE
Message-ID: <CAPig+cT2T8r9mefv-7GEU4khEDVrthK45X5kbVXU5c-MXU39dg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] builtin/config: introduce `color` type specifier
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> For consistency, let's introduce `--type=color` and encourage its use
> with `--default` together over `--get-color` alone.

A couple minor subjective comments below... neither worth a re-roll.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -180,6 +180,10 @@ Valid `<type>`'s include:
> +- 'color': When writing to a caller, canonicalize by converting to an ANSI color
> +  escape sequence. When writing to the configuration file, a sanity-check is
> +  performed to ensure that the given value is canonicalize-able as an ANSI
> +  color, but it is written as-is.

"When writing to a caller" is a somewhat confusing way to say "When
getting a value".

Likewise, "When writing to the configuration file" could be stated
more concisely as "When setting a value".

>  --bool::
> @@ -231,6 +235,9 @@ Valid `<type>`'s include:
>         output it as the ANSI color escape sequence to the standard
>         output.  The optional `default` parameter is used instead, if
>         there is no color configured for `name`.
> ++
> +It is preferred to use `--type=color`, or `--type=color [--default=<default>]`
> +instead of `--get-color`.

Repetitious. More conscisely:

    It is preferred to use `--type=color [--default=<value>]`
    instead of `--get-color`.

Or, even:

    `--type=color [--default=<value>]` is preferred over `--get-color`.
