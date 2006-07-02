From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Empty author may be presented by svn as an empty string or a null value.
Date: Mon, 03 Jul 2006 00:21:00 +0200
Message-ID: <20060702222100.2863.72633.stgit@h15n1fls34o811.telia.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Jul 03 00:21:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxAJK-00075t-EY
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 00:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWGBWU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 18:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWGBWU6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 18:20:58 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:47055 "EHLO
	av9-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S1750867AbWGBWU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 18:20:58 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id BA0CF37F26; Mon,  3 Jul 2006 00:20:56 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP id AA67937EE9
	for <git@vger.kernel.org>; Mon,  3 Jul 2006 00:20:56 +0200 (CEST)
Received: from h15n1fls34o811.telia.com (h15n1fls34o811.telia.com [213.67.102.15])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 9739537E46
	for <git@vger.kernel.org>; Mon,  3 Jul 2006 00:20:56 +0200 (CEST)
Received: from h15n1fls34o811.telia.com (idefix [127.0.0.1])
	by h15n1fls34o811.telia.com (Postfix) with ESMTP id 667EB40661F
	for <git@vger.kernel.org>; Mon,  3 Jul 2006 00:21:00 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23130>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 38ac732..26dc454 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -534,7 +534,7 @@ sub commit {
 	my($author_name,$author_email,$dest);
 	my(@old,@new,@parents);
 
-	if (not defined $author) {
+	if (not defined $author or $author eq "") {
 		$author_name = $author_email = "unknown";
 	} elsif (defined $users_file) {
 		die "User $author is not listed in $users_file\n"
