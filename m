From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH 2/2] gitweb: Use chop_and_escape_str in more places.
Date: Tue, 23 Oct 2007 11:31:23 +1000
Message-ID: <11931030851501-git-send-email-dsymonds@gmail.com>
References: <1193103083390-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: pasky@suse.cz, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 23 03:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik8d8-0006Qs-Ix
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 03:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbXJWBcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 21:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXJWBcK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 21:32:10 -0400
Received: from ipmail03.adl2.internode.on.net ([203.16.214.135]:49477 "EHLO
	ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392AbXJWBcJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 21:32:09 -0400
X-IronPort-AV: E=Sophos;i="4.21,314,1188743400"; 
   d="scan'208";a="172497348"
Received: from ppp121-44-32-71.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.32.71])
  by ipmail03.adl2.internode.on.net with ESMTP; 23 Oct 2007 11:01:29 +0930
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <1193103083390-git-send-email-dsymonds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62069>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a835bd1..1b6c823 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3402,7 +3402,7 @@ sub git_project_list_body {
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
-		      "<td><i>" . esc_html(chop_str($pr->{'owner'}, 15)) . "</i></td>\n";
+		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
 		      "<td class=\"link\">" .
@@ -3657,7 +3657,7 @@ sub git_search_grep_body {
 		      "<td><i>" . $author . "</i></td>\n" .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
-			       esc_html(chop_str($co{'title'}, 50)) . "<br/>");
+			       chop_and_escape_str($co{'title'}, 50) . "<br/>");
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
 			if ($line =~ m/^(.*)($search_regexp)(.*)$/i) {
@@ -5173,7 +5173,7 @@ sub git_search {
 					      "<td>" .
 					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
 					              -class => "list subject"},
-					              esc_html(chop_str($co{'title'}, 50)) . "<br/>");
+					              chop_and_escape_str($co{'title'}, 50) . "<br/>");
 					while (my $setref = shift @files) {
 						my %set = %$setref;
 						print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
-- 
1.5.3.1
