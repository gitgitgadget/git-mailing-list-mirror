From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cg-fetch: Fixed missing $COGITO_LIB path
Date: Fri, 21 Oct 2005 18:31:44 +1300
Message-ID: <11298727044144-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Oct 21 07:29:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESpSY-0000nM-4f
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 07:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVJUF2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 01:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVJUF2t
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 01:28:49 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:962 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964874AbVJUF2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 01:28:48 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ESpSR-0003e5-PG; Fri, 21 Oct 2005 18:28:47 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ESpVI-0006Fv-00; Fri, 21 Oct 2005 18:31:44 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10422>

Trivial fix -- prevents cg-fetch from working on systems where the COGITO_LIB
env var isn't set.

---

 cg-fetch |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 6dd73afff0a1f3e2433b90e2ea42f8500393bd97
ae2ea27f59cdb22d7587aaa49f12f29e1b1f77e1
diff --git a/cg-fetch b/cg-fetch
index f0c11aa..80b2a03 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -39,7 +39,7 @@ deprecated_alias cg-fetch cg-pull
 
 fetch_progress()
 {
-	exec cg-Xfetchprogress "$_git_objects"
+	exec ${COGITO_LIB}cg-Xfetchprogress "$_git_objects"
 }
 
 show_changes_summary()
---
0.99.8.GIT
