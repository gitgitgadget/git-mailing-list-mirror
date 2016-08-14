Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E521F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 10:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbcHNKiI (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 06:38:08 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:54383 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290AbcHNKiI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2016 06:38:08 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 90489230D3;
	Sun, 14 Aug 2016 11:38:06 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 875C933DE;
	Sun, 14 Aug 2016 11:38:06 +0100 (BST)
X-Quarantine-ID: <hWXdW8qkeIek>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hWXdW8qkeIek; Sun, 14 Aug 2016 11:38:04 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id CDD30334C;
	Sun, 14 Aug 2016 11:38:01 +0100 (BST)
Date:	Sun, 14 Aug 2016 11:38:01 +0100
From:	John Keeping <john@keeping.me.uk>
To:	David Aguilar <davvid@gmail.com>
Cc:	Luis Gutierrez <luisgutz@gmail.com>, git@vger.kernel.org
Subject: Re: git-mergetool reverse file ordering
Message-ID: <20160814103801.tpixnskdsf5ycj66@john.keeping.me.uk>
References: <CAD8hE_yzNZDPkxRy8s4Fy2_dZN5ppWzLM_2xc01C-VAdR1Pj_g@mail.gmail.com>
 <20160814034221.GB21057@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160814034221.GB21057@gmail.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 08:42:21PM -0700, David Aguilar wrote:
> This use case makes me wonder whether the sorting we do here is
> something that should be opened up a bit so that the it's not
> quite so set in stone.
> 
> For example, an extension to the approach taken by this patch
> would be to have `mergetool.reverseOrder` git config boolean
> option that would tell us whether or not to use the "-r" flag
> when calling sort.
> 
> But, IMO that is too rigid, and only addresses this narrow use
> case.  What if users want a case-insensitive sort, or some other
> preferred ordering?
> 
> We can address these concerns, and your use case, by opening it
> up. Something like,
> 
> 	sort=$(git config mergetool.sort || echo sort -u)

Why not reuse the existing diff.orderFile config variable?  (Also
supported by the -O option to git-diff).
