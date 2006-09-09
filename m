From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 13:31:32 +1000
Message-ID: <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<17666.4936.894588.825011@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 05:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLtZg-0003nH-0j
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 05:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWIIDb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 23:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWIIDb4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 23:31:56 -0400
Received: from ozlabs.org ([203.10.76.45]:37779 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932108AbWIIDbz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 23:31:55 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B12D067BA9; Sat,  9 Sep 2006 13:31:53 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26734>

Linus Torvalds writes:

> Right. This is why I would suggest just recomputing the thing entirely, 
> instead of trying to make it incremental. It would definitely cause 
> re-organization of the tree when you find a new relationship between two 
> old commits that basically creates a new orderign between them.

I think it may be possible to back up the layout algorithm to the row
where the parent is and redo it from there down.

Interestingly, I only see two commits out of order on the linux-2.6
repository, but on the full history (up to linux-2.6.12-rc2) I see
520.

> The menu would help, of course. But it would be even nicer if you'd be 
> able to make do without the --topo-order.

The graph does seem to look a little nicer with --topo-order, in that
it tends to do a whole string of commits on a single branch in a
bunch, whereas without --topo-order it seems to hop from branch to
branch more.

Paul.
