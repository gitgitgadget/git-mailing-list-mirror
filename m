From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-stash
Date: Mon, 2 Jul 2007 00:08:00 -0400
Message-ID: <20070702040800.GA17384@coredump.intra.peff.net>
References: <20070701080757.GA6093@coredump.intra.peff.net> <200707010910.l619A23c027837@mi0.bluebottle.com> <20070701091905.GA13559@coredump.intra.peff.net> <7vps3b4xcj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 06:08:18 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5DCy-0006Tp-2n
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 06:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbXGBEIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 00:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbXGBEIE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 00:08:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2571 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbXGBEID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 00:08:03 -0400
Received: (qmail 10562 invoked from network); 2 Jul 2007 04:08:23 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 Jul 2007 04:08:23 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2007 00:08:00 -0400
Content-Disposition: inline
In-Reply-To: <7vps3b4xcj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51338>

On Sun, Jul 01, 2007 at 02:39:56PM -0700, Junio C Hamano wrote:

> For paths that are cleanly merged with this three-way merge,
> merge-recursive updates the working tree and the index.  That
> means if you do "git diff", you would not see the local changes
> that were carried forward would not be visible, and you would
> need "git diff HEAD" to view them.  I found it confusing, and
> that was the suggestion I sent was about.  Nana's "3rd try", which
> I applied and pushed to 'next', addresses this issue by running
> "read-tree --reset $c_tree" (where $c_tree is the contents of
> the index before replaying the stash).
> 
> This is not ideal.  We would want to see "git diff" for such a
> path show difference similar to difference between I and W.

Ah, I get it now. Thanks for the explanation.

I see you gutted the confusing text from the manpage...I think what you
have now is conceptually much simpler, and it won't bite anyone unless
they are trying to do something clever with the index. In which case I
hope they will be able to use the description of how the stash is stored
to poke around.

-Peff
