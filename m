From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 05/14] gitweb: allow refs passed to git_heads_body to use a name different from the hash name
Date: Fri, 31 Aug 2007 12:59:52 +0200
Message-ID: <11885579922481-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:01:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4Fz-0006OB-9v
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbXHaLBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbXHaLBj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:01:39 -0400
Received: from joe.tiscali.it ([213.205.33.54]:54922 "EHLO joe.tiscali.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525AbXHaLBi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:01:38 -0400
Received: from localhost.localdomain (84.221.55.162) by joe.tiscali.it (7.3.122)
        id 46A8A46B00388F16; Fri, 31 Aug 2007 13:01:31 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57153>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6aec28e..c46e982 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3657,16 +3657,18 @@ sub git_heads_body {
 		} else {
 			print "<tr class=\"light\">\n";
 		}
+		my $hname = $ref{'hname'} || $ref{'name'};
+		my $name = $ref{'name'};
 		$alternate ^= 1;
 		print "<td><i>$ref{'age'}</i></td>\n" .
 		      ($curr ? "<td class=\"current_head\">" : "<td>") .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'}),
-		               -class => "list name"},esc_html($ref{'name'})) .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$hname),
+		               -class => "list name"},esc_html($name)) .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'name'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$ref{'name'})}, "log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'name'}, hash_base=>$ref{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$hname)}, "shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log", hash=>$hname)}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$hname, hash_base=>$hname)}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
-- 
1.5.2.5
