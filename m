From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/6] gitweb: Link to tree instead of snapshot in shortlog
Date: Fri, 22 Sep 2006 03:19:44 +0200
Message-ID: <20060922011943.15909.22400.stgit@rover>
References: <20060922011941.15909.32671.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 03:19:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQZhj-0003QH-Sv
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 03:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWIVBTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 21:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWIVBTq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 21:19:46 -0400
Received: from rover.dkm.cz ([62.24.64.27]:61344 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932173AbWIVBTp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 21:19:45 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 11A4D8BBF1;
	Fri, 22 Sep 2006 03:19:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060922011941.15909.32671.stgit@rover>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27510>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 87df7bb..1b1653a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1976,9 +1976,6 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
 
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
-
 	$from = 0 unless defined $from;
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
@@ -2004,10 +2001,8 @@ sub git_shortlog_body {
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
-		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
-		if ($have_snapshot) {
-			print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
-		}
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
 		print "</td>\n" .
 		      "</tr>\n";
 	}
