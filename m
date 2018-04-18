Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8E61F404
	for <e@80x24.org>; Wed, 18 Apr 2018 00:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDRAGy (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 20:06:54 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35523 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeDRAGx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 20:06:53 -0400
Received: by mail-wr0-f173.google.com with SMTP id w3so23385398wrg.2
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YpWu76dqgy633xP4NiP+3vsKuPg7LRYAwT8iqBh2xsU=;
        b=D9TiAwo4be7RHCmRxaCLHONZb5lQ7/Bq7DBIG45IAUAPu0YRNpVcm+4dlrLkX9VAVQ
         oT1t0IPv8pG2A3iUD9IEEYGn6i0PDYAWZ7T2Rbyikrb7gMA47BD7RVkpo9uLHtTkKyJV
         2YqiNWDL173KZgclyfTnLrwdJ4R5A4XEBbQqgyDy2otNhCcD+Annc7cFlsyEDkYssWoE
         qRJM7q3DD7QdpSQ2f24p+WR1S/9HyjQsM++OP1IRY91GlbOtdixQUPeYwym8fAOvgtcJ
         3W/3XTTUJVdYNNSQ4z13uQhnaxKxoGbnFFEwbrQvEatqD1O8T2AMQjdAQrZl3fQNJSyM
         91sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YpWu76dqgy633xP4NiP+3vsKuPg7LRYAwT8iqBh2xsU=;
        b=alo2zXSfMcXswwkRZlSWIDtX47IRzo+4TfpwHi7nMAMn8l7tOOsv6eYMdG0mVrMYCI
         oJjPfMeXjskC3VmVXG8NmGVZwYAeY3u40JlO1Gu3c4IMssceqBVd34uxgWj/7Qjv2SAj
         A/TY2aitMdQelsSVd2mUdgZrKy/ZatiqLLCW4lp2dWB+zHU30JKha7xBCJLMsSEhANyl
         MGovKl+I23nmyCdgxNSYWXtP0Z0nZqvu7DFoVNFtqyjU6G12822hlSE87ESHBic2OKQV
         IW1fF4P8INzc2hpPM/54Zr2BfIVMXv1rEnI85fP5pgug+JQRRaJLbyEArhDXu2u0iUph
         ii4w==
X-Gm-Message-State: ALQs6tDjWpFU0iajHblz7ZSzq3/Mg0/wlxwOEOgqS2Q9PZdsLKSiMbG7
        xds8u2ciwByAWnqgxg96GQY=
X-Google-Smtp-Source: AIpwx48AGDIO6w2/5RvjaGqnryuF6/wSMdiEuUZCULuVluapAnvNauDNXgq9g/WX61PlT4Y8a+xdPQ==
X-Received: by 10.223.183.34 with SMTP id l34mr3146176wre.85.1524010012410;
        Tue, 17 Apr 2018 17:06:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y42sm1275018wry.21.2018.04.17.17.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 17:06:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
        <87y3hn5drx.fsf@linux-m68k.org>
        <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
        <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
        <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
        <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
        <CA+P7+xrebnWe_6P0uGu2yEmXZ0+qjpykjrv39Nhd2hUPzO_96g@mail.gmail.com>
Date:   Wed, 18 Apr 2018 09:06:50 +0900
In-Reply-To: <CA+P7+xrebnWe_6P0uGu2yEmXZ0+qjpykjrv39Nhd2hUPzO_96g@mail.gmail.com>
        (Jacob Keller's message of "Tue, 17 Apr 2018 10:41:05 -0700")
Message-ID: <xmqqd0yxl6n9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Maybe something like:
>
> "Note that the push URL and the fetch URL, even though they can be set
> differently, are expected to refer to the same repository. For
> example, the fetch URL might use an unauthenticated transport, while
> the push URL generally requires authentication" Then follow this bit
> with the mention of multiple remotes.
>
> (I think "repository" conveys the meaning better than "place".
> Technically, the URLs can be completely different as long as they end
> up contacting the same real server repository.)

Sounds sensible.  Let's see if there is any further input and then
somebody pleaes wrap this up in a final patch ;-)
