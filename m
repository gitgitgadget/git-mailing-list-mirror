Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3270F1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 10:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfIGKeN (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 06:34:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33812 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfIGKeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 06:34:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so9139050wmc.1
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z81JxHF24RhM9AU87pzwh9xYdvBb4CX06cb5X5vh2Bw=;
        b=NORM6Nse55bpybxrlvcFhMKHLrV3FTq3/ltdqlHpK4dqnlvi21YUQBpw7pGhTnaLsi
         1o+QJenPPGzd5368PxYYKWrHsZzNvwm6dqNGyPCnk/EBYcUulfuLIPbyiHWUxvbUVeQR
         dXGRgulDKumvJh56jlmojOoXeJRcIEFl8ct+ZHIvixO807LrsiGe46imvYjDwPLGCqBW
         M1nh2nNPDwk7Zjct0hKUnXdYkovOcLMoxi4C9Bj+QtGtN3sRnuOwyMRZpfnEJ5qQrReb
         +XaVG6ePUBpulTXACmRr8JLJM78kwkaaTW/m33hNrg3pCVsC41lv5PkHXuTXXGHmy4mm
         RtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z81JxHF24RhM9AU87pzwh9xYdvBb4CX06cb5X5vh2Bw=;
        b=PVGJLXxSVpCZd4yiqokz5RHamrlE2NdzbRgCpbPPornJfrl16MzyI1M1vpLd6Vve0b
         UITDE023TWKtDYshVTsfRN4M7CZ5ale3JBHRXCIVc/9OF/NHvlB9/oQUHASBH0dFj0lY
         snbQ6GQknb/CGh+A/5Hr5HxYePFTaHGlrFHxseb5eK/7jiNb7MNX/DpTuccNCyfnmpv+
         vbcA0t5h+lyCEex7Tqn7meWyrL0JenZQ1mjgA9jTZ1Joh+OlSHSxqkpXzAMDX5yz0NkE
         GkZtIj2wp/naVinB3T5sSlriztuOz7LTyztakhc8Q+RnsJvvZVAW8+podJQZZyRXluG+
         bLdw==
X-Gm-Message-State: APjAAAWsu9fhZR9euP6BLd90XDlMzrGoRlzviWySTL76Efv7lyENpmVu
        HtM2U0ljWbirpbTLaDWllz0=
X-Google-Smtp-Source: APXvYqzyUDY2VBe/SkUPQF/mNhOF+0lFWFV3k6OFCN9R+wHUaUEJ02pP6fMaeVkgeNnp3/ALZHyu1A==
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr9268187wme.83.1567852450989;
        Sat, 07 Sep 2019 03:34:10 -0700 (PDT)
Received: from szeder.dev (x4db321b3.dyn.telefonica.de. [77.179.33.179])
        by smtp.gmail.com with ESMTPSA id q124sm13338643wma.5.2019.09.07.03.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 03:34:10 -0700 (PDT)
Date:   Sat, 7 Sep 2019 12:34:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] commit-graph: don't show progress percentages while
 expanding reachable commits
Message-ID: <20190907103407.GF32087@szeder.dev>
References: <20190907045848.GA24515@sigill.intra.peff.net>
 <20190907050132.GA23904@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190907050132.GA23904@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 01:01:33AM -0400, Jeff King wrote:
> From: SZEDER Gábor <szeder.dev@gmail.com>
> 
> Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> progress, 2019-01-19) was a bit overeager when it added progress
> percentages to the "Expanding reachable commits in commit graph" phase
> as well, because most of the time the number of commits that phase has
> to iterate over is not known in advance and grows significantly, and,
> consequently, we end up with nonsensical numbers:
> 
>   $ git commit-graph write --reachable
>   Expanding reachable commits in commit graph: 138606% (824706/595), done.
>   [...]
> 
>   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
>   Expanding reachable commits in commit graph: 81264400% (812644/1), done.
>   [...]
> 
> Even worse, because the percentage grows so quickly, the progress code
> outputs much more often than it should (because it ticks every second,
> or every 1%), slowing the whole process down. My time for "git
> commit-graph write --reachable" on linux.git went from 13.463s to
> 12.521s with this patch, ~7% savings.

Oh, interesting.

> Therefore, don't show progress percentages in the "Expanding reachable
> commits in commit graph" phase.
> 
> Note that the current code does sometimes do the right thing, if we
> picked up all commits initially (e.g., omitting "--reachable" in a
> fully-packed repository would get the correct count without any parent
> traversal). So it may be possible to come up with a way to tell when we
> could use a percentage here. But in the meantime, let's make sure we
> robustly avoid printing nonsense.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Compared to the original from:
> 
>   https://public-inbox.org/git/20190322102817.19708-1-szeder.dev@gmail.com/
> 
> I rebased it to handle code movement, added in the timing data, and
> tried to summarize the discussion from the thread.

Thanks for resurrecting this patch and for the summary paragraph.

