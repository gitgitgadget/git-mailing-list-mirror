From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Normalize searchbar font size
Date: Thu, 17 May 2007 04:24:19 +0200
Message-ID: <20070517022419.9052.35630.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 04:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVfG-00037a-Vz
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbXEQCYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbXEQCYV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:24:21 -0400
Received: from rover.dkm.cz ([62.24.64.27]:56924 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880AbXEQCYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:24:20 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 73D438B4BF;
	Thu, 17 May 2007 04:24:19 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47486>

Currently, searchbar font was as big as the page heading font, because
font-size was made relative - but to the parent element, which was for some
reason indeed page_header. Since that seems to be illogical to me, I just
moved the div.search outside of div.page_header. I'm no CSS/DOM expert but
no adverse effects were observed by me.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ff2f25b..4a1a423 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1988,6 +1988,8 @@ EOF
 		}
 		print "\n";
 	}
+	print "</div>\n";
+
 	my ($have_search) = gitweb_check_feature('search');
 	if ((defined $project) && ($have_search)) {
 		if (!defined $searchtext) {
@@ -2017,7 +2019,6 @@ EOF
 		      "</div>" .
 		      $cgi->end_form() . "\n";
 	}
-	print "</div>\n";
 }
 
 sub git_footer_html {
