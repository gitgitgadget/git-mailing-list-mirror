From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Add snapshot to log; remove redundant commit from log
Date: Thu, 28 Sep 2006 16:50:50 -0700 (PDT)
Message-ID: <20060928235050.63085.qmail@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1525972134-1159487450=:60693"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 01:51:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5eY-0005vV-Oi
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWI1Xuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWI1Xuw
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:50:52 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:24479 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964989AbWI1Xuv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:50:51 -0400
Received: (qmail 63087 invoked by uid 60001); 28 Sep 2006 23:50:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Vg3MpeZybU2x6qhac8LlFMHLplnQSXVpBqT/mo7c5GorVxEEpgAuSeCBTJ13Ae527bhpz2V9JJJaMyQyN3Xf1eaXLcj8N0t6DHLD8d2bgB8pRDNoTiX0tMmoaFYKF555Ve+JTAFNPSxAf1O2v5eoK7QXp0dzH3YWixQ+SQzhek4=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:50:50 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28072>

--0-1525972134-1159487450=:60693
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This removes redundant "commit" from log in favor of adding
"snapshot".  The commit can be had by clicking on the title of
the entry.
From	commit | commitdiff | tree
To	commitdiff | tree | snapshot
This makes it consistent with "shortlog".

Adding "snapshot" without removing redundant "commit" makes
it too messy as the log gets out of visual alignment.

I'm ambivalent whether this goes in or not.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
--0-1525972134-1159487450=:60693
Content-Type: text/plain; name="p5.txt"
Content-Description: 458135609-p5.txt
Content-Disposition: inline; filename="p5.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 953a0ef..9052647 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2887,11 +2887,11 @@ sub git_log {
 		               $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
-		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
-		      " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot") .
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
-- 
1.4.2.1.g05f0f


--0-1525972134-1159487450=:60693--
