From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsexportcommit: get rid of temporary directory
Date: Mon, 15 Oct 2007 23:32:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710152332230.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 16 01:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhYUl-0004Cw-6n
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 00:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbXJOWcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 18:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbXJOWcy
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 18:32:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:35188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753531AbXJOWcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 18:32:53 -0400
Received: (qmail invoked by alias); 15 Oct 2007 22:32:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 16 Oct 2007 00:32:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jplRazvUjkt4R0tnFa62rR2h/AekBFa2aBE7NHl
	MrPECi57uwGvLd
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61049>


Since commit e86ad71fe5f53ae4434566bd09ea4256090e5a3a we do not use
a temporary directory in cvsexportcommit.  So there is no need to set
one up.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-cvsexportcommit.perl |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index a33fa8d..6b0123c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -30,11 +30,6 @@ if ($opt_d) {
 	@cvs = ('cvs');
 }
 
-# setup a tempdir
-our ($tmpdir, $tmpdirname) = tempdir('git-cvsapplycommit-XXXXXX',
-				     TMPDIR => 1,
-				     CLEANUP => 1);
-
 # resolve target commit
 my $commit;
 $commit = pop @ARGV;
-- 
1.5.3.4.1174.gcd0d6-dirty
