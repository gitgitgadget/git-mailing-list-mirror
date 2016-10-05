Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E19520986
	for <e@80x24.org>; Wed,  5 Oct 2016 02:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbcJECmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 22:42:36 -0400
Received: from pug.qqx.org ([159.203.87.81]:33448 "EHLO pug.qqx.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbcJECmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 22:42:36 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Oct 2016 22:42:36 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
        id 6EC6720BE1; Tue,  4 Oct 2016 22:34:55 -0400 (EDT)
Date:   Tue, 4 Oct 2016 22:34:55 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 18/18] alternates: use fspathcmp to detect duplicates
Message-ID: <20161005023455.GA6215@pug.qqx.org>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
User-Agent: Mutt/1.7+57 (g134b9db) (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 16:36 -0400 03 Oct 2016, Jeff King <peff@peff.net> wrote:
>On a case-insensitive filesystem, we should realize that
>"a/objects" and "A/objects" are the same path.

The current repository being on a case-insensitive filesystem doesn't 
guarantee that the alternates are as well.

On the other hand, I suspect that people who use a case-insensitive 
filesystem would be less likely to use names which differ only by case.
