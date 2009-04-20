From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] git add -p: add missing "q" to patch prompt
Date: Mon, 20 Apr 2009 11:42:52 +0200
Message-ID: <1240220572-2183-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 11:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvq3L-0002vx-Oz
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 11:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZDTJnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 05:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbZDTJnE
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 05:43:04 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:41616 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbZDTJnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 05:43:03 -0400
Received: from localhost.localdomain (125.pool85-53-29.dynamic.orange.es [85.53.29.125])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n3K9gtKL003583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Apr 2009 05:42:57 -0400
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116953>

Commit cbd3a01 added a new "q" subcommand to the "git add -p"
command loop, but forgot to add it to the prompt.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

I prepared this against current "maint" seeing as the new
1.6.2.4 maintenance release is the first one to have the
"q" subcommand.

 git-add--interactive.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 566e371..5407b2e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1045,7 +1045,7 @@ sub patch_update_file {
 		}
 		print colored $prompt_color, 'Stage ',
 		  ($hunk[$ix]{TYPE} eq 'mode' ? 'mode change' : 'this hunk'),
-		  " [y,n,a,d,/$other,?]? ";
+		  " [y,n,q,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
 		if ($line) {
 			if ($line =~ /^y/i) {
-- 
1.6.2.4
