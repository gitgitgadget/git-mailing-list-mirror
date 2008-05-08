From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking
	branches
Date: Wed, 7 May 2008 21:58:06 -0400
Message-ID: <20080508015806.GA759@pe.Belkin>
References: <20080508013956.GA24956@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu May 08 04:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtvWU-0006qE-0N
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 04:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbYEHCF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 22:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbYEHCF3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 22:05:29 -0400
Received: from eastrmmtao106.cox.net ([68.230.240.48]:46159 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258AbYEHCF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 22:05:28 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2008 22:05:27 EDT
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20080508015805.TCMI24465.eastrmmtao103.cox.net@eastrmimpo01.cox.net>;
          Wed, 7 May 2008 21:58:05 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo01.cox.net with bizsmtp
	id Npy61Z00D0epFYL02py66J; Wed, 07 May 2008 21:58:06 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1JtvOY-0000DQ-AU; Wed, 07 May 2008 21:58:06 -0400
Content-Disposition: inline
In-Reply-To: <20080508013956.GA24956@midwinter.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81498>

On Wed, May 07, 2008 at 06:39:56PM -0700, Steven Grimm wrote:
> In environments where a lot of people are sharing an svn repository using
> git-svn, everyone has identical, but individually maintained, tracking
> branches. If the svn repository is very active, it can take a while to
> run "git svn fetch" (which has to individually construct each revision
> by querying the svn server). It's much faster to run "git fetch" against
> another git-svn repository to grab the exact same git revisions you'd get
> from "git svn fetch". But until now, git-svn was confused by this because
> it didn't know how to incrementally rebuild its map of revision IDs.
> The only choice was to completely remove the map file and rebuild it
> from scratch, possibly a lengthy operation when there's a lot of history.
> 
> With this change, git-svn will try to do an incremental update of its
> revision map if it sees that its tracking branch has svn revisions that
> aren't in the map yet.

Since I'm not qualified to review the patch technically , I'll just
offer encouragement, comment and question.  First, nice work, this
seems like a very helpful feature.  It might go quite a way toward
enabling a semi-distributed workflow with an authoritative svn
upstream.

Second, what will happen when different developers have svn URLs with
different schemes, e.g. http vs. svn+ssh?

Third, I think such a feature surely deserves a mention in
git-svn.txt.

-chris
