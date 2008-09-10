From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] git-svn: Fixes my() parameter list syntax error in pre-5.8 Perl
Date: Wed, 10 Sep 2008 11:09:46 -0400
Message-ID: <1221059386-3972-1-git-send-email-marcus@griep.us>
References: <48C7745F.1070008@statsbiblioteket.dk>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRLK-0002JI-SU
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYIJPJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbYIJPJr
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:09:47 -0400
Received: from boohaunt.net ([209.40.206.144]:50651 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbYIJPJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:09:47 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 3391D1878CC4; Wed, 10 Sep 2008 11:09:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.415.g7bb82
In-Reply-To: <48C7745F.1070008@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95523>

---

 Per Tom G. Christensen's commentary on a breaking test in git-svn.

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ecacf74..a97e1ca 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4425,7 +4425,7 @@ sub config_pager {
 
 sub run_pager {
 	return unless -t *STDOUT && defined $pager;
-	pipe my $rfd, my $wfd or return;
+	pipe my ($rfd, $wfd) or return;
 	defined(my $pid = fork) or ::fatal "Can't fork: $!";
 	if (!$pid) {
 		open STDOUT, '>&', $wfd or
-- 
1.6.0.1.415.g7bb82
