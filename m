Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED141F424
	for <e@80x24.org>; Fri, 27 Apr 2018 05:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757286AbeD0F5Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 01:57:16 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34757 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757153AbeD0F5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 01:57:15 -0400
Received: by mail-qk0-f179.google.com with SMTP id p186so562850qkd.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 22:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iyqlTTU6obDnamdaIKIDgYTK0RvttyhgBEEO20WcfoM=;
        b=Y7voWMpJ1B3/tG6RIN8qb4Ex4MJb79nyli9y3iPvLoULpPo7C+wdr4mSnrIiwH/XJ9
         zw06slESRafIG4zxJVuFmK73r9ugWKmpdpyayvpPr8agf4z6UaCuWY7XPxVjMXX99AX1
         DroqJ/mrt6lAp/8MaPNwi/mUvPZKa7L6uDJIsEG+Y89DMupgy4XuZniqTZBIUm1kxGsa
         IqMIMxQo9lqx+nZKijtpMjF7VH5lvaz5ynr2msSw7v2FS4gCXIw4M4qPEKQIo5ux2Bn/
         phcRRuW4PJBgLvN9is856XJVk/q3iT3x0w74KHEsVpqOnBPKsePHILyvsZ7y9uxmq9Ab
         3TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iyqlTTU6obDnamdaIKIDgYTK0RvttyhgBEEO20WcfoM=;
        b=STgOultl57JlCKV+f1tCJ5kbcv3j3WHsc+SIFcJwWSHwbSQk7M6fgwi6WEiyXlLRDE
         EHddP0CKuRP5c3z/wRXo+P9aY+160qU1xsMs6wt5NqzGMjHZtbdCtRBzToMdWAFpBOsA
         LOxPQEBExx+TIW14T7/dQ6fYdwWlcqQ0oYHJ81Eh6noLe20Rrpw1lIbh48qxtZJSNE4X
         Y1X02VU2t69uev5evBHkHrLyD931wWMm4cyGhELcRqixI1CA628y8lnG/J6nkrHQbmEJ
         NGhZQFPHUz6EcwVfJZj7sI3hJbsJZTFQTvS/DVCgkCSmU7m7gvI1nAuviKfi1tp/aLNu
         b1fA==
X-Gm-Message-State: ALQs6tAgPicHlckwxELAUR0uLNsJPXpNEoqyX+cBuVDcXcQwTPIdzb5X
        SrNDsQTKv4XCSXjmUZ6VF1Rd9mqzh5/fF371b5E=
X-Google-Smtp-Source: AB8JxZosSKAUaGLf5jK7xuu5gtazH4uSSH4XN3xjBPIY5db7VwTFZs9ZdRofziV6Rmn8K3NBiAdJc20lv43H2ihaJ4k=
X-Received: by 10.233.220.1 with SMTP id q1mr679625qkf.361.1524808634626; Thu,
 26 Apr 2018 22:57:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 26 Apr 2018 22:57:14 -0700 (PDT)
In-Reply-To: <404da8bdeb9808d2dfcfdf09bc62c76195c9a08c.1524722247.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com> <cover.1524722247.git.me@ttaylorr.com>
 <404da8bdeb9808d2dfcfdf09bc62c76195c9a08c.1524722247.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 01:57:14 -0400
X-Google-Sender-Auth: V_MpocNXw9EDTgMw9iGl82jXubU
Message-ID: <CAPig+cQticAS2wrucAVkxiEuGuwoDeyvXKdGb=7s4m+iugYmCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] builtin/config.c: support `--type=<type>` as
 preferred alias for `--<type>`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 1:58 AM, Taylor Blau <me@ttaylorr.com> wrote:
> `git config` has long allowed the ability for callers to provide a 'type
> specifier', which instructs `git config` to (1) ensure that incoming
> values can be interpreted as that type, and (2) that outgoing values are
> canonicalized under that type.
>
> In another series, we propose to extend this functionality with
> `--type=color` and `--default` to replace `--get-color`.

Now that you've combined the two series, this sentence no longer makes
sense as written. Perhaps say:

    Later patches will extend this functionality...

> However, we traditionally use `--color` to mean "colorize this output",
> instead of "this value should be treated as a color".
>
> Currently, `git config` does not support this kind of colorization, but
> we should be careful to avoid squatting on this option too soon, so that
> `git config` can support `--color` (in the traditional sense) in the
> future, if that is desired.
>
> In this patch, we support `--type=<int|bool|bool-or-int|...>` in
> addition to `--int`, `--bool`, and etc. This allows the aforementioned
> upcoming patch to support querying a color value with a default via
> `--type=color --default=...`, without squandering `--color`.
>
> We retain the historic behavior of complaining when multiple,

Drop the comma and be more specific:
s/multiple,/multiple conflicting/

> legacy-style `--<type>` flags are given, as well as extend this to
> conflicting new-style `--type=<type>` flags. `--int --type=int` (and its
> commutative pair) does not complain, but `--bool --type=int` (and its
> commutative pair) does.

Confusing. Part of the selling point of the commit message of patch
1/5 is the removal of this complaint/restriction, claiming that it
intentionally treats "git config --int --bool" simply as "git config
--bool", and that that loosening is required to support "git config
--int --type=int" without complaining, thus is a good thing. But this
commit message (2/5) backpedals and reinstates the original
complaint/restriction.

Perhaps I could have understood if 1/5 said that the loosening of the
restriction was only temporary and that it would be restored by a
later patch rather than using the restriction-removal as a selling
point. However, this patch series doesn't need to be crafted such that
a feature is temporarily lost and later restored, so I'm having
trouble buying the way this series is architected.

What could make more sense would be for 1/5 to introduce
option_parse_type() for --<type>, thus retaining the restriction, and
for 2/5 simply to augment option_parse_type() to also understand
--type=<type>.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
