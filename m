From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: [PATCH] git-svnimport: Allow direct access over https.
Date: Wed, 01 Feb 2006 13:31:56 -0800
Message-ID: <7756.1138829516@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Wed Feb 01 22:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Pa5-00054n-I2
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWBAVb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWBAVb6
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:31:58 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:4248 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932467AbWBAVb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 16:31:57 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k11LVvxV007758
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 13:31:57 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k11LVuIe007757
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 13:31:57 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15450>

I'm not sure what the benefits of "direct access" are,
but it works over https as well as http.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

71596fc3eb8d2ea25bd8fc99c03d2171d4136d88
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 6e3a44a..63339ef 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -141,7 +141,7 @@ if($opt_d or $opt_D) {
 	} else {
 		$svn_dir = "";
 	}
-	if ($svn_url->scheme eq "http") {
+	if ($svn_url->scheme eq "http" || $svn_url->scheme eq "https") {
 		use LWP::UserAgent;
 		$lwp_ua = LWP::UserAgent->new(keep_alive => 1, requests_redirectable => []);
 	} else {
-- 
1.1.5.g4a2b
