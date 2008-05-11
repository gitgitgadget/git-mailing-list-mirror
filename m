From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: expand svn:keywords, or how else to deal with them?
Date: Sun, 11 May 2008 01:45:58 -0700
Message-ID: <20080511084558.GC23929@untitled>
References: <20080509101919.GA25037@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 11 10:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv7Cy-0004pi-6A
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 10:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbYEKIqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 04:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYEKIqA
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 04:46:00 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53295 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbYEKIp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 04:45:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B264D2DC08B;
	Sun, 11 May 2008 01:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080509101919.GA25037@lapse.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81750>

martin f krafft <madduck@madduck.net> wrote:
> Hi,
> 
> I am using git-svn to track an upstream SVN project, which I then
> package for Debian. Upstream uses $Id:$ all over the source code,
> but I am not ready to argue with him that this ought to be removed.
> 
> The problem is that I build the Debian packages out of the git-svn
> tree, but use the published tarball. The latter has $Id:$ expanded
> in all files, while the git-svn tree does not - git-svn does not
> expand them.
> 
> The result is that my Debianisation diff now reverts the expansion
> for every single file. This is quite ugly.
> 
> I realise there are ways to prevent this, but I think that the
> cleanest would be if git-svn could be taught to expand svn:keywords.

*shudder*

> Is this something you could live with, Eric? I am willing to have
> a go at the patch, but my Perl-foo is crap, so I may well fail...

I'll accept a patch for it only if it's optional :)  Just the thought of
having to do keyword (un)expansion in git-svn is scary; so I'm not
willing to do it myself.

I'm mainly uncomfortable with how it'll interact with dcommit usage, but
since your use case seems to be fetch-only; you may just disable dcommit
if keyword expansion is enabled if it's too painful to figure out the
unexpansion...

-- 
Eric Wong
