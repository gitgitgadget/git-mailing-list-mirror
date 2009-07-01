From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Support for delegating tree iterators
Date: Wed, 1 Jul 2009 15:41:37 -0700
Message-ID: <20090701224137.GU11191@spearce.org>
References: <1246470772-4496-1-git-send-email-constantine.plotnikov@gmail.com> <20090701223448.GT11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:41:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM8Ur-0006u1-0Y
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbZGAWlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZGAWle
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:41:34 -0400
Received: from george.spearce.org ([209.20.77.23]:42111 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbZGAWle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:41:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 97031381FD; Wed,  1 Jul 2009 22:41:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090701223448.GT11191@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122610>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> > This patch introduce some methods that simplify creation of tree
> > iterators that wraps other iterators and which are located in
> > other package. Such iterators need to efficiently access the
> > name component of the path of wrapped iterator and wrapped bits.
> > The patch also adds a method that ensuring that path buffer has
> > a requried capacity when the required capacity is known in advance.
> > 
> > Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
> 
> Thanks, two style nits, I fixed during apply:

I also decided to squash this in, the name better matches with
TreeWalk's other like methods.  That is, the method name in TreeWalk
lacks the "Entry" prefix, but is otherwise the same name as the
name in the iterator.

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
index 50befbe..2116387 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterator.java
@@ -387,7 +387,7 @@ public FileMode getEntryFileMode() {
 	}
 
 	/** @return the file mode of the current entry as bits */
-	public int getEntryFileModeBits() {
+	public int getEntryRawMode() {
 		return mode;
 	}
 
 
-- 
Shawn.
