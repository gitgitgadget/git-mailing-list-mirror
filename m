Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B46D1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeI0COR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:14:17 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34124 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0COR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:14:17 -0400
Received: by mail-yb1-f196.google.com with SMTP id 184-v6so112045ybg.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JnBj6Wga6u7p9xlZA1Tux8j6S9o7cDiAOMwMYZLCMM=;
        b=jcXUssapXdPK5XzG3uxyCTeF5d4soEgPr3UZlIT60pTqRnYSV6bxOgZ++9CzzIi/64
         jvkwaXrq6p7YdU0GRiGHayQTdcRqUm9CBAccvG6KmkBYgW5+btLSHfvIHu9jcgu3+HvW
         rbup6lJTZ8JLLWLG4Zvej7jV/Bf35BteCtjTYoY4YZhEihci6eoq8Mf4j34Jt5HxHsHJ
         ENbK1BgfOCLmoBZzlqQ0LpIatntC1MHhnR7itUycGecVEnl0L5HGqGJUpk+jaBcAxezY
         qSuUvN82P6h8+e6xemG9VczL+rfcuu7D1LQKnEKON8aWf3oglUw8ySVlKd4BivdDIUSR
         1cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JnBj6Wga6u7p9xlZA1Tux8j6S9o7cDiAOMwMYZLCMM=;
        b=YSr0GSVcpM+CN1oX5b6O3s/Wi3TlszcL2qNOnnPtLoP+VZal8/og/wRR0wRr2svD0n
         anqOqJbUs69wQiJLtJfnzZoUZgnhb8EDo2Sj0P/wrTt4hdznaSYuNwTQV9oc/wTZMbP8
         DMI6U01aNXl6ooMa46LoKOT4fd9MBRnl0gAqry1tqHhrCZX5J00VuUlmogCTIm3OUMcA
         W/0ifvDmdk6gsAusFk9kxu2iw8HVYcErJOQhAJGmulMZqQo00CrRy1nVABIbhD/FZSef
         e8WEDjZYoiN2MUkrb24dqHpPol1vo/NdF/EeaPLx45R78q5mBdRJbzdPbQWV82w7L1pR
         2Gyg==
X-Gm-Message-State: ABuFfoilT1m7+jBXRHWi9QEwM9Yd1MjZtt9xmPOsAWPZFBaDrEt2pErb
        Ez3Tt0HNWUHrnlLSQhXQbKg5BVD+0l93uu926w8J5w==
X-Google-Smtp-Source: ACcGV619EZa3xRnEB48GbE9j3ck7Ed3CL82z7VOWkQlDlp5jZ+hoXDBW90e3xshJfjkegiRMk+6ncH8f3EfEu6tqUYM=
X-Received: by 2002:a25:908f:: with SMTP id t15-v6mr3968580ybl.201.1537991981449;
 Wed, 26 Sep 2018 12:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com> <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net> <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com> <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com> <20180926185812.GD30680@sigill.intra.peff.net>
 <xmqqtvmcjaxx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvmcjaxx.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Sep 2018 12:59:30 -0700
Message-ID: <CAGZ79kbeQvLuH1nGPkf8hHbs49SmuPeme_XBdz7ek5fU5AZ9Zg@mail.gmail.com>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I agree on both counts.  I just like to read these in plain text
> while I am coding for Git (or reviewing patches coded for Git).
>
> The reason why I have mild preference to D/technical/ over in-header
> doc is only because I find even these asterisks at the left-side-end
> distracting; it is not that materials in D/technical could be passed
> through AsciiDoc.

    /**
    Would we be open to consider another commenting style?
    AFAICT the asterisks are a cultural thing and not enforced by
    and old compiler not understanding these comments.

    Just like ending the comment in an asymetric fashion ;-) */

(I am not seriously proposing unbalanced comments, but for
longer documenting comments we may want to consider,
omitting the asterisk?)
