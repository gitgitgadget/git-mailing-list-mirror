From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Show snapshot link in shortlog only if have_snapsho
Date: Fri, 06 Oct 2006 15:57:52 +0200
Message-ID: <20061006135752.26493.63501.stgit@rover>
References: <eft97f$un0$3@sea.gmane.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 15:58:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVqD8-0002CM-AO
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 15:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWJFN5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWJFN5z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 09:57:55 -0400
Received: from rover.dkm.cz ([62.24.64.27]:7861 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932335AbWJFN5y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 09:57:54 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 763F08B301;
	Fri,  6 Oct 2006 15:57:52 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <eft97f$un0$3@sea.gmane.org>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28404>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5c7d95b..bcb41cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2098,8 +2098,10 @@ sub git_shortlog_body {
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") . " | " .
-		      $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
+		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
+		if (gitweb_have_snapshot()) {
+			print " | " . $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
+		}
 		print "</td>\n" .
 		      "</tr>\n";
 	}
