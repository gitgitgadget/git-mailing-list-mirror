From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/3] gitweb: Lift any characters restriction on searched
	strings
Date: Sat, 19 May 2007 02:13:34 +0200
Message-ID: <20070519001334.28618.30675.stgit@rover>
References: <20070519001329.28618.31334.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 02:13:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCZm-0002hb-Mx
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbXESANg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXESANg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:13:36 -0400
Received: from rover.dkm.cz ([62.24.64.27]:52346 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006AbXESANf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:13:35 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 9FA9D8B722;
	Sat, 19 May 2007 02:13:34 +0200 (CEST)
In-Reply-To: <20070519001329.28618.31334.stgit@rover>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47691>

Everything is already fully quoted along the way so I believe this to be
unnecessary at this point. It would pose trouble for regexp searches.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0143183..4ccb4e3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -404,9 +404,6 @@ if (defined $searchtype) {
 our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
-	if ($searchtype ne 'grep' and $searchtype ne 'pickaxe' and $searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
-		die_error(undef, "Invalid search parameter");
-	}
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
