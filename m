From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch documentation: clarify which filters are
 eval'ed
Date: Thu, 5 Jul 2007 17:07:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051704520.9789@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 18:08:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6TsD-00023v-AZ
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757737AbXGEQIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 12:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757171AbXGEQIB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:08:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:58744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754099AbXGEQIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 12:08:00 -0400
Received: (qmail invoked by alias); 05 Jul 2007 16:07:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 05 Jul 2007 18:07:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Sn88aCnJSD112l6EFLurWEjfw8rEQKXBtfAFUK3
	gWaKVoT3mki32j
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51680>


All filters, except the commit filter, are evaluated.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I tried to extract the magic of the "remove commit" example into a 
	function "skip_commit", since I guess it will be a common 
	operation. Alas, since the commit filter has to be "sh -c"ed to 
	get arguments, I do not see any way to use a convenience function 
	in there, short of sourcing a helper file. Does anybody see a 
	better way?

 Documentation/git-filter-branch.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 219a81d..eaea82d 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -50,7 +50,8 @@ Filters
 ~~~~~~~
 
 The filters are applied in the order as listed below.  The <command>
-argument is always evaluated in shell using the 'eval' command.
+argument is always evaluated in shell using the 'eval' command (with the
+notable exception of the commit filter, for technical reasons).
 Prior to that, the $GIT_COMMIT environment variable will be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
-- 
1.5.3.rc0.2689.g99ca2-dirty
