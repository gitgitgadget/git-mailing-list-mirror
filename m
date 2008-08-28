From: Garry Dolley <gdolley@arpnetworks.com>
Subject: [PATCH/RFC] Clarified how pattern works in documentation to git-show-ref.
Date: Thu, 28 Aug 2008 13:37:16 -0700
Message-ID: <1219955836-10070-1-git-send-email-gdolley@arpnetworks.com>
Cc: Garry Dolley <gdolley@arpnetworks.com>,
	Garry Dolley <gdolley@ucla.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 22:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoG8-0005Qc-QF
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbYH1UhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbYH1UhU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:37:20 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:39885 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754552AbYH1UhT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:37:19 -0400
Received: (qmail 13703 invoked from network); 28 Aug 2008 20:35:32 -0000
Received: from 97-93-43-130.static.mtpk.ca.charter.com (HELO garry-thinkpad) (gdolley@arpnetworks.com@97.93.43.130)
  by mail.arpnetworks.com with SMTP; 28 Aug 2008 20:35:32 -0000
Received: by garry-thinkpad (sSMTP sendmail emulation); Thu, 28 Aug 2008 13:37:16 -0700
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94136>

Several people in #git, including myself, thought that the following would
show all refs:

  git show-ref '*'

Since that is not how the pattern patching works, clarification was needed
in the documentation.

Signed-off-by: Garry Dolley <gdolley@ucla.edu>
---

I think including a little more info in the docs regarding the pattern would
be helpful.  Comments?

This is my first patch, I tried to follow all the rules in the
SubmittingPatches doc.  If I missed anything, I apologize.

 Documentation/git-show-ref.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2f173ff..5966450 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -86,7 +86,8 @@ OPTIONS
 
 <pattern>...::
 
-	Show references matching one or more patterns.
+	Show references matching one or more patterns. The pattern is tail-matched,
+	achored on a '/' boundary; pattern does not accept globs.
 
 OUTPUT
 ------
@@ -127,7 +128,8 @@ use:
 -----------------------------------------------------------------------------
 
 This will show "refs/heads/master" but also "refs/remote/other-repo/master",
-if such references exists.
+if such references exists. This will not match "refs/heads/master2", because
+the pattern is tail-matched.
 
 When using the '--verify' flag, the command requires an exact path:
 
-- 
1.6.0.1
