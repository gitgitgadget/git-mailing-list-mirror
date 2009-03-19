From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Adding History
Date: Thu, 19 Mar 2009 10:47:32 -0700
Message-ID: <20090319174732.GS23521@spearce.org>
References: <loom.20090319T173541-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roger Garvin <yoyodyn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:49:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkMMe-0004lo-NG
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139AbZCSRre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 13:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755029AbZCSRre
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:47:34 -0400
Received: from george.spearce.org ([209.20.77.23]:44854 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbZCSRrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 13:47:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4395D38221; Thu, 19 Mar 2009 17:47:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20090319T173541-173@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113800>

Roger Garvin <yoyodyn@gmail.com> wrote:
> Is there a way to add history to a repository?
> We have just started using git, where before we had nothing but backup
> directories all over the place.  We created the git repository using our
> existing source directory.  Is there a way to now go and add some of the backup
> source directories to the history?  Or would this break all the SHA1 of the
> current objects?

Right, you need to change the SHA-1 of all of the commits in order
to insert history in the past.

> I am not sure it would be worth it at this point.  But we are
> still pretty early in our use of git so now would be the easiest time.  

You have two options:

- Use git-filter-branch now to rewrite your commits with the
history added.  Its a one-time pain that you need to go through to
discard all of your current objects, and move to the new ones that
have the history.

- Keep the current objects, but if you need the history, add it
to the local repository by editing the grafts file.  This is how
the Linux kernel team can insert history that predates Git, if
they absolutely must have it.

It depends on how often you need to look at that history.  If its
"almost never", I would probably go with the graft.  If its "often",
I would consider the filter-branch now.

-- 
Shawn.
