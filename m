From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 2/3] gitweb: blame: Mouse-over commit-8 shows author and date
Date: Wed, 4 Oct 2006 00:13:38 -0700 (PDT)
Message-ID: <20061004071338.88148.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1054999703-1159946018=:78497"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Oct 04 09:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV0wo-0006bN-LZ
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 09:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWJDHNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 03:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJDHNj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 03:13:39 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:15734 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030409AbWJDHNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 03:13:39 -0400
Received: (qmail 88150 invoked by uid 60001); 4 Oct 2006 07:13:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e3xsQR3b5dbut8yvjp0Yzm3S5ZA8Qz25OjDH6AE663eCTBTpR3jVyzL6DRhjGG7RK1t3MUrqibOThE+5hKNRCwXhPAVbpKz1oEEqjDSFkGAzIxXxlWO9udG1M0S74LdNzrSn06uA4m5CLjtfQDXOhsPdShVIhRSjAxcWtBA0DXg=  ;
Received: from [71.80.233.118] by web31812.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 00:13:38 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28318>

--0-1054999703-1159946018=:78497
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)
--0-1054999703-1159946018=:78497
Content-Type: text/inline; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: name="p2.txt"; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9518086..cba0840 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2496,11 +2496,9 @@ sub git_blame2 {
 <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
 	while (<$fd>) {
-		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
-		my $full_rev = $1;
+		my ($full_rev, $author, $date, $lineno, $data) =
+			/^([0-9a-f]{40}).*?\s\((.*?)\s+([-\d]+ [:\d]+ [-+\d]+)\s+(\d+)\)\s(.*)/;
 		my $rev = substr($full_rev, 0, 8);
-		my $lineno = $2;
-		my $data = $3;
 		my $print_c8 = 0;
 
 		if (!defined $last_rev) {
@@ -2512,7 +2510,11 @@ HTML
 			$print_c8 = 1;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
-		print "<td class=\"sha1\">";
+		print "<td class=\"sha1\"";
+		if ($print_c8 == 1) {
+			print " title=\"$author, $date\"";
+		}
+		print ">";
 		if ($print_c8 == 1) {
 			print $cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
 				      esc_html($rev));
-- 
1.4.2.1.ga68d6


--0-1054999703-1159946018=:78497--
