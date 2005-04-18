From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 11:36:48 +1000
Message-ID: <1113788210.11910.52.camel@localhost.localdomain>
References: <20050416131528.GB19908@elte.hu>
	 <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	 <1113780698.11910.8.camel@localhost.localdomain>
	 <20050417233936.GV1461@pasky.ji.cz>
	 <1113782805.11910.36.camel@localhost.localdomain>
	 <20050418003526.GD1461@pasky.ji.cz>
	 <Pine.LNX.4.58.0504171816040.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:33:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNL8h-0005cr-Jz
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDRBhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDRBhO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:37:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19914 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261583AbVDRBhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 21:37:07 -0400
Received: from [150.203.247.9] (helo=[172.24.3.18])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DNLCC-0003cJ-Lo; Mon, 18 Apr 2005 02:37:06 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171816040.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-17 at 18:16 -0700, Linus Torvalds wrote:
> Alternatively, you can have just the rev-tree cache of them. That's what
> it was designed for (along with avoiding to have to read 60,000 commits).

Purely from a conceptual POV I'd be a little happier with the history
just ending with a parent pointer to a commit object which is absent,
rather than having commit objects which point to _trees_ which are
absent. But I suppose I can't really justify that, and I'm not overly
bothered about it either.

The important thing to get right at this point is that the tree we all
work with should refer to the history, regardless of how we choose to
prune it. The current linux-2.6.git tree has a parentless commit for the
2.6.12-rc2 import, which is bad. We should start with Thomas' git tree
representing the real history, and work from that. You don't even need
to see his tree; you only need the final sha1 hash of the commit in his
tree which matches 2.6.12-rc2, so you can use that as the 'parent' of
the first change you import yourself.

-- 
dwmw2

