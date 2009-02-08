From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: tool and worktree
Date: Sun, 8 Feb 2009 11:25:28 -0800
Message-ID: <20090208192528.GC30557@spearce.org>
References: <20090208034406.GB7230@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 20:27:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFJ4-0004oB-Hb
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 20:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbZBHTZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZBHTZ3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 14:25:29 -0500
Received: from george.spearce.org ([209.20.77.23]:59970 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbZBHTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 14:25:28 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 441DB38210; Sun,  8 Feb 2009 19:25:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090208034406.GB7230@b2j>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109001>

bill lam <cbill.lam@gmail.com> wrote:
> I track /etc using a config
> 
> [core]
> 	repositoryformatversion = 0
> 	filemode = true
> 	bare = false
> 	worktree = /etc
> 	logAllRefUpdates = true
> 	excludesfile =
> 
> But that can not be handled by tools,
> 
> git gui : cannot use funny .git directory .

If someone sends patches for git-gui, maybe.  This use case of
different repository and worktree isn't very common for git-gui
so it doesn't support it.

On Windows with some versions of Tcl/Tk I've had trouble in the
past with Git finding the repository when forked out of the wish
process.  To work around it I just required that the repository
be in ".git".

Have you tried making /etc/.git a symlink to the real repository?

BTW, tracking /etc/ in git won't track permissions and ownership
so restoring /etc from git isn't enough on its own.  Usually I
use some sort of shell script to copy /etc to another location
and check it into git, and a different script to go the other way,
with that script handling mode and ownership as it goes.

-- 
Shawn.
