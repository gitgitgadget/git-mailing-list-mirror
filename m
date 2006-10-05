From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Thu, 5 Oct 2006 12:22:57 -0700 (PDT)
Message-ID: <20061005192257.50209.qmail@web31809.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2063115975-1160076177=:49087"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 05 21:23:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVYoA-0002Ps-9b
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 21:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWJETW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 15:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWJETW7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 15:22:59 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:337 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750847AbWJETW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 15:22:58 -0400
Received: (qmail 50211 invoked by uid 60001); 5 Oct 2006 19:22:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PZ2ozG23MFXqRJhdtVNY9tc1/qCgGOkJ2FX6cve/kaa3ApiwFfsW1Tm3XqdX97XX1qEZPsJagj3GoqEgYQmAGkMCTcntc6fdXLxAeG4DLeF+ezxfsATa6PgKeTlLEoV7dVCZbtv2CAwMOl9NA2CxVPBc0BjDaqD5DPuPARANr4Q=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Thu, 05 Oct 2006 12:22:57 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28360>

--0-2063115975-1160076177=:49087
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Do not print "log" and "shortlog" redundantly in commit
view.  This is passed into the $extra argument of
git_print_page_nav from git_commit, but git_print_page_nav
prints "log" and "shortlog" already with the same head.

Noticed by Junio.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

--0-2063115975-1160076177=:49087
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bfd1405..65f1d82 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3014,11 +3014,6 @@ sub git_commit {
 			$cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)},
 			        "blame");
 	}
-	if (defined $co{'parent'}) {
-		push @views_nav,
-			$cgi->a({-href => href(action=>"shortlog", hash=>$hash)}, "shortlog"),
-			$cgi->a({-href => href(action=>"log", hash=>$hash)}, "log");
-	}
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
 	                   $hash, $co{'tree'}, $hash,
-- 
1.4.2.3.g2e575


--0-2063115975-1160076177=:49087--
