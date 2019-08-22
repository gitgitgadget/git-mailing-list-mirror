Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 485931F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfHVRTN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:19:13 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:41297 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbfHVRTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:19:12 -0400
Received: by mail-qk1-f171.google.com with SMTP id g17so5806494qkk.8
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hP+xKa6fNpa9f2yXOjD1okIrKTlq8wJ/2w/ukNWOOpE=;
        b=PfQZ8+V8dznO5rkBAYqcPrluxsuw7yRSQZv5faArP+QtcEJJyKmx7tFhnq7OdutasN
         fY8yBz6SzwnPaGpDAVnWjg0T1R3hKug2g29jcGF5Zdzh7q3dexcSBP5qXnCaTSyuKxzJ
         efo4d+cHCP9SlhfXu4Mxp/D3xrLwG5F0iUv7bi3N5tcdQqN3f6vNOTtDgv17FuHdVFP8
         yWac18uV/nBJ/rgoIg6OUfh1/VKXRbJX/vyMMXgA5ywJ/Ow2RZ2qMnlsP+e+Taln5sgF
         NuFb5ARJnL/phXFEEAMkaNRKNAJhjfEdYB/cE7wqI0wYVWoy2Fp0+PmLDq1TRJ4mxAoa
         oshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hP+xKa6fNpa9f2yXOjD1okIrKTlq8wJ/2w/ukNWOOpE=;
        b=ecsnyaaHp9RvIbhnNzjzGHhVebgcuoNa/0teJbawnig0Ku1aHzq6WkYfkMuxNXhoca
         bHhYMqK1ZjvO62N/F7i4BmZun9DcSV3aWqHoMyM8anikLN5nM40zNaAR7rw5qBQ7P/K2
         kk4RzUC9Nh++cemWkkhTK7P09iXLFnFvLGK2O3QhYLqlN6ylsPukya+xuGpsMy6XoATh
         0m05ZHAXPDYavbQypyfhJ7W/V6A5QCS/dO8vhFkL35d5vIn3Rxbw8oj5Wy7kJWMHgeLb
         YsClSJezG5UftH3tmJBz9uqi3Jmxfj7J6Flj1x97nbxgyGy3FbghtOAQt/+SmfdXaP37
         kjmg==
X-Gm-Message-State: APjAAAUTMNFet9KU6k3G3PIpVd2rsQcHNxBPmmPlC3VpDoIxZ0F2CT5r
        Fz/EcWnwsF5kuezEwwFDA7J94A==
X-Google-Smtp-Source: APXvYqwEFfuH7fwtUquHJZFJZVEmK5NXAAXsRUcReCZodxQlxmehQdMqTrGjakUjK4eHuzy3ea6Lug==
X-Received: by 2002:a05:620a:1345:: with SMTP id c5mr1640qkl.109.1566494351708;
        Thu, 22 Aug 2019 10:19:11 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:c8b3:58ce:c48c:b888])
        by smtp.gmail.com with ESMTPSA id m3sm154496qki.10.2019.08.22.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:19:11 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 22 Aug 2019 13:19:10 -0400
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Charles Diza <chdiza@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822171910.GA56780@syl.lan>
References: <20190822141928.GA3163@323642-phi-gmno-clahs>
 <20190822160702.GD20404@szeder.dev>
 <20190822162907.GA17013@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822162907.GA17013@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 12:29:08PM -0400, Jeff King wrote:
> On Thu, Aug 22, 2019 at 06:07:02PM +0200, SZEDER Gábor wrote:
>
> > On Thu, Aug 22, 2019 at 10:20:08AM -0400, Charles Diza wrote:
> > > By 2.22.1 at the latest (and continuing into 2.23.0) there is a
> > > problem with the display of progress indication during `git pull`
> > > (and possibly other commands, I don't know).
> > >
> > > I'm on macOS, and this happens in both Terminal.app and iTerm2.app,
> > > on both macOS 10.13.6 and 10.14.6:  In a standard 80-column wide
> > > terminal window, cd into a git repo and do `git pull`.  The chances
> > > are high (though not 100%) that one will see this:
> >
> > I noticed this today when pushing to GitHub (I suppose they have very
> > recently upgraded?) from Linux, so this is neither specific to 'git
> > pull' nor to macOS.
> >
> > I'm sure the culprits are commits cd1096b282 (pager: add a helper
> > function to clear the last line in the terminal, 2019-06-24) and
> > 5b12e3123b (progress: use term_clear_line(), 2019-06-24) with the
> > added complication of communicating with a remote.
>
> Yes, we moved to v2.22.1 last night. I'll revert those commits on our
> servers until we come up with a more permanent solution upstream.
>
> > I'm not sure how to handle the situation.  A few ideas to consider:
> >
> >   1. Update 'git upload-pack/receive-pack' to use some kind of magic
> >      character or char sequence instead of a "real" line clearing
> >      sequence, and update 'git pull/push' to replace that magic with
> >      the line clearing sequence appropriate for the terminal.
> >
> >   2. Variant of the above: leave 'git upload-pack/receive-pack' as they
> >      are now, and declare that those 80 spaces indicate when to clear
> >      progress lines.  Update 'git push/pull' to catch those 80 spaces,
> >      and replace them with the line clearing sequence appropriate for
> >      the terminal.
> >
> >   3. Update 'git pull/push' to explicitly tell the remote what line
> >      clearing sequence to use.
> >
> >   4. Revert, and go back to calculating how many spaces we need to
> >      append to clear the previously displayed progress line, and hope
> >      that we don't mess it up (or even if we do, it still won't be as
> >      noticable as this).
> >
> > I suppose this issue affects other git clients as well, so (1), (2),
> > and (3) might not even be an option.
>
> Yes on that final bit. We could always fall back to (4) if the terminal
> information is not available, but given that the benefit is mostly in
> simplifying the code, I don't know if it's worth carrying around _two_
> solutions.

My thoughts exactly. I think that I prefer the solutions in the order
{2, 1, 3, 4}, but (4) seems to be the most feasible by far.

Should we revert the series?

> One interesting bit: we have traditionally used \033[K on the _client_
> side of the sideband demuxer. So I think in the "remote:" case we were
> already handling this correctly, even before your patch.
>
> -Peff
Thanks,
Taylor
