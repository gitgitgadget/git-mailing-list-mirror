From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Make path in tree view look nicer
Date: Sat, 23 Sep 2006 01:00:12 +0200
Message-ID: <20060922230011.31500.86485.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 01:01:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQu0U-0008D2-Rb
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbWIVXAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965317AbWIVXAQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:00:16 -0400
Received: from rover.dkm.cz ([62.24.64.27]:13771 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S965330AbWIVXAN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:00:13 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 15F708B49C;
	Sat, 23 Sep 2006 01:00:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27538>

Based on talk on the IRC with Junio some evenings ago, I've updated the
path showing in tree view to look better and sent updated patches
privately, but it seems the old version ended up being used, so here's
the new one again.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a357604..d2366c7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1527,14 +1527,14 @@ sub git_print_page_path {
 
 		print "<div class=\"page_path\">";
 		print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
-			      -title => '/'}, '/');
-		print " ";
+			      -title => 'tree root'}, "[$project]");
+		print " / ";
 		foreach my $dir (@dirname) {
 			$fullname .= ($fullname ? '/' : '') . $dir;
 			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
 			                             hash_base=>$hb),
-			              -title => $fullname}, esc_html($dir . '/'));
-			print " ";
+			              -title => $fullname}, esc_html($dir));
+			print " / ";
 		}
 		if (defined $type && $type eq 'blob') {
 			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
@@ -1543,7 +1543,7 @@ sub git_print_page_path {
 		} elsif (defined $type && $type eq 'tree') {
 			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
-			              -title => $name}, esc_html($basename . '/'));
+			              -title => $name}, esc_html($basename));
 		} else {
 			print esc_html($basename);
 		}
