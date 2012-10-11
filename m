From: Dylan Alex Simon <dylan@dylex.net>
Subject: [PATCH] gitweb.cgi: fix "comitter_tz" typo in feed
Date: Thu, 11 Oct 2012 16:40:35 -0400
Message-ID: <20121011204035.GA19361@datura.dylex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 11 23:00:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMPrb-0003sZ-QO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 23:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759290Ab2JKVAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 17:00:04 -0400
Received: from datura.dylex.net ([66.114.66.16]:44864 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759261Ab2JKVAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 17:00:03 -0400
X-Greylist: delayed 1165 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2012 17:00:03 EDT
Received: from dylan by datura.dylex.net with local (Exim 4.80)
	(envelope-from <dylan@dylex.net>)
	id 1TMPYZ-00052O-Kk; Thu, 11 Oct 2012 16:40:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207515>

gitweb's feeds sometimes contained committer timestamps in the wrong timezone
due to a misspelling.

Signed-off-by: Dylan Simon <dylan@dylex.net>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7f8c187..10ed9e5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8028,7 +8028,7 @@ sub git_feed {
 		%latest_commit = %{$commitlist[0]};
 		my $latest_epoch = $latest_commit{'committer_epoch'};
 		exit_if_unmodified_since($latest_epoch);
-		%latest_date = parse_date($latest_epoch, $latest_commit{'comitter_tz'});
+		%latest_date = parse_date($latest_epoch, $latest_commit{'committer_tz'});
 	}
 	print $cgi->header(
 		-type => $content_type,
-- 
1.7.10.3
