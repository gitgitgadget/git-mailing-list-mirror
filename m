Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC471FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 15:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbcLNPG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 10:06:28 -0500
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:37242 "HELO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755004AbcLNPG0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Dec 2016 10:06:26 -0500
Received: (qmail 25734 invoked by uid 0); 14 Dec 2016 15:01:06 -0000
Received: from unknown (HELO cmgw3) (10.0.90.84)
  by gproxy5.mail.unifiedlayer.com with SMTP; 14 Dec 2016 15:01:06 -0000
Received: from box531.bluehost.com ([74.220.219.131])
        by cmgw3 with 
        id Kr0D1u02P2qhmhE01r0JCJ; Wed, 14 Dec 2016 08:00:29 -0700
X-Authority-Analysis: v=2.1 cv=G8WPTbU5 c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=n5n_aSjo0skA:10 a=hdC90xl3CoTQOJZ-95oA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:
        Message-ID; bh=vLHvPk18MJRO/LW5PDkdBvHnmP42s4OumxVwp5x0WIw=; b=mA/doKAjyclgdJ
        f3LWzQuK0iAY6tX/3vVdwR4LljBxwiQkp1XWXoicTqrt+laf4obKQhb8wh7k+GQv6PKWitgPifdbc
        bLzAj9w52U+jMeJahWqyDqMbIyljF/qPSH0yi;
Received: from pool-173-76-103-90.bstnma.fios.verizon.net ([173.76.103.90]:44444 helo=homebase)
        by box531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_1)
        (envelope-from <paul@mad-scientist.net>)
        id 1cHB2T-00073B-4t; Wed, 14 Dec 2016 08:00:13 -0700
Message-ID: <1481727610.4552.8.camel@mad-scientist.net>
Subject: Re: git stash filename - stashing single files.
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Jeff King <peff@peff.net>, Jonas Hartmann <jh@ht-studios.de>
Cc:     git@vger.kernel.org
Date:   Wed, 14 Dec 2016 10:00:10 -0500
In-Reply-To: <20161214144444.k4v64accedl6xvho@sigill.intra.peff.net>
References: <b528e23b-c763-846e-4040-504a58b690fd@ht-studios.de>
         <20161214144444.k4v64accedl6xvho@sigill.intra.peff.net>
Organization: Please remain calm: I may be mad but I am a professional --
 Mad Scientist
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.1-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box531.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 173.76.103.90
X-Exim-ID: 1cHB2T-00073B-4t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-173-76-103-90.bstnma.fios.verizon.net (homebase) [173.76.103.90]:44444
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTMxLmJsdWVob3N0LmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-12-14 at 09:44 -0500, Jeff King wrote:
> Personally, I think this is a pretty terrible interface. Besides the
> fact that I have never written a stash message in all my years of using
> git, it's totally inconsistent with the rest of git (which would use
> "-m" for the message, and treat arguments as pathspecs).

I agree that this is a terrible (and inconsistent) interface and I would
love to see it changed.

I do use messages on stashes all the time (because I can never remember
their context a week later without a hint--just looking at the diff is
not enough for me) but I would welcome this change.  Definitely the
first step would be introducing the "-m" option so people and tools
could begin the switch to using it.
