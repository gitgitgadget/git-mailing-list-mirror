Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB6B1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfH1PFc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:05:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:59648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726315AbfH1PFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:05:31 -0400
Received: (qmail 13753 invoked by uid 109); 28 Aug 2019 15:05:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Aug 2019 15:05:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11716 invoked by uid 111); 28 Aug 2019 15:06:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2019 11:06:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Aug 2019 11:05:30 -0400
From:   Jeff King <peff@peff.net>
To:     Vipul <finn02@disroot.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
Message-ID: <20190828150530.GD14432@sigill.intra.peff.net>
References: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
 <20190827190509.GB3150@sigill.intra.peff.net>
 <664344cb-f9e4-d4fc-fd14-620e3e10157a@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <664344cb-f9e4-d4fc-fd14-620e3e10157a@disroot.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 10:42:03PM +0000, Vipul wrote:

> Jeff King wrote:
> > The usual philosophy in Git is not to bother the user with
> > confirmations, but to allow recovery after a mistake.
> > 
> 
> Well, always prompting for confirmation will be annoying for some people
> specially who are mastered in git but, may be very useful feature for
> beginner's to avoid them from making mistakes. May be, this feature will
> be disabled by default and users have to set some config variable (like
> other git-config variable for example help.autocorrect etc) in global
> gitconfig file.

Sure, I think there's an argument to be made for confirmations (though I
personally would not want them). I was just describing what Git has now.

> > Note that there _are_ some commands which are not reversible: mostly
> > things that drop content from the working tree. So "git reset --hard" is
> > one, and "git clean" is another. There have been discussions and even
> > some patches about storing the lost in an "undo log", but nothing has
> > been merged.
> >
> Seems like a good idea. Are they ever gonna merge? If no, why? Or, it
> will merge in next feature release.

I don't know the latest state. A quick search of the archive showed this
as the latest version:

  https://public-inbox.org/git/20181209104419.12639-1-pclouds@gmail.com/

-Peff
