From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: [commit view] Do not suppress commitdiff link in root commit
Date: Fri, 06 Oct 2006 18:59:33 +0200
Message-ID: <20061006165933.4127.72491.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 19:00:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVt2v-0007bT-QN
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWJFQ7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWJFQ7e
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:59:34 -0400
Received: from rover.dkm.cz ([62.24.64.27]:46983 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1422731AbWJFQ7e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 12:59:34 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 49C0F8B363;
	Fri,  6 Oct 2006 18:59:33 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28421>

There's no reason for that, the commitdiff view is meaningful for the
root commit as well and we link to it everywhere else.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 56e5231..3a10124 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3034,7 +3034,7 @@ sub git_commit {
 			$cgi->a({-href => href(action=>"log", hash=>$hash)}, "log");
 	}
 	git_header_html(undef, $expires);
-	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
+	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
 	                   join (' | ', @views_nav));
 
