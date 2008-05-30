From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Documentation/git-filter-branch.txt: Fix description of --commit-filter
Date: Fri, 30 May 2008 14:43:40 -0700
Message-ID: <1212183820-40712-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 23:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CPe-0001xC-UW
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbYE3VoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYE3VoD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:44:03 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:35903 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754808AbYE3Vny (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 May 2008 17:43:54 -0400
Received: from localhost.localdomain (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 83331109EB6;
	Fri, 30 May 2008 14:43:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc0.158.g7c7a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83344>

The old description was misleading and logically impossible. It claimed that
the ancestors of the original commit would be re-written to have the multiple
emitted ids as parents. Not only would this modify existing objects, but it
would create a cycle. What this actually does is pass the multiple emitted ids
to the newly-created children to use as parents.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 Documentation/git-filter-branch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 506c37a..541bf23 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -113,8 +113,8 @@ OPTIONS
 	stdin.  The commit id is expected on stdout.
 +
 As a special extension, the commit filter may emit multiple
-commit ids; in that case, ancestors of the original commit will
-have all of them as parents.
+commit ids; in that case, the rewritten children of the original commit will
+have all of them as parents. You probably don't want to do this.
 +
 You can use the 'map' convenience function in this filter, and other
 convenience functions, too.  For example, calling 'skip_commit "$@"'
-- 
1.5.6.rc0.158.g7c7a1
