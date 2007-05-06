From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 'upstream' branches.
Date: Sun, 06 May 2007 09:39:19 +0100
Message-ID: <1178440759.17680.112.camel@shinybook.infradead.org>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	 <20070505174416.GA2898@steel.home>
	 <1178387429.17680.35.camel@shinybook.infradead.org>
	 <20070505225249.GE2898@steel.home>
	 <7v3b2ah30f.fsf@assigned-by-dhcp.cox.net>
	 <1178436926.17680.74.camel@shinybook.infradead.org>
	 <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 10:39:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkcGn-0008PN-Ck
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbXEFIjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 04:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbXEFIjB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:39:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54377 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbXEFIjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 04:39:00 -0400
Received: from shinybook.infradead.org ([90.155.92.197])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HkcGf-0007h6-IT; Sun, 06 May 2007 09:38:57 +0100
In-Reply-To: <7vy7k2e606.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46316>

On Sun, 2007-05-06 at 01:00 -0700, Junio C Hamano wrote:
> Ahh, I did not mean by "mtd's idea" _your_ repository, but I
> meant whichever one that was overwriting your 'linus' tracking
> branch you are using to track fetch from Linus's tree.

Ah, right.

> The cleanest way to view "what do we really have since the
> latest of Linus, regardless of how and from whom we learned
> where the tip of Linus is", would be not to let other trees to
> disturb the tracking branch you use for Linus's tree with each
> other.
> 
> 	[remote "a"] fetch = refs/heads/linus:refs/remotes/a/linus
> 	[remote "b"] fetch = refs/heads/linus:refs/remotes/b/linus
> 	[remote "c"] fetch = refs/heads/linus:refs/remotes/c/linus
> 	...

You're speaking from the point of view of the git implementation.
>From the point of view of the _user_, I would violently disagree :)

Having pulled that into my local repository, how do I then set it up to
push the latest commit of refs/remotes/*/linus into the 'linus' branch
of the origin, when I push back to my public tree on the server? Or do
you expect _everyone_ who pulls from that public tree to also do stuff
like:
> 	git log master --not remotes/a/linus remotes/b/linus remotes/c/linus


Can't I instruct it to _merge_ the 'linus' branch of each remote into my
own 'linus' branch? Of course that merge would only ever be a
fast-forward or a no-op, in practice.

-- 
dwmw2
