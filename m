Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307381FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 01:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbcLLB6a (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 20:58:30 -0500
Received: from ozlabs.org ([103.22.144.67]:52123 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753231AbcLLB62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 20:58:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcQwg1ptmz9t1Q; Mon, 12 Dec 2016 12:58:27 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 11:39:19 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Stefan Dotterweich <stefandotterweich@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitk: Fix missing commits when using -S or -G
Message-ID: <20161212003919.GE18316@fergus.ozlabs.ibm.com>
References: <572C8665.8090707@gmx.de>
 <572C8B36.2000106@gmx.de>
 <20160509034519.GC12515@fergus.ozlabs.ibm.com>
 <fea42c3e-a028-3204-690f-88843d31c264@gmx.de>
 <1f857709-3c47-d4a1-b858-3288347416f8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f857709-3c47-d4a1-b858-3288347416f8@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 04, 2016 at 10:47:16AM +0200, Stefan Dotterweich wrote:
> When -S or -G is used as a filter option, the resulting commit list
> rarely contains all matching commits. Only a certain number of commits
> are displayed and the rest are missing.
> 
> "git log --boundary -S" does not return as many boundary commits as you
> might expect. gitk makes up for this in closevargs() by adding missing
> parent (boundary) commits. However, it does not change $numcommits,
> which limits how many commits are shown. In the end, some commits at the
> end of the commit list are simply not shown.
> 
> Change $numcommits whenever a missing parent is added.
> 
> Signed-off-by: Stefan Dotterweich <stefandotterweich@gmx.de>

Thanks, applied, with slight tweaks to the commit message.

Paul.
