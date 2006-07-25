From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsserver: suppress warnings
Date: Tue, 25 Jul 2006 12:48:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 25 12:49:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5KTd-0004fh-JB
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 12:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWGYKsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWGYKsz
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 06:48:55 -0400
Received: from mail.gmx.de ([213.165.64.21]:37857 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751446AbWGYKsy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 06:48:54 -0400
Received: (qmail invoked by alias); 25 Jul 2006 10:48:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 25 Jul 2006 12:48:52 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Martin Langhoff <martin@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24165>


This patch defines $state->{prependdir} as the empty string, so that
quite a few warnings are avoided.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I still get this warning:

		closing dbh with active statement handles

 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9c9f21b..981b6ba 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -81,7 +81,7 @@ ########################################
 
 # $state holds all the bits of information the clients sends us that could
 # potentially be useful when it comes to actually _doing_ something.
-my $state = {};
+my $state = { prependdir => '' };
 $log->info("--------------- STARTING -----------------");
 
 my $TEMP_DIR = tempdir( CLEANUP => 1 );
-- 
1.4.2.rc1.gc123
