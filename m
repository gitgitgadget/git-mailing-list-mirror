From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 11:26:36 +1000
Message-ID: <1114392397.3419.97.camel@localhost.localdomain>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
	 <426A4669.7080500@ppp0.net>
	 <1114266083.3419.40.camel@localhost.localdomain>
	 <426A5BFC.1020507@ppp0.net>
	 <1114266907.3419.43.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 03:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsJH-00040q-9V
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVDYB1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVDYB1q
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:27:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9359 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262401AbVDYB1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 21:27:43 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DPsNr-0008O6-HB; Mon, 25 Apr 2005 02:27:36 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 10:31 -0700, Linus Torvalds wrote:
> In other words, I actually want to create "tag objects", the same way we 
> have "commit objects". A tag object points to a commit object, but in 
> addition it contains the tag name _and_ the digital signature of whoever 
> created the tag.

I'm slightly concerned that to find a given tag by its name if we do
_just_ the above would be a fairly slow process. I suspect you'll want
a .git/tags/ directory _anyway_, but with named files which refer to tag
objects, instead of directly to commit objects as in Petr's current
implementation.

Other operations we might want to be at least _reasonably_ efficient
would include 'show me the latest tag from Linus' and 'show me all
extant tags'.

-- 
dwmw2

