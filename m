From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Link (HEAD) tree for each project from projects list
Date: Fri, 22 Sep 2006 01:58:40 +0200
Message-ID: <20060921235840.5385.46104.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 01:58:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQYRO-0005il-8q
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 01:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWIUX6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 19:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWIUX6n
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 19:58:43 -0400
Received: from rover.dkm.cz ([62.24.64.27]:19670 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932122AbWIUX6m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 19:58:42 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 9BEC08BBDC;
	Fri, 22 Sep 2006 01:58:40 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27509>

Current projects list is oriented on easily getting "what's new"
information. But when already using gitweb as an interface to something,
I personally find myself to _much_ more frequently wanting to rather
see "what's in" (or "what's new in") and it's quite annoying to have to
go through the summary page (which is also rather expensive to generate)
just to get there.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 982ddbc..0d2ff82 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2283,7 +2283,8 @@ sub git_project_list {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
