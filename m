From: Jeff King <peff@peff.net>
Subject: [PATCH] don't mention index refreshing side effect in git-status
	docs
Date: Sun, 9 Dec 2007 03:21:34 -0500
Message-ID: <20071209082133.GA2257@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 09:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1HQF-0004FH-Vz
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 09:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbXLIIVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 03:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbXLIIVi
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 03:21:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1031 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbXLIIVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 03:21:37 -0500
Received: (qmail 23767 invoked by uid 111); 9 Dec 2007 08:21:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 09 Dec 2007 03:21:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Dec 2007 03:21:34 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67604>

The tip about speeding up subsequent operations is now
obsolete; since aecbf914, git-diff now squelches empty diffs
and performs an automatic refresh.

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of my other patches to the git-status docs.

I don't see any reason to mention this side effect at all. Those who
know enough to set diff.autorefreshindex presumably know what they are
doing, and the removed paragraph is a bit confusing to those who don't.

If there is some desire to document the side effect, I think we should
at least remove the mention of speeding up git-diff (which is just wrong
now).

 Documentation/git-status.txt |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index a1bb9bd..5c5a480 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -28,13 +28,6 @@ If there is no path that is different between the index file and
 the current HEAD commit (i.e., there is nothing to commit by running
 `git-commit`), the command exits with non-zero status.
 
-If any paths have been touched in the working tree (that is,
-their modification times have changed) but their contents and
-permissions are identical to those in the index file, the command
-updates the index file. Running `git-status` can thus speed up
-subsequent operations such as `git-diff` if the working tree
-contains many paths that have been touched but not modified.
-
 
 OUTPUT
 ------
-- 
1.5.3.7.2187.gb646
