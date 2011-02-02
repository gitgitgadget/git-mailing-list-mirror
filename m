From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] post-receive-email: suppress error if description file missing
Date: Wed, 2 Feb 2011 23:12:42 +0530
Message-ID: <20110202174242.GA12470@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Hemmecke <hemmecke@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Feb 02 19:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkhBA-0001i1-2E
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 19:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab1BBSLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 13:11:36 -0500
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:60373 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab1BBSLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 13:11:36 -0500
X-Greylist: delayed 1715 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Feb 2011 13:11:35 EST
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.13.8/8.13.8) with ESMTP id p12HglGm012934;
	Wed, 2 Feb 2011 23:12:47 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.13.8/8.13.8/Submit) id p12Hggg3012932;
	Wed, 2 Feb 2011 23:12:42 +0530
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	MISSING_HEADERS autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165921>

---
 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index f99ea95..71f2b47 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -709,7 +709,7 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
+projectdesc=$(sed -ne '1p' "$GIT_DIR/description 2>/dev/null")
 # Check if the description is unchanged from it's default, and shorten it to
 # a more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
-- 
1.7.3.4
