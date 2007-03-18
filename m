From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] Allow 'git-remote fetch' as a synonym for 'git fetch'
Date: Sun, 18 Mar 2007 21:47:21 +1200
Message-ID: <20070318094910.7985613A382@magnus.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 10:49:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSs0p-00079a-0A
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 10:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbXCRJtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 05:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbXCRJtN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 05:49:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42962 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbXCRJtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 05:49:12 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id 7985613A382; Sun, 18 Mar 2007 21:49:10 +1200 (NZST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42485>

I found myself typing this when doing remote-like things.  Perhaps
other people will find this useful.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-remote.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index c56c5a8..305f2e3 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -355,10 +355,14 @@ elsif ($ARGV[0] eq 'add') {
 	}
 	add_remote($ARGV[1], $ARGV[2], \%opts);
 }
+elsif ($ARGV[0] eq 'fetch') {
+	exec("git-fetch", @ARGV[1..$#ARGV]);
+}
 else {
 	print STDERR "Usage: git remote\n";
 	print STDERR "       git remote add <name> <url>\n";
 	print STDERR "       git remote show <name>\n";
 	print STDERR "       git remote prune <name>\n";
+	print STDERR "       git remote fetch <fetch-options> <repository> <refspec>...\n";
 	exit(1);
 }
-- 
1.5.0.2.gdcde2
