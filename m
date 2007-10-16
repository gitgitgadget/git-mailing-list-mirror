From: Michael Witten <mfwitten@mit.edu>
Subject: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 04:08:14 -0400
Message-ID: <1192522094-4988-3-git-send-email-mfwitten@mit.edu>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu>
 <1192522094-4988-2-git-send-email-mfwitten@mit.edu>
Cc: Michael Witten <mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 11:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhjAZ-0002RG-5L
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbXJPJ4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757431AbXJPJ4d
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:56:33 -0400
Received: from WITTEN.MIT.EDU ([18.239.2.43]:51357 "EHLO witten.mit.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757336AbXJPJ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:56:28 -0400
Received: by witten.mit.edu (Postfix, from userid 501)
	id 943EC262129; Tue, 16 Oct 2007 04:08:14 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.207.g6d7480-dirty
In-Reply-To: <1192522094-4988-2-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61136>

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-cvsexportcommit.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 869c8b5..22c3d2f 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -129,7 +129,7 @@ my $context = $opt_p ? '' : '-C1';
 print "Checking if patch will apply\n";
 
 my @stat;
-open APPLY, "GIT_DIR= git-apply $context --binary --summary --numstat<.cvsexportcommit.diff|" || die "cannot patch";
+open APPLY, "GIT_DIR= git-apply $context --summary --numstat<.cvsexportcommit.diff|" || die "cannot patch";
 @stat=<APPLY>;
 close APPLY || die "Cannot patch";
 my (@bfiles,@files,@afiles,@dfiles);
@@ -215,7 +215,7 @@ if ($dirty) {
 }
 
 print "Applying\n";
-`GIT_DIR= git-apply $context --binary --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
+`GIT_DIR= git-apply $context --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
 
 print "Patch applied successfully. Adding new files and directories to CVS\n";
 my $dirtypatch = 0;
-- 
1.5.3.4.207.g6d7480-dirty
