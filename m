From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 17:04:09 -0700
Message-ID: <7vlkckw8zq.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
	<20070809165218.9b76ebf7.seanlkml@sympatico.ca>
	<alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
	<7vtzr8wemb.fsf@assigned-by-dhcp.cox.net>
	<7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJHzG-00032N-ER
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbXHJAEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbXHJAEP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:04:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43931 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbXHJAEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 20:04:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810000410.TDXK1335.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 20:04:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a0491X00T1kojtg0000000; Thu, 09 Aug 2007 20:04:10 -0400
In-Reply-To: <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Aug 2007 16:38:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55487>

Junio C Hamano <gitster@pobox.com> writes:

> While I do not think the previous one was hacky at all, this one
> IS a hack, not meant for inclusion.  It makes the partial commit
> codepath to use vanilla "git read-tree" without any single tree
> merge semantics, and rewrite that codepath to use read_tree()
> which was changed with my previous patch.

Just in case anybody is wondering, this also passed all the
existing tests.  Maybe it is going in the right direction of
slowly moving away from unpack_trees() where we can.  I dunno.

I also do not know if it "fixes" the performance issue on that
testcase.
