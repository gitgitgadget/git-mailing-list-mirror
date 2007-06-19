From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Newbie using git -- need a little help
Date: Tue, 19 Jun 2007 00:10:28 -0400
Message-ID: <20070619041028.GG2825@fieldses.org>
References: <42118.74778.qm@web57410.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Smith <wolf1boy79@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 06:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0V35-0007pm-Ba
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 06:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXFSEKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 00:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbXFSEKb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 00:10:31 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47438 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbXFSEKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 00:10:30 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1I0V2y-0003uR-Sm; Tue, 19 Jun 2007 00:10:28 -0400
Content-Disposition: inline
In-Reply-To: <42118.74778.qm@web57410.mail.re1.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50443>

On Sun, Jun 17, 2007 at 11:55:52AM -0700, Robert Smith wrote:
> I've read over the documentation (the full manual) numerous times and
> must admit it's slightly overwhelming.
...
> I have both a desktop computer, a laptop, and a server where I host my
> git repository.  The goal for having this public repository is for me
> to be able to program on my desktop, then push the changes to the
> server, and then continue development on, say, my laptop later on
> grabbing the newer tree.

Others answered your question, I think, so I was just trying to figure
out how to make that bit of the manual more helpful.  Do you think
something like this would have saved you any time?

--b.

(Feedback like "I tried to figure out how to do X by reading Y, and
couldn't" is much appreciated, by the way--thanks.)

---
 Documentation/user-manual.txt |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e9da591..caa23c7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1772,7 +1772,7 @@ repository, but it works just as well in the other direction.
 
 If you and the maintainer both have accounts on the same machine, then
 you can just pull changes from each other's repositories directly;
-commands that accepts repository URLs as arguments will also accept a
+commands that accept repository URLs as arguments will also accept a
 local directory name:
 
 -------------------------------------------------
@@ -1780,6 +1780,15 @@ $ git clone /path/to/repository
 $ git pull /path/to/other/repository
 -------------------------------------------------
 
+or an ssh url:
+
+-------------------------------------------------
+$ git clone ssh://yourhost/~you/repository
+-------------------------------------------------
+
+For projects with few developers, or for synchronizing a few private
+repositories, this may be all you need.
+
 However, the more common way to do this is to maintain a separate public
 repository (usually on a different host) for others to pull changes
 from.  This is usually more convenient, and allows you to cleanly
@@ -1802,6 +1811,8 @@ like this:
         |               they push             V
   their public repo <------------------- their repo
 
+We explain how to do this in the following sections.
+
 [[setting-up-a-public-repository]]
 Setting up a public repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -1913,6 +1924,12 @@ proceeding the branch name by a plus sign:
 $ git push ssh://yourserver.com/~you/proj.git +master
 -------------------------------------------------
 
+Note that the target of a "push" is normally a
+<<def_bare_repository,bare>> repository.  You can also push to a
+repository that has a checked-out working tree, but the working tree
+will not be updated by the push.  This may lead to unexpected results if
+the branch you push to is the currently checked-out branch.
+
 As with git-fetch, you may also set up configuration options to
 save typing; so, for example, after
 
-- 
1.5.2.2.238.g7cbf2f2
