Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB812201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbdB1UAM (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:00:12 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33777 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdB1UAK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:00:10 -0500
Received: by mail-pf0-f180.google.com with SMTP id w189so5449002pfb.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dKU4s2/ijJC9bZ5jS9tWqPlMBmzQT4uCo0LvA20aoy0=;
        b=mTw80QwStspm98gfgxYFB0OYLRYPygVlt39+qM85+auuhV8NYhpWNIX+W5ctzYwnZo
         mXVqBzQVZRvVzs5ZuBodSZxiGZJhpZkgyQwbGlusIDQKrkOVcX/SHq7d33boRGN3NWcY
         inpbPDzT+98O8J6gch00h5y+xAlfDPM7RLxCjRzbwEe9A8HXj9dhZy0MTKEujHu8q4e+
         uWO6t2qDUKgqJJ7GX+qRpltJbg3qje1SEJLmOGhAZ4uo8xabD4sQd6H974ARevWmfkse
         MoBT+qfm/RSH7kmAp7PM9d6W9yWtIAUhXnV9CRQWGR6ICz8ipM8BZ/62q4Ia+CBfVZwW
         t1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dKU4s2/ijJC9bZ5jS9tWqPlMBmzQT4uCo0LvA20aoy0=;
        b=fNuU3hnPmMg+eKYvpneOUfjy9Pxl1eowDxKuiYhYghRjn0wBm453y3/32k2FFPcmT4
         52xg/CuUAtj79CTsVFsy8jJGl2wXDQjcTnOcMl13C0VImgtCxOzxz8Sj97kElUTnQ4kW
         kTpxNFmjjcPRT8QHSEycde3+tLByBfgmXOxBSNYA4RTLPUjaSKB3PYiYQQ9aY40fNgKV
         k18e+ST7amtnxbBRS26q0tdXnKxEbYNnyvmuE0uHc7uQkwraqrVUAXve2bl8E8N3ASoC
         r32IYsKKf0mKzpCDhHkDJodmnlWV+EpCEolFpLUGyV5yWxs/43DojylBjDDKuk6Nb9vx
         gbwg==
X-Gm-Message-State: AMke39kSsm6OYmz6t1FlybPVmF8tuugEjWiz0XiyjhflqyNBg5c25anD3fz+q4WEBobHsg==
X-Received: by 10.99.43.71 with SMTP id r68mr4191163pgr.21.1488308150856;
        Tue, 28 Feb 2017 10:55:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id f62sm5691978pfg.48.2017.02.28.10.55.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 10:55:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
        <f6b57868-0173-48d9-86cb-79780f7e301b@web.de>
Date:   Tue, 28 Feb 2017 10:55:49 -0800
In-Reply-To: <f6b57868-0173-48d9-86cb-79780f7e301b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 28 Feb 2017 17:38:37 +0100")
Message-ID: <xmqqa896kuve.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 28.02.2017 um 15:28 schrieb Jeff King:
>
>> It looks from the discussion like the sanest path forward is our own
>> signed-64bit timestamp_t. That's unfortunate compared to using the
>> standard time_t, but hopefully it would reduce the number of knobs (like
>> TIME_T_IS_INT64) in the long run.
>
> Glibc will get a way to enable 64-bit time_t on 32-bit platforms
> eventually
> (https://sourceware.org/glibc/wiki/Y2038ProofnessDesign). Can
> platforms that won't provide a 64-bit time_t by 2038 be actually used
> at that point?  How would we get time information on them?  How would
> a custom timestamp_t help us?

That's a sensible "wait, let's step back a bit".  I take it that you
are saying "time_t is just fine", and I am inclined to agree.

Right now, they may be able to have future timestamps ranging to
year 2100 and switching to time_t would limit their ability to
express future time to 2038 but they would be able to express
timestamp in the past to cover most of 20th century.  Given that
these 32-bit time_t software platforms will die off before year 2038
(either by underlying hardware getting obsolete, or software updated
to handle 64-bit time_t), the (temporary) loss of 2038-2100 range
would not be too big a deal to warrant additional complexity.

> Regarding the need for knobs: We could let the compiler chose between
> strtoll() and strtol() based on the size of time_t, in an inline
> function.  The maximum value can be calculated using its size as
> well. And we could use PRIdMAX and cast to intmax_t for printing.

Thanks.
