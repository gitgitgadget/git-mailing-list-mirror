From: David Madore <david+news@madore.org>
Subject: how to display a simplified graph of commits ?
Date: Mon, 29 Mar 2010 15:24:39 +0200
Message-ID: <20100329132439.GA734@aldebaran.xn--kwg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 15:34:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwF6L-0004bG-2a
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 15:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab0C2Ndw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 09:33:52 -0400
Received: from aldebaran.gro-tsen.net ([88.191.60.176]:46463 "EHLO
	aldebaran.xn--kwg.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0C2Ndw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 09:33:52 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2010 09:33:51 EDT
Received: by aldebaran.xn--kwg.net (Postfix, from userid 500)
	id BF096232CC; Mon, 29 Mar 2010 15:24:39 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143472>

Hi list,

I'd like to know if the following is possible and, if not, I'd like to
suggest it as a possible useful addition to the git frontend/graphical
tools: display a simplified graph of "interesting" commits showing the
relationship between a specified set of commits.

In other words, I have a set of revisions that I'm interested in, and
I'd like to graphically display the relationships (merges, branches)
between them, omitting the cruft of intervening irrelevant commits.

A possible mathematical definition of what I'd like would be this:
given a finite set S of commits, consider the subgraph G (of the full
commit graph) consisting of the union of all possible paths leading
from a latest-common-ancestor of any subset of S to an
earliest-common-descendant; define a commit to be "interesting" (wrt
S) when it has more than one ancestor or more than one child _in the
subraph G_ (i.e., it is either a branch or a merge point in the
subgraph), or, of course, when it itself in S; I'd like to display the
subgraph G by displaying all its interesting commits and the sequences
of edges between them (but not all the intermediate commits).

(The above, of course, is just one example of a rigorous definition of
what an "interesting" commit might be.  There may be others, and
obviously I don't care about using exactly that one.)

The point is that I want to understand the code flow among branches
containing certain revisions in a git tree, and who merged what--and
there are too many intermediate commits to make anything useful of the
standard display of gitk.  Restricting a view to a certain subset of
the files helps a lot, but it is still not sufficient as it is neither
true that every commit I'm interested in touches this or that subset
of the files, nor the converse.

Is there another way I can restrict the set of commits to display,
with any kind of graphical tool like gitk?

-- 
     David A. Madore
   ( http://www.madore.org/~david/ )
