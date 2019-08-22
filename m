Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777721F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbfHVRQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:16:12 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:33594 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbfHVRQL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:16:11 -0400
Received: by mail-qt1-f178.google.com with SMTP id v38so8632058qtb.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mUQHNSpbp9lkqjIdVEIf7OsfGZh2P7Mi/6mqh+MZOiA=;
        b=xEtLVqpNS2cmYNWh1S1Wb0k1JrXAnoR6Oo8rCY+LQx17dgywJYAqpFfIZHzFEhJV2D
         O1YAupdPifLX33Qwy754SPPyQqZJEWYs8ltR4ToFRiI8fg20YoQCMxTVVn4vWq1ag5m0
         90+4TFkgEe90d+0urL3/t2WIcJdbIMkADNb0f9Xn6e3d4XLStmwJD7Wpbqpd4c17O2r9
         ZbcqqAYO+PiYcx0DoX6L7nkdJU7PshTwSrmscilyMQClJ/vhPJx/aeeb99XAm50+uS5H
         60UeHNUGZU0pofUiPIxmlA40pfTM6W7/dvEET4uAKO5hUWlv/WR8Fx0glxZJfet7rzuO
         BxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mUQHNSpbp9lkqjIdVEIf7OsfGZh2P7Mi/6mqh+MZOiA=;
        b=W6hBv+XaFlGHqUR5bJyngRKVO7a4ZM1ZRmpuiSIi9rjuKuc4paS/BPPOsO4dUQIjbd
         gOCYrDWMxiZYPNeqnAsDMwOgm6BLdtnjK1fydQYgEpvWm5x8rWqin+x76wquZQRHhSnB
         eMckSFbpx/77QIoc5qyQRiy7EfZBlihjFeKZLWcTDWRlyMLHJDqS9qrgbd9yJbVChJMf
         dSGNNAZlHFnHPuDiRvz0oLj+3oXW8gaULehoMPq7KW1FAnFEhIuVA0gXvtW3RIXJ3h18
         FK435HIhBrzAg2OcN7j493aCjdREt4fUcBzOIavI0VA65vX0rE5iBjSFZyg+QAj8vYZ8
         NrQw==
X-Gm-Message-State: APjAAAWz6yUjG6tnhNJdf9g4imjXDkQSeaAQnxNdLMJORmPiGqq/BGPX
        4HgBlvisdjqnPlpcp3hZBnvcaA==
X-Google-Smtp-Source: APXvYqzDZgf+VP5z6C81D9g9KrvT9GznyJPfQRDgS0A5pSkGz2Bzh5dtPgF6fiHuuQQK9ruefKo5Ew==
X-Received: by 2002:ac8:6105:: with SMTP id a5mr654827qtm.285.1566494170636;
        Thu, 22 Aug 2019 10:16:10 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:c8b3:58ce:c48c:b888])
        by smtp.gmail.com with ESMTPSA id z186sm148694qkb.2.2019.08.22.10.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:16:10 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 22 Aug 2019 13:16:09 -0400
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Charles Diza <chdiza@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822171609.GA56720@syl.lan>
References: <20190822141928.GA3163@323642-phi-gmno-clahs>
 <20190822160702.GD20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822160702.GD20404@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Aug 22, 2019 at 06:07:02PM +0200, SZEDER Gábor wrote:
> On Thu, Aug 22, 2019 at 10:20:08AM -0400, Charles Diza wrote:
> > By 2.22.1 at the latest (and continuing into 2.23.0) there is a
> > problem with the display of progress indication during `git pull`
> > (and possibly other commands, I don't know).
> >
> > I'm on macOS, and this happens in both Terminal.app and iTerm2.app,
> > on both macOS 10.13.6 and 10.14.6:  In a standard 80-column wide
> > terminal window, cd into a git repo and do `git pull`.  The chances
> > are high (though not 100%) that one will see this:
>
> I noticed this today when pushing to GitHub (I suppose they have very
> recently upgraded?) from Linux, so this is neither specific to 'git
> pull' nor to macOS.

There's already lots of discussion later on in the thread (which I'm
reading now), but I just wanted to reply to this hunk to say 'thanks'
for pointing out the issue in the first place.

> I'm sure the culprits are commits cd1096b282 (pager: add a helper
> function to clear the last line in the terminal, 2019-06-24) and
> 5b12e3123b (progress: use term_clear_line(), 2019-06-24) with the
> added complication of communicating with a remote.

Thanks also for pointing out the culprits here and saving me a
bisection.

If you're curious, I only reverted 5b12e3123b (progress: use
term_clear_line(), 2019-06-24), not the former.

> [snip]


Thanks,
Taylor
