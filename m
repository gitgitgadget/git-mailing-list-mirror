From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 10/12] git p4: accept -v for --verbose
Date: Thu, 16 Aug 2012 19:35:12 -0400
Message-ID: <1345160114-27654-11-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:38:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29eG-0005lE-0A
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab2HPXij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:38:39 -0400
Received: from honk.padd.com ([74.3.171.149]:47781 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab2HPXii (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:38:38 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id BFF39D27;
	Thu, 16 Aug 2012 16:38:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 82B75313FD; Thu, 16 Aug 2012 19:38:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The short form "-v" is common in many git commands as an
alias for "--verbose".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt | 2 +-
 git-p4.py                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 8228f33..4b03356 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -163,7 +163,7 @@ All commands except clone accept these options.
 --git-dir <dir>::
 	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
 
---verbose::
+--verbose, -v::
 	Provide more progress information.
 
 Sync options
diff --git a/git-p4.py b/git-p4.py
index 02b4e44..c844d00 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3028,7 +3028,7 @@ def main():
 
     args = sys.argv[2:]
 
-    options.append(optparse.make_option("--verbose", dest="verbose", action="store_true"))
+    options.append(optparse.make_option("--verbose", "-v", dest="verbose", action="store_true"))
     if cmd.needsGit:
         options.append(optparse.make_option("--git-dir", dest="gitdir"))
 
-- 
1.7.11.4
