From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Remove redundant "tree" link
Date: Tue, 26 Sep 2006 12:45:37 -0700 (PDT)
Message-ID: <20060926194538.46031.qmail@web31809.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-427046414-1159299937=:44912"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 26 21:46:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSIsF-0007Ff-Pd
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 21:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWIZTpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 15:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWIZTpj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 15:45:39 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:55480 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932496AbWIZTpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 15:45:38 -0400
Received: (qmail 46033 invoked by uid 60001); 26 Sep 2006 19:45:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=anHb4yWwdC5V0LWxicZvP7BQdNoLUAcb+DJzXkeIdUSYGVwrJ0BaHLVnUdyiKxyerfkHo/8IGCRGWSA1qgiKlnZb45bBGoDI01eqyLCq2Cb821lfof8gmkWsdgZ6kGNovo2twY15jGG971/2R9TPcPw9wSY06zkNTdJ4B2UxksY=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 12:45:37 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27812>

--0-427046414-1159299937=:44912
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

In "tree" view, remove redundant "tree" link in the tree
listing.  It is identical to simply clicking on the tree
entry itself.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

--0-427046414-1159299937=:44912
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 959e3f9..8e9c827 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1631,18 +1631,14 @@ sub git_print_tree_entry {
 		print "</td>\n";
 
 	} elsif ($t->{'type'} eq "tree") {
-		print "<td class=\"list\">" .
-		      $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              esc_html($t->{'name'})) .
-		      "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		print "<td class=\"list\">";
+		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              "tree");
+		              esc_html($t->{'name'}));
+		print "</td>\n";
+		print "<td class=\"link\">";
 		if (defined $hash_base) {
-			print " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
-- 
1.4.2.1.g893b0

--0-427046414-1159299937=:44912--
