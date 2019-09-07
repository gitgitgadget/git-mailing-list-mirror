Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB39D1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394471AbfIGSzB (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 14:55:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36438 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393429AbfIGSzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 14:55:00 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so20240532iof.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tPrZiqbBzn1mUOfdPUvgejzuvcTgDgHGHv1b9LfHni8=;
        b=BMkuc9cSKhclvOYl1EFMvpXnrnxPwLavc0ys3Dqcsh9meW/hIaweYwcksod5YOTS/S
         sZbnUujwmi/qCLq9noYTmtk3KzN+OXRbfdWNq1/D/2aQkVBKBiVqYbhs5fkLsbDs0pUC
         gWApOYukHpKQZqs2O4v1kogc9A2RrjxdQmmim/E6lhNTOtROrDCplJPGSYY1DGtABKOn
         VkhAmSUZHMF1ygEPqcxN1UNY6KbmLZsBrI5cKIYxHYkplSz8BmWjsDJ6A73RViLyAuY8
         bNTodY4o+auBg41LvB/p3oPRZJavCUgC79BLpSWhP2eZPvZ6NkvTuLcl9BxXENp9UfSj
         FSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tPrZiqbBzn1mUOfdPUvgejzuvcTgDgHGHv1b9LfHni8=;
        b=eqmUQZg1ylRRuRaJgFoCDQKJB/U73u50ySFkRNSriwsW7y6yEgplbeJgS/cmRCGBRJ
         yEE6Wi7+luRgbvPvDJWMo557LbG7L7Pp4aRUYAzU13pOMfc59pkAiY62QnQTPOi/Q5G9
         1Zod6k1nuXaB621UBKq0bI0y6Fq+U5k43KskmDBBpEGz/fhxl4c8CrQctBjLZoDvBW0+
         3p3vEBsZpBmlj4QdyVi6keEmE89dN2uv8g6baHMccJNXdBAH4YwF1p+uTQUt5kMv719B
         /BlBFaK4lEbZqt2xYOaOTKrO80JYgupBzq3Kz9LU4NdwZ5ntZ3QWayZVSdjxaevm/DtG
         0Svw==
X-Gm-Message-State: APjAAAW+VGVVT04ZmIdIHxPtbYcyus7xBUNCkVgcodxDeF2AUncj/5Cx
        qfoRwtzFsKUKmVGWNULLs0K4vw==
X-Google-Smtp-Source: APXvYqyniAd426hfgRlPYamjJvjtCGWQmd6LwOkOXRn9b4ZWyG89N9K+7SooRzu3z6y3SKUnUifYNQ==
X-Received: by 2002:a5e:8f42:: with SMTP id x2mr11296898iop.112.1567882499837;
        Sat, 07 Sep 2019 11:54:59 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id j11sm7088022ioa.55.2019.09.07.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 11:54:59 -0700 (PDT)
Date:   Sat, 7 Sep 2019 14:54:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] commit-graph: don't show progress percentages while
 expanding reachable commits
Message-ID: <20190907185458.GA32028@syl.local>
References: <20190907045848.GA24515@sigill.intra.peff.net>
 <20190907050132.GA23904@sigill.intra.peff.net>
 <20190907103407.GF32087@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190907103407.GF32087@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 12:34:07PM +0200, SZEDER Gábor wrote:
> On Sat, Sep 07, 2019 at 01:01:33AM -0400, Jeff King wrote:
> > From: SZEDER Gábor <szeder.dev@gmail.com>
> >
> > Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> > progress, 2019-01-19) was a bit overeager when it added progress
> > percentages to the "Expanding reachable commits in commit graph" phase
> > as well, because most of the time the number of commits that phase has
> > to iterate over is not known in advance and grows significantly, and,
> > consequently, we end up with nonsensical numbers:
> >
> >   $ git commit-graph write --reachable
> >   Expanding reachable commits in commit graph: 138606% (824706/595), done.
> >   [...]
> >
> >   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
> >   Expanding reachable commits in commit graph: 81264400% (812644/1), done.
> >   [...]
> >
> > Even worse, because the percentage grows so quickly, the progress code
> > outputs much more often than it should (because it ticks every second,
> > or every 1%), slowing the whole process down. My time for "git
> > commit-graph write --reachable" on linux.git went from 13.463s to
> > 12.521s with this patch, ~7% savings.
>
> Oh, interesting.
>
> > Therefore, don't show progress percentages in the "Expanding reachable
> > commits in commit graph" phase.
> >
> > Note that the current code does sometimes do the right thing, if we
> > picked up all commits initially (e.g., omitting "--reachable" in a
> > fully-packed repository would get the correct count without any parent
> > traversal). So it may be possible to come up with a way to tell when we
> > could use a percentage here. But in the meantime, let's make sure we
> > robustly avoid printing nonsense.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Compared to the original from:
> >
> >   https://public-inbox.org/git/20190322102817.19708-1-szeder.dev@gmail.com/
> >
> > I rebased it to handle code movement, added in the timing data, and
> > tried to summarize the discussion from the thread.
>
> Thanks for resurrecting this patch and for the summary paragraph.

Thanks from me, as well. I noticed that we had achieved three billion
percent progress on the repository that brought this to our attention,
but didn't notice that you had already written these patches.

So, I am glad that they are getting the attribution that they deserve.
Thanks again both.

Thanks,
Taylor
