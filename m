From: Jeff King <peff@peff.net>
Subject: Re: Problem with git filter-branch
Date: Sun, 26 Oct 2008 01:07:06 -0400
Message-ID: <20081026050706.GC21178@coredump.intra.peff.net>
References: <4902E7D8.6050401@obry.net> <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pascal Obry <pascal@obry.net>, git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 26 06:08:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxrT-0000NJ-CP
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 06:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYJZFHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 01:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYJZFHK
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 01:07:10 -0400
Received: from peff.net ([208.65.91.99]:3777 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbYJZFHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 01:07:09 -0400
Received: (qmail 5207 invoked by uid 111); 26 Oct 2008 05:07:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 01:07:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 01:07:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99151>

On Sat, Oct 25, 2008 at 10:36:26PM +0200, Johannes Schindelin wrote:

> It is a (maybe ill-conceived) feature.  When branches are rewritten, their 
> original versions are stored in the refs/original/ namespace.  You can 
> force overwriting with "-f".
> 
> I wonder if people would like to have this feature removed; reflogs should 
> be enough.
> 
> Thoughts?

I have always been annoyed by the refs/original namespace, and it
certainly makes explaining the common task of "how do I get this blob
out of my repo" a bit more confusing.

So I would be happy to see it go, and the reflog mentioned in its place:

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index fed6de6..1e8e7b4 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -43,4 +43,4 @@ rewriting published history.)
 Always verify that the rewritten version is correct: The original refs,
-if different from the rewritten ones, will be stored in the namespace
-'refs/original/'.
+if different from the rewritten ones, will be available through the
+reflog as <branch>@{1}.
 
