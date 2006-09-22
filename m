From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix snapshot link in tree view
Date: Sat, 23 Sep 2006 01:21:20 +0200
Message-ID: <20060922232120.596.63045.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 01:21:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQuKj-0003nt-AI
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWIVXVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWIVXVW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:21:22 -0400
Received: from rover.dkm.cz ([62.24.64.27]:24018 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S964914AbWIVXVV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:21:21 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 5FA438B855;
	Sat, 23 Sep 2006 01:21:20 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27543>

It would just give HEAD snapshot instead of one of the particular tree.

Perhaps we should also include snapshot in the global navbar? And perhaps
stgit should have a way to edit the mail before sending it so that I could
note this below the three dashes? ;-)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c5f3810..fc31ac3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2771,7 +2771,7 @@ sub git_tree {
 		if ($have_snapshot) {
 			# FIXME: Should be available when we have no hash base as well.
 			push @views_nav,
-				$cgi->a({-href => href(action=>"snapshot")},
+				$cgi->a({-href => href(action=>"snapshot", hash=>$hash)},
 					"snapshot");
 		}
 		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
