From: Ben Jackson <ben@ben.com>
Subject: Re: "git svn reset" only resets current branch ?
Date: Mon, 6 Jul 2009 14:56:20 -0700
Message-ID: <20090706215619.GA38984@kronos.home.ben.com>
References: <43948.10.0.0.1.1246874857.squirrel@intranet.linagora.com> <20090706212928.GA11043@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@linagora.com>, git@vger.kernel.org,
	Ben Jackson <ben@ben.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 06 23:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNwAs-00027k-Ue
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 23:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbZGFV4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbZGFV4X
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 17:56:23 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:57197 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbZGFV4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 17:56:23 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n66LuLek039888;
	Mon, 6 Jul 2009 14:56:21 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n66LuKtO039887;
	Mon, 6 Jul 2009 14:56:20 -0700 (PDT)
	(envelope-from bjj)
Content-Disposition: inline
In-Reply-To: <20090706212928.GA11043@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122802>

On Mon, Jul 06, 2009 at 02:29:28PM -0700, Eric Wong wrote:
> Yann Dirson <ydirson@linagora.com> wrote:
> > I just tried the new "git svn reset" from master, and got puzzled that
> > only the svn branch which is an ancestor of current git HEAD got rolled
> > back.  Is that the expected behaviour ?  It would not make it very easy to
> > fixup imports from svn trees with lots of branches/tags.
> 
> Ben was the original implementer of this idea, so I'm not sure of his
> reasoning behind it.  For one, it's easier to only roll back one svn
> branch.  Perhaps adding an --all flag to this command would be the best
> way to go?

The only SVN repos I use git-svn with are either too huge and complex to
fully import with git (up to r135000 at work) or too small to have any
branches (all the various open source projects I've git-svn cloned).  So
the main reason it works that way is that I've never really used git-svn
with branches.

Eric,

Do you expect that it would work to reset one branch and re-fetch it
without touching the other branches?  If not, it would probably imply:

Should cmd_reset always loop over all remotes like cmd_multi_fetch?

As the "opposite of fetch" should it take '--all' and conditionally
loop?

Yann,

It would help if you made a test case (or extended t9139-git-svn-reset.sh)
that illustrated the problem and the desired behavior.

-- 
Ben Jackson AD7GD
<ben@ben.com>
http://www.ben.com/
