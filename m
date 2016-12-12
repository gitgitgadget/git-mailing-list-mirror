Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE3D1FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 09:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbcLLJvf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 04:51:35 -0500
Received: from ozlabs.org ([103.22.144.67]:58729 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753403AbcLLJv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 04:51:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcdQQ6gl7z9t0v; Mon, 12 Dec 2016 20:51:26 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 20:51:19 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Markus Hitter <mah@jump-ing.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] gitk: memory consumption improvements
Message-ID: <20161212095119.GF20934@fergus.ozlabs.ibm.com>
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 07:54:28PM +0100, Markus Hitter wrote:
> 
> List, Paul,
> 
> after searching for a while on why Gitk sometimes consumes exorbitant amounts of memory I found a pair of minor issues and also a big one: the text widget comes with an unlimited undo manager, which is turned on be default. Considering that each line is inserted seperately, this piles up a huuuge undo stack ... for a read-only text widget. Simply turning off this undo manager saves about 95% of memory when viewing large commits (with tens of thousands of diff lines).
> 
> 3 patches are about to follow:
> 
>  - turn off the undo manager,
> 
>  - forget already closed file descriptors and
> 
>  - forget the 'commitinfo' array on a reload to enforce reloading it.
> 
> I hope this finds you appreciation.

Thanks for the good work in tracking this down and making the patches.
I have applied the series.  Apologies for slow response (life has been
extremely busy for me this year).

Paul.
