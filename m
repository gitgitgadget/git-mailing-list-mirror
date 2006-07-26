From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] gitweb: fix two warnings
Date: Wed, 26 Jul 2006 16:58:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261658130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:59:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kqS-0004IZ-EX
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWGZO6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWGZO6i
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:58:38 -0400
Received: from mail.gmx.net ([213.165.64.21]:43153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750744AbWGZO6h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:58:37 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:58:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 26 Jul 2006 16:58:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24219>


These warnings cluttered up my log.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 gitweb/gitweb.cgi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index e226ac2..e5fca63 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -795,7 +795,7 @@ sub git_read_projects {
 	if (-d $projects_list) {
 		# search in directory
 		my $dir = $projects_list;
-		opendir my $dh, $dir or return undef;
+		opendir my ($dh), $dir or return undef;
 		while (my $dir = readdir($dh)) {
 			if (-e "$projectroot/$dir/HEAD") {
 				my $pr = {
@@ -810,7 +810,7 @@ sub git_read_projects {
 		# 'git%2Fgit.git Linus+Torvalds'
 		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
 		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
-		open my $fd , $projects_list or return undef;
+		open my ($fd), $projects_list or return undef;
 		while (my $line = <$fd>) {
 			chomp $line;
 			my ($path, $owner) = split ' ', $line;
-- 
1.4.2.rc2.g6a4e
