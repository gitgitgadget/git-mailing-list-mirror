From: Alex Vandiver <alexmv@MIT.EDU>
Subject: [PATCH] git-svn: Set svn.authorsfile if it is passed to git svn clone
Date: Wed,  6 May 2009 16:19:45 -0400
Message-ID: <1241641185-7025-1-git-send-email-alexmv@mit.edu>
Cc: Alex Vandiver <alexmv@MIT.EDU>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 22:25:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ngK-0008EK-Pw
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbZEFUYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZEFUYw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:24:52 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:57885 "EHLO
	south-station-annex.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098AbZEFUYw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 16:24:52 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2009 16:24:51 EDT
Received: from central-city-carrier-station.mit.edu (CENTRAL-CITY-CARRIER-STATION.MIT.EDU [18.7.7.72])
	by south-station-annex.mit.edu (8.13.6/8.9.2) with ESMTP id n46KLmFW027619;
	Wed, 6 May 2009 16:21:48 -0400 (EDT)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by central-city-carrier-station.mit.edu (8.13.6/8.9.2) with ESMTP id n46KJob1006014;
	Wed, 6 May 2009 16:19:50 -0400 (EDT)
Received: from localhost.localdomain (75-147-59-54-NewEngland.hfc.comcastbusiness.net [75.147.59.54])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id n46KJn6w007502;
	Wed, 6 May 2009 16:19:50 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc4.225.g060aa4
X-Scanned-By: MIMEDefang 2.42
X-Spam-Score: -2.464
X-Spam-Flag: NO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118378>

Signed-off-by: Alex Vandiver <alexmv@mit.edu>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..67265c3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -361,6 +361,7 @@ sub cmd_clone {
 	$path = basename($url) if !defined $path || !length $path;
 	cmd_init($url, $path);
 	Git::SVN::fetch_all($Git::SVN::default_repo_id);
+	command_oneline('config', 'svn.authorsfile', $_authors) if $_authors;
 }
 
 sub cmd_init {
-- 
1.6.3.rc4.225.g060aa4
