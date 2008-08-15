From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] bash-completion: Add non-command git help files to bash-completion
Date: Fri, 15 Aug 2008 12:15:48 -0400
Message-ID: <1218816948-7864-1-git-send-email-marcus@griep.us>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 18:17:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1zI-0006ju-Bi
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 18:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702AbYHOQPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 12:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759716AbYHOQPt
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 12:15:49 -0400
Received: from boohaunt.net ([209.40.206.144]:42963 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759687AbYHOQPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 12:15:49 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 8ACBD1878CDD; Fri, 15 Aug 2008 12:15:48 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92492>

Git allows access to the gitattributes man page via `git help attributes`,
but this is not discoverable via the bash-completion mechanism.  This
patch adds all current non-command man pages to the completion candidate
list.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 By adding them to the help completion, man pages such as the tutorials, hooks,
 and .gitattributes are more accessible to random discovery from bash-completion.

 contrib/completion/git-completion.bash |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c0bf7aa..76d56eb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -885,7 +885,11 @@ _git_help ()
 		return
 		;;
 	esac
-	__gitcomp "$(__git_all_commands)"
+	__gitcomp "$(__git_all_commands)
+		attributes cli core-tutorial cvs-migration
+		diffcore glossary hooks ignore k modules
+		repository-layout tutorial tutorial-2
+		"
 }
 
 _git_init ()
-- 
1.6.0.rc2.6.g8eda3
