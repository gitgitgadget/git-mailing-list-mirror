Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8133215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeD3WVa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:21:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40687 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeD3WV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:21:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5so16651533wme.5
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hlA5PSJSam7VD1EN1+kY7/NDUDQk0p/3gu3P296gRbU=;
        b=AqGZkLUXDgvrhIuN7ip6tZfLS1mzlig456umpWEiKpOKMzuD8jBfUzM9TA+flxvc7B
         p322gkrxGlO1VcABTf5Ig/j4t2y74auhcrSl8584UEcUTkg/466UL3lcuwHen1HkN6JN
         fkjfxQj4XfspQXs5QIej3sXBYGW2JLM8QiaByFylU/rODTeSN+E84xkyvEW7PHysejTB
         n6KsUlw91SpuCiQSTE1V6xqIMe93giXjWM/ggp2+QXlsN25DH+wV11du3rwD13f9+IzM
         oLjxmsbNkv7pRG5wGGCNl0lej43V07C9NTmHniO6D8UMd0XcymCqEnz0YbMXpakT2VhP
         HplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hlA5PSJSam7VD1EN1+kY7/NDUDQk0p/3gu3P296gRbU=;
        b=ptkY37/uRADFrif4e24hWXfEOohiT5l6lPeuPZlElG/ClCe3vimL0PdPYW00pAnPmR
         CuyZhV7Havua2EdLgNZ6ysgGbOcic2IATrr+mCpRQin4YJ/zdGXKxaLFhc5oMsn5vxES
         hW6+P08kChPd2REA3bYTTbV7Ehicsb5wdxHww7anogdqXuVjINemWMcvIxcRVWQ5oRrs
         +DLrLhk3vKGFSGNOnUsHyDr4HI/KemsjkXhm2vqRBujiDz6XVoBefGq8MiIpkG3ydAil
         nZDjPGTAMhNsZpI/tf6noxIfMfj5JeigijHT8LubbyA0QG33F+KuayLnlIly442a/Ja9
         ZEPA==
X-Gm-Message-State: ALQs6tD+SiEQ9J3fdqLjwJa2axH2a5XoknZ0bQ/PPXu8/grD9sulz38+
        St8ilpMdBmBotRfRkiXsfLo=
X-Google-Smtp-Source: AB8JxZrVpnZtGIJ02G6vN6nfyH75XEopdGaypYJVM/J5t6fk5EZUjBO+dqh6MHHt1bMn+FKDZ+5Lyg==
X-Received: by 2002:a50:c944:: with SMTP id p4-v6mr4189906edh.236.1525126888803;
        Mon, 30 Apr 2018 15:21:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o25-v6sm4777259edq.62.2018.04.30.15.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 15:21:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Avery Pennarun <apenwarr@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
References: <20180430095044.28492-1-avarab@gmail.com>
        <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
        <CAGZ79kakirTjA32cTmByLpjnb3QKUL5eGEgPFFMhUnewC73S8Q@mail.gmail.com>
        <CAHqTa-1KCsbG=6T8M0PLuM5s-j972jiv=vvZHUiwOxwgpPWJeA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAHqTa-1KCsbG=6T8M0PLuM5s-j972jiv=vvZHUiwOxwgpPWJeA@mail.gmail.com>
Date:   Tue, 01 May 2018 00:21:27 +0200
Message-ID: <87d0ygz66w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 30 2018, Avery Pennarun wrote:

> On Mon, Apr 30, 2018 at 5:38 PM, Stefan Beller <sbeller@google.com> wrote:
> There's one exception, which is doing a one-time permanent merge of
> two projects into one.  That's a nice feature, but is probably used
> extremely rarely.

FWIW this is the only thing I've used it for. I do this occasionally and
used to do this manually with format-patch + "perl -pe" before or
similar when I needed to merge some repositories together, and then some
other times I was less stupid and manually started doing something
similar to what subtree is doing with a "move everything" commit just
before the merge of the two histories.

>> https://trends.google.com/trends/explore?date=all&q=git%20subtree,git%20submodule
>>
>> Not sure what to make of this data.
>
> Clearly people need a lot more help when using submodules than when
> using subtree :)

Pretty clear it's garbage data, unless we're to believe that the
relative interest of submodules in the US, Germany and Sweden is 51, 64
& 84, but 75, 100 and 0 for subtree.
