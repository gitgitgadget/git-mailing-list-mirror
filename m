From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
Date: Sat, 08 Dec 2007 13:30:59 +0100
Message-ID: <20071208123058.7364.25491.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Dec 08 14:03:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0zL2-0006rL-2Q
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 14:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbXLHNC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 08:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbXLHNC4
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 08:02:56 -0500
Received: from rover.dkm.cz ([62.24.64.27]:52749 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbXLHNCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 08:02:55 -0500
X-Greylist: delayed 1909 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2007 08:02:55 EST
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 55D158B33B;
	Sat,  8 Dec 2007 13:31:01 +0100 (CET)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67554>

This is important for the list of clone urls, where if there are
no per-repository clone URL configured, the default base URLs
are never used for URL construction with this patch.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 491a3f4..d5505a4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1512,7 +1512,7 @@ sub config_to_int {
 sub config_to_multi {
 	my $val = shift;
 
-	return ref($val) ? $val : [ $val ];
+	return ref($val) ? $val : $val ? [ $val ] : [];
 }
 
 sub git_get_project_config {
