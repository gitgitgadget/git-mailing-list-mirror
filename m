Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF24A1F576
	for <e@80x24.org>; Tue, 20 Feb 2018 10:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeBTKCJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 05:02:09 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:40824 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeBTKCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 05:02:08 -0500
Received: by mail-qk0-f180.google.com with SMTP id n198so15676757qke.7
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=45/yAVd50DEAZZ7rp4XrrT7sl5FrwUY6HjJgfoJMBt8=;
        b=OS0y+XRN4QUy6zIyS+s4aWwHjkDYg25FLJEBW5dbBqgehls5hVxFs8mrzluTSRlcpS
         pzI1kaJEgLJ839VPq3bH8ExWfkJ3TVjpdY444XuAKg2WVvh3XvkJcBRoJdobtWbNF9NS
         6Er6w+NHHcMB1BvQ3EoZK7db0TlhgwRRlqaD+hgxLMuZkyTHB/9v/w9T7G41dkhL7c7z
         vYk+xNQTEwNHW/i69ioaFgPPJ2pxtZzG22Ut0u05hY5KPlkphiu4Y2e2N70ICYuUFvtl
         Kh8dpkzJlZ018i+BN0oQLPcPErAZqoyuW5ZfWdlcEi6H522BR+O9k32vOwO0/lWXc035
         8reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=45/yAVd50DEAZZ7rp4XrrT7sl5FrwUY6HjJgfoJMBt8=;
        b=M8jHoAvCNQ/Or/p7KHJvnKoXi/CujQ0e5pyWQ5Xi/lhxOfJIbUX3GuWs9n07vEqY1s
         2IOCbk75OQxLjkUbSkzH1JiMiFPRSPcDHVhwSWRgj/J0d+p1kO8HGMK6iVX6FoF+mpfU
         xDo+mFp/BYOAud5U4dTn0bm6jbmY/kCY29aFL1SV2Q86wLEHYFOLECg3tWU4KH4bsfdn
         TKgUtKMMbUBjnhn0jR0xlhyLbP5JNljU5jvvGpqmm7/c36Sxr3e94SPYRqWRlZ6QArru
         LzsQmBbeyyHkpxbEVpC2zUb2h4ntrKHhUSYj4P05M3F4e6TSCYzuro9B3hLBMGeDcTlw
         5BKw==
X-Gm-Message-State: APf1xPCZsVR5+vlb1buwNnl9iT77fBOdVvtoJO89CwKoC3I7YAROA/AC
        484aQaF9f2yEluyh+3EW2uv47xoJv3CpXxLLlEw=
X-Google-Smtp-Source: AH8x225fz12uJJ7mGx96xDZ8nLrL4nqwXVlDpLC1m4GUTN6/S1FXQwhWrdLcQdzc2f4SexCZY1cSpnrbsWTTOnxQH34=
X-Received: by 10.55.134.133 with SMTP id i127mr28419987qkd.275.1519120927337;
 Tue, 20 Feb 2018 02:02:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.26 with HTTP; Tue, 20 Feb 2018 02:02:06 -0800 (PST)
In-Reply-To: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Feb 2018 05:02:06 -0500
X-Google-Sender-Auth: h609aVrs6tbZwcAo5xuqSxI1cEk
Message-ID: <CAPig+cS0D_Svkj+1yFTT1nk1jvXhH35uNCET1r_6tLd86tdviQ@mail.gmail.com>
Subject: Re: [PATCH] Fix misconversion of gitsubmodule.txt
To:     marmot1123 <marmot.motoki@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 3:51 AM, marmot1123 <marmot.motoki@gmail.com> wrote=
:
> In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions `s=
ubmodule=E2=80=99s`.
> It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.

Thanks for the contribution. Please sign-off your patch; see
Documentation/SubmittingPatches.
