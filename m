From: Eric Wong <normalperson@yhbt.net>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 1 Feb 2007 11:36:47 -0800
Message-ID: <20070201193647.GA18234@soma>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702010157.51452.jnareb@gmail.com> <45C19DD0.20504@fs.ei.tum.de> <Pine.LNX.4.63.0702011108430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C1BDD3.8050103@fs.ei.tum.de> <Pine.LNX.4.64.0702010814470.3632@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 20:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HChji-0007dj-8y
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 20:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbXBATgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 14:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbXBATgm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 14:36:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:49573 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422961AbXBATgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 14:36:41 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id CD3637DC094;
	Thu,  1 Feb 2007 11:36:39 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 01 Feb 2007 11:36:47 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702010814470.3632@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38393>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 1 Feb 2007, Simon 'corecode' Schubert wrote:
> >
> > > So, can you explain to me how a filename is _not_ a file-id?
> > 
> > It is not a file-id like other SCM use it (I think monotone, not sure though).
> > If you copy/move the content to a new name, the ID will not stay the same.
> > Just see it as a hash bucket which allows you easy access to the history for a
> > file currently with this name.
> 
> Well, that's actually just another "file ID" too. It's just not an "inode 
> number" kind of file ID, it's more the "CVS file ID" kind of ID.
> 
> SVN uses "inode numbers" (I think they are just UUID's generated at "svn 
> add" time, but I'm not sure) to track file ID's across renames. Some other 
> SCM's do the same.

I think you got this part confused with GNU Arch (and possibly
Bzr).  SVN tracks renames in the changeset, it records (in the log)
a copy and delete.  pathname@revision is the only "file ID" I know
about in SVN.

-- 
Eric Wong
