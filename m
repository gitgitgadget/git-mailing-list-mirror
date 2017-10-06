Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE67F1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 15:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdJFPmm (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 11:42:42 -0400
Received: from ikke.info ([178.21.113.177]:49454 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbdJFPml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 11:42:41 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 6B2E244039C; Fri,  6 Oct 2017 17:42:39 +0200 (CEST)
Date:   Fri, 6 Oct 2017 17:42:39 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Alexander Gehrke <alexander.gehrke@qwertyuiop.de>
Cc:     git@vger.kernel.org
Subject: Re: [bug] git add -p breaks, if color.ui is set to "always"
Message-ID: <20171006154239.GA9299@alpha.vpn.ikke.info>
References: <20171006124730.onetucvpt3btlali@wheatley.informatik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006124730.onetucvpt3btlali@wheatley.informatik.uni-wuerzburg.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 02:47:30PM +0200, Alexander Gehrke wrote:
> After an update to version 2.14.2 from 2.14.1 "git add --patch" stopped working
> for me, just producing the same output as "git diff", but not prompting to stage
> anything.
> 
> I found that unsetting the config key color.ui, which was set to "always" fixed
> the problem.
> 
> From the manpage, color.ui should not have that effect and "always" should be a
> legal value.
> 
> Regards
> Alexander Gehrke

Hello Alexander,

There have been a few mailing-list posts[0] about this already. While
git add -p should probably not have broken by this, setting ui.color to
always itself does not make a lot of sense either.

You are telling git to always output color, even when the target is
something that does not know what to do with the color codes. Setting it
to 'auto' would make more sense.

The thread I posted to discusses some changes that might get introduced
to improve the situation though.

Kevin.

[0}:https://public-inbox.org/git/20171003093157.gq7za2fwcqsouire@sigill.intra.peff.net/T/
