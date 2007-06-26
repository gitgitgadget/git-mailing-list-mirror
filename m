From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: error: wrong index file size in
	/usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.idx
Date: Tue, 26 Jun 2007 21:55:15 +0100
Message-ID: <1182891315.3263.47.camel@shinybook.infradead.org>
References: <001401c7b82d$106f30b0$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tjernlund <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Tue Jun 26 22:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3I3e-0005ez-1S
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 22:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434AbXFZUyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 16:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757235AbXFZUyi
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 16:54:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49268 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbXFZUyi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 16:54:38 -0400
Received: from shinybook.infradead.org ([90.155.92.197])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I3I3Y-0002AP-FZ; Tue, 26 Jun 2007 21:54:36 +0100
In-Reply-To: <001401c7b82d$106f30b0$0e67a8c0@Jocke>
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50974>

On Tue, 2007-06-26 at 22:03 +0200, Tjernlund wrote:
> Did this and got a small error that I don't think should be there:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
> 
> cd linux-2.6
> git gc
> cd ..
> 
> git clone --reference linux-2.6 ssh://git.infradead.org/~/public_git/jffs2_mtd_patches

Your jffs2_mtd_patches tree is just a clone of
git://git.infradead.org/mtd-2.6.git, isn't it?

I get the same error when cloning that:

pmac /home/dwmw2/x $ git-clone --reference /pmac/git/linux-2.6 git://git.infradead.org/mtd-2.6.git
Initialized empty Git repository in /home/dwmw2/x/mtd-2.6/.git/
remote: Generating pack...
remote: Done counting 0 objects.
remote: Total 0 (delta 0), reused 0 (delta 0)
Indexing 0 objects...
error: wrong index file size in /home/dwmw2/x/mtd-2.6/.git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.idx
Checking 21649 files out...
 100% (21649/21649) done

The mtd-2.6.git tree has _no_ objects of its own at the moment; I've
committed nothing since Linus' last pull, and there's a weekly
'git-repack -a -l -d', which will remove any local objects which are
already in git://git.infradead.org/linux-2.6.git. Cloning linux-2.6.git
from there works fine, but cloning mtd-2.6.git shows the above error.

-- 
dwmw2
