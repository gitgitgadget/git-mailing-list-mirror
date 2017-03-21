Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E3F2095D
	for <e@80x24.org>; Tue, 21 Mar 2017 17:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbdCURAy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:00:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:48705 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933610AbdCURAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:00:16 -0400
Received: (qmail 6065 invoked by uid 109); 21 Mar 2017 17:00:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 17:00:09 +0000
Received: (qmail 16462 invoked by uid 111); 21 Mar 2017 17:00:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 13:00:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 13:00:05 -0400
Date:   Tue, 21 Mar 2017 13:00:05 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick --message?
Message-ID: <20170321170005.35ryjh4pr3jvvmx3@sigill.intra.peff.net>
References: <20170321160520.GA15550@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321160520.GA15550@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 05:05:20PM +0100, Andreas Krey wrote:

> Hi all,
> 
> I have an slightly unusual usecase for cherry-pick:
> I want to modify the commit message that is used in the process,
> e.g. do an d/^PROP:/ on it, but unfortunately -m does something
> else here.
> 
> And there is no --message here for good reason, as cherry-pick
> can pick multiple commits and so on. Bad for me, though.
> 
> So, am I down to the combo of format-patch and apply, or is there
> an easier way? (I'd also like to end up in the same state as with
> cherry-pick should there be conflicts.)

There's "cherry-pick --edit".

I had to look it up, though. For a single message I'd have probably done
"git cherry-pick $commit && git commit --amend". For multiple I'd just
cherry-pick them all first, then follow-up with "git rebase -i".

-Peff
