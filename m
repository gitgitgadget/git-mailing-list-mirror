From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: History: blob and tree are first, then commitdiff, etc
Date: Thu, 28 Sep 2006 17:21:07 -0700 (PDT)
Message-ID: <20060929002108.22581.qmail@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-41100574-1159489267=:21782"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 02:21:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT682-0005Ln-Ie
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 02:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWI2AVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 20:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWI2AVO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 20:21:14 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:52397 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161193AbWI2AVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 20:21:12 -0400
Received: (qmail 22583 invoked by uid 60001); 29 Sep 2006 00:21:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1cfBU/yj8/adZ+uK0UT9fw1cuA9LVM9hH/0+Es4jlrPMa4CM3/3ICHeJ4DCVIomkDKoR3e/FEnVffBmfd9zHB8rZir2BC7JUdKzuLZFg18sclQ4m/XJCFj/pg2Vkp/h0qgqCRVCq1uOCEXnLAhGbCJ8DMv4vkRUCMl+R+GO/VnI=  ;
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 17:21:07 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28078>

--0-41100574-1159489267=:21782
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Reorder link display in history to be consistent with other
list displays: log, shortlog, etc.  We now display:
	blob | commitdiff
	blob | commitdiff | diff_to_current
and
	tree | commitdiff
Instead of the old history format where "blob" and "tree"
are between "commitdiff" and "diff_to_current" if present/
applicable.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
--0-41100574-1159489267=:21782
Content-Type: text/plain; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: inline; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c0f7dff..f175237 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2071,8 +2071,8 @@ sub git_history_body {
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
-		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype);
+		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
 		if ($ftype eq 'blob') {
 			my $blob_current = git_get_hash_by_path($hash_base, $file_name);
-- 
1.4.2.1.g8492a


--0-41100574-1159489267=:21782--
