Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBC8202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbdJSUyR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 16:54:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:50216 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbdJSUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 16:54:16 -0400
Received: by mail-qt0-f195.google.com with SMTP id d9so9349564qtd.7
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h+g06y1MkrovXJcCJsvFjOgY2fJlK4TrqQdVnp/z7ag=;
        b=saERWCXGt4q0WkwyB8MZLl17t2UM22li70Zlg15vBwjBngxoJxQqVqPKu0yRmYuBn7
         qrRDU0mcPQATLMMwiSbJBOhR6WIpiz1welPrDCfAaUfg0zuHw+JwKmPdSlzMSXeel0d8
         ck8T01R/dPp/zuX+//Kn4BxCBmhL0hTWll1i9CSdlxWs4fEXS/FyuaDOQblLdat6PYfH
         /CGl0tNjb3t4KM08n5tHN87aAbM063J4JD8Uy0MZrjP3MNEnAx79d/dQlKMs4TljunGn
         mB/TX6nb3z0cTr+cnMayxpKzoSY90qXet+Cs9bSxW0lVUdfq2z2OMK+BYg5t3AvOmgBH
         mjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h+g06y1MkrovXJcCJsvFjOgY2fJlK4TrqQdVnp/z7ag=;
        b=IbmHLkyZq7QU/ELlHNTBSphvnSAxAiL/0GcEb32xLsyCp15X92IVIxybmrIpx8xjfn
         9LRe1PWp/crQnmBtbSL9uK77zTDqlwG+KwuTwPvxSwAhp+kHgOdYV56MmjJhxt9vkBWp
         4nYvVxWm/QhfadfJLLCyY9MVNv23BTto/fvcUBBaE4Z5aNouhIQHvNG2NIpXFitb3SdE
         uNmaCSxFjJyseN5QJrzlJXSavAMWSMrsR2DVFrvH6WssIsyOtWCojolQmGOU3a6w9rLj
         YZlzdO67oUcupT81+8CaEnhejUcfpEcwRxJ9dH5IwLRT7k/Ni0sG+GWUnXLTJivrjrJB
         D2wQ==
X-Gm-Message-State: AMCzsaVuQVyy90a3ppzxlF9sOG2FOPyLnR3UUhXMFVU48YmxZMb6qiba
        LzoHNx1Kq92uMFuVDDxLm93rVJyclZsBih+pcvqxBA==
X-Google-Smtp-Source: ABhQp+RfoqwdpFn8nlzEPuwRjXyVLH5CzDHy1pLVMB2HPXoXY00Fe9xYrP2pVhbmUeTxg10ad4QTuF5vMfI/c5Ke/hI=
X-Received: by 10.200.47.77 with SMTP id k13mr3617907qta.298.1508446455859;
 Thu, 19 Oct 2017 13:54:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 13:54:15 -0700 (PDT)
In-Reply-To: <20171019202556.hkz4r7hq4tlkjhvh@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net> <20171019202556.hkz4r7hq4tlkjhvh@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 13:54:15 -0700
Message-ID: <CAGZ79kZyx5tezrTN2Y26G=0E4VaXyQSODFK6=19ziSHprfDLsQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] t4015: check "negative" case for "-w --color-moved"
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 1:25 PM, Jeff King <peff@peff.net> wrote:
> We test that lines with whitespace changes are not found by
> "--color-moved" by default, but are found if "-w" is added.
> Let's add one more twist: a line that has non-whitespace
> changes should not be marked as a pure move.
>
> This is perhaps an obvious case for us to get right (and we
> do), but as we add more whitespace tests, they will form a
> pattern of "make sure this case is a move and this other
> case is not".
>
> Note that we have to add a line to our moved block, since
> having a too-small block doesn't trigger the "moved"
> heuristics.  And we also add a line of context to ensure
> that there's more context lines than moved lines (so the
> diff shows us moving the lines up, rather than moving the
> context down).
>
> Signed-off-by: Jeff King <peff@peff.net>

This patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!
