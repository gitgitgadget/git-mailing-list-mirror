Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B51B202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdGMTO2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:14:28 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33753 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbdGMTO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:14:27 -0400
Received: by mail-pg0-f41.google.com with SMTP id k14so34210659pgr.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p8PrEEqRe2fmEr3eUv5ZvCYqWadBSSSFznZZxLvufS0=;
        b=qr3qgQamY3z2c6GXL1T3i6v6ntNh7GJavldZqtOP0tJtW5d4WCkhVAYxb1XMVieR/I
         sCwKk5RRU2zWGlQn3xC3q1ouBN6tJWQhZcnZCPAQ24CLMZVbTZwNOahDly7ehhNMqpQe
         bXfzj+0Ru+6hDsUuW7o5+cGfS4O3NQhY7lrAIw6/IpjCcZVDJqzsnQbxgrZWGTc31HY0
         al7fqVp+RNp5BF5aiALkrHIz8zi3hIOw8GyuNP9CbOcDmLPhWy/lg5Ygbjmhkxd+y0Nx
         uSMEaxMCBZlc75QWgSsZEw4vgekLVIR7ugkPDqtzAY21amNLwqW49bSUDxxc+9fbScW8
         9NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p8PrEEqRe2fmEr3eUv5ZvCYqWadBSSSFznZZxLvufS0=;
        b=aGF9id2wTCnG3i0+AfVgawfZCNm4MY73Gb8cROEKioEOw0Pyfq+EJKUR2L2HnF0ytI
         4CiXmnHPI+8P1fqU6YiziMh3KdVwGuA/W9OTlC8VT0ZT5A5qNaUjZjU97XSpuL/Fqq+O
         UtM/wZBc3XRQtERhfrmq/y6oC1NPXwiuUXJ5xHmcwC5FMuux0qL485Xq6UBzzZUvjZY1
         8wpO6o/yfy8KLbvLn3x2ah0pFGFIalpheqB7PKh4XEOTnSAl9DW9HTUlTmE4qhQ5T9TW
         jFjD30+udGwL8AmMSOSUNhWVrIrNZwIObumhzVrbn6p20Rf11eZ7zk40N8K6+tfKG/jo
         YFaA==
X-Gm-Message-State: AIVw113D1gV81yd9DHZdz4N0dhElZ3OVGVJZFkcf0hXZ+qJ8ldl96ndt
        IscP3lTOhIDQL7LzqAVwRgNLyDluuydPXUI=
X-Received: by 10.99.44.206 with SMTP id s197mr10734939pgs.116.1499973266602;
 Thu, 13 Jul 2017 12:14:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 12:14:26 -0700 (PDT)
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 12:14:26 -0700
Message-ID: <CAGZ79kY_Vt5hK0FbzJgSZOxhNMKJ0f8N+uSmTTuF8nXu0vA-Xg@mail.gmail.com>
Subject: Re: [PATCH 0/15] making user-format colors conditional on config/tty
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 7:55 AM, Jeff King <peff@peff.net> wrote:
> This is a cleanup of the patch I posted last October:
>
>   https://public-inbox.org/git/20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net/
>
> The general idea is that it's rather confusing that "%C(red)" in a
> pretty-print format does not currently respect color.ui, --no-color, or
> the usual isatty check on stdout. This series changes that. Note that
> this is a backwards-incompatible change, but the general sentiment in
> that earlier thread seemed to be that the existing behavior is arguably
> buggy. See patch 14 for more discussion.
>
> The patch stalled back then because I wanted to make sure that
> ref-filter's color placeholders behaved the same. That required some
> refactoring which conflicted badly with kn/ref-filter-branch-list. Now
> that it has graduated, I was able to rebase on top.
>
> This version also takes into account feedback from the original thread.
> And as I added tests, it surfaced a few corner cases around color config
> that I've dealt with here.  The last two patches are the most
> interesting bits.
>

I have reviewed these slightly and think this series is a good change.

Thanks,
Stefan
