From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Remove redundant $searchtype setup
Date: Sat, 19 May 2007 01:12:32 +0200
Message-ID: <20070518231232.32429.37727.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 01:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBco-0003Cm-0d
	for gcvg-git@gmane.org; Sat, 19 May 2007 01:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXERXMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 19:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbXERXMf
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 19:12:35 -0400
Received: from rover.dkm.cz ([62.24.64.27]:33122 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXERXMf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 19:12:35 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 612628B711;
	Sat, 19 May 2007 01:12:32 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47680>

Sorry, this was inadverently introduced by my grep search patch. It causes
annoying "redefined" warnings.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ac78a10..0143183 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -413,13 +413,6 @@ if (defined $searchtext) {
 	$search_regexp = quotemeta $searchtext;
 }
 
-our $searchtype = $cgi->param('st');
-if (defined $searchtype) {
-	if ($searchtype =~ m/[^a-z]/) {
-		die_error(undef, "Invalid searchtype parameter");
-	}
-}
-
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
